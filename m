Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2BED2E9D5
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 10:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1F0989377;
	Mon, 11 Nov 2024 11:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h3kpCLmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B21158937A; Mon, 11 Nov 2024 11:49:34 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6367889365
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 11:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so3851801a12.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 02:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731322171; x=1731926971; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQvPsG2h1C/HpBizzlxDFFEyWDKEf3/xecPlWyUcV48=;
 b=h3kpCLmKMED2F+wtPZb7vjKSaP4uqFeht5k/kE4/UMz4k17bY9AKfhqvdyHXF4j/1j
 s4C67UE4Hwc9yGT3bfttHNU73+YJuKeVIRN39s1mItEnyQeHbK5qULPAAQPRQyhs0iSm
 uHQc1R/HiaKdl3TJO/9Kbz9GQZidq1ZPkN/73XCnTTZBHYxX1SCvRNbJ2iAhe9hWvyHq
 gejjpos4SrPTnlE6KvgRdtqwG0M2VcKKOYbYaoqLMMUb9LuO0EReNBxNA0VCWhE68N7O
 g7+IQPwAIREaHJ6P4QyhYqYSP6PXl/GMxDx9qEDOvnGnoGcurYZzCndZ5EkHULtR2GFF
 3Nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731322171; x=1731926971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQvPsG2h1C/HpBizzlxDFFEyWDKEf3/xecPlWyUcV48=;
 b=kjuh4xtAU2rPP91Sicc/k31UpjVKuYxTllb7HLn6MXv7+ZS7EeWc4A0Y60VJ1e8wAD
 0tiGF23/985nudxk9LZ78ZCh7pGXylFAe//zfwz5zFN7zqZy0jf9K7H1NDPDH3YJCPBU
 C+M0QC8bcf5q6tfBnOKPo0vYD5UbTEJkystqROGMHIjaraOcByfNE/kunYHtFN+5thoX
 e39oahDp5//QjUZkejMxfbJCbybUzpRg4+i59QIpYGjNHmJrKG1wujR9p/djHvw5L51+
 se/CWa4IWdSmJ+e4rA9+H+ILdCUQK9o4g3nwLZOyMAFDmdsuwnvLqa1tFjtmN+MQ6hRz
 3nXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0krpnpneqeKOFtbdxowTE8apG3o2mYeT+kdIFvHfw2uRnG0C1GCmfpEWZaWXlc5kJvA82ZQM=@lists.denx.de
X-Gm-Message-State: AOJu0YzCFd71W6Cyie6rGgaJcdjt4am3sWX31tA2Xr4J5zPgUY8ijg3f
 IzwyKmXIuxu2FNCb2qOuTkg971S48w4oeUFrTOg3UVlubichTUwWNnHxDppt/1aVpODXwUHhFIg
 msJIpR82wS5EKYGumvbJ0pMRN64g=
X-Google-Smtp-Source: AGHT+IGFjLJzeCRBGndfdLzoO5cCVemOMiJ0C7uXJ7fymLws8yHs+VHLZH5yNyVZbauYFKD+QXKSmbkiKrAN7ltNM5Q=
X-Received: by 2002:a05:6a20:7492:b0:1d9:a62a:b8d4 with SMTP id
 adf61e73a8af0-1dc22a60b8amr19532185637.27.1731322170624; Mon, 11 Nov 2024
 02:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
 <20241107-phytec_imx8m_optee-v2-1-bbc3747a60e8@phytec.de>
 <CAHCN7x+2XzhyERLmAaO-PVwkT6K_rcQgG-+xgTX8HaqstdZyOQ@mail.gmail.com>
 <CAJ+vNU3hpUwBdgCWGAWjpbc8o0wUwjRRQNdFNhJ-c9QHuKcPgw@mail.gmail.com>
 <79a2c61150260a98aaaa1baf583615a677ae75f1.camel@phytec.de>
In-Reply-To: <79a2c61150260a98aaaa1baf583615a677ae75f1.camel@phytec.de>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 11 Nov 2024 04:49:19 -0600
Message-ID: <CAHCN7xJOsasYAaE+h0+CpqE=GLU4sR6Y_ekFEX6AaYKzO52OYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm: imx8m: add OP-TEE node
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "manut@mecka.net" <manut@mecka.net>, 
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "festevam@gmail.com" <festevam@gmail.com>,
 Yashwanth Varakala <Y.Varakala@phytec.de>, 
 "sbabic@denx.de" <sbabic@denx.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 PHYTEC Upstream <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Teresa Remmet <T.Remmet@phytec.de>
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

On Mon, Nov 11, 2024 at 1:48=E2=80=AFAM Yannic Moog <Y.Moog@phytec.de> wrot=
e:
>
> Hi,
>
> On Fri, 2024-11-08 at 10:05 -0800, Tim Harvey wrote:
> > On Fri, Nov 8, 2024 at 5:49=E2=80=AFAM Adam Ford <aford173@gmail.com> w=
rote:
> > >
> > > On Thu, Nov 7, 2024 at 2:42=E2=80=AFAM Yannic Moog <y.moog@phytec.de>=
 wrote:
> > > >
> > > > Add tee node in SoC u-boot device trees. Use a kconfig entry to spe=
cify
> > > > load and entry addresses for the op-tee image in the respective
> > > > defconfig.
> > > >
> > > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > > ---
> > > >  arch/arm/dts/imx8mm-u-boot.dtsi | 17 ++++++++++++++++-
> > > >  arch/arm/dts/imx8mn-u-boot.dtsi | 17 ++++++++++++++++-
> > > >  arch/arm/dts/imx8mp-u-boot.dtsi | 17 ++++++++++++++++-
> > > >  arch/arm/mach-imx/imx8m/Kconfig |  8 ++++++++
> > > >  4 files changed, 56 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-=
u-boot.dtsi
> > > > index d31bc822532..ecc2319279e 100644
> > > > --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> > > > +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> > > > @@ -164,6 +164,21 @@
> > > >                                         };
> > > >  #endif
> > > >
> > > > +                                       tee: tee {
> > > > +                                               description =3D "OP=
-TEE";
> > > > +                                               type =3D "tee";
> > > > +                                               arch =3D "arm64";
> > > > +                                               compression =3D "no=
ne";
> > > > +                                               os =3D "tee";
> > > > +                                               load =3D <CONFIG_IM=
X8M_OPTEE_LOAD_ADDR>;
> > > > +                                               entry =3D <CONFIG_I=
MX8M_OPTEE_LOAD_ADDR>;
> > > > +
> > > > +                                               tee-os {
> > > > +                                                       filename =
=3D "tee.bin";
> > > > +                                                       optional;
> > > > +                                               };
> > > > +                                       };
> > > > +
> > > >                                         binman_fip: fip {
> > > >                                                 arch =3D "arm64";
> > > >                                                 compression =3D "no=
ne";
> > > > @@ -192,7 +207,7 @@
> > > >                                                 fdt =3D "fdt-SEQ";
> > > >                                                 firmware =3D "uboot=
";
> > > >  #ifndef CONFIG_ARMV8_PSCI
> > > > -                                               loadables =3D "atf"=
;
> > > > +                                               loadables =3D "atf"=
, "tee";
> > > >  #endif
> > > >                                         };
> > > >                                 };
> > > > diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-=
u-boot.dtsi
> > > > index 6875c6d44ff..f9108cb75c7 100644
> > > > --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> > > > +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> > > > @@ -235,6 +235,21 @@
> > > >                                         };
> > > >  #endif
> > > >
> > > > +                                       tee: tee {
> > > > +                                               description =3D "OP=
-TEE";
> > > > +                                               type =3D "tee";
> > > > +                                               arch =3D "arm64";
> > > > +                                               compression =3D "no=
ne";
> > > > +                                               os =3D "tee";
> > > > +                                               load =3D <CONFIG_IM=
X8M_OPTEE_LOAD_ADDR>;
> > > > +                                               entry =3D <CONFIG_I=
MX8M_OPTEE_LOAD_ADDR>;
> > > > +
> > > > +                                               tee-os {
> > > > +                                                       filename =
=3D "tee.bin";
> > > > +                                                       optional;
> > > > +                                               };
> > > > +                                       };
> > > > +
> > > >                                         binman_fip: fip {
> > > >                                                 arch =3D "arm64";
> > > >                                                 compression =3D "no=
ne";
> > > > @@ -263,7 +278,7 @@
> > > >                                                 fdt =3D "fdt-SEQ";
> > > >                                                 firmware =3D "uboot=
";
> > > >  #ifndef CONFIG_ARMV8_PSCI
> > > > -                                               loadables =3D "atf"=
;
> > > > +                                               loadables =3D "atf"=
, "tee";
> > > >  #endif
> > > >                                         };
> > > >                                 };
> > > > diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-=
u-boot.dtsi
> > > > index 56749ccacd2..9ede98a11e4 100644
> > > > --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> > > > +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> > > > @@ -185,6 +185,21 @@
> > > >                                         };
> > > >  #endif
> > > >
> > > > +                                       tee: tee {
> > > > +                                               description =3D "OP=
-TEE";
> > > > +                                               type =3D "tee";
> > > > +                                               arch =3D "arm64";
> > > > +                                               compression =3D "no=
ne";
> > > > +                                               os =3D "tee";
> > > > +                                               load =3D <CONFIG_IM=
X8M_OPTEE_LOAD_ADDR>;
> > > > +                                               entry =3D <CONFIG_I=
MX8M_OPTEE_LOAD_ADDR>;
> > > > +
> > > > +                                               tee-os {
> > > > +                                                       filename =
=3D "tee.bin";
> > > > +                                                       optional;
> > > > +                                               };
> > > > +                                       };
> > > > +
> > > >                                         @fdt-SEQ {
> > > >                                                 description =3D "NA=
ME";
> > > >                                                 type =3D "flat_dt";
> > > > @@ -204,7 +219,7 @@
> > > >                                                 fdt =3D "fdt-SEQ";
> > > >                                                 firmware =3D "uboot=
";
> > > >  #ifndef CONFIG_ARMV8_PSCI
> > > > -                                               loadables =3D "atf"=
;
> > > > +                                               loadables =3D "atf"=
, "tee";
> > > >  #endif
> > > >                                         };
> > > >                                 };
> > > > diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/im=
x8m/Kconfig
> > > > index b254a50b091..14f14db6a35 100644
> > > > --- a/arch/arm/mach-imx/imx8m/Kconfig
> > > > +++ b/arch/arm/mach-imx/imx8m/Kconfig
> > > > @@ -37,6 +37,14 @@ config SYS_HAS_ARMV8_SECURE_BASE
> > > >           If enabled, please also define the value for ARMV8_SECURE=
_BASE,
> > > >           for i.MX8M, it could be some address in OCRAM.
> > > >
> > > > +config IMX8M_OPTEE_LOAD_ADDR
> > > > +       hex "Load address of OPTEE image"
> > > > +       default 0x56000000
> > > > +       help
> > > > +         The load and entry address for the OPTEE image. This valu=
e defaults to
> > > > +         0x56000000 if not provided in the board defconfig file.
> > >
> > > I think this would need to vary based on the platform.  I think the
> > > addresses may be different depending on Mini, Nano and Plus and also
> > > dependent on the available SDRAM.
> >
> > Indeed the address differs for platform (as the DRAM base address
> > does) and is also based on the DRAM size of the board. Here are my
> > notes for IMX8M:
> >
> > The address is the link/load address for TEE that should match
> > BL32_BASE for the ATF (for imx8m) and CFG_TZDRAM_START for OPTEE. The
> > BL32_BASE is the same for imx8mm/n/p but it does depend on the size of
> > DRAM. The address should be the top 32MiB of DRAM but because U-Boot
> > is loading tee.bin from a FIT image into DRAM it needs to be a 32bit
> > address and thus needs to be adjusted down if you are on a board with
> > 4GiB:
> > 1GiB DRAM use 0x7e000000
> > 2GiB DRAM use 0xbe000000
> > 3GiB or larger use 0xfe000000
>
> I agree the addresses may be different. To my knowledge you can take what=
ever (32bit) address you
> want within addressable RAM as load address. I assume you are looking for=
 sensible defaults here.
> It appears to me the challenge is agreeing on a sensible value.
> Do you have any suggestions?

On my Mini with 2GB of RAM, there are several definitions:
 PHYS_SDRAM                      0x40000000
PHYS_SDRAM_SIZE         0x80000000 /* 2GB DDR */

What we if did a calculation like:
PHYS_SDRAM + MIN(PHYS_SDRAM_SIZE, 0xc0000000) - 0x2000000

With 2 GB of RAM, it would be 0xbe000000

My Nano Board has the following:

PHYS_SDRAM                      0x40000000
PHYS_SDRAM_SIZE         0x40000000

That calculation should return 7E000000.

I am not sure if we can do MIN and MAX functions in the precompiler,
but it would then cap the value to 0xfe000000

adam

>
> Yannic
>
> >
> > Best Regards,
> >
> > Tim
>
