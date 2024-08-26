Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACBDC5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7AD988C1C;
	Mon, 26 Aug 2024 21:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aa+N/aOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 138DE88B59; Mon, 26 Aug 2024 21:12:18 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BDA88C37
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39d2256ee11so18433775ab.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699533; x=1725304333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arHsLf0mL/Bmrmxsn27G4ocfaU+5B4v+aZ2dBfQVb8M=;
 b=aa+N/aOyVQaje67KB09v9LjpPZAu4BsrZSDOoTt3MvM+L6sV1Xim1RNuAQQQlO0A++
 ahV46RIveZ9imQzf7iwGGauDf8t3oSgjADd06I6R0FTEGsHbD/wMWq7ISldVmmKt7bfQ
 KC3RRgnVPidAuPUEIXu543UyqVuXaKKytR5WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699533; x=1725304333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arHsLf0mL/Bmrmxsn27G4ocfaU+5B4v+aZ2dBfQVb8M=;
 b=iKkErO1J0cdZtbYIiIMYQexb4oIkbxJDPY8aB/RnPHgPioK/fhXPRoD9GdiqBBLyts
 N8DQ3podgoKxZY89+hVfCACMpCDTYQXGM0MVZTJYPqzKF8yv0Kix0A4gw3rRlHsJdMSO
 RDkLE65SVsJv2boKkvbIauyins+GGYZfikqUCj3IuZDCvoBeGtJWW08Lut+srpmq3MRz
 K4zodt5CuvcQM2LGwIw6/NJG8bstUpvK7XtLKOnPP7A3AkXUd0GT5Ia9LfnEJjXZ6g69
 2wqHOt1WuQUhTRaztbqY5F5MAK4BCZEaczbEkcNhHZLjxQGYHUHdpHJBLB0QIOpe7StQ
 dm+A==
X-Gm-Message-State: AOJu0Yxrh7RoUsGJB4dbXRCyGOIbHZiXlHVKQypfLlEgu5naJERRevUE
 ICSnzQkvbisEpzbVKUlGHsRd+jETTFzA5eKe3btwgSfS1jgzAxeyUNxiBCMpl8cVmDD1xO0xXXw
 =
X-Google-Smtp-Source: AGHT+IEoEGNjXfpktlVE4a9qA9XCFI+ehCSEjoxebJCT6pKspbIWiW/Z7NKyNmgvB/d7meaAP2Mo9w==
X-Received: by 2002:a05:6e02:1488:b0:398:16d1:6127 with SMTP id
 e9e14a558f8ab-39e3c9c0727mr126420845ab.21.1724699533516; 
 Mon, 26 Aug 2024 12:12:13 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:12:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/15] binman: Make a start on an iMX8 test
Date: Mon, 26 Aug 2024 13:11:43 -0600
Message-Id: <20240826191143.426387-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826191143.426387-1-sjg@chromium.org>
References: <20240826191143.426387-1-sjg@chromium.org>
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

This patch is for Marek, to provide a starting point.

To try it, use 'binman test -T' and see the missing coverage.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/nxp_imx8mimage.py |  3 ++-
 tools/binman/ftest.py                |  4 ++++
 tools/binman/test/339_nxp_imx8.dts   | 17 +++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 tools/binman/test/339_nxp_imx8.dts

diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
index 3585120b79b..8ad177b3b65 100644
--- a/tools/binman/etype/nxp_imx8mimage.py
+++ b/tools/binman/etype/nxp_imx8mimage.py
@@ -27,7 +27,8 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
 
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
-        self.required_props = ['nxp,boot-from', 'nxp,rom-version', 'nxp,loader-address']
+        self.required_props = ['nxp,boot-from', 'nxp,rom-version',
+                               'nxp,loader-address']
 
     def ReadNode(self):
         super().ReadNode()
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 6317e72e649..225b5639b58 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7800,6 +7800,10 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn('Symbol-writing: no value for /binman/section/u-boot',
                       out)
 
+    def testNxpImx8Image(self):
+        """Test that binman can produce an iMX8 image"""
+        self._DoTestFile('339_nxp_imx8.dts')
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/339_nxp_imx8.dts b/tools/binman/test/339_nxp_imx8.dts
new file mode 100644
index 00000000000..cb512ae9aa2
--- /dev/null
+++ b/tools/binman/test/339_nxp_imx8.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mimage {
+			args;	/* TODO: Needed by mkimage etype superclass */
+			nxp,boot-from = "sd";
+			nxp,rom-version = <1>;
+			nxp,loader-address = <0x10>;
+		};
+	};
+};
-- 
2.34.1

