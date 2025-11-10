Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F26ECCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A6D883A83;
	Mon, 10 Nov 2025 18:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="l3Y/Mq6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7314883957; Mon, 10 Nov 2025 18:37:53 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CCE839D6
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py4MfdOkhO6gza0+3Y/oNO2S7SUqDop96Yh37PGrBEGZ2sTMvBwSOvXuH6oQBVNQ1cdwFel1KXaN8erAosp34j02AQx1vSfGqROoyqPSgOiXqTR2sFmh1cSRdUPc5GGdbOKo+d2WS6Sqdlp8p5LIImDneSuAjJ+AYqcrSTlH5wF23A7NdpNg0NFg6tI3I0N2ig8tL82R1PYnw5AZEAZ7hiT/UcBzp/OQBD41XQ18VtlVUoZo1aOvxjZFi9KvRC7OyT3vSpoqaDFtfGpja/RKoYDqmQKsmnTFMVFSPkmevzDiKjh4zchN5kC8Twd4EM7L2iTBFbnLg3+GapmbgU1gBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gUloFQVFVu6G2kzwqjbqM8Gpcx1VAQaoEvIvUqeaNg=;
 b=Rm49lQCiujYuOr0Avg1sWbp9hEW1AbSdesL5B3Cp6KPefbHd6khS3VhMoJ4+fhOBTOmSII0WANnC7eyrjLtep/WXrRyfehXsT2CGjMBbj+VnFC/7s8mCL8CR+MafJx4Wb1AdQtxqMmmqgw59QfEh/kZV1VJn0ncjukZ5YbV6xtFTCjMzrL6Vt4ir5XPgonDg7yWyVUv9Wp4ZuDIV6pbnbhzPKATXaloJ+mdLwI3XnYEm2Ts53mhbXDFiRRp+vpSGXezBpW1bbXLUZN4I3/4eZcJoXDQ07660NWWy3mbFOITYibRI5+8FQJAjlp0t6sDlHAoVRsqQ1gNAM/onmdjd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gUloFQVFVu6G2kzwqjbqM8Gpcx1VAQaoEvIvUqeaNg=;
 b=l3Y/Mq6nCxuruc6gP1aEg+en0t5g/5KbEwiaWUQ8Dzwx8oqhb73AC+pOUVhWj+GcFlmQDMGZFSLzdhTre8dG6W/poeoUynmKtqaewNuo4Xar46aAQFUjPTCUQEw5Y5DcKBo9LpMBwH2FDtE+NEY/aB/WDUSSQqE2KbkgeV/mc5s806SDN+1YGVh2xuF7caFqF0IfeT0VpCQMn2VKnLyAKgyAGe+uQn/AkJcho38QiE6+6gDcIP2t6V9ViKZ8UoUASnNnhXVhu8B45CVI5Qg/9gzl8VQWJfO7ccKED6/WmjuhmPvL0z+3L73rwSEVPy9xu9qVWV94dIl7VLyGNlELVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BY1PR03MB7802.namprd03.prod.outlook.com (2603:10b6:a03:5b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:37:47 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:37:47 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 balsundar.ponnusamy@altera.com
Subject: [PATCH 1/8] mmc: sdhci-cadence: Add reset control support
Date: Mon, 10 Nov 2025 09:37:30 -0800
Message-Id: <20251110173737.24545-2-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BY1PR03MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: e982d1b5-75f1-4ab7-0ee7-08de207fdcde
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ev9XRKPx1xNPpYaS0e8HrvqJNjRx/jZOTeB+rd6bBZe9cpLXDt22OMGtVAr?=
 =?us-ascii?Q?YKmqcfBvqJQeEeqtlhsMyTolUKUdqjl4utgr4B5KApsGbh5M9KKYy9pSMjpN?=
 =?us-ascii?Q?iCjxOeXOonbpHZYSlRAGebRaJI9je82yS70+tgVWRTXTc46Vgn6KGcwMouOO?=
 =?us-ascii?Q?gKXmj19/gZyShC0Sn8DtQNjCqJBTrserjv0DTIgnlkXfdFpz7r5YWbGXFI2m?=
 =?us-ascii?Q?ni1fk0YSspL7MB4SrLnZn9Kf/qWr9ggpbCIbO6WgIjS33SWyd+rR3GmSlsy4?=
 =?us-ascii?Q?VNwlW88C4vUNer+cx8CjVpSSbw5jnLEyoWwAciCdxgm3h7W/FkknKMDLlWS+?=
 =?us-ascii?Q?B8h1iY17/kxWhCLO/4zHen8Xx40cAT9NOlyYveMIf8p9QFTAknmIXQc+bn8d?=
 =?us-ascii?Q?dNPtexq3i14W+9kbR/iusBOpKCCX/Tyv25jE11iDrxla3Ec2usJ7QJLNn0J1?=
 =?us-ascii?Q?vjn3dEIOSwJI7Ki/4A9SS+6Q4izN6D/IVhYf13mc9OK6TmXaZbN8LQ6NfdHZ?=
 =?us-ascii?Q?ZAh0dkgzEb/BZeGu466EiWBolVHoyV/cBJPpaU/a2rp8Qoka1pI0FlgRSM/e?=
 =?us-ascii?Q?2M0W6t2KnliDIlXnAhmVKRBW0hvlytyigSDCDFkT0zExu1XqjKJUIM35Lpwl?=
 =?us-ascii?Q?of5tCDooXHcH5tJu4Ic3T6H6y2XIoyJfQLrKQHxDJOqdjuQb85chj6sxkbPF?=
 =?us-ascii?Q?/NPZz+3F01Mg328YG7PL0tfwis/IyRgUNOnDtMEvR42ywML6L5FLTzvAqcZQ?=
 =?us-ascii?Q?CLalyrxLkLf2kFLPkbeXd5kiQbC3CN97vAhdo/5rSJz9I1QV0LscSNPS5KnO?=
 =?us-ascii?Q?PRANxnS/qaq0OAmpH982PTl0RJ8Iih43TA+Ur3Ilo5xK4jyET/WYTp75U91v?=
 =?us-ascii?Q?OAGN9EYIsPrttm1QyaXFC2xU5Fdqw06182L0GhfJK/jRNioCGDqcCplEFGMy?=
 =?us-ascii?Q?b8+lOam+5F9CVrksU84e72qZM5UzZJ4enx712iS+ttU5++tZT2fFjwQ15i9I?=
 =?us-ascii?Q?d7d+FW3vpQuMXUrcXZkUSm9mY+ethZwlBaFNO3YA8kIZFKuovJ/uWYKtDq9G?=
 =?us-ascii?Q?yMdCM8w0wvsWnFIpROBZe3MrPgzZAwouPjBxi+Vq2le0Isgp2x0TidrEWj2T?=
 =?us-ascii?Q?ebU3tgJT6oyDIznDP9TredJYXwgaMa00wQVkw+ynBeCkZqSf5E9najKTiRWZ?=
 =?us-ascii?Q?LB/0hfDvkpJBeAD5WkeK+R51oU2wA9VYWrupUi/jTmq1CEIQ6ipR8iZXB8eo?=
 =?us-ascii?Q?UCPMBOAOlBlgu6oxoLM1Q35+/KiA4Z+UqX64ytVKkFFiXGBdxrTUPkiWbiGz?=
 =?us-ascii?Q?xXYnOITFXPbDu8g0l66smrVHdCJowXvDEa4NtsNaG0o34Zbv2dbVUzL5C3KD?=
 =?us-ascii?Q?NwRmc18cg+5/xNgr1Reai1zadUed1/Jmegr1cD2irgFid6C80CRF+Dkj9Ndn?=
 =?us-ascii?Q?tZpsL0jrynfJp0kirG18xxP4QyNe9mrk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lvmUUFLORLheVUbLAHFWK7RDwGb/mcnl5nzQIGrocED9UsbmBHiyZ/U50HWR?=
 =?us-ascii?Q?yIvQQLCsD02p0qRlxT7Y531jri4PIJiNLRo1py+ijjKBJ9BhPL9H/Dy5/eon?=
 =?us-ascii?Q?MnFJEivRiW023bKYWA2LOfkXrVaWAcWgo+YluACPAopjWhw0tvR/Kwg/oCyW?=
 =?us-ascii?Q?GrR0vy/dZQhgefHrnS2AIx+3FTD/PnZgJ3aY/+C1l3HyR3AVfOLfNhVBzpvh?=
 =?us-ascii?Q?Z8KH2gzpeKZ3y3/keNj3trHDjGc0uLRNbjHVXrEDlOyjOLqTwe752g2A4Tfk?=
 =?us-ascii?Q?UBQ/KF1Ssa6AF3i92klmb/H6S3WlznZvDPVabcWskCHPxaWwCy2MRZqTtdKo?=
 =?us-ascii?Q?spU7cSeVdtADeZJpTGWP/TkIt+D/jg8xnqiL6pN4gOell3877RGI770uLyNO?=
 =?us-ascii?Q?YabSqSaT+Xzbm6N+yMxhLkhIQW7Jsw/CZXGLzDQFgyFmLk0stavMT9P4x09c?=
 =?us-ascii?Q?0Bo20ta6/+M7iXje1I/LmVpBE000ohr+XPVJlHssBGvalEJW6avZZV625o6A?=
 =?us-ascii?Q?2dd2H8z/hExaDhbpS8+3h1Xm54q2CfSQ2L/spCUmgkF2YWvZMPlul2WBG1oC?=
 =?us-ascii?Q?1gki7RHzzE3ZN49qjg7STYRIMTEaeUSiOppFWUpTrMP41sv29KWrdBe0TO1k?=
 =?us-ascii?Q?M5mjIvP1jY6j39H/VAKqorTCj1ZoXqiT9JRFU6x7PXRAWSY2263dwmG3oIaT?=
 =?us-ascii?Q?0qZebhB6HweJ4iSUz1IJAQcJfTienuZqqAmbG8UJUBqffp7JXSFpGRr9Flzp?=
 =?us-ascii?Q?sPIvhV2zmsui7tjan9YhfX/ooegtkgqJJxHKHfnWKazItYr6DCbBYkXxyzjD?=
 =?us-ascii?Q?ZA5JSo2uuqDQozkXmbR0dDCroSk/0y6R37XsNQ4LUUUv20L826HYFGygje7t?=
 =?us-ascii?Q?XgrduxLj9MmcaLWU+jA4hOelvsojJ8KjQMePYRg8i5qQq2ecW1GG160x1NG2?=
 =?us-ascii?Q?3K6fHPUiMXTGnaGnnLxsVYHA5Qkn0zCFHrN+wp2AwqftwNtU0EBJVIL5TTN5?=
 =?us-ascii?Q?xvAmcTcfLKKzOG/0+i7nua+4a2dgqqdoEmeAK5Iq55bOIowoUZjL5gUmuKB6?=
 =?us-ascii?Q?+HpoeCr9vp4hyA2wC8HvxZCiZ7QC5JSAaL6DO/WIdtzJAWP3+85rd1k1fMor?=
 =?us-ascii?Q?TCHtn0wl/OmrGBUL3+WBDhLezjxjmvZxKkeSykQF5+k0Sn9C4nP9BMvpjvSt?=
 =?us-ascii?Q?hP6W8zn2MAKsF4yrCWyA19j7WXuWWKBrud2LCylN+hRU6iI4xHMaLwHu/gDs?=
 =?us-ascii?Q?6/7+IIJrOLgaCWCKSEDCpFwyOSx7aG7gUl636SFcZZAXajZ3KMHQ2mw12F6v?=
 =?us-ascii?Q?vqUVq9inrORD5WO/Y3j6F3GldkubVEOc/NgKKSpF47ioYelKVt0XniVRI+H3?=
 =?us-ascii?Q?m2N0halSkmfvC2Bds8BQPfxHrZcCyOU62ZyWhzQolWjw8a5BVYhDNt2rYWgk?=
 =?us-ascii?Q?GVTbmYiZ0RPiyl5fAeSIsf6uabrL2Hgs0Yg17v8YPRXYHtn4xODAvV7u51AC?=
 =?us-ascii?Q?bGvPQgKRjbYEfJ+/qHvekn0QU/dqRqojmevLqu4lAujud5h7jgx5M2otFQgS?=
 =?us-ascii?Q?1RQ16I6Oq+Wbh25aC4d92uOfMXBOr63VyJucO0c3axoWufSI3MM8ExmRvR5d?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e982d1b5-75f1-4ab7-0ee7-08de207fdcde
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:37:47.4079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gb+MVkDda8o2rrCv57TYGjOBh6GzeODG2PfxL1sUwR0dCscFdlB9ZZqbkH7cNuJie1lLGg0y6zxWAQ38rSwzxRKKFuovVHUoppEk6TwVh7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7802
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

Add reset control functionality to the SDHCI Cadence driver to properly
handle hardware reset sequences during probe. This ensures the controller
is in a known state before initialization.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index 7d169efa476..d9fda902076 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -15,6 +15,7 @@
 #include <linux/sizes.h>
 #include <linux/libfdt.h>
 #include <mmc.h>
+#include <reset.h>
 #include <sdhci.h>
 #include "sdhci-cadence.h"
 
@@ -214,6 +215,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct sdhci_cdns_plat *plat = dev_get_plat(dev);
 	struct sdhci_host *host = dev_get_priv(dev);
+	struct reset_ctl_bulk reset_bulk;
 	fdt_addr_t base;
 	int ret;
 
@@ -225,6 +227,12 @@ static int sdhci_cdns_probe(struct udevice *dev)
 	if (!plat->hrs_addr)
 		return -ENOMEM;
 
+	ret = reset_get_bulk(dev, &reset_bulk);
+	if (ret)
+		dev_warn(dev, "Can't get reset: %d\n", ret);
+	else
+		reset_deassert_bulk(&reset_bulk);
+
 	host->name = dev->name;
 	host->ioaddr = plat->hrs_addr + SDHCI_CDNS_SRS_BASE;
 	host->ops = &sdhci_cdns_ops;
-- 
2.43.7

