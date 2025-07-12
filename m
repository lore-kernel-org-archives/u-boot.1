Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35077C83F1D
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 21:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C40808AF;
	Sat, 12 Jul 2025 23:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Wn9jeaZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE69681D5D; Sat, 12 Jul 2025 23:27:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D5BC80050
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 23:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9534=Z2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1752355642;
 bh=gCxeLAd60Kx8wSF9LM2xOmlDTnk//iUWZgGxJ2LAsb4=;
 b=Wn9jeaZSnxIjRVDPEWT2PUaOy53EUw5WAEkckLWSATV0AC448G48ky8OvXtSUub3SfJnx4c/0
 UtN0Cvivl7CeKCcX2llv0L2rCsrn/PZuyryAklcvT3XCxOj3pjQ6HqbGk9xoxLR4uhNf4YZki59
 5cXFeVW7PTU7f10Mci6vGSHzuIGR/dhGbE1asvihnyCcptqjY17m/VXpJkgokzZuTJDUROrS+b7
 g1FZOkI3cyeBZK32fEGVFn2GJbeBK7+K54r819tDX8hj2WE7hfynNglWbjpvq2ryHH/j8HlesoM
 9+LDcPD3J4V3BYKicYGENn1/LZ+JMQddJA6vbiHoka7A==
X-Forward-Email-ID: 6872d336e9b61efbb89c1172
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] rockchip: Ensure env in SPI Flash can work correctly
Date: Sat, 12 Jul 2025 21:27:07 +0000
Message-ID: <20250712212710.684525-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
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

Ensure that the spi/sfc node for SPI flash is aviliable during pre-reloc
phase so that env can successfully be loaded from SPI Flash.

No boards with these SoCs seem to be affected as there is no default use
of ENV_IS_IN_SPI_FLASH=y.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3328-u-boot.dtsi  | 4 ++++
 arch/arm/dts/rk356x-u-boot.dtsi  | 1 +
 arch/arm/dts/rk3588s-u-boot.dtsi | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index b0e50a973a88..8ffc9ed3d573 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -132,6 +132,10 @@
 	bootph-pre-ram;
 };
 
+&spi0 {
+	bootph-some-ram;
+};
+
 &uart2 {
 	bootph-all;
 	clock-frequency = <24000000>;
diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 871869739536..738b9673d352 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -157,6 +157,7 @@
 };
 
 &sfc {
+	bootph-some-ram;
 	u-boot,spl-sfc-no-dma;
 };
 
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 5eeb138f3513..71fd352f640e 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -140,6 +140,7 @@
 };
 
 &sfc {
+	bootph-some-ram;
 	u-boot,spl-sfc-no-dma;
 };
 
-- 
2.49.0

