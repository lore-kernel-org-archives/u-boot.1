Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2367BCA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E15FF60B51;
	Wed, 30 Sep 2026 13:43:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fvH9VSJwlUKl; Wed, 30 Sep 2026 13:43:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 186D760B1B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790775797;
	b=lGZf4VMsrQg/7GxS9GQil3K/kbzfAoW6gn1B7ObQOEnxkECYC6Utx5ipiAV1Bi5u58HN
	 r0CIyuThIzUJ7zK7sFsotsPNrbhKCTC2yhvEM4JlyIrD3FPXjmH6pTgCkFFcwpfS7wByf
	 3ppqVGonzNUgcrrs1qpTz7gqpKFZvzp4tlNe6WlZc7KM55c2CNieoeOWgqV+nXzMImdeS
	 tVBdGEDibxI6GJseUQeY9qi+l20r0O/kc0gF2rjYvedLhp74ArLGqzwcAq2f3Smi8bIuB
	 dgWyqvmxp4oeN3Kf8E35QVtFLMIMVYuhjif1FS8vEhgGXuGOv4HAcxTyJkSo/vxW0Pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790775797;
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
	b=m1jIuw8IxQB4uCfM5KIX3MOWB8yVs+P6ptq4jUnjuXiUDYabThaVLpovsmeMVByhhZ1t
	 Ya1eVcECRcRnlZHzgbvLFx7D1H+v4rcsN+YgnJWT50l3GJS5fO0NGjOfeRuPcHQU9WhHy
	 RTs/qdjlwJqk15fq2mgsGQ+9laG0eBvCBR6N0YzisVh1grSkKIcW4axNjByowsE42jUZi
	 ydOtPdQ+W5en9xjTrrGCN1qTefW2a3HPV8EfGIf3Qc8N2cXUR3UWQT7tJXrYTL37b8ASf
	 QUwFbkyNu3BfDSwQ1eZIsVcjxuf3GQFe/SL0TqhIzJh6svIozKGCeWXJjVWsO/v6e/A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790775797;
	bh=6+OKls220ByxJJf2DCl1+XbU7IFeGj6EX9+ZZcptRmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ahCJyqwj2lCnEBv6LMrQlhrQBtXmfjNnIOfCV2iMi+GXPFMl655wTki1SEGEoWKNq
	 KbsL5xjVTmgxsxF7qZiDNd9htNMR5Ou3a+EfHUgqYkf3dqq+CnJhzE6sfoBODx/Z1n
	 Fp6zGb6IV8nmg2BMLklvO2efmFQtVntOb5aybs0Busg9/IYLP8Mk01PS2dNZOQPgG2
	 QktuKODUEECqZdBRn3U+ysQgyPc5X3hpdOBdm59SDeDXCtSQq+fuNZ4E6HlU6V9VgV
	 cFTfFDpM3c/8pmPFthuceU/Z/V3ESoT6W8me8XDHqRwjhYCYjCIOQRIFTVwpEdOVke
	 GkqQNE0wXeVRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 186D760B1B;
	Wed, 30 Sep 2026 13:43:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62AE832A
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 605848103B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rDWDCgVYVkQ for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 13:43:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5EB6F80E00
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790775794;
 b=lC27ZIRRVCBL0mg+3s7Ozh4fvcFIVnSwV6h1y8BpyUq+idMmD6VogC5msGgNbn4PimOt
 mNhpLbnmQVuJnshgxFHNMwqAKMrNXQf4idVmCzqqyQWo4p9mnY8jfanehfKDC99iX8WT4
 n0IOKMQXTIq1kuNzYj8JKYMTafPvJPbjyvnNa14UIt4Qz66KwllvWU2oHgzDWwl4c55lo
 RCnL9pAV/kuKWeOI7qAIj6pvXmk6/DoWHl6ub44UaxzWqOLJninxeFAT81krew0kDj2st
 /kINqfrkMWVjCmL0XzAttlN71vLVLkeGw6iOg5jUFxkmeFrtojCPwBSRV+XzIL7lI6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790775794;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=6+OKls220ByxJJf2DCl1+XbU7IFeGj6EX9+ZZcptRmw=;
 b=SiG9aGQcMMzD4cEoxKXZalWjieZAw9nh46/twQPbgJaxytU2FmMIyDBU0ZZdGqNtSvIM
 ufaJCttorlYwzkEBVUejJNrY/dunQX8YoUnzedk2IMLZCrUhf930R/fmx8H4mg0xrsSsg
 eAX7xw7au03nrADd/s1S4lLuNqP2crlukpfutiUiiG1a5LlJaaejO3aPCc3nh42o8BOf0
 yla63fA0d2KMU23exxvlmKyrFvmLOMdmRvjdSukxbFgYbgp1o/7s7u6Cm5TV5eg+xzLNI
 /h+Lq9sRC2e8VIHnTU6d/2ch2zcfuHyCbp6B1RnpgwFffDwD7/vdVMmmOncqleR9Zng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=Hofjtur0; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Hofjtur0
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EB6F80E00
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:14 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 82FD84E410D5;
 Wed, 30 Sep 2026 13:43:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5074060749;
 Wed, 30 Sep 2026 13:43:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 526E61032828E; 
 Wed, 30 Sep 2026 15:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790775790; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6+OKls220ByxJJf2DCl1+XbU7IFeGj6EX9+ZZcptRmw=;
 b=Hofjtur0cknmmEa69uH23aLmhZJBVSb03r26LEknwd20PS7VpG53mRpA5CURS1pWsAo98x
 dnJUYlrH7i7PNvYBCiFr9r69Jv3F1Q0C74UPmMQtq/VcW9gAiLCs47kyOqxwDZu7ANN2tv
 U+r0AuGps5DiOM+U7Yc+va+SSNg+EQN3qG0qMNIjhwx+FGYahVSkzQWUQQSyQ23S3lkp/a
 80GtZF/zTXB0GzfZ2M1F/WZ4BKYypGI0+sSTpo9hfHUacZe3LvWiK42j0mebgefIE0ukrk
 OJtUSILMI+7mjaN5KEtRuVG+hMd/Z2s4YLZAeJw4vg0dAcD+4kv3iumopfgLHA==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 30 Sep 2026 15:42:35 +0200
Subject: [PATCH v4 2/9] binman: nxp_imx8mcst: use the nxp_imxcst base etype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-imx93-secureboot-v4-2-f968a1b14dc5@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4904;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=eN/SW6E9mrUvoquhTJgvlkfcNNTiRKfTqHwuLyzKpuU=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvRHZUTxGHwxZVMyoagVQvmUSHcZWVAg2Ys0yt
 DKG+f47M3WJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar0R2QAKCRArAF6gG1qP
 A1P/EACijAhQp2R7i2lr/l4HBbIrUZJB24FjdnIB0xGLaUnJnFzmnYWHLtYPYIiRX6mxKXYDki0
 fkDAPDTFgfrso0ewIEmcKQBhBmkcctGauaLuM1QXRgginaJl0tTQtikWmHco3D+CiimbR/0a8xv
 hnM0pN7D6/wxzDEL4x4Ez8EkP9nZWDwXsHUM5YkzLWlSUuS4P4t+ntTgF73SXRqZqznvdYaq3QD
 P7hIVP/Jj47ciz2mNYwe0r+BkDfN4OKZLDyxP+Hud5ESQ0M1xzhAjvCObZZiPrWGRDkpsZEnuQX
 97V/Rz6O3wT3lDzx13+tW4VR6Bv26eIV97JCOjauBBI1ECur49jQisINZ2dBCOreqI2rRWjiJY4
 iUgjQsMR+9g9Vm3Fhe/PNHm8DZRn+1AXUeN42oZN2w0Ccv5pndBsfiJ9tScsbnBrTGkKfa4/Jwk
 +zisFU3MtghsPLINzuE6YkKi1FDWhgsv+46TB4+DEiToWad/XHZD+mL7eIZNKtNShnys6XsBE48
 kdH8fdK/A9eh0v25ccpvsJdSEVPrJX32d1283NWTBfb6pECJ/RNimjOoSmjiyz4Xf/JLV4Wml+E
 MFRsoEI1ncAYYhzLt0DbdwLnuO1W/hHH277U0B53qWQ68CSh/386vLujt8xtbK41TaUdkLeipcT
 jC71QvWiKGdcIig==
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

