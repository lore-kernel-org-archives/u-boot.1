Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8645ACD6E56
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 10:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 591CA8486B;
	Wed,  3 Jun 2026 12:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qbxT8vDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF9218486A; Wed,  3 Jun 2026 12:48:58 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EEF8056B
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 12:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAgi+YizMmObF1MGDkkJ8/Yj0vy63mEryUoPfguOVShCCap3qBftgBWfLGwNV+D2vjlneaeOOhuDYaKV9VPpK4QiHFuQPVGZK/GDwM9WN+u/MK7U/U1iJ7uvN6ud2IeLQfahJWHD98EOGjkJn2/tmveMfszt2di/9mQ559D5y/kJg0uam0ccrzvd177SAT8Y2SZ/gQGjT7tnucPR38t1V6V355SjHAmYjutqwozn5ShnakZNyaVQ9LwSswX/OmS6Ye+w706OgibeO55AnCXgoZuOkpqBZXvb7D/MzaAj0j1VM0BPFQ6W3BuyOEkT9Q1R2ULTBSNpjCdhppb2tzT84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAFn6Mu5zHprS1Fq3Sp0yZFSbWfPo1F4yxVUWXoWvvI=;
 b=i11eH0MKPIPI8Zu2IdOVesr6IQa32Qxte6PnhyrPXuhCdjXodZE1zdHS5D3Y0TqA6TUy2a8hIgmcY+ZITaxTbnTs6h6iYEJG9i0E5tydhQ7Z03XGnyj+eXpzZgLEVjdjQEa75U5ya/QUTFgYTCrJ6fXwcc7m1H/TXpreJDuxCoAPe9KcgVcHv5hoZMs3ETubi4UdcilNlWAgSjpLBiw+lklJrVaFB6+xyQWH26YKiDreaWXrVyhMbffGiaRRVCClB6TtRStpdgU5QHKX8cCQWeOlfklHhQmq1xQsk0QrUCX988BqctGbPpzCpRabRLdSamdQKD6aO2+IXnTpO69m/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAFn6Mu5zHprS1Fq3Sp0yZFSbWfPo1F4yxVUWXoWvvI=;
 b=qbxT8vDTXu5uIxIWap82hZmVtsFk8kBvKmqFrHFdZ+uQ/tzpYgbG0jJz4fyfnJMh4p1W0r+x0rG4x5UuAa5b80BckLLER7MJsiLa0GU7tSljMvdTtUCVsIdXDmFX3k5MJ5cEkEfPVcQ6p09YVsIwkotm84wkpL5+zGW6H01MSbl6/NVoI+l42j4Mh3YqeJEaUPicbbMG0SwlpN58hMuJhnZsCo/X7TMLnb/3SW+C6ZZH+YEjh2HGMQB2ruL7V9lMh6vWqlIqhhgVkamxj/8IMgMBzgQdrcBf/V4A3Z0oEWRS/HCJCGswGvvHVHdzImuJfeccv6hjatRxvIaoXU8qzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI2PR04MB10267.eurprd04.prod.outlook.com (2603:10a6:800:225::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:48:54 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 10:48:54 +0000
From: alice.guo@oss.nxp.com
Date: Wed, 03 Jun 2026 18:51:50 +0800
Subject: [PATCH v1 1/3] net: fsl_enetc_xpcs_phy: Extract common PMA MMD
 init sequence into helper function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-sgmii-v1-1-c4a0af0d5d3d@nxp.com>
References: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
In-Reply-To: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marex@nabladev.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI2PR04MB10267:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f91642-95ca-4592-7337-08dec15db4d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CREbAuskljacQaeU6z6OgbQnrEW4O0Kt0iTT8yFRFEHrR2B0QwTi3OmnbRe9FVTYR+9wmTsn3Ppgos7ayWitZhoSYoh7SCLFK2bm16TrQLL8sQnhIkLKNrW4ou3zLJ56cUAHVG/XAoRRtIAqYTivE+VB2kYokyxJM5jsqHQFiZMxVy5YmR227aOeCrx152mM9cO88LT4vQ8NsYLB8M2UzYZ0/7ewBWOysdc91MgsPG7XROzyCbuWmn4fpm4CeAklIMPGtrw1KRoT7LVctbYMbY3UxfPSY1eu9EfTDuwtXMjYlI5gXRdePMtvwjyQisdim0lIgqCm6DmRtF4DCofCEJc8ElGgi3TfYX83olN9H1RHIuoWNQokCi8ilp9wlbGm7a+vrOfgTkjCL3S+/EWfmbFCn4waMdjW+BNWEItWWKX3Qp5JAo50wehXYsq3uQC+hGS9Xc7W2LMU8AusOqVDn8AWvD6H+JSx4hE4LWluJQcSwVkUze6UiYPd6YqHAWlOWHQzKyAus0aOKxwUG5kF6mwK4wj+CZelAtgbxu3Osh8HYw9HS5iOYKIpqauBCuxzBicTx+oqEuHNCycXP6oQhz6PDUDGK2HwOD5ncCkizacQw/0/gRply0z0Z1My3sl2XQohIloeO+u5/NeIIEwJ32jQ2Uh8p+PVMdKJjNx68PU6SlMiHsH24av1oSaWoZrBm7eDuSVz8X4R+2xavwhO5UpZJwIXCf6yFzoL5inkrHweZ+HgFFK5KhZG3vlZL4zy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEtMVXJHK1Jpd3FIcWVscmxCbG9waWlmNThkUStoNkRLdUQ2eVhoQ1UrRU43?=
 =?utf-8?B?cVhvanBTY21KelUzYlQ4NjJ5b0dhWWl2bVpSd1BHWGtzZzMzRFNlbmQxRisy?=
 =?utf-8?B?V1VWalA3Q0tNQ2lITXVOS0xoWnpLL0FPM3FwZTh1cGw0OHhwRWlSRUxmNXZu?=
 =?utf-8?B?d3RwUDVKV1dFRDdvd2MvdTdmSkw1Wmo3VGVYRmI0Y3pIQ3F5b2NCWFp6bCtw?=
 =?utf-8?B?TUJMcjlYcFNSdHVrTWhyRXFad1p3Wk43VUFWcnhPU2NxN3BvVEI1dFRhRkFM?=
 =?utf-8?B?WFI5MXduSDVhQVBPWHMyQkZLZEl3RjhBaGV5bXZSNU12Zkt5ZkFYNXlMend2?=
 =?utf-8?B?OURwbGVhRW5VaEs0b0NaWmFsQ3Q0c3J5TWU0OFVCdkZXdk4vcEx4SFdpL2RB?=
 =?utf-8?B?bDVSQ2ZnMDR2QTlNbUF5ZzEzUnZva2NjRUpQNEJCNTRZZUxVa2dCb2JORGQx?=
 =?utf-8?B?NkVOVmJUdHBTcW9vVTJ1QmlpVHNvK0RaMVpJYlJaRGJCUi9saUQ5M3J5Ym9z?=
 =?utf-8?B?aGhjWll2T0FSd0VpeXlOREUvVXhmRXFLN1VUMC9lSWlsU0gyKzhxWDlwV1N6?=
 =?utf-8?B?Mm9iajFuU0ZXSGh5Sng3ZGxOTFhyL3dlM2xScmwwOEhrbkttMVJqMElxQlZP?=
 =?utf-8?B?MWR6bEI3cGpzNndrSlVZNXIrSk9IaGRQall2NURYbjFXaEJVSE5ZT0dvREFa?=
 =?utf-8?B?NE9od2dieU5pSGwwQWxHaU9nNzREYlNTSDNkK1c1TWVGNmpBMUxHdEhBOUlT?=
 =?utf-8?B?ZEpLMHZhR2tCVVBSdC8xVlpwRUNOVlkrVDRHMmdqcWkzdGpWdWREU082K3Jq?=
 =?utf-8?B?Z3ZWTlpYWFFSMjVjc1BZRU5sVjU3b2NETGlXdUwxNmVvQUVPc1V3d1lZU0lz?=
 =?utf-8?B?Qmd1cDZyUjhZQUdXUVN0ZU9ZQVE4NXZMVk5aRUJGUmlFY1lpUGtXU1kyeUov?=
 =?utf-8?B?NjZKZ3JibnJKQTNlajg2QitRY254U3RMdGhwVVBUSzB2WmNFOFN3VWc5TDFk?=
 =?utf-8?B?WER1Ymd2UG4yNmgvdCtwWGdra0Y1MGNkMUhGOEpuamV4K01CVEpoay81S1kz?=
 =?utf-8?B?KzFBd25DdmlZN3ZmVVR5aDJKSElLdXNqZ014TUNMdGIyZ0lSK00yMUNFZ3h1?=
 =?utf-8?B?UGx0NXEzbkZxekk3NFlGdVpHYVBORGYxZ0RpNUdqOW5pRTR5OWZwQmxOdXZk?=
 =?utf-8?B?d3d4b1Z6dHNqWmR2aUthMmZLTzkyRzdvMGpvTmlaaFZmb1hsWUQzMVRPN0Z6?=
 =?utf-8?B?KzIzY1A5d0JOMzFGVXNCWEl5VGE5emJzc2tPRlNOclV3bEZmQzFQSVJ6TGN0?=
 =?utf-8?B?NDlUWm5tV0poM2swK0RiMzRvUWJnRnM2cmFYdlB5ZHIrU091UnI3RjR4RThr?=
 =?utf-8?B?Tm82a0ZSMW54d04rWVVPWnB1YlIvU2JWdXA0OGt1WHU2dlMyNTh3UStvYTZv?=
 =?utf-8?B?ekFOU3VaRHpvUDM0OCtsTVo1NWUyZ2tja2h0SU53MWxlTEVkc1JNTFhIWVRj?=
 =?utf-8?B?blQyMFdLVmN2V1FDM0dud2hVSkFKUkU5Z0tYNnVuMlUrSkdIRVgzOHlLZm1q?=
 =?utf-8?B?b0V5M0xqUDRzRU5kTnJhSkZ1YjM0cjFqM1d1QUc0aWtnaFZZak9aU3V2K01H?=
 =?utf-8?B?WjlHZy83emtFRTV4dm9ldUJ6U2o0S0wrY2F6OVpYRFFsSktZVUVnSy9nNkd2?=
 =?utf-8?B?a0gvOW9PYUZrZGtqMmJBS0gzOGFBK3NrVEtXdzViUHRwQkZHK1RxYmQvaENR?=
 =?utf-8?B?Z0Q1bitML2hzT3hhb0ZNa3N4VUptZnFSR0RTQXZWbGJzWlRld2p1UDh4R0JY?=
 =?utf-8?B?ZXgvclFWUUlOYTVQdVlCdnpRY2ROQ09pQkN1UE54UDRwNThuVmZQOSs4Y3Er?=
 =?utf-8?B?RXA4ZzJnRmxZYUNoTDRJN2dkaXJCMDU5Y2wzbEtzNDZCazJtdEhXQU1LM2xZ?=
 =?utf-8?B?UEV2QlB2RFNmTjZjcFFnS3Q0TUpkRWF6QzdlWXI3MVFibUpncUVRczJDbUZS?=
 =?utf-8?B?eDVKemNQSXh2dVl0d3hob0ZtcnBIeWdSYzB6UURYRStpUjk0a0tZbTFTaCt0?=
 =?utf-8?B?ZUV0MkI4OHdLZWJmTU1BRDBycDk5OThFYzRpd28yV2EwLzcyai9WM3hvOG1k?=
 =?utf-8?B?OWcwWXVCN1R6QmZ5OTM5MnVHZlduQmNjYXZTZzQybUZXeUlxcWd4YXRrYWI2?=
 =?utf-8?B?MXh5RW5JSmh3ZjVzOWQ3bjNXdWlJRkxxMmZYNlBsVnR3RHVaV2ZVTlNuYm5h?=
 =?utf-8?B?bEk5dzgyUFhrWGh3YnhYU1hOa2M4S3czQjA1MmRrd1NaSzRpZThpNjBUeDk0?=
 =?utf-8?B?RTA1a0ZFUDNrWVZhUngyQ0dRRGxZZXQ0M0plcUk0TU56cUVEVTJGQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f91642-95ca-4592-7337-08dec15db4d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:48:54.4210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpX05QCXO8a2uoDaBQ1lSkx//kMOnT1Luqxwe65UOlZ7EUHHoyZd9D59wHmJiGCbfZkRWrfKL5qDQowwZ/23Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10267
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

From: Alice Guo <alice.guo@nxp.com>

Extract steps 1.6-1.13 of PMA MMD initialization from
xpcs_phy_usxgmii_pma_config() into xpcs_phy_common_init_seq_1_pma() to
improve code reusability.

No functional changes.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_xpcs_phy.c | 181 +++++++++++++++++++++------------------
 1 file changed, 99 insertions(+), 82 deletions(-)

diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 4039690223d..9c1ee752a66 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -261,6 +261,100 @@ int xpcs_phy_write_pma(struct udevice *dev, int reg, u16 val)
 	return xpcs_write(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg), val);
 }
 
+static int xpcs_phy_common_init_seq_1_pma(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* 1.6 Turn off C37 auto-negotiation */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_AN_ENABLE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	/* 1.7 Assert tx_reset and rx_reset */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.8 Wait for more than 1us */
+	udelay(5);
+
+	/* 1.9 Deassert tx_reset and rx_reset */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.10 Power down MPLL */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	/* 1.11 Change RX0 power state to P2 */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	/* TODO: check if it is needed */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	/* 1.12 Assert request of transmit and receive */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	/* 1.13 Poll for acknlowledge */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
 int xpcs_phy_usxgmii_init_seq_2(struct udevice *dev)
 {
 	ulong begin;
@@ -436,93 +530,16 @@ timeout:
 
 int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
 {
+	int ret;
 	ulong begin;
 	u16 val;
 
 	xpcs_phy_reg_lock(dev);
 
-	/* 1.6 Turn off C37 auto-negotiation */
-	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
-	val &= ~MII_CTRL_AN_ENABLE;
-	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
-
-	/* 1.7 Assert tx_reset and rx_reset*/
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val |= PMA_TX_GENCTRL0_TX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
-	val |= PMA_RX_GENCTRL1_RX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
-
-	/* 1.8 Wait for more than 1us */
-	udelay(5);
-
-	/* 1.9 Deassert tx_reset and rx_reset*/
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
-	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
-
-	/* 1.10 Power down MPLLA */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
-	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	/* 1.11 Change RX0 power state to P2 */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
-	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
-
-	/* TODO: check if it is needed */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
-
-	/* 1.12 Assert request of transmit and receive */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
-	val |= PMA_TX_GENCTRL2_TX_REQ_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
-	val |= PMA_RX_GENCTRL2_RX_REQ_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
-
-	/* 1.13 Poll for acknlowledge */
-	begin = get_timer(0);
-	do {
-		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
-		if (get_timer(begin) > 500) {
-			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
-			goto timeout;
-		}
-		mdelay(10);
-	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
-
-	begin = get_timer(0);
-	do {
-		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
-		if (get_timer(begin) > 500) {
-			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
-			goto timeout;
-		}
-		mdelay(10);
-	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+	/* seq 1: reset, power down MPLL, assert REQ (USXGMII: AN disabled) */
+	ret = xpcs_phy_common_init_seq_1_pma(dev);
+	if (ret)
+		goto timeout;
 
 	/* 2 Config MPLL for 10G XGMII */
 	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);

-- 
2.34.1

