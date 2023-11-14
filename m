Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30E7C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 08:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AFF887215;
	Tue, 14 Nov 2023 09:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iERhDew2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE475871A0; Tue, 14 Nov 2023 09:52:25 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C9987215
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 09:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso4146205b3a.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699951942; x=1700556742; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCLKamNhgMjk+Ag4SBVHZ9xSqec54un1/uZywLFnitg=;
 b=iERhDew2xOcsG79U1jnOw8uC4IynsXZMq16dLtqulVSyrYRoAkQjE4cDGNv6sBKEY0
 ULNr9CAfxZ6ZR3mKJFBUSaOp99iUiRakTfo86rTB+jjx08p7byxnY6HCnP9/+c6mRgPE
 PUQqbuoC+nhaRMHV7fImCgzDMlPsH3lsQidaqCstAkJs0o1M6QFjm+tU+t2LS8u0rRkA
 aK8tPwU7kRpYEwXF8ym9cO+4SxZETJTfkCVrGvP1P08X4C5/nhKE690r9ervotaR0P97
 QH4fbSEfYQAIaXrDZt2U7qgTO0Z/kKXOa2Y4lD3R7yDQow5kS9oiBVHoNgs2gY0yasKe
 GUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699951942; x=1700556742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WCLKamNhgMjk+Ag4SBVHZ9xSqec54un1/uZywLFnitg=;
 b=WHg84JyJLXc+YdKNyMgCauzwRx1Zn/2jwUb8oNdFLVHG+TM1LNFu8bPXTx6e3P3zqb
 cC3i0WE0ZNkn06TE4XUhl/To8nsCI4GYctvG7kodUZvErYue1G2PGQqXH2K2y7VoSHn7
 DKFFZx0fH5NCvJkNwJyGbljEpI2a39WFYadlPxjhsWrV7dhO+vjH391ggsLsJS2iJkHd
 eEN51sWKnfVmzk2+7Eai8TrlgpRfD/PlboHFwwxcE+JWU9wKumMMC4zYaQF2DmiROZrt
 gypgcoL4YmuyYKqZJBjTChcRBF/vC09wEuhH3BVimFg+NpJBYn9DuMz2fG04pxGd0RgU
 euEw==
X-Gm-Message-State: AOJu0YyVZKRxCOlXIK3ObdgqQhcbktftViHyXUQLLN6VgyVefrHZzHfR
 e6blBu5Dpqk1v5uZBXHPX2XjgFuaNh5hww==
X-Google-Smtp-Source: AGHT+IHH3+6KhcjoNyNMYs4J0mQLEUe+4dGG4+Tow0lFo9BmATVoPbH4pd8hb8sc8sNfPCmCOwhYUw==
X-Received: by 2002:a05:6a20:9191:b0:17b:1f76:86ee with SMTP id
 v17-20020a056a20919100b0017b1f7686eemr2720809pzd.16.1699951942157; 
 Tue, 14 Nov 2023 00:52:22 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.145.22])
 by smtp.gmail.com with ESMTPSA id
 fh23-20020a056a00391700b006be0bd6a4d8sm778696pfb.36.2023.11.14.00.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 00:52:21 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com, YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 3/4] serial: npcm: support skip uart clock setting
Date: Tue, 14 Nov 2023 16:51:58 +0800
Message-Id: <20231114085159.3739887-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
References: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
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

Skip the uart clock setting if CONFIG_SYS_SKIP_UART_INIT is enabled.
Fix divisor error.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v2:
   - no change
---
 drivers/serial/serial_npcm.c | 39 ++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/serial/serial_npcm.c b/drivers/serial/serial_npcm.c
index 76ac7cb80d..6bf3a943a2 100644
--- a/drivers/serial/serial_npcm.c
+++ b/drivers/serial/serial_npcm.c
@@ -83,8 +83,11 @@ static int npcm_serial_setbrg(struct udevice *dev, int baudrate)
 	struct npcm_uart *uart = plat->reg;
 	u16 divisor;
 
+	if (IS_ENABLED(CONFIG_SYS_SKIP_UART_INIT))
+		return 0;
+
 	/* BaudOut = UART Clock / (16 * [Divisor + 2]) */
-	divisor = DIV_ROUND_CLOSEST(plat->uart_clk, 16 * baudrate + 2) - 2;
+	divisor = DIV_ROUND_CLOSEST(plat->uart_clk, 16 * baudrate) - 2;
 
 	setbits_8(&uart->lcr, LCR_DLAB);
 	writeb(divisor & 0xff, &uart->dll);
@@ -97,29 +100,35 @@ static int npcm_serial_setbrg(struct udevice *dev, int baudrate)
 static int npcm_serial_probe(struct udevice *dev)
 {
 	struct npcm_serial_plat *plat = dev_get_plat(dev);
-	struct npcm_uart *uart = plat->reg;
+	struct npcm_uart *uart;
 	struct clk clk, parent;
 	u32 freq;
 	int ret;
 
 	plat->reg = dev_read_addr_ptr(dev);
-	freq = dev_read_u32_default(dev, "clock-frequency", 0);
+	uart = plat->reg;
 
-	ret = clk_get_by_index(dev, 0, &clk);
-	if (ret < 0)
-		return ret;
+	if (!IS_ENABLED(CONFIG_SYS_SKIP_UART_INIT)) {
+		freq = dev_read_u32_default(dev, "clock-frequency", 24000000);
 
-	ret = clk_get_by_index(dev, 1, &parent);
-	if (!ret) {
-		ret = clk_set_parent(&clk, &parent);
-		if (ret)
+		ret = clk_get_by_index(dev, 0, &clk);
+		if (ret < 0)
 			return ret;
-	}
 
-	ret = clk_set_rate(&clk, freq);
-	if (ret < 0)
-		return ret;
-	plat->uart_clk = ret;
+		ret = clk_get_by_index(dev, 1, &parent);
+		if (!ret) {
+			ret = clk_set_parent(&clk, &parent);
+			if (ret)
+				return ret;
+		}
+
+		if (freq) {
+			ret = clk_set_rate(&clk, freq);
+			if (ret < 0)
+				return ret;
+		}
+		plat->uart_clk = clk_get_rate(&clk);
+	}
 
 	/* Disable all interrupt */
 	writeb(0, &uart->ier);
-- 
2.25.1

