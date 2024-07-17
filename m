Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666AFC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 12:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCEA288A45;
	Wed, 17 Jul 2024 14:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721219370;
	bh=mXYreqTfnN7W79jq3XvgQhLIt9y9mchyDJGLGgeovsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r6QJmtOR58b6iNoBA2n9DEWcbT2FsiK1oEGN7Nqpy3bUWG4LsrFpRaFs1aaOYbXp3
	 OKvR1a0wjPGR//g/wIJSO2S2NjIn22KTWMkD6Wr5b4c1CRZml4F1hcX67Liz9IJcMn
	 Z9l7n4X9xaVxLqcKxX6IfjnEZ/GFndca5i6+3jUfiCOY3yjQO5R89CKyAO9PkWWgne
	 kRb0NPviTpYIK4i97GcDcMTfsPOQ1ni7f34NdyASAyiMRvd0K3G3dBZLAszEfBfVSt
	 rHKC4o+GGlcAL8HJw1mhJioFUIjvst9I8WLTgqj66DXIYTVuenL2goZwtw2WFjKmpI
	 JWn9xijkneTUw==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:7f4c:42be:fdf8:3b8a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AC81788A44;
 Wed, 17 Jul 2024 14:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721219369;
 bh=mXYreqTfnN7W79jq3XvgQhLIt9y9mchyDJGLGgeovsU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kydzG+aK5gnJq1/NfWqM1avO2n0EJMfltgbA5W3Aoj3e6UIJhFKlrKoPGvCVLf0Cj
 CaLA9bNX7i/zyznR9W2+1BF9C9ALsXFfRBkrCrSbkhMRGSp+ez4rAav6xiBfXu4fKc
 91Q3/73Xb14puc6JCY5me9K5OaRlwcpQnHZt1QjGGUllUH3T+IPAvrK94joUfU9Ovd
 rOR0T0n0ft+jzZCy+c5BD0wIQHlJS9TF/ypil9TENhrFE8s+KhkbfOf5jFwkQW6Ysq
 snrLXOiMC28Lxq3YNeqARCnbTLqH6LX2INZdHPxdTmDvRZbkV2ZHEZAXRIUkbZcCb7
 CjBdWA+cMtU1A==
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
Subject: [PATCH v3 2/5] net: dwc_eth_qos: Fix header to be self-contained
Date: Wed, 17 Jul 2024 14:29:03 +0200
Message-Id: <20240717122906.117861-3-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717122906.117861-1-pro@denx.de>
References: <20240717122906.117861-1-pro@denx.de>
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
 drivers/net/dwc_eth_qos.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index 8b3d0d464d3..6372ba9f35c 100644
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

