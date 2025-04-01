Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD93C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A681A820B3;
	Wed,  2 Apr 2025 00:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EIN5ZMmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B71A28171B; Wed,  2 Apr 2025 00:52:51 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86EB82027
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so66682015e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547969; x=1744152769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IOH8DkuVLxYfs/lJIWeNLRlOYkCQiYfxlfgFqsd0JDE=;
 b=EIN5ZMmAFhMCHI/qhLxSF8do4FKw3PNiE3HqmuZiGmNVrfmC6B9edVhHWBOMGiugvk
 yCxkzXjpfP//WHEEhV8gNlefpj8pqEfiMdOZ8L5QtlN/RhX8aEYInnrNU1aX+dYijY2G
 sI1AdIWv0ks0RyBGWQ/ctoSjriL23uBGlDg39ayaM1P6LRyWh84gCbRkJUOX/T5q1aDd
 5GSNNzKZD6Mr/Gq3CLcqQOtli2bfU9Et28e2poZhat/Ki07iIJkYFaSjrvINNdtzRClG
 gZf0p4x3igT7WkV4BMCLbbBZ9LijM6V52LTFzq6Os014xR/ooIZFKsRdU7Lk8VX/5Zrn
 BR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547969; x=1744152769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOH8DkuVLxYfs/lJIWeNLRlOYkCQiYfxlfgFqsd0JDE=;
 b=X/E85lro5BGPWlKv1pVZPECA3ovOezpbJ2UISsIyxnXUbkC2BC9x7QxTLmKCaTn1P9
 eXZoZ6MZth4sfwGyfUwn+RCky9JdLI/voB4lWuBO3I3eTCcfPP54cC3yLgxt32hqo7UB
 4ZX2vcVm6M3R8QcAzAtT7ZrimnCFX2yDqw7Go1MdwiNvPlBYijwkFBeFtJfXSfuMXoIh
 SMsqUaQeifL0l47JcWphpYtkAcpC68amjAfHR4HIL9/X+LsnykS7xLGGgMxLGO5tcG+z
 ArjJYz+2AO3D2MIpVv4khwMyteDiv5p39HKknbabzA+lRdu81rDDd2QSasAsXcPJ6K9r
 E6fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNegzDBSbyML6sZdCQPVG3tN31hHH/6yGZ7rBlR46xWGQdA1BKPkKy113xJPEDArvcXTYRUzs=@lists.denx.de
X-Gm-Message-State: AOJu0YxnV8GVat6aI4vvrcQKsfkq/e+PAd4vJK1eQOp5iATaYk2ENGKR
 QgKra3y9wy80+hQ1x2gO55RxNe+8Q2YiGKywfM0QZIh55jKecyLg
X-Gm-Gg: ASbGncuGLJvuLDLws0KKgeQ2F88/yZycVOG3F6Cac94FHB21N9T5NO5Nq2HEbgB7Q0z
 diVtEbZ3WOxaVWs+iIpxfq6lH+GSNJW0gm11Ng4XS3Q7elsot6l8LrIvAd/ZZQrZkslRHQbg1vj
 7s5sNU2GXN0S2R3CxdqBjU6wHFgJKYrE8AodHnRw30IyLlhpqDL+iTiGQnflEVG2sA+YHqf+pAs
 oO8eMCJSb1z506gB9Gh4xJjfM4Bh5deYSoOZwSz15tHW86nihJMSDP3hb2fJSq7UntJlr45TiUt
 vt9pOn7pUqvewHPelvfpvcvnmttC4OF9lkruEKZ/0bSQ3xbBU/9qQNOtYEUxZiODL/TUEW4COqv
 hrPHdW17VGB2kAw==
X-Google-Smtp-Source: AGHT+IGPpW0nmA44wXWuH+ANyS1YZU3P6AGtAgzVCqO9Ve2tuHiOkMcGqVD/9EnQaz6JUnEBVw3wuA==
X-Received: by 2002:a05:600c:314b:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-43db6249672mr145222255e9.15.1743547968877; 
 Tue, 01 Apr 2025 15:52:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 11/14] spinand: call SPI setup_for_spinand if supported
Date: Wed,  2 Apr 2025 00:51:43 +0200
Message-ID: <20250401225156.25790-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

Call SPI setup_for_spinand() if supported and defined to configure the
SPI slave for the attached NAND. This is needed to configure the SPI
with the NAND page size and spare size for correct configuration of the
device.

Call it as soon as the NAND is detected to correctly handle SPI
controller with select_op_variant detection.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/nand/spi/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f5ddfbf4b83..3a1e7e18736 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -941,6 +941,19 @@ spinand_select_op_variant(struct spinand_device *spinand,
 	return NULL;
 }
 
+static int spinand_setup_slave(struct spinand_device *spinand,
+			       const struct spinand_info *spinand_info)
+{
+	struct spi_slave *slave = spinand->slave;
+	struct udevice *bus = slave->dev->parent;
+	struct dm_spi_ops *ops = spi_get_ops(bus);
+
+	if (!ops->setup_for_spinand)
+		return 0;
+
+	return ops->setup_for_spinand(slave, spinand_info);
+}
+
 /**
  * spinand_match_and_init() - Try to find a match between a device ID and an
  *			      entry in a spinand_info table
@@ -964,6 +977,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 	u8 *id = spinand->id.data;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int i;
+	int ret;
 
 	for (i = 0; i < table_size; i++) {
 		const struct spinand_info *info = &table[i];
@@ -975,6 +989,10 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		if (memcmp(id + 1, info->devid.id, info->devid.len))
 			continue;
 
+		ret = spinand_setup_slave(spinand, info);
+		if (ret)
+			return ret;
+
 		nand->memorg = table[i].memorg;
 		nand->eccreq = table[i].eccreq;
 		spinand->eccinfo = table[i].eccinfo;
-- 
2.48.1

