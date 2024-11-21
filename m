Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C904DD7876B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D21389672;
	Thu, 21 Nov 2024 15:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="hzQyH6Hf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D5089672; Thu, 21 Nov 2024 15:30:02 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89D9788278
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:30:00 +0100 (CET)
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
 bh=/qcdyVE/Bx+c+hMteGo/0RQQypJNpmEz+dvYpTqa8b0=; b=hzQyH6HfVSi0/oppH0l9h1Hb/V
 HpKRWIs0IsFoDE1Enhwz/dFS2IUsgcB66y/SPR3qfLXKk6Qw30nhfTVmKgR38eVNhr8YZI640W+iS
 t8yGKIUgZNgDvHoCxilCn/8i7lQ2IFfFqxVONg+E1XAelBWRcpCOTMP3POqxfct3Ucos/0VrHL+R4
 rBGKf31Utw1Ia0qbh/sk/+G168lDyhIAkbBVahTgyLrvuQWZO0f3FH+DgFZ4RN9uemj8iuh4vN/Cf
 JnA+0nwY11V1VRjPOCVfnMPuLs6zDT+3oj9dzRfz4tXWd8geToiU3Z4Naon48NHrd5+AGZ+JnCPZs
 L2253tzQ==;
Received: from [185.156.123.69] (helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tE8A7-0007f9-0f; Thu, 21 Nov 2024 15:28:03 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH 18/20] mmc: rockchip_dw_mmc: Add support for rk3576
Date: Thu, 21 Nov 2024 15:27:29 +0100
Message-ID: <20241121142731.1202209-19-heiko@sntech.de>
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

The rk3576 uses a different base-compatible, as starting with this
generation, the clock phase tuning is done via registers inside
the mmc controller and not from inside the CRU.

In U-Boot we do not tune at all, so no other code changes are
necessary.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
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
2.45.2

