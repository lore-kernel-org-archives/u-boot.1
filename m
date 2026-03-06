Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E666FCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408D284068;
	Fri,  6 Mar 2026 19:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IAsA5oM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F2984067; Fri,  6 Mar 2026 19:14:18 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA7818401A
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:14:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8cd767d2d70so4786985a.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820854; x=1773425654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T54+6IIkF3Oxy41ODbMVjmE2DIPJ3EYVV1g6uvRhf+U=;
 b=IAsA5oM6duxEoTZx4Znt4e1dnYlcTsp1+1Tnlds6JCWVSkdgToVN0+qytYkfabjPhR
 tqKMplwtvpWq+e17LitUVlkTSMGyyZXQuKnkEe/AY1t7tnZk0RGQGUJIn3EBRJKWR0ST
 kyG8j/L/ohfpuQcbDk1UYXvkN9N3ie788JX64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820854; x=1773425654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T54+6IIkF3Oxy41ODbMVjmE2DIPJ3EYVV1g6uvRhf+U=;
 b=g3CYGIfT8rqUoyzN+4dLTeXHyeMT59IHs11l1QP6pyXR/McdWmqOovk4C6m8fcPirt
 rvI96nxrHNoTJe4/PyU750hxITbh/Q64uXga0TrKKAlsti5nSDXwPUkeXRGl3r7tY7RL
 xf0qp3DwNlxCQTHbfe4BJxjgM5uU7Q9ptlc5qT8hgx0SDTVtw4Hm8ZFD3Bcs3lgjqJw/
 adU3Kg7wybeXkhgXChFPhOqnI4DEQfm9RL22/egN9yTOMKbyCnFuC+DwGFhVDR1Isyfk
 oHEiLBwp6Q6wUAqfLoGh/gupUIWmeh1XowkhcYqRmYnLBTkRl55BT4ovxBwkGq+d0SHc
 GNsw==
X-Gm-Message-State: AOJu0YzuTjyPUgkRz7cnUQ/jP9C8u8x/+fBNH5V9+Ebnl7q9YduMViLA
 G5DMaRQlCnkp9dITkZX5uq6UHZaO3dbVB6l5+44DwPLnS7suXRqR8UxUwDnhQT6AK8yg5JCgYpo
 rgdA=
X-Gm-Gg: ATEYQzwA/ne8vTnqie+HRW2DA7vujzfjXTJxUtPzR0ggDPJ2DavhcHN3hgtdX/a7QP7
 28Oyxr7IO0r3AFminWxFiBTeNB2q/T3M0FOcVqTdfepyLsDHy3S+TK3JrFi5QGXheOuvudpxBz6
 VqDzqW+nSaWGWSxrUZSViC9vHZ7MwDBTI6bvAQnj7cKSMbTgsfkVCgbII4EYv1RkFq3knuM0DdR
 ZCeMN2GOO++G10R9tE6FMpvuZ2dLm6CaYjbhoPw33KaofPaXa//nulGgj0jbDSuuYjBCIW0TyQg
 HcZeJJ4lOQ4drutS+Ie05aXsqWtVhaN6Ao90tGutAB1Y4Nw+hcLojJYDfxJWuIloPSzjZVJBt6q
 7dWYhG+1ifL+K9SrVBdcZ96CypkAbvmHqpl9Oe2ZnZTl8UR+Dz7WhD7OcyVJgUaFPmraeI2bl2R
 bOWlWgSUKevgyxpYF++w==
X-Received: by 2002:a05:620a:290e:b0:8cb:d9a2:1347 with SMTP id
 af79cd13be357-8cd6d464c4amr380992485a.57.1772820854230; 
 Fri, 06 Mar 2026 10:14:14 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:14:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 18/23] binman: test: Move FIT signing test data to test/fit/
Date: Fri,  6 Mar 2026 11:12:46 -0700
Message-ID: <20260306181304.2426352-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306181304.2426352-1-sjg@chromium.org>
References: <20260306181304.2426352-1-sjg@chromium.org>
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

Move the signing-related test data (keys, certificates, OpenSSL and
SoftHSM2 configuration, dummy engine source) into the fit/ subdirectory
alongside the FIT DTS test files. Drop the 340_ prefix from files that
had it. Update the Makefile and all ftest.py references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Add new patch to move FIT signing test data

 tools/binman/ftest.py                         |  20 +++++++++---------
 tools/binman/test/Makefile                    |   2 +-
 tools/binman/test/{ => fit}/aes256.bin        | Bin
 .../binman/test/{ => fit}/dummy-rsa-engine.c  |   0
 .../dummy-rsa4096.crt}                        |   0
 .../{340_openssl.conf => fit/openssl.conf}    |   0
 .../test/{340_rsa2048.key => fit/rsa2048.key} |   0
 .../{340_softhsm2.conf => fit/softhsm2.conf}  |   0
 8 files changed, 11 insertions(+), 11 deletions(-)
 rename tools/binman/test/{ => fit}/aes256.bin (100%)
 rename tools/binman/test/{ => fit}/dummy-rsa-engine.c (100%)
 rename tools/binman/test/{340_dummy-rsa4096.crt => fit/dummy-rsa4096.crt} (100%)
 rename tools/binman/test/{340_openssl.conf => fit/openssl.conf} (100%)
 rename tools/binman/test/{340_rsa2048.key => fit/rsa2048.key} (100%)
 rename tools/binman/test/{340_softhsm2.conf => fit/softhsm2.conf} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 601d1f7eb8c..76d17e6d986 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7927,7 +7927,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'default-dt': 'test-fdt1',
             'atf-bl31-path': 'bl31.elf',
         }
-        data = tools.read_file(self.TestFile("340_rsa2048.key"))
+        data = tools.read_file(self.TestFile("fit/rsa2048.key"))
         self._MakeInputFile("keys/rsa2048.key", data)
 
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
@@ -7964,7 +7964,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'atf-bl31-path': 'bl31.elf',
         }
 
-        x509_pubkey = '340_dummy-rsa4096.crt'
+        x509_pubkey = 'fit/dummy-rsa4096.crt'
         data = tools.read_file(self.TestFile(x509_pubkey))
         self._MakeInputFile('dev.crt', data)
 
@@ -8039,7 +8039,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         prefix = "testFitSignPKCS11Simple."
         # Configure SoftHSMv2
-        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
+        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
         softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
         softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
 
@@ -8070,7 +8070,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
 
         # Make OpenSSL use softhsm2 engine
-        ossl_conf = self.TestFile('340_openssl.conf')
+        ossl_conf = self.TestFile('fit/openssl.conf')
         with unittest.mock.patch.dict('os.environ',
                                       {'OPENSSL_CONF': ossl_conf,
                                        'SOFTHSM2_CONF': softhsm2_conf}):
@@ -8114,7 +8114,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         prefix = "testFitSignPKCS11Object."
         # Configure SoftHSMv2
-        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
+        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
         softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
         softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
 
@@ -8147,7 +8147,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         # Make OpenSSL use softhsm2 engine and configure PIN for token
         # The PIN is incorrect on purpose, the correct one will be passed by
         # MKIMAGE_SIGN_PIN
-        ossl_conf = self.TestFile('340_openssl.conf')
+        ossl_conf = self.TestFile('fit/openssl.conf')
         with unittest.mock.patch.dict('os.environ',
                                       {'OPENSSL_CONF': ossl_conf,
                                        'SOFTHSM2_CONF': softhsm2_conf,
@@ -8204,9 +8204,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'default-dt': 'test-fdt1',
             'atf-bl31-path': 'bl31.elf',
         }
-        data = tools.read_file(self.TestFile("340_rsa2048.key"))
+        data = tools.read_file(self.TestFile("fit/rsa2048.key"))
         self._MakeInputFile("keys1/rsa2048.key", data)
-        data = tools.read_file(self.TestFile("340_rsa2048.key"))
+        data = tools.read_file(self.TestFile("fit/rsa2048.key"))
         self._MakeInputFile("keys2/conf-rsa2048.key", data)
 
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
@@ -8257,7 +8257,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testSimpleFitEncryptedData(self):
         """Test an image with a FIT containing data to be encrypted"""
-        data = tools.read_file(self.TestFile("aes256.bin"))
+        data = tools.read_file(self.TestFile("fit/aes256.bin"))
         self._MakeInputFile("keys/aes256.bin", data)
 
         keys_subdir = os.path.join(self._indir, "keys")
@@ -8277,7 +8277,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         # Retrieve the key name from the FIT removing any null byte
         key_name = fit.GetProps(subnode)['key-name-hint'].bytes.replace(b'\x00', b'')
-        with open(self.TestFile(key_name.decode('ascii') + '.bin'), 'rb') as file:
+        with open(self.TestFile('fit/' + key_name.decode('ascii') + '.bin'), 'rb') as file:
             key = file.read()
         iv = fit.GetProps(subnode)['iv'].bytes.hex()
         enc_data = fit.GetProps(node)['data'].bytes
diff --git a/tools/binman/test/Makefile b/tools/binman/test/Makefile
index d5e4c0f556a..6b42db6559f 100644
--- a/tools/binman/test/Makefile
+++ b/tools/binman/test/Makefile
@@ -85,7 +85,7 @@ blob_syms: blob_syms.c
 elf_sections: CFLAGS += $(LDS_EFL_SECTIONS)
 elf_sections: elf_sections.c
 
-dummy-rsa-engine.so: dummy-rsa-engine.c
+dummy-rsa-engine.so: $(SRC)fit/dummy-rsa-engine.c
 	$(CC) -fPIC -shared -lcrypto -lssl -o $@ $<
 
 clean:
diff --git a/tools/binman/test/aes256.bin b/tools/binman/test/fit/aes256.bin
similarity index 100%
rename from tools/binman/test/aes256.bin
rename to tools/binman/test/fit/aes256.bin
diff --git a/tools/binman/test/dummy-rsa-engine.c b/tools/binman/test/fit/dummy-rsa-engine.c
similarity index 100%
rename from tools/binman/test/dummy-rsa-engine.c
rename to tools/binman/test/fit/dummy-rsa-engine.c
diff --git a/tools/binman/test/340_dummy-rsa4096.crt b/tools/binman/test/fit/dummy-rsa4096.crt
similarity index 100%
rename from tools/binman/test/340_dummy-rsa4096.crt
rename to tools/binman/test/fit/dummy-rsa4096.crt
diff --git a/tools/binman/test/340_openssl.conf b/tools/binman/test/fit/openssl.conf
similarity index 100%
rename from tools/binman/test/340_openssl.conf
rename to tools/binman/test/fit/openssl.conf
diff --git a/tools/binman/test/340_rsa2048.key b/tools/binman/test/fit/rsa2048.key
similarity index 100%
rename from tools/binman/test/340_rsa2048.key
rename to tools/binman/test/fit/rsa2048.key
diff --git a/tools/binman/test/340_softhsm2.conf b/tools/binman/test/fit/softhsm2.conf
similarity index 100%
rename from tools/binman/test/340_softhsm2.conf
rename to tools/binman/test/fit/softhsm2.conf
-- 
2.43.0

