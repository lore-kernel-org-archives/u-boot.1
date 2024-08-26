Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA62CC5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C4788C66;
	Mon, 26 Aug 2024 21:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CKNv0QA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8BD88B59; Mon, 26 Aug 2024 21:12:14 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C94288C14
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-39d380d4ffcso17059595ab.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699531; x=1725304331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRm49h0hKWiXPkWMCIhRmQyPEdX3btmIlkjoB5gRxG4=;
 b=CKNv0QA15Gp/Y9xDF0srVbbq0Oupl7tz9r8GShSMIykOtDPv2YnZKa0SoCxQFp1BP+
 aY3pwgh/NqeHgtRqKzMlPdVyHm/ltA9YUBRA7Z+GiEyAIOiaOwvgtKnLmgX4UVyReVNQ
 GsdOQKpuVyE/tcSTL4Qqy2CEbocr+uGJ1TZks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699531; x=1725304331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRm49h0hKWiXPkWMCIhRmQyPEdX3btmIlkjoB5gRxG4=;
 b=FbkrLJllMl+QbJO7ZbIGXjLyBfzEi/V/aJtPOpwTXTMFnCLuZ7JdGizr0fEBr23dqg
 xt8ZT1IL9UXZVieRmegOyIRyZ7UKqF0uLkWMkgJlvi56Yj4Lh50QbhxEGgu+gJhuHyPO
 7pejqEsDeox5GMU0n4aGCTY9AbsoxenvVsHBZwIdEPxOOq4hDv+HLTDyKbSekwDhDu0U
 IC+FzmffUzScDtoslSdET/uwejwKdJWqgIUMLPT7Y91kYWGuMt7bM+o534blsS8DEQnL
 yEnHAcmKKXipgx7agFTE3WKuIXH6LDmjttseD/vdPA3+RiaKmqDgI4vfKGoUlaXQl9vz
 tkCQ==
X-Gm-Message-State: AOJu0YyJcY2vpcpiBwxbnUKm6OUuQw0QRD0Z8IYfXn19lY8rX5z/Lz+p
 5N25Hs6uaKgRgZDvG4kq8ObcqVBqnV2YoG+CjKtD9TI+xo0Wczle8jgm6hJnnPTvKKCML1RGbFU
 =
X-Google-Smtp-Source: AGHT+IH9WGLRHCzjueCgOl90HXsqkFXQEdEcKJHEguTcJxm1Ibt6zKB2x4Wv+VpPeFu308NwwtjUpw==
X-Received: by 2002:a05:6e02:1d12:b0:39b:936:83b3 with SMTP id
 e9e14a558f8ab-39e3c9842b6mr126399645ab.9.1724699530741; 
 Mon, 26 Aug 2024 12:12:10 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:12:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/15] binman: Unwind the end-at-4gb special-case a little
Date: Mon, 26 Aug 2024 13:11:41 -0600
Message-Id: <20240826191143.426387-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826191143.426387-1-sjg@chromium.org>
References: <20240826191143.426387-1-sjg@chromium.org>
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

Move the check for this further out, so that base_addr is computed in
Entry.WriteSymbols() rather than at lower levels.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entry.py         | 11 +++++++++--
 tools/binman/etype/section.py | 15 +++++----------
 tools/binman/image.py         | 10 ++++------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 8ad9fe89e0c..68f8d62bba9 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -711,15 +711,22 @@ class Entry(object):
     def WriteSymbols(self, section):
         """Write symbol values into binary files for access at run time
 
+        As a special case, if symbols_base is not specified and this is an
+        end-at-4gb image, a symbols_base of 0 is used
+
         Args:
           section: Section containing the entry
         """
         if self.auto_write_symbols and not self.no_write_symbols:
             # Check if we are writing symbols into an ELF file
             is_elf = self.GetDefaultFilename() == self.elf_fname
+
+            symbols_base = self.symbols_base
+            if symbols_base is None and self.GetImage()._end_4gb:
+                symbols_base = 0
+
             elf.LookupAndWriteSymbols(self.elf_fname, self, section.GetImage(),
-                                      is_elf, self.elf_base_sym,
-                                      self.symbols_base)
+                                      is_elf, self.elf_base_sym, symbols_base)
 
     def CheckEntries(self):
         """Check that the entry offsets are correct
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 6c181531b8b..7d2eb42627d 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -627,12 +627,10 @@ class Entry_section(Entry):
             optional: True if the symbol is optional. If False this function
                 will raise if the symbol is not found
             msg: Message to display if an error occurs
-            base_addr: Base address of image. This is added to the returned
-                image_pos in most cases so that the returned position indicates
-                where the targetted entry/binary has actually been loaded. But
-                if end-at-4gb is used, this is not done, since the binary is
-                already assumed to be linked to the ROM position and using
-                execute-in-place (XIP).
+            base_addr (int): Base address of image. This is added to the
+                returned value of image-pos so that the returned position
+                indicates where the targeted entry/binary has actually been
+                loaded
 
         Returns:
             Value that should be assigned to that symbol, or None if it was
@@ -655,10 +653,7 @@ class Entry_section(Entry):
         if prop_name == 'offset':
             return entry.offset
         elif prop_name == 'image_pos':
-            value = entry.image_pos
-            if not self.GetImage()._end_4gb:
-                value += base_addr
-            return value
+            return base_addr + entry.image_pos
         if prop_name == 'size':
             return entry.size
         else:
diff --git a/tools/binman/image.py b/tools/binman/image.py
index c667f583db6..24ce0af7c72 100644
--- a/tools/binman/image.py
+++ b/tools/binman/image.py
@@ -404,12 +404,10 @@ class Image(section.Entry_section):
             optional: True if the symbol is optional. If False this function
                 will raise if the symbol is not found
             msg: Message to display if an error occurs
-            base_addr: Base address of image. This is added to the returned
-                image_pos in most cases so that the returned position indicates
-                where the targeted entry/binary has actually been loaded. But
-                if end-at-4gb is used, this is not done, since the binary is
-                already assumed to be linked to the ROM position and using
-                execute-in-place (XIP).
+            base_addr (int): Base address of image. This is added to the
+                returned value of image-pos so that the returned position
+                indicates where the targeted entry/binary has actually been
+                loaded
 
         Returns:
             Value that should be assigned to that symbol, or None if it was
-- 
2.34.1

