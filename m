Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7015FD2ECF9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 07:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F87E83A2D;
	Tue, 20 Jan 2026 08:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KCmBdYDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E496683A3B; Tue, 20 Jan 2026 08:33:33 +0100 (CET)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9655582A9E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 08:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-2ac3d5ab81bso5317722eec.1
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 23:33:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768894409; cv=none;
 d=google.com; s=arc-20240605;
 b=dDkK8NOac8LtMi3srb1heoStigwHGBX9yPTScnY85abmgLU5nE+soArwmpSuF3s/9k
 bMEMtc5184RbMmIpqkvXAeINg2SNU7BNQ4tUR+Xli7N/1XBaME0VM9ktAxy0Dq+Y/1tv
 SkzbWeV7eZwkETVEbQRxFjjvzF1uW8iY8Z8Ykn0kXJ4sI3R4YgN68I4lulwDwWEvWGH/
 +wanM6dyHvy7LdRZk3aJ8P+4S/GNoMCEK2+IQmJicWi/XXBVoaVzx6ijJBOOmJDOR7M9
 Iy9Dt7dzOpWfiSEEeQHQlxeXLR6NfLwD3XmUjoH0DIV/t9FmQZ9/mvqI5vlDtPidfDob
 OjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a88mYNUCng1SYkuL+xaHhLv9d0keASVYhYTYnuCyt9w=;
 fh=HZe/QuQLf/MSOOizVqb6Tn2p1+bRaclfxbdHzGiOQqE=;
 b=kW8R8xhyqq4J7naBjkiiZwqXR9RIxGNHp70sUS3L504dqJssGbf0ryDlzaugwGCnjF
 x8gHsjD7hKdwzBAJYi+5YYQL782QeI+/MPrBHBICLDg36dkaPcMhhaCsYvpneWdzaNm9
 Ywoynh9vuVN1qQqYYdRWDLqvNyatjQaOL3RUs2eyOg49icfQYYr56MjLF2StGuVGgMY2
 GJEdW0GEYkInaNd0I7LKy8F3FBl4VCxk/R8x/m+iVpGX3a2VPsHEKk+kG+A4Nr1KHRBO
 upGooYxg/5T0WIKGYrCpI0DXW8NZ6UYK4OKvIHhSjyeZIbGzFPa7zd3F8pfgyYG3ec71
 jSZg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768894409; x=1769499209;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a88mYNUCng1SYkuL+xaHhLv9d0keASVYhYTYnuCyt9w=;
 b=KCmBdYDFIZ5Z7vq3QsmvcKldOUfs5u4LCbOUlCgBtP2ok0muUXV2oX8n9OwWQx1b0Q
 2A7Y+ajD/F6lWNgeRPLi5Rq3MuOwyrzSpvqRsWEiuijCiy/PoCNOoqObUByPl44IEuGW
 o6UO9FqzdtY/9pBAgDw6PZKEZ1OMbbxdoKDCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768894409; x=1769499209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a88mYNUCng1SYkuL+xaHhLv9d0keASVYhYTYnuCyt9w=;
 b=nEvaZlPaQFPaSTxAjrOYCS6ysOZb9rB1YLM3FXXFuainYoiGM5hKgUXGWnyB5L4V3F
 44fCMXuoBDK1rOX74BWZJg41JakwqvdwQCg0SgCW0hGzOecNO3I1VQX1DxXR9nrw3vIi
 v9+7ZPVs7tAIHpZdL4/U242ha0mgZXMTckMdFQBoRWQgewkHcutzokvo4/g+4sQMcdMb
 BOfqYsvHnMZzHPKRfM7qFOgfNALGqqU3jE3ft9JJfMqv/42JYV3ZP8fYXNzmltlg2OH3
 aE8UXZG6HMb4HxNVGPvKyQ+XmfAHwMKN63oO0BSkNufwlGe98YJg7VH+p8IsrVnrn/PB
 ne5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8skFr6F7dXTer7lWN5016oDf+5R3hqLNdCBf38xp1I4LoVOaKyDTsm2uV+6BgY3c/NMAJ8sQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwG3kQwYBF83UyH9pxX238xZ4gaeVcqpNGaycCWxcullORGhtNT
 CUFveyVD3bMVMi25NfMSE7JTlG9Aa9zgpkfvs1x5JIIiLD2y8uo2RZj24u2NLxxOv9tDbypxOyl
 mr8UYPS+eMLwfw1fzcxbsNIlmbVSkPNKwSkLc5ud4tw==
X-Gm-Gg: AZuq6aL1YQy+l4m6udGb/8mVaO2lbxeHHzCsHZPsTS5BlQoklM7uhp6aqi4tYsZq5DM
 bi0buqJJYG+LlOTeX7+4Nz8KghCxhnpRdpKE9bxOtddhkz9A6naDoqrS623ma5qy+FCtISCpeIg
 z1EMMFFyuVYIf4kcT7reCWK59Hv7nXwNReAYE00D7mLeOT+m6fVSZTM4syqv8uCzRAj3xoiTu1K
 eH6bbBV+vIFAluh0wZ5liMrYP9n7Mz8XJLiIQaRfrPm4wWblxrPD6s2BpC9F8qRFw2Ae+1N726X
 NO+PDRQ0IY4nWX8hZ+AUdhT5kA==
X-Received: by 2002:a05:7300:8b85:b0:2ab:ca55:89ab with SMTP id
 5a478bee46e88-2b6b4eb4c13mr11126224eec.42.1768894408260; Mon, 19 Jan 2026
 23:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
 <CAOf5uw=gqHtS7BynpaN-FO+gNinBnao+phhMAs-pn5gk9BSP6A@mail.gmail.com>
 <5b7e3e38-325f-424b-ab95-8775924333e4@bootlin.com>
 <CAOf5uwkwDKzZpbj-iXBL2YTu-eH=96f2EzLcn0TFyGcJZHiNWQ@mail.gmail.com>
 <CAOf5uwkhHyXHUHRMLa9OStb+uuWQ6wajWOWncd=HUgzGZSBV=A@mail.gmail.com>
In-Reply-To: <CAOf5uwkhHyXHUHRMLa9OStb+uuWQ6wajWOWncd=HUgzGZSBV=A@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 20 Jan 2026 08:33:16 +0100
X-Gm-Features: AZwV_QhX7dLJUZEI2pjtpWfX9CPpoeffhCwq-xbkk9a3UECURUMdgaJPmUtk_lk
Message-ID: <CAOf5uw=_1O=wYDTXxpXu1UDcUZWUN_9Se1HPbzzMU2Fttqm8Jw@mail.gmail.com>
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

On Mon, Jan 19, 2026 at 10:01=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Richard
>
> I queue them and run the CI, I have it ready, waiting for the denx
> site to be up again
>

At this point I think the best is resend the series including last
patches and the requested changes for two
patches

Michael

> Michael
>
> On Mon, Jan 12, 2026 at 6:30=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi
> >
> > My fault, I was thinking to already have picked them, I will do
> >
> > On Mon, Jan 12, 2026 at 6:09=E2=80=AFPM Richard GENOUD
> > <richard.genoud@bootlin.com> wrote:
> > >
> > > Hi Michael,
> > > Le 31/10/2025 =C3=A0 07:43, Michael Nazzareno Trimarchi a =C3=A9crit =
:
> > > > Hi Richard
> > > >
> > > > On Tue, Oct 28, 2025 at 10:13=E2=80=AFAM Richard Genoud
> > > > <richard.genoud@bootlin.com> wrote:
> > > >>
> > > >> Hi everyone,
> > > >>
> > > >> This patch series introduce H6/H616 NAND controller support (but n=
ot yet
> > > >> the DMA/MDMA part).
> > > >>
> > > >> All the work was done on a H616 board with a Kioxia TC58NVG1S3HTA0=
0 NAND
> > > >> chip.
> > > >> ECC is supported, as well as scrambling.
> > > >>
> > > >> Support for booting from NAND is not part of this series, but it's=
 almost
> > > >> ready. (It needs quite some modifications in sunxi-spl-image-build=
er.c
> > > >> and sunxi_toc0.c)
> > > >>
> > > >> H6 SoC has not been tested, but it shares all registers with H616,=
 plus
> > > >> some registers dedicated to Embedded Crypto Engine that H616 lacks=
.
> > > >>
> > > >> This IP has quite some register fields modified from the A10/A23, =
but in
> > > >> the end, it works more or less the same.
> > > >> Main differences with A10/A23 are:
> > > >> - The need for 2 more clocks (for ECC and MBUS)
> > > >> - The use of a new USER_DATA_LEN register
> > > >> - More ECC strengths (44, 52, 68, 72, 76 and 80 bits / 1KB)
> > > >> - MDMA based on chained buffers
> > > >> - some registers layouts have changed (mainly due do the stronger =
ECC)
> > > >>
> > > >> Patches 1 and 2 are small fixes
> > > >>
> > > >> Patches 3-6 harmonize the registers definitions between U-Boot and=
 SPL,
> > > >> and ultimately merge those definitions in an include file, without
> > > >> functional change, removing the usage of sunxi_ccm_reg on the way.
> > > >>
> > > >> Patches 7-19 are paving the way to the introduction of H6/H616 NAN=
D
> > > >> controller by adding per SoC capabilities for both drivers. They a=
re
> > > >> small for an easier review, without functional change.
> > > >>
> > > >> Patches 20-21 are adding missing NAND related clocks definitions f=
or
> > > >> H6/H616
> > > >>
> > > >> Patch 22 adds the support for H6/H616 NAND controller in U-Boot.
> > > >>
> > > >> Patch 23 adds the support for H6/H616 NAND controller in SPL.
> > > >>
> > > >> Patch 24 fixes warnings in sunxi_nand_spl.c
> > > >>
> > > >> A similar series for this NAND controller support in Linux has bee=
n sent
> > > >> and being reviewed.
> > > >>
> > > >> Changes from v1:
> > > >> - pick-up reviewed-by
> > > >> - use a readl() loop instead of memcpy_fromio() in patch 2 as sugg=
ested
> > > >>    by Andre
> > > >> - remove cosmetic in patches that are beyond cosmetic changes
> > > >> - remove usage of struct sunxi_ccm_reg, suggested by Andre
> > > >> - indent @caps member description in comment
> > > >> - give more informations on PAT_FOUND registers in commit message
> > > >> - drop NFC_ECC_BLOCK_SIZE_MSK which was just a 1bit mask for the v=
ery
> > > >>    same bit NFC_ECC_BLOCK_512
> > > >> - add missing MACH_SUN50I_H6 in Kconfig
> > > >>
> > > >> Richard Genoud (24):
> > > >>    mtd: rawnand: sunxi: cosmetic: remove needless comment
> > > >>    mtd: rawnand: sunxi_spl: fix pointer from integer without a cas=
t
> > > >>    mtd: rawnand: sunxi_spl: harmonize register defines with non sp=
l file
> > > >>    mtd: rawnand: sunxi_spl: cosmetic: use definitions from
> > > >>      linux/mtd/rawnand.h
> > > >>    mtd: rawnand: sunxi: remove usage of struct sunxi_ccm_reg
> > > >>    mtd: rawnand: sunxi: merge register definitions for
> > > >>      sunxi_nand{,_spl}.c
> > > >>    mtd: rawnand: sunxi: add per SoC capabilities
> > > >>    mtd: rawnand: sunxi: move ECC_ERR_CNT register offset in SoC ca=
ps
> > > >>    mtd: rawnand: sunxi: move USER_DATA register offset in SoC caps
> > > >>    mtd: rawnand: sunxi: move ECC_PAT_FOUND register in SoC caps
> > > >>    mtd: rawnand: sunxi: add has_ecc_block_512 capability
> > > >>    mtd: rawnand: sunxi: move NFC_ECC_MODE offset in SoC caps
> > > >>    mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
> > > >>    mtd: rawnand: sunxi_spl: add per SoC capabilities
> > > >>    mtd: rawnand: sunxi: move NFC_RANDOM_EN register offset in SoC =
caps
> > > >>    mtd: rawnand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
> > > >>    mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and NFC_ECC_PAT_FO=
UND
> > > >>    mtd: rawnand: sunxi_spl: increase max_oobsize for 2KiB pages
> > > >>    mtd: rawnand: sunxi_spl: use NFC_ECC_MODE and NFC_RANDOM_SEED m=
acros
> > > >>    sunxi: clock: H6: add NAND controller clock registers
> > > >>    clk: sunxi: Add MBUS Master Clock Gating Register
> > > >>    mtd: rawnand: sunxi: add support for H6/H616 nand controller
> > > >>    mtd: rawnand: sunxi_spl: add support for H6/H616 nand controlle=
r
> > > >>    mtd: rawnand: sunxi_spl: Fix cast to pointer from integer warni=
ngs
> > > >>
> > > >>   arch/arm/include/asm/arch-sunxi/clock_sun4i.h |   1 +
> > > >>   .../include/asm/arch-sunxi/clock_sun50i_h6.h  |  24 ++
> > > >>   arch/arm/include/asm/arch-sunxi/clock_sun6i.h |   1 +
> > > >>   .../include/asm/arch-sunxi/clock_sun8i_a83t.h |   1 +
> > > >>   arch/arm/include/asm/arch-sunxi/clock_sun9i.h |   2 +
> > > >>   board/sunxi/board.c                           |  19 +-
> > > >>   drivers/clk/sunxi/clk_h6.c                    |   2 +
> > > >>   drivers/clk/sunxi/clk_h616.c                  |   2 +
> > > >>   drivers/mtd/nand/raw/Kconfig                  |   3 +-
> > > >>   drivers/mtd/nand/raw/sunxi_nand.c             | 308 +++++++++---=
-----
> > > >>   drivers/mtd/nand/raw/sunxi_nand.h             | 228 ++++++++++++=
+
> > > >>   drivers/mtd/nand/raw/sunxi_nand_spl.c         | 322 +++++++++++-=
------
> > > >>   12 files changed, 629 insertions(+), 284 deletions(-)
> > > >>   create mode 100644 drivers/mtd/nand/raw/sunxi_nand.h
> > > >>
> > > >
> > > > I will pick the series over the weekend, check CI, and check better
> > > > all the patches that already
> > > > get reviewed anyway
> > >
> > > Any news?
> >
> > Sorry, I have picked the patches assigned to me, but now I found out
> > that I miss your series because
> > was not assigned to me. Give me a couple of days
> >
> > Michael
> >
> > >
> > >
> > > Regards,
> > > Richard
> > >
> > >
> > > >
> > > > MIchael
> > > >
> > > >>
> > > >> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
> > > >> --
> > > >> 2.47.3
> > > >>
> > >
> > >
> > > --
> > > Richard Genoud, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com
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
