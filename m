Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8BFC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 12:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7639B8777B;
	Thu,  2 Nov 2023 13:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sberdevices.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sberdevices.ru header.i=@sberdevices.ru header.b="B2gkYQmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C7787772; Thu,  2 Nov 2023 13:20:46 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED476875E7
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 13:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sberdevices.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 1DC9210002E;
 Thu,  2 Nov 2023 15:20:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1DC9210002E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
 s=mail; t=1698927633;
 bh=IqKNktyVLhcA8Aw87Pu2NltAWnBVQN+KKg5tD/A4MOM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=B2gkYQmOvBK2N/hJjsGhGmGA3B1JBbDkiQPTBwPpact8/V26wJimueYg92sik1eNs
 Nm6GIQVUWC014eiVL64O5eaET+9T/VMM3xNYNqmSpNPt+QkaC7KDP5PVlEgw3C63In
 FcWolcjhjUtXOnwFMpuwSGl2MV+bMAgm0Ewkb8NyT7z9o7/z28kshApZLPqd3uNwOr
 ZxTXBNhnBsI/8zovgpZMj0uZ/aRw5Y6fwR++jdgKxkOHcsTAMsK1U6MRVbpauXKFjT
 JxbTm0RFyJ3+38xCUWtfVXODkWhlr7CQhuLzoUmV6xKbG3mA7GnWRTVJhcpp8qxPhm
 a8CnbYORg0tyA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  2 Nov 2023 15:20:32 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 2 Nov 2023 15:20:32 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: Michal Simek <michal.simek@amd.com>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei
 Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
 <ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, 
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v5 1/8] clk: zynq: Move soc_clk_dump to Zynq clock driver
Date: Thu, 2 Nov 2023 15:20:10 +0300
Message-ID: <20231102122017.56995-2-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102122017.56995-1-ivprusov@sberdevices.ru>
References: <20231102122017.56995-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181075 [Nov 02 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from},
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch},
 {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/02 06:57:00 #22385341
X-KSMG-AntiVirus-Status: Clean, skipped
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

Move clock dump function in preparation for switching to dump function
in clk_ops.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 arch/arm/mach-zynq/clk.c | 57 ---------------------------------------
 drivers/clk/clk_zynq.c   | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-zynq/clk.c b/arch/arm/mach-zynq/clk.c
index 1945f60e08..e6a67326dd 100644
--- a/arch/arm/mach-zynq/clk.c
+++ b/arch/arm/mach-zynq/clk.c
@@ -13,20 +13,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static const char * const clk_names[clk_max] = {
-	"armpll", "ddrpll", "iopll",
-	"cpu_6or4x", "cpu_3or2x", "cpu_2x", "cpu_1x",
-	"ddr2x", "ddr3x", "dci",
-	"lqspi", "smc", "pcap", "gem0", "gem1",
-	"fclk0", "fclk1", "fclk2", "fclk3", "can0", "can1",
-	"sdio0", "sdio1", "uart0", "uart1", "spi0", "spi1", "dma",
-	"usb0_aper", "usb1_aper", "gem0_aper", "gem1_aper",
-	"sdio0_aper", "sdio1_aper", "spi0_aper", "spi1_aper",
-	"can0_aper", "can1_aper", "i2c0_aper", "i2c1_aper",
-	"uart0_aper", "uart1_aper", "gpio_aper", "lqspi_aper",
-	"smc_aper", "swdt", "dbg_trc", "dbg_apb"
-};
-
 /**
  * set_cpu_clk_info() - Setup clock information
  *
@@ -65,46 +51,3 @@ int set_cpu_clk_info(void)
 
 	return 0;
 }
-
-/**
- * soc_clk_dump() - Print clock frequencies
- * Returns zero on success
- *
- * Implementation for the clk dump command.
- */
-int soc_clk_dump(void)
-{
-	struct udevice *dev;
-	int i, ret;
-
-	ret = uclass_get_device_by_driver(UCLASS_CLK,
-		DM_DRIVER_GET(zynq_clk), &dev);
-	if (ret)
-		return ret;
-
-	printf("clk\t\tfrequency\n");
-	for (i = 0; i < clk_max; i++) {
-		const char *name = clk_names[i];
-		if (name) {
-			struct clk clk;
-			unsigned long rate;
-
-			clk.id = i;
-			ret = clk_request(dev, &clk);
-			if (ret < 0)
-				return ret;
-
-			rate = clk_get_rate(&clk);
-
-			clk_free(&clk);
-
-			if ((rate == (unsigned long)-ENOSYS) ||
-			    (rate == (unsigned long)-ENXIO))
-				printf("%10s%20s\n", name, "unknown");
-			else
-				printf("%10s%20lu\n", name, rate);
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index e80500e382..be5226175f 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -454,6 +454,64 @@ static int dummy_enable(struct clk *clk)
 	return 0;
 }
 
+static const char * const clk_names[clk_max] = {
+	"armpll", "ddrpll", "iopll",
+	"cpu_6or4x", "cpu_3or2x", "cpu_2x", "cpu_1x",
+	"ddr2x", "ddr3x", "dci",
+	"lqspi", "smc", "pcap", "gem0", "gem1",
+	"fclk0", "fclk1", "fclk2", "fclk3", "can0", "can1",
+	"sdio0", "sdio1", "uart0", "uart1", "spi0", "spi1", "dma",
+	"usb0_aper", "usb1_aper", "gem0_aper", "gem1_aper",
+	"sdio0_aper", "sdio1_aper", "spi0_aper", "spi1_aper",
+	"can0_aper", "can1_aper", "i2c0_aper", "i2c1_aper",
+	"uart0_aper", "uart1_aper", "gpio_aper", "lqspi_aper",
+	"smc_aper", "swdt", "dbg_trc", "dbg_apb"
+};
+
+/**
+ * soc_clk_dump() - Print clock frequencies
+ * Returns zero on success
+ *
+ * Implementation for the clk dump command.
+ */
+int soc_clk_dump(void)
+{
+	struct udevice *dev;
+	int i, ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_CLK,
+					  DM_DRIVER_GET(zynq_clk), &dev);
+	if (ret)
+		return ret;
+
+	printf("clk\t\tfrequency\n");
+	for (i = 0; i < clk_max; i++) {
+		const char *name = clk_names[i];
+
+		if (name) {
+			struct clk clk;
+			unsigned long rate;
+
+			clk.id = i;
+			ret = clk_request(dev, &clk);
+			if (ret < 0)
+				return ret;
+
+			rate = clk_get_rate(&clk);
+
+			clk_free(&clk);
+
+			if ((rate == (unsigned long)-ENOSYS) ||
+			    (rate == (unsigned long)-ENXIO))
+				printf("%10s%20s\n", name, "unknown");
+			else
+				printf("%10s%20lu\n", name, rate);
+		}
+	}
+
+	return 0;
+}
+
 static struct clk_ops zynq_clk_ops = {
 	.get_rate = zynq_clk_get_rate,
 #ifndef CONFIG_SPL_BUILD
-- 
2.34.1

