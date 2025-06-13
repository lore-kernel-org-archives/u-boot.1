Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113A8C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 17:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F9D82F33;
	Fri, 13 Jun 2025 19:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ueg7f76+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81A082F4E; Fri, 13 Jun 2025 19:23:20 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9FE982EA3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 19:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so14097805e9.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749835398; x=1750440198; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Df1pTdKTeqg3Lb8MB8WBMAKUSFdZHTW3MgkVpG8A5qs=;
 b=Ueg7f76+OkSPoe/o6uV4p8+1R5otFCEG/tHNKnRjHbhbsSTwn4AkV2+ja6YQnJOMva
 N0spth0kPemj9Z5GQhXMSBDaRGkPfi++sU8MV8315vKZJU0k1d7HxUppOZeSr8FUiECz
 r+X7nL1BhZsFK2J7rsBTEDrl7eJ2lfA25QQ2qlUITougbfQ3Je4afFQlfuh5THoL0muu
 cdLv2pT1yGCwlh1o/YtPsve6vz9/f9018jQ1nf4uv9ZOXNiX2a6X6x1l0w8QN6nZXgXc
 Uy9Lvzxq194bOinQCjIho1UW8pb4Qqy1aa0LzmhCHZnfOn3pDNfQLbdIIDg8vyg35wjG
 l9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749835398; x=1750440198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Df1pTdKTeqg3Lb8MB8WBMAKUSFdZHTW3MgkVpG8A5qs=;
 b=k8D+Mm2Ws+0fVdeW8dx+n5FzfsLZyvprVRagkMacJFGiovj2DzL5NWth+5/RBH1VFa
 O8ypOOzsRmNLAABqfVLMLIDtD2KCbYfxN2HSbmAupnjDj9n2LvJNbyatJjRmToUUsqNa
 R8ShzyumNQLb8GFPsT3qFE0blTzcmYCUiZ7DY8JLw33z4H3vwjqoOVuNwR5zgO2yk5cY
 767o32TkGjo9yItKkCvMX84SBYWWSpDLUyMdXWiAeaxeGWKGvVXqSXmP6gh4itj9hqLw
 EU3X19YK+PYgy7ZvPEKkSPCOH65LzCUfyltZVcjxGqAkYAekiV40nywe9wYZoxpd8pEq
 FfIg==
X-Gm-Message-State: AOJu0YwHbfCNL+/BE1/ofUZwNW/3rHwuoPtfYHlL5245hatFcu6JzT3v
 lssAGfU5xwiW/g485jiK4f5b8PYmwZdLlTo4kwYc5wK86BtIhhNElmhi+P+xnaDZUp8=
X-Gm-Gg: ASbGnctI8Dhr1/xPIiSqWXR7wtLsr5JOs0ifDVGWFOnaV8P2PeheuaOX3UwvTKTeT0y
 EhuOgxFLiU9gaP8kOTDjL8WJKJO5/QbNcebgDstjU7rAn2VO3ni5giyX2n6OTGacIpOghR7pI+P
 JlmjyxtEP2y8FCM+Z3YzkchkUYRNxdZUnLYJ+4oJBC6IK2nMpQukndY+UUPQJE/Rk72qJUdVoZg
 r8SIPfZSTZRDskR5xarMkgWlwqfrmHt1ZjUzuSCyAckmsUv2CeuldDjtuzg6PyBjCDJhzP3J7En
 OHe3h7H0shOMjkvD5dmAaDFuOPs0oox1kccvqlJfyJDn3xNCPgJdR6AAiGyCroP8SQ5nSuD7oDB
 zNQo=
X-Google-Smtp-Source: AGHT+IGAA5nZ5T3nZRWdOxiEApOa0iihLWcu5xO7M6qfVtiUPKwfxlKf9+gxxoBh/htZMSM65cnefQ==
X-Received: by 2002:a05:600c:190b:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-4533cadefe8mr4311765e9.7.1749835397951; 
 Fri, 13 Jun 2025 10:23:17 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c50esm57895015e9.4.2025.06.13.10.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 10:23:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 19:23:09 +0200
Subject: [PATCH v4 5/8] binman: add support for building Qualcomm signed
 MBN ELF images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-b4-qcom-tooling-improvements-v4-5-7ea1c68779fa@linaro.org>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
In-Reply-To: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3476;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=m6wxSaFMiSwQB0KhJG9e8wz/pDDnFRTBJ9h99vdxSGI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTF57VLFS8VhjKHMW/URPEkkJK0ZheJ+cEjYxq
 9pdJtJbmf6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExeewAKCRAFgzErGV9k
 tkaHD/9y7S7pYXYewC5ePyGInqhyWzd7l+HU6oa0n32Amdw+9q9/sHBTVjfnRnYA0rUdyd8rVL+
 pblNx4r82I8eRoFENezpVnjwnyt9J6skRa19RYYnf47EwUvjPkNF1bCZEwkm3fboVOD/1EqOzWx
 DkWonA7DKptYZ+iDrxZeQjaUVnz1Jvdkk/w+FKVuP7Xk/IXwkD4/uGISkMVYdDkBup5UIK6ZWld
 QB9ZcnKF2CSI+D6DImTtj4mqftrg/fCrYLFHuxjpf53ttVA+8WUctUsRlnfFl0C01me6enTpctD
 IeklYQMpNj2bFRDzmYMJFVYNoh1EljIhM+0sW6ZjvkzCeV9kGZdgnKogdDeAUTiMrmpWqYn+pU+
 5g9SZLBX426LHsRvfHttd8lEfwTbNpYZ0A5JRQPJ0KzhfmA/CCeMCCPO0nY1K3AiSINI/3PA6vc
 a4OkovthJ70uRiyiiTllR3hTITwqsPhz93h5SVjtflPFAeaGx38J4nhjyiv6szKX1lviNnjyFza
 X5S0AZucAAE0T/+JmXkdETJzcvY2Hu5ct1Qh3cyeebWKnD/DGMkbo9lltKDkoo9BuiR8OY+2mdt
 u/EBV2vis9/L7xh31l3rZMiYunS53nq2dHQcSgZ4u8DiL3p8Xz48SwlbbX8V+zR5HHNAy2Bdmbf
 ytzCwts4TlawTqQ==
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
 tools/binman/btool/mkmbn.py      | 29 ++++++++++++++++++++++
 tools/binman/etype/u_boot_mbn.py | 53 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

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
index 0000000000000000000000000000000000000000..e470b31fa3185c1eed27ccd46c2d845111c1ea59
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
2.49.0

