Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52001C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 08:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0464E88C07;
	Fri,  3 May 2024 10:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714726228;
	bh=EoLzF6CY4EBLImtZ5qzKZS2vmp0/dSvGYHlcXzDLz2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HPaHbkpkyimG25x2HSvEiz0+tdhHUE7mkatsFOz8Pu//ypR5lGWdqsI3Ecx5igUZ5
	 UFeCUPgg+fPZ/n7yJI8orie7vW2riZoEBUkvUCeuOE02qMeiyBUx/WgpvTqrMOu+Ei
	 BjeTYvApoiTRe0+z5LOgAylyk74+G7FDbcISN5PjUzfT/zswJSUJDd3zyrvEJkSPX4
	 OByKNZabibH/+hPxYBLNoBTSuDZi7UaBHSP570GRqb0aSluEWbp0eMD7Y49wE5OYZZ
	 jeDvWOsZgmj9Zoueu9QhjlAYZgRj53zEm4SeZIxV+izWVUkazLskfSR2MHMH2ySjcZ
	 BVnbK63V1PZGw==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E48D387FC1;
 Fri,  3 May 2024 10:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714726227;
 bh=EoLzF6CY4EBLImtZ5qzKZS2vmp0/dSvGYHlcXzDLz2c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=re1azwqb3RtVHG8OZ1hPmTwsjRsokWyJBveJdmITPoz1WKAZbk/RuRBUrb1NVe3Ag
 Npom+gUfac+iCQ3vdDVNqaHH/8Ei9b3y0dnrs5ofptv25QSBafbqfAVcF2x4l3RMTu
 KgUyQONsCymcgAoPFr5azG2/q31NYBh9VPYyAjlupNx7qE4HWwVBRPhSGmTxyhdCz/
 ZsUDtfCw3Caud4KTd6DDrqrMpD/OniS/i/yzYqgZjXNmKk8+5ZypsGeQAPy/vj/T3K
 ThdqUw5279OaMFY/7UbyFHvJ/d1rOnD59El4o9SIeCgRlaQqhKtxjpdKHPeoHaqo2U
 Y9/f7YjA5ljkw==
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
 trini@konsulko.com, xypron.glpk@gmx.de, yanhong.wang@starfivetech.com,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH 2/5] net: dwc_eth_qos: Fix header to be self-contained
Date: Fri,  3 May 2024 10:49:47 +0200
Message-Id: <20240503084950.70680-3-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503084950.70680-1-pro@denx.de>
References: <20240503084950.70680-1-pro@denx.de>
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
index d6ed3830be..c6e1f76caf 100644
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

