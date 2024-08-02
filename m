Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5F8C3DA49
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 09:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC2188B89;
	Fri,  2 Aug 2024 11:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722590755;
	bh=uteOotCIO/QOsesysL4BTyhh7MW6bSfB9LZEy9Hk85Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DCL6ZgesT/iDVNRbnOF7p1oVbUBX1ngdzJ9sFoZMRdgwuXQQJa+INqZxdRZOYw1t8
	 dUsSuYGu3n5aphSjJ9eGAviKOB9PVk+XhLM387NDt0gY+Iefhrm0qLywAyXjags9Qi
	 YgaiHjL7Av80jafXP6id0MTVMgfgFHz/nRgF31J54KVbql6MqAG9tjcxu7L+o0xy6A
	 UHn0ZmP5q0h+v3qdeUBNG4DD5Sp0ICO5kgbCEy5XKouzU6Vpsp18dKUs+R60pFrddK
	 ry8YtQf4qDqldOOS5oqHO8lupdvPCt3tNOC8GiWGxGxWs3A/w9ViaSZDrs4z7brGpg
	 ynAbyIOkgvKCg==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:7f4c:42be:fdf8:3b8a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 17DC688B8F;
 Fri,  2 Aug 2024 11:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722590754;
 bh=uteOotCIO/QOsesysL4BTyhh7MW6bSfB9LZEy9Hk85Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xKcNVk8jbI7uBQ1A4I79cpi+3/AVDylrDaYd/HUht7ibz1uU6OSfuAv9HCk2N1rt4
 ilPbO3ywcgd6H04hUhv8Z6RJOOY9ELnEzoIEXnYjfmytbMACNH/w3JnjraJiMxT2gy
 TtpdeqIRFqYtMThBFa253sHAr9LAlvBoVGHHfF6psz0q9iLm+NhOWIi/6XWPKtgT/m
 JRrAXYhlRzgflEBDrJ5NUAjc/PVMonWpqwHhc0GzbOmnCoJ+LrPNUUShqvxXGtNO/J
 lj4aCxfD+cVoGXKBf2rdHfol/t2I3rSpN8J064CC9iDztfYuEeaGk5Dg69PrSqM4Om
 TNkF0DS9KFrWA==
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
 trini@konsulko.com, xypron.glpk@gmx.de, marex@denx.de,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v4 2/5] net: dwc_eth_qos: Fix header to be self-contained
Date: Fri,  2 Aug 2024 11:25:36 +0200
Message-Id: <20240802092539.162892-3-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802092539.162892-1-pro@denx.de>
References: <20240802092539.162892-1-pro@denx.de>
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
Reviewed-by: Marek Vasut <marex@denx.de>
---

Notes:
    Changes in V4: None
    Changes in V3: None

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

