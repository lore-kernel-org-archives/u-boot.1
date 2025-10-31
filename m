Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584F2CCF9EE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 06:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E11983642;
	Fri, 31 Oct 2025 07:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aptJaizH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4A6836F0; Fri, 31 Oct 2025 07:43:51 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65EB28331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 07:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-295163ae901so12355805ad.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 23:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1761893028; x=1762497828;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgKCiW9cVv/TNcBobTaRdnRPBbdeBaj1ZU/fet140pE=;
 b=aptJaizH4VrgtpH5UnA6F0d0gxYPpS7fbFVDFr/rlrBg2KcrGfDD1sMMaV6JJ8YxR8
 SpV+HG2bwT3jAsEpZ/5dnaq8zxuBXdPSpbqWkFkyWg0iE44j/5YXZ9eF+CKcikaj8+N2
 pDoxwb6R+FFVseSCA2PgJUvMeyanmnsO9hBXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761893028; x=1762497828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgKCiW9cVv/TNcBobTaRdnRPBbdeBaj1ZU/fet140pE=;
 b=t5+T7qGezUIVNJlB4cxE6YerTIOyTBIPkhGuQU3omCrnliXhjaHu4WBOXDZcmRD353
 k4IjJsMMUbxEJtOPop0o+Fe1euvzhR99nszYnggRiaX+7k+HWcwPl762VJKsSwJJ6fBN
 cLlgZzkNvav7tZPhMt1RoIF6imFIUMPSpjwnA22G3lvS4BGriII8q2I+Xk/ftOz6OGSs
 aMdrklwKHBrkQnZLYNx4nW7UUVKTlPnrreamKYY3HN/SMlWuT0JD4Z8hfY/HJMwy2Hpi
 26KEqdv2rfAFvV5GOR21JsAmxRYdpCAnYNnShUAGfsgxMoTFm6U4FFB3w6YKZpo/1AgH
 Klew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHew/O+NSa9ZZrUIvk0MjnpgYq8y82BtGlaHVHd+n/SZvWLmW1QixaOYeUDJfTVJ3NVrZJwvA=@lists.denx.de
X-Gm-Message-State: AOJu0YyyduvOhUPYpyxWmm9RCdFSQNc9qYfCi/DRTf8+EfbVbhQfAUeW
 r5Cn4dDf1eX5mZ3pC4MI2smuA8JHX6WJpZNBlzyHoTY7yntjzS7Mupgjiznr9xTNCabweiZDY27
 84xiLdP9e9442B4L4K10ma6xGiFOW+sj6bkSqEEVHPA==
X-Gm-Gg: ASbGncteEwXaLBBqS/4f+Gxv+niOUI4nAFd9oYXxa02Cdlf8aUohKbt+qz5MXiigoM2
 DdyU/lHziD2e7n8XEntDudAuDndV+1DEi27tAlhVgEns1UjnD8pvDqicyobH1bw6ixIjQ/775Mt
 ArU0t6mMTVYgGD7mzQ6DClJ0re9FhmFV5b51lJXhgpiqRpODgHDWKhIgLzPEsepsIM9rkM8Yy2n
 ghOwRTi6QQJE+khBwQYYq+9ulkbTikkLMNxf8yNpV/4CE0oL2LXaJQb0nt2YVfYjYCWUCmpseZJ
 UjmoBRKr7ZpT5xhs
X-Google-Smtp-Source: AGHT+IHorx/QEKYFeYu9IPy2VrL+SCXc4tRiedILPHOMIawK10uQyZp9lDJPBsh7BZULiN9+VnRyWru8m4xo8CZyBhY=
X-Received: by 2002:a17:903:228b:b0:27e:e1f3:f853 with SMTP id
 d9443c01a7336-2951a3906b4mr31467735ad.8.1761893027764; Thu, 30 Oct 2025
 23:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
In-Reply-To: <20251028091256.600992-1-richard.genoud@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 31 Oct 2025 07:43:36 +0100
X-Gm-Features: AWmQ_blVS53SCqnxYdG9yX2bhcADUt0hhh6KAgzWberF2I_eAZwgbRBx1qybSjk
Message-ID: <CAOf5uw=gqHtS7BynpaN-FO+gNinBnao+phhMAs-pn5gk9BSP6A@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Introduce Allwinner H6/H616 NAND controller
 support
To: Richard Genoud <richard.genoud@bootlin.com>
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

On Tue, Oct 28, 2025 at 10:13=E2=80=AFAM Richard Genoud
<richard.genoud@bootlin.com> wrote:
>
> Hi everyone,
>
> This patch series introduce H6/H616 NAND controller support (but not yet
> the DMA/MDMA part).
>
> All the work was done on a H616 board with a Kioxia TC58NVG1S3HTA00 NAND
> chip.
> ECC is supported, as well as scrambling.
>
> Support for booting from NAND is not part of this series, but it's almost
> ready. (It needs quite some modifications in sunxi-spl-image-builder.c
> and sunxi_toc0.c)
>
> H6 SoC has not been tested, but it shares all registers with H616, plus
> some registers dedicated to Embedded Crypto Engine that H616 lacks.
>
> This IP has quite some register fields modified from the A10/A23, but in
> the end, it works more or less the same.
> Main differences with A10/A23 are:
> - The need for 2 more clocks (for ECC and MBUS)
> - The use of a new USER_DATA_LEN register
> - More ECC strengths (44, 52, 68, 72, 76 and 80 bits / 1KB)
> - MDMA based on chained buffers
> - some registers layouts have changed (mainly due do the stronger ECC)
>
> Patches 1 and 2 are small fixes
>
> Patches 3-6 harmonize the registers definitions between U-Boot and SPL,
> and ultimately merge those definitions in an include file, without
> functional change, removing the usage of sunxi_ccm_reg on the way.
>
> Patches 7-19 are paving the way to the introduction of H6/H616 NAND
> controller by adding per SoC capabilities for both drivers. They are
> small for an easier review, without functional change.
>
> Patches 20-21 are adding missing NAND related clocks definitions for
> H6/H616
>
> Patch 22 adds the support for H6/H616 NAND controller in U-Boot.
>
> Patch 23 adds the support for H6/H616 NAND controller in SPL.
>
> Patch 24 fixes warnings in sunxi_nand_spl.c
>
> A similar series for this NAND controller support in Linux has been sent
> and being reviewed.
>
> Changes from v1:
> - pick-up reviewed-by
> - use a readl() loop instead of memcpy_fromio() in patch 2 as suggested
>   by Andre
> - remove cosmetic in patches that are beyond cosmetic changes
> - remove usage of struct sunxi_ccm_reg, suggested by Andre
> - indent @caps member description in comment
> - give more informations on PAT_FOUND registers in commit message
> - drop NFC_ECC_BLOCK_SIZE_MSK which was just a 1bit mask for the very
>   same bit NFC_ECC_BLOCK_512
> - add missing MACH_SUN50I_H6 in Kconfig
>
> Richard Genoud (24):
>   mtd: rawnand: sunxi: cosmetic: remove needless comment
>   mtd: rawnand: sunxi_spl: fix pointer from integer without a cast
>   mtd: rawnand: sunxi_spl: harmonize register defines with non spl file
>   mtd: rawnand: sunxi_spl: cosmetic: use definitions from
>     linux/mtd/rawnand.h
>   mtd: rawnand: sunxi: remove usage of struct sunxi_ccm_reg
>   mtd: rawnand: sunxi: merge register definitions for
>     sunxi_nand{,_spl}.c
>   mtd: rawnand: sunxi: add per SoC capabilities
>   mtd: rawnand: sunxi: move ECC_ERR_CNT register offset in SoC caps
>   mtd: rawnand: sunxi: move USER_DATA register offset in SoC caps
>   mtd: rawnand: sunxi: move ECC_PAT_FOUND register in SoC caps
>   mtd: rawnand: sunxi: add has_ecc_block_512 capability
>   mtd: rawnand: sunxi: move NFC_ECC_MODE offset in SoC caps
>   mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
>   mtd: rawnand: sunxi_spl: add per SoC capabilities
>   mtd: rawnand: sunxi: move NFC_RANDOM_EN register offset in SoC caps
>   mtd: rawnand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
>   mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and NFC_ECC_PAT_FOUND
>   mtd: rawnand: sunxi_spl: increase max_oobsize for 2KiB pages
>   mtd: rawnand: sunxi_spl: use NFC_ECC_MODE and NFC_RANDOM_SEED macros
>   sunxi: clock: H6: add NAND controller clock registers
>   clk: sunxi: Add MBUS Master Clock Gating Register
>   mtd: rawnand: sunxi: add support for H6/H616 nand controller
>   mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller
>   mtd: rawnand: sunxi_spl: Fix cast to pointer from integer warnings
>
>  arch/arm/include/asm/arch-sunxi/clock_sun4i.h |   1 +
>  .../include/asm/arch-sunxi/clock_sun50i_h6.h  |  24 ++
>  arch/arm/include/asm/arch-sunxi/clock_sun6i.h |   1 +
>  .../include/asm/arch-sunxi/clock_sun8i_a83t.h |   1 +
>  arch/arm/include/asm/arch-sunxi/clock_sun9i.h |   2 +
>  board/sunxi/board.c                           |  19 +-
>  drivers/clk/sunxi/clk_h6.c                    |   2 +
>  drivers/clk/sunxi/clk_h616.c                  |   2 +
>  drivers/mtd/nand/raw/Kconfig                  |   3 +-
>  drivers/mtd/nand/raw/sunxi_nand.c             | 308 +++++++++--------
>  drivers/mtd/nand/raw/sunxi_nand.h             | 228 +++++++++++++
>  drivers/mtd/nand/raw/sunxi_nand_spl.c         | 322 +++++++++++-------
>  12 files changed, 629 insertions(+), 284 deletions(-)
>  create mode 100644 drivers/mtd/nand/raw/sunxi_nand.h
>

I will pick the series over the weekend, check CI, and check better
all the patches that already
get reviewed anyway

MIchael

>
> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
> --
> 2.47.3
>
