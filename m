Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F866C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 17:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5A9B60869;
	Fri, 14 Aug 2026 17:08:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uM_rYpkVchAN; Fri, 14 Aug 2026 17:08:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79F0E6080C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786727281;
	bh=jzxzWTYz/BQWS0EqVJt3kHCOAAm0WNfV/Z9NpAa3MH4=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GfwIUXM2fZ1ZiamhJgerpv4lPAKbY7YCrgdKj+/Rk2+RbleMUJpV3ER89FYOIXnsJ
	 v2GRzmBajEfttqrxpDnAXGBXtAeN65SYAUFARO04HynN6VoirFtjITTTSfOmjJuyX6
	 kZEvTGqvFF0l88Lw03z7S0XcE+H3Y0/R/bIn13PDsGni/C7nnVZ6k46neHkfnVwJfl
	 tsyajLPt1Uv1vG6BSeLgy20bRjbFl34Z9ww0KfnF7GK5fB6DWR8IZfWTfJKp8q438A
	 xVGKo5F2E+jX6kxG57eAF8IrHm3PwPJVMP8AWn4N5NmMroDUN4IgZgWszDljJ0r45Z
	 R1t3C3N0PQBig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79F0E6080C;
	Fri, 14 Aug 2026 17:08:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96F9F2B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D5F940CE2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:08:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RRWVuPO53Kek for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 17:07:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6BD0440CF7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BD0440CF7
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BD0440CF7
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:07:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5C75A1A1646;
 Fri, 14 Aug 2026 17:07:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 311926046D;
 Fri, 14 Aug 2026 17:07:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 091D111C4EF27; 
 Fri, 14 Aug 2026 19:07:49 +0200 (CEST)
Date: Fri, 14 Aug 2026 19:07:11 +0200
Subject: [PATCH 2/5] imx93-u-boot: wrap SPL and U-Boot nodes in a CST node
 if AHAB_BOOT enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260814-imx93-secureboot-v1-2-0c3c78020d03@bootlin.com>
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
In-Reply-To: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Denis Mukhin <dmukhin@ford.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Alice Guo <alice.guo@nxp.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex.vasut@mailbox.org>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=9krdnVphrtRBSJJTlAQoXxnxbnNTXV/YSlB9Zz/OS4Q=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqf0tU74A0GGKc3UQw1uytEoKBob7ZS/0Xstexs
 VCQyxwA9laJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCan9LVAAKCRArAF6gG1qP
 A0d4D/43Emg6Ur/nC6ioL3N+ilIQZicO/XG/D1MUHQg0n37UctJfUwbsShApffczj5UwXDMoysj
 LYWYJmDXd6L+yJfNZfzNZH6bNfvbsk3WFPN9tLxXOP3dQtDSQ++Qru7HXdNhYLyLBCdm5fJvRw2
 GEbZKFdEhm037D6tdl10P4CsIN5DZQ4mu6TqpRgkQebSQ9m99r+5Yag6fgY470UhxI/uD2vTUB2
 1ff676LOt7PPXhYfk5MwvIP7KdIlPcb4Oy/XvM4gmcj1hRjkWNM0mp3Bwcyuu2x46La46GCaU6b
 uF3ZQX+WuIHTl7WQhGEO0VSjPkOkX2SahBGmZvgOo5j/c5uggc1BKr8OiTOItKjxJtv2QV08lKW
 I3yGgBtNpaI7hjc3gy7mGP/XUF6+wNxw3XRaPzGok75N71iaOjOJDK/PytBHMPpkdREt9rt5BRE
 DfzYI3sWJ5hVJYhUjdN03SguvlzpEpVF4oAsqDzNsi8XnfUvt/rcP6MIx//55W99BdALcoBgJJX
 Yfp0A/EEWdU2d/SMvN9po8PgSIlE6n8Llt6gPBTdu4d9bqbpfcR2bMJZVgAZqHgyhlLIGzpaB4h
 43YEKboemU693VMPyrKaZrxMXOujveqr4ochk23kIvkqJaBjbPCiwHMhd2iqBxF5yYAqMRyK/dY
 iMYg2uR6GjpyInQ==
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29_via_U-Bo?=
 =?utf-8?q?ot?= <u-boot@lists.u-boot-project.org>
Reply-To: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

In case CONFIG_AHAB_BOOT is enabled, extend the binman image description
for the i.MX93 platform with a CST wrapper node. This way, if
CONFIG_AHAB_BOOT is enabled, binman will be automatically used to sign SPL
and U-Boot containers.

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

