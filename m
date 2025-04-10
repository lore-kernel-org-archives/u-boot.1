Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67D8C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF9783C32;
	Thu, 10 Apr 2025 14:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N0ZSjdp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B36683C65; Thu, 10 Apr 2025 14:43:56 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FAD483C62
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-85ea482e3adso58788039f.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744289032; x=1744893832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sfdd8o8XP6NEmRlULRU444l/6jMvTXALtYxNt0HYJkU=;
 b=N0ZSjdp6DvFaGuQfHCUkQ7RtYWYbd14EEopqjcDVg/l1RjxewO6ClxLQHJpQYH0C05
 2Vs5kV5535JVFGaQxwYajHR4vd1PqSb1qGtlUltDyNbiKbiw2tx4h2p6a16eLraj4/Y4
 q63AgYD4Mo/V+re6pHrbyAAqgTPakW7JXxHtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744289032; x=1744893832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sfdd8o8XP6NEmRlULRU444l/6jMvTXALtYxNt0HYJkU=;
 b=pmZeKkAUdZVmXum2Z9We2dQXsL6maum5856/zGSJv8U4/UI8N/wqJLODA8FImxbC06
 qxa+Dw1yTfUibftMfwJuUN+B36UJBTIcwHFZ4f8iRGdnSbSGgkyspdKn91bLWCGnoPcq
 SIOjuFSWCsN+xDTnFRwBMpIYokimKQpInUnBqbKHzCpE9NSpSFR5SBP/F6HAE6ms8OiZ
 5eRfNbb/cJ31C72ALxbAJaUZZSUb/HsBm5EAAaP57IZihkIMv2X3/9JsT2vykfQm7jtD
 TjM8+iGcEb6sIBlDQ14eR9heJDXHaewkK5D1W9Fw+M7ifuHA+3dPhzXjW7nrTHS1opc7
 av6g==
X-Gm-Message-State: AOJu0YxUYNMxA0pqNtM1MF3ovPxIdYOGhZR68gZoJMwTNjJJm23uTVaz
 E4FZpoL709JwZ0avrl9vStYPhiV+A6sDLLQd5qGrqZC0QkrkR7O53oaYLGHfz3QMwmCSLH93n8A
 =
X-Gm-Gg: ASbGnct+8pqKZi8dST7TY0/db9u/ulzIzFvRHLrY1mNjoMA2PbsHKXlJnhwpqJ3OLl9
 5W7IRRiWGUAgqquqV6NSTZcnk545qiiV6yfSeaExjxYzmh0xi40b/vo1TGrwHIuYfxZOqD+YMn3
 GYFGwwqkzCuvQCK/CPHO3qfhpuJQGEDtwM4WnTWToCVLdWCDn6F5oqIQpNpPFYL9QzHInnCcLB2
 FsiMXaezkOXjS1d5wFKAVNcchp5YneiDSE9mvbR+/u7YHKjdOWe31wfsVhhS4PffzPjMnOG3Iy7
 t4c4Wm3R+NFa6vmj/ew11iFgxez3XCSPkxRnKXavEBw9Il8gb3KGKk9BHF2gmXe3twzVegCn8zl
 nWA==
X-Google-Smtp-Source: AGHT+IHkG4iWpMa0jEg6hdvC0hfX9NuyI/Zu2pufvsfu0Y+2xL9I4Zyo47SQEakFomq48T8/OSaZEg==
X-Received: by 2002:a05:6e02:1c2c:b0:3d6:cb49:1e5f with SMTP id
 e9e14a558f8ab-3d7e4c3abc6mr23969745ab.2.1744289032325; 
 Thu, 10 Apr 2025 05:43:52 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d170e7sm729471173.32.2025.04.10.05.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:43:51 -0700 (PDT)
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
Subject: [PATCH v2 6/8] binman: Workaround lz4 cli padding in test cases
Date: Thu, 10 Apr 2025 06:43:03 -0600
Message-ID: <20250410124333.843527-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410124333.843527-1-sjg@chromium.org>
References: <20250410124333.843527-1-sjg@chromium.org>
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

(no changes since v1)

 tools/binman/ftest.py                           | 7 +++++--
 tools/binman/test/184_compress_section_size.dts | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 948fcc02259..92df2a03650 100644
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

