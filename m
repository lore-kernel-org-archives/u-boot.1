Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F783C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 19:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416DD88D21;
	Mon, 19 Aug 2024 21:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RaVwsCdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC9E88CC9; Mon, 19 Aug 2024 21:34:26 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4FEC88D16
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 21:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5bf009cf4c0so1307929a12.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724096063; x=1724700863; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hJfN0hpMVaXnz/L1Q4Hg/y0PeVcJwvBi7boyAKaJ46w=;
 b=RaVwsCdmtouMfUaKWDyTmy+UBVb0t+TtdPYMrrA0n4puphlHsk78R/StCgJmlfA1sd
 M3MVuY6ctPNRDB3O1vDs2oBiYMZuZJNDGO1SCUvyseKq7tz0ZZ8A+Ur0FgHZdM2K6tyS
 1QOAXtx5TjRuTi+5LnCEgNbGLPVElpxlB9OO8nt/ZwO5PX3K1gzRunLkX2RX8ll5qd8J
 BUz1J0gVyDWroGIxaOTz9FOP5BN+ip6SVRyucWC5R0XDY5c21EIvNjnPrpgSs7rZG6wM
 gHkb2ZpaJg85s50ylB2gIIF1MavCFw0rdylikX5olurcygwUyBfpjRKITJzip1/V2nhN
 nuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724096063; x=1724700863;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJfN0hpMVaXnz/L1Q4Hg/y0PeVcJwvBi7boyAKaJ46w=;
 b=qOr9BYWMMLQcVtzuvM5GzenM5F6YS6PgIzUgW2Djgu/KzWAe8gd18mr2XGdueh/gtZ
 NBv4VWS6zT1oFOgRq63vMprDCdPhr56pTtudYOOChz0qPcOk1dMcRXqoO2xGUjtAb/ov
 Qh6u2GqQVBPYzDrFJhyDyj7/bjOEVreRFFfvzu+8mXd3spXvNJ55t8LJHTNnJhI1zaP9
 eFUr34j3VZweXItMI2GznWBDLDBQQP/ge1Wwo+iEuhjTymp23OGgbp7fiL9E+LXumJ58
 0amUJjJwTBs3tX1ScMnnLy3OIphpOj0sPVnO5Zb3XaDTIKqxFqNbOQ0nXwwX01gIdiey
 50CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCDlXYDjBY3UIOltUgjGD5Ct28qjMWz34o5BIK88nq20ocW0xS4zhpJ47kifarR++fTDpFwiG9/IPxN8P8MDHzHqarqA==
X-Gm-Message-State: AOJu0Yzwy/3THHhoul4LHqTUngbn5rvrQpRkqmD/g1BMIx5R5qjyV8dp
 PFR7S4wkwbvQF6kLL689MIRH2868dpW3I5bpfMPJi0kbQmc09PPyIGtrslgJGN0=
X-Google-Smtp-Source: AGHT+IHgb4gf+UbgOIaG1aorQxqYg8zVMPE/lvR8+c2lpY4+JAbjelESkwI3l9goGPNdIbsOQNPhsg==
X-Received: by 2002:a17:907:f16a:b0:a7a:9f0f:ab2b with SMTP id
 a640c23a62f3a-a8392954042mr741646466b.32.1724096063114; 
 Mon, 19 Aug 2024 12:34:23 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383964976sm667783666b.188.2024.08.19.12.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 12:34:22 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 19 Aug 2024 21:34:17 +0200
Subject: [PATCH 1/4] clk/qcom: implement clk dump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-b4-qcom-clk-dump-v1-1-182cf77c23a2@linaro.org>
References: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
In-Reply-To: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6493;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nxK/d88itr3JtU0XB/+xiwMh0xK1wVyYi3ERrQRJ7+o=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmw548lE4+ZYQEf6s4J88uxTA5OLnejqK6CaDLW
 EeMosZOgyaJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsOePAAKCRAFgzErGV9k
 tnQEEACY7XgKSOnyZNWYoAg0JgXGxmLNOSgNqbHEgmdVaA1Hv2N4mFvtsnnsAUbOw6IYQEWTenN
 d1dULvdBUQnPr8xQtAxIKhPyTOv3iiOLJCVCgPVY7Vnyrmm1Q2oq8ay7FasX7xX+ynEaRXXBzs1
 DZtUwBcz4wX5XO+yLbFoBzZ/+jpJtN3FTHSg5ZbWQaPzrgGdOCqhQH4OX68hCUsn1ygSIZlS7Sv
 1pGAeyxkh5rhYbR9kUPhu5RCTzFrx2Z9bKOUk9niZ/gJMXVz/1vNDKuk8K/Q+np/eU3lB2nnZs5
 plpPPClTLKEcNn2HC4vidFfoiTVFzaG6Zggp5hm+Lc/QpHnx4tmF0JV2iXrxfL2nIS3YnAyQUyD
 31VSrAeK7ZBqonqY0vyiJn/AkOjCUPKSCe38mDDhv5BgF1JkKNP09/LJXEJI0qW9gTqKibfKp0c
 6/MvmXlqmkMQ/aclUmG6GIRdo/PYu1S3gcjojqlGMAAQyNSCmKx/9wVgLZlvteVJizk+as8IpY7
 kmoXPFQ6dNZ59pLy1ZJ1rlkyRlKtZyPh6ixqtSwJDfGqYCx+HnIBWR+YASeMcJV2WjU7zseuPUy
 ZpAt/O1tmSAK0ELYkiwjVr3Jv8i+bq8bQ8TBRFAz4AMnYhMTedYer01Z7cUI25RDCdv3O0kll/K
 TR//k9SlrSFhaaw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add support for dumping a few of the clocks used on Qualcomm platforms.
Naming the Global PLL's, Root Clock Generators, and gate clocks.

This helps a lot with platform bringup and feature enablement by making
it easy to sanity check that the clocks are programmed correctly.

== Usage ==

Enable CONFIG_CMD_CLK and "#define LOG_DEBUG" at the top of
qcom-<soc>.c.

The "clk dump" command should print the states of all the gates, GPLLs
and RCGs for your SoC.

== Glossary ==

RCG: Root Clock Generator
* Takes in some fairly arbitrary high freq clock (configurable clock
source and options for taking just even pulses and other things)
* Output frequency = input_freq * (m/n) * (1/d) where m/n are arbitrary
8 or 16-bit values (depending on the RCG), and d is a number (with
support for .5 offsets).

GPLL: Global Phase Locked Loop
* Crystal as input
* integer multiplier + exponent part (2^-40)

Gate: Simple on/off clock
* Put between RCGs and the peripherals they power
* Required to allow for correct power sequencing

If you do the maths manually using the equations from "clk dump", the
numbers should roughly line up by they're likely to be out by a handful
of MHz. They output is formatted so that it can be pasted directly into
the python interpreter.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c | 117 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h |   6 +++
 2 files changed, 123 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 79c7606a2253..5727d055e95a 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -12,8 +12,9 @@
  * Based on Little Kernel driver, simplified
  */
 
 #include <clk-uclass.h>
+#include <linux/clk-provider.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <errno.h>
@@ -214,11 +215,127 @@ static int msm_clk_enable(struct clk *clk)
 
 	return 0;
 }
 
+static void dump_gplls(struct udevice *dev, phys_addr_t base)
+{
+	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
+	u32 i;
+	bool locked;
+	u64 l, a, xo_rate = 19200000;
+	struct clk *clk = NULL;
+	struct udevice *xodev;
+	const phys_addr_t *gplls = data->dbg_pll_addrs;
+
+	uclass_foreach_dev_probe(UCLASS_CLK, xodev) {
+		if (!strcmp(xodev->name, "xo-board") || !strcmp(xodev->name, "xo_board")) {
+			clk = dev_get_clk_ptr(xodev);
+			break;
+		}
+	}
+
+	if (clk) {
+		xo_rate = clk_get_rate(clk);
+
+		/* On SDM845 this needs to be divided by 2 for some reason */
+		if (xo_rate && of_machine_is_compatible("qcom,sdm845"))
+			xo_rate /= 2;
+	} else {
+		printf("Can't find XO clock, XO_BOARD rate may be wrong\n");
+	}
+
+	printf("GPLL clocks:\n");
+	printf("| GPLL   | LOCKED | XO_BOARD  |  PLL_L     | ALPHA          |\n");
+	printf("+--------+--------+-----------+------------+----------------+\n");
+	for (i = 0; i < data->num_plls; i++) {
+		locked = !!(readl(gplls[i]) & BIT(31));
+		l = readl(gplls[i] + 4) & (BIT(16) - 1);
+		a = readq(gplls[i] + 40) & (BIT(16) - 1);
+		printf("| GPLL%-2d | %-6s | %9llu * (%#-9llx + %#-13llx  * 2 ** -40 ) / 1000000\n",
+		       i, locked ? "X" : "", xo_rate, l, a);
+	}
+}
+
+static void dump_rcgs(struct udevice *dev)
+{
+	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
+	int i;
+	u32 cmd;
+	u32 cfg;
+	u32 not_n_minus_m;
+	u32 src, m, n, div;
+	bool root_on, d_odd;
+
+	printf("\nRCGs:\n");
+
+	/*
+	 * Which GPLL SRC corresponds to depends on the parent map, see gcc-<soc>.c in Linux
+	 * and find the parent map associated with the clock. Note that often there are multiple
+	 * outputs from a single GPLL where one is actually half the rate of the other (_EVEN).
+	 * intput_freq = associated GPLL output freq (potentially divided depending on SRC).
+	 */
+	printf("| NAME                             | ON | SRC | OUT_FREQ = input_freq * (m/n) * (1/d) | [CMD REG   ] |\n");
+	printf("+----------------------------------+----+-----+---------------------------------------+--------------+\n");
+	for (i = 0; i < data->num_rcgs; i++) {
+		cmd = readl(data->dbg_rcg_addrs[i]);
+		cfg = readl(data->dbg_rcg_addrs[i] + 0x4);
+		m = readl(data->dbg_rcg_addrs[i] + 0x8);
+		n = 0;
+		not_n_minus_m = readl(data->dbg_rcg_addrs[i] + 0xc);
+
+		root_on = !(cmd & BIT(31)); // ROOT_OFF
+		src = (cfg >> 8) & 7;
+
+		if (not_n_minus_m) {
+			n = (~not_n_minus_m & 0xffff);
+
+			/* A clumsy assumption that this is an 8-bit MND RCG */
+			if ((n & 0xff00) == 0xff00)
+				n = n & 0xff;
+
+			n += m;
+		}
+
+		div = ((cfg & 0b11111) + 1) / 2;
+		d_odd = ((cfg & 0b11111) + 1) % 2 == 1;
+		printf("%-34s | %-2s | %3d | input_freq * (%4d/%5d) * (1/%1d%-2s)   | [%#010x]\n",
+		       data->dbg_rcg_names[i], root_on ? "X" : "", src,
+		       m ?: 1, n ?: 1, div, d_odd ? ".5" : "", cmd);
+	}
+
+	printf("\n");
+}
+
+static void msm_dump_clks(struct udevice *dev)
+{
+	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
+	struct msm_clk_priv *priv = dev_get_priv(dev);
+	const struct gate_clk *sclk;
+	int val, i;
+
+	if (!data->clks) {
+		printf("No clocks\n");
+		return;
+	}
+
+	printf("Gate Clocks:\n");
+	for (i = 0; i < data->num_clks; i++) {
+		sclk = &data->clks[i];
+		if (!sclk->name)
+			continue;
+		printf("%-32s: ", sclk->name);
+		val = readl(priv->base + sclk->reg) & sclk->en_val;
+		printf("%s\n", val ? "ON" : "");
+	}
+
+	dump_gplls(dev, priv->base);
+	dump_rcgs(dev);
+}
+
 static struct clk_ops msm_clk_ops = {
 	.set_rate = msm_clk_set_rate,
 	.enable = msm_clk_enable,
+	.dump = msm_dump_clks,
 };
 
 U_BOOT_DRIVER(qcom_clk) = {
 	.name		= "qcom_clk",
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index f6445c8f566f..040c0cf29943 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -75,8 +75,14 @@ struct msm_clk_data {
 	unsigned long			num_resets;
 	const struct gate_clk		*clks;
 	unsigned long			num_clks;
 
+	const phys_addr_t		*dbg_pll_addrs;
+	unsigned long			num_plls;
+	const phys_addr_t		*dbg_rcg_addrs;
+	unsigned long			num_rcgs;
+	const char * const		*dbg_rcg_names;
+
 	int (*enable)(struct clk *clk);
 	unsigned long (*set_rate)(struct clk *clk, unsigned long rate);
 };
 

-- 
2.46.0

