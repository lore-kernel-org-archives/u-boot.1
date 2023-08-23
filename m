Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D6FC27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1770864D8;
	Wed, 23 Aug 2023 19:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EybnIPCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E008647B; Wed, 23 Aug 2023 19:26:56 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C6E8645E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1a2dd615ddcso1036523fac.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692811613; x=1693416413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48y5UbXb0bIn5gqawCalsiAVtyhfXpXKZXyL2kzNP6k=;
 b=EybnIPCOfTIcB4KDNRvdufvm0y+SPfsvir2y6sGHM0dfdvyd+a2qQUxMfK+ShjeYca
 WNadyOHbafpywjARHqnqImtc8kfR/zjCy0WdZwZukpAilZ40fzqWbAcGlW/WOG41JjGl
 0j6APrdKvE5r9syqsOw7Oqr9DRF/+WsA9Scdi4IE9N1VrQpcQWt17FM+kNiSv8LeBJo5
 al/Jn6WIr6McIja5046KZm5Iu9Gd09MYhecmNchdhifui6a5+mzM7/IJVaM1QwG/kA0p
 96lk09qlcWywMbLLcQ6gj46kXO/XAi8oNCqgkLVMtw3XKpvaTFyFJHQPiWb2y7HPTlT0
 CitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692811613; x=1693416413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48y5UbXb0bIn5gqawCalsiAVtyhfXpXKZXyL2kzNP6k=;
 b=LXQrTRl4swQJozkTbYsVUHkTuaqJmy0jk0gsacAfUT8NUGbs85FgtHjV3v3hJfPoEk
 e7ObJWFVK38HjiDCLhNWkLwQqPO/1HkELD27XDju+cIcyQacqf8UycNV9m1oV1oGDGMG
 PkxBLQvx/ht1g7GThYa8eFNwciQt9peYiXwkb+PwRvxVdmApbsRtNdEQ8IMWa9J+Y4oh
 pW7HqBOKm3wB5umaLfQ+L2r/Kdw/bKdLV4llAgcDg49CVed0COPBMyycAnEmmvayCFPV
 hyIFfAVCq2iUJPBDTUCk+yyky4Zf9q5RP8kmKw35sqWoqfgtQT9LIkOP4VrcZ0W8nH8L
 IxJA==
X-Gm-Message-State: AOJu0YybL2+8y/vaJTCARXyzRKkrF8Ss3YYJKG+DUCqihEhktBiIzZTH
 68m9CQ6B7AWx2TcLBPIc2zWsvhcUXj8=
X-Google-Smtp-Source: AGHT+IEP2cGye1ps37/XdKZT2CXZXg5cf1O2Y6jl0kJ8XfAOWQGgJJOAGnx6EB/Wbo4R1XPf9YUPvA==
X-Received: by 2002:a05:6870:6124:b0:1b7:5e47:5b75 with SMTP id
 s36-20020a056870612400b001b75e475b75mr14220313oae.4.1692811613370; 
 Wed, 23 Aug 2023 10:26:53 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ae60:b44a:59b3:894f])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a056870734700b001c0e840ebcfsm7158926oal.35.2023.08.23.10.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:26:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 4/5] thermal: imx_tmu: Fix th temperature unit
Date: Wed, 23 Aug 2023 14:26:36 -0300
Message-Id: <20230823172637.303101-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823172637.303101-1-festevam@gmail.com>
References: <20230823172637.303101-1-festevam@gmail.com>
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

The temperature unit is millidegree Celsius, so divide by 1000 to correctly
print the temperature values in Celsius.

While at it, also change a typo: "has beyond" to "is beyond".

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/thermal/imx_tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index d9a04eaf79..f79b583811 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -238,8 +238,8 @@ int imx_tmu_get_temp(struct udevice *dev, int *temp)
 		return ret;
 
 	while (cpu_tmp >= pdata->alert) {
-		dev_info(dev, "CPU Temperature (%dC) has beyond alert (%dC), close to critical (%dC) waiting...\n",
-			 cpu_tmp, pdata->alert, pdata->critical);
+		dev_info(dev, "CPU Temperature (%dC) is beyond alert (%dC), close to critical (%dC) waiting...\n",
+			 cpu_tmp / 1000, pdata->alert / 1000, pdata->critical / 1000);
 		mdelay(pdata->polling_delay);
 		ret = read_temperature(dev, &cpu_tmp);
 		if (ret)
-- 
2.34.1

