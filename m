Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72683606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vGJeElyj;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=FnSdgJyq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50F0240798;
	Wed,  4 Nov 2026 08:52:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OoAY1ApXzk3N; Wed,  4 Nov 2026 08:52:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65D8340836
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782356;
	b=q6Ygqa4AGDIReM1SA3awFXKy7wa/lzKvaJrRbLdGXLdzrZoio97B1hPoCxXJmzPMoxIC
	 Q+E01wIYLzq4h8/LTtaI6imrK6uZhtY+vmdfjNTesERzPIbYByly6uv3yeQ4+39DJwi1n
	 V55HcrYs+40Z5jx2fZwZFYEWt0x5SN9hLb6oj2inAmZstsjblxGDV23ZA78GBxnE/ofcP
	 rHMDioUfiQBpmhCqZ0TUEWlpWWrhdwbZ/W+ib5IBAiQ1KB2J0XjnbAQ8L8xDpOz0Xvm90
	 QbPq9LyKNcWuUCIosI2tNCrcMmeJj6UhuFhnBpVA8xq8ogHHiOFBl/3T0/fxvNx7HpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782356;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wucyZpRbmTQjG17TJZGaKYFcprJ9JI8ZgO2QVfoWZyw=;
	b=BMH00vVQQbO76po4ByMC8/Dd09Xpl+HNLasRUFLTSZqRq3dIB2d67Zoc13/jUJ4KvAVg
	 dQ/QOzJo06ZhwyOCxdCzZgc2KANlLe8PZRc94Z7hSHAmwYQX8CziLq18IgFZYCJJNwJTu
	 WV62BQm+EzXfIJOhqnG6QeeFwLlvH9YMhTzq1NiVbR+kqrL/xZji/k70rk1JvEojQ6h6R
	 oDFfDvWQTnca0a9Yh32igDNLubAql5PH2RHe62hSgbQLDw7QGvVCG5ogf+aV178e95QrM
	 w5JJ9LrL+ZY+xxz+vKVfj7tvyysybemXFGxzYP9vyOlT0K1fGtwAJeBSMdPI2j8FaXA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782356;
	bh=wucyZpRbmTQjG17TJZGaKYFcprJ9JI8ZgO2QVfoWZyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vGJeElyjep0ntbzkW0CNVyO1aIhdC085RT7Vaw70MQpsLEfUT80ABpa2nYTQ5DQv7
	 2504rsuxF2uZ8d3Dpt/O61VBOt54k4YDLAVDDDu3Fd6rIJINnI4+oO9a3VWfI8FCLN
	 qpFEx20ZAfJZM1RqcPv4qzhefX/MBYzJug7AHV/RbRtr4lC0yXUqDxn6PfcBvUtI03
	 fTPXVWdJor6cB3W8B/+yXV5hTQbPLqvrDC1ZrLyLEdMOxYu6C+mXPivnR4fVN0305E
	 Hnfm1VGZs2ePQwFRnNHfJWlfCVF4Pn8zk8tsNziA8AWq0QTMYKPWP5wa0SFEq4sxGH
	 qOUEJ+b9BTUNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65D8340836;
	Wed,  4 Nov 2026 08:52:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 43613235
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3508D8118D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1SCOvUy-7vRX for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E91E78117F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782351;
 b=LIt/x1AdySVEDxoqvC3ycKFYceu+xrEhU3gadHy0MZSlv3ep8ZrLaJojuJQVgyLQsYk+
 DeQdoi5R4pqK6LNnJvww8dWt9J4qHgH6kNsgbEwY7hcNRWuuRTgxElf76tVdHKXm1dqrb
 tjr8CDNSgUIuRn0T7yPckI23P958+nx5bsgEMIMjySzWzKGg54komWrJ2iAGmZELm50xV
 4pWauYZZ+4HuekkEKgmI3Lb1OmO31vKvzZ2JvFwbgVyi7SG7S3wasb0kyKvKR496J9I5Y
 YJtNPHmx9xW8I7LLfvlTyn0TB8KcB+M1oZjzHApOamgztoBlHUUn/YQywfba9gQvBgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782351;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=wucyZpRbmTQjG17TJZGaKYFcprJ9JI8ZgO2QVfoWZyw=;
 b=UQ+g1dQt5S7TGnnNfUTcpFatW0wPTWt4gg5gkxQ0mRqHC8ziKyAAeRp214BTGeQ9ORHi
 A2R6wKzPd355aLVKbdyI6N9VoowFUfQZEr0CLB3QkLfZsF7SBctl6ZAQfGWungSbro93x
 fxMgH1Nco1G7Z0ux34LBlbZS7dFsLX+BzLv9rHMY3X0pgTPNR82zPH7ezGdHU1NdvdK3j
 olTT4Q2+yO5gV/pmJghwCpvDg2XKLtIUzvzkw4+2R/f7BQPNI3ndUO/Eve4lIlk3B1FNg
 veOvb1cUHnZAK7rPeACvsG2fiHLTmnbA3a68BH1E4/q78oQdgO8EMuDGMoFkPMCmnzw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=FnSdgJyq; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=FnSdgJyq
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E91E78117F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:30 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so3212415e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782349; x=1794387149;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wucyZpRbmTQjG17TJZGaKYFcprJ9JI8ZgO2QVfoWZyw=;
 b=FnSdgJyqXzli9LSiAkqprv9IY9Co7kKMvtAnh6uHW9jke3K0heTy3dXOvhmvkIeYKS
 QSuPppDEeLyUQtgSwlYoEOF+lOzRptOrqLr03n/+qH/6B7Rn6QcMbSdA5DCDWtpThxPv
 n1dmxjxyXEdPN04nPHJwmQdqJAaMDCQU7ing0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782349; x=1794387149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wucyZpRbmTQjG17TJZGaKYFcprJ9JI8ZgO2QVfoWZyw=;
 b=CA2Hwv12Ih18BBjReabKzAB014Zo5fhxf+rIxNe0H3d2aUJwKn3iiGk8/lEvy5P7Od
 JePaJSQf3FK8QyNbDiPgsRvpwZiDzbrZlWPC+QlueaI1+BTIamQGoilM4R8szpA2PfaM
 w+uSvhiKcJ0E1oQpDICbE6DqaKZMpmoItI1GPVOH0ofFd7H26jQq7eTy2Y4gOKyAFeWQ
 JtlVWUrM04PzclGZ5ijQg8owgAQqauL8Z2JAjC6XBqmNZgb78Ak2la4mlPx0W+wsktSg
 Wi4zCx6gFwHayF/WdoFV8iDi3DVJGTI/p218dKv+C8iVi53LwoMd8NHBQ+lzXzhvoifn
 eG0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxz7+kz/3FkZmfe1rSoVCxQMVgkW3Po1RK2M9wNGIgO83ZJMU4bCP2YfVYZJetDdg24OpvOZHE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8uaOYW+xXNswRAn6G/HQ3joO8vH/xweV8mXI+eIdC+wAMm9+7e
 G3XLFfv8PezZRhVCWpL/F9zh41II1/W8joZAWorvw+BdXJoeww6RS+g/6UE2dN2pTNXhWsvsJ+s
 XiJvk
X-Gm-Gg: AYBFou0ZuIOf/xswrcpVljKadHhhtNyvHX1V9Rycggt5odBNRNnvMsIl/1J/KJTpDrL
 LlNqEiAukJ3qy4TPSt3j+TiSb01WOXBYDo4JZankFOV9a871Knq/SL2tSaPt5QSyI7w/279powl
 +OgKVTuq0n7/mvXBbhoidYGHwypX7tm68jy4WSzVP+9n/cmCErpjQEhiIyU+BRbKobXCxDwVFa7
 HN6mFIJtEgJiqKUsFe5zJdNczoMR0DUP0ByPcqkHtdN4RC/K8ujR2UwghLUK675eq+3KpmTzhl0
 f7vGLKX/VDPygKG2iukdJ/bgzz3gDm+YHtn/5nuqKCCBytTxeH24jQRjEEbbF7iyjPPp5NzL7Uu
 pYQdbznPGdC1GHx6SAsBcngSZz5NcmIbx0I3U8Q9B5MiJvW3dwQnidxOLXj0j5wTftWTqYb+JHZ
 TzxBYXa6ovavBm/nbcgbifdA/PkcGS6alQVWYHA08kpxuxI3Csm6ydm52e/tRzC97C5RDbxauKA
 g8CB1/1J8gUcAm2krzRHE+cKEasddF7kijGeaZhpD5zmyvJa+SXiJLG91zaqjIjfq8oo3YB4o4U
 o4lAtA81kWKZR8zhVOgBVCRnnly9F3qbaGrIKjL+1zXlGNtUJyavuBLUj+L4GqetG6jCnoZ0M/i
 CXcU1QvERCXR6XPYstF47Rw4A0p9Y
X-Received: by 2002:a05:600c:4e88:b0:4a3:59c7:f226 with SMTP id
 5b1f17b1804b1-4ac16bc4713mr363757205e9.6.1793782348625; 
 Wed, 04 Nov 2026 00:52:28 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:28 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 31/33] board: engicam: stm32mp2: add splash screen
Date: Wed,  4 Nov 2026 09:50:04 +0100
Message-ID: <20261104085036.4012238-32-dario.binacchi@amarulasolutions.com>
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

Describe the RGB and LVDS displays in the U-Boot devicetree and show a
splash screen on the one selected by the "display" environment
variable.

The U-Boot devicetree can only be fixed up before relocation, when the
environment is not loaded yet. So, once the environment is loaded,
unbind the panels not selected before the video devices are probed. If
the selected display is not described, as for a display supported by
Linux only, unbind the video devices too, so that U-Boot does not touch
the display controller.

The splash image is loaded from the partition 10 of the boot device,
falling back to the built-in Engicam logo.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |  88 +++++++++++++++
 board/engicam/stm32mp2/microgea-stm32mp2.env  |   8 ++
 board/engicam/stm32mp2/stm32mp2.c             | 104 ++++++++++++++++++
 configs/stm32mp25-microgea-rmm_defconfig      |  15 +++
 4 files changed, 215 insertions(+)

diff --git a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
index 4cc0d47e999d..feca4e7d5f26 100644
--- a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
@@ -4,6 +4,7 @@
  * Copyright (C) 2026 Engicam srl
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "stm32mp25-u-boot.dtsi"
 
 / {
@@ -12,6 +13,93 @@
 	};
 };
 
+/ {
+	panel-lvds {
+		compatible = "ampire,am-1280800w8tzqw-t00h";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			lvds_panel_in: endpoint {
+				remote-endpoint = <&lvds_out>;
+			};
+		};
+	};
+};
+
+/*
+ * Displays supported for the splash screen: the Rocktech RK050HR345-CT106A
+ * RGB one and the Ampire AM-1280800W8TZQW-T00H LVDS one. Linux describes
+ * them in devicetree overlays instead, and the board code keeps only the
+ * one selected by the "display" environment variable.
+ */
+&ltdc {
+	/* RGB output: the pixel clock is the LTDC kernel clock */
+	clocks = <&rcc CK_KER_LTDC>, <&rcc CK_BUS_LTDC>, <&syscfg>, <&lvds>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&ltdc_pins_a>;
+	pinctrl-1 = <&ltdc_sleep_pins_a>;
+	bootph-all;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ltdc_out_rgb: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&rgb_panel_in>;
+		};
+
+		ltdc_out_lvds: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&lvds_in>;
+		};
+	};
+};
+
+&lvds {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			lvds_in: endpoint {
+				remote-endpoint = <&ltdc_out_lvds>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			lvds_out: endpoint {
+				remote-endpoint = <&lvds_panel_in>;
+			};
+		};
+	};
+};
+
+&spi1 {
+	display@0 {
+		compatible = "rocktech,rk050hr345-ct106a", "ilitek,ili9806e";
+		reg = <0>;
+		vdd-supply = <&reg_3v3>;
+		spi-max-frequency = <10000000>;
+		reset-gpios = <&gpiob 6 GPIO_ACTIVE_LOW>;
+		backlight = <&backlight>;
+
+		port {
+			rgb_panel_in: endpoint {
+				remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
+};
+
 &usart2 {
 	bootph-all;
 };
diff --git a/board/engicam/stm32mp2/microgea-stm32mp2.env b/board/engicam/stm32mp2/microgea-stm32mp2.env
index 2a65b14231a3..94c78c0fff1a 100644
--- a/board/engicam/stm32mp2/microgea-stm32mp2.env
+++ b/board/engicam/stm32mp2/microgea-stm32mp2.env
@@ -13,3 +13,11 @@
  */
 display=rk050hr345-ct106a
 extension_overlay_addr=0x90300000
+
+/*
+ * Splash screen, centered: splashfile in the partition 10 of the boot
+ * device or, if missing, the built-in Engicam logo
+ */
+splashfile=splash.bmp
+splashimage=CONFIG_SYS_LOAD_ADDR
+splashpos=m,m
diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
index de06d21764c2..51274f6b9dc7 100644
--- a/board/engicam/stm32mp2/stm32mp2.c
+++ b/board/engicam/stm32mp2/stm32mp2.c
@@ -8,10 +8,17 @@
 
 #include <alist.h>
 #include <config.h>
+#include <dm.h>
 #include <env.h>
+#include <event.h>
 #include <extension_board.h>
 #include <log.h>
+#include <splash.h>
+#include <asm/arch/stm32.h>
+#include <asm/arch/sys_proto.h>
+#include <dm/device-internal.h>
 #include <dm/ofnode.h>
+#include <dm/uclass-internal.h>
 #include <linux/string.h>
 
 int checkboard(void)
@@ -42,6 +49,103 @@ static const char *microgea_get_display(void)
 	return display;
 }
 
+/*
+ * The U-Boot devicetree describes the displays supported for the splash
+ * screen. Their panel compatible is "<vendor>,<display>", where <display>
+ * is the display fitted on the carrier board.
+ */
+static bool microgea_panel_is_display(struct udevice *panel,
+				      const char *display)
+{
+	const char *compat, *model;
+
+	compat = dev_read_string(panel, "compatible");
+	if (!compat)
+		return false;
+
+	model = strchr(compat, ',');
+
+	return model && !strcmp(model + 1, display);
+}
+
+/*
+ * Before the video devices are probed, drop the panels other than the
+ * one of the display fitted on the carrier board, so that the display
+ * controller drives it. If that display is not described, drop the video
+ * devices too, leaving the display controller untouched for Linux.
+ * This must run after the environment is loaded, hence EVT_SETTINGS_R.
+ */
+static int microgea_settings_r(void)
+{
+	const char *display = microgea_get_display();
+	struct udevice *dev, *next;
+	bool found = false;
+	int ret;
+
+	uclass_find_first_device(UCLASS_PANEL, &dev);
+	while (dev) {
+		next = dev;
+		uclass_find_next_device(&next);
+
+		if (display && microgea_panel_is_display(dev, display)) {
+			found = true;
+		} else {
+			ret = device_unbind(dev);
+			if (ret)
+				return ret;
+		}
+
+		dev = next;
+	}
+
+	if (found)
+		return 0;
+
+	while (!uclass_find_first_device(UCLASS_VIDEO, &dev) && dev) {
+		ret = device_unbind(dev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_SETTINGS_R, microgea_settings_r);
+
+#if CONFIG_IS_ENABLED(SPLASH_SOURCE)
+static struct splash_location microgea_splash_locations[] = {
+	{
+		.name = "mmc",
+		.storage = SPLASH_STORAGE_MMC,
+		.flags = SPLASH_STORAGE_FS,
+	},
+};
+
+/*
+ * Load the splash image, "splashfile", from the partition 10 of the
+ * boot MMC device, i.e. the SD card or the eMMC. If not available, fall
+ * back to the built-in logo.
+ */
+int splash_screen_prepare(void)
+{
+	static char devpart[8];
+	u32 bootmode = get_bootmode();
+	unsigned int instance = (bootmode & TAMP_BOOT_INSTANCE_MASK) - 1;
+
+	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
+	case BOOT_FLASH_SD:
+	case BOOT_FLASH_EMMC:
+		snprintf(devpart, sizeof(devpart), "%u:a", instance);
+		microgea_splash_locations[0].devpart = devpart;
+		if (!splash_source_load(microgea_splash_locations,
+					ARRAY_SIZE(microgea_splash_locations)))
+			return 0;
+		break;
+	}
+
+	return splash_video_logo_load();
+}
+#endif
+
 int board_late_init(void)
 {
 	const char *fdt_compat;
diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
index 34933f1e7e41..9fee56512488 100644
--- a/configs/stm32mp25-microgea-rmm_defconfig
+++ b/configs/stm32mp25-microgea-rmm_defconfig
@@ -38,6 +38,7 @@ CONFIG_CMD_PWM=y
 # CONFIG_CMD_LOADB is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
@@ -98,6 +99,20 @@ CONFIG_DM_SPI=y
 CONFIG_STM32_OSPI=y
 CONFIG_STM32_SPI=y
 # CONFIG_OPTEE_TA_AVB is not set
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_LCD_ILITEK_ILI9806E=y
+CONFIG_VIDEO_STM32=y
+CONFIG_VIDEO_STM32_LVDS=y
+CONFIG_VIDEO_STM32_MAX_XRES=1280
+CONFIG_VIDEO_STM32_MAX_YRES=854
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_SPLASH_SOURCE=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
-- 
2.43.0

