Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC4CC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C021080D9F;
	Tue,  4 Aug 2026 21:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kepszwlc9LTe; Tue,  4 Aug 2026 21:45:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDBF380D96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879911;
	bh=Yn0nzlqjchKT9G2BJLc+g48Jkz0Ob4sOXUU5XqZGWfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZAzpT349QLwyyccQr8Wm+VdN5LqrJFumRvcV59dsP36H01/B947+4Y7pioww1QdnO
	 ctxIYYfbu8SHhiKjgXPKYhRwA9VXjDFYUhngbClm6BhaIz+Em68kLgOIV8T8ykodrw
	 YHwS441yyAjoOdaDBHB7MyW1vOURYvAZqwGlTvMj6c+J3LYuSgdx6mMTk5jM6QRi56
	 UL3S2kxl6RItfnDONvmaZV7UZzD7POilQvfrSoSIdsD8we/C16Qn+opK455Hw8eavp
	 nazQD2eMMxGefbAt39hdPYWzPiiutjtQu8Ue3RsWyFEWut7NL6TIAe38vfJTiWoL6S
	 RrbOX1nhj3Nzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDBF380D96;
	Tue,  4 Aug 2026 21:45:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F1A610E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 75E014059E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nt3pUiDXGNsl for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:45:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8158040571
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8158040571
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8158040571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:08 +0000 (UTC)
X-Forward-Email-ID: 6a725d6196269bde08304580
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.5
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 06/10] rockchip: rk3568: Remove unused rockchip_get_clk()
 helper
Date: Tue,  4 Aug 2026 21:44:35 +0000
Message-ID: <20260804214442.2592597-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
References: <20260804214442.2592597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785879907; bh=Yn0nzlqjchKT9G2BJLc+g48Jkz0Ob4sOXUU5XqZGWfc=;
 b=F7tr8zk+wjkgQRu2Chg3m9hYIoQqPtsPBV6CDV3FkJg9GVGO+65al4T+pztYrQsOyTeUPNcJf
 g4WX6mbg+pkLzYXKe5rgIkYLRyF+kIHl5CVZVrML4hIxd9o4Scqyc8NW2Foqzn8BSolScCuiX7J
 n4NMeFxZ2Kzo3YRyWoYxM9j6bAx/YL4frB1i/eTwaD9w7sLhnzytk+nSdvRLcvsYQlMy+ph6+mm
 Q4HSxN/36YDPBFsUS03tlf/Y+IjYfSYGot/q5DSIVFH8w+kC/r05UTCKZYx28PfrGzDvnKvJI3a
 KU/ppMeer4JSm++BUYRMFlcI5nE2Zp2c0Yp8iKQFjFSg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=F7tr8zk+
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The rockchip_get_clk() helper is typically used by SDRAM init code of
older SoC generations or to help get the CRU base address from the clock
driver private data.

RK3568 has no uses for the rockchip_get_clk() helper, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3568/clk_rk3568.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
index 53755bcf55ad..72141e4726c2 100644
--- a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
@@ -3,15 +3,9 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd
  */
 
-#include <dm.h>
+#include <linux/kernel.h>
 #include <asm/arch-rockchip/cru_rk3568.h>
 
-int rockchip_get_clk(struct udevice **devp)
-{
-	return uclass_get_device_by_driver(UCLASS_CLK,
-			DM_DRIVER_GET(rockchip_rk3568_cru), devp);
-}
-
 void *rockchip_get_cru(void)
 {
 	return (void *)RK3568_CRU_BASE;
-- 
2.54.0

