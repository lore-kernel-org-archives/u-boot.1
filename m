Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968C9CA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 626DC60B67;
	Wed, 30 Sep 2026 13:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WUSjxGlL1Ucn; Wed, 30 Sep 2026 13:43:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E3BD360B61
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790775828;
	b=Fs2PVIqyPVkeYFgitu3ZOnTHk2y/hZ0aB4ItPrQxNO0MUZhkpIpUxkh/8L811ORwdtTk
	 jLKS20FGIEHAPxae6rlx37NyPkGmy0VzCZRoNXeHzkEb0RPpaTbkN+jCtsojwUft5HV/y
	 q/TD5ftLeKVdK+xSgipW+i38EWAh2FCaxFxIuE/5fFSp5St92Za0lStA9PN2/q8NgG7oD
	 TnGnQJKPgLKljhm7+r22effj6QAqJDD7dDFQTHcRgBxqHiyH82ZNF/Uh/8sL94JC6L5NR
	 8PREmwi/xKH0+9xNVuDgj32fk+KPEUmIIwPWKsxZFRtLcNGLxZN/yLPI+Kv1b522z5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790775828;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6fBhenKJMJHws7DPP8e1dSouJmvFNTVDzKaXR3jNZUw=;
	b=ABAJ54FEi6MTljrb0cPKq+JE9wd0qfpaLcrBDLEVvqy1NAWj8i6OYRSQVJmdlJLyCmgb
	 /EyGSiX/MCQhaaw4RIpybissFO18pZXh0SkkK2SjY41YzLvGZ5o7r2hla3kzwr0gyN9T1
	 tg8o2FChI7yFnAB/RMzgvK4PeXgup9sSbApgwtuYPJA0zhv3Cz1yk+raIq6c45MmV+Kiw
	 jwuXheKpjGLYDl7WHDDto+mTRCqJp91//bVwikMVyaoIOANmi7/MbtX0gPeUp06I9tHYk
	 wBmDBNIGuLgagh5UcnT6zm318Xfo967HvFGrqdZG7R3Blezd8wIb/2TV4muV9UMQXZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790775828;
	bh=6fBhenKJMJHws7DPP8e1dSouJmvFNTVDzKaXR3jNZUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1karStBDPTlCWP6ICKBUC4wUqNScBDWhEEUjcKw10Yn7ho5W/IQE7ph+7vsjCVxc
	 PGB69++7bgAriS4uGMnLAelVcyGfIBBaBOFiiR6p1a1zaI66fBBHbyzklTjZqcrsyT
	 36M+d3BRydfWNIOeBoQZBm4Lf/SmDYhweDRAul3UjscFZSqxDPdI0qY7En2XBRGYje
	 7NU9lit1+Tb/qR5ji12oVYgt9yU9gtuii8xTsBSQPB3sSAhBwy0JVZIrt3L1NxVKC4
	 6WHnjFrC8acfq3IkxoDz77/sczPuj4ZmVG/VxLnQlCUzxUuyvbinws4vgGLucLbiU1
	 hzGjqInDR/6Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3BD360B61;
	Wed, 30 Sep 2026 13:43:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ECC4380
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C93240AA3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 41jJBUu4KZoJ for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 13:43:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B63DE40A6C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790775825;
 b=ohkz2pwiQFVuRsUGGDts2Hz+hSwqV9+p1Qz5tgoE1bhH3yLSdjNSxVzvhn3fz195u51f
 /BJvPDloIXaORB1GnsbC+A3YX4jm0D5XVYZz5LmdpLCl62FeJSpgjYJz2k+6HgF1PHMTw
 bbfrkrJZ4jE1m+YyDjX3AL2PuYOsUVWoG5qeFYJULhV8zEcLlIfvKghH4Pi+6DR1LnyeT
 YM1bPhYbA0PbjC//5PhMLJEMW2ZKRcoInv4tIfN8NdKPLp1U1QxhW8F8B3nUG3xm0GBRM
 gGwdDaNgdNuxyIJEeQAXwWSVTkz56zwr19gd7Qp2sjU1fGWzHvM1lsw7Ros6VEEwQ5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790775825;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=6fBhenKJMJHws7DPP8e1dSouJmvFNTVDzKaXR3jNZUw=;
 b=sRMuy4IRdE1p2GLWhkie84UeQK5tsQgCkiR5xZ9MlEhOo6oxP/8ZSUMZ0M2tqZtnX7fe
 PJbojvu/hLNAOcDECpy/6ce03DexBqCwBNjzUofTliprG9SsHri0va3OboTQw1UNAF2wd
 fC+GqypbbO+/NtwmeB9L4K5pDEval9ItpD7rflu7NHDnRw0jxgA2nEZuW7n3lqqd0bBS2
 IxTl7Ug1DF8+zLzPk/92pOKfSFaPkAKG8X9FDvN9Q0qcMYEB2expb8jxFEpAvSDBL/K+b
 QxEezfgRxt1cKBMou8Ci4ihmo9h2ILxIDHVKjt60pExvXhduoopFScAqkMJmXqtM2vg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=gZqF4BAv; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=gZqF4BAv
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B63DE40A6C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E146B1A1078;
 Wed, 30 Sep 2026 13:43:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AD3B660749;
 Wed, 30 Sep 2026 13:43:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B0F20103298D6; 
 Wed, 30 Sep 2026 15:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790775817; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6fBhenKJMJHws7DPP8e1dSouJmvFNTVDzKaXR3jNZUw=;
 b=gZqF4BAv4jJI29JYPDpEocU0MNmJi8KtX6jOeZHR9f9Iq1HABdIxdocNyB8yoOG7fPxBoL
 k/xihZR7r+XZ3L2HD+I2TAFW+lE6Yi1RGJrXQZaEh0TJJ5MCYfON692CU2+dWT3Jlnt0T+
 yV8GWle38aSEmYItJv+xf6nOa2R8/lQqsp+NWShfPgEPliXr396rV0G9jF1dCHLHbaFr6S
 S+Ywy+/H8UsN3OblfkkJooMhllnpnyXlKRJYAR2WEEZNuypnvTfWiRijrcvgruHLNG3mve
 tIrUI2B8WTo6cr0pawjGDvV3eLig5mRIRCxxLj9SZ7t3AHsV0FF1E9geLbpwxw==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 30 Sep 2026 15:42:40 +0200
Subject: [PATCH v4 7/9] binman: test: add a helper to mock the cst bintool
 run_cmd()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-imx93-secureboot-v4-7-f968a1b14dc5@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=H5Ng0+IJnBRLiHFTyIOc3SYjDPy57E7yaTjvg0J7p+M=;
 b=kA0DAAoBKwBeoBtajwMByyZiAGq9EdnIG6lwGWqtDrivnfz/w8CVAEWC3Zgk7+e/ntXJGwTkD
 IkCMwQAAQoAHRYhBPsUrZCG27hCkEgECSsAXqAbWo8DBQJqvRHZAAoJECsAXqAbWo8DxoMP/0tC
 sKeeGw1MZD697u+7MU/gFt/w4knsqWbrqEvnuWGDJ3CCuSm0HXAo9p6CFdvD/Sbsp7Nv9JVsIly
 IMtc389kZ+4zN8rHGu339t86EuMxMugPkv6iP6+vRR5V18b4l8LIY1g3tUH5qJ4wLGzbDUVj2ld
 hjxmAFf5NUlR6rOEGDA8s0yxltDF9NUnPyAuCgF7I4VZjEwfuRqQy9p9inQF0M9EAxvbNagO4d7
 5nd20aYca3F1qaKgxJryJmTlHPNTl0tt9SPd8I6E5QSKfqH4tySVzrvJIQt1UHw/mkwavenZbZZ
 velAvhqPNsH5INfQDJyuPidWAKnyyp6cgzmfoNc9BOT9tanhjE6+tx5Gd2UN3y7ls8l1DZXgVYp
 M8WFMHF7CCVEdfbOVhr66G73StIuQT0qau28uAJy4viUhwi3rQkaipJ4TuaIO1m3K6uz274h1mw
 sA3K0dHzcUp9WKMk82XK4jtxIeJjehPPJdfGml+5glpVHC3QoWNsdinm17vcs4ErfrL2Ax6Gtls
 HURGdlkpsM28WQXNvQO0ORc3yyn0dzvHEeED58RfKGDPGwS514r/JOzVrsx7GY9lkxbotcALZLm
 4GWT3FRbY97Y9ZKHc3mLMi/8JfNDpXOMUwXxa8gjqUoUChxI3tz8n2n6jZk6tNcVCHcRsYALQG0
 qG3+h
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

