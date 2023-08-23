Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F08C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077BB86427;
	Wed, 23 Aug 2023 19:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWw1dYpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2627986473; Wed, 23 Aug 2023 19:59:28 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CC3C86411
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a8586813cfso591166b6e.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692813564; x=1693418364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mV9+uGNPS3fg0oeVjhBYaL1jMQSOnX1qSJMPyCXgt+o=;
 b=MWw1dYpJETl4UwL9mp0LSmsS7/8s5q1yQu1CQQbqcCGnjq+4MufLMQk6GzSpFDcLpA
 DHdJ8AbHMW3CZTBBhtMOqckb8pbmASqL6aP1D41isWvNEYaVm8P7TyHsmnHYuBpSOPSm
 6Iv4jqID8BQ3JUhPG2Z7uu3qIPzFqwvIQQ1lsdxSQPz31prSSlJZYa6AQPV9IsWO0enC
 ptMo4C0NT64ER7LuUjuaLJ7Fd1lBpbwafVLpI6wCRxTYKJi2Vxdyc6uSw3Z9kHtsbc4w
 B1p3TNirTl9Q3vS7r4Qq55tTtB5CQlgbdqJaLymlKx0rkNIlp/sowHEa1vIcIlfxXnc9
 0L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692813564; x=1693418364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mV9+uGNPS3fg0oeVjhBYaL1jMQSOnX1qSJMPyCXgt+o=;
 b=WivEZwS9vpAl1hOPf88TQf6DmgV+7AVJkPU4UsjtT8h5oI6/3AzPTwQFmh3e+GN5B3
 7Ch2hgBcCjMe25dA8WsGdPdhMD45yt6xSxcPXu0vIx8yI0ASuut9siEIOmiRwaBtd2/Y
 4+09gvpUqrysHeMiNpxnleFPtaJnwyQ2du03c/f68it0+YiG06K+OWEbaW/fSxCnHhlL
 0JpGj9IqQtlWc8EntvVPZi7ApZmVimXvLwTceQY1dI6gVkxg6ekNyJ7O8h/Yr8RVVIwG
 xClJl5c+Q0emJwitMofN5lSItcX/v++d6z6K9obPl7v24KiIzMtHy+WMsuds7dT/84tA
 Z+1g==
X-Gm-Message-State: AOJu0YxUk1BsdMOS0JUh97f5SXbIueKtCqJEqEv5Kia1hN6MWCcBfbCY
 DqI7tz1Ea9LanCcoTM6tG1E7h+Bf1o8=
X-Google-Smtp-Source: AGHT+IHUsNS1JkeeJR64qeQDlCnMw+3ZSQ85/NUIAqlEIH9qVawdlO9KN8/clIOmSZ6iIvAyCgS0IQ==
X-Received: by 2002:a05:6808:1528:b0:3a7:49b9:20c with SMTP id
 u40-20020a056808152800b003a749b9020cmr15629351oiw.0.1692813564709; 
 Wed, 23 Aug 2023 10:59:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b51c:1cae:f70f:7819])
 by smtp.gmail.com with ESMTPSA id
 17-20020aca2811000000b003a842626b62sm5625271oix.22.2023.08.23.10.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:59:24 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 3/5] thermal: imx_tmu: Increase the log level for high
 temperatures
Date: Wed, 23 Aug 2023 14:59:09 -0300
Message-Id: <20230823175911.319414-3-festevam@gmail.com>
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

dev_info() message is not printed by default. Increase the log level
to dev_crit(). This allows the critical messages related to the temperature
getting beyong the alert threshold to be displayed.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Use dev_crit() instead of selecting LOG via Kconfig. (Tom)

 drivers/thermal/imx_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index d9a04eaf79fb..d2ea084d2d2f 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -238,7 +238,7 @@ int imx_tmu_get_temp(struct udevice *dev, int *temp)
 		return ret;
 
 	while (cpu_tmp >= pdata->alert) {
-		dev_info(dev, "CPU Temperature (%dC) has beyond alert (%dC), close to critical (%dC) waiting...\n",
+		dev_crit(dev, "CPU Temperature (%dC) has beyond alert (%dC), close to critical (%dC) waiting...\n",
 			 cpu_tmp, pdata->alert, pdata->critical);
 		mdelay(pdata->polling_delay);
 		ret = read_temperature(dev, &cpu_tmp);
-- 
2.34.1

