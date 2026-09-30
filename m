Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2D2CA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FAF560845;
	Wed, 30 Sep 2026 13:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DCHGMD958b6f; Wed, 30 Sep 2026 13:43:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 16A7160B1B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790775838;
	b=TcutjvG3PAJklmfGqV+hkF6k3gPBVrQNx+/sHeD5tpsax2Tv2AlCx+ChWwleFi1wC+F6
	 EBYLEkGCp+m/tX7yuqyw18NCYg3CMWNWF1lFPuubNSUqmpAaR48ERYNWV4VFNz+3se9XI
	 JUWamLw5azFjfhoiwT2hODFnmIMW7YoeI55iWEQtLf72ySoV9V0sqk1n5rWMqo/8e3I2L
	 MGISyDCO66yNZ2mXdgvmhtcHFQUVHx9g00RJgsEaE5hpsZqRWHNyZojcTgVoGe/5u+W7H
	 weFqKIGnT7mZGrC4s/TY9HPcFT/204u7x6svqEHqlke0HKhHjaRBrx/rU3AmNIqdNcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790775838;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=upH8jSxmr9rSYVj7B4a0U54j9s/L9iP1+LcLu0T2H8w=;
	b=JaTNwyyW555TXYTmq0KhpNX++/EpFHwlKEu5FEeOqMQIFMZy7G4QhASsI3cRF5UwiVRC
	 dbchsFnQIzgwMU02VlJrSnsYUzuQaTpUd6Us40ok8ln6s9MvV67/yd1tk5AIezzXEVsRT
	 fyhJwIC1+w1ejiWHRmoZiRoD5jbS0tuKJ+Fj9xJW69M3FZWUC+nh2qR3nIX550vV+ROND
	 hhNB0i2SNthOd209DHQGhAPCSMIHXrlsRYziorQfrrwSZg2gkXu2lQyZYT4rkZXMJanBX
	 D4m4YxHgAEnQJ/KuM1BlEoASqETQcuDzH/MYdw9OR98YckNvOphWV9D/3CiPYZAmtKQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790775838;
	bh=upH8jSxmr9rSYVj7B4a0U54j9s/L9iP1+LcLu0T2H8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ymBm3nlfasbHau+mMIVw6+8Y07ZK0R97E33iW5BsedeV6Fc5rJFKMnqD+OH/jUYAJ
	 0LNALwsE9U4FF97O6bv2zY24f4thLh3O0Xb5r6H9UfupUlQdO3DwR4mLBZNAL6tTzb
	 9B+uXlY3zmPHdNC/QysOQmijf+szg5w8lESrIEzn+Y+Ykx6Houzfb/ojh48qAh0rgM
	 IlYHRu52NW6bmuMmi7QOwdzQ2joaZecNSrUpU8Oy1U2tw/0j6FyP3MLtWMajOLhC7+
	 +tuNRtw3g7udi3cGJza8ZOoPSNxs2AdSJe0xXxEvS+lbwsYlwyg2DtlbqEAGuvwH0h
	 cCgxmPZV/j3YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16A7160B1B;
	Wed, 30 Sep 2026 13:43:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F3CA380
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA2F8400AE
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tT8-1YoWpQky for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 13:43:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D8FDE4009F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790775836;
 b=PlaAHD6shj3ktydGXxXjFm3xWmYzHROAGnoynLHM+AZ+Uq5LIoPwF3Xy4zcse4Uiq/bL
 6U/mqAEvBGOsxSs6l3OWNS7hZtTLnilRf8czoBpkewsmMZbtH3Txr2TzH/Vt88CVNFV9w
 Nl3kFpBS+MAvY7TIGLW+cxDUziM0tPDaS9CBPYoaU9H9LnDvnPVFlnPGdB1dhyjHNM5yt
 5cp+j1wod0ptNUq3Q5KSAMNPlUEvjaCY55Ux8iFeail/a3VixfWXrwEm4H1hK6vR37Mea
 w1kPdxdNcdx6EtBAGeF8X6HgW5+MJler4sUDu7D/y9buWZsdEILQIgSxebmyZjeRQ/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790775836;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=upH8jSxmr9rSYVj7B4a0U54j9s/L9iP1+LcLu0T2H8w=;
 b=l0JSb5ii/9Uc4aimsolE3qJ8iYMylJG4MlzysdkbcHlAOo0buqrlo51t24W/pZUqe/ap
 +xTPxBvwP0+sSj/GUqBME9qwxWhe+8P0LqhiNVJdZtBoZj9ZAgVQ65xTgSHYVgl9oBnoM
 7GhlQnxAiRBtQxSKBmmdeqPKs5xychLhy7+rwqC+pqPoWFGqJ6DFX0flspVPOwci8PdCv
 N5di6ffzABkQICkx+0fE5C45nm0ZFoyGdB8YMYQWsnwUPv0NOOpfDOY5qbMW95dVKFy6/
 eyn3Y4NKok5r5JSeZe0IUnkD2jtpCNsBb/oCfocS+UakKkysKV2IFxEr0nDp0Vda9vA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="R/o9ZTJY"; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=R/o9ZTJY
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8FDE4009F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E418F4E410D7;
 Wed, 30 Sep 2026 13:43:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B7CEA60749;
 Wed, 30 Sep 2026 13:43:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA10A103298D9; 
 Wed, 30 Sep 2026 15:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790775831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=upH8jSxmr9rSYVj7B4a0U54j9s/L9iP1+LcLu0T2H8w=;
 b=R/o9ZTJYH6+kuFQmNIn7VYtvCJ+epqVOZsbJC6oZ36RuJjHJJPwQLoQgX3w9m23FkjRI9P
 9CUUxYNUyo/g2NIW2GxRrp2/KL+mFkd4iPtwGoIrJm1vohj3hJKz9i8tuRB9Z4e9FdEFCP
 Zqbn7HA90hoV56lDCZFnu3or7u39z5+2AL3SP9q6rD6+OawZUHXemnG3K9WVm8Aab7wSJe
 UUqppNKuDUd7pmda/IOqRG8cA0CsxoypRgzVftWhBPPRkgO6axy/49/4Et5T7qu3A3oIrl
 NcI3Bgd3F/BLTUP8luQBUoZx5yxH2YyFj8YFjC8xowxgoOxu+zM4adJww1Zkyg==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 30 Sep 2026 15:42:42 +0200
Subject: [PATCH v4 9/9] binman: test: add code coverage for nxp_imx93cst etype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-imx93-secureboot-v4-9-f968a1b14dc5@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6274;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=Qn/7z7W1RmZaGhmVjjj8sXFf8Y/C1iQ57ZpgbycFpyY=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvRHZMJ2OVlkMmDXfzX5Q3DJuTN81Nl55R96Of
 bot1AOS3riJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar0R2QAKCRArAF6gG1qP
 A/pcD/9Ui7Zk79dj5NyV+vJ6+ERQ7TAFkW4ExkeNDcBQuguUOnCkemYJfU0JVaNvz6AAPaMZGVr
 2AmD4R0Nh6TRbfn7dKjQfm2TLHnZAg0fdTVy6cqXeBRH35eNH9QlQvccIpcVdjkcKKs4EUzNGu8
 xAq3snS1OoyNtxfa0NHCruNZBoCVK4WnazikDFeFy0lVej7d36Bpp39/wVXxp4QXuASbfqYCrdR
 dPXRKW46C0Ln28aLumAYM3/8LDlabwpcV1hmYlSfPs9esLCOKgTlN5hnGiGC/lomG03fkPn4q+J
 /pyEBLc00vN6b/jhlt7RqR9LDWAD5GLr0BgW309EsUoYIN2+MUrr2O7QD5/of9lUllFlgOWOKoC
 K/9oPilScppE8TBouMew2/SFzxLIj+kpC/v6JIZPlJ4C8LTmn+Hf3eT4taHdSTCRDjCJC+Zkg1b
 48ZC1toSkMq7w6UYO5gTFKu/OwwxwwmhVxd0mZKgRjLx0xt0OeZa8oPp6tR7Vl0mTmBjmCckhP6
 f0DHIzHf17/a3e5ccoJPKr5V9xhupS+Qfv/5FzCZg3Gd6pvXWK9WESxy0Q1fPIq5XLPQzji7HNM
 UP8vRR9LRZ13iUJ1jG8Nfc5v5hsDMDY4klC5iNV0tYJsyeukZoPd28p1ewEOwkDfZYRUHQoWiDF
 H2AuOqSsmcAjC0Q==
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
 tools/binman/ftest.py                              | 78 ++++++++++++++++++++++
 tools/binman/test/vendor/nxp_imx93_csf.dts         | 18 +++++
 .../binman/test/vendor/nxp_imx93_csf_imagename.dts | 24 +++++++
 3 files changed, 120 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 783836045cb..959c4854866 100644
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
@@ -8158,6 +8159,83 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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
+        cfg = tools.read_file(tools.get_output_filename(
+            'nxp.csf-config-txt.nxp-imx93cst'), binary=False)
+        self.assertIn('Offsets = 0x0 0x90', cfg)
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
+        cfg = tools.read_file(tools.get_output_filename(
+            'nxp.csf-config-txt.nxp-imx93cst'), binary=False)
+        self.assertIn('Offsets = 0x400 0x490', cfg)
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
+        with self._MockCstRunCmd():
+            data = self._DoReadFile('vendor/nxp_imx93_csf.dts')
+
+        # The output must be the fake 32-byte CST blob produced by cst
+        self.assertEqual(data, b'\x00' * 32)
+
+    def testNxpImx93ImageSizeNone(self):
+        """Test SetImagePos() early return when an entry has no size"""
+        # The imagename entry is in GetEntries() but not packed, so has
+        # size=None, which triggers the early-return guard in SetImagePos()
+        self._DoTestFile('vendor/nxp_imx93_csf_imagename.dts')
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

