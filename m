Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5598C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 15:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29B3482CA0;
	Wed, 11 Jun 2025 17:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="HorCvQDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7DD982CA0; Wed, 11 Jun 2025 17:11:00 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B25F182C65
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 17:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QftwlIpjhYlg3WfF+fhVU/vfyDHeLh9I/c/xqCJJ2l0teLsIR0omDGk7hLv2+pF7AL9wGKq68reSwvFTY/3L4rU/gk9zNfNfzk4SPqYvBDT5UXrVB950Zl7C7LleKeOlaM69ffJlVSFsZ9Mxnbu3vVBMxZcLilr5FiFO4iXhhIC5PcIxYC54bY8S8H7gj2gI1kc3eT5vkuwxVUVr0I3UnuGL6ydkGPst69HsV8aX6yiACHfh8K2Q/2qqzM/HARgKKT6CTwJzKabXZvjroAh1B7uveFVHLM7SLTiPWG9OZc99j4qRHaNxzsevHNa3NuDGR/sxsT5QdEeTbGtN6RpCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYtr71h/w8xDmpSWbjn4sGBmO5GlMqrpQVNUUZRgf/k=;
 b=Co5pTlfufK+yw4cOp2a4xysad459YOYYNhsYipm8g+PmB5wG/o46YNK8Ru3UT8bqxygg4L1JmddopaQi1/8ocvGmBfgEx894GeLVu5pLlSQy7MX4h030TgJD/2ys9tpl1TD3kVr0saUBkq8498WErGvaqohWSu3FBaDg5MWIZXsIWhuyKgaUI/0Vp9TZerDpEZ4VpJ3ULrTRvJozMZxBP3bEqyGng0YF+OGB/4jT/NXmy77yjAIYPa/BeTD9FhSNzLIthAXCrc3wTT3bsOdzVXn4gnoKgYo++M1yz+WxLJvM3L1lUdmE/Cqn0/1R3Ez2l7XVzb/fzP336kkVc5wniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYtr71h/w8xDmpSWbjn4sGBmO5GlMqrpQVNUUZRgf/k=;
 b=HorCvQDVghw6jViZ6dfxRPQvfFZDuXVNGf2bgzoV5K9LWv2Gjn5wFPwHXN3Y3prTUHA2b4gh5lLvIHRoT06A4Gg0ww8c0B2DR105mZD5hpsKcUoB5keGpGfSm8J8TcHnYYlIwKnMNJYUIc1XRWFWnAE8kHFjp140ZSfzNXRyqq4pdKy5pb9SkoxrS4MD0E5UOhdyCviu+vKkT7yAzsaUDP5GwIqDyt+NRqjD4CS0s0U0BsUR1M9lOXVk4G9vrlyhF3TTq0ZBksLETg5D+GGegHT7TUaOkIdWm3yiRw2DQ1Vh7Pjtf20ClD7M3IYJp8P4nwnygANm5YrdUH6z+crhEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8089.eurprd08.prod.outlook.com (2603:10a6:10:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Wed, 11 Jun
 2025 15:10:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 15:10:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 3/3] drivers/spi/airoha_snfi_spi: add dma support
Date: Wed, 11 Jun 2025 18:10:43 +0300
Message-ID: <20250611151043.1259441-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
 <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: c16678cb-1bd7-43b4-2fa7-08dda8fa29eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kVu6SRr4CtUAAMOBbwamhCTCWsNNsgxb1UGWe14It3ZFpy7zWYIjvg3Q7eSq?=
 =?us-ascii?Q?PhmEDBAl/zKcRDWTJo2cgV5a39GGmsEeAKq9VMk2blejbBRMK+d8kF7BTX0L?=
 =?us-ascii?Q?YoQZ3rXYC2B5i25NK+7ZQsPCCxGdgDKfPMZXSml1FclKX+GKzIl5pLt9ZD5/?=
 =?us-ascii?Q?PzgKZ10QCo609Qv6pAhE50aC184Xpt9zU/POe2zA5uq6nuuLS0m12+W3rpDY?=
 =?us-ascii?Q?zhC35CqfdV6Z8G4HqAWVCa+iz81tgvWU7JZvfTFeYIUtQDhkjHKd76zTjw4r?=
 =?us-ascii?Q?jLrcQrOnQ1fpXC5wDRn7smi3Spbs23vXSY8Wgoxw9QQLA9QuPfUSVGDfhUMu?=
 =?us-ascii?Q?rw4tYUi0xAjZrUPYGLq2xN/wpRCN93JMe6a6e0Tp4DEEYaYIm512Nz73CsFL?=
 =?us-ascii?Q?co6SKtb0rWp4OP/jO/2wgxOnvX4wj7yRzcpMToB/o04c5WrxCd2JNHQUKECY?=
 =?us-ascii?Q?lfpm3p2KwQP02pf5zGQVXhqPVy7CfKhI7FbpBoZ16cfoIkYKWpKaDiIp6jpo?=
 =?us-ascii?Q?B/DfoslDj5otGolO9C+xLX++DDkiyto3ewUpfeRcN7EGO0nUNLjR/q6fDzFI?=
 =?us-ascii?Q?V4hQCT121izFf69XXGXSdqa2DXCRK7klWL1lXPan2B6LYbD7hb41IfxyvVlW?=
 =?us-ascii?Q?ZNI8U9Nvr8pVRY9krfcWmUx4qC/0oDHbLUe0wtIXx78pP+yuEMMs6eG+80oa?=
 =?us-ascii?Q?S2eyXISKK9ywU6I3gpjgIIezeI3w88eB3v7tUpySmH5AcyeVrv7r+o09YGy1?=
 =?us-ascii?Q?K1uDu62yzjftbfDs2lMwfhY+krb9aKqF6KTAkaPbUJwUX1bxb5KvJMcG6IUB?=
 =?us-ascii?Q?naFtzLAxIYO+aqEmnDj/327i0YiNuvT/NXf5ayJ0Gnpz0AH/XPSKFV9ftXXs?=
 =?us-ascii?Q?jPDFGAacCzdMOd6uI2QrQl/7WlNMBbUpwss7FB4HMM+p5YXHkQYZubcJ9Vha?=
 =?us-ascii?Q?u0hv66aoj8kRbV3v+jydTih+Nxj+SKprkASLGaRq0TO6/6qGmB0+mCgtKb8n?=
 =?us-ascii?Q?wNNb9JoAMILgAkfis8xBPiem1btopfjWkOPL/t6FSZiOEgCrrSdhZ6VhOwkJ?=
 =?us-ascii?Q?ZN/ki8LMenWorvZpxfaXkOpqMa1bVScElBGhAkt4sICbkwJvpl6t8ap5lHmJ?=
 =?us-ascii?Q?UGyKjT+i/RxGPfY3RqDLZJLu24gy1OBvAGksIk8+LOGdgRrXcZPuwMz5HiOC?=
 =?us-ascii?Q?klUlhVOuGenoRZ1VYUpDnI1zRJrlbzn1C0kEQ7aR/pNFxE9RQau6dGv4aIE8?=
 =?us-ascii?Q?ZgjCcyD3ZM4g+4SNb5SQ7km7MoPO1mYw4nNQ2qjkdkwKkQ3ePrZlciQ8XTJG?=
 =?us-ascii?Q?VXwW5/+W36MWiAiOjZEtAXbyLfa94u5cQhS5+ILguSlg1/Sssq2UF8RSj/Rd?=
 =?us-ascii?Q?l5OBMziLAO9Ae2Obj/aaDe5dYPwuTlUHVBU8YFWHqXJmh6wEqgbRcIfQq7uQ?=
 =?us-ascii?Q?PXJIzaovdGLwsb/NpiqiKqupJT7lsbDc9CUxZpETfgH7aDfBLkf6mA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AZzYCJjcoMh6IUC3OLfGYN7KaYYqpO8Wo7lkuNSwAX0N6O5cnKQzkeEwaZG9?=
 =?us-ascii?Q?mXR4kl0hEac2j4u8ZUJqGXJKm9S1yqmsh65ypK9JXWTN1YIVef4MMI596V9h?=
 =?us-ascii?Q?hlG2KcN+eZsBeYFZnOBmO0WLSmNoiHgxe+45HRpQpUaiztBhv0AYw9PXfcab?=
 =?us-ascii?Q?Co8O3szHJ5klVzvWOJ1Ad4mHZrwgSyRsS+sVSvKEn3b36hpeotmgXcPwim+W?=
 =?us-ascii?Q?r76rXF6a9VC6Ad51yDCWarrS6OJk49+Zvq+6yKzrEkKTHa5dxEi4VTFUs0vD?=
 =?us-ascii?Q?ZgbA6QCkXNoLYN1noyjpOiI9x6rC8t9YOf7RnmV2KzH86PMVHH8bighMdw6v?=
 =?us-ascii?Q?EvJpm0udXVRRZ9y9taOEApkjjFiUsTPGUnFRqMu3qOVCaPgaPTN5UuxBydbV?=
 =?us-ascii?Q?vg3uYMbGYAiam5qKRYDrw0JpMlPNCmRY6McAJ1oYWK/t+jeZRc6l5ylLnEyT?=
 =?us-ascii?Q?Y7ZdZCi01uNvwQz0efdg5zqSzwf0YAGJhUBf4NcNQxmnnA783GSOFzdXeysQ?=
 =?us-ascii?Q?/GY9oVajw/hgCqFxgryrKDpAVLm+mdbylraZD8DRKuvhmWyN7VMU/TtURQyQ?=
 =?us-ascii?Q?ALbdLiHLcj5J+VpxyXzr38IWOkBGYtbb6gEe5SHivHEMV6uG1W3l+KRSOkeX?=
 =?us-ascii?Q?HE3ujuj9vfEM1L0MAoma2knHdACOAR9JiGWLCoPR1wvM09cA31lMNs56+Bqf?=
 =?us-ascii?Q?Cg0D/u8DzK06PFZS/fEFArCt6Gjvr8ruoccRylmRVIIWbrgcL0V+BRFhv1N7?=
 =?us-ascii?Q?psXAJiOsDwhzt5ka8SFN/mcCjMsbUCf7hTWaYnADajMclyMoG+QWbo9OYiPp?=
 =?us-ascii?Q?v1KXSkRntE9/AByJBEWmjacqczaz1QuhlHMpeWUC04BZgOhRovsxhfyWSnt0?=
 =?us-ascii?Q?bmohNFqBlJ7ZCMqi6cioOaIPWyUqMk2eyoEnMzbDeTUCLHHXcg9bXyFh3xLn?=
 =?us-ascii?Q?rURawiH3EiCdKfvOvtplp4MoCkxAnA4yih++OaSbH9V4WyXGU1sOojmVvewW?=
 =?us-ascii?Q?VDG2eAtJYP5BS2IbjMi54OR6FI13B3T77XgAYmHPVnAausWiOdov5xJrNZf9?=
 =?us-ascii?Q?tkkhgIdtitPvIHTQuYls66rYYmcCj6XR3b5rKrX3BFGqD09qKDek7oCGjxnC?=
 =?us-ascii?Q?n2GlG1z1j6bF+Y6G3jzlJbVW4E3XzLm5Vl3LpjM0mHh+surewxTIXosbyHUD?=
 =?us-ascii?Q?AZ9PjGGATBCoWNxfJZymEoJuB278GLYqiL9WiLEgIO5f8Zih6hMBCX+FnWUK?=
 =?us-ascii?Q?fLe3/rp5qNKu5R8XFmGYlL+JDRM30dDe+kwiRaQgvXqZeX2bKrHJMpEHmMHy?=
 =?us-ascii?Q?91kd3H8ZhX7iXkCeKotqxzR5/O+z3VQDeGY/BSZlyMLAOtjq1j9pcDOdkWSU?=
 =?us-ascii?Q?k89aSyj/k8wg5VOyBj3nLBJveStAz4qHUCpG1sYWrqijWBDON2FnxpaJh0u1?=
 =?us-ascii?Q?26M45p7xNqXU2s785BQNROibOJ6b4v4wu2fxtqa29D9PQ+4tDTTMuhtI2hQH?=
 =?us-ascii?Q?kezQOmPoEofbVslZpko2vuDRlM+5sYUT7rtAbyoUVCYBhA1s3E9GpBZYZ0um?=
 =?us-ascii?Q?5PFVW9piqfZzk1L3TAX7uBR4uQkf8PkilDolzCVUd+RQmVeZzNEYpDC9SIWv?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c16678cb-1bd7-43b4-2fa7-08dda8fa29eb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:10:55.9648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DjjT+dbktZHMFNy+DFQULDQlrcHVp8UWo58QO+t2OBu7SA9doYFtmx0LwQfrGQoLr7kNwlnpU7PlT0UInv+3yg01AGhFEVGzP0GJg1/8EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8089
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

This patch speed up cache reading/writing/updating opearions.
It was tested on en7323/an7581 and some other airoha chips.

Unlike current desing it does not use any knowledge of spi-nand page/oob
size. Instead it will only use an information from spi-mem request.
It will speed up
 * page reading/writing without oob
 * page reading/writing with oob
 * oob reading/writing (significant for UBI scanning)

The only know issue appears in a very specific conditions for en7523 chips
only.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 519 ++++++++++++++++++++++++++++++++++
 1 file changed, 519 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 363590231e2..00c202e8e62 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -119,6 +119,7 @@
 #define SPI_NFI_AHB_DONE			BIT(6)
 
 #define REG_SPI_NFI_CMD				0x0020
+#define SPI_NFI_CMD_WRITE			BIT(7)
 
 #define REG_SPI_NFI_ADDR_NOB			0x0030
 #define SPI_NFI_ROW_ADDR_NOB			GENMASK(6, 4)
@@ -141,12 +142,17 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
+#define SPI_NFI_DATA_READ_ADDRESS		GENMASK(12, 0)
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
 #define SPI_NFI_PG_LOAD_CMD			GENMASK(15, 8)
 
 #define REG_SPI_NFI_PG_CTL2			0x0528
+#define SPI_NFI_PG_LOAD_ADDR			GENMASK(12, 0)
+
 #define REG_SPI_NFI_NOR_PROG_ADDR		0x052c
 #define REG_SPI_NFI_NOR_RD_ADDR			0x0534
 
@@ -173,7 +179,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -189,6 +197,8 @@
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
+#define NFI_CHECK_MAX_TIMES			1000000
+
 enum airoha_snand_mode {
 	SPI_MODE_AUTO,
 	SPI_MODE_MANUAL,
@@ -212,11 +222,19 @@ enum airoha_snand_rx_buswidth {
 	SPI_RX_BUSWIDTH_QUAD   = 0x0f,
 };
 
+enum airoha_snand_nfi_buswidth {
+	SPI_NFI_BUSWIDTH_SINGLE = 0,
+	SPI_NFI_BUSWIDTH_DUAL   = 1,
+	SPI_NFI_BUSWIDTH_QUAD   = 2,
+};
+
 struct airoha_snand_priv {
 	struct regmap *regmap_ctrl;
 	struct regmap *regmap_nfi;
 	struct clk *spi_clk;
 
+	int dma;
+
 	struct {
 		size_t page_size;
 		size_t sec_size;
@@ -567,6 +585,478 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 				  SPI_NFI_CUS_SEC_SIZE, val);
 }
 
+static int airoha_snand_dma_on(struct airoha_snand_priv *priv)
+{
+	int err;
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_ctrl,
+			   REG_SPI_CTRL_READ_IDLE_EN, 1);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int airoha_snand_dma_off(struct airoha_snand_priv *priv)
+{
+	int err;
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int airoha_snand_nfi_read_cache(struct airoha_snand_priv *priv,
+				       enum airoha_snand_nfi_buswidth buswidth,
+				       u32 opcode, u16 column, u32 len,
+				       dma_addr_t addr)
+{
+	int	i, err;
+	u32	val;
+
+	/* NFI init */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_INTR_EN,
+				 SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
+	if (err)
+		return err;
+
+	/* NFI reset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		return err;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFMT (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup FSM operating process flow (NFI_CNFG_OP_READ)
+	 *   - Use DMA instead of PIO for data reading (NFI_CNFG_READ_EN is set)
+	 *   - Use AHB bus for DMA transfer
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+	if (err)
+		return err;
+
+	/* Configure NFI for reading */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD, 0);
+	if (err)
+		return err;
+
+	/*
+	 * Setup transfer length:
+	 *   - Enable custom sector size feature (NFI_SECCUS register)
+	 *   - Set custom sector size (NFI_SECCUS register)
+	 *   - Set number of sector will be read (NFI_CON register)
+	 *   - Set read data byte number (NFI_SNF_MISC_CTL2 register)
+	 *
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 *
+	 * We will use the following settings:
+	 *   NFI_CON.sector_number = 1,
+	 *   NFI_SECCUS.custom_sector_size = transfer_length,
+	 *   NFI_SNF_MISC_CTL2.read_data_byte_number = transfer_length
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
+	if (err)
+		return err;
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE_EN |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, len));
+	if (err)
+		return err;
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL2,
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, len));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_STRADDR, addr);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL2,
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   FIELD_PREP(SPI_NFI_DATA_READ_ADDRESS, column));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
+			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, buswidth));
+	if (err)
+		return err;
+
+	/* trigger DMA read operation */
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				SPI_NFI_RD_TRIG);
+	if (err)
+		return err;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+			      SPI_NFI_RD_TRIG);
+	if (err)
+		return err;
+
+	/* is reading finished ? */
+	for (i = 0; i < NFI_CHECK_MAX_TIMES; i++) {
+		err = regmap_read(priv->regmap_nfi,
+				  REG_SPI_NFI_SNF_STA_CTL1, &val);
+		if (err)
+			return err;
+
+		if (val & SPI_NFI_READ_FROM_CACHE_DONE) {
+			err = regmap_set_bits(priv->regmap_nfi,
+					      REG_SPI_NFI_SNF_STA_CTL1,
+					      SPI_NFI_READ_FROM_CACHE_DONE);
+			if (err)
+				return err;
+
+			break;
+		}
+	}
+
+	if (i == NFI_CHECK_MAX_TIMES)
+		return -ETIMEDOUT;
+
+	/* is DMA transfer completed ? */
+	for (i = 0; i < NFI_CHECK_MAX_TIMES; i++) {
+		err = regmap_read(priv->regmap_nfi,
+				  REG_SPI_NFI_INTR, &val);
+		if (err)
+			return err;
+
+		if (val & SPI_NFI_AHB_DONE)
+			break;
+	}
+
+	if (i == NFI_CHECK_MAX_TIMES)
+		return -ETIMEDOUT;
+
+	udelay(1);
+
+	return 0;
+}
+
+static int airoha_snand_nfi_prog_cache(struct airoha_snand_priv *priv,
+				       enum airoha_snand_nfi_buswidth buswidth,
+				       u32 opcode, u16 column, u32 len,
+				       dma_addr_t addr)
+{
+	int	i, err;
+	u32	val;
+
+	/* NFI init */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_INTR_EN,
+				 SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
+	if (err)
+		return err;
+
+	/* NFI reset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		return err;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFMT (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup FSM operating process flow (NFI_CNFG_OP_PRGM)
+	 *   - Use DMA instead of PIO for data writing (NFI_CNFG_READ_EN is cleared)
+	 *   - Use AHB bus for DMA transfer
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		return err;
+
+	/* Configure NFI for writing */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD,
+			   SPI_NFI_CMD_WRITE);
+	if (err)
+		return err;
+
+	/*
+	 * Setup transfer length:
+	 *   - Enable custom sector size feature (NFI_SECCUS register)
+	 *   - Set custom sector size (NFI_SECCUS register)
+	 *   - Set number of sector will be written (NFI_CON register)
+	 *   - Set write data byte number (NFI_SNF_MISC_CTL2 register)
+	 *
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 *
+	 * We will use the following settings:
+	 *   NFI_CON.sector_number = 1,
+	 *   NFI_SECCUS.custom_sector_size = transfer_length,
+	 *   NFI_SNF_MISC_CTL2.write_data_byte_number = transfer_length
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
+	if (err)
+		return err;
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE_EN |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, len));
+	if (err)
+		return err;
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL2,
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, len));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_STRADDR, addr);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_PG_CTL1,
+			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD, opcode));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   FIELD_PREP(SPI_NFI_PG_LOAD_ADDR, column));
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
+			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, buswidth));
+	if (err)
+		return err;
+
+	/* trigger DMA writing operation */
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				SPI_NFI_WR_TRIG);
+	if (err)
+		return err;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+			      SPI_NFI_WR_TRIG);
+	if (err)
+		return err;
+
+	udelay(1);
+
+	/* is DMA transfer completed ? */
+	for (i = 0; i < NFI_CHECK_MAX_TIMES; i++) {
+		err = regmap_read(priv->regmap_nfi,
+				  REG_SPI_NFI_INTR, &val);
+		if (err)
+			return err;
+
+		if (val & SPI_NFI_AHB_DONE)
+			break;
+	}
+
+	if (i == NFI_CHECK_MAX_TIMES)
+		return -ETIMEDOUT;
+
+	/* is cache writing finished ? */
+	for (i = 0; i < NFI_CHECK_MAX_TIMES; i++) {
+		err = regmap_read(priv->regmap_nfi,
+				  REG_SPI_NFI_SNF_STA_CTL1, &val);
+		if (err)
+			return err;
+
+		if (val & SPI_NFI_LOAD_TO_CACHE_DONE) {
+			err = regmap_set_bits(priv->regmap_nfi,
+					      REG_SPI_NFI_SNF_STA_CTL1,
+					      SPI_NFI_LOAD_TO_CACHE_DONE);
+			if (err)
+				return err;
+
+			break;
+		}
+	}
+
+	if (i == NFI_CHECK_MAX_TIMES)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int airoha_snand_read_cache_dma(struct airoha_snand_priv *priv,
+				       const struct spi_mem_op *op,
+				       char *dma_aligned_buf)
+{
+	int err;
+	u32 mask, opcode;
+	dma_addr_t addr;
+	enum airoha_snand_nfi_buswidth nfi_buswidth;
+
+	mask = ARCH_DMA_MINALIGN - 1;
+	if (((op->addr.val & mask) != 0) ||
+	    ((op->data.nbytes & mask) != 0) ||
+	    (((uintptr_t)dma_aligned_buf & mask) != 0)) {
+		/* Not properly aligned */
+		return -EOPNOTSUPP;
+	}
+
+	if (op->addr.nbytes != 2) {
+		/*
+		 * flashes like gigadevice GD5F4GQ4RC
+		 * and similar is not supported
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by DMA,
+	 * replace them with supported opcodes. Figure out
+	 * required buswidth.
+	 */
+	switch (op->cmd.opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		opcode = op->cmd.opcode;
+		nfi_buswidth = SPI_NFI_BUSWIDTH_SINGLE;
+		break;
+	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
+		nfi_buswidth = SPI_NFI_BUSWIDTH_DUAL;
+		break;
+	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
+		nfi_buswidth = SPI_NFI_BUSWIDTH_QUAD;
+		break;
+	default:
+		/* unknown opcode */
+		return -EOPNOTSUPP;
+	}
+
+	addr = dma_map_single(dma_aligned_buf, op->data.nbytes,
+			      DMA_FROM_DEVICE);
+
+	err = airoha_snand_dma_on(priv);
+	if (err)
+		return err;
+
+	err = airoha_snand_nfi_read_cache(priv, nfi_buswidth,
+					  opcode, op->addr.val,
+					  op->data.nbytes, addr);
+	if (err)
+		return err;
+
+	err = airoha_snand_dma_off(priv);
+	if (err)
+		return err;
+
+	dma_unmap_single(addr, op->data.nbytes, DMA_FROM_DEVICE);
+
+	return 0;
+}
+
+static int airoha_snand_write_cache_dma(struct airoha_snand_priv *priv,
+					const struct spi_mem_op *op,
+					const char *dma_aligned_buf)
+{
+	u32 mask;
+	int err;
+	dma_addr_t addr;
+	enum airoha_snand_nfi_buswidth nfi_buswidth;
+
+	mask = ARCH_DMA_MINALIGN - 1;
+	if (((op->addr.val & mask) != 0) ||
+	    ((op->data.nbytes & mask) != 0) ||
+	    (((uintptr_t)dma_aligned_buf & mask) != 0)) {
+		/* Not properly aligned */
+		return -EOPNOTSUPP;
+	}
+
+	if (op->addr.nbytes != 2) {
+		/*
+		 * flashes like gigadevice GD5F4GQ4RC
+		 * and similar is not supported
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	switch (op->cmd.opcode) {
+	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
+		nfi_buswidth = SPI_NFI_BUSWIDTH_SINGLE;
+		break;
+	case SPI_NAND_OP_PROGRAM_LOAD_QUAD:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD:
+		nfi_buswidth = SPI_NFI_BUSWIDTH_QUAD;
+		break;
+	default:
+		/* unknown opcode */
+		return -EOPNOTSUPP;
+	}
+
+	addr = dma_map_single((void *)dma_aligned_buf, op->data.nbytes,
+			      DMA_TO_DEVICE);
+
+	err = airoha_snand_dma_on(priv);
+	if (err)
+		return err;
+
+	err = airoha_snand_nfi_prog_cache(priv, nfi_buswidth,
+					  op->cmd.opcode, op->addr.val,
+					  op->data.nbytes, addr);
+	if (err)
+		return err;
+
+	err = airoha_snand_dma_off(priv);
+	if (err)
+		return err;
+
+	dma_unmap_single(addr, op->data.nbytes, DMA_TO_DEVICE);
+
+	return 0;
+}
+
 static bool airoha_snand_supports_op(struct spi_slave *slave,
 				     const struct spi_mem_op *op)
 {
@@ -589,6 +1079,32 @@ static int airoha_snand_exec_op(struct spi_slave *slave,
 
 	priv = dev_get_priv(bus);
 
+	if (priv->dma) {
+		switch (op->cmd.opcode) {
+		case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+		case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+		case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+		case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+			err = airoha_snand_read_cache_dma(priv, op,
+							  op->data.buf.in);
+			break;
+		case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
+		case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
+		case SPI_NAND_OP_PROGRAM_LOAD_QUAD:
+		case SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD:
+			err = airoha_snand_write_cache_dma(priv, op,
+							   op->data.buf.out);
+			break;
+		default:
+			err = -EOPNOTSUPP;
+		}
+
+		if (err != -EOPNOTSUPP)
+			return err;
+	}
+
 	op_len = op->cmd.nbytes;
 	addr_len = op->addr.nbytes;
 	dummy_len = op->dummy.nbytes;
@@ -679,6 +1195,9 @@ static int airoha_snand_probe(struct udevice *dev)
 	}
 	clk_enable(priv->spi_clk);
 
+	// force dma usage
+	priv->dma = 1;
+
 	return airoha_snand_nfi_init(priv);
 }
 
-- 
2.47.2

