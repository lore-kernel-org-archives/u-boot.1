Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501FBC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 10:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E26088621;
	Sun, 30 Jun 2024 12:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShqErZwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69D388624; Sun, 30 Jun 2024 12:37:10 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C749B8861D
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 12:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ce9ba0cedso3360219e87.2
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 03:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719743828; x=1720348628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=suxOGmQSW8H/Ky2b74QlBndtQF+aluUMs/xAIcOUoxY=;
 b=ShqErZwn6CB35MHtDJnUM2dkl5Iq6c0mIrcm68dsf85HgiR7/0LatoIZM2psdZ+YcJ
 vxxDfbXPJeklWgEaSmzoAeQYP7CceyddDU5c32SYTjEyfBsLuho47SvZU2S0WwaJOece
 PByxBogI9/7BTpFaC7Elyh500/B3EabuF4ScI+ZY9zIwaVQKJHDiX2QQilwvFLPTWqrT
 OpagBzU2uV4RwrizvrbUdq84+NR/8gVqWbzgUt4jixmEhI0U09uouhluQ3qaq5+wEIvN
 BwwUW/eF8FHEvslvSb30pf5IfTwxFhSbDujuEvurOdgcYkQTEzWc5R7E7QgJKMd/Lrea
 0+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719743828; x=1720348628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=suxOGmQSW8H/Ky2b74QlBndtQF+aluUMs/xAIcOUoxY=;
 b=kF8izGAA/1Q9kpFAHHaE6w6e0KrAbTnTGYx08ZqMlgoOEAysg5ECNW2rVGchfbU8BD
 oBp+24tHbh6Bb021MqxDcbTwncH7tkCdLTTwUUAWbTWQ9fXJLkbgbgbHm1FhHBNYvE22
 e2HI7p8v7CGn0GOO/uljk9y0dlLi2TH/w+lZRaRoYdjcroovqif5goG8l+4hYqibPjW2
 8dbfEl6A7Yb4/J09QGPwFe0X4w8Cf4oClUxsZ19OUR2JDleS2OTkrqJWnN/Q19hFAABd
 iadM/YgMFqlpu4lXwV3+9xhE1+kC/ymrBADVOzAzxIuEfdnM4ekLPl5WjU/coz8lXdJk
 tDcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPtdVEdCG7u9FpvV8biZvsAj2ZnWgtMTSYKrzSqaaCCb3NINgQ5TK5TUFnT52tCbDF4pK+UVa0+BVWnydlTKGW+Eycug==
X-Gm-Message-State: AOJu0YxCyN7U/dojgEgc4Kq06g0T6O8Sw7G/4oTUmfjXVaEDcdyHOnv9
 xf+J45jUmuCFX9DPsf3kHtoB4HRkeofH1eguDjmSjfJvRhEwqqI+
X-Google-Smtp-Source: AGHT+IHG5kGZdIeMw/mqH7aS6aqExnnLb41mmDfCmg8b+cgaOyflSMN77XDjW0hQ1QWpWtvDdiW1Fw==
X-Received: by 2002:a05:6512:32ba:b0:52d:215c:4111 with SMTP id
 2adb3069b0e04-52e826679b8mr2080407e87.24.1719743827780; 
 Sun, 30 Jun 2024 03:37:07 -0700 (PDT)
Received: from localhost.localdomain (109-252-15-116.nat.spd-mgts.ru.
 [109.252.15.116]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab0bb67sm894587e87.40.2024.06.30.03.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 03:37:07 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: trini@konsulko.com,
	u-boot@lists.denx.de,
	sjg@chromium.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] doc: add bootelf command documentation
Date: Sun, 30 Jun 2024 13:37:03 +0300
Message-Id: <20240630103703.49318-1-Maxim.Moskalets@kaspersky.com>
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
 doc/usage/cmd/bootelf.rst | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 doc/usage/cmd/bootelf.rst

diff --git a/doc/usage/cmd/bootelf.rst b/doc/usage/cmd/bootelf.rst
new file mode 100644
index 0000000000..5472a90fe2
--- /dev/null
+++ b/doc/usage/cmd/bootelf.rst
@@ -0,0 +1,52 @@
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
+-p|-s
+    Load ELF image via program headers (-p) or via section headers (-s).
+
+-d
+    Setup FDT by address. Available only if CONFIG_CMD_ELF_FDT_SETUP is enabled.
-- 
2.39.2

