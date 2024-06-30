Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CE9C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 14:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DECC88629;
	Sun, 30 Jun 2024 16:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ETqQRSC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0260388629; Sun, 30 Jun 2024 16:15:53 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08ACE8824C
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 16:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52ce01403f6so2423869e87.0
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719756950; x=1720361750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sqzobgnamGORRyZZUH0piao0uwcPtjsosSjtUKgJ8s8=;
 b=ETqQRSC734ytkXNpFvK5zX8MJPCReW0y1zKkghk1J8reZVdUXfOmo6RMYhhHu2g5dm
 6nXR3rv19h5WWOclK336Hg/SF+YRfxwOmHw8WKl4gdn6aJxoByYojZEw+ACSb8kZMNVE
 2Ic+W9LVCUCVffy01K1uJ75C5uFGL2wljOeCTvN91gAfI4Q+l3Jo4HUFj0df6YvUPpju
 D+CTA+PGOssuVeKA+KCreIl/e3qWsUKgjCRyUogB3AEodT2pV6bI+YR7nIvqz0gy8+yO
 H8XWAm39SqZCYfKHiY5YL0Z/0jqTS7bgT/1zCVzcZ1Y5riSCdWGE7BdXrfDxbr6402Qh
 qdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719756950; x=1720361750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sqzobgnamGORRyZZUH0piao0uwcPtjsosSjtUKgJ8s8=;
 b=RMjdV3P9ysmvAEtcrYgSlGjktB9Y//yeTbnT8JDyDMgZ9yJEPB+ogILsYgNQN4QjnE
 yrwUJHG3RklWvlksFwQVQrkENCUklKrQIjapOQomdIvdp8YCNP20it9/I2wVVqjsBLFB
 WbdaBez4X8RINN5nnd0dwUMMHIoJmJaT+smQeXk3bbUxezI65+fUm/zkYILRpcnCZEus
 4OzgfEFz0xvcUE75qvwwk3ZxiuKZv78BEtHl4ywlwh/RicKEqY8uQL/IqSm1Bk0HH2rP
 Zqg8RUD03Y+dtb7ilVk5cp4KBDwjAiV1BwesMTgCZMFREdMdK1jEDCWJ0MDOzABm2//m
 cKZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHimbnuZxkEhzHTsyMCNG912rhaTk1HeJgz7oo+eIUHK+nGL05wJ/kqDIGXoYAT4HWjpqG3FtGBOm754RdKjYki51anQ==
X-Gm-Message-State: AOJu0Yz1j72ZuJ5UF2ui2/OmJGrskzLKO7OcbGa76HWd103530ZSJWHm
 V1LimBeRT0/qHCin/4YOWpqwUHflOKu9g3hAyeFau/mvJeIl1+SXSCsOZg==
X-Google-Smtp-Source: AGHT+IFiRh+d/mnc0c0i8nyDfTjAPtobnrYdN5/8DSYVv7+R8MIpKnNa5Ht4hbCtABFeNcKOOkWCUw==
X-Received: by 2002:a05:6512:1d2:b0:52c:d9c6:f934 with SMTP id
 2adb3069b0e04-52e82671ea0mr1795597e87.18.1719756950009; 
 Sun, 30 Jun 2024 07:15:50 -0700 (PDT)
Received: from localhost.localdomain (109-252-15-116.nat.spd-mgts.ru.
 [109.252.15.116]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab3b2e4sm963434e87.272.2024.06.30.07.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 07:15:49 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: trini@konsulko.com,
	u-boot@lists.denx.de,
	sjg@chromium.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH v2] doc: add bootelf command documentation
Date: Sun, 30 Jun 2024 17:15:45 +0300
Message-Id: <20240630141545.215907-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
v2:
	Add Configuration section.
---
 doc/usage/cmd/bootelf.rst | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 doc/usage/cmd/bootelf.rst

diff --git a/doc/usage/cmd/bootelf.rst b/doc/usage/cmd/bootelf.rst
new file mode 100644
index 0000000000..748c3e2e4b
--- /dev/null
+++ b/doc/usage/cmd/bootelf.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright 2024, Maxim Moskalets <maximmosk4@gmail.com>
+
+.. index::
+   single: bootelf (command)
+
+bootelf command
+===============
+
+Synopsis
+--------
+
+::
+
+    bootelf [-p|-s] [-d <fdt_addr>] [<image_addr> [<arg>]...]
+
+Description
+-----------
+
+The *bootelf* command is used to launch a ELF binary at *image_addr*. If
+*image_addr* is not specified, the bootelf command will try to find image in
+*image_load_addr* variable (*CONFIG\_SYS\_LOAD\_ADDR* by default).
+
+Args after *image_addr* will be passed to application in common *argc*, *argv*
+format.
+
+A command sequence to run a ELF image using FDT might look like
+
+::
+
+    load mmc 0:1 ${loadaddr} /kernel.elf
+    load mmc 0:1 ${fdt_addr_r} /soc-board.dtb
+    bootelf -d ${fdt_addr_r} ${loadaddr} ${loadaddr}
+
+image_addr
+    Address of the ELF binary.
+
+fdt_addr
+    Address of the device-tree. This argument in only needed if bootable
+    application uses FDT that requires additional setup (like /memory node).
+
+arg
+    Any text arguments for bootable application. This is usually the address
+    of the device-tree.
+
+Flags:
+
+-p|-s
+    Load ELF image via program headers (-p) or via section headers (-s).
+
+-d
+    Setup FDT by address.
+
+Configuration
+-------------
+
+The bootelf command is only available if CONFIG_CMD_ELF=y. FDT setup by flag -d
+need CONFIG_CMD_ELF_FDT_SETUP=y.
-- 
2.39.2

