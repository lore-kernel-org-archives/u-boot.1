Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE31C0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 06:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0466280B9F;
	Mon, 10 Feb 2025 07:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="jTyCw++1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BD4180B9E; Mon, 10 Feb 2025 07:52:16 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793C4809A4
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1293da399=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1739170333; x=1770706333;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9bI8Ilfhf0OY3MfXPkHIGEO0mxoo+LXZqlsLQoiRy4E=;
 b=jTyCw++16Rq1Aw7yzawSbOaovbQqrt2U/LUXDOCAXVU16DIJF5Gua/9n
 N7hGuQbblfL+4OIWHNolThc1IJvo0q2/uAI81LPtsyJD7NLMlZsQdiQwn
 OmgGkf7oD0XH9Jm8Hw4oTZlgHZUKyAvouA1Dd1hMBlQpprZ7kKu4cI05C
 HGslJ4BlzuQt2GnBtkUzdpPTmrEtGvhLAo8km4W0q7/RxURsy3Ol7bb9R
 dJJ41tplhC109o3R9LQZUwstMVTE+RzC0VzO/H7UE//wmUK1MV0UTEp8K
 vsy2zHLdSgHyz9/xQ/DPDUX6Xj81BxjlT08EOS3xEw8TMBczVpV134VZC g==;
X-CSE-ConnectionGUID: 14CdqfAISBKFvOtfHNczmA==
X-CSE-MsgGUID: Xbm8DKdVQiWPMVPlwvvarg==
X-IronPort-AV: E=Sophos;i="6.13,273,1732604400"; d="scan'208";a="37072165"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Feb 2025 23:52:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 9 Feb 2025 23:52:07 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 9 Feb 2025 23:52:05 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 6/7] pinctrl: at91: Add support to align with Linux
 Devicetree
Date: Mon, 10 Feb 2025 12:21:42 +0530
Message-ID: <20250210065143.313553-7-manikandan.m@microchip.com>
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

U-Boot pinctrl driver expects a reg property explicitly unlike linux.
To align the DT of U-boot with the Linux, reg property is also arrvied
from child GPIO bank nodes when configured under the pinctrl node.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 2afa1b66821..2938635ed95 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -522,17 +522,30 @@ static int at91_pinctrl_probe(struct udevice *dev)
 {
 	struct at91_pinctrl_priv *priv = dev_get_priv(dev);
 	fdt_addr_t addr_base;
+	struct udevice *gpio_node;
 	int index;
 
-	for (index = 0; index < MAX_GPIO_BANKS; index++) {
-		addr_base = devfdt_get_addr_index(dev, index);
-		if (addr_base == FDT_ADDR_T_NONE)
-			break;
+	if (list_empty(&dev->child_head)) {
+		for (index = 0; index < MAX_GPIO_BANKS; index++) {
+			addr_base = devfdt_get_addr_index(dev, index);
+			if (addr_base == FDT_ADDR_T_NONE)
+				break;
 
-		priv->reg_base[index] = (struct at91_port *)addr_base;
+			priv->reg_base[index] = (struct at91_port *)addr_base;
+		}
+	} else {
+		index = 0;
+		list_for_each_entry(gpio_node, &dev->child_head, sibling_node) {
+			addr_base = dev_read_addr(gpio_node);
+			if (addr_base == FDT_ADDR_T_NONE)
+				break;
+
+			priv->reg_base[index] = (struct at91_port *)addr_base;
+			index++;
+		}
 	}
 
-	priv->nbanks = index;
+	priv->nbanks = index < MAX_GPIO_BANKS ? index : MAX_GPIO_BANKS;
 
 	return 0;
 }
-- 
2.25.1

