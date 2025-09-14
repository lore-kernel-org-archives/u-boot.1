Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EA7CAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 20:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA6B082A9E;
	Sun, 14 Sep 2025 22:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AKUHXnP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E44E582AE1; Sun, 14 Sep 2025 22:59:19 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56737802C1
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 22:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-ea40276ec3fso491777276.0
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757883556; x=1758488356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5SjkQcEazPbeuLWutv8vfmYExTwx+zoEy7tWR1WqhM=;
 b=AKUHXnP8it3eDWJdYaLmVzwtdiD/RUSlyA23g8k1P1PfREaaINQ2GHoahZc8nc+YE5
 YAn3OmVPhH8DuT3zFAtbYuAZFf4lgUNhs5NU0EcLQY+8ycUe92KAEq5lEHtCoE7pJ2Ck
 mBApNegILWVI/rlmk3JeSguCIBzermiom/ncl6ygljdyhT4fvVgfBX+Cet7y8/xAY50M
 cqb7dveF000RwsyXJkcBtWwwEq6S1SDmtV0RGvV6ndCUmXxxVDoZDKFeDVRlyRSpA/u6
 e6hdlIltgSFIWWnG360flP5eDoP0o4w8RuaNiugmoK66A39UbJe/GfVo5YwbtVSd+QFf
 UBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757883556; x=1758488356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5SjkQcEazPbeuLWutv8vfmYExTwx+zoEy7tWR1WqhM=;
 b=GOFHV1tFmAC1AuRGB9gyHGIHREpu1eJzKRGxHJZpnpcwW88pUhgDIrsyUZwN02LCc3
 YFocBzaLGqy8GuyTfRsaWnpmmib/0sZ8X5qEBrmn3cSwNg9eICRDfQ+eg1rxh26LqG/z
 8Hr3oa1Olw1N8ePW6e14XGK3RQDxHGRcMp0OPeLrzLvJSN/s4SxcmK82Cf2CngLNJUF6
 kRyBeBVhQXSCcZNmg62QkeuKzpjR3gRJIo7teoFcNwIMX3wvTjf67tPQHFqPx2b5Leeq
 f9dJgHn8YSspmHBQ3uyy488TtelPv2mSu6RruCvD6/twTBVMKGuRoYCC/bS30FqQ1aBh
 FnoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSkGjxK4xReXbSVqc8K11TEa5SL92o4/q4RRwNMKdzbEyoUI3jFZZJafuSQdyKjhB7rrKTEMo=@lists.denx.de
X-Gm-Message-State: AOJu0YwYEIHX2RyIXnooKH9QYdYD7g0cp3ekvGDVnaiQ4+75kyPtOAuk
 wgg0Qms5mMpF38dvxWA+k2DW1QVrOVrZCyA/P6hDKBgqRLewCNXKHpou
X-Gm-Gg: ASbGncsHPjNkeFUwU7JeV3SBP9ntSsdWk42R746yLBXf3Bv5lXDupoKlZRAfTf4SgHX
 xND9u/41yxCm/XR2NhhILnlHT32wiLZ1Fah6E/HAyx9eS/GurSLk4xlIM4oJcsDJagk+tRCNNC/
 CIFjSRAnaK2FBpUEUGWPTF7/0rzyQnjf/CfjmC7gQ1DYHoRb9JyiHsds1S0ZK0eX2+gTMEqPbh/
 RKeElbUw5ZAKped+bEJ0MJrIddlV4oex1xLgV9KdX4hHyQo5AfwigaCGL843NAdU5xxhCHzOGyU
 HajIF9agFMpfuhqnznfmSbe+z6pmKcl47RrEYt5uTK0Kkeh5Jt9geRsZB6cuZsuZkl1k/nl5hfK
 XdMnE6JWKf0PGIOERYcwLmUKYZypnr6SjnzA3GiIrNRFsGO3+d0rer8vvKLKOMnoitbI/7HZcPi
 L3q3i9/ZBP9w==
X-Google-Smtp-Source: AGHT+IFrwKN9yH04rYx8tTd7j3mq4WJCug1tNJ6+e2qjDsL4cc5Wq6CekX2EtS/K9H+Rap5kcmHBVg==
X-Received: by 2002:a05:6902:5409:b0:ea3:be0a:cce2 with SMTP id
 3f1490d57ef6-ea3d99e125amr7427380276.7.1757883555995; 
 Sun, 14 Sep 2025 13:59:15 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-ea404efe625sm855253276.33.2025.09.14.13.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 13:59:15 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tony Dinh <mibodhi@gmail.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] doc: usage: Add File System section and Ext4 documentation
Date: Sun, 14 Sep 2025 13:56:28 -0700
Message-ID: <20250914205807.22817-1-mibodhi@gmail.com>
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

Changes in v2:
- Correct the syntax for ext4load command.
- Correct the syntax for ext4write command, and use a better example.
- In examples, only highlight commands, not text.

 .../filesystems/ext4.rst}                     | 95 ++++++++++++++-----
 doc/usage/index.rst                           |  8 ++
 2 files changed, 77 insertions(+), 26 deletions(-)
 rename doc/{README.ext4 => usage/filesystems/ext4.rst} (51%)

diff --git a/doc/README.ext4 b/doc/usage/filesystems/ext4.rst
similarity index 51%
rename from doc/README.ext4
rename to doc/usage/filesystems/ext4.rst
index ca9f19953d2..c6cdaf57fac 100644
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
 
-In addition, to get the write access command "ext4write", enable:
+In addition, to get the write access command ``ext4write``, enable:
 
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
 
@@ -51,11 +72,16 @@ The number of journal entries and dynamic memory allocation are proportional
 to the partition capacity. For example, an ext4 4TB HDD partition could
 require approximately 500 entries and more than 128 MB heap space.
 
+Examples
+--------
+
 Some sample commands to test ext4 support:
 
-1. Check that the commands can be seen in the output of U-Boot help:
+1. Check that the ext4 commands can be seen in the output of U-Boot help:
+
+::
 
-	UBOOT #help
+	=> help
 	...
 	ext4load- load binary file from a Ext4 file system
 	ext4ls  - list files in a directory (default /)
@@ -63,32 +89,49 @@ Some sample commands to test ext4 support:
 	ext4write- create a file in ext4 formatted partition
 	...
 
-2. To list the files in an ext4-formatted partition, run:
+2. The ``ext4ls`` command can be used to list the files in an ext4-formatted partition:
+
+::
 
 	ext4ls <interface> <dev[:part]> [directory]
 
-	For example:
-	UBOOT #ext4ls mmc 0:5 /usr/lib
+For example, to list files in ext4-formatted partition directory /usr/lib:
+
+::
+
+	=> ext4ls mmc 0:5 /usr/lib
+
+3. The ``ext4load`` command can be used to read and load a file from an
+ext4-formatted partition to RAM:
+
+::
+
+	ext4load <interface> [<dev[:part]> [addr [filename [bytes [pos]]]]]
+
+For example, to load file /uImage from an ext4-formatted partition:
+
+::
+
+	=> ext4load mmc 2:2 0x30007fc0 uImage
+
+4. The ``ext4write`` command can be used to write to an ext4 partition:
+
+::
 
-3. To read and load a file from an ext4-formatted partition to RAM, run:
+	ext4write <interface> <dev[:part]> <addr> <absolute filename path> [sizebytes] [file offset]
 
-	ext4load <interface> <dev[:part]> [addr] [filename] [bytes]
+For example, to write a file loaded at 0x8200000 of size 256 bytes to an
+ext4-formatted partition with the filename ``/boot/sample_file.hex``:
 
-	For example:
-	UBOOT #ext4load mmc 2:2 0x30007fc0 uImage
+::
 
-4. To write a file to an ext4-formatted partition.
+	=> ext4write mmc 2:2 0x82000000 /boot/sample_file.hex 0x100
+	256 bytes written in 138 ms (1000 Bytes/s)
 
-	a) First load a file to RAM at a particular address for example 0x30007fc0.
-	Now execute ext4write command:
-	ext4write <interface> <dev[:part]> [filename] [Address] [sizebytes]
 
-	For example:
-	UBOOT #ext4write mmc 2:2 /boot/uImage 0x30007fc0 6183120
-	(here 6183120 is the size of the file to be written)
-	Note: Absolute path is required for the file to be written
+References
+----------
 
-References :
-	-- ext4 implementation in Linux Kernel
-	-- Uboot existing ext2 load and ls implementation
-	-- Journaling block device JBD2 implementation in linux Kernel
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
