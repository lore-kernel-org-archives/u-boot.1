Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15D5C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8158652C;
	Mon, 28 Aug 2023 19:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XEdxbTE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D758650B; Mon, 28 Aug 2023 19:56:02 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF6C864CF
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d795e9a0816so2748191276.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245356; x=1693850156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41s09ipCwt+HBXBMYVUqKkWkZfUk1Ucr/z/9hXAc8o0=;
 b=XEdxbTE9Ho5wVAaThqAXiNQi/jThbyxNqPCZhMpxKA0sCXjQvIKpO+TSJwSlrdplbw
 woRbLHh1EKDsscTQXpLsWJA2UPjNEUZYXMUKzS56FsuANSsPHwBgwrwmPaFac34ud/0G
 hNEEGmvW1Ws25DUb9fM4udg6jEpanz3+Q0iPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245356; x=1693850156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41s09ipCwt+HBXBMYVUqKkWkZfUk1Ucr/z/9hXAc8o0=;
 b=AQGJsfdDuk24Djy9mHyx5FnH2soWMlifydam1gCm72ruRy0K2izFdVT7CQO8fqYPuw
 vNbbXWdfNxhfEZhC/cDOQs2Eq/WZZjF+h4Lew9AIZWwM8QI6vDJonF4MBC6VXaDsWpMm
 niGVqtaUFH8dKbLpREDgTDq0uiW2X8uv5hTDEOKtvY+TATWUAxrlyqKOLAmtimkGgG7f
 rk1ck0ODNxk3ouGj7aL96XpuC7wPtyIPEEQ4HTmCwXceX2PfcXgKtM+IjYPO7DKD9hYA
 N2zzEaGOhl+yB3cZuFzA0eH5DKKgaOR51D8Yt5D/cdS2EMVYWGWBjpmUq3aolkh84BdR
 4WWA==
X-Gm-Message-State: AOJu0YwjOTbnzp7DZertiq7L9+ClP1jn/1H5ZLpua0ZoZUW/3Mfqafqe
 4X1EBrW/j+3uDsZc5H0DyEi1IQdv9uvyS+FJdgvHEA==
X-Google-Smtp-Source: AGHT+IE2C5jpnNElz4h+5fXdO7fX/055uo+A3KgB9iE1GvHkZeXb6dllrTiXiD8CdKJPf4rqpaQhqkLymfw7S0KlWAA=
X-Received: by 2002:a25:8d8d:0:b0:d7a:bfcf:2d1 with SMTP id
 o13-20020a258d8d000000b00d7abfcf02d1mr6502543ybl.33.1693245356083; Mon, 28
 Aug 2023 10:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230824011804.1501058-1-sjg@chromium.org>
 <CAJ+vNU0PJ3FuHXZqp7xgx0QRK6oE7KSGDOCRafGk-GyNWyduzA@mail.gmail.com>
In-Reply-To: <CAJ+vNU0PJ3FuHXZqp7xgx0QRK6oE7KSGDOCRafGk-GyNWyduzA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:55:00 -0600
Message-ID: <CAPnjgZ3KwM0i57uZ8wd-63qY41Oo1hQV=ckb3CoSm2Z0PtgL_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] imx: Drop unneeded phandle in FIT template
To: Tim Harvey <tharvey@gateworks.com>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>, Stefano Babic <sbabic@denx.de>,
 Su Baocheng <baocheng.su@siemens.com>
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

Hi Tim,

On Mon, 28 Aug 2023 at 11:33, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Wed, Aug 23, 2023 at 6:18=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Adding a phandle to a template node is not allowed, since when the node=
 is
> > instantiated multiple times, we end up with duplicate phandles.
> >
> > Drop this invalid constructs.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi | 2 ++
> >  arch/arm/dts/imx8mm-u-boot.dtsi                   | 2 +-
> >  arch/arm/dts/imx8mn-u-boot.dtsi                   | 2 +-
> >  arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi        | 2 ++
> >  arch/arm/dts/imx8mp-u-boot.dtsi                   | 4 ++--
> >  arch/arm/dts/imx8qm-u-boot.dtsi                   | 2 +-
> >  arch/arm/dts/k3-am65-iot2050-boot-image.dtsi      | 8 ++++----
> >  7 files changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi b/arch/a=
rm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
> > index 484e31824b85..d93e1cbd8a71 100644
> > --- a/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
> > @@ -41,9 +41,11 @@
> >         };
> >  };
> >
> > +/* This cannot work since it refers to a template node
> >  &binman_configuration {
> >         loadables =3D "atf", "fip";
> >  };
> > +*/
> >
> >  &fec1 {
> >         phy-reset-gpios =3D <&gpio4 22 GPIO_ACTIVE_LOW>;
> > diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-bo=
ot.dtsi
> > index 035282bf0b00..6085128e24ec 100644
> > --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> > @@ -140,7 +140,7 @@
> >                         configurations {
> >                                 default =3D "@config-DEFAULT-SEQ";
> >
> > -                               binman_configuration: @config-SEQ {
> > +                               @config-SEQ {
> >                                         description =3D "NAME";
> >                                         fdt =3D "fdt-SEQ";
> >                                         firmware =3D "uboot";
> > diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-bo=
ot.dtsi
> > index 5046b38e4e29..bc57566a108f 100644
> > --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> > @@ -204,7 +204,7 @@
> >                         configurations {
> >                                 default =3D "@config-DEFAULT-SEQ";
> >
> > -                               binman_configuration: @config-SEQ {
> > +                               @config-SEQ {
> >                                         description =3D "NAME";
> >                                         fdt =3D "fdt-SEQ";
> >                                         firmware =3D "uboot";
> > diff --git a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi b/arch/arm/dts/=
imx8mp-rsb3720-a1-u-boot.dtsi
> > index f3fb44046d5c..c4ea536b29bb 100644
> > --- a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
> > @@ -162,6 +162,8 @@
> >         };
> >  };
> >
> > +/* This cannot work since it refers to a template node
> >  &binman_configuration {
> >         loadables =3D "atf", "fip";
> >  };
> > +*/
> > diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-bo=
ot.dtsi
> > index 36e7444a627b..200938a98072 100644
> > --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> > @@ -146,7 +146,7 @@
> >                                         type =3D "flat_dt";
> >                                         compression =3D "none";
> >
> > -                                       uboot_fdt_blob: blob-ext {
> > +                                       blob-ext {
> >                                                 filename =3D "u-boot.dt=
b";
> >                                         };
> >                                 };
> > @@ -155,7 +155,7 @@
> >                         configurations {
> >                                 default =3D "@config-DEFAULT-SEQ";
> >
> > -                               binman_configuration: @config-SEQ {
> > +                               @config-SEQ {
> >                                         description =3D "NAME";
> >                                         fdt =3D "fdt-SEQ";
> >                                         firmware =3D "uboot";
> > diff --git a/arch/arm/dts/imx8qm-u-boot.dtsi b/arch/arm/dts/imx8qm-u-bo=
ot.dtsi
> > index a3e0af48109b..d316e869516f 100644
> > --- a/arch/arm/dts/imx8qm-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8qm-u-boot.dtsi
> > @@ -112,7 +112,7 @@
> >                         configurations {
> >                                 default =3D "@config-DEFAULT-SEQ";
> >
> > -                               binman_configuration: @config-SEQ {
> > +                               @config-SEQ {
> >                                         description =3D "NAME";
> >                                         fdt =3D "fdt-SEQ";
> >                                         firmware =3D "uboot";
> > diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dt=
s/k3-am65-iot2050-boot-image.dtsi
> > index 3ecb461b0110..64318d09cf0a 100644
> > --- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
> > +++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
> > @@ -41,7 +41,7 @@
> >                                         os =3D "arm-trusted-firmware";
> >                                         load =3D <CONFIG_K3_ATF_LOAD_AD=
DR>;
> >                                         entry =3D <CONFIG_K3_ATF_LOAD_A=
DDR>;
> > -                                       atf: atf-bl31 {
> > +                                       atf-bl31 {
> >                                         };
> >                                 };
> >
> > @@ -53,7 +53,7 @@
> >                                         os =3D "tee";
> >                                         load =3D <0x9e800000>;
> >                                         entry =3D <0x9e800000>;
> > -                                       tee: tee-os {
> > +                                       tee-os {
> >                                         };
> >                                 };
> >
> > @@ -78,7 +78,7 @@
> >                                         compression =3D "none";
> >                                         load =3D <CONFIG_SPL_TEXT_BASE>=
;
> >                                         entry =3D <CONFIG_SPL_TEXT_BASE=
>;
> > -                                       u_boot_spl_nodtb: blob-ext {
> > +                                       blob-ext {
> >                                                 filename =3D "spl/u-boo=
t-spl-nodtb.bin";
> >                                         };
> >                                 };
> > @@ -88,7 +88,7 @@
> >                                         type =3D "flat_dt";
> >                                         arch =3D "arm";
> >                                         compression =3D "none";
> > -                                       spl_am65x_evm_dtb: blob-ext {
> > +                                       blob-ext {
> >                                                 filename =3D "spl/dts/k=
3-am65-iot2050-spl.dtb";
> >                                         };
> >                                 };
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
>
> Simon,
>
> Adding Ying-Chun Liu (PaulLiu) here as he is the maintainer for both
> boards being affected here.
>
> I'm not clear if the two affected boards here do have duplicate
> phandles due to only having a single dtb in their defconfigs. However
> I could not get imx8mm-cl-iot-gate-optee_defconfig,
> imx8mp_rsb3720a1_4G_defconfig, or imx8mp_rsb3720a1_6G_defconfig which
> use those two files to build with latest master to even check:
>   BINMAN  .binman_stamp
> Image 'itb' is missing external blobs and is non-functional: blob-ext
>
> /binman/itb/fit/images/fip/blob-ext (fip.bin):
>    Missing blob
>
> Some images are invalid
> make: *** [Makefile:1115: .binman_stamp] Error 103
>
> So it seems these boards are broken anyway and need some attention so
> for both patches:
>
> Acked-by: Tim Harvey <tharvey@gateworks.com>
>

Eek, OK. Well that's good to know. Thank you for digging into it.

> Is there a test that binman can make to catch any future occurrences
> of phandles being added to templates?

Yes in the FDT library's test_copy_node()  and binman's testTemplatePhandle=
Dup()

Regards,
Simon
