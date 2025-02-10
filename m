Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1278C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 06:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A5580AE5;
	Mon, 10 Feb 2025 07:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="DvSDWJYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F32803B5; Mon, 10 Feb 2025 07:52:15 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADAB080548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1293da399=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1739170332; x=1770706332;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M3JJULuvg7lWWs7xhjdU/QPEfsroPpBfEC3UajbsY68=;
 b=DvSDWJYIaTFDRlbx9eppitu8O7HRNkiayvBCjdr+EAPlHBClkNTI+Q7R
 CFC6hsDB6MvphowHohXKAv6I2fOyO2+cQRW9uef4RDwpUsFMxWr6sMjla
 Y2Mi/ps+Se0V8/nSlDhhrITCzVOWEv9XXL7b3lkAMBZJqxjm6RvmIj35F
 Iua16iISSuWVIh5Jyg76tEMCMU9B+cEQvXx7ivDDBha6MGrpKnA/gjAzp
 u8aqe6VXnCuV0pMctinbWVaU4mw+oFsHw35rSZnKP5zZfw4WP7kTZF3k3
 YsuxN/H7ti5ImOvC9InlTbmotI7I0snOfrkPGtrn8MTYHm7jaXUGsYMFZ A==;
X-CSE-ConnectionGUID: 14CdqfAISBKFvOtfHNczmA==
X-CSE-MsgGUID: Cddg15WdTNOKDx6YKvBy8w==
X-IronPort-AV: E=Sophos;i="6.13,273,1732604400"; d="scan'208";a="37072163"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Feb 2025 23:52:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 9 Feb 2025 23:52:04 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 9 Feb 2025 23:52:02 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 5/7] pinctrl: at91: Bind GPIO driver to the pinctrl DT node
Date: Mon, 10 Feb 2025 12:21:41 +0530
Message-ID: <20250210065143.313553-6-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210065143.313553-1-manikandan.m@microchip.com>
References: <20250210065143.313553-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

In Linux DT,the pinctrl node acts as parent nodes with all other
gpio banks as child nodes and a single driver in Linux handles both
pinctrl settings and gpio requests.Current U-Boot DT maintains both
pinctrl and gpio nodes as separate nodes and offers two different class
of U-Boot drivers: UCLASS_PINCTRL which handles pin functions and
UCLASS_GPIO which handles gpio requests. In order to align the DT
of U-Boot with the DT of Linux, a hook is been added in the pinctrl
driver to bind the gpio driver with the pinctrl driver so that
when adding gpio nodes as subnodes to pinctrl node (as per the Linux ABI),
the corresponding APIs will be redirected and handled by valid
drivers attached to the pinctrl driver.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 5038cb535e3..2afa1b66821 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -9,6 +9,8 @@
 #include <dm.h>
 #include <log.h>
 #include <asm/global_data.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <dm/pinctrl.h>
 #include <asm/hardware.h>
 #include <linux/bitops.h>
@@ -492,6 +494,30 @@ const struct pinctrl_ops at91_pinctrl_ops  = {
 	.set_state = at91_pinctrl_set_state,
 };
 
+/**
+ * at91_pinctrl_bind() - Iterates through all subnodes of the pinctrl device
+ * in the DT and binds them to U-Boot's device model. Each subnode
+ * typically represents a GPIO controller or pin configuration data.
+ *
+ * @dev: Pointer to the pinctrl device
+ *
+ * Returns 0 on success or negative error on failure
+ */
+static int at91_pinctrl_bind(struct udevice *dev)
+{
+	ofnode gpio_node;
+	struct udevice *gpio;
+	int ret;
+
+	ofnode_for_each_subnode(gpio_node, dev_ofnode(dev)) {
+		ret = lists_bind_fdt(dev, gpio_node, &gpio, NULL, false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int at91_pinctrl_probe(struct udevice *dev)
 {
 	struct at91_pinctrl_priv *priv = dev_get_priv(dev);
@@ -524,6 +550,7 @@ U_BOOT_DRIVER(atmel_sama5d3_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = at91_pinctrl_match,
 	.probe = at91_pinctrl_probe,
+	.bind = at91_pinctrl_bind,
 	.priv_auto	= sizeof(struct at91_pinctrl_priv),
 	.ops = &at91_pinctrl_ops,
 };
-- 
2.25.1

