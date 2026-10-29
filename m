Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A343606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I+1DgmGQ;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=l0fVh0hq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D475A60710;
	Thu, 29 Oct 2026 17:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 14LS8uln0ZtO; Thu, 29 Oct 2026 17:36:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 057A160A6F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295365;
	b=oXfczUU3WK6M8Ml9tJJ1cd2zOEF0yrdAzZF8hvmk00WP4ZuHRBrbKqXDC1stKkUmY/ec
	 NrS1PfX6T1oJurLjU6f12SEyfMCg+9ukuoPGmzF8D/sqG2j/vdgc719u9O85HB1fHioWq
	 /J4VT13RoQ32aY/FT7aCoHPGNl9yGHvre4mKv4Cv0jZBO9LIZcY/wXVQoEZIw2poBt6NE
	 YdaG2uu1Mpe/i7WuLaG7LR6Kf54WtkPXE2+CQm1Vz9OV40L7TkIIcej9WBKsvHMgf1N4j
	 U7VTLvTNiVyrk6+IwcjAXHo4w9g/Ulim/DAHw/4MyTO8nuBIMM3NU0MnJKX+XB3WADw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295365;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I/hHLdLVruU4T/9De7LO2UGrRMmiSpoqGZgB1pdHd5g=;
	b=CKRWUyxTyyLddr9NH65OohCLtjn1DbU39PTt3bgmphB6ZoVplZfvRr7YIvl0LHQRlpLI
	 gFFfaOIj6WgpBfNChnEuluCUu4sK6E2aveuZJJabBGRhrywLQ/K4Wsj+AXypNYzGMAy0T
	 /7sFdUz6dngouW4SmJI35DQzhavcwnKOJBi2agcSY8yDwDFLT6Yc+QjS8ohMQwD3v3KvH
	 dXOI67N92wOL0+EVHPhWSnO9aLQDJlIfFvhdhpSMBjwrG57qDdHjExb7T8MFlTGoQ5U1u
	 M4WtLLis0cbyYJkwXDZrzP7Tc7EtfejngrkGUwzkApomDC2KTNn0xbKsfDEfK2jthew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295365;
	bh=I/hHLdLVruU4T/9De7LO2UGrRMmiSpoqGZgB1pdHd5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I+1DgmGQ1YGa3NZ8VShjETLNrqJbQosyHSZ0FsZor1xS2NeTUzGW9hz+hCx4J+pLX
	 bcdBJcXzyxsEhmCW+OzdEL1SO2Pdnpbgbc0HHSKTOaLguCJmI/mnsAcI7Wk5fbCCfE
	 sG0nJpSlyvMByr4SApd2pcqqq8uBCM6oaZBjA2fV4iBURPUBLnnKsTc+LP15pK0lfF
	 cMVdHFfVrXoOG/aaKpc9f4vB1a5PqC0DRYmgJNmIlmD3JO4dtIm9Uq9Q71uEuv7vNx
	 kOjH4ePWAhpzx8RgnTcAXkst1JVoR726nTm7AKyeDZn+YndXH2n38tu/BHT8kM3BZI
	 drAOcXyO0qDgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 057A160A6F;
	Thu, 29 Oct 2026 17:36:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 823512FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6650E80AE8
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GwNBAijIPBom for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33CF780FA7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295360;
 b=Hmx0W1TkKD4iiUVPyG8NSJITaUmIcr3IDu2xna86Oh9uur92LwMyenSWBffUNkzTzNIN
 97V1i6rUiu7exUXfFKmnkbBBliuonJg5ijOm1q4NGvg1Yvy8JmK5jzCNrQoMWgfYOU+lX
 YBtLZ4fHllBiBwLwYlRiMiNEl/5lDgqwhsFHJhgM5bdczXZDrX8FOOsz31bWs98MgM2s4
 3EZlXHs/sFwn9/L1Qnvv3fpPtEA1tINvWuE2BcoXechPbyP02BmpS8bd7t9A5Gl4ECxZl
 eojxEfJg2UICcaZu/TNjgxsWJfG4mRwB7HIT3U9wbvAOD01KcWnRSmm8VqhkmJqIfkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295360;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=I/hHLdLVruU4T/9De7LO2UGrRMmiSpoqGZgB1pdHd5g=;
 b=WBnUA6+yJIGd0oDNqOPI2yJFIZlsHM8ALJBhB0kvW6nGdDQFchGRnChNrt8o7qDpdRbG
 bv3a9Q93EO5zs3bj2XzJh1i6NGUuM1QWlBsw2s8Ku/HDldqzJO1QRL+XjGf4gcJavPxCW
 3DwQRKo/xedAD7YydZLALxJ9fmVEC0OYh12kNaySa5fVYbwvyH6BjdJ+iaZAyplHUfi09
 XkD0PGtqboTRj6xgZ0WQZKEvl0/X5B7oWmkl7Gya6LBB16fJpWY8BNfH3U0LfMVMxuzjo
 49g2rO4exYKv2QG517LDxjgJNWFJNEBZYwbcPya+IPzm+W1xhOzZ0quEpxbrOT5HSAw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=l0fVh0hq; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=l0fVh0hq
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33CF780FA7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:35:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 4C671C49F4A;
 Thu, 29 Oct 2026 17:36:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D33556076A;
 Thu, 29 Oct 2026 17:35:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 72B1710329107; Thu, 29 Oct 2026 18:35:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793295355; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=I/hHLdLVruU4T/9De7LO2UGrRMmiSpoqGZgB1pdHd5g=;
 b=l0fVh0hqBu14TCc5eAxibn0FMEPNudp5TUXugVWfHPzO5W42toU8LE4laEdUANC3uVvJa8
 xNsZ3oBe9M8F9v4XDtad1owDQF+8ZVSxlv2YQ7IIXdN0Ztwf7ev6/xfMdPf1FtDwoEL8/K
 wZuEwEBnm7bPNXabTaAa9GI2JejZ0Di8tAHXhjTsSufBjHzPhI6LPZ9A0iiaEnGDZXcc8s
 IAELalSmml70PTc/0KgzkfrvN2zSIN9b2ybrssrt1z+BvDEoBsxeHlKHTfbmi16lyhGLfy
 NLI+R35HI/rFrRluWFkQpziZehklaqWdaP9SkB85b2BVqKk8LfRYtV70Q/Kw3w==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 29 Oct 2026 18:35:25 +0100
Subject: [PATCH v6 2/9] binman: nxp_imx8mcst: use the nxp_imxcst base etype
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-imx93-secureboot-v6-2-27b9c987e25f@bootlin.com>
References: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
In-Reply-To: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
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
 bh=HoqKvtME/qqv85vtLJuiBC+BxG2vqjCvYzhE9tfOZVY=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBq44PsKsx6XZ6wvHojgD6TBLWypWQYAv9aC7WF8
 o35vkyzfdaJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCauOD7AAKCRArAF6gG1qP
 AybCD/90A5iFi+kCDQ4PiftNg5bIJnhyeCmm1TyEOJkhKuC23rGMFq71MulHG+vuRBxpevrGCUU
 Kmrmjr8e8qab+1olvW7zLLkcRzX/4326fCgsQ497H1WPlvenJ94SOd/mqFTJsbSBapwjqgGAeex
 WbZwz7A6jwZ6FEbh2v6c3fdk4ZlUdR05GcDksTmXFAuiquIgOnkEhNIDsbAMjafQr+eSyXiYK10
 RT/gjrjpg6962IVs4Nw5p5xFCavWSOnWnQaaLHEUeGlc7AFTq8QK/Hgm5DRt1Z/+4r60lZjcEt+
 1FHRpk4CKjp9Je1PKweohkhsyXIeCz0Tjma82W9WUGZYbB1qa0yVt8+HgeHZlv2S0DadnFPNlmR
 QESTxAwK31XSeITHPbT4sh+LD3WpEjbT5FlzOrFk7q7wNrAkaTGMsnx2YWI+7Q82Vpi2cbaybpk
 +VLJbLFphDqO4EizsZOSFJvDVWCOi7uh40fPPdt0SEgfkPuRsAk3EnzgPAI+WscQpA20aqJnB1D
 xy8yVGXD+wU3G4eMLOTwbWXlMmzBrnTW2tHfqgoBzPvjdKIlh89WEb9V0xi1T2PUm21jyRGsg6p
 mn/c3v9gavIux0rU4hJdZJUjdvLTm7t5V+rjAGEJcX0iNAcOkdUWohCk1nAQRVdGL5uAtZM5KcW
 i4hEdTIDJ0QmSmA==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0

