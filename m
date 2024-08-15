Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACF2C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2BB88C31;
	Thu, 15 Aug 2024 22:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CrR7yMcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B1B88B63; Thu, 15 Aug 2024 22:33:20 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 527C588BF9
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5da775a15e3so674638eaf.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723753989; x=1724358789; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJwGcBV/lU7Ch3dxBlPyJgkd73T7V2VCHGCX/r92/vM=;
 b=CrR7yMcQEqd4iCdobritkc0p/hUzsPz9/XWBSyqpTXQjD5XhL6V+bJvU8AcvuI0nVI
 fpkhh1EfKCuv/1Zna0wkCRAF0jkDNY4wVj/jKyx0SRw/uMhmA8TlbE8RYqlBRfPzTL2Y
 hvfXbgH1ad3SLGx1Ksky97nR/QZ7b1Tb75fo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753989; x=1724358789;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJwGcBV/lU7Ch3dxBlPyJgkd73T7V2VCHGCX/r92/vM=;
 b=qz0VHqS5XdHl49QypqmwAXVsenzSu9xk5jEcQ/fGYsinIvZcmyAI3Sx4qPLo2NL01J
 9bvk+qsmrTrG3o9rLSaMy7iACwgbjzpRW55Z3T6lhhvXkEcgcME/XbeJ11t4yNQAlDSd
 sRSaryQJpFNN5WkW8cselmDNSlcQuPKHXPGRk6JkKANjU1bzyQkLvsMoAWkuNhj3TrvM
 vxaXCGIPuZFYXnSPbKoXyYhv1D/DHUspeHoaVy8yxlFQ6H/gs0laZMxxpy6xiZGaLbuF
 zf2qk91nZTL/KDfOO2Uvt9R14L260zd/ccD8Ks5uDLhDLK9YRFxixytA4ZcVSM9lwvqe
 0tiQ==
X-Gm-Message-State: AOJu0YyofQf4r4bP/+F8WeuAHsN4NZRrZ3g9uHoCl4qmi6l3pJIBldPk
 +j0A70D3V0zhE7pcS9GEi5ky8lnjU+jxCVTS3vRA1MF2A1rmkAPr1keznYVZs3dYPWJqE/hSP/t
 Z0us=
X-Google-Smtp-Source: AGHT+IGnvCFxnQGTV5/SiICyFgw+HjmoGASlyMklB6+PMLi42+NOQlINEmr4iNYz7uTotXd+99dk4w==
X-Received: by 2002:a05:6820:2224:b0:5d8:2eea:9c8f with SMTP id
 006d021491bc7-5da99ed8e23mr231324eaf.1.1723753989706; 
 Thu, 15 Aug 2024 13:33:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cdd9dedsm402006eaf.21.2024.08.15.13.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:33:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240807152659.313103-1-afd@ti.com>
References: <20240807152659.313103-1-afd@ti.com>
Subject: Re: [PATCH] defconfig: Add a config for AM335x High Security EVM
 with SPI Boot support
Message-Id: <172375398885.3490037.11788799387337293392.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 14:33:08 -0600
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

On Wed, 07 Aug 2024 10:26:59 -0500, Andrew Davis wrote:

> Add a new defconfig file for the AM335x High Security EVM. This config
> is specific for the case of SPI booting.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


