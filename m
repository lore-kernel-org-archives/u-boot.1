Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D5FCCFA04
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 18:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13308391B;
	Mon,  3 Nov 2025 19:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mPKYM/Q9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276C5838D7; Mon,  3 Nov 2025 19:40:24 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118658392C
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 19:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so2908090f8f.3
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 10:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762195221; x=1762800021;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MoF4lOhXhGMMhZPc2PKtpytiXEWkgK1LlwwPxecx+5o=;
 b=mPKYM/Q9w6ZOAxglDviHNCuMUqCsC24+KfI67WrpwRLq/RXMKzLFjamiY9d8RstMsi
 nzGNQQ37L/VaD3h6mij/FBR93yOSvuerJq8gG+mh8Fr4Engh79UcEZ+FFu7Fla4phtap
 CZrKY4NjLxMp+hv+ypvgJZe62NCMK8ddgiqDY8hHVy51M1ifNHQNHzqlsTBuZ9yrNKLk
 MsqiofASSTRBDF4wBSgAR19/qkfSpbU64TeTTV7MMPNf7HxtKnvWrA/v5eTCDAuM40y1
 /+bAajR/XYhBlZThjGhC5ZrceCscv5dbhBrZ9Xx+iltnx8oeSQyxWLq4Qowz2LCPh8mp
 Fc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762195221; x=1762800021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MoF4lOhXhGMMhZPc2PKtpytiXEWkgK1LlwwPxecx+5o=;
 b=QfxYpH+ueC4aeszVz8DnUTgwCxk10HZJmlgnsW8olKE1Kj9uA0iXJzHQ57vU7v9R4W
 l8pparH56262acwPQG0A4aJVZ3ztd9DlahlzGOZ+Es3UqXHcywDrB4YhC7VGPPc9WBhc
 PI7ECwJI56s06lfjUbyCcCu//s/+UDUuwQgqz8y+QMcO7i2wThOTChIUBHyqCHP/aLFz
 3bNhXUvdNuccYAUfEek/sKqzq76T6qNmjdQlGgzUu9eWxUQZ0sgfRXkhrXSdptBeMdZi
 jPnsXcALbrR3Fh7k/bRio7SeRfz0dFSpkKOVkjM5bYIDlEvYazH/sShCMYl3A1/mQ88s
 J0Cw==
X-Gm-Message-State: AOJu0Yyx+BQoAVxq2m2Bo2gjKTgdNUx8ODWEmtw+97/Mbjy0+oztJ4gr
 e61NFvGPTgAOR7MQJ1x9VZbB7epN+nglj8wpV7z860u5Xa4TBwoR4ZM8lfR7bYB8Cd4=
X-Gm-Gg: ASbGncvwP97xI5VAv5RqImYoHhW2NRjoSS/APvkmOGlOjkzNMBpHgiDeR367ZaOXCJy
 c5GH6O/Vv4hbgn+xylYN+cHovGifXjxkHL30QgR3SdkcNU+9stuFuc9AtbWoyl0YAQSlRHT1Mat
 3Bx9LUP42+40uKbX1Zpc6tvwR+YTRHidUcZQmZmxlA8Wa5JUt57JFUkfbKyNTjg/6n34DeGAxuT
 U6rQTdHBnVRLLnr689ObMaB5jCR/Tl6i2p1og3voND8OSrKB3QYibYBxHWG+F+9WE5abPDNKImb
 VNKpfZ2q0ZzF5ZQg+gaXrwcWvchAlTeOVkEhQ+nNz3vIYGueE+C8dN5XTj/CTnpB5/CFAubqcZd
 TDnOd81egE27vB4B9S0BXRmDcmWlIOaS/gqxtUm3R+ih2ZtFCufVyRrYKb5NdjmW7Iy6tZXRDpk
 qVpg==
X-Google-Smtp-Source: AGHT+IGHtzcwvx7QHlIgHEW0OGN/07WPZ38jgBdgzNY2wlB9DzmrJf6VqX88mZCRrBrl0IyC7OFong==
X-Received: by 2002:a05:6000:24c3:b0:429:c8f6:5872 with SMTP id
 ffacd0b85a97d-429c8f65c81mr7686664f8f.61.1762195221431; 
 Mon, 03 Nov 2025 10:40:21 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:23eb:8c68:e19:f7bc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1f98d9sm160295f8f.32.2025.11.03.10.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:40:21 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Mon, 03 Nov 2025 19:40:05 +0100
Subject: [PATCH v3 4/4] board: am65x: Use generic AM6x board detection function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-am62xeeprom-v3-4-e390779c0fc5@baylibre.com>
References: <20251103-am62xeeprom-v3-0-e390779c0fc5@baylibre.com>
In-Reply-To: <20251103-am62xeeprom-v3-0-e390779c0fc5@baylibre.com>
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

Replace the board-specific implementation of do_board_detect()
with a call to the generic do_board_detect_am6() function to
avoid code duplication across AM6x family boards.

The generic function provides the same functionality with
additional fallback logic to try alternate EEPROM addresses.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 board/ti/am65x/evm.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index 5c45a33eac9..68606746d5f 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -72,24 +72,11 @@ int board_fit_config_name_match(const char *name)
 #endif
 
 #ifdef CONFIG_TI_I2C_BOARD_DETECT
-int do_board_detect(void)
-{
-	int ret;
-
-	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
-					 CONFIG_EEPROM_CHIP_ADDRESS);
-	if (ret)
-		pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
-		       CONFIG_EEPROM_CHIP_ADDRESS, ret);
-
-	return ret;
-}
-
 int checkboard(void)
 {
 	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
 
-	if (do_board_detect())
+	if (do_board_detect_am6())
 		/* EEPROM not populated */
 		printf("Board: %s rev %s\n", "AM6-COMPROCEVM", "E3");
 	else
@@ -102,7 +89,7 @@ static void setup_board_eeprom_env(void)
 {
 	char *name = "am65x";
 
-	if (do_board_detect())
+	if (do_board_detect_am6())
 		goto invalid_eeprom;
 
 	if (board_is_am65x_base_board())

-- 
2.34.1

