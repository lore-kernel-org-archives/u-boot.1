Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19811606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SiD0u2Fw;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=b0NaVHn4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED39160A72;
	Thu, 29 Oct 2026 17:36:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jO8BwmcOFQkq; Thu, 29 Oct 2026 17:36:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E1CF60A78
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295402;
	b=mumeAWR1jlQ/vF5p0/StOrILc0N61EyvkZdJ3yDwlzsi3wuED3qw77bISivvJRuTOAN+
	 irkSt0UGbdTeAWi4w+ajVXNk/6VafNTt+A2BTGGq/01ohGQU0QgTt+ChiIlTYAa+8X9Sj
	 ya3fle+C36E2KvBoIZSzYF+fsLKHGqmAlazCNBOWTQMYBhEC5xkxju+GjQN1crX0+GfcE
	 f3AgalNrLFfegfZnq26XmJ/NDMfiAP9vE9i1ZbogVnLMWcypHZOmGj8GlPfF28Wc8BSN8
	 qSy/wZdfuyLZ6ipBLcBMOxunu2BTDJIOTEhZGfIIR/aFXdPAWbOsJlAHQjdfhnOvwGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7y12txNZdNPMlRyjPz4biDHGJiyjNtFuMeQCkg+SxcU=;
	b=QXEhiVCTQSuetWQ4aXx2UwdS6K/BSFPeAG5cVSFWXorGdvP9GqCxoM3xAuE/GOKj+HvY
	 4qnIXZ93xBHj6zzqqSYCXLaQPkVbaQCMpmS/F8BNfcZVQdYtHcCCvCVA93JzPxa6extc0
	 SB8wU5KnlUTue2Yh/S2vSrXwKRHnOMMbYRdU0Ucd8swKEFmRrmgfCiLfB53+8ENBXA3ND
	 TCiCBk1HHsSlPLzmCuUFHEqGv6pDKJgqyht5gwwgydQdUEwl3iOVnm1NLDNsJRvzNLHYE
	 zuapV0oyn5KoLpRfydxeQVbW15JVdb6onJbS2kAjzRVq9gmLxswuVjR8HABFMIpAc4w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=b0NaVHn4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295402;
	bh=7y12txNZdNPMlRyjPz4biDHGJiyjNtFuMeQCkg+SxcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SiD0u2Fw5Nu7/sZYvheVAFer53gkTzAyl8Dyx4OG5eQLbZVyppF8yhxLLOfem5H5a
	 QmU5lUgpaQEzpe84YD97BAso5JTnzXbMdHN7dRqr982U2c5gwsNOW4D4CbDp5UHFwc
	 2VdpneP8owvf17/aCuJaocUOrBGQ62haZpD959ZerdAofyBXKMOGWCgLWSdhqLmTaY
	 mvmHy56S9jFPAp2a0p8AuS758TDpaJfRvsfQ5H2ImbHURdr3vdPrahqAjV7eBWoZEW
	 jqOLuZyBIF4nDPp7VTluq9WSG8imHioCbD/5gHp7bwSQDwibbiWixPW9pzyWCNzwBV
	 yMl5iq4kUkYCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E1CF60A78;
	Thu, 29 Oct 2026 17:36:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C26F92E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 968CE60A78
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qx9yocpBccv4 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:36:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB16960A72
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295400;
 b=LMtmLHn7j/tDxU4vaAJDbhj2OjCxeZqU0Yq1ZrhOxxSBXRtApEiB0ki3vY7gYj9BUgTP
 YbDpA/sCkcvzQfm7IrAqZmY8vrT0xXSPSfw/MBI66h4VZkXKDSN9IiTXL5VugMNk+b0fQ
 cnZnoryrTmaNBoTUS1sGOh4DfzmzwWJ1eOs8Bk1h4xHjXQbJHEc/n+GAbwmB+lpBA06v5
 04rqy5ZbYnbLaMVPaQMjI6thSysZjsMT2PO/hKFaRJbxAFXyh2unj955r1ykcB9GLynCX
 8ZE70ZFYia29obBxJlp6ssDZM6w0q3gXqwPpr6Hqq7B54ERurtd/lHxF9wHtVRS5uKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295400;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=7y12txNZdNPMlRyjPz4biDHGJiyjNtFuMeQCkg+SxcU=;
 b=tMqJNFC+rixqn4QoX9LCdEvn3DCrod0OAFAoHcCBQ+nOud/C74X7T0DSo7b4lyQDDG3y
 Gdh6DxhokSo0sVOjdRKPjAYEUErGrqso58RGTiWxLERLLJHQFVKJWlB8GTwnV+Q6RGlKP
 RI02Wj1QTN1YnXtIKfC1fVxdIBa/Bi5IZ5cFMhJxxngZ5oUD4aTjaYy7qYZ4KZP7P76sx
 pnHwRysxZOnGhtXxgG7Hb5yjYmU1xU0HZ1ckPE1Nwg+jxLhQog93Kxym2WY4TNRdjVWoK
 g7uhpxO2C1egOKPvpcxkuMlBeTcG8OWZ9dF/ZRXKm5LVg8UZHzCsD6F28cE8jA68oQg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=b0NaVHn4; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=b0NaVHn4
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB16960A72
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A5C201A13AC;
 Thu, 29 Oct 2026 17:36:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 796FD6076A;
 Thu, 29 Oct 2026 17:36:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 673E1103290DC; Thu, 29 Oct 2026 18:36:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793295391; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7y12txNZdNPMlRyjPz4biDHGJiyjNtFuMeQCkg+SxcU=;
 b=b0NaVHn4wp3gKlmuDrvagnrVliIQN5r+3asv586KzLlODo8weQPMXmrm3TgGVHHsw6anCu
 vfHmPb94T1b6JzihPIRIgTZxQw/zMkwEkg5ZlMOxOhpaAlr3q5Rnzu1CZm5qSzBKN9D11U
 bw+0kSiqpOEst/EMClm8pzKSsrRGpgngzZExKM0Q841zCIUhC2dlssvue6UJUnDV1ipt1S
 IIm5jFPmP7iG/m5tx5YCtD+6mwWR2KJgzt8hb8cRoLCn7d64fAWu6zE30H5RKZcjiK46RG
 DOwnHB16QRIJBE2sDvmpPPyV9Zqco6vornRxexGEB7XYEG1kUqx71VAAbEr2dw==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 29 Oct 2026 18:35:31 +0100
Subject: [PATCH v6 8/9] binman: test: use the cst mock helper in
 testNxpImx8mCSTSigned
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-imx93-secureboot-v6-8-27b9c987e25f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=qUM29zuLKc4SoKurEGw+WJvVlCvbkn1ZCZZFmZjK5Z8=;
 b=kA0DAAoBKwBeoBtajwMByyZiAGrjg+2iGoojOoUAUtb8q6x0G8cIESMSe6GcH3OggQCx5erlR
 IkCMwQAAQoAHRYhBPsUrZCG27hCkEgECSsAXqAbWo8DBQJq44PtAAoJECsAXqAbWo8DZo4P/3TF
 +9LI8hg3f+B0i9zXBQxTntxOaZWgZPuJkfo6e1BvFXWJjbg6dqYlXmqSevClaRMgNxkfHzSG/QR
 Vtn4NFk+r4+b0BKSM4Dc58Qjxi3Im1kbA7vsZapwnH7uULnWJ7UDCThitjIlNssjw0tO1zXEsju
 M//u4b3r+frRinEpfoP3CkOi73/6dmroIdD7IFOjmhLx0uZvUrU8BO/wxHiKda7Jpozx/IFtXOe
 HSzEukz8tt6XHBX6mTplyZKGzbvazMDG+tGOkIW5M0fMjCeUwtHq+iPSSZds3ukowlw/PecFGHX
 bImzyfjP3RUObb5y65soPl8rRX7Sq+KKSf2XUN1Ai2Hw42F4hx0e0FyR+53smNhWtSAn5xiPBJk
 q6FZBkQ/3mt8ea9gBLLCoat1P3agv8qxfcVZjX491yRCCJlj5bJMhaNK4YxRV3+7hm5nV4dJSPB
 NFeidZZQWfGIVnFFS2Jzno3yBkM9ZbDmNPVuikZbXqLAmuwJsAepmrBXo1q0KprlZa+67h1t0na
 tOReuNTdQmcc6hI3iPRVwLWRPLloTiW4xBOJuS3K3edjiiaiDH8Oy7IPortpFLC4uAHm0ldWt9j
 iO7OHvwjDIyP4SecWACz0Z3vohUt00GIzk+9wPaj0w7cRjZpqcJ9leHpvK//tzVibiqxuCNCFIc
 5Gxnf
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
2.56.0

