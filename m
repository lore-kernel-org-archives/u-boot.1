Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC96606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MrqcDfnX;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sEejetzy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79AC981094;
	Thu, 29 Oct 2026 17:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVqbmCM6J_is; Thu, 29 Oct 2026 17:36:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A097D8108A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295376;
	b=H1b3J83+MZcYTTgm73cRJJVGiHS/J26uzwhwpiHkZpwql7H+GWhqXuv75gGV+AZC8Kqb
	 ZEyi4wHsQTI188xLnE8WwO700K4KxBscBecQNip2aITDv1jrdlLvZpHIB2CFPszJGXdgl
	 f37WI6p2Cj7t/raAU7lYemkugGLFrSzyJpJ5BopkDKKnTNj6wPnwkKqd6lsBUATGQxZj9
	 SefTfJU+UyQag7k3lY9zEcMJsq1b8zY5NvsKztOWPexsCrxUhdHPISFSqjaYaYVpY55kF
	 U+3YVRAxhZRXQ1HT8Pmdj4W2nXwmYHN0s5ya1Cjc0q+DQ+g0r9ABnyHkgJBU8GfmmsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xme47hTUhtCA4lrW4l6kPrJ7LS+lVvpJju+/xLqp8G0=;
	b=V1KDfkPSaDR90dVuBLwB9Yt6FbgUbjosHsioxDvaBI0NdwxA2tBo1IdPB60qvBv2kD2k
	 bmuMCPibPkh8M3H+TvEdSlrYMAty6eNzEpaMEZcTgoyU84WmHbjMDQMgE+yCor0L66ibE
	 jKk6ipUGi394hdMRMpx3EV1uk3EAZN9g4ltnp2ckY+nIRJ/N/XGs+VNTcRcw5F+zD1u29
	 DV/od2XkYL+ex+fiKYzt+eIMTqYKOhAKLfJrtM9JroNwj7nwYyt2cRSlGUrbKjET0HMg0
	 RdmqUSTTAB8qzQ571ehGJquZgkSbOG6+AArSLBFvmRc8/PJk+nIUDBd7jKRq9KE2cVw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295376;
	bh=xme47hTUhtCA4lrW4l6kPrJ7LS+lVvpJju+/xLqp8G0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MrqcDfnXsUFDyN+0gPfsn2QHVRCaEfzOg2lMQ8CIbEQTwMFFDodq8D6P9m+3vrAp7
	 hfP/wLJZR3Dcxl/N+HFiEnS2SMyMo7YwkfwNcnNc3yk060551s+yAKypZQ5Y0oNy0w
	 8I1z9LP63Y0cTJU0K+aVyVWiMaijvfB66GX8eNTuOEz4Z8KyMgGs44erwQhUxjtSkF
	 9XeesFacQBSGQ7Fb3mkOPfDu5pmv/errKBSKztRBfi2PFAl09DBYHYRJwGbhaSSC5S
	 jpvm/bV8udRF6aJG329rjuVIrL9MVnGKk1tNrH7Poj+dUosn62QWdPbn+1PiIqg2Rm
	 kHgMqDt7/98KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A097D8108A;
	Thu, 29 Oct 2026 17:36:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 26BCB3A7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C45E60A77
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsM4_gVmCGY1 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:36:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4EDAD60A71
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295375;
 b=P0nvAPny8fjAtwCVaIukkeNnWMlEl2yUZiA/mLPB1UBW6OkWUhgnZrEYpx/Q9IefdGMU
 qgXUWeOb/Uir7fD6g86zaQZyzr91Op4VJlI4PxLR4LjoOVw8oUeJPN+GQr4+9VCUBaS4e
 ByZVUaOW0tBt3awQBRp72BN/T9+f4TGvNVohTU9DRupnxF6QL9dPIk8ulY9soSm3Ec9fo
 Ms0nx35q6uBFmT2VFCN8FgzxFzpsYvwmYfgREe3ea4vR5DE2p2MlN9JC18XdEFUaerOpA
 EnpsdOQzTR44r/iSlmPJLq3a5XnDAXzoRy6gUhGBe+MiitfpNsMPW7ivKSUXgU07M9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295375;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=xme47hTUhtCA4lrW4l6kPrJ7LS+lVvpJju+/xLqp8G0=;
 b=iLJSWH1wx0YwygID4loITyJEy/d5E+/4ptLHGd8zlLyKq/u3vs5Ty3RE6nEagyhvAD8J
 xQlwPDOGThIw0nY0EfuAZy9Rgs0QIOaXMs+jOY/RI1fNXgPG0glkC//XhN04Ch1qCHtn4
 w/1wDOyrUuWdOltKiuxxIyQYhdBZRv492sW19m+vVTDwK7LKzjltzeYzl4Jh78bc5Gwls
 QCnaeqj+s1i4Of3KsNreFiqmaRBvWRCflMWAHG3cRyD6SZmDopnK5DTPO1xDdoUEklTAo
 eTyse45gNKkahlEzGBD1iYs5HaHJxhUe+mwWDTSTYtKsRrIGG2mXCYd8XJZF2ZUWgIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=sEejetzy; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=sEejetzy
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EDAD60A71
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:36:14 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 95FFB4E4139D;
 Thu, 29 Oct 2026 17:36:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 100A96076A;
 Thu, 29 Oct 2026 17:36:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8196E10328F94; Thu, 29 Oct 2026 18:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793295361; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xme47hTUhtCA4lrW4l6kPrJ7LS+lVvpJju+/xLqp8G0=;
 b=sEejetzyPSiSsJlRfPoNTubNgimi1UqEWeH1bocva4ijLA5EfflGv7WQSO7d2eJ8sxjZNk
 +MRt+yaMNLf6m7bbPHO5HeKqz43kKo7vTMKlEks28DIc3ScO/IuaefjYnq7jtzHR9ez9Vv
 yfFcdWUXMwukvuDvAOWXpwlljYew8WNFOYCIqQfdyEPQ2zmzzlWKpEnwjGCvDE4eBxkd6e
 KT/OpyjTzER6nD/ZqRFxdZz5e7sF1C02z4RUdWuvfiqrBQHuHc/V58PyQW3LgdM5CYQLi6
 bST3RqYVEUIpu20+CO5hl3HGFb2s8/hEt87tNeRmMQd4kn9onbQnENHuwohxSw==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 29 Oct 2026 18:35:27 +0100
Subject: [PATCH v6 4/9] imx93-u-boot: wrap SPL and U-Boot nodes in a CST
 node if AHAB_BOOT enabled
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-imx93-secureboot-v6-4-27b9c987e25f@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=LafQzl7B2n5aM1aCkoWDItq8vtRiZg9EKsySP9YW7TI=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBq44PsRILUngDjyJWdBX+veOJdk42F0+GjU5zLh
 +aOK5g8tCCJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCauOD7AAKCRArAF6gG1qP
 A+zmD/4mAyUR3dmARGMv0A/vrsdgXjbuoV95rk5VvO4U2BxYA1h9dV865enk8y9Epd9b9ZWngYL
 z9CSK1ruEEAvS7sKDI1+ZEsmAOdSjEJMeSaGF3lN1BJ1FS9PcF/+1U7tWnIyAyB87b+j/EpMvRE
 BU8vHhnZyv38L/kFyDp9uphanz1vHHCR8Hr+j+X2PblT9nR1BgNFFR2fjlpDoH2eAkXFCRZjKzi
 os+LY2lKYXQU2FD36RmkaOsvHFhlBKhsJOdrlKYXFT2GxVw+Qea0SO7QzcI8jiPt7NgvG16lcbn
 sqvQvhKUGGb1T4KKvSZy0LU8V3yJ+zYmPWSpkKu5Kgg51Zs8SAdpNd06o6qu5dL78b6EQBv29pa
 Nl23lBRmSveeTAWodGV0+Uuynu/tAIk0L6Yz79JQvddDyG7c/bVH8LBKjdr0YSe1BmNueGWgB/+
 hlAEJ5w9oSIFHrExlseNqQ9r+/Tvz7rGa9SiGwmE/JUXuw8zrATXq2pqvfNM+l4B1cve/8juwzz
 0axdxFDqAy+QIQ9MTqOmLSKia7ijAknaoJ76MiQqjDkoNEgFV7SPJf2YOx7sx4EkCqPADGXZFp9
 6kvU/dtYuzJYSg0E2sWbK345aQO77zYbXG6M1yoPhYcQZs18GkbKZOv4EhWINjS5nlzbj9y4QfD
 sFcnHYwArj+eJ/A==
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
2.56.0

