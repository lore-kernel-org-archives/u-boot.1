Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9E2CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 19:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858D2881BD;
	Wed, 10 Apr 2024 21:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=loftorbital.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=loftorbital.com header.i=@loftorbital.com header.b="LgLIcHB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C05881AC; Wed, 10 Apr 2024 21:50:30 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA3F87B71
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 21:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=loftorbital.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=charlie.johnston@loftorbital.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e504f58230so7325365ad.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=loftorbital.com; s=google; t=1712778626; x=1713383426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybK3jcxQsQPWX19fhBZtxVSPuzvnLtavJc3iUCNRDRk=;
 b=LgLIcHB+oUrElekE3znIAOl0jlf39RT7MOACCRA5SVLmuSqxoEv2ERDHcmJ/3HEHvc
 S8HPj/LvpD/h14dzMk+bDdJepO51umOtphFVeqKLlg7oowWBS8ym3xPOtfAtO241uYVl
 Eaheto5iMPCtsP9P9CZubKZDX1GDvc/ev6GM1b1zvfodgPNMsyoVrK9T5EZVCaOg9wdV
 wp83pyvM+JNG9siEa6Swco6ZUoLYkkpPtnbfV1MPWNQzkOgWapGTivbtSSMLrk1v7ynl
 mRhkOJr27dXQpYgfQ0H/OblfwuL7pV/qmEtw5cfdJJ6yQMl47TUTLaFPYZBuLga/UX6Q
 DLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712778626; x=1713383426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybK3jcxQsQPWX19fhBZtxVSPuzvnLtavJc3iUCNRDRk=;
 b=hNFSL78J76K303N0CFLuxdACpxyQFn9XImoSadnfRalbsReeZmgZskoFq4Hp0sHCvF
 3xJQwmtvC5Cdc353/8/9KsVptGlu7NIoW9k2tbyCDf5HvPaODARlRN4SbNxg/8IOgLUA
 UeqUZe/PH4Cb19E6IKDJfF08nF/kwYo3zNoMNpmch5JBSg8Ujy5YAXgsKc5Uyc/yR0cY
 1PMRa5n3y/BzAETR41jkHocpUZPs2avkz6klhzujDBKZcVkY9EU9X9cJwxTl9lxIrjYI
 ACTyx8HID1w0DGCiz6vMV1/xL/j3UswaK3YNB0ShkA4znZ+ArkQJqMiCVPZaq0BRd9Pq
 B0Ww==
X-Gm-Message-State: AOJu0YwTTF5CkbsKIwZhFBBpLa6/NM27Gaj5GiryZRHFfrR8FBbtPv6G
 Z5H1W+0wwahO1JrEiUTInbCgW0JbYI10KtZXhhfVZhi57E5MhUqTkOVPSBw03fV/k08PCeeJ21Z
 H
X-Google-Smtp-Source: AGHT+IHPgoReTT+hn8HYJEq9fTmB/AidiNSn2Sy8cPGEJ5nAShQAdIEIRUQETRVRcYJOtbYcJhw5fg==
X-Received: by 2002:a17:902:c94c:b0:1e2:16b6:e9b6 with SMTP id
 i12-20020a170902c94c00b001e216b6e9b6mr4571569pla.48.1712778626535; 
 Wed, 10 Apr 2024 12:50:26 -0700 (PDT)
Received: from cjohnsto-vivado-vm.. ([12.172.216.189])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a17090311cc00b001e223b9eb25sm11131932plh.153.2024.04.10.12.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 12:50:26 -0700 (PDT)
From: Charlie Johnston <charlie.johnston@loftorbital.com>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, Charlie Johnston <charlie.johnston@loftorbital.com>
Subject: [PATCH v2] board: zynqmp: Move zynqmp commands from board/ to arch/
Date: Wed, 10 Apr 2024 12:50:08 -0700
Message-Id: <20240410195008.405061-2-charlie.johnston@loftorbital.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410195008.405061-1-charlie.johnston@loftorbital.com>
References: <20240410195008.405061-1-charlie.johnston@loftorbital.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Apr 2024 21:50:58 +0200
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

The zynqmp cmds.c is currently tied to the board but the commands
contained within are more closely tied to the architecture. To
allow usage of those commands when the architecture is ZynqMP but
the board is not, this change moves the cmds into the arch/ tree.

The source file is renamed to zynqmp.c to reflect the command name
as well.

Signed-off-by: Charlie Johnston <charlie.johnston@loftorbital.com>
---
 arch/arm/mach-zynqmp/Kconfig                  | 13 ++++++++++++-
 arch/arm/mach-zynqmp/Makefile                 |  4 ++++
 .../cmds.c => arch/arm/mach-zynqmp/zynqmp.c   |  0
 board/xilinx/zynqmp/Kconfig                   | 19 -------------------
 board/xilinx/zynqmp/Makefile                  |  4 ----
 5 files changed, 16 insertions(+), 24 deletions(-)
 rename board/xilinx/zynqmp/cmds.c => arch/arm/mach-zynqmp/zynqmp.c (100%)
 delete mode 100644 board/xilinx/zynqmp/Kconfig

diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index 6a7be0b427..ed0aa29c12 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -212,7 +212,18 @@ config SD1_LSHFT_MODE
 
 endchoice
 
+config CMD_ZYNQMP
+	bool "Enable ZynqMP specific commands"
+	depends on ZYNQMP_FIRMWARE
+	default y
+	help
+	  Enable ZynqMP specific commands like "zynqmp secure"
+	  which is used for zynqmp secure image verification.
+	  The secure image is a xilinx specific BOOT.BIN with
+	  either authentication or encryption or both encryption
+	  and authentication feature enabled while generating
+	  BOOT.BIN using Xilinx bootgen tool.
+
 source "board/xilinx/Kconfig"
-source "board/xilinx/zynqmp/Kconfig"
 
 endif
diff --git a/arch/arm/mach-zynqmp/Makefile b/arch/arm/mach-zynqmp/Makefile
index 8f897a37d1..38be1627ee 100644
--- a/arch/arm/mach-zynqmp/Makefile
+++ b/arch/arm/mach-zynqmp/Makefile
@@ -8,3 +8,7 @@ obj-$(CONFIG_MP)	+= mp.o
 obj-$(CONFIG_SPL_BUILD) += spl.o handoff.o psu_spl_init.o
 obj-$(CONFIG_SPL_ZYNQMP_DRAM_ECC_INIT) += ecc_spl_init.o
 obj-$(CONFIG_$(SPL_)ZYNQMP_PSU_INIT_ENABLED)	+= psu_spl_init.o
+
+ifndef CONFIG_SPL_BUILD
+obj-$(CONFIG_CMD_ZYNQMP) += zynqmp.o
+endif # !CONFIG_SPL_BUILD
diff --git a/board/xilinx/zynqmp/cmds.c b/arch/arm/mach-zynqmp/zynqmp.c
similarity index 100%
rename from board/xilinx/zynqmp/cmds.c
rename to arch/arm/mach-zynqmp/zynqmp.c
diff --git a/board/xilinx/zynqmp/Kconfig b/board/xilinx/zynqmp/Kconfig
deleted file mode 100644
index ffa2f0215d..0000000000
--- a/board/xilinx/zynqmp/Kconfig
+++ /dev/null
@@ -1,19 +0,0 @@
-# Copyright (c) 2018, Xilinx, Inc.
-#
-# SPDX-License-Identifier: GPL-2.0
-
-if ARCH_ZYNQMP
-
-config CMD_ZYNQMP
-	bool "Enable ZynqMP specific commands"
-	depends on ZYNQMP_FIRMWARE
-	default y
-	help
-	  Enable ZynqMP specific commands like "zynqmp secure"
-	  which is used for zynqmp secure image verification.
-	  The secure image is a xilinx specific BOOT.BIN with
-	  either authentication or encryption or both encryption
-	  and authentication feature enabled while generating
-	  BOOT.BIN using Xilinx bootgen tool.
-
-endif
diff --git a/board/xilinx/zynqmp/Makefile b/board/xilinx/zynqmp/Makefile
index 204e4fadf0..9ab50eca40 100644
--- a/board/xilinx/zynqmp/Makefile
+++ b/board/xilinx/zynqmp/Makefile
@@ -40,10 +40,6 @@ $(obj)/pm_cfg_obj.o: $(shell cd $(srctree); readlink -f $(CONFIG_ZYNQMP_SPL_PM_C
 endif
 endif
 
-ifndef CONFIG_SPL_BUILD
-obj-$(CONFIG_CMD_ZYNQMP) += cmds.o
-endif
-
 # Suppress "warning: function declaration isn't a prototype"
 CFLAGS_REMOVE_psu_init_gpl.o := -Wstrict-prototypes
 
-- 
2.34.1

