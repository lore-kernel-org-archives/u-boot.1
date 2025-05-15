Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422F2C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A250682BF2;
	Thu, 15 May 2025 16:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rQC66Pub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A0782C49; Thu, 15 May 2025 16:56:00 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C06982C30
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so8295875e9.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747320957; x=1747925757;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCeQwed33O8/cupvpVNiSMnnjyWuZD/E8lM3+ypML7M=;
 b=rQC66PubNmR6KJX5utP3gxjHHw6vqUZMYwI/AG4/9Sj4WB2+oFjGAsYIa8iE7zd9v5
 SUfBIm2UyWd0sUzWo52OVULYG+8R6DBZ5oR18cVJ1XHXNscNdZELVFIXq5QXgLjs7hSI
 vgI8lv5nOytB8IXAqjDtWfpkTxyVM/0SAjlqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747320957; x=1747925757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCeQwed33O8/cupvpVNiSMnnjyWuZD/E8lM3+ypML7M=;
 b=WDDLIZyTX90lOCGvZF33yq7GNPdQomzTeO4x2cfr0rO2iKDNKw35KPiJs7eZ52odGb
 e8DK+JpgKNPrNTCcwG3fNTSJXsun7Qe41KOy32K6D3HXwGw8MXHyJe1CH7KLBhzkHLL1
 zJ9YtwG53wZxNBYTBretXcgJg6dWXdLQHa7KQE5HmGrbLLnnlwcNbXE6Wxqgrvd6CBhJ
 FcKzz/K/oAi0Grye0jwdq0KCalusfQ1Rg5UL2Ks1XDJHNXRLR7R0kroa6UHMQzsytApG
 10DTGLxNVyx6asGF32es0SDR+5iwisIGzoPv6c50xkGhZMdQDRiv8o5TrsAqddMNWd1r
 mTgQ==
X-Gm-Message-State: AOJu0YzJ/MksbcF+QrTMQXurGiN/XZG94ZG+m3VZa4QwtaJ7CbC5k25P
 dJQ7rOHP4iRLgtOjKKQP/QbrnJZahRh6sO08uQbQjX58WQrwLtPWIW7i5kb9jdZ/CC4Gh/m31yC
 twVc=
X-Gm-Gg: ASbGnctxkMqUvKULgvcr5cO9BtRbUdfS9UHbjfZsG6wPsZkk/0jaMoHCNbBpCfcdk/5
 HWfR50QRZRPN1TzoETmmM2muA2WZMQtrQhnHFC9A4igUIrdmaQAY9cFgbmu5Mq8NAcG++ryO3Vy
 Bc8hPt36cvfRjkzRweJmRaH21dd1X+RYaoj/sBSGjiONhPB5c1J8lUFZNyZaarCc7BhYzYmO5XT
 oLaZE5fms8+Dlu8vNi9aMZV5Yz0nOKbpx3qyoL9G34jJSoKQSuDtaTAPTFTjJg+LNekfqujISXq
 ZYwtFNDaQistHkI6hnhQ6HGICrhqXBmyuBfEXwQaiJpFbyaboykZT+cUOXCR/kKVPqGwPiWlUFg
 3im0DCRKOiISynZw3IEOOIgsZaS4lKTALbzjwAvCwqhc=
X-Google-Smtp-Source: AGHT+IEoPKKzGJvU2UJJq7H/to03yvGkcdZFhpUAC2eSOv03ohhV89+pjgsrH1zhqkzIvPbw6X0Fqg==
X-Received: by 2002:a05:600c:4ecf:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-442f217a414mr90465715e9.30.1747320957570; 
 Thu, 15 May 2025 07:55:57 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3369138sm77030235e9.8.2025.05.15.07.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 07:55:57 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v2 4/4] serial: mxc: restore booting for imx8mn_bsh_smm_s2
Date: Thu, 15 May 2025 16:55:37 +0200
Message-ID: <20250515145541.886857-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515145541.886857-1-dario.binacchi@amarulasolutions.com>
References: <20250515145541.886857-1-dario.binacchi@amarulasolutions.com>
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

The commit dda454e933c6 ("serial: mxc: Support bulk enabling clocks")
breaks the booting of the BSH SMM S2 board.
Restore proper booting of the board even in case of failure of either
clk_get_bulk() or clk_enable_bulk().

Fixes: dda454e933c6 ("serial: mxc: Support bulk enabling clocks")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v1)

 drivers/serial/serial_mxc.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/serial_mxc.c b/drivers/serial/serial_mxc.c
index 28f4435d01dd..b09a5fe0f7a4 100644
--- a/drivers/serial/serial_mxc.c
+++ b/drivers/serial/serial_mxc.c
@@ -310,22 +310,31 @@ int mxc_serial_setbrg(struct udevice *dev, int baudrate)
 	return 0;
 }
 
-static int mxc_serial_probe(struct udevice *dev)
+#if CONFIG_IS_ENABLED(CLK_CCF)
+static void mxc_serial_enable_clk_bulk(struct udevice *dev)
 {
 	struct mxc_serial_plat *plat = dev_get_plat(dev);
-#if CONFIG_IS_ENABLED(CLK_CCF)
 	int ret;
 
 	ret = clk_get_bulk(dev, &plat->clks);
 	if (ret)
-		return ret;
+		return;
 
-	ret = clk_enable_bulk(&plat->clks);
-	if (ret)
-		return ret;
+	clk_enable_bulk(&plat->clks);
+}
+#else
+static mxc_serial_enable_clk_bulk(struct udevice *dev)
+{
+}
 #endif
-	_mxc_serial_init(plat->reg, plat->use_dte);
 
+static int mxc_serial_probe(struct udevice *dev)
+{
+	struct mxc_serial_plat *plat = dev_get_plat(dev);
+
+	mxc_serial_enable_clk_bulk(dev);
+
+	_mxc_serial_init(plat->reg, plat->use_dte);
 	return 0;
 }
 
-- 
2.43.0

