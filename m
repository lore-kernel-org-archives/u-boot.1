Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5DACA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B42660B2C;
	Wed, 30 Sep 2026 13:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Cdxw03YbU4D; Wed, 30 Sep 2026 13:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9545E60A4C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790775793;
	b=irBuBXGGyosqXIWSkmH/g1auL9eVvJ/4mQG9mYWVSyDuEh95TEWi5dOWKUV6BFiSD3ol
	 B4gARnOt1+d7OJDXr/bsSOJGgzWuNm1pH9kWU0vLsXbGt7JySkxEt7TlL9YSby7gG2eU6
	 Znbhf+6Y2b1A47mtU4K1uCAvWGnS1Rb4APEcpxMFh3mXWEITLdUEJLRPM6uZ54LDAdqsI
	 m733uxwzKcrBDsSZAZnuts/ImCLB7/vQr3WWj3Ybp/uiLhuCUYiB/l/4B/pqEmpzWb6Yb
	 QUFFHtk8CJ9Z1HYu0K/OFRCHESGcPvZ6/G69AovKjKktZDt/CS/LYNJim3rRJJYzKYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790775793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xuQDIuRT5Ydlod8EJ+kubc6LLrdpbkAqIRzmXDaMO3s=;
	b=qD1BY28swccR2hEInKNa0eEHNy4rTo9yPQcPEqgaCh0l5lwgkiWJx58AUM9yWgJ5ujC5
	 HxHNkOMYC91YcVZ4k7wPuwlV9ETbARXl68tQrQINnFyMN32Y1v3POwbtuNOckMz6PLiwq
	 jS/XOy3a6FJODZXKBA8LLEUnHq1FNkczycvBGzERlmfeUVYuKwhdaRge66n8r/eDERq8J
	 sADlct4mtRtX7Zmq2hMmJacF/s+R9BHIBBxemO2cHtz8YT+oGLKf/8XNnxqtCLmdaNCZy
	 yHdtOxIxgKZsEm8XtfoP1C5x61ebI+aop7FTOe8cNFz5/V9iah03w07hhukYQCqw/XA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790775793;
	bh=xuQDIuRT5Ydlod8EJ+kubc6LLrdpbkAqIRzmXDaMO3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LqjnT6f7hs71/lL+keTW9HeJYU1/TkRyrSNeii+C0fZID6DMPYkNQxSIfAX403b24
	 nTGmI2XxQoItCyefZyqQCKJAXnj50LdWK0kUejlMU1QS/iCx+1NlpteuRXbM9WwWtM
	 u00iSX1IF2nurySAwC+i7N838cieyjAWtMZg77WgaKz/zweQOb7T+NN0HrKepEBgYJ
	 Z/wUJ0wECsstToNeMw+iqxpB7X98RdgMKFW3pRgFYV7SgRO6nBxQMoyc+gbvcmfJGy
	 1Zy6UXDAo0kOGFvsVy0q+OcocPpjy+HiI6aUkIblQAthCLwxvPKVZvsGV5jtd9wUgr
	 hnJykZIMrI0pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9545E60A4C;
	Wed, 30 Sep 2026 13:43:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A422B3AC
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92E4840A8C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sikxwAVeNQw1 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 13:43:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0DCBC40862
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790775791;
 b=UNxg4eckR9mVAW+WlT2xChJVblLMBdkBFCKq1Ylz4Gzz+RDPljIFszqqAadsinf5wgr4
 KKA8yUOGbbt0YA9IGaHd+9cAHs56V8kfrikO0bGEkaC628oMfaYiUBg2KHAxz14puAKhe
 vPuUXm9qCxeAltUo9je0E9n+yiuV73uiTPR6mGk7SfAutcLoB2tSRr050l19yj1pjdh9I
 1uxrM0LJ4m+Ex1BLzcfC2u8EQDI+wybJzjp9nmtwAShV4zXbZeBP1OydRptPUx9/pB6uB
 RwZH5QW2ZYCJFykqaefcY102QGhXJhDIahePZH+m4MmYuWyIm8l/PFMZFV/Uj/3hgzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790775791;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=xuQDIuRT5Ydlod8EJ+kubc6LLrdpbkAqIRzmXDaMO3s=;
 b=XaeFzy+Cgzj3kQXCCfKBqhmWKPJcAZdD3P5m+YczQH0aB4YOfcfrvX7r2qhEhLNfHh7+
 guKrbLPLeFaTlqU8D+Qw50u5pP5otQtS7arD7wYYwg1yRZLCMOkdTEfX4i8ppBc+6h6Iq
 nWq8UT8qUpHxOnY6OvjPDy0zBsbbzCE9IgOM8JiQ8f6yCacuHkTsjVx5BujkjdLoOPB31
 n/ng4ixQYokmHm+a0Nm5PiEEKVcRUTo2Bg3NMFHAZQWxpzlP7/gUpGrgMQJhuoDYawzGS
 Ln4a0Nolgy3EsWoSVlUiC9iWIb69Sc7GcarGQNhyLUeyyXyzbPkZwdbs3c9CG8E3A9Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=n9crZMfJ; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=n9crZMfJ
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0DCBC40862
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:10 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B83251A104B;
 Wed, 30 Sep 2026 13:43:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8A2D360749;
 Wed, 30 Sep 2026 13:43:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 29D8A103296AE; 
 Wed, 30 Sep 2026 15:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790775782; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xuQDIuRT5Ydlod8EJ+kubc6LLrdpbkAqIRzmXDaMO3s=;
 b=n9crZMfJL7SEkforxCG/5v8iDEuITcgU29sTngbAEVDGKbyQ8iXDpzVNbLWI+ubp8XuLdA
 NWuVaAH0LpO2aZ+nRJN7meLdnmnbDMRMXf0OPIKOqGRl+lToxsDhZxMiVzMpj1swkeE3yF
 5iHXoiGgmffvNz+yDp46N73vxf9DvwG+5bvmz7lAQVZuvYIej7P9GbBnBjTeAvYRZUuF7U
 todzkFC8IooxhvY0BNRhsXm2PQ+XnbaQBIFgcxRAPhywzEOdbFBWuB2X1gq2Gz6gNyfwxG
 t3zUajVtHM0fLtPL2mArb2tCICAfRhqGf/Qa67smRrrNbL0RTKr/0JAp2Ig88A==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 30 Sep 2026 15:42:34 +0200
Subject: [PATCH v4 1/9] binman: add nxp_imxcst base etype for i.MX CST signing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-imx93-secureboot-v4-1-f968a1b14dc5@bootlin.com>
References: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
In-Reply-To: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
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
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4979;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=WznAPlG6bDiOay+VliQcgDEQ3hQFDAaAzgzFJUepVGY=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvRHZSeuCxxotSdfmNMl1yM1nmkbEIvBE9exaN
 XXSP+a99p+JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar0R2QAKCRArAF6gG1qP
 A3bNEACo1+BpKuSGzUTX2n0xTunGIrbFclJaAiGxhdDIlICLa3yaa7THwO+Lzepfxz+fkgJyc5Q
 yTto3oykZbzxCxBvZR8Rd9BvFP0NW6Je+8gzW8qrl6/ZgRJW3SiiYiUK1QEoE1bE3TkAMHQie+Z
 r7essk2p8x4Fia2O3HMGV0RplFyuaM26/pW2FMbcqOYtklJxLynYLUsmOgaxNCEBoEL9yyIuZJU
 X1VUINLRqEHfvA6yyw7xvS0uOp/ABifk29TrjtPJjFk+dAe1GRBx9h0zH/QartlEOYtJcAaXwpS
 qjC6TPd9kZzRJMA/Gjy6EblgckXh6FPewxcWl/37yD2/+85GBF4Jn1L12sxEvbKSq800BAgjJes
 IZVLqFSOgmqrIRuStHXtkqql4qUQqyQ4auhReVH4S7CJl/M+9DX8CwR0VTl43BGVns11CgWdj0M
 SrTtt3Vhr86ZaJy+hV0C/9Ds3YBbt9pX5FgsZ1h+aWRYh9QvBzdh/zFvBdT+jCHATxdHkBk8bny
 QKiVS27Q6QXWxK9pojEfSPKK2SMFMLAwsXlWmhWbg8tkK0v9nmPgQx+2Dfgiyc3nLjFMp9n9cvs
 UkJqvKN8RjzINZvpyXVGMczd3LYc/dC9e96kfKnC72amFkpS/hkbD/dGtp8hZltGzm23uBC15EJ
 iwE8B1sE2Ra16Ng==
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
 tools/binman/etype/nxp_imxcst.py | 120 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/tools/binman/etype/nxp_imxcst.py b/tools/binman/etype/nxp_imxcst.py
new file mode 100644
index 00000000000..718537fda40
--- /dev/null
+++ b/tools/binman/etype/nxp_imxcst.py
@@ -0,0 +1,120 @@
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
+            'SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table',
+                                            'SRK_1_2_3_4_table.bin'))
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

