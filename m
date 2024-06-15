Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ED9C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 09:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46BF987D1A;
	Sat, 15 Jun 2024 11:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="lhAPZxJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C8387ABC; Sat, 15 Jun 2024 11:35:08 +0200 (CEST)
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3517287CF1
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 11:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
 by mxout3.routing.net (Postfix) with ESMTP id B7D73604FF;
 Sat, 15 Jun 2024 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=20200217; t=1718444105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w6MFxXzx1ZuGoavQuqhUIoMUtNSeGr3sI4Go0VEjarc=;
 b=lhAPZxJkkdrdyGF7K0pVQHpjgtGtTZVD+z+4XcVngr+9kE5AFYk231iP/vkA0b8c6SOQNL
 wz6VJsqF8egYJ/28IVoSHQnxIuTdABxjL4THKmFW1/L/7IzMwpsOc4H41wjKlsEoi5o7ib
 dQMvf6j8XTJR1bbutI65hbO8uCsHZv4=
Received: from frank-G5.. (fttx-pool-217.61.159.183.bambit.de [217.61.159.183])
 by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 15483100203;
 Sat, 15 Jun 2024 09:35:05 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	u-boot@lists.denx.de
Subject: [PATCH] arm: mediatek: fix ram init for mt7622 (decrease to 1G)
Date: Sat, 15 Jun 2024 11:34:56 +0200
Message-Id: <20240615093456.95856-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 1b457c4a-b368-45dc-b1d3-1c629d3ea64d
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

From: Frank Wunderlich <frank-w@public-files.de>

RAM init on mt7622 based bananapi R64 is broken since v2023.10.

Increasing the mem-map does not help here, so i reduced the maximum
available ram in get_ram_size call from 2G to 1G (board has only 1G).

Fixes: 5fd6d4c7b3ad ("arm: mediatek: retrieve ram_base from dts node for armv8 platform")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm/mach-mediatek/mt7622/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt7622/init.c b/arch/arm/mach-mediatek/mt7622/init.c
index 00d3eb9ce7a4..1f32ff947dcd 100644
--- a/arch/arm/mach-mediatek/mt7622/init.c
+++ b/arch/arm/mach-mediatek/mt7622/init.c
@@ -28,7 +28,7 @@ int dram_init(void)
 	if (ret)
 		return ret;
 
-	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_2G);
+	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_1G);
 
 	return 0;
 }
-- 
2.34.1

