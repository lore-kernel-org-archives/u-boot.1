Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7EBFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA9484605;
	Wed, 29 Apr 2026 00:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aDVV2FRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBE5884686; Tue, 28 Apr 2026 20:04:50 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C86684660
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+christian.dreher.nanoxplore.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C42CE42CC0;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A75FAC2BCB7;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777399486;
 bh=dRgrSgO2f1Yy4lxJqzwAl8dmkPypPy9ZCjDRQGhEmAI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=aDVV2FRGk+INaHIRPq9t3qpxVO8M7gcs6BHDxdmJ9VF2qSOvUb1qhvqtOO3C/8oro
 0UR+9mCRZ7HFwy8hMaWGxE/PQIINCQMNZF99yhLCb9gLrn260u0GdK0Xf2ayOunM9m
 lNExSAOBVRF3gor5041grxqwoJXLXexhz5jYlcBgJeFO/YbhX2ixAq/7ROgLVBkCql
 615ziUUu+BnsKyj5EQJ7iaSQb7wqZuphMJstaX6WoMXgrigTPd28ocBdDNn7g5w6Jf
 +kDrYySS9FGyrIEI2ASEdzKfw2ypy/ev9jcig7An2ytEWaf+GTZ373woRATdWqkVFo
 8yXdanHa5navA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9711FFF886D;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
From: Christian DREHER via B4 Relay
 <devnull+christian.dreher.nanoxplore.com@kernel.org>
Date: Tue, 28 Apr 2026 20:04:05 +0200
Subject: [PATCH 1/4] net: macb: include arch/clk.h only when necessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-net-macb-support-for-feature-lite-instances-v1-1-480e4cecac01@nanoxplore.com>
References: <20260428-net-macb-support-for-feature-lite-instances-v1-0-480e4cecac01@nanoxplore.com>
In-Reply-To: <20260428-net-macb-support-for-feature-lite-instances-v1-0-480e4cecac01@nanoxplore.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Christian DREHER <christian.dreher@nanoxplore.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777399485; l=896;
 i=christian.dreher@nanoxplore.com; s=20260428; h=from:subject:message-id;
 bh=9046TvejUO8RMUiT/+l/BjcleTvgUspN77fLbvIWyHo=;
 b=IJSfQyXJkvFnkIH0kzd8+4ie2ynOFlSgadn4sk02V71eP1p+VdyA8GxJDBJOTwAXV8xouGNlL
 YpB8/00lMe5ATSuuI1fBh4kzC9S8b2DN/3O3GJTw7FdZX1/M1mKwmbH
X-Developer-Key: i=christian.dreher@nanoxplore.com; a=ed25519;
 pk=id7EcKmXLV2xNgNiCIcsPjkoMQHM/qxTYqEqMhidSAU=
X-Endpoint-Received: by B4 Relay for
 christian.dreher@nanoxplore.com/20260428 with auth_id=760
X-Original-From: Christian DREHER <christian.dreher@nanoxplore.com>
X-Mailman-Approved-At: Wed, 29 Apr 2026 00:48:15 +0200
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
Reply-To: christian.dreher@nanoxplore.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Christian DREHER <christian.dreher@nanoxplore.com>

It does not exist in my setup (an on-going arm64 SoC), and removing
it does not cause any missing declaration, but some code called when
CONFIG_CLK is missing calls get_macb_pclk_rate, which is only defined
in arch/arm/mach-at91/include/mach/clk.h

Signed-off-by: Christian DREHER <christian.dreher@nanoxplore.com>
---
 drivers/net/macb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index cbf5f605518..719aef39a3f 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -38,9 +38,13 @@
 #include <linux/mii.h>
 #include <asm/io.h>
 #include <linux/dma-mapping.h>
-#include <asm/arch/clk.h>
 #include <linux/errno.h>
 
+/* Without CLK, we rely on the arch definition */
+#if !defined(CONFIG_CLK)
+#include <asm/arch/clk.h>
+#endif
+
 #include "macb.h"
 
 DECLARE_GLOBAL_DATA_PTR;

-- 
2.47.3


