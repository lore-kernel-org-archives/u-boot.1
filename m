Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9BFC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C683886986;
	Mon,  4 Sep 2023 16:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hLnod7S+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA8E86977; Mon,  4 Sep 2023 16:41:43 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CFCF86936
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79289fefdbeso72172739f.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838499; x=1694443299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OiksT/V9UnmMZcYseSblMAFuLvG0+IL3Gjd50Rs2/I8=;
 b=hLnod7S+gANj3/3M1dVwTZURTUd6Jugns//MdHTr1imRMVznxEGdAXASpYrphIhHdu
 5IqLfMGI6iXicQ5YWdp8r6NFOwDj40b7uK9CVwKSVDO1duBu17X3kHbfx8/Z1fSEgAMa
 wQ9CBmWojLQyQNF99TJQL0HV7iAg8cG47pHdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838499; x=1694443299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OiksT/V9UnmMZcYseSblMAFuLvG0+IL3Gjd50Rs2/I8=;
 b=LtvZhovZ4r1a/2QGbfaSA5VPsPpGLJ6yFV8765Xg6YozeOBF6fsUnud1rNmApKKYNA
 ZFegFk+YyACRcembFqCyL2fJ9HycYv9Y1RPv35I05dR0DmLQfUCZi/gOdS1PKGc/YqXN
 tyOvHwPTjioTVPKINcFdlj5XOwE5/+K27JydS5pmSmmRf3NKK7SV6GImUk8ezN2m2p4b
 pisDYiI2x3ql8Tz0mK9hMthv2H9dKDnpFUHt59eOKZdz9z04G+g5fNhlWhEIaotK1FWt
 f1Xpezv3c9czGO1Zs4PIqFpe3DtYcgy9ROWFUSnPFwfPQtpihHDjSLxl0qm3qkWlsBzQ
 iSyg==
X-Gm-Message-State: AOJu0Yxcnw5fXn3ODfmEbU5MzpK8bIHizgpCRdDTUIgkpV1683QIWg3k
 K0XlV5GnEc9D9EMfzjvEW9gQfeUu6oVEvJc9OX8=
X-Google-Smtp-Source: AGHT+IFq+Lanf7ekcXn5HEjpVgX8IlQ1eVc92T9knNQOqloA7OKG0tn1stTBWanKv9geVL0uo1V9nw==
X-Received: by 2002:a05:6e02:eec:b0:34c:e16d:6796 with SMTP id
 j12-20020a056e020eec00b0034ce16d6796mr12303409ilk.16.1693838498963; 
 Mon, 04 Sep 2023 07:41:38 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 00/20] Kconfig: Tidy up some options
Date: Mon,  4 Sep 2023 08:41:03 -0600
Message-ID: <20230904144131.2699824-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

The view from 'make menuconfig' is confusing in places. This series aims
to improve the top-level menu and also the boot menu.

It also groups FDT-fixup options tegether, at least the ones I could fine.

Finally this series marks the distro scripts as deprecated, so people have
a pointer to standard boot.

Changes in v3:
- Drop comment about an update/ directory
- Drop extra newline and quote
- Add new patch to drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS
- Drop patch 'Move SYS_RX_ETH_BUFFER into the network menu'

Changes in v2:
- Add new patch to move bmp code to drivers/video
- Just move these options to driver/video for later consideration
- Fix FMU typo in the subject
- Drop now-unnecessary depends on FWU_MULTI_BANK_UPDATE
- Mention in the DISTRO_DEFAULTS option that it is script-based
- Expand and rewrite the commit message
- Use the word 'Mark' instead of 'Make' to improve the English

Simon Glass (20):
  lib: rational: Move the Kconfigs into the correct place
  Kconfig: Move API into general setup
  video: Move bmp code to drivers/video
  video: Move the BMP options
  video: Move BMP options and code to video directory
  FWU: Avoid showing an unselectable menu option
  test: Move POST under a renamed Testing section
  boot: Move fdt_support to boot/
  Move fdt_simplefb to boot/
  boot: Move some other fdt-fixup options to the same menu
  boot: Rename Android-boot text
  Kconfig: Create a menu for FIT
  Kconfig: Move SPL_FIT under FIT
  spl: Tidy up load address in spl_ram
  boot: Make standard boot a menu
  Kconfig: Move TEXT_BASE et al under general setup
  Mark DISTRO_DEFAULTS as deprecated
  boot: Join FDT_FIXUP_PARTITIONS with related options
  boot: Drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS
  boot: Join ARCH_FIXUP_FDT_MEMORY with related options

 Kconfig                         |  67 ++++++++++-
 boot/Kconfig                    | 200 +++++++++++++-------------------
 boot/Makefile                   |   4 +
 {common => boot}/fdt_simplefb.c |   0
 {common => boot}/fdt_support.c  |   0
 common/Kconfig                  |  20 ----
 common/Makefile                 |   4 -
 common/spl/spl_ram.c            |  19 ++-
 doc/develop/bootstd.rst         |  23 ++++
 drivers/video/Kconfig           |  27 +++++
 drivers/video/Makefile          |   3 +
 {common => drivers/video}/bmp.c |   0
 lib/Kconfig                     |  17 +--
 lib/fwu_updates/Kconfig         |   9 +-
 test/Kconfig                    |  12 +-
 15 files changed, 227 insertions(+), 178 deletions(-)
 rename {common => boot}/fdt_simplefb.c (100%)
 rename {common => boot}/fdt_support.c (100%)
 rename {common => drivers/video}/bmp.c (100%)

-- 
2.42.0.283.g2d96d420d3-goog

