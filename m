Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161F3CCD184
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 11:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4372183438;
	Sat, 18 Oct 2025 13:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BUmh6RkU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3945836D1; Sat, 18 Oct 2025 13:08:01 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C93E1807B1
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 13:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2942B3FAEF; 
 Sat, 18 Oct 2025 11:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760785679;
 bh=h0uZrU5lUhpTC02PFqGeUvQgCe7S626pyKWdBC7GaU4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=BUmh6RkU0P356zpzh8b1l0gygxv/j6vYDjA+taKu6OzQr+Qy4BWB8lYydlmX8eiH5
 vtaDy3/JCzmrer6krJxmmk1UxEZH8vohu3EIq/wIu37LKivEQ9RoiDn6SOmZySBVAv
 NeEm66qrpUFMNlvIS/VuwhWmyBDk1wrJuyQjESGU6xY1YzKeWsM21FL4qEBgfHQbVe
 Wp9/gn9iGEqOwLiHnNpOujJXNJNlAnRaiqS+v3Gg+4A1weIKjXg2mkNwhQRweiK3nj
 ZZcOfprT/Ne/rbgm+5AFtl5ClvqXifjnGQJtBontKvwQuoD1y6EXlECn8cvfSVHc73
 Ph/0dkoEbClR50T3MITCrwsBvUbbHDVXVqjVwL/iNNIBSueEZ+ArJJHbTSZwjJgUiJ
 k4IQTYsYeq79yd77V3EMmTAJ3mdrfliFTm1yr2X2TNkT5FVx7QjSpIwNtQRVQtXJRv
 Wz2RvefC3DgfIQeZ7GvpdYYpCy/z9cApRF8mhO0z80/ry1R/+P76SkBzM+USnWF9nV
 AK4/gAjz5sDfKBNr5VTBrhL2EsBX6Vgu4ZH5DcMYP21VQxG52+EzGj8f6tgV1N7lQr
 kxl7CKk7H9Jqij3JxAXSTxgfuYQ4xKLJkTx+slb5LibvTYe6l0KG2iNTQKihjdu/it
 lq2cg+flyr71cIz16zXiA7fk=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: separate read and write command documentation
Date: Sat, 18 Oct 2025 13:07:44 +0200
Message-ID: <20251018110744.53188-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

* Avoid two step navigation to get to the description of the write command.
* Add missing index entries
* Correct formatting of the examples.
* Describe configuration and return value.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/read.rst  | 39 ++++++++++++++++++++++-----------------
 doc/usage/cmd/write.rst | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/doc/usage/cmd/read.rst b/doc/usage/cmd/read.rst
index 840846728fc..9045a7e7e31 100644
--- a/doc/usage/cmd/read.rst
+++ b/doc/usage/cmd/read.rst
@@ -1,7 +1,10 @@
-.. SPDX-License-Identifier: GPL-2.0-or-later:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
-read and write commands
-=======================
+.. index::
+   single: read (command)
+
+read command
+============
 
 Synopsis
 --------
@@ -9,14 +12,12 @@ Synopsis
 ::
 
     read <interface> <dev[:part|#partname]> <addr> <blk#> <cnt>
-    write <interface> <dev[:part|#partname]> <addr> <blk#> <cnt>
 
-The read and write commands can be used for raw access to data in
-block devices (or partitions therein), i.e. without going through a
-file system.
+Description
+-----------
 
-read
-----
+The read command can be used for raw reading data from a block device
+(or a partition therein), i.e. without going through a file system.
 
 The block device is specified using the <interface> (e.g. "mmc") and
 <dev> parameters. If the block device has a partition table, one can
@@ -25,20 +26,24 @@ partition name (using the #partname syntax). The command then reads
 the <cnt> blocks of data starting at block number <blk#> of the given
 device/partition to the memory address <addr>.
 
-write
------
-
-The write command is completely equivalent to the read command, except
-of course that the transfer direction is reversed.
-
 Examples
 --------
 
+.. code-block:: bash
+
     # Read 2 MiB from partition 3 of mmc device 2 to $loadaddr
     read mmc 2.3 $loadaddr 0 0x1000
 
     # Read 16 MiB from the partition named 'kernel' of mmc device 1 to $loadaddr
     read mmc 1#kernel $loadaddr 0 0x8000
 
-    # Write to the third sector of the partition named 'bootdata' of mmc device 0
-    write mmc 0#bootdata $loadaddr 2 1
+Configuration
+-------------
+
+The read command is only available if CONFIG_CMD_READ=y.
+
+Return value
+------------
+
+The command sets the return value $? to 0 (true) on success or to 1 (false) in
+case of an error.
diff --git a/doc/usage/cmd/write.rst b/doc/usage/cmd/write.rst
index f42dc003dd4..737eb28c069 100644
--- a/doc/usage/cmd/write.rst
+++ b/doc/usage/cmd/write.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0-or-later:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: write (command)
@@ -6,4 +6,41 @@
 write command
 =============
 
-See :doc:`read`.
+Synopsis
+--------
+
+::
+
+    write <interface> <dev[:part|#partname]> <addr> <blk#> <cnt>
+
+Description
+-----------
+
+The write command can be used for raw writing data to a block device
+(or partition therein), i.e. without going through a file system.
+
+The block device is specified using the <interface> (e.g. "mmc") and
+<dev> parameters. If the block device has a partition table, one can
+optionally specify a partition number (using the :part syntax) or
+partition name (using the #partname syntax). The command then reads
+the <cnt> blocks of data starting at block number <blk#> of the given
+device/partition to the memory address <addr>.
+
+Examples
+--------
+
+.. code-block:: bash
+
+    # Write to the third sector of the partition named 'bootdata' of mmc device 0
+    write mmc 0#bootdata $loadaddr 2 1
+
+Configuration
+-------------
+
+The write command is only available if CONFIG_CMD_WRITE=y.
+
+Return value
+------------
+
+The command sets the return value $? to 0 (true) on success and to 1 (false) in
+case of an error.
-- 
2.51.0

