Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF52CCFA07
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4FEF8901B;
	Fri, 27 Sep 2024 00:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GbbHfx8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3844888F9B; Fri, 27 Sep 2024 00:46:40 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C288901B
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-458366791aaso8342561cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390797; x=1727995597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oB+kFWYr6VO1zDSHp/QiflCBX53cBwQFBEDFUIAcHJU=;
 b=GbbHfx8lf09yZ9bsoKMq1FthRVuEbCSrlKuwEp0Hfh/DmLNZt9z0lCU9Q6B+dUbzcG
 QTB1CUBLiL6RJElR6gXK1vrAWoeZY4CcJajMGacBCmF0rYAciloMLtB3IX+XyiEjVo51
 hZs1Ry34vyOq3WirnZjmt3L/5811o5IHY+LB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390797; x=1727995597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oB+kFWYr6VO1zDSHp/QiflCBX53cBwQFBEDFUIAcHJU=;
 b=JCb9tWbCEk74prMgR6Kmvaqpp7rbTX2hkpBYiYEm/MTHqC9oup28DlNt+ohmLiFOWD
 hiiACaIDa8JeVVHlT7H8jtz898fBfdBMXibWHm9+YUefB2Q6lsRfm6wP3ZcqU2NFoqIZ
 E6bleuJvistY79mzQJD37uyToyIIZFDIOHVScsuadqPB2ZlXo0a2JElAeY87RW6zIRpB
 LytlKZ19+V2pFq1rXlZ4lo+0xc69mQUwXqdKYjTLWH9bbu3fT1mhwHy5sJMHlt5qVcI5
 UrAysm/rpqtJ62QsaN1B6fhM7Ig4R2moI57KluxsmBqHnd7O9m1OGFgVle402NpQo0+U
 JOKg==
X-Gm-Message-State: AOJu0YyDP58YkQejY02jZpQ05GXvqWPLt6CbvrLzuMIvNwZem79ss7sG
 WIJomGD+mNVsPYLthQiZ6it/REmNN5lpJPUcL2C+Berqd3xMj/tlfQuCiG4rJczjI6oJM3N/m1l
 Lci0CfgE=
X-Google-Smtp-Source: AGHT+IHXiIOB576DlyiSnNRD9N3o7S7MiDTFbGNnzc6fkRp9IOjNPwlc66SwiygR4lbSv+HvxnqFgA==
X-Received: by 2002:a05:622a:3ce:b0:458:3b10:872 with SMTP id
 d75a77b69052e-45c9f2a488dmr14701651cf.60.1727390796892; 
 Thu, 26 Sep 2024 15:46:36 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:46:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Devarsh Thakkar <devarsht@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH 36/42] xpl: Rename spl_in_proper() to not_xpl()
Date: Fri, 27 Sep 2024 00:36:01 +0200
Message-ID: <20240926223814.1276764-37-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Give this function a slightly easier name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/mtd/nand/raw/sand_nand.c    | 2 +-
 drivers/ram/rockchip/sdram_rk3399.c | 2 +-
 drivers/serial/ns16550.c            | 4 ++--
 include/spl.h                       | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/sand_nand.c b/drivers/mtd/nand/raw/sand_nand.c
index 53489223030..3678bb8a41b 100644
--- a/drivers/mtd/nand/raw/sand_nand.c
+++ b/drivers/mtd/nand/raw/sand_nand.c
@@ -601,7 +601,7 @@ static int sand_nand_probe(struct udevice *dev)
 		}
 
 		nand = &chip->nand;
-		nand->options = spl_in_proper() ? 0 : NAND_SKIP_BBTSCAN;
+		nand->options = not_xpl() ? 0 : NAND_SKIP_BBTSCAN;
 		nand->flash_node = np;
 		nand->dev_ready = sand_nand_dev_ready;
 		nand->cmdfunc = sand_nand_command;
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 7f8a6ba8410..5676c099a43 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -196,7 +196,7 @@ static bool phase_sdram_init(void)
 	return xpl_phase() == PHASE_TPL ||
 		(!IS_ENABLED(CONFIG_TPL) &&
 		 !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
-		 !spl_in_proper());
+		 !not_xpl());
 }
 
 static struct io_setting *
diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 248fe3f778f..3489228127e 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -473,7 +473,7 @@ static int ns16550_serial_getinfo(struct udevice *dev,
 	struct ns16550_plat *plat = com_port->plat;
 
 	/* save code size */
-	if (!spl_in_proper())
+	if (!not_xpl())
 		return -ENOSYS;
 
 	info->type = SERIAL_CHIP_16550_COMPATIBLE;
@@ -555,7 +555,7 @@ int ns16550_serial_of_to_plat(struct udevice *dev)
 	struct clk clk;
 	int err;
 
-	addr = spl_in_proper() ? dev_read_addr_size(dev, &size) :
+	addr = not_xpl() ? dev_read_addr_size(dev, &size) :
 		dev_read_addr(dev);
 	err = ns16550_serial_assign_base(plat, addr, size);
 	if (err && !device_is_on_pci_bus(dev))
diff --git a/include/spl.h b/include/spl.h
index 09472f7f9bc..bea4d78f8c6 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -134,8 +134,8 @@ static inline enum xpl_phase_t xpl_phase(void)
 #endif
 }
 
-/* returns true if in U-Boot proper, false if in SPL */
-static inline bool spl_in_proper(void)
+/* returns true if in U-Boot proper, false if in xPL */
+static inline bool not_xpl(void)
 {
 #ifdef CONFIG_XPL_BUILD
 	return false;
-- 
2.43.0

