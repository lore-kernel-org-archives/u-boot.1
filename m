Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEE4D70DF2
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3C880325;
	Thu, 18 Dec 2025 20:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OoGDVVwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 232708003E; Thu, 18 Dec 2025 20:42:44 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB01B80325
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7b6dd81e2d4so1126721b3a.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766086960; x=1766691760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQQPrVcQuKGWRqkwPqURQu4DB0GctoNWsomn5vC8N7w=;
 b=OoGDVVwchkmK0Tcj6i29ayHDpEcYYIDeBYwAbnHiN6W/v1PWAoSB/IMI6uQvV1GkmZ
 1nYvwv8TqinvTMZ9Mg88yFLnfyjcSg7ItqDyp2ewJMQO+zlUKjBhZwRPU5oG5+uE6KCt
 Uuq/6no4gl1uu0TnEdWWeqk1RB3o/A8lKjnJOnpt+4UFwjhxvrlqhZgkBDNnuQVIxk8z
 2FahEX1DWCFQ3QnGWQKxzn6uHa9rXDXPmLH5BbgddY0m7AhRn+a4uZAuv7mojvCk7TVo
 Q6SGK6oKkE6QBLHGMX0HC92RfLYS8+FQfPuvKIVeBxL1Xj3RQfWJYxuPGdn4u4TZsCmP
 taYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766086960; x=1766691760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQQPrVcQuKGWRqkwPqURQu4DB0GctoNWsomn5vC8N7w=;
 b=X0UbE4Gr/lw/x7qN2fcFFJq/jAWTRhrFUGt19w/AzTaQ/uLOLOlbWSN8/jyrj0nOWY
 XNavm8EDP5Mvz8nI4xilupJBJ/eyE+3RHFNLoizYahECFbljTDTjuC2GG9UrotNSRoX6
 j06wXUS1O4lSiM+Gz44oiDOGck+PFQ5HuyIoIdchDDIsO+0psq9Zp/QwbZbHPhYN8MLv
 cwDEX3vo/vuKaeZganEz6iirq8N3uw1bcaP0xBtjbihbHNKyhb37vl+bFXAENRTJrt1J
 n7fpktFc1q3/ibcCBA0RPNkBwHJ5yGdig2t21NWDnB8DOeBCy9m+R4cQNc0wzvcnt6Rg
 saww==
X-Gm-Message-State: AOJu0YylZf4nre36fqxQ0qwi8EaSiiLlmvRl0vNuqHIbq6mhCZ8y9XPK
 KHrNYJv+0Ktv1wkIjcZkitRH4ASZWIpmu188Hv8b0iQQLBjGuaFEi3gg
X-Gm-Gg: AY/fxX5VPvUuY/hJyjOjV/bJ34XFDhA/ifQMXgCmZKkJpPgYQ8ls40t0Dgz41k4/x8q
 rAkB4NxFFt0CGWJkhgLsUpDC5tde2PY4SW/FkxZUTj+w93cQjkzpgqO47+S747bNuoZVupmtQhj
 BiVQJ0XWfDvB9Q211m6wY0ERd4VfZn3w5eJOmFqt1cVTW1Y2hPTOP7pPdOpDDynrT9cpyzP5sH4
 MzJFVSXx1xILlrzpiwCz4zyyKbF7Mie6Eu1eLjFdeVXPLgGyqwBMu+bAgVM39YowqUJEAzH3BHU
 Z4uXvFZlClLS/ifnO9BAUzGJgnilyhBmN/MLlBaw9dYHXAK+WCn8zgms0A2ZxGIInyU5Tb/VIiG
 u6zUruDCIPJe+6NGsWDVpeG0YsJ7l2jLC6f/NlGhYF8HZ9O5Q2BJVSYrnoWCbR+Xz3Z8u0HEpCT
 MM41pissRKmdJMqzFaOUu0mj7f
X-Google-Smtp-Source: AGHT+IFczc9ny0+5szMaEgLD2x8vHLdHbuhN5w/NquRw0XrOAsI6ZF2C0I8v2Dv07DBF/FR0sHc7ug==
X-Received: by 2002:a05:6a20:748e:b0:359:d00b:45f4 with SMTP id
 adf61e73a8af0-376a9ae284dmr518429637.52.1766086960370; 
 Thu, 18 Dec 2025 11:42:40 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:dc63:c226:257b:b4c4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7c146aabsm116413a12.25.2025.12.18.11.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:42:40 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org
Cc: u-boot@lists.denx.de, Chris Packham <judge.packham@gmail.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 1/3] mtd: nand: pxa3xx: Pass valid dev to dev_err()
Date: Fri, 19 Dec 2025 08:42:16 +1300
Message-ID: <20251218194218.1972757-2-judge.packham@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218194218.1972757-1-judge.packham@gmail.com>
References: <20251218194218.1972757-1-judge.packham@gmail.com>
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

info->controller.active is not initialised so the dev_err() call ends up
dereferencing a null pointer causing a crash instead of outputting the
error. Add a dev member to struct pxa3xx_nand_info and use that instead
of info->controller.active->mtd.dev.

Fixes: 661c98121d49 ("mtd: nand: pxa3xx: Fix not calling dev_xxx with a device")
Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
Cc: Sean Anderson <seanga2@gmail.com>

Notes:    
    Changes in v2:
    - Add a dev member to pxa3xx_nand_info so we can keep using dev_err()

 drivers/mtd/nand/raw/pxa3xx_nand.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
index 7bf54fa46540..a5293563a9fd 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -187,6 +187,7 @@ struct pxa3xx_nand_host {
 struct pxa3xx_nand_info {
 	struct nand_hw_control	controller;
 	struct pxa3xx_nand_platform_data *pdata;
+	struct udevice *dev;
 
 	struct clk		*clk;
 	void __iomem		*mmio_base;
@@ -588,8 +589,7 @@ static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
 			ts = get_timer(0);
 			while (!(nand_readl(info, NDSR) & NDSR_RDDREQ)) {
 				if (get_timer(ts) > TIMEOUT_DRAIN_FIFO) {
-					dev_err(info->controller.active->mtd.dev,
-						"Timeout on RDDREQ while draining the FIFO\n");
+					dev_err(info->dev, "Timeout on RDDREQ while draining the FIFO\n");
 					return;
 				}
 			}
@@ -641,8 +641,7 @@ static void handle_data_pio(struct pxa3xx_nand_info *info)
 				   DIV_ROUND_UP(info->step_spare_size, 4));
 		break;
 	default:
-		dev_err(info->controller.active->mtd.dev,
-			"%s: invalid state %d\n", __func__, info->state);
+		dev_err(info->dev, "%s: invalid state %d\n", __func__, info->state);
 		BUG();
 	}
 
@@ -1560,8 +1559,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		ecc->size = 512;
 
 	if (ecc_stepsize != 512 || !(nfc_layouts[i].strength)) {
-		dev_err(info->controller.active->mtd.dev,
-			"ECC strength %d at page size %d is not supported\n",
+		dev_err(info->dev, "ECC strength %d at page size %d is not supported\n",
 			strength, page_size);
 		return -ENODEV;
 	}
@@ -1802,6 +1800,7 @@ static int pxa3xx_nand_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	info->dev = dev;
 	pdata = info->pdata;
 
 	ret = alloc_nand_resource(dev, info);
-- 
2.52.0

