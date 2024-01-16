Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC27FC4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 13:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE40874D5;
	Tue, 16 Jan 2024 14:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oa0fs/yZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B6187716; Tue, 16 Jan 2024 06:39:11 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7F8870D9
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 06:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso3833086a34.0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 21:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705383547; x=1705988347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAZVLN4Kob8RexOf6PVcoFQRf5GeDJVq8z0gAU8zGU4=;
 b=Oa0fs/yZj+DfdS0Oq6g+tNexCnyvuuba2aQhmm+p0tUTn0EkaJ/w/WpgKBTmKQb+sl
 FJzKlFehcA70CfiCc05MlJJv4mCQo3Ra3mwwHB/gRMTtg7aE6plJrWurCoch6Tof//6J
 Qxx4Dpxp8cNDaty2OOUZioaF7vKTEAG6/ssHbpV7J3BuNhzRrNAxpLSWeq0Vz4DT06BV
 v99kfeA8wjgD5AgYFxcccotQ/qwJ1cJu/YHmsYz2aBXk8xB/IP3FYOBzfmrKUnd++yFm
 1vVz73YkII6GIqh4TBZ2KA9eYiVJC7ueE9I8a/su8vc8vyWAPUhxhWnXQcgwjUTCj36W
 ww+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705383547; x=1705988347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAZVLN4Kob8RexOf6PVcoFQRf5GeDJVq8z0gAU8zGU4=;
 b=VDiDyuLjM3a4EnJR+sgRNlqB0/TpHSxL6P1c8wl2kPnnfJZDVxNsmQSG9nYUQochpi
 A0bgJsD3mzYoP8rZ/lEdYC0gDut7vrFx5f6TB2YFMGIhf7qIA9JbZQAM9xIFAm6fwBf0
 pZ+vkuLBCwpOMOpAHXAhhdGmCQ8zIPwNJku905u9zNSY2r9lZRODrB597//+qGH0Bg+b
 IQLV9iHAchn8uCwfrzySstx/5bBqknSB/Xw7bjIX7YVOroQJE3CGKF9AJ0Y2DJzQI9zI
 /31fwzixZZs3K+oNF+X/yddX0WmDCXJAcld4DSKbEBIcQVy4nP839rAZiFlSbwKrkEpL
 I+6Q==
X-Gm-Message-State: AOJu0YwLkxsqY2nXacAk/i13Funks5Y1t6nCMgzq83nOPQjIKa/j63mL
 2TcuXULi1T0hp5ipk47nAZ0=
X-Google-Smtp-Source: AGHT+IFkLQuoBb8aT7lBWUPgS2c9KQVEf5/oS1NOHOUoFvB2/QZh8VdWKBHTn7Uh4B2AieQyLoEKIQ==
X-Received: by 2002:a05:6830:4799:b0:6db:b3cd:75fa with SMTP id
 df25-20020a056830479900b006dbb3cd75famr6183706otb.63.1705383546761; 
 Mon, 15 Jan 2024 21:39:06 -0800 (PST)
Received: from sun-virtual-machine.localdomain ([107.172.101.235])
 by smtp.gmail.com with ESMTPSA id
 c28-20020a63725c000000b005cdf7923113sm9010768pgn.68.2024.01.15.21.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 21:39:06 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: jagan@amarulasolutions.com
Cc: chiawei_wang@aspeedtech.com, ssunkkan@gmail.com, u-boot@lists.denx.de,
 vigneshr@ti.com
Subject: [PATCH] Add XMC
 XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C site:
 https://www.xmcwh.com/site/product
Date: Tue, 16 Jan 2024 13:38:34 +0800
Message-Id: <20240116053834.3628-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAMty3ZCo4NyOo8c7Msn5Ub+B7eTA-MEoFXh7_jeFPVUvVWMyPg@mail.gmail.com>
References: <CAMty3ZCo4NyOo8c7Msn5Ub+B7eTA-MEoFXh7_jeFPVUvVWMyPg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jan 2024 14:18:59 +0100
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

Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
---
V1 -> V2: separate the ID and Defconfig 
 drivers/mtd/spi/spi-nor-ids.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 8db522fca0..32329704d5 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -554,6 +554,10 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XTX
 	/* XTX Technology Limited */
-- 
2.34.1

