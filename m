Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147E5C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 009FC864CD;
	Mon, 28 Aug 2023 23:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e1KQHbLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54518864FF; Mon, 28 Aug 2023 23:56:43 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68182864CF
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a8506f5b73so2688463b6e.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259798; x=1693864598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0WYSA8d1VvFRrRZgasejS9WTuUbE90kdpQ8IJiDKmQ=;
 b=e1KQHbLByjWBHsUBGtD4ZNKyCwjgWUIWHrE5cIMCBQJZPKCwt/QlGZBoVCExUjdWtr
 aJPGOTspgqB/V9A1PxwQ40xKvbhC9/arncy0Zlb0uE8tGA5SY9+vgbS7b+9o+X+kzhCi
 5cDnKgruDlRFaLwQAb29TGjKndNRbk62JA6d/bU7qfiLyKah5EOrXm3GuyYNRlFJrIpn
 WD4ZlTLpxgx94x5fdpjM05Mt54R3nIH6c71rEpSDRWvLE8grqQyZlXt77QYseFtuIDdW
 wIhmCPXvT3gv425tbiormqCDumaRZ85hE5uyYQIAHUfthxU13E/F2iKRsT0H12nztfAa
 doJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259798; x=1693864598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0WYSA8d1VvFRrRZgasejS9WTuUbE90kdpQ8IJiDKmQ=;
 b=dtbIPedSiFXlsA/3l1D1BjATCELXHF2JLp9elAMFyT6VOPdlD9bKp4hZjZ689vEWZw
 dLLHPJN7aSMy/KMcKebYtbL1cQLSAlFb9ONB1g6XtOGtDyCa0We8KLkh8gZG22T8a2+K
 fr+bQZmwrN2L975ap4ljO3XL33Lo9DCpi2YMIEpSuoglBFMzTfy3i32QXt8i0joN7cd1
 J+lrz6FL/TXGbSA7IX3EB4Py5ekl1NfZy+8hfWMx9v+cUtsH/sfWEcLshARtnSjhKwZ9
 8FcUDRILYkrJ0CwRd7kCnej8w9LDzTlIkQoMKFVF+9TO1RVGN7WAq9yJA4h6/P4i4x0x
 0nyQ==
X-Gm-Message-State: AOJu0YzJJKYfaYbocbaOFTAorsoq6zzyjnkVx1J28SA8jxH9DQBh3vDj
 hF/ilz1pXYkF3xcmSQM3HKfl8eGwpsE=
X-Google-Smtp-Source: AGHT+IFlKjMKRwVKaDZAeBUepgBuBNSfOFtyZvKx24PVBzrSPsdc8sdwP185kBQ2ufiiwBmR4+WdBQ==
X-Received: by 2002:a05:6808:1a92:b0:3a3:6cb2:d5bf with SMTP id
 bm18-20020a0568081a9200b003a36cb2d5bfmr11333219oib.4.1693259798291; 
 Mon, 28 Aug 2023 14:56:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a0568080b2800b003a7527207b5sm3856298oij.7.2023.08.28.14.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 14:56:37 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 2/8] doc: Add gpt command documentation
Date: Mon, 28 Aug 2023 15:56:09 -0600
Message-Id: <20230828215623.3727536-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230828215623.3727536-1-JPEWhacker@gmail.com>
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
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
2.33.0

