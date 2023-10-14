Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54F4CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B667B86EC4;
	Sun, 15 Oct 2023 09:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ihweq+HL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234BF8071F; Sun, 15 Oct 2023 09:09:49 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58CC8691E
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3af608eb367so2326697b6e.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697353752; x=1697958552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMJJBPSLCVmbPG27BoiLPUUG4v44HtIWiFbnWRS8g+U=;
 b=Ihweq+HLkrecD+tPbzJdv8gVyeLl+880B96BqcXWqrphqihmt0P0Z9L/Rpem5LDcgU
 4uFYsl6kdCT9JFpSM3TDSh0TjviJFml0vqKFPR1xDlQjwxYe42lqb4qFPNp6d5DFe4hb
 odh6wf2bzfjDva9rSbu5gr0sMALZnZRMaXgd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697353752; x=1697958552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMJJBPSLCVmbPG27BoiLPUUG4v44HtIWiFbnWRS8g+U=;
 b=at7VIRNjd3v4d0s0jEgv3nNXmYQWAdCrcmsp2Fj6NpS7kLD6Wxd2YOovmiQ72g+umQ
 sA5cGux6uMS59dkx3AyNbUnswwdwVEV2qxmM+QxQL97bU3fSLMNLTKsRlMQzLS+/krco
 QgJ2Fc1ohG4VJ6lh0tAfpGbDbFnhlcYrnMAf5AuLjQB9nJFf46ysO9vgyq/rRKIb+7em
 qlNBX2qFHb2JxIvyOw85UG00Bqv0tXT8HuMgqaqnTfS6Pn3a//qYEKs6DCXawxcJUgTT
 gE61oNgAQ0NuGDx5oMwcko9MtOMtFQt8D0T6eknMv9JufweDUFWtjVCwIPXc2Vpe0qKu
 xTtg==
X-Gm-Message-State: AOJu0YzGXXOOcxzz490g9FC0Ohy3bcIYRMH1U+VtpOo6Efr5wQ//G81z
 QWvJZ3PrVwOh9RI68oyby39FTfrloN3jhXMABNXsow==
X-Google-Smtp-Source: AGHT+IHb8MQPnCCV0HPolOeMAnpA6dfua7nqtP8aZDhdEIzSpF98aZKJoKrtkvzUwh1BQZQqkdhDbw==
X-Received: by 2002:a6b:e704:0:b0:78b:b892:e334 with SMTP id
 b4-20020a6be704000000b0078bb892e334mr34977347ioh.11.1697316042071; 
 Sat, 14 Oct 2023 13:40:42 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a02cb1b000000b0042b14d9be7bsm5424649jap.22.2023.10.14.13.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 13:40:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 5/6] binman: Rename TYPE_STAGE to TYPE_LEGACY_STAGE
Date: Sat, 14 Oct 2023 14:40:29 -0600
Message-ID: <20231014204033.3077052-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231014204033.3077052-1-sjg@chromium.org>
References: <20231014204033.3077052-1-sjg@chromium.org>
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

In preparation for changing how stages are stored, rename the existing
stage tag.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/cbfs.c                     |  2 +-
 include/cbfs.h                 |  2 +-
 tools/binman/cbfs_util.py      | 12 ++++++------
 tools/binman/cbfs_util_test.py |  3 ++-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/cmd/cbfs.c b/cmd/cbfs.c
index 8a61f2c26f9e..3cfc9eb27270 100644
--- a/cmd/cbfs.c
+++ b/cmd/cbfs.c
@@ -118,7 +118,7 @@ static int do_cbfs_ls(struct cmd_tbl *cmdtp, int flag, int argc,
 		case CBFS_TYPE_CBFSHEADER:
 			type_name = "cbfs header";
 			break;
-		case CBFS_TYPE_STAGE:
+		case CBFS_TYPE_LEGACY_STAGE:
 			type_name = "stage";
 			break;
 		case CBFS_TYPE_PAYLOAD:
diff --git a/include/cbfs.h b/include/cbfs.h
index 38efb1d2b02e..2bc5de2297e4 100644
--- a/include/cbfs.h
+++ b/include/cbfs.h
@@ -22,7 +22,7 @@ enum cbfs_result {
 enum cbfs_filetype {
 	CBFS_TYPE_BOOTBLOCK = 0x01,
 	CBFS_TYPE_CBFSHEADER = 0x02,
-	CBFS_TYPE_STAGE = 0x10,
+	CBFS_TYPE_LEGACY_STAGE = 0x10,
 	CBFS_TYPE_PAYLOAD = 0x20,
 	CBFS_TYPE_SELF = CBFS_TYPE_PAYLOAD,
 
diff --git a/tools/binman/cbfs_util.py b/tools/binman/cbfs_util.py
index 076768ae839b..9ca32f7309ff 100644
--- a/tools/binman/cbfs_util.py
+++ b/tools/binman/cbfs_util.py
@@ -96,7 +96,7 @@ ARCH_NAMES = {
 
 # File types. Only supported ones are included here
 TYPE_CBFSHEADER     = 0x02   # Master header, HEADER_FORMAT
-TYPE_STAGE          = 0x10   # Stage, holding an executable, see STAGE_FORMAT
+TYPE_LEGACY_STAGE   = 0x10   # Stage, holding an executable
 TYPE_RAW            = 0x50   # Raw file, possibly compressed
 TYPE_EMPTY          = 0xffffffff     # Empty data
 
@@ -265,7 +265,7 @@ class CbfsFile(object):
         Returns:
             CbfsFile object containing the file information
         """
-        cfile = CbfsFile(name, TYPE_STAGE, data, cbfs_offset)
+        cfile = CbfsFile(name, TYPE_LEGACY_STAGE, data, cbfs_offset)
         cfile.base_address = base_address
         return cfile
 
@@ -326,7 +326,7 @@ class CbfsFile(object):
         """
         name = _pack_string(self.name)
         hdr_len = len(name) + FILE_HEADER_LEN
-        if self.ftype == TYPE_STAGE:
+        if self.ftype == TYPE_LEGACY_STAGE:
             pass
         elif self.ftype == TYPE_RAW:
             if self.compress:
@@ -354,7 +354,7 @@ class CbfsFile(object):
         attr = b''
         pad = b''
         data = self.data
-        if self.ftype == TYPE_STAGE:
+        if self.ftype == TYPE_LEGACY_STAGE:
             elf_data = elf.DecodeElf(data, self.base_address)
             content = struct.pack(STAGE_FORMAT, self.compress,
                                   elf_data.entry, elf_data.load,
@@ -639,7 +639,7 @@ class CbfsReader(object):
         files: Ordered list of CbfsFile objects
         align: Alignment to use for files, typically ENTRT_ALIGN
         stage_base_address: Base address to use when mapping ELF files into the
-            CBFS for TYPE_STAGE files. If this is larger than the code address
+            CBFS for TYPE_LEGACY_STAGE files. If this is larger than the code address
             of the ELF file, then data at the start of the ELF file will not
             appear in the CBFS. Currently there are no tests for behaviour as
             documentation is sparse
@@ -750,7 +750,7 @@ class CbfsReader(object):
         fd.seek(cbfs_offset, io.SEEK_SET)
         if ftype == TYPE_CBFSHEADER:
             self._read_header(fd)
-        elif ftype == TYPE_STAGE:
+        elif ftype == TYPE_LEGACY_STAGE:
             data = fd.read(STAGE_LEN)
             cfile = CbfsFile.stage(self.stage_base_address, name, b'',
                                    cbfs_offset)
diff --git a/tools/binman/cbfs_util_test.py b/tools/binman/cbfs_util_test.py
index 64592525ec7d..2775d05b8120 100755
--- a/tools/binman/cbfs_util_test.py
+++ b/tools/binman/cbfs_util_test.py
@@ -490,7 +490,8 @@ class TestCbfs(unittest.TestCase):
         load = 0xfef20000
         entry = load + 2
 
-        cfile = self._check_uboot(cbfs, cbfs_util.TYPE_STAGE, offset=0x20,
+        cfile = self._check_uboot(cbfs, cbfs_util.TYPE_LEGACY_STAGE,
+                                  offset=0x20,
                                   data=U_BOOT_DATA + U_BOOT_DTB_DATA)
 
         self.assertEqual(entry, cfile.entry)
-- 
2.42.0.655.g421f12c284-goog

