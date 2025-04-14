Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FA6C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32187826AD;
	Mon, 14 Apr 2025 22:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="M0bXZcXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9825A82153; Mon, 14 Apr 2025 22:21:00 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64742828D0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DKWXXVoFHvqH4xgtDP2VN2grifTlcoa0ff9dYQCQ9Hg=; b=M0bXZcXSlvnL6FLYrWUtjY0TAX
 TN1rgvAKOQD0OhtITUSaXeNlsLNb6YV3mnFRwIMuaLXDLcAix4rsL17nJ/KUGhktD76Fj18opBy7d
 5mT6JZiRwQAr2RVhPzYhxgq0XHNmLHknC1eU1nXjaXhgwrejx8CgQ/uZDiVL3m6omfuO0mj06i9wB
 uoE2uTcCFZZCgx4VwzxpYu8xlK3EpVXIKgxl3X/GvCkG34hEHcpeHY1dVeKmDO+cxc61PbSD0mSFr
 t2AIfdh7L+F6tawFpoiqACMzHM2DbMFNCX0JAZqTU+NEwbqay/pkLM3UQ6hXQcuQIuGqnkbQ4l040
 eAHo2u5Q==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4Pzy-0001rf-6W; Mon, 14 Apr 2025 22:01:42 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH v2 11/16] mmc: rockchip_dw_mmc: Add support for rk3576
Date: Mon, 14 Apr 2025 22:01:06 +0200
Message-ID: <20250414200111.1357867-12-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250414200111.1357867-1-heiko@sntech.de>
References: <20250414200111.1357867-1-heiko@sntech.de>
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

The rk3576 uses a different base-compatible, as starting with this
generation, the clock phase tuning is done via registers inside
the mmc controller and not from inside the CRU.

In U-Boot we do not tune at all, so no other code changes are
necessary.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/rockchip_dw_mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index 422b8f7e4c8..7a72abaa38a 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -171,6 +171,7 @@ static int rockchip_dwmmc_bind(struct udevice *dev)
 static const struct udevice_id rockchip_dwmmc_ids[] = {
 	{ .compatible = "rockchip,rk2928-dw-mshc" },
 	{ .compatible = "rockchip,rk3288-dw-mshc" },
+	{ .compatible = "rockchip,rk3576-dw-mshc" },
 	{ }
 };
 
-- 
2.47.2

