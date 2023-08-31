Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E56FC83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A822C86550;
	Thu, 31 Aug 2023 05:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SQ75duFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B51C08654A; Thu, 31 Aug 2023 05:53:26 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B16686550
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-44ede2dce3aso222436137.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454001; x=1694058801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tu7oIfBMQjdR6eYVlim4wPjbQ838/qUkx6NM5h2/s0I=;
 b=SQ75duFsJAxL1EOcZ2IJHp3MspvkOAgtH34ebrJRB7gJtmZhYOUjes9hY8OI23uUfz
 D7Jevi2mpKzsHz+Lfm16+14sYopBrrt2ZkJJBAjEdkGABDFGmNU20SZn7ojA5UMD6fPF
 s8uoE8cbLyc8nvXpG2zPCu1WbXr7Il6vkg7qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454001; x=1694058801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tu7oIfBMQjdR6eYVlim4wPjbQ838/qUkx6NM5h2/s0I=;
 b=PGiwpGa8i96qX1CG0wbGAYnu7vlKl902Oql2AAVxmn8eO/qIsdoeqRNUr/4LNKm466
 pxH1s2cqthlMheCu/h74IKWdKcPyH/8CNosWo1QQITZL/0VjObPh4jTiuo0NDE1MZrMt
 8OQQNrcQ3l7nnYeGWy1tQ99rrlNjpMtaWc3LifzMAp5ZyZj/rpfeGDNzcySwXBVbIT8u
 aEUDTiDsln6hInrIeltfYLjj77Cn+lBp1BmhJmpq4Zxf6JeO6UWMKJOaY7g6DxgxAYWI
 4lSroH2DqYGI/0nmGxw6/+8WvGt78VLtUB38CtqyVuLQpzTkH/9C6rDkWlVdF+irPmtK
 gsgg==
X-Gm-Message-State: AOJu0YzMH5VPZ1BRMnlJF8YmumSfEf0N5OXEtAxrpdvm6QEPl0Ny/RvX
 hLxynghMfYn9g1rxtjWaZtD06LT+yKcQw0ZnPvI=
X-Google-Smtp-Source: AGHT+IEN/aK4UvaS8TbWM5eckJjDinmYNNPy5YVnKbu0YkcGEABn0dAvHZpNypEuGldwD6yluPCdTw==
X-Received: by 2002:a05:6102:143:b0:44e:96f8:cc9 with SMTP id
 a3-20020a056102014300b0044e96f80cc9mr4168997vsr.18.1693454001144; 
 Wed, 30 Aug 2023 20:53:21 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 00/19] Kconfig: Tidy up some options
Date: Wed, 30 Aug 2023 21:52:54 -0600
Message-ID: <20230831035319.2316665-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
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

Changes in v2:
- Fix FMU typo in the subject
- Drop now-unnecessary depends on FWU_MULTI_BANK_UPDATE
- Mention in the DISTRO_DEFAULTS option that it is script-based
- Expand and rewrite the commit message
- Use the word 'Mark' instead of 'Make' to improve the English

Simon Glass (19):
  lib: rational: Move the Kconfigs into the correct place
  Kconfig: Move API into general setup
  video: Hide the BMP options
  video: Move BMP options and code to video directory
  net: Move SYS_RX_ETH_BUFFER into the network menu
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
  boot: Join ARCH_FIXUP_FDT_MEMORY with related options

 Kconfig                         |  67 ++++++++++-
 boot/Kconfig                    | 202 +++++++++++++-------------------
 boot/Makefile                   |   4 +
 {common => boot}/fdt_simplefb.c |   0
 {common => boot}/fdt_support.c  |   0
 common/Kconfig                  |  20 ----
 common/Makefile                 |   4 -
 common/spl/spl_ram.c            |  19 ++-
 doc/develop/bootstd.rst         |  23 ++++
 drivers/video/Kconfig           |  11 ++
 drivers/video/Makefile          |   2 +
 {common => drivers/video}/bmp.c |   0
 include/net.h                   |   9 +-
 lib/Kconfig                     |  17 +--
 lib/fwu_updates/Kconfig         |   9 +-
 net/Kconfig                     |   4 +-
 test/Kconfig                    |  12 +-
 17 files changed, 220 insertions(+), 183 deletions(-)
 rename {common => boot}/fdt_simplefb.c (100%)
 rename {common => boot}/fdt_support.c (100%)
 rename {common => drivers/video}/bmp.c (100%)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

