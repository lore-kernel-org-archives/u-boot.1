Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13763CCF9E3
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2AF83710;
	Fri, 24 Oct 2025 16:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tR4jNL4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A33282A9E; Fri, 24 Oct 2025 16:17:19 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7616483655
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 16:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso26331715e9.0
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761315437; x=1761920237;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vGwQK8X1pi9j/TfBL9xE3rbgOKa05VyAan9hXgtAwvg=;
 b=tR4jNL4sEpsh2A6OsRXXb7glAetVlpfzbItNSBeA21Ipg9yKWFG+dLVeBu8Il6Drng
 p5ICR0oRK1RCEK3mLc38fgRJEEsaG0jxye/8d7ujVqNQ4paEw5xFcLUb+7sbUQPti2Ud
 iDR4LgMszmytA0Ir6XJjleLIRqVytttx0sYVuzJqkG9clgenlZb6yfaTKmGJCfmA3IGk
 T6VmwknNdU0KDDhqKcZwUevRQLtpBdLfWIYNZ2xaTjJpW75N5cUlM2I0JDqF9iaSQalz
 NLnnw3clQTT4uQX5WPxjHSht2Y11vmG/RrUUfNeYPAWEAHLKC0nZWW0sGYth4j+Rzegr
 hAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761315437; x=1761920237;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vGwQK8X1pi9j/TfBL9xE3rbgOKa05VyAan9hXgtAwvg=;
 b=Dbbv5WmFfa8xEv1yF4s/X1id4BuKmKjNQbsAcpoou1CogJGX0gSvfJRIiby2myC6nz
 8A3kWKtCacBMRMaitoMBphU663I73Nhh7Z42EmtpQ03JpxLahuq2J9hCEYcLim3GNICx
 eURYxJHgHJs1DCkgWemZQen1Itz4hoIn3evgS00c78HTwPG0Fx9azbufxnjGg9zT5It6
 6gLYSQ7fxJLFMBIHhpxwd9sB9i1aAu4QF5Rts7jHT6Gq7UgK+jQ8iJGcgAtUpWU+aU/W
 Jg1kkK2sxT84XOMhjoiB6ij6w+YO56mb5xCtAYSjC/b2r32eFJujzVtcCKGGAIvCBN05
 kNVw==
X-Gm-Message-State: AOJu0YxAbmnafYBMKRbT6UmbCfSdjiavMudF7LKYuW709BtXHmb0UM7u
 ge/W9+MgKaRLQFeWWkkYjHDDNMpmzdZJJpNq4DK1liBBcUN6lomLhiCwDK4sFm1KG9o=
X-Gm-Gg: ASbGncsOwhg8Vey8O6hby8hX9qs1Qfwb03WKSMF9ce896vvk3mOZTzX7lPq/k9yNrxv
 LePmlX0k6qoOrl/YbO0nxMeupZ/Z2upoLnbn653rVjJYULA1JNBuCBMkfTG6d5WV9AFUk6STSWy
 UlHfHjHGa3lVp5Lo6+yJ/A2Z0HNcGcKJ1JqJqfKah398HSKJBOMvQxbEGQn45L8cSNuJ1IPVFHU
 KWaW8sFqFaHK5yOa1Zsq/apBILzwFu5aH+cIqJV27ccQlkkdj+Byu0UytvA04SufO8rewBPP1fg
 OF2M3C3u0odTeQraNX6APw1VP0KjxwI9ZZH0SirJcdBfP6LBduY/Xi9tlw9uyS3CEq87o1l2jVY
 X59ma/S+bNl87fhR/gB0pv5mHrz6ccn0xoBJtgdPBwhQ3okhSXqzMN+TZoSg+ogYbL8uCeEruUa
 hXXxzpJS0oY85GIQ==
X-Google-Smtp-Source: AGHT+IF9VgJ9K1RwlJMHFYObDxd98d7xzEo5J39fIFe14I4R76KiRJNUboVm3Dyog/6eD3jQv+tN0w==
X-Received: by 2002:a05:600c:46c9:b0:471:747:2116 with SMTP id
 5b1f17b1804b1-471179303d0mr217391375e9.41.1761315436810; 
 Fri, 24 Oct 2025 07:17:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:a5c0:bdf6:3b95:6cfd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ccc60sm9656065f8f.34.2025.10.24.07.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 07:17:16 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 24 Oct 2025 16:17:14 +0200
Subject: [PATCH v2 3/4] board: am64x: Use generic AM6x board detection
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-am62xeeprom-v2-3-0e372347e7d4@baylibre.com>
References: <20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com>
In-Reply-To: <20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Neha Malcom Francis <n-francis@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Prasanth Babu Mantena <p-mantena@ti.com>, 
 Judith Mendez <jm@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dhruva Gole <d-gole@ti.com>, Andrew Davis <afd@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aashvij Shenai <a-shenai@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
X-Mailer: b4 0.14.3
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

Replace the board-specific implementation of do_board_detect() and
setup_serial() with calls to the generic do_board_detect_am6() and
setup_serial_am6() functions.

The generic function provides the same functionality with
additional fallback logic to try alternate EEPROM addresses.

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 board/ti/am64x/evm.c | 45 +++------------------------------------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index f9bb593e4c6..3688cf2ca25 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -114,30 +114,11 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
 #endif
 
 #ifdef CONFIG_TI_I2C_BOARD_DETECT
-int do_board_detect(void)
-{
-	int ret;
-
-	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
-					 CONFIG_EEPROM_CHIP_ADDRESS);
-	if (ret) {
-		printf("EEPROM not available at 0x%02x, trying to read at 0x%02x\n",
-			CONFIG_EEPROM_CHIP_ADDRESS, CONFIG_EEPROM_CHIP_ADDRESS + 1);
-		ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
-						 CONFIG_EEPROM_CHIP_ADDRESS + 1);
-		if (ret)
-			pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
-			       CONFIG_EEPROM_CHIP_ADDRESS + 1, ret);
-	}
-
-	return ret;
-}
-
 int checkboard(void)
 {
 	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
 
-	if (!do_board_detect())
+	if (!do_board_detect_am6())
 		printf("Board: %s rev %s\n", ep->name, ep->version);
 
 	return 0;
@@ -154,7 +135,7 @@ static void setup_board_eeprom_env(void)
 {
 	char *name = "am64x_gpevm";
 
-	if (do_board_detect())
+	if (do_board_detect_am6())
 		goto invalid_eeprom;
 
 	if (board_is_am64x_gpevm())
@@ -169,26 +150,6 @@ invalid_eeprom:
 	set_board_info_env_am6(name);
 	ti_set_fdt_env(name, ti_am64_evm_fdt_map);
 }
-
-static void setup_serial(void)
-{
-	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
-	unsigned long board_serial;
-	char *endp;
-	char serial_string[17] = { 0 };
-
-	if (env_get("serial#"))
-		return;
-
-	board_serial = hextoul(ep->serial, &endp);
-	if (*endp != '\0') {
-		pr_err("Error: Can't set serial# to %s\n", ep->serial);
-		return;
-	}
-
-	snprintf(serial_string, sizeof(serial_string), "%016lx", board_serial);
-	env_set("serial#", serial_string);
-}
 #endif
 #endif
 
@@ -199,7 +160,7 @@ int board_late_init(void)
 		struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
 
 		setup_board_eeprom_env();
-		setup_serial();
+		setup_serial_am6();
 		/*
 		 * The first MAC address for ethernet a.k.a. ethernet0 comes from
 		 * efuse populated via the am654 gigabit eth switch subsystem driver.

-- 
2.34.1

