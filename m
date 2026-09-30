Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82457CA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A7D640AA2;
	Wed, 30 Sep 2026 13:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ss5KE_e_U0UC; Wed, 30 Sep 2026 13:43:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8894740A20
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790775835;
	b=Zgb7AcvDnV0sglvUmpdmGxya9oFIurb2jQuVIEIZ8QW0MzWAmnH+63MaNtSI7YQ7yfnz
	 XHp5TpfRMsuovxrYirnKBY/H8o84n5Ymg7c0oTeVC211YCLc3Ec0wfQL75pXZRLWMd3OK
	 C38I9bKOaUb2ycqBGDyYLsk5yFocmxwI/1dhaw+MenRkq1BYLI57Q+mrget5YrTdHYvUW
	 biQzYFKc5M707eTAV3Sqb6C0sBQ5uUxia8xVTZzjuDRSMJ70eA/fre67f/H6Z6E6e10X7
	 JIX+0mu/twKIQkENecW/L0Due5JaDENq2y7RHPcXIDGKORZp2AX5vKdWakVfNY0KoZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790775835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7afraESNXGSGg0TB0qWCH7X6S3XyVx4154JTRsFdaVE=;
	b=sSvy7H1qG886NjiIHn2PIvyMuh57U9ukwEOV5+iRGGOSkF+AHSkqnwJ/Vn24nElPnhwD
	 0NFkJo8sdsa4W4QMWp6+5LbU17wej2iWTuCcVTguLg9igmEzBE4NcPUxJ6bGwFK4Bsf4e
	 awI0IeQ0i7nuPPxcDfyaUAVs/KHTuZmy4lj48QBraEQKGq9bIMJOZE0vzjmV94eSW1EAN
	 Qz+Et4kNpbYDEs+0/aPg5D85JHOjt2rtisBMSrYqLG2Z0T5Em8D5gPL43u7umYlXjAcJQ
	 BG56HO3s7LOYRIHs++J9Zr5Qcv2DF5L8c0Z03l+Zvo7AlLGivnqad0ndIocjQcGQEGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790775835;
	bh=7afraESNXGSGg0TB0qWCH7X6S3XyVx4154JTRsFdaVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OZqMEyOkTOL7tz6r4Q3FSRplXB9itvAeHCAdzh/9d1ArEx2MX7ao3gn93q0BqnjHc
	 xG5fdZXWgWxJOEZgUjdEtcJLey313T5ya6aMnjP7FBTCWCMYUj6cHqwYPga7OevV5g
	 1QMHYfRussuqAt0nU48T2nSvI0VTCId3vKo7vGgOixVfywvM9hj9iSgzDKMIT+ZEuj
	 aazP8WB1lvOKGBaKKKdzkHC9B6Ov2gaTc4bvq58E0Mp/l9Hj86IvHLjIOc1Sdw2D9Q
	 Y5jzIuB+4LWMVsjb1UKzL/r16fz9Bp0puvfEFwpI780tsHLLAnCCgcBCBkAulaTwST
	 dTPG1kiiz4mNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8894740A20;
	Wed, 30 Sep 2026 13:43:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DB2514C2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C112460B39
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qN9NQZTMvJPM for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 13:43:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0E60F60845
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790775833;
 b=fVwp+SVaTYqlIL/cwNlWOBK2pSRPlx2z4KNiOJz2Z3W7qrfgHJ8WTZ5AiJi/gthZMS4X
 afvgFyE6bN5pSo/yWCbdVplHA/9IEn1jPnT86YIoWrIc3kK8xAGd0fXrpPCvtO2h52eW5
 W31Gcd7I9MFHZCnjQm91+HnGmhTh2f6bi30pw+ZtFfOAN1ijHKsFS4G0bOTNCVLnE/kQz
 +6EZloNndgi52vUKo8VLvvarDIOvMckZ0h4EqE7ZcmLDCF0B2UCECLscV2GgozDdckWjl
 pDhp9WmH6ps3x034iE8bVsevQ6FU8qZeSheLhhYRGEvhC98u7U/z8SA0kuAKkLH5z7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790775833;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=7afraESNXGSGg0TB0qWCH7X6S3XyVx4154JTRsFdaVE=;
 b=eGoEe74EHlUkN14w6ABfxggaso6eXTA+tY7zXXdvPS9R5NhajkGfCqip0GUvFRqYRHi/
 tVJu8i+dIgKZxq/KykF5ux1KPOa5n0v2WZkbIqiDKb52Gt4pvfojZ3QLJJTVZajx6i0nQ
 0o+ivTQQT6XG6vRAySnftiDi320cPN+XPPoIhFogXU3IkHC57ApBfl7Ujk/ocvl3hMwoU
 FuCCwCFaPBIDfep8AlgNbur2xvH0YszBTMdAb0S7U8f9zlxnCEbXMJce0Gb+zmqy1+0pM
 /xoiPzXhxgsmTX0w0G9Jy7GPLJkHsTfFh5qtWbkftSMtMRBLngbYq0r1CCW6HcWPBlQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=rogHnqhK; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=rogHnqhK
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E60F60845
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 34E314E410D6;
 Wed, 30 Sep 2026 13:43:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 074EB60749;
 Wed, 30 Sep 2026 13:43:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E6AD31032828E; 
 Wed, 30 Sep 2026 15:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790775824; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7afraESNXGSGg0TB0qWCH7X6S3XyVx4154JTRsFdaVE=;
 b=rogHnqhKcvHiknpOeVD+p0JEFOO7L4v3cYQTz8G3WIr257dc2t/cMl/2HQSDAUHY+oSbpJ
 merRpf8r5DbQh1+VdLIYTPoWsw+dnTBsV4T0tHoQO3dtEE8V932/yMoIZFSAkYqY5Fzr5s
 ySStDzCU1UyBn2DjhW5lOTVkQ3RHBNerfaV/kLh6N8ftD6vFZdYu4T+dwBVQ5YNd18zysW
 7tqtRb+rvef97j0y87l7E1jRVM2pgJW8qEnmepfZFLvOVH2nI+WhW86R9iZ8xTf2A14YI3
 xxclDj6XCqQsokF1yiETZdcgnPdIQ45uCqZPnDrdDxStSLhBPGMpyNEbIgwV9A==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 30 Sep 2026 15:42:41 +0200
Subject: [PATCH v4 8/9] binman: test: use the cst mock helper in
 testNxpImx8mCSTSigned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-imx93-secureboot-v4-8-f968a1b14dc5@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=JeXhZf4ZT78K4sqC6p25qLlG6DC9nUghRNDk7/o5yVw=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvRHZhBvK3jqCkyYZFhgXRVFoRFIvUVydDQbeu
 KrJu75oo+mJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar0R2QAKCRArAF6gG1qP
 A1zVD/4kcDU7tZCY7MYIkYuZlX/isvocS2vX+LfZr1478vq2GsC7FPdA341g/TZTODddFMmu0dK
 8s/XLSmxBxmNBuDstlRpLvb2oKM6TAt/4CajGdj5ZIMezVQv+cEJ4Fb0gFILpGEGrd89JAfVW1y
 q80FqP0g/Mv00BSEGihtPlBLijV6ST2eCxYWE8wLzfCstsdshn+g68HD5iPjc6mZ0RoVoT4iFU2
 x9ynHRRX7fxY3nRbVvrGPNAMpHStvrfVEy6QKM2r+1ahJ+OlJd9CANgWKOTun4VvDbO69A/uhc8
 fuMaDeVZwDz71lYzJRYjgPsVxAx+sTPV+YbsLTxFc0ffpw58UxUe+TpL3agxWaZogSXd0007c2+
 PkcaolflnUlp/dtn1iOydQd1XllDgr1/ae0QZ3tHbGNmVBWUolxYwO2wuSmcDgoGDzq6KmZYL6G
 lVda+VNav3CGXrwWQ2HDcqijshuKlLsB83gZO9nMRy0ue1mDRMeG63WUXrCirFmYn/1xKI88xv6
 R5NmSEDe/O8amt9NynRmWTrprkh5It0RrfhLmW59Tc033vtkPChjfzbvR4HUV5+8kMmr6KLg7Kc
 yRF2WY0s2lPWzS+kN9ATOU5GLFyMMTIgA1HvRCXKxUPPgtpEE8tLMe4uq7opuDI0t+wR89oc9BS
 1BCSlfZGPG71Ryw==
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

Use the _MockCstRunCmd() helper instead of the inline fake cst
run_cmd() mock in testNxpImx8mCSTSigned(). No functional change.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 tools/binman/ftest.py | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 239787345f8..783836045cb 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8133,21 +8133,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         ivt_data += b'\x00' * 36
         self._MakeInputFile('imx8m-ivt.bin', ivt_data)
 
-        # Mock run_cmd() so that when cst is invoked, it creates a fake output
-        # blob and returns success, thus covering the signing path
-        original = bintool.Bintool.run_cmd
-
-        def fake_cst_run_cmd(self_tool, *args, binary=False):
-            if self_tool.name == 'cst':
-                arg_list = list(args)
-                if '-o' in arg_list:
-                    idx = arg_list.index('-o')
-                    tools.write_file(arg_list[idx + 1], b'\x00' * 32)
-                return 'fake cst output'
-            return original(self_tool, *args, binary=binary)
-
-        with unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
-                                        new=fake_cst_run_cmd):
+        with self._MockCstRunCmd():
             self._DoTestFile('vendor/nxp_imx8_csf.dts')
 
     def testNxpImx8mCSTBintool(self):

-- 
2.55.0

