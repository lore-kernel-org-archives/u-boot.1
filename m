Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF085E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A89CB80200;
	Thu, 12 Dec 2024 11:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cqD40axT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAEDF801DA; Thu, 12 Dec 2024 11:07:19 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CF1801EA
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so649389a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998037; x=1734602837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3oOMrWdWBuIoi456RA2n0RzHfvBg9ekJRRLzWujniVI=;
 b=cqD40axTJmteC3GN/MBTu70O4xUgNKnu+pWko4h1IH5pMtPuSK3wweEjyPgrCwzFIV
 Xi20Op5i3x/elqHevOXFFNO/PFn03Cf0MXgVygDMSwPVjK73v0ufPZcBSLOyMh7X2U71
 XGctk08aOFStTm2S30gN3kc/MuMxr8pyLflmyiY9s23tSkKINY8E3Q8iB6QS4ae5nydA
 zYANRFJodiPxZdGFclhjQLPerLLdbsvBSfBsrmNlM4yq0+6RLeFwRhR4jdMvVrhI7L14
 Qnkn2Cqle/dH57TTQSy7zUdvJek7y7fs90GtVJAYEFbR1owWSupepVA8OZnHMSSNHnBF
 bklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998037; x=1734602837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3oOMrWdWBuIoi456RA2n0RzHfvBg9ekJRRLzWujniVI=;
 b=XkGmveoScI/qteFRXDDF/z8tbnicp43iJ47Xw9vBM36avJHGuWyrWNaCv8o+inXVfF
 nW78CXy+IGzEpRK7EZaVUXNls9cFCIunduuJdhBhFQTQ4Z4851j7nGFqR9UIMkxtiaT6
 CcZXOhEVBESLzvFFcJDFDVrTb4HU6mr3al/iBVaXeZ1Kg7lrCIrn3YnHu2lCqTesOSPO
 pn7+YqWqaKI2Uh0koFv+3Nd5LNtqx5Ph5CmIlaynH62kzGxM0UKA6KQyukBSox0NuQ8B
 wjT4fv83nEiu1HOLzhBA/b1TsVCPpdjKfozGsP1GSVgaIbGnsCzW1IeK7vMG2BF+viso
 UTtA==
X-Gm-Message-State: AOJu0YyqxPhS0cgfinRIs3DHcScTIrvuEQT8E5a/fwEzV7zj4QA5v/G0
 HajT5a5oN23iBYgJNtPXnoq4g8/11o0rvIB7avKcwCoBKvi9ayHh
X-Gm-Gg: ASbGncu8nZDjsFRhMWUJ9+nc/NW7tm8MOkO9E1M9ez6mO3OPFrgEEbCMwPI3q9mBeEf
 KHfbSpS1KBhLoNrFou7zf5YcT5CylBiOnuYfYxN9wNR/wCOQbzaeOpdxMveltgEc9nRx/mglwxa
 8BSoeyX6R9QBVo9c6iByxU5nLTqr121Z206mxliyAwGrMNvEs+LTFSbfGPqSL9xCOz5HbGKWZV4
 JxtPJzlmpMEOr5AtE0KRuCWry6lD0h6B78UgX08Qp29E/tu
X-Google-Smtp-Source: AGHT+IFmkFustjXfzwSg9ToeYPjOOd46WJ9k//J31Bc/0O9WwHGEGbap/QsettAppRG9MrfR3Qjrrg==
X-Received: by 2002:a05:6402:449b:b0:5d4:3761:d184 with SMTP id
 4fb4d7f45d1cf-5d4edcce1f1mr540530a12.10.1733998037077; 
 Thu, 12 Dec 2024 02:07:17 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d149b4a049sm10167200a12.35.2024.12.12.02.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:07:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/2] driver: clk: tegra: partially support PLL clocks
Date: Thu, 12 Dec 2024 12:06:45 +0200
Message-ID: <20241212100646.5646-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212100646.5646-1-clamor95@gmail.com>
References: <20241212100646.5646-1-clamor95@gmail.com>
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

Return PLL id into struct clk if PLL is parsed from device
tree instead of throwing an error. Allow requesting PLL
clock rate via get_rate op.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/tegra/tegra-car-clk.c | 49 ++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-car-clk.c
index 1d61f8dc378..dd4d7791120 100644
--- a/drivers/clk/tegra/tegra-car-clk.c
+++ b/drivers/clk/tegra/tegra-car-clk.c
@@ -10,6 +10,9 @@
 #include <asm/arch/clock.h>
 #include <asm/arch-tegra/clk_rst.h>
 
+#define TEGRA_CAR_CLK_PLL	BIT(0)
+#define TEGRA_CAR_CLK_PERIPH	BIT(1)
+
 static int tegra_car_clk_request(struct clk *clk)
 {
 	debug("%s(clk=%p) (dev=%p, id=%lu)\n", __func__, clk, clk->dev,
@@ -20,30 +23,50 @@ static int tegra_car_clk_request(struct clk *clk)
 	 * varies per SoC) are the peripheral clocks, which use a numbering
 	 * scheme that matches HW registers 1:1. There are other clock IDs
 	 * beyond this that are assigned arbitrarily by the Tegra CAR DT
-	 * binding. Due to the implementation of this driver, it currently
-	 * only supports the peripheral IDs.
+	 * binding.
 	 */
-	if (clk->id >= PERIPH_ID_COUNT)
-		return -EINVAL;
+	if (!(clk->id >= PERIPH_ID_COUNT)) {
+		clk->data |= TEGRA_CAR_CLK_PERIPH;
+		return 0;
+	}
 
-	return 0;
+	/* If check for periph failed, then check for PLL clock id */
+	int id = clk_id_to_pll_id(clk->id);
+
+	if (clock_id_is_pll(id)) {
+		clk->id = id;
+		clk->data |= TEGRA_CAR_CLK_PLL;
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static ulong tegra_car_clk_get_rate(struct clk *clk)
 {
-	enum clock_id parent;
+	if (clk->data & TEGRA_CAR_CLK_PLL)
+		return clock_get_rate(clk->id);
 
-	debug("%s(clk=%p) (dev=%p, id=%lu)\n", __func__, clk, clk->dev,
-	      clk->id);
+	if (clk->data & TEGRA_CAR_CLK_PERIPH) {
+		enum clock_id parent;
 
-	parent = clock_get_periph_parent(clk->id);
-	return clock_get_periph_rate(clk->id, parent);
+		debug("%s(clk=%p) (dev=%p, id=%lu)\n", __func__,
+		      clk, clk->dev, clk->id);
+
+		parent = clock_get_periph_parent(clk->id);
+		return clock_get_periph_rate(clk->id, parent);
+	}
+
+	return -1U;
 }
 
 static ulong tegra_car_clk_set_rate(struct clk *clk, ulong rate)
 {
 	enum clock_id parent;
 
+	if (clk->data & TEGRA_CAR_CLK_PLL)
+		return 0;
+
 	debug("%s(clk=%p, rate=%lu) (dev=%p, id=%lu)\n", __func__, clk, rate,
 	      clk->dev, clk->id);
 
@@ -53,6 +76,9 @@ static ulong tegra_car_clk_set_rate(struct clk *clk, ulong rate)
 
 static int tegra_car_clk_enable(struct clk *clk)
 {
+	if (clk->data & TEGRA_CAR_CLK_PLL)
+		return 0;
+
 	debug("%s(clk=%p) (dev=%p, id=%lu)\n", __func__, clk, clk->dev,
 	      clk->id);
 
@@ -63,6 +89,9 @@ static int tegra_car_clk_enable(struct clk *clk)
 
 static int tegra_car_clk_disable(struct clk *clk)
 {
+	if (clk->data & TEGRA_CAR_CLK_PLL)
+		return 0;
+
 	debug("%s(clk=%p) (dev=%p, id=%lu)\n", __func__, clk, clk->dev,
 	      clk->id);
 
-- 
2.43.0

