Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38770C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A3B88258;
	Sun, 23 Jun 2024 19:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TGn/r58a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 749DC88271; Sun, 23 Jun 2024 19:40:38 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4378587702
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b9794dad09so1700635eaf.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719164435; x=1719769235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8InBjfnxc5wqh+h8OZBtf+EvRzipSbRBw0bwBqkAbUw=;
 b=TGn/r58asDUvwRSqvx7i3dSTFmSIFn1cXx10iB52bTixWTS65vbOSJTehJj8j6N1pE
 6L2F22760MN6SdD7aDKr594voAlIVv/vG/5pwPSuhtXrqNGdlNT1d3nnOTVRP08upT6W
 XSjffj8sFOuij1Q6mcAmanC2T/M7Mgger0TSA3fBuSAQlFJX8/ofjDkjvhjgK+RXvLRZ
 uTz9iW+Sh+ZPqZXLEP7rJZzN2YceM/SK5mEycT9SzueIT8cm09anlgi7Vhy2cRbAM8Ix
 H1A5a6Qgw8lc8EvwQZGzpfQnuEuT9HqY7YxX4xBZ8xoOtLiqHfNqxsF+mx0cT2Z8x2rD
 S2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719164435; x=1719769235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8InBjfnxc5wqh+h8OZBtf+EvRzipSbRBw0bwBqkAbUw=;
 b=KcfiNzMgFoDnamgUlO6bx1o5JkR7WmoYIyXb0BC6Jaa0WfyKHqG1wSiGkn3g/f+VfB
 G6dzm9ZR+xbuX2XuTDUvXGoIkJIs7yA7rmUmGIK/1vya9NaTU0zvQN1P7TDlWMYk6J5C
 HqtYNXO/lR7XajxJJECVWD1yGEcCXvfVdd12rfHMMfMVPnCsp45OB9XxeRKZiDi9Ij+e
 Vc5oe5FrcOxItK50d2dU4tVHnmwZmY2s0T1hs7ZgUKhVMqToEKDMsST8r3rTTlyk2xpq
 4IpfgPYmm/UaY47bziR45JhTAZYg1r/77wMBgStQC2v+4BdCVOkAsvpstUcwfegB4tAt
 nqjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEr7o6Wea4TAnBgHGuST7+OBWBQkGtCXQm4s1evPXSGuDXROFBHWk+9VU/cH1ujMn/3Gy58bZ7jb4PlrJb9gd+WUG01Q==
X-Gm-Message-State: AOJu0Yw5EkDI9Z+c24gGsr67r5Z/ZPv8G7vtHSZGj3qSzzzU3CyfpfZT
 Eb4O1LpWpy/PBKNzntIj7FOU3OO3FMQHpinllL82aP74jUtKxnwZ
X-Google-Smtp-Source: AGHT+IHTeXiWvAHBK0LXdhBElZN1gYBVv2RdLO4Q503RiyhIpRHxxVoqK3zMYUQJCXqpQ+PmGRC+GQ==
X-Received: by 2002:a05:6358:3113:b0:1a2:59e:e887 with SMTP id
 e5c5f4694b2df-1a2389a51c4mr445481255d.7.1719164434706; 
 Sun, 23 Jun 2024 10:40:34 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716baf4c053sm4166016a12.78.2024.06.23.10.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:40:34 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH] Fix Kconfig coding style from spaces to tab
Date: Sun, 23 Jun 2024 23:10:21 +0530
Message-ID: <20240623174021.15247-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
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

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 boot/Kconfig |  8 ++++----
 cmd/Kconfig  | 20 ++++++++++----------
 disk/Kconfig |  2 +-
 lib/Kconfig  |  2 +-
 net/Kconfig  |  4 ++--
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 6f3096c15a..12148ac3f2 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -150,10 +150,10 @@ config FIT_IMAGE_POST_PROCESS
 	  processed before being added to the FIT image).
 
 config FIT_PRINT
-        bool "Support FIT printing"
-        default y
-        help
-          Support printing the content of the fitImage in a verbose manner.
+	bool "Support FIT printing"
+	default y
+	help
+	  Support printing the content of the fitImage in a verbose manner.
 
 config SPL_FIT
 	bool "Support Flattened Image Tree within SPL"
diff --git a/cmd/Kconfig b/cmd/Kconfig
index b026439c77..011f4ad429 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -271,7 +271,7 @@ config CMD_BOOTM_PRE_LOAD
        depends on CMD_BOOTM
        depends on IMAGE_PRE_LOAD
        help
-         Enable support of stage pre-load for the bootm command.
+	 Enable support of stage pre-load for the bootm command.
 	 This stage allow to check or modify the image provided
 	 to the bootm command.
 
@@ -897,9 +897,9 @@ config CMD_MX_CYCLIC
 	bool "Enable cyclic md/mw commands"
 	depends on CMD_MEMORY
 	help
-          Add the "mdc" and "mwc" memory commands. These are cyclic
-          "md/mw" commands.
-          Examples:
+	  Add the "mdc" and "mwc" memory commands. These are cyclic
+	  "md/mw" commands.
+	  Examples:
 
 	  => mdc.b 10 4 500
 	  This command will print 4 bytes (10,11,12,13) each 500 ms.
@@ -2150,12 +2150,12 @@ config CMD_BLKMAP
 
 	  Example use-cases:
 	  - Treat a region of RAM as a block device, i.e. a RAM disk. This let's
-            you extract files from filesystem images stored in RAM (perhaps as a
-            result of a TFTP transfer).
+	    you extract files from filesystem images stored in RAM (perhaps as a
+	    result of a TFTP transfer).
 	  - Create a virtual partition on an existing device. This let's you
-            access filesystems that aren't stored at an exact partition
-            boundary. A common example is a filesystem image embedded in an FIT
-            image.
+	    access filesystems that aren't stored at an exact partition
+	    boundary. A common example is a filesystem image embedded in an FIT
+	    image.
 
 config CMD_BUTTON
 	bool "button"
@@ -2934,7 +2934,7 @@ config CMD_UBI_RENAME
        bool "Enable rename"
        depends on CMD_UBI
        help
-         Enable a "ubi" command to rename ubi volume:
+	 Enable a "ubi" command to rename ubi volume:
 	   ubi rename <oldname> <newname>
 
 config CMD_UBIFS
diff --git a/disk/Kconfig b/disk/Kconfig
index 8549695807..ffa835eb35 100644
--- a/disk/Kconfig
+++ b/disk/Kconfig
@@ -116,7 +116,7 @@ config EFI_PARTITION_ENTRIES_NUMBERS
 	  number.
 
 config EFI_PARTITION_ENTRIES_OFF
-        int "Offset (in bytes) of the EFI partition entries"
+	int "Offset (in bytes) of the EFI partition entries"
 	depends on EFI_PARTITION
 	default 0
 	help
diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31a..b8e4f516f9 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1143,7 +1143,7 @@ config PHANDLE_CHECK_SEQ
 	bool "Enable phandle check while getting sequence number"
 	help
 	  When there are multiple device tree nodes with same name,
-          enable this config option to distinguish them using
+	  enable this config option to distinguish them using
 	  phandles in fdtdec_get_alias_seq() function.
 
 endmenu
diff --git a/net/Kconfig b/net/Kconfig
index 5dff633629..7cb80b880a 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -42,8 +42,8 @@ config BOOTP_SEND_HOSTNAME
 	  DNS server. To do this, they need the hostname of the DHCP
 	  requester.
 	  If CONFIG_BOOTP_SEND_HOSTNAME is defined, the content
-          of the "hostname" environment variable is passed as
-          option 12 to the DHCP server.
+	  of the "hostname" environment variable is passed as
+	  option 12 to the DHCP server.
 
 config NET_RANDOM_ETHADDR
 	bool "Random ethaddr if unset"
-- 
2.44.0

