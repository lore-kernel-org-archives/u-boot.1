Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2A5C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 00:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A38876DD;
	Wed,  8 Nov 2023 01:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q34OixEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D41876FE; Wed,  8 Nov 2023 01:41:07 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A683087703
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 01:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-280200949c3so4839155a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 16:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699404056; x=1700008856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ij8JJNQcp1TM4xmjjriwb91MOvgnBe/46mDym69Hls=;
 b=Q34OixEh3A5CH/ukVLF4uQN7kCUUDViUL96MMnvAt06O5WG7IApzuWzFvuLGgaYvO3
 DXUBZyvU7KqrrEWzBXrcg6LcdW8YVIRV2bk3zFADPEMZysa97wxIk/F1G8dopKSoHqbA
 VjhqmZREj78N1Kout/4iW6kPo/HWItdpuAaAMMtK2vXZ/dBRO/DxiwnH6Sx0tm+eDhoF
 HadqbwzeMEodUafOk8eylv+z6Pk+2tHFqE2E/AwdL+e51fFCmxYRz5+qJA+UfBouLUly
 jo+/qRKHx0zRZSN+CWXUz++Hg5/OkPFV4ZcDjwz0l2yJtOp0Vge2DlExn748Hxr1j7U9
 H22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699404056; x=1700008856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ij8JJNQcp1TM4xmjjriwb91MOvgnBe/46mDym69Hls=;
 b=dhfWuDjcddnru1TYyPrkNCjkhBkmgQ8wqCT3oJN+Dz4D1HNNcJjZXM31SIfY2e1gGh
 5w21FO5S+lx3AWzuop6WIxfQhsOn0NhgF2Eltfgyi0P+nSkUPVTIS1E53qfqdiJzmbDB
 SnZitSVUhXTEhkdkPGUAvGB8EdtVvPV36Db63NND9C+IvVaVe3dJFsHx+O1IAoCaDd44
 erXMHKwIR3twhB80aud69RvzJpwt+jOc4uyzLGCxVf0KNMfBdXV9Q0ns+INGZl2RWxlr
 1MZ4wmqIzojR6uSTaiOTTj2a90nbRZKTLwFvCH09UQCXcrH0IT2SQZ6SNm/H4+z5/PME
 P2hA==
X-Gm-Message-State: AOJu0Yywo/44iTO56GjYekDyb28bNiplaziMvszeazDmPEAuPdjh+sqF
 rGlnK/pqegjb1CFVu6VAYBU=
X-Google-Smtp-Source: AGHT+IFOObyDZXerC+WtPBScOdyitXcQYKfIybExpMPUT575U648FamPWOxiVQCg4l2T4t/uSbU6Wg==
X-Received: by 2002:a17:90b:1c81:b0:280:8c99:1801 with SMTP id
 oo1-20020a17090b1c8100b002808c991801mr368013pjb.16.1699404055893; 
 Tue, 07 Nov 2023 16:40:55 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.132.54])
 by smtp.gmail.com with ESMTPSA id
 mv21-20020a17090b199500b0028066f3c373sm384284pjb.17.2023.11.07.16.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 16:40:55 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com--compose, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/4] serial: npcm: support skip uart clock setting
Date: Wed,  8 Nov 2023 08:40:27 +0800
Message-Id: <20231108004027.281383-5-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108004027.281383-1-JJLIU0@nuvoton.com>
References: <20231108004027.281383-1-JJLIU0@nuvoton.com>
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

Skip the uart clock setting if CONFIG_SYS_SKIP_UART_INIT
is enabled.
Fix divisor error.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
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

