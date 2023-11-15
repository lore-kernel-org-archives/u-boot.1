Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBF6C4332F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10564871F0;
	Wed, 15 Nov 2023 14:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I5x+bGyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D658721C; Wed, 15 Nov 2023 14:19:42 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0AE386366
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9c603e235d1so1001612966b.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054378; x=1700659178; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=L9MW6AcSpjg+QEj7eXD476aNqEAdwEj0xnxIaVFVN7k=;
 b=I5x+bGyE9Ww/F7ZMa6vfR2WzTEFV/e/dGZKv61HrjURQW+qWY57wsrRKcpUDDOv3t+
 TAA69LGpzBsPS9uC1MJeEGzseHd8+IrS27A90jTYjF8n9mdqgsPMXcyupdEueolSStVG
 TvbNCAcOyhTqUZZleXd7c5LkuwWTZ9WPx+Drw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054378; x=1700659178;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L9MW6AcSpjg+QEj7eXD476aNqEAdwEj0xnxIaVFVN7k=;
 b=R6SlQjC/qMVJlfcWfyH/C9QWLUqtaRFetHOseOIlglHv/p/bMbB/EAhJrWohVHkJ0f
 eSzB3sClzawagTKcDCTvq2BY4DjmakQlAat9AQVdd0dskU+c1PYmdd5JPQewJxFaFm1F
 SbYkjfDV5p15nOFbf9rfEQGcYRDW4SShcwDUXyWMz0plLfboaxJYq/Z93vvhEYSvY8Ul
 HKs9udMKXnsVZAMMrZOSVyv0WOOm/jAqTNuY5emcHOgcJ72/si4QmJ+kcQkLtBIoYizB
 Kej/oprS0PrlT8hyGx4FVoHsq7LiL9doZ1z/Ogg+VMxNCOajGF3AthTxAC6t3kN6IihD
 O0Gw==
X-Gm-Message-State: AOJu0YwYGxXo9cFkmb1jhOjFP3MiDwUDgBKDPh+D+nhqYroGnj/W21iP
 VjvbBslAAfGO8Dd/dhL+WXnv2j+YqnkwbewxfJUVpCN0A9oQokc4PRACwQ==
X-Google-Smtp-Source: AGHT+IFVgCr2I0OdrR2ENouBzFMobLQS/9RDX/Lnmkjpeu7G2t29yrYCEoih68qV6x4nLXqXzQucneYioY0txdMCVO0=
X-Received: by 2002:a17:906:370f:b0:9e5:d313:fee7 with SMTP id
 d15-20020a170906370f00b009e5d313fee7mr9083970ejc.50.1700054377919; Wed, 15
 Nov 2023 05:19:37 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 06:19:26 -0700
Message-ID: <CAPnjgZ3V6qnjrKS+XL95LS-iLJv2VU3g5Us=DHJmpHT7xRC+cA@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

Hi Tom,

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/18586

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=55&view=results


The following changes since commit 92b27528d777ce85362af45e7d2974a6c856219b:

  Merge branch 'master' of
https://source.denx.de/u-boot/custodians/u-boot-sunxi (2023-11-12
16:36:52 -0500)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-15nov23

for you to fetch changes up to 0d4d9f94c555577f78cddc372c307465fc92413e:

  bootstage: Correct exhasuted typo (2023-11-14 20:04:01 -0700)

----------------------------------------------------------------
patman correct import of u_boot_pylib
correct long-standing EFI framebuffer bug
minor test refactor

----------------------------------------------------------------
Heinrich Schuchardt (1):
      dm: Do not enable debug messages by default

Sean Anderson (1):
      sandbox: Close file after mmaping it

Simon Glass (10):
      efi: Correct handling of frame buffer
      bootstd: Refactor mmc prep to allow a different scan
      bootstd: Add a return code to bootflow menu
      expo: Correct background colour
      patman: Split out arg parsing into its own file
      patman: Move the main program into a function
      patman: Correct easy pylint warnings in __main__
      patman: Avoid using func_test at top level
      patman: Correct Python 3.6 behaviour
      bootstage: Correct exhasuted typo

 arch/sandbox/cpu/os.c      |  15 ++--
 boot/expo.c                |   4 +-
 cmd/bootflow.c             |  53 ++++++++---
 common/bootstage.c         |   2 +-
 doc/usage/cmd/bootflow.rst |  67 ++++++++++++++
 drivers/core/Kconfig       |   1 -
 include/dm/util.h          |   4 +-
 include/video.h            |   9 +-
 lib/efi_loader/efi_gop.c   |  12 +--
 test/boot/bootflow.c       |  64 +++++++++++--
 tools/patman/__main__.py   | 254
++++++++++++++++------------------------------------
 tools/patman/cmdline.py    | 147 ++++++++++++++++++++++++++++++
 12 files changed, 413 insertions(+), 219 deletions(-)
 create mode 100644 tools/patman/cmdline.py

Regards,
Simon
