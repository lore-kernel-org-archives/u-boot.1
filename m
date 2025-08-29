Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48863CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 174278380F;
	Fri, 29 Aug 2025 16:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A39F834E5; Fri, 29 Aug 2025 08:10:22 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B9083577
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaU2icAknOwUNg0ko4MFtO9R7Cru+f9lamrTum/jVDIEVCQfQ96zqP6zvrdTDzF8DE5Jx9g4ynqwDLy+PTukHtxlMujtDk41FzVoeIrN678aLwOOEUi29DpZlXa9GzGZri1iMefWHycna40B0t6sk0fXMNzPlqUJnpYqCCMq1tdzMuXSM3Z2PmwZxfTSLR0FkNLthyWimq3k5cGAA312VlTGU6bp1AZVA7rl0wGq9Mz/rHguQ0k0pifD6zidUw6N2z4zPPjx5lfnyZL19YryY5F4Hyd14+LhAC4rBA36+sNLdtjWXoyzGN7UK7asjcbpgnVAAU1ZOQzzC1fKi2XOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vUdRkpYrz4WFXfpKaFyvRqCetCzmn9ivgq5/9lZUaA=;
 b=gEYkzHReVHgmr7y6CCwRWMrhrwonRjcDNA+2OHrq34xneKULYBW1NSVYPLSCJUwV4S3i7sMSW9L+lVR4nofO2ohDR8wXkrnvxNkd5ouISmLvrZu5BJym+6CC35DNz1WQO7tGX97KEiK6lM8rxm32s+rI6vzaloyU5yJFR2RLp1cAgJBs6Ef9S9B5BN4d0tMw5rV/dgNxHriqKVnqzNQ6FekMdrbRXqCCMiq4BTvbj16NxMg9KRNT1Y2OIyxBYvv5YQwlweaOciwviQXgCSC7In5yu/adbP6C4ElNLjs23VUT0mgWhc8UBsd71N9i5GFK9NH57E4L8jtC0U336zkQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1257.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:13 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:13 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 08/10] configs: visionfive2: Add VisionFive 2 Lite DT to OF_LIST
Date: Fri, 29 Aug 2025 14:09:29 +0800
Message-ID: <20250829060931.79940-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250829060931.79940-1-hal.feng@starfivetech.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1257:EE_
X-MS-Office365-Filtering-Correlation-Id: e5eee3de-2144-4796-361d-08dde6c2b79e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: BI7Y4+mjPLOkZ+f+a5dN/5sWBSY6OhRS+QQMDEd8JTftVYfj1Yeczcb12UnZWc+snLAe/GG+eI69Uhje3rOwaoDddVLGjOm8b1LurENzZkRrdLjNBeuVZSRP/KTMcOlMqlXU8VpoeYuLdEyHxjf/vv0r77CKlB5M74zAaS6+R40BE/5cmNR6I14puOmibF1SZjHLGNUgz1rQz4Q5LUAPaNIX8Ar9qTuo3MVevSnYLIK86lcWTcpziCyj3AEHIVZpjmIJPtyI5pxyZ6Bbg6vaka++8HnglCfVe17UzFDWwA9xjlIzG9mX5IbOyfNlceyVJJTwcfmx0xhCm7PQU1TYBx5sdcXe71jZxFwkwGsjZBelqy3gtZvNaVCNlghtUPkUjTuQ8iu2K5URKCtl4yINw5Pt632Ryx1/zfuiqoCB6Lvoahi8MuItMQwRKEgxCsqu5wq4ZunD0xFyCo5UR4RFGZ/ZkRD79Aq1cS6TA85quJXiZHlFAzrP3iXyBGgrJ3dDawE5k1VoFmWCDxCGrMBF+lfNwxFey0oJQLGMWp/zAwF2x7e4KjfFWaQMyfNLCfwdNX+32kU7Y26Tu+u6g8Fpwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YBLiyQk3+FvSCNOFOoDaaUO0akhqCzqvbXI29MU7E4fD+Uqk1fYAU+uD5TJT?=
 =?us-ascii?Q?sJGUNWw2RQFJUciNGPjUCsM8a/u2+rUnw/uUvYszoedFyNBf8TLTI7VLgffs?=
 =?us-ascii?Q?XrbDou+OCpjAbeGAWFhvNMNFw+RidxyfwIcgpnxwSH0EplwCBReRnUUgw8RN?=
 =?us-ascii?Q?UzBhKHAVrEpZB44T4n5s5DwO8SeoF9DSHl6MgacHU0J5yDi80aA3E55XltYe?=
 =?us-ascii?Q?fhkplPy7nCFd8k4GR/+/0PSDv7LhBUCMgcd72/NT+2rP42kptQ2DV6FB6/xh?=
 =?us-ascii?Q?MXzOdXgNx/s3pAjJVGiz1ROHVi8/dhyrXYbJMOjXmu6RXAl6Ojx0Kd+gKXzt?=
 =?us-ascii?Q?gEaIGPu7xcKxkIkDv14B/GNtDNNpr1iNGQ2baOrHNJzOftKi7O9zvK27K15i?=
 =?us-ascii?Q?ye4/1Q20Z79N3msGOjevLUEpqTWlZPP2KSn7/5ecUtHABZlNfi9xu996Gvfe?=
 =?us-ascii?Q?zqwya/MSF9vfXwe4kZp/GcE+fpBEvt/X9Y3mgQW6hJWmcrHMBYiSMnjJPFbo?=
 =?us-ascii?Q?qBEvP8DMHKMifh2mQg4WqkQJyue1zRoktHPxORCbTPSxLOc33GmI/hRgTayI?=
 =?us-ascii?Q?Cu3U6TGRSWCDZzYnf40vsB4GWLR1o4mzdDFQmahsjI4n7/96fssXrpoo1IqS?=
 =?us-ascii?Q?vbVJT7aVPKoydqsxBTI8xRDUmDsm7ymCyfJXkJAujExQvFkJDbXpX/El/vsn?=
 =?us-ascii?Q?bbKzZpzx1MqZkYsnMl30knqzjY/0fcMBU4TLKN8P/XNGB6MbBnRQ+K1ZI2iz?=
 =?us-ascii?Q?7++QOo6jvoHTTuDmFAJzJxwt/9TmeA/e9cq6sIXV89VoQ6umFLLoqY0/DUum?=
 =?us-ascii?Q?SOEVU8Y91r0v+1z6FHPJBL+V4ay9Ca7M5iSXap40nAJyQa/2a8kZenB2JMCG?=
 =?us-ascii?Q?m9Z3Q7ggsMVFeLfAuM1Vpywj3/yHDwbpCjPIrJph71JzeQkG43QFVa0iju2B?=
 =?us-ascii?Q?k5YOExtXcdCALsQrAZzyOOaFejCH9D35ere6O2F+XQk4cm1HX9G6l8wW8Is4?=
 =?us-ascii?Q?u2CdIxepjI+wGLnJwXVQUi18DfFsQDNcUul5Vb+BpeRTs0u3Mx6Dc5aYkED+?=
 =?us-ascii?Q?Q+ptuhvslrFXLP7m95n6zsUg68u/xU4glDhwbKRGFCM47lp+FeCBMdlv+73I?=
 =?us-ascii?Q?wRyjQ1RbfOzrQBBjw0gEmVk+p6YFUrXylI71gj3ZK+7+wWB6+R/3FcCbiC9H?=
 =?us-ascii?Q?Hfs38yqq6kiSAfSchZ5i1F7JltiGPjxhmGoI81gMKnaKNNyit2HLxA3pdSL0?=
 =?us-ascii?Q?gFLMlIQY3jmXXEtT4h/ex9ooo+pJ0uo9WMmwNKyvExFEhWOiiqjbYnx6HK6E?=
 =?us-ascii?Q?66SZwXLKbdRhUzdwtRfKEC6NbrWVINCt8kaIdLzqAcBG7s2WaL/+/q16SO2c?=
 =?us-ascii?Q?jmt9cLXUZ1yKfdvTy+90Ypla0lsqaShZV+fPzieB65GrazEqmiicKlPiV+ZM?=
 =?us-ascii?Q?3h7GwVjLr1dvvf1c3hccpICqBipbNVUkr1mvQqQK0IXCu+pm/S6CTMjQMe2r?=
 =?us-ascii?Q?W0zLYpk/SjM+kaVsoPfUnPLvmKdDygU2HIZ2xQf1n/dTVTVJUOlne8RdDGLi?=
 =?us-ascii?Q?WXOv2NWvSps5uZ0B3gBpHVt7wzeF9JYlZ56p3Md0E9yJiR19p/l3s+bHNGHs?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eee3de-2144-4796-361d-08dde6c2b79e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:13.6381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTpHZfvmLg3TCBteRzyV13lezof9SVt0xG54xahiE4OC2HrKgjD6muXps/yFYFj4QN9ekY0bbHVpeKc7HTTKMTK0mi5Dr5IwogQwYfnuk08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1257
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

So the VisionFive 2 Lite DT will be built and merged into FIT.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 544140c03f7..5a0e918c733 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -78,7 +78,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_WGET=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
-CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
+CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110s-starfive-visionfive-2-lite"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.43.2

