Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58D7C83030
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 01:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675A081FEE;
	Tue,  1 Jul 2025 03:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KhsGEvl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3842581FFC; Tue,  1 Jul 2025 03:45:42 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D10A8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 03:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-553b60de463so3204522e87.3
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751334331; x=1751939131; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQTUQNPZlz5xD/IO92qKBUQkWiRWy0Eq/TDbTvjIq2I=;
 b=KhsGEvl7lz3IXBhIhF67bkXjx9WzWnxf1n9QNBIam8sYZ1n4EYmbOXRt1oWAug1DzX
 KRbOQGaR/Sf1xU9Emj/TyqTV8yCMVo8KEGqx2iWJEJDgjxj2int10jvbCK15AIKEsAlu
 7i2f2Yi/QcDLpLRtc/mJxzOlhyKvoxUnHto488DYcPeYrJrA098QvRe8ErA6eo+agBzf
 Z8hZmXgmXXOhjs6r6cUZyEeUIZXLqRyacSATaNsEWFZiTDxsgmgFwwkXW58PD5KraqPI
 w8nLZYwEEJQrQ8I2+JGDA94npNl9I8jUtUy/I8cPgc+9ZsgxBQXUM6pfTdF0nZS0Wc5c
 91yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751334331; x=1751939131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQTUQNPZlz5xD/IO92qKBUQkWiRWy0Eq/TDbTvjIq2I=;
 b=dF9DWILL7VFh0obq4WBuEKK+cVOK90kJ2WD+aj5IbTKpcj1ewZPr64GXFgijUeaDLk
 giKwhPbpXS9E2vsHzbXi2R02qdxBTFHo1bjrn33jucjI7tOdMqfmy1hpDj3qTj2EZlyY
 KFkbL6zbt+ldtXEyGA9YiQqfSBpivp8vDIH7h7cn02wyE8rDsbYpOO60OcelWaXv2ewZ
 DNau/GkymVbs84FTDsn7dY1Snv+IOuLDtfPE342EzB72D5SzU8J1Q39rungDb4I05zab
 1a64TrU9bS/ENv0owtBbvfG4OAF5LASQmRFCKW+2TwD7q7mkzUO6BJPmCUIKUKUrHSeD
 csww==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6/kUTOq5HCVYHiRMvdYgtXG4JTMFxAuUNbUQFN3mGofwquGDah61QyAYic7HYJ/GFCzk/5vs=@lists.denx.de
X-Gm-Message-State: AOJu0YwD306FfcOKA5fF4t2t4mO3TI3LRH7J3FAUBQ4geeyLqAxunXBp
 ujAkj51SOprZZNCwuEla5uCxiecQKmwcdMhlowGPvP74BuNUoXlBecTDvz3YNfEZFQ1bkONNGNE
 9mV5pts6H+K8Lq5ybCMslu9AXZ23beR4=
X-Gm-Gg: ASbGncsvmOU1XMGEJXxTuE40ippt2JWyjkKe2cpZnhfLr72VEiUsc14ySIhwc/xaJt3
 eUN0NUnHqN+xQJZu8MHhkJweG63/ncm87xJBUI/PV5jNWJ3RtIyyFkvW58zlc0xfg7F/uWA2djU
 1Wtwp+EH8OE0GRDI7uBJ/Si+wWzKttwRSasiKepuvpDNiGBMYpZ5Idh2VtmshqXecdcLsWWAC9K
 LQ=
X-Google-Smtp-Source: AGHT+IFNOeRg8RKeDC1OnoQtoMbYJbt/h0rss2Y6fk9VEYMqjSETFjqY6Esj3GzyMu8bwqOQBzCsi07jmWAxKj+/JJo=
X-Received: by 2002:a05:6512:e8b:b0:553:3486:1d9b with SMTP id
 2adb3069b0e04-5550b8d2b0fmr5143254e87.30.1751334330947; Mon, 30 Jun 2025
 18:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250627054943.3140496-1-lukma@denx.de>
In-Reply-To: <20250627054943.3140496-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 30 Jun 2025 22:45:19 -0300
X-Gm-Features: Ac12FXx8CZlnqvm1g1Jt_7KIFhhI0-BqXf9kJ05XyaMfd4bxogeKQ7Yb1kJPmdI
Message-ID: <CAOMZO5Da48sAEX=wLXEhYsch8pZO0DxLwcW+Ps_MaDgBtaA+_g@mail.gmail.com>
Subject: Re: [PATCH] arm: pinctrl: Define .mux_mask field for NXP's SoC
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, 
 Gary Bisson <bisson.gary@gmail.com>, Jonathan Currier <dullfire@yahoo.com>,
 Marek Vasut <marex@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Jesse Taube <mr.bossman075@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 27, 2025 at 2:50=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> The commit e8a9521e649f
> ("vf500/vf610: synchronise device trees with linux")
> has synchronized U-Boot's DTS with v5.19 Linux kernel.
> It turned out that in Linux's upstream iomuxc node description the
> 'fsl,mux_mask' was missing, so the U-Boot's pinctrl driver for NXP's
> Vybrid SoC was not working properly.
>
> As by default the mux mask was set to 0, for example the vf610 based
> boards (like BK4) were bricked, due to misconfiguration of gpio at
> early boot stage.
>
> The fix for all NXP eligible boards is to define .mux_mask field for
> soc specific *pinctrl_soc_info structure and use it directly in pinctrl
> MMIO driver, without the need to read the "fsl,mux_mask" property from
> device tree.
>
> This change brings the NXP's pinctrl driver in U-Boot closer to Linux
> upstream one.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Applied to u-boot-imx/next, thanks.
