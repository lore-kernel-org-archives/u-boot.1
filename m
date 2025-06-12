Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E27CC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87F5C82C87;
	Thu, 12 Jun 2025 16:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PIU/L3eF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A7A282CC9; Thu, 12 Jun 2025 16:16:50 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F1482C7F
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cfb6a794so6195145e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749737807; x=1750342607; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3rBlczCLDuJeJVfwlHqjHo9naPJLzz7NV2CUVDyqSTk=;
 b=PIU/L3eFFFQ4fv+60497+lBIAzsOdqwFEPpfoXNUAa8e1AG7EuuzJwy7IIAZx0TNTz
 vZ7X4duR1ygUrIEOFnltPkLIB9WT36ukJGHFh8jLknPhEsBMSU8lZYbJZcWOx4NZM68g
 s6/UxupahBpO+YuW5runClBmCP3ESiWIA0iG6ZACo1boxthI5ilco0sC3xCHbk3jRe0l
 Ev/cm+qlz7W74AxfXCCYKS8iFz/92Hl2R5HhNYzTzxW769c0RnY10zsi9l6WnHxl6vdO
 ukSEFQ/IfnIQVVzyn1y464+0VFak6GYEkszI+DRjUEGwF5LC/YkebGL3rj3RprqR3eoF
 7rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749737807; x=1750342607;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rBlczCLDuJeJVfwlHqjHo9naPJLzz7NV2CUVDyqSTk=;
 b=niWZmDi68bMcWq97zCrorX8t/Iz4BaVn5VwoEZ+LIoBBMCJSrm7WBbF0etjlFOdJCF
 8WKTB8xLQFiLt9yF3us3EubIk7ooLwu2iud7dxCuBnl0K5wJ5o5cMRcSnWcQP14/SXwL
 FPJomHtDaRffahW2SzhfCx920w4Fa5qCUQ0cn4cclUE3z0aGXIYuC6y6nyURCj0/vWCZ
 sX53WwGcgbYMGllpR1x1cFAm+n0ARg4IEYtKWRYLRk0NT6DBUaPetiL67W53rKzNN87Z
 g9i9Zb8yxHtNJLJAeD8b0fb2D1sx/y8YKEsxZprs5XTsDfOhppFF7JLUmraA43Sa2p8r
 upgQ==
X-Gm-Message-State: AOJu0YzTGFX8tBc7SjY5B9Hef9gUg6TXribcnw7aAGqyQQL3vpny4J6z
 YJWcjhpeQyBhnHgf11lURBQMaDJjOyvjwZ2FQMmBqu5Dv8cEvxQZaXXay2W6fSXxJ8DXLxyYGKj
 FVkaz
X-Gm-Gg: ASbGncs6IdilYVJNiIE+HeIoDk+UQKZCrkmqxSBDJjB/VnSfVOlqYPnA4sP6cRLYMZL
 O7z/Ld/cV4iv55FsnNjHx6hFqOqdZJo6g7UB7araulTP5dxNgE1y2EkQSA7ZzzgKgF1IQC1GKYs
 faTHiouH0R/OKjjZ8hUPoaXbQPf9zyFBEsJFRYuadAOT2EJQU3KPN1XInrFVSUG2fbOyolqesMT
 lmRQq1i6k1Gr1mHekSLUwwk/Ncwk4lI+F1zlZ2jwCt2QJX4DMzIBunZVJwcf8UHAEYOY1LfoMZj
 hujDsIAod/v+KgOv8qH4znqyRSPmTnVcCFTj3Mt2Rh9XVCurTvKQ/ghcDIFl+1ps1Mo1LT8n
X-Google-Smtp-Source: AGHT+IGXdWPVU5l4D2oYxmyG3TBEyESq5Mz3X4IK0qYNj/OQHusQ8e1Rx6weoCRjn5GAN5pmxkOGKA==
X-Received: by 2002:a05:600c:1d94:b0:442:d9f2:ded8 with SMTP id
 5b1f17b1804b1-4532906416bmr56032755e9.15.1749737806751; 
 Thu, 12 Jun 2025 07:16:46 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561b510dfsm2044006f8f.82.2025.06.12.07.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:16:46 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 12 Jun 2025 16:16:40 +0200
Subject: [PATCH v3 4/7] binman: add support for building Qualcomm signed
 MBN ELF images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-b4-qcom-tooling-improvements-v3-4-76f34cf216e2@linaro.org>
References: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
In-Reply-To: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3365;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=TXFHSBTqflb6f6NfX7pRRs+cU+8UjpId/6G4GiI9qEA=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSuFGvw+ehD6xUslITd7b15HwQIJL0+3sKW2Ny
 V+cE8QvJEOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaErhRgAKCRAFgzErGV9k
 tq6pD/4jaPX2bacPb+DkkQtxEEcl/X4fLm45G8CCWM3siuNwWcJQX/pTebB4Zr2kBbRD85ziYIy
 gzcVbzK4O44M3mhnRKfJTyWnaY7XL+GY3kUldQJHqj54KkwGcG2RI8G3y5CJ/BmMSgiP+0ZNi4n
 3Is5Tc19DM7Jv6zOkxDAVu3w1XiIVKvdWjxnDUI2MeYvYsr9Gh0xrwmwjRlOYFSdDqVKqP0wn6x
 iOkuIfjcOUf/5AsiMwIPptOf6WHYsdbxoTyWq11UJsEbPUrYA7+5b3Ek+4SlP2SpqgQ6UFiJQ+v
 QzFwS+5nXNLoRWWc0J/rFFLZzi6V69uJJ+jnM+lO4CuTRjbgFugJcoMeVTmZf5jk3bXkVIH00Uv
 NwcaS9NKkIW+YJ5jBzBJoiJUlAc4QlZWswOAisz7KkADKTKNEcnD4ya0CjghQVT/mO6Tx46JGKB
 JqGC+GlyJhlCLY3oVcZyX9cAgu4arTyT4sJIeJSJHOt3BObcRRDpGtAEMM1HGinVTN0g4m+hA2x
 W6tmUCYnPGLRuZWg+vVc4WxjcuiEU1a38IzGkUePyADynEJxD3sQdoIs3rcEMi0bRf28bYXzyn9
 Zr2SqYJPFq1rVXBrLSgoY2TWHFtvYDHHICQBOqhLi7LyJm4LdtjCSH3ESzDEL+xXhebtDbG2Ijs
 cVCYzbQoYXmxvBA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Implement support for building u-boot.mbn files using the new mkmbn
tool.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 tools/binman/btool/mkmbn.py      | 29 +++++++++++++++++++++++
 tools/binman/etype/u_boot_mbn.py | 51 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/tools/binman/btool/mkmbn.py b/tools/binman/btool/mkmbn.py
new file mode 100644
index 0000000000000000000000000000000000000000..232e2b442a166f9e86a4d4eb5f55f624eee0dc62
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
index 0000000000000000000000000000000000000000..35c271a45e3ce75f10d1852eb0ac290b38913d84
--- /dev/null
+++ b/tools/binman/etype/u_boot_mbn.py
@@ -0,0 +1,51 @@
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
+        return self.ReadBlobContents()
+
+    def GetDefaultFilename(self):
+        return 'u-boot.mbn'
+
+    def AddBintools(self, btools):
+        self.mkmbn = self.AddBintool(btools, 'mkmbn')

-- 
2.49.0

