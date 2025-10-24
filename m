Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491FFCCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F2483631;
	Fri, 24 Oct 2025 16:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x6PQRIz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BCBD83631; Fri, 24 Oct 2025 16:17:17 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D66F83677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 16:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475c696ab23so12637905e9.1
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761315435; x=1761920235;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G+HD+LjcLtK80L90qmLbxiuVeB+WxJLgRVTUogCiLVI=;
 b=x6PQRIz6r4Nlce2nvFy/ebgoRngGS4bO9fh6ZeDl6YX8Lwi/RirNUKX0fk8q/7EeXF
 TA7CkUjAVA05Ek3bGj6TLAFvsEucr3Wz4kVU0PnUTnlj8YTQthz1+8LkN4nkWwrLWpvx
 Nx7Irg0dVlmHdx72G7+VBbz/aUvyO3EGzM34h5LrRSiec23wdMczhJiCUjOJme8oYmPO
 thMn50q9eiZOWHL5yGmXHnoEdpjPhwIns2keDIFQBT6meAWqrdDQB7h4dZQo4XjHwXG1
 NExZK2MSozyrSnUFSNI6GWCT4qxmZnIPCnL9osdnPv1x5xwLS/kp6imf268DtuRS8tBZ
 oP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761315435; x=1761920235;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+HD+LjcLtK80L90qmLbxiuVeB+WxJLgRVTUogCiLVI=;
 b=wd3hN5YROAlktHL+QBwjpGauuN2Lk5Cc0hYLA1O8UrHpRkbndETF/wxgI8uXQ386VP
 Inxes37hH+Whx/F0jLpDDr4wh8UFc92oINFxOTbe0tZxcuV+etWAx1EwL4GwLyi6UqLQ
 mwX+uqMRRog5lizvlYGJwzK+yNiyt5ffG3ZH2mLzFLfKS9/GvOGiABwMT70TAd8pgpdx
 5Uv/qFrDutM9ot7RliSr57+lqrbZ98+NoI5YQm/VyXTwMysGZ5uPU9gLCnhsu3sYNxdf
 MizFkwzMf7R985W/T+nmR0mNyzaho0BUNDmGUVkPkljYVYJxIOQHmk1rZpqB9ACmEwiS
 0sKg==
X-Gm-Message-State: AOJu0YzytpbfDWww2Gpcf8tD/h9jKtuDD0TEwJmPvvvTqBsWNYdfjNiE
 1E8WBwqDixfVVRadAl821dqz8jq/glBpPv22zC5aWhJiG8WDlnJxvr36WGC9gfbwU3Y=
X-Gm-Gg: ASbGncvSLJuRCYHDR6wmCG3i72jjTH3/541ZQbNIHpfiCsPEgQ3QIbJF5y16osI/oyi
 6QstVUv2X1Q2/ifVOir8kfCyX6V408iYNTCtF9jjae2x+AsmulraUTHmXhmyTYgBLou30IgRdWy
 4z6FN3q5HkrDCDSdDcgJ5KbgeCZ/ZP93PucvjCNTUktM3ndINZPInpY8WrC8K3IQ0Nh9GZeHPJs
 tZ/d9EAvco7K2ot+8G8d1j4nGFOk4Lmi7rEykjVOr5yDJTdyS2u41i3lwG3sKiLuWAKet/i7E4c
 eSSkVHBF+/WAuzqC3bOoNRpt8mfCUPBeyyWdvebU4fZ+23HIhqVa71ljgYry5rvaLiibyNMZc7h
 KstFs266wMQtg90iZl4I68uiw6LPosp3r+7LLrPZnSZdn4TA85BuIixx17rLXS9U7M8I4vUp8jI
 9LYSjg7AQE+Hfo+Q==
X-Google-Smtp-Source: AGHT+IEANIr5teUY4Q1wR3qr4TCwEJKF2NBGYPmkBmgxp27T6xfkTESWMOhceBtKzSdI5122a0XV3g==
X-Received: by 2002:a05:600c:8711:b0:471:145b:dd0d with SMTP id
 5b1f17b1804b1-475d2ebf857mr19356835e9.24.1761315434691; 
 Fri, 24 Oct 2025 07:17:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:a5c0:bdf6:3b95:6cfd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ccc60sm9656065f8f.34.2025.10.24.07.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 07:17:14 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 24 Oct 2025 16:17:12 +0200
Subject: [PATCH v2 1/4] board: ti: common: Add generic AM6x board detection
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-am62xeeprom-v2-1-0e372347e7d4@baylibre.com>
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

Add two new generic functions for AM6x family boards to simplify
board-specific implementations:

- do_board_detect_am6(): Generic board detection function that reads
  the on-board EEPROM. It first attempts to read at the configured
  address, and if that fails, tries the alternate address
  (CONFIG_EEPROM_CHIP_ADDRESS + 1). This provides a common
  implementation that can be used across different AM6x boards.

- setup_serial_am6(): Sets up the serial number environment variable
  from the EEPROM data. The serial number is converted from
  hexadecimal string format to a 16-character hexadecimal
  representation and stored in the "serial#" environment variable.

Both functions are protected by CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
and are designed to be used by AM62x, AM64x, AM65x, and other AM6x
family boards.

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 board/ti/common/board_detect.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 board/ti/common/board_detect.h | 22 +++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index a43cc075b92..d49e26fa453 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -824,3 +824,46 @@ bool __maybe_unused board_ti_was_eeprom_read(void)
 	else
 		return false;
 }
+
+#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
+int do_board_detect_am6(void)
+{
+	int ret;
+
+	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
+					 CONFIG_EEPROM_CHIP_ADDRESS);
+	if (ret) {
+		printf("EEPROM not available at 0x%02x, trying to read at 0x%02x\n",
+		       CONFIG_EEPROM_CHIP_ADDRESS,
+		       CONFIG_EEPROM_CHIP_ADDRESS + 1);
+		ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
+						 CONFIG_EEPROM_CHIP_ADDRESS +
+							 1);
+		if (ret)
+			pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
+			       CONFIG_EEPROM_CHIP_ADDRESS + 1, ret);
+	}
+
+	return ret;
+}
+
+void setup_serial_am6(void)
+{
+	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
+	unsigned long board_serial;
+	char *endp;
+	char serial_string[17] = { 0 };
+
+	if (env_get("serial#"))
+		return;
+
+	board_serial = simple_strtoul(ep->serial, &endp, 16);
+	if (*endp != '\0') {
+		pr_err("Error: Can't set serial# to %s\n", ep->serial);
+		return;
+	}
+
+	snprintf(serial_string, sizeof(serial_string), "%016lx", board_serial);
+	env_set("serial#", serial_string);
+}
+#endif
diff --git a/board/ti/common/board_detect.h b/board/ti/common/board_detect.h
index b057f3b2269..26ada2a449c 100644
--- a/board/ti/common/board_detect.h
+++ b/board/ti/common/board_detect.h
@@ -313,6 +313,28 @@ int __maybe_unused ti_i2c_eeprom_am6_get(int bus_addr, int dev_addr,
  */
 int __maybe_unused ti_i2c_eeprom_am6_get_base(int bus_addr, int dev_addr);
 
+/**
+ * do_board_detect_am6() - Detect AM6x board and read EEPROM data
+ *
+ * This is a generic board detection function for AM6x family boards.
+ * It attempts to read the on-board EEPROM at the configured address,
+ * and if that fails, tries the alternate address (CONFIG_EEPROM_CHIP_ADDRESS + 1).
+ *
+ * Return: 0 on success or corresponding error on failure.
+ */
+int do_board_detect_am6(void);
+
+/**
+ * setup_serial_am6() - Setup serial number environment variable for AM6x boards
+ *
+ * This function reads the serial number from the AM6x EEPROM data and
+ * sets the "serial#" environment variable. The serial number is converted
+ * from hexadecimal string format to a 16-character hexadecimal representation.
+ *
+ * EEPROM should be already read before calling this function.
+ */
+void setup_serial_am6(void);
+
 #ifdef CONFIG_TI_I2C_BOARD_DETECT
 /**
  * board_ti_is() - Board detection logic for TI EVMs

-- 
2.34.1

