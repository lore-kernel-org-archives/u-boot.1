Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBDBC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 19:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43DC186AF8;
	Fri, 25 Aug 2023 21:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UvY20lj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44AC286AF6; Fri, 25 Aug 2023 21:38:47 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2ADA86AF8
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 21:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bdcbde9676so982195a34.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692992320; x=1693597120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXfbPqhrQmdWuZEcoGaoexV06rmyHym7jQYYsi7SQ+U=;
 b=UvY20lj3k0FDyrohP/oSmbiWIYMgdxovFatlaX3qiXj3gfUgKVREyU/30sals80EAG
 V7v1wGQ+lWhbMWyVUQc6OUqafOd8M/k2WccCNMJaIzYVJ/Qi8dWPJwigcZRBZ2ovZAbu
 /xcdVcJbkWmOtjOKkdcUrI679hk13C7B4AFrZZ3t6A9dY7wQau3PyAsJu9d7aomA6zL6
 EqZhs0O06gdSbRVMBAgDbKuGsDMtJbeQDOpuHT6Jh7wWtY0oHfe8gJ96tKYHlrEO7KbC
 EF9uXdjD1jYG6+NtorUc/FJTlPn8WSI2Nz+nq8RdNKNX3/1mME4jcdxLN4gpyOyFKhbk
 pZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692992320; x=1693597120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXfbPqhrQmdWuZEcoGaoexV06rmyHym7jQYYsi7SQ+U=;
 b=dPrMm+l9HXKgYq0B7omLnco/ytL7b6y8wa7I2g4cApfwXAYyW41bQ5e2wYhuWIq23T
 6DvV5KJ6+/Asw8R8dh2A9fnE5oIJtWxLGNcWZaseEw9bjpMxLU+hrD9tx33Q795oxAp4
 Ehaa3gPJFq55GYlSRkKV9pujBms4h8gSF79bxofL/qVUNMj1O5dmV0yOHdYr8yasi/Af
 83orfpyBaOEdvSxlQ+CbikphFPcBOqSqMmYey/HKfqMQglnA+yF+z26/X/Lm52pZlQ3F
 AWcwOaDhdGqsX59GDeXLI49R1usY9F43ph/Q2pHHg5GBHEDzKHQfPHYAG0dwo/dxFPRB
 2HAA==
X-Gm-Message-State: AOJu0YybNLXrYUil5P+ic4pXIK7PbVQ9GtpCYU9ITaD+Q0ba0BzMLGYK
 4cu5U53JfhKDqhOa7v11eJfYUvZsVgQ=
X-Google-Smtp-Source: AGHT+IGX3yI8rjHLxzV5eonnYqz3pTimIZbWolMyi1qhkeXlV86Vy0kHQ8YmcdvRsKQdeepp6qMyyQ==
X-Received: by 2002:a9d:6b94:0:b0:6bd:7d0:4f23 with SMTP id
 b20-20020a9d6b94000000b006bd07d04f23mr6708728otq.20.1692992320511; 
 Fri, 25 Aug 2023 12:38:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a9d7e8d000000b006b871010cb1sm1171022otp.46.2023.08.25.12.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 12:38:39 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 2/8] doc: Add gpt command documentation
Date: Fri, 25 Aug 2023 13:38:18 -0600
Message-Id: <20230825193830.2753640-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230825193830.2753640-1-JPEWhacker@gmail.com>
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
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
 doc/usage/cmd/gpt.rst | 141 ++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst   |   1 +
 2 files changed, 142 insertions(+)
 create mode 100644 doc/usage/cmd/gpt.rst

diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
new file mode 100644
index 0000000000..f6e082fb94
--- /dev/null
+++ b/doc/usage/cmd/gpt.rst
@@ -0,0 +1,141 @@
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
+    gpt repair <interface> <device no>
+    gpt write <interface> <device no> <partition string>
+    gpt verify <interface> <device no> <partition string>
+    gpt setenv <interface> <device no> <partition name>
+    gpt enumerate <interface> <device no>
+    gpt guid <interface> <device no> [<varname>]
+    gpt read <interface> <device no> [<varname>]
+    gpt swap <interface> <dev> <name1> <name2>
+    gpt rename <interface> <dev> <part> <name>
+
+Description
+-----------
+
+The gpt command lets users read, create, modify, or verify the GPT (GUID
+Partition Table) partition layout.
+
+The syntax of the text description of the partition list is similar to
+the one used by the 'mbr' command. The string contains one or more partition
+descriptors, each separated by a ";". Each descriptor contains one or more
+fields, with each field separated by a ",". Fields are either of the form
+"key=value" to set a specific value, or simple "flag" to set a boolean flag
+
+The first descriptor can optionally be used to describe parameters for the
+whole disk with the following fields:
+
+* uuid_disk=UUID - Set the UUID for the disk
+
+Partition descriptors can have the following fields:
+* name=NAME - The partition name, required
+* start=BYTES - The partition start offset in bytes, required
+* size=BYTES - The partition size, in bytes or "-" to expand it to the whole free area
+* bootable - Set the legacy bootable flag
+* uuid=UUID - Set the partition UUID, optional if CONFIG_RANDOM_UUID=y is enabled
+* type=UUID - Set the partition type GUID, requires CONFIG_PARTITION_TYPE_GUID=y
+
+Here is an example how to create a 6 partitions, some of the predefined sizes:
+
+::
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
+If 'uuid' is not specified, but CONFIG_RANDOM_UUID is enabled, a random UUID
+will be generated for the partition
+
+The 'gpt verify' command returns 0 if the layout matches the one on the storage
+device or 1 if not. To check if the layout on the MMC #0 storage device
+matches the provided text description one has to issue following command:
+
+::
+
+    => gpt verify mmc 0 $gpt_parts
+
+The verify sub-command is especially useful in the system update scripts:
+
+::
+
+    => if gpt verify mmc 0 $gpt_parts; then
+         echo GPT layout needs to be updated
+         ...
+       fi
+
+The 'gpt write' command returns 0 on success write or 1 on failure.
+
+The 'gpt setenv' command will set a series of environment variables with
+information about a particular partition. The variables are:
+
+* gpt_partition_addr (the starting offset of the partition, in hexadecimal blocks)
+* gpt_partition_size (the size of the partition, in hexadecimal blocks)
+* gpt_partition_name (the name of the partition)
+* gpt_partition_entry (the partition number in the table, e.g. 1, 2, 3, etc.)
+
+To get the information about the partition named 'rootfs', issue the following
+command:
+
+::
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
+The 'gpt enumerate' command will set the variable 'gpt_partition_list' with the
+list of partition names on the device. For example:
+
+::
+    => gpt enumerate
+    => echo gpt_partition_list
+    boot rootfs system-data [ext] user modules ramdisk
+
+The 'gpt guid' command will report the GUID of a disk. If 'varname' is
+specified, the command will set the variable to the GUID, otherwise it will be
+printed out. For example:
+
+::
+    => gpt guid mmc 0
+    bec9fc2a-86c1-483d-8a0e-0109732277d7
+    => gpt guid mmc gpt_disk_uuid
+    => echo ${gpt_disk_uuid}
+    bec9fc2a-86c1-483d-8a0e-0109732277d7
+
+The 'gpt read' command will print out the current state of the GPT partition
+table. If 'varname' is specified, the variable will be filled with a partition
+string as described above that is suitable for passing to other 'gpt' commands.
+If omitted, a human readable description is printed out.
+CONFIG_CMD_GPT_RENAME=y is required.
+
+The 'gpt swap' command changes the names of all partitions that are named
+'name1' to be 'name2', and all partitions named 'name2' to be 'name1'.
+CONFIG_CMD_GPT_RENAME=y is required.
+
+The 'gpt rename' command renames all partitions named 'part' to be 'name1'.
+CONFIG_CMD_GPT_RENAME=y is required.
+
+Configuration
+-------------
+
+To use the 'gpt' command you must specify CONFIG_CMD_GPT=y. To enable 'gpt
+read', 'gpt swap' and 'gpt rename', you must specify CONFIG_CMD_GPT_RENAME=y.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 3326ec82ff..4bfaabbd16 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -65,6 +65,7 @@ Shell commands
    cmd/for
    cmd/fwu_mdata
    cmd/gpio
+   cmd/gpt
    cmd/host
    cmd/imxtract
    cmd/load
-- 
2.33.0

