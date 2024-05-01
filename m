Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B84FC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D90488CFB;
	Wed,  1 May 2024 04:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r+StjYIY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59BF788C4B; Wed,  1 May 2024 04:46:08 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 270D088CD9
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6a0ce3e823fso13803406d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531565; x=1715136365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NWt/yuIZRrQEv+e79sSsgcdd4dKlENBCGs4NP6ayLU=;
 b=r+StjYIYxviGxkJIG/mDqwwRFoKnmXaIroyTgdbOy5XQmH/k62N4zDXLiVXMfrsZfT
 3hW+S/LxG/T68jGsvSnY/O/zqWrIvc1Zm/3LohOsqGuRIsbN538q5BDxOT0M53qdrHMz
 r49ONBfmiFZ376RHyFsJwTFNR187ztIoIsyr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531565; x=1715136365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NWt/yuIZRrQEv+e79sSsgcdd4dKlENBCGs4NP6ayLU=;
 b=mN/rYxL5vTEaxGiE+kkyDoOngr32fyV/dARDzOPmNaomtvi/qszoEYZgTk7JNOpSNi
 w+bZNEuovB+ZRSJ5DXeTnqnKkVKWJGUnDLsmnE72qXWC943GuGIOo70QrUWrBiEOgVEc
 J/k3yqKW29nk9pVwZNd+v8jUl7oFJCmqvgO6BJR7WWVrOzt1bpn3gBtG/xFuqxMmEVOU
 LeXKVQVHY5Dh1UOZa6mENzSNQdbbHTQX3TbBxfivz/un8gQF2881QnEKAiA1qCYmfkVn
 ufFDtzgSTxQvL1Oae8WOC1Zhk950ne4atwgzoar/dz8CDKiYYmO9IfFC3nwDTSKOVPuY
 VVNQ==
X-Gm-Message-State: AOJu0YwHMLm4Z5qUHBXV819szo1dxrDEPO8OvY74ZF0N+hqmPK324v2H
 NxIOqZSAJTHVMKdJoBGpGCE/tS4oSIZa/R7083ut69Jxr78jIzmSqjY1scUdYImEuAhqPYyg69c
 yRr6WYIT3
X-Google-Smtp-Source: AGHT+IElC/m2/6y5VLXlx5Ven4uiGDWoa1FdhAibFSH5IGUIUXSx9ozZlEk8RW3JWQ5C8w5GZ8ZwtQ==
X-Received: by 2002:ad4:5c4e:0:b0:690:c568:8dc9 with SMTP id
 a14-20020ad45c4e000000b00690c5688dc9mr1243222qva.36.1714531564748; 
 Tue, 30 Apr 2024 19:46:04 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:46:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH 148/149] board: xilinx: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:15 -0600
Message-Id: <20240501024316.1767971-148-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 board/xilinx/common/board.c     | 1 -
 board/xilinx/common/cpu-info.c  | 1 -
 board/xilinx/common/fru.c       | 1 -
 board/xilinx/common/fru_ops.c   | 2 +-
 board/xilinx/versal-net/board.c | 1 -
 board/xilinx/versal-net/cmds.c  | 2 +-
 board/xilinx/versal/board.c     | 1 -
 board/xilinx/versal/cmds.c      | 2 +-
 board/xilinx/zynq/board.c       | 2 +-
 board/xilinx/zynq/bootimg.c     | 1 -
 board/xilinx/zynq/cmds.c        | 1 -
 board/xilinx/zynqmp/cmds.c      | 3 ++-
 board/xilinx/zynqmp/zynqmp.c    | 2 +-
 board/xilinx/zynqmp_r5/board.c  | 2 +-
 14 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index b47d2d23f913..30a81376ac41 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -6,7 +6,6 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <efi.h>
 #include <efi_loader.h>
 #include <env.h>
diff --git a/board/xilinx/common/cpu-info.c b/board/xilinx/common/cpu-info.c
index bfe7f5b7e385..765bb24d9376 100644
--- a/board/xilinx/common/cpu-info.c
+++ b/board/xilinx/common/cpu-info.c
@@ -4,7 +4,6 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <soc.h>
 
diff --git a/board/xilinx/common/fru.c b/board/xilinx/common/fru.c
index 12b21317496a..8cf307e33f20 100644
--- a/board/xilinx/common/fru.c
+++ b/board/xilinx/common/fru.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 - 2020 Xilinx, Inc.
  */
 
-#include <common.h>
 #include <command.h>
 #include <fdtdec.h>
 #include <malloc.h>
diff --git a/board/xilinx/common/fru_ops.c b/board/xilinx/common/fru_ops.c
index 167252c240cd..610293bccf78 100644
--- a/board/xilinx/common/fru_ops.c
+++ b/board/xilinx/common/fru_ops.c
@@ -4,13 +4,13 @@
  * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
+#include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 
diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index da03024e162f..88e10fa7a7fa 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -6,7 +6,6 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <fdtdec.h>
 #include <init.h>
diff --git a/board/xilinx/versal-net/cmds.c b/board/xilinx/versal-net/cmds.c
index b18a71fe52c0..4d52084846b7 100644
--- a/board/xilinx/versal-net/cmds.c
+++ b/board/xilinx/versal-net/cmds.c
@@ -7,10 +7,10 @@
 
 #include <cpu_func.h>
 #include <command.h>
-#include <common.h>
 #include <log.h>
 #include <memalign.h>
 #include <versalpl.h>
+#include <vsprintf.h>
 #include <zynqmp_firmware.h>
 
 /**
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 4f6d56119db1..77ba783501eb 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -5,7 +5,6 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <fdtdec.h>
diff --git a/board/xilinx/versal/cmds.c b/board/xilinx/versal/cmds.c
index 2a74e49aedec..c78793573e86 100644
--- a/board/xilinx/versal/cmds.c
+++ b/board/xilinx/versal/cmds.c
@@ -6,10 +6,10 @@
 
 #include <cpu_func.h>
 #include <command.h>
-#include <common.h>
 #include <log.h>
 #include <memalign.h>
 #include <versalpl.h>
+#include <vsprintf.h>
 #include <zynqmp_firmware.h>
 
 static int do_versal_load_pdi(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index 6c365910011d..b9a91110ff79 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -4,7 +4,7 @@
  * (C) Copyright 2013 - 2018 Xilinx, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <dfu.h>
 #include <init.h>
diff --git a/board/xilinx/zynq/bootimg.c b/board/xilinx/zynq/bootimg.c
index 2f55078dd768..79bec3a4cfbc 100644
--- a/board/xilinx/zynq/bootimg.c
+++ b/board/xilinx/zynq/bootimg.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Xilinx, Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <part.h>
 #include <asm/global_data.h>
diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index d7c7b2f22955..05ecb75406b4 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Xilinx, Inc.
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/board/xilinx/zynqmp/cmds.c b/board/xilinx/zynqmp/cmds.c
index 9524688f27d9..bf39c5472ea9 100644
--- a/board/xilinx/zynqmp/cmds.c
+++ b/board/xilinx/zynqmp/cmds.c
@@ -4,13 +4,14 @@
  * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <vsprintf.h>
 #include <zynqmp_firmware.h>
+#include <linux/errno.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index f370fb7347a5..c4050af2a5a5 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -4,7 +4,7 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
diff --git a/board/xilinx/zynqmp_r5/board.c b/board/xilinx/zynqmp_r5/board.c
index 5c5a2e93863f..0c62b0013c46 100644
--- a/board/xilinx/zynqmp_r5/board.c
+++ b/board/xilinx/zynqmp_r5/board.c
@@ -3,9 +3,9 @@
  * (C) Copyright 2018 Xilinx, Inc. (Michal Simek)
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <init.h>
+#include <linux/errno.h>
 
 int board_init(void)
 {
-- 
2.34.1

