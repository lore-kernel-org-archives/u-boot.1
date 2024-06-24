Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C214AC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D7688360;
	Mon, 24 Jun 2024 10:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719218122;
	bh=OGLeWlI8LBF3NCWh7g1w04Ja4u3R9eYEwi2EMfXm0Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xOPx9Q4/PjFRf5eDTZ74jdzci6rnl8Xt4yo47DpkcpUiGhYo/GkEBszdedZT94CL/
	 N4TcxfOuLy9tk6bLJUsxderxxE9QUVemKgxOUJPwe7eKHHnYbIOe0z0RaeOEeh1hs3
	 ex29wVuJTwFKyaNBteT5ErprwY3/zX95d6wqxMbDhrv7R64tyoolM7pF9SQJCnNo0T
	 WW/xnGzKIDMJeG8z3NpRHoanVHBS3TMgLJBnbGBQKGCQz5IenqfHDrSUUBMW9GZzog
	 qPsJzbWBKYtyawNERM78w02P0hTxm6cIFt0XX/8FwLSuSyU8OVBnTj21u/HEA3JVbF
	 uwAYLbrMbBEkQ==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E210E88381;
 Mon, 24 Jun 2024 10:35:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719218120;
 bh=OGLeWlI8LBF3NCWh7g1w04Ja4u3R9eYEwi2EMfXm0Bo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jv5eKD8c0r5AAWOg8uXtOXYD1/CWQvNBMHT2rQl6dDFsvRAecKbxfldwXIFy7Ei4v
 7aKp1f1NsTrQRE1Pr/lLloSSXfYiCvYg+iAdn4lR+LTFVchUp7+UBcWpLbiSFNnwz6
 pxfWYffg3jZpEO54oGlzAqiAvXA9y3C8FXlImjf4ASYSaTcPjxTUfZbzfMOzkDB0dt
 x2Q4m1pYsAXkwzLOteQK5KRRgwdRPWNQXhuAZRBdN7IuqtqSxbguNWBpAOuYDK7GEh
 XOKLDfVleyrLuvhirGhG21F86CV3s5HFNr5aJQpWXwU335DrAMAG9cfdMAkCvnxu0a
 ZsQwi8a2ccf5g==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com,
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com, sebastian.reichel@collabora.com,
 sebastien.szymanski@armadeus.com, sjg@chromium.org, sumit.garg@linaro.org,
 trini@konsulko.com, xypron.glpk@gmx.de, Philip Oberfichtner <pro@denx.de>
Subject: [RESEND PATCH v2 2/5] net: dwc_eth_qos: Fix header to be
 self-contained
Date: Mon, 24 Jun 2024 10:34:47 +0200
Message-Id: <20240624083450.90297-3-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624083450.90297-1-pro@denx.de>
References: <20240624083450.90297-1-pro@denx.de>
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

Before this commit, usage of this header relied on a specific include
order. Fix it by including all dependencies.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 drivers/net/dwc_eth_qos.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index a06390a698..c7d3e23ab7 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -3,8 +3,11 @@
  * Copyright 2022 NXP
  */
 
-#include <phy_interface.h>
+#include <asm/gpio.h>
+#include <clk.h>
 #include <linux/bitops.h>
+#include <phy_interface.h>
+#include <reset.h>
 
 /* Core registers */
 
-- 
2.39.2

