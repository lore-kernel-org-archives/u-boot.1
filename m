Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E8CC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E9383927;
	Wed,  9 Apr 2025 19:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DF7KYrwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5148483931; Wed,  9 Apr 2025 19:17:49 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A3483936
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so3948263f8f.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219065; x=1744823865; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vT3dvXaEBlfy0rFssbJUe6Xmkqv2WiwMKsS2gzXHFX4=;
 b=DF7KYrwaZWR+JM30hR4VLHBczodQBA9ZqkWN42l903FFcu3nomtjCIVusVdbe9xxSX
 QPZqjY6J6hjGDD/xQUPRJXwCbvKOpf60Hm0lORA/WymGgqWU0gvwvL3VkwnTY66V8nOe
 SFBnWN0GGr6NfQqrIQNzuGyu/drHxFQM7tTtmnZ95ayH0rMXp5A8SkQ1sWB8l9lwKDP9
 iQ0mJ75VwHs5Xkr1gXK/IDwpySHONJJQ1GbhrL+C1ITaWSG+xnbtbHk2HB+09X7FlxyI
 YklNJWql8M1eM3DSJuOq0PiOzDmZEiT3mSgE7CwEr1Ksq+XI4KvYfC9O1WG3azgepm1Z
 btUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219065; x=1744823865;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vT3dvXaEBlfy0rFssbJUe6Xmkqv2WiwMKsS2gzXHFX4=;
 b=UKf//ZAELQcOESDHgSljGl/bB6oHSypGGSjqoVqKJJVZjvEDxAr05SS0AFYK+rO5OJ
 3FMVZTNtp04cFsE+Y52FZ4CQZc3K2x7evyFBxb2kkOYLUmmN21lrcGh2BytZnLHW1Zg4
 rgn+DR7G+pI+ruyEykm40g7ZuDVqO8P/THh73KKcAG71nbG3pALo9uZWk4kssT9VpokF
 NwncYyU9aJZ/oivtnhn2LFps7U8asEDx6peeLdid7GZb83Fkl0IzKcyLN4C6qA803J8H
 C5WefBk9hWP1PlEHFKnYPrDPb0gzHXrtrojefg04FnZC74LDLkIbPQ/XVJb6snV+TmBH
 Vm2w==
X-Gm-Message-State: AOJu0YzyXJytEii4Gt6rsRdSbtNdzNdB9Os7/veoPWp9xQ5Yd6aH+oZI
 FExOzjNHOj+EhouZuiQrFdkuxSgFexqbimCJ9siAMY7qm0JHiUTQvQlpPSjY1Ztcs0YvHat5SaJ
 uF04=
X-Gm-Gg: ASbGncvQMA4zHtdJY+rCDEGRgRGhgG1ieg8Cjp6Yg6RZbgsoEGULNMn2ZcwCeUTL1tr
 /6BD4aRZcPcH4xqGi8Kjr8znf3IbQbOmEwp8LRfN9nmFZIXeMX2+EaKSOXU9v2lbEBfHxtKjZBR
 Wqz4+ELKpJQNZyPno+yY5raLWZiaJzWy7f0nv254GlWsvtm8rPV06DcJ91L2Mr/bcbOpVACvqp7
 JbcUHSrUo5j0vjStDWM37ns9iOqkgkSxOnBh5o30eaC1lVog0zdTFwCv0ho952IhvxjOGK+NMmQ
 Pmy9Uqo095ENXSlJYSkM16pH9cGWOQw3hoGq361V5jUru9sUERVoz0ufKj51KUR3t++gRk6vYj8
 LApkM42EBj4+pN+Gd
X-Google-Smtp-Source: AGHT+IFG8zkukJZc8+igoHPlb9+d3oYXKuGsGjIpmcbUE3KRD6Ej3j7AoWAjrjJScXv8CPpleMFa0A==
X-Received: by 2002:a05:6000:40cf:b0:391:41c9:7a87 with SMTP id
 ffacd0b85a97d-39d87cdacffmr3549840f8f.51.1744219065064; 
 Wed, 09 Apr 2025 10:17:45 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c817dsm21916455e9.23.2025.04.09.10.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 10:17:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 09 Apr 2025 19:17:28 +0200
Subject: [PATCH 5/6] mach-snapdragon: of_fixup: set dr_mode for RB1/2
 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-livetree-fixup-v1-5-76dfea80b07f@linaro.org>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
In-Reply-To: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2925;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=UZlyOdWfx8YBUxe7BHbI77ByPFSYewCyVDOmLyM8kEU=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn9quu1A4cVyCzNBMhJ52gdhK5w4JLiRVffX1KZ
 O97JUavZsSJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/arrgAKCRAFgzErGV9k
 tt1eD/9Fa+mRvYalzy1WrcJ09MeKJtsz5VFr72LUtkYQEqtmVDmWBrCHjs+ummy5pLY3pRaaSp7
 TI5HpnTO3/TW7fdfjqST8FNWEoXHSKQrKG4KHgOq6YiTMgo2n6a/xNzpobwPRuAV5v1+F0q31ta
 4D0Ymw/Po+qPTiO8qHih9QsroUEsN3bcR4A51/HkZ3VtC0++rxKfQ0T1T66FSD/LPhoJcSdItV3
 3zsjA0I1vRsAKe6+MGwRYTOVG6rU3oSZWmnjOnTOGijbt42a1kQKk4xs4oxuZb8JYl3EqrEJe6u
 C87cCEDZZR6ZhsSd6y+glR8WmPdaZRSgmiK81iwLP28cMASnfGt+3krdjTZNUCyLV+TvvkZtrda
 arxr0RgKR2sUein84Sx/e0oMsoa9fmxqThcM+Rlt79joG7UCuBudXTxfV3Kvyr76NEIv6yT7fj0
 F6J8PswOGj5KseLc4nCWFHu/8S12SjsM9VCRG43FbMV6ZH6K4OQTSTRNNS0t61C0ItVRIkKqsBS
 WdY4KqD7mudJmQAot15vNMQYryuKWARt9JcLb4kR/UIXpHyTJDfbdjunHa938K1MxVGoNMy6Y0j
 2ol1cecG9Jy8Luj3CxnIgqbUf8F9OR6NobjSAQTDUnlEPTc+IYIy0yUdgKOo/5XHW5wnKY8aAiL
 FsIa0m3g1qYEo+w==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The RB1 and RB2 have a single USB controller which is manually muxed
between a type-c port and an internal USB hub via a DIP switch. OTG is
supported in Linux, but the DWC3 driver in U-Boot can only handle a
single mode, and defaults to peripheral mode.

We did hack around this on the RB2, but the RB1 got left out.

Now that we can fix up the live tree before devices are bound, drop the
DTS hacks and do the fixup at runtime instead.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/qrb4210-rb2-u-boot.dtsi |  6 ------
 arch/arm/mach-snapdragon/of_fixup.c  | 28 ++++++++++++++--------------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/arm/dts/qrb4210-rb2-u-boot.dtsi b/arch/arm/dts/qrb4210-rb2-u-boot.dtsi
deleted file mode 100644
index 7d1375f38c44d7bd54c022fa3d390f666a35d6ee..0000000000000000000000000000000000000000
--- a/arch/arm/dts/qrb4210-rb2-u-boot.dtsi
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/* This is usually OTG but U-Boot doesn't support that properly */
-&usb_dwc3 {
-	dr_mode = "host";
-};
diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index b39036e8e0890fdf834a0dfe6966ef3dd365f3d2..62b329e2c90d7e0a374838968ab5707333edbf03 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -98,8 +98,21 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
 		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
 		return ret;
 	}
 
+	/*
+	 * The RB1/2 boards only have a single USB controller and it's muxed between the type-C port
+	 * and a USB hub. Since we can't do OTG in U-Boot properly we prefer to put it into host mode.
+	 */
+	if (of_device_is_compatible(gd->of_root, "qcom,qrb4210-rb2", NULL, NULL) ||
+	    of_device_is_compatible(gd->of_root, "qcom,qrb2210-rb1", NULL, NULL)) {
+		ret = of_write_prop(dwc3, "dr_mode", sizeof("host"), "host");
+		if (ret) {
+			log_err("Failed to set 'dr_mode' property: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 static void fixup_usb_nodes(void)
@@ -162,21 +175,8 @@ static int qcom_of_fixup_nodes(void)
 }
 
 EVENT_SPY_SIMPLE(EVT_OF_LIVE_INIT, qcom_of_fixup_nodes);
 
-int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
+int ft_board_setup(void __maybe_unused *blob, struct bd_info __maybe_unused *bd)
 {
-	struct fdt_header *fdt = blob;
-	int node;
-
-	/* On RB1/2 we need to fix-up the dr_mode */
-	if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2") ||
-	    !fdt_node_check_compatible(fdt, 0, "qcom,qrb2210-rb1")) {
-		fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
-			log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NULL));
-			fdt_setprop_string(fdt, node, "dr_mode", "otg");
-			break;
-		}
-	}
-
 	return 0;
 }

-- 
2.49.0

