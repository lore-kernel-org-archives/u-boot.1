Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F54C28B2F
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 14:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7801D809A4;
	Sun,  9 Mar 2025 15:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YsAPAxQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959BE801DE; Sun,  9 Mar 2025 15:07:30 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E3508122F
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 15:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so3195187f8f.2
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741529248; x=1742134048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hISvsQTj6kYryNowQ+kgqECuovrORA0i4aIGkLy1wyQ=;
 b=YsAPAxQLagkZ9ivkBqhcZ9GWj+0K7XhEVfJwUZsWW6laOe42QqSc/5rlg3kXcIOTl9
 hCqjXawzSr0hgb6p/+3rWMkriNdtqXXkkm8FRGpkJu3BIi/jgCpP7eNCAgZl+uVfquIZ
 wYWYNJEMNq0bB03k9r+beqfWkmliRqoLKLePGlfpD38itjMVBO1zQQkw0YcU3W3kKrau
 cgGp2pJ4FECmg+zsDqvmESMde3P2gEmxUR+gF5NyYA9YxhgtTuf0dWl/Gy7z/lQS7WRX
 m8TFPNGe4pdR+BjR/oDWJzwfEbXv4gGYlPSCS4o5p++J7QykaKosVaBlLG/lXpremIGF
 bXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741529248; x=1742134048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hISvsQTj6kYryNowQ+kgqECuovrORA0i4aIGkLy1wyQ=;
 b=C9sRIdhAWTdBKf7K/9vwDsdAJPnZpo9jtlw0VWzuTLOXfGsCmnxMF8bSdACvQwIfml
 bPygSlf6UJFxywxwzvcVsoSZnI52Dn2rTz27wNPQX7bHDqB+2nxrtpq4huZA6yTz8TeK
 wu1SIxTWTBwLW44CmLRLUn3hlhmsmGnaAiHKtduVNqbKetQDHbL+9WTgbNkSVlLaJwl9
 vHIecE/VmmN+nlFlDRoJeYNLTzJqIn/ZXRtQmlaxnf7tpGWwOHmprtnDWNvIvpRCe2DN
 tqG25/ij9VeC//a7kZsjxIqrzvzJNEhAtcYkx2jThRYD3fstWnrIK2bA6U5c42N0HxGA
 z4HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpAH9GqX2ilUiTz6t6KsJxfJGThQAq0aFSqz71PglOFFtTUD3ixI5w4QrCkT9HZ2d6m2u6H6k=@lists.denx.de
X-Gm-Message-State: AOJu0YwkrL3MnF3RMI2jLjMIkQsHoFcuZ2iY29nCQ0wu3lNXl6ZOGrQb
 pCdaJD3aKETiC8G9IhCLAkxnyFXxAFxwQ+ds38mS4kzWMW/pJKoC
X-Gm-Gg: ASbGncuUpI3TQ6w4CyP2Wml3pWyaI0aaijPF2AEGRCamoChlR+Ba5NTNhk3HtgVHCU/
 bYigr1R1VaP/MEgyFw+FPRnKVb747FqcKpVqtebrWSB+YhJMam1cmy2vb+LwKWEdLcABhrkjWPL
 LjjV16RKwf5Gg27ZNCqb1UT9Fc/AMoTnm0TZyOOmGMqfvlrhe3041uMpU106RkjcVzlWJGOVmAr
 WY4oyrtemA7jL6tXGy7AbiHvZuPdqfHEHM6c26byGcyVQNse0hzGnGn2ogIUB57o4SKPCNyje7y
 50rXdT3zd5aOYRuifIsXBiRWiBl+LXHnnzFJv9NS5f54JITFgMPcYHS3YuXPqyp42FZJDSEKmZL
 zhqoEjd+mqm1JQg==
X-Google-Smtp-Source: AGHT+IGZENlHjcyidgIM04ViQuMFY+wlFqbB4ArZlN/U93Pk5sH7J7zNrHG9dkXplTMLY5/v3MbpQA==
X-Received: by 2002:a5d:6d0f:0:b0:390:e46f:4454 with SMTP id
 ffacd0b85a97d-39132d72c52mr7720292f8f.32.1741529248020; 
 Sun, 09 Mar 2025 07:07:28 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3912bee262esm11946816f8f.0.2025.03.09.07.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 07:07:27 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH 4/4] arch: arm: dts: an7581-evb: Add clock and reset nodes
Date: Sun,  9 Mar 2025 15:06:46 +0100
Message-ID: <20250309140652.23543-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309140652.23543-1-ansuelsmth@gmail.com>
References: <20250309140652.23543-1-ansuelsmth@gmail.com>
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

Add clock ande reset nodes in preparation for adding support for
Ethernet and eMMC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-evb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/dts/an7581-evb.dts b/arch/arm/dts/an7581-evb.dts
index be600ad0664..7b886e1ec14 100644
--- a/arch/arm/dts/an7581-evb.dts
+++ b/arch/arm/dts/an7581-evb.dts
@@ -4,6 +4,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/reset/airoha,en7581-reset.h>
+#include <dt-bindings/clock/en7523-clk.h>
 /dts-v1/;
 
 / {
@@ -141,4 +143,20 @@
 		clock-frequency = <1843200>;
 		bootph-all;
 	};
+
+	chip_scu: syscon@1fa20000 {
+		compatible = "airoha,en7581-chip-scu", "syscon";
+		reg = <0x0 0x1fa20000 0x0 0x388>;
+	};
+
+	scuclk: reset-controller@1fa20000 {
+		compatible = "airoha,en7581-scu", "syscon";
+		reg = <0x0 0x1fb00000 0x0 0x970>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+
+		scu_ssr: system-controller {
+			compatible = "airoha,an7581-scu-ssr";
+		};
+	};
 };
-- 
2.48.1

