Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82010D12D55
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 010D883F9B;
	Wed,  3 Dec 2025 13:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gsWw+658";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A1C83FA7; Wed,  3 Dec 2025 13:22:34 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C60BF83F93
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ns3w0R4MYmOzgJDsQIFMXxwlO4JQUAaaau/zkvp+BzEyGnXqyqKBRzGITxfDEPzieBPC4IhEaoU+NSMw2WL66vGflLobtoxD8AzXOnPvLNO3SSBqOn/cvIp8Slg707T9V+T4xV0GAOmXK3Pb3/xL6Gtkk3mnFAnF0xhvU03uEHhEvOkqX96BnA5cB3HPEl27gN+9g/0RXLSqzNI0/TUlhdmbQxM4m9e36K9YDCuma99zoA7OpEtS3kjtCaOdmYVzyriSY4VI3XccXDhts31oSbO33UQ0TSZkSBm7Z6dUF9e+2s+33NvbwbQGlItUPGiRjTLpHJYCSUM7I95NAXCRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0pSR6nt3u1KaepPe5hTuNKXg+pYxQY929+1t7MAVeI=;
 b=hbtnpkYEA2hdFpoOORy9+YGIqY6TsM7af2u4P3Mv7v9+XdfQDVVzvXiMjhuXNK3sr9/2+BuSf/uAXX8UGjFbroSja5g/ZM+1j4EtOnMuO52zqK5n4uDwQgU4YYfDbzB5fpo7P/NzLs8a3n6w6d+sX8Q0/wV4pjVXTT21MPc10uxJgdxPufm+xohg7osNF925SJiuUJaxcHfFfmGx3Al4xwtsk31QGr2TGKOUGpKvN41q39JZSXQY8G6EfSn6/BTm/iJpkfnZB74glJc03Tczg3C022q0vd7KUW+OSnIMs0w7TOBc0dZ6kyASwenrsd5S8oF6a0ne3wuhQxi3/9YuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0pSR6nt3u1KaepPe5hTuNKXg+pYxQY929+1t7MAVeI=;
 b=gsWw+658MKZSsdGBM/nEc3O4wE4QIiOHGRedufU+32SHR59EySCKR2p8xZ95gxSuICY6rv57jBUTCe4H2Uy1p/6456FaiBFuCoxsnGcecPoV0Bf7r6KURFZ7fy7jTCqnAYL0NxCIb/3Gn/OMwbFuCk6fdeFh03CVyTBppsDNZJaLs0W7hSMT7DwnLWkN0bdmDlAQ+CB0h4rc1ViLOni3XYH/JY7EgQUmfInfJUy2APcOIcczRMgw7/oAXkQccZ++jFdeEZmTwaBw20VbLgGxk92kJjf/IBaXbmb1Zmh9UrHpi7Vhf4Sdtq9EJxa28qlfCiw6UYY+gZPRiH5qR44vPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA5PR03MB8452.namprd03.prod.outlook.com (2603:10b6:806:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 12:22:28 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 12:22:28 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Subject: [PATCH v2 2/9] mmc: mmc-uclass: Use max-frequency from device tree
 with default handling
Date: Wed,  3 Dec 2025 04:21:32 -0800
Message-Id: <4fbb3f32b70e30cc57c85083d24a00a423e48b82.1764760325.git.tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1764760325.git.tanmay.kathpalia@altera.com>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA5PR03MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e321e5-0cf1-4e35-c6a6-08de32669fba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?szOty1nNbZBW6CI3vzXZ/W/Wk53/GYIk4aviljrcP0qH2dSFuNFxvaiMKQ9x?=
 =?us-ascii?Q?sIiqDK0UTFHAhfSR/YwoIN83YXMmA4ex94AUzpdVt2ALgwnXTF4Cshxql35z?=
 =?us-ascii?Q?aN24sqgFEK9pwXxjDfxbq6Z0QHxUy9ouYtSoTdIkWkBrqpODhQjDZyVY5BD6?=
 =?us-ascii?Q?QtEct6PrLGzBxroAQAu9NxIo1yEoICNTrqADg50y1qYhqpZBLTrjpkDv3jvk?=
 =?us-ascii?Q?5T4O99HLC56B/UBAmNA7Q1iAneOnB8AE19D1CgePM9VajMNbzdpb8TSJUVAc?=
 =?us-ascii?Q?i+GN8TUetX+CxoKyrzoxDiSLIr2l+GnbvL2G8uqCkVB3OVBvH1+cq/WodWCV?=
 =?us-ascii?Q?qHYP6ikfmcsdB3pfTrupWRsYyaF9jmu96vRqGTrVgLTyZyukxh/ppyOe/6/D?=
 =?us-ascii?Q?phPWLHRXI7u0rQArfWL0J/snBjuMMprSoGPaSAFa79RF81aSvruXDDUOOusU?=
 =?us-ascii?Q?Vwt+dZVlCijtALD4TAuDp3y7pkqX23juIjv4wAvjso8P9KDEKaEmfJXDdZv5?=
 =?us-ascii?Q?IEgGVFcrvHAS3K6NHTqsu1RAXReQvMeSshqh6UNtLlvUVbJYcDPYMeuv27E/?=
 =?us-ascii?Q?cn63FinihyVgILJFY+Jc9FAz/ySv9AFLDVh1U6IHfITaMlhqDMPZ52uSkl4i?=
 =?us-ascii?Q?wtqdQT/NBL0M4wmDN5xX29Ash/EGXznaC8zD7LEd+CMB6e4gaMEAEfmFQqdU?=
 =?us-ascii?Q?Q60goIAuhFC9ZyKtSu9VfNQaSv8SfenMMzHWp++KkmdiEKhTvqwgnsZYzzc+?=
 =?us-ascii?Q?acSvBXFC/oD5CjES9qsgIijO0lDd42l++hC8Y+8akLvPYLvCAdtnU3cYfuV8?=
 =?us-ascii?Q?PVZsf+XZ8PB8IBAoWRAxu9m3GRJw+YJa30A9l3o9Bn/nUKF9ZxRSGbnHhFI+?=
 =?us-ascii?Q?9MxedDTYbwvetmlXoq64OLq0xW4+PMVpAcimvSz8FKyuPfERqyQC3Uczgw67?=
 =?us-ascii?Q?ZQy1glFGfMl6QjGx1mN/6yaoWKWIUlqrfgeGZIOpDLTHSGQDCTw4QuT0f/Ti?=
 =?us-ascii?Q?+IoqSkMdrUSqN8a3J14jhiUJOFQbZ/Vq3cQuV5zKmwoWdEsLphSRzOIzUzJQ?=
 =?us-ascii?Q?bXn8zKxL5qlyNL26oOmrRquQilySjT6KouFB5JoSSebdcb5dxrHQ5ZXJTC0U?=
 =?us-ascii?Q?xRyFWOuJSpGAz/jDmvJrTEP2zVc02utVSYnMv8d4NNkI+WGkXlG6JzkJw8QT?=
 =?us-ascii?Q?N/PIICZXDRjnSZN8NgHRSGMaG6bPw6zdjjWjuhKbiMEbSoQ315jeQVVUVkJK?=
 =?us-ascii?Q?Tzhsdqr5LPyysBf4iYehAoQRJJJdce2+8pYwzGXtKOCxiCbamfJcGwpt2exp?=
 =?us-ascii?Q?nomR3heSZ/FAAv8SGFX/o7usX4Bxi7XkI2OBaHTsNGjhvSH+aK/xocneX5y3?=
 =?us-ascii?Q?Tijo56OBNJHR2SxaG1UjXBx+cyhLOt/hYvqi78ubgZ0wRcVMMzPO9piob8vd?=
 =?us-ascii?Q?Z1cCFyhH+PU7rAWxMGYvuZgFdos8Ypa/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IUncCBQgkZkJMzDXjUhI0izgMjCM8bsGmn7VYq+ZBI2impOko4eGfbp00QeH?=
 =?us-ascii?Q?yKXrhRaxSy1lHXnMnD97GZViX6O9LiDOJ1IaFbQ//srcam8ose8fh0Z4jeYl?=
 =?us-ascii?Q?bhm3XLPdaKxzrRAZ6yW5vgO/1rGBs1jc/tDNpE7kZJZvCduu9oDOHSJDrTR+?=
 =?us-ascii?Q?AtLn+U575N90BWD1Q+sqKVrH0B7p/LXFoZliHjH/OLPKADnbQF1YsTi1UeNT?=
 =?us-ascii?Q?GvKlfJDVL+RIFCUzMpy8ZhpEDL2Ne0/r1+KnW1HuBscIHIWv+Xhiy9vI5sw4?=
 =?us-ascii?Q?aU6FhZ8TsIl4D65B/eqSLtuxsfDIt+Z7kIDNm9o8QUEwEU0ggmC15WFpi/+i?=
 =?us-ascii?Q?5JQcHpI2TGB/jibeBhx1YSV9HF+XrYArWXR/4WfI7GHZN82buFfT9tuErNlg?=
 =?us-ascii?Q?DjCOYfWWHI1NreRQ1wi43R/hmJfq930aUxQKKPhzQyUe75EznFrlK1kc05M3?=
 =?us-ascii?Q?ZWL9DUFZCx8F+3G5WWfIxlze/Q2tjeJkw+dQOcxKl9RZ5NMiOJGsKtmjjzGF?=
 =?us-ascii?Q?0KPnOcm11dK7vwsXFm5iAcPRKhi9osGcrKgtXxCb59v7c1FJK5ypS2jArlCC?=
 =?us-ascii?Q?rg9+Xww/IN73PBUHHxv8Zaxh/D4uIUXQ8rMSTd7lrlDBc2KMkvErTJPIZ7NR?=
 =?us-ascii?Q?zqALCPfGrqINC7+ebyMtan7qb0cdJgbLEsua0Wm+5EhkBLc7+BEDCY/g7tIb?=
 =?us-ascii?Q?kFn7fUbMt5DNH9Y/uu6IMAzVAHK9iUO3RrYPrqY1D203GlwcQ3qJQC6ne00u?=
 =?us-ascii?Q?H6xokmyJ4cKPNYgaknINSAKzo2wWtR0R5XsF5UFG3EdfAin1koMovAUI3YtJ?=
 =?us-ascii?Q?JseWm5vY7J4aGKUVNTQlCdXKVZPT1vM/7/+1JYECwWOK3B+XZZGVY42xaTUp?=
 =?us-ascii?Q?nxPmEEL6ER6gRGryspdNU0l3bhC9GHf+78v5YXpA48bIViRwNaPkPk6xsNAt?=
 =?us-ascii?Q?QsW2kq11b57EDngbK7tOwQNQnexWkTQc77nQdhcBcDgYPr6KTEoKOTBQypGT?=
 =?us-ascii?Q?uZfZQAwfO4VChtUfAurQZPj9klhcVBbSQWSubtBROgDiNesAKpbBZ5dLoD5x?=
 =?us-ascii?Q?klc5vuHeQocRRo+QsjKhOUYKZmAuVfBczGS6IlCbJTKe/IQRVUnJU3jyede3?=
 =?us-ascii?Q?MNPexnOIQxVTdF0etkY0FVXBjjfuXZ0iFaBswf8raSslfOGTX1SflXR+iocd?=
 =?us-ascii?Q?JhcyVniJaD9bSCgHMgXVyg+O95MFo4LAuJWnkFGBw5vJ8WnunCD6+FWvTS/A?=
 =?us-ascii?Q?SeUMOsl3BOVCiqo8dGGgRboB0pIfi9tHKrYYJlSK8DQlVlWdQfyw4jfkFtp4?=
 =?us-ascii?Q?a85zIXJZMOi3C+1EsBLfwlud0Td91H3ynHipxzLujfLBycz+0Zy3aMsBHx/O?=
 =?us-ascii?Q?oMUedzsTAabyhdX4ZksWZwibOE0V3VQfprUAE8HTQ8J3jQQWDrrZpRVwBXRz?=
 =?us-ascii?Q?SRkmWf0YlukDGGdp1Sak9Yj8nelpngotYUlNKvUzXinfOMskyz+aIhxQTqnX?=
 =?us-ascii?Q?sGGszTVSDfjMSbQFgMpUnRfwY8PIKzT0NKZPpDEe3RphtZ8a5GqEpxXirUx+?=
 =?us-ascii?Q?SyZpl5L6Gcidd9BmKneEJQbt1Xbmluy131gS28O7tY8i7jCRTtv6agShDJVG?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e321e5-0cf1-4e35-c6a6-08de32669fba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:28.2183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOoOQSsDc0mUU1MypxHMdy2qhyawcYUjixzrIQMNmkHuw6JDv38d1lWcynBcNikUnvZfk6cTaV74lyFQ9BKDseFUYz7iVzZ3Myzj6pPE54Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8452
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

When the max-frequency property is not specified in the device tree,
the function now explicitly defaults to 0 instead of leaving cfg->f_max
uninitialized. This allows sdhci_setup_cfg() to properly detect the
absence of a device tree specified frequency and fall back to using
the host controller's maximum base clock frequency from the capabilities
register.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/mmc-uclass.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 2f4dc5bd887..bf0bea93853 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -243,8 +243,13 @@ int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg)
 		return -EINVAL;
 	}
 
-	/* f_max is obtained from the optional "max-frequency" property */
-	dev_read_u32(dev, "max-frequency", &cfg->f_max);
+	/*
+	 * Maximum frequency is obtained from the optional "max-frequency" property.
+	 * If not specified in device tree, defaults to 0 and sdhci_setup_cfg()
+	 * will set the MMC configuration maximum frequency to the host controller's
+	 * maximum base clock frequency from capabilities register.
+	 */
+	cfg->f_max = dev_read_u32_default(dev, "max-frequency", 0);
 
 	if (dev_read_bool(dev, "cap-sd-highspeed"))
 		cfg->host_caps |= MMC_CAP(SD_HS);
-- 
2.43.7

