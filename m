Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DEE109878D
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE04840BE;
	Fri, 20 Mar 2026 15:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="c+aKCCgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31B083F9B; Fri, 20 Mar 2026 15:32:18 +0100 (CET)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C6683D71
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kcxt@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1774017135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hm9fJ3yxSQGREpX5SEAGSr7BemnoK3AeLceHTiP5I9o=;
 b=c+aKCCgYH7948Avtx+F4t/CAXXj2QVswT/WwRLMec+XXLvoI/7toBNvqvpPlZtB/RMz/WS
 XpVCD7i/ciEASBmyfmqESMXKAAo3RWBMacTbN83ryP9pYm+VsqjrUurSRdRptIgpfn7IoQ
 H0qDY7GPmBmiOeQPItStaL2uIaplRuduuf8NxI4IYKW4Iu4XKQQP+W259/Z27jGEdsITck
 /2ydWKU7JmovRyGz4jQ5+HEZJxU/us89xgzbcH8cm/MY2ShuaCcDNzlU0lvTxt8Ixh71QM
 1mVuih6PShRpAwRj1wDvN1JWvi62ASrdnqQvjsJk2/vl9jtRIEdv1Qgr7xoEag==
From: Casey Connolly <kcxt@postmarketos.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 u-boot-qcom@groups.io, uboot-snps-arc@synopsys.com,
 u-boot-amlogic@groups.io, Sumit Garg <sumit.garg@kernel.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>,
 Thierry Reding <treding@nvidia.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org,
 Marek Vasut <marex@denx.de>
Subject: [PATCH RFC 36/40] clk/qcom/ccf: add uboot common code
Date: Fri, 20 Mar 2026 15:31:32 +0100
Message-ID: <20260320-casey-ccf-upstream-v1-36-5b654f4b6620@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=6881;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=2qOA+o3v19CGy2zJ1s5jEqAA/wlJRSgZHpFXVPwRAf4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsy9kSvmmj/Wvdr4XWiS6LqJTyu+hC+s1F1QIurZ1vavx
 ftpXf6njlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR+fMZ/ln8m/60KPHgMV/m
 h2J3rLu/5ciGL1+kdHLplG3rw9uTrN4y/JVNFxFaMKvx4JLPnltWMizk39A4+/uUwOWHNuz+5P3
 p+pGZAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 20 Mar 2026 15:38:37 +0100
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

From: Casey Connolly <casey.connolly@linaro.org>

Add a few math functions that are missing in U-Boot, as well as a helper
to bind the power domain and reset drivers. These must be adapted from
Linux since each driver is allocated its own udevice.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/ccf/common-uboot.c | 188 ++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/ccf/common-uboot.h |  38 ++++++++
 2 files changed, 226 insertions(+)

diff --git a/drivers/clk/qcom/ccf/common-uboot.c b/drivers/clk/qcom/ccf/common-uboot.c
new file mode 100644
index 000000000000..c37239cacad2
--- /dev/null
+++ b/drivers/clk/qcom/ccf/common-uboot.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: BSD-3-Clause AND GPL-2.0
+/*
+ * Clock and reset drivers for Qualcomm platforms Global Clock
+ * Controller (GCC).
+ *
+ * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
+ * (C) Copyright 2020 Sartura Ltd. (reset driver)
+ *     Author: Robert Marko <robert.marko@sartura.hr>
+ * (C) Copyright 2022 Linaro Ltd. (reset driver)
+ *     Author: Sumit Garg <sumit.garg@linaro.org>
+ *
+ * Based on Little Kernel driver, simplified
+ */
+
+#include <clk-uclass.h>
+#include <linux/clk-provider.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <reset-uclass.h>
+#include <power-domain-uclass.h>
+
+#include "common-uboot.h"
+#include "common.h"
+#include "gdsc.h"
+#include "reset.h"
+
+int qcom_cc_bind_pd_reset(struct udevice *parent)
+{
+	struct qcom_cc_desc *data = (struct qcom_cc_desc *)dev_get_driver_data(parent);
+	struct regmap *regmap;
+	int ret;
+
+	regmap = qcom_cc_map(parent, data);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	if (data->resets) {
+		ret = qcom_reset_register(parent, data->resets, data->num_resets, regmap);
+		if (ret)
+			return ret;
+	}
+
+	if (data->gdscs) {
+		ret = gdsc_register(parent, data->gdscs, data->num_gdscs, regmap);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+// FIXME: import gcd.c from Linux?
+/**
+ * gcd - calculate and return the greatest common divisor of 2 unsigned longs
+ * @a: first value
+ * @b: second value
+ */
+unsigned long gcd(unsigned long a, unsigned long b)
+{
+	unsigned long r = a | b;
+
+	if (!a || !b)
+		return r;
+
+	/* Isolate lsbit of r */
+	r &= -r;
+
+	while (!(b & r))
+		b >>= 1;
+	if (b == r)
+		return r;
+
+	for (;;) {
+		while (!(a & r))
+			a >>= 1;
+		if (a == r)
+			return r;
+		if (a == b)
+			return a;
+
+		if (a < b)
+			swap(a, b);
+		a -= b;
+		a >>= 1;
+		if (a & r)
+			a += b;
+		a >>= 1;
+	}
+}
+
+/*
+ * calculate best rational approximation for a given fraction
+ * taking into account restricted register size, e.g. to find
+ * appropriate values for a pll with 5 bit denominator and
+ * 8 bit numerator register fields, trying to set up with a
+ * frequency ratio of 3.1415, one would say:
+ *
+ * rational_best_approximation(31415, 10000,
+ *		(1 << 8) - 1, (1 << 5) - 1, &n, &d);
+ *
+ * you may look at given_numerator as a fixed point number,
+ * with the fractional part size described in given_denominator.
+ *
+ * for theoretical background, see:
+ * https://en.wikipedia.org/wiki/Continued_fraction
+ */
+
+void rational_best_approximation(
+	unsigned long given_numerator, unsigned long given_denominator,
+	unsigned long max_numerator, unsigned long max_denominator,
+	unsigned long *best_numerator, unsigned long *best_denominator)
+{
+	/* n/d is the starting rational, which is continually
+	 * decreased each iteration using the Euclidean algorithm.
+	 *
+	 * dp is the value of d from the prior iteration.
+	 *
+	 * n2/d2, n1/d1, and n0/d0 are our successively more accurate
+	 * approximations of the rational.  They are, respectively,
+	 * the current, previous, and two prior iterations of it.
+	 *
+	 * a is current term of the continued fraction.
+	 */
+	unsigned long n, d, n0, d0, n1, d1, n2, d2;
+	n = given_numerator;
+	d = given_denominator;
+	n0 = d1 = 0;
+	n1 = d0 = 1;
+
+	for (;;) {
+		unsigned long dp, a;
+
+		if (d == 0)
+			break;
+		/* Find next term in continued fraction, 'a', via
+		 * Euclidean algorithm.
+		 */
+		dp = d;
+		a = n / d;
+		d = n % d;
+		n = dp;
+
+		/* Calculate the current rational approximation (aka
+		 * convergent), n2/d2, using the term just found and
+		 * the two prior approximations.
+		 */
+		n2 = n0 + a * n1;
+		d2 = d0 + a * d1;
+
+		/* If the current convergent exceeds the maxes, then
+		 * return either the previous convergent or the
+		 * largest semi-convergent, the final term of which is
+		 * found below as 't'.
+		 */
+		if ((n2 > max_numerator) || (d2 > max_denominator)) {
+			unsigned long t = ULONG_MAX;
+
+			if (d1)
+				t = (max_denominator - d0) / d1;
+			if (n1)
+				t = min(t, (max_numerator - n0) / n1);
+
+			/* This tests if the semi-convergent is closer than the previous
+			 * convergent.  If d1 is zero there is no previous convergent as this
+			 * is the 1st iteration, so always choose the semi-convergent.
+			 */
+			if (!d1 || 2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
+				n1 = n0 + t * n1;
+				d1 = d0 + t * d1;
+			}
+			break;
+		}
+		n0 = n1;
+		n1 = n2;
+		d0 = d1;
+		d1 = d2;
+	}
+	*best_numerator = n1;
+	*best_denominator = d1;
+}
+
diff --git a/drivers/clk/qcom/ccf/common-uboot.h b/drivers/clk/qcom/ccf/common-uboot.h
new file mode 100644
index 000000000000..0bfabaf2c4dd
--- /dev/null
+++ b/drivers/clk/qcom/ccf/common-uboot.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
+ */
+#ifndef _CLOCK_QCOM_H
+#define _CLOCK_QCOM_H
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <linux/compat.h>
+#include <linux/delay.h>
+#include <div64.h>
+#include <linux/bug.h>
+
+struct udevice;
+
+int qcom_cc_bind_pd_reset(struct udevice *parent);
+
+unsigned long gcd(unsigned long a, unsigned long b);
+
+void rational_best_approximation(
+	unsigned long given_numerator, unsigned long given_denominator,
+	unsigned long max_numerator, unsigned long max_denominator,
+	unsigned long *best_numerator, unsigned long *best_denominator);
+
+#define usleep_range(min, max) udelay(max)
+
+/* U-Boot: custom clock flag for clocks we need pre-relocation */
+#define CLK_REGISTER_PRE_RELOC	BIT(31)
+
+static inline const char *str_enable_disable(bool v)
+{
+	return v ? "enable" : "disable";
+}
+#define str_disable_enable(v)		str_enable_disable(!(v))
+
+#endif /* _CLOCK_QCOM_H */

-- 
2.51.0

