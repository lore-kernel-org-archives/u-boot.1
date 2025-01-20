Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4498C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49B4780C67;
	Mon, 20 Jan 2025 22:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AbkI7ceK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B37C680A4F; Mon, 20 Jan 2025 22:27:50 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C91E801CF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a9c9f2a569so36864295ab.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408467; x=1738013267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+lUUP02bC08bvTKgUHyp2FQtADX1knbSRPzqEexp3s=;
 b=AbkI7ceK61LCrqN9p3BPbgyrO5u1r5601q4bphvnbBu1/y0VlePT28E47eMB20si4l
 g82AclNEbechmSAuKPLytfBYGnS5MOJkvBhMnkeAjWEtJPIICzMQNGGsDLx6piwWBoIn
 GiOls8SyoMrhAOEn8LDJUos6GjiKwPJkQlZ8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408467; x=1738013267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+lUUP02bC08bvTKgUHyp2FQtADX1knbSRPzqEexp3s=;
 b=HyWFLxbQgMFZ08V9gGn3gLTtw72QRd+/MFmhcnj3kgMgPEnfRXLOQdH25Z2NrdCgTy
 Co/ONEyiTSmixwXo9T0k26HrT2DsVwPBh1gkDi1Vmwn1A2Z3H/O8uL0COYMs4sWcn68X
 4a6HyqM55HYJ7cWMLd/8tVHhclWLVhP7FhNwNfoJHeEla7wuSm2G9hw9pk2iW3fhtzyl
 Bq0KsCDJ4i+dnzAmWmw2YHKu9kBnADnqCf2PlnHBBjSbDktBGhnFHMBt5CMdaIj2SVGN
 yNjIqQFLEYU6qkkaXOt1ouwqoiCBBTwClPzib8zlIzkbFtkL3Z44/XOXViEh51bvNlS6
 pX5A==
X-Gm-Message-State: AOJu0YxbyCKbdvUhwIv3u78cJYwTomzDlIBNpsOtoz66Ys5rpkw6lQjm
 /cU/b3V2Ou9oD5o2qgSlvV+tv3P+5DD4pKEILFAnzJAVP4Eqb4a+5tz0qP7ljT7K78IXHX9nTXM
 =
X-Gm-Gg: ASbGncupQ4OWKaUZYCa1uBHXOlmRkHnp8P6J+vuirROtLWCCrnLs3uXKQfidoAkv3TF
 p3XJBry81eamON3xGV+5tSnie8vmSyxNu2u9siP24zXUSpk69tpzOvwDDOC+V4DrZuOgoDfjyau
 NtA9/azZBXWR6uEV64P3Xbc5WqO5Zw06WqVEH7xuluvhCidG/cGmcwpOiD1NWjb1l/QOB5US//L
 KG87EIigFs5ZQ0HuAeZfPl2QRDjkJYeZk1WKkq41K5Hy3d/LMDwT6Dmn1RV6XYjmUlomIvHaTn9
 dwliWNVWPMqx8DHRn+NdFptrYFe/hPk=
X-Google-Smtp-Source: AGHT+IEnpfpoTmmHJeMMYNx7of6FA+S7GbphsLHIZtLMrhHtZV0HtTuo/+qlPWAmZRmzUq3oxSjtlg==
X-Received: by 2002:a05:6e02:388b:b0:3a7:e83c:2d08 with SMTP id
 e9e14a558f8ab-3cf744b5b00mr151517175ab.22.1737408466757; 
 Mon, 20 Jan 2025 13:27:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 44/44] doc: Update ut documentation
Date: Mon, 20 Jan 2025 14:26:06 -0700
Message-ID: <20250120212613.516664-45-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

Update documentation for the 'ut' command, since it has changed a
little.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to update ut documentation
- Drop patch to disable test_suite.py

 doc/usage/cmd/ut.rst | 74 +++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/doc/usage/cmd/ut.rst b/doc/usage/cmd/ut.rst
index afeafa824d6..e794922c806 100644
--- a/doc/usage/cmd/ut.rst
+++ b/doc/usage/cmd/ut.rst
@@ -11,7 +11,7 @@ Synopsis
 
 ::
 
-    ut [-r<runs>] [-f] [-I<n>:<one_test>] [<suite> [<test>]]
+    ut [-r<runs>] [-fs] [-I<n>:<one_test>] [<suite> [<test>]]
 
        <runs>      Number of times to run each test
        -f          Force 'manual' tests to run as well
@@ -30,7 +30,7 @@ includes a near-complete set of emulators, no code-size limits, many CONFIG
 options enabled and runs easily in CI without needing QEMU. It is also possible
 to run some tests on real boards.
 
-For a list of available test suites, type `ut` by itself.
+For a list of available test suites, type `ut info -s`.
 
 Each test is normally run once, although those marked with `UTF_DM` are
 run with livetree and flattree where possible. To run a test more than once,
@@ -56,36 +56,44 @@ write unit tests.
 Example
 -------
 
+Show information about tests::
+
+    => ut info
+    Test suites: 23
+    Total tests: 833
+
 List available unit-test suites::
 
-    => ut
-    ut - unit tests
-
-    Usage:
-    ut [-r] [-f] [<suite>] - run unit tests
-    -r<runs>   Number of times to run each test
-    -f         Force 'manual' tests to run as well
-    <suite>    Test suite to run, or all
-
-    Suites:
-    all - execute all enabled tests
-    addrmap - very basic test of addrmap command
-    bloblist - bloblist implementation
-    bootstd - standard boot implementation
-    compression - compressors and bootm decompression
-    dm - driver model
-    env - environment
-    fdt - fdt command
-    loadm - loadm command parameters and loading memory blob
-    lib - library functions
-    log - logging functions
-    mem - memory-related commands
-    overlay - device tree overlays
-    print  - printing things to the console
-    setexpr - setexpr command
-    str - basic test of string functions
-    time - very basic test of time functions
-    unicode - Unicode functions
+    => ut info -s
+    Test suites: 23
+    Total tests: 833
+
+    Tests  Suite         Purpose
+    -----  ------------  -------------------------
+        1  addrmap       very basic test of addrmap command
+        4  bdinfo        bdinfo (board info) command
+       14  bloblist      bloblist implementation
+        7  bootm         bootm command
+       66  bootstd       standard boot implementation
+        2  cmd           various commands
+       14  common        tests for common/ directory
+       502 dm            driver model
+        6  env           environment
+        1  exit          shell exit and variables
+       19  fdt           fdt command
+       10  fdt_overlay   device tree overlays
+        1  font          font command
+       20  hush          hush behaviour
+      115  lib           library functions
+        2  loadm         loadm command parameters and loading memory blob
+       18  log           logging functions
+        1  mbr           mbr command
+        1  measurement   TPM-based measured boot
+       13  mem           memory-related commands
+        1  pci_mps       PCI Express Maximum Payload Size
+       11  setexpr       setexpr command
+        4  upl           Universal payload support
+
 
 Run one of the suites::
 
@@ -112,9 +120,3 @@ Run just a single test in a suite::
     => ut bloblist bloblist_test_grow
     Test: bloblist_test_grow: bloblist.c
     Failures: 0
-
-Show information about tests::
-
-    => ut info
-    Test suites: 21
-    Total tests: 642
-- 
2.43.0

