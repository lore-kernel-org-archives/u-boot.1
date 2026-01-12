Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2DDCF45B0
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 17:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF94083759;
	Mon, 12 Jan 2026 18:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RtFTvG8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B715683885; Mon, 12 Jan 2026 18:30:30 +0100 (CET)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9B883700
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 18:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-2b1981ca515so3417239eec.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768239026; x=1768843826;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pOywEplEj/hdTMvfPjbywhx4x8arjVbJdYKtAmbSdw=;
 b=RtFTvG8biCI6QY3JSvNC+OP1/JtfejWJaH+ufm2M4cjR9YIGVF8X4Ullq9Sj+B0eVK
 6vHDYl3xJI8P/hguZBpPWFMoOxExSdqIaLJ2I9uoC0kLyk/8lyJen41wTgxtTCgfi1uR
 MjeVh6LKzc8mcWBjZ2Sz+T9Fxvj3RexQg2cYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768239026; x=1768843826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0pOywEplEj/hdTMvfPjbywhx4x8arjVbJdYKtAmbSdw=;
 b=KCTglls6NER5drJqE/Fa08sE1+qWUYpUJs5j2Wp/1l6mGpQNd0PX1C17ILYI/KkPFn
 i/RssnIBKCUyulVdFwWhOhfb8Z82k1CvZYo729zF/TFAcM1JzJisTiQoPosQKgk545cp
 7VI+uFpbcIsglHqGujk02oUZNjFsu7OARLC61GAWmEZLR/8LVOJh2CjDJp65vUFhVP3f
 RzQp5h8yQnLc40XU2jdGnjpwFzaCSfWVt+A8EJD/AFllYqqU+K3mJGLXtdmGyWs+sfL6
 KmealtFmTU02o6OCl6Ut/3FoD7jhTgZ5mM5QkZlBOUiwCfGBkxkavaj0qdvKyAOhRERN
 XX1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyWkziKCPAhrZe8qfLjtWke0OrAbRcDUzQK/cGtaQAvWKruOApIZDqVGR4PxS5AxcDT8CUGKI=@lists.denx.de
X-Gm-Message-State: AOJu0YwLA+88BdYIR4qM1MThJUjQzv8xPxFtZUElPnpJdu4IUp7aSLnj
 0TjrNqhCBHuxZYxDGQyEThkNXQddG2BNGPKxrS800ViiTSWxL8vGz4RExWsN8oCc3LOEjDqFCTs
 wyisLVGBX0/KbF097b6feOQ0d56CfU1q0Fe5xtBcXJQ==
X-Gm-Gg: AY/fxX4Su68W+wNgNe9nUV/YEaHPOXgkiuzP0mv4V2AdiJkIOB3IuheQ+WkkHrntiAP
 PKl0Qm2bRa2ZhAzdLwovsY7QhUHno/fiX1t9GTmAPIbrDsMSvtnnYbX7J1qtYXYl7IcPgRuCpaA
 NH3QY4tMrFoBYjgXH0Q4KGwwAOekL1ln3w7qdqJNafHsIapp3ZBty9sNA6odEbbYWNhWcoIeLZh
 HgVh2B72+AL94EPdk3zPTOawrxglppkOuJ6OY8bgZTKoTYvC8PXE+j0A0AdeJq1Mpk9TCfNaOlc
 n+9BtbtWJlctKutSVyEietFbgg==
X-Google-Smtp-Source: AGHT+IFIZvzADu5Gdmv9xhh/3qu3rpKK6o0FpjS0oUegb9Vqdz/YclE+FlNQBrWXhtfU+WBAh3TLvj74AhVncIbmui0=
X-Received: by 2002:a05:7301:fa03:b0:2ae:579d:2038 with SMTP id
 5a478bee46e88-2b17d1fb992mr17531754eec.4.1768239026105; Mon, 12 Jan 2026
 09:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
 <CAOf5uw=gqHtS7BynpaN-FO+gNinBnao+phhMAs-pn5gk9BSP6A@mail.gmail.com>
 <5b7e3e38-325f-424b-ab95-8775924333e4@bootlin.com>
In-Reply-To: <5b7e3e38-325f-424b-ab95-8775924333e4@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 12 Jan 2026 18:30:15 +0100
X-Gm-Features: AZwV_QiFzoWLKdB3Sb8RVNlYbnx_G5aDHh0D9BhYbjKyi-DEs1Jb4BdBtM3a7xw
Message-ID: <CAOf5uwkwDKzZpbj-iXBL2YTu-eH=96f2EzLcn0TFyGcJZHiNWQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Introduce Allwinner H6/H616 NAND controller
 support
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Tom Rini <trini@konsulko.com>, Hans de Goede <hdegoede@redhat.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@intel.com>, Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi

My fault, I was thinking to already have picked them, I will do

On Mon, Jan 12, 2026 at 6:09=E2=80=AFPM Richard GENOUD
<richard.genoud@bootlin.com> wrote:
>
> Hi Michael,
> Le 31/10/2025 =C3=A0 07:43, Michael Nazzareno Trimarchi a =C3=A9crit :
> > Hi Richard
> >
> > On Tue, Oct 28, 2025 at 10:13=E2=80=AFAM Richard Genoud
> > <richard.genoud@bootlin.com> wrote:
> >>
> >> Hi everyone,
> >>
> >> This patch series introduce H6/H616 NAND controller support (but not y=
et
> >> the DMA/MDMA part).
> >>
> >> All the work was done on a H616 board with a Kioxia TC58NVG1S3HTA00 NA=
ND
> >> chip.
> >> ECC is supported, as well as scrambling.
> >>
> >> Support for booting from NAND is not part of this series, but it's alm=
ost
> >> ready. (It needs quite some modifications in sunxi-spl-image-builder.c
> >> and sunxi_toc0.c)
> >>
> >> H6 SoC has not been tested, but it shares all registers with H616, plu=
s
> >> some registers dedicated to Embedded Crypto Engine that H616 lacks.
> >>
> >> This IP has quite some register fields modified from the A10/A23, but =
in
> >> the end, it works more or less the same.
> >> Main differences with A10/A23 are:
> >> - The need for 2 more clocks (for ECC and MBUS)
> >> - The use of a new USER_DATA_LEN register
> >> - More ECC strengths (44, 52, 68, 72, 76 and 80 bits / 1KB)
> >> - MDMA based on chained buffers
> >> - some registers layouts have changed (mainly due do the stronger ECC)
> >>
> >> Patches 1 and 2 are small fixes
> >>
> >> Patches 3-6 harmonize the registers definitions between U-Boot and SPL=
,
> >> and ultimately merge those definitions in an include file, without
> >> functional change, removing the usage of sunxi_ccm_reg on the way.
> >>
> >> Patches 7-19 are paving the way to the introduction of H6/H616 NAND
> >> controller by adding per SoC capabilities for both drivers. They are
> >> small for an easier review, without functional change.
> >>
> >> Patches 20-21 are adding missing NAND related clocks definitions for
> >> H6/H616
> >>
> >> Patch 22 adds the support for H6/H616 NAND controller in U-Boot.
> >>
> >> Patch 23 adds the support for H6/H616 NAND controller in SPL.
> >>
> >> Patch 24 fixes warnings in sunxi_nand_spl.c
> >>
> >> A similar series for this NAND controller support in Linux has been se=
nt
> >> and being reviewed.
> >>
> >> Changes from v1:
> >> - pick-up reviewed-by
> >> - use a readl() loop instead of memcpy_fromio() in patch 2 as suggeste=
d
> >>    by Andre
> >> - remove cosmetic in patches that are beyond cosmetic changes
> >> - remove usage of struct sunxi_ccm_reg, suggested by Andre
> >> - indent @caps member description in comment
> >> - give more informations on PAT_FOUND registers in commit message
> >> - drop NFC_ECC_BLOCK_SIZE_MSK which was just a 1bit mask for the very
> >>    same bit NFC_ECC_BLOCK_512
> >> - add missing MACH_SUN50I_H6 in Kconfig
> >>
> >> Richard Genoud (24):
> >>    mtd: rawnand: sunxi: cosmetic: remove needless comment
> >>    mtd: rawnand: sunxi_spl: fix pointer from integer without a cast
> >>    mtd: rawnand: sunxi_spl: harmonize register defines with non spl fi=
le
> >>    mtd: rawnand: sunxi_spl: cosmetic: use definitions from
> >>      linux/mtd/rawnand.h
> >>    mtd: rawnand: sunxi: remove usage of struct sunxi_ccm_reg
> >>    mtd: rawnand: sunxi: merge register definitions for
> >>      sunxi_nand{,_spl}.c
> >>    mtd: rawnand: sunxi: add per SoC capabilities
> >>    mtd: rawnand: sunxi: move ECC_ERR_CNT register offset in SoC caps
> >>    mtd: rawnand: sunxi: move USER_DATA register offset in SoC caps
> >>    mtd: rawnand: sunxi: move ECC_PAT_FOUND register in SoC caps
> >>    mtd: rawnand: sunxi: add has_ecc_block_512 capability
> >>    mtd: rawnand: sunxi: move NFC_ECC_MODE offset in SoC caps
> >>    mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
> >>    mtd: rawnand: sunxi_spl: add per SoC capabilities
> >>    mtd: rawnand: sunxi: move NFC_RANDOM_EN register offset in SoC caps
> >>    mtd: rawnand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
> >>    mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and NFC_ECC_PAT_FOUND
> >>    mtd: rawnand: sunxi_spl: increase max_oobsize for 2KiB pages
> >>    mtd: rawnand: sunxi_spl: use NFC_ECC_MODE and NFC_RANDOM_SEED macro=
s
> >>    sunxi: clock: H6: add NAND controller clock registers
> >>    clk: sunxi: Add MBUS Master Clock Gating Register
> >>    mtd: rawnand: sunxi: add support for H6/H616 nand controller
> >>    mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller
> >>    mtd: rawnand: sunxi_spl: Fix cast to pointer from integer warnings
> >>
> >>   arch/arm/include/asm/arch-sunxi/clock_sun4i.h |   1 +
> >>   .../include/asm/arch-sunxi/clock_sun50i_h6.h  |  24 ++
> >>   arch/arm/include/asm/arch-sunxi/clock_sun6i.h |   1 +
> >>   .../include/asm/arch-sunxi/clock_sun8i_a83t.h |   1 +
> >>   arch/arm/include/asm/arch-sunxi/clock_sun9i.h |   2 +
> >>   board/sunxi/board.c                           |  19 +-
> >>   drivers/clk/sunxi/clk_h6.c                    |   2 +
> >>   drivers/clk/sunxi/clk_h616.c                  |   2 +
> >>   drivers/mtd/nand/raw/Kconfig                  |   3 +-
> >>   drivers/mtd/nand/raw/sunxi_nand.c             | 308 +++++++++-------=
-
> >>   drivers/mtd/nand/raw/sunxi_nand.h             | 228 +++++++++++++
> >>   drivers/mtd/nand/raw/sunxi_nand_spl.c         | 322 +++++++++++-----=
--
> >>   12 files changed, 629 insertions(+), 284 deletions(-)
> >>   create mode 100644 drivers/mtd/nand/raw/sunxi_nand.h
> >>
> >
> > I will pick the series over the weekend, check CI, and check better
> > all the patches that already
> > get reviewed anyway
>
> Any news?

Sorry, I have picked the patches assigned to me, but now I found out
that I miss your series because
was not assigned to me. Give me a couple of days

Michael

>
>
> Regards,
> Richard
>
>
> >
> > MIchael
> >
> >>
> >> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
> >> --
> >> 2.47.3
> >>
>
>
> --
> Richard Genoud, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
