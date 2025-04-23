Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277CCC369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C2081F4D;
	Wed, 23 Apr 2025 14:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ie45q/y/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725CE815D1; Wed, 23 Apr 2025 14:30:22 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBB6809D4
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85b4170f1f5so214087739f.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745411418; x=1746016218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8CKBpYsxr5y4Yht/uFSiSoca1Xk5wz7yZNi4AYNepY=;
 b=ie45q/y/wsu1Bl0t6jEvsWaxTU7W2dF3ShItKWOPs7aSyYIwVkFIoIhUsWWo7xNn5Z
 jZblup47kRWfJJhbTasU3ntJr1G8gmRbOx2hNa/GJpsIbVyVI3DoOpKoB56eOWI8SrPm
 P3GQZrfVT7YZb/xpLb2VhQbJsufBUEJwjD47w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411418; x=1746016218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k8CKBpYsxr5y4Yht/uFSiSoca1Xk5wz7yZNi4AYNepY=;
 b=P1V+XRc3u2xxDnFklQpySwNZBLdYNCnivEipoJlBBfy7Jogw2SITyY3ZfBQAJP2JMO
 J+sIzMfnYXTLx6c0HRVyAF5SbyY8HLNb8x/BI9D7d1YMxfs5BGXErRBJRo+o9Kwbd424
 NGptjO8RaMJUJ3SDuye+IFRTVyjKBrvsSG2YVz2LL9j+rYj41cLrhD1v13Ak3CcCxg0d
 5/Rt05UWh4qyMmxN15oOGaZIKVJVJDP0pxcMTLvfFFrhoGw3U5oSvkdCJ++TtW55W91s
 pAdRGkPXp3Mq0N9yR0eBhK3j2alsWQCa1Wd1A6Gv9UxJ+FxG2eFAINgYHSlms+JiUlUv
 QCOA==
X-Gm-Message-State: AOJu0Yyw3t7sTAUQNhwrqhC3yd5SI//13gjJHGbAPQUfbi2ikNtD60bB
 2bMAgXA8LQkptNXTh0CcloqVFvBV5EhyRIy8RSDbZVk0up7hwaYIJJZaOL6Oyx3L7hAwMXvV2Ms
 =
X-Gm-Gg: ASbGncuKvhu1ZCtBAkI0xmCxs2GN34wM7VfCwcyeDEwzuNjZrwRAVjZgYGuGh4HmSfr
 aQpUkx+ixLgKF9CtjY3NsHDStB6Nh9wGxHdry8GIBM+s1GFyiMd4REaGRpHtXsGlj6S2RzxwFbk
 Nhe7wHh0XWwt43m764iZz1ogFwgC6I9x6YJJCD/OZxQ9h98V6bYwZTyrCjVfKDxfm5fbc+T2eMc
 CgMGR4eP7eC6V/2ov6hQE8iFjZocxF5y991JR3iUs811kxMCJKON3eTRbVbxrqJs+M4wcDNPNbA
 XqVkJiOA4fczXr9mvesDORTsD7oxmxL1VYbUL7mOGMjWVT+ivoPrGnjo80VITpCeKgT2qC4z5Vm
 Rf3CwbaCmImwv
X-Google-Smtp-Source: AGHT+IHE8kallUtaudPW/+mE7a/V+MzyOYpqfikKt7LHUXBv/qswRPTueln5nhEh397m7xtYITOAnQ==
X-Received: by 2002:a05:6602:3e99:b0:85b:3763:9551 with SMTP id
 ca18e2360f4ac-861dbe2161emr1925727539f.7.1745411418010; 
 Wed, 23 Apr 2025 05:30:18 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864447402a9sm30086239f.15.2025.04.23.05.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 05:30:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Moteen Shah <m-shah@ti.com>, Simon Glass <sjg@chromium.org>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] tools: binman: ftest.py: Add testcase for bootph-*
 propagation
Date: Wed, 23 Apr 2025 06:29:33 -0600
Message-ID: <20250423123009.779628-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423123009.779628-1-sjg@chromium.org>
References: <20250423123009.779628-1-sjg@chromium.org>
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

From: Moteen Shah <m-shah@ti.com>

Add a testcase to ensure that scan_and_prop_bootph() actually
propagates bootph-* properties to supernodes.

Signed-off-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/ftest.py                 | 18 ++++++++++++++++++
 tools/binman/test/347_bootph_prop.dts | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tools/binman/test/347_bootph_prop.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 92df2a03650..8c019a4dcf3 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8000,5 +8000,23 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self._DoTestFile('346_remove_template.dts',
                          force_missing_bintools='openssl',)
 
+    def testBootphPropagation(self):
+        """Test that bootph-* properties are propagated correctly to supernodes"""
+        data, _, _, out_dtb_fname = self._DoReadFileDtb('347_bootph_prop.dts',
+                                                        use_real_dtb=True, update_dtb=True)
+        dtb = fdt.Fdt(out_dtb_fname)
+        dtb.Scan()
+        root = dtb.GetRoot()
+        parent_node = root.FindNode('dummy-parent')
+        subnode1 = parent_node.FindNode('subnode-1')
+        subnode2 = parent_node.FindNode('subnode-2')
+        subnode3 = parent_node.FindNode('subnode-3')
+
+        self.assertIn('bootph-pre-ram', subnode1.props, "Child node is missing 'bootph-pre-ram' property")
+        self.assertIn('bootph-all', subnode1.props, "Child node is missing 'bootph-all' property")
+        self.assertIn('bootph-pre-ram', parent_node.props, "Parent node is missing 'bootph-pre-ram' property")
+        self.assertIn('bootph-all', parent_node.props, "Parent node is missing 'bootph-all' property")
+
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/347_bootph_prop.dts b/tools/binman/test/347_bootph_prop.dts
new file mode 100644
index 00000000000..02bcf2d6f37
--- /dev/null
+++ b/tools/binman/test/347_bootph_prop.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+/ {
+	dummy-parent {
+		subnode-1 {
+			subnode-2 {
+				bootph-all;
+			};
+			subnode-3 {
+				bootph-pre-ram;
+			};
+		};
+	};
+
+	binman: binman {
+	};
+};
+
-- 
2.43.0

base-commit: 4446bc331c65d3efb8a9321d6368c61edb56479b
branch: try-ti2
