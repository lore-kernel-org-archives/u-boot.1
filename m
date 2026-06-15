Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04347CD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 19:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D895E84884;
	Mon, 15 Jun 2026 21:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="TATsa7v7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496A2848A6; Mon, 15 Jun 2026 21:24:39 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B6508484C
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 21:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-43d16405b54so1375618fac.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781551474; x=1782156274; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0wGiL6tA6Mu+fnId9ynOWX/8KTZlOKoF85JkIXjyMlI=;
 b=TATsa7v7fsKAkzA/OxSKkwkf4Mzg2Bj3oSdobKT8NN0XZ5DvLa9xkesdkaOxiAqx90
 Rx6tl7e+qCi2tCyDXqR6y0oXbrp4t7fOLxnAhiGxf3sS9jAMNpTz05JFzT3B4WqhVbta
 eCEb47UoGGkyD6ANXZmWl2valLnwJU7C56CKhSxiiQwjP360lmadgjqgjtPcgcbiFs+P
 3RfkKHpLjuLEmxdF3fDQGPBXYvxlvQ0lHdeN5MwfZoz4sgTo5YWZKIUxfNBlQk6yVkrg
 SeFkncyXYrqjBbH7kaQywMhkiKHw2DzVltfZ3ibXtsbtwYW1TJTwMQa3FGm84f8VNxq9
 Devw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781551474; x=1782156274;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0wGiL6tA6Mu+fnId9ynOWX/8KTZlOKoF85JkIXjyMlI=;
 b=C8N6HDZxhqxKDLsvbe9fQTLDz57OYKY9pJ6QCJakvtX+/cOu3ezWN1ANCf/oY+56et
 sEuqKRKUrA4jeEWYEXiLN1CqZT0i1LKMtO9CeF6IkW4RCdjq1FQFdmlzhnv3URq5AL1v
 qN0CJJF1cEvsvZKnMkQBZHO92THzybAXYQgc4HFT2cQBCIid8vhdApxhYrBSR16TXMCo
 FLA9dkfWgZwYpOw6KkVy4z/tgHF2xE9sI19GP2EK6/ETxS/kt6WUv47vTGYh33RnG3BC
 sdhpQBCOHzY9LM6QW6HHszAi4n5mAtM2rSaH0X6Eip1KcHNLATF0NBB6T+I9Z15xMPBc
 1fgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rrmGyRaicT555zyk6FJea/1yN6A4yfIz6vmOi9OqkCuhQUgn6YUm/+OG8/6bOJoFSz++mMHU=@lists.denx.de
X-Gm-Message-State: AOJu0YylDQGuRkKbMPR+xthoDQ3oAougNSqtrfLcUmr11m/7p2nQkd7U
 puOYnhPhLTgGtv4xqXYGAk9gFXlTbLkDdu0jUIg/jQilHnZ0NCOrSei7Kq1LewdGnXo=
X-Gm-Gg: Acq92OHGbNoDVm882hhwx3M+HMRVo3aZk9TPO1r3Awrg0/ZRVO6xJNFUvwzcdoGFyUq
 PEn+U2qGlFIQWC2XlyF5FhuJQTFUtnPpEQKMaAw8jYx+seaDsdCZ55Z93AFtbVmw3FP7XWLEWRE
 1foPN3wwyQ1t6swiibZ4ccBSYoRQ2JFZa43qWzzBfU5kbem76GO97XIHfK3CqxkFaNXAoQM4ljY
 oqE2wOR/qIXR8PxpuNvtoCzOxoR47raqVP/8SR45KJq1MhJxvr59oRQSfz8+7xFJvzrMjSoDG7o
 7BvY1lB1W1svVNjoCbrZI2vzOVMa2KkngvCUa/kpsQ59zGFsRDJdhTuO5uUzQm64cnPtdLObv3i
 zWX1bLH7Pn6qvNeW1RH7k0Sr0NbOMFKlF+OYJLX5WQnygV5CQJE/zolVSGMviGcKMPu1kqibkbr
 3amvqo2hXaFngE7N2ULuEhb4iQbEv/
X-Received: by 2002:a05:6871:a984:b0:441:3cdc:28c7 with SMTP id
 586e51a60fabf-4428c185818mr7190905fac.9.1781551474235; 
 Mon, 15 Jun 2026 12:24:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430866fa15sm573450fac.0.2026.06.15.12.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:24:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 14:23:32 -0500
Subject: [PATCH v2 2/8] net: mtk_eth: select LMB_LIMIT_DMA_BELOW_RAM_TOP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-mtk-fix-ram-size-v2-2-f72cfc52ce58@baylibre.com>
References: <20260615-mtk-fix-ram-size-v2-0-f72cfc52ce58@baylibre.com>
In-Reply-To: <20260615-mtk-fix-ram-size-v2-0-f72cfc52ce58@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Rudy Andram <rmandrad@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=743; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=w/DRD4O/fUACIV0S73ECIVv/u9zbWFp+ckhMaaN/WVQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqMFFB396AhiQMaWogHgGn89/aHHTbtKYkfzl9Z
 Bo8U69PZxmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajBRQRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AQsAH/A/1sNeZJrRf1kgNZa+xtn+u9Q6i2C+dE64N9Dt
 H0uuabwn67Yw2cMWXJOK8nyJJwxBHCc+Lj6nFcTNcs8RlyJN7wCSRAPLpYsxhnM8o07tkly8l3g
 0Z1W2/8FcV+cTBF+uaFY5MSm+/BP6OVHCBpKE8jS/x4qQ2r62hFMbV7jSqsqagdIfwmhP58R28K
 V/QnK067d5/YONMIcrb7t3QUphzb9K2wdCNNR03RremOQiwaNWFUelXKceM0mzpl7nXlCpCgmws
 PdrwrtFScyMb/k3idAxTFLN+ZgjrKhI09cXZ5JcTtjD1xo2P+ACbBO73kxJy3s1gMr/bx613567
 ccMU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Default to CONFIG_LMB_LIMIT_DMA_BELOW_RAM_TOP=y when MEDIATEK_ETH is
enabled. The MediaTek Ethernet controller can only access the first 4GB
of RAM when DMA is used.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/net/mtk_eth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mtk_eth/Kconfig b/drivers/net/mtk_eth/Kconfig
index 5d4e54ab90e..7d58f542bde 100644
--- a/drivers/net/mtk_eth/Kconfig
+++ b/drivers/net/mtk_eth/Kconfig
@@ -5,6 +5,7 @@ config MEDIATEK_ETH
 	select PHYLIB
 	select DM_GPIO
 	select DM_RESET
+	select LMB_LIMIT_DMA_BELOW_RAM_TOP
 	help
 	  This Driver support MediaTek Ethernet GMAC
 	  Say Y to enable support for the MediaTek Ethernet GMAC.

-- 
2.43.0

