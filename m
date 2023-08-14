Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A873C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB07869CA;
	Tue, 15 Aug 2023 00:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bf5HVtVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE06D869D1; Tue, 15 Aug 2023 00:41:25 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B5ED869A2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34992058e95so21251755ab.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052882; x=1692657682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/x5wim2pCzHntdfUS2V+OTXuukxwhrG4wEA2msqwQA=;
 b=bf5HVtVu4XL+m7YYhtw5XWPAavJiYHbuw6y+AtuG3BIA3D3iu819IoMdKbpnhUvP3w
 xBiL0vEgEfL1Gg6mAOGTLkTwXf9CVEHpj4wO2BrYHVN3c4bNK/M4qY60VwTk8BkvkxDp
 8rqFTNvkBcf7jvt4xwIa7fsG002ijBG0dNPlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052882; x=1692657682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/x5wim2pCzHntdfUS2V+OTXuukxwhrG4wEA2msqwQA=;
 b=BgokjM7HU+5BMAoXrZWFvBqzsBVsbQBR8LvGoBVIcPE6ZkwVZj+kge/OeM4Sb4nkAR
 EZx8nMTfwlvoHA5BBRc1FmTfjRPb+1Ugw6+SVpTNguxDTHbA/pImHBtOeB02vNRElSe5
 DmwbjU/jfktAXukRTI3iHBgQeY3LeXT7NZ4ddp0ZugA/5sCEvH0YrjQPoNW3fZ6ujXs7
 /Tbb8zwN4X/Gy40Ms6oWSwhpSwiBeIYRL8zNNFv+c3amVAeKQaV3aLgmt4Se/+hMGvv1
 EJXnXf/RgdtpjaCZh8wzoZCU+77v3ri1Khx1/dHKEJ4+/hAy8w3W0KY8t39Xt7xl3RtZ
 FkrA==
X-Gm-Message-State: AOJu0YywhBtAL5AJgX/9Vt4YDJi6fOywA3ng96E5CqBU/SYLJ95/gm/Q
 ElPisLYA16xERr/zoSIQCa/ZW62GYnuV73/9QqA=
X-Google-Smtp-Source: AGHT+IG2A02AuGqYEsnERcXKV8FLqv0VzDCCMwi7hYUnQBoGkC0d2yLz3PgOdLmvwkuElBq0OHXITQ==
X-Received: by 2002:a05:6e02:1c0f:b0:349:501:12bd with SMTP id
 l15-20020a056e021c0f00b00349050112bdmr17571744ilh.20.1692052882230; 
 Mon, 14 Aug 2023 15:41:22 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 08/19] expo: Tidy up the expo.py tool and usage
Date: Mon, 14 Aug 2023 16:40:28 -0600
Message-ID: <20230814224047.535491-9-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

Tidy up this tool a little:

- define which arguments are needed
- split the enum values out into a header file
- warn if no enum values are found
- display the dtc error if something goes wrong
- avoid a Python traceback on error

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/expo.rst            | 37 +++++++++++++++++++--------------
 test/boot/files/expo_ids.h      | 25 ++++++++++++++++++++++
 test/boot/files/expo_layout.dts | 23 +-------------------
 test/py/tests/test_ut.py        |  4 +++-
 tools/expo.py                   | 22 +++++++++++++-------
 5 files changed, 65 insertions(+), 46 deletions(-)
 create mode 100644 test/boot/files/expo_ids.h

diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index 2ac4af232da4..0643283ae481 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -367,22 +367,27 @@ strings are provided inline in the nodes where they are used.
 
 ::
 
-    #define ID_PROMPT           1
-    #define ID_SCENE1           2
-    #define ID_SCENE1_TITLE     3
-
-    #define ID_CPU_SPEED        4
-    #define ID_CPU_SPEED_TITLE  5
-    #define ID_CPU_SPEED_1      6
-    #define ID_CPU_SPEED_2      7
-    #define ID_CPU_SPEED_3      8
-
-    #define ID_POWER_LOSS       9
-    #define ID_AC_OFF           10
-    #define ID_AC_ON            11
-    #define ID_AC_MEMORY        12
-
-    #define ID_DYNAMIC_START    13
+    /* this comment is parsed by the expo.py tool to insert the values below
+
+    enum {
+        ZERO,
+        ID_PROMPT,
+        ID_SCENE1,
+        ID_SCENE1_TITLE,
+
+        ID_CPU_SPEED,
+        ID_CPU_SPEED_TITLE,
+        ID_CPU_SPEED_1,
+        ID_CPU_SPEED_2,
+        ID_CPU_SPEED_3,
+
+        ID_POWER_LOSS,
+        ID_AC_OFF,
+        ID_AC_ON,
+        ID_AC_MEMORY,
+
+        ID_DYNAMIC_START,
+    */
 
     &cedit {
         dynamic-start = <ID_DYNAMIC_START>;
diff --git a/test/boot/files/expo_ids.h b/test/boot/files/expo_ids.h
new file mode 100644
index 000000000000..027d44bf38c5
--- /dev/null
+++ b/test/boot/files/expo_ids.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Sample expo screen layout (ID numbers)
+ */
+
+enum {
+	ZERO,
+	ID_PROMPT,
+
+	ID_SCENE1,
+	ID_SCENE1_TITLE,
+
+	ID_CPU_SPEED,
+	ID_CPU_SPEED_TITLE,
+	ID_CPU_SPEED_1,
+	ID_CPU_SPEED_2,
+	ID_CPU_SPEED_3,
+
+	ID_POWER_LOSS,
+	ID_AC_OFF,
+	ID_AC_ON,
+	ID_AC_MEMORY,
+
+	ID_DYNAMIC_START,
+};
diff --git a/test/boot/files/expo_layout.dts b/test/boot/files/expo_layout.dts
index 55d5c910dd5e..913140bace98 100644
--- a/test/boot/files/expo_layout.dts
+++ b/test/boot/files/expo_layout.dts
@@ -5,28 +5,7 @@
 
 /dts-v1/;
 
-/*
-enum {
-	ZERO,
-	ID_PROMPT,
-
-	ID_SCENE1,
-	ID_SCENE1_TITLE,
-
-	ID_CPU_SPEED,
-	ID_CPU_SPEED_TITLE,
-	ID_CPU_SPEED_1,
-	ID_CPU_SPEED_2,
-	ID_CPU_SPEED_3,
-
-	ID_POWER_LOSS,
-	ID_AC_OFF,
-	ID_AC_ON,
-	ID_AC_MEMORY,
-
-	ID_DYNAMIC_START,
-};
-*/
+/* see expo_ids.h for the IDs */
 
 / {
 	dynamic-start = <ID_DYNAMIC_START>;
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index aa1d477cd565..6a59c306322f 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -285,10 +285,12 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
 def setup_cedit_file(cons):
     infname = os.path.join(cons.config.source_dir,
                            'test/boot/files/expo_layout.dts')
+    inhname = os.path.join(cons.config.source_dir,
+                           'test/boot/files/expo_ids.h')
     expo_tool = os.path.join(cons.config.source_dir, 'tools/expo.py')
     outfname = 'cedit.dtb'
     u_boot_utils.run_and_log(
-        cons, f'{expo_tool} -e {infname} -l {infname} -o {outfname}')
+        cons, f'{expo_tool} -e {inhname} -l {infname} -o {outfname}')
 
 
 @pytest.mark.buildconfigspec('ut_dm')
diff --git a/tools/expo.py b/tools/expo.py
index c6eb87aec739..ea80c70f04e3 100755
--- a/tools/expo.py
+++ b/tools/expo.py
@@ -69,7 +69,10 @@ def calc_ids(fname):
 
 def run_expo(args):
     """Run the expo program"""
-    ids = calc_ids(args.enum_fname)
+    fname = args.enum_fname or args.layout
+    ids = calc_ids(fname)
+    if not ids:
+        print(f"Warning: No enum ID values found in file '{fname}'")
 
     indata = tools.read_file(args.layout)
 
@@ -88,10 +91,10 @@ def run_expo(args):
 
     with open('/tmp/asc', 'wb') as outf:
         outf.write(data)
-    proc = subprocess.run('dtc', input=data, capture_output=True, check=True)
+    proc = subprocess.run('dtc', input=data, capture_output=True)
     edtb = proc.stdout
     if proc.stderr:
-        print(proc.stderr)
+        print(f"Devicetree compiler error:\n{proc.stderr.decode('utf-8')}")
         return 1
     tools.write_file(args.outfile, edtb)
     return 0
@@ -109,11 +112,13 @@ def parse_args(argv):
             args is a list of string arguments
     """
     parser = argparse.ArgumentParser()
+    parser.add_argument('-D', '--debug', action='store_true',
+        help='Enable full debug traceback')
     parser.add_argument('-e', '--enum-fname', type=str,
-        help='C file containing enum declaration for expo items')
-    parser.add_argument('-l', '--layout', type=str,
-        help='Devicetree file source .dts for expo layout')
-    parser.add_argument('-o', '--outfile', type=str,
+        help='.dts or C file containing enum declaration for expo items')
+    parser.add_argument('-l', '--layout', type=str, required=True,
+        help='Devicetree file source .dts for expo layout (and perhaps enums)')
+    parser.add_argument('-o', '--outfile', type=str, required=True,
         help='Filename to write expo layout dtb')
 
     return parser.parse_args(argv)
@@ -122,6 +127,9 @@ def start_expo():
     """Start the expo program"""
     args = parse_args(sys.argv[1:])
 
+    if not args.debug:
+        sys.tracebacklimit = 0
+
     ret_code = run_expo(args)
     sys.exit(ret_code)
 
-- 
2.41.0.694.ge786442a9b-goog

