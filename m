Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33A3C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 20:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1477881D2;
	Thu, 11 Apr 2024 22:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V7ySfzYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A34187E91; Thu, 11 Apr 2024 22:05:15 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC0481F9A
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 22:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b3d05e945so1409696d6.2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712865912; x=1713470712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIbpdVkjyjY7NzqaBNfVyODmHEgHFcAXpODOa6lou50=;
 b=V7ySfzYPzihS93APk4+97Bjry+Pi5q7qHPKsBYwsWOWSHMwTX5/Gja+EZQ5ozOu74Y
 ljO6gVkxk4EzRKsLGVaBcwNiXDfP67xz3CKS0Kb6GVQWtCiKv/EpvVnFABTdhFzj1k3m
 BGSg8uquxEiV2fCKBTqSXnsPAtzCLuSL31YOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712865912; x=1713470712;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZIbpdVkjyjY7NzqaBNfVyODmHEgHFcAXpODOa6lou50=;
 b=czLm2EXXKUE84x0/3h2HpTHDfpiHjbbFSL4fOIplTaPqIL6Tf64wsF2XITLtfnTHIR
 P0xGnwDLVIO4sw/BTV+K/6A5KFPO5sZ9a6m0qu3hzd6/vkz9dZ/judbIuaHVCsmLTerj
 i5dqcuG7/+CzaYyD/2apTQQxBWUkqAA7XzhMHIr/ijxn6zKdmljtZYbdAK3aWMpFBH+r
 f5Shh9iBULEnuTFhAFDJv07SkLmAEb9b7ZBbLWY/5B+xSEMmIgb6H3awT6r0uKvqYSu/
 A7JuCEuB1JyEZzjF5cf4sH4yX5ARpSxvMUuvF+obRWOKmodkf4J4ROnfmJABAvAGouDa
 rykg==
X-Gm-Message-State: AOJu0YwF/XsYeF6VChzfFWIAacINw8/C+9fFYL57279kSRuXmAUPWrxn
 6UhQrPSJM/0rdlACWwEKX4nPxQfOZK7yo/OCWo5k/pDEiEiTeNVOUuy/CLedILI=
X-Google-Smtp-Source: AGHT+IER62yIvy82RnP+pMhGMWjbT1rG6n2KJLg1oMyp4aYKvrD0gl1GCaIelEAnMlFVXKNNf4cb2g==
X-Received: by 2002:a0c:fba2:0:b0:696:a48d:26a0 with SMTP id
 m2-20020a0cfba2000000b00696a48d26a0mr794692qvp.46.1712865912249; 
 Thu, 11 Apr 2024 13:05:12 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 f15-20020a0cc30f000000b0069b114bcb2esm1349715qvi.46.2024.04.11.13.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 13:05:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
References: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v4 1/6] boot: fdt: Change type of env_get_bootm_low()
 to phys_addr_t
Message-Id: <171286591122.298989.8603089527631856478.b4-ty@konsulko.com>
Date: Thu, 11 Apr 2024 14:05:11 -0600
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

On Tue, 26 Mar 2024 23:13:11 +0100, Marek Vasut wrote:

> Change type of ulong env_get_bootm_low() to phys_addr_t env_get_bootm_low().
> The PPC/LS systems already treat env_get_bootm_low() result as phys_addr_t,
> while the function itself still returns ulong. This is potentially dangerous
> on 64bit systems, where ulong might not be large enough to hold the content
> of "bootm_low" environment variable. Fix it by using phys_addr_t, similar to
> what env_get_bootm_size() does, which returns phys_size_t .
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


