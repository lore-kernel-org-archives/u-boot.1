Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018AACDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABCF86DF6;
	Fri, 13 Oct 2023 01:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a/MrSSj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E0F86D33; Fri, 13 Oct 2023 01:04:25 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1281486D94
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7ac4c3666so18524067b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697151841; x=1697756641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2h5sFJaNM0uPjKGK7BJ6K3/KLIDbeOp37CTU7HdAnKY=;
 b=a/MrSSj50vjl3jB344fg7D/GpOmS8JWljs6l5PL918kdkjxn+IlKo8cM/WC9nDYBIK
 sgoOHP46xDyl2fXxipVyETauFA4nx0GsC0SroxFbbcqtI+TrD5uJ6zI0Pfj7BGTl/1HT
 74cavVjofYYLxAZkGzta+arlrk8eq09ns0R24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697151841; x=1697756641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2h5sFJaNM0uPjKGK7BJ6K3/KLIDbeOp37CTU7HdAnKY=;
 b=rAzppHumzGbzhAnpD0kIJb46SqoFVhc6Cve2wqpcGVwkL8EuE3S6weFBLUWtYSdfyC
 7SjdU3Bq7GeQz3hqKvuQtaUNULpcdK4/dmfH3rXCswF5/gWe//OXpP3cES/245/3xvdL
 Mv91vG1MvfJUR13YGLLUsAwRLF/mNcbmvq1Qor4qtWMEyHfWMvi59TbS7qZqtr2uYXxd
 LVJ5t+Fkumi2P4i0fOXMFDgYcGxQCyezIJCLEA4E/j/PUmnL3GRCHlSHHJwgdCZRku9E
 GsqubT4D5TBfCjdxz1cFGR5ygU/U17LoiCeQO0t6W9IEIAY0wA5Jn/2NkZoP/nKca9Mg
 AoRw==
X-Gm-Message-State: AOJu0YxhqxGDSQBwhPT71M2PboKC4ZfIyxx1IUB8nrs5jRQ0HZhmy15W
 P2/cm/85I1vsvQ+S5FB6c6zpcsLWXuMKbvXy2qH+eg==
X-Google-Smtp-Source: AGHT+IGG6mRvMYHuUTyke15BBOpkb/DlH2Ax+sbSmQiYvZ0w+5gqTqlLOLbTuyjb/iLPAEkQEv0Q4g==
X-Received: by 2002:a05:690c:f05:b0:5a7:e726:13f7 with SMTP id
 dc5-20020a05690c0f0500b005a7e72613f7mr7712256ywb.8.1697151841358; 
 Thu, 12 Oct 2023 16:04:01 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a816f07000000b005925765aa30sm278730ywc.135.2023.10.12.16.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 16:04:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/7] checkpatch.pl: Make common.h check boarder
Date: Thu, 12 Oct 2023 19:03:53 -0400
Message-Id: <20231012230359.2005249-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

At this point in time we should not add common.h to any new files, so
make checkpatch.pl complain.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>

This causes a bunch of patman tests, for checkpatch, to now fail and I
don't really understand why, at all.  And that was before I added a test
for the new error, which I had hoped would clear up the problem.
---
 scripts/checkpatch.pl           | 8 +++++++-
 tools/patman/test_checkpatch.py | 7 ++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 488d73a0ed77..c3314da8a3c7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2636,12 +2636,18 @@ sub u_boot_line {
 		      "All CONFIG symbols are managed by Kconfig\n" . $herecurr);
 	}
 
-	# Don't put common.h and dm.h in header files
+	# Don't put dm.h in header files
 	if ($realfile =~ /\.h$/ && $rawline =~ /^\+#include\s*<(common|dm)\.h>*/) {
 		ERROR("BARRED_INCLUDE_IN_HDR",
 		      "Avoid including common.h and dm.h in header files\n" . $herecurr);
 	}
 
+	# Don't add common.h to files
+	if ($rawline =~ /^\+#include\s*<(common|dm)\.h>*/) {
+		ERROR("BARRED_INCLUDE_COMMON_H",
+		      "Do not add common.h to files\n" . $herecurr);
+	}
+
 	# Do not disable fdt / initrd relocation
 	if ($rawline =~ /^\+.*(fdt|initrd)_high=0xffffffff/) {
 		ERROR("DISABLE_FDT_OR_INITRD_RELOC",
diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index a8bb364e42b2..187736d617d5 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -401,10 +401,15 @@ index 0000000..2234c87
     def test_barred_include_in_hdr(self):
         """Test for using a barred include in a header file"""
         pm = PatchMaker()
-        #pm.add_line('include/myfile.h', '#include <common.h>')
         pm.add_line('include/myfile.h', '#include <dm.h>')
         self.check_single_message(pm, 'BARRED_INCLUDE_IN_HDR', 'error')
 
+    def test_barred_include_common_h(self):
+        """Test for adding common.h to a file"""
+        pm = PatchMaker()
+        pm.add_line('include/myfile.h', '#include <common.h>')
+        self.check_single_message(pm, 'BARRED_INCLUDE_COMMON_H', 'error')
+
     def test_config_is_enabled_config(self):
         """Test for accidental CONFIG_IS_ENABLED(CONFIG_*) calls"""
         pm = PatchMaker()
-- 
2.34.1

