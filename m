Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBE2CA5FD6
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96B7380934;
	Thu,  1 Oct 2026 16:27:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IqaI3HFUPBxw; Thu,  1 Oct 2026 16:27:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E36B68097A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790872048;
	b=MBCoAy9/2Abl7fUfR5Ju6J+i6FBbP+zQENpKh1ePunRlLRZtoSv3FtWSsNpR9u9TziqF
	 eJ9s6/F6VTe+VZAbT38Ovq4W7CE8Y4pWM7+q5W1EXcnjnGmwhhimylwbVe4xACRKlzadY
	 wnMBmzr2kDy86S0vRA5LujpzJakiltB8IcaEC+xGyqEkU+kBKbr+GcNWQURFRebeKZirL
	 Ftr3EAACili0m8QMyA7kfJ8IQkjpKzHFT3og4FWDjZUrIDonA67uTfYqpXk3PcaePQVBu
	 IFcOcCOxYtjv4ZjM14FAcVBm5OZp9ZmtopBF4bIYEfxCX/zVgXCf0yZEkHT3EjtlKWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790872048;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6odRWV7S6G/GH72ImGqORGWyH7wrLnQ053D/fRgKGvc=;
	b=fWOkBTLSfRRldhrn3Dvg7pRdzQ033QJ5NpNMe/+sBvczWqaprJdtWknzWdHveJa2E4Yd
	 lCn6pxUKlepSfyDpa5MTJWCTYPOQ5r+Gnl96Y1bBxQvUB5WaYmFixy9A3BD6Cnj/kIEhd
	 petnRFX+5GrQBoL4J/Mavmb7svrr9uVPBi+1E8ON1Afru5dHGWJSA/9KHVqTgBxlLSRZH
	 9kuMF7WuoZYSdCFqDCZ8bmqQFZY9HqE/efSIm3g5oTHyASMfhxo4uQ27+ZqaC9wdzFNv7
	 inW/nhCgaHRz03e4FYGizT5E11TPhjkKFOZMe3IQ6eawnv64xNGmnkk+fNSkxgbe+Lw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790872048;
	bh=6odRWV7S6G/GH72ImGqORGWyH7wrLnQ053D/fRgKGvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yA4/LlrZ1+/BVzhXolOURhVufigTso5Vun5hd1ZAqwXyb4bwM1VJ9uJjRejzkJgK3
	 sWQ+x2OizM4xOwzufoIAhoPGivGFvXqRlseb+G9QRCn27cJLVCYaNEDeYkCTMux7ta
	 AyfOHgW4TnoAMWW9khvYT1ktiHlu+M9XyAvahUi/7AGCyOGWcbG8oBKK/yR6IPYiv3
	 BQopZi95cwOgWnbLZwiUiwc8kDYQCS7I6iacExD9XVc1dSD0AdmV2iykoqep9rk0dT
	 i1QD/G2ufz+ldlwm31rmMU1lHZ3G+UAZU1UeOejyKmw0uLj/N1PalwAA3fjqfO/u0h
	 z9FStSraQO79w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E36B68097A;
	Thu,  1 Oct 2026 16:27:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B64BE3D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D0E340098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OqmQKThewwpW for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:27:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6E95940185
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790872044;
 b=q0zcW8E2hHXE+OWIE0wJdTrRtolv/jhD0AiLfwV+d0XUV+8em0CtnAMS3drNACkbilSW
 YPfkRJR7jCRwsnyPNghTbTb1wpGau/5sLWhWgBTBDl9BDNXPbjmyHA2UxLBsvF+6YI28C
 43BQepHYwsoV+nwqsDrpeRETDa0DDLQyUrqNf5zUqv8frgX2vS1ncwVH0sNglOZivUhUN
 37Mh9Fx8Xm283UqRNRPYymVhVsf7MDIt32eQqxghBshEyR/sTdeGrzi5+f6gjP3NOzSYc
 SAFcpcHLC0KuKd5yjUe8Y73A+uVptYuUZpG3YC2+SzEunJeu+fwOUcgEirCrh132iUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790872044;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=6odRWV7S6G/GH72ImGqORGWyH7wrLnQ053D/fRgKGvc=;
 b=mo8lOM+a9OYbFupvZSWY6/XUbKPT5LXSRRriVosCrT7BUpk1ITH05IpyWKU9uePfZYoA
 OgEryrgZd3ugklHxOzECPOvTI4d8Mjf2Tbn0b51tPaWaw6FeDmG9A/BRRoyZ/0Ley7cb4
 g8EG1zkvwYiNFVYgFD5ZOXqpt0GLGgkF6gBlWllQWCPs4JVFloEP5St4T4pzg/rSuXYxK
 K0SDeiECi0kDlKS0xaB3ANlBNYTDKqrExT2tFlDRfamJ77A2CWewIDv+qpWEvho39L45c
 D/v2q0/U9e4//+2UVYkrMtFW4L8fNPNbIZLHc28NFLlnkzLJH6n77tXGxJhoWAwMrtQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="YN/NgG4X"; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=YN/NgG4X
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E95940185
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id AAD3C4E4208F;
 Thu,  1 Oct 2026 16:27:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6FC5160343;
 Thu,  1 Oct 2026 16:27:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 966DE10328340; 
 Thu,  1 Oct 2026 18:27:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790872036; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6odRWV7S6G/GH72ImGqORGWyH7wrLnQ053D/fRgKGvc=;
 b=YN/NgG4X19KzP/SanXynqtloFyS27Sfck5x8+5t2pwW9LgyhcgZ9xlgRAiVAScd4H4brkB
 W8u2swm29tX9MDvOGF5SSvLrDnqflTVTTN5K1h8MPMlZbAZianY6z198rUUuhaN0EOxtpb
 rUGue604cazIN3IWJjNMdmO9MCtg7kV81YD3LXQAf1tpsO1/bXX0dxyCN28dFuJjF/GnN+
 W8FQxJKVyJM64h/L5tS5615TWUXrJDlLBqrMafinqX5KSW0wM1/CUcJp4HhJYPY1mKIMvU
 5u7cEFQKjDEzshgSUuiw8x2NaxI3Sd4gnAubhTu5ce6uocekSkLj5wJ/RsXUFQ==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 01 Oct 2026 18:26:24 +0200
Subject: [PATCH v5 7/9] binman: test: add a helper to mock the cst bintool
 run_cmd()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-imx93-secureboot-v5-7-d97dea41bd1f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=qabcXs6aGq3aYfevG7Cja9lId0v3Q3w7IxHhDAyldxM=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvom4Hk8agBECY/FACJlW2JcW4kCE0C86YTgCz
 i3xuvvq2FCJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar6JuAAKCRArAF6gG1qP
 Aw8DEACN9IodS7P9yYLs+XeWtqvKD3kDEP741VGY828WlRn1Nhzr57yQzyiNbXaf1+5CiLnnFHy
 KO8jHgPtCfnmfdjx3BLLwgZijC0s18r/BAIkiHIJDMZT2jvXt2//VsRJYCcEl3da3MBbCkoXT+v
 QRST9f0DS+nB7Tj1wBOxJHIL5DkUILxvaqKtOBt+2TS+83gkD+2q4QH1rR6BPIO33vAhlQP0UWC
 WoD4gI6iI6OIMnanuR1HE5C9CPex0lceQUy+vzCN+xYKHWFv0YRavM2v7E7ClJhIdQpvjALREXs
 EezOcyV7YuHLbLibMlDHlcCSycs9ym1W1W7iu65YOvQiXyE0kZAhEec6x25o07CX/zVEYVpt11W
 6lEPojnek/QezuJFiicioqT9InGXISbJqL1eNwYmTpvTVef9fEZL5g6ire96R+U1eURZPkr6JJX
 jtJYr+4aArILxx8EsLYUlOPlPrvQ1ZvdaYYQVz+02fs6R8xXPilfaSmQ06TtoBBQrUeCgKkVFTZ
 ArvGzR7G1Y0pj/DuBg4qAfXxDEpkqB7QRL3Gpf3uH4fv3iHCyOfNgQsPBoblJXdkSv1HQacLxh5
 4k8ANXkhXZxN9yuJ0Fb+gBwaI5O/eZcmGKiNM2JAMWA68XsN/hM2S/AR4gjHzmhyr/br3pw/qGJ
 nv9tbTOSANkK7cw==
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
2.55.0

