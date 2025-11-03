Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E764FCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 18:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FBE583936;
	Mon,  3 Nov 2025 19:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wj1e+OCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15576838D7; Mon,  3 Nov 2025 19:40:23 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 166BB836D1
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 19:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4711810948aso33738875e9.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 10:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762195220; x=1762800020;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FUoz2a4/M+gQBp0Z+AwPc3eJoB4/KIwAz5jGeijGQek=;
 b=Wj1e+OCuJ1duSjHMrlocbcPUqDQCWXPXoOx9YjVVUHkE/9RvkLR4Iw9WJ7WKrnGfvX
 aMW0aw+XEX2qKr6+i4946ohGY7EvzxbcGRo344nbCdpStV51ariJ2dJYP0cRNbO0bDf0
 Dxi6cgxTVubA5or2tV0D15//DV2wlJR5hSmpCJzTStn9h1m2YFszbv3k6dwXaKjKOh4S
 U77D4Yn5N8LNZ68WH0+tDG3GSntJ5h8F0eqii52Ja4sBEfshqdFmWRBFmFBKwpg45cxu
 +vK18n4cv2gUeFM11fTM67jrbfKrpQW72ZQAvdAgZAOYQaHEFSyZLd1rT9xnSi7vH7VY
 9X8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762195220; x=1762800020;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUoz2a4/M+gQBp0Z+AwPc3eJoB4/KIwAz5jGeijGQek=;
 b=kYlzgO8GD6Wt7jj/wa36fiEwkMLp9nCFCMFgkZlyRhxinPd66nk+LbwTfyanIhmeYS
 ehTLLusR08KKh3bOrmPVbAokQxgNx9017EFZ9t+0vCk+atVb3PwU6oLVLVbdS/a+n21b
 SccUM3gviDdsUf7GBO8eDm6SCVYlbN71LN6y8eph1CHHbwPsQ6F/VQnj7QmSQhSFCiTm
 Q+TXnZfnyAuivTVZ9SBe3obJi2F+Wy2mbY3WQUBiuomJZ4KOz8pXtkV6oJOqeeee8/zg
 bULQaciejOD9GK5Xz4xn6LT/DMSlRw0qLLqWgMY2CRsrrwJTJ9MAWxgMx7IkReB8Ztkf
 Wv+g==
X-Gm-Message-State: AOJu0YyXf/TEdAbdZaWxL3EMkcgJcozYCdGlsCaY+m4LSk7CCvWjcCVG
 Xwz0PRUGyqybkPqZcDz64uf2HMn4Wh1EjBQ+pYVGqaQ3LU0WOW/bS77Fhnv7eXMKs9A=
X-Gm-Gg: ASbGnctB+D2zbBitRvQvhN4lu5jbmkx8t1hgMFBi1dXva6KVPQR2miro+H3mahO6xRU
 xF65C63x7f5o/YGHfE9bzWWRIjLHjTsB8L0utM1NP/Br6IXZ/QCucMu58p3qCY34vZwQVqeOxIs
 srMWVUhGkPXdmCUvMpEdcjj3Rx1JLTNjb6MTJa4x6g+w7s52z9xL/Cv2rY+rQpbOtX7ZS1uWQEc
 csa49eVANd/RnlUbhdWi7AycJGV7TREykxjPAqf9l02gJaZ6Is6VfGUxmu64Kjan3NU9QkflYLE
 skaG0wPW8NvBqqugsb8tpkWujVM0z6Qk9C4wqVgqKxHz5NXYN6GFKLYr4p21ijpD8NxLkSEW1sF
 7fOOQs9WMTIIthmHjpJj6T0ec3E4YR/K0IUqLkfXLx/7bjuKzF710gPF4zMy5SOxvO9a31G66yu
 +tVUnRgmS8spPV
X-Google-Smtp-Source: AGHT+IGZXHSYLQ+WjT+NhM/4QlG2Vvkvpye43KtWUEkwGYKuy8XvQ1EjbEkY8GEieCI1AzpZc4D/aw==
X-Received: by 2002:a05:600c:1e21:b0:46e:59f8:8546 with SMTP id
 5b1f17b1804b1-477307e6f8emr109294955e9.17.1762195220475; 
 Mon, 03 Nov 2025 10:40:20 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:23eb:8c68:e19:f7bc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1f98d9sm160295f8f.32.2025.11.03.10.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:40:20 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Mon, 03 Nov 2025 19:40:04 +0100
Subject: [PATCH v3 3/4] board: am64x: Use generic AM6x board detection
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-am62xeeprom-v3-3-e390779c0fc5@baylibre.com>
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

Replace the board-specific implementation of do_board_detect() and
setup_serial() with calls to the generic do_board_detect_am6() and
setup_serial_am6() functions.

The generic function provides the same functionality with
additional fallback logic to try alternate EEPROM addresses.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

