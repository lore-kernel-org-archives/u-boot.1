Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEBAC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2F38835C;
	Mon, 22 Apr 2024 01:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741554;
	bh=mjUSQsGdaDrOovfKzI9H3XiTrCokHmMKzZEsFZjO+S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UUWy7rpJaKzNhTV+orUYO5B5BeXeij3AB9QnbW3i6MV+FIyaZIbGZL6IKM9Mp/k9k
	 LXR0PVmo0aZtEvwDmhBCrmtOZQBNQhMo+DZvFjXmKOl2de0j5kdEBEK51m2ryG9at+
	 RwB8j4QEZrDtB9iewrBJUVBTpkL1Rub/8cy0vvUCf1VcAd4MkcJyBeGNcVEAgZlboG
	 mvL3LdO14KoEVWJOfOksvSLdxZzOFMvTJkTbbIoaGkLmuMM/ZXdMvh5omp4SISPixV
	 70zo2dFj9ka4hL6EFfHQeQ/gwWb/TECGJ8VkS2FqDmlhgYMHg5EjigLqvd5l5rReKJ
	 HlfdtKff1886g==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8ABDB88322;
 Mon, 22 Apr 2024 01:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741549;
 bh=mjUSQsGdaDrOovfKzI9H3XiTrCokHmMKzZEsFZjO+S0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WT3JV0vtAEVyWHWUzLmPqdjMlugFt2SJlvMeSAsGWd72+0w7ocPoOsJSUOhph8anp
 Vhu4V+K9mC8sU98oi7SmKo0Y1eaKucIktf/Z9Lofexa8ZSBWAu+Nx1sovEDh+lbKvC
 0d7yyDtA29550hpiH0xgtQabpImtcAyok7NrTtfmI1waSXBzgs4kKrhTnxHsd1nkKb
 8FT1mz3/zU7cac2q32PWN7pF56VC8HgsjTrFZvQotEnI75TGhcl2a+sFWX8gurWVvy
 F7dokY2RcGHgKBs5JutsAYP71J2Qccl3rmDB8rF4wt5MHTejGpxcbKLrhkp9iKfufS
 i31UBZV8n0ueA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 08/19] ARM: dts: stm32: Add alternate pinmux for MP13 PWM5 pins
Date: Mon, 22 Apr 2024 01:16:54 +0200
Message-ID: <20240421231849.194648-8-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240421231849.194648-1-marex@denx.de>
References: <20240421231849.194648-1-marex@denx.de>
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

Add another mux option for PWM5 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index b58bf6c0024..d19408f19f9 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -245,6 +245,21 @@
 		};
 	};
 
+	pwm5_pins_a: pwm5-0 {
+		pins {
+			pinmux = <STM32_PINMUX('H', 12, AF2)>; /* TIM5_CH3 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm5_sleep_pins_a: pwm5-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('H', 12, ANALOG)>; /* TIM5_CH3 */
+		};
+	};
+
 	pwm8_pins_a: pwm8-0 {
 		pins {
 			pinmux = <STM32_PINMUX('E', 5, AF3)>; /* TIM8_CH3 */
-- 
2.43.0

