Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E39C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 19:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E2487B01;
	Thu, 28 Dec 2023 20:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yx4TcqWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867B3879E9; Thu, 28 Dec 2023 20:48:29 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0353887B49
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 20:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-427e69f70afso15143291cf.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 11:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703792904; x=1704397704; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nm3vgKsckklqjNzAO8oqsgXSj1huNJyVodZNruQUPA=;
 b=Yx4TcqWcyjhhBdsfDWYRuRisc5dZqAHMBWCr+jyLzvKRJnR1Z5EHa7cxGcJoTT6cQT
 8OSuCLDNr7+BEqpvwud9v8Tr2t4Kngzjsts/IzuGQTqyy72Tf7cTQCXfzgxkMpXSqZfa
 TolHzSTeu3CAmYCip6eUDVhyczX8h6akhmJas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703792904; x=1704397704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nm3vgKsckklqjNzAO8oqsgXSj1huNJyVodZNruQUPA=;
 b=Z5CGbzY+LRsgapiXhVmFf27G5eR15wwxM7h/X4iZ8zdq6Zicm5ScV8goHri9hkadLk
 ZcOL3vSuz4ppe9LkZ/AXSctXN6enE48rmb+Uni9iLKJTXaE0Mi8xm1ilfaAO/0AALTib
 V+0kO4pi7zoByHBnmsc+yzyjV69h7JvBh/gSz4oIybSMUWRveVcWYz/o4crkX9nQirh2
 Ha33p3iiBbKMAQzzBjR9ZSuUHsBX3DPXwtCk0xt0ekC+/AYpee3EVwIMeGMMgA0SvisU
 ZyWMU8kAJeLNgoSiUHSVKVudlUe1ksS1ra9XuW81fILSuSJ+sgTgJjTv5qZUjlfCHTwR
 tPwg==
X-Gm-Message-State: AOJu0Yxmn4hUj2MpXbPZDnIuiu7ScV7u0NcDmjfzBmIxQEbYgKyAtJ5q
 NIJMCcvFf7l/0x83v8pb8FguXjDDuaVRA6R22q+CdspeFHdE
X-Google-Smtp-Source: AGHT+IFzWnbwyeVFfCQT35A1ZnwpYai9+l/Sy8oBOJnnbahIUDxN2eMlg5Jhm3dHZjgJ1O/MZtBseQdx8NaE1zMk7+I=
X-Received: by 2002:a05:6214:caf:b0:67f:40eb:bfa7 with SMTP id
 s15-20020a0562140caf00b0067f40ebbfa7mr17380942qvs.48.1703792903810; Thu, 28
 Dec 2023 11:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-8-sumit.garg@linaro.org>
 <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
 <20231228135642.GA2652760@bill-the-cat>
 <CAFLszThP+GJcPP_LJBva1M5mi9Wj-Nh-z7A6-fkSpPgOTtLmRQ@mail.gmail.com>
 <20231228152504.GF2652760@bill-the-cat>
In-Reply-To: <20231228152504.GF2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 19:48:13 +0000
Message-ID: <CAFLszTh24c1L4xfab7EmgSYJt6HhwfK+0h6quEMNt9QxW01DqA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] dts: meson-gxbb: Switch to using upstream DT
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
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

Hi Tom,

On Thu, Dec 28, 2023 at 3:25=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 03:09:41PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, Dec 28, 2023 at 1:56=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Dec 28, 2023 at 01:37:11PM +0000, Simon Glass wrote:
> > > > Hi Sumit,
> > > >
> > > > On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@lin=
aro.org> wrote:
> > > > >
> > > > > Although there were still some variations in board DTS files base=
d on
> > > > > meson-gxbb SoC but I think those were minor differences from upst=
ream
> > > > > and shouldn't impact boot on these devices.
> > > > >
> > > > > So switch to upstream DT via mirroring amlogic/ directory from
> > > > > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby dir=
ectly
> > > > > building DTB from there including *-u-boot.dtsi files from
> > > > > arch/$(ARCH)/dts/ directory.
> > > > >
> > > > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > > --------------
> > > > > - Dropped Makefile portion and enabled OF_UPSTREAM for SoC instea=
d.
> > > > >
> > > > > Changes in v2:
> > > > > --------------
> > > > > - Picked up review tag
> > > > >
> > > > >  arch/arm/mach-meson/Kconfig           | 1 +
> > > > >  configs/nanopi-k2_defconfig           | 2 +-
> > > > >  configs/odroid-c2_defconfig           | 2 +-
> > > > >  configs/p200_defconfig                | 2 +-
> > > > >  configs/p201_defconfig                | 2 +-
> > > > >  configs/videostrong-kii-pro_defconfig | 2 +-
> > > > >  configs/wetek-hub_defconfig           | 2 +-
> > > > >  configs/wetek-play2_defconfig         | 2 +-
> > > > >  dts/arch/arm64/amlogic                | 1 +
> > > > >  9 files changed, 9 insertions(+), 7 deletions(-)
> > > > >  create mode 120000 dts/arch/arm64/amlogic
> > > > >
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > > diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kc=
onfig
> > > > > index d6c89058061..8ddb59161a0 100644
> > > > > --- a/arch/arm/mach-meson/Kconfig
> > > > > +++ b/arch/arm/mach-meson/Kconfig
> > > > > @@ -25,6 +25,7 @@ choice
> > > > >  config MESON_GXBB
> > > > >         bool "GXBB"
> > > > >         select MESON_GX
> > > > > +       imply OF_UPSTREAM
> > > > >         help
> > > > >           Select this if your SoC is an S905
> > > > >
> > > > > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defc=
onfig
> > > > > index 41dbf7981f8..2e1c756bf7a 100644
> > > > > --- a/configs/nanopi-k2_defconfig
> > > > > +++ b/configs/nanopi-k2_defconfig
> > > > > @@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > > > >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> > > > >  CONFIG_ENV_SIZE=3D0x2000
> > > > >  CONFIG_DM_GPIO=3Dy
> > > > > -CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> > > > >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> > > > >  CONFIG_DM_RESET=3Dy
> > > > >  CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> > > >
> > > > So now I am wondering if we can (later) have the SoC be implied whe=
n
> > > > using OF_UPSTREAM so we can do:
> > > >
> > > > CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > >
> > > > and it will add the 'amlogic/' automatically?
> > > >
> > > > Perhaps that might be a way to bridge the gap in terms of file layo=
ut?
> > >
> > > That's going to start to look real ugly real quick I suspect and I'm =
not
> > > sure what it really gets us? It seems to me that the convention of
> > > "vendor/board" has already been well enough adapted outside of the
> > > kernel, with the odd sticking point being getting everyone used to
> > > whatever will be happening for 32bit boards long term. So I think hid=
ing
> > > the vendor part of the string here will be more, not less, confusing
> > > long term.
> >
> > Now that I dig in a bit, I see that the devicetree-rebasing tree does
> > not have any Makefiles in it. How does Linux build with it? Does
> > anyone have instructions?
>
> Linux doesn't build with it, it's the relevant parts of the kernel tree
> extracted for other projects to more easily use (more or less).

Hmmm, in that case can we add Makefiles into the U-Boot version of the
tree, for U-Boot use?

Regards,
Simon
