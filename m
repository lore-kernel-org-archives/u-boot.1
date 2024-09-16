Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829C5C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4760889BD;
	Mon, 16 Sep 2024 11:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zEjZVp8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 317C988EFA; Mon, 16 Sep 2024 11:59:00 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75B6788EF4
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c3d209db94so5283061a12.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726480734; x=1727085534; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vqy6PVBHxWJx4+pP+WOa/qhGDCdQPicD1vpW1c3GTF4=;
 b=zEjZVp8JPbbQ9dJffrI6vKB5GSeWawwFHnOvsqYYaIoSNHxISzhIvhBSkyTPJF+OMB
 /XgiPOBd70w5IM2Fy1g4foa5jCdLoKZc4afLDbJxnluZ7PvBqI8Mt07kn+0ZQRx8MBRo
 2+UnWZzwulDrfYWWSnBpdhTf+YSdEc7fHgHwy73VU4ULpdM2unJVz//5CaprekMXwSWP
 IeQjum8FrJHLdJWCbeTFAJVjl3fbZvrUtt1r1E5jGH29ywZFWEzdQBL9NGK4GNwnI1kO
 fdJ4F1HbR3mekysD8kwbcgV69ycWuxZkDR5mehiBuziNpE5euO/Yy5/52FYm2T+h3m+S
 2dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726480734; x=1727085534;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vqy6PVBHxWJx4+pP+WOa/qhGDCdQPicD1vpW1c3GTF4=;
 b=kVwqJ1Yt+aOQtaB/mhno9K6RGhgVq9eyzRUR8KJ5436FfY+EXnotr5thcy2pdwLgLy
 bp3yfpwZGqq4PlQ5ijrJ09rbSph6l854ivaTAs5ZvJbmqUbljfj88B6ahBxAvJ/rxgjm
 R6IQt65nX6xBun918e3tR4FgKKx/+gOi4CvQALd7KgfQt1IHBYXWeS1fs6pPdYScWKiK
 B3E15axDcuZP76fr3CslLnYMNZQVTmAsKPlWVcmmqhTvc22RzfvYfMFhIEgw09KcgA3h
 QFO5q8fngir/rvKokMIdKIK4P9ro7dzn5m/yvXrojOFGRu5oEINwjNs3i3Yf0NIQxul6
 mTHw==
X-Gm-Message-State: AOJu0YzWcqwXH21COnWO+ANZ+zO/qb3uxmDG06IDD6pCT3jICMrijD+N
 7OmxX3LQjHHbgByWtNPk+iWl4gCqLetzVhWyHFbrGe0SARktIlgGznEloklhYWE=
X-Google-Smtp-Source: AGHT+IHhUcezbTFYaAYFoCIiS4ZLnIVq7uypdRn3p9IUJCKwcMwaOMmwygGR0y3OFHvKTck95XWjOw==
X-Received: by 2002:a17:907:9446:b0:a86:894e:cd09 with SMTP id
 a640c23a62f3a-a90293c4fe5mr1674501366b.9.1726480733719; 
 Mon, 16 Sep 2024 02:58:53 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109662fsm292862966b.38.2024.09.16.02.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:58:52 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Sep 2024 11:58:47 +0200
Subject: [PATCH v2 5/7] mtd: rawnand: brcmnand: Add read data bus interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-brcmnand-fixes-v2-5-08632f64c8ec@linaro.org>
References: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
In-Reply-To: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0
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

This is a port of the read data bus interface from the Linux
brcmnand driver, commit 546e425991205f59281e160a0d0daed47b7ca9b3
"mtd: rawnand: brcmnand: Add BCMBCA read data bus interface"

This is needed for the BCMBCA RAW NAND driver.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 20 +++++++++++++++++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 552b239b95ae..2f786584a1ae 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -769,6 +769,20 @@ static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
 	__raw_writel(val, ctrl->nand_fc + word * 4);
 }
 
+static inline void brcmnand_read_data_bus(struct brcmnand_controller *ctrl,
+					  void __iomem *flash_cache, u32 *buffer, int fc_words)
+{
+	struct brcmnand_soc *soc = ctrl->soc;
+	int i;
+
+	if (soc && soc->read_data_bus) {
+		soc->read_data_bus(soc, flash_cache, buffer, fc_words);
+	} else {
+		for (i = 0; i < fc_words; i++)
+			buffer[i] = brcmnand_read_fc(ctrl, i);
+	}
+}
+
 static void brcmnand_clear_ecc_addr(struct brcmnand_controller *ctrl)
 {
 
@@ -1812,7 +1826,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
-	int i, j, ret = 0;
+	int i, ret = 0;
 
 	brcmnand_clear_ecc_addr(ctrl);
 
@@ -1825,8 +1839,8 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 		if (likely(buf)) {
 			brcmnand_soc_data_bus_prepare(ctrl->soc, false);
 
-			for (j = 0; j < FC_WORDS; j++, buf++)
-				*buf = brcmnand_read_fc(ctrl, j);
+			brcmnand_read_data_bus(ctrl, ctrl->nand_fc, buf, FC_WORDS);
+			buf += FC_WORDS;
 
 			brcmnand_soc_data_bus_unprepare(ctrl->soc, false);
 		}
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
index 6946a62b0679..3a1d60471361 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
@@ -11,6 +11,8 @@ struct brcmnand_soc {
 	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
 	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
 				 bool is_param);
+	void (*read_data_bus)(struct brcmnand_soc *soc, void __iomem *flash_cache,
+			      u32 *buffer, int fc_words);
 	void *ctrl;
 };
 

-- 
2.46.0

