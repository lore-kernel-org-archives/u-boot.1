Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4A5C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 00:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8C687D60;
	Fri,  8 Mar 2024 01:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XDbr+tDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D38887D80; Fri,  8 Mar 2024 01:04:39 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 078AE83339
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 01:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-22195b3a8fbso200689fac.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 16:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709856273; x=1710461073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8WpmdhQC3KMXqD/OnNVkffYCf1720asOXYrEz50/bNM=;
 b=XDbr+tDkcT5ql5JkPer+D52zjR9PctRfR5LyYSMgtbnRqk75f53GBhCqTXmoeND63S
 kk5ZopkScOzDiiNoM2v7Wck3xLRnb1hRcEsJF+5Brt7JxqO7d1nYKm/tkiTGwgGlvBgh
 FGZiPX2w3GnlXKEUSbkSbkjitE15umST6k0RI/f1Ggbt5tP5ggbSOk6KROdmR4Bo2E4T
 pTWFln5RVxbNjUyZswi+xXjCqx1NhkBTSygsaAT1E3769pReM9J+fmjPwbBIUBWVeqzd
 +1+7u5OYCevsO+jyzaLtB8E1ErsnR9cIufXyz66kTAn0oshladWuiuN5bKgQqc340gTS
 kmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709856273; x=1710461073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8WpmdhQC3KMXqD/OnNVkffYCf1720asOXYrEz50/bNM=;
 b=urGwa19KIuUl8bcVKKoPl7npbGiytXAx8bR4b0IxYYpa8PDph3s7Jd05bp+IdxHU3S
 IRylNVzMKyiIufBdAbU5wH8mvbwadW8XLhutq0FeZtAmDLY6FeuvA3AvFiV4twhknxnu
 WCAjrZPCyCMg5iKuGKB3afd82njfIYJK0IO+DH+UBkzKy3S/55K3ajz0NsnV45aaNUTG
 J422GEfRJqiuOwBUD5UP5Nr9S0k0hNvQqS7ZbIWBUdD9RGEa/CJ2d/FF9aHqMVUdNhCl
 Z4g2QTurUxEcbX+27L9ewHNr9agPQv/CkEtcWRle4FH3Lu/Io3yMYF+1UmW2sI8PmmPW
 2ZSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAJgUs7poCP1KktDnV4JOENj8Bop3gjwBUwtOepfMqCS/8Yno7mxrefioxV1p0+VJ5gfsVQVV1NHJmDXF78xEWc3K6KA==
X-Gm-Message-State: AOJu0YzRizyJxuKt13tGnKzrMmmDgvpVHDTvvQrGjqnbDXFcIem5cB1i
 8qzECLsJAYn090bp65/whM3TGnrY17rIPrfS7i3oWqkA0kraVbvpwEMTO0RV/RU=
X-Google-Smtp-Source: AGHT+IFnGtmhp+H9b8sEXHFEQzhGC/F6g0O9tkc82u62DFvLdlfScB7iK47X3KZpkuko8FgV8W6ULQ==
X-Received: by 2002:a05:6870:724d:b0:221:1c2f:21e9 with SMTP id
 y13-20020a056870724d00b002211c2f21e9mr1473109oaf.58.1709856272891; 
 Thu, 07 Mar 2024 16:04:32 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 wh13-20020a056871a68d00b002208ca7a9aesm4248713oab.57.2024.03.07.16.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 16:04:32 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Subject: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE present
Date: Thu,  7 Mar 2024 18:04:32 -0600
Message-Id: <20240308000432.32369-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Sometimes clocks provided to a consumer might not have .set_rate
operation (like gate or mux clocks), but have CLK_SET_PARENT_RATE flag
set. In that case it's usually possible to find a parent up the tree
which is capable of setting the rate (div, pll, etc). Implement a simple
lookup procedure for such cases, to traverse the clock tree until
.set_rate capable parent is found, and use that parent to actually
change the rate. The search will stop once the first .set_rate capable
clock is found, which is usually enough to handle most cases.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/clk-uclass.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index ed6e60bc4841..755f05f34669 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -571,8 +571,20 @@ ulong clk_set_rate(struct clk *clk, ulong rate)
 		return 0;
 	ops = clk_dev_ops(clk->dev);
 
-	if (!ops->set_rate)
-		return -ENOSYS;
+	/* Try to find parents which can set rate */
+	while (!ops->set_rate) {
+		struct clk *parent;
+
+		if (!(clk->flags & CLK_SET_RATE_PARENT))
+			return -ENOSYS;
+
+		parent = clk_get_parent(clk);
+		if (IS_ERR_OR_NULL(parent) || !clk_valid(parent))
+			return -ENODEV;
+
+		clk = parent;
+		ops = clk_dev_ops(clk->dev);
+	}
 
 	/* get private clock struct used for cache */
 	clk_get_priv(clk, &clkp);
-- 
2.39.2

