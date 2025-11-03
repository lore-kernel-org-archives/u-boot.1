Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E59CCCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 18:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC5C8391C;
	Mon,  3 Nov 2025 19:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sE6dNTtK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0957C8331F; Mon,  3 Nov 2025 19:40:21 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 062DA83700
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 19:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4774f41628bso6725175e9.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 10:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762195218; x=1762800018;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CBW2vk4smWqTmhxxqefnKh7Ls8xTss10KxXafZ58O7g=;
 b=sE6dNTtK+UoB7tEgtcz4BekfOZuptbpAsOFXS56FDQ9qkhh9Of5gPstUNDmH56W76z
 HxB1nR2Ul6GoCo6YNlfq0cbc061xjpPdTQDNHVIf5j4bKn9h734+NjM6mNm6Q/Y8BQCR
 fwZhBl98vHylm17u+GPd5VfLLEfk9Z/Jclok0RH7jqjSuLneDNrnfC1iR2tTtBdBs6Xx
 pdMA7b/VxfnbRK22usRtLPgWFFiv4W/MmCBbNSFQEiH9ZsfMzipuA5fnULkZ32DOJ+RQ
 gTOVR0KM630KLHpsaRvzPjPOmn4Auk3gHUVQWzJdiFlIAnhTrC69tGw6oGSOf+nRWWII
 SqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762195218; x=1762800018;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CBW2vk4smWqTmhxxqefnKh7Ls8xTss10KxXafZ58O7g=;
 b=SEwG8G2SYDeu4zqUhr+q5qjO94mUJRTz3gWCUu9oQXCnTsvW/eiD8bdh1YR+DPrxO/
 xTgj+HEp2I/zIWTIm73GtxnxW+I1+qIPsV/pSI/TXQ3vW1rmJFPX9EjI+nMPxSaF6qT5
 8OKzSXymAbznKkGx40ruAXGoF+w3slRneC0BXHvig/jrV2tlb+8N6ipu4ZjIE0uAGcwI
 27eN6MEiSip3owgN8zfnJe+5buWqE3Nm6iBnkTmrPJ4AIwLgMlXPp4hOIATLAu+bdAZ3
 JmKMKzVjEIA7VMrgJHwx2zLzfuiq0XRTZ0/1KLq6KxSGtSG9lo0DQVMz8DbyOVXoiAGS
 yDxg==
X-Gm-Message-State: AOJu0YwSuqLQY9rLOuxOtvTDbf5Ugbk0DM6SYg6Bhx27zS6ssfy7GKu5
 GnBhffKL3Q6GWi9C1EWsIAeDHgBm+ACI9GD+9B4kst47Y3k13dN7u+apkJBCbDqTSCM=
X-Gm-Gg: ASbGnctJWvKZ9o/INq/UPBybmL6bwarGV74ehLoKMumflnDyG6AZ6LI/Z58gtdryi77
 usABj5NG8j8tXSHQozgdXCuyvSYibbzku+qZMZZQm2qDLFrpLn4IJiE9+ytsUTILsmDMJRa0qY0
 HOzDU5inskwuBjd06ssFp2d+qlhYceLGuyQyEWddh6BouCb/SvobSO+iEhT6JR7TcEDW7xqMl7C
 bSqy2dm2xu2S4DW+ROVlfh+A6uxB4spfROoBDRBj+sZ8iKm6KrmCrjPbFWTbl9tFOX9NEevw3nD
 hYTHm02Dkv7x6Zl40wf3/aPzcwU1yYxHH6hQfIfQ9xu+za2P1g/AgxV7YoBb9NKdgO80+HM0t97
 2EmNCLhZDEGOUqRfZdprZTMpT3o9UIgnEUjJ4RRrWatGm60MGl3DGbCSeKz6V7VkmiQ1InH0YMh
 3u8w==
X-Google-Smtp-Source: AGHT+IFxB+moFIrnOEthAJBv2orJUJwW9GNmWU64rnscYKdK6WUmoPaq5cShCdxV1DslTKrcZD9lvg==
X-Received: by 2002:a05:6000:3109:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-429dbcea015mr433327f8f.21.1762195218335; 
 Mon, 03 Nov 2025 10:40:18 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:23eb:8c68:e19:f7bc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1f98d9sm160295f8f.32.2025.11.03.10.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:40:17 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Mon, 03 Nov 2025 19:40:02 +0100
Subject: [PATCH v3 1/4] board: ti: common: Add generic AM6x board detection
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-am62xeeprom-v3-1-e390779c0fc5@baylibre.com>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

