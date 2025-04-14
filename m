Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A061C369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BAF282162;
	Mon, 14 Apr 2025 22:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="N1RTZsoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B8A78215B; Mon, 14 Apr 2025 22:01:58 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493F88215B
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=cTS+B4zxA5nRpK7rEHgOvp/IYt7kv4Ebu0sAaRodDz4=; b=N1RTZsoyWBNqntZ59Y6xXcCbGG
 RXD22+c0vW9kMesBcexLC74dZJ9EdozfFomgGJjXuNmZGPtjfDfz5CFDGnruePDAORsWHPt75MJln
 U3Of1W7QDevorq8bXJ+IaGTjLuwiKhTLwEmbfRW9lQxVqOUPUDKZ6uRksF/bictn8sDqhloAXiVdH
 qfMSSNzrZ8v06IWS1pAU6TJdN2CLHtP4JR8/2apQMi7YbVdFQ0NTyoS2SETTvW8pkwhqm6QYDBqE9
 /NfhUP3fh8Km8Qk00EN/kAc8/wt9TQS/7gma6gBTYdXpBj0R44IbJihETjIyp0QrYCSltOebN/NMK
 C7mWKRNA==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4Pzt-0001rf-4E; Mon, 14 Apr 2025 22:01:37 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH v2 03/16] arm: rockchip: add RK3576-specific syscon ids
Date: Mon, 14 Apr 2025 22:00:58 +0200
Message-ID: <20250414200111.1357867-4-heiko@sntech.de>
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

From: Detlev Casanova <detlev.casanova@collabora.com>

The rk3576 defines some more different syscons, namely the IOC-syscon
holding io-controller registers and sdgmac holding settings for the
gmac controller.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index a9921fbb6e4..533f8bd89eb 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -39,6 +39,8 @@ enum {
 	ROCKCHIP_SYSCON_PIPE_PHY2_GRF,
 	ROCKCHIP_SYSCON_VOP_GRF,
 	ROCKCHIP_SYSCON_VO_GRF,
+	ROCKCHIP_SYSCON_IOC,
+	ROCKCHIP_SYSCON_SDGMAC,
 };
 
 /* Standard Rockchip clock numbers */
-- 
2.47.2

