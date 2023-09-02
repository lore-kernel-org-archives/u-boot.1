Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2549FC001DB
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 14:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F97D868BB;
	Sat,  2 Sep 2023 16:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CUnm6fco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55426868B1; Sat,  2 Sep 2023 16:53:30 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B9AA86898
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 16:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso512787f8f.1
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693666406; x=1694271206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qngk3U/RoGV31BGndtOspXrBHoqZK19EQiCz8M+Ehv8=;
 b=CUnm6fco7ZKaeo9G68gv8wGAJdvqaNJPK5v5n7dm27QOwQgtq3e4qKtVjf1rzW4N9k
 Rdracu1rXCA2de4+tUVRLa2Of1tugOekLzVBCyjH88W5TbtiA42wQmrv6oGr3XIvgQb9
 fKc4/iy3erulSMRXDVGhW4ZwgveY4r7kVaAQ35X14xMD7AL/8i6Mtkj7uYqlx78PS29t
 VKqViX9RDyUkrO+nC5x0MCbh9TFo95nOBXPbrvwdC74cJbXo9inEZnVpWKc6Q1y/9hGX
 cAkVt9EkltdeZoyawILp1WdFyNvLUytYSSlugzHAQ4QdnNa1AoMHeY8YlM41uJvg7sI3
 IoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693666406; x=1694271206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qngk3U/RoGV31BGndtOspXrBHoqZK19EQiCz8M+Ehv8=;
 b=iIpp1J9NEeoXGGlrt20xalrYSYG/xnuq/A0l1spRR51C2QqhIAom4gNMXhS+bl2406
 +H7ffuDZBJBeN18+QHKQaMAPOu4dWa5kDztgF9lEC+QjgLqLmddvShx9QpHvpoxhGNQ5
 mFXC47R8DGq/nWdGZmVfcNu+DcNPrZ2UwLRSECIejdJjxi86TaGX+dZ6JjuRHfIwpNwI
 GlnEM8TLVu4ozqFZ+Jelb8WuBtPdNB0R8PB3/mgr3tGJmDZGJLhJvMKjOZBpJA226aG2
 AX5fKcFUxMhiRPmQOhJyhaoWUFoN0WxMHog2WdxZku5xhn2P3Fn2wkiErHFHiCFuHtGU
 i2iA==
X-Gm-Message-State: AOJu0YxABze+ySoJEh9Ay1/e1et4zwOcUruqjqBvAlb3VYa8H48NhejX
 TWXlE+r6EJVp+RLERIUIYVcKGBvpqNNfICW4
X-Google-Smtp-Source: AGHT+IHggyYQCmhvv1KfuExu6nHy/rLm6g66W6q0lKSlInt8smnrSFjd8m3Xn/yENDONOmJq2hpnPw==
X-Received: by 2002:adf:ee90:0:b0:319:6b56:94d9 with SMTP id
 b16-20020adfee90000000b003196b5694d9mr4887573wro.2.1693666405778; 
 Sat, 02 Sep 2023 07:53:25 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 cc11-20020a5d5c0b000000b0031f34a395e7sm2385449wrb.45.2023.09.02.07.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 07:53:25 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v3 7/7] doc: add new section to build/tools
Date: Sat,  2 Sep 2023 16:53:10 +0200
Message-ID: <20230902145310.107054-8-jmcosta944@gmail.com>
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

Add 'Integration with IDEs' section.

For now, this section is mostly a reference to the documentation of
gen_compile_commands, also in doc/build, but it can be futurely used as
a guide for other IDE-friendly features.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 doc/build/gen_compile_commands.rst |  1 +
 doc/build/tools.rst                | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_commands.rst
index 6b32eb678a..da812525fe 100644
--- a/doc/build/gen_compile_commands.rst
+++ b/doc/build/gen_compile_commands.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0-only
+.. _gen-compile-commands-label:
 
 ====================
 gen_compile_commands
diff --git a/doc/build/tools.rst b/doc/build/tools.rst
index ec01722925..5cdbf27d83 100644
--- a/doc/build/tools.rst
+++ b/doc/build/tools.rst
@@ -45,3 +45,16 @@ Launch the MSYS2 shell of the MSYS2 environment, and do the following::
 
    $ make tools-only_defconfig
    $ make tools-only
+
+Integration with IDEs
+---------------------
+
+IDEs and text editors (e.g., VSCode, Emacs, Vim, Neovim) typically offer
+plugins to enhance the development experience, such as Clangd LSP. These
+plugins provide features like code navigation (i.e., jumping to definitions
+and declarations), code completion, and code formatting.
+
+U-Boot provides a script (i.e., scripts/gen_compile_commands.py) that
+generates a compilation database to be utilized by Clangd LSP for code
+navigation. For detailed usage instructions, please refer to the script's
+documentation: :ref:`gen-compile-commands-label`.
-- 
2.41.0

