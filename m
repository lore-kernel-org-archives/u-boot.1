Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460D9C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9C587495;
	Tue, 12 Dec 2023 17:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="TVvcCzn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1847087812; Tue, 12 Dec 2023 17:04:46 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F4287495
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1rD5FA-000BXY-Hr; Tue, 12 Dec 2023 17:04:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1702397079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eat9ATv/S1//4Xl9cjCrKAX67E7cy4w4LGS+Qna75ZU=;
 b=TVvcCzn9hVd2WEIaisU4Xoi8WiPgsS2KytFOnUM+xi7yMsk/eedPq4c4MIPsoB2HuOHCGI
 VEQ7gKwetVjmNMJSbA52X/igIqUZ6IYdcfDGPm1mK2AnjVu6590tJVAjuZBhpmc73A0dJT
 Nngf+mXagCtefvmrHzqUvkv1OwBmM7GdhWNcRIiQoRAZo10HX7NqbR2njPLMcK/OF4q0fJ
 zpsrx1V4MkSC0dhWHKcHOQXJ3ya8ZgCv94XJDsS9V6Bw5RfCu3iKw3fOi2vWL456gg1TnK
 woqLqZcy2YpPeKkZgsYHsPizbLJAbCTvkHHxe1Z40D+1ko+0iFgnSvuEw0NPRg==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH 3/4] ARM: dts: at91: sama5d2: Align more node names with Linux
Date: Tue, 12 Dec 2023 17:04:22 +0100
Message-Id: <20231212160423.44290-4-ada@thorsis.com>
In-Reply-To: <20231212160423.44290-1-ada@thorsis.com>
References: <20231212160423.44290-1-ada@thorsis.com>
Content-Transfer-Encoding: 8bit
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

Port from Linux v6.7-rc4.  Should not hurt U-Boot but makes diffing
easier and allows referencing node names in board dts.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/dts/sama5d2.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/sama5d2.dtsi b/arch/arm/dts/sama5d2.dtsi
index 0dbacade3b6..7b62fffb4ff 100644
--- a/arch/arm/dts/sama5d2.dtsi
+++ b/arch/arm/dts/sama5d2.dtsi
@@ -119,7 +119,7 @@
 				status = "disabled";
 			};
 
-			pmc: pmc@f0014000 {
+			pmc: clock-controller@f0014000 {
 				compatible = "atmel,sama5d2-pmc", "syscon";
 				reg = <0xf0014000 0x160>;
 				#address-cells = <1>;
@@ -759,13 +759,13 @@
 				reg = <0xf8030000 0x98>;
 			};
 
-			rstc@f8048000 {
+			reset_controller: reset-controller@f8048000 {
 				compatible = "atmel,sama5d3-rstc";
 				reg = <0xf8048000 0x10>;
 				clocks = <&clk32k>;
 			};
 
-			shdwc@f8048010 {
+			shutdown_controller: poweroff@f8048010 {
 				compatible = "atmel,sama5d2-shdwc";
 				reg = <0xf8048010 0x10>;
 				clocks = <&clk32k>;
@@ -780,7 +780,7 @@
 				clocks = <&h32ck>;
 			};
 
-			watchdog@f8048040 {
+			watchdog: watchdog@f8048040 {
 				compatible = "atmel,sama5d4-wdt";
 				reg = <0xf8048040 0x10>;
 				clocks = <&clk32k>;
-- 
2.39.2

