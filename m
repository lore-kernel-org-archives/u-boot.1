Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17CFC27C75
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 22:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DDD388971;
	Fri, 14 Jun 2024 00:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QuRucRAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A05B87D33; Fri, 14 Jun 2024 00:02:21 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75EA488955
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 00:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57c73a3b3d7so1579767a12.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 15:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718316139; x=1718920939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdFbdU6GWGYmnYvS7/op1cLVVAsMUENYd4EAmvNfac4=;
 b=QuRucRAH6ClBOpHMf1pTQWWGV/XpavWQ+CniSdzCnRqs9AZg0cvuLP4FHOjvDZ9GQo
 QTiai++ZEG2rRvNwaQWrs6lwKQ0UliN0uyH78rzOZy/8dYr+bCzzrfuxmq8gY7G+BGkt
 f9w5D3J7vdTGewgWZKEPfxum/W6zSbQvbmiijGxUoly361N1KE6LKpkRQ8VKbFioie3R
 T+/5XFu3jWmxWnif39dvkMIOt220NBjsp4t9NALKqfWpD+j2xffK/wv3SAfCoKxjp3DK
 9Gjebd6AH006RwugmmX+j61XJKGWyzkzvoRj2ZbOlz2Md61q1AhwKSgZGShSeLFdht5c
 tOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718316139; x=1718920939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdFbdU6GWGYmnYvS7/op1cLVVAsMUENYd4EAmvNfac4=;
 b=IHMTQ77bfqf4xJ77pkemDBIJOK3OlZULRpdR4utdeXXQu9sAbAx1GTZyu0cKT1lBUs
 YGSSpaK0wUXQ4uCuGddCy9qB7/uHMz6BhLY5QkIC0Zl9VMJguJxtXUmOUYHdRn0mM2sP
 ldPv4p9wLkn5KlOUi6V1sz8ZLyaQ/rX7UvP6LVIVubcPBA7qVHKrexhcCt1fPZ2XvPTA
 M8Te0lakot4FAz2tHJ4sT87NP6PLE2Jrm1iTWy4jRPaVwTxBKRbo8CKb+1HGzGLuGdm3
 F7nwrEbYsTT8FXKL4N8XXD2x9e9bi/P3r1aoiSeyIDR6J3uqLO7KzzzhWfL8RmqC11i6
 WAAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXYGRnM7Q3fj70U//dWPe849leskmzQphYo8qV4EyuDeCBSyLz5NEFfQ++eBMVw6EnMmmN33vxf4wuR53qUE8JtG7F9A==
X-Gm-Message-State: AOJu0YyQedyazV+F+vLv9T9R7E4t3+leVifBQ4/mlkRKCjT6eD7kARJK
 nr1zjKKuPa7IoAt0TY84reJEEizbZDDjgoCs/YtEBq+e9AkcU4gR
X-Google-Smtp-Source: AGHT+IF/v5UOh5HCxWmIkvUadINH44yxH65Eiwy3YuW4pi020FgAFIoQTko2Z+Ien4woJ3R2jDHSMw==
X-Received: by 2002:aa7:d791:0:b0:57c:bf7e:f3e9 with SMTP id
 4fb4d7f45d1cf-57cbf7ef667mr148439a12.14.1718316138555; 
 Thu, 13 Jun 2024 15:02:18 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c633:5ca4:b5e1:26ba])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72cdffcsm1412473a12.6.2024.06.13.15.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 15:02:18 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vasileios.amoiridis@cern.ch, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 2/2] doc: api: bootcount: Convert to rST documentation
Date: Fri, 14 Jun 2024 00:02:12 +0200
Message-Id: <20240613220212.37078-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613220212.37078-1-vassilisamir@gmail.com>
References: <20240613220212.37078-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Jun 2024 00:04:20 +0200
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

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 doc/README.bootcount  | 53 ---------------------------------------
 doc/api/bootcount.rst | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 53 deletions(-)
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
-- 
2.25.1

