Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1342E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 06:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C62894F0;
	Mon,  9 Dec 2024 07:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d/K/JU0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55712893A2; Mon,  9 Dec 2024 07:44:39 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43561895B9
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 07:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53e399e3310so1981361e87.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 22:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733726676; x=1734331476; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bI/tzbrNeU/ZkYjxfkyRG8/9PVPpu0Gmg1Oh695pgNI=;
 b=d/K/JU0abnYyU05pjvNEKRje5+38dbVuMD/tU7Z/dHv6UsmGrSYwjMT/b65BhvPl99
 1OgjLUKBzv+wk1d6AxpfMPZSOtXuEBQq1sa//SEKKjzgjGcQIMwpPI7YWZJbQvY8ysrN
 kg9aCTRSBb0zrpP8GA4Shh3nzRhJOeHmcb/RWUKMXqQDYdRi6DcJA52UGyESBGdtPUCV
 VQNcvK4S7GxFDO9lXxmLkiy18HT0ow3LAltOGnFGjbbiqxSvvfiGERCZnCwjBJXQUxvd
 yr4B/zp4eO2+6Ep2EbL8rRnv1q3qfdTffuEs5zeP0gu8UfIiH0RJKZj4eCupgLu2S7dK
 Rz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733726676; x=1734331476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bI/tzbrNeU/ZkYjxfkyRG8/9PVPpu0Gmg1Oh695pgNI=;
 b=rnyH0a8KL+r4nE+27RGaaUF2DJbNAbFi8MLO2KvUxKREGKKX5vSiDTp8aZU5UC3Dt/
 uSkcvdjphWK6snk3iOzl0tcuM5R19ZD8xArRLFj1s10hjVeYCmwWSz9S1DOKjr1X7KUZ
 8c4cxPoHT4jdWkl/tTXll97Tlp9mfzR8G4AsX3pCMV5Q/2eiF57+8SVmv+nlnb7NSV5a
 +OTIr5mtyzxeFq8bOB4epCE2HEPytefC38Bd/6rVjr8ysLM+DtM737wG2AD4jcVNjpv2
 1TDH1e0kQ8/ya+DSY3XBZEA6TQ0DSNzLy7RyZdq8Lr5h0uzy5D1WKSBlYxdr8YPE4Nas
 wVrg==
X-Gm-Message-State: AOJu0YwbC9CpLAi4ADLkry/PVyIhrR9+sOG2p6/TBMG4xMU9eC3DKGJc
 ZLU2/1MbnXW6zwWRE3A4XXO6RmAyeiiylUCsIH9FDekJfJooqqMq
X-Gm-Gg: ASbGncvDYxWuaKrwUHmjANPVEzGugaSDAvYXS5WgOW7nTLbrAUiSrKkGuFFHcEop6Rh
 0ZrHryfZ+Q55XyGpuTRNFPpPMrq4U5jg6akCkgs97w+6XNIBcTglx8OiJpeBMfsyl7a/Oy0kzYI
 nmFA++sZOkFfltarFY6n4bU5GoJ+Pi3KmGYIB3YHSCBPDC3jmZo1N4glwkyWhETdmOyrydMNr6T
 BtcevCEBpyjjuoizhAvdZk6tqrK4B4QdCUBKGcu
X-Google-Smtp-Source: AGHT+IF+KuHGV2rtAda+j8kaK6Fa/Wt/qfBwTAQKyIb9PtKa9Jl8HmZTfx6CsCPRHQJa5K2Sht5mLg==
X-Received: by 2002:ac2:5ec2:0:b0:53e:2bb0:4942 with SMTP id
 2adb3069b0e04-53e2c2ed85cmr4088295e87.57.1733726676275; 
 Sun, 08 Dec 2024 22:44:36 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e313bfb40sm951527e87.222.2024.12.08.22.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 22:44:35 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Ye Li <ye.li@nxp.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Jim Liu <jim.t90615@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/2] gpio: fix request of PMIC GPIO child
Date: Mon,  9 Dec 2024 08:44:12 +0200
Message-ID: <20241209064413.6282-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209064413.6282-1-clamor95@gmail.com>
References: <20241209064413.6282-1-clamor95@gmail.com>
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

If correct PMIC child was found it should be requested as well.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/gpio-uclass.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index e776906fe73..e6c00c48722 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1160,6 +1160,14 @@ static int gpio_request_tail(int ret, const char *nodename,
 			/* if loop exits without GPIO device return error */
 			if (device_get_uclass_id(desc->dev) != UCLASS_GPIO)
 				goto err;
+
+			ret = uclass_get_device_by_name(UCLASS_GPIO, desc->dev->name,
+							&desc->dev);
+			if (ret) {
+				log_debug("%s: getting GPIO device failed %d\n",
+					  __func__, ret);
+				goto err;
+			}
 #else
 			debug("%s: uclass_get_device_by_ofnode failed\n",
 			      __func__);
-- 
2.43.0

