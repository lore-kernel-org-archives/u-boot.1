Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48663C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 17:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42AD986EDA;
	Sat, 11 Nov 2023 18:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="heWSu5ol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B822186FDE; Sat, 11 Nov 2023 18:33:13 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62BE486F1C
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 18:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so2543319b3a.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 09:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699723990; x=1700328790; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8oI6mwRII5aM1mkpWCfn7WrSa5uHdfQK1t57bxWA80=;
 b=heWSu5ol5wYWuCbAE6/TE+V4O8jpCbAIJjDhYlj4V3819kDn7Kx9Jy42K9AfKdqVER
 W+U8z0V+KEVhLJp+zW3agbRYKJ7Y4qAC/1Tnh4QGDvFSjRt212khcdSJwVxaWlLgM1NJ
 SoKcUpFypm24DPHK5+wtqVvEYm2VVZa8YxZ7xlFzTvrGX+Laus+l34grDxunebTpZTZ+
 Ej0R3tJ+AQPnp1EtCMIodD3HMIP8z6jw7C/C3Br3L9lK9isKMLSoAM+DctcA5yfIe/tb
 fWnWzisLF3RfUrk4yZpaJUFx/wc3qWo00bbxPo4sLJIdx+YYoWcQzSv3B4Z4U/Hj6PBA
 CH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699723990; x=1700328790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8oI6mwRII5aM1mkpWCfn7WrSa5uHdfQK1t57bxWA80=;
 b=vopPuc6hJNRPC+aPuzE1iqDe0o0OhjhUjG1HlCPCShcrXFlr0L2zsBTleBE2pjsXWX
 +GW4WZo2NUKMWitaJxMWscra27k9NmYM0u2I2YObB09iYOXQzDgzJjJM3awDsTAqwZJu
 BUZQye5wuhtDy6QQLBKXzX1npJglqgyLMOktJgvFs0n+szofZ8eGpB93a4Ir8cud9+4/
 fzQRB3Kk87QGyPvoibO6Mk/3/w4bxXHHgKfGQZM12yUKv+jxg2fu4mztAXyKOt7yIga4
 p6FKqK682ICkldRaVvbPx8pNAPDFZ7eUVCglQF+K8bB/RgW7X/rDZlSwNyi1ZYFIq1Wo
 K23w==
X-Gm-Message-State: AOJu0YyltR4Nn3b7zq5F4tLEdePnGz2Ext4cgQ0Txk8SdTyOD89trQff
 WlIKNraBhGT1Tz38ruUiCLtgfg==
X-Google-Smtp-Source: AGHT+IENlTA6N2lJuZ3FqQ1YhAGcruiGgckbHsDpgmimuuhwtWkAT63CgyLbW4x0DYF6t2J+H+Dikg==
X-Received: by 2002:a05:6a20:1450:b0:157:e4c6:766a with SMTP id
 a16-20020a056a20145000b00157e4c6766amr1841631pzi.41.1699723989708; 
 Sat, 11 Nov 2023 09:33:09 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com ([223.233.86.194])
 by smtp.googlemail.com with ESMTPSA id
 c64-20020a17090a494600b0027cf8869ee7sm3772218pjh.0.2023.11.11.09.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 09:33:08 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 3/3] drivers: xilinx_spi: Probe fifo_depth at runtime
Date: Sat, 11 Nov 2023 23:01:21 +0530
Message-Id: <20231111173121.92889-4-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231111173121.92889-1-mchitale@ventanamicro.com>
References: <20231111173121.92889-1-mchitale@ventanamicro.com>
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

If the fifo-size DT parameter is not provided then probe the
controller's fifo depth at runtime. This is ported from a patch
in the Linux Xilinx SPI driver.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Link: https://lore.kernel.org/r/1422029330-10971-5-git-send-email-ricardo.ribalda@gmail.com
---
 drivers/spi/xilinx_spi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index b63cda2091..99ae5be291 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -109,6 +109,27 @@ struct xilinx_spi_priv {
 	u8 startup;
 };
 
+static int xilinx_spi_find_buffer_size(struct xilinx_spi_regs *regs)
+{
+	u8 sr;
+	int n_words = 0;
+
+	/*
+	 * Before the buffer_size detection we reset the core
+	 * to make sure we start with a clean state.
+	 */
+	writel(SPISSR_RESET_VALUE, &regs->srr);
+
+	/* Fill the Tx FIFO with as many words as possible */
+	do {
+		writel(0, &regs->spidtr);
+		sr = readl(&regs->spisr);
+		n_words++;
+	} while (!(sr & SPISR_TX_FULL));
+
+	return n_words;
+}
+
 static int xilinx_spi_probe(struct udevice *bus)
 {
 	struct xilinx_spi_priv *priv = dev_get_priv(bus);
@@ -116,6 +137,8 @@ static int xilinx_spi_probe(struct udevice *bus)
 
 	regs = priv->regs = dev_read_addr_ptr(bus);
 	priv->fifo_depth = dev_read_u32_default(bus, "fifo-size", 0);
+	if (!priv->fifo_depth)
+		priv->fifo_depth = xilinx_spi_find_buffer_size(regs);
 
 	writel(SPISSR_RESET_VALUE, &regs->srr);
 
-- 
2.34.1

