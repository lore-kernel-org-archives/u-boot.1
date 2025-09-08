Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC39CA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D67782AE9;
	Mon,  8 Sep 2025 13:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WO5rtsv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF6482DA1; Mon,  8 Sep 2025 13:06:17 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF46800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-336b908cbaaso35912411fa.1
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757329574; x=1757934374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QfRqrFJxzDFzbu2UDzf0SfzZCWe5nVkEgHUn+e2mUaY=;
 b=WO5rtsv43X4EU1WZam35L7zB2qFyXOY8MYYDb/D2k/sf38auTqTgE7FpQSFMksPsJ/
 RljQxZBik/o4ZTzC4b/5N5RbuaAgQCi0eU6Is4+I2pvNj8s9dded/tOba6SvuqsxDGHj
 lBU1buNMlWuU+qJC0BwSIpPxxl3ysCsnSqJ28FXbZjPQSbgLF/bSIeW53m+TcRnpbdAC
 whpT8tNIqQwqjj2hcnrPxfFHK1fQAKa6/iANegcHit5E9ohiOb13ljABffyWEcNOdi11
 fmz9vwog8PHnkCz2wWY7HvI+vkh6BqsdXXbTNbCXPbTb0gkKjIxHuRyLLDu07TBKNRIc
 i3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757329574; x=1757934374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QfRqrFJxzDFzbu2UDzf0SfzZCWe5nVkEgHUn+e2mUaY=;
 b=Djj1dx2asfKyKtbLh9uKF99HmD45++p+tI+W1Szz+ufV/qEDvwQsQLSmUYxk1rB21Q
 jjFX3PWMpgrUAWPHvCXZfVzgR85yp6ND7WaC3JlXNBl3pl93aRyj0rxdrs8D6k4pr6Vx
 PTcTSWfE7fztqbmTdG/Pizs3LcbNHmu4/I3y3zSk4hv6QuQchzDZpGs5c7E+Bf7GSVYb
 wqXYXVnDoYT8MIXlC82Ro+AJAp7mU8vXfHXTvCiTpD8idyaX8pi030OxOhMqy0Eo6yWh
 dylDbALyCsHuiHvIlRoxeuVlOPDDsRTsYq2715a0S/VUPtLtCJ0e2ky9zGmXMLUyooIO
 BhGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2CqRO3X3rvD96w/2AzkWfZuqgQ1enG8RhpKn4PWenjYWjr4lGRqTVpRACwbDdSAX/GP9PMXc=@lists.denx.de
X-Gm-Message-State: AOJu0YxXjs5pf5PH+KAZSrswJiCHaZivntiOe3+jrKkB0+2FkwX7i730
 2Z72Xs8f8VvJFNBIVa345wkTOdCYV7KHowaKPjN2sPpOJnOOgrsGyNP+DXJ/ymfh8OH12LETNkp
 4TVnjKpR1IwRwhaSlFc1uNrZ/oFOJL5E=
X-Gm-Gg: ASbGncusYbZ6n2gy0+Mzd++1gxIG28wDcx/9SzoBFlVCOLxThKi+bq7IMbtAa/tlUxU
 viT6Yl7Cu6n2RHcLCmTiAtxvOuRsjRKDHbk/O/HC9PSGBsjlDAakjyPAA+jUj6VB9wOb+txJUm1
 YBjjRqzPhXG4RtK2+mKPF+B8o3dS98SufnyaM10bxp2lbBOXpv7aP5Dsc9q3WD0ryuluNHUicOd
 IHAntU=
X-Google-Smtp-Source: AGHT+IEZSPq/Sd/Wsl7Oqne7IcBBAoCiZVN0lUqeGJLaVGOyUobrXqL15Ra+slQbWeoywYtzh7P4bT5ANUDdTPSFg14=
X-Received: by 2002:a2e:bc0a:0:b0:336:de55:9d9b with SMTP id
 38308e7fff4ca-33b566fa988mr19457911fa.3.1757329573515; Mon, 08 Sep 2025
 04:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250416125643.2234165-1-s-vadapalli@ti.com>
 <CAEyMn7ZhsU9vBeSHcPY_oJZXbA51BU50T5HXVRg=6-Ocac4ywg@mail.gmail.com>
 <1b370af1-cdb0-42ac-9389-d97fd4b4a8fe@ti.com>
In-Reply-To: <1b370af1-cdb0-42ac-9389-d97fd4b4a8fe@ti.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Mon, 8 Sep 2025 13:06:01 +0200
X-Gm-Features: Ac12FXxhJ9JnWJFnC7Mzd8nX9ix91MHx7SZwSGuYnC_mXp9NvpbPOI0EON1fojY
Message-ID: <CAEyMn7ZOADOpO9R4DAugj=fugtSVDgUCMCo1wUEhPmb6fCH4ZQ@mail.gmail.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: invoke phy_config() in driver's
 .start callback
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 matthias.schiffer@ew.tq-group.com, richard.genoud@bootlin.com, 
 c-vankar@ti.com, u-boot@lists.denx.de, srk@ti.com
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

Am Mo., 8. Sept. 2025 um 13:02 Uhr schrieb Siddharth Vadapalli
<s-vadapalli@ti.com>:
>
> On Mon, Sep 08, 2025 at 10:52:37AM +0200, Heiko Thiery wrote:
> > Hi Siddhardth,
> >
> > Am Mi., 16. Apr. 2025 um 14:57 Uhr schrieb Siddharth Vadapalli
> > <s-vadapalli@ti.com>:
> > >
> > > Currently, the phy_config() API is invoked by the driver only once since it
> > > has been probed. While this works in general, it doesn't allow the driver
> > > to bring the PHY back to its default reset state. As a result, the driver
> > > might not be able to recover the PHY from a bad state. To address this,
> > > move phy_config() into the driver's start callback (am65_cpsw_start()).
> > >
> > > Apart from providing the means to recover the PHY in the event of failure,
> > > the implementation is in line with the idea of "reset and configure" that
> > > is already followed by am65_cpsw_start() when it comes to programming the
> > > CPSW MAC.
> > >
> >
> > I do not know if this is the same issue here, but I see that in case
> > no cable is connected and I try to do a dhcp command the board/network
> > stack of a J722S EVM stays in a broken state. After plugging a cable
> > it is not possible to do a successful dhcp. It requires a reset to get
> > a working network again. Same issue can be reproduced when unterrupt a
> > running dhcp task with CTRL-C.
> >
> > ----
> > U-Boot 2025.07-rc3-g259a4765c26b (Sep 08 2025 - 10:44:20 +0200)
> >
> > SoC:   J722S SR1.0 HS-FS
> > Model: Texas Instruments J722S EVM
> > DRAM:  2 GiB (total 8 GiB)
> > Core:  91 devices, 29 uclasses, devicetree: separate
> > MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> > Loading Environment from nowhere... OK
> > In:    serial@2800000
> > Out:   serial@2800000
> > Err:   serial@2800000
> > Net:   eth0: ethernet@8000000port@1
> > Hit any key to stop autoboot:  0
> > => dhcp
> > ethernet@8000000port@1 Waiting for PHY auto negotiation to
> > complete......... TIMEOUT !
> > am65_cpsw_nuss_port ethernet@8000000port@1: phy_startup failed
> > am65_cpsw_nuss_port ethernet@8000000port@1: am65_cpsw_start end error
> > BOOTP broadcast 1
> >
> > ----
> >
> > Do you have an idea what is going on here?
>
> The following are some experiments that I performed along with the
> results:
> 1. Board:  J784S4-EVM
>    U-Boot: 2025.10-rc3 (latest)
>    Results of the test:
>    dhcp fails when the Ethernet cable is not connected. Connecting the
>    cable and re-running the 'dhcp' command works. Reset is not required.
> 2. Board:  J784S4-EVM
>    U-Boot: 2025.07-rc3 (same as the one being used in above test logs)
>    Results of the test:
>    Identical to '1.'.
> 3. Board: J722S-EVM
>    U-Boot: 2025.07-rc3 (same as the one being used in above test logs)
>    Results of the test:
>    Issue reported above is seen.
> 4. Board: J722S-EVM
>    U-Boot: 2025.07-rc3 (same as the one being used in above test logs)
>    + Revert commit corresponding to the current patch which is:
>    https://github.com/u-boot/u-boot/commit/05dc050059d2
>    Results of the test:
>    Issue reported above is still seen.
> 5. Board: AM62P5-SK
>    U-Boot: 2025.07-rc3 (same as the one being used in above test logs)
>    + Revert commit corresponding to the current patch which is:
>    https://github.com/u-boot/u-boot/commit/05dc050059d2
>    Results of the test:
>    Issue reported above is still seen.
>
> To summarize, the issue is unrelated to the current patch. Moreover,
> the issue is not seen on the J784S4-EVM. I will spend time trying to
> narrow down the root-cause of the issue.

Great, thank you!

> Regards,
> Siddharth.
