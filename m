Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323C8CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 12:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D22986D6E;
	Fri, 13 Oct 2023 14:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OEqaYHg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBBF586E77; Fri, 13 Oct 2023 14:40:49 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D736C86D62
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 14:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7a7e9357eso24693807b3.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 05:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1697200843; x=1697805643;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KdqauqrjRaYcw4sDqNufQoRCVvaZlAlAXM23VktMpwY=;
 b=OEqaYHg/BuhWdbddVQZMaSogP5SIQSNEWiDDxxjpNH1PWLFBX+otQj5J70obwtZQfV
 xqrqSAW2TVvHNLdwfKwwukPvpfXuXOzjWHnSJQSBQueLxl9xl+VeHVY/+G8RPI9nVfyk
 TW5Y5jMU2codl44HRQ4n3WeyJ5n+eMYiu45MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697200843; x=1697805643;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KdqauqrjRaYcw4sDqNufQoRCVvaZlAlAXM23VktMpwY=;
 b=CrfYxxiNv7gdUni2XyNyVnwOt0EikOJsO5RFgP8Kc+ybB0lA2DuUECLTZGyyExT1hc
 ihy9OnyBTea4FG/W35sNRjXZJx+wV74Zqo7G57xf0oCpw3isx6BCJ7t47qoLoaJCguyo
 pI0ZuGklBCLHXl9i3rRezou3jYdXg+J9uluSEQHPZwss+3KuTv5p0XxbrEFOHKOo61H2
 T3Egp64RxHX9g/V/kThzPqH8QfV0AtuT35NN+B9GaMYrgKvf3SxyqGHX/YI2vQKhFIMJ
 qPgRk/JF9+GLe5ypq+DBbTY2imlrgLI/FcBxp9ZgmR7HYzDuKSe0Hx4iSSJrclrxuAzQ
 GZaw==
X-Gm-Message-State: AOJu0Ywnt0w1zyaGitdtk7bGgF3XN6hfNTG4zPLSdEaJY2lZPOIx5AJH
 ICUGRq9DOhiwXZl6eVEK9wgq5QWr7kM826QUyrcG+Q==
X-Google-Smtp-Source: AGHT+IHxnr7mL5A9CuWu4lLgPEz+xPiI0f2A3VGp/qOY/qlfZ4oAPC3iFyzURJYaOawc/lmB/A0MBMXH0s4DUo/fVrw=
X-Received: by 2002:a5b:f08:0:b0:d81:51ca:ff47 with SMTP id
 x8-20020a5b0f08000000b00d8151caff47mr23107895ybr.10.1697200843467; Fri, 13
 Oct 2023 05:40:43 -0700 (PDT)
MIME-Version: 1.0
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Fri, 13 Oct 2023 14:40:32 +0200
Message-ID: <CABGWkvqnzkji8pTJ9upj0YY7rtYtwmt0CouCQk26eC2UWLDB9g@mail.gmail.com>
Subject: Pull request for u-boot-nand-20230417
To: Tom Rini <trini@konsulko.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
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

The following changes since commit 86700279645921fb2c28c41711deb7d7ed75bc29:

  Merge branch '2023-10-12-assorted-TI-platform-updates' (2023-10-12
17:02:51 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
tags/u-boot-nand-20231013

for you to fetch changes up to be0da1257f189c09604b01bc04a7e8411bf18e5c:

  dfu: mtd: mark bad the MTD block on erase error (2023-10-13 10:49:07 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/18106

----------------------------------------------------------------
Pull request for u-boot-nand-20231013

The first 5 patches are from Mikhail Kshevetskiy, aligning the mtd spinand
core with kernel version 5.15.43, fixing a bug on Winbond, and adding
support for Winbond W25NO2KV.

The other 2 patches are from Patrick Delaunay and they fix a bug and mark
bad the MTD block on erase error.

----------------------------------------------------------------
Mikhail Kshevetskiy (5):
      mtd/spinand: rework detect procedure for different READ_ID operation
      mtd/spinand: sync core spinand code with linux-5.10.118
      mtd/spinand: sync supported devices with linux-5.15.43
      mtd: spinand: winbond: fix flash identification
      mtd: spinand: winbond: add Winbond W25N02KV flash support

Patrick Delaunay (2):
      dfu: mtd: fix the trace when limit is reached
      dfu: mtd: mark bad the MTD block on erase error

 drivers/dfu/dfu_mtd.c             |  34 ++++++++++++------
 drivers/mtd/nand/spi/Makefile     |   2 +-
 drivers/mtd/nand/spi/core.c       | 129
+++++++++++++++++++++++++++++++++++++++++-------------------------
 drivers/mtd/nand/spi/gigadevice.c | 253
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 drivers/mtd/nand/spi/macronix.c   | 190
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 drivers/mtd/nand/spi/micron.c     | 194
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 drivers/mtd/nand/spi/paragon.c    | 133
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/spi/toshiba.c    | 104
+++++++++++++++++++++++++-----------------------------
 drivers/mtd/nand/spi/winbond.c    | 116
+++++++++++++++++++++++++++++++++++++++++++-----------------
 include/linux/mtd/nand.h          |   5 ++-
 include/linux/mtd/spinand.h       |  97
++++++++++++++++++++++++++++++++++++++------------
 11 files changed, 927 insertions(+), 330 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/paragon.c


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
