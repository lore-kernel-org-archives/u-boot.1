Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2327CCF2C5
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 257D180B98;
	Mon, 19 Jan 2026 10:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n3orRgQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0227483015; Mon, 19 Jan 2026 10:02:17 +0100 (CET)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA1D800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2ad70765db9so4131391eec.1
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 01:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768813325; x=1769418125;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFFzDllupjUTgJobLZVdnOiypBD5HElp7fvwXdeeLVc=;
 b=n3orRgQ/jKwzQFnshj6MEp38qaOlJU17O2KeOyylPCAOO2rShwZZ8VPAN47XJ/5fr0
 r92tYl5nB9ohy8IBms/CCFSQ5cwE8u6Z8TmU264dovlllBgsDwR2ha9Uw3TsbBCZ7BxY
 fXZbOYs0KruHolE0iBSr5s/q7vKurpm2G6Yd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768813325; x=1769418125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KFFzDllupjUTgJobLZVdnOiypBD5HElp7fvwXdeeLVc=;
 b=OkerJjzREJlutjWQjveIjSHttzUKHlxbJMRvF2BnEGxTUSxhv5YW9wkyD9v2Q1LRcY
 9LBd6PcfNNVvX+bC5V7LCy3nU8Q+5Hn2zh1nKRjrmk/VLE+YVxFFTPwLjVq+zS5uOlBI
 RCI/EJ/eFSgMmIZFquPVLXmXy2ZNJIqIVHR7ObL3n2//GOzPitmC+LT7a9fydq+a09N3
 4dscqQbIaSQu9UA+kG9kuFslAtKN1EFsCOOkJDBQK5vToLiKxdQISq2RdTuKxrF3jJ4p
 F5jCxVTIf12Fu87w4mafESq+VfRdwXuqEaY4nxXD/Qfd8lJtym3EOuBbQD3BkbFnMSF8
 a4dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2t/IWp5rPx2Re+HbV4e3tzoCoe7t4d0YKsnGNrjqu3cjIcUenB1fu9S/wFVvNdc3nlUB+0qM=@lists.denx.de
X-Gm-Message-State: AOJu0YzBL3xCt2StFf9Txf17gjggvrn94pIHF7SC2nqjdjY4dHhd3MVL
 Fw+VD6IW2EXleYmEMCIifSptRl/QicdmL1EvYlDUX5Eva1Utsz5hOeyjox1RpF+DkqyPtqDKMHA
 OZTFmTdMP8PyCj8AjLhjphK9uQJaK9XYr6qqhyJ0tHw==
X-Gm-Gg: AY/fxX66Zv6eluVJSc4bMSoEfuj2RZmgZXiSLdk7u1NOeNYeKAKduWIx1ZIvgw9YRav
 BPLK90Pu9RRZJwQfgjgsGMKTmoQ+4j3mI6r2QOryrYuEJyENHSM6D44hqAWSx408h3GuiYs5nPB
 htG6v5Gsp4L6hFM3WKj5hPbX9hNeWBU0d2tECVJEIc4jFG69AeNFMuk9lb2touVzHFi7QJHko4d
 VRkWIQAAzY2ettO+8mIdED1MYecoCsd9hZVpdnPWJUPsR4/CDe+Ck0GYxJkMxvLWcQ0wOjPa5cV
 g46eGnwtzKlYBPjkIxVL7P0kdYE=
X-Received: by 2002:a05:7300:8bac:b0:2ae:55ac:3ff6 with SMTP id
 5a478bee46e88-2b6b4e28374mr6989559eec.1.1768813322971; Mon, 19 Jan 2026
 01:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
 <CAOf5uw=gqHtS7BynpaN-FO+gNinBnao+phhMAs-pn5gk9BSP6A@mail.gmail.com>
 <5b7e3e38-325f-424b-ab95-8775924333e4@bootlin.com>
 <CAOf5uwkwDKzZpbj-iXBL2YTu-eH=96f2EzLcn0TFyGcJZHiNWQ@mail.gmail.com>
In-Reply-To: <CAOf5uwkwDKzZpbj-iXBL2YTu-eH=96f2EzLcn0TFyGcJZHiNWQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 19 Jan 2026 10:01:51 +0100
X-Gm-Features: AZwV_QhA0GGDls6xjmbrfDDmip7PNiFxc66WvoAeT_3AITw60W0gAu_hakTGfQU
Message-ID: <CAOf5uwkhHyXHUHRMLa9OStb+uuWQ6wajWOWncd=HUgzGZSBV=A@mail.gmail.com>
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

Hi Richard

I queue them and run the CI, I have it ready, waiting for the denx
site to be up again

Michael

On Mon, Jan 12, 2026 at 6:30=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> My fault, I was thinking to already have picked them, I will do
>
> On Mon, Jan 12, 2026 at 6:09=E2=80=AFPM Richard GENOUD
> <richard.genoud@bootlin.com> wrote:
> >
> > Hi Michael,
> > Le 31/10/2025 =C3=A0 07:43, Michael Nazzareno Trimarchi a =C3=A9crit :
> > > Hi Richard
> > >
> > > On Tue, Oct 28, 2025 at 10:13=E2=80=AFAM Richard Genoud
> > > <richard.genoud@bootlin.com> wrote:
> > >>
> > >> Hi everyone,
> > >>
> > >> This patch series introduce H6/H616 NAND controller support (but not=
 yet
> > >> the DMA/MDMA part).
> > >>
> > >> All the work was done on a H616 board with a Kioxia TC58NVG1S3HTA00 =
NAND
> > >> chip.
> > >> ECC is supported, as well as scrambling.
> > >>
> > >> Support for booting from NAND is not part of this series, but it's a=
lmost
> > >> ready. (It needs quite some modifications in sunxi-spl-image-builder=
.c
> > >> and sunxi_toc0.c)
> > >>
> > >> H6 SoC has not been tested, but it shares all registers with H616, p=
lus
> > >> some registers dedicated to Embedded Crypto Engine that H616 lacks.
> > >>
> > >> This IP has quite some register fields modified from the A10/A23, bu=
t in
> > >> the end, it works more or less the same.
> > >> Main differences with A10/A23 are:
> > >> - The need for 2 more clocks (for ECC and MBUS)
> > >> - The use of a new USER_DATA_LEN register
> > >> - More ECC strengths (44, 52, 68, 72, 76 and 80 bits / 1KB)
> > >> - MDMA based on chained buffers
> > >> - some registers layouts have changed (mainly due do the stronger EC=
C)
> > >>
> > >> Patches 1 and 2 are small fixes
> > >>
> > >> Patches 3-6 harmonize the registers definitions between U-Boot and S=
PL,
> > >> and ultimately merge those definitions in an include file, without
> > >> functional change, removing the usage of sunxi_ccm_reg on the way.
> > >>
> > >> Patches 7-19 are paving the way to the introduction of H6/H616 NAND
> > >> controller by adding per SoC capabilities for both drivers. They are
> > >> small for an easier review, without functional change.
> > >>
> > >> Patches 20-21 are adding missing NAND related clocks definitions for
> > >> H6/H616
> > >>
> > >> Patch 22 adds the support for H6/H616 NAND controller in U-Boot.
> > >>
> > >> Patch 23 adds the support for H6/H616 NAND controller in SPL.
> > >>
> > >> Patch 24 fixes warnings in sunxi_nand_spl.c
> > >>
> > >> A similar series for this NAND controller support in Linux has been =
sent
> > >> and being reviewed.
> > >>
> > >> Changes from v1:
> > >> - pick-up reviewed-by
> > >> - use a readl() loop instead of memcpy_fromio() in patch 2 as sugges=
ted
> > >>    by Andre
> > >> - remove cosmetic in patches that are beyond cosmetic changes
> > >> - remove usage of struct sunxi_ccm_reg, suggested by Andre
> > >> - indent @caps member description in comment
> > >> - give more informations on PAT_FOUND registers in commit message
> > >> - drop NFC_ECC_BLOCK_SIZE_MSK which was just a 1bit mask for the ver=
y
> > >>    same bit NFC_ECC_BLOCK_512
> > >> - add missing MACH_SUN50I_H6 in Kconfig
> > >>
> > >> Richard Genoud (24):
> > >>    mtd: rawnand: sunxi: cosmetic: remove needless comment
> > >>    mtd: rawnand: sunxi_spl: fix pointer from integer without a cast
> > >>    mtd: rawnand: sunxi_spl: harmonize register defines with non spl =
file
> > >>    mtd: rawnand: sunxi_spl: cosmetic: use definitions from
> > >>      linux/mtd/rawnand.h
> > >>    mtd: rawnand: sunxi: remove usage of struct sunxi_ccm_reg
> > >>    mtd: rawnand: sunxi: merge register definitions for
> > >>      sunxi_nand{,_spl}.c
> > >>    mtd: rawnand: sunxi: add per SoC capabilities
> > >>    mtd: rawnand: sunxi: move ECC_ERR_CNT register offset in SoC caps
> > >>    mtd: rawnand: sunxi: move USER_DATA register offset in SoC caps
> > >>    mtd: rawnand: sunxi: move ECC_PAT_FOUND register in SoC caps
> > >>    mtd: rawnand: sunxi: add has_ecc_block_512 capability
> > >>    mtd: rawnand: sunxi: move NFC_ECC_MODE offset in SoC caps
> > >>    mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
> > >>    mtd: rawnand: sunxi_spl: add per SoC capabilities
> > >>    mtd: rawnand: sunxi: move NFC_RANDOM_EN register offset in SoC ca=
ps
> > >>    mtd: rawnand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
> > >>    mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and NFC_ECC_PAT_FOUN=
D
> > >>    mtd: rawnand: sunxi_spl: increase max_oobsize for 2KiB pages
> > >>    mtd: rawnand: sunxi_spl: use NFC_ECC_MODE and NFC_RANDOM_SEED mac=
ros
> > >>    sunxi: clock: H6: add NAND controller clock registers
> > >>    clk: sunxi: Add MBUS Master Clock Gating Register
> > >>    mtd: rawnand: sunxi: add support for H6/H616 nand controller
> > >>    mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller
> > >>    mtd: rawnand: sunxi_spl: Fix cast to pointer from integer warning=
s
> > >>
> > >>   arch/arm/include/asm/arch-sunxi/clock_sun4i.h |   1 +
> > >>   .../include/asm/arch-sunxi/clock_sun50i_h6.h  |  24 ++
> > >>   arch/arm/include/asm/arch-sunxi/clock_sun6i.h |   1 +
> > >>   .../include/asm/arch-sunxi/clock_sun8i_a83t.h |   1 +
> > >>   arch/arm/include/asm/arch-sunxi/clock_sun9i.h |   2 +
> > >>   board/sunxi/board.c                           |  19 +-
> > >>   drivers/clk/sunxi/clk_h6.c                    |   2 +
> > >>   drivers/clk/sunxi/clk_h616.c                  |   2 +
> > >>   drivers/mtd/nand/raw/Kconfig                  |   3 +-
> > >>   drivers/mtd/nand/raw/sunxi_nand.c             | 308 +++++++++-----=
---
> > >>   drivers/mtd/nand/raw/sunxi_nand.h             | 228 +++++++++++++
> > >>   drivers/mtd/nand/raw/sunxi_nand_spl.c         | 322 +++++++++++---=
----
> > >>   12 files changed, 629 insertions(+), 284 deletions(-)
> > >>   create mode 100644 drivers/mtd/nand/raw/sunxi_nand.h
> > >>
> > >
> > > I will pick the series over the weekend, check CI, and check better
> > > all the patches that already
> > > get reviewed anyway
> >
> > Any news?
>
> Sorry, I have picked the patches assigned to me, but now I found out
> that I miss your series because
> was not assigned to me. Give me a couple of days
>
> Michael
>
> >
> >
> > Regards,
> > Richard
> >
> >
> > >
> > > MIchael
> > >
> > >>
> > >> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
> > >> --
> > >> 2.47.3
> > >>
> >
> >
> > --
> > Richard Genoud, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--
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
