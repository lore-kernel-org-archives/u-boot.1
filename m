Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F19FCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7610683F2D;
	Fri,  6 Mar 2026 19:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sde7sfaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D8B8382A; Fri,  6 Mar 2026 19:13:33 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A303838FA
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8cb38e86cf2so1009604785a.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820810; x=1773425610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpsbSKbLtLR/B+206RE5jFQjNv5BuxuN/uC6rRIIDA8=;
 b=Sde7sfaY4O14Z1JXgSV2nyK6ueQkGZOm3UGjInPsiHoXqRYkgSlvPNljapUrgU2M2K
 GvA3ipiJVoISVpalFrSq3UxRfMvlXiDgs4pXWe4k1njZGbmt4W2cTAohtYU2YJk3RKIK
 jMceubIN9csmfI78Yl5Q640DedLkgeOtHNjoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820810; x=1773425610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GpsbSKbLtLR/B+206RE5jFQjNv5BuxuN/uC6rRIIDA8=;
 b=qiwrZNuWPlVYlZDqV7ABw6rMbxzNVTeAOD56sKEhO5L7x4TmFHHx0M/XpI11XEfRU2
 R4o820gGuHpOW5gtZYs4Xr2LuoKBTulC+NZZ77v3tTMJ/MWDGFopWicER0WXjPDJZ/sc
 Kwwi5PHlTczGOlNzMaJC/KXXQzJxeo4D4nOj77Kwrgq6beBW0o+xgs0IATPHqbiABFf5
 ZgKjAegE8i8xjLDmO9vvtRKEccWCb+Mag0lbFI5Af35Nj1tussuoccwduFUFoQWmWrWq
 eOuhF3Ybt/cbpaOBOZDxCHIDT7PsbEUbeFoosjr7+AEQ7OXR5b9OVxTCbHpiAoI30tvv
 T/2Q==
X-Gm-Message-State: AOJu0YzfkOTz0pe4WV7fS2Oc7uKdJDN5eHpJpJEA2uf7VssIB43IrZ4Y
 WN+DmeMFw1jipKrpBKDOc8fbuFEk73obBCb78RSP+Z6wOKg3aAJUXbuij5Ij8wSrLeyV9ZyZPp7
 bJYg=
X-Gm-Gg: ATEYQzz5sZxA3hXD68/ri23lT2ISRYKrUi8FvcubrUu1Nk0zwGJLJIQeITzhlJa+dp8
 cBGYlXgol5skww/sqkWdKBpI+0DAx9v7/nXg6oYOHt7Al6cwiw9EA5+66iq3BLhTwmR8apCiK+1
 adlo9AIBcyWSkivOTy6srCsnCr0VpTG9B5FZ05tVLb+Sq7HlGkSLGH5RjzOYilW4K7qFLpNf2lp
 JfpUtavcwECKT9RPztda6xkDNLtykalei9J14V6ascPL84uH1yDex3vJtmEu7H01lrzfOdMG0rN
 DH1DJ8hcMBmI/xZTqt3oPJNACBjyxWsxSZibg5TDRZEySClEnj3SYXgDtbl1LK+HFUO0PQV+8lJ
 Ajry6H3Z6xULODR5bf1Uryr/DQ+cx67BJqyvRGKtwTlWAXblz/+Or0tMoquxQwgddsNTX4hDVr9
 zYIKTnS5X/sAqI1XmdTRVFpCzXnCqD
X-Received: by 2002:a05:620a:4593:b0:8c6:6e2b:ac1a with SMTP id
 af79cd13be357-8cd6d38f89bmr391422785a.28.1772820809832; 
 Fri, 06 Mar 2026 10:13:29 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:29 -0800 (PST)
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
Subject: [PATCH v2 01/23] binman: test: Capture output from tests with warnings
Date: Fri,  6 Mar 2026 11:12:29 -0700
Message-ID: <20260306181304.2426352-2-sjg@chromium.org>
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

Tests are supposed to run silently and capture any output produced.

Fix testRemoveTemplate() so that the message about the missing openssl
is captured, along with the invalid-images message.

Fix testNxpImx9Image() as well, since it is expected that container.img
and bl31.bin are missing.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 tools/binman/ftest.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a53e37f31b3..a96789d4f1c 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7915,7 +7915,8 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         container_path = os.path.join(testdir, 'mx95b0-ahab-container.img')
         with open(container_path, 'w') as f:
             f.write(bytes([0x87]).decode('latin1') * 32768)
-        self._DoTestFile('350_nxp_imx95.dts', output_dir=testdir)
+        with terminal.capture():
+            self._DoTestFile('350_nxp_imx95.dts', output_dir=testdir)
 
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
@@ -8307,8 +8308,11 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test whether template is removed"""
         TestFunctional._MakeInputFile('my-blob.bin', b'blob')
         TestFunctional._MakeInputFile('my-blob2.bin', b'other')
-        self._DoTestFile('346_remove_template.dts',
-                         force_missing_bintools='openssl',)
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('346_remove_template.dts',
+                             force_missing_bintools='openssl',)
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'file2'.*missing bintools.*: openssl")
 
     def testBootphPropagation(self):
         """Test that bootph-* properties are propagated correctly to supernodes"""
-- 
2.43.0

