Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518AEE7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1058D83CEA;
	Mon,  9 Feb 2026 19:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L8CJ3OiT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A5383D0B; Mon,  9 Feb 2026 19:03:55 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39F080325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-385c2f88618so40790501fa.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660233; x=1771265033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3IMQH+Qn6rUouWc0CSCXWeeayK800uF3TnqY7nzBzQ=;
 b=L8CJ3OiTfeOUz15/ZqXtRRaPsen9b1mqwhAeWgoauEzS0GTRmksMAn3BekC0AHzmTu
 8aTmP5L9Wrhe9QM+ZFyZqX/WrCgT5I80AmTBQMDvXgivDfiU8suPD+3RxdD2h3u1FTO2
 HwiKqV1rAT+RmTiaRutMroqk3b/8q10x9hdwLOdJVl3y0Atx0VDsjy618o8PxgrQqRSb
 EHN+wDpqUwWlL23ieAUbpPH7sHMHWmQEkWaSFOGTCnlCd9/FK1aGYV75oJRpqIENwfY5
 iXdM2pdmrNYF7alSNis+100oP5OaHYs3hE+1JUwkrL0w1MDJCpNVOd6RUf8nn5+PHWIl
 OEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660233; x=1771265033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S3IMQH+Qn6rUouWc0CSCXWeeayK800uF3TnqY7nzBzQ=;
 b=tTRkc8iTsJ0kMb9K+QV1yMAWY+oL2KC7zJHG8ez1hz3bF43bJPFkxLd91OtW+VSBra
 JAnIdG7hNaOIbxxRvEfGd3lFWZPQXavVu8vM7TgNF19EDOWJ3Mgkp2mOTktR5ONQo7wp
 Jo5xqB57EArXdfFHgaBH2UOXEA2GzGQ6gb43+eMiIdjcAEcVNYXhqKPBfM4h9Npjf8Rv
 uJcwUx5lkkn+I90K7Puuf4bwFwZOaw+V+wsQPr2Ju4cIa+Fj7zZ/hudHreLAfzOONSfs
 vk1vynvfCb0paaEH1W6j/2B8Kg1GEhj9cTjvfxko02fA7Un01Y2rbJoGPZajAfGQ3/eK
 sc3Q==
X-Gm-Message-State: AOJu0YxcWkWLJI4zuZ5vro5AehQ96FbJ4v0BXLm7VO25wjM3vBBFUAT+
 CBRpjHLuNwtE4RoiKpfy/njNtZKPWCgS9AE6aRjaaEMJWgrXhPLRzgz5
X-Gm-Gg: AZuq6aJse9XgRI86e6O4rMca1uzmAwdP4MoreUMHi8rmEUg8B4eiZSXQL/QpALWKzan
 jmfo4Y41zQsACpGnqaweeCteU1rtWHIGPrPh1kN/N6ncVBFx5B3YU2fV9Q1bIpRqBd1+yqOq9eI
 5F4d21ie6H+mlN20ZV6tPHrRaG/EUBrleYwY/AX5Vgjk++BR9LY15zc3KIx4tQDGULFxX0leL3W
 nvQGZKTvC7kto9lV4HpRp60de2hyDJh/IM5YC9Udg/fnSjQgQyaFsaChiFymA7b9EzGHl9/vbLB
 zVSgrifWWIlJFaf6a/xuAIQR1ynb8W+yul3OMVrW6BMF9mKnOoA+VrEbwMv/h3yxN0SFfNamkoz
 P1NgJoysOHjRYncZsK2r1VejChOPz/bjdnK4PmqUcRx1PLRL3yc3sFBAARNFhoYyeHGetFs5QgJ
 7V
X-Received: by 2002:a05:651c:f08:b0:383:282b:7ac5 with SMTP id
 38308e7fff4ca-386b5118bc1mr44734341fa.25.1770660232886; 
 Mon, 09 Feb 2026 10:03:52 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b6236383sm27285351fa.10.2026.02.09.10.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:03:52 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/4] pwm: tegra: properly calculate pulse and frequency
 divider fields
Date: Mon,  9 Feb 2026 20:03:26 +0200
Message-ID: <20260209180326.32190-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209180326.32190-1-clamor95@gmail.com>
References: <20260209180326.32190-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

The pulse width field requires better precision during calculation. Add a
proper frequency divider calculation based on the PWM clock instead of
hardcoding it to 1.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/pwm/tegra_pwm.c | 61 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/tegra_pwm.c b/drivers/pwm/tegra_pwm.c
index 6ddaf626dc4..2601ed6c5a5 100644
--- a/drivers/pwm/tegra_pwm.c
+++ b/drivers/pwm/tegra_pwm.c
@@ -4,14 +4,22 @@
  */
 
 #include <dm.h>
+#include <div64.h>
 #include <log.h>
 #include <pwm.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/pwm.h>
+#include <linux/time.h>
+
+#define PWM_PDIV_WIDTH		8
+#define PWM_PDIV_MAX		BIT(PWM_PDIV_WIDTH)
+#define PWM_FDIV_WIDTH		13
 
 struct tegra_pwm_priv {
 	struct pwm_ctlr *regs;
+	u64 clk_rate;
+	u32 min_period_ns;
 	u8 polarity;
 };
 
@@ -32,23 +40,56 @@ static int tegra_pwm_set_config(struct udevice *dev, uint channel,
 {
 	struct tegra_pwm_priv *priv = dev_get_priv(dev);
 	struct pwm_ctlr *regs = priv->regs;
-	uint pulse_width;
-	u32 reg;
+	u64 pulse_width;
+	u32 rate, reg;
 
 	if (channel >= 4)
 		return -EINVAL;
 	debug("%s: Configure '%s' channel %u\n", __func__, dev->name, channel);
 
-	pulse_width = duty_ns * 256 / period_ns;
+	if (period_ns < priv->min_period_ns) {
+		debug("%s: Channel %u period too low, period_ns %u minimum %u\n",
+		      __func__, channel, period_ns, priv->min_period_ns);
+		return -EINVAL;
+	}
+
+	/*
+	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
+	 * per (1 << PWM_PDIV_WIDTH) cycles and make sure to round to the
+	 * nearest integer during division.
+	 */
+	pulse_width = duty_ns * PWM_PDIV_MAX;
+	pulse_width = DIV_ROUND_CLOSEST_ULL(pulse_width, period_ns);
 
 	if (priv->polarity & BIT(channel))
-		pulse_width = 256 - pulse_width;
+		pulse_width = PWM_PDIV_MAX - pulse_width;
+
+	if (pulse_width > PWM_PDIV_MAX) {
+		debug("%s: Channel %u pulse_width too high %llu\n",
+		      __func__, channel, pulse_width);
+		return -EINVAL;
+	}
+
+	/*
+	 * Since the actual PWM divider is the register's frequency divider
+	 * field plus 1, we need to decrement to get the correct value to
+	 * write to the register.
+	 */
+	rate = (priv->clk_rate * period_ns) / ((u64)NSEC_PER_SEC << PWM_PDIV_WIDTH) - 1;
+	if (rate < 0) {
+		debug("%s: Channel %u rate is not positive\n", __func__, channel);
+		return -EINVAL;
+	}
+
+	if (rate >> PWM_FDIV_WIDTH) {
+		debug("%s: Channel %u rate too high %u\n", __func__, channel, rate);
+		return -EINVAL;
+	}
 
 	reg = pulse_width << PWM_WIDTH_SHIFT;
-	reg |= 1 << PWM_DIVIDER_SHIFT;
+	reg |= rate << PWM_DIVIDER_SHIFT;
 	reg |= PWM_ENABLE_MASK;
 	writel(reg, &regs[channel].control);
-	debug("%s: pulse_width=%u\n", __func__, pulse_width);
 
 	return 0;
 }
@@ -78,9 +119,15 @@ static int tegra_pwm_of_to_plat(struct udevice *dev)
 
 static int tegra_pwm_probe(struct udevice *dev)
 {
+	struct tegra_pwm_priv *priv = dev_get_priv(dev);
 	const u32 pwm_max_freq = dev_get_driver_data(dev);
 
-	clock_start_periph_pll(PERIPH_ID_PWM, CLOCK_ID_PERIPH, pwm_max_freq);
+	priv->clk_rate = clock_start_periph_pll(PERIPH_ID_PWM, CLOCK_ID_PERIPH,
+						pwm_max_freq);
+	priv->min_period_ns = (NSEC_PER_SEC / (pwm_max_freq >> PWM_PDIV_WIDTH)) + 1;
+
+	debug("%s: clk_rate = %llu min_period_ns = %u\n", __func__,
+	      priv->clk_rate, priv->min_period_ns);
 
 	return 0;
 }
-- 
2.51.0

