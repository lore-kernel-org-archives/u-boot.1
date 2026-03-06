Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B735FCC050
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 831498404A;
	Fri,  6 Mar 2026 19:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aMzweBsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E63A8404A; Fri,  6 Mar 2026 19:14:20 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F41D8401A
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8cd75abd09dso18498485a.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820857; x=1773425657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydmNE+6dEBPZqSZVUsUndXRqv3iG1hBQkQxuJtm9Rh4=;
 b=aMzweBsTyYLJtjMBBDSfVcB9JxuYJAV+PCMhJqivl7fe9ZCNxtFSI1H1iUCvczW7K0
 qALzeL8++ZQ/eNQpW6WmgEZEr0WMjkMwvuUT5zaONrEgMJI5ZVIYxFdFTeFPse2+QULR
 xtSDeYT0FfmQxwMv6G77y7k6qYek3SuIkqp1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820857; x=1773425657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydmNE+6dEBPZqSZVUsUndXRqv3iG1hBQkQxuJtm9Rh4=;
 b=SPFdjHY32y1uI1gGgaG6GCDnbjr5YQyuK0rZDq5kRHepEP3S+eJrWUAuPHJG0iyq13
 6KOKVH5rs4D+wYgKlGwSct0IW2+QSeVEa1U5HJJ0pmB6Ozhw6G49Hdbs97IEaEBzcJg5
 GuEVKtHt9aWuT6FfxvyKv77C1vLwIEzG5KTlbqC1OzB0dSNNvBU8RoDH3103J+AF5OvI
 4IPZqEZOyCvZDVUjhWY6tYaDow/Jc53uu8rnvDqehHcnrBEFLxY/OqkqiiohvYj79wcY
 ZeSD1n/q3sLCNVbYucothteoaVHp5rciyrPmM4A5PjTaMXZJVJt2/E/kjRiFENSQe1tX
 AU3g==
X-Gm-Message-State: AOJu0YwLFtoYUJuBgZTJ4Vyt1OSmB5SPQEqd6S/K3O1iapfspa+43cji
 JkUz/mS9fP35EulXFY+ec2l3Iyi7F/jQY6kkr5hHAZXjXNxear1zjJImAXbigERWq8Byu9uIqtW
 3Eog=
X-Gm-Gg: ATEYQzygP0pjOw04XP1sKqKcB+IZO0xy0mM+aNveWDFjM2bnpfdwD+Kv/eBG0xCTA7h
 h49m3xJ5MRsT8X60mVW5tXZjasCz/NakAcSUuTn1q7C2WC82OV27nV3iv6Ku7aepESxlHqByQEl
 jxHz7UaNp1cXFnYGNrsAxBz1+iCUWVC6XE2GxUCc1npFPd470GFFT6AInEGKxEoOCioq1/sZDZC
 mM5HLdzrsApQ2sCh6jBO5QzW5Qp5NWSdmfD1h3oORpuz2uF/x5dl598kxIo8Hssy4kC8Zc8uLOZ
 f3eCxjtP+Bsug89wjljDcKJ9ZjxQVJ5rB4gCq3ZpMbDzvfW1pvI6/c0qfoSi9OC/1eGwqig+SAB
 89LN+UQ81K7JzxrrjmRM3EGN6ab9xZhmoEa10JfmWjemTRyENWuiv6qR5bWiRPcQ+NWuA43R3cp
 QLil3ahVul8TgmgN5Baw==
X-Received: by 2002:a05:620a:254e:b0:85c:bb2:ad9c with SMTP id
 af79cd13be357-8cd6d4b4ee3mr404013585a.53.1772820856626; 
 Fri, 06 Mar 2026 10:14:16 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:14:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 19/23] binman: test: Move shared key files to test/security/
Date: Fri,  6 Mar 2026 11:12:47 -0700
Message-ID: <20260306181304.2426352-20-sjg@chromium.org>
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

Move key.key and key.pem into the security/ subdirectory. These are
used by security, vendor, and capsule tests but security is the most
natural home for key material. Update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Add new patch to move shared key files

 tools/binman/ftest.py                    | 32 ++++++++++++------------
 tools/binman/test/{ => security}/key.key |  0
 tools/binman/test/{ => security}/key.pem |  0
 3 files changed, 16 insertions(+), 16 deletions(-)
 rename tools/binman/test/{ => security}/key.key (100%)
 rename tools/binman/test/{ => security}/key.pem (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 76d17e6d986..612237d0b41 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6859,7 +6859,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testX509Cert(self):
         """Test creating an X509 certificate"""
-        keyfile = self.TestFile('key.key')
+        keyfile = self.TestFile('security/key.key')
         entry_args = {
             'keyfile': keyfile,
         }
@@ -6872,7 +6872,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testX509CertMissing(self):
         """Test that binman still produces an image if openssl is missing"""
-        keyfile = self.TestFile('key.key')
+        keyfile = self.TestFile('security/key.key')
         entry_args = {
             'keyfile': 'keyfile',
         }
@@ -7198,7 +7198,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackTiSecure(self):
         """Test that an image with a TI secured binary can be created"""
-        keyfile = self.TestFile('key.key')
+        keyfile = self.TestFile('security/key.key')
         entry_args = {
             'keyfile': keyfile,
         }
@@ -7208,7 +7208,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackTiSecureFirewall(self):
         """Test that an image with a TI secured binary can be created"""
-        keyfile = self.TestFile('key.key')
+        keyfile = self.TestFile('security/key.key')
         entry_args = {
             'keyfile': keyfile,
         }
@@ -7220,7 +7220,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackTiSecureFirewallMissingProperty(self):
         """Test that an image with a TI secured binary can be created"""
-        keyfile = self.TestFile('key.key')
+        keyfile = self.TestFile('security/key.key')
         entry_args = {
             'keyfile': keyfile,
         }
@@ -7232,7 +7232,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testPackTiSecureMissingTool(self):
         """Test that an image with a TI secured binary (non-functional) can be created
         when openssl is missing"""
-        keyfile = self.TestFile('key.key')
+        keyfile = self.TestFile('security/key.key')
         entry_args = {
             'keyfile': keyfile,
         }
@@ -7245,7 +7245,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackTiSecureROM(self):
         """Test that a ROM image with a TI secured binary can be created"""
-        keyfile = self.TestFile('key.key')
+        keyfile = self.TestFile('security/key.key')
         entry_args = {
             'keyfile': keyfile,
         }
@@ -7261,7 +7261,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackTiSecureROMCombined(self):
         """Test that a ROM image with a TI secured binary can be created"""
-        keyfile = self.TestFile('key.key')
+        keyfile = self.TestFile('security/key.key')
         entry_args = {
             'keyfile': keyfile,
         }
@@ -7331,7 +7331,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testSplPubkeyDtb(self):
         """Test u_boot_spl_pubkey_dtb etype"""
-        data = tools.read_file(self.TestFile("key.pem"))
+        data = tools.read_file(self.TestFile("security/key.pem"))
         self._MakeInputFile("key.crt", data)
         self._DoReadFileRealDtb('security/spl_pubkey_dtb.dts')
         image = control.images['image']
@@ -7353,7 +7353,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test xilinx-bootgen etype"""
         bootgen = bintool.Bintool.create('bootgen')
         self._CheckBintool(bootgen)
-        data = tools.read_file(self.TestFile("key.key"))
+        data = tools.read_file(self.TestFile("security/key.key"))
         self._MakeInputFile("psk.pem", data)
         self._MakeInputFile("ssk.pem", data)
         self._SetupPmuFwlElf()
@@ -7382,7 +7382,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test xilinx-bootgen etype"""
         bootgen = bintool.Bintool.create('bootgen')
         self._CheckBintool(bootgen)
-        data = tools.read_file(self.TestFile("key.key"))
+        data = tools.read_file(self.TestFile("security/key.key"))
         self._MakeInputFile("psk.pem", data)
         self._MakeInputFile("ssk.pem", data)
         self._SetupPmuFwlElf()
@@ -7414,7 +7414,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testXilinxBootgenMissing(self):
         """Test that binman still produces an image if bootgen is missing"""
-        data = tools.read_file(self.TestFile("key.key"))
+        data = tools.read_file(self.TestFile("security/key.key"))
         self._MakeInputFile("psk.pem", data)
         self._MakeInputFile("ssk.pem", data)
         self._SetupPmuFwlElf()
@@ -7523,9 +7523,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testSignedCapsuleGen(self):
         """Test generation of EFI capsule"""
-        data = tools.read_file(self.TestFile("key.key"))
+        data = tools.read_file(self.TestFile("security/key.key"))
         self._MakeInputFile("key.key", data)
-        data = tools.read_file(self.TestFile("key.pem"))
+        data = tools.read_file(self.TestFile("security/key.pem"))
         self._MakeInputFile("key.crt", data)
 
         data = self._DoReadFile('capsule/signed.dts')
@@ -7540,9 +7540,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testCapsuleGenSignedVer(self):
         """Test generation of signed EFI capsule with version information"""
-        data = tools.read_file(self.TestFile("key.key"))
+        data = tools.read_file(self.TestFile("security/key.key"))
         self._MakeInputFile("key.key", data)
-        data = tools.read_file(self.TestFile("key.pem"))
+        data = tools.read_file(self.TestFile("security/key.pem"))
         self._MakeInputFile("key.crt", data)
 
         data = self._DoReadFile('capsule/signed_ver.dts')
diff --git a/tools/binman/test/key.key b/tools/binman/test/security/key.key
similarity index 100%
rename from tools/binman/test/key.key
rename to tools/binman/test/security/key.key
diff --git a/tools/binman/test/key.pem b/tools/binman/test/security/key.pem
similarity index 100%
rename from tools/binman/test/key.pem
rename to tools/binman/test/security/key.pem
-- 
2.43.0

