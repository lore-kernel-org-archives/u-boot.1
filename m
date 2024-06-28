Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B10C2BD09
	for <u-boot@archiver.kernel.org>; Sat, 29 Jun 2024 01:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45A5885CE;
	Sat, 29 Jun 2024 03:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Exq9HBtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 978AC88581; Fri, 28 Jun 2024 19:35:51 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704778859F
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7252bfe773so101525866b.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596149; x=1720200949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K77ex8tsI5XTk7QXNQuTCYQM0QaztWhh8z12mcaMuEE=;
 b=Exq9HBtBuzpEVTR9kOLbsrxajX363JxyxLKsK7/i3pZ82g5EMcqAS7CtdUbxPgucq+
 GAZtt/U6BqtLvrfq6c12NToQweYYf9y+4tWWDxfqe/BpExn573KmHCx4rOSqXUlyQ+HY
 MwyvIqKTp5z6d4IjH6ahvjTY1k2cN1bI+HpUbbKRJjZiLnpsG+e+focWrLc8zuMWL7DY
 s5r+eW4fOWmcT7JezbP3KAszzrGKciwWPThcbA7L9TMn8afkdoLPiM5yyCgeQiFdw78D
 TQgYznfgeXdtLYUlVPXjm8zV6wP07YzFo5HOaA6Q3T+J7iX6kv9R7fnf/YfEkW+0ZFWs
 HTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596149; x=1720200949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K77ex8tsI5XTk7QXNQuTCYQM0QaztWhh8z12mcaMuEE=;
 b=FumWxkq1OmTrBLVHZi7Cr7m7y8i3aumDXtAn8fJV6mdStUxjdKjBVttS0QiIQUsTry
 iKX5KHTAPPvK+QYkONiKgdDltRU/6TjG3WK24M/QrhYFh9Ol5XKVvSYFasrdVpi7hoNd
 zlnSP9lka/szG+fR81PAzLy3V927/cAMlFpHFQnAPUHv6KwEEOJceAut/yj7GMlpS0C3
 aVqI+W6OIWWptSP7JBIfL4v4j/N+PX0A2j0Y+9Tij/80K2XzCwLX9DbZUPCw6QIscbbe
 5RPxaxyeX6kMR9DSeEVO4xJZRiJk7rrzOWrSSEOkU9wSoONedZn8v3D/kwKfPH7AKa35
 wd/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUExoQOgLCJvFMG+ToeSaJGdAG3Uye9YI3Cxf5IkpG5lbd8Sq44b7pyZO50ou2l69nYTCK+TOci08VAcdW7URfhP3AYeA==
X-Gm-Message-State: AOJu0Yy34n6GvsHakmiUAa6P3Wu7F5hPcZ/eP9Jl3G9kw3vtoiQet/6J
 7xjjqNMk8sDeRJzsS8+5Tl1BPtjnnBQZ2kD3LoYQZbjCuofSD1xS1pSP5CCxbLw=
X-Google-Smtp-Source: AGHT+IGjA1myRaIzNbrRBWzxo0YvW8l2wDLoI0C5xTcvuUTRGsLXnva8p/OeK2ckp+BcItRDxobx2w==
X-Received: by 2002:a17:907:1c22:b0:a72:9d25:8ad3 with SMTP id
 a640c23a62f3a-a729d258ff1mr479198066b.9.1719596148642; 
 Fri, 28 Jun 2024 10:35:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b996:e85b:4fbf:5c89])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aafb9e4csm96214666b.95.2024.06.28.10.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:35:47 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vassilisamir@gmail.com, quentin.schulz@cherry.de, u-boot@lists.denx.de,
 Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
Subject: [PATCH v4 2/3] doc: api: bootcount: Convert to rST documentation
Date: Fri, 28 Jun 2024 19:35:42 +0200
Message-Id: <20240628173543.129207-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628173543.129207-1-vassilisamir@gmail.com>
References: <20240628173543.129207-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 29 Jun 2024 03:11:20 +0200
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

Move to the new documentation style with rST formatting.

Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
---
 doc/README.bootcount  | 53 ---------------------------------------
 doc/api/bootcount.rst | 58 +++++++++++++++++++++++++++++++++++++++++++
 doc/api/index.rst     |  1 +
 3 files changed, 59 insertions(+), 53 deletions(-)
 delete mode 100644 doc/README.bootcount
 create mode 100644 doc/api/bootcount.rst

diff --git a/doc/README.bootcount b/doc/README.bootcount
deleted file mode 100644
index 0f4ffb6828..0000000000
--- a/doc/README.bootcount
+++ /dev/null
@@ -1,53 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-
-Boot Count Limit
-================
-
-This is enabled by CONFIG_BOOTCOUNT_LIMIT.
-
-This allows to detect multiple failed attempts to boot Linux.
-
-After a power-on reset, the "bootcount" variable will be initialized to 1, and
-each reboot will increment the value by 1.
-
-If, after a reboot, the new value of "bootcount" exceeds the value of
-"bootlimit", then instead of the standard boot action (executing the contents of
-"bootcmd"), an alternate boot action will be performed, and the contents of
-"altbootcmd" will be executed.
-
-If the variable "bootlimit" is not defined in the environment, the Boot Count
-Limit feature is disabled. If it is enabled, but "altbootcmd" is not defined,
-then U-Boot will drop into interactive mode and remain there.
-
-It is the responsibility of some application code (typically a Linux
-application) to reset the variable "bootcount" to 0 when the system booted
-successfully, thus allowing for more boot cycles.
-
-CONFIG_BOOTCOUNT_FS
---------------------
-
-This adds support for maintaining boot count in a file on a filesystem.
-Supported filesystems are FAT and EXT. The file to use is defined by:
-
-CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
-CONFIG_SYS_BOOTCOUNT_FS_DEVPART
-CONFIG_SYS_BOOTCOUNT_FS_NAME
-
-The format of the file is:
-
-==== =================
-type entry
-==== =================
-u8   magic
-u8   version
-u8   bootcount
-u8   upgrade_available
-==== =================
-
-To prevent unattended usage of "altbootcmd", the "upgrade_available" variable is
-used.
-If "upgrade_available" is 0, "bootcount" is not saved.
-If "upgrade_available" is 1, "bootcount" is saved.
-So a userspace application should take care of setting the "upgrade_available"
-and "bootcount" variables to 0, if the system boots successfully.
-This also avoids writing the "bootcount" information on all reboots.
diff --git a/doc/api/bootcount.rst b/doc/api/bootcount.rst
new file mode 100644
index 0000000000..9435a7ef15
--- /dev/null
+++ b/doc/api/bootcount.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Boot Count Limit
+================
+
+This is enabled by CONFIG_BOOTCOUNT_LIMIT.
+
+This allows to detect multiple failed attempts to boot Linux.
+
+After a power-on reset, the ``bootcount`` variable will be initialized to 1, and
+each reboot will increment the value by 1.
+
+If, after a reboot, the new value of ``bootcount`` exceeds the value of
+``bootlimit``, then instead of the standard boot action (executing the contents
+of ``bootcmd``), an alternate boot action will be performed, and the contents of
+``altbootcmd`` will be executed.
+
+If the variable ``bootlimit`` is not defined in the environment, the Boot Count
+Limit feature is disabled. If it is enabled, but ``altbootcmd`` is not defined,
+then U-Boot will drop into interactive mode and remain there.
+
+It is the responsibility of some application code (typically a Linux
+application) to reset the variable ``bootcount`` to 0 when the system booted
+successfully, thus allowing for more boot cycles.
+
+CONFIG_BOOTCOUNT_FS
+--------------------
+
+This adds support for maintaining boot count in a file on a filesystem.
+Tested filesystems are FAT and EXT. The file to use is defined by:
+
+CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
+CONFIG_SYS_BOOTCOUNT_FS_DEVPART
+CONFIG_SYS_BOOTCOUNT_FS_NAME
+
+The format of the file is:
+
+.. list-table::
+   :header-rows: 1
+
+   * - type
+     - entry
+   * - u8
+     - magic
+   * - u8
+     - version
+   * - u8
+     - bootcount
+   * - u8
+     - upgrade_available
+
+To prevent unattended usage of ``altbootcmd``, the ``upgrade_available``
+variable is used.
+If ``upgrade_available`` is 0, ``bootcount`` is not saved.
+If ``upgrade_available`` is 1, ``bootcount`` is saved.
+So a userspace application should take care of setting the ``upgrade_available``
+and ``bootcount`` variables to 0, if the system boots successfully.
+This also avoids writing the ``bootcount`` information on all reboots.
diff --git a/doc/api/index.rst b/doc/api/index.rst
index 51b2013af3..ec0b8adb2c 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -6,6 +6,7 @@ U-Boot API documentation
 .. toctree::
    :maxdepth: 2
 
+   bootcount
    clk
    dfu
    dm
-- 
2.25.1

