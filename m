Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0792D78769
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 295808976F;
	Thu, 21 Nov 2024 15:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="NGDlPKlI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CECF89775; Thu, 21 Nov 2024 15:28:12 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D232C896E0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q95eLaqhQcYYNvCkw0bAsf4mzY6Qg1OtLdFJtpaNuyE=; b=NGDlPKlIUpCJ7I8yXA+yodX/2o
 Qs2Vayy8WGc7rVDU/g2IhBW8m1UR0FqbJseabmFOEFEOWJsENuuHfEXFjAdQ+laC4p4xDMlYjKyHs
 q0gLiuSbGK5psoa2qZfuOF/D4Y/XKYTqlRIMan2qi5HwO9Fsl3Bd4oCptp0wocBYy06C0EisGe9sO
 bcGmROKChwwXu62DX6SgD/hYezqGIb5n+9UVti8pHcQOxOBxbg7H3Noy+enFIOixBZqEQZ0DejI0M
 7q68uzOPrtufi7JOC9tICCA6LmrcdmiXVksNJcuvV+WsgSXmsNQB+aEZkYqY8Ci2CHws20PXf34DP
 ssYBTbxw==;
Received: from [185.156.123.69] (helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tE8A0-0007f9-85; Thu, 21 Nov 2024 15:27:56 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 02/20] dt-bindings: clock,
 reset: fix top-comment indentation rk3576 headers
Date: Thu, 21 Nov 2024 15:27:13 +0100
Message-ID: <20241121142731.1202209-3-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142731.1202209-1-heiko@sntech.de>
References: <20241121142731.1202209-1-heiko@sntech.de>
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

Block comments should align the * on each line, as checkpatch rightfully
pointed out, so fix that style issue on the newly added rk3576 headers.

Fixes: 49c04453db81 ("dt-bindings: clock, reset: Add support for rk3576")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240909223149.85364-1-heiko@sntech.de
Signed-off-by: Stephen Boyd <sboyd@kernel.org>

[ upstream commit: eb3b3f520518003cd363239fc160bdd7ed327319 ]

(cherry picked from commit 92b03f0021dfe4686d84fb75d52a5b4203c000a5)
---
 .../include/dt-bindings/clock/rockchip,rk3576-cru.h  | 12 ++++++------
 .../include/dt-bindings/reset/rockchip,rk3576-cru.h  | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/dts/upstream/include/dt-bindings/clock/rockchip,rk3576-cru.h b/dts/upstream/include/dt-bindings/clock/rockchip,rk3576-cru.h
index a2933021be8..25aed298ac2 100644
--- a/dts/upstream/include/dt-bindings/clock/rockchip,rk3576-cru.h
+++ b/dts/upstream/include/dt-bindings/clock/rockchip,rk3576-cru.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
-* Copyright (c) 2023 Rockchip Electronics Co. Ltd.
-* Copyright (c) 2024 Collabora Ltd.
-*
-* Author: Elaine Zhang <zhangqing@rock-chips.com>
-* Author: Detlev Casanova <detlev.casanova@collabora.com>
-*/
+ * Copyright (c) 2023 Rockchip Electronics Co. Ltd.
+ * Copyright (c) 2024 Collabora Ltd.
+ *
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ * Author: Detlev Casanova <detlev.casanova@collabora.com>
+ */
 
 #ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
 #define _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
diff --git a/dts/upstream/include/dt-bindings/reset/rockchip,rk3576-cru.h b/dts/upstream/include/dt-bindings/reset/rockchip,rk3576-cru.h
index 291fec0ecba..ae856906f3a 100644
--- a/dts/upstream/include/dt-bindings/reset/rockchip,rk3576-cru.h
+++ b/dts/upstream/include/dt-bindings/reset/rockchip,rk3576-cru.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
-* Copyright (c) 2023 Rockchip Electronics Co. Ltd.
-* Copyright (c) 2024 Collabora Ltd.
-*
-* Author: Elaine Zhang <zhangqing@rock-chips.com>
-* Author: Detlev Casanova <detlev.casanova@collabora.com>
-*/
+ * Copyright (c) 2023 Rockchip Electronics Co. Ltd.
+ * Copyright (c) 2024 Collabora Ltd.
+ *
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ * Author: Detlev Casanova <detlev.casanova@collabora.com>
+ */
 
 #ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3576_H
 #define _DT_BINDINGS_RESET_ROCKCHIP_RK3576_H
-- 
2.45.2

