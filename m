Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C112C83F2C
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 14:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73352867B6;
	Sat,  2 Sep 2023 16:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aof4JyTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6138643B; Sat,  2 Sep 2023 16:53:31 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC23D8684C
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 16:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31c63cd4ec2so2509158f8f.0
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693666405; x=1694271205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mg1PguG0pB+8AAHRB68FqnT/TXExVQsRcE5ID7CWLA=;
 b=Aof4JyTB2/FjMLY9Gt+dyH3ahUQLyMeXIkxZVmUwxCTtzt+yuCDwqtGViUOUT/NgF7
 E+3tzfMI2he7pclMwYcZQVZF6zhDyfGLvPrtniLU3GAoCfHaGW46nrwkLmuaUsTLEiXw
 35hdRPO844XUfrvXIZPaSm2Sc5D2F4t6E9524WPZMV0Q0WqNBQS5Jrzit1v+FB8sX6YR
 tiihbnwIkCppW9iHUwHBeZfA5hhQLuI08nLgVxHujshXpx4PRDoTW/Je/hX/F+ZW/rsC
 ANqkTODnDwiGptYil/S9aOy7Rifnjar7ZXV+CbwsfaxrREqdeeevl/8A1Hf0kk4lpciJ
 L1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693666405; x=1694271205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0mg1PguG0pB+8AAHRB68FqnT/TXExVQsRcE5ID7CWLA=;
 b=LJFHBIvWJgcFAcNyX5mZg9lIIddEz+3IBf4lToIF1ESmCM4ivbWnae2PfQhOBvG4YN
 +DngnDNa/n//j4hQLBKKmpqGqLKzledBJ8Vw+7ZV32FZ8U8aRApCO98sHwkO2eG5bPFg
 Av0YCVr3wbpM0ldpl+vYWIvNKm8H9lRjJ1hF2YMdbH6tTspj/WMk8s2e8HHWzP5Ks1qX
 vaxf2EOzGUmSuW/f5ymPzPaQXUgBdB0yEdFiHIiG/c2Cj8e8UGhGsxA1C7r03u7iShOu
 LI7YPDZIjHnv1yfFpyZRWl11Z9m8CuiO5lts1yKNHqGfGmJPT6FzoXskGB/rxKdMf2lr
 5pAQ==
X-Gm-Message-State: AOJu0YwTOyCHNZJWDHgfedOwbgm7WAZ5p9sjbcRBwwN2EzNquKtUC4wz
 W8vLO9z43C63rwXlMhzmktI5VRZ6crZeAyz2
X-Google-Smtp-Source: AGHT+IGSZ0O34uRn+I0ZEuUHUMYVnTUzFWsMThh+N0oAZ0vm2xqQ7BkAPNWu0ccgJm5hbCeVhQQC0A==
X-Received: by 2002:a5d:5009:0:b0:317:5168:c21f with SMTP id
 e9-20020a5d5009000000b003175168c21fmr3974512wrt.31.1693666404972; 
 Sat, 02 Sep 2023 07:53:24 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 cc11-20020a5d5c0b000000b0031f34a395e7sm2385449wrb.45.2023.09.02.07.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 07:53:24 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v3 6/7] doc: add documentation for gen_compile_commands.py
Date: Sat,  2 Sep 2023 16:53:09 +0200
Message-ID: <20230902145310.107054-7-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902145310.107054-1-jmcosta944@gmail.com>
References: <20230902145310.107054-1-jmcosta944@gmail.com>
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

This documentation briefly explains what is a compilation database,
and how to use the script to generate one.

This is not a portage, as there was no original documentation in the
Linux sources.

Acknowledge the documentation in the script's header and in doc/build
index.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 doc/build/gen_compile_commands.rst | 46 ++++++++++++++++++++++++++++++
 doc/build/index.rst                |  1 +
 scripts/gen_compile_commands.py    |  1 +
 3 files changed, 48 insertions(+)
 create mode 100644 doc/build/gen_compile_commands.rst

diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_commands.rst
new file mode 100644
index 0000000000..6b32eb678a
--- /dev/null
+++ b/doc/build/gen_compile_commands.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+====================
+gen_compile_commands
+====================
+
+gen_compile_commands (scripts/gen_compile_commands.py) is a script used to
+generate a compilation database (compile_commands.json). This database consists
+of an array of "command objects" describing how each translation unit was
+compiled.
+
+Example::
+
+  {
+  "command": "gcc -Wp,-MD,arch/x86/cpu/.lapic.o.d -nostdinc -isystem (...)"
+  "directory": "/home/jmcosta/u-boot",
+  "file": "/home/jmcosta/u-boot/arch/x86/cpu/lapic.c"
+  }
+
+Such information comes from parsing the respective .cmd file of each translation
+unit. In the previous example, that would be `arch/x86/cpu/.lapic.o.cmd`.
+
+The compilation database is quite useful for text editors (and IDEs) that use
+Clangd LSP. It allows jumping to definitions and declarations. Since it relies
+on parsing .cmd files, one needs to have a target (e.g. configs/xxx_defconfig)
+built before running the script.
+
+Example::
+
+  make sandbox_defconfig
+  make
+  ./scripts/gen_compile_commands.py
+
+The database will be in the root of the repository. No further modifications are
+needed for it to be usable by the LSP, unless you set a name for the database
+other than it's default one (compile_commands.json).
+
+Options
+=======
+
+For further details on how to use the script and its options, please refer to
+its help message, as in the example below.
+
+Help::
+
+  ./scripts/gen_compile_commands.py --help
diff --git a/doc/build/index.rst b/doc/build/index.rst
index 64e66491bd..7a4507b574 100644
--- a/doc/build/index.rst
+++ b/doc/build/index.rst
@@ -14,3 +14,4 @@ Build U-Boot
    tools
    buildman
    documentation
+   gen_compile_commands
diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 1a9c49b34a..aa52e88e18 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -5,6 +5,7 @@
 #
 # Author: Tom Roeder <tmroeder@google.com>
 # Ported and modified for U-Boot by Joao Marcos Costa <jmcosta944@gmail.com>
+# Briefly documented at doc/build/gen_compile_commands.rst
 #
 """A tool for generating compile_commands.json in U-Boot."""
 
-- 
2.41.0

