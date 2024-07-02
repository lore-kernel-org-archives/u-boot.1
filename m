Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129C1C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 09:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62432884C9;
	Tue,  2 Jul 2024 11:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FkEK4qNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 742ED883C3; Tue,  2 Jul 2024 11:22:55 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8454C8836C
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 11:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Haller@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719912173; x=1722504173;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uFFrj80ILsR6yXRU5dGImQiIO/G725N4qM21K8LPhO4=;
 b=FkEK4qNxtRsmbY+aWlaFs6W1iCQ1DCU7NEHI5BwOaTJsua2QdwfgYLncPKVWP64d
 v7MGOQd/sG2fvFpcH1j6mNg/2eE1IG8tBDivbgcnakgIwHU7mKU7nSsWa+4MA2Iv
 5+z+ptgVEXEo28VEsBAB1X4pQNBlgM4iqGl/via1ii0=;
X-AuditID: ac14000a-03e52700000021bc-0a-6683c6ed6573
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 36.68.08636.DE6C3866;
 Tue,  2 Jul 2024 11:22:53 +0200 (CEST)
Received: from lws-dhaller.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 2 Jul 2024
 11:22:52 +0200
From: Dominik Haller <d.haller@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <w.egorov@phytec.de>, <jma@phytec.com>
Subject: [PATCH] board: phytec: k3: k3_ddrss_patch: Add ddr phy reg count
Date: Tue, 2 Jul 2024 11:22:40 +0200
Message-ID: <20240702092240.34349-1-d.haller@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWyRpKBR/ftseY0g+vtHBbPOpuYLaZO2sxu
 8XZvJ7tF9zt1BxaPVwdWsXucvbOD0aO/u4XV48/Fd6wBLFFcNimpOZllqUX6dglcGf8XChXs
 4ax4sbedsYHxB3sXIyeHhICJxN3TK1m7GLk4hASWMEk0/H/EBOE8ZpTY37iFDaSKTUBTYvqk
 rYwgtoiAmcSitefB4swCDhJTNu1nArGFBTwl5mw4ygpiswioSHT0TwOzeQXMJb4fWsMIsU1e
 Yual7+wQcUGJkzOfsEDMkZdo3jqbGcKWkDj44gWYLQRSv6abFaZ32rnXzBB2qMSRTauZJjAK
 zEIyahaSUbOQjFrAyLyKUSg3Mzk7tSgzW68go7IkNVkvJXUTIyhsRRi4djD2zfE4xMjEwXiI
 UYKDWUmEN/BXfZoQb0piZVVqUX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUwWSYO
 TqkGRrslvgKTKh7sKnpzmWnJqw88lxU4Xxs+43C4qPR7B5NB7LeqvZuKI5umilsaTj2nJtU5
 +85add1pmzkD8tLDl5Sef2N8cJqTVPvHoG+lPxgDexZtEn+mWPloEk9216r2/VNkVtz+eN9G
 P9BWf0v2hbB9AosZ/hs15gvHnvQoL6z7efHAVjaV20osxRmJhlrMRcWJAMhEOUBJAgAA
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

Add and use the correct number of ddr phy registers to update the
corresponding settings.

Fixes: cbf5c99ef317 ("board: phytec: common: Introduce a method to inject DDR timings deltas")
Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 board/phytec/common/k3/k3_ddrss_patch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/phytec/common/k3/k3_ddrss_patch.c b/board/phytec/common/k3/k3_ddrss_patch.c
index 39f7be8dc922..5afe5a20c7f3 100644
--- a/board/phytec/common/k3/k3_ddrss_patch.c
+++ b/board/phytec/common/k3/k3_ddrss_patch.c
@@ -12,6 +12,7 @@
 #ifdef CONFIG_K3_AM64_DDRSS
 #define LPDDR4_INTR_CTL_REG_COUNT (423U)
 #define LPDDR4_INTR_PHY_INDEP_REG_COUNT (345U)
+#define LPDDR4_INTR_PHY_REG_COUNT (1406U)
 #endif
 
 static int fdt_setprop_inplace_idx_u32(void *fdt, int nodeoffset,
@@ -54,7 +55,7 @@ int fdt_apply_ddrss_timings_patch(void *fdt, struct ddrss *ddrss)
 					return ret;
 			}
 
-	for (i = 0; i < LPDDR4_INTR_PHY_INDEP_REG_COUNT; i++)
+	for (i = 0; i < LPDDR4_INTR_PHY_REG_COUNT; i++)
 		for (j = 0; j < ddrss->phy_regs_num; j++)
 			if (i == ddrss->phy_regs[j].off) {
 				ret = fdt_setprop_inplace_idx_u32(fdt,
-- 
2.25.1

