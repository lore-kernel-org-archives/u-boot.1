Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488E9EC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614A586AAF;
	Thu,  7 Sep 2023 17:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CTJqXLAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC3B86AA7; Thu,  7 Sep 2023 17:59:43 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA6686A34
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34f0fd5f871so4900405ab.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102379; x=1694707179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iL7vhhV/M8ixZvg7dWNzl15dz6iLZwN2At4tjwPxtCU=;
 b=CTJqXLAfKg4PB3G8zB1QnGJGLZkF2+6DDg4gc38wYKEzMNZYijYWilYjJyYggboxJb
 CkTT0KrzzZDpXP0lmIGR20YhIBqqlwyHuMJLUfN62ap0e+7ax9ahgf70bU+NMsMiUQa9
 EV48XBBRpMi9XwX8dLA5K5EW2ytGDwZmUlE0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102379; x=1694707179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iL7vhhV/M8ixZvg7dWNzl15dz6iLZwN2At4tjwPxtCU=;
 b=IGpeOnMpaqTNUKr65vtgkA3SR+q8AdwOJPXLCcVlgIrb5lSJCQkWSewtZgolJ7QjKD
 EoajY5IntETG0cHVZPTInXs+2o48yKMk2a1DpbprqnRTEYYqI09v1hFPYX9Pjb4OPRUR
 FgAc9QmP66wIMfddqP858FDtDu/sl7O/wdICSgx7u9GSeS3DJ1pjAa1PsPGeG4PS22H4
 FRsKndCEZHxpVNR2C1P6bwAjsu2Dt9iI+f7UYVOHhGHejgEjZFoz6DikxdPs8Ky5rxV6
 I6b1lzYVVYUTZ+CqhaT82femQyXP4L5nYNAWgiHB75NnDQ3EDlz7ijf00mhUX67mBs0N
 N6YA==
X-Gm-Message-State: AOJu0YynGkQKu3PC/sdDQrDvKOH91/5BKC1nqokdSwMQ1EW3it3HTDAs
 vHHB1kwD0DNz+44qfkHZOLKomHly9uZ/WKr1J/U=
X-Google-Smtp-Source: AGHT+IFeQGRgsEqrfqJdSErVS/GkIsNr0dYVzm+vkxyVPdO+bE2Mz4C7ImA51h4Zate6k9Ca8q/u3Q==
X-Received: by 2002:a05:6e02:1d11:b0:349:7832:5d8 with SMTP id
 i17-20020a056e021d1100b00349783205d8mr169598ila.5.1694102378901; 
 Thu, 07 Sep 2023 08:59:38 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 00/22] Kconfig: Tidy up some options
Date: Thu,  7 Sep 2023 09:59:05 -0600
Message-ID: <20230907155933.48511-1-sjg@chromium.org>
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

Changes in v4:
- Just move these options to driver/video for later consideration
- Allow TIMESTAMP without FIT
- Add new patch to drop SPL/TPL_RAM_SUPPORT option for SPL_LOAD_FIT_ADDRESS
- Add new patch to make ARCH_FIXUP_FDT_MEMORY depend on OF_LIBFDT

Changes in v3:
- Drop comment about an update/ directory
- Drop extra newline and quote
- Add new patch to drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS
- Drop patch 'Move SYS_RX_ETH_BUFFER into the network menu'

Changes in v2:
- Add new patch to move bmp code to drivers/video
- Fix FMU typo in the subject
- Drop now-unnecessary depends on FWU_MULTI_BANK_UPDATE
- Mention in the DISTRO_DEFAULTS option that it is script-based
- Expand and rewrite the commit message
- Use the word 'Mark' instead of 'Make' to improve the English

Simon Glass (22):
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
  spl: Tidy up load address in spl_ram
  spl: Drop SPL/TPL_RAM_SUPPORT option for SPL_LOAD_FIT_ADDRESS
  Kconfig: Move SPL_FIT under FIT
  boot: Make standard boot a menu
  Kconfig: Move TEXT_BASE et al under general setup
  Mark DISTRO_DEFAULTS as deprecated
  Make ARCH_FIXUP_FDT_MEMORY depend on OF_LIBFDT
  boot: Join FDT_FIXUP_PARTITIONS with related options
  boot: Drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS
  boot: Join ARCH_FIXUP_FDT_MEMORY with related options

 Kconfig                         |  67 +++++++++-
 boot/Kconfig                    | 222 +++++++++++++-------------------
 boot/Makefile                   |   4 +
 {common => boot}/fdt_simplefb.c |   0
 {common => boot}/fdt_support.c  |   0
 common/Kconfig                  |  20 ---
 common/Makefile                 |   4 -
 common/spl/spl_ram.c            |  19 ++-
 doc/develop/bootstd.rst         |  23 ++++
 drivers/video/Kconfig           |  27 ++++
 drivers/video/Makefile          |   3 +
 {common => drivers/video}/bmp.c |   0
 lib/Kconfig                     |  17 +--
 lib/fwu_updates/Kconfig         |   9 +-
 test/Kconfig                    |  12 +-
 15 files changed, 238 insertions(+), 189 deletions(-)
 rename {common => boot}/fdt_simplefb.c (100%)
 rename {common => boot}/fdt_support.c (100%)
 rename {common => drivers/video}/bmp.c (100%)

-- 
2.42.0.283.g2d96d420d3-goog

