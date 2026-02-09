Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB62E7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 337CF83C23;
	Mon,  9 Feb 2026 18:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="imhUJGY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BCC683C54; Mon,  9 Feb 2026 18:27:27 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102B883C54
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45c889aba0dso3433210b6e.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770658044; x=1771262844;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+NORPSMZCz5cmEUjzbDbHMSHtKv4rQgC9bGJeW/Yrtw=;
 b=imhUJGY36aaUv3DJYKRxUNxYmI8sYJm1fGKQCVBlgvtKB93HCAVzJDNRfrdZhQtXkk
 d8+TWQImxC2ac7i4CvotRlkTvV6ip760b+VYc72ue7I3O7tPumJF2+YiLmKb7Y20kBeo
 c/MdGvcqzdysjM0Alu1lvtkJm5OA69nUeegx5eUkaeF+jknz/Etak0sVW8dwzxlwszek
 21DJUjfYZm3lzxVtb+9kO1M77UWO+nB+MhdfVhfMZDCLq/t/Tz7p9WGuiiHQmPJsVqt3
 s1vLX7bZgqkh3VuJ0NZjQFpbXtvjF7sTmWoguPm6sxbZmglleSr/P8OBbZCQDm1hXqkw
 5v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770658044; x=1771262844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+NORPSMZCz5cmEUjzbDbHMSHtKv4rQgC9bGJeW/Yrtw=;
 b=jfRgYuV0hxoPqSIVIyYA1MFAorLECfrNtoNn41xPZnK4a73eRgoP/naRKevjbX/zSK
 AO5gJs2JXutGqbtNzQ2DYrBL8dUb1yaQN6L3ZJjjpxMzVvPY0kVcotoUCP1LWxyTgS/k
 fEAPvpdvV2VOtbah3lAhBf374vIhGg+znSIZZCfogmvzUYYv0jqSDeSTPgIYBNg9wf92
 KEnNSZ8Zk6vGEAv3ucE0vzvoBjMA+7WhC7a8H215CAzdNAHeBVJxqUufPG+bLeaRFIGn
 2TemvjyaYXeFAR+Zi/ZK4j0hD6FeWolgfMEC1G+JYds9VhIaUntYUau+GhYsh79WlaBF
 ao5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdxjpCV766j3CEojCcCGVohw03iNheGiIEIWQNT9Ad72jA6HrjW6MYz0QOTi5+6npCDx/0hFg=@lists.denx.de
X-Gm-Message-State: AOJu0YwVkgzATAp+s9D5gueGwgIm/0dGvzxllYreiq70yT90yi4dN6vw
 MiTirm79fM+vv2oiECzOuksJtlih3PWqxURUVbSK3Noh/wrlb9/W/4zby371jwUKcLE=
X-Gm-Gg: AZuq6aK8DiCcJDCofhqY3zYeSDLen07kdzPrMSX7AHUk4dDeSTUakRmtVkS1Frh0XCB
 xqO6xC5BM+swRYbPypunVk/k2GvOCmwOp0hr+woerYSarURAq97xN2HSa5ycyx4splUaMSRb7NK
 c/DF1gqzAegTGwHefDwnYQgrpHl3Ket49vVsiUUcG5K0V4Ad0G63SdTI5ciDcXeVg/N95Ca5a4g
 5+2ReOyt9Hws63I+h+jQySubFN1hRlgl1MHxpRELN11H+rpo+w/vycHc02TkHDTdWtbHN1MqrkT
 U1jMJntrYFX99i/6Ry+zs+VuCWoKBKm+nUTKAHl8cDj8hWfRhLRBjqtxSBcxlqLiusHOQ5evxQR
 TUVc+IZziTJxMPNMXCnJZuTRm7tdxMd2qJBHq9NGHxtiiLhhsvoJPI7IjqeL6FyvNUJs1th4Rbc
 3xLCDZ3fgwR6Du67U=
X-Received: by 2002:a05:6808:14d0:b0:450:b92c:aaa2 with SMTP id
 5614622812f47-4634f86fc5amr88500b6e.18.1770658043809; 
 Mon, 09 Feb 2026 09:27:23 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-462fe9de7ecsm6695383b6e.9.2026.02.09.09.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:27:23 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 11:26:55 -0600
Subject: [PATCH 1/2] arm: dts: mt7622: Fix SPI bus bridge warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-dtb-fix-spi-bus-bridge-warning-v1-1-84e3e2d8352d@baylibre.com>
References: <20260209-mtk-dtb-fix-spi-bus-bridge-warning-v1-0-84e3e2d8352d@baylibre.com>
In-Reply-To: <20260209-mtk-dtb-fix-spi-bus-bridge-warning-v1-0-84e3e2d8352d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=nQWgngks15mffGIbkp0Tvi68thR3PKnODzgLSZD+rwk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpihjscIq0CVmI9XKV39DK6ptiiuaDmk22YHVkH
 iRJ5Yhwbo6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoY7BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AQlQIAKBE9IAoufdwGlwqpHIU2h3wruD7hT2qib+r2YR
 fO/MPFZvwCx2H16Ss3gwYF7HSBIKp0Ic5occRw95Y2wTsSuSIE6TlSgvZcGV+2ow/GdoqJleLHF
 1JOcDZbZ+GAqZWRqxY8CdryyhjBvYhcy/uIhafV6WU5SWCX6TLBKwoCXT4wo+uYwliUh8fXslWF
 N1SZ06D6H6xs3FdzXVYSP4dtJIkOkR0BgTcLHeJnhp9oh4Z/a3t2LYT/pxkKCWUCaJB63/d6SdZ
 unYi8ulT3yyEAc8pwgErNzNX8i6Z7v5Zj8c7hS242Pc4C5dxu5s5y3v7vxrj+sMaXJwGBmHi6bj
 GxXU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:38:26 +0100
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

Change SPI node name to generic "spi" in mt7622.dtsi. This fixes the
following compile warning:

    w+../arch/arm/dts/mt7622.dtsi:56.22-65.4: Warning (spi_bus_bridge): /snor@11014000: node name for SPI buses should be 'spi'
    w+arch/arm/dts/mt7622-rfb.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt7622.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/mt7622.dtsi b/arch/arm/dts/mt7622.dtsi
index 2d89fa08b4d..12c501711bb 100644
--- a/arch/arm/dts/mt7622.dtsi
+++ b/arch/arm/dts/mt7622.dtsi
@@ -53,7 +53,7 @@
 		#size-cells = <0>;
 	};
 
-	snor: snor@11014000 {
+	snor: spi@11014000 {
 		compatible = "mediatek,mtk-snor";
 		reg = <0x11014000 0x1000>;
 		clocks = <&pericfg CLK_PERI_FLASH_PD>,

-- 
2.43.0

