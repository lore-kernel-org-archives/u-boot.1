Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911B5C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9759836F0;
	Sun, 25 May 2025 12:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MQkx0UeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97B4983721; Sun, 25 May 2025 12:48:42 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFECE82CCE
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a366843fa6so809484f8f.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170120; x=1748774920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzG8E0zWJpDT09infXpZgomlJwI2jm/0RM9eVG/RzRU=;
 b=MQkx0UeCvXXcrdB4agATzY9sk7hW+9bcxnji5AhWzuqX2B+AkOjOGNIOEkmoAV2R1R
 MIY5YZljBhoFvuurB2s5HMHesdUXCQMae1AoiYRP0NUAVLtTn3cNV/YYLumdvxuNGM6d
 JMqNqYgR5qQBPAKlaeGJ4buU6WkG//FOeicuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170120; x=1748774920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzG8E0zWJpDT09infXpZgomlJwI2jm/0RM9eVG/RzRU=;
 b=jtZzPHQHMOG/n/acWtnuWLHL9Tp4cVz9r8C5LtomxUYDiJB2MGYE8gY/E/qHfLRov7
 hb0ioQ3V4Y5G2Yd1PMn62Ln61e954mXDBVsWhEIqnWCyIiNGow8UsiVZrR1UlS7remxZ
 tveRo26U1Et4c60ZqNQMkO0udfo43yJ1W5pUXhS2c/MLoRqJg3cfkKGxDRZYb8fnZmem
 kbAIB6Oj/hRU4SAcaoohDRFbMtWFEVAg1MfU8z1kgcrxyqsOAkWHsoK5Urjvg7aX3Zoz
 alZwsKIGXZuTHXWuOu6r3NKhRhWlSAcOMsdtwlhFPbO54981eAFZgCmsjofQAMDlTFAA
 0iXw==
X-Gm-Message-State: AOJu0YwKNaWXwQy2zkWYer8WhzFNgFtM7/2/cB3W0q2wqC/qyA79c9v/
 42HcYSo6Bh3kKQYLK5nJGxAdDNm9iMoo1/UhIwJjjodvllGoYVoflT8Y9Mp9A0knhuOLkSJurJn
 BHEF270Ra
X-Gm-Gg: ASbGncuyOQCocExQvQyGG4CGHMOPxaRJP707TZyD1SQU5W5SI8vslrgE7VokOrhMhUD
 WAWWVGFNse7KJoGFKDuZU1M8lXhVU+VmwxAS5USPvPc6BUQt53tQxnzVUwQKr9idhbagPuBKoTi
 KeBo0RW4yPyC14nMe+Pi+V25Xl3xV7fIvzA/Dgxq+TWcnWdk0Uaay4iS2olS+lCR7zMYczm97kE
 m2qYmRn67GQ1vkgvzFvt6N0q5FpzxRFxkFN8huzFU9LYDhM6EBtq+8KuUB+5UdazF1FyASktz09
 /LxrS6k3bEmrnNML2p1DceHFWi2OTPK98kUcWzCTQnj45FbiOUZsVigXz25ZKmTBHK42QfO8ZFD
 k+WXu6g==
X-Google-Smtp-Source: AGHT+IGi8Vxcd/MFWYFba/vqDXQbp057vazfKQJgo/ECxtj0AWiGm5T3fAmXu4WkPgPBB9zqRbdbkw==
X-Received: by 2002:adf:ec4d:0:b0:3a4:cf40:ff2d with SMTP id
 ffacd0b85a97d-3a4cf41007bmr2483102f8f.21.1748170119710; 
 Sun, 25 May 2025 03:48:39 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Greg Malysa <malysagreg@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 20/25] rockchip: Set the skip-at-start property correctly
Date: Sun, 25 May 2025 11:47:56 +0100
Message-Id: <20250525104801.1440260-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

The rockchip image is written to the media at block 64, which is a 32K
offset, so set the skip-at-start property to 0x8000

Update CONFIG_SPL_PAD_TO to point to the offset in the image, since
Binman is dealing with the 'missing' 32K now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Move this patch to the end of the series
- Drop 0x8000 offset for SPI

 arch/arm/dts/rockchip-u-boot.dtsi | 1 +
 common/spl/Kconfig                | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 905706c68e7..8da3c1c2a98 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -170,6 +170,7 @@
 	simple-bin {
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
+		skip-at-start = <0x8000>;
 
 #ifndef CONFIG_VPL
 		mkimage {
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index fb6c90733ee..fa28c18fa48 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -96,7 +96,7 @@ config SPL_MAX_SIZE
 
 config SPL_PAD_TO
 	hex "Offset to which the SPL should be padded before appending the SPL payload"
-	default 0x7f8000 if ARCH_ROCKCHIP
+	default 0x800000 if ARCH_ROCKCHIP
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x11000 if ARCH_MX7 || (ARCH_MX6 && !MX6_OCRAM_256KB)
 	default 0x10000 if ARCH_KEYSTONE
-- 
2.34.1

