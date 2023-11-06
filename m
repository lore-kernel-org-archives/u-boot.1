Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC86C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 09:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A3C586FA5;
	Mon,  6 Nov 2023 10:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="goCHIH7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4485786E81; Mon,  6 Nov 2023 10:01:02 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7756686E40
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 10:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9d2e6c8b542so611032266b.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 01:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699261258; x=1699866058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0sKiLArrOtLm4qQHPdG/iWhAp/z/rz5rgLLQwRHPRs=;
 b=goCHIH7pYdWNhbXia+FthmORlNaGrDN6QrUcLlzEon3qYc73XCsLZxSKxPm7DdACid
 jQfPoMw7xt3phK2HJxDvc8LLMwbCTYwmrPG9FlGqyls9UCtK6cjRjCA17EY0xI932jxE
 ubmL5H71DZeHipUxkhFzYSi2nWCCRjJ4x5GBl/ZHGTRRT298QKDqwgAhpjoN/jmNVw2x
 YiM3W6xtaQN+yGBTAMVC8Ll5OACqoCjsq3iTS12sCt+OkK0zeDO6GmGBj/Jnh9o33GF6
 mtUTE0x2ScTuxeFQRQgOit/OX0C3e/tuxQC3NpvqjV8RxRTUMESMNowRxfKcgTAAyWnz
 Q6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699261258; x=1699866058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q0sKiLArrOtLm4qQHPdG/iWhAp/z/rz5rgLLQwRHPRs=;
 b=g+hSspdeTWqEzLY95mfWeQsTaN/pgQ56IK+MVknQG80FsjVfi0pQ6PbeywpIeqis1h
 pwxs4oWXB2dw0OxYfe0eajBT9mzEyOD/TI4mPYKHi7diOGF53eC1f7T8hKbpX6zrnaV8
 lNx+fb8IV8hGr596rAQqbXf7YJh3UJlPiGf2rR8/kNIOUN7gl8jhXKJleidmSuYZt3mr
 FzXBLYRqpZaUCyS+xMbSnM8SWaRrAa7PK+nJlyooQG0eLJEfBPxpEZkcQyr9Y9LOu/fr
 v7+ZBAsMtV6OrbDe5c5e8MS0n6svCLikIIqfrlKVDLpuQZdaZXdU0wJVb6DKrCYHkMUu
 yx6w==
X-Gm-Message-State: AOJu0YwwzC/sYruDBFGncE9Lem3qLsVXnhs05nS7/zlJpN3O0tx2fsmn
 vIunBavBq+j2wlWJxzYVVn8OoNjtNR0=
X-Google-Smtp-Source: AGHT+IFaGr80jjXTcy1TM8318GW66tajLSn2IZq1Pwob7qbJrcYzUlx4XdljQqPvfxiHwiZ2c1x3Tg==
X-Received: by 2002:a17:907:d9f:b0:9bf:7ae7:fd6c with SMTP id
 go31-20020a1709070d9f00b009bf7ae7fd6cmr14671128ejc.10.1699261257670; 
 Mon, 06 Nov 2023 01:00:57 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 uz12-20020a170907118c00b0099bcd1fa5b0sm3870115ejb.192.2023.11.06.01.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 01:00:57 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/3] drivers: gpio-uclass: support PMIC GPIO children
Date: Mon,  6 Nov 2023 11:00:44 +0200
Message-Id: <20231106090046.258589-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231106090046.258589-1-clamor95@gmail.com>
References: <20231106090046.258589-1-clamor95@gmail.com>
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

UCLASS_PMIC may have GPIO children without exposed fdt node,
in this case if requesting fails, check if uclass is PMIC.
If so, iterate through its children to find correct device.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/gpio-uclass.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 7aece85a70..6ef7cb4b78 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1143,9 +1143,28 @@ static int gpio_request_tail(int ret, const char *nodename,
 		ret = uclass_get_device_by_ofnode(UCLASS_GPIO, args->node,
 						  &desc->dev);
 		if (ret) {
+#if CONFIG_IS_ENABLED(DM_PMIC)
+			struct udevice *pmic;
+			ret = uclass_get_device_by_ofnode(UCLASS_PMIC, args->node,
+							  &pmic);
+			if (ret) {
+				log_err("PMIC device get failed, err %d\n", ret);
+				goto err;
+			}
+
+			device_foreach_child(desc->dev, pmic) {
+				if (device_get_uclass_id(desc->dev) == UCLASS_GPIO)
+					break;
+			}
+
+			/* if loop exits without GPIO device return error */
+			if (device_get_uclass_id(desc->dev) != UCLASS_GPIO)
+				goto err;
+#else
 			debug("%s: uclass_get_device_by_ofnode failed\n",
 			      __func__);
 			goto err;
+#endif
 		}
 	}
 	ret = gpio_find_and_xlate(desc, args);
-- 
2.40.1

