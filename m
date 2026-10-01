Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537C5CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E1C460BCC;
	Thu,  1 Oct 2026 16:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-aUJMuMhTrY; Thu,  1 Oct 2026 16:27:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3F48B60B26
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790872061;
	b=cAc8j2sA2fTqJhzvyIpNm291Gds/fhK+SCUfcoDYLQR2xCRZ1bWtqMZpZzofWcQbnnuW
	 2sjcgCyy8Hhco4SRe46VbEsTm0L0AsSZCWYI7p8tAPfQXH9uoJVMmmWhWm7cmiF18ozXs
	 Tl1HFUcX4yUqeve9Lfbo9prm0DzfccR/C2zsqlRroHGBleVE9iqLdkKAMb0E64h/Hp+kQ
	 CymlaVSt1N4KzCMIYYIeXQLoaGZWh0pglJEHrZPACmqWsRmQ5qe6HJgAiFzpHlbvwyi+Z
	 ymn7fypGE9Z6eSdHknhMFjuE9+TzuJwt6UZLWkXMZ5nzIwpfYN9acy2JCfxix5K/tGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790872061;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9zhYKAqwhPt06ybtX/OJW/ViuS34LadPEBHs+i46S5w=;
	b=mCkqbC1JDxPV4YV62RjDTZ7ODazl41BmkF3Gb6hZoK6dclcopr8uMe2M+U/vFF4U2PPt
	 gFxKvgw3A/tmPGRdrXgswWMqZzqFal67Hp3vzAdlilhrgVIdIoc6fU2J9g6JvuP430eUy
	 oG6aRt+5vIoI7gm55LuO5wQlNXUp+UQuqo4iBQB/kQZIa+DkX2Zar39mMyFjTiqNuNpII
	 hORLNNQXSFlvLUlJo5uSco983+7OI+QkAUyUtevnbhOFIjc3L/lRqfH6gmJf3oS2mX5Dr
	 CR+ElMnHzt0EyOL+URGSj98dag2e6WH7sibhazduRuCJLUxhz9k1/1hY9yEQ0/+ml9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sMRBhWRk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790872061;
	bh=9zhYKAqwhPt06ybtX/OJW/ViuS34LadPEBHs+i46S5w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RwMke274lVMwcGCk5EpwGYEmAQquNwK684NMrOUISZXbj0KepQh+9k5GLSQhG4XWT
	 gzG2OAXmhdhHD976tN7PWc0Wg0JXvWsD/lA6a4pyeeOBPU2fJfMQppC1uYR+RwTFY1
	 Glrq3mn94cpGHv7ETfpf0FzS/wjAhOFCXWDFOclnC3+IVIle8tl/8sLyskWjo75oVd
	 mraZ+c+/u4kYIOcMRrIJOGFOQ6db2jYdVlUduC2CoUXMBk7f0k6oEmr7KNSqdbroNk
	 pBjnMeot90Cimwj4xJrn6Cp4DERQOHcEFMFGd5UIxIhZs8G3s3UpqPfBnoVqDRRaDo
	 zPd+KtJoxv3PA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F48B60B26;
	Thu,  1 Oct 2026 16:27:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9696D3D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87AE760B94
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bkuYKyl2JYhu for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:27:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ADD5D60B4C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790872058;
 b=etCujiHCzEgDEVebmPQj03fkunFCNlB00p81JEFDJleWJvl0A+l7hHyp7HSa7DTmr9mT
 H9lajQSKOOhAjaYLXP9+c1GuCApFH7ENMEOEGKpbBQ12ZAm4CDfHE0I1yZQjrdfQ3mzRb
 lW39kmFz0Zk5EHUNqU9s1J8w9CmxYTa1xHnvOvsDduxGHNJ6BrHec3bSKiedOkYt0D5UY
 A5HxvlFEhrPYuzp2YTkGl81ibEEY8UHmx/KR61Wvk1yolJVT7Yrf+IP3x57CL0UYF0jzp
 AFk4OntndcV7L8HXnVIyei0efi5S2wLSZtjMZOl7Mww4kweliNivYYiopbYV4I6+XOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790872058;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=9zhYKAqwhPt06ybtX/OJW/ViuS34LadPEBHs+i46S5w=;
 b=dXJl73JTDFXLaS2AOSedWrS6kemLJum1mghivfTw/J5s1pG5Wt8VPLYZK8PlExbC4SJw
 XcACU9UloKV8C6Ytu3VY/nLcgkLSb3dPJfseoDrZ7DH0zmMUqW15VOxFGoIJon11WcRho
 mgx1qurC2tLNXl3sZbw56nZirmWeRgNKzhUM9YHgAwhvR1BZeZv5Iu2GPQv8YUzzHwh5h
 Lmu0MDOReKQYQJOqN3VKlJijKHdvBqBxblbiyL1wlcaZ59vatEaccXt2EynS0uJyGaQ+h
 BGtjcXy1PUKUrcppW2dh/kJQdbBvemWeUTrPRHgHJBvJH0Nz81wr9vgArI2LoTbnQIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=sMRBhWRk; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=sMRBhWRk
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADD5D60B4C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id CE69E1A18BF;
 Thu,  1 Oct 2026 16:27:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A17AE60343;
 Thu,  1 Oct 2026 16:27:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6D2DE10328327; 
 Thu,  1 Oct 2026 18:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790872051; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9zhYKAqwhPt06ybtX/OJW/ViuS34LadPEBHs+i46S5w=;
 b=sMRBhWRk3RNxjLsk1+hHwaGuRY7iJ4hruqspjIqDaqFFpGykLZTy4ZzGy9IDWrEQuTb3HJ
 WTTSKx2v+SZOXUoC/2Xkj0BT9Cgs0HIdThaiwpzqc16z/1Q2/uLBtqKVV4/Z7V4DhrtK+7
 +UBt5FFjtit2u1gZQtVs5z9hjcGmmaTllMF3kqFrZmGypYKJTdhgT5al6wq3j3ZqPfrtkp
 POzP58x0fzainLF5iCgQe1GQFCasgE7Be5c9HFaT4wRrUfINrbMHn2Mn2nMH+sLFPzS05R
 vkxJXw2ouizwPOhrElx10SQvrnmPdPypTjQlM51byqLkI5ExMiDyAaQfuEflsA==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 01 Oct 2026 18:26:26 +0200
Subject: [PATCH v5 9/9] binman: test: add code coverage for nxp_imx93cst etype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-imx93-secureboot-v5-9-d97dea41bd1f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6350;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=UeWylPr4p8fFPgZe/4DKAGpDhWNoEYGIbvF2nCEFZzQ=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvom4LqA4RLO/v6iHAK1BCSNqmAwYU56yTGRKT
 XkEbHqY8+SJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar6JuAAKCRArAF6gG1qP
 A6FWD/wOsrewPFoWr/vp/hrAIerNLDjBaW5ErdTajv3PZUzgW5CJb7oVOS9O6bZdATHsiIgT5Wh
 y5oJu+2sxJFVAmZEoP9+M+gzeIJrx9U9UzdIlIFfa4jlAR7ld92kekW0Y0v7KaVfoBAvYC0JkGP
 A5lztuYojpM4bZifofd9ZaCH069PVqpDILBE0y4bJb4J50dDGgceHBLiom1N88NXfuwXhai5xRG
 PalgIXTvzlCv4HXeWyPVRUM62KDufCDyGOELY7MJcVBRW4qYo89lWnwTX19u5NHfC87X9/03xhF
 1DhwDH6Zt62TIxn/X09BbhXedpgfwHw3spOA7Ew3JhAgIjOnaS5A5Jg2oSF9Z4vc6Oga6Ga8Qdl
 raFmmoV8Hd4Gz1bBzEOMY97UhEFw6VU+kSxWOimNT4q7cacxNLUrB8+yB0XyOko+TSp6C4AsqLP
 7syETNnmPnxtDoAM4gH+yfRfB9b4Zf0HA3ZxCmRb+Csq7ma+0prnGBxMrFMby9loLEiTT3dM2B3
 6nwvOX5G8zBJ/ukg5YCLwvFU5UGxIqP1xCWb96yeflSgdWvsFOcVa1WWf9ewplbsXssm+ebUiQi
 iGIVnKKdp+QLnp03bVDHJ0HuGbbgKrvJuryoDh+vGJas8jBzEH4BS6LQNEhVagw98gGt2FexTrg
 tuR2VpGQLM1blaw==
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
 tools/binman/ftest.py                      | 97 ++++++++++++++++++++++++++++++
 tools/binman/test/vendor/nxp_imx93_csf.dts | 18 ++++++
 2 files changed, 115 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 783836045cb..822ad5c6f07 100644
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
@@ -8158,6 +8159,102 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             result = cst.fetch(bintool.FETCH_BUILD)
             self.assertEqual(('cst', None), result)
 
+    def _MakeImx93SplContainer(self, offset=0):
+        """Create a fake AHAB image containing an SPL container
+
+        The SPL container header tag is placed at the given offset, and the
+        returned buffer is large enough to also cover the signature block
+        referenced by that header. The image-entry flags hold the A55
+        core/type (0x23) as their low byte.
+
+        Args:
+            offset: Offset of the SPL container header. Use
+                nxp_imx93cst.SPL_CONTAINER_OFFSET to build an image which
+                starts with the ELE FW instead.
+
+        Returns:
+            bytes: Fake AHAB image data
+        """
+        data = bytearray(offset + 0x100)
+        data[offset + 3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        data[offset + 12:offset + 14] = struct.pack('<H', 0x90)
+        data[offset + 40:offset + 44] = struct.pack('<I', 0x123)
+        return bytes(data)
+
+    def testNxpImx93cstNormal(self):
+        """Test CST signing with an i.MX93 SPL container (no ELE FW)"""
+        self._MakeInputFile('imx93-container.bin',
+                            self._MakeImx93SplContainer())
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
+        # the ELE core/type, so the SPL container header starts at
+        # SPL_CONTAINER_OFFSET and the signature block is covered too.
+        ele_data = bytearray(self._MakeImx93SplContainer(
+            nxp_imx93cst.SPL_CONTAINER_OFFSET))
+        ele_data[3] = nxp_imx93cst.CONTAINER_HDR_TAG
+        ele_data[40:44] = struct.pack('<I', 0x866)
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
+        self._MakeInputFile('imx93-container.bin',
+                            self._MakeImx93SplContainer())
+
+        with self._MockCstRunCmd():
+            data = self._DoReadFile('vendor/nxp_imx93_csf.dts')
+
+        # The output must be the fake 32-byte CST blob produced by cst
+        self.assertEqual(data, b'\x00' * 32)
+
+    def testNxpImx93cstShortInput(self):
+        """Test BuildSectionData() passes a too-short input through"""
+        # The input is too short to hold the container header fields read by
+        # BuildSectionData(), so it must be passed through unchanged
+        data = b'\x00' * 32
+        self._MakeInputFile('imx93-container.bin', data)
+        self._DoTestFile('vendor/nxp_imx93_csf.dts',
+                         force_missing_bintools='cst')
+
+        out = tools.read_file(tools.get_output_filename('image.bin'))
+        self.assertEqual(out, data)
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

-- 
2.55.0

