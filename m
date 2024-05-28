Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9451C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 12:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0016883B9;
	Tue, 28 May 2024 14:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="RBT77pVX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74CD883B9; Tue, 28 May 2024 14:31:46 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5314D88361
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-421205e8cdeso5308885e9.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716899502; x=1717504302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3iNEwhDpABS1fUgE/PaLasUi/VDZqxUXYqsWbeEfeM=;
 b=RBT77pVXYlxnbS48n98Fkyg0DBwoh7iZKETwCZsounV5hNdSwBXyggpSongSOBBxKx
 2wCf90Z08W8YzevQJNM/XrXowuRJga2SwMQMLKsPTPz8d5chnYIsbhC7Bcp4QEsiIuIJ
 94Z36ArZTh/ZUJyvQFSW4YaRQQj7/UfcCX+TsKbzdq/BxdZiEF7AcmXVeBeP2eDKmqdp
 /IvJo+TAxvf/4nuBs2crJUOgbbeADTBj9HmKvfd2KQ3Wd7e0sj3c4rkswYmMkmNTAOI9
 dYwgiQZYn5flMd5cZBWvMR/JPhwybXQ7Laua7DGBZ6Mw8Hl5+4IcUPVW/eFgjfvQwgHg
 UZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716899502; x=1717504302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y3iNEwhDpABS1fUgE/PaLasUi/VDZqxUXYqsWbeEfeM=;
 b=bEUiHeUigz119r5rlWW/MqvghDz1k/u3e/L/Og5NejED3cYBCP8DifCP3Um0gjZlSg
 7Jeybv5VxQ8SjTPwlAVcYGTXV4fKu6zBoZDFbBSyBWUzBtGcBiusibFwDadYTwFalQ/x
 PyhM1n2CBkuGAB2s7A0Ip8TA4SnY1Go0OuZwnk8vFBH7vu0W9cOUJ96w9TJ9RQw0MMte
 JdgI3a7OaXePFOGHw3DNj7wwem2bCQYoD8uRbBta4mz9SXAObOo/9lRwNMbmfN1i+kn1
 sjthTU3wwOpAwQPav1869b2rigpEc9sKvrEbvf3pwyMDfIFuW3wQhmXbQT/qEgej92mV
 G9Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg2QBhh9eOA2uVMRZVN0ZirHfIjtkoFidVgyBpzwp1QZLspp4RQYbO99v+ODN/C8SbJfhonaxRjrZsMn/tK9aPJHsYSg==
X-Gm-Message-State: AOJu0YwNaB+fKJoJeSYZpiCDx1eAL5sD1fRBR6Z3G8lBaWHXi53BEIF+
 XdBp5MQqh9Yn40UcIq61+fHBEC50VqbdQPbmKRUgHA5qoTw9askTpExieRGcst0=
X-Google-Smtp-Source: AGHT+IETbZnxPZeYebPFvGVLe9BnD8EN09t0VK81Y1qzwLlo1CGunnK0CApvj5Hq7Ok+Vgg4pa5fcw==
X-Received: by 2002:a7b:ca48:0:b0:420:182e:eb46 with SMTP id
 5b1f17b1804b1-42108aa7bc5mr126354595e9.38.1716899501418; 
 Tue, 28 May 2024 05:31:41 -0700 (PDT)
Received: from fedora.. (dh207-15-56.xnet.hr. [88.207.15.56])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4210896f442sm139708725e9.11.2024.05.28.05.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 05:31:40 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: lukma@denx.de, seanga2@gmail.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] clock: qcom: ipq4019: add I2C clocks
Date: Tue, 28 May 2024 14:31:04 +0200
Message-ID: <20240528123137.170414-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
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

I2C clocks are not initialized by the SBL, so lets add support for clocks
required by both of the QUP I2C controllers.

BLSP1 AHB clock is already initialized by SBL, but QUP I2C driver is
requesting it so we have to add it to the enable list.

Based off QCS404 clock driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/qcom/clock-ipq4019.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index fca7626ada..73dbd25811 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -16,6 +16,12 @@
 
 #include "clock-qcom.h"
 
+/* I2C controller clock control registerss */
+#define BLSP1_QUP1_I2C_APPS_CBCR	(0x2008)
+#define BLSP1_QUP1_I2C_APPS_CMD_RCGR	(0x200C)
+#define BLSP1_QUP2_I2C_APPS_CBCR	(0x3010)
+#define BLSP1_QUP2_I2C_APPS_CMD_RCGR	(0x3000)
+
 static ulong ipq4019_clk_set_rate(struct clk *clk, ulong rate)
 {
 	switch (clk->id) {
@@ -29,7 +35,22 @@ static ulong ipq4019_clk_set_rate(struct clk *clk, ulong rate)
 
 static int ipq4019_clk_enable(struct clk *clk)
 {
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
 	switch (clk->id) {
+	case GCC_BLSP1_AHB_CLK:
+		/* This clock is already initialized by SBL1 */
+		return 0;
+	case GCC_BLSP1_QUP1_I2C_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP1_I2C_APPS_CBCR);
+		clk_rcg_set_rate(priv->base, BLSP1_QUP1_I2C_APPS_CMD_RCGR, 0,
+				 CFG_CLK_SRC_CXO);
+		return 0;
+	case GCC_BLSP1_QUP2_I2C_APPS_CLK:
+		clk_enable_cbc(priv->base + BLSP1_QUP2_I2C_APPS_CBCR);
+		clk_rcg_set_rate(priv->base, BLSP1_QUP2_I2C_APPS_CMD_RCGR, 0,
+				 CFG_CLK_SRC_CXO);
+		return 0;
 	case GCC_BLSP1_QUP1_SPI_APPS_CLK: /*SPI1*/
 		/* This clock is already initialized by SBL1 */
 		return 0;
-- 
2.45.1

