Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F77D63922
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A61B893F9;
	Wed, 20 Nov 2024 11:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="or9TfTzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D7BB893EA; Wed, 20 Nov 2024 11:19:24 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BDE88C8F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JtZuMuxfSmg4VXw/usj1diqnqyDWdLASwjbNnqneZBQ=; b=or9TfTzSjrB8rfok1G2kOLMLl1
 3XaLkiWzszzsCkaUfKBRvrht7g7m+CCFERSWtWwrtsMOTHzz395w/AYyvdQuvd9hJDRMSPsTVUs/a
 sFZ2bslcPRJ55gq01ZR02S6w3yXTpFmDoKbhfZI1OnIhcxj/ii0cPpatcI9gfFgr2l2cLAsfZ0QMG
 p3v9CvVHrwRfhUCumZZg09zxUBaaWtHcMrDfgCID+5UvsskXP/aAIDe7Vi9w5BFAVdIyKIXezqC46
 LquN2lJIOH3KrkPUw3gtYHZgpuz9N1AWZQLBJlLe1hZazfjJKCDIW7MubYx5OpC/45yyb28lk2WRa
 ZrwUfGyw==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=phil.fritz.box)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tDhns-0006Ir-4A; Wed, 20 Nov 2024 11:19:20 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	u-boot@lists.denx.de
Subject: [PATCH] clk: rockchip: rk3588: fix mask define for aclk_vop_root
Date: Wed, 20 Nov 2024 11:19:11 +0100
Message-ID: <20241120101911.1142500-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
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

The mask for aclk_vop_root is 3-bit wide, not 2-bit wide according
to the TRM, so set the mask accordingly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index dad484813fa..afce8a44af3 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -346,7 +346,7 @@ enum {
 	ACLK_VOP_LOW_ROOT_SEL_100M,
 	ACLK_VOP_LOW_ROOT_SEL_24M,
 	ACLK_VOP_ROOT_SEL_SHIFT			= 5,
-	ACLK_VOP_ROOT_SEL_MASK			= 3 << ACLK_VOP_ROOT_SEL_SHIFT,
+	ACLK_VOP_ROOT_SEL_MASK			= 7 << ACLK_VOP_ROOT_SEL_SHIFT,
 	ACLK_VOP_ROOT_SEL_GPLL			= 0,
 	ACLK_VOP_ROOT_SEL_CPLL,
 	ACLK_VOP_ROOT_SEL_AUPLL,
-- 
2.45.2

