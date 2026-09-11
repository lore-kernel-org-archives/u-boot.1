Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A6DC88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA1FF605F9;
	Fri, 11 Sep 2026 16:36:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8bcmexSrOc4; Fri, 11 Sep 2026 16:36:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4E7DF60621
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789144582;
	b=at6+a0pAq4haI7UY+vL3+U+DuXHzf8UZdwMCP6+gvnIKz07VKsQOWx68NCZzaO5lLWWj
	 yhJCxmHkXd1OpYwvyNakdZmR47E96YgNsthGJCXSVuU8xm0YGjg655GBWMtZbOf6eN2Nm
	 m3AeGAhaxNE4U9Spq+Zo3RgkpPrs2SAB8ZRZxiBWxo0DOKdXT29oI1el7nmE93hCfN+66
	 UbxleMFkBGYEyoFkhgmTHDSbw7XqRbGQnwqsOEYzEmzkm+j+PibAbZLzC32DjW4IQHnyS
	 wYydaUvDwmekRMSv4xwqwCgQQTcxXzh+cT+wINileVJ8d2uasQUXolyqQNocuDmkpxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789144582;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qmCJj6w1WXHLj2t5lHMeqrOtc7bdJ05xCIbIjbWAAlU=;
	b=PulFBSEgP6hrA3KnCpv0iJs2O2AXFX4Bw8OwS9evD56yfxAqADwZtsWmV9GiN0X8JzE2
	 gpFlG+59R8PKt4v6KzaV/ICxj5EaP3/dzbB10g40GaWcrCtlof0dAQGjcu7621mNFw7Ep
	 WAGpCIU/MVOLFKS873h3pSdzyNgYEWDev0WPybFDjQlQXElYPhb9i+nt2pN2ITUXRGcR4
	 1CmVZVNdtwnosrt2WWZa8HrAzRzpfKKAOXJqhsu/PRbJCMd/xhEeYusix1fvKkJgIEtJC
	 pCGh5G7b57Xp3khbNEQJxamOe7vhYkEIUl/RgY1fyOicyAZtFmMjLv6NIDGJqwwFbrw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789144582;
	bh=qmCJj6w1WXHLj2t5lHMeqrOtc7bdJ05xCIbIjbWAAlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QqTaBeuBx5X6vb33SC4fjsyS3I7mnGaG4jViTmkMteF/aia2COQAVjFu4Z0c9WHLz
	 c6xE12isMNlDapQl/Xdzg60hXkIG54Y+kY7038bfG7f8m+fsuEw+OiFFCl1JiZDVhf
	 u4ggGWEvOE6sxSynuYgynLk1+m0rXeTtAPElHOvevQHJ/uJUlhURYv+ZxyLS1ewfVu
	 cMuwr5MSjthXBeaMBG4NOmxUgIIoL9cCIBgjJGREulOdRpaSTGdFLHFCVtaEQ+ySXD
	 6IEpfo48UjHtp1RimgbbyxPPtbfAfwS3HLjABKLhE5ZjyNqpBEj9IwapaTIXvyjLf6
	 LeHOT99iyy+4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E7DF60621;
	Fri, 11 Sep 2026 16:36:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D1FD701
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F32F180EF2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S59z0OgL35Zj for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 58CB080EA8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789144579;
 b=WNgCDJCbSO9wqvVAAiyWeW0vdi2qksmHYh6mHeTZMesVlGaddDG+3EQGWZRAUbgcauTk
 gbVQJY5Mu38Vo2RYY5mUWbcpVQkXw6/h2mkEP9Y6ppponMZsBPewqojPWfKPvOEznopYR
 ypdpdKOTko/n2lif9nx22/wKhIoxOXI1y78SM+M+DXVdF196RqG8W2snlfgOpKfvsIFnw
 isjMt00N7oNl+TfvQAmnNdXiOdcRDb2v6imOIejCHn/cRqev2y9MLjPH/TMpTGbinLwdW
 ncMHc7aQIPjJff1kjR5gC8G3hLkJG8l2ljUJsXz1scX3yPLCwzxousZMYqu2BkjmWwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789144579;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=qmCJj6w1WXHLj2t5lHMeqrOtc7bdJ05xCIbIjbWAAlU=;
 b=abGa85nGUqvL0r1MyIp4InHhtyjTlMzIqNb94YypJi+nez2IenNOPWSejDMa3uNGUBpK
 l7JAAehDj/7yvttwAs3nJP0aPZeGeVMcy9/yLaKk6r/3E8kfAAp2W6e9oIrd5U3Eswe8l
 b+CvmcukGEA2Jc3GxL1wSwF13y5lsspjmThMkPko+v3uDAAj9qhuxOUA2KrcoEdsY6IdB
 5jE3WkmBZ9i7Bez7a71IY8p1QCbfPwOvN3DYs282Sh7t1RG5xjr1nslsliYYu29LPq20R
 ERb2vhvy6OV7cYj/VMqHBVW9r+i0Rid5r+L/Yo8Zk5caCXu3COqtSGCOyEkQwbOPHEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=QDKTDce0; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=QDKTDce0
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58CB080EA8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E3F6C1A00D5;
 Fri, 11 Sep 2026 16:36:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B130D601A3;
 Fri, 11 Sep 2026 16:36:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 66B2C11C7A23F; 
 Fri, 11 Sep 2026 18:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789144571; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qmCJj6w1WXHLj2t5lHMeqrOtc7bdJ05xCIbIjbWAAlU=;
 b=QDKTDce0X5VuN3tmio32J51XlVVX+MO1qFidYgYwgoDI8WdXGf8o041guw/3/fIBKZkDr0
 5/5dSbJllSEovvZTDM4xNr4oFbXkG/Z5CUeDhqtw7Zeo2vY7gPYoQXtRYmNBqzU3atMjW+
 3H//g9S7wOm4yVQ+RCTv8cfeHyVcDCIEY0f4yfdNatAP07DvWQiYQdbw0dQIzWqjihGzMk
 7pf9nc/ltFFq3IdtVcfSeNSU31f4vAZQ8PWHYtG6uDdTtEbz37bCXwWuvJoelamZPgKocZ
 m1vT60facNu2ov75WJZljX77zEYBqF6sJ9mHOKz4pfHbw7xiawTNfJ8+3NuWAQ==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Fri, 11 Sep 2026 18:35:05 +0200
Subject: [PATCH v3 2/7] binman: nxp_imx8mcst: use the nxp_imxcst base etype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-imx93-secureboot-v3-2-542a99793af0@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4880;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=vdKdUi9fS5wXwZhuKIVF5S9BdFBwqgz9RMXFQVZMYiQ=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqpC3pX2VBiV4DeKb1OfFNx7u1izShZrX1UnGbv
 P63YAR3HT6JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCaqQt6QAKCRArAF6gG1qP
 A8XBEACZEw74KDBErhihulb7vpmlkhUoBzyXYggbVCRLOEQzSEd9RuX19FS5sEsZixwbIJAvthq
 zxMLJzgZ/80erjMzUG7bHO225AVEnUwytQiTsgg1rCPYuqrjiBbrrekPlNQmpcTjhkfPFEiAue8
 2D2y+M2hpA4lbxCMjUCGnmdoP38iImIc2fXqZk+TRCLobdJLgPFXMUJe2pkZqu7Jzi+Zf5lj9Dk
 82THGB+nEQdO/pOYn0J4G14Q4SEiSec0iZXCLPwqY3DWfrT4UuWo9F7g3mPvRa3k+e/hD/498ud
 nRZVHD7ikC0AIpcFtjVkAko3RdvVC9XxelfNQpnT15M3VzgYw2XnuXTyXvhxs6ezZLuhmEtsXeL
 5hqf0X5pyXo1a+bm5CFPyoCGP06Vd72SFS7w59xkXAhAId0/Rjf4PophivWgSl7ui10H5Wt5PIR
 nO1YImNe2ibsSE899YtZttJNHZicGwo3egbhYDGWucCCTcAchR6TPBakdy9/+EmQuPt8V5/5grq
 cSNHIIWO4z+NHARSJcoTvIkEfVz4eW6lw9Wg1rI8VD47smw8mFwcnxmGknwgE0GwyFUcjxJjhGE
 MLp2u7gmTqiBJ+S9aNAbarvkckK4W1FAqyapgiNSMihFAZ5npinPW+2OI/KbuAxU+ttu8nSg/5p
 haOJ1KISndBfQiA==
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

