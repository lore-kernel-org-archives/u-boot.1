Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6F6D64072
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 18:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36CB8922E;
	Fri,  8 Nov 2024 19:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Tx/oUgkZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA7498922E; Fri,  8 Nov 2024 19:05:21 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B50788E0A
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 19:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6e8063533b5so21933347b3.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 10:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1731089118; x=1731693918; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwM6aCZbo5+sXFjaHhn1q17tagkgpHuqzYFj84I6y3I=;
 b=Tx/oUgkZYNHtcAXJG3bsEtN2JYGzBDa0dCPZa4HxHaocO4Imd5UKpE90sM4kTj8ABy
 83tIdp48yVvnuYHsaO+8uVe7/T7UO/TJAv+joUBZF34P+oxUJM1cg1KL+rBjWcdma49x
 h2rjlG13jtL5lpEi0l/EJv86AS10i/vjufM/1f+iVWNyk8SxvuPeo/dAjeiF1viYmyrE
 sUnqUj59u1+Eu3TF/eHbNP23iI8GV8MOgJU/8y0V1lCFQ9Xu842eVQpLgUghr4cLnF48
 OGoxX1cTAxF5+su+lsBQXEVqLURbzemnTwdUac41CPvc0egfidI39yi5i5eQF1B1jY9R
 pmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731089118; x=1731693918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwM6aCZbo5+sXFjaHhn1q17tagkgpHuqzYFj84I6y3I=;
 b=ZXjA+MbLd4BRhI0vA1kiRgr2XJ1vAwquKpxNGocQFkvkk2pgQVdA2M/iM3B7uQVfWF
 6T5L9dBgwYDiRM+bHiCzgYhG//xhxANxlaGsdCuhAKz4fpu9wB8ecALZI8tqWgjQ28PR
 oFeUJ+dZodXveJDdxvCrKwd5ilUdy3uT0NsVWjri7GHpR6GLMgXrvoF3rNYkvyT77+t4
 EI01DnUlR52CMo+A0Hs1ulhPmjpJSrtGI+et8cLWXkOni/wb8J8Ema4fJL1iTPFLc1l5
 2sc3C6s3GaLrUnjlCARaGK3QUqHnV+B48JQp69Mnsb9L2CZ1eSBW8Ss5nRulJidiE8RK
 xtrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvNIQXD8Jr/J8qa2vK+E+kov1gaY5slumDdvwcKUW0t12hR4ydWMi9EOHpuR7ngLmFi/kDwxE=@lists.denx.de
X-Gm-Message-State: AOJu0YyIqa7npnM77YA2X6Mz7AhWwUFgqCmEj98ILiQkKsF4aj+6kf6D
 4oP10jaql/4Y6XYcvTwATrwOrG6+MY6cVNxYjGNLftBjxN/Q3YIxj8LHdFazjdZdtT7Env0mUNH
 NX0ToJDmO2YxonntCcqW3kP22W4Y3ArMriKl4LA==
X-Google-Smtp-Source: AGHT+IG01q+59O05QzA0dNhgZxBuq3nfWNtcd0F3A1zPhEY+rDY+PQ+jaR6oC/SmuSt4fb3y5uLmqoa/1aeHYuDUgiA=
X-Received: by 2002:a05:690c:700e:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-6eadddbcfd8mr40796237b3.20.1731089117811; Fri, 08 Nov 2024
 10:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
 <20241107-phytec_imx8m_optee-v2-1-bbc3747a60e8@phytec.de>
 <CAHCN7x+2XzhyERLmAaO-PVwkT6K_rcQgG-+xgTX8HaqstdZyOQ@mail.gmail.com>
In-Reply-To: <CAHCN7x+2XzhyERLmAaO-PVwkT6K_rcQgG-+xgTX8HaqstdZyOQ@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 8 Nov 2024 10:05:06 -0800
Message-ID: <CAJ+vNU3hpUwBdgCWGAWjpbc8o0wUwjRRQNdFNhJ-c9QHuKcPgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm: imx8m: add OP-TEE node
To: Adam Ford <aford173@gmail.com>
Cc: Yannic Moog <y.moog@phytec.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Manuel Traut <manut@mecka.net>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Fri, Nov 8, 2024 at 5:49=E2=80=AFAM Adam Ford <aford173@gmail.com> wrote=
:
>
> On Thu, Nov 7, 2024 at 2:42=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wro=
te:
> >
> > Add tee node in SoC u-boot device trees. Use a kconfig entry to specify
> > load and entry addresses for the op-tee image in the respective
> > defconfig.
> >
> > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > ---
> >  arch/arm/dts/imx8mm-u-boot.dtsi | 17 ++++++++++++++++-
> >  arch/arm/dts/imx8mn-u-boot.dtsi | 17 ++++++++++++++++-
> >  arch/arm/dts/imx8mp-u-boot.dtsi | 17 ++++++++++++++++-
> >  arch/arm/mach-imx/imx8m/Kconfig |  8 ++++++++
> >  4 files changed, 56 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-bo=
ot.dtsi
> > index d31bc822532..ecc2319279e 100644
> > --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> > @@ -164,6 +164,21 @@
> >                                         };
> >  #endif
> >
> > +                                       tee: tee {
> > +                                               description =3D "OP-TEE=
";
> > +                                               type =3D "tee";
> > +                                               arch =3D "arm64";
> > +                                               compression =3D "none";
> > +                                               os =3D "tee";
> > +                                               load =3D <CONFIG_IMX8M_=
OPTEE_LOAD_ADDR>;
> > +                                               entry =3D <CONFIG_IMX8M=
_OPTEE_LOAD_ADDR>;
> > +
> > +                                               tee-os {
> > +                                                       filename =3D "t=
ee.bin";
> > +                                                       optional;
> > +                                               };
> > +                                       };
> > +
> >                                         binman_fip: fip {
> >                                                 arch =3D "arm64";
> >                                                 compression =3D "none";
> > @@ -192,7 +207,7 @@
> >                                                 fdt =3D "fdt-SEQ";
> >                                                 firmware =3D "uboot";
> >  #ifndef CONFIG_ARMV8_PSCI
> > -                                               loadables =3D "atf";
> > +                                               loadables =3D "atf", "t=
ee";
> >  #endif
> >                                         };
> >                                 };
> > diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-bo=
ot.dtsi
> > index 6875c6d44ff..f9108cb75c7 100644
> > --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> > @@ -235,6 +235,21 @@
> >                                         };
> >  #endif
> >
> > +                                       tee: tee {
> > +                                               description =3D "OP-TEE=
";
> > +                                               type =3D "tee";
> > +                                               arch =3D "arm64";
> > +                                               compression =3D "none";
> > +                                               os =3D "tee";
> > +                                               load =3D <CONFIG_IMX8M_=
OPTEE_LOAD_ADDR>;
> > +                                               entry =3D <CONFIG_IMX8M=
_OPTEE_LOAD_ADDR>;
> > +
> > +                                               tee-os {
> > +                                                       filename =3D "t=
ee.bin";
> > +                                                       optional;
> > +                                               };
> > +                                       };
> > +
> >                                         binman_fip: fip {
> >                                                 arch =3D "arm64";
> >                                                 compression =3D "none";
> > @@ -263,7 +278,7 @@
> >                                                 fdt =3D "fdt-SEQ";
> >                                                 firmware =3D "uboot";
> >  #ifndef CONFIG_ARMV8_PSCI
> > -                                               loadables =3D "atf";
> > +                                               loadables =3D "atf", "t=
ee";
> >  #endif
> >                                         };
> >                                 };
> > diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-bo=
ot.dtsi
> > index 56749ccacd2..9ede98a11e4 100644
> > --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> > +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> > @@ -185,6 +185,21 @@
> >                                         };
> >  #endif
> >
> > +                                       tee: tee {
> > +                                               description =3D "OP-TEE=
";
> > +                                               type =3D "tee";
> > +                                               arch =3D "arm64";
> > +                                               compression =3D "none";
> > +                                               os =3D "tee";
> > +                                               load =3D <CONFIG_IMX8M_=
OPTEE_LOAD_ADDR>;
> > +                                               entry =3D <CONFIG_IMX8M=
_OPTEE_LOAD_ADDR>;
> > +
> > +                                               tee-os {
> > +                                                       filename =3D "t=
ee.bin";
> > +                                                       optional;
> > +                                               };
> > +                                       };
> > +
> >                                         @fdt-SEQ {
> >                                                 description =3D "NAME";
> >                                                 type =3D "flat_dt";
> > @@ -204,7 +219,7 @@
> >                                                 fdt =3D "fdt-SEQ";
> >                                                 firmware =3D "uboot";
> >  #ifndef CONFIG_ARMV8_PSCI
> > -                                               loadables =3D "atf";
> > +                                               loadables =3D "atf", "t=
ee";
> >  #endif
> >                                         };
> >                                 };
> > diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/=
Kconfig
> > index b254a50b091..14f14db6a35 100644
> > --- a/arch/arm/mach-imx/imx8m/Kconfig
> > +++ b/arch/arm/mach-imx/imx8m/Kconfig
> > @@ -37,6 +37,14 @@ config SYS_HAS_ARMV8_SECURE_BASE
> >           If enabled, please also define the value for ARMV8_SECURE_BAS=
E,
> >           for i.MX8M, it could be some address in OCRAM.
> >
> > +config IMX8M_OPTEE_LOAD_ADDR
> > +       hex "Load address of OPTEE image"
> > +       default 0x56000000
> > +       help
> > +         The load and entry address for the OPTEE image. This value de=
faults to
> > +         0x56000000 if not provided in the board defconfig file.
>
> I think this would need to vary based on the platform.  I think the
> addresses may be different depending on Mini, Nano and Plus and also
> dependent on the available SDRAM.

Indeed the address differs for platform (as the DRAM base address
does) and is also based on the DRAM size of the board. Here are my
notes for IMX8M:

The address is the link/load address for TEE that should match
BL32_BASE for the ATF (for imx8m) and CFG_TZDRAM_START for OPTEE. The
BL32_BASE is the same for imx8mm/n/p but it does depend on the size of
DRAM. The address should be the top 32MiB of DRAM but because U-Boot
is loading tee.bin from a FIT image into DRAM it needs to be a 32bit
address and thus needs to be adjusted down if you are on a board with
4GiB:
1GiB DRAM use 0x7e000000
2GiB DRAM use 0xbe000000
3GiB or larger use 0xfe000000

Best Regards,

Tim
