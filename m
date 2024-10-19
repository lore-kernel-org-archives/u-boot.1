Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4F8D3C91D
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2FEF88E5C;
	Sat, 19 Oct 2024 17:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NDesmpNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16FA787D1A; Sat, 19 Oct 2024 17:22:24 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3B98857C
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83a9be2c028so111093139f.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351338; x=1729956138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OR0C9ZCqN8TB4LAa8w+Vhi07KOv/PC6TpgHT+uoxjsg=;
 b=NDesmpNPKBdjWMbOamk+kHz/VOaL+O21h3tyzPEStzF9Yy55bmAcLLttSLd2WcjlDE
 dvI5lSH85K/NDSGcfoazAaQXROZYqY4bMUJp7BiQUMv/5PI+FebF3C5YFncTjmx2eh+p
 79GDcobhAZxZ6ONPqnwuMCXz8xPZ8ekxbyD3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351338; x=1729956138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OR0C9ZCqN8TB4LAa8w+Vhi07KOv/PC6TpgHT+uoxjsg=;
 b=v7JPrIQH3hKazRed38ndW8boTm+G0DDGG39jcGlj+frU5JG+CRLewLjuOlHSkKio6N
 HxojCRJCwM6X51mDXbvXPStkjh3dsJTPTgpMq30KThgHjbMEQ7QRNAceWkSe5gulZWgT
 p1XKzWK76VEXRx33mRSX64LZ1hFzBHH6wGjITkTnonW1DDlLb2lm/+m0fftpzPtepB9m
 LxziGHNvi2c3G7XcT3kuH4gHMIIq3r9ugizrSCbxTQr9g6qcysR8L97hlyLXHAlPGpw+
 Ff3jHUDnlOUZ0vvyrBIweThVWrKoiR8mOb1svoRU3wVJWA2g76SZnl6BrqiIwKXjScB3
 Hm1g==
X-Gm-Message-State: AOJu0YwaCqmZmKWVoFFTNrsxF6OPHxr2sB/vN2qq8hpcObqrgTcSzrBW
 V2DIk9VgKfqvVwV9PrYCn3wQ9wxsYMpl8YkywfC86kx/SzmcX0NMPLsh74BEh6+GBUa6IE30uZE
 =
X-Google-Smtp-Source: AGHT+IHKOZhb7Vw3KO2vgciMUXaM+GkRjTkP3mmDtZ3y5tm7/uwkkjWJq5tmbqcqSy5IQOIiHwZK3Q==
X-Received: by 2002:a05:6602:2d8a:b0:83a:aa8e:5f72 with SMTP id
 ca18e2360f4ac-83aba5d41ebmr630927439f.4.1729351338248; 
 Sat, 19 Oct 2024 08:22:18 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Edmond <seanedmond@microsoft.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shantur Rathore <i@shantur.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 00/31] bootstd: Support recording images
Date: Sat, 19 Oct 2024 09:21:40 -0600
Message-Id: <20241019152211.1014896-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Oct 2024 17:45:04 +0200
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

This series provides a way to keep track of the images used in bootstd,
including the type of each image.

At present this is sort-of handled by struct bootflow but in quite an
ad-hoc way. The structure has become quite large and is hard to query.
Future work will be able to reduce its size.

Ultimately the 'bootflow info' command may change to also show images as
a list, but that is left for later, as this series is already fairly
long. So for now, just introduce the concept and adjust bootstd to use
it, with a simple command to list the images.

This series includes various alist enhancements, to make use of this new
data structure a little easier.

Changes in v2:
- Add an image type extension in bootflow.h
- Add new patch to put myself as maintainer of alist
- Change the tag to bootmeth_efi
- Drop patches which add new image types
- Update to use a new image-type enum in bootflow.h
- Use the word 'feature' instead of 'hack'

Simon Glass (31):
  alist: Mention the error condition in alist_add_placeholder()
  alist: Add a comment for alist_init_struct()
  alist: Expand the comment for alist_get()
  alist: Add a way to get the next element
  alist: Add for-loop helpers
  alist: Add a function to empty the list
  alist: Add a way to efficiently filter an alist
  alist: Add maintainer
  dm: core: Add a function to see if a device exists
  test: boot: Use a consistent name for the script bootmeth
  bootstd: Move bootflow-adding to bootstd
  bootstd: Move bootflow-clearing to bootstd
  bootstd: Add a function to get bootstd only if available
  bootstd: Drop the bootdev-specific list of bootflows
  bootstd: Move the bootflow list into an alist
  test: Expand implementation of ut_list_has_dm_tests()
  test: Drop the duplicate line in setup_bootmenu_image()
  test: boot: Update bootflow_iter() for console checking
  bootstd: cros: Correct the x86-setup address
  bootstd: Maintain a list of images
  bootstd: Update bootmeth_alloc_file() to record images
  boot: pxe: Drop the duplicate comment on get_pxe_file()
  bootmeth_efi: Simplify reading files by using the common function
  bootmeth: Update the read_file() method to include a type
  bootmeth_efi: Check the filename-allocation in the network path
  boot: Update extlinux pxe_getfile_func() to include type
  boot: Update pxe bootmeth to record images
  Update bootmeth_alloc_other() to record images
  bootstd: Avoid showing an invalid buffer address
  bootstd: Update cros bootmeth to record images
  bootstd: Add a simple command to list images

 MAINTAINERS                      |   7 +
 boot/bootdev-uclass.c            |  76 +++-------
 boot/bootflow.c                  |  56 +++++--
 boot/bootmeth-uclass.c           |  54 ++++++-
 boot/bootmeth_android.c          |   3 +-
 boot/bootmeth_cros.c             |  33 +++-
 boot/bootmeth_efi.c              |  16 +-
 boot/bootmeth_efi_mgr.c          |   3 +-
 boot/bootmeth_extlinux.c         |   7 +-
 boot/bootmeth_pxe.c              |  21 ++-
 boot/bootmeth_qfw.c              |   3 +-
 boot/bootmeth_sandbox.c          |   3 +-
 boot/bootmeth_script.c           |   7 +-
 boot/bootstd-uclass.c            |  59 ++++++-
 boot/pxe_utils.c                 |  36 ++---
 boot/vbe_simple.c                |   5 +-
 cmd/Kconfig                      |   9 ++
 cmd/Makefile                     |   1 +
 cmd/bootdev.c                    |   2 +-
 cmd/bootflow.c                   |  13 +-
 cmd/bootstd.c                    |  65 ++++++++
 cmd/pxe.c                        |   2 +-
 cmd/sysboot.c                    |   6 +-
 doc/develop/bootstd/overview.rst |  21 ++-
 doc/usage/cmd/bootstd.rst        |  79 ++++++++++
 doc/usage/index.rst              |   1 +
 drivers/core/uclass.c            |  11 ++
 include/alist.h                  | 139 ++++++++++++++++-
 include/bootdev.h                |  27 ----
 include/bootflow.h               |  72 +++++++--
 include/bootmeth.h               |  22 ++-
 include/bootstd.h                |  50 +++++-
 include/dm/uclass.h              |  11 ++
 include/pxe_utils.h              |  14 +-
 lib/alist.c                      |  41 +++++
 test/boot/bootflow.c             | 110 +++++++++++++-
 test/dm/core.c                   |  22 +++
 test/lib/alist.c                 | 253 +++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py         |   5 +-
 test/test-main.c                 |  18 ++-
 40 files changed, 1191 insertions(+), 192 deletions(-)
 create mode 100644 cmd/bootstd.c
 create mode 100644 doc/usage/cmd/bootstd.rst

-- 
2.34.1

