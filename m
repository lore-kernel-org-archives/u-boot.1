Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67197C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 330AF60625;
	Fri, 11 Sep 2026 16:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWKw5Jj3h6b9; Fri, 11 Sep 2026 16:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 672FD60635
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789144593;
	b=FqgXQ/bh3Ckwkq5TyXjTbBOQbqteDuX+kG3M2ICyY6y3ZtB8uqohpQ0o9kU0LdhGq8gB
	 IazXQmlpyyAQNIRD85sVO395glozCvdONN41BBpVvUQDgO8JZAcTej8hd5Kd8mTGt7Zyo
	 8MYCW2HfiOD7z2NOvXMeHepOMnJk2mVmkZVWNJecUW0n/KRjjDbZK0Y8pcUbcNtSR2qcr
	 VO86F4Da0FqVSkHXxSl1aDYqy+xI5RgDFiw6vqBg+SWThopx3r7Rl8pmyIaRxkmRl70mP
	 nV6WTSylH0xz4amyPo0Sz2mARyRt2TDMhndUlFx7uOosJLeYz6NMDQrRBZvGK52w6WA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789144593;
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
	b=S+5KS4ojeMQ9lbpV6fk9UC2nFmBSfoAu7gqTj+ie94b6uiCIXWXLEP/oosLbQaZ6k5fC
	 pPj889hK+nWyuGTBlAp3QUz766bctpKvul+fL1SLA+zLd8wiaw/8Il7xkSSHddoH8HYw4
	 oG1jP4MUIGB0L3BOpBx3iIdnw5rgdUVT7FgDI1q0/uxPcRiBbautJfA27tMACFCwYrMi4
	 RThTOLcsrD+uC4zpOZ6mSuXwb9z7C+ue+722eKrVIjKuzqB/cuGkrtFE3rRRi9zHvCDlL
	 LgoZudzcaSI3QCljiIRlB/G0dEG3WW04zg7ucIZhfElDA12o0877zpCe+nBCq1GfxRQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789144593;
	bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lyz+vEjoVFvIxwLuH8GqYSDB7ywTBAPSjGPTPqsRovumEUScZBH/vvDAR8JkjGF0I
	 GwcuZ9oYilIxhjmrZ33ifeZ87mx1CfW/oz4eSgZKJLvliNCHmr9xS1sPZh5i5rj+ck
	 DCs0ekLiCZIW7o9MLNXHgcp+L02ICIiFLZStBwW6vjZ2a7aJRxusjCH8tU8rqIdUAG
	 M4pr4+McTkFA6JAJAijWeN2KkQNnbQipCOOuWKoxDZln2Mt9yhe5//CLMTtJGW0hYL
	 xcysexW+UuSwVnQLlOV4P1AUgpTXdl//EGcyA2zJZaP+hPJO8waKzgGHBg4OsN26KL
	 cen862xVDPFwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 672FD60635;
	Fri, 11 Sep 2026 16:36:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE1EC72E
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B420680EF2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pjRtGML24ekX for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BFED680EA8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789144592;
 b=mGcwl5ewgt0dmVeZAIxHpsL+/+uSU9iO2JXyQ/F8Qca4q7BAvo+opRHbv/FjVjLgci9/
 bNmbxWftN4tKb/SOBILtAkluutIlOd76z0NkjHI4qEZClX9o0oWocmvirmKiSIVgUQJj1
 4RLQle2zwxrFxpQkHzT7DWzyZqGt/rM3tCaZ2UQv1UwHxs1A7DRjrEYRk90YsiW8kexn2
 gOpHQUbUX6vpCU6iKWzVuTW7RtFhELySflt7l5LZhi2HS7mArZTLScxukgaFooT0J3vZW
 S2yKmPdwnPiA+uhsNG+FB+m+liltuu/ks0yhHjqdIkfZg9lyt9S1/WH9trCo3zb38fA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789144592;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
 b=pSlKdjB80/0/2wvkI27gaBMWKwbkvQT1AxmdEYCGHBYzZ9EkuA/DXsiwbFJxIBx/oPJf
 iQUZUuPq2xZADP+ArCMLzHW/DHa78QrT5RNIN04iHD6jjvCeseGQ2Tmfrx0L8cEMSOc7L
 l3QDjf79q2jf+WmX1E7rzEPdW6AUwLoeenD/c+GmppqhArokzQymI435hjRF8xPBSjmvc
 KygwgEIwmuO7eI45V5sw6eKZxEAw/Fp58eSUu2rQzRf9q/IKGmTBTx57s8dMO4UgqUK47
 trdyRmLyl00kzGRY0i/nYkismNAmuOMNzW2gazGmeJazSNB+5AZrlZJ0zKfl8V7NfHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=bI0xY7vs; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=bI0xY7vs
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFED680EA8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:36:31 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7F08D1A0214;
 Fri, 11 Sep 2026 16:36:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 534B2601A3;
 Fri, 11 Sep 2026 16:36:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 04F7311C7A9DC; 
 Fri, 11 Sep 2026 18:36:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789144584; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
 b=bI0xY7vsRPNkdnRFPniKFHSSFRFmedYgqLnHCIYfOfrHU8xltVMqazrv+ElJ6nyNzMsrb4
 EekCOanqUAtenGtoCvZvdv9cG65sSFXNTuy0Q9HrlbkQBlZ75RN1UvYfPmQUjre0WsS9tp
 V0G83y7G77R2+CYTbvgvoGsNwOWacHmt9xa97OaR+bGfr5QUwXWaD57l6617TjayGamyW/
 6wPZk2iwqwW+XJ7wzKdfQZFwxxaSULQL0iiXDy3bQFN1EVCxr0UQ9JHHy+O0KqeDJ3LeUo
 gPV0NDC3zDTrSM/ZDr95Q0FVnlAiiu6EDwuUUqdH2g+m98EJg9e+KKGxoL9VEg==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Fri, 11 Sep 2026 18:35:07 +0200
Subject: [PATCH v3 4/7] imx93-u-boot: wrap SPL and U-Boot nodes in a CST
 node if AHAB_BOOT enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-imx93-secureboot-v3-4-542a99793af0@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=ZkEmdyR3F1pUrAFHik1ktGcW3RljQLHrC1VaN9f6v+g=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqpC3puncPDYsFDCHDFkxmsISZCXeSwi1HEU27J
 uQcSlT4Rt6JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCaqQt6QAKCRArAF6gG1qP
 A9olD/4hV1AmRqUtF2j6wcnRV/92KpJTm9eNu2aov8Pa48L9NO08+d2bSfja/GZR9TdHvkb0XOc
 GzwLwoDu+fv9LZqf53OHDpDmh97AJFjVsKR6hgd90OsLPKqOI0hUImtRlUqPAgeP/V6+hQUCxd0
 kGShZ2Nl2rmfIPE1RMl0VmgNH6+cO4i/zClOyJh1gf2qDh/9zDGcQuX2T7t8F3WzE1DNMJTl4aO
 H1s6nJ4NG877wNCqvEdz3R5KlA7IWGYGPnDn3oad+KIFiYmINUJ1IDTityg7NlS62fdN7WXPU04
 K7eu+DfMNPhoFtozs7oVLUKnYpZf1CEl0t1ZICM4FRXpBdwJCXUC0CXafNuK2sfh4FrDTPSqonl
 HHqEM4ZoXDor/3QZFpJx7O0mtjNl0eJMjFMl9ThoXLcrOMVWrYBI185MeG2DPEH3CxfYwyF03MU
 Xxgm76ebUatbaQKlY95X2VK1Hherlblzo1Jn3enAdVrg5iqyDBqzXgDH6pukjLNDKz1SadipdMA
 XQNgoFedh13oTwoP3se7THGfPMUiyPCftN8CtnNimJQi7k7ehDVvoTV4QdpifJQlfZ8XSovdAjJ
 WfjNdXBa9OM8l0f8Wex7DMtOdnzzahQMVR5navplZPN5ssf2GnIX4rr1e64yzG4Tg+az7hStTE6
 4/NqBnRJ37aeVIQ==
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

