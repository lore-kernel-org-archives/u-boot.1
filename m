Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA01AD5C0EE
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6BA890CE;
	Fri,  8 Nov 2024 16:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZJqsY+NY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46A4890D5; Fri,  8 Nov 2024 16:23:59 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC2C8904E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 16:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83ac05206c9so87738839f.3
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731079436; x=1731684236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJcig0K404Sqah6fdr9/ntO4m1BCi3SwrbsmFwcuwac=;
 b=ZJqsY+NYXdq+sCnTy88XwiU6W7pPRgIEfSnsZpzn/V5tR2cCyfawmrhqyYKsZLvU66
 CqwQN9oqfDo8lH4mPDIIxmIqwe9/3X3vv1/oBVzwnhq8Db3HDqsUgPX6A9Wu8H6F6k6I
 YWIHsupegmEaIosvVJGeueGq1Hzach1Txt4CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731079436; x=1731684236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJcig0K404Sqah6fdr9/ntO4m1BCi3SwrbsmFwcuwac=;
 b=ZaOnjbojNv+SjZxXSiuh7cbuGML0UpBI1Ug9ka4rFYw2LIYsETWRx0rJKnmc2uHRWS
 viCEH1fUmEpUzsEnPik6Dum+4DfaJq5Zv6xNCT96OipnUb6QznHQ5ZfLTL0EbCcVLtaU
 AlAphBuq+e8oIhgOMLAkfjm9gWKaON9ka0Cn9ERQEMclka5zS/m9d+c2siZoXxz4vcUB
 JxlgzZLWvdEbqC1m5s7sU75KUUfgudv0xv/ck7yGENZTDh/6ynp30EgZ/TIDNhFbD68H
 h2S5l83OB/wKLhU82tLEpuL2HTjJHovRXxgPPidW5dvI+6UMe7g49aSOnyz2yYgbYlku
 ZSVg==
X-Gm-Message-State: AOJu0YxD6163Gmp+m3iROGB45rPU7ICOSTxotFZSnZcutGbumQ+y+wcE
 1rXavYMXcrpn7QymJvXuPWHe07iRJy62zEGBnzEwOD0nCe2PD0X1MnEQwYSss0b7eiOh/WUiiOQ
 =
X-Google-Smtp-Source: AGHT+IGg4x0L/9MoEJYHl/RZpKVIitQG0i2SBCsqbNChrKjROLaeh6AWWzBpAZWlRPae+zy51xYMag==
X-Received: by 2002:a05:6602:6406:b0:83b:47:8d5 with SMTP id
 ca18e2360f4ac-83e0329122fmr317629639f.3.1731079435652; 
 Fri, 08 Nov 2024 07:23:55 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de5f7e3283sm864420173.6.2024.11.08.07.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:23:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Brandon Maier <brandon.maier@collins.com>
Subject: [PATCH 1/9] buildman: Add a lower-level test for KconfigScanner
Date: Fri,  8 Nov 2024 08:23:42 -0700
Message-Id: <20241108152350.3686274-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108152350.3686274-1-sjg@chromium.org>
References: <20241108152350.3686274-1-sjg@chromium.org>
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

This code is tested by test_scan_defconfigs() but it is useful to have
some specific tests for the KconfigScanner's operation in U-Boot. Add
a test which checks that the values are obtained correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/func_test.py | 51 +++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index 0ac9fc7e44f..db3c9d63ec4 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -1067,3 +1067,54 @@ endif
             result = self._RunControl('--print-arch', 'board0')
         self.assertEqual('arm\n', stdout.getvalue())
         self.assertEqual('', stderr.getvalue())
+
+    def test_kconfig_scanner(self):
+        """Test using the kconfig scanner to determine important values
+
+        Note that there is already a test_scan_defconfigs() which checks the
+        higher-level scan_defconfigs() function. This test checks just the
+        scanner itself
+        """
+        src = self._git_dir
+        scanner = boards.KconfigScanner(src)
+
+        # First do a simple sanity check
+        norm = os.path.join(src, 'board0_defconfig')
+        tools.write_file(norm, 'CONFIG_TARGET_BOARD0=y', False)
+        res = scanner.scan(norm, True)
+        self.assertEqual(({
+            'arch': 'arm',
+            'cpu': 'armv7',
+            'soc': '-',
+            'vendor': 'Tester',
+            'board': 'ARM Board 0',
+            'config': 'config0',
+            'target': 'board0'}, []), res)
+
+        # Check that the SoC cannot be changed and the filename does not affect
+        # the resulting board
+        tools.write_file(norm, '''CONFIG_TARGET_BOARD2=y
+CONFIG_SOC="fred"
+''', False)
+        res = scanner.scan(norm, True)
+        self.assertEqual(({
+            'arch': 'powerpc',
+            'cpu': 'ppc',
+            'soc': 'mpc85xx',
+            'vendor': 'Tester',
+            'board': 'PowerPC board 1',
+            'config': 'config2',
+            'target': 'board0'}, []), res)
+
+        # Check handling of missing information
+        tools.write_file(norm, '', False)
+        res = scanner.scan(norm, True)
+        self.assertEqual(({
+            'arch': '-',
+            'cpu': '-',
+            'soc': '-',
+            'vendor': '-',
+            'board': '-',
+            'config': '-',
+            'target': 'board0'},
+            ['WARNING: board0_defconfig: No TARGET_BOARD0 enabled']), res)
-- 
2.34.1

