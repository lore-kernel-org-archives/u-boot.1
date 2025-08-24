Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1ACCA0EFC
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 10:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A99828A2;
	Sun, 24 Aug 2025 12:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZrNBG1K4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3DE82AE1; Sun, 24 Aug 2025 12:36:43 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DECE800C1
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 12:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b49d98691faso317500a12.1
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1756031799; x=1756636599;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y3PAHPPAfQLkr2Ie1Ls4hNGAkXOANN645aNQ692QiV4=;
 b=ZrNBG1K4ISfZ70YO/gWFHowWu5jdVMIYi57nHGeMii6Jpzfrr693YHWPkRUCmGvVAN
 qmqT0pVTJbKKXCX9GNZbuQyflBVt3MiznlW71mT/oHNsMiWyXBd6ixhl4gjQ0VRH3BX4
 8AyG/GzzADuiUmU5mh0XydGZsF+TOkeUobavc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756031799; x=1756636599;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y3PAHPPAfQLkr2Ie1Ls4hNGAkXOANN645aNQ692QiV4=;
 b=cCKF7wjr6z116G8+czL2pZn+7x6DxaHdGA05/AwCJBAE7yldms45x5LKLbBkiUomjM
 EPpfNvxIL/QPkN3RmK9xoIUOHmNX1j3BcI6YIZY5Ll8LnO73s8DJTjn3EAdIVr7gyV2I
 6EklriDdTPz/ewLNfLxQA/+fCs4fupi6XrDXhyZ1B0RXqedMdXdvGuRjgw5CCqDXgF7z
 O8RkiZnRKJRiHkam0u/osHQneZECnpOHhlW+asK1RevaDnCxBVgjyqwyg+vJnc8W5+Hl
 TnwJb5Nd8xa+1ohNk8HWOfg7hktClYOBTMnC1u9eug/G1IXoi3HYzuUrLktt5TFb+EQh
 nrZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhc6pVMg9akldedD5yNgdTBTDfw2MESB/dDu4R2TVnskmhUXEmOappQUbiDuVM9wHIc5ocAoY=@lists.denx.de
X-Gm-Message-State: AOJu0YydYkjES7j41U9eCANJR2GwQiopPyQ4VEmVuVVo+BVzlx9/Cq9v
 WGmrm9IXadv9rZpm89e8Z4q44ZbiO6LaD8/Dy8P7OTYIcZL6DcarhR135+GVOggekeOor7TwBzi
 QQikclZnoSlAZfNzCzzMrW/ycr4uYaVrt66ogn5kcsQ==
X-Gm-Gg: ASbGncuQeCek7g345iv+MxEazL1OA7UD/SeGZlozMRcjgM/Kf4c2CTymfMQTU+wPkQU
 0Y5c2XK7dQcUI/RgFKS37NQZdjKOWLtyh03fnFKpaJuiz+44EcqrDqsP9VhKmHt2nxERArjJV2M
 MuKXleBQlw6bw9WluB7ijm5AcH4yEMmW7bwS1euEIrzl3eQoq5IyXwAzLFkPmF1l1yfBXxW3PI1
 LewOOo=
X-Google-Smtp-Source: AGHT+IFwkgdIlJ+dFy5TuRMKeV0Y57dym1vtA9vqMtKCxE8noPhdNFQlx2gVhCbg4GHTDQyZ3KENPBsKoNExLlLEB88=
X-Received: by 2002:a17:903:b4f:b0:246:ae6e:e5e4 with SMTP id
 d9443c01a7336-246ae6ee8abmr23964195ad.6.1756031798823; Sun, 24 Aug 2025
 03:36:38 -0700 (PDT)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 24 Aug 2025 12:36:27 +0200
X-Gm-Features: Ac12FXyGVXFZ4KBCYtXx9jOds4m2jJm13Y2dhgBy5OdoogNFY2bLsZAO6OQj_jc
Message-ID: <CAOf5uwn3zo=yXVc=04Y2hcFZaEv2UTkPUN4SpPx9LeJ8DTx_Vw@mail.gmail.com>
Subject: Pull request for u-boot-nand-23082025
To: Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

The following changes since commit 94e690c44a03959c39f0f5a44a9b89c851af3b60:

  Merge patch series "bootstd: rauc: Fix segfault when scanning device with
unsupported layout" (2025-08-21 15:05:15 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
u-boot-nand-23082025

for you to fetch changes up to 6b156c62ced25d3f8aed64c81e471353b56d0f2c:

  mtd: nand: Do not dereference before NULL check (2025-08-23 16:37:26
+0200)

This series address issues found by Andrew Goodbody and David Regan. Add a
new
benchmark tool from Miguel and small feature

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/27449

----------------------------------------------------------------
Andrew Goodbody (1):
      mtd: nand: Do not dereference before NULL check

Dinesh Maniyam (1):
      mtd: nand: cadence: Fix device assignment to avoid warm reset issue

Miquel Raynal (1):
      cmd: mtd: Enable speed benchmarking

david regan (4):
      cmd: nand: bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB
      cmd: nand: more descriptive help info
      cmd: nand: nand dump display update
      cmd: nand: nand dump with ecc option

 cmd/mtd.c                           | 15 +++++++++-
 cmd/nand.c                          | 56
++++++++++++++++++-------------------
 drivers/mtd/nand/core.c             |  7 +++--
 drivers/mtd/nand/raw/cadence_nand.c |  2 +-
 env/nand.c                          |  2 +-
 5 files changed, 49 insertions(+), 33 deletions(-)
