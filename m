Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3893CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 752E340A9E;
	Thu,  1 Oct 2026 16:27:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gezApFrOARyC; Thu,  1 Oct 2026 16:27:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BCBC240AC9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790872053;
	b=Y+LDByruOWaMvqhpap8SQCpqeQ9b5lWfISFWUoOxOAR9bUYopqlpSwIuYRWUSR/3A6ZP
	 r9zhdZrBMVRnR0X+S+0f5E2oljjOjkvshtjK7kpYqArrsfFLSTaJNqPwhjYTBaGIxipXs
	 fzmum+Yogc1CRshwTsfcwJGdR+cxPzUUl6GUur8Mt46x1SQcYRJ4nmwtLIcA06E5iKoiV
	 vFnD0N9UWHwjhLanbJO1oWwskgNUgURszO1IoSt5stffjPCejqanItn+qI04Ud/dedjD9
	 ZMuvbO9PfsrRduBeGRzaD3uumsMaVsjHSPRiKUU3wm06RvsiTAFxcGweN8JjEer0J/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790872053;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Tjev5AdC99zs4Wjw6FekkdRhnx4LR6uhV7Y1p5vq7AY=;
	b=BUQ6P3Y1193eXYVYuPo5ATu5cFQOYev0R/oNPaxIn5bEbix6sQ7dNO+FcGHKiB1Xvdiu
	 fyVUrz9zOaX6kVLLTWLHqMAKxiLtIGU4iwgngk59hqjzoxwkbIFIJtXi5oBVfmQho87Pv
	 Kr3kQDjzCUPa/C3vvaNBSondg5LtpHxIbu7UvMUPIRhJZRzmRC96nk9fTaAh7V2iDBxvg
	 EK6J2Y+ovsJjnXWckgaHHnqZcpwRCmpk5+NU13okBGVkc9rf4eUklHnCucOmV7q6ccC+I
	 Qhpfk3zyaWX7LhHEBHv5/DXN3iu3mBFnEgN5VEY9HVq6W3as6JDRV8ZnqORgNmO2gag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790872053;
	bh=Tjev5AdC99zs4Wjw6FekkdRhnx4LR6uhV7Y1p5vq7AY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=siHmR0HP03Cfrh2ayUnitEsy+xlF6dULs0X2p862ihgxQ6D3NkDs80RcZwZn0BFAx
	 Hgrl17XxevVGr05ARHgLnoJx3Nvcp1cNvOqbGuu0U0OCW07lhB5YGifOwdCacp+Zu0
	 6Ej+iFY9e4E7DgCzUfiFieHFG0I6Ebt8bqP0b1H2bKuaoPwMwkGmE58mEvuj633rew
	 DXuY1OeqFv28+vhvFcareGOxLWt8UDaPcl9o48f/zgPAxMQvdYZt6qrWqndMDi8EyZ
	 l1soydxMy30p3wYKu6DM9lnJbXj+woy9Yyw8ZUnGsjDHcOTJXpuLk7a5xtHAoaivMu
	 vvO2kIWPtmb8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCBC240AC9;
	Thu,  1 Oct 2026 16:27:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ABBA73D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 920C240185
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4SUX1Npg5x-P for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A769D40098
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790872052;
 b=QBz5/juK0Mt+NydaRhM4zNpuNFW3Ryf9hdHXt5ynFRoseUhVvYkPq40hTBzEOQOIfbsW
 4Z5fRFYz8D423qvVs7nTHOlFq/IjZF97Gdak95bzWPemMVpDMgjxWUkrWrp3+5PU5pbiV
 x/4XVGgoFbrPEVFdL2Bs9AlIT2HCHRKaqOqykmVRR9nBR9LHONtoFVR/lFLOD0WPcCURM
 IegYjqMv0JPbCF3DkLrPpZe+Io0WugT8SvqsiP1P06i5Ei0SNFbzjZijBWZvbdG310qIR
 VID0jAmaIpJV5KeaM09ouJUEnA5l19Ruunv7mJTqH1HiKaYAWdIgX01iprhYtslrXVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790872052;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=Tjev5AdC99zs4Wjw6FekkdRhnx4LR6uhV7Y1p5vq7AY=;
 b=D2HQM8bPxz33bP8eCHNVqe9tWX3UlqSdCvhxgaQhgwCC90wWvtyxc0VDobKqn9C5cJ+o
 FS8JaBNqwe2xGYiR1wWKrs4fYvs7icWrZ81ieqoOIxfLlasRaam1LjKQVndrMEoIm14OV
 VR5F1q6VKTmF+nuwfKsmi+1y3W7aTAyJ68l+JGH/sxqR4qQniFKB4uxsjNQXiXQ36m/xp
 MziOh2V6ntGY7lrdFR/B260gcNlL/xJHaHuYxFAQWR1+pWw6h/874QvRcQhHnm0eBGAdJ
 xQo8NF88m2nclPRW+6KL4Wv9oalk9OgtCLJzlS/BPGNhBG3ZPy2hzUhH0UYeycJLkCQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="k5hD/Q67"; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=k5hD/Q67
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A769D40098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:31 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id C14921A18C6;
 Thu,  1 Oct 2026 16:27:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8E1E160343;
 Thu,  1 Oct 2026 16:27:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4328D10328318; 
 Thu,  1 Oct 2026 18:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790872044; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Tjev5AdC99zs4Wjw6FekkdRhnx4LR6uhV7Y1p5vq7AY=;
 b=k5hD/Q67arfoanyKvIAl7hcQJkaOlPQ7ZooFaf6vH+caYqhFJxYu/rRa3f7k+pyRMZZKMF
 2AVo46gHmN6tl82F7GiFufhHd5TJkT9hkumwq9qaWtTVlhzsDQnCZqrnTzGjIKX9rcCyF/
 h9YaVT0/3qOAU1S2L+245k42P1kIwVuukJWfZHNbQGm55Df0iTt/hg3KMteHqoCc49Uajf
 qA2d4FGifsjl/3Yd6goR4iRu+27oyc9ZuFVRlWPZR7H6LfkZhWZz/EnKw072dm9tfsqsBb
 3O5afZKo86c4Gucv1iEKCpNpLEeAMQG3tHq4utPai3vqjxXrpYptWwgfl3CU6Q==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 01 Oct 2026 18:26:25 +0200
Subject: [PATCH v5 8/9] binman: test: use the cst mock helper in
 testNxpImx8mCSTSigned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-imx93-secureboot-v5-8-d97dea41bd1f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=Yzv9jViDv0JVkEUOXc88WgaX2JuOn8aGNId13XrA5FQ=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvom4dzVmlO+19+I0WytfjM+WZCVoSq8PMKvZR
 koHjxO8cW6JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar6JuAAKCRArAF6gG1qP
 AyljEACNugfkbAe3T8zi7kVWyOcfa7RF6iUNf6P1dnxLNh/OtRtC/lX/warCXRkJlzrsePDxdhF
 TMODAL8HZ/Jzo/EARj5qskiX3dYMacMBPWoxFsob08ldupEJ15TMQiUPj0nZHqyzEVmRMyd8Xkl
 CodtcswBsCG2nSj3aETDGKu14C0c/uGQHbo3UmlofNprz3CUtY2VzvZXT6ZKVIBqeTZVryKSn8z
 5FWPuH/AT8nmhQ6mcyx7mZztPLlMp2AKNuRUXqc4iNLh12y63j43FDe7eUoFJfXT1JSfEdWFx9X
 zQPvtMKxZRpyfxvuQGGmPRDZAbQ0MVrb/Poh3933bpNVahklFEFV0XyGcLA3YuDwxTWIR5s3+Np
 FmuimH9jCVZ5mGjjwzKeKPpn2J26djJogt8G2jo198JTRhCEfQjQuA3EroPf5v52luPXyttcA5c
 nRHlAEJodOmbi5zouhMkvUuVawS0FdpEQAGcSSKX9X0l8v2l5vgIlS49iNUfHVs9q8iYI2Ci5yU
 VggrS3bjtOIxZmaEmE+JL1TFxWuYROiHamCupMEr2JWiWAvYaR4mVOf0SM0izLDkfsfjLyNplkN
 6Ec9ARjCleFnC7gazQQ7TOunEwMpyfVQ1fI/tQa3DyWPjpKS5WFcvwzyltNwiCSBR9hT4tHdc5n
 8x7GA2Z8rDSyvnA==
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

