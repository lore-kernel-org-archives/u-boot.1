Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71101E748E9
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 10:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD60870BD;
	Sun,  1 Oct 2023 12:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bHyHZD8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48433870C5; Sun,  1 Oct 2023 12:00:52 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECF0C86EFF
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 12:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3232be274a0so1232418f8f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696154449; x=1696759249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DinrtiGbWU7IKwb73jTNgtGyClbqN6mTQj/gJa05yGg=;
 b=bHyHZD8gKk767/EqrmZwnKeC0uzFgy+fZnjqie+zPWSq5VmRDC+OH3TuEnQSIeeN1K
 uNOcnwqxxedJJSsH3F5Qvb6HwsoGbdt7fQC1ujBLqGPtP6XOQk+FG4IptJyyzjflorZ8
 uwRs5fQZxcDq3SiD3qIciS5kuESJiNrZlzvDLOsvQC3TB1510KXR8FSPJN8erw4XfQZc
 PdNmdnCAPFIIPrj0RvUoZlw6bu8hqZrW0Mbk1/XKjBuHEUrX1QaJ5nUrCAFBF36mCfi2
 S8pl4wrO/ErYDMLgvUycqG0VqSgQF2CUe2Do4RUKsuJEUfITSBzc1VnWoHI4djURC3BV
 vMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696154449; x=1696759249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DinrtiGbWU7IKwb73jTNgtGyClbqN6mTQj/gJa05yGg=;
 b=bQY3RQkgx8JMqkeoSBLRh1jMmVk74igSkAd4F7T90FV8FNLTgDKqvWq8Bz83xZXV8N
 nnTCP6BczCckaPEHuzlhdMZYNSOQt20KWBt8IpMuVV8qomyT9EbQ6ORfEwS8x9Kal8bU
 C9OIKr+5MKOgtjIUdJoD99IQYe/NkN1Dj5i8ZzILV238jEc13u9URuRnywpvCMxscz73
 40qQYN0gs4SeXkuT84VZP02cP46sc+vEw/VYw5cEorHsCUYFDDg7sfApIXe6mnHhJHoa
 EVN+YRKR9/rszywKg6mRMny8FwdxgrtkO2+V95YgK/+xihCqsKSeiIxAU4Cc3cQEN0m2
 s/iQ==
X-Gm-Message-State: AOJu0YwMzQwIXRdain98zuNAxdD1WXi6aCBG6RdfoeoPOeHxbiHJTQW9
 Q1W6Kx4uqgt6OTeVd/z3Ukws917FpxNxOsBJ
X-Google-Smtp-Source: AGHT+IGTmDziDr5RsV/M7u1u45wiSFM6AeIjT7O70UGO5QJC09I1Zrt9yLgo6EmAmUEqdF+EvUaSnw==
X-Received: by 2002:a5d:4049:0:b0:323:3b45:c452 with SMTP id
 w9-20020a5d4049000000b003233b45c452mr7737698wrp.14.1696154449071; 
 Sun, 01 Oct 2023 03:00:49 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b00326f5d0ce0asm3087135wrw.21.2023.10.01.03.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 03:00:48 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, Y.Moog@phytec.de,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v4 6/8] doc: add documentation for gen_compile_commands.py
Date: Sun,  1 Oct 2023 12:00:34 +0200
Message-ID: <20231001100036.34936-7-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001100036.34936-1-jmcosta944@gmail.com>
References: <20231001100036.34936-1-jmcosta944@gmail.com>
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
 doc/build/gen_compile_commands.rst | 83 ++++++++++++++++++++++++++++++
 doc/build/index.rst                |  1 +
 scripts/gen_compile_commands.py    |  1 +
 3 files changed, 85 insertions(+)
 create mode 100644 doc/build/gen_compile_commands.rst

diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_commands.rst
new file mode 100644
index 0000000000..50305cec4a
--- /dev/null
+++ b/doc/build/gen_compile_commands.rst
@@ -0,0 +1,83 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Create build database for IDEs
+==============================
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
+For more details on the database format, please refer to the official
+documentation at https://clang.llvm.org/docs/JSONCompilationDatabase.html.
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
+Beware that depending on the changes you made to the project's source code, you
+may need to run the script again (presuming you recompiled your target, of
+course) to have an up-to-date database.
+
+The database will be in the root of the repository. No further modifications are
+needed for it to be usable by the LSP, unless you set a name for the database
+other than it's default one (compile_commands.json).
+
+Compatible IDEs
+===============
+
+Several popular integrated development environments (IDEs) support the use
+of JSON compilation databases for C/C++ development, making it easier to
+manage build configurations and code analysis. Some of these IDEs include:
+
+1. **Visual Studio Code (VS Code)**: IntelliSense in VS Code can be set up to
+   use compile_commands.json by following the instructions in
+   https://code.visualstudio.com/docs/cpp/faq-cpp#_how-do-i-get-intellisense-to-work-correctly.
+
+2. **CLion**: JetBrains' CLion IDE supports JSON compilation databases out
+   of the box. You can configure your project to use a compile_commands.json
+   file via the project settings. Details on setting up CLion with JSON
+   compilation databases can be found at
+   https://www.jetbrains.com/help/clion/compilation-database.html.
+
+3. **Qt Creator**: Qt Creator, a popular IDE for Qt development, also
+   supports compile_commands.json for C/C++ projects. Instructions on how to
+   use this feature can be found at
+   https://doc.qt.io/qtcreator/creator-clang-codemodel.html#using-compilation-databases.
+
+4. **Eclipse CDT**: Eclipse's C/C++ Development Tools (CDT) can be
+   configured to use JSON compilation databases for better project management.
+   You can find guidance on setting up JSON compilation database support at the
+   wiki: https://wiki.eclipse.org/CDT/User/NewIn910#Build.
+
+For Vim, Neovim, and Emacs, if you are using Clangd as your LSP, placing the
+compile_commands.json in the root of the repository should suffice to enable
+code navigation.
+
+Usage
+=====
+
+For further details on the script's options, please refer to its help message,
+as in the example below.
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

