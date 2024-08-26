Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE40AC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5022C88B5A;
	Mon, 26 Aug 2024 21:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WPxUOrdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F500880DB; Mon, 26 Aug 2024 21:11:57 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B4B88A3A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39d30f0f831so14950705ab.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699513; x=1725304313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GOESYcKu4Krmg9D63Z/Amg5PTkxDoRWR3jEemvUr6A=;
 b=WPxUOrdjahBX7i4HFIK9ptk1SktwDudSob9zhGIea5D5TaDg/jV0P2WyMrl9RkzUuE
 Q2NRMS9GDgFzstW978plC0MjbXkg9ezat/Jm8DrwEfsATGnLpi09HrfML8tWYnpT0/rg
 EL/hyrmy1MTkCj0DDYGILTEQr9ZjeUbFQbOOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699513; x=1725304313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GOESYcKu4Krmg9D63Z/Amg5PTkxDoRWR3jEemvUr6A=;
 b=b32RCNyoW7Py9xR0pcVksrKwnOR3W3Y5ou/ktYgMPccvAHBjLoC/+qfhnfg7kkfpyd
 4nlnI+4ujKByGIx7a3OGlmbfqXUaZ2X6Pe5oNiuiw9kUNdd5hEd4PE0GG/2UGu6a4JTD
 srjv40pwyVCzBWbsRB2AwY/LQN7PGxb584ySQCJifhkdeHH9ES3bjQL9slSRwgYRfRVZ
 p9dKjGVy5s0U9xun7AYHR5J62e7w69yXvwREndM7FEUNczBHrno91XrK4pCSbDthb7NU
 MQEP6wznlUkfNzTp0ef3fSeMBnXAlP/mfjIsBmmN6v09oFUNGgUQr1a2qkIqH30zG4XZ
 ipLw==
X-Gm-Message-State: AOJu0YxxqsOs2Bl5tbpcMgg39S/TBcH6gJFVL0MMIblApnEbPrWtm0Tz
 ptS5oOfmzqlmtIaLSeViTqAaAbTz7+M7N+/XFeGx1TXohF9z2c2mOj1svAw/OwF/AseYVNwiRRs
 =
X-Google-Smtp-Source: AGHT+IGrf5XlZWjuWidv2bPb0zssA7abDq83GraWpI7SvnAGrZAbzxT6RSbrKlsf9gtpmQ57vbmELg==
X-Received: by 2002:a05:6e02:1907:b0:39d:637f:97bc with SMTP id
 e9e14a558f8ab-39e3c8e13eamr135246585ab.0.1724699513543; 
 Mon, 26 Aug 2024 12:11:53 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:11:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/15] binman: Fix up test coverage for mkeficapsule
Date: Mon, 26 Aug 2024 13:11:29 -0600
Message-Id: <20240826191143.426387-2-sjg@chromium.org>
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

Add tests for missing tools to complete the test coverage for this
etype.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/efi_capsule.py |  2 ++
 tools/binman/ftest.py             | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 5941545d0b2..aac8789f9cb 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -151,6 +151,8 @@ class Entry_efi_capsule(Entry_section):
             return tools.read_file(capsule_fname)
         else:
             # Bintool is missing; just use the input data as the output
+            if not self.GetAllowMissing():
+                self.Raise("Missing tool: 'mkeficapsule'")
             self.record_missing_bintool(self.mkeficapsule)
             return data
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 93f3d22cf57..50ba51f8b63 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -403,8 +403,10 @@ class TestFunctional(unittest.TestCase):
             test_section_timeout: True to force the first time to timeout, as
                 used in testThreadTimeout()
             update_fdt_in_elf: Value to pass with --update-fdt-in-elf=xxx
-            force_missing_tools (str): comma-separated list of bintools to
+            force_missing_bintools (str): comma-separated list of bintools to
                 regard as missing
+            ignore_missing (bool): True to return success even if there are
+                missing blobs or bintools
             output_dir: Specific output directory to use for image using -O
 
         Returns:
@@ -7690,6 +7692,24 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             # Make sure the other node is gone
             self.assertIsNone(dtb.GetNode('/node/other-node'))
 
+    def testMkeficapsuleMissing(self):
+        """Test that binman complains if mkeficapsule is missing"""
+        with self.assertRaises(ValueError) as e:
+            self._DoTestFile('311_capsule.dts',
+                             force_missing_bintools='mkeficapsule')
+        self.assertIn("Node '/binman/efi-capsule': Missing tool: 'mkeficapsule'",
+                      str(e.exception))
+
+    def testMkeficapsuleMissingOk(self):
+        """Test that binman deals with mkeficapsule being missing"""
+        with test_util.capture_sys_output() as (stdout, stderr):
+            ret = self._DoTestFile('311_capsule.dts',
+                                   force_missing_bintools='mkeficapsule',
+                                   allow_missing=True)
+        self.assertEqual(103, ret)
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: mkeficapsule")
+
 
 if __name__ == "__main__":
     unittest.main()
-- 
2.34.1

