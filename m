Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86D0C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A74780EEC;
	Wed,  2 Sep 2026 13:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k409eE72Sh9a; Wed,  2 Sep 2026 13:41:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356516;
	bh=bcgBAQQ9l2yg4Dv0Bz/e6sHcs+0K+LO2YO+3TspM+GE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DnZOyKf6HtXbFWOyz9PAfJwNGMTZhRQsmtf1KrJo95tOwJ1RMQJc4Z6pGPNQqw8rl
	 fIUlsnzItqYzlXS5UklOw3E1gSZOoB42y6UzHIfSjRC3a/12ZRbUBtZFnIUKcIJ8ou
	 1ydYcNjuiVTFgQlonZ6WfsE6oHVbIX9RcvWPVnl8rarVXn42DJ+cuqDHCG5MZ07hIw
	 eNCpru8Ugov8YyDS0/RJeDtMwvJFgMd8OM676FahI2cZ0Ce1/2nNCz3KASTrEBxFw/
	 FS/ZBuUbndf+0nKcDhkZG5CW+fZCv79vHh27+iqPi/Ec1BOYyF+S5JpNpKC6tQOIVv
	 TwBZxPylPezvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6238A80EB4;
	Wed,  2 Sep 2026 13:41:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 594131D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B17F606CF
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MnTFvU_Nh0C1 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:41:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=nhTELMHN
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 679936069C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:41:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 206971A1957;
 Wed,  2 Sep 2026 13:41:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E5FE66053C;
 Wed,  2 Sep 2026 13:41:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1FE8A11C7977F; 
 Wed,  2 Sep 2026 15:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788356510; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bcgBAQQ9l2yg4Dv0Bz/e6sHcs+0K+LO2YO+3TspM+GE=;
 b=nhTELMHN4m/zifptizVTQgIEizk8ZXcLrNWSdmDJPs+X3265UorjpgCKutwMSGWqr0ByDC
 5TR+PsUbi4/nfHqMo00drR4My87LSICUZVY+OZmNk8eFD5WRV+jevohWD9IevbeaivKP0l
 WX/XAFcqkKLgmG1SfzFM1xtDepXIxbs0OrjaVhLrlVCasT9iuXAUUtplKd1jTKggU1wbJ5
 KqQ+kdeMQXKdfu0hKVvsgF446RPPmRjg4s7WTGASXykzWRGiCKCiRE/HJsxlF+7Qj6NhTD
 JgE+lgqtmM0V6qyhBID5xdo7oRbu+9vUfRl7XyiYm95AdmM+QT/hqg0WMlOZ5g==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 02 Sep 2026 15:41:28 +0200
Subject: [PATCH v2 1/7] binman: add nxp_imxcst base etype for i.MX CST signing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260902-imx93-secureboot-v2-1-5947b92a5072@bootlin.com>
References: <20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com>
In-Reply-To: <20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4959;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=kAUr5fYXN/6NRqAj3EpxrY/RE5CMTIm6sHATadyaies=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqmCeUE1rMGnAvjDW32eA5SLOB1hMKFLohAXdPa
 Kp1qz5RcxKJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCapgnlAAKCRArAF6gG1qP
 Awu3D/wIWzjVgLf6huKudyigRWrg1u7w+volUknphpPQMJlwUdMb7bkqOvv7AgVFll3FyS5zezc
 n/S3ddwFUNczIEFJce/jKWcL0eoHwDs9xDAnQUR2+zxkCYVnibtO90AUrhyIAOheuAJNdFksSYS
 v08FUOF3yBB//LVdXpm55QXmRx2A5yvGoq0z3V9xBZPawXcriGWfXJmKvemxeHw1NaHV9ylwSAQ
 NAvqjUSIfE9Gzyg80ndkf+YPCEzMeknD3C98sCWKKy97ov8aAuLUPS3uNeO+IqCwKgM/BB8EUpL
 E1S2pmz574URMvHdaTvN0jxDdYWxE6/SHIfMHDRMy+rlzy3z18u0Az6hhsz6y3jSBaWPk17P25v
 Dvy2lshOK7PynmOqWPBPDZESqiIXV/r1Af7dB3Al/GDd2fb/wXAYbOawCQY4Zl+EXCGp/ME2gh8
 UBJ5IbZKIFT56uDrC67Rn9u1f/mfm6JkN/UNgO/XqUZHXbq7o/mrCXoDQtXJvQtQLgf+pe/WEx8
 aIx7g2SVFui3vFOQbzpAS9uuwm+2aw2z9RLo8HEsiah821Lv5HXOOPD2iEG2e0DyAyqCoPzrNks
 kF0SnIVpDj6xpLDw+8FQbbGqcsbRs4HJPucL296OD46DVSmPcZgtQF7kcF3VrQ7zx9fSaPaj1rj
 0/JL0HER9OB5R3Q==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add a common etype which provides the shared functionality for signing
i.MX images with the NXP Code Signing Tool (CST). This includes the SRK
table property handling, the CST bintool registration, and helpers for
writing the input data and configuration files and for running cst.

The nxp_imx8mcst etype and the upcoming nxp_imx93cst etype will be
converted to use this common base in the following commits.

No functional changes.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 tools/binman/etype/nxp_imxcst.py | 121 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/binman/etype/nxp_imxcst.py b/tools/binman/etype/nxp_imxcst.py
new file mode 100644
index 00000000000..3f863704b87
--- /dev/null
+++ b/tools/binman/etype/nxp_imxcst.py
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 (C) Bootlin
+# Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
+#
+# Derived from nxp_imx8mcst.py
+# Copyright 2023-2024 Marek Vasut <marex@denx.de>
+
+# Entry-type module for NXP i.MX Code Signing Tool (CST) base class
+#
+
+import configparser
+import os
+
+from binman.etype.mkimage import Entry_mkimage
+from binman.etype.section import Entry_section
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+
+class Entry_nxp_imxcst(Entry_mkimage):
+    """NXP i.MX CST .cfg file generator and cst invoker base class
+
+    Properties / Entry arguments:
+        - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.cst = None
+        self.srk_table = None
+
+    def ReadNode(self):
+        super().ReadNode()
+        self.srk_table = os.getenv(
+            'SRK_TABLE',
+            fdt_util.GetString(self._node, 'nxp,srk-table', 'SRK_1_2_3_4_table.bin'),
+        )
+
+    def SetImagePos(self, image_pos):
+        # Customized SoC specific SetImagePos which skips the mkimage etype
+        # implementation and removes the 0x48 offset introduced there. That
+        # offset is only used for uImage/fitImage, which is not the case in
+        # here.
+        upto = 0x00
+        for entry in super().GetEntries().values():
+            entry.SetOffsetSize(upto, None)
+
+            # Give up if any entries lack a size
+            if entry.size is None:
+                return
+            upto += entry.size
+
+        Entry_section.SetImagePos(self, image_pos)
+
+    def AddBintools(self, btools):
+        super().AddBintools(btools)
+        self.cst = self.AddBintool(btools, 'cst')
+
+    def write_input_data(self, data, uniq):
+        """Write input data to a temporary file for CST
+
+        Args:
+            data: Data to write
+            uniq: Unique string for naming output files
+
+        Returns:
+            str: Path to the written file
+        """
+        output_dname = tools.get_output_filename(f'nxp.cst-input-data.{uniq}')
+        tools.write_file(output_dname, data)
+        return output_dname
+
+    def get_config(self, template):
+        """Get a ConfigParser loaded with the given template
+
+        Args:
+            template: Configuration template string
+
+        Returns:
+            ConfigParser instance
+        """
+        config = configparser.ConfigParser()
+        # Do not make key names lowercase
+        config.optionxform = str
+        config.read_string(template)
+        return config
+
+    def write_config(self, config, uniq):
+        """Write ConfigParser object to a temporary file for CST
+
+        Args:
+            config: ConfigParser instance
+            uniq: Unique string for naming output files
+
+        Returns:
+            str: Path to the written configuration file
+        """
+        cfg_fname = tools.get_output_filename(f'nxp.csf-config-txt.{uniq}')
+        with open(cfg_fname, 'w') as cfgf:
+            config.write(cfgf)
+        return cfg_fname
+
+    def run_cst(self, cfg_fname, uniq, backend=None):
+        """Run CST tool with given configuration file
+
+        Args:
+            cfg_fname: Filename of the CST configuration file
+            uniq: Unique string for naming output files
+            backend: Optional backend (e.g. 'ssl' or 'pkcs11')
+
+        Returns:
+            bytes: Output data from CST, or None if bintool is missing
+        """
+        output_fname = tools.get_output_filename(f'nxp.csf-output-blob.{uniq}')
+        args = ['-i', cfg_fname, '-o', output_fname]
+        if backend:
+            args.extend(['-b', backend])
+        if self.cst.run_cmd(*args) is not None:
+            return tools.read_file(output_fname)
+        self.record_missing_bintool(self.cst)
+        return None

-- 
2.55.0

