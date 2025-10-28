Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32775CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 11:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABA48832AD;
	Tue, 28 Oct 2025 12:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eSNuOQVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18FBC836C8; Tue, 28 Oct 2025 12:16:33 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB2A780422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 12:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b3b27b50090so1036885466b.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 04:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761650189; x=1762254989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lk0tsjCKL02ruLhPva2StDvfYsQp9WvwOI7WMCI0Lvg=;
 b=eSNuOQVOGQtArG7QMRnX/0b++8Uo9/44HQ0N3XR1CVqlb/l85S3bWMhbFZDq0XmKC/
 Moof5pBVCglgxzNuTdIkuCr04qZSwOAA4MaerZk2mQaXcJ8UK452TxpLynbNGssXWdt1
 xu+lfm+VR/UW227ByM54NjOHBlS7AgjLHPepUKvujeXVPksjnn5lUSEsPaXM1yyOhL+y
 9WOwRwDAmmHV9Mm9TtQUvKgm/m5FYbtbQCXAsVCG8iuwdX7/Bazu4z+t/UNy+8VbQZA9
 RX1DEY2N2tVmo1UBWVVh1PP7hextmwjJ7K4ajuH3Stm2YqILEKWA8SeH069+QXlSKwP5
 dNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761650189; x=1762254989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lk0tsjCKL02ruLhPva2StDvfYsQp9WvwOI7WMCI0Lvg=;
 b=caR2F7CO28z4KqUrAocg33EoWo1kNvgPmFuhCnsfMZptJ7bD1hDN9dblSA1lM+1JWy
 nF+Sbs5X1GdNAVE4jewQxfCrVvA/648VrMEtcXBzSMBgfltWuixM/ImbjbYGhelVQw8B
 oqTwkPCyihs3RD8+/axdaTDiJWa9V1mYEBGctC6Cuhgl5Ss+TwimYKUw7dC0Cz4S0QXN
 KA+o+Xyi/oOkvg9TkG//X7geY+t87uV9KzsNTAuu/48tJYN9P4Pj8dnPAnnYY6MAKjpG
 q2GjYcyUQxa2AmBDEFcMRDmeMeIeRa3rcY6oPfKM6+KwreyJhD3Yp/fObOsPCJPZAvwi
 zbMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyt0F2qnVABP1jhZK8c0hQaucsflxf9UnDkHvhAUKgDRR330GP+lvabi73MTAn8fwgF+/UmXE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjfo4KOju/LdW5doNXAukbzbFYhq5Ea8smS3d/6g8RMsZXDjQz
 3Yb5OcOLwKrTp8hy04oZVhTUwy19nF52GdQdlX169sGZEo5judxPcyam88ZNx/dSc94=
X-Gm-Gg: ASbGncuU6LoKJ5xDerUr7xC+DKXY5ZZ04suZ/KtJS8srGiGozLntdfNmHhyNZmIvs9+
 TkxRmJi5YUknv8e8vRYB8JzyCShm64Jf6piyvpkOJT3SivYq9ZTeQ3Fag8frpfGiq3a80zWASmS
 z9CyImLJ0slpgL4udaJXXVqJLUPQ7kdTdWP0+pUWwEqmoJSQVomG1osYUwxzy4n3AKkMbY5SRCm
 MrhyHdeGi5pJVo4fzMjry0Tk+qhIIgtS4wTvVsyOZA36LcLUFqv3b5oFndymALIwnvGkxqmmG6R
 eMarPUuYj6bsokCpYxAmDpY71lKZLRORhGijUZjxTE5f6qXcnKYwqPg2c7Xiaw7wNYW1a7oVMhW
 w0JBrqRYOZvhb0cyECfEvT/Xks9nQfBDc3pYeUq4tw9kGI6jO0p6pBpzY2rwtiqa+F0lbQZQSKr
 E0VyBH953rfUsJp8c4PxtxKG8udeueH4Nz8t9QNIbO4z2uhkfcvGzm
X-Google-Smtp-Source: AGHT+IEd5s/46SI0YMvNHSNAcQ7JjnGvncantA4CBl2q6NCIqqTHs9rAR4vgnh6hfMW0fSnXYYEeiQ==
X-Received: by 2002:a17:907:6e90:b0:b6d:7f84:633 with SMTP id
 a640c23a62f3a-b6dba487aabmr329039966b.20.1761650189282; 
 Tue, 28 Oct 2025 04:16:29 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85308c8dsm1068688266b.0.2025.10.28.04.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 04:16:28 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] binman: fix mkmbn integration and tests
Date: Tue, 28 Oct 2025 12:15:07 +0100
Message-ID: <20251028111604.2510314-2-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Add the missing cryptography requirement to binman so that mkmbn
will work correctly, fix a pylint error, and adjust mkmbn to properly
integrate into binman rather than writing the output file directly.

For now skip testing u_boot_mbn since it has some weird requirements due
to how mkmbn works and can't be easily integrated into binman.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
Changes since v1:
- Remove mkmbn elf class fixup, it's a separate patch now
- Link to v1: https://lore.kernel.org/u-boot/20251023133850.3686431-1-casey.connolly@linaro.org

---
 tools/binman/btool/mkmbn.py      | 9 ++-------
 tools/binman/etype/u_boot_mbn.py | 5 +++--
 tools/binman/main.py             | 4 +++-
 tools/binman/requirements.txt    | 1 +
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/binman/btool/mkmbn.py b/tools/binman/btool/mkmbn.py
index 232e2b442a16..c1439977833e 100644
--- a/tools/binman/btool/mkmbn.py
+++ b/tools/binman/btool/mkmbn.py
@@ -12,18 +12,13 @@ class Bintoolmkmbn(bintool.Bintool):
     def __init__(self, name):
         super().__init__(name, 'Generate MBN (signed ELF) image for U-Boot')
 
     # pylint: disable=R0913
-    def run(self, infile: str) -> CommandResult:
+    def run(self, infile: str, outfile:  str) -> CommandResult:
         """Run mkmbn.py
         """
-        args = [infile]
+        args = ['-o', outfile, infile]
         return self.run_cmd_result(*args, raise_on_error=False)
 
 
-    def get_path(self):
-        path = super().get_path()
-        return path
-
-
     def fetch(self, _method):
         return True
diff --git a/tools/binman/etype/u_boot_mbn.py b/tools/binman/etype/u_boot_mbn.py
index e470b31fa318..6268397fd122 100644
--- a/tools/binman/etype/u_boot_mbn.py
+++ b/tools/binman/etype/u_boot_mbn.py
@@ -31,10 +31,11 @@ class Entry_u_boot_mbn(Entry_blob):
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
 
     def ObtainContents(self):
-        self._pathname = tools.get_input_filename('u-boot.bin')
-        res = self.mkmbn.run(self._pathname)
+        pathname = tools.get_input_filename('u-boot.bin')
+        self._pathname = tools.get_output_filename('u-boot.mbn')
+        res = self.mkmbn.run(pathname, self._pathname)
         if res is None:
             self.Raise('mkmbn not found or failed!')
         # Exit code 61 (ENODATA) indicates that an MBN file can't be built
         # for this board. This is non-fatal since it may not be required.
diff --git a/tools/binman/main.py b/tools/binman/main.py
index fa5ad79ca0e8..bfd6e990d2e4 100755
--- a/tools/binman/main.py
+++ b/tools/binman/main.py
@@ -102,9 +102,11 @@ def RunTestCoverage(toolpath, build_dir, args):
              'tools/u_boot_pylib/*'],
             build_dir, all_set, extra_args or None, args=args,
             allow_failures=['tools/binman/btool/cst.py',
                             'tools/binman/etype/nxp_imx8mcst.py',
-                            'tools/binman/etype/nxp_imx8mimage.py'])
+                            'tools/binman/etype/nxp_imx8mimage.py',
+                            'tools/binman/etype/u_boot_mbn.py',
+                            'tools/binman/btool/mkmbn.py'])
 
 def RunBinman(args):
     """Main entry point to binman once arguments are parsed
 
diff --git a/tools/binman/requirements.txt b/tools/binman/requirements.txt
index 7db72e888e3e..51b8ecd73478 100644
--- a/tools/binman/requirements.txt
+++ b/tools/binman/requirements.txt
@@ -3,4 +3,5 @@ importlib_resources==6.5.2
 jsonschema==4.23.0
 pycryptodomex==3.21.0
 pyelftools==0.31
 yamllint==1.35.1
+cryptography==46.0.3 # for mkmbn
-- 
2.51.0

