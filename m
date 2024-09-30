Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB9ECF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A0D88E46;
	Mon, 30 Sep 2024 03:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KDA5/bFr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E743488E43; Mon, 30 Sep 2024 03:50:27 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A9C88DB9
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a3445ab7b5so9162155ab.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661023; x=1728265823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qRGrOD+ndsj14E3x6fkPPGxTsGmqfs4RHsmeITu2Mw=;
 b=KDA5/bFrf3hkKRBYViBA8xqE1Th/7AxNHpqV+4J1rq7Fdl/IH0yti4Iae0GYdqpJ5g
 OVu8t42iASv5Xx8kzXHIBckrB9Qx1HGrzyxtT/1es5JQiKF8xBGh/iDQp2c/ytPFlajY
 xAZrk3oQPrNQOLsticWyG/zBlObEmS/DLqdNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661023; x=1728265823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qRGrOD+ndsj14E3x6fkPPGxTsGmqfs4RHsmeITu2Mw=;
 b=s6/eYcV3S2n3rUUa4zlYDfsAf2lxySPU62Rf/O0UPuI+HHBBWt6Oqttdn9jb+/na+N
 tOyvlAMtU+d9V+8MsZCSqVA+yt0SP0BJPANFpyt7jY66c+65sG0/WClfz18+aFiqyulK
 JeWU/QLyl7iZJTPG+U+7m3W6TnPA71fvMV1e9LkIAyjeL99jPMBfdInNZ+YFxhxjIZCN
 R0vVq9L5QQjm0eCwlDuo3lCob7MyBTCz9sekAlUUSofdPKDtdw7I4VnhLB9nqs+oBO99
 6MOzRlQJj0MWnwDmAgpptK3tXY0mSul1XCt4iMQK1Dba2myazLOtF17h5WRL+TBSBvT5
 RsFQ==
X-Gm-Message-State: AOJu0Yx2h9h+NiJOKBv4xSY2VdT8FtDwVn4EIIztfVUzKW2Z5aFx/+D2
 Nre58aJ7FTDxCostBKj7UuMgAeWvip3fBuTp0Gvf1R28HBb9xsH782CuBvHBF3rHFQhphjISwnw
 hZA==
X-Google-Smtp-Source: AGHT+IGwybzKLImRttFSpRwGvSTgFiynxpRRxkkKr0dBFp5P5Uea382z3B2sd2wWvkvf5O3k2mIj4w==
X-Received: by 2002:a05:6e02:156c:b0:3a0:9903:42c3 with SMTP id
 e9e14a558f8ab-3a344638959mr70309885ab.10.1727661023256; 
 Sun, 29 Sep 2024 18:50:23 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:22 -0700 (PDT)
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
Subject: [PATCH v3 14/33] xpl: Rename spl_in_proper() to not_xpl()
Date: Sun, 29 Sep 2024 19:49:37 -0600
Message-Id: <20240930014956.1434060-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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
index 229d7b5b65a..456e841b1c4 100644
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
index 6fcb5b523ac..55bc39648d7 100644
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
index bf011139548..948486164d9 100644
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
 #ifdef CONFIG_SPL_BUILD
 	return false;
-- 
2.34.1

