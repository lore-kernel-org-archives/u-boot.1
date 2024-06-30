Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFB5C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 14:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A4288629;
	Sun, 30 Jun 2024 16:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X1oOaUIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996F088630; Sun, 30 Jun 2024 16:19:58 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5BDA882B8
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 16:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52cdc4d221eso2269354e87.3
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719757196; x=1720361996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EGLYILj6bAxm+ybso3aEHgB6y8skEMqQSEOAfMaT8Vk=;
 b=X1oOaUIB4NnPxsqZeyUYj1/nfQ0O8arMPuVf0e+mM/V+ZmtpPrsnzSpDAvdtM8wg5I
 +Ja89GMqTSFSpUEWDyLkCknHBXEQGVkQ1zIihMc03XgQfRj1FGN9VgqE6eEYIe+q16hA
 3keFK0Z8ZQ5Dp7wOx1L/zhN/G7GitCNwLM3VwWdqoe5hSzYf3YHUa63mg8P2RI0pM8u1
 BBV9c6Mj6nT2+dvWtQkckOlGRBHv+LgY+qX6L3e+bi24t5E2BdXYUuqP3Ngqi7BKLhGZ
 i7CUdt4VvL2MbcCD8qqDDsDGrDbPKUzDTKIMwiWtQ40b7xZ+2TTk09UMA4CpbeCDhL5l
 1zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719757196; x=1720361996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EGLYILj6bAxm+ybso3aEHgB6y8skEMqQSEOAfMaT8Vk=;
 b=LdA3Zz4nGw8Iq9DWjHnYym+Y35xqBYNQ5sheG5MgQAkxH86vwMh3QR2/BuithMd2Hf
 2gvTK8Tq4JldV9Or2SdnFHXx2kiDUwWxbKOZvstw207NF2nHn7NQukaIL588Q8i9fkIC
 ZAAD1gXjIUicU6ibjJYb9gaCvFbucBoM/5uRNKuokwAGQr92dnwo+1/8a7kmA93G16jH
 CHJn1mRSwT/7FpoR60TfXdZ1AMDcaYPeAteBpjWrBaH7WAFL2UbB8n9Xk9oBhowSxugb
 UmuLcbq8dXkTfZQAD5kBDRtix19M3ILpOpy8RRNgJxNH+kH6YEoNaZRlcTSLGsZjVetf
 6CFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC5NFbnvWygJod0KFfLoKEdqqEvEc19upOKEiXpuK0OMbxSlAUzu8EU+T/cVrlKLyIlwFvMuVZtdo7FLe5qlf1P2gfQw==
X-Gm-Message-State: AOJu0YwA4nBBxV4dKrbnRarxqzc5hRBy70SRLY+AJBxBZBhfpNYupPqO
 tJdpLuXeaWPeyPMhMp5w1zMNFks8AyWTqV6nWA6qyJ35aJamAEVI
X-Google-Smtp-Source: AGHT+IEBtQG2F/Bl2VjZM41V1UOlmqfYPy3IyhxwGgEcNHHpJs7zxl1mPyjinNS8w+HGDTVUw3uukA==
X-Received: by 2002:a05:6512:39d0:b0:52e:6d6e:5770 with SMTP id
 2adb3069b0e04-52e82646839mr2240964e87.14.1719757195619; 
 Sun, 30 Jun 2024 07:19:55 -0700 (PDT)
Received: from localhost.localdomain (109-252-15-116.nat.spd-mgts.ru.
 [109.252.15.116]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab2ea1fsm978657e87.188.2024.06.30.07.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 07:19:55 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: trini@konsulko.com, u-boot@lists.denx.de, sjg@chromium.org,
 xypron.glpk@gmx.de
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH v3] doc: add bootelf command documentation
Date: Sun, 30 Jun 2024 17:19:52 +0300
Message-Id: <20240630141952.216250-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
v3:
	Separate -p -s into different lines.
v2:
	Add Configuration section.
---
 doc/usage/cmd/bootelf.rst | 61 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 doc/usage/cmd/bootelf.rst

diff --git a/doc/usage/cmd/bootelf.rst b/doc/usage/cmd/bootelf.rst
new file mode 100644
index 0000000000..8bae31ef1f
--- /dev/null
+++ b/doc/usage/cmd/bootelf.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright 2024, Maxim Moskalets <maximmosk4@gmail.com>
+
+.. index::
+   single: bootelf (command)
+
+bootelf command
+===============
+
+Synopsis
+--------
+
+::
+
+    bootelf [-p|-s] [-d <fdt_addr>] [<image_addr> [<arg>]...]
+
+Description
+-----------
+
+The *bootelf* command is used to launch a ELF binary at *image_addr*. If
+*image_addr* is not specified, the bootelf command will try to find image in
+*image_load_addr* variable (*CONFIG\_SYS\_LOAD\_ADDR* by default).
+
+Args after *image_addr* will be passed to application in common *argc*, *argv*
+format.
+
+A command sequence to run a ELF image using FDT might look like
+
+::
+
+    load mmc 0:1 ${loadaddr} /kernel.elf
+    load mmc 0:1 ${fdt_addr_r} /soc-board.dtb
+    bootelf -d ${fdt_addr_r} ${loadaddr} ${loadaddr}
+
+image_addr
+    Address of the ELF binary.
+
+fdt_addr
+    Address of the device-tree. This argument in only needed if bootable
+    application uses FDT that requires additional setup (like /memory node).
+
+arg
+    Any text arguments for bootable application. This is usually the address
+    of the device-tree.
+
+Flags:
+
+-p
+    Load ELF image via program headers.
+
+-s
+    Load ELF image via section headers.
+
+-d
+    Setup FDT by address.
+
+Configuration
+-------------
+
+The bootelf command is only available if CONFIG_CMD_ELF=y. FDT setup by flag -d
+need CONFIG_CMD_ELF_FDT_SETUP=y.
-- 
2.39.2

