Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD61CA5FD6
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28D6F40C91;
	Thu,  1 Oct 2026 16:26:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ME4z3pLJEl98; Thu,  1 Oct 2026 16:26:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C0A5540B53
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790872014;
	b=beM8r7AqZVEV1Fe0tdUK3IntV4B2WfwLJZmDDw381JctlPc3A6AbS6RfnExSNoNBWpfj
	 YzOoKgNoVyifj46AMUeVcOCi9u5xEPLN82OM8BUStx5MglYI2WlRoibuN/Tx7gLw1+MQ/
	 0nUndU+8tu8Iocudn1sbG/edjXeZuV0TRxZ4MuVNvhobHpvebm3pf6UlY+ZqVsvjcBni5
	 5IccxIiGfuUrs5eFQrO4QE/C9CDToqexSPL4jL3lonC4SnVOXQwrdjtT+vmdiEWT9r3IJ
	 sh0UU8TmWWbEL6rpPuYQF5BHvn1OdHL2lWd4BIxDXcguwh7r9wVlfmec9RIRJLnaaHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790872014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9yyUFLH8q8L+7G3U7VOLoNuSPFlQE3UnsXrG+3nkIVE=;
	b=DbD9bFeUU+f0EBdHUVT4n5QA9gQRL7rUmOcgVI1ax5YOFuRq0D69EkOU6VYNJA//Ob7a
	 QZ/n9MefYWIsNeTldTOqVkgVlfYRyps4EkBShQMIKPHh1BA6zK7E6QyAK9Wp3+00c05Qq
	 4++1euEld6ouY6orAghB0OW+nV+cuEOe1K5XKpacvOO35d8/mNLoyfeX9tBDL0hF17TSQ
	 +dH3nv61CPrOiMAtUI7i+0jM8uz6OKYWnp4zKGFHWdaBpN7/JyWUlF1QWCNLyCxHWVvlk
	 QrruKjR3Bh/5LVYuQXqFk0VhQKbXhOZACN9A+VFuxdkQtYJ0jjpcNcM0UU+6QNopJIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790872014;
	bh=9yyUFLH8q8L+7G3U7VOLoNuSPFlQE3UnsXrG+3nkIVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YsjJqG82QXyZhHrJEEZBFNPYnSAIMAJAM+ZPvxSov4Cxbt+CvkO1s7eDQiABdyi5g
	 v3d2D2+W5qZMfD7mxfF2j4qkfOV1FGvGtEy1WdkEyTVsdg6nNBXdR997iEegQr1P4L
	 gv3Iv2OtcSzuRLrRKoPpRiR5bXv6XDGnIx1uURtel1RIhcNPHa8NKPxmsAUapZnw7N
	 Ks1EcWfARH368c58ek+gOKmP5X2NyhDC0LCogm3bLBTDexuXxBCmNeNkMugkwLxGX7
	 H7QZMey2OuiwM60ylvL2HdprwhK9eJOieTxf7jsNFC9/3Pw8W6tvk7GU6LkGNRoUqR
	 xGyuataeu2RbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0A5540B53;
	Thu,  1 Oct 2026 16:26:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D13D3D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 198E581222
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVOnzdvHNJ3n for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:26:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 49B6E811D1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790872011;
 b=HDqTLRse1vtzlpBXfYHSnRroMoUayosKujQXoqVxErFpM37JM4sHqZw/53YqA1wqj7vE
 M+rAqNQdFRPMq75no3RMuRkzHPi2ZXO8SoaHoPQtDyZKXLouThmbfY9AvZL1LHlBzDft1
 4BiuTVVsRBGg817aqzUB/SItIFPiyN5TiwfWH5DAcNOppWSY7OQeyMNkbYXprAMm5i23/
 mjq9+QLikJHEToDiPTU/dGhwQ0nRAZgq7WBRrBub2ivZKHEO6aV0VmX/wvRZQ+2iEbTGD
 a8A37k19fe5Rx4PPoPEXXBwP0goLZgrdRDRPIMn7XQrZbvScBevyzXscmu1PRAe0THA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790872011;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=9yyUFLH8q8L+7G3U7VOLoNuSPFlQE3UnsXrG+3nkIVE=;
 b=Wj4jaUitt8zXso07Lsk15HaZ6Qm00TtxRfnq4G7+F02GzIRcWF9yX0rysw1FFcgYA1fz
 5XxbHTIg95hz9ZMJOvvZVKa6YT7Ego7X5BKzVBjqilzGhHtqXaI/bBlXxzn6Fx/okntLb
 4B1en7hLcy5FPCkMfadVPY3M1E8gC91UNhX6pwViN5jNrNUrbv3Z8nm7enAs+1LyreYbF
 pEWa6DERPFSfNKVx7osTsWkN3MgTjP1+lfb/tUtEiRALJap8zCZxKAK9TnvH2mOBToxOH
 HcymhTIC5XoqJDGP3CTqRJzndI7if1uiZ2m5lbGKnWU+TCWqOhPxlkRD1LnMsYx7Czg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=aMvZl3Id; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=aMvZl3Id
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49B6E811D1
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:26:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5105A1A18B7;
 Thu,  1 Oct 2026 16:26:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 247E260343;
 Thu,  1 Oct 2026 16:26:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B768510328312; 
 Thu,  1 Oct 2026 18:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790872006; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9yyUFLH8q8L+7G3U7VOLoNuSPFlQE3UnsXrG+3nkIVE=;
 b=aMvZl3Id3usom/RysF0JJwTQ0CpelYB8T/ghlbpfQT6pD12YwlwZuAnpYslrfJi3aIn1Ws
 P0UyCx07Mw3NYvt0KGA+LOcLS62nqCRYxfmpNIVNcVWl8FMvwd4vwVK+VYOnH3eC1/zyBR
 YT4QElL+61l8jt/dpUgtQt98pT6h0kuaHPngWUbo9OgpsX2PaXrEN1R8K+m6iDpYtypee2
 E6lBEFeVRyFLA0W85Cnj2tnNqpWlgXnMZhwWN37aQHbyVkL/07BaaSm6MyFwFNdY1fYS8W
 7Rribi97wlkMgvnYRb3K7OJZ24bzG0/i1NKOY7Y027FbzB2Igd9clAhUAIFWsA==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 01 Oct 2026 18:26:18 +0200
Subject: [PATCH v5 1/9] binman: add nxp_imxcst base etype for i.MX CST signing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-imx93-secureboot-v5-1-d97dea41bd1f@bootlin.com>
References: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
In-Reply-To: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5024;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=NlOca9sbHHoHy7VR+jOJKppFWkzTo8KZIIB5dHXlk/c=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvom3bL2EhDkGMWdqyXsddEZconwLEKDpO2WTZ
 BNW8g19dv6JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar6JtwAKCRArAF6gG1qP
 A5scD/0VXBvH+vCps+m2TaUoaAlUV7qKChqIOsP+RamInLUrtdB4qyI0Pl1sLIgKpgIUCht29Hq
 44faSYxEiAIIwiBNXmtvwygxg3eY1r5lEmgBxpFB/UNR+3gzjYbo6tpuZTP7XnYezOdlXI+JVFY
 CT9AHss8tl569CtgIP39sm94chCJ69WXO9FI9BQTz8lnRYA1JcY7k4cGRIFu34+x51wGMori/Cw
 ln/3VlAQkVaz/a2lg7aHs2Okz9OjLsnYU7HoxniOvAUYBGJSdHTvVg/IIEFu2KeTB2q6298bjyi
 Wp84KO1tQUmn+/3TggeMA4OVUoezchRveIEuO3kqz/efvrYWyzunuZ9sgw9lMmjFpEg+962fZiL
 Jy+06A8G7Af9Pim39Qs7ofvE+FwqQfI6BQ5l7t6yncJ2IYjX3Q1iX2MW1QphZxjppuXPbOIs9Yj
 nVLikqn7LRziMigJvlPPiE116hWX8XzFbY+NUS0U1hoEId7MRXsphCv9BwDeukVpFDnr2SnLDVc
 g0IRmt33rvshbt36u0w8f8/VYc85pHQvcXj/d2BzUKPFTr6yRdjPB3mHON1/wlp+HelOjOLANIQ
 TgtUPIyTOZe6vCbZWYx4Wc8m6gEPdqsriSDS90tHzndgIWbevdrZJE2IDExT9bTfSUEtuY1FTPx
 8JKPop4kBaPuIvw==
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

Reviewed-by: Simon Glass <sjg@chromium.org>
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

