Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7F4C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 09:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C5183A05;
	Fri,  1 Aug 2025 11:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ln13H0tK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E3C183A22; Fri,  1 Aug 2025 11:54:13 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB19E83A05
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 11:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45555e3317aso3523465e9.3
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 02:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754042046; x=1754646846; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MJUu7NeXkUSt7PVoZe1fVwIPkXbnkgWjZWnssAblxnc=;
 b=ln13H0tKxuVUaK2iQzdbV+8dunDJ2Ge0F6D4YFa7DDnV5CleDKwVUaYJj4g95LgbNj
 LiLa9k9dM2p04jShiWb9y33QWbW+/cfDESMYrwk1w+G2mW9pJxZtAla6iCJlbuByfJ6z
 zfvOFK5NnX4b0ry8SW3xcjrGEguZWAKCJ+tU4P/MQVVC/0Wg07eG5aKynS4IbzUNU5yp
 1UIeaga/JXiBDTuNvegJXoAohg0mtQcJul1R+4NrJOs8rMpOycwDHqK7GHuKj/Ss6fqE
 ZW1uGAI5NctcVJFx0aWxJN+7XjpKQfXkGruJKWGeF0E2COTZiV6pQGnPLeIDVjptTDbX
 CxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754042046; x=1754646846;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJUu7NeXkUSt7PVoZe1fVwIPkXbnkgWjZWnssAblxnc=;
 b=VSpCdAGfNynsafPPVhAvLg5Juv9ZOgPmXpLX/cD9W4nO5IA5BinQgsUSsGO6A8EGsk
 BNeG1WtCX3fc+4ZVk47B2yhF34lWNka7ZwIchYLcTQEbiYBXeJEAxcMVZ0BEG6DUFhbG
 aA/dLyYf2/KOThXQc62r2dtf6V1zNuGEfVJtADnhiT615fHOkVIo9Zq6ouFXQIFk8cLS
 AxakzHv3KC3m3Ru4gkLCYLrTUvZQSTewkLarzFMNkOPeHDQGLE+3ZCEqquwRjjvZbUvZ
 /IEGY2c/iQz6Yuuw8ulLhtGuCZaxs5xe+xHJS9f137yUV3PTJr/IAgfnWa+zWmB8kOhl
 xMQw==
X-Gm-Message-State: AOJu0YycHhMI4wuD8mlQkywVcgAZ5SYIGK5zK30D00y4AeeaaMoRV6dt
 E8SFQiDH9Bnl6SZgRzwjzqwUhZmqsIQdTGImmXhbB5Ls0mOJeTg+ozeYw8DZDyIGJuY45ehPFL5
 y7s5c
X-Gm-Gg: ASbGncvWSnfcBq6+VnQ1gGbqWf+ae5J/IkF7MCbWCpgQQxJ6YXhVFmEDl6g1LqRCBB1
 +nGUnvY7dyUl86lDbuEDwKaNsBw659kwclrdxEdRaXuZMvyYfrDnJ7Se68d36bu2/Q2fyA4iv9n
 25n63N36o7f9OPCLGNsNQEP4I/z2VruubPZYDP6QHZo6BZ2bZ9QX2A4QthHEmMhr0fEaLsvtTgL
 pJ/yLSbj+eTSIQS0vghI2nNTDyWlGukhyB/1FisPRCWWjQTyUkSLK/9vSdr5Ok1EfK/JsmpipI7
 3P3a1005rr3jeZLN/GpquOSPQgBF9A7Cvrej3gdFinNTh/ZvurUVrmTaN9a1cra4jsCqEhchCQ3
 xIuLKb66vxbKbyIkiDrKlqt0rQZJ3HK8e/d1rZyuU4vcnTSPTziU=
X-Google-Smtp-Source: AGHT+IHwHpmrM7sSn0OYJ/qcYalk/0Gz0dUqPcZiFS8Tl8myTPOnGIb4qE2cpPiJ/AX1yDBp6KdqTg==
X-Received: by 2002:a05:600c:5027:b0:456:1204:e7e2 with SMTP id
 5b1f17b1804b1-45892b9f1e1mr102650215e9.12.1754042046230; 
 Fri, 01 Aug 2025 02:54:06 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eba17sm95280515e9.24.2025.08.01.02.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 02:54:05 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 01 Aug 2025 10:54:04 +0100
Subject: [PATCH 1/3] mtd: rawnand: cortina_nand: Fix -ENOMEM detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-mtd_nand_raw-v1-1-80c316f5bb99@linaro.org>
References: <20250801-mtd_nand_raw-v1-0-80c316f5bb99@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw-v1-0-80c316f5bb99@linaro.org>
To: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In init_nand_dma there was code to detect failure to allocate memory but
it had two problems. Firstly the 2nd clause when info->tx_desc was NULL
attempted to free info->tx_desc when it should be freeing info->rx_desc.
Secondly there was no detection of both allocations failing, arguably
the more likely scenario. Refactor the code to simplify it and just fail
as soon as either allocation fails.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mtd/nand/raw/cortina_nand.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/cortina_nand.c b/drivers/mtd/nand/raw/cortina_nand.c
index 06918a46e93..a27a6994f56 100644
--- a/drivers/mtd/nand/raw/cortina_nand.c
+++ b/drivers/mtd/nand/raw/cortina_nand.c
@@ -186,14 +186,13 @@ int init_nand_dma(struct nand_chip *nand)
 
 	info->tx_desc = malloc_cache_aligned((sizeof(struct tx_descriptor_t) *
 					      CA_DMA_DESC_NUM));
-	info->rx_desc = malloc_cache_aligned((sizeof(struct rx_descriptor_t) *
-					      CA_DMA_DESC_NUM));
-
-	if (!info->rx_desc && info->tx_desc) {
+	if (!info->tx_desc) {
 		printf("Fail to alloc DMA descript!\n");
-		kfree(info->tx_desc);
 		return -ENOMEM;
-	} else if (info->rx_desc && !info->tx_desc) {
+	}
+	info->rx_desc = malloc_cache_aligned((sizeof(struct rx_descriptor_t) *
+					      CA_DMA_DESC_NUM));
+	if (!info->rx_desc) {
 		printf("Fail to alloc DMA descript!\n");
 		kfree(info->tx_desc);
 		return -ENOMEM;

-- 
2.39.5

