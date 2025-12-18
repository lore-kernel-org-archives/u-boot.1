Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB975D6ACEE
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C93383D00;
	Thu, 18 Dec 2025 13:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="TQd4Fi57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E9083CF3; Thu, 18 Dec 2025 09:33:37 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D36883BA1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miB3w/FNk6+dzOfqy9tEGm3PRyreiRs6DqEI7pVGJREf7eNGQvMgIMmon7e4sVFqrY0ePUJjug0h7WS1We8Ef9O9qxOsRMKzxkZg+KXCIjZPbct1Oo/7xBUG5mV2tw+HFiqCXLTVPtI9CfHMEbRU5tOgYzXUhLrGG2Sg+jYqXYLO9nc3c7VFeNgUb1P1+OB3qote3fKZ5a2JREN4rJl4u/yFCNOQR+3V1SdKrzlFkO4PrSTOHSb+1OSw7d0+fXAmTZlaWQpVYkpf8BghK3BDzgXeRvSA/nrRr2WFhyvLD8XQEWE5ps1/ioq6PXm9E/lmIXG5mYz7xnykSZwwu+qiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYRXH2lb9d0s72HZfUgj4xmI7G9bnYsbUTFNNym1pn8=;
 b=fSM1eBP707OctVRqmFd4md2Kn5SWt1MtwdSpLzdRkLzVhCYA65oD57Zau2fOYQXZoJotTfR6MGkn0MGM2QrnR42MsHRJom1vcL2aKHrTVuB1GJs0Sd7zbeFQNHmsUtNARRPuH1vLEZvbyglZbNF6qmLmdrN+L2ncCYKnK/F0mqxFLfqvz5Ibua2+cyZZI7T+9g33DdgpUSTBy0shysoze9bzW8sC1rLgUTTaqlC4yOmbHBjRPrWDa2e/GVRWUNJw3zXjrYJTD+as6nqX2uZ5v8fNhCINX95DORtJH+ZzHxN7j1JyU34E7Vdd0ITgEb9d/exLg2UK5iTiTpdaJmuMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYRXH2lb9d0s72HZfUgj4xmI7G9bnYsbUTFNNym1pn8=;
 b=TQd4Fi57+7WQzBy7wOC+eW6LW/lyWMp6KnyVLSBBfGyxficT8PEv03kgoMzGNZTaqI57Q+sP4WvUDHKHhv6u2uU1fItav6/F6NHTh6tXsoYgPEPJvsXyKIOyDtwLKMz0IFj/yp/GYMb7XvWH8zNkFUUA+1H8rDPp2XLco3ycw+0nlHckY3GrbS/Dfx0ITWfQoIQyCjKkisX5olMz/7/kA4DY6a6+dssZpZY1oZ0ky8CcP10m7U7e1LLb1l3LAR4UyxHU7MsYRptc/2QGcHRsWnvkXR6zWh9o2yFC4ONYC842riHT4OPF9mxwxIex5mfOn7ntw/3wX79izE6nnU9czg==
Received: from BYAPR06CA0009.namprd06.prod.outlook.com (2603:10b6:a03:d4::22)
 by SA6PR22MB5895.namprd22.prod.outlook.com (2603:10b6:806:419::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:33:32 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::a0) by BYAPR06CA0009.outlook.office365.com
 (2603:10b6:a03:d4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 08:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 08:33:31 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 41B90F047F;
 Thu, 18 Dec 2025 10:33:29 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v1 1/7] video: imx: ipuv3: remove undefined function
 declarations
Date: Thu, 18 Dec 2025 10:33:20 +0200
Message-Id: <20251218083326.644326-2-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
References: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SA6PR22MB5895:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7021e47b-92a7-490f-6ead-08de3e102096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yp+Y52TrDscMPvUY0AsaRnkoIOZHKDFDHz8FP5GflDOucXDq6WXB1pnDwi9/?=
 =?us-ascii?Q?iStOOTrr+NI0T9e9xOsed/1PKvotE2iJF6N5CFqva3C5dm9QtU30P/jAHsk8?=
 =?us-ascii?Q?u3mP4g3nBI0beJkrpoIugPDYinULtBVD0JhhKZCbiehAaQSZelxtnNEdcnIJ?=
 =?us-ascii?Q?gJz/ncDrIVKLniZIp8/mW+oAnA1nqk1DGvGKzO59N1OWqtQa/mKP83u7aVoL?=
 =?us-ascii?Q?C8Y44IxIQEqaoYB8DIePCJ8QvCAcyLGJteV+8yWRFNzzrHH70+xZOpzfZYVH?=
 =?us-ascii?Q?5HLewpp9BF5P7Tui5mMZrRPBBR+wweXdAhn0RJGOYJ1cs2kXSd4mhdR/D+sw?=
 =?us-ascii?Q?ywJp8MEIKSKQ+wmUn/FZmARtNzl586l4rpAu7lI5/UZAkarH7KEhtm3HCqPx?=
 =?us-ascii?Q?bEbBX7tE6Cy//SQ35FvmD56Os2eNVAf+D4/HmYFBi1bQb/5h7+BtAurEbF+w?=
 =?us-ascii?Q?lZ1nag+FVGP90uipPynqUW9Wk+yThgFrNwiq6vuGDjqF1K3tXzQiV1RxesIb?=
 =?us-ascii?Q?U8ogXcPNPjZkAYmM41I2is/iOvspCqzvN0fNAIx7x2Jzv0z0T3opTmtzh+dv?=
 =?us-ascii?Q?pPYfGM2Xi5NSDc6Gh2FpugkF0u/9ngN0THE7Y1gokvKOfu6RwkbUU/0SivFm?=
 =?us-ascii?Q?HaWRI536Clciqr2sPY//JC8jrVi13DzbuTnIWFshnWz4fUmj7EGHYzwYTK6G?=
 =?us-ascii?Q?plMtM9bi15lBiInO/ghAVM0RaVj3PeehYaFL4wDI9le5k7yUske9bDROafQx?=
 =?us-ascii?Q?Fjm5jwPb5J05W0blvVREL7VKRWyxctuCQRjmk9ggHWezIhBNYPAtwr6RNoXZ?=
 =?us-ascii?Q?XvX8butXdLJ9RC/IJCOW5aQJV5wi0lEYFHx9Fs8NBRmjRXRPR+dDrTUiGnMt?=
 =?us-ascii?Q?4oSZgwROFFfyzf0sjc+f7arSo4T1a++NQnf5qzzqgh2Gxty2AvPlVFKC7G66?=
 =?us-ascii?Q?sBmNeR3+y1+4XfR+6E8ywraKxF50Msj/admK1ZU2vJfCvaSRvlqPTsQZdwfk?=
 =?us-ascii?Q?+uEywNfWsR3RrEqHcfgL7JkEYnRq6WW3EPbjsqGyXBrg86MWNXu9IP+44Ayp?=
 =?us-ascii?Q?4prNxHBhUoMg1U7UlgBS4K2ihUSjdisa/1h7NjEiaBIcBGeM+VoX88oMs/sZ?=
 =?us-ascii?Q?6fDOcCLYD3ZdfOtWdmjnK3aTD7NeGUuNBMz9lEH5ZamTRPfybhxYovnf1Zoz?=
 =?us-ascii?Q?1KJUQSylniYK0gZYIuSpo3uBHPb7sz5NE0qX8avsaRGrpZmc7/nTrdfniM7b?=
 =?us-ascii?Q?8DIJn23hxqyPa9752oGLg9xgBGdoMN9EH6RJflsuFgtLMhD9vWtNxZDF8ypX?=
 =?us-ascii?Q?pwbM050hC7mLxY4qc29F0ZFcgQm+MBmPAOdw392NwlFDXyvXdd1P6UkxjXDi?=
 =?us-ascii?Q?AMc4vnICuUriTBZPbRde5nsA37xtdzOwkhoWoBwhM+jNnGdSZeJaZ5Bnep+5?=
 =?us-ascii?Q?R6q+wZOGr8/6sPit7mkaQb2GjfOm1jzzhaXxmzPmgVobd8prqeqMiwagSprO?=
 =?us-ascii?Q?JSQfKvLsmGCGNZPSj33ISDiGqcGrgHetvhEaRli8ZUT9tQpCHfxAz4L1u1PC?=
 =?us-ascii?Q?5oeQBiDLxMzdJ8srABM=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:33:31.7790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7021e47b-92a7-490f-6ead-08de3e102096
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR22MB5895
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:13:44 +0100
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

These functions don't seem to be defined nor called anywhere so remove
them.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

 drivers/video/imx/ipu.h        | 4 ----
 drivers/video/imx/ipu_common.c | 8 --------
 2 files changed, 12 deletions(-)

diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index 4c13c9342f7..93bc97e6300 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -215,10 +215,6 @@ int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
 				dma_addr_t phyaddr_0, dma_addr_t phyaddr_1,
 				uint32_t u_offset, uint32_t v_offset);
 
-int32_t ipu_update_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
-				  uint32_t bufNum, dma_addr_t phyaddr);
-
-int32_t ipu_is_channel_busy(ipu_channel_t channel);
 void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
 		uint32_t bufNum);
 int32_t ipu_enable_channel(ipu_channel_t channel);
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index bd1ef0a800d..61a3fe1e83b 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -1249,14 +1249,6 @@ ipu_color_space_t format_to_colorspace(uint32_t fmt)
 	return RGB;
 }
 
-/* should be removed when clk framework is availiable */
-int ipu_set_ldb_clock(int rate)
-{
-	ldb_clk.rate = rate;
-
-	return 0;
-}
-
 bool ipu_clk_enabled(void)
 {
 	return g_ipu_clk_enabled;
-- 
2.39.5

