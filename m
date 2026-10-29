Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D7606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NWUQu4up;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XiF8EFam
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BA6C810AC;
	Thu, 29 Oct 2026 17:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zb4Z9sob0Bkg; Thu, 29 Oct 2026 17:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E0DA81092
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295395;
	b=Zqp5OLQjND0FcpEA8JPKiSWSLCAurfTQncQse+4OZRO6i9d6w3gYWkonLv7Wq6pdtmwJ
	 /OPGgKh+a9vckyn9ZL/O97eThhEheEbnWMC91sliEBTIwgdjOsaI50B1DSmlnl9/bVkJn
	 bh76YrKyRceaDnxLnVMZ0adEqAZurG5KKyLUuqGayAuoYnnTSHRsN8JLNmWZE9o47Q7JF
	 9Dct2IR3Gf3ckOGagy43A0FLVF0J6OmFSFcuOy6TDXB10CWGC1wIfa6BKtXH5C7ufj3pI
	 5szvGOFqVGt/VITINrp0kgOeyRaGSaTrTJsRkbIKJ7F5NxzgoIAiBLOtjlOZjFOU9KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G8xQIYW8mmS7IsMRdYQcBl4TqSIsZeCoLUgehIdpxoU=;
	b=GnTTKcGT5i5KosKjZCOnRyU8ri/QpsxrLJ6par+N+LF8bZENaqUUeNgTIKzMHmPIOSkI
	 u5W0eqkBBJgoROVrg6O4/s9kjubWWsq897WDvWnHDjjvARl79eRwVb25j45a0QtaMCuAW
	 TqrR+ZsbmuO9KK7I7U61iNXzz5v3eeP/giL97L3XuuNN8Q5Ygalu2zPIPf3qH+oLSSD71
	 wITzKmx0A32qa7BiSy0lrOgldsFVftlB4iN/9GB1BUc0X2ILITg0FrXxJ4WebY1DYA+6H
	 N1hUcqlaXS8MnCxH3scDUjv7mJA4rVbayICwEink6fA/Zs3KzCO/bOuNkEc3Ipl+Txg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295395;
	bh=G8xQIYW8mmS7IsMRdYQcBl4TqSIsZeCoLUgehIdpxoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NWUQu4upKtl9fpzYKj5I23Ge/JUe7n2xHlCSVrq5fhReWMKRFM6cxgkLxKVpSWKHH
	 UgqeiusDMISHqiVaqDIiLZMnZPKGIo023ROv8DrVzzcYbtw0rr1/DUzzJ7pIG7TiuR
	 1hZY3PgZbQaHz7d5GAEA3j+q4logvoHLVbdtQxNsapc08b55lQTesHEHfsum5Ugj8j
	 UjwG7uMp5mJuGTB4O5mjOsIYLLdww/cXQuw6FABVvd3rWLCrrL6dnFaqMSf977qXiQ
	 gt23C36s4oWUIRmmH/Osb4OyYK2WvrjW6kPildJfBDK1KgKd6XnxXK7sB86VmVhQ/s
	 JASnMZSVr/6Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E0DA81092;
	Thu, 29 Oct 2026 17:36:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FF162E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65A5440552
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3n974Bqqwvqj for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD66840735
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295392;
 b=Ct7kGLcAeXI8xl8ttL66qWz577UYymdhuLOZMQyd8MqkD0I1x4pXFSGQf0Xfb7kx+4/2
 DxMUkBCGfh0hoUbzMxpoJ3zgrWrYDr7Vz9qSSJlyvONjVoUePZsF8EY2vvyp8d06hTWyc
 JFLyBZleMISJUTgmDEnGq8CRnFa146fwpR8KERTWxArh+z2l+uRRoyexo9sQCstSi+7Tl
 jNa4bdmrn9Vyn2FKZrGWGweOGhbdS6mHP2QsbszwqYbQUIWgf0l502gAIt8wywpEdZP4c
 9C4zGkwrYoYHUdDSu4K0nhkM9BNPo9ghZWXHFdt1J6MihgihSZT16dUuSs3pSsXOqdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295392;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=G8xQIYW8mmS7IsMRdYQcBl4TqSIsZeCoLUgehIdpxoU=;
 b=j8Y62nEm4nacD1gERUw8zrefu7y3XABdXwIaVirgszuIqUN/b/XzL5htnZiF/bND1yBw
 BenyvNdYIddQy+Cmc/JhX9t5zQkjcJt9fGeyCWvGIHKI5AIHwzcoH5HMyyXvEIWTIOCCZ
 chdLuE62Th0DfYYAxkr0X0K5OkM+5YUJxwNPPaUNryetMaAOGDAp9hLNojfwOMGyr6VBR
 M/k5FoVaq5vSfUwZEGtstse9qRtAfcoJleJuYmLWYO0h55GSgbDAU6PREADewbJLYPPpy
 qF8aHn+D/Vftl1rTe7du59IeWGuOawEGrKvTPEbRRPH67Tvkvk7TxSBphcgSKvbaaCQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=XiF8EFam; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=XiF8EFam
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD66840735
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:31 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 86BEB1A13AC;
 Thu, 29 Oct 2026 17:36:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5666C6076A;
 Thu, 29 Oct 2026 17:36:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A8F1810329122; Thu, 29 Oct 2026 18:36:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793295383; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=G8xQIYW8mmS7IsMRdYQcBl4TqSIsZeCoLUgehIdpxoU=;
 b=XiF8EFamJDSALoWhW87SZb7NRnd3hWBBB5CAPiJ0pijkztbcAWOf5h6A0/q8SAsT8KGQKz
 lPGVbxm9dUZBk31ennGA4pU8xAHD/u8G20EjIfnmaNNrjHBk8spAgWUS+Ll8RgeGpndg5W
 DVaJFtyH40VWQ3wS3uFOpf///7MSkcBHuRkQPf6qibM/X5AzOwI4FPl54M7VRWSQVRKtci
 fdiUPRjgi02/g50ZIhUGu1IybMZMEzAbBEYuMqhcNoh7FCVuhM4NoYSuEr7uZVUvBLVal8
 1ffxvG4V67TovXbjq7zfIW/SSOha4Rpf6AEiOqmDT+lHBVHN9EeVxnllwMKUCg==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 29 Oct 2026 18:35:30 +0100
Subject: [PATCH v6 7/9] binman: test: add a helper to mock the cst bintool
 run_cmd()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-imx93-secureboot-v6-7-27b9c987e25f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=3wJgJfQIqpjg0XuFlbRxPYFSOsbN2JtFdajWeFI67Tw=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBq44Pt5PfWuRPAqqfEhwJFCZX2GhfaO7ZwAj4Uz
 f97TVc0AkGJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCauOD7QAKCRArAF6gG1qP
 A0zwD/4gSpH2IIyhL3Ltw9W/betPtw7i4NAVAfddnhs4wx+GffZ50xN9SxDkoUumwVYWrBtXSk2
 DBAWaNJ/5uIqMs4E19uk8xSe1vdAsREnJrY4XaqS6VnN1Ba+VCZ/DnUryuw/j+ScMR+XfyP9dtQ
 XVtNtmAoWqb74zAlsigySBKRGzve6cUgR88ta6dusVlEptAapf/GErlQF7k7YuQHl6JqDSwUX93
 MWx1HYLN3SI6jOdGrcwU7WWSaCCpnl6rYv83RQYuChr70fDQtC2V+soQQqWbVwj3t6/iWQFRhfO
 zhTRiAVzuGYYiNsMZa6kmQxpfU/ykf5RPTA5RBsvZmQKGGvO/h3vla6rIZy6ZBMhDIJFRQpUUOP
 e6WiOAiuqhmvnUNiaNWsS6gvC/7eDCkolQ3JZsOhFC5gIAba8VGFQrlQPHAAQBind6MtXgvaLaP
 ixv57dUUqIEW+MHt25IK/uPJMDEcB6Ft0nkNA5OQ9SVLvAkQjnrGWIrSvEnpRib0PBefA7Tpnvr
 dYbWvP1mpkMab/yqaqga47Qb1/M6YawM+5B0NUG8ntw6iD4+1faNIBhkWQXKI0OogUadrPhTWn3
 WPXQO9Wo3oG9krVsqs6iBXzM8GOhjsNVf040gBEcpo1LvY2OSPXj/YL4YsVij63SdLagsOfmXEK
 jVo2L5YKYQBYkMw==
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a _MockCstRunCmd() helper which fakes the cst invocation so that
the signing path can be tested without the real tool.

This will be used by the nxp_imx8mcst and nxp_imx93cst tests in the
following commits.

Suggested-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 tools/binman/ftest.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 5f0de4c74a7..239787345f8 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8105,6 +8105,26 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             self._DoTestFile('vendor/nxp_imx8_imagename.dts',
                              force_missing_bintools='mkimage')
 
+    def _MockCstRunCmd(self):
+        """Mock Bintool.run_cmd() so that cst writes a fake output blob
+
+        Returns:
+            unittest.mock.patch: Patcher for Bintool.run_cmd
+        """
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
+        return unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
+                                          new=fake_cst_run_cmd)
+
     def testNxpImx8mCSTSigned(self):
         """Test CST-signing-success path with mocked cst invocation"""
         ivt_data = struct.pack('<I', 0x412000d1)

-- 
2.56.0

