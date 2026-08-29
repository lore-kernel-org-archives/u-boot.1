Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860BBC61DCB
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 19:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5491F60631;
	Sat, 29 Aug 2026 19:21:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SqpRyZBmgM6A; Sat, 29 Aug 2026 19:21:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788031309;
	bh=5UhbcLL8av2D1uMewEDVySnCIZuCS552Vv+WO0QEfrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NBsVAxS8lVYSClGUmwuO0IOH/ToPZ42tnNAUcD242/nSmpW7WiLT/09L8Zse9vynm
	 uZ9LBZK3NvM0/7kUto3fe2G6D8Tyzn4UJ7UIwbWUEns+3DklwWufUYxuiAHbO5QlDU
	 UxffasC1Co3x5vkk7JdYRNPktpEpnn3Q/OpQ2agMO+wUhxV9i/DbkBRMz7PfnEIH3S
	 qEPO12GIRRdg9DoUd9sTwbr6zANuFAIW/RSbKwkg0tuV48w636eNgGlZpcKbntsTDu
	 nS2QTM+sICRcAk83kaklym1OUmq3TUrBURGJUYGNEDZopj7SO8dBqLN7akVqUzsAdK
	 Q4MNoliWISpUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D51C60621;
	Sat, 29 Aug 2026 19:21:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E049B127
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C67B960621
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 01L8od9XsjMr for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 19:21:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=go8cePbZ
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC29960627
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:47 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so2430780a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788031307; x=1788636107;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5UhbcLL8av2D1uMewEDVySnCIZuCS552Vv+WO0QEfrk=;
 b=go8cePbZNFsOO7/0YgBO82Nv8oKdgiItKyKnGlpe4uy24YlxK8ZmleZ1hSsVjTKv1U
 vwWhm8X/E6yy0v14JDuy1ZIIymGLUxANzNlEJ+iQQXyH6vLC43m1WH0zRloG8Evwz/RY
 5fqKxBTXwrWEOCvQnDuFh/2JK7CbiNsLUpWJoNzGxHIUk/3q8FoX2NcbhXzqLOkh/KDj
 XPWiUME5doRV6noBqspv9/gTuK9D2AXWpcNo0ArFlGlKfKhvJiBceKA4JHKDZ55Rdp/X
 ji4AIZJ8R6et6+P+hHgRpEdKzfzpFAm8/HWzL3Fs5iLs1z3zmPEg7UmGZbvcPd+LRjRv
 miGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031307; x=1788636107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5UhbcLL8av2D1uMewEDVySnCIZuCS552Vv+WO0QEfrk=;
 b=LV6zeH84mGZFhwd8Slea1cE40RzfzgiHU/gdOznMmdX/EdlIjM4Z69Grc7Xsbl2ggA
 f7vBUJTrOvduUGxLC1g1lCcaviKtM95HkWDI3ELQElY3R7+PYGNDLJTkAMvOHQleWcIt
 J19R9wkv2hf5Jt3zD3g6EXlJVnhrJHqcy2bbzH65sdAExlmWygdwVaVLinzM9xDXRc0C
 64nVSzBHDYawGMk7cyncF6YIqrJ3H0BcmdKTskBD6tVvE/cFRimuQ+skvdGwaz5Phmmk
 KeEJHsMK3l+c2zmHh/biWdbRjKHUfSIwXMe/IFDPIyZzeiLh2oZe0hfMO6AqAYoR/ZPE
 sA+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjDOEjNU8kge+mtBgJpYGmzHtDoH/5m/4iPCaCr9yozgWalR1WP4vbLUV8/cys4fHOGdhe50o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l2xctMMCFRVphKE9kxO3HqvOceVu1NF6vzddeoO3PRpQkB9J/O
 l9pnrCztgQTZYHt8vQEFG301stUhlAMjDUWKKaYoi6JZTkOoT20RHbp+
X-Gm-Gg: AYBFou3nCIR5gCHp18r4nUkurI1lTRLFt2olmZDMyUpozaiqPDwrF4he9Ckelij1Xpy
 83FK0bIYgG7CfEHwH0rsSrOl0YMSKhteF+xIB6t8bvm30jsvPqG4d4Yf/cxWyeL6lMFmL31Ktlc
 OQu4t9U88ppQZB9eRyl9RkacnUZIkDLWow79nEsPyfi5VaE86HIkgkqAhNvZihC7hVLNzlcgg5V
 eA2HonkTddpANd8F8oHD56BuOogzrERO3OkEYMYi5ouWtAbLFMzae6vEQMCSAVXb8U23NBnpDNC
 zwrJ/Kdl+Hd6yLRBd3jeD4ZVMQWUU5pZRH9r3Y0uT35nk+r6yfE23BUiAQU0E6LaOZOIp/Ys+ji
 t7oqqsziir3P83xiExT1FuiYT18Q1cVsU7kHrmmYyY33knTALBf5XItfec2aNSMsXrPH68FMjTK
 Cf4jQC9cuQqi/Qd+0Xy9Us1I1S1PSdf6JSRPilRy8aVQIvMRi1FEZyuBq9E+grwgU/wTgmQmR+C
 9kExSG+hV5k3fIlKyhBALLmA/EJsrBFrDp7Cn7ZK2H/Kan987DZ0UXoEAcsDOsAVw==
X-Received: by 2002:a17:90b:2c87:b0:398:c9be:cca8 with SMTP id
 98e67ed59e1d1-398c9bed0c2mr209349a91.2.1788031307020; 
 Sat, 29 Aug 2026 12:21:47 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (184.247.229.35.bc.googleusercontent.com. [35.229.247.184])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm12837034a91.4.2026.08.29.12.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 12:21:46 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 4/6] doc: 9p: Add 9P filesystem documentation
Date: Sat, 29 Aug 2026 19:21:17 +0000
Message-ID: <20260829192119.2658328-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260829192119.2658328-1-visitorckw@gmail.com>
References: <20260829192119.2658328-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add documentation for 9P filesystem support, including configuration
options, QEMU configuration, and basic usage examples.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 doc/usage/filesystems/9p.rst | 55 ++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst          |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 doc/usage/filesystems/9p.rst

diff --git a/doc/usage/filesystems/9p.rst b/doc/usage/filesystems/9p.rst
new file mode 100644
index 00000000000..ca44b74de12
--- /dev/null
+++ b/doc/usage/filesystems/9p.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+9P Filesystem
+=============
+
+The 9P filesystem is a network-based file sharing protocol. It is primarily
+used to share files between a host and a guest over virtio, providing a way
+to load kernels, device trees, and initial ramdisks without needing a disk
+image or networking setup like TFTP.
+
+Configuration
+-------------
+
+To enable the 9P filesystem support, you must enable the following configuration
+options:
+
+* ``CONFIG_FS_9P``: Enables the 9P filesystem layer.
+* ``CONFIG_NET_9P``: Enables the core 9P2000.L client protocol.
+* ``CONFIG_VIRTIO_9P``: Enables the virtio transport driver for 9P.
+
+QEMU Setup
+----------
+
+To use 9P with QEMU, you need to expose a host directory to the guest using
+the ``-fsdev`` and ``-device`` parameters.
+
+For example, to share the host's `/tmp/shared` directory with the guest under
+the mount tag `rootfs`:
+
+.. code-block:: bash
+
+    qemu-system-aarch64 \
+        -machine virt \
+        -nographic \
+        -fsdev local,id=fsdev0,path=/tmp/shared,security_model=none \
+        -device virtio-9p-device,fsdev=fsdev0,mount_tag=rootfs
+
+U-Boot Usage
+------------
+
+Once booted into U-Boot, you must first probe the virtio subsystem. You can then
+access the 9P filesystem using the ``9p`` interface name. You can specify a mount tag
+(such as ``rootfs``), a device index (such as ``0``), or use ``-`` to select the
+default (first) device.
+
+.. code-block:: bash
+
+    => virtio scan
+    => ls 9p rootfs /
+    => ls 9p 0 /
+    => ls 9p - /
+    => load 9p rootfs $kernel_addr_r /Image
+    => load 9p rootfs $ramdisk_addr_r /initramfs.cpio
+    => booti $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 6f477b842ca..6d7ca6b9aec 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -46,3 +46,4 @@ File Systems
    :maxdepth: 1
 
    filesystems/ext4
+   filesystems/9p
-- 
2.55.0.897.gb25b4bd76c-goog

