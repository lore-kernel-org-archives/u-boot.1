Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FC5D4922A
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19E42893E7;
	Mon, 18 Nov 2024 15:32:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dl5Qwwnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA77B89396; Mon, 18 Nov 2024 15:31:59 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF1589396
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f84907caso4617394e87.3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731940316; x=1732545116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u5ka/okGWx8eW4TAP2bI6zt9uj+1Igk7EPRHlZwg/DI=;
 b=Dl5QwwnzU5jdAcKbOFyg8HcM0muVF9iZM2RLcl1YfwhoIaCTHjrgDZ0vrUEF6UguWc
 Nhhdcjv+azI+8nwvrn7qUUzWWnNpjv2vYs+A1Kbjx7QyYU/08Q50NRahiZszoQ7mbKg+
 WvYBbT6olJTOZPMYVnHTRnpbIoLTBRO/IexahW7kGxi17cDWCz9f3hPi4/5CsBl16ewi
 /svcqUfNX5mD3tAK6lm8gGQfgWPHPGW0juS7jmAXTnW+hBFXfTtwYm2Rd/H671h5VI+b
 iXYHCtZ4VhtmC/fu3LC/jEiNae8eBO4b6fvN6ozg022d8OUHDwoyWkzQ2TWyDl6fzNjo
 HbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731940316; x=1732545116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u5ka/okGWx8eW4TAP2bI6zt9uj+1Igk7EPRHlZwg/DI=;
 b=GLFUD1UZcGiVA3EwF/Lqqktqhmd1XgXN/pG1UtskZsvsjVzHP2wuJJIndIObRWgBG3
 VfithAZA+IFDRyliMYysDH+ZLNEppN/EgGw+WkGDu6eiSzbIsnngDE0VtO46TaGleUuS
 zSMLk0Zitxk482mfqQ/Ybw2/XpjzjnXtdqv0ODuiObfowd3vz32Fxhjyvio8zQaH9Iwn
 ePJWt+tbOm/IPVu61cb04su8aDx6TaqQTJOkVwiQXa3wsgkaJT/FHrpdLjLILETczNvc
 jxyadS1fntPsSCCJg6J01QdxpPUaiDvF7cndcXLWHu+WXzq2H6YVALykq9bQAjHBiJo/
 b/Mw==
X-Gm-Message-State: AOJu0YwqsJnu2LyBGqyy+U1p1adWwKzmVWPgTNDDMZPSfanxwcdpe+Hx
 dgoThcpchHXyiw7W6hoDyw50tm6oLIHnO4czxjj5g2ITbxRli8paeBY1UHdNpi5hMUdGpwqUnEV
 ufPk=
X-Google-Smtp-Source: AGHT+IGSjrzFa3Jx4kqRwBRpU1BTxGms2cxQQIPLCG6A0gYFU/uWnirhUcfUEadnBpL6cxqQOJ0TWA==
X-Received: by 2002:a05:6512:b19:b0:539:d0c4:5b2c with SMTP id
 2adb3069b0e04-53dab3b9865mr5346688e87.51.1731940316484; 
 Mon, 18 Nov 2024 06:31:56 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:ea85:3dd5:8dc7:57d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab78783sm157149425e9.12.2024.11.18.06.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:31:56 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: lwip: fix get_udev_ipv4_info()
Date: Mon, 18 Nov 2024 15:31:25 +0100
Message-Id: <20241118143125.2258888-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

The local variables ipstr, maskstr and gwstr in static function
get_udev_ipv4_info() cannot be pointers to read-only data, since
they may be written to in case the device index is > 0. Therefore
make them char arrays allocated on the stack.

Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reported-by: Adriano Cordova <adrianox@gmail.com>
Link: https://lists.denx.de/pipermail/u-boot/2024-November/572066.html
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/net-lwip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 470217781a4..b863047f598 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -91,9 +91,9 @@ struct netif *net_lwip_get_netif(void)
 static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
 			      ip4_addr_t *mask, ip4_addr_t *gw)
 {
-	char *ipstr = "ipaddr\0\0";
-	char *maskstr = "netmask\0\0";
-	char *gwstr = "gatewayip\0\0";
+	char ipstr[] = "ipaddr\0\0";
+	char maskstr[] = "netmask\0\0";
+	char gwstr[] = "gatewayip\0\0";
 	int idx = dev_seq(dev);
 	char *env;
 
-- 
2.40.1

