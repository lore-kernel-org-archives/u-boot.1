Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D099CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7B986B16;
	Sun, 17 Sep 2023 16:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KoCRtJdG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yO6J9IFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7011A86308; Sun, 17 Sep 2023 16:13:56 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A562786AC0
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpVKG39grz9sQ8
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5PVZYxBiHoO3WBnD5Sw+0CTxOwvocVVkJ+oRT2GgMc=;
 b=KoCRtJdG53N7R9YQ35p/pzbxGFBp79JMFdBCf265rfXi8jPUhy961VudmgCsZ3tEAo2rpW
 rga4wmYtvO06r8l6rCAnGKkUntgdr8AD4MQPyUP27IOtTbK7+p6yUj3mX/40Clb7OFtzPV
 fqi5TkZkOg9LOmbpZ5H9nm2ij5DxAqqFfV2kvHkQrHFHUNR15dTwBeeg5oceCSObBglg7m
 F97cueuCV+92d49ixynRrsGPSHuPUMLJjpx/iwopObVHTEzNJaHSjmjIwQ7QAAT+/GJop2
 L5zAFyWgIUNg4YT7crI7IW53s4Q/KnBKyTXTeL27hLgs+a9lt1ocSLLLKBhHqw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5PVZYxBiHoO3WBnD5Sw+0CTxOwvocVVkJ+oRT2GgMc=;
 b=yO6J9IFuTSgSnZjSNxDj5a1rlB2srXd5gAbA2ofjJVFvZ/QFJSpyqXVhUOJyJHnfHMAoRU
 vNs8NNKOsFKaY4qI2v5hwrLsfjggEvZnNTgb5HsFHTz30HES/A30zAWYFNx2iF5hrwOogQ
 vEWPDz6xB2TP/JlaKLCXIzKHqZTPEqJLywidn7RBov+9p36vlBtOGlgcBbZHeJuptYIRB6
 bjxoUUk7jQX5m287vbRgLHHLIrZnogKRqD6Ix0yarIUH2qE57+FKPbYYjyMhHJNrwvX4iL
 Gsw4Ypsw3i8t1rexOL1YsdwDaSN4mekNORvMfNGkn1pee1xKxsTdv9YI4RCEwQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 02/19] ARM: dts: renesas: Synchronize R-Car R8A7791 M2-W and
 R8A7793 M2-N DTs with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:02 +0200
Message-Id: <20230917141319.379939-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cgzrrbp48447hfirs6qeqd4xojf16tbo
X-MBO-RS-ID: 3a7f661f1e822daba35
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

Synchronize R-Car R8A7791 M2-W and R8A7793 M2-N DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a7791.dtsi | 4 ++--
 arch/arm/dts/r8a7793.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/r8a7791.dtsi b/arch/arm/dts/r8a7791.dtsi
index d8f91d9f42a..b9d34147628 100644
--- a/arch/arm/dts/r8a7791.dtsi
+++ b/arch/arm/dts/r8a7791.dtsi
@@ -1223,7 +1223,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
@@ -1365,7 +1365,7 @@
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi1: ssi-1 {
-					 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x03>, <&audma1 0x04>,
 					       <&audma0 0x49>, <&audma1 0x4a>;
 					dma-names = "rx", "tx", "rxu", "txu";
diff --git a/arch/arm/dts/r8a7793.dtsi b/arch/arm/dts/r8a7793.dtsi
index 9ebe7bfaf0e..f51bf687f4b 100644
--- a/arch/arm/dts/r8a7793.dtsi
+++ b/arch/arm/dts/r8a7793.dtsi
@@ -988,7 +988,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
@@ -1111,7 +1111,7 @@
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi1: ssi-1 {
-					 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x03>, <&audma1 0x04>,
 					       <&audma0 0x49>, <&audma1 0x4a>;
 					dma-names = "rx", "tx", "rxu", "txu";
-- 
2.40.1

