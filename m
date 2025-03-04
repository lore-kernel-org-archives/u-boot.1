Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8251C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F5381919;
	Tue,  4 Mar 2025 14:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cBl0v18R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECAA81426; Tue,  4 Mar 2025 14:10:11 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238A581870
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85add67e9c1so75365439f.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741093807; x=1741698607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXx6KjxI9wXIIZMsAs43DAkw8h5kajrCOKSlUj7WINQ=;
 b=cBl0v18RROu72bQq0H1yUPbQChK9/7PI33qj9dhRjgy0K1dR2PqsMnS+8hpRvq7H4x
 jRJmOe6YT+SIBZ4Pb+x3s1mii2v7SE6Jt9kZetrmB7glfaBV/NSZFz0s2mLno2Fu7O2w
 Ruh4V+x/J2jm4WFhzJvEIHFQ97MFozFoAXKhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093807; x=1741698607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXx6KjxI9wXIIZMsAs43DAkw8h5kajrCOKSlUj7WINQ=;
 b=fgqKYFk3b8fHU+QkT3EJaTNfKhpHeal4iaHlIfHwyNgcBSFO9+3bXssw2TB4ySuIdZ
 q1MQ7AxG2xG/o356Ia6gKObPVlQ6DeVykzwZcL9AZl/vC5oVG+3/WUdheuPGaBsUbJo0
 bCG6f9tzGtpzBBMBFIEBAvYQ7grZxZjc9WgLliyC3mXWzwOJ5THfdWa0NnSEUtyL/Q2W
 6RO56D9gHwsJuwn1R4YrmXKnM4c7Nb2BNivEC1NjiXeLYzed66ofCTFrLyiRZMYkJRPU
 vTxVUAlY7j+l4hAvfb8NE+jgzD76pRGLwa6lh1cxNGVLNTRJ7jQVd5zJfXLKF8PIm5y4
 pmpQ==
X-Gm-Message-State: AOJu0YwYQ0G6hMoQead8JyEM2AqtEQto+5gVUGDFvl8qrub2JcIeVCV5
 cAcynt59TWdUvO6SljBi2XZ6gkBo6QW0p86fDXKFS4HWbcNr2zpWqb47ghRKHf5lUJxjPUoZM9Q
 =
X-Gm-Gg: ASbGnculWVDm9ppQCMPu43h68hYsgqGdZjpX47kIcC6luWxkv3RNw8PVRYiDd6SmQR7
 nfhjeVQ5RvjZ343wMrUv/4e03RPpw+yfzk+Vdb1OUgVuynkKlDn3Nhf8wfVmomRiov1/yOXphag
 ANPEPGFbcmSEb5D6ISyas4EnzUhZ7f6tfA3886t5dvAzDcs4hiGeYrkhLjf6Ue4LHEE205AAhA/
 4wMOEs8JtIE+ScNVQs9TDP5GMhJfsEfGfD+nvy8TN3sf/c3dC3YOe01bjZnv2K7EhbJMZAn/Q8U
 AwyHGNREbAeULxEb9Ky2I55CqB2o8EaU1YOjZQn1CwAIs9GZgI2ySc67lw6cxKhmBJSqR5shdh4
 oaLgs9Q==
X-Google-Smtp-Source: AGHT+IEL8xTU9gFhld0zU8qX6MnPfwfmHv2aSW0dD3Tgy2HZcMV6/6+cHueCMqQ0cfFAU2JBvwhvTw==
X-Received: by 2002:a05:6602:408d:b0:85a:dd30:a19f with SMTP id
 ca18e2360f4ac-85af03bb2edmr295319639f.6.1741093806942; 
 Tue, 04 Mar 2025 05:10:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-858753cd304sm287383839f.33.2025.03.04.05.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 05:10:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Simon Glass <sjg@chromium.org>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/7] binman: Workaround lz4 cli padding in test cases
Date: Tue,  4 Mar 2025 06:09:42 -0700
Message-ID: <20250304130947.109799-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304130947.109799-1-sjg@chromium.org>
References: <20250304130947.109799-1-sjg@chromium.org>
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Newer lz4 util is not happy with any padding at end of file,
it would abort with error message like:

Stream followed by undecodable data at position 43.

Workaround by skipping testCompUtilPadding test case and manually
strip padding in testCompressSectionSize test case.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/ftest.py                           | 7 +++++--
 tools/binman/test/184_compress_section_size.dts | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 1a92a99b511..e46a1e84372 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4613,6 +4613,8 @@ class TestFunctional(unittest.TestCase):
         dtb.Scan()
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
                                         'uncomp-size'])
+        data = data[:0x30]
+        data = data.rstrip(b'\xff')
         orig = self._decompress(data)
         self.assertEqual(COMPRESS_DATA + U_BOOT_DATA, orig)
         expected = {
@@ -6218,8 +6220,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testCompUtilPadding(self):
         """Test padding of compression algorithms"""
-        # Skip zstd because it doesn't support padding
-        for bintool in [v for k,v in self.comp_bintools.items() if k != 'zstd']:
+        # Skip zstd and lz4 because they doesn't support padding
+        for bintool in [v for k,v in self.comp_bintools.items()
+                        if not k in ['zstd', 'lz4']]:
             self._CheckBintool(bintool)
             data = bintool.compress(COMPRESS_DATA)
             self.assertNotEqual(COMPRESS_DATA, data)
diff --git a/tools/binman/test/184_compress_section_size.dts b/tools/binman/test/184_compress_section_size.dts
index 95ed30add1a..1c1dbd5f580 100644
--- a/tools/binman/test/184_compress_section_size.dts
+++ b/tools/binman/test/184_compress_section_size.dts
@@ -6,6 +6,7 @@
 		section {
 			size = <0x30>;
 			compress = "lz4";
+			pad-byte = <0xff>;
 			blob {
 				filename = "compress";
 			};
-- 
2.43.0

