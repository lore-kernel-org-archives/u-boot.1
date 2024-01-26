Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DF8C47DDF
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8172487C2F;
	Fri, 26 Jan 2024 13:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="bk2yNcg5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F62E86784; Fri, 26 Jan 2024 10:25:50 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1946F878AA
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 10:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.wojtaszczyk@timesys.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40ed252edd7so8097685e9.0
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 01:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1706261147; x=1706865947;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orEmFtK67RnJfPUq+crWv/FsUO2wRZFm8kEJkrk+c0U=;
 b=bk2yNcg5sNOu7+cZ3EFp9TtTSwVgEvJEaNkwyPQW3m+fJNU8QRDwcHTLG0OZN6bXPa
 +EBQNrvdMbQkdl0fjDOvm6g/xdUvskJPsn5u80zBVtnsmjxpFTYYGAAV9cnDzaRrYoHd
 Qo4HlKjbLg1tWYsX6r3p8TFm1w22H0HxBSDVr2SgmhfBInXvpIfc8RNMoZUa8jwmAsLN
 bOQEtCwuALQxb3PEylIzBLNe/XfzS9dfBBnbA9hx0VE5ENimhqlvIyKTMUuVPYuj+RYP
 iFBbPk3u08EoqPnXhYAmeCUpr6KB0gwmcg6WPPIhJ2hKLKmtXtn73twwEguUFTUJhNtI
 BBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706261147; x=1706865947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orEmFtK67RnJfPUq+crWv/FsUO2wRZFm8kEJkrk+c0U=;
 b=ZZO4JtCdNgnK2xCOGhAx07heBagOIB1KIvdyVX+xbN6PSCsR3zY3N8REARFSZTT/kL
 YCy6bskANrgCFYwBYONQb8/sgERaskEgWICHqXBy3O4AMRLd2Mdh268MTjTHf7a5yUIS
 13psHM/PgJj1wsNBCyXXD7qNaCep1BMw5fzmvCAvfI/TJXQcroFTXni7A2l9Pz7xpMW7
 wZtqM9RVUycZ0ZuWDRQjSLgDQahaHB7SlW2BPjH89jk3k4m4NNWIRXRrQ2y0EhDsBvlQ
 vUSVyU5AnqoEBPOAtBdlIal1108Xyc62IYMojbIeGNFuFuy+aVhqz3j9yKXdIwhkla4w
 QmGA==
X-Gm-Message-State: AOJu0YwsvDypWLjO1b/Yd1Ud10mkTrz4Do4YZtM7QxJz2N1JIACtFSLh
 J74afypeKKZSGSKK4NicFRJlmCTtNTQ+BjuLwvmSu9AOrKsLEEEGvCiIcdKk4lVjAXvSi6CfWiv
 8Z0k=
X-Google-Smtp-Source: AGHT+IGxZwwiWpprqqLzd19jGQHq0cMDwCld66nU1kbV585Dw6ba78KKLf3SF3Z3rE6EqsOH+xI3pw==
X-Received: by 2002:a05:600c:2212:b0:40e:6239:317 with SMTP id
 z18-20020a05600c221200b0040e62390317mr439060wml.253.1706261147365; 
 Fri, 26 Jan 2024 01:25:47 -0800 (PST)
Received: from localhost.localdomain ([91.216.213.152])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1709064f1800b00a349a5f9f77sm416208eju.47.2024.01.26.01.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 01:25:47 -0800 (PST)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: u-boot@lists.denx.de
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] binman: Add basic 'file_size' and 'int32' entry types
Date: Fri, 26 Jan 2024 10:25:29 +0100
Message-Id: <20240126092533.20709-2-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
References: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jan 2024 13:24:57 +0100
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

Entry 'int32' type can inject arbitrary 32bit integer value into a firmware
file. Entry 'file_size' type can inject file size as 32bit integer value into a
firmware file.
Both entries are helpful when a boot ROM requires magic value and/or
firmware length in header.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---

 tools/binman/entries.rst        | 25 +++++++++++++++++++++++++
 tools/binman/etype/file_size.py | 28 ++++++++++++++++++++++++++++
 tools/binman/etype/int32.py     | 24 ++++++++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 tools/binman/etype/file_size.py
 create mode 100644 tools/binman/etype/int32.py

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 254afe7607..7696ea7023 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -712,6 +712,18 @@ without the fdtmap header, so it can be viewed with `fdtdump`.
 
 
 
+.. _etype_file_size:
+
+Entry: file_size: Size of a file as 32bit integer
+--------------------------------------------------
+
+Properties / Entry arguments:
+    - filename: relative file path
+
+This entry reads file size and places it as 32bit integer.
+
+
+
 .. _etype_files:
 
 Entry: files: A set of files arranged in a section
@@ -1138,6 +1150,19 @@ first/last in the entry list.
 
 
 
+.. _etype_int32:
+
+Entry: int32: Arbitrary 32bit integer
+--------------------------------------------------
+
+Properties / Entry arguments:
+    - value: 32bit integer value
+
+This entry places arbitrary 32bit integer. Useful when a magic value is
+required in a firmware.
+
+
+
 .. _etype_intel_cmc:
 
 Entry: intel-cmc: Intel Chipset Micro Code (CMC) file
diff --git a/tools/binman/etype/file_size.py b/tools/binman/etype/file_size.py
new file mode 100644
index 0000000000..d99ca1c067
--- /dev/null
+++ b/tools/binman/etype/file_size.py
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2023 Timesys
+# Written by Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
+#
+
+from binman.entry import Entry
+from dtoc import fdt_util
+from u_boot_pylib import tools
+import sys
+
+class Entry_file_size(Entry):
+    """An entry which is filled size of a file
+
+    Properties / Entry arguments:
+        - file: path to the file
+
+    Useful where a firmware header needs length of the firmware.
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self._filename = fdt_util.GetString(self._node, 'filename', self.etype)
+
+    def ObtainContents(self):
+        self._pathname = tools.get_input_filename(self._filename,
+            self.external and self.section.GetAllowMissing())
+        self._file_size = len(tools.read_file(self._pathname))
+        self.SetContents(self._file_size.to_bytes(4, sys.byteorder))
+        return True
diff --git a/tools/binman/etype/int32.py b/tools/binman/etype/int32.py
new file mode 100644
index 0000000000..463dfe46fd
--- /dev/null
+++ b/tools/binman/etype/int32.py
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2023 Timesys
+# Written by Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
+#
+
+from binman.entry import Entry
+from dtoc import fdt_util
+import sys
+
+class Entry_int32(Entry):
+    """An entry which is filled with arbitrary int32 data
+
+    Properties / Entry arguments:
+        - value: int32 value
+
+    Useful where a magic header is needed.
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self._int32_value = fdt_util.GetInt(self._node, 'value', 0)
+
+    def ObtainContents(self):
+        self.SetContents(self._int32_value.to_bytes(4, sys.byteorder))
+        return True
-- 
2.25.1

