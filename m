Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9896FCD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37B2E846AC;
	Tue, 26 May 2026 09:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lPZs1Kff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B03483FF5; Tue, 26 May 2026 09:53:30 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 980E98464D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NC3l55ddQvcJh7wsnmbUO/0Pd3RRaap5Y0cVQ12X7863qIx63I899/qSFs3Ouy47Ps2kwT0Id5IY4AlZJ7FZcT5i4dFUGG8mjSPJoqbyoJ5oinlrdtDu5iaM7gpss1LSLZuUbpxn/uYhUFL+ttroVQDPbAF72JmpHfmZltJnd4IepE1hP/FxJpz/P6mW0Zkw3KxnmqmJF4vEDOwS5ZNS82SAw/IJCuuhevAID55TswMii+/UBnBVUBJ77ld4xd/rR/buZXWmz01lrWm69qFFLZh2H8hRxfGlFvBV524XqRdi9xGOU7MMdSeeWKKQuLUtAm1QRebnRMSU6iWzr1fqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6FxNmal4J/mR/+FTiZs+UNlQOzv+T3t3kiuwSj1LRo=;
 b=QLIacNlDkWr/OtQKKvzVPIICAZaJSWY1lD8ZoQFVItlwBH9l4VaZgxupZqIUM3xmHpsAGrO9URtcsFdEYXRVJ1zg89oSF2P4XQPhVFalypecHm0q2arfElhtIOqOmjEP7iJcsKNEO7qk7DSvw4kLfLMM7rm0/cNMdw8L/+U9P4DF6V3vCemGl8R9/eAH84Gnx0/DusbaPpg6iaPxeH736mx5abXqF2XxGdG3FjUyxe95ApdwbwYnAGRRPRSzywAqiUaNTZTIE61NNoVf/7+zcS7hcqKDG9xLLYmBpG11wYyYnEuxxiPJ+dfgqVSzwqHXMaUWiY+ImSDrNJIFmqAzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6FxNmal4J/mR/+FTiZs+UNlQOzv+T3t3kiuwSj1LRo=;
 b=lPZs1KffDFLOHd774LCRNd9zloT1kD3OoWkxS+UjL/VpKcp4Nbmo74jrTWhNbTX7ULcvTjZ1umKWTM4nyIScuMMCMEeXc2bxMLvmWl+UJyPNMgJlPOvTC3qXPmm5dMdaXK4SXhjv11kr7dLxXEiQfGmu+6U6sEIIv2SiE6TWpwnKIv+sa4cWyIXjLLuTcfDCCvfTYEAsCnVFwl06sI3gOH/YHREp40HBtFrEkWRjCC0NoWrcqsCSbGKUqFQ1kG2/JdpG3SX05hd8SzAJpoRjtV1JYjvFGGGPQgHxeloQWhyIB9WcP9GBRiS7hccPvcs4Q04mnEaL6X09c+l26uD+vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:53:22 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 07:53:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 17:09:58 +0800
Subject: [PATCH 2/6] usb: musb-new: Use ofnode and dev APIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-usb-v1-2-a4e22b23bfae@nxp.com>
References: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
In-Reply-To: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9dc39f-b3d5-4f5f-63b9-08debafbdbf5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|11063799006|6133799003|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: bwuS2R6hUgh4oBShW52IloqHpa4LVZFdcP/xJN0EOREUVI874esetitZpAt3rTyxMHwm6YQpfDrvTQMjWV7Kkh4DvIaOHP9oc950CVFi+lBJ+7G/zPCbK85PkIpUi/L+KWHXawCrSfzXxLytk/AyiH/lj+hq4hqGjcwMO4NXF0HpAsWprmFpnI63yGUqB5pmk4SN287hlH7mF32s5dKOnKJVlVsjdVVIB+lnOT4hgfD4SBRsHcoJVtzzHi4wIcKIU27BX6lbXSUuJwqj8fBzCdhxWG5yab5B3q/t9zLu94BWSjxKZ15IrOKA2Cc8+hmmwnbSvcfph89Vj+4mYPa3RlQh6ajv3hLq/dvQBl/JdcN8bThL2oanGEkGND4sPYH3apWgiVn6U+Uag4ANIoPbjar5GbxVNX3GnYRkN8ff2ib+ojKzR1nyY6aFTEGoyAsyqt0bFYBAg57vlCx0a/3ERuBD3cDx7yNx3Zh5dxKVipVs7AsWhq5nYKCxvwcb/IjJLH0tFLdA906LV9QJFx6VK2DZKcbigo3DiuWq+xR5MC248QyVHEtOxb1AG2W7F7YJ/fswzUgufWgU0EsQutxJ8Wod8kYmPa6WNY3HwJOvHwGkCtrpA2kOUJxOzT4I3g33+v7J36wbvBFoBC2judgqJI/8ydczmSqDFdcJ8jC+IdZZRd2GqCKhzr9Mgz7YUEcZvmc7tMv7OAoKrs/N1eLMzf/4f0NCEBwfkJ1TACAdDh11hxyug21NsiebIYWOyrpC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHZpMTJTL2FhYkNtUTNLSDF5NEhsclhuc2FUK3dORTBUSURRRmplejBuTHhR?=
 =?utf-8?B?YURBb2F4amtjN3UzV2lqWUZtR2lWOGNZZ3VIdUFRUDJmWmtwekxod3ZYazFU?=
 =?utf-8?B?ZTgzWmxqdmJqTkJUSmkzRVZ4Snk4RFhSVEw0dERraHd5RkR2bzN2TTFvNW5q?=
 =?utf-8?B?QzYrcWZFZlQwR3RranEvRDlzcW45NllFcEl4TXNpcFNibVAray9MaXdUTnU3?=
 =?utf-8?B?Nk9SR1I0R0pNTnBqTWU1NG1LWHF3WGFOWHRMaDVHSzdaeCtUN2J2UUwwMTJ3?=
 =?utf-8?B?RytOaU9DSHordkR1dXRTeGVCMHVkWVd0Y2RHQXRIM0VHdVNQeTdoYnZRZVlE?=
 =?utf-8?B?Tmsyb3lQWUt6K3NpZWNyaU9NOVhBSEpWcnN4dEhJTllJdllZT0xBYlVxOEVM?=
 =?utf-8?B?cTVJdU9xRmpaN3Y0OUh0akg5cUZrcXl4cWtHL0I0NjVCbWU1bG1kMHdyc2Zw?=
 =?utf-8?B?bXNyRitWQlJ1Q3hKMitMMzBSOHpPZHM1UzdKSlpqb0NvMnl6TitjandwajNi?=
 =?utf-8?B?dkZTVTFucDZYQUMzNHVnUXIwa3B5NVN0ZlJqbE5GNE9ZcFZ4MWR0dFhtWGc3?=
 =?utf-8?B?cWdVZUhIVEZTd2JTMytDVytESFcxM3l2OWIyeGFTWWNJREh1cmVpdTJvZy9L?=
 =?utf-8?B?REZRYWdOVmVodDNFYW9JWnJrVmdSMHBuU1czVmFCVnFob2J5aUVDY1pNSWFT?=
 =?utf-8?B?K1VyclhHWXlOcm9sZ3Q1MWF2VzR6V0VhS1Y3T3NmZlhLWnFEVnd5dDZuRGFj?=
 =?utf-8?B?LzIzYWc3aklNOHJNZndtT3pIL3hVTzBXOVg4WHpwVjZJVHdpd0NXUTNHZGIy?=
 =?utf-8?B?VlltM3pZbkRBMWFaZXFZdzBBQ1F3ZEZlTHEwa001dDhqWENxcjB4b081c2FB?=
 =?utf-8?B?dHh2V0h5REZLTnlxaWxZNnVldWRBRSt2UjNjVlROQWVsZ0pGZitIeVFlOGNw?=
 =?utf-8?B?ZysrN21tUVpqbmtuK2xvMmFCOHFjaXc3NEo3a254MVd6Y096ZXllNXNOU1c2?=
 =?utf-8?B?WjNoMG92aTNYdGtxeGhETG1mY011S25hbmlvTnFsejVnZlFYTVRYaXVVWFAz?=
 =?utf-8?B?TW5KVWxmZ1cwb3RUQUZ1SElaWFBtdGJrTmlqbUpSS3E1WUdNS1dtUW5jSmFh?=
 =?utf-8?B?QjI5eDl1UmxORit1cTJGY2gzM050bnJ0QmRyZnpOVFNhRmcyVlErbzJnZHVw?=
 =?utf-8?B?b3F0ODRuOERjNE1wckRnVXlJRkJWQUtIYlRrU0NpZkJ1VUVZMDAxTXptU0xP?=
 =?utf-8?B?blMrYjJRRmZhbXFMQUpqOXNuUlBHeWg3VXZaZzVyYk0yRHRtbW9TcjgxRkpI?=
 =?utf-8?B?L1VPcC95L2JjQXk3bGZXOUVqSGptWm9YZnBlSHRxTmo3Z056aWs4aDVDZGh6?=
 =?utf-8?B?bVdHd0RIeHZFQXZDTk9EQTREdkhXbXlmSmZhNm5XVmhLdEZlWFFHMmpyai8r?=
 =?utf-8?B?b0pENU8zS2tBamw2MXQ3VjFocFRNQnV6b3JMQ1FneCt1WTNiTENSRXpvY0dM?=
 =?utf-8?B?bWJnbGpteTFOL255akkvb3Q0UlBscmZnNHp2OHlMUnY1amlnRlRTRmRzdnZT?=
 =?utf-8?B?Mk4zeUd4ek16TVEzZ2ZjYldKWCs0bmE0czdzU1J3dG1rNkgrTDNVNjQ4WDFD?=
 =?utf-8?B?R3dQbkhnQkZYdXhTQW93QkRTdDUzVjVIcmlpT2dJSmtPb2R2dStKYjRCTGxk?=
 =?utf-8?B?U3NidUZqUGdDdDJwdDFxS1kzL1lURk9DYnFXSTF4ejJ3cVNtNGl0ZG9HbGZH?=
 =?utf-8?B?UkJjYzlYR0FWQmNJZkN4eGttcDlFeHZ5SEYrNXljN0RUZk5uQ3o5L1ZyVWE4?=
 =?utf-8?B?RFMyOVdjTFVhU1diRVNwZGVMYUJKL2RLbzVnaWNsb0dXRnUxejJtY1pSWVlz?=
 =?utf-8?B?djNybVMvUXUwTHl2ZmJtSzRYL1pXZkhyMVd5STBuSmlRVWo1cGVFMmNUdjVR?=
 =?utf-8?B?QUpGRDFoMnI5WE02STZHS3pZZTNTMVJFQUVCY1lWMFEvNmdXM1JYNkc2V1Rm?=
 =?utf-8?B?RVhIdWREZ2tFbWhSVTJRdTB3Vm1ZckRoYnNNalJaRmlwUzZjYTlrdDJTRHJw?=
 =?utf-8?B?RjRYdDhXS2xvS2MxWWNkVFNDNVd3ZC90OXBmYzF1eEZzTGY4VTRqbC9CYUJn?=
 =?utf-8?B?cWhUMW9qOEFIY0FxUmY3Y1VaaU0rSUJRWWNQKzlPd29TK2NOU3hkL09OUi9Z?=
 =?utf-8?B?WlZPYmlIZ1dLMEhPNDNnS3NtWmxKY0xrY2hQZzN4NjRuMnpTUGdacDJack9P?=
 =?utf-8?B?ajJleVhidFYwS21DaDRsQ0JLRlNnWm1ocWhmWEZ5ODl0c05WR3k2ZmhTWnIw?=
 =?utf-8?B?ZlZHU3VsZlVyQXAxbzNqTXJiWkVJNElWVTZWUjZ2WEd6bGduMFlTQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9dc39f-b3d5-4f5f-63b9-08debafbdbf5
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:53:22.4328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQXnj5ovX22fL4b7F6z/K4F39NXm2EWoJM0P2hysjlFyI/vu1bAzclYn8U2v8WfC1/YgoDWs6FjUJIK2KHtZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401
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

Convert the TI MUSB driver to use dev and ofnode-based device tree APIs
instead of legacy FDT interfaces.

Replace dev_of_offset(), fdt_get_alias(), fdtdec_get_int(), and related
helpers with their ofnode equivalents such as
dev_ofnode(), ofnode_get_aliases_node(), ofnode_equal(), and
dev_read_s32_default().

The USB index lookup is updated to compare ofnode handles instead of device
tree path strings. Also remove direct dependency on gd->fdt_blob.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/musb-new/ti-musb.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index e083cb7d0ff..3dd6e3eb718 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -51,29 +51,25 @@ static void ti_musb_set_phy_power(struct udevice *dev, u8 on)
 
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 
-static int ti_musb_get_usb_index(int node)
+static int ti_musb_get_usb_index(ofnode node)
 {
-	const void *fdt = gd->fdt_blob;
 	int i = 0;
-	char path[64];
-	const char *alias_path;
+	ofnode alias_path;
 	char alias[16];
 
-	fdt_get_path(fdt, node, path, sizeof(path));
-
 	do {
 		snprintf(alias, sizeof(alias), "usb%d", i);
-		alias_path = fdt_get_alias(fdt, alias);
-		if (alias_path == NULL) {
+		alias_path = ofnode_get_aliases_node(alias);
+		if (!ofnode_valid(alias_path)) {
 			debug("USB index not found\n");
 			return -ENOENT;
 		}
 
-		if (!strcmp(path, alias_path))
+		if (ofnode_equal(node, alias_path))
 			return i;
 
 		i++;
-	} while (alias_path);
+	} while (ofnode_valid(alias_path));
 
 	return -ENOENT;
 }
@@ -81,15 +77,16 @@ static int ti_musb_get_usb_index(int node)
 static int ti_musb_of_to_plat(struct udevice *dev)
 {
 	struct ti_musb_plat *plat = dev_get_plat(dev);
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(dev);
+	ofnode node = dev_ofnode(dev);
 	ofnode phys_node;
 	ofnode ctrl_mod_node;
 	int usb_index;
 	int ret;
 	struct musb_hdrc_config *musb_config;
 
-	plat->base = devfdt_get_addr_index_ptr(dev, 1);
+	plat->base = dev_read_addr_index_ptr(dev, 1);
+	if (!plat->base)
+		return -EINVAL;
 
 	phys_node = ofnode_get_by_phandle(dev_read_u32_default(dev, "phys", 0));
 	ctrl_mod_node = ofnode_get_by_phandle(ofnode_read_u32_default(phys_node, "ti,ctrl_mod", 0));
@@ -109,7 +106,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 	musb_config = malloc(sizeof(struct musb_hdrc_config));
 	memset(musb_config, 0, sizeof(struct musb_hdrc_config));
 
-	ret = fdtdec_get_int(fdt, node, "mentor,multipoint", -1);
+	ret = dev_read_s32_default(dev, "mentor,multipoint", -1);
 	if (ret < 0) {
 		pr_err("MUSB multipoint DT entry missing\n");
 		return -ENOENT;
@@ -119,7 +116,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 
 	musb_config->dyn_fifo = 1;
 
-	ret = fdtdec_get_int(fdt, node, "mentor,num-eps", -1);
+	ret = dev_read_s32_default(dev, "mentor,num-eps", -1);
 	if (ret < 0) {
 		pr_err("MUSB num-eps DT entry missing\n");
 		return -ENOENT;
@@ -127,7 +124,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 		musb_config->num_eps = ret;
 	}
 
-	ret = fdtdec_get_int(fdt, node, "mentor,ram-bits", -1);
+	ret = dev_read_s32_default(dev, "mentor,ram-bits", -1);
 	if (ret < 0) {
 		pr_err("MUSB ram-bits DT entry missing\n");
 		return -ENOENT;
@@ -137,7 +134,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 
 	plat->plat.config = musb_config;
 
-	ret = fdtdec_get_int(fdt, node, "mentor,power", -1);
+	ret = dev_read_s32_default(dev, "mentor,power", -1);
 	if (ret < 0) {
 		pr_err("MUSB mentor,power DT entry missing\n");
 		return -ENOENT;

-- 
2.51.0

