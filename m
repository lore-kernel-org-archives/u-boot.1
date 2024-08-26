Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104C8C5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC0788BC0;
	Mon, 26 Aug 2024 21:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V8ZaR/Pb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9490A88C29; Mon, 26 Aug 2024 21:12:08 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 730118842C
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f861f369aso185411439f.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699525; x=1725304325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYgeZqqhmGXUqvWkIovpWX8UMRyTK8ljE4KpyWMMCbo=;
 b=V8ZaR/PbhNKWHPWLvQm4SHBDuYUvNbjcMvQ9JmZqb/Rw8QIu026OXl25ekPhkg6hnl
 dikL9uAXg0MTDhl4yIO2Tyz3n7BghGHPKEvYPiPUwhkB6yR7LVjXGEwLxyhJQZSNfqvh
 DPCw6IIU2MpqLvpOFjp23uZT/GzJ62L2fSv5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699525; x=1725304325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYgeZqqhmGXUqvWkIovpWX8UMRyTK8ljE4KpyWMMCbo=;
 b=LO+hOSXK09SJXpghCkcRmruxCEv4RJ72XdynIetad0nMnb3QDXcbV9d7sfAg8jaxHG
 8SJs03tyI6yJlEwWaRxOifzvg2iJZez6w/ysLu9glweknUr4nvotWnG3vwSztzanwV9/
 sNqPD4IEegJXlyfi5GmStzsXNhcQ9Rkg7PcG4POCFMcky6M60FF1iC4EQgv33VlEzpXH
 /ysH3llDzCSljeTyCIvc12+4lnkeskV6NFPoGFnacrT5el3p2Y/521tphX1VOxCVENol
 lQIMkZ/S1C51ai9cGyT6MrIviEkZjhKnKWyaJQIupCntfa/HaULCBFNi92/CsD7b+Spw
 JjPA==
X-Gm-Message-State: AOJu0YxcOAezcd5b/d+Hr1guBZG7UvPHsm9YRCBu86jr3Q0L3HwCRYps
 GBkrEBqXtQCAVzl2A3sHqa0nldaG17OukDTkYS/XauNiuWOK+phPuAynCSvRILAtG/8Fs1rBF/g
 =
X-Google-Smtp-Source: AGHT+IFInLymM6/qheJS5kSKTVsimekSmutGnoqHIr1WieKR4J6GZ/ORX/ednb/Fl5dYD16oCjUJFQ==
X-Received: by 2002:a05:6e02:13aa:b0:39b:3244:a355 with SMTP id
 e9e14a558f8ab-39e640059e0mr5455155ab.11.1724699524801; 
 Mon, 26 Aug 2024 12:12:04 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:12:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/15] binman: fit: Refine handling of devicetrees for
 OF_UPSTREAM
Date: Mon, 26 Aug 2024 13:11:37 -0600
Message-Id: <20240826191143.426387-10-sjg@chromium.org>
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

With OF_UPSTREAM the dts files are in an SoC-specific subdirectory,
meaning that the resulting dtb files all end up in a similar
subdirectory.

We don't want the subdirectory name to appear as a node name in the FIT,
so handle this as a special case.

Also the default devicetree may have a directory-name prefix, so handle
that when searching through the available devicetree files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 19 ++++++++++++-------
 tools/binman/ftest.py     | 15 ++++++++++++++-
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 96f4fdf3333..0abe1c78c43 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -600,13 +600,17 @@ class Entry_fit(Entry_section):
                 if val.startswith('@'):
                     if not self._fdts:
                         return
-                    if not self._fit_default_dt:
+                    default_dt = self._fit_default_dt
+                    if not default_dt:
                         self.Raise("Generated 'default' node requires default-dt entry argument")
-                    if self._fit_default_dt not in self._fdts:
-                        self.Raise(
-                            f"default-dt entry argument '{self._fit_default_dt}' "
-                            f"not found in fdt list: {', '.join(self._fdts)}")
-                    seq = self._fdts.index(self._fit_default_dt)
+                    if default_dt not in self._fdts:
+                        if self._fdt_dir:
+                            default_dt = os.path.basename(default_dt)
+                        if default_dt not in self._fdts:
+                            self.Raise(
+                                f"default-dt entry argument '{self._fit_default_dt}' "
+                                f"not found in fdt list: {', '.join(self._fdts)}")
+                    seq = self._fdts.index(default_dt)
                     val = val[1:].replace('DEFAULT-SEQ', str(seq + 1))
                     fsw.property_string(pname, val)
                     return
@@ -711,8 +715,9 @@ class Entry_fit(Entry_section):
                         # Add data for 'images' nodes (but not 'config')
                         if depth == 1 and in_images:
                             if fdt_phase:
+                                leaf = os.path.basename(fdt_fname)
                                 phase_fname = tools.get_output_filename(
-                                    f'{fdt_fname}-{fdt_phase}.dtb')
+                                    f'{leaf}-{fdt_phase}.dtb')
                                 self._run_fdtgrep(fname, fdt_phase, phase_fname)
                                 data = tools.read_file(phase_fname)
                             else:
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 12cc3b78a6a..56deece7230 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4183,7 +4183,8 @@ class TestFunctional(unittest.TestCase):
         data = self._DoReadFile('172_scp.dts')
         self.assertEqual(SCP_DATA, data[:len(SCP_DATA)])
 
-    def CheckFitFdt(self, dts='170_fit_fdt.dts', use_fdt_list=True):
+    def CheckFitFdt(self, dts='170_fit_fdt.dts', use_fdt_list=True,
+                    default_dt=None):
         """Check an image with an FIT with multiple FDT images"""
         def _CheckFdt(seq, expected_data):
             """Check the FDT nodes
@@ -4227,6 +4228,8 @@ class TestFunctional(unittest.TestCase):
         }
         if use_fdt_list:
             entry_args['of-list'] = 'test-fdt1 test-fdt2'
+        if default_dt:
+            entry_args['default-dt'] = default_dt
         data = self._DoReadFileDtb(
             dts,
             entry_args=entry_args,
@@ -7633,6 +7636,16 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         finally:
             os.chdir(old_dir)
 
+    def testFitFdtListDirDefault(self):
+        """Test an FIT fit,fdt-list-dir where the default DT in is a subdir"""
+        old_dir = os.getcwd()
+        try:
+            os.chdir(self._indir)
+            self.CheckFitFdt('333_fit_fdt_dir.dts', False,
+                             default_dt='rockchip/test-fdt2')
+        finally:
+            os.chdir(old_dir)
+
     def testFitFdtCompat(self):
         """Test an image with an FIT with compatible in the config nodes"""
         entry_args = {
-- 
2.34.1

