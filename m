Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA13FD45FA
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 22:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F298183E76;
	Wed, 25 Feb 2026 23:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G5akQBml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2088A82A9E; Wed, 25 Feb 2026 23:51:23 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F2383E61
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 23:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-899a98c2421so4355736d6.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772059879; x=1772664679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTL08iQqvjaa0/H2MGZyKDxQ2LVWN7gkmzWV2Cst64I=;
 b=G5akQBml1AcdQJbNdDjgrSTiNEN4A7B13jmXElCHwqVA6idcrkI1jRKTUTNlfgj4O/
 C4BtzkXJPUoO7BYfIgAU13LYqqajKknCe5NiMBT0DBfLH7auhjOVUfk4eDiwN/ZvVsfM
 PLDJOrL3qUqQc+fD/Y5xZJCsg2O7NTSeUVEts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772059879; x=1772664679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zTL08iQqvjaa0/H2MGZyKDxQ2LVWN7gkmzWV2Cst64I=;
 b=Oe2k3Cs2M+o9DaWDGMZsjkHeyZCVAqWOxlKXqWl4/F8fxTW/JJrRf0i1Me+RVfFJvT
 stdLtz0PwWcTVBX32FckIe32Lx3EHad/2njDzDgbIFsltKsvhROnzpoWETRoCvgMIJrp
 3fzglk+PbvafuxlwtwZpTkgHgbQadowwbz3UoZ2tUzKbei+cyY4ME6ipat7BLl10U82U
 boixdupy9Ap4L7WT8usaaP8PWGBQ8s+X7l96EYsSOkZL+nc4bKEehL6bp3zghutdHlr9
 F2EoZuWnnzDHWEdUF6ddgTjvvZmBKjbMY0AwGVB2wzUqDpSKAF1W+p3i/VjKmygsA2pp
 pBuA==
X-Gm-Message-State: AOJu0YxFuZr7zuFX69R2mZkFhnSWNPEAuBuUqmF9V8I+gLuNbRWlkJj2
 V3wgCcib7dWfm1AQwyWFHn1iXMENvst06A+iIdjN1eZCIZZ3zrf5fEWSJol67NhYFTOnl3J43WL
 o4K8=
X-Gm-Gg: ATEYQzxKql8Pp2PnJ2Bah9qBIf3uOnFitRf4OGFM6e0qH9Wn7S9Y4ezjegPk4PWxxU4
 SK2zh4HR/Zg5DBrBsPGai3MBC8al0ymBU0268MKi9xMPog+yC6TttQI46q5AtGBfRDRD5sa6ILU
 erOZhK+etbOr6U+Pz1Bghi/0eZ8ftZSHb5GSTYJhJiwvWGEpPy3sMCdggwni2kV6/I4RxcKNFob
 LlxCTWwi7RURgoPg6vnJk9C85z5uI2cblMwcO5atTABt5eLV0O+0pL5g7FJa/LayW/Spge0uaya
 Tx97JrFuo/ryIouOYK3QhTjg8kMZ/o0LaBT7kCGYlIAsDjRtzWkp7JucT8JoWJjnmDsZ2wUsjaF
 hqFPaNC3gFSo0JtRr9ooZxbHEF3BriozVJB9PZeYk3U0IdNPRqbjWfhTkocnX5DHwijH9ob3NEO
 YCg0UkKq8WQdTCYe0M5A==
X-Received: by 2002:a05:6214:40d:b0:895:4aa6:8a17 with SMTP id
 6a1803df08f44-899c1e9d678mr32781386d6.50.1772059879244; 
 Wed, 25 Feb 2026 14:51:19 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf72e21bsm43730985a.44.2026.02.25.14.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:51:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 2/6] binman: test: Drop the number prefix from non-dts test
 files
Date: Wed, 25 Feb 2026 15:50:31 -0700
Message-ID: <20260225225040.2568118-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225225040.2568118-1-sjg@chromium.org>
References: <20260225225040.2568118-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

The non-dts files should not be numbered. Remove the 340_ prefix from
several fies and update ftest.py to match.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/binman/ftest.py                            | 16 ++++++++--------
 .../{340_dummy-rsa4096.crt => dummy-rsa4096.crt} |  0
 .../test/{340_openssl.conf => openssl.conf}      |  0
 .../binman/test/{340_rsa2048.key => rsa2048.key} |  0
 .../test/{340_softhsm2.conf => softhsm2.conf}    |  0
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename tools/binman/test/{340_dummy-rsa4096.crt => dummy-rsa4096.crt} (100%)
 rename tools/binman/test/{340_openssl.conf => openssl.conf} (100%)
 rename tools/binman/test/{340_rsa2048.key => rsa2048.key} (100%)
 rename tools/binman/test/{340_softhsm2.conf => softhsm2.conf} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 208ac3896dd..202c2adf58d 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7926,7 +7926,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'default-dt': 'test-fdt1',
             'atf-bl31-path': 'bl31.elf',
         }
-        data = tools.read_file(self.TestFile("340_rsa2048.key"))
+        data = tools.read_file(self.TestFile("rsa2048.key"))
         self._MakeInputFile("keys/rsa2048.key", data)
 
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
@@ -7963,7 +7963,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'atf-bl31-path': 'bl31.elf',
         }
 
-        x509_pubkey = '340_dummy-rsa4096.crt'
+        x509_pubkey = 'dummy-rsa4096.crt'
         data = tools.read_file(self.TestFile(x509_pubkey))
         self._MakeInputFile('dev.crt', data)
 
@@ -8038,7 +8038,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         prefix = "testFitSignPKCS11Simple."
         # Configure SoftHSMv2
-        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
+        data = tools.read_file(self.TestFile('softhsm2.conf'))
         softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
         softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
 
@@ -8069,7 +8069,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
 
         # Make OpenSSL use softhsm2 engine
-        ossl_conf = self.TestFile('340_openssl.conf')
+        ossl_conf = self.TestFile('openssl.conf')
         with unittest.mock.patch.dict('os.environ',
                                       {'OPENSSL_CONF': ossl_conf,
                                        'SOFTHSM2_CONF': softhsm2_conf}):
@@ -8113,7 +8113,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         prefix = "testFitSignPKCS11Object."
         # Configure SoftHSMv2
-        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
+        data = tools.read_file(self.TestFile('softhsm2.conf'))
         softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
         softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
 
@@ -8146,7 +8146,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         # Make OpenSSL use softhsm2 engine and configure PIN for token
         # The PIN is incorrect on purpose, the correct one will be passed by
         # MKIMAGE_SIGN_PIN
-        ossl_conf = self.TestFile('340_openssl.conf')
+        ossl_conf = self.TestFile('openssl.conf')
         with unittest.mock.patch.dict('os.environ',
                                       {'OPENSSL_CONF': ossl_conf,
                                        'SOFTHSM2_CONF': softhsm2_conf,
@@ -8203,9 +8203,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'default-dt': 'test-fdt1',
             'atf-bl31-path': 'bl31.elf',
         }
-        data = tools.read_file(self.TestFile("340_rsa2048.key"))
+        data = tools.read_file(self.TestFile("rsa2048.key"))
         self._MakeInputFile("keys1/rsa2048.key", data)
-        data = tools.read_file(self.TestFile("340_rsa2048.key"))
+        data = tools.read_file(self.TestFile("rsa2048.key"))
         self._MakeInputFile("keys2/conf-rsa2048.key", data)
 
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
diff --git a/tools/binman/test/340_dummy-rsa4096.crt b/tools/binman/test/dummy-rsa4096.crt
similarity index 100%
rename from tools/binman/test/340_dummy-rsa4096.crt
rename to tools/binman/test/dummy-rsa4096.crt
diff --git a/tools/binman/test/340_openssl.conf b/tools/binman/test/openssl.conf
similarity index 100%
rename from tools/binman/test/340_openssl.conf
rename to tools/binman/test/openssl.conf
diff --git a/tools/binman/test/340_rsa2048.key b/tools/binman/test/rsa2048.key
similarity index 100%
rename from tools/binman/test/340_rsa2048.key
rename to tools/binman/test/rsa2048.key
diff --git a/tools/binman/test/340_softhsm2.conf b/tools/binman/test/softhsm2.conf
similarity index 100%
rename from tools/binman/test/340_softhsm2.conf
rename to tools/binman/test/softhsm2.conf
-- 
2.43.0

