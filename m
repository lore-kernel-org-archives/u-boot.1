Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E1AE77180
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56598012C;
	Fri, 13 Dec 2024 15:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GYM9jyhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44903801BF; Fri, 13 Dec 2024 15:53:51 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C59B80137
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3023c51146cso17993161fa.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734101628; x=1734706428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bQN3g5i+OCi0GMeYBJJ9GgdhdUZQv0+FBunoyVSnDk=;
 b=GYM9jyhLAsWPz+Gjez5a4Tzlsmy52CI0x3YK9Un9f791+N/gBEYFhaFA3KbeJtIQkQ
 7CbLcITmezAdYODQsFyN7NoAXyqPvJxz2KjrT8p2X+4sQrsRpcufDZHSlxtMsKQmLZCG
 xJBv7vXl25PbmmoZqYNEuZWPP018kVwcFBCSV92ZDKBdkWAIutqnSlv77ioG5JEIRWwK
 /+tihHeTVM/Yy7mGVC0X0A+qjd/olxpz4+M1okWpVUNxaRwKY09BS0UZpJYw5biqJjNv
 2h1Wb9o1zN1Kb2mnXaILcwJZ6jBl2NOpMLPFWtO6ck0Hn8yjKK5+EMXycqCmD/VH2vBS
 ncpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734101628; x=1734706428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bQN3g5i+OCi0GMeYBJJ9GgdhdUZQv0+FBunoyVSnDk=;
 b=quy5VPl33WOKd2ylNh611VAu8c4wRmaUcqisU5Rdlh/3R/nYNj3C3b8twGOd5NQHNh
 7oO6Vkij5qeHdE5Drd3pe3bdpQca0ONJNKaoTL1zfDnG8j4+X72PY8++XmX6jfiL4IZl
 zZ7fw4mX8SFhYk4b3s4oxgHxLdHSurOxOYQCI0c2nfADPolgK7j1f0Lggl+vQcoykmOi
 M5539rtjkFyTHI8rUnTgYrJaOo+EoUKm3XExdebnCIdY1aP3/Mmg2igEeb3JacAiuBm/
 4vF0IR35qTrfXGBYUKVJMMChROCf1t9UMTzYDrkmUDyGHPtn4AwBI5N/zpIArW3VVTvx
 2ZGg==
X-Gm-Message-State: AOJu0YwG493YAuUzWR1AtJigq/RQtYTlVxTeMX3AENT9CvNZn+/gb0rC
 I1/g4dIq83Ga1nD6d+TgqglJ8aUogKvBbpTO1R+bKNCY7+JFRk+Z
X-Gm-Gg: ASbGncvArLBi/7s9V4uXXa5znsazNrhfKrYpAIW9pgI7Cul2s0+2jOE84Y5S8bIBDgZ
 ObYf/uAlKNRNCPNCErXIStZg6ZLVvX/JM6Uxrn482hozv+F0FdsqlN+S4KhRSRVQPOR/RCsqCW4
 dUo4S7mrFKVqo/29wMQWgnmyioJZK+0F8CnV6O6anRJImi8kpUZWgedNvwf6HZA+gf9RRUxu4Kq
 EgBSQi4FNI3dwbUpEvWUx2i1WI+71VcFsGBztojHKTa/5To
X-Google-Smtp-Source: AGHT+IFXIcw815UNkUKcslpaP9NoFg3CxTov3/XIQLHt4TOfQ+DwH8Zvp5OQQfrMxx2uYy8ZH0aA7g==
X-Received: by 2002:a05:651c:b28:b0:302:2097:392f with SMTP id
 38308e7fff4ca-30251c1466bmr18173951fa.7.1734101628271; 
 Fri, 13 Dec 2024 06:53:48 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30216eb1013sm18626561fa.34.2024.12.13.06.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:53:47 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 1/2] driver: clk: tegra: partially support PLL clocks
Date: Fri, 13 Dec 2024 16:53:18 +0200
Message-ID: <20241213145319.10956-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213145319.10956-1-clamor95@gmail.com>
References: <20241213145319.10956-1-clamor95@gmail.com>
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
 drivers/clk/tegra/tegra-car-clk.c | 47 +++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-car-clk.c
index 1d61f8dc378..ec89d4b2b2d 100644
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
@@ -20,24 +23,41 @@ static int tegra_car_clk_request(struct clk *clk)
 	 * varies per SoC) are the peripheral clocks, which use a numbering
 	 * scheme that matches HW registers 1:1. There are other clock IDs
 	 * beyond this that are assigned arbitrarily by the Tegra CAR DT
-	 * binding. Due to the implementation of this driver, it currently
-	 * only supports the peripheral IDs.
+	 * binding.
 	 */
-	if (clk->id >= PERIPH_ID_COUNT)
-		return -EINVAL;
+	if (clk->id < PERIPH_ID_COUNT) {
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
-
 	debug("%s(clk=%p) (dev=%p, id=%lu)\n", __func__, clk, clk->dev,
 	      clk->id);
 
-	parent = clock_get_periph_parent(clk->id);
-	return clock_get_periph_rate(clk->id, parent);
+	if (clk->data & TEGRA_CAR_CLK_PLL)
+		return clock_get_rate(clk->id);
+
+	if (clk->data & TEGRA_CAR_CLK_PERIPH) {
+		enum clock_id parent;
+
+		parent = clock_get_periph_parent(clk->id);
+		return clock_get_periph_rate(clk->id, parent);
+	}
+
+	return -1U;
 }
 
 static ulong tegra_car_clk_set_rate(struct clk *clk, ulong rate)
@@ -47,6 +67,9 @@ static ulong tegra_car_clk_set_rate(struct clk *clk, ulong rate)
 	debug("%s(clk=%p, rate=%lu) (dev=%p, id=%lu)\n", __func__, clk, rate,
 	      clk->dev, clk->id);
 
+	if (clk->data & TEGRA_CAR_CLK_PLL)
+		return 0;
+
 	parent = clock_get_periph_parent(clk->id);
 	return clock_adjust_periph_pll_div(clk->id, parent, rate, NULL);
 }
@@ -56,6 +79,9 @@ static int tegra_car_clk_enable(struct clk *clk)
 	debug("%s(clk=%p) (dev=%p, id=%lu)\n", __func__, clk, clk->dev,
 	      clk->id);
 
+	if (clk->data & TEGRA_CAR_CLK_PLL)
+		return 0;
+
 	clock_enable(clk->id);
 
 	return 0;
@@ -66,6 +92,9 @@ static int tegra_car_clk_disable(struct clk *clk)
 	debug("%s(clk=%p) (dev=%p, id=%lu)\n", __func__, clk, clk->dev,
 	      clk->id);
 
+	if (clk->data & TEGRA_CAR_CLK_PLL)
+		return 0;
+
 	clock_disable(clk->id);
 
 	return 0;
-- 
2.43.0

