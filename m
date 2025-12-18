Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97A7D711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 22:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C163805D7;
	Thu, 18 Dec 2025 23:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mo74kVwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78EE8042F; Thu, 18 Dec 2025 23:59:51 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0918003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 23:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-34c3259da34so1150643a91.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 14:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766098787; x=1766703587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQQPrVcQuKGWRqkwPqURQu4DB0GctoNWsomn5vC8N7w=;
 b=mo74kVwYP3/2FVJOUYHmgGtoO2kcBJgGNEIu4jc9DyKqMOv0IwKQWfDat78qFK3Apc
 reej4HC9pbcp57c+4jdyDWeG7ZRlvejAFpeVz+dI+ik8yEKRlmHPdEoLvZ1PIJpHcAbY
 T9s7g/+q+4NyOqVy0hxOMFY+5MX/aAtMRe4TQgKhD4VM58/mFsw1JPYHM0unMc2kzJ6/
 eTwv8zmnpNOIYWWfgWR9jgJKN0ilMUrTa23GQDPVmfl3YFb6SMyH6k+QCtZ0shVokCSp
 4MFFVNsVjBn+kZxpVBwFxXxke2shIwBQhuJLN6jicOQIW0hEE4xjS0d2PUNf/D7BtNmH
 vfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766098787; x=1766703587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQQPrVcQuKGWRqkwPqURQu4DB0GctoNWsomn5vC8N7w=;
 b=HDlCmeNsSaTBZ1jIKf1oJZJCJsPsEUCssO5HSSfqWx9iArgh4iPLVOXUbVV5bAIDN+
 akyD4dkkCaB47ODqVbi6a2vprucx6g3ldn51ERe52cDvBpCAiR0dRk6YUHxwtJx0XAPu
 cXM+76MuQs3e5e3RPNFfxi/cblL/hs22jEh0L35IHh5rJr1QFsKplUw9WHbufzT7Z1RS
 9j6IIwX5H2JTT+bxZicrEfbU0sBbxJ88Vth2Px+LuKNofHhFLZdvBkv5YW7LZlAjIUr0
 +zL16wYaBw3J4EdPp+whVoXQoQhAbrVYZIhSVPU3G7hdgulis84YdavxFAmtp4KEcM3T
 Z3xQ==
X-Gm-Message-State: AOJu0Yzr+9nK9q3/H/fKPAtBCgi5fG4ZMfkfy34JRp83Dgopu2Yz4rfp
 WjlvZpFiWKKLFLbEyQT++uX9/oZLzwcX3p3OR0xIp6rDhr3IXnVcyoCm
X-Gm-Gg: AY/fxX5Kq7pW0w4Voly4iHDBNfIN9IDNlxMKtqY6p0ypx2xzF+fDkDBtzYV4pYskBJN
 jkH4hCLGTLwT+UVbnMatYYbIrXKGQ0ny686s2j1NWBsjlFoJy4aVYaRO5SZPjx30Wv41LWzL/r2
 rdWGa8LoQ/u/FrKtTszsHphm/P8JotSuOoKnTJVmvbqD4vI4gr/+Bp/FlLOoNMwFWlhXWBjvE3s
 M849F36fxvN46jAw87Vu2Z98qmukEr7zz6Ti0nt69HRu1gzluxWpJY6EakJ6Z0STpIhkPuELYov
 VtZivuQDdCAXGzVivqDLqtViIU+O0oEG0ZXISCVkGpGw++6az9kT5HRPD35QcaLxfdAE9E4vf7O
 iXSXdiWl+6/ozJB5PwnUrzOUh7FuJki+IclWOZZnm7xpoNZxwJ/ZCgXCzypulpVi9rr4CnNFUca
 5zUWg5ViOaMY9EmZNKw1zpfdK4
X-Google-Smtp-Source: AGHT+IEYdrI2QzdSIfp2lpDQKfnKjv+g6wWJ5qABd/vr8XolRwydwTkMpP7tr4h0KQo8IbnA/H5W7w==
X-Received: by 2002:a17:90b:3145:b0:32d:d5f1:fe7f with SMTP id
 98e67ed59e1d1-34e92142cb5mr850620a91.15.1766098787293; 
 Thu, 18 Dec 2025 14:59:47 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:dc63:c226:257b:b4c4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70d6565esm3431356a91.6.2025.12.18.14.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 14:59:46 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org
Cc: u-boot@lists.denx.de, Chris Packham <judge.packham@gmail.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 1/3] mtd: nand: pxa3xx: Pass valid dev to dev_err()
Date: Fri, 19 Dec 2025 11:59:34 +1300
Message-ID: <20251218225936.2016920-2-judge.packham@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218225936.2016920-1-judge.packham@gmail.com>
References: <20251218225936.2016920-1-judge.packham@gmail.com>
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

