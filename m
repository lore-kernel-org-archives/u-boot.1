Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377D5D41C17
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D4983DEC;
	Thu, 11 Dec 2025 11:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UtAcO+wu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B618839DE; Thu, 11 Dec 2025 10:10:41 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57446835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd/kpFtaiIOs826tFR9fA8Jth/WNYZXbb5o4K7Gm90hZefi+z4lqiv5zbMu6Y+i1z/PJpM4EszWlsBcss/I3l4I7P/CHvy3sakqTOpHqIm1DyL9CgjZGL+K8gS1NgsATDfUW4WyxWQ1CDzfK0LDSKNMOcRyGCeupYsspjjmAh6vMNPtKcRU8iNuooZ0mSa/zP/if1Vg9eYU6eesJtV1wFTl+CMFuFxkgh70OpBAEFpJcEcEOlgwFrw681m5OA60pGMTTa7/iznyqvDAKqYQwbXOzSQ9ACH+D1QnZto6KdeFsuFWGsq7yrMFhozxzoDf3GkNIZf7m7Y+9RXtC53fIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILmIQdJz9BE+ri6RNPOdH5lVmjvGGe0akMaADlGBfbE=;
 b=j83/W7utspBFcyh8eA8ibxjx8Vn1V7UqZt7+3b5eC7rOyaT6MG9vXopvF0yAjR3A3otIzqbxykhtP9jbChfOCTanG5P6u32JnCAZQMdsa8XWID6/W0YelJ3YJeuiv+R8Z3q49j4oJmbtvcWEdRdbQXuk69JfD/wLv7/hBclhadyrg0CH0No1yLTAP9GTj2r+pnanZEosN7hZEQEkGaKF5e9miI+W1xP6xGgr0aa58BDSMnYyhWD3xcynbE9T5Ih5zAooppKL6AxshiQVU4e2WlBpihu4NzKA3zyv514N3B2Zm6D3vBH59VJ1C9laKyBtlQzalLqUCGrc9tCqVJFI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILmIQdJz9BE+ri6RNPOdH5lVmjvGGe0akMaADlGBfbE=;
 b=UtAcO+wurlwCS9GLrG2yJj5q8R5RAmjDFcl4GbaJAT7ldVN9dyntGltBm4n31bkBJmaxGRWKCQ3bE9rXHUZ6aVgSevxEP3vFcVqS+dc6jkQgtjVL+jCO6HD1FhCSyN9yBBgO5rShwmbNEEgKA0hSS2vMOFORCKHmpkGiVYwoGkN1rW8ded15BcfMgb6GN5l0NqNq8SF7cR7oT2alYNAqS+7WOtjEEA22Yd9JmLY2afU6BMLd0COFfEBpJ7USqqqP58y0cfaHugF/XYS/rdcjBJ7bdK80MyhAyaZmSAJG5iCZkZPDdkd3pJzBfsUO/zT2nbZQS5LtehvKFa/zgCQ7Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 09:10:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 09:10:37 +0000
Date: Thu, 11 Dec 2025 18:24:09 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH v2 6/9] mmc: sdhci-cadence: Use hardware version field
 for Cadence SDHCI controller
Message-ID: <aTqbyRbICOoti2GC@nxa18884-linux.ap.freescale.net>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
 <9234bbbac9c03069e8f61178d93dee9f04a8c395.1764760325.git.tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9234bbbac9c03069e8f61178d93dee9f04a8c395.1764760325.git.tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ad1c46-6344-493a-48d5-08de389525ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8KmouH7kHuzMRYHu9FXorO72EAMrNnZq/7F9eigBkOmWmlubhM1q5Gb2pj/x?=
 =?us-ascii?Q?fbHR91BVPnDZgLzhnNzOH415eIbJFVp9OrkZuqHrG8cCPbMyZhaYCHlQtYMJ?=
 =?us-ascii?Q?p8JRb/ZTZ+utXe/1zdX/UJvNnAoVsMoMML2Q9XECiq7AJ8gPJrRxK8azPRMo?=
 =?us-ascii?Q?/Jww9YZ9UW5qhHnJxCE2ivw6y+HFZWnzsyN4R8Ad0qmMJQJyyR4YW4pQyFMJ?=
 =?us-ascii?Q?m9DGrEe44J2jo5MmYW1mgMQrVgh/suIfFN/K38vyy8X+yj9Hn0MPSNfgoAlz?=
 =?us-ascii?Q?IUaPcVrBAQnI+yjEQqyR8uxqUBeQoco1Ew/KVEp3th0TbbsyCSub+BWq6h0B?=
 =?us-ascii?Q?tGFWaSU/Q71cAtyvTsILaYdGpwldga9bqcIjlBHBskFDJpO89274AQvTO5UC?=
 =?us-ascii?Q?Du0ykkMc7XBusBJjGT+2RZ/ebUO0vOCW/dCseG5lu/TYjutDHIJKqdl820Ma?=
 =?us-ascii?Q?Ja9ZYmWUjmO1moiirU/8/5RpOXVPDMEngfinLDlaYC8WA+lYpQwaJwwDMRkg?=
 =?us-ascii?Q?5NRM9e/hUELHG7IArgqwhiEOndGxmHsipJ1oKzuDWYiPDOHaxQWD93sxjv0r?=
 =?us-ascii?Q?c+9UCKMcMVYq+46/Hq0BwpXcHVQWR3fV3oZeaOz5z0XNlt/5s0UI+74WaZPv?=
 =?us-ascii?Q?7vuOz+m6pEoj2uGdHIZ723TwFP+jduBhnZuA5H8QTmODLo2kwIGuxPuQ3HbI?=
 =?us-ascii?Q?sqS47G5F1F0ybBbR6YA+QhkVNzNMMH7y3D2ajJElkbM//C2o1DHPym2JPKte?=
 =?us-ascii?Q?TzCaoP12kk8OpN7MHmOcc2G2iZ9jRHVntZD8W6pQvsBZozexK3R0QMEdVf72?=
 =?us-ascii?Q?8NtXnSLlTA3lwxIQFmh33FvE/0yarO5PuUCa99sb8fsMvJ8jdGsNaoncBQeH?=
 =?us-ascii?Q?7jdT3240hPOojPmQ+/rV3vQ8TwR7FefQ5RJroYYBhB8vBwdzrgrlUKlSfL+g?=
 =?us-ascii?Q?B0D9Dahnm9JcY7peLryjDYLkFEzm+0gji2WMsxKVgMaDYbbEoh/4h94cfWN7?=
 =?us-ascii?Q?IcnJ5wtFvdB7qqEh5y4L2N+ZxuFVNO7hrnDNVSOQ+FJfLzRZ0hM8ySDf+T+K?=
 =?us-ascii?Q?jJC3e/5J/Mb8tC2K7UvmoFZlz0IWBNP75GVkDBY1x4065IYN4lfBPXOnuSw/?=
 =?us-ascii?Q?pCpBqrtn5TTx+B8y8484sm61xESM5cc7+LXxTuSRuEThmg78A6m9ZR0Is054?=
 =?us-ascii?Q?suNajs32JmRAqXMex8GCyVrWxTt7VEMx2CnNPWkxwzYqX+KwAUUdkrTyFiAt?=
 =?us-ascii?Q?5Tt4CK9bb64zzTA2/ieJ1Rnzcu6rcxSafH5RuR8aysGp65osfy6Oozn7LeWh?=
 =?us-ascii?Q?+7qyymaF2bkj80V3BDAJneplAqZdH54pVM7znVXXvQo4Pi1upZrNm1r7vXqI?=
 =?us-ascii?Q?qBQR6r0k0bzYIuyRLvIStIY3DElASnI2eJ9fTv0lpf0FhidzIuslneo7sUOa?=
 =?us-ascii?Q?iF22CtdmksR39P1eR4zoQBpyxHva9OdVTzVjG5xC4pOjgmfKGyyceqqIBIET?=
 =?us-ascii?Q?JFwDY7eoNzlb7k3yfzQWV1OcrzfPeVm6v21R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HvskTe3OPxnVTfymRF3YGoqZPbzlcydDn24NrCwXtI9iqZ07jgQWkfYucTaw?=
 =?us-ascii?Q?GqJI/FY8jNP1AQ1dCSXIMADvBoOkPv1lPclWQjg3JEbrL2p8AEmRCLzkXYJq?=
 =?us-ascii?Q?yFvcxa1c8Zuj7+eK915lGPb3FhrcbFLsS3KEKWmVcDZ5ggk+MtGnEbjq7ATR?=
 =?us-ascii?Q?Je0cCFPIZEB47yfxtMYzW2gzvKBSXUh9kWObDqFfEDhdHSksPfSY24jXiClK?=
 =?us-ascii?Q?BF4heMm2IqbUW2O5dM23v7NzfdgO8uziyQRndpyCmhR9sHSxZBemFcWGZ55b?=
 =?us-ascii?Q?FTiJ5hyVDp+sqcEqhGL+1V/1OMp2lRPQynJvimhirZCBbgY3Wr0NcHgki6QP?=
 =?us-ascii?Q?fHdne2YaLUoqSBA5xhnTp5OQQVr90pc7NRv1xzAwk0jLa9Av1CJnQRvLAdpp?=
 =?us-ascii?Q?bXzotktN5oJJKEZdzzQw3bFSowF2BvcJnXAD24Zwyu9Cqu7z3Iej3aeNIW7k?=
 =?us-ascii?Q?mg3l6DSXmmHyrD/KlgwG09S1Dhimlko8qrkoSYnk0z2Do0BT17XDVl6tl/ix?=
 =?us-ascii?Q?1k/UXV0tbkuhh24asZ2ANfpC8vXR53MCQAnXbV6jkTi+ce3oRnV8GNF9qC1H?=
 =?us-ascii?Q?frXqH8WckG1S2tEYmgBAgTnRYHmpxpZhCQ6+pPGcX2LlfQ7d6ufXY0r6AG9F?=
 =?us-ascii?Q?BZ3TNpkhA8IUAea8LX4DFUWLnYxZXowqEIP1oCJxZyj6KF5yvvsCn3BpFXfu?=
 =?us-ascii?Q?S7pYpMEokU0cpWtWrTvyG+AZUuibALotwAIuaVNCD0jEUzpYDgzP+MSs2Zp3?=
 =?us-ascii?Q?8gh7pv9rfNDGOzE92uNZCLWn3YZdsOLzvcnhT1Ue2Csz4jnyM7a8eSeLaci2?=
 =?us-ascii?Q?ofddM54GRi+o/ytPbjDcv5q6KbrMm46oxAAMeUcoK2msvyoZIxEp7N/w9HSN?=
 =?us-ascii?Q?DktWc4k17xAG//I5ZLy8lCi60Fd/xNXj8YSy/T0qqSLCg5Db2vjU0RMoQpQa?=
 =?us-ascii?Q?hMP2K9W/9jaScg74qrvYbxdZNdbkfwcRbBGOe2h2a11hkqmgt60Rap07FfLG?=
 =?us-ascii?Q?qafYNYAQmm0HV5BKFh7/gaWBV2RGJTV644YXd76GhuGgwNzGobv8hbj0NF0C?=
 =?us-ascii?Q?3v7Oyqw11oEVjeG2Lv0WjucN3oJigMZESPmlqEU8pCvbBdPA7CLx9kuJJwCk?=
 =?us-ascii?Q?eJrD0zmXOOlMk9u/lQ+sAGJahsbbr7SYawFRt5N+mHbeZ4u+Cgpq3B/XTAn9?=
 =?us-ascii?Q?lA80Wob0W7pkr7EyfuyTV+pHcIpJcYgY7Q6WXdLYBGp74pR0bIOx+Cs0hQTH?=
 =?us-ascii?Q?EzPoo/S/na8hHvboF/zzNzqNUQW0yCHgmCZgByMmYBeOSRFgeA84XSmIGtxd?=
 =?us-ascii?Q?oyjVJUtAkwNHaJZjY9tGqhwc/YjL4Wj4gzOdPsmZKzCS8V0ouqYU0HzDgqtH?=
 =?us-ascii?Q?2XM3crJw3sZmZM07NP5yrX8yDByxygaotXAQiKMf9FLJXwtM9Orw9HSXQrKV?=
 =?us-ascii?Q?yP2btof/BdmX9o4UzH46ufzBo8I0kg3YDKOsl/qYiSBEXpPcaLrBIFjUhcxE?=
 =?us-ascii?Q?jboKEwHJNIbYXvWCiRgzpaZtS/hrEjPUdrx+6psvG0t8BU3XDUNuv9MmJxPV?=
 =?us-ascii?Q?y2BKKZhlcm7t2/X9td9AJCq6DqF1Ygb603J0cLEp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ad1c46-6344-493a-48d5-08de389525ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:10:37.2569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/6876FL6q7Hel3YRWVrjphdzgR6LqZa+JYLjNTUVylbJIsqCJwAY4mR9DDZ6E4Me8+8A8fdHk3ZRG59DG6jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

On Wed, Dec 03, 2025 at 04:21:36AM -0800, Tanmay Kathpalia wrote:
>Replace device tree compatible string checks with hardware version field
>detection to determine SDHCI controller capabilities. This approach is
>more robust and aligns with standard SDHCI specification practices.
>Controllers with SDHCI version 4.2 and above will automatically use the
>enhanced PHY adjustment, and tuning v6-specific procedures.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
