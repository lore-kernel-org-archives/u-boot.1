Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D09C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C522874DB;
	Thu, 16 Nov 2023 17:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KN5pM7dv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2AE4874E4; Thu, 16 Nov 2023 17:44:11 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01BA874DA
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc4f777ab9so9251195ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700153046; x=1700757846; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbR08Ini5VbqKP+nKWF8nUioGkUSl2FeHUGXdTZ6Bxo=;
 b=KN5pM7dvqR2CockDu/43n4OD6THMik48QVRohC0jyMI5/iZwiYoTJC6USs4o4pPP4G
 pxKUMYAHO8+vPQorx1B+XocRfb+PlUue097akZ70kbbERfOfJDTmJULUhOhL2N8mdbcs
 7OjzPoFPWg6Ibos9j+wAwecK8ZSwmmmFhO7Nhi81kWkwsm5edrZcDVTfZnMjXi2HxEIj
 rlZk+aRJZDjHuzPbmHRF2mkggXYnC5+A7QbX0cUhj5x4E0yGY04io2nNCvS6a/FT7N7R
 Ub7irrWXUXDXWnlxx8dpHSEZiZo/q4BB5wy30NgBdxBTnYfXILV1BlmevSqF5p73Zqgf
 DFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153046; x=1700757846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bbR08Ini5VbqKP+nKWF8nUioGkUSl2FeHUGXdTZ6Bxo=;
 b=IIvrhvNlja3zHeCnYPjfGtLyFLM/X0u3UtXJCmsI9t+y2x+meAogqkSjAwI/Tq02Uf
 yILBkqeNfcz27sAgpRa9tCeZGBtdbIE7jT129X7bVgYtK2OC+eBx9gke+6dvLgfJqg/6
 /N79dY7WzavBuxJNNPLCcqw9jgn51naj7pq//qvuRvA58LSodPMMQ2ncPhGmauDuY465
 YQowqWPZJi1RDru3TiPLuNXsSD4ZiXFnqJdbqulldBCoMuGGIA41ZBMpIyOofFUQPKCu
 z7ey4W5hxzIjZtrrdHaQKCa05wPWcCNFhZP3duGKZXu6Xa2nSCdZqjuWSQP+CPoJff/c
 Dr8A==
X-Gm-Message-State: AOJu0YxSm0wyfNxcYZjDh/9Oc4NAxLI7hSFT/VQU5pIS6BShE8mlz1po
 qhHJnS1JZcH515/t7WBLTHYqKA==
X-Google-Smtp-Source: AGHT+IEijHYEbsJHmiy/NpaErIQHyJLgyi/WDe2vHuUeHNSUFYtp6GH6MS7l/OeQJhkJHDmn42Hg+A==
X-Received: by 2002:a17:902:ec84:b0:1c8:9d32:339e with SMTP id
 x4-20020a170902ec8400b001c89d32339emr10801289plg.50.1700153046019; 
 Thu, 16 Nov 2023 08:44:06 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:57e3:f37f:e352:7f6c:bf18:83f0])
 by smtp.googlemail.com with ESMTPSA id
 l2-20020a170902f68200b001c5eb37e92csm9439839plg.305.2023.11.16.08.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 08:44:05 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] drivers: xilinx_spi: Add xfer callback
Date: Thu, 16 Nov 2023 22:13:35 +0530
Message-Id: <20231116164336.140171-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116164336.140171-1-mchitale@ventanamicro.com>
References: <20231116164336.140171-1-mchitale@ventanamicro.com>
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

Add the xfer callback which is used by the MMC_SPI driver and generally by
the dm_spi_xfer callback.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/spi/xilinx_spi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index d9faceec18..b63cda2091 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -278,6 +278,18 @@ static void xilinx_spi_startup_block(struct udevice *dev)
 	spi_cs_deactivate(dev);
 }
 
+static int xilinx_spi_xfer(struct udevice *dev, unsigned int bitlen,
+			   const void *dout, void *din, unsigned long flags)
+{
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+	int ret;
+
+	spi_cs_activate(dev, slave_plat->cs);
+	ret = start_transfer(dev, dout, din, bitlen / 8);
+	spi_cs_deactivate(dev);
+	return ret;
+}
+
 static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
 				  const struct spi_mem_op *op)
 {
@@ -427,6 +439,7 @@ static const struct spi_controller_mem_ops xilinx_spi_mem_ops = {
 static const struct dm_spi_ops xilinx_spi_ops = {
 	.claim_bus	= xilinx_spi_claim_bus,
 	.release_bus	= xilinx_spi_release_bus,
+	.xfer           = xilinx_spi_xfer,
 	.set_speed	= xilinx_spi_set_speed,
 	.set_mode	= xilinx_spi_set_mode,
 	.mem_ops	= &xilinx_spi_mem_ops,
-- 
2.34.1

