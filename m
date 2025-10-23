Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C966CCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 13:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E253C8006D;
	Thu, 23 Oct 2025 15:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jLm2qj1f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9AEE82E34; Thu, 23 Oct 2025 15:38:57 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A468003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 15:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso576359f8f.0
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761226735; x=1761831535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yT55aSkyinJN84SXXJ6GmKDK2mxhYd71YSs3KtQx1kA=;
 b=jLm2qj1fLRmcQZF5s8lR4HybuwYgOh+8k+Iwh9mQxpO1/O1aa1nE+9MDIYntwFpFGK
 rVHyOQaiN047SCpGnaOudcWSjDaRaR66pzP7gcha6EWg2ChLxxcmIXy9zufCHxgP6Hoy
 K3wSFenbbR4GRsTmncwiqSGeg2HsUd/HFHajv5d7jYJG60Gx0JFH0NAEShbPkAEDAFL0
 4uEqywYVNVIqSawB5rit42ra868ROwnEWNacJwwLHai06V5lH553RQc4zniSRD8abbxh
 1CB94mNPo89cFeCO3qoiwvWhe6ZekN+9Qp439mK1wBy+tegURR5bOgDgqjVZ57FY+Z3X
 siDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761226735; x=1761831535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yT55aSkyinJN84SXXJ6GmKDK2mxhYd71YSs3KtQx1kA=;
 b=FZ0PH9T9fwfh8tYWBagP3l1TeOv6FMV/OgM/C15YrYc/KKv0p01phbtdgmNqhNWuB1
 YSmJ4IIteAA4o/K6LHCTxB4rj0G5cal6xGCeaV11zt0nePNrZYAPrM+fJJTUXcWSkXZc
 EDRiUlvTjWhRfxixo+sikszd9GtFAtWgfWB7G/UIA+8aV9iUXC7g91RVeP1KhZfBuOnh
 ha+7M6qqSVvW7JgDCVjOvlkpdh14g3iGgwdHRGolK+06OiTlWaEJ/d7b+fhcJaREE6sf
 krHs1d9XzEkly8u6qy9Dr8xByuQVO6K5tLg+NOdPGExkHmyeBur2YfT9yPQrLJpQPMPK
 0A1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcZFklwABHH2AgIhN+xWYKlZBK3L+lcQTnhXRnBP3/3Ikx7fUYbgEC4jgzYJFgUNZuOmMC+6M=@lists.denx.de
X-Gm-Message-State: AOJu0Yyz9NJdgv29IwHyDD5jVptrvUKSijDxJDx77QcoXLwBO+QB2cmy
 GgiGCY4icH+ysdPJT63JV8u/KdfOmXIyxA0UQc4UM414Xl+R9n7EWoqZuJw3u2h1MO8=
X-Gm-Gg: ASbGncvgUPURDzuqxnY1dFACwdBG2Rv9+JpUlqpjvXsGSden19681OyuwNRQfhs2V28
 72rfvwFvqO4lErkmvWqYfZCzfZCyTlRyuQOgxrOJ10diT4Vv4+0t/yt/7MUGzfZ0YHSgfm/foSO
 wLap8mZjZJPf/tUZBguDsDV/VA8Im4Fgd84ipAesQMMyjFPhqovMmzdrU018aQuxZKLeMqe7/HW
 C4bDd6tqHv2RmyRbCAOSABfjbWrDBmTwl7aP4zMycsYfqOrU0OnL9Tl3RDU+rZ8FvUGwI9roxdE
 4OlzB/zjUSfyQveLzQ7+cZuvMsaCQpfXQuQWtxvWWubbPu7NGWWGiyv2s1FENcAmbqVi8a7TRlk
 3AAM5BAp6jWoQPDfIECbWKfjGlh7yc9iB+Rgw84LZEaHeAMKJZvLCSGn3/QwVvUNLZq3W0fF3Jd
 p8yMTgsHjYZBHLwvplNAX4WQOQ5ipnuzNJGCSaL684Gam6w8y6Gw3h126Q96HFd6s=
X-Google-Smtp-Source: AGHT+IFA1VWPVjBJEEiFaRMXo7QJSuAe2/c5zkrTNVOy8Ilw2fUBqg/hOnW4gM7ck1o96rSX98XtAw==
X-Received: by 2002:a05:6000:1ac5:b0:425:8c14:1de0 with SMTP id
 ffacd0b85a97d-42704db4899mr17487556f8f.61.1761226734801; 
 Thu, 23 Oct 2025 06:38:54 -0700 (PDT)
Received: from lion.tail248178.ts.net (p4fc3da2c.dip0.t-ipconnect.de.
 [79.195.218.44]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898add8bsm3906118f8f.23.2025.10.23.06.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 06:38:53 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH RESEND] binman: fix mkmbn integration and tests
Date: Thu, 23 Oct 2025 15:38:26 +0200
Message-ID: <20251023133850.3686431-1-casey.connolly@linaro.org>
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
Resent to fix my name
---
 tools/binman/btool/mkmbn.py      | 9 ++-------
 tools/binman/etype/u_boot_mbn.py | 5 +++--
 tools/binman/main.py             | 4 +++-
 tools/binman/requirements.txt    | 1 +
 tools/qcom/mkmbn/elf.py          | 6 +++---
 5 files changed, 12 insertions(+), 13 deletions(-)

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
diff --git a/tools/qcom/mkmbn/elf.py b/tools/qcom/mkmbn/elf.py
index 86f12d1f4e5d..7737adc6a4e2 100644
--- a/tools/qcom/mkmbn/elf.py
+++ b/tools/qcom/mkmbn/elf.py
@@ -171,11 +171,11 @@ def _align(i: int, alignment: int) -> int:
 class Elf:
 	ehdr: Ehdr
 	phdrs: List[Phdr]
 
-	def __init__(self):
-		self.ehdr = Ehdr()
-		self.phdrs: List[Phdr] = []
+	def __init__(self, ehdr: Ehdr | None = None, phdrs: List[Phdr] | None = None):
+		self.ehdr = ehdr or Ehdr()
+		self.phdrs: List[Phdr] = phdrs or []
 
 	def total_header_size(self):
 		return self.ehdr.e_phoff + len(self.phdrs) * self.ehdr.e_phentsize
 
-- 
2.51.0

