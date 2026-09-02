Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B609C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54D7680F73;
	Wed,  2 Sep 2026 13:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ubeeeu74DMBI; Wed,  2 Sep 2026 13:41:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356519;
	bh=qmCJj6w1WXHLj2t5lHMeqrOtc7bdJ05xCIbIjbWAAlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R7S+W80yh4tdwiel5f/KedBWbSJYF6JtjDbAIyb8R/yWD2iLiNiRFYQoPswguUqcT
	 uJaMvw9YW/ZbZpSKeVHBuEXrj3O7GbS3op0mpezux69MCCkftyQU6GMJaRBBejdSqz
	 A62/hhTRhCLffng+6rvJ8Zfarp8GZ5qdROzMztAFrzquAmomNWSugHi/kbHjuHKacF
	 Mi2dqCsKln4DdpvuPtgQqnMDcHRep5Jbo04zIaCrTTrYhkxgVwjWR7ga3vqMFg8CTH
	 OuLJ8rQ1L0RjOkXCpPbg1y2/WrFqSUMuMDZ9GvoCn1gOw1tvj5qjwPJAZShxp2VDbU
	 4ONsto8SOp9tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80B8C80F36;
	Wed,  2 Sep 2026 13:41:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FA5A498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1D204006F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eC1zP_Y5jeee for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:41:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=ICvKbaGr
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B760D4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:41:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C46894E414CD;
 Wed,  2 Sep 2026 13:41:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 98B666053C;
 Wed,  2 Sep 2026 13:41:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD2F711C792AB; 
 Wed,  2 Sep 2026 15:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788356513; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qmCJj6w1WXHLj2t5lHMeqrOtc7bdJ05xCIbIjbWAAlU=;
 b=ICvKbaGr9ClLKRPMTdCsoKXNaYjF4NeU3FgU5UPM2gENH8gQ9vDQJdMFNLFA9jKX/pnF9A
 HVZcWZAQzO2+1mCL5TI/GZ5dUs5R7bK7dsLSXul/re/CA/HatgqpPwb5PDiBDvMFvuITI+
 2TKyQtaI15tR21JazTaWnR7yUCMBthSSp0D1G5iIvbL9uNXkAkQ1cJsu+oYmaUkysl/UzC
 yQM9Tz+tIbCrYajyQBH+Ihh0J11Z1kdlxk8NHP1rV2SjUebxnKN600yUO57RNhqs27yacw
 CwLKZLW5d7OoovQBUy2+Hw1WYpAe0jyvCqRT44GaG8SbbX/PXaf4nNMySsDUTw==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 02 Sep 2026 15:41:29 +0200
Subject: [PATCH v2 2/7] binman: nxp_imx8mcst: use the nxp_imxcst base etype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260902-imx93-secureboot-v2-2-5947b92a5072@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4880;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=vdKdUi9fS5wXwZhuKIVF5S9BdFBwqgz9RMXFQVZMYiQ=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqmCeU52CHwWEwFx2R1NhmvReNAdWwOntNKIt70
 BZiGp0s3DCJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCapgnlAAKCRArAF6gG1qP
 AxsNEACo6aUyA9lB/0xORjr3Mbw+k7OVPKFtM18Sj4flXCyP2JEPa0yaNVg1fO7MhERrnsbUNcS
 twsG3nHCf8FsLMWCC2Yo7dy9nl+iN0KtS7KHszK+/oDBg/HGo6NYPQie6pbbv6xbikFdGX5HJea
 nrLCwUPmWgmgn+l3sXnCb5iqf4FdFTAY7mxh5IlQf4TcNIKcOfLRhaN8UtuWruqRpee+IapBJx7
 zviYLbnK1yiPcgJ9EMtT5BHMKD/qN6izojbIhu6Gp7dUASQOK2XKDAQ/dTRP925WkQ1CMmADwIU
 8MvEjj4ISyhVU/BWwE6Eyv57yipPOdqXtnsYPiLzCRrPKp6czpY9AEa3Sd49XJJwQBYEuMa968j
 CR2GDiNP8DNsHPOIpzkR/UAdq6UEMltG/Lrg8Pim900b881n5jkyWZy1UcrbLV568DqvYPfrqcQ
 Dxuw5mNaHq6k79K+JHQa1KXF7cEycxOQvblso7+hKY2BIvDKcDlBL1jvz1QinqoBjydBMco00ha
 g+2xUkxhWYD7VVZJvxzi3qrIk7hgbIRNmC4mVGdAo/Q50OkajeaUCImngNeRuezPemD+rL9q6na
 entqq5+ifosJl9nwszbGpeaFvNsqurpaD++k3wNWaptB134NtFHvj8ikpXIJCI8usuCXwvVTNAw
 fEO2COCLkCXcNJA==
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

Use the freshly introduced new nxp_imxcst base etype and remove
dupplicated code.
This should not have any functional impact.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 tools/binman/etype/nxp_imx8mcst.py | 60 +++++++-------------------------------
 1 file changed, 10 insertions(+), 50 deletions(-)

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index 29a7451678d..3f81b9f83c6 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -7,16 +7,10 @@
 # input configuration file and input data to be signed.
 #
 
-import configparser
 import os
 import struct
 
-from collections import OrderedDict
-
-from binman.entry import Entry
-from binman.etype.mkimage import Entry_mkimage
-from binman.etype.section import Entry_section
-from binman import elf
+from binman.etype.nxp_imxcst import Entry_nxp_imxcst
 from dtoc import fdt_util
 from u_boot_pylib import tools
 
@@ -61,7 +55,8 @@ CSF_CONFIG_TEMPLATE = f'''
   Blocks = 0x1234 0x78 0xabcd "data.bin"
 '''
 
-class Entry_nxp_imx8mcst(Entry_mkimage):
+
+class Entry_nxp_imx8mcst(Entry_nxp_imxcst):
     """NXP i.MX8M CST .cfg file generator and cst invoker
 
     Properties / Entry arguments:
@@ -82,9 +77,6 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
     def ReadNode(self):
         super().ReadNode()
         self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
-        self.srk_table = os.getenv(
-            'SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table',
-                                            'SRK_1_2_3_4_table.bin'))
         self.fast_auth = fdt_util.GetBool(self._node, 'nxp,fast-auth')
         if not self.fast_auth:
             self.csf_crt = os.getenv(
@@ -158,17 +150,11 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
             return data
 
         # Write out customized data to be signed
-        output_dname = tools.get_output_filename(f'nxp.cst-input-data.{uniq}')
-        tools.write_file(output_dname, data)
+        output_dname = self.write_input_data(data, uniq)
 
         # Generate CST configuration file used to sign payload
-        cfg_fname = tools.get_output_filename(f'nxp.csf-config-txt.{uniq}')
-        config = configparser.ConfigParser()
-        # Do not make key names lowercase
-        config.optionxform = str
-        # Load configuration template and modify keys of interest
-        config.read_string(CSF_CONFIG_TEMPLATE)
-        config['Install SRK']['File']  = f'"{self.srk_table}"'
+        config = self.get_config(CSF_CONFIG_TEMPLATE)
+        config['Install SRK']['File'] = f'"{self.srk_table}"'
         if not self.fast_auth:
             config.remove_section('Install NOCAK')
             config['Install CSFK']['File'] = f'"{self.csf_crt}"'
@@ -184,8 +170,7 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
 
         if not self.unlock:
             config.remove_section('Unlock')
-        with open(cfg_fname, 'w') as cfgf:
-            config.write(cfgf)
+        cfg_fname = self.write_config(config, uniq)
 
         # SSL is the default backend, PKCS11 backend is optional
         if self.backend == "pkcs11":
@@ -193,34 +178,9 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         else:
             cst_backend = "ssl"
 
-        output_fname = tools.get_output_filename(f'nxp.csf-output-blob.{uniq}')
-        args = ['-i', cfg_fname, '-o', output_fname, '-b', cst_backend]
-        if self.cst.run_cmd(*args) is not None:
-            outdata = tools.read_file(output_fname)
+        outdata = self.run_cst(cfg_fname, uniq, cst_backend)
+        if outdata is not None:
             # fixme: 0x2000 should be CONFIG_CSF_SIZE
             outdata += tools.get_bytes(0, 0x2000 - 0x20 - len(outdata))
             return data + outdata
-        else:
-            # Bintool is missing; just use the input data as the output
-            self.record_missing_bintool(self.cst)
-            return data
-
-    def SetImagePos(self, image_pos):
-        # Customized SoC specific SetImagePos which skips the mkimage etype
-        # implementation and removes the 0x48 offset introduced there. That
-        # offset is only used for uImage/fitImage, which is not the case in
-        # here.
-        upto = 0x00
-        for entry in super().GetEntries().values():
-            entry.SetOffsetSize(upto, None)
-
-            # Give up if any entries lack a size
-            if entry.size is None:
-                return
-            upto += entry.size
-
-        Entry_section.SetImagePos(self, image_pos)
-
-    def AddBintools(self, btools):
-        super().AddBintools(btools)
-        self.cst = self.AddBintool(btools, 'cst')
+        return data

-- 
2.55.0

