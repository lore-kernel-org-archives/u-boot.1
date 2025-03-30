Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE0EC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23D96817C4;
	Sun, 30 Mar 2025 11:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="amBgrRka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E38281DCD; Sun, 30 Mar 2025 11:21:31 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A0058129B
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so593123666b.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743326488; x=1743931288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YgcrTRGKz8hG4NAPrS5UahxsleBwDxfJXiniVTKy60=;
 b=amBgrRkaPs7RH5nNv31EUmLX3O0zlSuyxmU0SZXg3bsigbWYObvqIbnf8Nz1nJ0Dk2
 UQ2B1RvJunrPv/tk7su8HMxOMbuuwcgYmItKxFne7ReXagvOhjq/tEn8EAFtd/wfEaX0
 xYfHznFkJg1yB6XQVxcLSE7RPXfeQjwcJ2Y0cETyP4N8DyTdA6fWl7j/AJBA+UVBd4/9
 lhuGKESq6KdSI5hwN+qjjiBCK5Wg7EUXi38wwuLvarN4Z+8lvI391h29Y0GfbD8UnTK1
 +aauUeHO/LX5rrxH1teWorVOpRuPWoEgjmdum3i6yzzJBW4TMm1AoJVtCi3BREjU8ldj
 /d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743326488; x=1743931288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YgcrTRGKz8hG4NAPrS5UahxsleBwDxfJXiniVTKy60=;
 b=C21X7v1JdmtXoFmqto2fn2ehETScMfueE5x1hAJnBztJTcRX4Zpykg1HeN0ZF0ZdVx
 iFtkPfCSunpWhtbNjvo8+JCRD61U4zwg1kUE+VVv8SqAkmPe4rj3g7tplbyLCy29uuOQ
 iZU8Fgr1YhDpC9XDHt6qcpIFU4wxlASJkA639dvuHClFB/Mt2VuhTT/LNTxUx01inFpS
 lBZNUgW9xsXh0NBKD7NM5OxCdEa/3Me6zVbzv6uAgf6r2/Am7NYzJzB9L+Tksj8U9X3+
 14j63TrGVhJnMIvK8sV7LfSSaLSrfwBKCEDkUdy01P2LkMzw/Fdlm6pc3Z6U7bkB6aCq
 p4bg==
X-Gm-Message-State: AOJu0YyMrCfT+KWFlsqxZa/OBWjKToTmZt7TqJpZ1tr3ehxzMatDYG9J
 3PFcSiFLO1aviBf2pRVkIU6f08E1paljcCHLoTSxXETGre/Rea66u48dYw==
X-Gm-Gg: ASbGncshS/D5kHZhhY/hiayH/Ae9cVXjN1ypW3usisknMYlmIMSJduqkSl7QlJWsAx0
 5kwhaC2zb0o/ofjonoSVmscKq4T+COY+WGuwFgcaeVWaUYzf9pG52vNUrroI/J9yhPgYMi4IoFT
 j1QOjx8EcXCSRlrW6WfzxScZ2LteYd0gX3aJGmrnWfxCPzeN/V74VVRWBEjYbIAyGhbjmSmRmw0
 O12TsshJdE92JjZ6L4ZS6bzVVpQgFvnWsGGOAqZ9GGXM+eFcLPADnxwNABlf4ouNIXxHRJvhns7
 bVFGglb9WJwXcs/i1tMPrZD34gamUMm4yz5g
X-Google-Smtp-Source: AGHT+IEe0EHemF/R1UUesBfzitBlbzwjH5yfOuarUnO8Rknv/yPp9BlCZZSpmALIbqMi+16VmIECtQ==
X-Received: by 2002:a17:907:3f26:b0:ac3:446d:142 with SMTP id
 a640c23a62f3a-ac738975d8cmr498104966b.2.1743326487997; 
 Sun, 30 Mar 2025 02:21:27 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7196f56a9sm461565566b.173.2025.03.30.02.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:21:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 William Zhang <william.zhang@broadcom.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] spi: tegra20_slink: fix CS polarity setup
Date: Sun, 30 Mar 2025 12:21:08 +0300
Message-ID: <20250330092108.9946-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330092108.9946-1-clamor95@gmail.com>
References: <20250330092108.9946-1-clamor95@gmail.com>
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

Add missing configuration of chip select polarity. Default polarity is LOW,
which satisfies most cases but some devices require HIGH polarity and will
not work.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/spi/tegra20_slink.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/tegra20_slink.c b/drivers/spi/tegra20_slink.c
index d54a5049205..097d9164175 100644
--- a/drivers/spi/tegra20_slink.c
+++ b/drivers/spi/tegra20_slink.c
@@ -29,7 +29,10 @@ DECLARE_GLOBAL_DATA_PTR;
 #define SLINK_CMD_IDLE_SCLK_PULL_LOW	(2 << 24)
 #define SLINK_CMD_IDLE_SCLK_PULL_HIGH	(3 << 24)
 #define SLINK_CMD_IDLE_SCLK_MASK	(3 << 24)
+#define SLINK_CMD_CS_POL3		BIT(23)
+#define SLINK_CMD_CS_POL2		BIT(22)
 #define SLINK_CMD_CK_SDA		BIT(21)
+#define SLINK_CMD_CS_POL1		BIT(20)
 #define SLINK_CMD_CS_POL		BIT(13)
 #define SLINK_CMD_CS_VAL		BIT(12)
 #define SLINK_CMD_CS_SOFT		BIT(11)
@@ -64,6 +67,13 @@ DECLARE_GLOBAL_DATA_PTR;
 #define SPI_TIMEOUT		1000
 #define TEGRA_SPI_MAX_FREQ	52000000
 
+unsigned int cmd_cs_pol_bit[] = {
+	SLINK_CMD_CS_POL,
+	SLINK_CMD_CS_POL1,
+	SLINK_CMD_CS_POL2,
+	SLINK_CMD_CS_POL3,
+};
+
 struct spi_regs {
 	u32 command;	/* SLINK_COMMAND_0 register  */
 	u32 command2;	/* SLINK_COMMAND2_0 reg */
@@ -155,6 +165,14 @@ static int tegra30_spi_claim_bus(struct udevice *dev)
 	writel(reg, &regs->status);
 	debug("%s: STATUS = %08x\n", __func__, readl(&regs->status));
 
+	/* Update the polarity bits */
+	if (priv->mode & SPI_CS_HIGH)
+		setbits_le32(&priv->regs->command,
+			     cmd_cs_pol_bit[spi_chip_select(dev)]);
+	else
+		clrbits_le32(&priv->regs->command,
+			     cmd_cs_pol_bit[spi_chip_select(dev)]);
+
 	/* Set master mode and sw controlled CS */
 	reg = readl(&regs->command);
 	reg |= SLINK_CMD_M_S | SLINK_CMD_CS_SOFT;
-- 
2.43.0

