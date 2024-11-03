Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C31D11100
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 14:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 464938910B;
	Sun,  3 Nov 2024 15:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KUdtuow8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3406E8914F; Sun,  3 Nov 2024 15:48:04 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C868912B
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 15:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so447805866b.0
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 06:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730645279; x=1731250079; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ho0J/hvWIowUJnJZ1PdRczPx1x83JD+VDxL2opltbcE=;
 b=KUdtuow8ZKHolLfsFgQy+FMmv112Bz8Hb8ksTvejCiN0xF0qVZY7RN00CiXYb+rhyw
 CO+XoIaBJdEz4MXyXjaotI7eIw2vOuKY2QFQRyG1I+2k/I/Qd5kPItiZlXrx9xAakEuT
 PdMU+bUvV8sdDtsFIlLuu0qnI1E4+la8fCn20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730645279; x=1731250079;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ho0J/hvWIowUJnJZ1PdRczPx1x83JD+VDxL2opltbcE=;
 b=ccN7/9vYnVhsyJT11n+EZZ7yvIf9hNC957sColJjP0sS4APKhBgp3Fi2kei6DL3jNK
 1KrXWkkPbFLvLqeXQkkLGw/QdUTcUv5c0I21rolyI+fNIiSo7em7KUlz7Dqpl8DwHwRa
 n+45cjpR98bP1l9PZ9Uu2KvWMzLlpFNN96hVhRvqtIU5hdOV44rVKwvTGV2y2QeXeT1s
 KyHGN+8kNNu8oOG5MbUdL0MFu6hT81QaX3G38GwAQJB4842fC84iVZ6kkYD/Tk7CoP7j
 t8e/WAzJPpS6PclIy/uozbEPsxakOHriRlTzEkSVEij0MKXY3Hc82ckILhoX1uMnXZ2/
 vZeQ==
X-Gm-Message-State: AOJu0YwEx7XOLSpozv7l8MhakJszZdX0apTWtUJzU6MU3f2nBD4IpiEL
 4EdTyDn4ytqlHs0T7NufWum26moqatONr7dE8zxKBfgtQ7rTDdmUzR63Np/QVqUGEQSvYSItMi8
 pDSeuGsIpsiG7TIpduq6DEgGKlNFOwMmcmoIy0Fb82v0X1OYDvA==
X-Google-Smtp-Source: AGHT+IFJigJAkc+0EIPYKxQrJ2W/xhTWBX/5oKAOys2UZRyh3g+ZxN3X5vKocpUdfZJL0v19dq6WZdrTF5x0Va5Yyuo=
X-Received: by 2002:a17:907:3da1:b0:a9a:4e77:92f with SMTP id
 a640c23a62f3a-a9e50b9e343mr1194730966b.56.1730645278972; Sun, 03 Nov 2024
 06:47:58 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Nov 2024 07:47:46 -0700
Message-ID: <CAFLszTj16p8-H1J349FoLowzpO7SNfdwELEDyDmi=U9+gZiCbw@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
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

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/23152
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=71&view=results

The following changes since commit e61ea9f2e5d2967826c2c6e3edba961064fbbaa1:

  mtd: spi-nor: Guard SPI_STACKED_PARALLEL with DM_SPI check
(2024-10-31 13:34:29 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-2nov24

for you to fetch changes up to 572b7b0255f9f33002ce7d2a8b2bac30ab49a48e:

  sandbox: Fix comment for nomap_sysmem() function (2024-11-02 16:14:55 -0600)

----------------------------------------------------------------
alist enhancements and fixes
minor test and sandbox fixes
some more x86/coreboot patches

----------------------------------------------------------------
Jonas Karlman (1):
      bootstage: Do not sort records

Simon Glass (27):
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
      test: Expand implementation of ut_list_has_dm_tests()
      test: Drop the duplicate line in setup_bootmenu_image()
      test: boot: Update bootflow_iter() for console checking
      bootstd: cros: Correct the x86-setup address
      bootstd: Avoid showing an invalid buffer address
      x86: coreboot: Add a test for cbsysinfo command
      x86: coreboot: Show the option table
      x86: coreboot: Enable support for the configuration editor
      x86: coreboot: Add a command to check and update CMOS RAM
      x86: coreboot: Allow building an expo for editing CMOS config
      log: Add a new category for tests
      test: Allow saving and restoring the bloblist
      bloblist: test: Mark tests with UTF_BLOBLIST
      sandbox: Convert sb command to use new macro
      doc: sandbox: Add docs for the sb command
      sandbox: Add a way to show the sandbox memory-mapping
      sandbox: Fix comment for nomap_sysmem() function

 MAINTAINERS                       |   7 ++
 arch/sandbox/cpu/cpu.c            |  13 +++
 arch/sandbox/include/asm/cpu.h    |   3 +
 arch/sandbox/include/asm/io.h     |   2 +-
 arch/x86/dts/coreboot.dts         |   7 ++
 boot/Makefile                     |   3 +
 boot/expo_build_cb.c              | 245
++++++++++++++++++++++++++++++++++++++++++++++++++++
 cmd/Kconfig                       |  11 +++
 cmd/bootflow.c                    |   9 +-
 cmd/cedit.c                       |  28 ++++++
 cmd/sb.c                          |  42 ++++-----
 cmd/x86/Makefile                  |   1 +
 cmd/x86/cbcmos.c                  | 139 ++++++++++++++++++++++++++++++
 cmd/x86/cbsysinfo.c               |  73 +++++++++++++++-
 common/bootstage.c                |  12 +--
 common/log.c                      |   1 +
 configs/coreboot64_defconfig      |   2 +
 configs/coreboot_defconfig        |   2 +
 doc/board/coreboot/coreboot.rst   |   6 ++
 doc/develop/cedit.rst             |   2 +-
 doc/usage/cmd/cbcmos.rst          |  45 ++++++++++
 doc/usage/cmd/cbsysinfo.rst       |  99 +++++++++++++++++++++
 doc/usage/cmd/cedit.rst           |  76 ++++++++++++++++
 doc/usage/cmd/sb.rst              |  79 +++++++++++++++++
 doc/usage/index.rst               |   2 +
 drivers/core/uclass.c             |  11 +++
 include/alist.h                   | 139 +++++++++++++++++++++++++++++-
 include/asm-generic/global_data.h |   2 +
 include/dm/uclass.h               |  11 +++
 include/expo.h                    |   8 ++
 include/log.h                     |   2 +
 include/test/test.h               |   3 +
 lib/alist.c                       |  41 +++++++++
 test/bloblist.c                   |  28 +++---
 test/boot/bootflow.c              |   4 +-
 test/cmd/Makefile                 |   1 +
 test/cmd/coreboot.c               | 119 +++++++++++++++++++++++++
 test/dm/core.c                    |  22 +++++
 test/lib/alist.c                  | 253
++++++++++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py          |   2 -
 test/test-main.c                  |  31 ++++++-
 41 files changed, 1521 insertions(+), 65 deletions(-)
 create mode 100644 boot/expo_build_cb.c
 create mode 100644 cmd/x86/cbcmos.c
 create mode 100644 doc/usage/cmd/cbcmos.rst
 create mode 100644 doc/usage/cmd/sb.rst
 create mode 100644 test/cmd/coreboot.c

Regards,
Simon
