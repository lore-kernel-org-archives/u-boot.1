Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D475CC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563F68142D;
	Thu,  6 Mar 2025 15:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YalLrXMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A3781433; Thu,  6 Mar 2025 15:26:03 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F9AF8142D
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso378701f8f.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741271161; x=1741875961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcXFUhHXxwpQjhY9ngA2fYwAh5PvWFvp9h7Czg8HhxM=;
 b=YalLrXMoohErmLyz3pOLAwJYOflNphpcCacb6b/9JrDWeanc2Fzl6SeOVxHoj+WXKx
 W9nFzvjypcpBxkHfBEZ1BtohTs5nbbVEYYR8tKBcSZK5zOZnH/M+eqXSpoeipUc2Ni4L
 H6L1xElb4y5DZYwY6Qa55Z4jry4ZoDPYIkdkedvJpK185ke1KVuMhu/NJzrYBzJimPgB
 vuxFNPWk9kJf7hZ8NiIMUOKsV+6PQpcZw7azuPalklzCFTVOv5ZfYKnhVQrM9LOUqsBm
 I+ePzGN9GKdhGDp5Osd4sSBkTBblN+xWLiPJZtgWju4xxt7nDhJF4OpGtHYwoe2Rz+0q
 jU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271161; x=1741875961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcXFUhHXxwpQjhY9ngA2fYwAh5PvWFvp9h7Czg8HhxM=;
 b=Cs5QbiJmmidUubqDYpRvDHAQOXhl7esiKzYAIZHZp2GAsBZqjSnAtp1fm+OZPE8pAf
 n0158v9jpdMF8EisUx/zWWW47cZpVwsHEUTkD45VXWIqkxjmWW9sSnW6oVeymZOCU/y7
 Ij1Sp60cRQpnX43Uc0Kpn0d6cXWc7iMHBzOkgFQG4w3oQx/Zs7tz5Y8xiqgyRuqcXVJD
 p54gjATh797LO9C1lQJU8CyhDJK+zUwAEgyOe6GMuvdSVwF0RJySG66Ma9AS+6ku065G
 GpMuNfUXVSMqaXtSP75qRVESOrhsg9PBETfSXBZ/MbRfRBA8SyFikZtzIodgWuoGSSwA
 tjYg==
X-Gm-Message-State: AOJu0YzhMJGky/ESIeN9pu4EKI1RTKNXxN7mnvXzhj0/0cMX4O2wcs0A
 3ydL4eXwCCDVVCiaNkBCfyXrlgU6VmpPxErbrSBkEkhp2U1T72Buw20pI09mxZTnD9gN1E7bpLB
 p
X-Gm-Gg: ASbGncs5yWXeVgR26G2gQKGItpXCxkImHuPYQpKfrBI3Us3i6s0mlWMnbsIBteMwUb9
 YlLfXp4xvICWeDEKJxBUgPzF3a0stn699JELFHVoPEm/V/SK6OzrjHONAZEvcpi8OVC9Rw1Qjda
 YVeDEXWT0ARuwQsRNJ/oAT7ii1fEHhXV7+OZKX2vz21lk+we2cLhDwXSR2rQOJzv4/Bla7/1emB
 FGkoBjF18ALHWfX0WBBsMo4HTpG06NOOtcFPRAAYOXkH1mf47gBel4VC7mcmOWYIYxxjKKLLiER
 AXYSaEE/YlNQ1U9Sz3h27IfZEkeLj8Ovt8XxxfCkKwIhGqUm6zYdsA==
X-Google-Smtp-Source: AGHT+IEeB9QJyH8hLuGkWmKshQFo+cZM9W8x1D2Vpux0vEntUZoELO6BoKJ4fujWJSE6SykO//ZWvw==
X-Received: by 2002:a5d:64c7:0:b0:391:2c09:bdef with SMTP id
 ffacd0b85a97d-3912c09bfdfmr1454266f8f.30.1741271160856; 
 Thu, 06 Mar 2025 06:26:00 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm2181543f8f.26.2025.03.06.06.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:26:00 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 3/3] net: lwip: remove net_lwip_remove_netif()
Date: Thu,  6 Mar 2025 15:25:21 +0100
Message-ID: <20250306142525.3079189-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306142525.3079189-1-jerome.forissier@linaro.org>
References: <20250306142525.3079189-1-jerome.forissier@linaro.org>
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

net_lwip_remove_netif() is not used, remove it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/net-lwip.h  | 1 -
 net/lwip/net-lwip.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/net-lwip.h b/include/net-lwip.h
index 58ff2bb2d43..36df78d61db 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -13,7 +13,6 @@ enum proto_t {
 void net_lwip_set_current(void);
 struct netif *net_lwip_netif(struct udevice *udev);
 struct netif *net_lwip_netif_noip(struct udevice *udev);
-void net_lwip_remove_netif(struct netif *netif);
 struct netif *net_lwip_get_netif(void);
 int net_lwip_rx(struct udevice *udev, struct netif *netif);
 
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 77f16f8af9c..f50cfbf27fa 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -214,12 +214,6 @@ struct netif *net_lwip_netif_noip(struct udevice *udev)
 	return get_or_create_netif(udev, false);
 }
 
-void net_lwip_remove_netif(struct netif *netif)
-{
-	netif_remove(netif);
-	free(netif);
-}
-
 int net_init(void)
 {
 	eth_set_current();
-- 
2.43.0

