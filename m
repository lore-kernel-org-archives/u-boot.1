Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05659C25B78
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 17:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47917884DC;
	Fri, 17 May 2024 19:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="JpfQ4Lvp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05615884CD; Fri, 17 May 2024 19:36:14 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76CEF884E1
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 19:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a5a4bc9578cso459199066b.2
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715967369; x=1716572169; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9JgpT0iD5QKfPati6r1tZpT7sJG+gdX54lZ/cN37eY=;
 b=JpfQ4LvpqsH/Xci+3cZNOlzyMrp0L7QS0+wn1eW8J73dNtiRhGQpnkl06qPbz/rdPz
 oCb+tM5urf0YwGu5W5b3GfHWK70DN9KmIEXtWhnTGZdRRZE9MeEQ9F2iowDEjgnmgyMg
 WBdVyb4vxt4i3v7vjEfaM/MV/GfocW84BJmA1f8HJsRkVTThpcBhKBMI0grokiDoPmTs
 tLD8N1WrdFOpQ2GgKREZGgTFyr2f0FD2KGqSDK1YgqqKUj/KCkeh8ZHL43cb8wT5TCsp
 Z/tOSJmpaEsrQZvVyWL+3tV/kTpeJEtrmsAhu9WTIxMYkcbExIm5BYtGOS6ktUtoeKNB
 JRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715967369; x=1716572169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9JgpT0iD5QKfPati6r1tZpT7sJG+gdX54lZ/cN37eY=;
 b=safpqQN1PMWuV0PsyGcPk85QvfmN/z0IHu71w+MzRarI0nWYCDYU3VGLCHiNVFO536
 ETFyO/XAZR1Dlc+SDjoM+wHuTqIIO3XngKCuH6dVaJSiRdlqnYI8Ofe8iDZiTSQJRM2R
 eJcHBl72h7UrFubO1OOD2xWJ7pfu9r/D9iVacDhNo31cTG4j8t0RMvgi41DGsk9VO3F4
 HDZ7TtiMQ0aCTyYSAJYhcTABvM88VyGHi0B5NEK76RJtIdVAk/nKu6WlGVEW4EZrrl6m
 TcSfE7LfcERe1Ae5hZzap7h8QnXV1UGog1uZ6FM/vy8qa50bCP6GAoucwQ0Vtci79mGt
 CMZw==
X-Gm-Message-State: AOJu0YxfXq3YbdAVZDMQdNccH9z40t0gcAe9h/bRTq+eCeSrb9lifkV2
 OTznOjZwaVoapw5Yzx+42b244LlVOCv7xtb14Wz+DJZTvJfdxQNA8nx4GWJD45s+QjHr1tO4XdQ
 V0nJXC4IqrClxBnydv/VJH/X4QDyEYiGVaMVE1w==
X-Google-Smtp-Source: AGHT+IGlijReSOypcHWT/BXp4K4rsL9NW2Ol46jVG58PrUCTeeBJNh249ein5iY66bSD0bPVOnPmc6EqnJuk6gDUjco=
X-Received: by 2002:a17:907:320b:b0:a59:b177:22d7 with SMTP id
 a640c23a62f3a-a5a2d53b75emr2738642066b.8.1715967368808; Fri, 17 May 2024
 10:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240516213036.89016-1-marex@denx.de>
 <20240516213036.89016-4-marex@denx.de>
 <CAJ+vNU1Sb60gX4RoHwO=o2kf0c9bW85W2i1VwJg3Oa1hFmxADw@mail.gmail.com>
 <b5366e76-6642-457d-ade9-a0e68f181e99@denx.de>
In-Reply-To: <b5366e76-6642-457d-ade9-a0e68f181e99@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 17 May 2024 10:35:55 -0700
Message-ID: <CAJ+vNU3jpRe+6VvA1UVJSvoxf5SrAvK-ZC9vcsCF74_zLsyx_g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] imx: hab: Use nxp_imx8mcst etype for i.MX8M
 flash.bin signing
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, anton.gres@ifm.com, ch@denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>, kernel@puri.sm, 
 u-boot@dh-electronics.com
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

On Thu, May 16, 2024 at 6:31=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 5/16/24 11:40 PM, Tim Harvey wrote:
>
> [...]
>
> >> -The entire script is available in doc/imx/habv4/csf_examples/mx8m/csf=
.sh
> >> -and can be used as follows to modify flash.bin to be signed
> >> -(adjust paths as needed):
> >> -```
> >> -export CST_DIR=3D/usr/src/cst-3.3.1/
> >> -export CSF_KEY=3D$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pe=
m
> >> -export IMG_KEY=3D$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pe=
m
> >> -export SRK_TABLE=3D$CST_DIR/crts/SRK_1_2_3_4_table.bin
> >> -export PATH=3D$CST_DIR/linux64/bin:$PATH
> >
> > Hi Marek,
> >
> > I thought you were going to leave the above env setting examples in
> > the documentation.
> >
> > I suggest showing how to specify using env (by just leaving the above
> > in) as well as by copying them directly to the build directory if
> > wanted.. otherwise the documentation is lacking.
>
> If the tool can do env vars now, I would like to avoid copying key
> material around. So what about this:
>
> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> index 1eb1fb0aa61..257ffb45656 100644
> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> @@ -144,6 +144,8 @@ The signing is activated by wrapping SPL and
> fitImage sections into nxp-imx8mcst
>   etype, which is done automatically in
> arch/arm/dts/imx8m{m,n,p,q}-u-boot.dtsi
>   in case CONFIG_IMX_HAB Kconfig symbol is enabled.
>
> +Build of flash.bin target then produces a signed flash.bin automatically=
.
> +
>   The nxp-imx8mcst etype is configurable using either DT properties or
> environment
>   variables. The following DT properties and environment variables are
> supported.
>   Note that environment variables override DT properties.
> @@ -160,7 +162,15 @@ Note that environment variables override DT properti=
es.
>   | nxp,img-crt        | IMG_KEY   | full path to the IMG Key
> IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
>
> +--------------------+-----------+---------------------------------------=
---------------------------+
>
> -Build of flash.bin target then produces a signed flash.bin automatically=
.
> +Environment variables can be set as follows to point the build process
> +to external key material:
> +```
> +export CST_DIR=3D/usr/src/cst-3.3.1/
> +export CSF_KEY=3D$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> +export IMG_KEY=3D$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> +export SRK_TABLE=3D$CST_DIR/crts/SRK_1_2_3_4_table.bin
> +make flash.bin
> +```
>
>   1.4 Closing the device
>   -----------------------
>

Hi Marek,

Yes, with that change you can add for the series:
Reviewed-by: Tim Harvey <tharvey@gateworks.com>

Best Regards,

Tim
