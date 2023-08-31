Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9260C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F2B8675B;
	Thu, 31 Aug 2023 18:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pJtxEu7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2680867B6; Thu, 31 Aug 2023 18:51:59 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA58B86682
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bc9c01e154so1155832a34.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693500715; x=1694105515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lwRd5gu5cxc4NlrM3Bm7jaeVA7Ebv4TA4U+57pmHWg=;
 b=pJtxEu7kW+yfyJ0Ixx8OCtVorAKDRjxY3+6Ck6AQKTKG5SeyKYE2StOIvsg7y3a+E1
 S1/Xey+pMyypbFegcY027BLA3z5zh6g1/JpwfwR6o6Xu5b0PXZ4v+hjIW4Orqf//PjLS
 MDZ4Mn8bcsaNxi99vrUg42sEUy99+OgGt4cSDKFH+I4DJyMbsf0TnO0FNhhKhaCDebQU
 u9SOL95lj7oME8Re6L50eJoPalQi7cVe9SCKTdFOAQOt1eq00Ldv1GtHT6yB6/1aOYrF
 Rs+6Imxwg9f4cGqHrEhUZnbcT1TENfa6HRTWaBSKP2CpU//b78fVH08tZJLC/kU2P1Zw
 dNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693500715; x=1694105515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lwRd5gu5cxc4NlrM3Bm7jaeVA7Ebv4TA4U+57pmHWg=;
 b=Pnc9C0toGaB3lb3nbYJSro75jOdLwHOMWLImHv/o3FZLC7FZqF+BK3htdwbDaJXwTE
 czIdJp9j4u5kXisflzBH3Mt0joIS6PHcCG2Mm86tI+PbZWOiSXPidJrevc+ohRqzXfEv
 rJPIKLfOa93JzAM5AGtz9FxhdW7pzB//KRS/SUbmInI10ce+UMXRAkYvidZzzoum+piR
 /mqf0IO0bnnCBX0bdw7Rf+aDWvyZeeEELteBXk1eDulxLSUmixTPXNpWG4Z62/L+M37o
 n3/gzYtsm75yyowceV3Dbp25/9tA/g/+KEtjE3qix8btDJLB3aI2cFvKXIl6K8RIj/mc
 rfDA==
X-Gm-Message-State: AOJu0YwwYwYN7QtTioUAeWCVAe5HKTd1ySVT3ST+1/xshM5MjhWKAKSQ
 Ud8tjJ2rk7S8HL1yFRCM/pH4U1u8f9U=
X-Google-Smtp-Source: AGHT+IETbEJh6d2QbqM7hvvV4HdlLpNE/lKWzHSMJaBI8tPjtEYvUxDKNT1+NASITEM80IV6OcyCTA==
X-Received: by 2002:a05:6830:929:b0:6bb:3032:55e5 with SMTP id
 v41-20020a056830092900b006bb303255e5mr2260737ott.9.1693500714813; 
 Thu, 31 Aug 2023 09:51:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::b66b])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a9d6b8f000000b006bb334880d8sm867020otq.81.2023.08.31.09.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:51:53 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v5 2/8] doc: Add gpt command documentation
Date: Thu, 31 Aug 2023 10:51:35 -0600
Message-Id: <20230831165144.592820-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831165144.592820-1-JPEWhacker@gmail.com>
References: <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230831165144.592820-1-JPEWhacker@gmail.com>
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

Adds initial documentation for the gpt command

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 doc/usage/cmd/gpt.rst | 184 ++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst   |   1 +
 2 files changed, 185 insertions(+)
 create mode 100644 doc/usage/cmd/gpt.rst

diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
new file mode 100644
index 0000000000..6387c8116f
--- /dev/null
+++ b/doc/usage/cmd/gpt.rst
@@ -0,0 +1,184 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+gpt command
+===========
+
+Synopsis
+--------
+
+::
+
+    gpt enumerate <interface> <dev>
+    gpt guid <interface> <dev> [<varname>]
+    gpt read <interface> <dev> [<varname>]
+    gpt rename <interface> <dev> <part> <name>
+    gpt repair <interface> <dev>
+    gpt setenv <interface> <dev> <partition name>
+    gpt swap <interface> <dev> <name1> <name2>
+    gpt verify <interface> <dev> [<partition string>]
+    gpt write <interface> <dev> <partition string>
+
+Description
+-----------
+
+The gpt command lets users read, create, modify, or verify the GPT (GUID
+Partition Table) partition layout.
+
+Common arguments:
+
+interface
+    interface for accessing the block device (mmc, sata, scsi, usb, ....)
+
+dev
+    device number
+
+partition string
+    Describes the GPT partition layout for a disk.  The syntax is similar to
+    the one used by the :doc:`mbr command <mbr>` command. The string contains
+    one or more partition descriptors, each separated by a ";". Each descriptor
+    contains one or more fields, with each field separated by a ",". Fields are
+    either of the form "key=value" to set a specific value, or simple "flag" to
+    set a boolean flag
+
+    The first descriptor can optionally be used to describe parameters for the
+    whole disk with the following fields:
+
+    * uuid_disk=UUID - Set the UUID for the disk
+
+    Partition descriptors can have the following fields:
+
+    * name=<NAME> - The partition name, required
+    * start=<BYTES> - The partition start offset in bytes, required
+    * size=<BYTES> - The partition size in bytes or "-" to expand it to the whole free area
+    * bootable - Set the legacy bootable flag
+    * uuid=<UUID> - The partition UUID, optional if CONFIG_RANDOM_UUID=y is enabled
+    * type=<UUID> - The partition type GUID, requires CONFIG_PARTITION_TYPE_GUID=y
+
+
+    If 'uuid' is not specified, but CONFIG_RANDOM_UUID is enabled, a random UUID
+    will be generated for the partition
+
+gpt enumerate
+~~~~~~~~~~~~~
+
+Sets the variable 'gpt_partition_list' to be a list of all the partition names
+on the device.
+
+gpt guid
+~~~~~~~~
+
+Report the GUID of a disk. If 'varname' is specified, the command will set the
+variable to the GUID, otherwise it will be printed out.
+
+gpt read
+~~~~~~~~
+
+Prints the current state of the GPT partition table. If 'varname' is specified,
+the variable will be filled with a partition string in the same format as a
+'<partition string>', suitable for passing to other 'gpt' commands.  If the
+argument is omitted, a human readable description is printed out.
+CONFIG_CMD_GPT_RENAME=y is required.
+
+gpt rename
+~~~~~~~~~~
+
+Renames all partitions named 'part' to be 'name'. CONFIG_CMD_GPT_RENAME=y is
+required.
+
+gpt repair
+~~~~~~~~~~
+
+Repairs the GPT partition tables if it they become corrupted.
+
+gpt setenv
+~~~~~~~~~~
+
+The 'gpt setenv' command will set a series of environment variables with
+information about the partition named '<partition name>'. The variables are:
+
+gpt_partition_addr
+    the starting offset of the partition in blocks as a hexadecimal number
+
+gpt_partition_size
+    the size of the partition in blocks as a hexadecimal number
+
+gpt_partition_name
+    the name of the partition
+
+gpt_partition_entry
+    the partition number in the table, e.g. 1, 2, 3, etc.
+
+gpt swap
+~~~~~~~~
+
+Changes the names of all partitions that are named 'name1' to be 'name2', and
+all partitions named 'name2' to be 'name1'. CONFIG_CMD_GPT_RENAME=y is
+required.
+
+gpt verify
+~~~~~~~~~~
+
+Sets return value $? to 0 (true) if the partition layout on the
+specified disk matches the one in the provided partition string, and 1 (false)
+if it does not match. If no partition string is specified, the command will
+check if the disk is partitioned or not.
+
+gpt write
+~~~~~~~~~
+
+(Re)writes the partition table on the disk to match the provided
+partition string. It returns 0 on success or 1 on failure.
+
+Configuration
+-------------
+
+To use the 'gpt' command you must specify CONFIG_CMD_GPT=y. To enable 'gpt
+read', 'gpt swap' and 'gpt rename', you must specify CONFIG_CMD_GPT_RENAME=y.
+
+Examples
+~~~~~~~~
+Create 6 partitions on a disk::
+
+    => setenv gpt_parts 'uuid_disk=bec9fc2a-86c1-483d-8a0e-0109732277d7;
+        name=boot,start=4M,size=128M,bootable,type=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7,
+        name=rootfs,size=3072M,type=0fc63daf-8483-4772-8e79-3d69d8477de4;
+        name=system-data,size=512M,type=0fc63daf-8483-4772-8e79-3d69d8477de4;
+        name=[ext],size=-,type=0fc63daf-8483-4772-8e79-3d69d8477de4;
+        name=user,size=-,type=0fc63daf-8483-4772-8e79-3d69d8477de4;
+        name=modules,size=100M,type=0fc63daf-8483-4772-8e79-3d69d8477de4;
+        name=ramdisk,size=8M,type=0fc63daf-8483-4772-8e79-3d69d8477de4
+    => gpt write mmc 0 $gpt_parts
+
+
+Verify that the device matches the partition layout described in the variable
+$gpt_parts::
+
+    => gpt verify mmc 0 $gpt_parts
+
+
+Get the information about the partition named 'rootfs'::
+
+    => gpt setenv mmc 0 rootfs
+    => echo ${gpt_partition_addr}
+    2000
+    => echo ${gpt_partition_size}
+    14a000
+    => echo ${gpt_partition_name}
+    rootfs
+    => echo ${gpt_partition_entry}
+    2
+
+Get the list of partition names on the disk::
+
+    => gpt enumerate
+    => echo gpt_partition_list
+    boot rootfs system-data [ext] user modules ramdisk
+
+
+Get the GUID for a disk::
+
+    => gpt guid mmc 0
+    bec9fc2a-86c1-483d-8a0e-0109732277d7
+    => gpt guid mmc gpt_disk_uuid
+    => echo ${gpt_disk_uuid}
+    bec9fc2a-86c1-483d-8a0e-0109732277d7
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index f45a7f5502..fa702920fa 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -66,6 +66,7 @@ Shell commands
    cmd/for
    cmd/fwu_mdata
    cmd/gpio
+   cmd/gpt
    cmd/host
    cmd/imxtract
    cmd/load
-- 
2.34.1

