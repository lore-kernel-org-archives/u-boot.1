Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C41ECD6D3
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D8F8367F;
	Wed, 11 Feb 2026 19:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ku+v7IKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F6B83CB5; Wed, 11 Feb 2026 19:22:51 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06BC083015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmSIvwbWwtBethgZDOHl+PguJ3Fe7g5rzUkFuyMS4J0gG4WHEIAstlDnZndTWBDYPuFrh2j5hQrRRHfGOK1gFsXhrTOr6gQLMQJWMjkfpdhPKo3ZVX0NGnNTaKpTSNSvJOE0mHp8LiU/EncYVXCdaflUFwEwsZg3VkS8Zl6U17LqlxVUcv1KwZ0T0gQ033VQ3cZ+ky+KxJt7z3n8Z2ET41NLjhyKmm6TogTLaeKJVHO3M8wBe/uX5p40AfW4EakqBeSZDCih646xcgXPofRzh7ueedo6JxQ/yWeojerEiE0TvuP/CNtYH2FGzam8frSx6oqqEvgE9O2eTcs3tO99EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxIsWQKoaGjpfzjRAa8YBEOQm9pH6f3Ief2snnoUmFw=;
 b=KPnJc8gEJ6Xqa0S7MWScd9+qhw1RBz+6vJPoEoShk8InO68cPjdZJrjMreD/TiT18quyFgA+JdzLTHVAm+u29rtPLxgx1tw/UWUxU1lQPGq4R/bsw6dJNVd0O4s0ROQMm2SvDJg5RdmUopit8yNgePJmQus1NLhLzbQg1faJt1RpNBGBeoZP8P5W8JfW6HK5vdGyFSWDccZ777aMeu8jRdcuOW7XoP82WKXSHKzzF4/AV7eLYiaiGDo+9k/aC1wnagXpQeGEABPQlb67jUxGGwqLiF7M+kztoeAC0VE49/VIsRh+CJbcC2RW1UxqFLQso8va/Bss9qDhMvuLvDMFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxIsWQKoaGjpfzjRAa8YBEOQm9pH6f3Ief2snnoUmFw=;
 b=ku+v7IKT85Cgt3T0EWdsJjrlnKwAMHuHiKkvqK9XCjYHOlXSinIpr4eZYn0/ZsbEjc5Y+NnQQUw7/iXYAr6TswkGzrc6vZzEzriiNflCE9yfjYRBHQGfLDfKDvFRHpqVweH++XTfmc+K6fpe1jKXH990If7x09S8EwugRO9ar6WyoWuAK8ReYuxjPZDE3tX9JrtF+xyg93rkohoYumbUWKRyCiRYnbDlszfiX/HnWQQ4zEKjWauqwnfvK8qY4GW0YHKYGBSFTI3nXqmd/gTa4nVOgSfL/Yw2CNyJC0TAdO6b2RL67EBSYfcN9U0bo2zau/neg8tYMmK88tM2w8+DTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:22:46 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:22:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 01/16] net: mdio-mt7531-mmio: use common header priv struct
Date: Wed, 11 Feb 2026 21:22:15 +0300
Message-ID: <20260211182230.968921-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fad933-53b0-47c6-f811-08de699a8e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yM6gYeqn/QiIcDGQWPOWV9szlbFqhF+A+qDaH8OtrwLasvHuc5ZzhbHHfDd1?=
 =?us-ascii?Q?9PKCULQTZsmhp+j/cCQZXBpyX5vrjIa0+PPXoSWU3DJl4mmMVZHCiXzUvB4a?=
 =?us-ascii?Q?JDjE9irYyWUdJMoTZpgEYHqtN5V0WCxy7zzHdMu58EuBe9xKl4fNc/+hZnGr?=
 =?us-ascii?Q?Eh6rVWmwgIeNLElAu/psgjtqYUOgCjHl3xU2Xmp4Ti8/Qa7nnpaJHCb3+0w8?=
 =?us-ascii?Q?SCE5NxxfDqvHLQF+vCCLpL3kdrIzm2qGGZXX52Q9/MIkW3nCoHNQzpYK6UYS?=
 =?us-ascii?Q?iGV4D0eeC5mMWWPFd+uW7q76kxyeWli6vbTrecnD3CCovgAVSeGfC6R2lRTo?=
 =?us-ascii?Q?hfSeNke+VJ46kLfT/HXSvoyVuPwOHOoQ1vRFY+0J3Xo/OVhpeQODx+AIxxi3?=
 =?us-ascii?Q?oZFOXcFICD1eEA2g3fZg1zCnoejF60ZDWGNTQhzWdtkRa/lqKGf/0pEt8Nry?=
 =?us-ascii?Q?MtTIwY8jXYLSd6xN8cMaJA07xlyKb7zCoCP3/NH1zHe9GaESnrEFLHkasWfe?=
 =?us-ascii?Q?NeBzb+vQm5vmH/Brp6HIoOszT+y2gIfKaTW7vPlMTROux2wBJH90KZkvmJaI?=
 =?us-ascii?Q?cSbYNf/p5mtYlHdPf/3BkVL02/W/FnkL8BaSrtH6vXGe6SBeOXjcuvqiQgoz?=
 =?us-ascii?Q?VbCbYKGnTSwgyvYgUuGojldCouDiDlN3xQlsAaZ7TAdWuPCp7bWtiKk6J4z/?=
 =?us-ascii?Q?bWurTmQgJ/ng7QVoeK9xB6QpCn7c7trVlM+e08dlykgpTO3Jr2njuPN4RYxZ?=
 =?us-ascii?Q?jVMdF1MyA77p2voxa1a5OoofKiYiMCoK8outdzRrVjt6EOr2Z3NybvSp99px?=
 =?us-ascii?Q?sXLBMLvxGSpDENIMaWZOWWg+l527dB4+GvgssbXA+NAAw9eaGiyhFUcUI5b2?=
 =?us-ascii?Q?TAG6MBeVi0Ms5RvU0fLFSwr+FbtHkvqjiz220RXATv0ZgrfQQDdtIcLjvuT8?=
 =?us-ascii?Q?ksjNOWF0pVClCI1ZIu9Xceosk81p/zQlJC41fy8CTJY/d3ZOW46xww7ZYNj1?=
 =?us-ascii?Q?arqOEiGiOJt5OWs9SPZ5Fb+51Mf0ZVhreDyQ4migfiIk/UObXXEstcRQwIN6?=
 =?us-ascii?Q?qE3sW8BdXCBnrLMC4ekZaQiDozVpT9Jjc0o8y+eR7fTZMYMmgh6UdZeL8rba?=
 =?us-ascii?Q?5Gj7PXDEx/wFC+jGkbm5MYEOsjGU9K/VCvoEMvmEQGls/+l0CuyyTnax5rLw?=
 =?us-ascii?Q?rLOWcriiJz8sgIKppKKdVMOnw+W9JJbnOoy8QIaglc9b7OiHDUFg6xFN8QsO?=
 =?us-ascii?Q?n1wlOuxufiiZ3ug7cI4Wi1KSvwtIJhfJvskCke5bbxt0lOWiAs1Jd8WuXIpa?=
 =?us-ascii?Q?qQLJVC9miwhABVFRmncy3gTBJ5RRtwwZx9NHOSnChbty75pSNcvkqCyjfPqE?=
 =?us-ascii?Q?uWB1YLlmrY0nOYRb8JvHOP257yLOHSsNt1U2D5eB+alb+H9JbVvAWBxEuBhp?=
 =?us-ascii?Q?tvwv1+iCjkHlYuiYaIxqt/0jQ5lsbD+YqooPH5DaMNaAZJyJiCYvKZ0dDMJa?=
 =?us-ascii?Q?kEnxVG3lFqn2BhmIHbrCYyxVamXREXY8lasWQBC0hCFWRfxBAZfR6+gWNZ05?=
 =?us-ascii?Q?jXaBXoPRsJ+F1+ZXuc1Sdi7WP5q2VyntWA1bi6B5C3XctnIdT5tEch7/vkD1?=
 =?us-ascii?Q?tTYIbWRyVQ54sk/M6vVzjtPYSyk2De4oYsuvib2IKQ9S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8b2cm+MKOydu4prPCOlhF1CWDlNfkXZRWCAcWgS1/r4scVbTdyzb4jxecbgS?=
 =?us-ascii?Q?ljKJfwxZUU6Lv2euSkX3C5/BsS05DN8UdnPX5vL9osNE/HaDbIjS7X0gSyrB?=
 =?us-ascii?Q?mLImkDui+r1Il7/yYMT1ILCYhdCC4jadbbK0Zty75YfWY6HteFEvzy9mmOUP?=
 =?us-ascii?Q?5A5VLecidkWqm3j+WPrarihoFfkXgSJnHq/7ibNcGoJcaFgUo0+yXojM0Hsm?=
 =?us-ascii?Q?mYvq4XFarwKD1f7asvXJ8Hd2nYvd0je0FWrc+ROGHxZxYI15fCIr8Pm0YX1I?=
 =?us-ascii?Q?SRf2WchuYkDzuygRDbXLM3e7k9aTUD8Dae3oQ2oHxJfYd6iw1hFRv1V4D2Mg?=
 =?us-ascii?Q?980mSaHstrG56uWhl5kKdVnr53VeM4VHvrgdk5D49FNDGDjK0Du0w6KEqtqK?=
 =?us-ascii?Q?irFvEweRjOPNS3agwOpznl6+1SY4OcXLjn1afDOLMhcWKSlRP6KPFiZHFVnz?=
 =?us-ascii?Q?bBb4piB5hvxb5E9elcS0zcvL/7iE4d4u2/3mlr/a+lI4qRbn9xm2CU4ubb9n?=
 =?us-ascii?Q?8dLXup/Z0IM7GcTCnOCL1n+svMC0t0Oa1cDvdhpHrJdX/v8qi1wb7jG6gDX7?=
 =?us-ascii?Q?Yy8IKNiOCUQvblpxxRDYZLQFT82yjt+lfK6drNDl+TX5x5iXj3tbAKEpsMZH?=
 =?us-ascii?Q?16GiP02WierUUA73ntit9wjj02ygn5cdeHfiAwIwaJXSP7iiI+KGjxlx/NEc?=
 =?us-ascii?Q?R4R1tFh6gDQKDh9ceUNQuIpLigBdOry7rPa0l2GwRUASY3oZgHMFOdI5cdD1?=
 =?us-ascii?Q?mv+7a5Vm3qXGqOV7r2pb1Ay2JgCZDBRIlEoP4ni/sdW8f2nMQMlEDEdbxcEN?=
 =?us-ascii?Q?QSA8btGJkH7U/yBHVbqaWHJD3vCne5U/tZbezo+mHdJiKoJT30c3xWcNX8Sr?=
 =?us-ascii?Q?TfmBT/idXe8OGRIPk5ASe8ypGyW8TD3ANuY99MxNxv+qllAPpcz7NKbYvJ2n?=
 =?us-ascii?Q?oV7Wq+FxuZRwL8ZIyIOUuLTFhOSYgwKfju8FcAlv/GR/64/t+ofdpnJdMmoc?=
 =?us-ascii?Q?xqHDhhH1k7gL8mAq66wygK4rR5e8LdVxNVG6Kc/hvL0r9QhQAHWVsym/ZhJI?=
 =?us-ascii?Q?0j48spz+NWg/9P4cLkwCUzQochDobTOBgI8tHNw8jBVCD5VqfdKRmGzjCrmT?=
 =?us-ascii?Q?kfBCTjXRSQZuMehcySbuPgWuOvtWSuXWkCc68VSF3Jy8lZxjcmsoXDg83qA8?=
 =?us-ascii?Q?wHTuzb5MfQUZiGPfb2U+9XtxAc4lLz64dey9H7Jboao9muHTKg6WT1LqlZv+?=
 =?us-ascii?Q?hQ9QJfcPl7z/hH0/SU6ZeXD8RnhUcXH4Eb21S8HrKdAvHC7qHD1w/lMvesnF?=
 =?us-ascii?Q?MmkXPShApEu3XiUfdIk+TLyZnzL+Hu9gWLGR3Lo10ssXKQU29jYHMxt3chOc?=
 =?us-ascii?Q?oMYVmZug19JLZKdZn/yBTUjpi/Z8ckGdZifyI5FhIlxtfaNnUYVtGZ9eJTJc?=
 =?us-ascii?Q?xGQkGk8cWJ+7qi7oVu5Hk1Bgr1Rms4OrNYNhrgtFJBST/dRKF7X+pZEecEZb?=
 =?us-ascii?Q?lUtup23pRK6RMtkR+unDifUvrgoC6PsZa3fmvi5OEedLkXaqpGSiqDvpbZLs?=
 =?us-ascii?Q?q2jm3ec/46AXf3pq5ZPuRp7WhMZsJJ09I5aW4iKJPdopC0wgmeh1gztp83Ig?=
 =?us-ascii?Q?ngC7JD5aspx/J4mYbhvgk9JKwPaU7w+Zb3FOV8e2mZorILP+M4NUmK3NswVp?=
 =?us-ascii?Q?v2lETl+VfYKWdcHywjUcI2MW/mhw+XYpcSIHO/zuSpvXCQa4LHAXbvq63AEx?=
 =?us-ascii?Q?L5yMF5kCZzcrO9K31AhZrjyKjlgEdjw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fad933-53b0-47c6-f811-08de699a8e3d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:22:46.7891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DhvijQRb2+6dXkaOdzjS8gnIWvuiAVpNDx6SOHCbSSQbobhXX90bgl91U6hwGh4pGU83gFItmfF46za2OqfMWHIgNZaHtv+2doOrGpjBew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8572
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

From: Christian Marangi <ansuelsmth@gmail.com>

Instead of having duplicate priv struct for mdio-mt7531-mmio driver in
both driver and header, use the one exposed by the header directly.

This make sure we have consistent priv struct if the driver will be
updated in the future.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio-mt7531-mmio.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mdio-mt7531-mmio.c b/drivers/net/mdio-mt7531-mmio.c
index 5a0725010f2..930454a9b0e 100644
--- a/drivers/net/mdio-mt7531-mmio.c
+++ b/drivers/net/mdio-mt7531-mmio.c
@@ -6,6 +6,8 @@
 #include <linux/iopoll.h>
 #include <miiphy.h>
 
+#include "mdio-mt7531-mmio.h"
+
 #define MT7531_PHY_IAC			0x701c
 #define   MT7531_PHY_ACS_ST		BIT(31)
 #define   MT7531_MDIO_REG_ADDR_CL22	GENMASK(29, 25)
@@ -25,11 +27,7 @@
 #define MT7531_MDIO_TIMEOUT		100000
 #define MT7531_MDIO_SLEEP		20
 
-struct mt7531_mdio_priv {
-	phys_addr_t switch_regs;
-};
-
-static int mt7531_mdio_wait_busy(struct mt7531_mdio_priv *priv)
+static int mt7531_mdio_wait_busy(struct mt7531_mdio_mmio_priv *priv)
 {
 	unsigned int busy;
 
@@ -38,7 +36,7 @@ static int mt7531_mdio_wait_busy(struct mt7531_mdio_priv *priv)
 					MT7531_MDIO_SLEEP, MT7531_MDIO_TIMEOUT);
 }
 
-static int mt7531_mdio_read(struct mt7531_mdio_priv *priv, int addr, int devad, int reg)
+static int mt7531_mdio_read(struct mt7531_mdio_mmio_priv *priv, int addr, int devad, int reg)
 {
 	u32 val;
 
@@ -75,7 +73,7 @@ static int mt7531_mdio_read(struct mt7531_mdio_priv *priv, int addr, int devad,
 	return val & MT7531_MDIO_RW_DATA;
 }
 
-static int mt7531_mdio_write(struct mt7531_mdio_priv *priv, int addr, int devad,
+static int mt7531_mdio_write(struct mt7531_mdio_mmio_priv *priv, int addr, int devad,
 			     int reg, u16 value)
 {
 	u32 val;
@@ -115,7 +113,7 @@ static int mt7531_mdio_write(struct mt7531_mdio_priv *priv, int addr, int devad,
 
 int mt7531_mdio_mmio_read(struct mii_dev *bus, int addr, int devad, int reg)
 {
-	struct mt7531_mdio_priv *priv = bus->priv;
+	struct mt7531_mdio_mmio_priv *priv = bus->priv;
 
 	return mt7531_mdio_read(priv, addr, devad, reg);
 }
@@ -123,14 +121,14 @@ int mt7531_mdio_mmio_read(struct mii_dev *bus, int addr, int devad, int reg)
 int mt7531_mdio_mmio_write(struct mii_dev *bus, int addr, int devad,
 			   int reg, u16 value)
 {
-	struct mt7531_mdio_priv *priv = bus->priv;
+	struct mt7531_mdio_mmio_priv *priv = bus->priv;
 
 	return mt7531_mdio_write(priv, addr, devad, reg, value);
 }
 
 static int dm_mt7531_mdio_read(struct udevice *dev, int addr, int devad, int reg)
 {
-	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+	struct mt7531_mdio_mmio_priv *priv = dev_get_priv(dev);
 
 	return mt7531_mdio_read(priv, addr, devad, reg);
 }
@@ -138,7 +136,7 @@ static int dm_mt7531_mdio_read(struct udevice *dev, int addr, int devad, int reg
 static int dm_mt7531_mdio_write(struct udevice *dev, int addr, int devad,
 				int reg, u16 value)
 {
-	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+	struct mt7531_mdio_mmio_priv *priv = dev_get_priv(dev);
 
 	return mt7531_mdio_write(priv, addr, devad, reg, value);
 }
@@ -150,7 +148,7 @@ static const struct mdio_ops mt7531_mdio_ops = {
 
 static int mt7531_mdio_probe(struct udevice *dev)
 {
-	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+	struct mt7531_mdio_mmio_priv *priv = dev_get_priv(dev);
 	ofnode switch_node;
 
 	switch_node = ofnode_get_parent(dev_ofnode(dev));
@@ -169,5 +167,5 @@ U_BOOT_DRIVER(mt7531_mdio) = {
 	.id             = UCLASS_MDIO,
 	.probe          = mt7531_mdio_probe,
 	.ops            = &mt7531_mdio_ops,
-	.priv_auto	  = sizeof(struct mt7531_mdio_priv),
+	.priv_auto	  = sizeof(struct mt7531_mdio_mmio_priv),
 };
-- 
2.51.0

