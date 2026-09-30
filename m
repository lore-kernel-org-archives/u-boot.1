Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19A5CA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC44560B1B;
	Wed, 30 Sep 2026 13:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RBf-HMcBJBqo; Wed, 30 Sep 2026 13:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E1B3560B5F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790775809;
	b=Kz+amg6DF3f/Dy8rgQDMPxo/NS7WjoE4g0cIVTAPqesrgxeq5LLsywkNFo/K2sAOoC5D
	 De1CgwvA0ljBFSKnSCfX1zHxRQVY0zKSFFgmR4yAMc8EXz1C3PHpAs5xP4JB5Uy4c8GUY
	 hbFGvHBKZtnigm0f1Pg4uOXLLPNSY+68PWYRPzsIuMOoek6rc8tAs4JACnnoNZpmLoyma
	 YnJRcVW6TSQY/p2DjMrRH45Z3VVQQn/NZK+0WqcMcJ2s3JCu9B3h5jE3hiwd0ewc8LzK8
	 I7ICF4ag7yIXOipgNvhL0l9BsMzxmFieNVnsH5r+cDzvAF2zddW44wvnJ9Wfa0PrVtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790775809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
	b=f8yPbJtjWmIrkDPwAQdstJDhHLEtIea4k/M0YhPa0IHI+gOAVZQWJ+DUm2QT7rHZXdEY
	 Ts5tOnBgSYO0/H3PWMUy8M/fdNKMlW2NNWkIJIK5tY8+PmWDedmK/o4MVGsRv6yFfBkdW
	 TWXQu5HJQXkX2K5MXiIQ5cwkYDBgxO11BsSxno/hbyI4EwWiVUXab2zUJz4c62t3Efe/F
	 3ziIJbpBQSu7MjXYtPvaAt54fE+omOyFaDs/mVa/7if5oQZASE3RvFNa89H9LAI1H44SW
	 2p2kikGgUyJCa9jLrhv8oQzsKwxloqpJFn3YEd7r9yFDUGdWM94xiGHdcE463KqcxaQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790775809;
	bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nSpuDyL7FQ7WpXsG+NmoPtXc3/vZn5mgvtpPfzvYzSH0Tvg8peZxzZlwpZEOG60CW
	 Oeb2rkccNleSr7ryjeJFOLPnMLbXKiX5a/BrRlU1zNOUI9GBwqz9ndiAPHbnQUbmYe
	 yEL05K6d4Kn2CyR1eiXcU0XgwrMXyOVGM3wwvCrWJ8deIrFQ0T/IIgcwmoyTkcwe9k
	 ITxslTsNvC5HE+Yqq4KPEIzZsebZuj6FUi+FdORqW2wwGG347YNr0ucYvy4b2QWXlI
	 CzqRDBbq/C9S6b05+liZxHsFQ9if9pQZw95j/4euALdqy8i7xWwkauN+3r5oaZAofi
	 DGdiawHHkWWbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1B3560B5F;
	Wed, 30 Sep 2026 13:43:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BA9A132A
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B862F40A18
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xiN2QDlzuk64 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 13:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F38F5408CB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790775807;
 b=JaQJK56LQTU7xvCQHdRuhQ/w2qOqUx6Vz2xjgQfOkHXkwSOlYDgZacZpPWtGydU/x1KW
 kF1/x5y182J91mrgXLzLKCqRPCGk9dS6TJVPYzqoXPuDGgyW9VyLhxAry+eHZ7D/wRO9b
 FVgZU2i6uOQxykzxHhxMH/k3TwQwe5gctR3Y0EDX95QeEcub2XRc4+EBJl369N84nL+PS
 630nkpLIDmTHzclpLjiwfWE4XBXk1Px9Fo1qIKfd4YA51uVbLmGVt6JqJ+ZtgjwMwgD72
 /qboxw0mbIZ7TA5Zbk4qyVm+OZMFCx1nQSvm+Y5ojbhxXnbSA++SglTFTg553PslzOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790775807;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
 b=bBKXyFgGN1CZZQiP3lRvbOEL/XlUEfxTrUOwhoqhX5BVFiZlYnIrmZfCLlxc4+USy3Pb
 JiBAA4Qnt+PapdEjv0FdRPbAeuzdfi0jC5wiuy9LSlgeVyy2mxLzl9cPYqCpVysKNxVlt
 XCqtY1O8q/tHxNyssIL7PDFktMLfkhzcRFmpKgwVVpNdyk3fPBrQUadGvGma9fQ11XVRL
 1bxQcOYX3J01UYKwzyEM/b8bCaZgVsgwg+gpnumOHaG9eMTV2SlRlbbKaP0LjUx6IIesW
 wYP7ngKwWIxeQh/Ds7BwHZ8vMImV37gpFSm2+aFjW0RuIiHT1GTENeOagllkohesbEQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=2CEfuqo3; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=2CEfuqo3
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F38F5408CB
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9A1784E410D5;
 Wed, 30 Sep 2026 13:43:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6CCD660749;
 Wed, 30 Sep 2026 13:43:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DC566103298CB; 
 Wed, 30 Sep 2026 15:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790775802; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
 b=2CEfuqo30PrFIBtxgrFuTn1KPgyRPa0ISWBQ1Ed8ldgT/lyE698MQE4rABzaIXgHsV+xbU
 GaWeEfIxIwL2163jKLbA1pF0FY5TyH7FUT2RdIaoNAzngWjZh/0wrKM7zW1ERRGIsvuVc+
 SbisTL4fekOOILgyO4EDa2Gb9UYsrG6pUimLCLOqp8wSVuKxIhABpP/gz4+5kxtGtyWjew
 tAxTnbVuK5DqOdDfEZcES+oAQaghlDgKrLUGlptcKYNDoLbZdzUvvwlHTOOR0Z0mUejVol
 V7/9+NotURdYL/nExckMIO2M5ThPYDUCRu1j+fEqd6sCuWkFb4OsZqrhc3MxcA==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Wed, 30 Sep 2026 15:42:37 +0200
Subject: [PATCH v4 4/9] imx93-u-boot: wrap SPL and U-Boot nodes in a CST
 node if AHAB_BOOT enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-imx93-secureboot-v4-4-f968a1b14dc5@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=ZkEmdyR3F1pUrAFHik1ktGcW3RljQLHrC1VaN9f6v+g=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvRHZdNSYTk8zcY9C9Et6JtQfLDGIBR1XytIex
 9/JU02wNleJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar0R2QAKCRArAF6gG1qP
 AwBNEAC3lbBWP2yB80KsScupPPbXU2D4O9c5H1eD1Mr890i7ziy1BChV/DssKT/dMaF9r+Ci9v7
 bK3KWtUCGumAMhX/HnaJMQXnMa1drNzLQNshrql5wF5HIFf4ngzjgQEoVUUSE8x5Twt0ixMzMnW
 KfAnt7EU8Ml8IL4P6BTTjd+i4e2jclSVZMiDBGiX9/IdC2ae6guItBN2vQpdobkj6Agbt3icMrE
 mALRWmgyDeF/0RToX5h9UfQyphcOjjKLeg3LR2PXGcODEK0Ow+gzELphXV9LwEbtXdY90n1HY/x
 BkKm27A9V+35dySRGkYXbgFiu03xRz3QsDeomcia+tYpYJO7zj6aqjmk6jFabLxj1yOXFwC5Y2A
 1u1g/OiSuK3DJCE5ExbbaR4+dyRS93fZb7itxG7Y0InLxF9mw6orYt3oBcc3H28m852auQuVOFZ
 qmCjVgZSti86q9+uprWAxVly1o/WzyDTfoQQ/5oJaJpOpz6wrl8vg6G/iTLIEV6QnVqDMS66XSg
 I9izS2fMMm/vyQ/nhll1uyFnuBUFozJF3UhaNq6ZJxzW5xQfjvCN+/aMFJ2UJEEL0iPywhXyGG9
 dzK2W4tDk0Z4335IeiQO5Fy/RrzrHwcxyKORDrQ09JLlUDOkS5ls9O3ttPeAFS+zoF5wAccKQ/W
 RhEn+4mlDYcwpSg==
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

When CONFIG_AHAB_BOOT is enabled, wrap the SPL and U-Boot binman nodes in
a CST node so that binman signs them automatically.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 arch/arm/dts/imx93-u-boot.dtsi | 54 +++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index bd970c955cf..569b3ef5d9c 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -47,32 +47,48 @@
 			filename = "flash.bin";
 			pad-byte = <0x00>;
 
-			spl {
-				type = "nxp-imx9image";
-				cfg-path = "spl/u-boot-spl.cfgout";
+#ifdef CONFIG_AHAB_BOOT
+			nxp-imx93cst@0 {
+				filename = "spl.signed.bin";
 				args;
-
-				boot-from = "sd";
-				soc-type = "IMX9";
-				append = "mx93a1-ahab-container.img";
-				container;
-				image = "a55", "u-boot-spl-ddr.bin", "0x2049A000";
+#endif
+				spl {
+					type = "nxp-imx9image";
+					cfg-path = "spl/u-boot-spl.cfgout";
+					args;
+
+					boot-from = "sd";
+					soc-type = "IMX9";
+					append = "mx93a1-ahab-container.img";
+					container;
+					image = "a55", "u-boot-spl-ddr.bin", "0x2049A000";
+				};
+#ifdef CONFIG_AHAB_BOOT
 			};
+#endif
 
-			u-boot {
-				type = "nxp-imx9image";
-				cfg-path = "u-boot-container.cfgout";
+#ifdef CONFIG_AHAB_BOOT
+			nxp-imx93cst@1 {
+				filename = "u-boot-container.signed.bin";
 				args;
-
-				boot-from = "sd";
-				soc-type = "IMX9";
-				container;
-				image0 = "a55", "bl31.bin", "0x204E0000";
-				image1 = "a55", "u-boot.bin", "0x80200000";
+#endif
+				u-boot {
+					type = "nxp-imx9image";
+					cfg-path = "u-boot-container.cfgout";
+					args;
+
+					boot-from = "sd";
+					soc-type = "IMX9";
+					container;
+					image0 = "a55", "bl31.bin", "0x204E0000";
+					image1 = "a55", "u-boot.bin", "0x80200000";
 #if defined(CONFIG_OPTEE)
-				image2 = "a55", "tee.bin", "0x96000000";
+					image2 = "a55", "tee.bin", "0x96000000";
 #endif
+				};
+#ifdef CONFIG_AHAB_BOOT
 			};
+#endif
 		};
 	};
 };

-- 
2.55.0

