Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E628EC8748
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 12:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9F786993;
	Fri,  8 Sep 2023 14:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A8D86A3A; Fri,  8 Sep 2023 14:00:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C384F86A1D
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 14:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 483971007;
 Fri,  8 Sep 2023 05:01:09 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D65A13F67D;
 Fri,  8 Sep 2023 05:00:28 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 2/8] btool: mkeficapsule: Generate capsule through a config
 file
Date: Fri,  8 Sep 2023 17:29:56 +0530
Message-Id: <20230908120002.29851-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908120002.29851-1-sughosh.ganu@linaro.org>
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
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

Add support to the mkeficapsule bintool for generating EFI capsules
through a config file.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 tools/binman/btool/mkeficapsule.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index 61179747ff..b0599aa506 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -20,6 +20,7 @@ Options:
 	-A, --fw-accept  firmware accept capsule, requires GUID, no image blob
 	-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob
 	-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff
+	-f, --cfg-file <config file> config file with capsule parameters
 	-h, --help                  print a help message
 """
 
@@ -80,6 +81,21 @@ class Bintoolmkeficapsule(bintool.Bintool):
 
         return self.run_cmd(*args)
 
+    def generate_capsule_cfg_file(self, cfg_file):
+        """Generate a capsule reading parameters from config file
+
+        Args:
+            cfg_file (str): Path to the config file
+
+        Returns:
+            None
+        """
+        args = [
+            f'--cfg-file={cfg_file}'
+        ]
+
+        self.run_cmd(*args)
+
     def fetch(self, method):
         """Fetch handler for mkeficapsule
 
-- 
2.34.1

