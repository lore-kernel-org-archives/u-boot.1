Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621D9C52D6F
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 20:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79BE588792;
	Sat, 24 Aug 2024 22:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RO/o1m6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08002888C1; Sat, 24 Aug 2024 22:02:16 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6438877E
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 22:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-27032e6dbf2so2021983fac.1
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724529732; x=1725134532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAsjolSAWnq/GpU4TndEsA+sxb9MjFrvkO3Tt6/an6k=;
 b=RO/o1m6PdjNoe9ygRmstw0gVqfeP1Nmv8Kb8YnutTLL0u6E3h/6ruhkpiTlPY604XR
 9/DFoRaYzuxYxWHqo/4jCVUoT4F1MTTPtu8B24iq/3A4jl2l38YS7VwN1mB8OMMlEp2+
 f808wcCy78FhPE+W6H1l7LJILZyhRXFRY4Ve4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724529732; x=1725134532;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eAsjolSAWnq/GpU4TndEsA+sxb9MjFrvkO3Tt6/an6k=;
 b=EjlmIYLemF/qr7xC1YTFErMKpcH5D9z70eyupAwkfMwrSNdr09IvGSj6ZyxbzJ7fr5
 ej7EAR5zalCFfxkxq5IKoL5St/ehSnwzXIq8ig9I11ESqVfVh6mIYFDaG9xN2M53+1N5
 kZIlkVNMR9E8Qgff/44kqcvmNxIQYtF2hHpJCkS42Q04XN7UwXW6C5CU6kG6LPVx936Y
 HnU+CuODcaNROudYL6fvtxQdHNpmnTAI/nrPhbi3IVEk9zZPRO5TkhENqqQiUwvG/XXs
 aF7k+MFrfxVLmt9xD3l07guUpoZytk+j5FaDfioO0jLjIC0nijCrL9q7MCd16MAX1Ol4
 aR/g==
X-Gm-Message-State: AOJu0YxuSQuRMRHDW3gSL4zfFZcA7BcK39tXUKllTob2vuWGxU+gzc66
 IIIZrcOt3eTbIkQEH4HrdOjPVuHMQJTzlIcNX4Rv2MTFl1EyxxQnyQIgZ++VFTI=
X-Google-Smtp-Source: AGHT+IGNcEfUNFfN0OCzj+B0aceVvpTMZQhVXwL7GCYmyywIpgv1OTi1lLF8dL+eJwLo7TwAMF/isA==
X-Received: by 2002:a05:6870:3c15:b0:270:2c12:98c3 with SMTP id
 586e51a60fabf-273e67aace1mr6211731fac.50.1724529732576; 
 Sat, 24 Aug 2024 13:02:12 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f41f507sm300754485a.132.2024.08.24.13.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2024 13:02:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, huang lin <hl@rock-chips.com>
In-Reply-To: <20240822135503.2363706-1-sjg@chromium.org>
References: <20240822135503.2363706-1-sjg@chromium.org>
Subject: Re: [PATCH v4 00/14] spl: mmc: Some tweaks for SPL, particularly
 with MMC
Message-Id: <172452973055.2581148.4176048793688635803.b4-ty@konsulko.com>
Date: Sat, 24 Aug 2024 14:02:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, 22 Aug 2024 07:54:49 -0600, Simon Glass wrote:

> This series includes various minor fixes and tweaks found when trying
> to reduce the size of MMC code in SPL.
> 
> Changes in v4:
> - Mention the change to lower case in the commit message
> - Put a 0x prefix on the 'enhanced size' message
> - Drop defconfig-resync patch
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


