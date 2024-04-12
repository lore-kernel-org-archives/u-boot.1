Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6EEC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 21:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14CEF8820A;
	Fri, 12 Apr 2024 23:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="guGQEqYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A6387E01; Fri, 12 Apr 2024 23:59:33 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1189881F4
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 23:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso993507a12.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712959170; x=1713563970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FozAuZnD2DWCyMf+Ar61q/IQTmA2FT4v8SCME/trvCA=;
 b=guGQEqYpDTE8Tf2bRRdaYz1trsjoaCKDgV3Ozw0YTXY9FOjAqOSLZRk2EHfQNfsdmS
 iWO/7st6V4GXtSy1neakLvEXljLQf72xto8CimreWjpR/r+EmuY3gEFHpOLJXBaggE2W
 5Fovu8iGahKReO3Nz8bnoiwVqxJK6ZH9QQ9ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712959170; x=1713563970;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FozAuZnD2DWCyMf+Ar61q/IQTmA2FT4v8SCME/trvCA=;
 b=dEtV5EhQrF3QrGQCmqc9Kq01WMVIdpr8aXkeNgVSFYA8dAeAjCmmhcUlW7/IQbCCWd
 fZkjO7C4d9IVs0WOHSou0iHffwrhx0NS25a91AdOqR5Gw/jKWHaLWrbm87D8QhkRx6eX
 VS+L8YwzDfqOjOnLWpNAkh8tNvIbUB/Bw3c129Bkr7PjLiqttPz7vDPdW6+IsD+Trp+c
 iQsfuriLwAiPvm88/6oPbH9j2AeeGLPdSoEPzpjywGc+BcrL8Vh1+mTs/k3i7bRwVmM6
 ol6G8ouR9NsLR9w6OxMEBatMpAlzWwtIGpkvyIQw6ulgeriAs33EJ6+6f2PvYf5QXBCU
 Mhvg==
X-Gm-Message-State: AOJu0YwxyvS4RitQuPsO64PMauUpVuMsjOSq1up/i+wUmuTSyMCg34+m
 iJDsAo4fsCEJAxemTFLhJ5uC6PsapAAmVZI2W6bhb0Y2YsvqBhxC8CfCkppFUOs=
X-Google-Smtp-Source: AGHT+IHRN6iH2J/+InS9VCSZg9KLjgjjS2cRNlEZPj1hcFZsyRRVJK9Wl5CuJ2iKSLWljPXD6pCzWQ==
X-Received: by 2002:a17:903:184:b0:1e3:e0a2:ccc3 with SMTP id
 z4-20020a170903018400b001e3e0a2ccc3mr4948317plg.30.1712959170089; 
 Fri, 12 Apr 2024 14:59:30 -0700 (PDT)
Received: from [127.0.1.1] ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 kw7-20020a170902f90700b001e45240eca4sm3472958plb.196.2024.04.12.14.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 14:59:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Simon Glass <sjg@chromium.org>, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 MD Danish Anwar <danishanwar@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240404070803.2455207-1-danishanwar@ti.com>
References: <20240404070803.2455207-1-danishanwar@ti.com>
Subject: Re: [PATCH v5 0/5] Introduce ICSSG Ethernet driver
Message-Id: <171295916789.1044279.16764299431043315466.b4-ty@konsulko.com>
Date: Fri, 12 Apr 2024 15:59:27 -0600
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

On Thu, 04 Apr 2024 12:37:58 +0530, MD Danish Anwar wrote:

> Introduce ICSSG PRUETH support in uboot. The ICSSG driver is used in TI
> AM654 SR2.0.
> 
> The ICSSG PRU Sub-system runs on EMAC firmware. This series Introduces
> support for ICSSG driver in uboot.
> 
> This series has been tested on AM65x SR2.0, and the ICSSG interface is
> able to ping / dhcp and boot kernel using tftp in uboot.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


