Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED31C35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 18:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E47881DAB;
	Sat, 22 Mar 2025 19:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WNf95yal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AD5810FE; Sat, 22 Mar 2025 19:38:42 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6CC981D25
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 19:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c5b2472969so301642185a.1
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668718; x=1743273518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/we4y2Pql7oEtXmGAXuID4BHEgAnjWhe0+dMWnQ5tqw=;
 b=WNf95yaliTufmjDo1XkPzMdSMQo4rSFn8CXBuVVn6V+pR68z3tUgEcUFQkGV/5NiZE
 rYvbLM10ZuNdw30xRq91Up8dK2iYXTZqaDYjFYETgvIjJoXns0eHFz9o9Vc9fWbaSdR8
 +tm9Y+KZIqAo53hcT4WfjcVYZHrpw5H27+DPTTJPDKsCARyc2fjVx/nuh18V0v7wpvzM
 qgusgzuE8qR1YMYol3NdCR1+xtC/pw96R9VObaLp1yH5alqxOpV67ozwgSbeP8H2V8Ps
 QdidiQroupxH39qZHs2z7ZBwVa5E8L2h1MDfrQIBEbVwbw7ZR4cHMxA1JhghEkVJYEjK
 MCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668718; x=1743273518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/we4y2Pql7oEtXmGAXuID4BHEgAnjWhe0+dMWnQ5tqw=;
 b=qPk5mzpUKjNqXyT96vT7gPXt+2lDvh0fVkfcKLiVQ9U124tWx/ZZMbNUB6KRE/rjQU
 Wdzjml9flToX5ad36YTrv5DaGtwb5vYpxvLsKLahE1MKfZ/TEvklUPkO/SYOFFGi/L/Z
 93L+zk9yzqAdS68YsArAf6woLjQMOaYDTH9DZJFA4hf1wjH9hIWfTUSH4UJCIQRqKUP1
 lToxT1176Cn5VjV227+ZgbRRq/byLsdNlDg+nvJCEPIzBZnO99WNXjvHqUbrbudbwl7s
 Zs6Ztw8dq/RCcINZWlTov2iNMgq5ocE8N2gXTwvE1lvLQrzYPtUMH9kpHA4ck0Lg+/FN
 +Rkw==
X-Gm-Message-State: AOJu0YyqZWCzhaafylkXTKcY8Bl+KYUMJjPD2yiOjuIxOH+qZW2HM4bw
 5uMoA5vUCv+CvsGZ3BX37CNNgBQqnytJVqu3LK3ofPnkg9Is8urGDgz66g==
X-Gm-Gg: ASbGncv10JjeCj5ICnc4Q5NpZboQfXw+xC5PbXGNB0iF5LT0JTEnB7VPvUdA3czFw2O
 nU+hZDD4GD79tB6VDgUzDyIqZJnu6pk5IJeiZpDYGvxDFWAFggY0/5n1Opj3SSo28mHyPYX+2E4
 2rhHhn3tvkxaOfEy424I7peSLI8gyH1KXZoLZ9SRnxf9z/KWamPiscReBVKPt1ZqlN7NVO/SnVa
 QrBSGRjVc1ipk+nwGvXka7MJfcxSugvdx/WrYelYSCOaUddl/XdsB0uP81QJI2tIPUwKlDBDTxU
 RswGHAMQrxeFCvVFT7cVn0a3DQtGFQiEk64UABeVjsA8CtY9If6aom3SrXN50+z9EcyUfjvW860
 Fu3cvcFK8SqW4KslePhs=
X-Google-Smtp-Source: AGHT+IH4Mk7jNRcXGkE1cgpNw2FKBWaRrp/qUlP9tDq9LLRGN9K1DCk+uRnS0YOCst9hvLPkHk850g==
X-Received: by 2002:a05:620a:4106:b0:7c5:a5cc:bcb9 with SMTP id
 af79cd13be357-7c5ba2058c4mr1088266385a.56.1742668718110; 
 Sat, 22 Mar 2025 11:38:38 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec648sm278126185a.61.2025.03.22.11.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:38:37 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Sumit Garg <sumit.garg@kernel.org>, Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V3 3/6] cpu: imx8_cpu: Print Speed grade if IMX_THERMAL or
 IMX_TMU
Date: Sat, 22 Mar 2025 13:38:05 -0500
Message-ID: <20250322183812.784676-4-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250322183812.784676-1-aford173@gmail.com>
References: <20250322183812.784676-1-aford173@gmail.com>
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

Much of the data that is display by imx8_cpu.c is also displayed from
arch/arm/mach-imx/cpu.c, except the temperature grade and active
temperature are only displayed when SoC is an i.MX9. Since IMX9 now
implies IMX_TMU, change this to check for IMX_THERMAL or IMX_TMU
in the same way it's done in mach-imx/cpu.c to enable displaying
this information for any SoC with either of these configs enabled.

Before:
CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
Model: Beacon EmbeddedWorks i.MX8MPlus Development kit

After:
CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
CPU:   Industrial temperature grade  (-40C to 105C) at 28C
Model: Beacon EmbeddedWorks i.MX8MPlus Development kit

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/cpu/imx8_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 53d31b3c0bf..faa6a0704a6 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -177,7 +177,7 @@ static int cpu_imx_get_desc(const struct udevice *dev, char *buf, int size)
 	ret = snprintf(buf, size, "NXP i.MX%s Rev%s %s at %u MHz",
 		       plat->type, plat->rev, plat->name, plat->freq_mhz);
 
-	if (IS_ENABLED(CONFIG_IMX9)) {
+	if (IS_ENABLED(CONFIG_IMX_THERMAL) || IS_ENABLED(CONFIG_IMX_TMU)) {
 		switch (get_cpu_temp_grade(&minc, &maxc)) {
 		case TEMP_AUTOMOTIVE:
 			grade = "Automotive temperature grade ";
-- 
2.45.2

