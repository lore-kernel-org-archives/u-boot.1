Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB23C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C2186429;
	Wed, 23 Aug 2023 19:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CHyHmd/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA61E86427; Wed, 23 Aug 2023 19:59:25 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9B686411
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a751bd3372so657372b6e.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692813562; x=1693418362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBfHJKEJNbUDEB+mm3XnXjqoZC5SqA1wcq/W7CI61/g=;
 b=CHyHmd/S1yF1yrrQEMATrkWtMSzsnDfC1+0qLqnqcmZNQ6YxeISEuZVPQrHWODG4ox
 h4B2YbF+UIwveLWVt+BaaYHNATGjSf18ijPmsFe0iyvlzfs/7Of1NodmhBj416hDQhNi
 k/93+CuamsUFoqvkRMTUBy/cBogsdjqVq0ND2q2/p+5qLppTAmZrepyFaqs9ngGW8hGt
 OFplN1U5F1XTm1BQsQwCBuZ0HXzfjJmvfBi44+3vlbuFtIujnoDmqwUGqMCoVdVO5mE/
 1Gs4K4WDhQKVPy1dVvjdULlC38Ur+JzSuZrHIXd387sSqXisuakr1FXCYlCIoY4BHae+
 pSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692813562; x=1693418362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBfHJKEJNbUDEB+mm3XnXjqoZC5SqA1wcq/W7CI61/g=;
 b=EFhnyx0m0wvtzN0HmEHuOxsKBlel8Q2/lkooK2nWZzY+iSKNXlPRleWNtqzNeO8OSI
 ove3tyl5U9by0a5LOaO1qMrR2JrkuLWOmI2aC3CV5cP8vzin9sNVXb5NK3LBESFbFqrx
 Rf0NknGiR8YBg3TsQkHaGInAVlsV7uNl05yKNWiVaqrZcmiMvduqz1esTR6fl+RdIvhc
 T4OBnYrNNIC6lnOA2uA5wm8v0I4og1Ubba/YjOO7LVz6dWYCToml/+UJuK5MU9IhwCSq
 poNyuQCo+lnevWtAPc0n8bNWG1InXst6RqK77gaQB7CVE/VT18apQxD7DoGmDpGtE1xM
 WJbw==
X-Gm-Message-State: AOJu0Yy92jPfO0oNne14lGg7Vg3MoW/JCmnzFo/C6Xj4VLT3kz1GQuu5
 DNGcfPXC8ZPZfbW4t/Jw0Po=
X-Google-Smtp-Source: AGHT+IFmbX/p8ys4vZYwogd0di7nhQYTKaO7gISbspYZEoYlSfqmdzz0o1u//p26EAKl7SRYd7maUQ==
X-Received: by 2002:a05:6808:2022:b0:3a8:8aa8:a4c8 with SMTP id
 q34-20020a056808202200b003a88aa8a4c8mr650167oiw.2.1692813562346; 
 Wed, 23 Aug 2023 10:59:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b51c:1cae:f70f:7819])
 by smtp.gmail.com with ESMTPSA id
 17-20020aca2811000000b003a842626b62sm5625271oix.22.2023.08.23.10.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:59:21 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/5] thermal: imx_tmu: Fix the polling default
Date: Wed, 23 Aug 2023 14:59:08 -0300
Message-Id: <20230823175911.319414-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823175911.319414-1-festevam@gmail.com>
References: <20230823175911.319414-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

When the 'polling-delay' property is not passed via devicetree,
pdata->polling_delay keeps at 0. This causes the imx_tmu driver to get
stuck inside the busy while() loop when the CPU temperature is above
the alert point.

Fix this problem by passing a one second polling interval, which provides
a proper delay to let the system to cool down and exit the while() loop
when the temperature is below the alert point.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- None

 drivers/thermal/imx_tmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index 97efc55044..d9a04eaf79 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -37,6 +37,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define TER_ADC_PD		0x40000000
 #define TER_ALPF		0x3
 
+#define IMX_TMU_POLLING_DELAY_MS	1000
 /*
  * i.MX TMU Registers
  */
@@ -574,6 +575,8 @@ static int imx_tmu_parse_fdt(struct udevice *dev)
 
 	dev_dbg(dev, "%s\n", __func__);
 
+	pdata->polling_delay = IMX_TMU_POLLING_DELAY_MS;
+
 	if (pdata->zone_node) {
 		pdata->regs = (union tmu_regs *)dev_read_addr_ptr(dev);
 
@@ -602,7 +605,8 @@ static int imx_tmu_parse_fdt(struct udevice *dev)
 
 	dev_dbg(dev, "args.args_count %d, id %d\n", args.args_count, pdata->id);
 
-	pdata->polling_delay = dev_read_u32_default(dev, "polling-delay", 1000);
+	pdata->polling_delay = dev_read_u32_default(dev, "polling-delay",
+						    IMX_TMU_POLLING_DELAY_MS);
 
 	trips_np = ofnode_path("/thermal-zones/cpu-thermal/trips");
 	ofnode_for_each_subnode(trips_np, trips_np) {
-- 
2.34.1

