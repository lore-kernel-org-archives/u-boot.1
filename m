Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7684AC79F70
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F0C86478;
	Wed, 23 Aug 2023 18:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A/Dwl6oL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BFA864CE; Wed, 23 Aug 2023 18:48:16 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FAC86467
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6bd77864e05so4132809a34.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692809292; x=1693414092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zihlNu3hTWetIlriJZT0DMq2dEgl0/zdN3h72vE3gEw=;
 b=A/Dwl6oLxiP/322/jn8Kizb92ZA+Z3qwIDn66wkdF8SFFEKWcmuEpw5ff3CMXjwIVg
 NG90AZEmd0k9JNw8nZN6+QH1LYQ+cQJt6v8oHNTAho920iXbVOoTwW4x1uk/SXNL8dIG
 p27I9pMl9yXAGijZj3e0+6g7aiULEMwKOJbZiFokaIzzrjPKxacEs3xhpW38qEIQQJ7Q
 bcxcvEQgboO9BCgIgoTR0p6gmRdQe7N7aven2ztbKWaceXG0ZF/Cqf/bg1srWjRCeQt7
 Ls/FETC0L8OyaMls3kpAAswHgPUVvH3fH+o7NRMM+KFqzMMbgJZyGygFM+fG2loHfDRw
 t+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692809292; x=1693414092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zihlNu3hTWetIlriJZT0DMq2dEgl0/zdN3h72vE3gEw=;
 b=ZELjftF2BIc5zZPiXOeKpmsGt7EvksMIm9oO+Qnjy8qfc+M3qP3oKLqJN8gn9/9Fhu
 RbZpdD/hEi76lHT6wsathD/2yWzte/fkVMT3J2eFmF9s+DLnFe2hBsiTFcp1VQG2uhKh
 ZJQsF+dET1+z3f/TB5q1lYlvOwWgdtQhVcm+GxIW3XLKZSZZlUM7fGAWCt56MDiTEnfk
 lWvAC8iNlSZcGtfIdpPHlZCWgVwWOoaD1ATqRYbMVo3nJLeBsn2OfgyOQwYyht+9oTtJ
 5tbYxX9Avakgmv7UDiuh1ODeVVgtnfSPte/5CAki/xk/eiTO9IncOe0q5h6F6pousnJ0
 DrZw==
X-Gm-Message-State: AOJu0Yw47m8et6+3URJKy/yaTuYIRp13pzSCeYfGMqbzEAfoTJ+McXtC
 +Jv3BP9nxqLwNs0ZNa+9yidscwgmcNw=
X-Google-Smtp-Source: AGHT+IF6Gkqr4HX00h9LBHDfKHyJhFL2Deizp7c7PHtNrfBOlCax3T5bwqa2WHEHnfnc8UFe9GEUYg==
X-Received: by 2002:a9d:631a:0:b0:6bb:1071:ea72 with SMTP id
 q26-20020a9d631a000000b006bb1071ea72mr13409333otk.36.1692809292610; 
 Wed, 23 Aug 2023 09:48:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::751c])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a056830205600b006b9cb784553sm5794042otp.36.2023.08.23.09.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:48:11 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v2 2/8] doc: Add gpt command documentation
Date: Wed, 23 Aug 2023 10:47:38 -0600
Message-Id: <20230823164755.2874792-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230823164755.2874792-1-JPEWhacker@gmail.com>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
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
 doc/usage/cmd/gpt.rst | 139 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 doc/usage/cmd/gpt.rst

diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
new file mode 100644
index 0000000000..ea2cf73a60
--- /dev/null
+++ b/doc/usage/cmd/gpt.rst
@@ -0,0 +1,139 @@
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
+the one used by the 'mbr' command.
+
+The partition list may start with a set of parameters for the whole disk:
+
+* uuid_disk (the UUID of the disk)
+
+Following the disk parameters, partitions are specified separated by a ';'.
+Supported partition parameters are:
+
+* name (required)
+* start (required, partition start offset in bytes)
+* size (in bytes or '-' to expand it to the whole free area)
+* bootable (boolean flag)
+* uuid (partition UUID, optional if CONFIG_RANDOM_UUID=y is enabled)
+* type (partition type GUID, requires CONFIG_PARTITION_TYPE_GUID=y)
+
+Here is an example how to create a 6 partitions, some of the predefined sizes:
+
+::
+
+    => setenv gpt_parts 'uuid_disk=bec9fc2a-86c1-483d-8a0e-0109732277d7;
+        name=boot,start=4M,size=128M,bootable,type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7,
+        name=rootfs,size=3072M,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4;
+        name=system-data,size=512M,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4;
+        name=[ext],size=-,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4;
+        name=user,size=-,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4;
+        name=modules,size=100M,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4;
+        name=ramdisk,size=8M,type=0FC63DAF-8483-4772-8E79-3D69D8477DE4
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
-- 
2.33.0

