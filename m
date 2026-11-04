Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A785606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X66W1vxj;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=bLIiZzAs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FDD960831;
	Wed,  4 Nov 2026 08:51:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id riKTUaEJ2MWN; Wed,  4 Nov 2026 08:51:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25DD16080B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782302;
	b=qbzR+wJzKaZHAvOzybMQuqKhya71z7Kk910/uCQlCVZSalG4WmOTZpQzVMKlvikxeQci
	 aMMOYUlqmBOBOj45oX4U9KDNDIDOChgNQI62HPmqQ5+X55tOQ9URfva0pk5kl71UMqj/y
	 aPaCA2xcWSBpJv11gBJFBMwlgxa0AWWyqTIfx0xeSJfSq5OlkyZRUIghPLAt53UIivIRg
	 r/9i2oj7RoNMnUj0OcKB7Y2SRZ3eiG98Py3MYUVkOUBZdDDHf/nOselNGNRgpKvgAUnYb
	 9pEen1H/bBgB5sARvSppY9TshNfGZyxy7lOEPtommxNWcvZdAOYsQaN9WZjVMpL9YrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782302;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2CrQH1DjM69xwKGbGDiQwgtmUJulYt2q4abfsij9LfU=;
	b=AHvrp4ySk4XVLNrKR5psh1Qsm+Fo9pT4sO8AdloGFyoX5Ipz1FHVCsmXpU1P6IhW5IIo
	 oHEP3XLKljpG4DOreVaCxZalD7zRg1JqifhFkC9IoJWKdS2jChMFwY+0g4VxyeYJ5HjD6
	 rAyPgHFf2tkcxW5x2ibFETvHWrq4pH6tOsVHwxAoNp8o+16n4W6yR0wC/jSzuTIpbudDQ
	 NMXGVqyci0HXsWDG2lePD4Rtvjixhf+hY8kaHdqRpkHJISlAMvAwhwhePcx7MCCYRCuWe
	 6QLUTgGS6Oe8xN6SLH8rhQDeDer+qTkKtl5FLCwAunvZr5NACWs8W3g1mcsRBU3Oadw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782302;
	bh=2CrQH1DjM69xwKGbGDiQwgtmUJulYt2q4abfsij9LfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X66W1vxj9K6qoBKrVJOuB6pGM+fYYUTKbE6R5OmA5i6hXSuSslnort/5NmFWosYul
	 4EQzrX4M1RbjWIK6FvQxO45HTh8NPZYp8B2v9tDhYMi4/JHrJc8DGnE7IQ1XzBTJMK
	 +QO4iQAdhToD437TxVMm17kkscrz/0c1OyPRRG6ZsgkWUKomNrwkNMvVEuaSuyJh4E
	 DUBf1L0mL4hBDonaSoEfmsA/0bONQjTKEtqJ41vd4zYpp8ulrljqb5HSiVeHDXlyp1
	 359kP51lWsX8lai/aOCIzDpXWeEMzx62b3o8Ypg+32B6Htx+h/RGOb668U3aD4aQZM
	 u9j8xpIvuBHMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25DD16080B;
	Wed,  4 Nov 2026 08:51:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 353C5A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19F25401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ed9cgdOssRJE for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B32B44004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782299;
 b=cql0AHxnwkm8ZBkGqB1o2VT7CmmxIjiEJjwtLloc7T3NYGW55uvacqXxrdWL0SjQR9jj
 nHiG9WyOjeavUUkaurLXr1JdqtAtf5A9AKvTbchwxEvKizHt7QvPJDwuyBf3g8sCr4kYz
 UbfXtvyy2N3o3O8jbSuAhkjFlGGf0TQQz0PAjFQsX2uFv8bNGuWfyH7v+wWlL48i1tuJ1
 INPgWGHZtWRNoki2OEK/v5CzlF9jJMTwUh+Bo8bJmLsyWWnoOBm+FdfI5MMRQbkJyhWPz
 2or7SAnk4RW+Hdx7IoTbazh1Zejla8VlgqUcvXInMoifBDFZ80/LZeuVBivttcpqCFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782299;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=2CrQH1DjM69xwKGbGDiQwgtmUJulYt2q4abfsij9LfU=;
 b=sDjBWWfOZXTUeeW7Y3dlSY9AOfksKL5s8mCFjV/SL/vlJfJixqUWgOQkFmJL8vRhb5bX
 nZ4wETCZZPobhcO/bVIltGCUJm3cT9JhfvctDDoLvVYDL8HwHKO+qrriOrGS55j5qtUnH
 SheFJaXWB1NNGUrutygLw6WUBDRJUDYRQI5CCV5ZHvVLqCulqzjKcUexGsNTRilMEa7pk
 h5Wr8qxQS2sP00DWj927xp3fHal/9ypFnwuAur2ZBsDTCRp6E3YvtmYs0nfmjVELt30qd
 SS9lQq2P+VH5hxpYU+iE0QYWmFnjEKKEQGApa0JGZYd8C/j7KpmTabMcoXUi1vI7Xyw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=bLIiZzAs; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=bLIiZzAs
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B32B44004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:38 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so2486985e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782296; x=1794387096;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2CrQH1DjM69xwKGbGDiQwgtmUJulYt2q4abfsij9LfU=;
 b=bLIiZzAsvxg3GaNjAfjZj4YE17dMXMPkMdN9UwjB6ntbrTbNcW05qw3d1Tj0VcH+Ro
 a4vj2CIsPIe2P34wOVIsHCSVPl92kUIfsofhWO2UFFq9L6u/6OrNd5ZwYfLYODxTh/2v
 0AEjm01CnSIkcC+4pWmcg1NoM3A3ADlmsbU9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782296; x=1794387096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2CrQH1DjM69xwKGbGDiQwgtmUJulYt2q4abfsij9LfU=;
 b=BA5k75BpQnBVS3fT4oATa/X5tRfFhTM141jhBSOJ07ksUNFyvqORxga4cPCb9Bc35G
 E2aZWHArd2HRozAJVx2/ugV9764JG3ex4v5QtnclD3e2+EgazcOXSLMSEuRnu2M0sL+j
 IEghJqiYzAzDmXDw+jqYKbh3Elp9zqK+5eKNSJEbGuVKnDhwoQLZs+H4Kw/bxP5Ujyh8
 itEOV62SOeklT1DKVc4G97Jsb+j/3HM4O0969AfczYlHBW/wSZjgE8MTstP8QOmnjUre
 OIYvotUK514WkplpeDsyL4Pdb3Tbf0Nc6NOjRZsIBvv9S7gRd0M2FnC0xk74NlfOZNQR
 AFeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/4l4DoPnaT/TdGCJ0R68UYRqECoDh4hzq3PwkbaePYujszueIUIkSn3XS8zMBIdit9s2rf/8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9rFRSiYJpc/HMj8NmEHkdOGCssN5WVXHDCMofGpRK+3fgeL0Vr
 heOJf9l00oAFzLnUFOvlHY5I9kPh+hIADjk2NWGWQ7X9a8L1vVSwMte44cekuyohKBk=
X-Gm-Gg: AYBFou3gBDTgHy9Jy3WnrGm5MGoxuMrKRota0g3WkNSBvBs5Ia4j4YCfiSjP4G72Ahn
 DZsZiqqAxQeuN/KRqQWwKJTFYBNxvjGkPEY0KRrADTAzsKlSnooxt1uajO7b1+yGWc+XHktMQ9w
 ceCv9oNCp55ChvpeUn4gpjto9TCuc6IB5c3KMaHM4zAj2FWOkODq3YJbfwqNc3+5YgGi5Tu7KDq
 0YJQExfzNy1aZAKWxbZ/Me5XqQyxk/lIAYkSzI3nJLs2KfyeZy89GtWDyfFUCJrwZdfaW5wHQi2
 p3NCsxt1TekjXZpww/VmckJlCkr97YSkFe7R503nrDCblQJuTSFmgbnAS3XjZhJLPdar1Z4kOFH
 L11mGZKITA68ev1Pd5toR7/5GjTMsXQ/KfGKxIXdKPVoDZSh0ZYRuKmEGF/bWbithnh1LjLsmWh
 a1aJyX/nQNYcUXwtCExcnWvlBEwLxGqovYzbNQqrU64Sb8r+nzzZM08hT3zLYxFy95hKDLPGY7i
 J79z7oA59eOthrb8lRsFjnagXUBcO4kPCyTkj91J01Xyo2EyjWb/cc3VcejHOBe0D6OVO2wVUQY
 FOnobvYr9cK+/jXBP5SYUBPCcaJLsuweLHkfTfiWRIitvcpi+1mY+qKtm3I0dCffIHMNrORFWpf
 x/ptb9icfh2GN+Fanok0YtxpIAanA
X-Received: by 2002:a05:600c:858b:b0:4af:9cae:df63 with SMTP id
 5b1f17b1804b1-4af9caedf69mr185987725e9.31.1793782296297; 
 Wed, 04 Nov 2026 00:51:36 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:35 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 15/33] arm64: dts: st: support Engicam
 MicroGEA-STM32MP257D-RMM board
Date: Wed,  4 Nov 2026 09:49:48 +0100
Message-ID: <20261104085036.4012238-16-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Support for Engicam MicroGEA-STM32MP257D-RMM board with:

 - 8 GB eMMC Flash
 - 2 GB LPDDR4 DRAM
 - CAN
 - LEDs
 - LCD panel with touchscreen
 - Micro SD card connector
 - Audio codec
 - Buzzer

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-16-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: bc7b07bda4e0dbb70c8cac0532691c39602390b8 ]

(cherry picked from commit 435db86022032d69ff48f5e0aae57169d700b02f)
---

 .../st/stm32mp257d-engicam-microgea-rmm.dts   | 319 ++++++++++++++++++
 1 file changed, 319 insertions(+)
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts

diff --git a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
new file mode 100644
index 000000000000..f5af0913bf1b
--- /dev/null
+++ b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "stm32mp257-engicam-microgea.dtsi"
+
+/ {
+	model = "Engicam MicroGEA STM32MP257D RMM Board";
+	compatible = "engicam,microgea-stm32mp257d-rmm",
+		     "engicam,microgea-stm32mp257", "st,stm32mp257";
+
+	aliases {
+		mmc0 = &sdmmc1;
+		mmc1 = &sdmmc2;
+		serial0 = &usart2;
+		serial1 = &usart1;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <85>;
+		pwms = <&pwm2 0 100000 0>;
+	};
+
+	buzzer {
+		compatible = "pwm-beeper";
+		pwms = <&pwm4 0 1000000 0>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer {
+			compatible = "simple-framebuffer";
+			clocks = <&rcc CK_BUS_LTDC>, <&rcc CK_KER_LTDC>;
+			lcd-supply = <&reg_3v3>;
+			status = "disabled";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			gpios = <&gpioh 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			status = "okay";
+		};
+
+		led-1 {
+			gpios = <&gpioh 6 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			status = "okay";
+		};
+	};
+
+	mclk: clock-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_ext_pwr: regulator-ext-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "ext-pwr";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpiog 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "STM32MP25-RMM";
+		widgets = "Headphone", "Headphone Jack",
+			  "Microphone", "Microphone Jack";
+		routing = "Headphone Jack", "HP_OUT",
+			  "MIC_IN", "Microphone Jack",
+			  "Microphone Jack", "Mic Bias";
+		dais = <&sai1a_port &sai1b_port>;
+		status = "okay";
+	};
+};
+
+&arm_wdt {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-1 = <&i2c1_sleep_pins_a>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5306";
+		reg = <0x38>;
+		interrupt-parent = <&gpiob>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpiod 1 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <854>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-1 = <&i2c2_sleep_pins_a>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	sgtl5000: codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		#sound-dai-cells = <0>;
+		clocks = <&mclk>;
+
+		VDDA-supply = <&reg_3v3>;
+		VDDIO-supply = <&reg_3v3>;
+		VDDD-supply = <&reg_1v8>;
+
+		sgtl5000_port: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sgtl5000_tx_endpoint: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&sai1a_endpoint>;
+				frame-master = <&sgtl5000_tx_endpoint>;
+				bitclock-master = <&sgtl5000_tx_endpoint>;
+			};
+
+			sgtl5000_rx_endpoint: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&sai1b_endpoint>;
+				frame-master = <&sgtl5000_rx_endpoint>;
+				bitclock-master = <&sgtl5000_rx_endpoint>;
+			};
+		};
+	};
+};
+
+&ltdc {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&ltdc_pins_a>;
+	pinctrl-1 = <&ltdc_sleep_pins_a>;
+	status = "okay";
+
+	port {
+		ltdc_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&m_can1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&m_can1_pins_a>;
+	pinctrl-1 = <&m_can1_sleep_pins_a>;
+	status = "okay";
+};
+
+&sai1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sai1a_pins_a>, <&sai1b_pins_a>;
+	pinctrl-1 = <&sai1a_sleep_pins_a>, <&sai1b_sleep_pins_a>;
+	status = "okay";
+};
+
+&sai1a {
+	dma-names = "tx";
+	status = "okay";
+
+	sai1a_port: port {
+		sai1a_endpoint: endpoint {
+			remote-endpoint = <&sgtl5000_tx_endpoint>;
+			dai-format = "i2s";
+			mclk-fs = <512>;
+		};
+	};
+};
+
+&sai1b {
+	dma-names = "rx";
+	st,sync = <&sai1a 2>;
+	clocks = <&rcc CK_KER_SAI1>;
+	clock-names = "sai_ck";
+	status = "okay";
+
+	sai1b_port: port {
+		sai1b_endpoint: endpoint {
+			remote-endpoint = <&sgtl5000_rx_endpoint>;
+			dai-format = "i2s";
+			mclk-fs = <512>;
+		};
+	};
+};
+
+/* MicroSD */
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	broken-cd;
+	disable-wp;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&scmi_v3v3>;
+	vqmmc-supply = <&scmi_vddio1>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&spi1_pins_a>;
+	pinctrl-1 = <&spi1_sleep_pins_a>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpioh 8 GPIO_ACTIVE_LOW>, <&gpioh 3 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	display: display@0 {
+		compatible = "rocktech,rk050hr345-ct106a", "ilitek,ili9806e";
+		reg = <0>;
+		vdd-supply = <&reg_3v3>;
+		spi-max-frequency = <10000000>;
+		reset-gpios = <&gpiob 6 GPIO_ACTIVE_LOW>;
+		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&ltdc_out>;
+			};
+		};
+	};
+};
+
+&timers2 {
+	status = "okay";
+
+	pwm2: pwm {
+		pinctrl-0 = <&pwm2_pins_a>;
+		pinctrl-1 = <&pwm2_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+};
+
+&timers4 {
+	status = "okay";
+
+	pwm4: pwm {
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pwm4_pins_a>;
+		pinctrl-1 = <&pwm4_sleep_pins_a>;
+		status = "okay";
+	};
+};
+
+&usart1 {
+	pinctrl-names = "default", "idle", "sleep";
+	pinctrl-0 = <&usart1_pins_b>;
+	pinctrl-1 = <&usart1_idle_pins_b>;
+	pinctrl-2 = <&usart1_sleep_pins_b>;
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
+	status = "okay";
+};
+
+&usart2 {
+	pinctrl-names = "default", "idle", "sleep";
+	pinctrl-0 = <&usart2_pins_a>;
+	pinctrl-1 = <&usart2_idle_pins_a>;
+	pinctrl-2 = <&usart2_sleep_pins_a>;
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
+	status = "okay";
+};
-- 
2.43.0

