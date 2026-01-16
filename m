Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86AED489A3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 13:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E949F83935;
	Fri, 16 Jan 2026 14:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WEQKgG0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB078367F; Fri, 16 Jan 2026 12:00:58 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD6C830E4
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 12:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-5029901389dso12054451cf.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 03:00:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768561255; cv=none;
 d=google.com; s=arc-20240605;
 b=jCazVOOt0kCt2O0725hfDF7OaK8rKpGsIoQ8RORXZ7FEvh0gJkUXvfRWPAaL6+R8+H
 uljn06Vz965kFu79flnv6YMiy01W1Dx7B5+qku+0MT6c626aMCgh4pKxRUq+ZB+INChU
 g+Vzazs1wgu5/a/NIB3vtIvxMKLbM0XHWNx6qbBDWNfAqEr16Jhq7JEF14xivrW9jDBn
 jshnsY2uiBt6R4uHyQpZMD8U+IOvDDbzeVPcpn8YQqLoDPvu1XYCGPdyH9nhdv3tA84v
 bS8dPviA7JBY6bqgzJoIjk79VKBFVaWRateM4aJFckiVBgJjEjhyn+nAY5Xz7vZ0u56g
 BIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IKTFXgHUmUZpUim/4nogAbgZNRYZryfNCdvu3PT7IgI=;
 fh=8VqwTZ7piYjPWQEFUarO0F8pZOq/0cPbU4RFz6Q+04g=;
 b=DhhH5PEtbKM2Zv7XaTqojqvBdc9pXajOT3MC9ROyqxXUkoK8ywBStYzqFHMNRm6b1v
 ArkN0DSYX2hCs2nNCk8MEH7m8PwpKdLm8FZ5Uk8Z/jZzUjiwnqK3nd/s+3o4lT++Ip/X
 8Aj2yZxH5q6P24CJglwCqO7WFy9u1x1Px6KSkO2RCDEwEyXr8czn+guaqQfj9WgSol61
 i0UVTgpnj4uswfUa8WkhgzCX6R/u3x0C6uukFmJlecv4LTRLrDh73wVu9AqfVT9+mrGT
 XWBTi4edxfOgYfxaVrQO6CDXkjWaV35uaxZnKD0dmkmCGIY4chdOFPynEKWxanEsRpWi
 dRMA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768561255; x=1769166055; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKTFXgHUmUZpUim/4nogAbgZNRYZryfNCdvu3PT7IgI=;
 b=WEQKgG0YheoJlp0ebyMoUIQThzjweakiQE6AM2lvOa2H+BjyimhNFTN1ZLFZB3ASlB
 XbLTrRfAPGpvrSkniCrKEn4iF2MIzFhZWtXZnGwH5HmbMcYfuG+rpacAf0yNVQwvHBsq
 rg10p4d8I4p7CPbJR8U4F5h03AZOE4nh8Kq8Y7s0UCeN1QITRe5MIyVgJ1wAxkqZTo/M
 VbRHoTcn0Yc4mUEhL/83R9smzoXcQhRWEP6mr8TMh2gKVoB5TwYs/xjReV+GLFx64PeQ
 ivaOnV+A/7L2zOu2Auo7uHafWYIUlqn1QujIQ3UDax5QVpsMQiJjJdHKO5TgK1nFAv2x
 TneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768561255; x=1769166055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IKTFXgHUmUZpUim/4nogAbgZNRYZryfNCdvu3PT7IgI=;
 b=RjCGw9FyuA3bQ3qNSQiNS7gzWFW9YmcqYDAIooQtt5HBhMv6pQ4zQrBDr2amMfB0hQ
 l40NFZFkK1QRyEDVMEyBiElsyT3RIu2DXZ6gf/DFvocMdY/ZtY3HUrSB/XLGvqj53WIK
 x5OxplfSB9alGjWvpXbHoVCSgdMkVQXtBf4ZKg9cTQB0TpZrQFLy1lc2mrUNeJp2UKAI
 UUxYDow40+c7CnTxOZISGiWWckd5HEByw+6b2mkyx1Rfb93Mpu/S98lS/G5y2i/Ru/y6
 ute+6013mF8PWrioSEon0qRS+C7nV7WarrbNnm2n1BBurIQXYhaTlmqeHBHnEnys7eoV
 RhdA==
X-Gm-Message-State: AOJu0Yw5PZYQWQaKmIxv9ZZ6Oxj/F625MjqIqcWwoAxLwBgPQPJkY85B
 wiDd3WbUVi7B8i6Z/n1NoJqRqrWIfaQgghHue2+uAF0QjaMO7ScQqcPwNdf52cBg9hYn6Mj+F9M
 XjnLBEwB/ECyRCGizejZQ2OAayLqgWPw=
X-Gm-Gg: AY/fxX6yDCC6uBUDhhaIXyYMSPh7C1aUGNCBnKKD+IvzCQn0SBAw06dvepwlScLwBTV
 NwXA4Uqv81IcUwpK0BJu5l52GxiDKUjUu5ykVEk1gcbkD+M/a0nnsjwkALpxCk79VUkN3Jfuf2Z
 RQkj8HYe5K8ScIkZNgkkO7E4jYaosCXXx49vE/YWfuTwQkjtg3Ldrf4aP4TTEFxJeK77P+qv2E6
 T67nwo8Od0dC7lrhSrS0O4XJmks4k7CnIlRkL771b79wulebJBxtokL/V6V9oPmBfe4zdhrJnG9
 703l2tbOkvEzVk7SOY4XbKZ4Ilcb
X-Received: by 2002:a05:622a:1794:b0:4e7:2210:295f with SMTP id
 d75a77b69052e-502a15ec140mr37368121cf.13.1768561254549; Fri, 16 Jan 2026
 03:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
 <20260108-rk3576-ufs-v4-2-e8e67649f3f8@gmail.com>
 <ad431bd8-7c0e-41d3-b079-14ab5c82b7a7@cherry.de>
In-Reply-To: <ad431bd8-7c0e-41d3-b079-14ab5c82b7a7@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 16 Jan 2026 15:00:40 +0400
X-Gm-Features: AZwV_QgeMyXpLirHGil1Bxws_QHyFF_3RTp3oI8XmCb5JttLeIbK4KMxOeQg7tw
Message-ID: <CABjd4YzwcqrB26AOA+7QUTiv84pq-=gp8VL0jSR+KBDFoMESEA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] ufs: rockchip: Add device reset support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 16 Jan 2026 14:32:50 +0100
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

On Wed, Jan 14, 2026 at 10:24=E2=80=AFPM Quentin Schulz
<quentin.schulz@cherry.de> wrote:
>
> Hi Alexey,
>
> On 1/8/26 6:49 PM, Alexey Charkov wrote:
> > Wire up the GPIO line which Rockchip RK3576 UFS controller uses to rese=
t
> > the connected UFS device.
> >
>
> It'd be nice to say that reset-gpios is required as per the Device Tree
> binding, c.f.
> https://elixir.bootlin.com/linux/v6.18.5/source/Documentation/devicetree/=
bindings/ufs/rockchip,rk3576-ufshc.yaml#L70

Will do, thanks!

> > This seems necessary at least for some UFS modules and fixes the follow=
ing
> > error while enumerating UFS storage:
> >
> > ufshcd-rockchip ufshc@2a2d0000: ufshcd_link_startup: Device not present
> > ufshcd-rockchip ufshc@2a2d0000: link startup failed -6
> > ufshcd-rockchip ufshc@2a2d0000: ufshcd_pltfrm_init() failed -6
> >
> > Fixes: 76465ce21ee4 ("ufs: rockchip: Add initial support")
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >   drivers/ufs/Kconfig        |  1 +
> >   drivers/ufs/ufs-rockchip.c | 25 +++++++++++++++++++++++++
> >   drivers/ufs/ufs-rockchip.h |  1 +
> >   3 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> > index 6c75bb2a0790..30b0c87798e1 100644
> > --- a/drivers/ufs/Kconfig
> > +++ b/drivers/ufs/Kconfig
> > @@ -76,6 +76,7 @@ config UFS_RENESAS_GEN5
> >   config UFS_ROCKCHIP
> >       bool "Rockchip specific hooks to UFS controller platform driver"
> >       depends on UFS
> > +     select DM_GPIO
> >       help
> >         This selects the Rockchip specific additions to UFSHCD platform=
 driver.
> >
> > diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> > index 0384244387da..48444705fb29 100644
> > --- a/drivers/ufs/ufs-rockchip.c
> > +++ b/drivers/ufs/ufs-rockchip.c
> > @@ -5,6 +5,7 @@
> >    * Copyright (C) 2025 Rockchip Electronics Co.Ltd.
> >    */
> >
> > +#include <asm/gpio.h>
> >   #include <asm/io.h>
> >   #include <clk.h>
> >   #include <dm.h>
> > @@ -153,11 +154,34 @@ static int ufs_rockchip_common_init(struct ufs_hb=
a *hba)
> >               return err;
> >       }
> >
> > +     err =3D gpio_request_by_name(dev, "reset-gpios", 0, &host->device=
_reset,
> > +                                GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> > +     if (err) {
> > +             dev_err(dev, "Warning: cannot get reset GPIO\n");
>
> No need for "Warning: " as it is an actual error.

Agree, will change.

> > +     if (!dm_gpio_is_valid(&host->device_reset))
>
> How could it be invalid if we managed to request it in probe?

Probably can't, indeed. Will drop.

Thanks a lot,
Alexey
