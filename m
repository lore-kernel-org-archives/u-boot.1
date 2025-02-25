Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155B7C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 20:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB80480F92;
	Tue, 25 Feb 2025 21:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TyC2y0cL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF4480805; Tue, 25 Feb 2025 21:07:03 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6DC80FF2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 21:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-855a095094fso164155639f.1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740514019; x=1741118819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaMq5wHTD45Ugg0sk24oA+m9vQEqi44KoWEPtKWf3Sk=;
 b=TyC2y0cLT2vl+VPyr3GMrcAgNv9vnib0ypvbSArb+wzbrSEO9TU3lAlniEQj7fhDrh
 eW0t3qLZjiHLZENvmOCNGo+8/jb5SockRWiQL1jmQQF5AHaOEEL8WQbXy50KHztD/ZEn
 uQI59l7NJ24e0foh9MPJqkhgk8C4FlAKxHAdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740514019; x=1741118819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaMq5wHTD45Ugg0sk24oA+m9vQEqi44KoWEPtKWf3Sk=;
 b=imGs6sXwCBuO3I7p9gQ61xEUJu4Sojm9pBFW7JdYrLH7d8iNny4Fuheky1NdOHLHFC
 5p9wz4q0uNqAdJFeptQa4I2YBch3lJTJXLSSPdMQ555zV4iT9ybe0ooVjeUH5sQE1f6L
 ByxaXImJGX4CYdJVgFr1Fk1L7RcGkW9437hSezSvGlyPpbn5QY2ZwMt87j3ne7sBRUrj
 hEhcu4+GyFddNVpX6cNKn7VqeAOCLzsk5auzBJQlmbGe7VX0gME7dhOG/qp7dZbgquuB
 PC6Re0TKOljHMJBD1ZosTYGHiZ1aCaG6lVI6Tnvt+B4RZGmqaLVo35G74PsBxNw61nuX
 eEJA==
X-Gm-Message-State: AOJu0Yz6UGBWjXKQwIuuoNaxkHcbWDdREEoglZS9wuDD5wlg0EcK/cpo
 ZOtQMfuKkCnoFyXca4pZ8tNmG3L2q7x003HnM0Yy+ejX8G2ZvOum/qTZXKVg92cHs4uv1PxnWM4
 =
X-Gm-Gg: ASbGncvSrGlkYw0/LdZsdANhVgRWBp0fHrS2DSe5VgmAOrj0TcPtvi95cRQ7mG7YMmi
 uKmYtBONBoD1So2UkhfYhQJBQfD6zzRc2/kEoaFK0NI9ojx0wGy9myBwP7B/8hEWn2lJrywbZL3
 hrcUmXm6TEhibI6W8gv80PKoH8v+eclofUMpcRZekEjMhMiz2RGIyjIPnjdPWpbiyKhVSw87CTQ
 dvw8jQBEm2ShLOf9wP1tfGsyfAURaeuxx1GkSZr2n+SnW3y4HdJ7E62nOfYnaBPIuTFAAbSY8b5
 WAw1wmyQ7VDpNiDxZGuOowfhKmrSxFRMMDZZpqEpEbd5mnkNOdwMocFHCPJYR0U=
X-Google-Smtp-Source: AGHT+IGojFLpqchzgt2h9UhhdYkaImXvRwvnIWGppxpHszRL/wDKaaiCgUKA8hPyfVfgoFPelIWCtw==
X-Received: by 2002:a05:6e02:1446:b0:3d0:4700:db0b with SMTP id
 e9e14a558f8ab-3d3d1f139e3mr9834095ab.2.1740514019670; 
 Tue, 25 Feb 2025 12:06:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d361ca210bsm4653305ab.55.2025.02.25.12.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 12:06:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Simon Glass <sjg@chromium.org>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/7] binman: Workaround lz4 cli padding in test cases
Date: Tue, 25 Feb 2025 13:06:30 -0700
Message-ID: <20250225200635.3781149-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225200635.3781149-1-sjg@chromium.org>
References: <20250225200635.3781149-1-sjg@chromium.org>
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
---

 tools/binman/ftest.py                           | 7 +++++--
 tools/binman/test/184_compress_section_size.dts | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 53242c6333f..da39807693b 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4591,6 +4591,8 @@ class TestFunctional(unittest.TestCase):
         dtb.Scan()
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
                                         'uncomp-size'])
+        data = data[:0x30]
+        data = data.rstrip(b'\xff')
         orig = self._decompress(data)
         self.assertEqual(COMPRESS_DATA + U_BOOT_DATA, orig)
         expected = {
@@ -6196,8 +6198,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
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

