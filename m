Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDAECF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF94788D9C;
	Sat, 28 Sep 2024 22:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UianfNr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C09E88DED; Sat, 28 Sep 2024 22:01:21 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 232D288DBC
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-82aa3f65864so141371839f.2
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553673; x=1728158473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WacnzXmz5qmvEbok823pYN9/AuMSAlSQIlVv0TRG5Hc=;
 b=UianfNr9zts/JrHKUniy0K0eTPr5OCQL7OTNIKUp8t0PLhRRay/goRDOPmXHZHZ8De
 fbx6+awqfbD9MAaEQmL3x+aQa71LhTd5YHmIwIWlrL3xcBLS/jv3lwelZNll3YIfTNo8
 7Sng6YUdZp85l1lRrI5CuMiXpBq6oPu48XAL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553673; x=1728158473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WacnzXmz5qmvEbok823pYN9/AuMSAlSQIlVv0TRG5Hc=;
 b=bvjI3wq/XH+aTwSRchpkoQtrXUhT8AxXopOu9Zr2xUoyzWHQy0Nb4qvhqhgk6KpOFG
 qfR5mlSIFDLdOWaeJcOTvkZgaJO49vXQ8ARJLwhi8PaaEqjK8xvjDvejdVFSNmXdVVgM
 /tQrE9bRnIzh+fWKlGiUDK1CBJvSL2Qoj1akJrWMbP/e3t9C4/0dgH7cxQZwYgn4SVR0
 iFjwLGugAMpAOki8XAcE1iWy4uIBsA4P+LqB/QmHUuoJ9SEqTjyxd2RKz4UEsRkOXJiR
 x2L/t8Z5Jc+odxnXULLcUGLO1BeoBmBp8oBLzIlqnRBcuIg58LH/V/KNP7gUnelQxZ7f
 EOCA==
X-Gm-Message-State: AOJu0YwxI9H9c0z6Xq8oIfn9tB7CRYQV93PA+8reYTS+fOG4obypmJld
 roi9CqZj4wpY0mq/MoENHwYZwe/sWgYjginJAbK8e5cxmiyKWcVP8h9bHC2u4eOXjeLj6Ct1UTK
 EwQ==
X-Google-Smtp-Source: AGHT+IFfDYaPf8mOCN3XyC0Cz7JoFcKP1AaPh4rf6ajFpeSTZEaqkVO0Xp28F6DPbj5DyWFTlHCgqw==
X-Received: by 2002:a05:6602:6b0d:b0:82d:2a45:79f6 with SMTP id
 ca18e2360f4ac-83493248209mr785259439f.11.1727553672649; 
 Sat, 28 Sep 2024 13:01:12 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:01:12 -0700 (PDT)
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
Subject: [PATCH v2 24/30] xpl: Rename spl_in_proper() to not_xpl()
Date: Sat, 28 Sep 2024 14:00:24 -0600
Message-Id: <20240928200030.194546-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

(no changes since v1)

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
index 7b48af49af8..6fa8f268770 100644
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
index 079a38433a2..c9ab0f3e977 100644
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
2.34.1

