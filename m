Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79B8CA0FF3
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 20:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 585D186758;
	Fri,  1 Sep 2023 22:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jB1cTBmr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F85686177; Fri,  1 Sep 2023 22:04:21 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2324866CF
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 22:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401ec23be82so24697665e9.0
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693598658; x=1694203458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRHl9oAo6l8JVVaT8sveDVJX5sNbE+Ajq4cagCw2jv8=;
 b=jB1cTBmrQ2WUI9p1o5IwrPE25MiKYdQ/GQt56wXDTFdF9mlcPb1twjIwRsvEPn8SFt
 TLb0PM127AwHvmTAoiVIcBLmOjV7JtI/bJmLhCk5dBtqLkhEcSB1rUSC7wbj9lx8foNI
 EO3HoyEdTpzV5q+WC/PDuMvVCbRX39B9O3yVOjW0gKbmEl3jKyO5Mz5ELu+ySwH3rW/F
 ubfz5NT2M6UES5HmaXkbRA9x2uKMNpS/Me7WMbYHE2abGmQpPXK0lJxzxkJWD51oXAh1
 05vQizcVAEYTvOC5LOU3HzMPwBOwd+dTKGdJr7tRWxUp+d+gfiTJF09N3mCxUxspsSzx
 WUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693598658; x=1694203458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRHl9oAo6l8JVVaT8sveDVJX5sNbE+Ajq4cagCw2jv8=;
 b=c06juSR4chGybvMBb065eL4GZaB/RWrQZQfS+1Zn2gpjMVtUCXkl/v3Gqy6XfrNahZ
 ThBZPGH/b3pSo04dc/Q7s4dJmZvWgLwBw9mv7R+4ymV3RxFOajLPu3zOxUefo5gYNFIU
 dK7FggMy2lnq5DDoGCmzUMN9FetGmbnCo63VEkIjZo9smgMpEe2eeH2fHullWdV5LLbn
 Y13QQNwCU2oLjx7rmJ7NFl4PW+mgF/ePasGRldpj43N4PzTmWB4bq3lCQxovgBiqQeMB
 ntSmvd5YgWN6jhaob7f1+0ebt8bEnV9feAmzIP1/f0Kc/+xmB+kv6Q5ZiR+izyGDUQUv
 yMGQ==
X-Gm-Message-State: AOJu0YzyE/9upHTw7s1tXwKGPl5wq56b0xILWv+C5kN5RQUp1mjF2uk/
 8GJCxIDPyXD0AZ+31nw6TxdMh9RWYyw/wwPy
X-Google-Smtp-Source: AGHT+IF3S80eNwycRP7+yMBIKD0Vkd58fR7t8xsY8AK5gcT+jYHLOkNzPea6A2K2UtrAp1v2zdwIvg==
X-Received: by 2002:adf:f691:0:b0:317:6fb5:bafc with SMTP id
 v17-20020adff691000000b003176fb5bafcmr2557458wrp.65.1693598658016; 
 Fri, 01 Sep 2023 13:04:18 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 l4-20020adffe84000000b003176eab8868sm6207849wrr.82.2023.09.01.13.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:04:17 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v2 6/6] doc: add documentation for gen_compile_commands.py
Date: Fri,  1 Sep 2023 22:03:53 +0200
Message-ID: <20230901200353.90290-7-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901200353.90290-1-jmcosta944@gmail.com>
References: <20230901200353.90290-1-jmcosta944@gmail.com>
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

Acknowledge the documentation in the script's header.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 doc/develop/gen_compile_commands.rst | 46 ++++++++++++++++++++++++++++
 scripts/gen_compile_commands.py      |  1 +
 2 files changed, 47 insertions(+)
 create mode 100644 doc/develop/gen_compile_commands.rst

diff --git a/doc/develop/gen_compile_commands.rst b/doc/develop/gen_compile_commands.rst
new file mode 100644
index 0000000000..09466938fe
--- /dev/null
+++ b/doc/develop/gen_compile_commands.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==========
+gen_compile_commands
+==========
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
+on parsing .cmd files, one needs to have a target (e.g. configs/*_defconfig)
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
diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 1a9c49b34a..f0c6bafdc5 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -5,6 +5,7 @@
 #
 # Author: Tom Roeder <tmroeder@google.com>
 # Ported and modified for U-Boot by Joao Marcos Costa <jmcosta944@gmail.com>
+# Briefly documented at doc/develop/gen_compile_commands.rst
 #
 """A tool for generating compile_commands.json in U-Boot."""
 
-- 
2.41.0

