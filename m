Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACCDF9D0ED
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 18:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B834B8421D;
	Tue, 14 Apr 2026 20:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=kd-solutions.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kd-solutions.pl header.i=@kd-solutions.pl header.b="UX/C8Bpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00764841CD; Tue, 14 Apr 2026 17:59:58 +0200 (CEST)
Received: from mail-d13.seohost-mail.eu (mail-d13.seohost-mail.eu
 [153.92.25.142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D08E283693
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 17:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kd-solutions.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof@kd-solutions.pl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kd-solutions.pl; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8GLg1fHDAN+of8bqXDBdmu/6hc5dkIhZMb8ZKYW87Os=; b=UX/C8Bpwp4+CLgMO44GmHb5BtY
 K0dqDJgAfuWLAG8Y1DToK+PE2w+QjBjnlWNMnSeZja9M4Vf0IdvTTc0QEgWNakBJD2hnzVNoScr4i
 VGOIBo2ck7aVuWeBEiuPXBOBnEoxgUdw2zVCcM5dwL3ORLhuPcKNPa5YxXIBvAho/51YYOMViFSqu
 YxjWt3mXYYPOaty5tkbHfxriIlZ14rn1LkNlQN42hPgJdWAciGOdVOikoyFXvvigZ1HGMVEHDbt5S
 aHszos0JpUV8tTY2IHiyFY1wrbxJtvpI5G8Y10Al0tXL6j4yFqHvbLAfwm6Cbm9a2ZW+2GIfLAdqr
 BvMkyHew==;
Received: from [77.236.6.67]
 (helo=krzysztof-drobinski-HP-EliteBook-660-16-inch-G11-Notebook-PC.lan)
 by h74.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <krzysztof@kd-solutions.pl>)
 id 1wCgBA-0000000CzA8-0ev4; Tue, 14 Apr 2026 17:59:56 +0200
From: =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
To: u-boot@lists.denx.de
Cc: sbabic@nabladev.com, festevam@gmail.com, trini@konsulko.com,
 jeremie.dautheribes@bootlin.com, krzysztof@kd-solutions.pl
Subject: [PATCH] imx93: Add support for OPTEE
Date: Tue, 14 Apr 2026 17:59:28 +0200
Message-ID: <20260414155928.1391211-1-krzysztof@kd-solutions.pl>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: krzysztof@kd-solutions.pl
X-Mailman-Approved-At: Tue, 14 Apr 2026 20:11:54 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

OPTEE-OS starts correctly when "opteed" is enabled for Secure Payload
Dispatcher in TF-A (tested on OP-TEE version: 4.9.0), however imx93
devices require a patch for OPTEE targets because binman does not see
the tee.bin file when it is available.

Enable conditional OPTEE support for imx93 devices.

Signed-off-by: Krzysztof Drobiński <krzysztof@kd-solutions.pl>
---
 arch/arm/dts/imx93-u-boot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index dc86746ac90..60648bd10a5 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -69,6 +69,9 @@
 				container;
 				image0 = "a55", "bl31.bin", "0x204E0000";
 				image1 = "a55", "u-boot.bin", "0x80200000";
+#if defined(CONFIG_OPTEE)
+				image2 = "a55", "tee.bin", "0x96000000";
+#endif
 			};
 		};
 	};
-- 
2.51.0

