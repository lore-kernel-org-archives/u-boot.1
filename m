Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9DAE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EADD4896FF;
	Mon,  9 Dec 2024 17:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DU1tZz3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A6A89710; Mon,  9 Dec 2024 17:15:03 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE8889699
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3022598e213so9306481fa.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733760900; x=1734365700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmZi3iCQTN1BjNX132wUsXSSSN9dPugqOUg4J2p4zB0=;
 b=DU1tZz3I+rXXCi0mwS1mh+26Za6YRt8Yu3+ZQS/an4nQbSkdnYsmqoPBt+yJhjzkag
 ubVHzMcUgL8BIVFScre+q8xIpglJrD93wv8P7ySmINMJO8YcM97mF/ZMGy/CXz8R3wqm
 2EvkibQ9UQcVwkBlHaMQFWq7E4kFdY/mP19HXogn4+9UJoxkwbZc+LaqPZsrGp+B/QVF
 qxdEIRtaPekiq21555srxLPsawY6wzt4FpQ4cvB/ohfr2S6Q5thFe+fjybVUApptc5/2
 dsv6QgIb+gY0JG3+bWhnRx5UJB9WTT71Cp7ABM7icNkenER2IuubLsQwS9WgTYpxlHId
 v+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760900; x=1734365700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EmZi3iCQTN1BjNX132wUsXSSSN9dPugqOUg4J2p4zB0=;
 b=Fmx9ADgApf+bsfrOVgQ8G6VUv8FEvcSxjOCh1jqnKxaa+1G1FilhygNu0RnYxRKo4q
 VmdrPJVJIyIRlcfe5OGsMvcU/NeOH93pHpLylIyxOlsnEXkDq16OIZKmc6hdQI/PhMzC
 XIxjFBnfqFElNc/rL2e78agn5K0ackEVlWH8Gnuy7OhNCIrffjIAG4N4bbYltPVIcMsx
 v7NO+NwB89BiiB+wslld0at+h7CnawWr/n3iyTAPdwO5CvSDQ7n3H9z5Y79UqC7bzd2Q
 nNySHhsphLQx+OYB1e883QucL8RUt0/FFzeHgTmPBdzrFgpkrBBWmXdI2Ktt+psPp9U1
 uOiQ==
X-Gm-Message-State: AOJu0YwVStTkZ1cnqyjTibA/97eeBlhWlxNqWf9PDsya95ylWOwM40wL
 3BGGsQ3PDZNgugICZK6sENjsRtK8VJD/ggJ2+uCh8+kuDVvXDz/k
X-Gm-Gg: ASbGncuzMb5G6hcBi4cOVgOVPdl6t0dlTcpBuavaOufbNUfqJ0HJ8n82Zsi2vco5SpX
 OC0zSWrtimhtOdtYA3KI04c7eD7fqU9SQECBW5gIPCCS2xZIiDPfE4X86OR3ZzP+8pxK6jZxfTJ
 q0M0sJmNcKpDf4fQtR7oKVXBRc3e4XqPZ4IgMyeLK5U4HduR58A4kuXCKFlbXkUHx3hxkX/1AMG
 qEHMHIF+NXWr45nXs9KF4MIzZvRia7YPIOoDN6TKw==
X-Google-Smtp-Source: AGHT+IHaW2Rt6o7dBKItVyMELbTtvrWuDRuSJGGdN4gMZNGR++Gzd1maUl5F5Pln0mKMlzjeXybcRA==
X-Received: by 2002:a05:651c:996:b0:302:218a:6355 with SMTP id
 38308e7fff4ca-3022fb46ca0mr3367981fa.13.1733760900187; 
 Mon, 09 Dec 2024 08:15:00 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3021a02d90bsm5940971fa.80.2024.12.09.08.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:14:59 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>, Heiko Schocher <hs@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] Revert "drivers: gpio-uclass: support PMIC GPIO
 children"
Date: Mon,  9 Dec 2024 18:14:32 +0200
Message-ID: <20241209161434.6563-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209161434.6563-1-clamor95@gmail.com>
References: <20241209161434.6563-1-clamor95@gmail.com>
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

Requesting of PMIC's GPIO child should be done by binding
GPIO driver to PMIC's node is GPIO driver does not have
its own node.

This reverts commit c03cd98d1a163666b4addcdd9a34fc0c77dfd0a5.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/gpio-uclass.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 0213271e3a6..67fc776cada 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1142,29 +1142,9 @@ static int gpio_request_tail(int ret, const char *nodename,
 		ret = uclass_get_device_by_ofnode(UCLASS_GPIO, args->node,
 						  &desc->dev);
 		if (ret) {
-#if CONFIG_IS_ENABLED(MAX77663_GPIO) || CONFIG_IS_ENABLED(PALMAS_GPIO)
-			struct udevice *pmic;
-			ret = uclass_get_device_by_ofnode(UCLASS_PMIC, args->node,
-							  &pmic);
-			if (ret) {
-				log_debug("%s: PMIC device get failed, err %d\n",
-					  __func__, ret);
-				goto err;
-			}
-
-			device_foreach_child(desc->dev, pmic) {
-				if (device_get_uclass_id(desc->dev) == UCLASS_GPIO)
-					break;
-			}
-
-			/* if loop exits without GPIO device return error */
-			if (device_get_uclass_id(desc->dev) != UCLASS_GPIO)
-				goto err;
-#else
 			debug("%s: uclass_get_device_by_ofnode failed\n",
 			      __func__);
 			goto err;
-#endif
 		}
 	}
 	ret = gpio_find_and_xlate(desc, args);
-- 
2.43.0

