Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4D3C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 122268389A;
	Tue, 27 May 2025 15:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="tjUcae8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 203288389E; Tue, 27 May 2025 15:30:14 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C6083898
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCVGC8027975;
 Tue, 27 May 2025 15:30:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 m/31IxwmimrO/BqEy1D6weXlzQ0Pt3uH6ubwxbwy5Ws=; b=tjUcae8ilDujOZ/J
 CYui5FfSAc8C+MznvbXh9siABWI6IlJH9RZTF0I26PHcdEFO0C8iI3iKaQXpx+sk
 WlXSybxQ+Fnw2yhhFU9kQlciU487UMmHjR55wYB1x/IHSy1CYtUSiqBhEI8aDaaF
 6TcJF4Q57RL/kZrZnX6rjKjtyag6OLHR17JCLBnG+wk8/fyXGjriJ21zHgcqf9L5
 +mWPEJbzlUGWgBv9CiB7oVP6RGrOmh3MsqNtU0NseTuZMBPQB8SSFxOLLs0Fx1Jc
 Cu+k7d/CV+r/yV37e5EXS9pmEQ8LHFqF8TAzzbHx/I0Z/H8QTAfTBWGQdHHG44eG
 XdHamQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46uqp4j585-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:30:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2090E40058;
 Tue, 27 May 2025 15:29:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E4CCDAEC2BB;
 Tue, 27 May 2025 15:28:06 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:28:06 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/13] phy: stm32-usbphyc: manage properly the clk
 identifier with CCF
Date: Tue, 27 May 2025 15:27:51 +0200
Message-ID: <20250527132755.2169508-10-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Add private uclass data for "stm32-usbphyc-clk" as it is not done
by the driver model.

This clk struct is needed by CCF to save the unique id used to identify
each clock.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 drivers/phy/phy-stm32-usbphyc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/phy/phy-stm32-usbphyc.c b/drivers/phy/phy-stm32-usbphyc.c
index 8d643b762f9..fcf8617ee9b 100644
--- a/drivers/phy/phy-stm32-usbphyc.c
+++ b/drivers/phy/phy-stm32-usbphyc.c
@@ -16,7 +16,9 @@
 #include <syscon.h>
 #include <usb.h>
 #include <asm/io.h>
+#include <dm/device.h>
 #include <dm/device_compat.h>
+#include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/of_access.h>
 #include <linux/bitfield.h>
@@ -633,6 +635,7 @@ U_BOOT_DRIVER(stm32_usb_phyc) = {
 
 struct stm32_usbphyc_clk {
 	bool enable;
+	struct clk clkp;
 };
 
 static ulong stm32_usbphyc_clk48_get_rate(struct clk *clk)
@@ -687,9 +690,25 @@ const struct clk_ops usbphyc_clk48_ops = {
 	.disable = stm32_usbphyc_clk48_disable,
 };
 
+int usbphyc_clk48_probe(struct udevice *dev)
+{
+	struct stm32_usbphyc_clk *priv = dev_get_priv(dev);
+
+	/* prepare clkp to correctly register clock with CCF */
+	priv->clkp.dev = dev;
+	priv->clkp.id = CLK_ID(dev, 0);
+
+	/* Store back pointer to clk from udevice */
+	/* FIXME: This is not allowed...should be allocated by driver model */
+	dev_set_uclass_priv(dev, &priv->clkp);
+
+	return 0;
+}
+
 U_BOOT_DRIVER(stm32_usb_phyc_clk) = {
 	.name = "stm32-usbphyc-clk",
 	.id = UCLASS_CLK,
 	.ops = &usbphyc_clk48_ops,
+	.probe = &usbphyc_clk48_probe,
 	.priv_auto = sizeof(struct stm32_usbphyc_clk),
 };
-- 
2.25.1

