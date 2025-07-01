Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7087FC8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 04:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB34981FEE;
	Tue,  1 Jul 2025 06:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="o838C/Dm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5069F81FEE; Tue,  1 Jul 2025 06:49:38 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111C58006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 06:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD7AEWvaAhn2a8dfObdBX2D7HFo1oaYzEHE8rlipZu3nwlRFfn5h6fisulqLiOFUbB5Ra5lk9/GXtjHthtYXx9bdJNJ99X2RwThvICwg2+K2GFlE+wMHXfvUXitxonpRoY5HHsK8VaUgxzVAoj2tu8JLBnSHHQmNHyWdZGY7CoAVJgMeVtXMjioKMNCukYSfIPeRTtL5XS65p74kzBmcmJzWxXlXJan9c/SpuBOOa+tv9spv+pZcutxbGTEUGrBA8RvsHVIEc7F90ZLJlwSKJqPA0gzCMtxaTXISAGJfCdcNLE3jFtV95RnhgDle/Tfesv/Mf7lCfNjfvYA9rLulBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGB/qWuTY6gyzEtTFkbiqUOHpTxOYLA4F4MV9v9wYDo=;
 b=l4/tFi626M8zTQFFv+/UjNGYF6uuegq4rmlyEQ+lSZaaeGaDLrBCkxca6bnw5Yd8ojtFEQC7CJR7L2zt5jDF3SE8mWv6kFQ8k5MKItv5v0Qqh9NEZ9m9YjQHtN9bVCRctjbUS/tAvDir3xz2aYhH+Tcuhlk0/EyJCeL1fYkaLgPOoU+h5725n+FMpVdUszFi3rQPS9vnFVk8976XCrINHt8cUOHDnkjyJxN12NDe20Wyc3U7nahNpzDXYJD9jD+ZTmgrU6185FzSqwkMlK08Ecr6f1DyyOONCZOEwNKF7NNvKuRc+5xugGJ0rsjkLCty93AozaDxGyGn2z80f8dsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGB/qWuTY6gyzEtTFkbiqUOHpTxOYLA4F4MV9v9wYDo=;
 b=o838C/DmxyYrP76OIGLpmtLMO9xr7FVbBWlhbfFFlafebrSMAjUABamK6N2315LGLiPnIs2JUjNrkvF8uCKJAfaGoBaGN/g9KmN0fXLnkx+k3xEudq+TSX7QuyncbqWuj1fpIifAoxKZ8ROFTSCflj6muZ22vAD2rXTKF2B/THNLEynR63gpp+/wYvg5aTrTCPJANrXCcE4XKvr4tuVE/azwLIXikvxBY2zlOwyydTmH4bUaegmFeNsiNo5o6WQbnXf7yTePg3rZmBPx3lLd8wZ3lkkHQhKzh2YOEFT1sdyL/EcfLasvu9l/dUsNDRIzHKmAzro6/b84zWqFPHjFTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by SA2PR03MB5850.namprd03.prod.outlook.com (2603:10b6:806:118::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.33; Tue, 1 Jul
 2025 04:49:31 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8880.024; Tue, 1 Jul 2025
 04:49:31 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] drivers: net: phy: micrel: Try to get phy node from phy-handle
Date: Mon, 30 Jun 2025 21:49:23 -0700
Message-Id: <20250701044923.7410-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|SA2PR03MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a468ce6-f9dc-434c-6a30-08ddb85aaa55
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FjfTiQ5AUFyr1a1Al/58CWHkDSyvVz50yYo1oGIslQR9MTTJgQisjNrI7yP1?=
 =?us-ascii?Q?IwG1V2Gk2Uv0bDoubmZidcbfVNF2Nf+QQeUZiVcSCfAoZjBIOw7c69BMn2E3?=
 =?us-ascii?Q?zOqhr8D5uaAFvO8z5t/rKLOE6t3maUVrAcYMDwNh5IaBN5YAhjr0zkCVImIH?=
 =?us-ascii?Q?UAhgofW5uKvoPR/0wVnFbPIwBec5Cp5drmA3+RN77WwC4WsOrvicq50y0XPz?=
 =?us-ascii?Q?vpg/hQvpbtmsnM6j3ziiu3WoDptAOlKvYXR+1P9/HSJn3icnBpw94FGOYiuo?=
 =?us-ascii?Q?G/GrISC/K1zrsR0hLxQvZeD66Mso3oacqfvPo4tCAvT+4QUDo7xo8XaIphvw?=
 =?us-ascii?Q?aWANgylC48Sc5rKxShTgqUsfDC9I25tGqj8mCKEoA85iXNYXtHCupHpkZuCK?=
 =?us-ascii?Q?qPTVHTLOFUYr5+XT/TYcV850l9DjLFVldxq1EHAYal1D74p8kvZTUDUGCWZv?=
 =?us-ascii?Q?803T1vVm0qUGAi6bUkijgs/mwAybM8Ie8VnrzqEZlXMLDgvGr1soUm/0R2uI?=
 =?us-ascii?Q?XgIofsfk6BSIynE/UptQEZ/fA8NPAIsaO+E1ayGm4vd+YAn2ttId6yKEZiaN?=
 =?us-ascii?Q?NFdb5d6bNBINQz35sKD9sXBKAunPMpWGkbG5pcMQBiWTxQQVsr3UR/Fc+1TT?=
 =?us-ascii?Q?zi4dnY576+5hU3E1Q0xZWEcI/gH7z8+3u/fmTF5/RgfCCaKaNh/s37IlL014?=
 =?us-ascii?Q?AKdWc+NvmIPlLe8FhFdUB3lDfc2CIu8rUIkA9TI7fQwFpGl4nL9W+OdasTq+?=
 =?us-ascii?Q?lf5obWpebipKuoVhpzgjj/Ee2cIWtrF/A1oh14Bbhltg3Z3v40WxXU6eEYX2?=
 =?us-ascii?Q?AziS1leAfqSrfe9nHdlGstcHjpMNouLVutMsS+y/A5FQSTM/kpe0uQugUVfL?=
 =?us-ascii?Q?6RnPkvgnuL9HITiXYB3ECU095GYGqp1mOdywC+vC90PDnYt79/Xn2ahpzEOT?=
 =?us-ascii?Q?tk1qZSG7zkLHs5zsQiOtk4E2KOQ7D1LNJzpJjlCyzBJ8GsZg35DooP/NuWWM?=
 =?us-ascii?Q?0M6QVb+jA83rMymc3vn8cKrfBd8GMTFO4GgiVLuCJ17VUrMqe14N8ONRjj/1?=
 =?us-ascii?Q?92vkrqKL6MmJoBQsOV0krZxoQZr6ihXSChmNwXIQ/SPfb2H9lSK9YUV/1dyY?=
 =?us-ascii?Q?59s1yFmGE/DzznjhoBM1wFOWmPlUsRXFkQItHazFFov8x/PFECAnwUI1jwhk?=
 =?us-ascii?Q?jAlbYACxvCOHYFMb1HOI8go4IcY2UnniVcA16XLLMrcqJzVZgMMak/O8kjbN?=
 =?us-ascii?Q?JDfdw0o4DdZ5bfz6XCJEfr7W0TVdKZv/tqleWzEvLPMzgEM6rrPyeZmBFTOr?=
 =?us-ascii?Q?1gvEoCSjE7gSEWGcCCw654anp+8ZUBPtaVrtkCHcemUL4s32pkKaRFrt0Wvb?=
 =?us-ascii?Q?i+zGaGM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kE+3HKHaBOecEVScq78VINsOjUN3uU33S1AJklN7z49aL1eoHGkVkDvBQ1xN?=
 =?us-ascii?Q?oDhUGPkv8CWAY+VdQdr/wh1FuuSfHFK8ZPH91fABpMQYzFEIT9+typYU6dU0?=
 =?us-ascii?Q?fxLaB8jdPvXQERpP4FlV7VHn/pUhfZQbV/xQTT88ZgEwqsZVFw2EFoBQJLBR?=
 =?us-ascii?Q?O1q8FBDzwH6pjwa5QrJl+XWAXS50bpNVXU4gHn3oE/UgUYB+Dyn/3gJ/sHd9?=
 =?us-ascii?Q?TWxdSJLLD/fA7vBB7pmbcYSB3Rh4EnFwpv9deMQBzU65yOFqinkyJ9R710BS?=
 =?us-ascii?Q?x6wpsLm9HO/XQalhhlkcSCaNRlZmzRqBCukSnX31uDeyAfSScrOq3Ro4mbGR?=
 =?us-ascii?Q?wqxAKLmHmCWsQJC4ZmErDvq0l/hubwPLNXRRDU5sejJnjPDHkFsuver6zeXt?=
 =?us-ascii?Q?jbbQxmP9XXTpy2r8qi6wg4Lt7Ug+9EFUPHd/M0zd1/7k/Co9LRevlSM0Dbi+?=
 =?us-ascii?Q?srL1/U0cOUc0tKH0yAYmNOMO6haaJfx0Fy8Rstmu+MhUMIqgnM1LqoG9QGjV?=
 =?us-ascii?Q?q2gVkQQdHaR2W/xr0ypEU0GTcyXEtnmHGaPH/iyL4MMQ8y0W4WiyjeN+gzZr?=
 =?us-ascii?Q?liURavFjkAyAJudxnDL+c2/F6j35qwJkZ4qZ1YvKc280p7s8lvTVhVhl38oe?=
 =?us-ascii?Q?wW0/v96S0Z4+D3lloj1BGMYLCdLO+uGqA3COlctZMzcVcwII6UfLdASE+eO/?=
 =?us-ascii?Q?qyydbsZ9tFQUKNPSI3F0gow0PTJPtFMyNuTuTrb/88uJ2UUAFRprBcZ8zNLH?=
 =?us-ascii?Q?DA+40/8O1g3BqmxqsYQuU009dTmFzdfzTXOPO3b/pbbqTyZGM8TOF5vGh8vr?=
 =?us-ascii?Q?Iu/ZeKHreEohfP0f5Wa5Hi5FqSpeECxQtLa+VXlUgrHjfvOFLlhJK1VqPT8X?=
 =?us-ascii?Q?/YoneFfkZ8HQW2uYjx/ORkO8Fpszsn4OfYurZHZG432BCCvnLNMNICdYH2l9?=
 =?us-ascii?Q?/mYssQALvFWXwZsQRBRWBs5VeI6u15FWlv9hVaFg0Oux6R6nCS42ch9gbGKd?=
 =?us-ascii?Q?N3GhdRlenHVonN96KOHZY5B0bRyV7M55xwltJzLs+Br/6yrZl0RrU7C20A9u?=
 =?us-ascii?Q?bwOz+weDGzh42X34+mvMIa55ApVvyaeJPoExOXLGrWzdCWr1fCDB3fgro+E2?=
 =?us-ascii?Q?7dBa+1MBxvGC52HHXpQVlXOlkilGEZ76/27lBY2xaWzsD4coch1aV2i8Sb0t?=
 =?us-ascii?Q?1Aroe9l3X4NCUHz0AbLDEA0JMmzXN/BZzS/W4gbU202j73IXUtuMs41t8I/l?=
 =?us-ascii?Q?38yu9BXRscmz+2IbY0f5nkylu6NC5Df0vb/DASUsVyS5PwswiyUoi3pfvZZM?=
 =?us-ascii?Q?Lzv8bwDkwMkD41jVWJiawK2in7rLSqIgFIoyPgtSw8m0uD8NrFU3yQ9WRzlI?=
 =?us-ascii?Q?aBo3v0VjQKBgwsMgBR4HhFLjE3vStymkpJ+w6/TP06lThVWERycMBEum9Ebp?=
 =?us-ascii?Q?sdCtiE4jKfYoKUFo7M4lgCIbUqv/mY0rbe8TFwEfGwBY113oZ6CJeudwXnoq?=
 =?us-ascii?Q?3q25xeWty+JelEW1pJOjySg27gG9yVefQ+g0aNaDH7sOUPDEUk8JEJHSLMzD?=
 =?us-ascii?Q?FHyMnTW8SnLNDWutCICzBC60PmlPYO7nZSSRNz9nB1mR2HMYY0/I9w+BuRBF?=
 =?us-ascii?Q?YRvuHMdqz8HJJn5l/oa2hTo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a468ce6-f9dc-434c-6a30-08ddb85aaa55
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:49:31.2382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUq4tf5mV0Rk2vLY6SJ6Rnx9Uq4pTU2dFKJsd/Q6lCr54lxXBMWFOOt+PaFWpX/thpLJ0PGFH+MC+0DbJ0ObAx5Y3VepY4FN6CMLD6h9tD6LTwu4lZ2IadEdy+kx3BFW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5850
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

If phy node isn't found in ethernet-phy subnode, try to get it from
phy-handle. And when this fails, only then use Ethernet node. This
fix results in getting correct phy handle properties for the
phy node if defined.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/net/phy/micrel_ksz90x1.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index ee8eae1efd9..a02dbe900b8 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -7,6 +7,7 @@
  * (C) 2012 NetModule AG, David Andrey, added KSZ9031
  * (C) Copyright 2017 Adaptrum, Inc.
  * Written by Alexandru Gagniuc <alex.g@adaptrum.com> for Adaptrum, Inc.
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 #include <dm.h>
 #include <env.h>
@@ -110,6 +111,7 @@ static int ksz90x1_of_config_group(struct phy_device *phydev,
 {
 	struct udevice *dev = phydev->dev;
 	struct phy_driver *drv = phydev->drv;
+	struct ofnode_phandle_args phandle;
 	int val[4];
 	int i, changed = 0, offset, max;
 	u16 regval = 0;
@@ -126,8 +128,14 @@ static int ksz90x1_of_config_group(struct phy_device *phydev,
 	}
 
 	if (!ofnode_valid(node)) {
-		/* No node found, look in the Ethernet node */
-		node = dev_ofnode(dev);
+		if (dev_read_phandle_with_args(dev, "phy-handle", NULL, 0, 0,
+					       &phandle)) {
+			/* No phy-handle found, look in the Ethernet node */
+			node = dev_ofnode(dev);
+		} else {
+			/* phy-handle found */
+			node = phandle.node;
+		}
 	}
 
 	for (i = 0; i < ofcfg->grpsz; i++) {
-- 
2.35.3

