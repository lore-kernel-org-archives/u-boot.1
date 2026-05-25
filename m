Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46707CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD355847EF;
	Mon, 25 May 2026 04:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BfhilUOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 706A484882; Mon, 25 May 2026 04:35:10 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2B5846EB
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEdWXbyubSxeWot//dpPrRApkfyjJQNH5AjU7rgVM6eoCC6HBkEYXD4VnxAtuf0Tar0Np373j4QlhwoMyvhks0axecT22u6I/cT9cDOOCBAjRBmI0Z4f9EYnlyAIbQ3tIHLI05toIdIu6sZZAyMCn/WAxkG+Qb+kwB6p4wF2/4rS3faNhHc+HDfNsepMwh3QgnjGIggRXUQe43jjZU4/GSkP7aWa3ILo1HFCzL6Gzdq0plHLciuvAPEViKM8JC/3B87kzqufawoHdT7O4KVY9fK8bv54NyKbN5rw4e5A9cElmEi+nnhjNTWgO1jd2Dnurug20fIL4rtoaj6mIAd+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e+6/o7EBXNwmENG8H1k29vxR1E9+7/1FUbkEIEF4Ew=;
 b=OmpZZRuiPaAta/ILVuPCLimkzh5VN4PeXFuTDp4ELwgGB02ZaLa69xE2Dmge+1esckTf0mbmEq6pfEAzRLZoXgXuvGWBh1UPjYf+6QUHLrN8rSmH5Ugf8gR9AKZCIl5EPLxXiVauH5fYTU8H5SaPgkFgq55KuFDmTfiN5QBlfWM3S1m/o+Q5zTY7VmIRbKoHhKKL2W7ghAPpweXdntM4V5YOmlA3DxAIxHKQgoH46RoDZfcnjzbezMELPGgswXrWZRM8smKQlpiK1ar+JwU1dq6TdljqlMNvWv2sxmhaI8PdXelov7/sgB3pujAzt0vR7yqkt4Mz04nTEopQnS8Lcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e+6/o7EBXNwmENG8H1k29vxR1E9+7/1FUbkEIEF4Ew=;
 b=BfhilUOpVDr4pRax4Ubnxh+4bVFBetbIBQXjyoYtYbTEb3SulHE383c9Iru74lMEiTGkekkxkD4fOQHxlzDG8m5r1DSXRl8P7OkTPLVwxLq0jdqQNzMvlycGUwOQrQe8mru6okLb8j56HDAfU2ZoL3Tqpu37muliupkC4Q0PeeHwGqhXqXaIEeZl0AKrV09T8OOOmqSMABmoqgwMMfqPGeMTRveAAec0ELSgv+mctUTUBUD7Rb33LpAUYr1QtlPUN6DOyEJQ/1ey17oCn0c+dlZMMhuzrlVXOZprEx8MnYr1Nj5JopIHwc7zDeZueIJSfk75Nly+Ou45bfsh7jwWmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10118.eurprd04.prod.outlook.com (2603:10a6:102:45b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 02:35:07 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:35:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:51:48 +0800
Subject: [PATCH 2/3] watchdog: rti: Use dev_read_addr_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-devfdt-wdog-v1-2-d8142b674ba0@nxp.com>
References: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
In-Reply-To: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
To: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10118:EE_
X-MS-Office365-Filtering-Correlation-Id: ea798928-1cc5-49ea-b132-08deba063bd9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|22082099003|56012099003|18002099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: ItJ51XdmEFsxT8zwyoHrTM1EJUKuPJ/b+QCKsHctqKdYoADbFxHYIY/c8swAbYub8H/JsMsOSnVRg2VuetWGUVeVj/vYRDJvrNkazepqiF4YfqogCSO9UpdFqHHa/OHo9mLyLYOCYTHT+8HGqBcDLPjkVXHr7pLTr/KoX8TmxuOjq6TZ+DGa50PeSnMo/S/DuqMdSU7A1C2/kg1WGdiVlYHJ6jLJlNOHB6835tg6vng78kprA8Uj46mJ8F6IH1MrL1rvWRu8eljjSXcE+1YFSEGuyKYiLd2p3BQYAQTLIaSkXxbwlQRspRQIqfen3S+Gz5c+ZJrnjtaVjmU9NPAaKCsfZ5683FJZUkj77WrAW6DYMBppyP7mAZ0Luq/0NfWiKAxSaRC/VPVDmzcX+UzESRAythyaGAQtNgX/GYPe84l0f29+LJA2wLu1h1xeBJGnpfsyrIKqRiEtjk+EsnO5oAAD7xHp3++mCTbv0u0oujYudzzl22Na8Bq3TCYSzFGLrQ/BhNSIPeT684f53X45S3Dmn+mmsq2Ioq3fIbdrWVs/X2wXZ1YP+NLnROrioiNSTNh2NpZQUoFnvnSv/dE2JwlLPG/UdgWs5IL8Ikuf8pj73JQPogvsDfy40pdbw9FVoZJqxNFCPL4quQhgGXx3i5yIOYXw+KaEBkTKCKLOaEE/YwKkCtV5QEwBnZYfX5SMzFNX0Poc84Twv1HV39rbdHw/kc3q7nLp+xFatx2JkQS+HogadcOJGKizjyQTxlBE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(22082099003)(56012099003)(18002099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVFnT29IUk1ZS29Xd1pvOUtreWkySWVYVTdNdWVYaFNROWdOOUtRb2RiR1JG?=
 =?utf-8?B?L0F0Z3ZNM280eWEwcStQNGpzb2lENDRJbTNIeFpzRllNQXVWbG5oS0xMUGtu?=
 =?utf-8?B?bm4wUFNKVHl6SlZObzRibnpLUkdZV01GZ2w4TUZHZVpaUldjQ1FEclZ6c0tY?=
 =?utf-8?B?dm5BckNuU0h2aG5tQUo2TTQrdy9zYkdoaTF3c29WUTRxOUhuVnExd3hrajJJ?=
 =?utf-8?B?dzAyREg0TVNxaWRnWXJCNUh3U3B0SzZZMklHS3VMNE56WExBWFhHc0o1V0VN?=
 =?utf-8?B?ajdEc3B3b0NBM2E3b2tJTjZYQk5ETjVkMzQ2SUZpbURIQlU1eE9WaFluQ3kv?=
 =?utf-8?B?YkR3TmlWSWs5cEVYaVNjZnUwVzYrMXBHblcxWjdPTFJmOW9PM0dvTk4xR1Br?=
 =?utf-8?B?eERFbU93Q2NKeEtXUXh2UnBOdDVNMU5VRDhjS2tTL29BUnE2N2hZM0pDM0dT?=
 =?utf-8?B?THF4TUpJVWV0TTFVTmc5MkhLQ3Z3cnh2MitTTzBxTE94ZzZpOTdaUFBGZWxZ?=
 =?utf-8?B?L2J4dmZ1UHlVWDhGeXNYRnZpdytpcEZkOHdIWjMyUE9qRFBHdEtCUzRRWDZa?=
 =?utf-8?B?amVMb0dxRmRSRUMzdE9VcG93a0lmTHFNUE4wZEx4NnI4REpUK3I3NkpkQ2pM?=
 =?utf-8?B?RVl6cis1TnRyQnN2TWJNdW1PSUp3SkFHb2paMG83eWN2S2FsRUJGdUc0dnly?=
 =?utf-8?B?OWRSTlZuODlpTFFUZUpITmQwQ0JGZ3NSTldUSmgzUWlrN3Y5VTNORkZIZkhL?=
 =?utf-8?B?UktqblBOZnVSUllaNFdtNDBUYjliYkY5QVdUbVRJWU9LTG82UzA5TXVxTW1p?=
 =?utf-8?B?ZWY2R1g2cDNONzhJZ2tBN1BFSGNkT3hRQWRoRVpXSCtnM3FWM1V0NTJGSWdW?=
 =?utf-8?B?YzlRaU9yWmZDRHczdkVTNEhYalFEa1RwaGxpMjJaSE5WQVc5eFZweUd2RGVS?=
 =?utf-8?B?ZmRxdXlHU1hVb1V6MUsvOXFuNFJuT3pzbFYzblE5T0kwYmkveW45dVVtZE1J?=
 =?utf-8?B?cEdBNjZ6WGo5UDBlc1Zsb3pxSmhNRVNIbHNPQjZPOElYYUljSFpRS2c5amEv?=
 =?utf-8?B?VU4ybEVCb1R1eUZ3c0dmQW92TzhxK2NyRUJPMDc2dHBBcmtiUEVQWUZEdzBi?=
 =?utf-8?B?Y2Z5NVIzdDRYTXRkZ29wdVArZnE3ckYwRFZ4RTNNd01HVHpyVTRrbWJ0WW52?=
 =?utf-8?B?ZlVYYTNoVlM0L2FYSkl1K1VGYjY3cGdaZDlpcjFuanJiVnU0MGdxYm83Z3FL?=
 =?utf-8?B?Qk1PTXd4K1E0a0wxRWkvQkpwalczbFpadW5ybXl0eVIxSkFiTE5Ha2FPSlBR?=
 =?utf-8?B?c1NhV2JyK0p6d1V2aW54aTNleFFETmEvQ1RUOTMxVDI5UVZkd21LOEFvVkRS?=
 =?utf-8?B?UlNkdnNUeWZKQWxwVTY4MDZSR2preUxPTEdQZ2x0MUtRRmh4VWRyZC9Lb3Zy?=
 =?utf-8?B?dVdaOFBEOHkrQWI3UzAxTitGUXV5eXZabHdjNTRkVHptWnN1V3FsUk1wQ3JQ?=
 =?utf-8?B?cDJUZjhPRTk4UEVRY1g5dUVYYVlTN055WGNuWlhIcXVHbWdTMWY4NGxGUzBL?=
 =?utf-8?B?eUdVRTV3K3VQMTAvVDM0bXBNVkM0SXVSNkprbkU1ODMyK2lWMFNpbm5IUlNV?=
 =?utf-8?B?M2J2VGJ5dmdnd1JlQjljS2hZV2sxMDc0dG9HSGRyak5DcHNkclRqYnpBVW1s?=
 =?utf-8?B?OExsc1lybXVUckxOWG5FWmo2Qm04OVVvbW5WR24ySHg4M3hNdW9HZk5kdk1P?=
 =?utf-8?B?QU1ualM5NDVBbUxnTmg0VGhNNlZ0OVc5S0t0Mi9hdkdIamM5TG9ycDBMQmQ4?=
 =?utf-8?B?RFRhWlFmMXBQQ3JQTi9ZYWh1NXJTcmFpNnVvekFWR2R0SlVndVRXS3l5STls?=
 =?utf-8?B?N0ltdWZRbEl6RDNjSGJhUjBiblA2bmZ3Z2tCR0ZrNm1TZTVqd3FZVUhBNzZW?=
 =?utf-8?B?TUl5WG1QcFF0SXlOQ3Vic29SdEFWR3hWMzlPMjJoZWVkUVloSVFldWtaUW9h?=
 =?utf-8?B?NmVENXFRZmdKMlMzek9BZmVpRi9YR3hLTzNscU9wN0puYVl1K0NWREt6eXNX?=
 =?utf-8?B?TXZGVDFkSTNDOENKNi9hUDhtV2QwdjlBakxCVExxOWVZWGxLT0tDOThBM1pa?=
 =?utf-8?B?T3RCaUdpamVmMmtOQU0wU2I5Z3ZwTVVnUG5pNVFocndJWUIyNTY5aGhOTjRE?=
 =?utf-8?B?OFNsYVlPeTZlNHcwaklYMk4vbThmSlhPV2hGb0VFb0R0blF0dFpRVW5vSjV0?=
 =?utf-8?B?S3R5NTlhTnY2aEd5L2hqRUhUcVB6RE9rTVE3VytBUGdXOUJsaUlWbUppVXln?=
 =?utf-8?B?bmVoUkRvZ0FlOTEzM0ttcTlocXVSN1k3M1k0azNYZkxRN3R0ZHJLZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea798928-1cc5-49ea-b132-08deba063bd9
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:35:07.0879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLVTI/vq7tdPRHIpLj7AfJrmhUw1P8teofkpUyhwpBttBGrWD99rw1dBB8M9AHPCOfX/NnmB+mFbdIywfVCJrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10118
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

From: Peng Fan <peng.fan@nxp.com>

devfdt_get_addr() returns FDT_ADDR_T_NONE(-1UL) when fail, using
"!priv->regs" to check return value is wrong.

Replace devfdt_read_addr() with dev_read_addr_ptr() when retrieving the
register base address.

dev_read_addr_ptr() supports both live device tree and flat DT backends,
avoiding direct dependency on devfdt_* helpers.

Also use "void __iomem *" to replace "phys_addr_t" to avoid type
casting.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/watchdog/rti_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 7b387266b99..866f555789c 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -39,7 +39,7 @@
 #define WDT_PRELOAD_MAX		0xfff
 
 struct rti_wdt_priv {
-	phys_addr_t regs;
+	void __iomem *regs;
 	unsigned int clk_hz;
 };
 
@@ -177,7 +177,7 @@ static int rti_wdt_probe(struct udevice *dev)
 	struct clk clk;
 	int ret;
 
-	priv->regs = devfdt_get_addr(dev);
+	priv->regs = dev_read_addr_ptr(dev);
 	if (!priv->regs)
 		return -EINVAL;
 

-- 
2.51.0

