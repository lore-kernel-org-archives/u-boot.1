Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469D8C5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4398888C61;
	Mon, 26 Aug 2024 21:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f+DkwiKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE76188C14; Mon, 26 Aug 2024 21:12:11 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C3C88B59
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39d34be8ca2so15602855ab.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699528; x=1725304328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jf8Vrh2l+vDmjZ2H/wu2TGUBELXjL6wHtVgcj1dwE1E=;
 b=f+DkwiKtLyXNu2ucVDpIoyDdHxLfWD5clknnd/YIpQ2bZ6b6o+M5ta0sdZe1yW4/A7
 zTrErcT8rt6IGzwwsOFv1ljEKkJ6G29ZRaSPul7TiZ90QS1LJZtBR+CvALLwoL8oDyCS
 I4nlvGeXQpT+v6aNaweDsB1okdRh0yReZtOF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699528; x=1725304328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jf8Vrh2l+vDmjZ2H/wu2TGUBELXjL6wHtVgcj1dwE1E=;
 b=NMX4S/xomyCIp5Yxh8dPScrtPyg2KusNFZmyolQc9uHDNM2blIDdNk/vQrMSgfRMRn
 2imFlrIhySTsi/2nbhfkcbQlQo/h1Jy+yIbJNUAkHnnbGFXq8rbhm2CddF9X5sTX+O4Y
 GzKw5AYGEsymgiDoZuI70M0UCwlFEpznth9CTE0bVDRhmFOpODLQK89YU0CpRtqcBWhq
 AKsWT57Lp9u0mPRyVYXWtI28DvJEmccARk1el6+ewiz/EV3I6Us0WrenKyQELa7qT1xT
 U6oXrgAG0/uWwzjoXy808h/A8d2tpS/uzG/D81yG/FwwMnPoweeQvA74eUk9YQYrlhET
 GBpg==
X-Gm-Message-State: AOJu0YxblltoBWPCQFJ7j42PALo1E0c359qhVMJZLJEBBfo1L8GgYuFF
 +7y3TxEsmO4QB9/bMdzCHSmLpdArhYd87N/cu4wFtk0RTX55HnrsqX9G6KUVxweD+uyCdaK+S6g
 =
X-Google-Smtp-Source: AGHT+IHm2nMFCYe1d/DrSq9BTPdkqKvDfHGN5AbFo7EvGk99cZ7L35TcaZNlcbn3wBgu0Nsmfu0guw==
X-Received: by 2002:a05:6e02:1d94:b0:39e:38f6:d00c with SMTP id
 e9e14a558f8ab-39e3c98f93emr132852245ab.15.1724699527993; 
 Mon, 26 Aug 2024 12:12:07 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:12:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/15] binman: Add minor improvements to symbol-writing
Date: Mon, 26 Aug 2024 13:11:39 -0600
Message-Id: <20240826191143.426387-12-sjg@chromium.org>
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

Add a clarification to the documentation and add a missing comment. Also
update the test so that when it fails it is easier to see what is going
on, rather than having to decode hex strings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/binman.rst |  4 +++-
 tools/binman/elf.py     |  3 ++-
 tools/binman/ftest.py   | 36 +++++++++++++++++++++++++++++-------
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 0cafc36bdcb..04564f4f66f 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -494,7 +494,9 @@ point into the image.
 For example, say SPL is at the start of the image and linked to start at address
 80108000. If U-Boot's image-pos is 0x8000 then binman will write an image-pos
 for U-Boot of 80110000 into the SPL binary, since it assumes the image is loaded
-to 80108000, with SPL at 80108000 and U-Boot at 80110000.
+to 80108000, with SPL at 80108000 and U-Boot at 80110000. In other words, the
+positions are calculated relative to the start address of the image to which
+they are being written.
 
 For x86 devices (with the end-at-4gb property) this base address is not added
 since it is assumed that images are XIP and the offsets already include the
diff --git a/tools/binman/elf.py b/tools/binman/elf.py
index 1c3b1e225f4..73394830ebe 100644
--- a/tools/binman/elf.py
+++ b/tools/binman/elf.py
@@ -247,7 +247,8 @@ def LookupAndWriteSymbols(elf_fname, entry, section, is_elf=False,
             entry
         entry: Entry to process
         section: Section which can be used to lookup symbol values
-        base_sym: Base symbol marking the start of the image
+        base_sym: Base symbol marking the start of the image (__image_copy_start
+            by default)
 
     Returns:
         int: Number of symbols written
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 56deece7230..9f329704115 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1526,18 +1526,40 @@ class TestFunctional(unittest.TestCase):
         # The image should contain the symbols from u_boot_binman_syms.c
         # Note that image_pos is adjusted by the base address of the image,
         # which is 0x10 in our test image
-        sym_values = struct.pack('<LLQLL', elf.BINMAN_SYM_MAGIC_VALUE,
-                                 0x00, u_boot_offset + len(U_BOOT_DATA),
-                                 0x10 + u_boot_offset, 0x04)
+        vals = (elf.BINMAN_SYM_MAGIC_VALUE, 0x00,
+                u_boot_offset + len(U_BOOT_DATA),
+                0x10 + u_boot_offset, 0x04)
+        sym_values = struct.pack('<LLQLL', *vals)
         if no_write_symbols:
-            expected = (base_data +
-                        tools.get_bytes(0xff, 0x38 - len(base_data)) +
-                        U_BOOT_DATA + base_data)
+            self.assertEqual(
+                base_data +
+                tools.get_bytes(0xff, 0x38 - len(base_data)) +
+                U_BOOT_DATA + base_data, data)
         else:
+            got_vals = struct.unpack('<LLQLL', data[:24])
+
+            # For debugging:
+            #print('expect:', list(f'{v:x}' for v in vals))
+            #print('   got:', list(f'{v:x}' for v in got_vals))
+
+            self.assertEqual(vals, got_vals)
+            self.assertEqual(sym_values, data[:24])
+
+            blen = len(base_data)
+            self.assertEqual(base_data[24:], data[24:blen])
+            self.assertEqual(0xff, data[blen])
+
+            ofs = blen + 1 + len(U_BOOT_DATA)
+            self.assertEqual(U_BOOT_DATA, data[blen + 1:ofs])
+
+            self.assertEqual(sym_values, data[ofs:ofs + 24])
+            self.assertEqual(base_data[24:], data[ofs + 24:])
+
+            # Just repeating the above asserts all at once, for clarity
             expected = (sym_values + base_data[24:] +
                         tools.get_bytes(0xff, 1) + U_BOOT_DATA + sym_values +
                         base_data[24:])
-        self.assertEqual(expected, data)
+            self.assertEqual(expected, data)
 
     def testSymbols(self):
         """Test binman can assign symbols embedded in U-Boot"""
-- 
2.34.1

