Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B6FC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5EE188384;
	Mon, 22 Apr 2024 01:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741557;
	bh=9k5Im/gWHTfSBHxqPT6oS72oKqBdA7HU1bc8PTJcZW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XdrJWQaQqjNs/Qwa8sRcQgzV95/vzektHCiy253cIjVxutdIguibjUvUuuY5sBeMU
	 IdgnPwWEXOlEfFmjn9gUz6qS2IWgCKcBK9VVxEtqXXQNgSy1qwLJ+oip7g5hifUUcy
	 pl4PQeIWBCYmUxUlRZug9CwIeTGbOaajrTjsE2NPKdNJ7qvUegKvLnkQqBhM0ypVwD
	 XkO64vpGT/hlgnRHQuesObmf+f7w1fqfwrTf0w4fjpew2qwHFhgSa+D3C38FwCcXGY
	 VTNa20ykgPJMbZ4w0ro1vkHLUsBMBy2SVUqrQimN/srZtzYOPXU9NrawTiiaeHc00X
	 XccMXs9ZbwoCw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 38DDF88335;
 Mon, 22 Apr 2024 01:19:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741552;
 bh=9k5Im/gWHTfSBHxqPT6oS72oKqBdA7HU1bc8PTJcZW4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U93YGueyYL+rOoUNyfKHgQilLMjrNodRmdAmCl9/pNTw3zYq9JPXClswVoE63h+qM
 qDnDXBUO+5qSWjTxsCNg1/yPgZJeM7qvjyVIxOKeDRxpjOROgUHHcozI90ZJd6WX/o
 SBPjCbSaCwVM35w+HxY0n+1jFG0wSuHfK4aZu9AwRWbrUi4d9OQgi+BTelBfzSw8OU
 L9O2wZgDfFfDOVWaDVuJxyoxpfTZmkUFQ7GkE1D5OxtiVNbfcAbthXJxdDs+ttbSEU
 7YBmJOsG65r5GsdRRDUkfPyBsL5g/Ln2/O6WWMeTCvwqzQsmqyXt9hiaPpk5sLE2XS
 HttO1JYkad4Jg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 16/19] ARM: dts: stm32: Add alternate pinmux for MP13 USART2
 pins
Date: Mon, 22 Apr 2024 01:17:02 +0200
Message-ID: <20240421231849.194648-16-marex@denx.de>
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

Add another mux option for USART2 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index dae015a0ddf..65f91265a4d 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -758,4 +758,45 @@
 				 <STM32_PINMUX('E', 11, ANALOG)>; /* USART2_CTS_NSS */
 		};
 	};
+
+	usart2_pins_b: usart2-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 11, AF1)>, /* USART2_TX */
+				 <STM32_PINMUX('A', 1, AF7)>; /* USART2_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 15, AF1)>, /* USART2_RX */
+				 <STM32_PINMUX('E', 15, AF3)>; /* USART2_CTS_NSS */
+			bias-disable;
+		};
+	};
+
+	usart2_idle_pins_b: usart2-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* USART2_TX */
+				 <STM32_PINMUX('E', 15, ANALOG)>; /* USART2_CTS_NSS */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('A', 1, AF7)>; /* USART2_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('D', 15, AF1)>; /* USART2_RX */
+			bias-disable;
+		};
+	};
+
+	usart2_sleep_pins_b: usart2-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* USART2_TX */
+				 <STM32_PINMUX('A', 1, ANALOG)>, /* USART2_RTS */
+				 <STM32_PINMUX('D', 15, ANALOG)>, /* USART2_RX */
+				 <STM32_PINMUX('E', 15, ANALOG)>; /* USART2_CTS_NSS */
+		};
+	};
 };
-- 
2.43.0

