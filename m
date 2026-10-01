Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAA5CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3A1460B26;
	Thu,  1 Oct 2026 16:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vW2Krv4SN-P; Thu,  1 Oct 2026 16:26:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 34DA160873
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790872018;
	b=br9SkDiXhqe8sUyAZ1y58HEBunVmDlWXkxW1zkvuv9mYpu9pbILKRJ1tHGDen8kUQ0yP
	 MXB44A48ZhSziS+30pAFWS6UlloCSkhLHygxYtR6LK2RfssSP4q75zMQbMaQZpnDgK+Dm
	 WQgA2phhT2NGI/QhuDIpokI+VEm/tMFIFH7QplWYotMjU63uM0d4GgtwKQPnA5Co3LNDb
	 F5WssxHHCY7rEbXkpDMTeRL7u4QoWf5Cw/r1LVKsIu1RfoGo5pFeAVP7LPdLimgvexf4L
	 BiABXmm3v29V/PD1CVp1SVpqtdo2pgJWQno8JE7WEyneJyFraI8ToyotQ+QBioBP/wQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790872018;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6+OKls220ByxJJf2DCl1+XbU7IFeGj6EX9+ZZcptRmw=;
	b=XzkzvGaJ7TuRm8faLFmApEP3dJp+FJRd09WXV3TmcPv9wPgrCXW+QUeDIrc3kXgL3xFp
	 1oQJ4r36uqcVacqM7asYGTytmF3BN4fvycerLuoVj96T32FtiwIv6ZATrt4BxOS3NpvLn
	 eBtUNVJJO/X+qwyeJUR/P6XeEkm1BuiwkXaF9JzocxiQSb6316kvAXv6RpDuY0SvXndG3
	 GU9omEAH/Qcn0mfxHG4MfCsCmYOoiqlE02SP4WHYwLVZWAHg+oA8Y4BMu/1g2DWtJmUy4
	 LjUF89YDkPDULDhdPcAsP1xv0bHHlfoObY53VCypmzw8fkqfww7ivc1df4jHNEZcpMA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790872018;
	bh=6+OKls220ByxJJf2DCl1+XbU7IFeGj6EX9+ZZcptRmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXUZTlQ6wZ24Pa/3BsbLBM2rnZ6ZTSNdZwjrF8qk+OJvcs3sJSP4QcDi64M92cNwg
	 yMz8vc9hY9xA+QiYnWa9BBMyCdLkn8eBtaIPlbZ+bf/OW/5xW/vUQfZkB8s7Jupv5o
	 GaausT8tczVNQ+1j9Awu3Aa2wQFdmf54kQhEG+tj6yzrsHb8TPu35VP65mQyOWkz54
	 NQ7Zlqq6aXWKoPBtAZSJ+pX+f1sbKKUtVwjsBPZ7MbQCHXKqsA/S4PcdVRMHo/HoRo
	 YAufkiwJqHRRQtMfQqFJ+fV+VgRnSosePT3oyp4/+hb2ppbWOtRtbdYpvQFMMD4Wov
	 iGq3akXvnIzmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34DA160873;
	Thu,  1 Oct 2026 16:26:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E4A3282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 345A740185
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:26:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vHmucF5H8NAO for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:26:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1144040098
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790872016;
 b=W2stfS4W2u5u1nd1zwUGsjzbsvkjj8R+XnQY0edKUsyXawj+H2QI3vqhm5tc3s6G2gu8
 GP3HTRq05rGH2oYyvtb81xuN8XGy6R05bBmkZmjnX68osVGPodPv2zIQgoVfXEsX2fKpm
 nFOWUrTrjC61Cjekxjgd3l1I3AP40UhxdBj1e1o5gEJ3Lt9Po+I2QfmyLIDEYpQDG0eAc
 CgCvaeVKsizmtxtVCFPWBgtqbnN/3qwLJ9nVZX8b97BI2CclMj8I/PhWSeC78Z8cXB7vD
 oqdTgB6AnsuNez89/5IJPIXvj2nUEYvE3lZOFQcf4MLZXoqsvmsv480WvFsjqa4fLRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790872016;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=6+OKls220ByxJJf2DCl1+XbU7IFeGj6EX9+ZZcptRmw=;
 b=pIMgDUHXdeYUSsw508H2GlUR4fHdhDfFfyFVu+P8fBebyH5jTnaPZgOt+bWiq+OKC4pf
 5nHZTA3C/ZuCd6G99c+4kQR641SLMU4CPdvccmkwc95kc/Hp5ZHSdCvZ/Wpgi38sc820V
 BAsiyh4gElNuNePSONccJV/SI6vsb+juash/MT3wiE6A8KPDA/EZIU8777XrXwohwSe3A
 XdxOoBefBLeAHNIfw2gNbg1HpznmjBucZfiNoIJXg5b+rEMzxsfmbWgEkpoNkKVVpj55G
 uhpEVWx7GBMVCXTUqupExNkt1MzsnSN0V65PiFMK9z762MwBpkGsDyYE9BKUGck0Veg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=hCh6nlH1; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=hCh6nlH1
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1144040098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:26:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 916CA1A18BA;
 Thu,  1 Oct 2026 16:26:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4E72860343;
 Thu,  1 Oct 2026 16:26:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5083510328318; 
 Thu,  1 Oct 2026 18:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790872011; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6+OKls220ByxJJf2DCl1+XbU7IFeGj6EX9+ZZcptRmw=;
 b=hCh6nlH181g3/T43FNd5feNJXmTSeAc5Hp8aTzHKUBG9j2ZAe9Ixc6LtvBmGf9RCAFqZhJ
 x7DKawXM6T4iYR1GNJc4HrpEBat6bOc8f8PnadNDmga9rbEoOYkkOjkwgcMdEvQZ3Y4ifW
 iCB5Wnh1M37ybxMFr3juldGaMRig1dXTSn/od+ULbiH7A5A8a7Hn1x3714n0G+D0KEfGF6
 JtrDbx3d0+6N62qmI/Mc3+wzXcxMVtBidmnV7ULPMxlEKsBH9pT84QArkIjLuQvXmp+mRZ
 LFv49Z6nS6oEkWP0M60uPWT/hzdojNg2xVEAMLuE8UrVUjmh3icq8wfpaCF3Ug==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 01 Oct 2026 18:26:19 +0200
Subject: [PATCH v5 2/9] binman: nxp_imx8mcst: use the nxp_imxcst base etype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-imx93-secureboot-v5-2-d97dea41bd1f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4904;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=eN/SW6E9mrUvoquhTJgvlkfcNNTiRKfTqHwuLyzKpuU=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvom3BaUfrvHyaACbo/C+jgQF4LwgPuHHdWYX3
 S7uqIG0sBOJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar6JtwAKCRArAF6gG1qP
 A+p4D/0ak02Mgj/Y/aMcb2QWz23vrnT+uVnA0AxeRcnIEnHQVnam1LLVt3e7K6akW6mI1C04iGV
 vsopRWIqziuLd0/MyU2lkr0zkQSStZQZFPfVwg5UNya2BwqbhRiivG7xfwICyMOKQx8NdnCtYEk
 cApYrbzs6s00D0E4ri98Qf127GbWp9NYFUzJ1FGD0D5qMu0dkPIFX4iW93y8UXgf/TgSPIE56Yn
 8WFg5F52B82277cL9VxiTnGx7n+VKhnhOUkodGK+r0vbFNu+BWBc6hEjm22gvuWuKJG9vSYIkez
 PJR7NFqqyBq2b/37lrNooFY02Uo4XQJOHQEv0uTjq36fRiW0/2Xq39HCITs8zTrQEB/8qRfndl0
 AaY0pwQIESrjGWN6r2cXo6hh/CFhFD4O4MSwxkMgC30Pnyx0saZBgplbLZB2Dsfb1VNvQGOw3Sp
 2zs44K4kGEqLeil9GfiJxigPlFjDhiN1N6pYO+1YbFLqvSsD6uRpBtHj/8dZwKsPMn8wyQdPOGe
 bEX8xVBQc/QuUDv7qFf5duZTX/TSEU7zKvHySFftz+o9n51IOLJLraN3Ny/ymB6/LK2mKKGz9hF
 XferDENjJYEmmOkKRHuFN+17oVuZFAFog/MAgD45cRQwxJ2MndDdxdW78xeVuNHkHIQ1K0acjLL
 KD03cINiAwxgl2g==
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

Use the new nxp_imxcst base etype and remove duplicated code.
This should not have any functional impact.

Reviewed-by: Simon Glass <sjg@chromium.org>
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

