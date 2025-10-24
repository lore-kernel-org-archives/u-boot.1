Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F14CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9531837E4;
	Fri, 24 Oct 2025 16:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K1/HjH+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 469F783655; Fri, 24 Oct 2025 16:17:20 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F732836C8
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 16:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so17255875e9.2
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761315438; x=1761920238;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1MH6ndKebsrGexL2kaYr+AZ3buvnQI8u3IwdFWHGHfg=;
 b=K1/HjH+EpgcAUmYjpI+nAxITyos9dJxa+SmdzCXSravfMLzwDlLQWzE2RYbiIDThRB
 RyJz+lUpM/edwXfCr9hPTrLELVI5DjV88qrXJoGIXQfBZr+E/Fz+Edd+5BGgTGKIIxo7
 qL2zwtwYRfKKNvoCbKX7D23p86N3/YS5CASQ7eIRTy6vntrraF+8cyxZtCZmbBcGEz0N
 36W8pit0PbVzh0hsyqiAKhlmaFShcjh6d320o8pm9+8p3weR/WzxN4RWW3uhMDGgc+ob
 9Jza+JrwNj/gEOrMq8M8Fae8zou6QaSkIRjKCuJjq99neMf9NP0xddEtC//ybKj9HJTi
 ycjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761315438; x=1761920238;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MH6ndKebsrGexL2kaYr+AZ3buvnQI8u3IwdFWHGHfg=;
 b=fauxKGZEBf9JRJkBdbgOJ+uxQ2I1DWo5uE1v7txMUa1Iz4OnKcMuu9VzcPffm6kaiA
 wC59KPJpEql1ZZafyLdAjwr+F/f8RHPeWYNCerH7B5ciZMiPQP7MgF3BD2WjYjlnLagY
 vEh/mI+9k9RlpdbE9+8VDOC9d9Bf6iyFOqn3H5lczFr5PaNMXK3i//4h0OT3H808sjq4
 blVkDrmC7O5QNqUBEK/Fb/6nZwy823uNelRw8sm4wmiH6jVmuWjFab/+vqkrv12/N2cI
 XJkGO0RQ+Uc6cjy2+mwCsrM581t8U+bNDO65gY4vaE+Gy3dDQl1g/KGDJenGqk40y0OL
 w9Lw==
X-Gm-Message-State: AOJu0YzCQ8LzWwPBxm2EY04JA9grNq/WZvJXFRYTrrMre8kmJEkhK0u5
 YrFp3MY2gUTb3TiF5OtUykwe3ip5es3JqtApqJDSGKHibhO/1CPJvI6hmtNQX/ktfHg=
X-Gm-Gg: ASbGnctj8LROPA5wy4ORHeLjdY+d+zcJZn5b9b1GpULa5VQELSTrtnVDMdBErIr5GvW
 fsWyXiFXsTnw8b8vTpwKo9AIqFkRbC6huzu2MP0CxwYFe27DYF9d1pFlIlHrazShZ3xeFlAl3jM
 a36nE1OpbuTASvbEAhtWMN4LY6/y0Fo8BvNES0JYOVrvJGiQ/PIzlE56BW5nmjQzOTtp020zj3w
 fUEbXU0W8jFxHZWP+bMqnLkydOVJd/JCcuwQr6zQDFa+JKjVVATm6RIpPfS2C/0iB31MJBrByEU
 eFRf0Rl3QoKIZlnykiIC3LmFVd1J0228rL5kGONWQyP/XOi/u3rzz9G1EJysJ+zvRcEQKJSQl/s
 xmbDYnuyAhMcTglWCRV/raXYQlSDydwYBnxrM0SKCTqAuP7MLB6Oy0UxhxHWlGoQzzT5qbrg5m1
 k4Vos=
X-Google-Smtp-Source: AGHT+IEbwUR9ioohp9OB7AY7UnnGLJEnVtEsuAGsHKnSeug/PfvbZARLZRxgXtaaYDXD/vMHsHr4BQ==
X-Received: by 2002:a05:600c:458b:b0:471:16e5:6d7a with SMTP id
 5b1f17b1804b1-475d2e7df18mr19051035e9.13.1761315437785; 
 Fri, 24 Oct 2025 07:17:17 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:a5c0:bdf6:3b95:6cfd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ccc60sm9656065f8f.34.2025.10.24.07.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 07:17:17 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 24 Oct 2025 16:17:15 +0200
Subject: [PATCH v2 4/4] board: am65x: Use generic AM6x board detection function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-am62xeeprom-v2-4-0e372347e7d4@baylibre.com>
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

Replace the board-specific implementation of do_board_detect()
with a call to the generic do_board_detect_am6() function to
avoid code duplication across AM6x family boards.

The generic function provides the same functionality with
additional fallback logic to try alternate EEPROM addresses.

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

