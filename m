Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AB8E8B36B
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 22:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65F4C83D9C;
	Tue,  3 Feb 2026 23:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="W9WNXaU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6206383DA7; Tue,  3 Feb 2026 23:45:58 +0100 (CET)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32A083D77
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 23:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2b71515d8adso6032602eec.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 14:45:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770158754; cv=none;
 d=google.com; s=arc-20240605;
 b=iAaCc+5OEp6QgbBPRxQQMFY1qX9fnnVf3jykFfM12eZ3dN2LhIq0sNfjipNI5T9xu0
 SRv7pMH2A3oeZB3jrSbptUlTT/iG171BjlF+niWyVFYQeKV8mr3EUA6PMgOG5fMaApCu
 RkSkCqa/QN6p8OzPynphFswk6UHi4BGLWk9s8cVcQ1kunsvD49kB+5bObb9H0wT3HFPA
 vBH2ZM9FXUzyAHbvgEEHxdM1i0WvB9PB6mU3tK9FOmGxb/3k2e1DJ0AduHOKU+NcRrX7
 KLuztzMAN3/3ajs1GRmZovygIoa1vawpXXsHnDsKIed/hD6fs/c5tKrWbQwwrbwzwsNf
 P1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=Msn1W9hSyFIqH9nlYQerNqJwzul6/4NsFDE/ZTGYNZo=;
 fh=a5C6O7gonRlZcZREVMRTGhESbYIotQ5/kIdu6lpeZtg=;
 b=aWYafazN7Gch8SZvvZJwWFeT2x3dmWLBXPZMKed1yN/62J2l3mUgJi6p9/3HMqMAd9
 UAlsfsVLvjQWU6K9Y+iGgZTn0xg1/RUJc2d+ozhIsmNJXuH5Xi/Qysqh/QCd7Iov+tp3
 g/ngGw+ixzxZ7yeLx1rgMh8Ub9pzVaDfHwbBRn97wg5IXWl4LOmbPtiN+7eFCLeukOTx
 PvZ4/MpFhR4pbvA0f1w8pWdxfo0jKAqqgLd4tBazEL/AyIFdMoC05HndOFPracymOULH
 LMLVeALLIvLg1O1P1Php/OO2fT3BDuhtsPCg2MVYhKOc8f1EU9SQS3QcY/vd8YHgQmta
 yc2w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1770158754; x=1770763554;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Msn1W9hSyFIqH9nlYQerNqJwzul6/4NsFDE/ZTGYNZo=;
 b=W9WNXaU0sHoeuohhYD3G7G/jvRWky1fGjTT1Y9/FM4BCXKeUFMzziEfw6w4WA60owv
 bz1Jm1GAFZM7fT2TPAx6sW6qGL0WyXDablcrxN39hPV2jh9DJdt8QkNoPKIinCMEM+Uz
 KSWK4v0m7x8ZEbyeguib1qKxNFp/0WIsrgnzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770158754; x=1770763554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Msn1W9hSyFIqH9nlYQerNqJwzul6/4NsFDE/ZTGYNZo=;
 b=Ph1vsHsYeAhJfEWYlwqAYZmJVF6KP+LkGSlO/3lrNfBNDgnfLieAioq8s/2FXz+Yeg
 CmvwfH7JXMDfimi1p8kQJlZtsvhnGedp4WVXolTB3rkCd5GvIL7x81b9T/C/laWgt9KN
 Ac943HjQS1tQunUGq9WxlbthQ/Lg0U134NQrTH9xZjls06svhEW1ot+w/MNSOl8L82oJ
 eJtHPPf0eq8N187ZvipiE8r73i5d4afRxwq56KXPcFC4Zfn7IXWLjjgk0bMw2+WLAciO
 GKSkQyHWh9+c4F/ygqBgA+H1jx87rtSkCegweRqBGnZJ1EXQgoShsJd5sI+w5WcP0y77
 VvOw==
X-Gm-Message-State: AOJu0YzNCjvExhEmb+zZD1k4w/GBFQLHH5r9+tUMvu3pPM5kx5Q8q1hh
 ocrxzjFhQafK/h/Hi/wgF+/KqzDAtvvjwmdkLtgWtuoCDtVDIxg5dLqyTyDOgQWEP0j3I6r2NW2
 GgJ+kSE8oxQq6A5jTAFhGq3E6XnCyopa+DA8pWH0fHSFQbnyF06AlmaLpHg==
X-Gm-Gg: AZuq6aJFSSIUiPUzXt76juoY7R2YbAc78ie7kWUD61s5RQH7IH80lgpS0XTL+Nr216X
 15dHSVMMKL4Cci5R1kTSb0Jn9iYSjlwr9ghZ67gzCmRCfgdYEqwXNA5P7xvIyiBk/nOmAoN10cL
 g1fGOgWo4Gw+8xuCa1v4Tgln2MOW/SOFHnvIhHutj6ft9m1+J+7W/abWnkS+Ph5VgOVJSwdlPXJ
 Oep0JFIyz0Whe7E+QXQVWHQIB0wBSylFmRvkpb9c0Isg9UNvfChYCz3LLPE0agZAgCRMSKMv0Tc
 VyEYK/AC3k5bgROeN4XK3BQ9YEQ=
X-Received: by 2002:a05:7301:678c:b0:2ae:614a:330e with SMTP id
 5a478bee46e88-2b832a45b93mr482513eec.41.1770158753540; Tue, 03 Feb 2026
 14:45:53 -0800 (PST)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 3 Feb 2026 23:45:42 +0100
X-Gm-Features: AZwV_QjHQSq0U33c9Empw-vwXZXic72lFjqObxYW8FjsIK8_EG3DVzWG2pEvFJ4
Message-ID: <CAOf5uwnzPQsvaJoQo1F+aAWP7MHbrPfsxiAbesCTfQzmH9oUWA@mail.gmail.com>
Subject: Pull request for u-boot-nand-03022026 (Take 2)
To: U-Boot-Denx <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>
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

The following changes since commit 71f2564b178f3986dc89cdaa4558f0caa74fd88c=
:

  Merge tag 'mmc-for-2026.04-rc2' of
https://source.denx.de/u-boot/custodians/u-boot-mmc (2026-02-03
12:46:30 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
u-boot-nand-03022026

for you to fetch changes up to 800ebf7e94e3a7e375cf915ae21e14514fd81450:

  tools: sunxi-spl-image-builder: support H6/H616 NAND boot
(2026-02-03 21:45:27 +0100)

This series provides a comprehensive cleanup of the Allwinner (sunxi)
NAND controller drivers and
introduces full support for the H6 and H616 SoCs in both the main
U-Boot driver and the SPL.

The series successfully deduplicates register maps between
sunxi_nand.c and sunxi_nand_spl.c
while migrating to a capability-based architecture. This approach
allows the driver to handle
the H616's specific requirements=E2=80=94such as shifted register offsets f=
or
ECC/OOB, the removal of
512B ECC block support, and mandatory MBUS clock gating=E2=80=94without
breaking compatibility
for legacy A10/A23 devices.

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/2918=
3

----------------------------------------------------------------
Richard Genoud (26):
      mtd: rawnand: sunxi: cosmetic: remove needless comment
      mtd: rawnand: sunxi_spl: fix pointer from integer without a cast
      mtd: rawnand: sunxi_spl: harmonize register defines with non spl file
      mtd: rawnand: sunxi_spl: cosmetic: use definitions from
linux/mtd/rawnand.h
      mtd: rawnand: sunxi: remove usage of struct sunxi_ccm_reg
      mtd: rawnand: sunxi: merge register definitions for sunxi_nand{, _spl=
}.c
      mtd: rawnand: sunxi: add per SoC capabilities
      mtd: rawnand: sunxi: move ECC_ERR_CNT register offset in SoC caps
      mtd: rawnand: sunxi: move USER_DATA register offset in SoC caps
      mtd: rawnand: sunxi: move ECC_PAT_FOUND register in SoC caps
      mtd: rawnand: sunxi: add has_ecc_block_512 capability
      mtd: rawnand: sunxi: move NFC_ECC_MODE offset in SoC caps
      mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
      mtd: rawnand: sunxi_spl: add per SoC capabilities
      mtd: rawnand: sunxi: move NFC_RANDOM_EN register offset in SoC caps
      mtd: rawnand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
      mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and NFC_ECC_PAT_FOUND
      mtd: rawnand: sunxi_spl: increase max_oobsize for 2KiB pages
      mtd: rawnand: sunxi_spl: use NFC_ECC_MODE and NFC_RANDOM_SEED macros
      sunxi: clock: H6: add NAND controller clock registers
      clk: sunxi: Add MBUS Master Clock Gating Register
      mtd: rawnand: sunxi: add support for H6/H616 nand controller
      mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller
      mtd: rawnand: sunxi_spl: Fix cast to pointer from integer warnings
      mtd: rawnand: sunxi: fix page size in control register
      tools: sunxi-spl-image-builder: support H6/H616 NAND boot

 arch/arm/include/asm/arch-sunxi/clock_sun4i.h      |   1 +
 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h  |  24 ++
 arch/arm/include/asm/arch-sunxi/clock_sun6i.h      |   1 +
 arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h |   1 +
 arch/arm/include/asm/arch-sunxi/clock_sun9i.h      |   2 +
 board/sunxi/board.c                                |  21 +-
 drivers/clk/sunxi/clk_h6.c                         |   2 +
 drivers/clk/sunxi/clk_h616.c                       |   2 +
 drivers/mtd/nand/raw/Kconfig                       |   4 +-
 drivers/mtd/nand/raw/sunxi_nand.c                  | 306 ++++++++++-------=
---
 drivers/mtd/nand/raw/sunxi_nand.h                  | 228 +++++++++++++++
 drivers/mtd/nand/raw/sunxi_nand_spl.c              | 317 +++++++++++++----=
----
 scripts/Makefile.xpl                               |   1 +
 tools/sunxi-spl-image-builder.c                    |  92 ++++--
 14 files changed, 700 insertions(+), 302 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/sunxi_nand.h
