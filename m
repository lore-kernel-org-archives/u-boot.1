Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC1CC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 15:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6455C833DB;
	Tue, 22 Jul 2025 17:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dhE7Eflz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033308388C; Tue, 22 Jul 2025 17:35:16 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9088A8386D
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 17:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so4325273f8f.3
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753198513; x=1753803313; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7/AGizxKX0ec1VlXlYDK0SqZKuODc/qqOoyycxQbwqI=;
 b=dhE7Eflztz+EWN9lke+N56FTLu7r9Xl31SVge3STbK82HHt1POuWU3nH2h6UoC6jjL
 wNcoWnsPtkdiUngtvqUz7yxGqrDPRg3Ed9iCBeVKdIvj+IxCErZ4aa6A+0h0l4TCpBCo
 Jfd9bYVi2CuD2hfwLHg4Ib4vSAcmwK9bwYHBK3HGyPtxLKfgo7DPDQjaB9h3bIu3mCst
 zxima09XuhTrrr0x0KLlUQi4AOorPPqVv+WtMEej4W6zGXxVhNpO9DGnBsB8JxFJDfHB
 5dLXnlPJUDrTZx2ZLBr8HMALVutTSm5r6XcLmn8GFP4Hp1VX5B79po8XBmBIQD3+ieQe
 W6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753198513; x=1753803313;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/AGizxKX0ec1VlXlYDK0SqZKuODc/qqOoyycxQbwqI=;
 b=LhMSh2evu4O0VPT0FbfxlZKYBEfvJM0umbFl3Um+N1fIKzHcs+K5A1Wsr1IB4RSdOg
 Vm6wT9JO886KsxGvHuELLU6hpqtyPNA1Ek47G3P0FupCCx9Wru4SlEDLNYjR7gEZXF4X
 M9FgANAJClR3EP9L/IjzduRxqfsHpvHzp8pEqLpPa0q/Rg5AaUFGpGeYMrMTeKewf8Tt
 AMgu8o/rORo7ANxJg3q4lF0DHCdnXkaK3quH2Dx/AYWYR6cDbKN2m1vaJ7ckVM5Rd4wL
 dsZGg4Gh+eNzw0CvY7uHtToVT8BKMjuGU43u/sh0ulsBsyiggvIAlT9vaduO/gJ5uACV
 QqfA==
X-Gm-Message-State: AOJu0YxsmJhvADzTHJHQNMq1OcKqLlBcwv0HNDz9Qy6P22JRTEQqLt1z
 CkP1ENgws0LiiuBDHu6Fh/Ze8AmVhK8ZHdhi0zBiOVPEHR119g9pGlShXx/hEm4lkPA=
X-Gm-Gg: ASbGnctVydjJqx4yCuM2VMoSFN8vHjvavwEsy8UnPREPJAzaYiSqhrvsmZFzIuUSMKo
 gc2PNUyufJzjFiS8jxTZjFfj6wDXTzwS8taYCmpEumUr3u9pdX6UILkZSYFSOYbd+A8fXE2MkOI
 2wBVzLSw0f46RrMB8h6wGH9kL5CAw2KOGMhYXgnSonzxRRUBGvu6otPo7HW8KwH11301ZXZ/EFl
 pliUlOUGXAYjrp15K/FTQWmOTCfSNg6rGAlkyn6k+A10ggXxebMGlL9k7v1+o02NRvMBWck1Z00
 Zk36heO/1UOxl8blZmbdzj/ZaqFIFsGJdMdMA6aTYMv0qbujPAZSmW9TrMuU3rgeHjBgNVbdMuo
 khLuf/qYmyb5VT+zG28yymtKUT142zcMwq3cmygl2rAOLY7SGOinfYgN2w+rr2Cjcww==
X-Google-Smtp-Source: AGHT+IGEu7lv0G1D+p0yaGKpVzKqIwl21YhKzQ8XpUkC4QSguui2e/YqKYCBoR4ZHcCoy+gZ80zewA==
X-Received: by 2002:a05:6000:2084:b0:3b2:e07f:757 with SMTP id
 ffacd0b85a97d-3b60e4be9a5mr20223056f8f.1.1753198512866; 
 Tue, 22 Jul 2025 08:35:12 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886286sm198716285e9.26.2025.07.22.08.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:35:12 -0700 (PDT)
From: Casey Connolly <caleb.connolly@linaro.org>
Date: Tue, 22 Jul 2025 17:34:55 +0200
Subject: [PATCH v5 5/8] binman: add support for building Qualcomm signed
 MBN ELF images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-b4-qcom-tooling-improvements-v5-5-df143f1247fc@linaro.org>
References: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
In-Reply-To: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XmkAWcRbUhEPPz4ZKBLh2YXGvLjiQm2W8G645GM5bTk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoz69Ssao18ty2+d5SXokW3WkfIhg1svpcBh6/1/q2Yzt
 27x2bm8o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEyE+Twjw+ZUvvT+6RW/e/7z
 KVw542xmoS7cNmGd46qZfcHSx9dpT2NkaFy3aCpD48Y9Z4Vsl857WH/3S2fUwxV3o1i2TQzepWZ
 w+jsA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Casey Connolly <casey.connolly@linaro.org>

Implement support for building u-boot.mbn files using the new mkmbn
tool.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 tools/binman/btool/mkmbn.py      | 29 ++++++++++++++++++++++
 tools/binman/etype/u_boot_mbn.py | 53 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/tools/binman/btool/mkmbn.py b/tools/binman/btool/mkmbn.py
new file mode 100644
index 000000000000..232e2b442a16
--- /dev/null
+++ b/tools/binman/btool/mkmbn.py
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2025, Linaro Ltd.
+#
+"""Bintool implementation for mkmbn"""
+
+from binman import bintool
+from u_boot_pylib.command import CommandResult
+
+class Bintoolmkmbn(bintool.Bintool):
+    """Qualcomm MBN generator for U-Boot
+    """
+    def __init__(self, name):
+        super().__init__(name, 'Generate MBN (signed ELF) image for U-Boot')
+
+    # pylint: disable=R0913
+    def run(self, infile: str) -> CommandResult:
+        """Run mkmbn.py
+        """
+        args = [infile]
+        return self.run_cmd_result(*args, raise_on_error=False)
+
+
+    def get_path(self):
+        path = super().get_path()
+        return path
+
+
+    def fetch(self, _method):
+        return True
diff --git a/tools/binman/etype/u_boot_mbn.py b/tools/binman/etype/u_boot_mbn.py
new file mode 100644
index 000000000000..e470b31fa318
--- /dev/null
+++ b/tools/binman/etype/u_boot_mbn.py
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2025 Linaro Ltd
+# Authored by Casey Connolly <casey.connolly@linaro.org>
+#
+# Entry-type module for 'u-boot.mbn'
+#
+
+from binman.entry import Entry
+from binman.etype.blob import Entry_blob
+from u_boot_pylib import tout
+from u_boot_pylib import tools
+from binman.btool.mkmbn import Bintoolmkmbn
+
+"""
+Casey TODO:
+
+* move qcom-binman.dts back to arch/arm/dts and figure out how to make it build...
+* set CONFIG_BINMAN_DTB in qcom_defconfig
+* update docs
+
+"""
+
+class Entry_u_boot_mbn(Entry_blob):
+    """U-Boot Qualcomm signed MBN ELF image
+
+    This is an ELF file with custom program headers containing Qualcomm
+    specific hashes, signatures and other metadata. It contains the
+    u-boot.bin image.
+    """
+    mkmbn: Bintoolmkmbn
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def ObtainContents(self):
+        self._pathname = tools.get_input_filename('u-boot.bin')
+        res = self.mkmbn.run(self._pathname)
+        if res is None:
+            self.Raise('mkmbn not found or failed!')
+        # Exit code 61 (ENODATA) indicates that an MBN file can't be built
+        # for this board. This is non-fatal since it may not be required.
+        # however we print the stderr which indicates how to add MBN support
+        # if it is actually needed for this platform.
+        if res.return_code == 61:
+            print(res.stderr, end='')
+        elif res.return_code != 0:
+            self.Raise(f"mkmbn failed: \n========\n{res.stderr}=======")
+        return self.ReadBlobContents()
+
+    def GetDefaultFilename(self):
+        return 'u-boot.mbn'
+
+    def AddBintools(self, btools):
+        self.mkmbn = self.AddBintool(btools, 'mkmbn')

-- 
2.50.1

