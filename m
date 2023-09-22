Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C63CD4F35
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 09:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5339F864E9;
	Fri, 22 Sep 2023 11:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="UYtVv30i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C3A86575; Fri, 22 Sep 2023 11:09:46 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B56B1864E9
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1qjc9g-003rQP-Lf; Fri, 22 Sep 2023 11:08:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1695373784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RtpzRa70ArA6HQHFsZnRGVk3hb0ai5cKrRlQENo04o=;
 b=UYtVv30iuI/S5ZLAT0I2gqulUc7BbL5u6181aAPcHJnXerViWs1I+v/QKPrp/+60YZLf3Q
 B6qDlJdhO2AbGAWJ00CE3dhiL3AAE7ZYLnNnCuw9YUrz80CYLWNYDPqNoN8aNOr5L8GG3s
 VKp/tB+n8BgVk6f3RS96WRKxGgy19U/PGVP05KUtwmYGt8LPe9QAlFOqCaBHvXQYHjVXUH
 hYGReLUcb7hZL1huztht6BR7b14UiPb4CAlT2zm+dAtZELjMS0xQo9pNKsfY9PcssiEW1P
 /m8CADGx9mTFX/Zc8zriAJS2CMTQJbjgK7o4CNtj1451VMB/jnL2GmQO916ItA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 1/1] mtd: nand: raw: atmel: Add error handling when
 rb-gpios missing
Date: Fri, 22 Sep 2023 11:08:56 +0200
Message-Id: <20230922090856.920303-2-ada@thorsis.com>
In-Reply-To: <20230922090856.920303-1-ada@thorsis.com>
References: <20230922090856.920303-1-ada@thorsis.com>
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

Adapt behaviour to Linux kernel driver.

The return value of gpio_request_by_name_nodev() was not checked before,
and thus in case 'rb-gpios' was missing in DT, rb.type was set to
ATMEL_NAND_GPIO_RB nevertheless, leading to output like this for
example (on sam9x60-curiosity with the line removed from dts):

    NAND:  Could not find valid ONFI parameter page; aborting
    device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
    Macronix NAND 512MiB 3,3V 8-bit
    512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 64
    atmel-nand-controller nand-controller: NAND scan failed: -22
    Failed to probe nand driver (err = -22)
    Failed to initialize NAND controller. (error -22)
    0 MiB

Note: not having that gpio assigned in dts is possible, the driver does
not override nand_chip->dev_ready() then and a generic solution is used.

Fixes: 6a8dfd57220d ("nand: atmel: Add DM based NAND driver")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v1 -> v2:
    
    - Only issue error message if error is not ENOENT.  If the node just is
      missing, move on without error message.

 drivers/mtd/nand/raw/atmel/nand-controller.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 2b29c8def6..fa962ba591 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1600,10 +1600,13 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
 			nand->cs[i].rb.type = ATMEL_NAND_NATIVE_RB;
 			nand->cs[i].rb.id = val;
 		} else {
-			gpio_request_by_name_nodev(np, "rb-gpios", 0,
-						   &nand->cs[i].rb.gpio,
-						   GPIOD_IS_IN);
-			nand->cs[i].rb.type = ATMEL_NAND_GPIO_RB;
+			ret = gpio_request_by_name_nodev(np, "rb-gpios", 0,
+							 &nand->cs[i].rb.gpio,
+							 GPIOD_IS_IN);
+			if (ret && ret != -ENOENT)
+				dev_err(nc->dev, "Failed to get R/B gpio (err = %d)\n", ret);
+			if (!ret)
+				nand->cs[i].rb.type = ATMEL_NAND_GPIO_RB;
 		}
 
 		gpio_request_by_name_nodev(np, "cs-gpios", 0,
-- 
2.30.2

