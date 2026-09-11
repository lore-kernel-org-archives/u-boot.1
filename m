Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6A6C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54ECC60621;
	Fri, 11 Sep 2026 16:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yWeDsP5ZdFcp; Fri, 11 Sep 2026 16:43:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 02B2460625
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789145034;
	b=mKY8IKUC5xrI/Dppy9AM5qVNwjHtnQ7KZ0kGSFKD/w16a4BPfUvNBRwKFcE7szc3gPiZ
	 r6zBAMImd5HNC/PiX1HclcNOt7izHV022cS9YJkMZDQHlIsIP0slGWIMwjIPrhSEgyFk4
	 k6S51BO0ue1VHaifIJs1KKYao11NUIPXwNa9ePyT3oBBoibt+KdIH0wuKbpIdF1eERm+h
	 DcQdX4PncHTaROokR1l8Pyugd+i4nvgy5kcwpWr+gY3YVQwgFNijFgD/ZFc3HsebZ4fRl
	 Jk0rewMuVedLCUP70HuFIr+SnqOSfQimwrsCuZkX4/Q/9HzQMUvFxsDkfk+HI3yc2BA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789145034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bcgBAQQ9l2yg4Dv0Bz/e6sHcs+0K+LO2YO+3TspM+GE=;
	b=Io4FaHPyqyun07ZHo+Vto67J5ag1a831F6c0+KbqeMn2OSm64/OYdxzbTiM4zRuGNSjA
	 JZ/KlC0hDISobwP7oj/PrqTzIVgUdG4AxYBz3J7Ww2c2WuPJjnaNp4L5+GaI7z1da+mpY
	 Dc8zKTFSBNsYeCiVaep7npb2GL7ZvjVoPx6J4r/gQq342NDIxWdJSYs422Cgze639eq5i
	 zIfMdqOzwcKMcLNoachXmmbbXdtEmbIcNZaaX4Pd402/Mh4D/Mdf51yt5vSF07x9oGI/e
	 wUXtciuovAIvj286BpWtpUtpXkxA5ZMk3WEMmb07Jwxjva1CVy2vJWOmQ5gLj8sUsJw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789145034;
	bh=bcgBAQQ9l2yg4Dv0Bz/e6sHcs+0K+LO2YO+3TspM+GE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dm4cav8KnKQmzGhrtLA/kIgYAkUNX54djKlkuL//mAkSrme+euOraXYQ9r0SMjEAa
	 VAjeobcaMzwLnIASmlnt0mAP0cKJaE2f1YeP+BazTNOgOebmXEO8hYwAXNXvVxgQCQ
	 8XeDnXbAiSP9RoBRNsHOJ8avq7srLf7lZU5XTGYcgp5fb1VYSMw6nZXXiyQvmJaANl
	 3oFx+8lHUDstQHx7h1ISbCzY7yUVtZo9LkeDAFKd48lBga0ryPe1FjRKgSpFZPciOm
	 P1OYSqc418wC4umXcBv70PyVis0bL9n7S0euj++GG1PuGYmEGX1uWdRXkZmYYZgfZW
	 pW3g37uFLK7ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02B2460625;
	Fri, 11 Sep 2026 16:43:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2B7314C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D43D780E69
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XIz7YqrJK7q4 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 416BD80E5F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789145031;
 b=QA1TpGd9/Mo8Dt4uCouzr4ECeeiRc7CrFOwqL7c9VboQNiK+jAVBmHEO/YdLvFYqvVbU
 L7ipbOKEt78fDTCMEaJ9ZnRyjiQ05v/He/dGxjeI3v/geuVbNF4AooPrrnANhttCCSidZ
 KByr0iTuVw+mXFV8hOv022E9QccXm3RE1E1DKvM3O+mTgX9qTICfcYCcgXIzVc6FBoxTS
 GS5JZQuJfqCeSfE2mAGa3LCss6adunlepSidAOeYbn/Yp/Vl4l46e9OWSE6OoaIoWSNnJ
 7sMfScCyWurDcwoWN4KWEflwfonS2AECQyDKFjw747S47w05bH3VwI1ZJj9ll6Hu1/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789145031;
 h=X-Greylist:Received-SPF:Received:Received:Received:DKIM-Signature:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=bcgBAQQ9l2yg4Dv0Bz/e6sHcs+0K+LO2YO+3TspM+GE=;
 b=jxgzAquSd7hADTKn+uMWx/TDxl3F0No8cN/aN3W5fWpHTOPLaqW1iyFrNrJqTXSFwyEV
 HjMNhaAueYWwW6d3E77sPRzzuiQxDBn9c9+osMPvwrKwp5Gzbc/yfRdRDRVw7u6LHvoZY
 iXZIN80ZVYo+m9I88CgX3cqFe/FUKU9xLtUP9wB4IoRehVrdp5VZtRbXgRH/B4oHPvhrP
 OAK1MhXxr0h4qTsP6pfTTQkGCBQ0bdM/wowBLry6fLDEYXZvWTHL6S+KoNM/Eu4KB7kYu
 igPJZ+kmVmJ8kXUFKMRAmG51+QaRkHne4vurRywJ+qDc+kzyqIREK70UU/D1taFWDyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=xD+wqupz; 
 arc=none smtp.remote-ip=185.171.202.116
X-Greylist: delayed 464 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 11 Sep 2026 16:43:50 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=xD+wqupz
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 416BD80E5F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:43:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 56AF6C63A0E;
 Fri, 11 Sep 2026 16:36:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7E3F4601A3;
 Fri, 11 Sep 2026 16:36:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E43FA11C7AFAD; 
 Fri, 11 Sep 2026 18:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789144565; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bcgBAQQ9l2yg4Dv0Bz/e6sHcs+0K+LO2YO+3TspM+GE=;
 b=xD+wqupzbSxz8dd3+CFxEzVbutJthWxmoyPRfuR/oJdAT3dVL91Rm4P11smP1dlkX+l4CL
 w6Qw0n9aJJqlmGiZG5JmSympLTLtDHhx6FiXSo6bI6J2RWw4w4tUMDjOG7RahJ5e9aiAno
 FsgtrFca183EOAGhx7VLoAy9cZlFni4Zlocbdz7CR9+baqCig6jQRoU1V4WLxBhjtFmT4C
 K/XgxPqieH/61/atXZ3WqgiOWSL+R501hUNGmVHZmyGgGXznQHrvgN8kbbVCiq3fPctP68
 Z39LbRjd+blKo4IqCvE5GAptdBlLTqE20wTBO1D08qAFJQWQPdsK+Y7wN1+6QA==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Fri, 11 Sep 2026 18:35:04 +0200
Subject: [PATCH v3 1/7] binman: add nxp_imxcst base etype for i.MX CST signing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-imx93-secureboot-v3-1-542a99793af0@bootlin.com>
References: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
In-Reply-To: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
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
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4959;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=kAUr5fYXN/6NRqAj3EpxrY/RE5CMTIm6sHATadyaies=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqpC3o2nE9Sf4TqgF6Smn4ifIaWClYEn6yzbj+K
 e10DAS8SN2JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCaqQt6AAKCRArAF6gG1qP
 A7hJEAC7STIrHWr8undeYVklq0Vd0J+sBuOzBCaeXdy638AEhCg79hfpbVte/fkpKEu9AkPnJoO
 wZf1fiIYYEnkf277/n5SvVQa7SKFd9cMB+2pJIiL0jpDH3YYTeXn3PoGahpkoJ9tqwFqZOnSNzH
 24vkn40SGQxXUFNVLgMx/P6+VClsp6Q+NpBdCsBv2yOpR8WH39o0+RHUUvDZgIiEsu5W0++/8+y
 vWQpdHuyp2O6+CDpChUdrU9NQrZlMfhrCqBS49CNQjqhTV1eA3rK0c8aL37Ms2qs2glgO4C5WOR
 V1mCfEEz+i/Es5GWfJc2K6c5CBwo4qLKmlKjwTHNwT3oGq9a72tU3NF8hi17pbAnSsCR9Cvp7fY
 k7Ho+DItJG9HaF6GMj/sePA/oc6zCeqh798BcnlnZvySP2hAmNY9oNU7heoQY0piS8emRDUEXs7
 Y56ntHdzMTrFzvJ3MG83p03oI/xmcdWmAVAnp+AEIs5Hyje1vYjAB7ExWxtK69hRCnLxy3i0Ipo
 lJleQKXuzHzocZeeMvY8aWVNR6zXDdkOiakPCqedcafVdYmy0nV/usCFnMo/p85m+3+NJBhMC3F
 Oc62saTW1tkiz22NtBnVC4xzzPzD1zj9aFxR+2G9PO6ofxZ3Pht7S0YjFf6srxjtr85nbKQGae4
 lLiOW+wObZnkYHQ==
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

