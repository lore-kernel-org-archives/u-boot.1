Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17032CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 04:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C6D78334F;
	Fri, 12 Sep 2025 06:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CcN1isrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E658833EB; Fri, 12 Sep 2025 06:55:05 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8501583322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 06:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e96e5535fcdso2517580276.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 21:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757652900; x=1758257700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MO6CiqWXprYtTybZtVlOLUvBjC4So5EX/ec6eARGkeY=;
 b=CcN1isrKiWDhu2zbVjz9fqCkn4TQMvNHDptpOLDfd8Ijicdj9O6Zt2euN70nVRcZWO
 ijSBCl9sJLbYzFE5opcFn3NpilRq+BRhyvAE4g1xH4LMmz8KiV8wPx/lXNeTwOmUeVEW
 AbTm60y7QaovSShXjnE7RqPnjfi/aKUctzexX8xCvZmhx/bFcq4Jo3jfuBWuMalvBEZn
 qqxCnkKVM9FwrZD44OZodi5q4a/xW8yLe5iJUga2CN5yA6i/qm43moLk1InM750EUZoA
 QOGKN0P1kF7ccHIytpBbTU0si0NYIXbHJi/MAS6TBb1JyadRavg4jJClE3MWpGXJsShn
 tgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757652900; x=1758257700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MO6CiqWXprYtTybZtVlOLUvBjC4So5EX/ec6eARGkeY=;
 b=uyiNnA3bIFoy57SGPJqOFOh5T89V7bsy3tFx5eiqQDrWCelJe7amY1M8uROrLoXC1D
 fCvEh0Q9Spy48cZHN5XWm75PZVhZNkYLwCQcrmUapmu0UkLJY9iAhpnaQgW467jHrx0F
 mypKdwsChl5E2R8sW0SyPVN50LmrgWbltFtKRUhxh22Dl82vd98fR7+e49Z5iceS+ms3
 ox/TYLfSwgr21I2430FDWZTEqbFUlVXmuHdWE9frU03KEut7PFCQtIJE4KZ/CDGsCDvl
 8gAvW9VvXEdWWBIHetjZbPnrv8Qrma3vHgEcMaMlmmXEKwF1bBZoKNUcGZ7z0ieagQSk
 XUNQ==
X-Gm-Message-State: AOJu0Yy4ZkZC8lPI3BLbk6KjvlfHf15Ykdb8t1ZvtFMWXhcha/BZ2/0N
 N4uGzZG19wBkMPIdSzFzR87HlCaR3Trbgq03ErT+eyV9I03GYYXY+JAH
X-Gm-Gg: ASbGnctSkTBEB8pKrqKnG6SPzlSU0PHevAFeymWu1/jHAOBvQsI6rronPbh1jsJuCmn
 89u+FPWejKyzsQRjYhddFp8qaY1j3vW6ijKDz/+2gu5rmDOnOp28GMrQqVdgiTU4DOjZ3MAuog3
 ClOvlymJff8bakD9Y/M0R5NF3J/98Xb3tHNLG3VQ5AoN7u1RWAPluKw9tQhCoXY3YyBzMhh0qj9
 pGhQG0MxQ/nhBc4Nv7323SSFHgKlSanapu0XEEE38Zm5ceGRRBhi3WkqtwHUb9/cs+NRUzQRVDr
 3F8Zmp0q//wUxG4b1lqjDETYcEGIr5RDU50z/IwYncbqUTopLOPCGq+taCA/116yDC8a9t3m4SN
 kdyPGonZN23VNcIyUPod5NqOXT7qSW80BgRMmtfEjKAC12ir6s4SLNScF4YsxbVDttBoyfa03ir
 VA3v6jSPKWNRd+3Z+VkAtd
X-Google-Smtp-Source: AGHT+IHGtBf8XntrZNxLFwjI5u3OerYHtOVopfsptxQXHxxorIBfdGVpZ0n3gglJqbxsBUgzBD+JSg==
X-Received: by 2002:a53:afd2:0:b0:600:52f0:3be7 with SMTP id
 956f58d0204a3-6274e2118b1mr1124222d50.12.1757652899946; 
 Thu, 11 Sep 2025 21:54:59 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-730c3bedcadsm1931487b3.22.2025.09.11.21.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 21:54:58 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Fiona Klute <fiona.klute@gmx.de>, Harsha Vardhan V M <h-vm@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Rasmus Villemoes <ravi@prevas.dk>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] doc: usage: Add File System section and Ext4 documentation
Date: Thu, 11 Sep 2025 21:49:25 -0700
Message-ID: <20250912045352.18856-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Create doc/usage/filesystems/ section.
Convert doc/README.ext4 to rST format and move it to the new section.
Update documentation to add configuration instruction for Ext4 Write
when using large partitions.

Note that this patch depends on this previous patch:
https://patchwork.ozlabs.org/project/uboot/patch/20250910215702.15576-1-mibodhi@gmail.com/

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 .../filesystems/ext4.rst}                     | 55 +++++++++++++++----
 doc/usage/index.rst                           |  8 +++
 2 files changed, 53 insertions(+), 10 deletions(-)
 rename doc/{README.ext4 => usage/filesystems/ext4.rst} (79%)

diff --git a/doc/README.ext4 b/doc/usage/filesystems/ext4.rst
similarity index 79%
rename from doc/README.ext4
rename to doc/usage/filesystems/ext4.rst
index ca9f19953d2..18e45045344 100644
--- a/doc/README.ext4
+++ b/doc/usage/filesystems/ext4.rst
@@ -1,9 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Ext4 File System
+================
+
+Overview
+--------
+
 U-Boot supports access of both ext2 and ext4 filesystems, either in read-only
 mode or in read-write mode.
 
+Configuration
+-------------
+
 First, to enable support for both ext4 (and, automatically, ext2 as well),
 but without selecting the corresponding commands, enable one of the following:
 
+::
+
   CONFIG_FS_EXT4	(for read-only)
   CONFIG_EXT4_WRITE	(for read-write)
 
@@ -20,22 +33,28 @@ or ext4-related commands:
 
 use one or both of:
 
-  CONFIG_CMD_EXT2
-  CONFIG_CMD_EXT4
+::
+
+	CONFIG_CMD_EXT2
+	CONFIG_CMD_EXT4
 
 Selecting either of the above automatically selects CONFIG_FS_EXT4 if it
 wasn't enabled already.
 
 In addition, to get the write access command "ext4write", enable:
 
-  CONFIG_CMD_EXT4_WRITE
+::
+
+	CONFIG_CMD_EXT4_WRITE
 
 which automatically selects CONFIG_EXT4_WRITE if it wasn't defined
 already.
 
 Also relevant are the generic filesystem commands, selected by:
 
-  CONFIG_CMD_FS_GENERIC
+::
+
+	CONFIG_CMD_FS_GENERIC
 
 This does not automatically enable EXT4 support for you, you still need
 to do that yourself.
@@ -44,6 +63,8 @@ Lastly, the current u-boot implementation for Ext4 write requires a lot
 of memory to run successfully. The following enable support for
 large Ext4 partitions:
 
+::
+
 	CONFIG_EXT4_MAX_JOURNAL_ENTRIES
 	CONFIG_SYS_MALLOC_LEN
 
@@ -51,10 +72,15 @@ The number of journal entries and dynamic memory allocation are proportional
 to the partition capacity. For example, an ext4 4TB HDD partition could
 require approximately 500 entries and more than 128 MB heap space.
 
+Examples
+--------
+
 Some sample commands to test ext4 support:
 
 1. Check that the commands can be seen in the output of U-Boot help:
 
+::
+
 	UBOOT #help
 	...
 	ext4load- load binary file from a Ext4 file system
@@ -65,6 +91,8 @@ Some sample commands to test ext4 support:
 
 2. To list the files in an ext4-formatted partition, run:
 
+::
+
 	ext4ls <interface> <dev[:part]> [directory]
 
 	For example:
@@ -72,6 +100,8 @@ Some sample commands to test ext4 support:
 
 3. To read and load a file from an ext4-formatted partition to RAM, run:
 
+::
+
 	ext4load <interface> <dev[:part]> [addr] [filename] [bytes]
 
 	For example:
@@ -79,16 +109,21 @@ Some sample commands to test ext4 support:
 
 4. To write a file to an ext4-formatted partition.
 
+::
+
 	a) First load a file to RAM at a particular address for example 0x30007fc0.
 	Now execute ext4write command:
 	ext4write <interface> <dev[:part]> [filename] [Address] [sizebytes]
 
 	For example:
-	UBOOT #ext4write mmc 2:2 /boot/uImage 0x30007fc0 6183120
-	(here 6183120 is the size of the file to be written)
+	UBOOT #ext4write mmc 2:2 /boot/uImage 0x30007fc0 0x5E58D0
+	(here 0x5E58D0 is the size of the file to be written,
+	which was output by the ext4load command)
 	Note: Absolute path is required for the file to be written
 
-References :
-	-- ext4 implementation in Linux Kernel
-	-- Uboot existing ext2 load and ls implementation
-	-- Journaling block device JBD2 implementation in linux Kernel
+References
+----------
+
+	* ext4 implementation in Linux Kernel
+	* Uboot existing ext2 load and ls implementation
+	* Journaling block device JBD2 implementation in linux Kernel
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 3a48521d5d5..4b0533c8e69 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -147,3 +147,11 @@ Booting OS
 
    os/plan9
    os/vxworks
+
+File Systems
+------------
+
+.. toctree::
+   :maxdepth: 1
+
+   filesystems/ext4
-- 
2.47.3

base-commit: d5a4a71f3f8876a05f211af0af820180e4c81721
branch: master
