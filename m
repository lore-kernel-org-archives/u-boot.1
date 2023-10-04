Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B85E7B5F4
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4241C86477;
	Wed,  4 Oct 2023 13:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76AA874DC; Wed,  4 Oct 2023 13:27:54 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2389E874DC
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 371EADA7;
 Wed,  4 Oct 2023 04:28:30 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57EC63F762;
 Wed,  4 Oct 2023 04:27:49 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 4/5] btool: mkeficapsule: Add support for EFI empty capsule
 generation
Date: Wed,  4 Oct 2023 16:57:21 +0530
Message-Id: <20231004112722.416877-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004112722.416877-1-sughosh.ganu@linaro.org>
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
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

Add a method to the mkeficapsule bintool to generate empty
capsules. These are capsules needed for the FWU A/B update feature.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 tools/binman/btool/mkeficapsule.py | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index 61179747ff..89c0adfc9f 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -80,6 +80,35 @@ class Bintoolmkeficapsule(bintool.Bintool):
 
         return self.run_cmd(*args)
 
+    def generate_empty_capsule(self, accept, revert, image_guid,
+                               output_fname):
+        """Generate empty capsules for FWU A/B updates
+
+        Args:
+            accept (int): Generate an accept capsule
+            revert (int): Generate a revert capsule
+            image_guid (str): GUID used for identifying the image
+            output_fname (str): Path to the output capsule file
+
+        Returns:
+            str: Tool output
+        """
+        if accept:
+            args = [
+                f'--guid={image_guid}',
+                '--fw-accept'
+            ]
+        elif revert:
+            args = [
+                '--fw-revert'
+            ]
+
+        args += [
+            output_fname
+        ]
+
+        return self.run_cmd(*args)
+
     def fetch(self, method):
         """Fetch handler for mkeficapsule
 
-- 
2.34.1

