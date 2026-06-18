Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F26CD98E4
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 02:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA7AB847C3;
	Thu, 18 Jun 2026 04:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CPcnJtBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 764548495C; Thu, 18 Jun 2026 04:01:59 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94157846B0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAGQxOxAmeHgURSafqxu18HKr/f9DYU3ubLnn3eAh01DTn7pE6V6diiNk2LcBJ3KY+ciaHYZlyqgZ3VfiGldX80qrY3OWTA7WncSRVi4zxGm9I+loobnQSCMmw9ypSExGDRCfBlZabPvrwtGWjaJl2ihcCDEhXVsxZIjGL+v3txIni5bFBT6UH7t/SxpFKaBX16Gin292jX79q/cbSZhvrOGGuCaxZkL/78MkHmVqZTeXGlb26an7hw7aCX+oUXVy540nsWEfyWp6YTvLja0kbAKq7HU7HFdeWgr3L+DJBuKxKIiUnXwtH3zHWZB0OGFq1lQ6gkfNtCEoRU+SJfnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/8MC145zc2cP4otrc/Laru2lrGW1jPJoDwPU9d63jc=;
 b=yHUl64Fe2fHeTxMtaKQZUO2ePlE037k7znuzo/r0C8dpKv1FdeXumvyW/+yGpDN0K17MFP9Z0fkFBqCxn1gYJwZKtyyrc/snko0h2OS/XhT9zOrGDubxWOkOcVLT9L2RmA3pD5Fydrw8aIlv80ztdz5qrCS/fKACJyF/aUlKhxhAb9r+Chzlwi76xATC/u2AZgxubGqTVaI9pGFm49B01qFB2vlYzZzw+zxO3edxh9FFMhaWHnOYWXf5JXMvDuVz6x8yWHgYc3XdVZeKfD1gJS0JFE0H6gyUSTSR3emlGTtByBP/bKR84+nk+hk9RDBKeRWymfUau3MQnVYOs/DkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/8MC145zc2cP4otrc/Laru2lrGW1jPJoDwPU9d63jc=;
 b=CPcnJtBQLoZOeN7KBTbPoKZvSP4Sd1ols5+rBIGS1FhQxZQZsgwjCsqHr4+TmYI1ZNRpCiAMWDzRiNkE5UjLlLWLAY2d2QZqaBfziTZcgieYM83SIwO87PYruHapBcDOZXwBn+LiqVcMVoup4uXxiF+ysNQsX/TfM1eQ4HbzRCB5/G8eoFAG07w6rEP030dbL1e3fkWtPSUxW8p+JVEtnCgTnRoQSOtzfYsyanhdvTNTurmZ6oHp/PNHH+ThjvZ/s5X/mLwN1htSde18x+v/EJy+AETPm/EbucG9Mjvn8s2aFEJfLcGOi5m44rzhjHCNmpCL0uIi9lOoVBtB0TMuhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 02:01:56 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 02:01:56 +0000
Date: Thu, 18 Jun 2026 10:05:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: ye.li@oss.nxp.com
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com
Subject: Re: [PATCH] arm: dts: imx943-evk: Add label for gpio expander devices
Message-ID: <ajNSWC84nO9kX5n5@shlinux89>
References: <20260618011936.2871866-1-ye.li@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618011936.2871866-1-ye.li@oss.nxp.com>
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c301889-18a1-4dd1-a353-08deccdd9306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: irMJRJGb29bMxe0wPRoMSKXV0YFYFKOE2ZjhMDcOWGQgPJRQrIzqRkJ29+Ceu4x3ogjETj69jMo+NXTn1+yXJdAEKrHBYYhzeD3V93dOmU3wsZls2BCbI2rw9u2kSSXPUCMmoF9stMrMgdXtUk/Ek+FiUndynd+Btz1FbAqlAGiJp4iEMf2balFHUpVjy+6CDJNfjXlFF/0z150uODsknFTO8uLF8bh4+Uqk3j7Qvlw3aeqcS1bLtdxhfehKQF7iAFTeii6shSsQqdKiajVEpXKUOqMofseyh+fwQhL0QAKtqWphxcHgNdvr/f5QMfJP41HvB2vFNcE2/osnp9c0GL2Dsj1HxW/fh9eGwgfcLIljFnhNuVCTT+JlnVLdwUslZJw+/ZaVxcd06e2MgebyKmDHBn6VIlgtZ8Vq5mK7/lrqPLbwVzOpeJmHL0wBsxREUPwmuXzH4DvPk1JtFPbBYmmV2fYwcM/mwbx7PFfteIRQHfFc3x2g1961jMlmzJ+51cEZ6/ADop/okEToc9yrd0a6Ycq/HlXSZ0gM150j5IlfKikeg7/B9Xt80F5qNchbtr5fS6zpmiUvuSyqXDPPzN59bsgDj6bCqJC2SBA90dI6aMONZpxL/AOVizgmrVzb2QL9COgQMPU/WF64gOYuJCCHPVuMbGMkESpXcgILgTZvuwyyGpKZg6QL2SwHVKIG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p8jASJ1A4uilardGrnve6JM+SLGIFtqQyPJt/NoK39PQQKUX3amEUkqZaFLk?=
 =?us-ascii?Q?aePmLyCOUPoixvvpnTx+HEKE69WRcXFiXbj9kJSOgCMhW7q6JOmGv6Ne6+Xc?=
 =?us-ascii?Q?I230D7VH9bdWVrIlNxrFWqIrQvn374Vv0UC2+S101Mmkj78jVK44eb665SG7?=
 =?us-ascii?Q?L8YFD8xKva266QLSmCU6Jgkd7B3DRG0ZoMhB629Vvs1m+04CZ42qdz2fVT0k?=
 =?us-ascii?Q?9F8ynwfw1eF7mK3NzO7HPZCricsBMyhYVidpH0n6dDM2u+yNt+/xWRf0EkD4?=
 =?us-ascii?Q?YD3CIKYmvyIVDFjhBvqNiL/kibbLbga5KZVMvV8WQheOMqFadc1SqPbnGjKX?=
 =?us-ascii?Q?eZPUD3oO/nVHqenTX1LpRvXr8HooJOfQBHK85LAxcbGUIlfaF5w5I602wgbs?=
 =?us-ascii?Q?ligeQiMZEzZ6QHUKfZHZGf2pEp++K0bDdVc58t2jdTrqaDsYWR54Woi18yaG?=
 =?us-ascii?Q?cy7P3s1vNKC+a7uZfyRm5dwDpG5TYY+EAFcyRUyWc1mt4Zp42a3rGyFX4tqN?=
 =?us-ascii?Q?pz40SnrerIcWgPVGJhLXn2rMHlA6QGzxdM0jy7DjqDS+2b0/cCzvB0uYRQMC?=
 =?us-ascii?Q?MCjXC6S+n5blOTh9gBfqQX/1V1xc7ueFizn4UlQHRle/nQDH3HqTiTmhEbya?=
 =?us-ascii?Q?i5rHYX05EhJ9qwodQKEe2KDf8y3bKhLfF5v5Jz6nsbqXI4LfBv+0dHLkoH6/?=
 =?us-ascii?Q?pa6Zm0p8R9olcHcz9Rmyj/wS2Nh3MU3tvw4h5uJpK7ZAYpROGyqkQx0a+fU7?=
 =?us-ascii?Q?VA3rDhIrNrcwEBs2UBahgcStSB/frgmhEVW2DSOEebHprz8h/Ojqot+RC1ii?=
 =?us-ascii?Q?SVUSp/ro+DzEqat712B8deez296jRvVD5zKo9+66gip/jbSGr379m9TM5wJd?=
 =?us-ascii?Q?9BmMaRG8YbcruPaYWdKweVSPk3lIHx2E8itlnJRGlFWmvyHBycXApzEM9zvH?=
 =?us-ascii?Q?zF4CAHVOwxxrBTuPDH5z97gsB+uhwKPrRTvcsv2Hfa0PlQodev85IWTsIK7l?=
 =?us-ascii?Q?pOZCTVgE2xV1YfZhi0LAHEJ+ZyrtK0xKF3uFiqUQUrrNe7nqo48BPqGPZuv5?=
 =?us-ascii?Q?lUH/hcx+nHLYqAJKH2l2AQ9VtTwlxClio/Wonw9+BqMM78N/AfrReFCFG/ln?=
 =?us-ascii?Q?TcMkpGyu0sT5Y/yHNeBcuAiqr3aJwHKkLy/QCzWnt6bGiu1u/8EE1TBQOpwC?=
 =?us-ascii?Q?TNw45EaTDStiTtR084YTjGjY/c3j8LaxXLEPpe7W+PnXJqCYB2BK2qfTE4+X?=
 =?us-ascii?Q?1zpEa5kkDvz5Jz8FTXAsx44b/SsX1IiQOqVJ5hv6+9OuW8SnzNvC7gzEuEeZ?=
 =?us-ascii?Q?1teKdbncXdta9Yy8ljIFTqHovEG1343PxC9p9j9gdxwfKWDaDTvHhv1vYroh?=
 =?us-ascii?Q?5PiG8irVOXn4YGC2NXdrQ/MxxIIgIb7zRUb5A3U2iNuADh9YrXCxkDYXQSlr?=
 =?us-ascii?Q?QMmcDh5tAPT/e9mEDb8W35N5kzu2ZssNQMEUC+4945uyFScTY0JUb2G5TXUj?=
 =?us-ascii?Q?Q3FMJ7ip2jLyLqKTtJzmC4dMMnxirlG4vrAxBJr9Srmwsf32xLrT8RWGGuTC?=
 =?us-ascii?Q?btVG2fs5LpE51llPb5C2KTWeVgWi94C480CACAtmqoD3bSWikRNPS3+yhocz?=
 =?us-ascii?Q?bb7C1TZa1rx2t6vPZtpdpzYVIqILBmmeeyIfS3+T5ICEBEWqXQqXOCmPSHQK?=
 =?us-ascii?Q?50hZZTS3S+i2S3VOTgehR3/qe+c5eCw9a/CK1n2pHPfMygJz0YYBuT5qGRp5?=
 =?us-ascii?Q?WqkMcZu5hGRH4U4vLKu4BwI0mzOwpGATvTsbMnBCOFqGiwU8tNoP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c301889-18a1-4dd1-a353-08deccdd9306
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 02:01:56.1537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KitNMGf4Ku9R4vV2gwbE8eLmujdblhFdrMrVbGHoLFRfGAKYutu3xo4//qUWb2pqqWIp7HcO8iuoDVe9pZ/EcwzYVvZ1S0Nx4j9j71u0oY77CeHXtuR6PBx9dlAHYSN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163
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

On Thu, Jun 18, 2026 at 09:19:36AM +0800, ye.li@oss.nxp.com wrote:
>From: Ye Li <ye.li@nxp.com>
>
>Because the i2c address of some gpio expander devices are same, so
>in dts they have same node name which lead to same gpio device name.
>Users can't get the GPIO through GPIO API or GPIO command.
>Add the label to each gpio expander node, hence give unique name.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
