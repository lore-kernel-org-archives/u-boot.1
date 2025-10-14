Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EB8CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 18:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD39180107;
	Tue, 14 Oct 2025 20:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a0Yum8o/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC73807B1; Tue, 14 Oct 2025 20:12:38 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17436800D7
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 20:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63babfdb52cso3952359a12.3
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760465555; x=1761070355; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q37EnZdGEFNYgBgIsdIKBBkziy+fTXQogtUpe+JDUSk=;
 b=a0Yum8o/h5QzcmHPwW0C5sDPYPf2ZY6U0O6qtNOTq0Y45ha1VAgf8HCl7CXu56bPJu
 9svz0TvsUAa6TnBHGfJphZx8DsAuu9iHgoebxluxlNxpiC9o7TamTAJbGRamD9gvadRg
 YTaDp3mTPb1vXV2MiAcRp7b/uysqHkEO1zPDAhUxnYFjKwLePOuCUjH8i/N2cn3seyJB
 uNvPBZpQtQyMNFTgM67vMSYauYturf3xfJoh77hHsfcA8K7bggyUdYbV6+fYX6o8800M
 LvOXduHHmQuiTyt2GqhJwuEnxnLixYgDI2Xcs27ErGAM1SIUU3mgT2OaSJjCLRykcKJH
 ruYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760465555; x=1761070355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q37EnZdGEFNYgBgIsdIKBBkziy+fTXQogtUpe+JDUSk=;
 b=Vvx5jW78sy0FvK2ZO0vFGGdOaavKQaxcBElk68Lb0ZVtiY33cAUHDkdkJEp1hN4d8N
 XdDuGomcuDewyXrawOWU5eS7MD4b8TEvYlU03VIxr2B1WWbtS33B41WJUobDzk8mzGPr
 lTy6u6j00ESt+xgSwjWvTMwm4K3W3/TVkc4MxFENJ3bEaumsmtMiVaBqOdaUEeZXUiTM
 fa8gMvSdMGV5e/HJsvkNkt3dPF5u9EwB+lBkkybzDLcSup1yOsbKO/ImZJbCZjkw/XKs
 U5Oub1hIO3S4kQMPq5QbKyh37HGO5Cfd0kb8szZ5YbJMkgvxGPrSetGvCFcftlhPTAsj
 CH7Q==
X-Gm-Message-State: AOJu0YwX2Uw49csUdVCAvhtg03vaLumKrO0kkjyjav/qp5/uPKMw/3J9
 VzRm3Dq7MNAVPhoeTNbn3FfhISVRRmauj0fMOqm+NwnSSkXEZTx972217QZD+jd3MtjO1O161P5
 aUiuk/rfC/8IuFgeolm6tuj7K0GW3oFQ=
X-Gm-Gg: ASbGncv4JJ82kK1zZp9WQlRggEkgrigHUYlrYRvD0tyaZcY2SR171ris1bmFwtW319y
 Cg2D83aORYnuKVFwHWTgiKZ3yq6liH/kLKWCuVFH0BLzSS/GV+WRRLxgyQvGWrSGpiXxRw1Rtn3
 RJpyhoPEgr5G3WMeMvJV1fQYeLljtWwPtQ5MmxD/38eQPRhpvKEOy4JSsUGPVet8Mt30YdrxntZ
 iU13pnmc4Tafw8qhf6aK7vr7AkHCUqApsn4KPDBtFigLhBObg3ys8zb+cgzsQqHIYA2iC5tEz9V
 LPgm89pgi8n4H0RokEz0zvApzQDyzjQJYppD9pHJCcsj
X-Google-Smtp-Source: AGHT+IHA7YDC+oxpMAwPF1FGGFYtw89QA1TxQppwmJMSR8rcnzLOXrxTCqxE0/Xe3HO5J+lWF/vDX0WD9wxVomuT5nM=
X-Received: by 2002:a17:907:6d25:b0:b04:3dc7:7d80 with SMTP id
 a640c23a62f3a-b50aaa9c847mr2813993266b.18.1760465555306; Tue, 14 Oct 2025
 11:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <aO5F+z0n5ETHZZGt@GRAPHRT>
In-Reply-To: <aO5F+z0n5ETHZZGt@GRAPHRT>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 14 Oct 2025 19:12:23 +0100
X-Gm-Features: AS18NWATDL7RJ-hCXtcG_PvuYqUcD12Poptt-7xd4yPmev0ONPxL5dmsKF4xDQM
Message-ID: <CALeDE9M1nfBSM6jLer1uqtzf+b8eZq_33ALA7_mSKC5k53OoQw@mail.gmail.com>
Subject: Re: [bug] can't start watchdog on RK3288
To: Marius Dinu <m95d+git@psihoexpert.ro>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

> I have a bug to report. I tried starting the watchdog on Asus TinkerBoard S
> (Rockchip RK3288), but it's not working. I investigated a little bit. Here's
> what I found so far:

What version of U-Boot is this? Does the watchdog work in Linux?

> => wdt dev watchdog@ff800000
> drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: timeout-sec: (not found)
> drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: hw_margin_ms: (not found)
> drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: u-boot,noautostart: false
> drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: u-boot,autostart: false
> drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
> drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for clock-controller@ff760000
> drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for clock-controller@ff760000
> drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking oscillator
> drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking clock-controller@ff760000
> drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
> drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
> Can't get the watchdog timer: watchdog@ff800000
>
> It seems that the error is generated in designware_wdt_probe(), after
> clk_enable(). Function clk_enable() runs on branch CLK_CCF=false. It returns
> error from ops->enable. Struct ops is defined by driver: rockchip_rk3288_cru,
> in drivers/clk/rockchip/clk_rk3288.c, but it doesn't have a .enable or
> .disable component, so there is no ops->enable.
>
> The solution to this one would probably be a stub for .enable. AFAIK, it's
> always enabled.
>
> I also tried to enable CLK_CCF (drivers from Linux tree), selecting the
> watchdog works, but if I try to start it, the board immediately resets.
> I have no ideea how to troubleshoot this one.
>
> Thanks.
> Marius
>
