Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFF4EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91404841CD;
	Thu,  9 Apr 2026 15:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="nSVqmSya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC7684118; Wed,  8 Apr 2026 21:25:08 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CADB84120
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.cisneros@hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638F2jWq1851674; Wed, 8 Apr 2026 19:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps0720; bh=Fa
 dC60KT/B5h2aPSJuhItBgpnUYaL6NRPb8xrgcRRh8=; b=nSVqmSya2A0Pnu4wyx
 FSPjEPuuXT1F34a9yVpsPBBsjMPs1EABXbiokpyowPDwZ5q2UK6c8AKweuunylHb
 DTQ9p1RLhicLGQnP33oPWk0fOCm2Afs16sOzJ6SH4Lh0pcgzK4crp4vW3zrEcpt+
 CX1vhLmR9pgvAicVsFMrQyCF3njWbweQ+tf28eyq3tKOeDFJ90QJNPmmjs5hKpZ5
 rFe++uGPjlO0Ocip4x/Nk6vrgOPiynp+s8yahBzSfgxtk6UUd8e7kf4u0zi5aEmQ
 YBqokpkwr4Czr3IU7D3zB34/aRXStIRt1gQyVy4S5cNDWvwDHsEj07hqLkI1VVkN
 ygqw==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ddnu8e096-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 19:24:22 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 0E41C2BACC;
 Wed,  8 Apr 2026 19:24:22 +0000 (UTC)
Received: from [127.0.1.1] (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id E4CF8805E61;
 Wed,  8 Apr 2026 19:24:20 +0000 (UTC)
From: Jorge Cisneros <jorge.cisneros@hpe.com>
Date: Wed, 08 Apr 2026 19:24:16 +0000
Subject: [PATCH 4/9] watchdog: Add HPE GSC watchdog driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-hpe-gsc-upstream-v1-4-2be1fb7cbbfc@hpe.com>
References: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
In-Reply-To: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Jean-Marie Verdun <verdun@hpe.com>,
 Nick Hawkins <nick.hawkins@hpe.com>,
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Chen-Yu Tsai <wens@kernel.org>, Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jorge Cisneros <jorge.cisneros@hpe.com>
X-Mailer: b4 0.15.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfX6HI9+/9pRAMS
 mtCO+wpgfdpANqGeT7hM7AkBTZlrF/svLpDC4DQ1m1BToGrRurbplkZX3uX9th0c88xHpxR7QYs
 MVdX1HDsM6za7XmXxtBJ83aCQPrskghpH67Lk09MVqACeZ8/rLh5jKZ6EAcovTb3DeDl3z4Vpwu
 VYRMrytF5dTTFViFpnivxhJDweUoMiCevFocej+kCyaxzj2XiM2O1mImTDaA+70ykN3EwgvSjCg
 oXanF/PBmkjVn5VNDXi4SqKsIQLS+LbpT/lBnRiPEg3MEHP85nwLOzD25YD7yMSrrMe1lEQVdaH
 xIp3X6/l7fy02JpF8qLtwCvJojl42IvJ2bryfCdhlhSBZwlGNx4Awd3lfhAwwSCSurqXpDWg2zP
 kgsiutxJIy0YH1m4r32HJYXOmZOW2B0RyjzyROGGZXq65H8pUoJXXY3GRa/5C2We31KRtibm1Qy
 KbjlUb+tkdvO3/0y3nQ==
X-Authority-Analysis: v=2.4 cv=LJhWhpW9 c=1 sm=1 tr=0 ts=69d6ab66 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22 a=MvuuwTCpAAAA:8
 a=NIagIq1R15lFhUNdsw8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GOkdmUhvl5-SIBKz1gmSGi8_W8FEy_ry
X-Proofpoint-ORIG-GUID: GOkdmUhvl5-SIBKz1gmSGi8_W8FEy_ry
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080181
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:00:51 +0200
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

Add watchdog driver for the HPE GSC SoC. The GSC watchdog uses two
separate register regions: a counter register and a control register.
Writing the counter value resets the watchdog timer, while writing to
the control register enables or disables the watchdog.

Supported operations: start, stop, reset, and expire_now.

Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
---
 drivers/watchdog/Kconfig   |   7 +++
 drivers/watchdog/Makefile  |   1 +
 drivers/watchdog/gsc_wdt.c | 110 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 35ae7d106b1..692a7eb4304 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -195,6 +195,13 @@ config WDT_DAVINCI
 	  Select this to enable the watchdog timer for DaVinci SoCs such as the
 	  OMAP-L138.
 
+config WDT_GSC
+	bool "HPE GSC watchdog support"
+	depends on WDT
+	help
+	  Enable support for the watchdog timer in HPE GSC BMC SoC
+	  used in HPE Gen12 servers.
+
 config WDT_GPIO
 	bool "External gpio watchdog support"
 	depends on WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 02e2674f8af..f7397e03527 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
 obj-$(CONFIG_WDT_DA9063) += da9063-wdt.o
 obj-$(CONFIG_WDT_DAVINCI) += davinci_wdt.o
 obj-$(CONFIG_WDT_FTWDT010) += ftwdt010_wdt.o
+obj-$(CONFIG_WDT_GSC) += gsc_wdt.o
 obj-$(CONFIG_$(SPL_TPL_)WDT_GPIO) += gpio_wdt.o
 obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
 obj-$(CONFIG_WDT_MCF) += mcf_wdt.o
diff --git a/drivers/watchdog/gsc_wdt.c b/drivers/watchdog/gsc_wdt.c
new file mode 100644
index 00000000000..b535f47e052
--- /dev/null
+++ b/drivers/watchdog/gsc_wdt.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2022-2025 Hewlett Packard Enterprise Development LP */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <wdt.h>
+#include <asm/io.h>
+#include <linux/err.h>
+
+#define MASK_WDGCS_ENABLE	BIT(0)
+#define MASK_WDGCS_RELOAD	BIT(2)
+#define MASK_WDGCS_NMIEN	BIT(3)
+#define MASK_WDGCS_WARN		BIT(7)
+
+#define WDT_MAX_TIMEOUT_MS	655350
+#define SECS_TO_WDOG_TICKS(x)	((x) * 100)
+
+struct gsc_wdt_priv {
+	void __iomem *counter;
+	void __iomem *control;
+};
+
+static int gsc_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+	struct gsc_wdt_priv *priv = dev_get_priv(dev);
+	u8 val;
+	u16 timeout_secs;
+
+	if (timeout_ms > WDT_MAX_TIMEOUT_MS)
+		timeout_ms = WDT_MAX_TIMEOUT_MS;
+	else if (timeout_ms == 0)
+		timeout_ms = CONFIG_WATCHDOG_TIMEOUT_MSECS;
+
+	timeout_secs = timeout_ms / 1000;
+	writew(SECS_TO_WDOG_TICKS(timeout_secs), priv->counter);
+
+	val = readb(priv->control);
+	val |= MASK_WDGCS_ENABLE;
+	writeb(val, priv->control);
+
+	return 0;
+}
+
+static int gsc_wdt_stop(struct udevice *dev)
+{
+	struct gsc_wdt_priv *priv = dev_get_priv(dev);
+	u8 val;
+
+	val = readb(priv->control);
+	val &= ~MASK_WDGCS_ENABLE;
+	writeb(val, priv->control);
+
+	return 0;
+}
+
+static int gsc_wdt_reset(struct udevice *dev)
+{
+	struct gsc_wdt_priv *priv = dev_get_priv(dev);
+	u8 val;
+
+	val = readb(priv->control);
+	val |= MASK_WDGCS_RELOAD;
+	writeb(val, priv->control);
+
+	return 0;
+}
+
+static int gsc_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	return gsc_wdt_start(dev, 1, flags);
+}
+
+static const struct wdt_ops gsc_wdt_ops = {
+	.start = gsc_wdt_start,
+	.reset = gsc_wdt_reset,
+	.stop = gsc_wdt_stop,
+	.expire_now = gsc_wdt_expire_now,
+};
+
+static const struct udevice_id gsc_wdt_ids[] = {
+	{ .compatible = "hpe,gsc-wdt" },
+	{ }
+};
+
+static int gsc_wdt_probe(struct udevice *dev)
+{
+	struct gsc_wdt_priv *priv = dev_get_priv(dev);
+
+	priv->counter = dev_remap_addr_index(dev, 0);
+	if (!priv->counter)
+		return -EINVAL;
+
+	priv->control = dev_remap_addr_index(dev, 1);
+	if (!priv->control)
+		return -EINVAL;
+
+	gsc_wdt_stop(dev);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(gsc_wdt) = {
+	.name = "gsc_wdt",
+	.id = UCLASS_WDT,
+	.of_match = gsc_wdt_ids,
+	.probe = gsc_wdt_probe,
+	.priv_auto = sizeof(struct gsc_wdt_priv),
+	.ops = &gsc_wdt_ops,
+};

-- 
2.43.0

