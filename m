Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5124C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A61760662;
	Fri, 11 Sep 2026 16:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXWRiBjtvgAv; Fri, 11 Sep 2026 16:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7EC09606B1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789144614;
	b=Q/rrxCbYOAr43gGll8lTjV+w2ft/mge7O32baaWSD2xbxpJN7mUmFNwM5SECUC1xGOyP
	 PG7JHLUYH3J7pEPc3hvtA4wWXzXYwg9wMXQBURzJpCSV84U30bgV4RnX0DEKr7r/N34/D
	 TUbs0JhQltmZAE0KoxN8Gas8vX4U6g/gYiWCD3WrJKDP+LyUSYIWDsY5tQAtrdUP0VPX2
	 88YJSz7S4QU4paAu54JQ9GBfWiaMcHOMp8MAiTBLolztxcQJpIi6nmWdmm/a3c4zIoFoa
	 +yKjjXBH7hJ6/w4cqpyIm52ptj250LZLvi3mvCGJX9YFaFQd0Cnu+3/aNaBDpJGFJeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789144614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s8WcAu5dpeIWRaqYcYpRKPntOW8SV7IlcygdeD0uPc0=;
	b=GTrK2A6VUFsjiPT2Qgit8dj/QIgrl83qsnXkiIe/R20X0a7Zo+37esI2Jdp4jhvjAll4
	 Vp0/pEYi/sj3SFufwEeCT/M+ypaktm1XUxFzskZzqBdn1Sj5vhgQQx2zoUMBjlQIf936t
	 BOn0XrfeA6CJGcmLLr4dHwXBDJYz0p17MKNEsrhVFjtb4xnjcddRd6Zo0G1bLOU1Fmngq
	 pHnY125lGCoMDeW5XGzfFo1JjqkKqgojVpch5LADmLR5Pk+Q0Y3NprpsLkJsAvxbGkkUf
	 8T70ZgT4qeRxUof9GCQI17/yVaEhl7/0ZXGKtRevrOdvS3yP5Es5bnCIYqBfZtjGFDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789144614;
	bh=s8WcAu5dpeIWRaqYcYpRKPntOW8SV7IlcygdeD0uPc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=umxkU036hZCND4sxlvQhxKEkuwgJbRy7rYl7sCkM1CT4A/g8Jydw4nHXwUGlpcTM3
	 UE5u+k7eWYpRJlGkY2b0xQ9mWxls9LvxtzTvNb8wMw/Frsg0PvVexz+DGI2jgeHmue
	 4csmgJ3faiGjQjrbZrS2352uPJo+oB17TpQJ8qxYb53OfXwdhQuOyH4k6Nd9MH5OIf
	 MVFWJdIVTE48LsmnuXUF0WWPsihAhfAgJ9uCxRwHbyNJRRhWatvgFnlYsOZizKkbOA
	 nNmiPhO85cL+xtXMW2CvuKIWxxzweraQ/rvoYHUjvfDXOteOOAwLp4Yj5mSyzDJZMX
	 Ygm8SHvCqiwYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EC09606B1;
	Fri, 11 Sep 2026 16:36:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 438BD701
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35410407EC
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id toV8lBQMH_ab for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:36:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 16BDF406A7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789144612;
 b=kPwXjBYGxkMEJ4eUIvVb6CT24z1Zn8mWOrEVFUS2L7pYk5yYat4FQRPf3LEGekvVKFJu
 qfxkf+b6ku9msOS5JfKfLMtO7+liFg7MbrWZ+zZ/6kAqXfidFKVcWOBuWRjS9F6KE3QOy
 ng55vPgzhrFum/5UMZRldn7iVQsK/9v5Q9oIOevRD/7cvQh4EaK+bn6ZCuCgdbXJDIr2P
 OvEZguGSstakJTKl9Va1kg9UKv88EHM6Kc8mSLsiGcTrFl3xbKhuSggL04hOzYUu2oCXD
 vqA3Xnm1diPdqso4FcWlQdH9OJ/o/3syzC7I/epCFl34Z8Me9ZXyArio2IPedEKA8xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789144612;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=s8WcAu5dpeIWRaqYcYpRKPntOW8SV7IlcygdeD0uPc0=;
 b=MCXwx2BBdaRs+N8UBXcGTtN/0pve2nY9E/CJzwN9LaZ0dTIrI3dcY5K72ZjGUkG1yrJY
 3dJJ7tqEXj2UBUNyN0t33ox8WQG+/clXnBSmekpvkdd6vD/In7df5oZU3/zs72n/PTNiU
 O8W1ixsX879u5bBPYdzL29v2SbPozZjzVUrPfifkiFqHSLduLqVO+NG3xQeA1EDiroRze
 X8HxOZ+4qsfz7Sa43slmdnfGVgFkQPre9rbAQvAULQp5kMAs/yTz6Y9fuOLd5J/hQGFj9
 OuxF+O22i86SXLbvgq1QuPkov9IKy4HU8ZqKHpD4L1z8xFbom99RWXx88TMa6CVv8NA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=RLQyArFS; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=RLQyArFS
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16BDF406A7
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:51 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C43D04E401F2;
 Fri, 11 Sep 2026 16:36:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 96CA6601A3;
 Fri, 11 Sep 2026 16:36:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4903C11C7AF95; 
 Fri, 11 Sep 2026 18:36:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789144604; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=s8WcAu5dpeIWRaqYcYpRKPntOW8SV7IlcygdeD0uPc0=;
 b=RLQyArFSjfRXV0ZfxjEspcJoRVvM+JtsMkXXfOvb83EFNyfciOwzTHLZDhXiLigEcWUWim
 gpoaE8akY84f+bwR+Vs0TyJh350u0FsJGaIJaoeVnI8MI0J2e9MMZ+owiZFgCeU5IncRVR
 yaHIqYX3K9LpydqTxZPtRvvmZLzboMweSAFs4UsXspk0nm95sDQJK4Oa1+xP1N1uomV2tZ
 Oa+WYg9o4OnQluq6kOhuePbZnopVnKqp2MB5hKrXU/bFBej/G3iAAPYI9QJ4a2Q3n3CDS+
 yWdirycMpAIEUHb1bKmD7gsLmuoy2FcxVmygqQnWwviz5ijwQjBq9jGH30AI6w==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Fri, 11 Sep 2026 18:35:10 +0200
Subject: [PATCH v3 7/7] binman: test: add code coverage for nxp_imx93cst etype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-imx93-secureboot-v3-7-542a99793af0@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6687;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=PVxckJoGYSHJHRSpuIM0Pu+vZjbH6wMSZjEMyybi9Ek=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqpC3peN2xVFiSMeddFeLKKmIRKiN97YGe9XHmk
 fSe8x9FoqiJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCaqQt6QAKCRArAF6gG1qP
 A8+pD/0b2AE82YlRqj8fykykWI3csQOevExK1CGafubiBEcDFtz3rbiE1rKvL+rBlCLrzeqsz0Y
 RTi8jGa2p6jMaE8PmKyto2JMIx8cDoWMn+CmIwvVdUN68S8N/JhXQGedUvFWGYId3o1Ko9woIOW
 6GoNNGXMK+7OqTdDpjKJoQ5jqecn5Oih1KbaEJg1k0eRzqbexdzZc+3V5DsCqmkV6j+n6gmEXJD
 mBIe+pWKhfqTfij2AiR+jAZZymokHF+lkyFkrfFeSniWuqaxMSu6SSqquE9Fn2H8QReAcQWQWV2
 /JDZfyU60u5EUtOZ35VVNPHWve1T8l+tH6OPJO/QtAeBcRoubLCsb8hsLDQkj78m7h2rPal1exc
 0GcXTpMX6oyIzSUXl4xguxVPhvMcY7HS9fc8N0fED5DV5rU1CkmOxuG9SLWVUVLJqysiaM8c661
 DwRlNX84EW/YaiJ1LrwEJhjnLohAQYII5Q5oiAkVKu4DXkTRERQdr4ZJUGnsQfZQnNOhsBSsfsr
 utAI77vwD5XYeJ7ViIFqYEtGKbDoQT0Sv09796gKrNm12dcfLSKvyOEsieW3E+4HEdBSO6xYuWM
 81lwXvGmDa1iKSAT/0oa8ytaPb9ZFy+0gmdZHa4jcWHMuJEuOyRiNNSX8fF6NXoAnvmWvVr5O2b
 /ZcoTpQRz2jxrRw==
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

Add test methods to cover all code paths of the nxp_imx93cst etype,
reusing the pattern of the nxp_imx8mcst as done in commit 0cab35362d77
("binman: test: Fix code coverage for iMX8 and cst bintool") by Simon
Glass.

This brings nxp_imx93cst to 100% coverage.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 tools/binman/ftest.py                              | 85 ++++++++++++++++++++++
 tools/binman/test/vendor/nxp_imx93_csf.dts         | 18 +++++
 .../binman/test/vendor/nxp_imx93_csf_imagename.dts | 24 ++++++
 3 files changed, 127 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 5f0de4c74a7..ce012b415ff 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -35,6 +35,7 @@ from dtoc import fdt
 from dtoc import fdt_util
 from binman.etype import fdtmap
 from binman.etype import image_header
+from binman.etype import nxp_imx93cst
 from binman.image import Image
 from u_boot_pylib import command
 from u_boot_pylib import terminal
@@ -8152,6 +8153,90 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             result = cst.fetch(bintool.FETCH_BUILD)
             self.assertEqual(('cst', None), result)
 
+    def testNxpImx93cstNormal(self):
+        """Test CST signing with an i.MX93 SPL container (no ELE FW)"""
+        # Create a fake AHAB SPL container: tag at offset 3, image-entry
+        # flags at offset 40 whose low byte is the A55 core/type (0x23),
+        # and the signature block offset at offset 12
+        spl_data = bytearray(64)
+        spl_data[3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        spl_data[12:14] = struct.pack('<H', 0x90)
+        spl_data[40:44] = struct.pack('<I', 0x123)
+        self._MakeInputFile('imx93-container.bin', bytes(spl_data))
+
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+    def testNxpImx93cstELE(self):
+        """Test CST signing where the SPL container starts with the ELE FW"""
+        # Create a fake AHAB image starting with the NXP-signed ELE
+        # container. The low byte of the first image entry flags (0x66) is
+        # the ELE core/type, so the SPL container header is at 0x400
+        ele_data = bytearray(0x410)
+        ele_data[3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        ele_data[40:44] = struct.pack('<I', 0x866)
+        ele_data[0x400 + 3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        ele_data[0x400 + 12:0x400 + 14] = struct.pack('<H', 0x90)
+        self._MakeInputFile('imx93-container.bin', bytes(ele_data))
+
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+    def testNxpImx93cstUnknownTag(self):
+        """Test CST with unknown input tag passes data through"""
+        # Trigger the pass-through path using an input without the AHAB
+        # container tag
+        data = b'\x00' * 64
+        self._MakeInputFile('imx93-container.bin', data)
+        self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                         force_missing_bintools='cst')
+
+        # The pass-through branch returns the input data unchanged, so the
+        # produced image must be exactly the 64 zero bytes
+        out = tools.read_file(tools.get_output_filename('image.bin'))
+        self.assertEqual(out, b'\x00' * 64)
+
+    def testNxpImx93cstSigned(self):
+        """Test CST-signing-success path with mocked cst invocation"""
+        spl_data = bytearray(64)
+        spl_data[3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        spl_data[12:14] = struct.pack('<H', 0x90)
+        spl_data[40:44] = struct.pack('<I', 0x123)
+        self._MakeInputFile('imx93-container.bin', bytes(spl_data))
+
+        # Mock run_cmd() so that when cst is invoked, it creates a fake
+        # output blob and returns success, thus covering the signing path
+        original = bintool.Bintool.run_cmd
+
+        def fake_cst_run_cmd(self_tool, *args, binary=False):
+            if self_tool.name == 'cst':
+                arg_list = list(args)
+                if '-o' in arg_list:
+                    idx = arg_list.index('-o')
+                    tools.write_file(arg_list[idx + 1], b'\x00' * 32)
+                return 'fake cst output'
+            return original(self_tool, *args, binary=binary)
+
+        with unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
+                                        new=fake_cst_run_cmd):
+            data = self._DoReadFile('vendor/nxp_imx93_csf.dts')
+
+        # The output must be the fake 32-byte CST blob produced by cst
+        self.assertEqual(data, b'\x00' * 32)
+
+    def testNxpImx93ImageSizeNone(self):
+        """Test SetImagePos() early return when an entry has no size"""
+        # The imagename entry is in GetEntries() but not packed, so has
+        # size=None, which triggers the early-return guard in SetImagePos()
+        self._DoTestFile('vendor/nxp_imx93_csf_imagename.dts',
+                         force_missing_bintools='mkimage')
+
     def testNxpImx8MFSPI(self):
         """Test that binman can produce an iMX8m FSPI image"""
         self._DoTestFile('vendor/nxp_imx8m_fspi.dts')
diff --git a/tools/binman/test/vendor/nxp_imx93_csf.dts b/tools/binman/test/vendor/nxp_imx93_csf.dts
new file mode 100644
index 00000000000..bbe8eda4b70
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx93_csf.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx93cst {
+			args;
+
+			blob {
+				filename = "imx93-container.bin";
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/nxp_imx93_csf_imagename.dts b/tools/binman/test/vendor/nxp_imx93_csf_imagename.dts
new file mode 100644
index 00000000000..13009438ee8
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx93_csf_imagename.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx93cst {
+			args;
+
+			u-boot {
+			};
+
+			imagename {
+				type = "section";
+
+				u-boot {
+				};
+			};
+		};
+	};
+};

-- 
2.55.0

