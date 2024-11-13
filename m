Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89BCD637A0
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 17:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E25198936F;
	Wed, 13 Nov 2024 18:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RLIs8Dln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA79E891F1; Wed, 13 Nov 2024 18:40:46 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2B4891E8
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 18:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e619057165so4101112b6e.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731519643; x=1732124443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynqj5kB0wDG/xwHQsmevSmW9WgjzVgFG6DTfwswrOz4=;
 b=RLIs8DlnF29McdZ12oJ5omkmpgFJ51NFPKM6DutNVgS8Telhzyz6JxAudyIY+Hel28
 Y8/G8X3WEdb2uCjoY1aJ21aPjLNTWkGx7zT1erQjBOOnpdgaCp/Hmorntvod2OnkHRCt
 WbuYgWfWFZSLPwsup6VIncjAxgTaowZqvHXak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731519643; x=1732124443;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynqj5kB0wDG/xwHQsmevSmW9WgjzVgFG6DTfwswrOz4=;
 b=mCDm2tPNbNPrRYL+WxA0fc9XqwmmySBZCNRmwYMO/kK0tp6tqZqDub65ChcaasStRf
 1N9CYzNjM20lnZho7JUOAUXE9FgTAGa2BApSv2TGTb5yalcCKmdbnLEwy1OF7lpFyYsi
 M621PBMRGAhHIcKaV4NTnz08BX0gmx96RE+U5oRQlPPBGV/yTl0BY+P5FV+Fy9wGpN0k
 v7NXQUosrcF9WF5PU1caDQE3rEpvLT0xpTDYIMB8/UXPIDmYZU5H32wd1aC7GUL2bE2N
 vMmtZUHt3w316eXaYNqeQSYnzL/azacI26u2qgDAM4RzkVXCDUt4dBVDKLTHZoAaKHWa
 HzsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNWgLGKntGKQOKPxFPnp2Qd0bgBV5ghrX24RN0zKutdqWEF/7+q5OH7ROMvIUAd8o42IDMhkI=@lists.denx.de
X-Gm-Message-State: AOJu0YzkUsNVbPyEy42pJmtEQ++KoK4Nlu7lZwAQVs4r8sCxhq7zmfny
 XheVxOEPpCt2v3JYA0ZsM6GDlCTrCJB6LFw2lU//dSwlyAKGmnvanFveNOfuG0j1uJVddSOqI4i
 OQtE=
X-Google-Smtp-Source: AGHT+IHtpckTuw12jZfSLhXmFZIKNdC14y9SPlns6Dxvix7tfJyy436ou5+6BJvewFxz+I6Mda+XsQ==
X-Received: by 2002:a05:6808:1828:b0:3e6:5761:aea with SMTP id
 5614622812f47-3e79469c437mr18324408b6e.10.1731519643417; 
 Wed, 13 Nov 2024 09:40:43 -0800 (PST)
Received: from [127.0.1.1] ([145.14.135.248]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b096bdabsm736295b6e.21.2024.11.13.09.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:40:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20241105193129.28582-1-heinrich.schuchardt@canonical.com>
References: <20241105193129.28582-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] board: qemu-arm: select
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR
Message-Id: <173151964183.1299521.3182556931328741059.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 11:40:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 05 Nov 2024 20:31:29 +0100, Heinrich Schuchardt wrote:

> qemu_arm64_defconfig with CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=n leads to a
> build error:
> 
>     arch/arm/lib/crt0_64.S:85:
>     Error: constant expression expected at operand 2 --
>     `ldr x0,=((CFG_SYS_INIT_RAM_ADDR+CFG_SYS_INIT_RAM_SIZE-480))'
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


