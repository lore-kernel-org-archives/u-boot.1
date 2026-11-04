Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085A606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NLMIh7jG;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=hpT3Vzmc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C7C46084F;
	Wed,  4 Nov 2026 08:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nlsSY8iyecX0; Wed,  4 Nov 2026 08:51:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D81A16084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782307;
	b=jkWzZWvxSj1ADWA5IzmEFN0jkI6Yl175q8Pyx3o30d50Q1PrZhn/ANMV0tD+ABfyYaxr
	 8afIbkLQda3QMVG+n9JONXY5SdA7GmwKitXHmcoXaGKtxHO9q5PQXIPaD2yDvgq1kWu1N
	 4nivB7AJz1AnpfgAPy+UIfEkRyQwm3aXDtwfGcE9/zrrRk5RKyZ3GnYdrn5yTO13ULEhv
	 ibhdBm4X/30GoWcUD+ql1P++CeqNReENc8YP4UKDTaKYAAomvxIdUDayRw8fSx71O0Rt9
	 qUhx4YzNimcHeKSc7VciBF5oOF7cQDWKfrvPGzNMeLwvxz3c8WYgi/PCN0XbvMd0ZaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782307;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1fYDYK4/0py2sPc/P4MXBMkGVAuK0Mp193TalKAa6Zw=;
	b=DZ9hkYJ34+UbfqGZobOP+T6KXl/fJUFuAWvrI4109AZz/+x19QcwygSaiJwDcqq2iO0X
	 iZT/Yz80j5kEGTnHrFIznlAnPLol2+GWCACpbni9ErjhkXUZ/RC5gvmdrMIHMqjM9RNIL
	 JycVL4sII7QSJdfb3xR7w+l5KLeUGIZRF5a9crw1k1zImS0/hwXZQkWz5BMB1KJTiodib
	 waggZRFor6JVVNVLbpV7GMO6g/mBqLSx+aAGffD5tI76tt19at+yt6cKNpiolTRoVtsVS
	 2a9/af6G8WXeKVfxv2DvPm53AZFo5NeNaTa3fiHUJQzcSd6T4HUIMDCxBYT9wWVRgxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=hpT3Vzmc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782307;
	bh=1fYDYK4/0py2sPc/P4MXBMkGVAuK0Mp193TalKAa6Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NLMIh7jGO+6drojYj5XQVWV2iMOJAWKqNki1z3w5SG3rWEx2DvixprsYG3k/TEmHP
	 1ssbE9AAcvvpyNMIllNlesUIIwyLY68ZpSh0Vg/xAy+9HTBWv7iFuNLcxeGXtwhWM0
	 s3TgXtV+TOcTOGdsYDxsyXXoVlrBQEOJD3K+Qjx+I/j4I3Mp07ELunD8jQcIc7mpUa
	 PUtNK0xuGdwL0weJhKDFhoYuVUEkNdh7R36TflXUI391mYtDAdxuWjNqEZYj7Dnod0
	 vPHxyZZqf+H1m1spbtf2vU2yx/u1n+14+rAGljS9/ka93ecJITajU2TJmxl9fBNx2I
	 j8ZSsZ0pLA2dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D81A16084A;
	Wed,  4 Nov 2026 08:51:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE5BB2AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F6F96084A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jK30CObmrtWx for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 609DA6083A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782304;
 b=nSXELMLhY00/caYGWi/G+V+L3HxcihF0rDtDdWkmwzyz8ccJIhZlMICgo0bHL461Re13
 ADCDNZoryEdCg4rswwlYZDcf3tsdWIJ0necBlqeFFaa0cfau64QTuyNvIhCrgRLtby4P6
 VSQt+uW1iAzyolR4F3Mi0+t8WMzJpha/gBczpJdPjijV442mrxOwHlwfq+lutp8pp0tHj
 /83DYDFXbQZNfV1QEPwAEce81x9xvI7aDv6syn9ravisvgn48dx/DNWcQVFGvAbZ1P9+4
 mB/9msqoYOrZZH++MTc0/BCNwwCX7giTsLlkvX6WtUigTy8gUfIfcBv5S4uOkoL6kjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782304;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=1fYDYK4/0py2sPc/P4MXBMkGVAuK0Mp193TalKAa6Zw=;
 b=aY9TMrNXcQ5llq8dVbGOk4j2ifRrLvRdmCBl2TgXST4Zehp4+pTu2ln3EicrPzWO+nUw
 +lM6SdTUiC4U96JIFwtgbRb5yFq8x3kOsIZ4zUaEvKbqL2Ww4DB26B2UeUwvIy4XDDVdf
 H217aFcYPM9hmDw2UDZI25mbKVqTDOSYgQVz3lmnR6GYCcINliYrSCuJZiIwSSLANli+C
 VeKfEXejXXWbgDKZ1DSZjUKEL+cjn9wbn/Hl692bZPwQ4+Bq1RcNIUOBCyz1F/ndua95A
 lq6c84t4+xrNcT9OMraIoCrBkbQR7FQ63eU5ov/km3sIMkURPG/fO8ZmTsNrCjcofyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=hpT3Vzmc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=hpT3Vzmc
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 609DA6083A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:43 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso3798255e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782301; x=1794387101;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1fYDYK4/0py2sPc/P4MXBMkGVAuK0Mp193TalKAa6Zw=;
 b=hpT3Vzmcjv8TUxjcok9zb6USryEOC1z8h05YWs8uGEp0VW3RZ961nRbRjaON0vgH1P
 6IIgX5jaxbYBK3PnBhUBQpHXWP2QNwYwS7A+9PR5gIVKh0R1XNEKkK05m86o9Qe1Yly6
 IoHSHr4UHBSL+mBHHRaVQGDiqmwWLEydTB3II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782301; x=1794387101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1fYDYK4/0py2sPc/P4MXBMkGVAuK0Mp193TalKAa6Zw=;
 b=B+YsTQOyKQRNfWV8TSxAK+NU+A0cVb7LC/ObsiyXTKP1KMWr91/4NymRQdzG+xoukF
 rwJGdfsN3yq6q2j5YyUGBUIKTGX10jyF4UZLrNJ+gXsZ8vhrWktcPeqIKmTG7lh0jeVP
 /v7ySZbU2A8E7yNhG6rmVIWWCO8eW88AW7O5rCXYloMtLaNh3oeJ7AMr1peeFG85iTqv
 5OkHn1C/nR9tvA395ojAM1Vb/LkWq+tdJGFQ02wRxFKi5yl6NXFUEUVvc8+BbHNxJNz6
 5EYW8rR5tcORlsjsoQGvnAaWPdub2QRZ/yhowtgfzjA93bhRjnGgq2W14P3xVbpWtDFp
 H2nw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcoZETskeMuKvCxVyyRPxRYjErTvAp56dPAHLzj9ZrKgAl4w659AXxVOMfFNlED5EPqip/KHI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/6LiLVJ7lVKj7KbOOOkYFkEK0edNatJyF9Pjb3VzuaCct8lrAw
 RVl05DUDRz+ySvvOLQWeGNdIxjq2No/F87QPF9AsEWMuhIUFcunydHg3b+aWzpjv4lU=
X-Gm-Gg: AYBFou2hRj/CsGnh7G2kKxcyyDLp7uMA7MamDAYpZBKj8yJEW6/aFbLNQMD3Mpde10W
 ONrzibfa8ZmqPJbejbsbQmcfG0ESntmY4fDX+4jbPbFXRwdSCQTU8kpQelDyN8LWURSg1tQSKVm
 Yafd1IFfdgx3j3MvnrGfGtYE642adO6FPTXthf1kS73r7Q7/R1pp/MlgYUOIsGVBAEXYbCUbE3x
 Rg4JpnOO4T6MEDgAFIMQ2otMZo1AASJi/ne5eawEKI2cFQ53KGwn7A1dN2YZrCzkkzPkWAaEpjk
 bUaGBxECdRJEeIqEghwn4AYNstj2Hp6+6Kwp2Z5iHAzPtq7zwap9bAEJpZca7LjSdYhoBGFgF/3
 Sp3XxjmLM4eBLk3uH5eqqH8knoLWZ55TnF6Cn/SCIBN9ZYvMIaoKdJsgah4S+9pDKR1tlhC7062
 cgfubm5aHbnvqKA5KNafIKiaBEjxxk68Dcd7Dwg8VnlbjAnZnzpudXMJ8SXEeZZLRlG1hIlME+L
 0lzaoX5WzvKfgBWjbLbKoblWJq7GCU6rhH4FGutnR7pFJtgj1xDwIBvfjD1qHeqqzDL/LNUfpFv
 WbaiTVlIfZB3VXVUcR9owqzQB2K2Yfs0M53tZdZs+3g8CQZ/E+JcGpxvsVa9gmHOPqTk9NxeWzb
 hv5x0YHP4ACbGhvI3PQLeR3P6CnE=
X-Received: by 2002:a05:600c:628d:b0:4a1:9663:7633 with SMTP id
 5b1f17b1804b1-4ac17d16b99mr348240245e9.11.1793782301176; 
 Wed, 04 Nov 2026 00:51:41 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:39 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 16/33] arm64: dts: st: move Engicam MicroGEA-STM32MP257D-RMM
 display to an overlay
Date: Wed,  4 Nov 2026 09:49:49 +0100
Message-ID: <20261104085036.4012238-17-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The board is fitted with different displays depending on the product
variant. Keep in the board dts only what is common to all variants and
move the RK050HR345-CT106A RGB panel and its touchscreen to an overlay.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260923155333.610134-2-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: c82d6c52a2514b0a5a7968b6fed8ff212b80e5e1 ]

(cherry picked from commit 8fbbd1cc0edb754a6653ec4af418e02887cb3bdb)
---

 ...icrogea-rmm-overlay-rk050hr345-ct106a.dtso | 68 +++++++++++++++++++
 .../st/stm32mp257d-engicam-microgea-rmm.dts   | 46 +------------
 2 files changed, 69 insertions(+), 45 deletions(-)
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a.dtso

diff --git a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a.dtso b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a.dtso
new file mode 100644
index 000000000000..f89641bdb23b
--- /dev/null
+++ b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a.dtso
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ *
+ * Rocktech RK050HR345-CT106A 5" 480x854 RGB panel with EDT FT5306
+ * I2C touchscreen controller.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-1 = <&i2c1_sleep_pins_a>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
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
+&spi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	display@0 {
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
diff --git a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
index f5af0913bf1b..faedddc2c914 100644
--- a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
+++ b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
@@ -116,25 +116,9 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&i2c1_pins_a>;
-	pinctrl-1 = <&i2c1_sleep_pins_a>;
-	i2c-scl-rising-time-ns = <185>;
-	i2c-scl-falling-time-ns = <20>;
-	status = "okay";
-	/* spare dmas for other usage */
+	/* dt overlays don't support /delete-property/ */
 	/delete-property/dmas;
 	/delete-property/dma-names;
-
-	touchscreen@38 {
-		compatible = "edt,edt-ft5306";
-		reg = <0x38>;
-		interrupt-parent = <&gpiob>;
-		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
-		reset-gpios = <&gpiod 1 GPIO_ACTIVE_LOW>;
-		touchscreen-size-x = <480>;
-		touchscreen-size-y = <854>;
-	};
 };
 
 &i2c2 {
@@ -179,19 +163,6 @@
 	};
 };
 
-&ltdc {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&ltdc_pins_a>;
-	pinctrl-1 = <&ltdc_sleep_pins_a>;
-	status = "okay";
-
-	port {
-		ltdc_out: endpoint {
-			remote-endpoint = <&panel_in>;
-		};
-	};
-};
-
 &m_can1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&m_can1_pins_a>;
@@ -259,21 +230,6 @@
 	#size-cells = <0>;
 	cs-gpios = <&gpioh 8 GPIO_ACTIVE_LOW>, <&gpioh 3 GPIO_ACTIVE_HIGH>;
 	status = "okay";
-
-	display: display@0 {
-		compatible = "rocktech,rk050hr345-ct106a", "ilitek,ili9806e";
-		reg = <0>;
-		vdd-supply = <&reg_3v3>;
-		spi-max-frequency = <10000000>;
-		reset-gpios = <&gpiob 6 GPIO_ACTIVE_LOW>;
-		backlight = <&backlight>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&ltdc_out>;
-			};
-		};
-	};
 };
 
 &timers2 {
-- 
2.43.0

