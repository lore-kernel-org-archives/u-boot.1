Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA991C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32DBA88C3F;
	Sat, 20 Jul 2024 12:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JVV+DOof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7609A88C4A; Sat, 20 Jul 2024 12:50:15 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3BF988B74
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-367e50f71bbso1294009f8f.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472610; x=1722077410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhfQBxtG0abfhatLRzW1AQOP2TUIAF0Uf00LH3p0aSc=;
 b=JVV+DOofQnn2+suo0Tx2xHNJ7UK97dRST8ZrBgO6NL80RvoCyXfbso9CrIb7NobOWa
 1ab62gfP++sOK58x4LVk7cldnL2KAqmJAagbQ/oHTFZFzk7TJW97kOTwkubw79IsZw7P
 FY+0+ZFmLOmm0om/nQvXCy4M6xcQWlqbnI/zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472610; x=1722077410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhfQBxtG0abfhatLRzW1AQOP2TUIAF0Uf00LH3p0aSc=;
 b=aJMVbzIU4RC2004VfI+cQboYTxKrpgwaF55QnORrEH868nx8hK+BS4IxbmTy4ULIeE
 JAWzCCLga3FX4Q6BEjaJCC0hU/A6QDk37I5oJTD91TR9OFwU9f4HxSeO8eAL9RJ0EgqG
 cmKionoAyRFGYk6HARaxB3hTl/fJFV2kZ2TjHVXVkLM0LUGaflGU5v2oI7kmGRorSf5S
 v4iWIL/SdRhnkWiY9PlQ1gjXXbm18d852X7OF1L0+UL8P4t9ZiLbFOb0wd62PIZu/7DU
 ua4UErsGi+XJXsXi1dxZCtJpdbofWDAHjlxfizyqi3iiqX0chE+5yxvYV6jKZxnQA9sR
 u9iA==
X-Gm-Message-State: AOJu0YzwE0/yxuPNyI08k80cTWMJcHaNNpLbgQvvUF5+JH1faje2BZ+7
 5wDB0X9YYfwZyWqpT7W+8XqKTjYx5ttpTjkfZs7ioCA9AdfZPFNg9uRANLXB+Oaf/JyUsYD55ik
 =
X-Google-Smtp-Source: AGHT+IHTxjxov4uueMgkyaYu+UA8hEJg9Wb+QbYTiCRMYJCAPbYwTGLvwnj4C9N8dZPML+sQZ7UUcQ==
X-Received: by 2002:adf:ed0a:0:b0:368:71fc:abb7 with SMTP id
 ffacd0b85a97d-369bae4e084mr773352f8f.16.1721472610613; 
 Sat, 20 Jul 2024 03:50:10 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/20] binman: Correct indentation in testSplPubkeyDtb
Date: Sat, 20 Jul 2024 11:49:41 +0100
Message-Id: <20240720104950.2730773-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

This function has strange indentation. Fix it.

Fixes: 8c1fbd1f607 ("binman: ftest: Add test for u_boot_spl_pubkey_dtb")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/ftest.py | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bb691cb3ff2..d091855b8e3 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7175,27 +7175,24 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
 
     def testSplPubkeyDtb(self):
-         """Test u_boot_spl_pubkey_dtb etype"""
-         data = tools.read_file(self.TestFile("key.pem"))
-         self._MakeInputFile("key.crt", data)
-         self._DoReadFileRealDtb('306_spl_pubkey_dtb.dts')
-         image = control.images['image']
-         entries = image.GetEntries()
-         dtb_entry = entries['u-boot-spl-pubkey-dtb']
-         dtb_data = dtb_entry.GetData()
-         dtb = fdt.Fdt.FromData(dtb_data)
-         dtb.Scan()
-
-         signature_node = dtb.GetNode('/signature')
-         self.assertIsNotNone(signature_node)
-         key_node = signature_node.FindNode("key-key")
-         self.assertIsNotNone(key_node)
-         self.assertEqual(fdt_util.GetString(key_node, "required"),
-                          "conf")
-         self.assertEqual(fdt_util.GetString(key_node, "algo"),
-                          "sha384,rsa4096")
-         self.assertEqual(fdt_util.GetString(key_node, "key-name-hint"),
-                          "key")
+        """Test u_boot_spl_pubkey_dtb etype"""
+        data = tools.read_file(self.TestFile("key.pem"))
+        self._MakeInputFile("key.crt", data)
+        self._DoReadFileRealDtb('306_spl_pubkey_dtb.dts')
+        image = control.images['image']
+        entries = image.GetEntries()
+        dtb_entry = entries['u-boot-spl-pubkey-dtb']
+        dtb_data = dtb_entry.GetData()
+        dtb = fdt.Fdt.FromData(dtb_data)
+        dtb.Scan()
+
+        signature_node = dtb.GetNode('/signature')
+        self.assertIsNotNone(signature_node)
+        key_node = signature_node.FindNode("key-key")
+        self.assertIsNotNone(key_node)
+        self.assertEqual(fdt_util.GetString(key_node, "required"), "conf")
+        self.assertEqual(fdt_util.GetString(key_node, "algo"), "sha384,rsa4096")
+        self.assertEqual(fdt_util.GetString(key_node, "key-name-hint"), "key")
 
     def testXilinxBootgenSigning(self):
         """Test xilinx-bootgen etype"""
-- 
2.34.1

