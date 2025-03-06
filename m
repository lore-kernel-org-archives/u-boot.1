Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C31C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7DC80E94;
	Thu,  6 Mar 2025 01:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d2L2KtoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2A2D811C1; Thu,  6 Mar 2025 01:26:27 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6202808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-852050432a8so3449539f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220782; x=1741825582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WXc2hFRxZBUzuf7VR/uYPyw/nQjv1GO7ZXVi1+4IcwE=;
 b=d2L2KtoMoifYuv9u9A+9KzvukxsaubeR1LJHDJKwaXg1YH0WTyRocE/rWf5rlLFhD7
 1xT7h2hSDb95VnfGiPAjG+F4x/XoGQw+BwrJns2J25A+FvlxZDc5F7cCtpwFeTOwsEL3
 kg6ZSIi7irWdMvrKEFwboMZyUlk2zelSOptXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220782; x=1741825582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WXc2hFRxZBUzuf7VR/uYPyw/nQjv1GO7ZXVi1+4IcwE=;
 b=mpPauqtkb2INjh3bUgKINtsETXUgmlGlUbNCEopCDzzlv4oRPWya64KASJpCpIkeHW
 eRWLSSiaj10A/kftCdxxpHVZBF1jfBvzFdID3P5x7NrL3C06j3gI8gS0ilG46UJtoj9l
 7fQjHbpD/Ydx2XAJZ3m7YXDMd3oYwOaHyHhPI8cJs7OsYbdyV/ADW/hrlNkZheXxn7Z8
 5j5I6v5EapIPP8t3iPbJN+w+/L9fU9C6MFGnDCRWCHBRTvFzshnOiHdJy8OpKmXJPNzi
 KPhUzkIJzJ2hGXh+o9fTwd8fO9CdzWFwqp9+UwTjpfvulbZvmolAC7257HnCqG5oJYsk
 aaLQ==
X-Gm-Message-State: AOJu0Yy9NrbPa+yUBIag/xqOBOJq9fZSoZabi34wA3CyIi20mrVesK5g
 5/qSs/OAnF3s1Fz2vkEUex1pabuPH9aW37IyJ5O+Xyo8dt9iJxgEe0CDq6xgeQe3bC578kXuyNQ
 =
X-Gm-Gg: ASbGncupB1LXEJYpFWrhHvdTg2g6KiCgd/8NQqJtPO8coKHesXGZ7ErpOBpyl/LWaPJ
 ruKBZ/JOWHHpTaEgUpzTf9t5lMj4su/ErVfw2+Oxqoj820gnBSOr4qcA/TIjF/7AnSNr4XuXrFG
 t2x8KrAovqo8EcUVSo8nrscjSN/kknQ5cN1teNdJG/sGLBbBdCWAfUOqvbYNO9+C0c8uigy3mqJ
 YdsCNyzeL27bEAB2Q8p+0ndGHKlSgHtBXCxf5pfdg+4Pg3xJdgz5D9HTSrPLv87BPtUoUp3vJND
 p/BmkeyodQsdS/Z2Wi9nnVfkxMlpA1549fvlZfauu5VqzuQfhw1dQeIfbNWM7DMXSHbingwdVeQ
 cpRU2PA==
X-Google-Smtp-Source: AGHT+IGd7CbGP6kJuo50IPOgmd3TqU7mcPA4R35glOLT8LCdutDxzMweBfvWRXqpVBIs3/zFBTLsMQ==
X-Received: by 2002:a05:6602:340e:b0:855:9621:d08c with SMTP id
 ca18e2360f4ac-85b0eaef341mr158461639f.4.1741220782365; 
 Wed, 05 Mar 2025 16:26:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 00/29] pxe: Precursor series for supporting read_all() in
 extlinux / PXE
Date: Wed,  5 Mar 2025 17:24:54 -0700
Message-ID: <20250306002533.2380866-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series includes some patches related to allowing read_all() to be
used with the extlinux / PXE bootmeths.

These patches were split out from the stb4 series, since it will need to
have additional patches for LWIP, to avoid breaking PXE booting when
LWIP is used.

Changes in v5:
- Use ramdisk address for the initrd_addr field, not kernel address
- Split off the first part into a separate series

Changes in v4:
- Correct for updated lmb_reserve() call

Changes in v3:
- Add new patch to convert IMAGE_FORMAT into an enum
- Add new patch to add a format for the booti file
- Add new patch to support booti format in bootm
- Add new patch to support compressed booti images in bootm

Changes in v2:
- Split out strlcpy() change into new patch
- Move strlcpy() change into an earlier patch
- Fix 'initaddr' typo'
- Rebase on earlier change
- Add new patch to simplify the code reading fdtcontroladdr and fdt_addr

Simon Glass (29):
  x86: Make do_zboot_states() static
  x86: Rename zboot_run() to zboot_run_args()
  x86: Drop duplicate definition of zimage_dump()
  x86: Move x86 zboot state into struct bootm_info
  x86: Rename state to bmi
  x86: Move the bootm state for zimage into cmd/
  bootstd: Correct display of kernel version
  x86: Drop the unnecessary base_ptr argument to zboot_dump()
  boot: Use strlcpy() in label_boot()
  boot: Split pxe label_boot() into two parts
  boot: Split pxe label_run_boot() into two parts
  boot: Pass just the FDT argument to label_process_fdt()
  bootm: Allow building bootm.c without CONFIG_SYS_BOOTM_LEN
  boot: Convert IMAGE_FORMAT into an enum
  boot: arm: riscv: sandbox: Add a format for the booti file
  boot: Support booti format in bootm
  boot: Support compressed booti images in bootm
  boot: pxe: Use bootm_...() functions where possible
  pxe_utils: Simplify default fdt in label_run_boot()
  boot: pxe: Refactor label_run_boot() to avoid cmdline
  net: Keep the bootstage functions together
  net: Tidy up the comments to parse_args()
  net: Simplify parse_args()
  net: Return the load address from parse_args()
  net: Return the address and size from parse_addr_size()
  net: Return the size from parse_args()
  net: Refactor part of netboot_common() into a function
  net: Drop #ifdef in parse_args()
  net: Provide a function to run network operations

 arch/arm/lib/image.c          |   9 +-
 arch/riscv/lib/image.c        |   9 +-
 arch/sandbox/lib/bootm.c      |   5 +
 arch/x86/include/asm/zimage.h |  57 ++---
 arch/x86/lib/zimage.c         | 102 +++++----
 boot/Makefile                 |   2 +-
 boot/bootm.c                  |  77 ++++++-
 boot/bootmeth_cros.c          |   6 +-
 boot/image-board.c            |  36 +--
 boot/pxe_utils.c              | 417 ++++++++++++++++++----------------
 cmd/bootflow.c                |   8 +-
 cmd/net.c                     |  92 ++++----
 cmd/x86/zboot.c               |  33 +--
 include/bootm.h               |  63 ++++-
 include/image.h               |  48 +++-
 include/net-common.h          |  30 +++
 net/net.c                     |  44 ++++
 17 files changed, 661 insertions(+), 377 deletions(-)

-- 
2.43.0

