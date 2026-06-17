Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81095CD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50BE84949;
	Wed, 17 Jun 2026 09:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GFusaa6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4208803F0; Wed, 17 Jun 2026 09:06:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 990C984971
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQd2xuZYqIGkMtkHDMF92x2vawiBl1/j7yYiFKy9UQgJBp/+oPTDLsfUCxi/PfnkiF3rXXY/5kDR+3HYarL9DAwSm3+em8mwL0n/YVTdvrhf8bF2z7T9SjPmBrpNxP35+bqLn0smG0s/1V0gFqkd6QrPzRcoaj65r/BUukOHxQk0GWVzZhfMdcvG3zY+S/44Oaz67FaeXIzIx6M4czhIJNnmdfwz0BfwJJ+vUdV7E9rfWijyEfc7DK33nhpfNb3OqUdQevj22kh0Dr7Bn058NcLRbLhXMD8QpoETOzJQTz0zmqKHIGZw5h5HvsdXL7mH5f7mbzaJndeYtJstHRJuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hny4iH35S6H3L/nAOr0FtbO6YStOXIEjumlaGZMBQ1A=;
 b=RIiiSzgwui84+hKIFD65D2KGUG9arBc/zBttouvmeIiuMjfYIq9J8i+m3JrRhSSJZLBJl4Z8Iaj/hY/3kz35VgHn/PiC/eDEl85oqpJnDYYoJuES9kfi2n/xwaaxgBp7uyn/KEePXia8ix4j7kg1Dwd791q8PJKVXfYJK6C0Qa9QAQrWSPm3l7Yccp3OMuKdywR6aETJiozoVFsvOCpOwh11GnI/2KzTRSh1+3/h1EQQ4YrqcRt8+pUhBAgJtivrOOWAitRCTCmaQ5su1lzcANO4xGw/mfkMAg3gzKQrDnswF1xG+HMf9ddo78fk0nx21Ki8ddwu7CDXWeDosM6ieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hny4iH35S6H3L/nAOr0FtbO6YStOXIEjumlaGZMBQ1A=;
 b=GFusaa6J/0MAg7tTOIVTEOJVG427bb4MxgpyC/C85ZwyObImz5/VO1vFCgkRMD0SCjEQKOs1M6r3w2GBYH8LHQibAlLGOYGl+Ytjl7KxXU0OIrL/CudqsyEfrfkYca1WVkNk1NVhZUCzJ4rWz6Ea52fmxfvyXU0yqXKa46SZQjxT5/sC6utdiXSVRLvtrlozj+CV9dU00uYcZfZfJmlR4d0qHfnC0+RxkH78d5R5BPA3IGNfAhmpBfXpOFXRlQyQqWj8zPTuNtEFGibBjFGz+j57eiGIjehT+ZBAx2IC3wxrELoRUtGTz3zO/ZfKdo91l/kObluXkyibL4FlcfFjvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:06:50 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:06:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:06 +0800
Subject: [PATCH 07/11] usb: tcpm: skip state machine for pd-disable ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-7-b824fe1e9299@nxp.com>
References: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
In-Reply-To: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c1a1ef-3906-45fe-4c06-08decc3f0082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: f1C7W4cdk+/f83YUiodDKF2qvLnl88MWJDY03TY6D1Ww8Wz/B48DaS1uvWN7HuCljy0rNWrnJd83c+6nXfZd+aySuOnaSqY3GDuiHiP8lYk+6lCsbUuw7bQCsRrKDw0KCBcXo/NE8NqeXJ3Yije3BjLeXM5Jvk6XdEEOR9qkSAU0ytNKu9P8rjO+mAn04THXQxnAxFGxjF+JZXKldcgJJZAyiVNknIEWN0CNgHi3X2nVvH0HtdsH3H143hE2KPqixSukmfMU4w3XvP4zUlv/nX8pgdRnCd142t0LAzsA+72mgw8pX6i9DbSKtO7JEcNjhTzqLE+O1Z4zOHCq7r1b1zmKPuRHx6hPcD+vPxFqQkaEZ7JU4D+Mv2hcG4SPqoyYrKmzmkbms4m2i7NIIWPDBq8DDq9jyVD5KmIXAV+pSXyD5bi2qLxQmzs0m45GE/AraotxkPINk5TXhdht8LxO28xv4mMVry4M4Dfl1qzJJqJ6AVa4/8IHi54QATKxvlJKlk81lCriiwjjZFpQAjNl1UfswufQ2MmamnMHFvOw4FrGK6bqUhIBhQ95PHXSh7zkdxiA3TnDz2xg2L0rw7Dyx1s59ZpLBCIpEvUG+U2qiu/7LJQVvVTFHF7URFesAI9MnBw1iYk+/j0Er7vWQ5zXv7AVKAFqlhFiY356xaT/jX01RYltqkey5GytmjOpLbLM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0t0OGFlV0l1RC8vd3RmQTRxNmhTengwRkg0bEFhOS9YRER3cFNFTWhZOVhW?=
 =?utf-8?B?OXpadWpCWCtiTDJiMXo1UUxOKzA5Q3FKOEU1U2l6MWVRbFpZNjJLZ3NNOHdy?=
 =?utf-8?B?eUVZN1Nib0FUUm9SZVJYZ3NvWHJVWnQwWTVnWGFYdSs0b3ZJM2FOSTRPSTVI?=
 =?utf-8?B?TGNSU29CQ2MvTjJVTFdMNjdldkc3emJjNXViZUgyMHpKNS9XeFpZZytDejJC?=
 =?utf-8?B?Wlc0WTdrclpFalgwM2lsTkxYemtrSFA0SkNxbzRVd1U0SmpJK3N3cEFiSDJh?=
 =?utf-8?B?WXRLM0ZnaHUxUWJ2MGx6ZnR1dnpvend6QWZ2MVRza0ZQS1lZNmhTT1VKcXdJ?=
 =?utf-8?B?NDNHKzNMMGFYMnFXMUYvREphRzVEVitQWEphckxEakNlaEJRSlllOUNhUWpI?=
 =?utf-8?B?UEtpdXBhTk5hUkpiVjhxQ2xmcTdvTzNUdG9GdGlNKzdvenFxMlFSU3RyanlO?=
 =?utf-8?B?V1JwTGt5VzM1d3hSRFRmQjUySjVsUlBsUHdnWTNBZTJtekR5Z0VEYjhSZUZJ?=
 =?utf-8?B?YzJqeGxZajBlcmRaUS9MWHAzd0trRVJaZ3dVeUNVTWJGUTQ2UU45UU1MRG1D?=
 =?utf-8?B?ZW4yQWNvUWxHTVR5aW5lV2JZcWF3YXhZY3ArUGhaRGhuVjE2R2tmMXAybDdQ?=
 =?utf-8?B?ZjRmSmwzSXgvNGVnVHJvSm5wMWFHNzNYQlBLMnFaS2FNQWZSb0NXUzVFRXBO?=
 =?utf-8?B?RkcwUHpIakNSTGlXYk5LK3FuSGFpK0FxVzMvMHZ0V3VtQ3ovSXdiaW9VS3ZR?=
 =?utf-8?B?dndTM1RaZGNTaTZaazhncFpHZ3d6dGNGT3MzOWRvUnhLNFdFNHY3em5ZNzBm?=
 =?utf-8?B?UytkR0RjNHZwZm5ITmlFb21XdkRnVUF2SElZSnNHZ2hGZi92VWExWXpvOTZO?=
 =?utf-8?B?c2dlVkthdFBWTGtNT1BRN0t1SWV0M0RDVElMdHh6SGhLK1JtZ2NaallVS0lO?=
 =?utf-8?B?QUNaYlBSVGdmR2c5RVQ4V1JhZ1ltaVpWcHVqWWNUTEdvZUU1Z2tpTHVVTTEr?=
 =?utf-8?B?YWdKYTJVaVgzY1J2K2UzdkVPR0dFUG9mY3M0QVk0OUQzdGJYMCtlaEp3SVBL?=
 =?utf-8?B?amRvNUtNNEppcGxwZjQwN2UwMFV2TlFDS1BLTlJJa0lvSmNVVHBwOGtxUW9C?=
 =?utf-8?B?cWRmeDcyMHhXUUdxZmZKaEU2eWpuVTdYQ3pGYUE5bEkwOHdRdW1Vb3lLOUNw?=
 =?utf-8?B?ay93bERhTHloUHpxSU9KK1hPQWNiajNwcVZFTURSZzJsTEhMMjZ0Ukh3S3dB?=
 =?utf-8?B?UzF5Qnp4UFcxRmhjOHR4dVdpaVk4ekhRRm5vdHh0OVkzSWR1UmRteFNQZU9o?=
 =?utf-8?B?V05LRFMrTHlJMDV2ZVNRY3lwSmVYTEN0Wm5jNWpPdHYzYnVZaEhFdGN4Um5x?=
 =?utf-8?B?bHpWN3NZcTc2bENxVUQ3Q1pvY2VjbFFLVXNGWkJWdTNXaG1hOWVXTUxWd0NW?=
 =?utf-8?B?aURCdVg3dnVVbHlhOEVUK2UrTmtQeTY5ZnhZQjNOUmgwWW16V0F1dDNERGgr?=
 =?utf-8?B?NkRzc3BnZXA4U2k5TWJlTWNscXVPQ3hTcDd1c0pNaEt3VTFNVk5yREl0NEhC?=
 =?utf-8?B?aVp2aFoyZ1hiMmx2MGNoUGdVSE5Ld05EVmpObmhPdW1VNHJmSG1MUjhyR1N0?=
 =?utf-8?B?SmhES0ZXWWNkN1pDZ1o0Wk9GSEVQUnNsV2YvYzlxKzUydnhtMW1aTFgxVGtQ?=
 =?utf-8?B?OWtJOTFjYzg3cXdZTTZHODNCelpGUW5EbzR5c1VTdDRYTGFDcWZaV29LWlVB?=
 =?utf-8?B?dXYwSmI5enUyclBxM0FrSVIxRHNpNGd6WklFOHF1SkZIVjdqMW82eXFTaTZN?=
 =?utf-8?B?MWkwcWowSThrM0x5SHBRbnRIQndwKzYwRDkwS2JBUHF1ZGZWS1pIRGJHdC8x?=
 =?utf-8?B?M3FpVHE2NDBBKzRET29zQmE3dUJ3OFAvUFo4aE5ocmVPOUZvUnR2UENGTkRy?=
 =?utf-8?B?NVNsV0RYMjR5a2xpUko4V3ZSaGxFaEppUlJRUTZFeFUwTGlsbXoxeE5MN3dN?=
 =?utf-8?B?Ynk2YThGVVl3OVdGeHZUTEdobUNzbGFGVkZlNGdXdzAwY3hDbU1qdFVkZU5N?=
 =?utf-8?B?VytVMlhBWkRkenVMcWpORm53SkU5UnMyMlA3MEZ4M3E2bU5nVFZsanBHamJh?=
 =?utf-8?B?VVV3cjlRMXJtdU92SFNUQ3FaSTB0K3AwbEJzVk15TlMzYXJVSTJwNmJNTVhj?=
 =?utf-8?B?WnZkbU1Gc3JOV3hhZFpONllmbC9USkdLVkg1ejF4bXJsTlk0QlVVLzNlSW9m?=
 =?utf-8?B?Y2VwL1J4RDFLdU1ERUR2RGMrQXB3eFlwVmtaS0Y1NTUrUnhMMFczTXlSSkpv?=
 =?utf-8?B?ZGJ3TmhnbnBuR0czTk1kVzdhclA2ZmNCT01QZUNSSnAxQ2VFY3E5RVNlNGsx?=
 =?utf-8?Q?lJ8+HzMWJEC75iAEWWedFdW9F4PhAhwihfhrU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c1a1ef-3906-45fe-4c06-08decc3f0082
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:06:49.8824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH9L0hvAgQAobxDeXezPvFFBr4pD77K9PHltmCdbWPLz1Iz1oneaGVnZv7Q5eWOqcDOv368fGktnxWWQuOhGdHDEYEqSdMi7opHViU76dAwOHJeNO25PkkElFf/thJrP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906
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

Check the pd-disable property in the connector node during
tcpm_post_probe(). When set, skip tcpm_port_init() and
tcpm_poll_event() so the TCPCI driver is probed (I2C accessible,
ops available) but the PD state machine does not run.

This is needed for dual-role data ports where running the state
machine during probe would disrupt an already-established USB
connection.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/tcpm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 1ce46118fea..32c67b8886e 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -2306,8 +2306,15 @@ static void tcpm_poll_event(struct udevice *dev)
 
 int tcpm_post_probe(struct udevice *dev)
 {
-	int ret = tcpm_port_init(dev);
+	const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
+	ofnode connector;
+	int ret;
+
+	ret = drvops->get_connector_node(dev, &connector);
+	if (!ret && ofnode_read_bool(connector, "pd-disable"))
+		return 0;
 
+	ret = tcpm_port_init(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to tcpm port init\n");
 		return ret;

-- 
2.51.0

