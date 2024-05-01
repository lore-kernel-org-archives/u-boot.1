Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B69C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A44588B77;
	Wed,  1 May 2024 04:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TzIDxdOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8FE088B70; Wed,  1 May 2024 04:44:27 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE81388AD7
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78f03917484so435258385a.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531464; x=1715136264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UlBoCpCuLhy7DrI8wIQ03F00iho68kLRgq6uWgX+v4=;
 b=TzIDxdOLiTh6F+ZUPU4xyozERXSygAGZxl0+uxgKA0OgobuWQbhPar+Pkn9y8CN4fB
 hRi4WJe2vqJg8sVsdy1F3Daz3Cjq3jxCziaj6vDus4ZkPFzitVslOeog906MhvEM3Z+T
 yII+I6RpxRi1PAkAYQSDDtqosA8G4JQFQL5ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531464; x=1715136264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5UlBoCpCuLhy7DrI8wIQ03F00iho68kLRgq6uWgX+v4=;
 b=R8fTfBB9EClXMeYBf/IzZdphQyHTrc5JgFcqRTPKeLNw2UX67iQMPr3pJyB07GmydP
 S9je7lZjJhNnZeVJ9jcujp3iEtpiPMQYDJdbASSCFaxJhCbEmGOIZXCFHvkCd9vTakU0
 t9OEzuUNFXdtNgEn31sVVCPlknQxECO+B60wGWyM6wY0pmubiENifL7RHk87TufdY0F4
 1IHdRE8FYG17O6h+vAOadrjQwb18fkeEqEVr3HJkU9TUXSITOOkLzMNCOrQFdn1bDRaG
 vED86T/bDqcxNsxmiXkkzxNmALFQ/F588mgnm9BhVeGEkWeblTk2XADkDiBr4dhGM8y3
 Mzxw==
X-Gm-Message-State: AOJu0YwzvNEvr2lieb/3sBPkbq5mfvvRrtTF6WBDEs9zLBeTSF/RemnB
 6Jq3fMJAWcT1Fld5zFYlrHxTIw2+a4PGsyYEAmAOT6cjceTjbVLcbBQnQrWJiC9KFLggq6NTIM4
 m+k/qKQ==
X-Google-Smtp-Source: AGHT+IGIijh3jHXSeXt4/zjhvwqCJ1/jMUFNDTWiO45GDF4SaaqRpjI06YHPDUgerhHalYFZ4A9p4A==
X-Received: by 2002:a05:6214:2621:b0:6a0:c990:223e with SMTP id
 gv1-20020a056214262100b006a0c990223emr1324364qvb.23.1714531464444; 
 Tue, 30 Apr 2024 19:44:24 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 057/149] board: emulation: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:44 -0600
Message-Id: <20240501024316.1767971-57-trini@konsulko.com>
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
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Alexander Graf <agraf@csgraf.de>
---
 board/emulation/common/qemu_dfu.c           | 1 -
 board/emulation/common/qemu_mtdparts.c      | 1 -
 board/emulation/qemu-arm/qemu-arm.c         | 2 +-
 board/emulation/qemu-ppce500/qemu-ppce500.c | 2 +-
 board/emulation/qemu-riscv/qemu-riscv.c     | 1 -
 5 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/board/emulation/common/qemu_dfu.c b/board/emulation/common/qemu_dfu.c
index 7e7d84f6c00f..393fcaeb7422 100644
--- a/board/emulation/common/qemu_dfu.c
+++ b/board/emulation/common/qemu_dfu.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020 Linaro Limited
  */
 
-#include <common.h>
 #include <dfu.h>
 #include <env.h>
 #include <memalign.h>
diff --git a/board/emulation/common/qemu_mtdparts.c b/board/emulation/common/qemu_mtdparts.c
index 60212e97acf6..c1501276789c 100644
--- a/board/emulation/common/qemu_mtdparts.c
+++ b/board/emulation/common/qemu_mtdparts.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020 Linaro Limited
  */
 
-#include <common.h>
 #include <dm.h>
 #include <mtd.h>
 
diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index ecfd19f1a7ed..6095cb02b23f 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2017 Tuomas Tynkkynen
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <efi.h>
diff --git a/board/emulation/qemu-ppce500/qemu-ppce500.c b/board/emulation/qemu-ppce500/qemu-ppce500.c
index 221361691c15..58e5d5eb9427 100644
--- a/board/emulation/qemu-ppce500/qemu-ppce500.c
+++ b/board/emulation/qemu-ppce500/qemu-ppce500.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2021, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index 173245b40e3c..e5193e31e37e 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/ofnode.h>
 #include <env.h>
-- 
2.34.1

