Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45006C5472F
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 417B388BBE;
	Mon, 26 Aug 2024 21:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U3l5PEUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A480A88B59; Mon, 26 Aug 2024 21:12:04 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571BB88A7B
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39d37d9767dso16491885ab.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699521; x=1725304321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNidnTUABp95VXDCO3anqnF0kBZf04fJONvLxFcxt+Y=;
 b=U3l5PEURWPSv6SpX6mqtkTYAk8agOTlCsupAdOxkzZvFLeJMZNy6Tcp1jlek7FFKbh
 lT3wqqD01Ki267/NIx1bPb/uy5BsMUYu3h5zkIAzbiYxUMo1/Vw5s8PNBJEgntksZZO+
 +uWnqqk/WTTOnJcj9mGCDNVaZhJyPCrLSSNcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699521; x=1725304321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNidnTUABp95VXDCO3anqnF0kBZf04fJONvLxFcxt+Y=;
 b=ZKPkLPLr/niClPtZ9MJY9zjJL7PQUutBQgFbzNsIPzUtqxySLDNsZtLMtvLfQ7spDj
 yoZiiBTdXAiOVL3n12vrzxUKOmBZ4zBpfPFwpg4zxr1eKI7gSyPHKgwMPTs1uMP4Pq56
 q8RkigKXvF5j78XqqNE2BD4ntnsfZD0DEIE293DIRm5hqGmI/0IxxOyPUCLKVA3M+yxZ
 vSpghbkfLZAamNHARPQlgI+m9TfJ8PZHFYs2ovYgOwIgNpDO9eYkYhcTVVHme2I8xkOW
 NHupDAHCuQSCLQpahH/tmONrxVhL5A2E7r3oYdRVdo84fCwAND8zV8ZD8CI3sXszeX8k
 4m7Q==
X-Gm-Message-State: AOJu0Yw8XSxe+iZ5TXmTmQvpS8G2Af1lCvlM6EGy8Tm/eOmOlMMbTrTr
 DFHAIiz8Eb+AvdKTReXDNKQAYI6lmQeYN/82y00NLpb0X9lSjfPmPgSsBQXGYrPAqogJhaH4xBc
 =
X-Google-Smtp-Source: AGHT+IF12gv7BLA2Vg4sMxka8Sr4W6OI0XQt+HXfv6w5Pj3WAry+R7xss4JaJ3KyuDcB40qDOwNNZQ==
X-Received: by 2002:a05:6e02:214a:b0:39d:37de:4196 with SMTP id
 e9e14a558f8ab-39e63ea1c53mr7066845ab.18.1724699520745; 
 Mon, 26 Aug 2024 12:12:00 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:12:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/15] binman: Update fdt-list-dir to use the provided
 directory
Date: Mon, 26 Aug 2024 13:11:34 -0600
Message-Id: <20240826191143.426387-7-sjg@chromium.org>
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

Since the files are known to be in the provided directory, use that
instead of requiring it to be added to the list of input directories.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 10 ++++++++--
 tools/binman/ftest.py     |  7 ++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index f25226d3a73..51c82c55e4a 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -96,7 +96,10 @@ class Entry_fit(Entry_section):
             can be provided as a directory. Each .dtb file in the directory is
             processed, , e.g.::
 
-                fit,fdt-list-dir = "arch/arm/dts
+                fit,fdt-list-dir = "arch/arm/dts";
+
+            In this case the input directories are ignored and all devicetree
+            files must be in that directory.
 
     Substitutions
     ~~~~~~~~~~~~~
@@ -671,7 +674,10 @@ class Entry_fit(Entry_section):
                 # Generate nodes for each FDT
                 for seq, fdt_fname in enumerate(self._fdts):
                     node_name = node.name[1:].replace('SEQ', str(seq + 1))
-                    fname = tools.get_input_filename(fdt_fname + '.dtb')
+                    if self._fdt_dir:
+                        fname = os.path.join(self._fdt_dir, fdt_fname + '.dtb')
+                    else:
+                        fname = tools.get_input_filename(fdt_fname + '.dtb')
                     fdt_phase = None
                     with fsw.add_node(node_name):
                         for pname, prop in node.props.items():
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 50ba51f8b63..12cc3b78a6a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7626,7 +7626,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testFitFdtListDir(self):
         """Test an image with an FIT with FDT images using fit,fdt-list-dir"""
-        self.CheckFitFdt('333_fit_fdt_dir.dts', False)
+        old_dir = os.getcwd()
+        try:
+            os.chdir(self._indir)
+            self.CheckFitFdt('333_fit_fdt_dir.dts', False)
+        finally:
+            os.chdir(old_dir)
 
     def testFitFdtCompat(self):
         """Test an image with an FIT with compatible in the config nodes"""
-- 
2.34.1

