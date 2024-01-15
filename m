Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE471C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 10:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4698186314;
	Mon, 15 Jan 2024 11:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PFpblLa4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8416871CC; Mon, 15 Jan 2024 11:48:27 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D966786308
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 11:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbdb124491cso6587996276.1
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 02:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705315703; x=1705920503;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CSmkq40sBVUI84nypYwy0As8tAB0TTK3WJp/z1hjwTQ=;
 b=PFpblLa4J2sR1OLLD2U+4EYE5FlETzRfqjK+PDpT3+LYZq1eUkiYCaNg9Z8PgkuCx2
 mOLmphdWkBmusTJVkcl1d2hdFF8VrmnkqDglwGSsz8/8p2CZFv3P93FrpPT2CFWfcNEq
 XqGRRbzxAMraSZMS2amxAUAc7IwPEsBUlXgc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705315703; x=1705920503;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CSmkq40sBVUI84nypYwy0As8tAB0TTK3WJp/z1hjwTQ=;
 b=wIRT3a050vUCuU5qK6Xk1fuu+djeOu29gqVdYrdf78Fd58Jx4REWsYceXqt6FEfktS
 EBtEeStLHuuJbEXlOWn5bphXnVjnI0lLUcu0YbYMXQQffsK8ouHDM1SSzAf9xX+Ztdeu
 6+3xIyZxafKI+ov60XLF7mOqRRtBmzKa7PuzDKHFJE6vA2CtcHDzgsJmCXCCx00HDc1K
 epd/iWEb2Rzlym4tUcCQOee4hw5EFFWEydjH5WU/1tStQTvhrCpO3Vo1zK52N+TUU/aL
 UGMzlCauFctmwY59X185GtxOkQJQhyw+wIFzTGm42NdJ+Qj0GQkpsgFZn7m89SrFifVC
 rszQ==
X-Gm-Message-State: AOJu0YzAcgS4pZFY9ZK2+0WVxWtLgayI5ofAjFchAUhBJQMdD8HxUVQw
 A9RvGQEnePvGDwzavd3JuhgvLBTubEwkkc+RessOuDH7NbS+Dw==
X-Google-Smtp-Source: AGHT+IGybVxRUYMnftT1f08mw9Z7ogpyGrNCOJIt8HhvRzEGmPNIIixjQmYQfSjPL1xaKKcdg3QFn9c4dKWx/0wAkAY=
X-Received: by 2002:a25:db88:0:b0:dbd:998:5fbd with SMTP id
 g130-20020a25db88000000b00dbd09985fbdmr2689691ybf.32.1705315703606; Mon, 15
 Jan 2024 02:48:23 -0800 (PST)
MIME-Version: 1.0
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 15 Jan 2024 11:48:12 +0100
Message-ID: <CABGWkvo7ERgbNViKy=mYAyiHkemULT-8qXWQr3yprzQnL7cDYg@mail.gmail.com>
Subject: [PULL] Pull request for u-boot-nand-20240115
To: Tom Rini <trini@konsulko.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Roger Quadros <rogerq@kernel.org>, U-Boot-Denx <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hello Tom,

The following changes since commit 697758e7c81131da6db0e3b10515019fe3aca8c9:

  Merge branch 'master-sync-dts-663' of
https://source.denx.de/u-boot/custodians/u-boot-sh (2024-01-14
18:07:49 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/u-boot.git u-boot-nand-20240115

for you to fetch changes up to 4dfa08af79097d068d6657a4c77e7d474733b796:

  arm: mach-k3: am642: Define NAND boot device (2024-01-15 08:58:24 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/19322

----------------------------------------------------------------
Pull request for u-boot-nand-20240115

The first patch is by Heinrich Schuchardt and fixes an integer overflow

The following two patches are by Dario Binacchi and add arguments check
to the nand_mtd_to_devnum() and nand_register() functions.

The remaining patches are by Roger Quadros and include various fixes for
the OMAP platform.

----------------------------------------------------------------
Dario Binacchi (2):
      mtd: nand: complete nand_register() arguments check
      mtd: nand: check nand_mtd_to_devnum() argument

Heinrich Schuchardt (1):
      cmd: mtd: avoid unintentional integer overflow

Roger Quadros (6):
      mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
      mtd: rawnand: omap_elm: Fix elm_init definition
      memory: ti-gpmc: Fix build
      mtd: rawnand: omap_gpmc: Use DT provided IO address
      mtd: rawnand: omap_gpmc: fix OF based partition parsing for NAND
      arm: mach-k3: am642: Define NAND boot device

 arch/arm/mach-k3/am642_init.c            |   3 +++
 arch/arm/mach-k3/include/mach/am64_spl.h |   1 +
 cmd/mtd.c                                |   4 ++--
 drivers/memory/ti-gpmc.c                 |   2 +-
 drivers/mtd/nand/raw/nand.c              |   7 ++++--
 drivers/mtd/nand/raw/omap_elm.c          |   4 ++--
 drivers/mtd/nand/raw/omap_elm.h          |   6 ------
 drivers/mtd/nand/raw/omap_gpmc.c         | 116
+++++++++++++++++++++++++++++++++++++++------------------------------------------------------------
 8 files changed, 59 insertions(+), 84 deletions(-)


-- 
Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
