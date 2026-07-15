Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F9CC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 12:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1250B84ADB;
	Wed, 15 Jul 2026 14:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="PSULE4dz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C1984A3A; Wed, 15 Jul 2026 14:27:38 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8136F84AA1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 14:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so9705182a12.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784118456; x=1784723256; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tFpKuXBxZu36B7gdJ6SJKo9ZzmeERSL0ZjKMoxp7bsk=;
 b=PSULE4dzWWlxoI/GZgruthk4M8JoEUm2Zsv8xAM5keuN9956jFvGDUwLZTzjS/kP6k
 HUfXsMlRynDwVCQE7DnBW0tbuNhZsANEUei/973MDC5EJ6SSAnIuBeiKW9SgKVRFhLyI
 rzMqENGeNSBfJkRsgPxa2nIzXFLckUv8Mh88yVE/d1/Kw0BOjdUmuQUhYiaLgvOdXmP3
 qFBpMGzJ6WV2/1FdC+HGfwE1eHAP3rinaV/Tu9JVfXfDugZHdW0ivSG6S01RHU9GS+xc
 BkETCUJr8mVlqJhWPBeyzJs4zdg+xL4kHhCBrC4pvsjMezmq7hJHPpNYVdwLIVA5YMbY
 jwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784118456; x=1784723256;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tFpKuXBxZu36B7gdJ6SJKo9ZzmeERSL0ZjKMoxp7bsk=;
 b=Z2oXlpOVvZVb0vhjugxjSR9r+Rx2syWqS/s0xuP5xt386Soh+GWiVBGXa2ku7m8Fub
 FwY+WXkljfctXM0nZSnjqmYAyaV+TaFn9qzObV+x2wAH9XPzDU62xQxfNEpmJ9QAEqk0
 bysigztqMdYOCbZcKNCtE0zHCOe0ljotSIuDmZ8q+BvAe09KoetxHWY8cG8NEe2vgymQ
 lvM4LWnKSEfj+M7wvw8XFFyyg06hJr4dZxpXOOkPghevAEDYPYGLuBFsiC5M5G0XXgUg
 82yi5lvfkTAREGdczYFJ6mdBBNDelRnHCJVBQL15nv+nEROm9fQhdKHGqYjvNt5lncjR
 2O6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoM6jXmWj/HUV9JhEhJx3wdZDe0jpHexq7vnbqFgvBTxCuyxdWVztZNe+AYo6g56R00vHekkso=@lists.denx.de
X-Gm-Message-State: AOJu0YxKDYP1nLJzQvcRgSkOEvwtbF3zCQg9kk99gLtQTyhGIopkCWKz
 VldRoWS6ukkghmFcatcPRjLas09PDeqqSaM/FEpr6mtAR5jriev0awSkphwsgst8Etc=
X-Gm-Gg: AfdE7ck2lbptFByM8y21ga0ZDrDKBKuYJsgIee6x8mrIybJL1dH3QutTDHHcUdBGHWY
 ipe/xV9gKiWGR6CjW29nlCupGyZssSqL8CSBXKa9sy0UmDZpha478vXK1zVMU/quCGsFSTDebqp
 8or4v2CnIdJ0wq0nIAH6m3jLRoT/w2+1g/WNXIrlzgYV9eqfYzvhmlPq8FJQIeotnfGXhtp5WuJ
 nXi5P/8UXdEe1ubeyT8J2fA2cXzaUCSb98gJz7zzXTJ7qOjMmIF5D4e0rzLfiES2uCr1amTbLz6
 kWZcpqZA3a7au6RFQsBSYIPNDWVsLM8jEn6b3rmusfPI9yhbRS/cejJ4Gu0PxIAwxFg9czf34Cs
 4EXvaFsPZVHqr1zkTVWeho7FzRI12FsRDq6HfTWHm4Q14kakd1W9EwCABlYQoN44c77atMIqANc
 dOLco5ffTLif5quJpps3GK+cbfUNnwz7b1VrsL/egEXjHzhq9rgMY1jmA/r/eocoglIjE=
X-Received: by 2002:a17:906:9c96:b0:c16:2750:fc56 with SMTP id
 a640c23a62f3a-c1667a76e98mr403996466b.41.1784118456028; 
 Wed, 15 Jul 2026 05:27:36 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e6ecsm15062266b.44.2026.07.15.05.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:27:35 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 14:27:06 +0200
Subject: [PATCH v2 4/4] clk/qcom: Treat different GDSCs differently
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-gdsc-flags-v2-4-27704470a24c@fairphone.com>
References: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
In-Reply-To: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Ajit Singh <blfizzyy@gmail.com>, Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118453; l=2714;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ZkOKTg7bl5QpqVn3+cXar9PjsAakXnhsazSnPGyoEuE=;
 b=aoXPJUrpvqtzcsWnYKxae3Qcb+l/NNyC42FkgIkPNY33Pjq2sLI2ai/toKq57n1pB6wESlRfH
 eO5t4qam1dpCFOyWbORIlzROO8O8qBlAhTBkaZmZcD8eNZdwKVlEXUj
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 14:38:59 +0200
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

From: Alexey Minnekhanov <alexeymin@minlexx.ru>

In the Linux driver, depending on which GDSC flags are set, a different
status register is checked when powering it on/off. And on top of that,
a different bit inside that register is tested. Currently qcom clk
implementation in U-Boot lacks this functionality, so adjust logic when
checking GDSC status to match one in Linux driver.

This fixes problems on e.g. MSM8998 and SDM660's with USB_30_GDSC to be
forever stuck during power on, since unlike e.g SDM845 one it doesn't
have POLL_CFG_GDSCR flag (only VOTABLE).

With this change all GDSCs that have POLL_CFG_GDSCR in their flags
keep old behaviour (same as before this patch).

Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/clock-qcom.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 557f30d54d4..4e391187080 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -527,19 +527,35 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
 
 	writel(value, base + map->reg);
 
-	if (on)
-		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
-					 value,
-					 (value & GDSC_POWER_UP_COMPLETE) ||
-					 (value & GDSC_PWR_ON_MASK),
-					 GDSC_STATUS_POLL_TIMEOUT_US);
-
-	else
-		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
-					 value,
-					 (value & GDSC_POWER_DOWN_COMPLETE) ||
-					 !(value & GDSC_PWR_ON_MASK),
-					 GDSC_STATUS_POLL_TIMEOUT_US);
+	/*
+	 * Depending on the type of GDSC the status register is different,
+	 * and we need to check different status bit (condition passed to
+	 * readl_poll_timeout() is different too).
+	 * See Linux src: drivers/clk/qcom/gdsc.c @ gdsc_check_status() func
+	 */
+	if (map->flags & POLL_CFG_GDSCR) {
+		if (on)
+			ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
+						 value,
+						 (value & GDSC_POWER_UP_COMPLETE),
+						 GDSC_STATUS_POLL_TIMEOUT_US);
+		else
+			ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
+						 value,
+						 (value & GDSC_POWER_DOWN_COMPLETE),
+						 GDSC_STATUS_POLL_TIMEOUT_US);
+	} else {
+		if (on)
+			ret = readl_poll_timeout(base + map->reg,
+						 value,
+						 (value & GDSC_PWR_ON_MASK),
+						 GDSC_STATUS_POLL_TIMEOUT_US);
+		else
+			ret = readl_poll_timeout(base + map->reg,
+						 value,
+						 !(value & GDSC_PWR_ON_MASK),
+						 GDSC_STATUS_POLL_TIMEOUT_US);
+	}
 
 	if (ret == -ETIMEDOUT)
 		printf("WARNING: GDSC %lu is stuck during power o%s\n",

-- 
2.55.0

