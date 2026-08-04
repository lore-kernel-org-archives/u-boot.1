Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B09DC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3666B80DEE;
	Tue,  4 Aug 2026 21:45:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id paEAEJJA6ugu; Tue,  4 Aug 2026 21:45:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9F1E80DD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879922;
	bh=dGadVTJuo+l5IAWEbIBKvAmqIecWg7NSuRLNVen7h/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gQcm3ipUBUDvB1eDubnuH0BNGainKx0dZ6TaPiHad7wQQGSsjq1QxB3B8Fh077pfJ
	 mQqgF3QZ1vf6N/T2nkh+Fu7ehNKzoVM2ZfOGUBK9sUxGakG9M7H5Bjks6cityPNJtF
	 INMBBxQ13sbyzota1cP9jIu0VdktmRtxS0sLyooRRIOCW6eJdKyI4JwYVq5YKMGsh4
	 cHKyQ5jioEAz46ybigwNwlr3TXDurz+788AfhuQfvPZ3lDSg5JLSQPfhnbc0M6jWgR
	 iZ6WhByORlbo2q7T45EqQq3AyASAxXukdUtL/8W7VMV/YO5n29/+XmmJDrmWTPRRgl
	 gSIskDC899e0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9F1E80DD9;
	Tue,  4 Aug 2026 21:45:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7997E270
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5FDE340571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SC5AO6UCo7dj for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:45:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0F28C405D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F28C405D0
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F28C405D0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:17 +0000 (UTC)
X-Forward-Email-ID: 6a725d6c96269bde0830460c
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
Subject: [PATCH 10/10] rockchip: rk3506: Remove unused rockchip_get_clk()
 helper
Date: Tue,  4 Aug 2026 21:44:39 +0000
Message-ID: <20260804214442.2592597-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
References: <20260804214442.2592597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785879917; bh=dGadVTJuo+l5IAWEbIBKvAmqIecWg7NSuRLNVen7h/0=;
 b=xIA7Mq3eG0ixmzzpoJ63BomCFHEdmnDbeH86eYILmrvT4QyFjWigBXlpvt6gp0j8oJsxlXWZG
 Fp+2u+itkWhxmqw9+7JMVK/ecp3u8d+26ifGO3TcsEsPF1zc0GDxUobDH4gxl/k7+oqgJQg0ynW
 FZl+Ox0fTIypjI1vSfTL9DfnxJXGrPOk9CIAul+U3Ly3cg5tvh+5lteg5PMs8vSeX2WLE0YP3lJ
 c0tYR8s3n4b6GyI/3B68ea4Fq/GRJyoFiit1CZfsLgOW5m46VlHiEM3fkdxQjAjQx2M39566EL6
 J56O+cAHgoHMVoWC1IWJIpCZjdMiMOApuS94EtW4DJRQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=xIA7Mq3e
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

RK3506 has no uses for the rockchip_get_clk() helper, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3506/clk_rk3506.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3506/clk_rk3506.c b/arch/arm/mach-rockchip/rk3506/clk_rk3506.c
index 96723f403cfe..e3161418302e 100644
--- a/arch/arm/mach-rockchip/rk3506/clk_rk3506.c
+++ b/arch/arm/mach-rockchip/rk3506/clk_rk3506.c
@@ -1,15 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 // Copyright Contributors to the U-Boot project.
 
-#include <dm.h>
+#include <linux/kernel.h>
 #include <asm/arch-rockchip/cru_rk3506.h>
 
-int rockchip_get_clk(struct udevice **devp)
-{
-	return uclass_get_device_by_driver(UCLASS_CLK,
-				DM_DRIVER_GET(rockchip_rk3506_cru), devp);
-}
-
 void *rockchip_get_cru(void)
 {
 	return (void *)RK3506_CRU_BASE;
-- 
2.54.0

