Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E4DCA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394B2809A5;
	Mon,  8 Sep 2025 10:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gZQUYG7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D0982C84; Mon,  8 Sep 2025 10:52:52 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 323A9800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3380787b30eso36758771fa.2
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757321569; x=1757926369; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N1c/Ii3muJus7dl/hrzhHwRFBFt+eBuArJKt441WINk=;
 b=gZQUYG7K0lu5Dhg8Q5azPwuMMa7QucS7e54PSiUiQ3lTqZzQQiRkds7+V3pWflE74n
 bT+wy9pXSRR7EHw+Pf+kFSPDi5KQcTjLjb6rW24YyyJM0QdXBVsk4/a6f9+MEEWhYpCO
 HMZFn/DilJtVk0KMFL8N11BI4hO1P7ZJ4hTuJleN1F4mSjzvl+yuMVlwWB898LXgjjvY
 bCPoccKQljsXabWuwf6KPczFY+rxlc0SYMlRX5RTtHuZqbQSlD30MuqDlXdbJa+NuHNF
 pN2QzrlAi8tIyT6mLWf+LrUOGX+NahZWGkGTXFksFPTrKYBCPQmRYcyW0SzFHvgvDwMw
 AySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757321569; x=1757926369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N1c/Ii3muJus7dl/hrzhHwRFBFt+eBuArJKt441WINk=;
 b=T/4H9oMTqDfPcgPiC4VqPFVREAVQaCID2MSHr14+cJN2hZEyZKOeKA8CKQCo3nIuzY
 jijYvtLwSxcd9G9hj2JOGWo/PeI4odYhveFzj4LogSpk5WPOpnXKRMJ6kEfxb3mvQfiv
 YwoEjgb3UVIrSOplaLPfro9c1WUyREZOO8rW8cLR7Js142loTNJrWdVCXC6Gv77Wdm5o
 RzdXJtiaci8g/DvZe95d9VRzAS4cpZ6E6yBN97WoC00U2/qm9VRk65AlRNey6/jCtuq4
 bUY5fRJtM1MvffwAJIbkPtN34ysbBmYhm0L6JdaG88+q1v+inJQAhsqQEHCbrWSbi1RA
 pWVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcIRLZvfpkdOXuXYQAGmkY7RLt2j4xMHvhHJZC1t11Zf3VZC5g3wytTM05sL1EYJpa1GOzHno=@lists.denx.de
X-Gm-Message-State: AOJu0YzCBdMrLQ4828MNX9Jr+K2+zoOAB3mzA/rU5LKnLQKCsf4JqZL3
 XmlcyOzGWtCmjC12A93pEylBNL/rkEhVsZkv9vGJhmOoozW3BSOUQ5+MlVorjdOY2ScH+mH4dPz
 GIYe9FAAd2zmSChUVw7PdUJqgVSGPlx0=
X-Gm-Gg: ASbGncvqV1Y3iQSDwm/DZ8OtxvUW8fM97ji0VNXLJXGJmZNITtzTIYzvYrU9L2l/Y2Z
 Xu8GyQ2MS05VAVuIXzS2sX5gSokE2jacHDWQavgcRya+yL0DEfCvqMSW/B8I6I4QrSL0io9AA2p
 SHDvsTyn8tn3v4DIb4KF4REYNdr1d+M9dP7ItmS5zdmgy6cqET91EguoXMXcBYUr2FnBYsH2gdB
 U7TbpexHFTeqfGUkuk=
X-Google-Smtp-Source: AGHT+IFd8QBP+kpjE9vntvOOI3zbNNcYe3LDIJunWA23ZZWsye0euT7IuJrWW3kkIPeo+PB38pbgk9qWAFAvYunbOhY=
X-Received: by 2002:a05:651c:2221:b0:336:8267:c1fa with SMTP id
 38308e7fff4ca-33b4dab7931mr16543441fa.19.1757321569129; Mon, 08 Sep 2025
 01:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250416125643.2234165-1-s-vadapalli@ti.com>
In-Reply-To: <20250416125643.2234165-1-s-vadapalli@ti.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Mon, 8 Sep 2025 10:52:37 +0200
X-Gm-Features: Ac12FXxsqsHMcpp5PooWx-Io40O5mblbqERr9WkGa9m_8OLcEYXikMQjHbb7lDg
Message-ID: <CAEyMn7ZhsU9vBeSHcPY_oJZXbA51BU50T5HXVRg=6-Ocac4ywg@mail.gmail.com>
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

Hi Siddhardth,

Am Mi., 16. Apr. 2025 um 14:57 Uhr schrieb Siddharth Vadapalli
<s-vadapalli@ti.com>:
>
> Currently, the phy_config() API is invoked by the driver only once since it
> has been probed. While this works in general, it doesn't allow the driver
> to bring the PHY back to its default reset state. As a result, the driver
> might not be able to recover the PHY from a bad state. To address this,
> move phy_config() into the driver's start callback (am65_cpsw_start()).
>
> Apart from providing the means to recover the PHY in the event of failure,
> the implementation is in line with the idea of "reset and configure" that
> is already followed by am65_cpsw_start() when it comes to programming the
> CPSW MAC.
>

I do not know if this is the same issue here, but I see that in case
no cable is connected and I try to do a dhcp command the board/network
stack of a J722S EVM stays in a broken state. After plugging a cable
it is not possible to do a successful dhcp. It requires a reset to get
a working network again. Same issue can be reproduced when unterrupt a
running dhcp task with CTRL-C.

----
U-Boot 2025.07-rc3-g259a4765c26b (Sep 08 2025 - 10:44:20 +0200)

SoC:   J722S SR1.0 HS-FS
Model: Texas Instruments J722S EVM
DRAM:  2 GiB (total 8 GiB)
Core:  91 devices, 29 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1
Loading Environment from nowhere... OK
In:    serial@2800000
Out:   serial@2800000
Err:   serial@2800000
Net:   eth0: ethernet@8000000port@1
Hit any key to stop autoboot:  0
=> dhcp
ethernet@8000000port@1 Waiting for PHY auto negotiation to
complete......... TIMEOUT !
am65_cpsw_nuss_port ethernet@8000000port@1: phy_startup failed
am65_cpsw_nuss_port ethernet@8000000port@1: am65_cpsw_start end error
BOOTP broadcast 1

----

Do you have an idea what is going on here?

> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>
> Hello,
>
> This patch is based on commit
> f892a7f397a Revert "Merge patch series "pxe: Precursor series for supporting read_all() in extlinux / PXE""
> of the next branch of U-Boot.
>
> Regards,
> Siddharth.
>
>  drivers/net/ti/am65-cpsw-nuss.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
> index 3c62fc0b428..9b69f36d04d 100644
> --- a/drivers/net/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ti/am65-cpsw-nuss.c
> @@ -438,6 +438,12 @@ static int am65_cpsw_start(struct udevice *dev)
>                        port->port_sgmii_base + AM65_CPSW_SGMII_CONTROL_REG);
>         }
>
> +       ret = phy_config(priv->phydev);
> +       if (ret < 0) {
> +               dev_err(dev, "phy_config failed: %d", ret);
> +               goto err_dis_rx;
> +       }
> +
>         ret = phy_startup(priv->phydev);
>         if (ret) {
>                 dev_err(dev, "phy_startup failed\n");
> @@ -639,9 +645,6 @@ static int am65_cpsw_phy_init(struct udevice *dev)
>         phydev->advertising = phydev->supported;
>
>         priv->phydev = phydev;
> -       ret = phy_config(phydev);
> -       if (ret < 0)
> -               dev_err(dev, "phy_config() failed: %d", ret);
>
>         return ret;
>  }
> --
> 2.34.1
>

BR,
Heiko
