Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E753CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00D7848F0;
	Wed, 10 Jun 2026 16:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="sANsWOkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B508489F; Wed, 10 Jun 2026 16:17:25 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F01848F0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3F8264E42DF5;
 Wed, 10 Jun 2026 14:17:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 11B4D60012;
 Wed, 10 Jun 2026 14:17:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9B48F106B9A43; 
 Wed, 10 Jun 2026 16:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781101040; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=kUWABbmmco89Tp8pjFiK/4+M3PLoRPDi9hXlq/0D7e8=;
 b=sANsWOkmpsSueVA4x+0Ni93pc/zFxGeCrmncI7PnZ8lgXmLFIZIKvn+h/a0YVlvmozUTNx
 03x7JZXeRCCPZ+iR+lA4c3jRf9aFE6RX96DvfAzC0IMpPTZwiE/IF5EIygbpBfwNA/wCYx
 JROFwUAaGR60j4feF1HJNDEVA3jPTeKo6/1Htz9zAux9EjfgJun+YH5ZSvKLSSNey5m2gX
 e/PVqcWSIDXlS1Eu8UK1FZvf+ODBaIlxsqPEuq5UfMRT2QekfTxaBKDA01S2U5WdDnarqa
 Khe7jQJEGHZD34rCFKAH2+z3qna347Xy/hNCDgUrWf7syDO4aJgjdTIQ5oWyBg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 10 Jun 2026 16:17:10 +0200
Subject: [PATCH v2 2/2] imx93: Add support for OPTEE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-mathieu-optee-fix-v2-2-197aee94b7ad@bootlin.com>
References: <20260610-mathieu-optee-fix-v2-0-197aee94b7ad@bootlin.com>
In-Reply-To: <20260610-mathieu-optee-fix-v2-0-197aee94b7ad@bootlin.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781101032; l=978;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=pGd0zukWtlfQdJAsHFZl/yitDfMNe2w1X7rJNjCtKg4=;
 b=k9v3Y+FiaJY6NKh+7thsb6aHKDR56X5v7srzU/ccOvvf16U+SijN1C+Q1oti8PsssMPa65R/1
 2eie9qq7eZ4BNLk7OxEzUsRhI7gE3prSidvhs3M98BDg2ZluNPucUAG
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
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

From: Krzysztof Drobiński <krzysztof@kd-solutions.pl>

OPTEE-OS starts correctly when "opteed" is enabled for Secure Payload
Dispatcher in TF-A (tested on OP-TEE version: 4.9.0), however imx93
devices require a patch for OPTEE targets because binman does not see
the tee.bin file when it is available.

Enable conditional OPTEE support for imx93 devices.

Signed-off-by: Krzysztof Drobiński <krzysztof@kd-solutions.pl>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 arch/arm/dts/imx93-u-boot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index dc86746ac909..60648bd10a5c 100644
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
2.47.3

