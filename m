Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879D8CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 978A684954;
	Tue,  2 Jun 2026 12:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lrsM/y6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A4984948; Tue,  2 Jun 2026 12:05:20 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B98C284951
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IG+Bcw3pieIMpa/5K+0yEekkC40hmXqiZFWQgosQzIWZch0XqQ6QNyBv0WRoCpOnPCVRNHizzJmPcQ2HvHDoMzAg+fmPlFhmxvCGMqYRPeW4XKwShxUbJ8iKku4cQ3KN0nvF/ky0h12Pa8Cb4NQvNqtbo7XrUFvhltIaHuJCUXSib6egi8qGblCed/QsG4CnaZtqhP/na++PNY4Mj7eILF+CSWjqnlZt1Qe223/8VQIXsTq2DijzqgLqQRvXh2htAVa7/bXtrOxCVAEMvpTqXRfk+M6xMaR5hhmbwCfx682l3xzt84z14pQEn2i2jRhrdMzWC8TZyJ1jTk0Cr/diUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYC30YgZZPiBuD+2yVvfcgv6wnjXdAYeqOf4f7DU140=;
 b=ENXYdrjtMdSegKnfMJi9FKZFuSOnSSA4EBNQuhsWXGAn8CSpOzhmG0ULdCF+oVxiRuHIAgItzr3hNUjqMc2RSrfy1mRzJrxBYKNSLb9Qhq30BQGiFYgJJ164+x1pmsWwSVtz0P/yMANOPvhoTjLJkeuMJEk8yH25ttRPx4pFg7Fmh5JAur0YKntmWNJgPDd91q+2O3iz6VNDt+ACTuYr0oP4uS49rxCwfblJmP/bRknow1uFQ9O3KFeE1gcT8id5vC3w57LOpeUCuNniJd4Z2gqarSVXrJvMEvoHP0wBS0i37IFsO/grb9Jcz/l9jC/2eTU+54HhvUbh+29nEaKF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYC30YgZZPiBuD+2yVvfcgv6wnjXdAYeqOf4f7DU140=;
 b=lrsM/y6eaGBvPfubqaiQpG2qUd0ZGMr1BI+zG9tbfMg532TfClUBRKBHeNgAao8HSdhzdWtYMtRznJ4PSttz0r8YoMP7PhKBZyhgnHmyZaSnmO9L/KBxrJ/MRD/tkatQU58fL5nCrsJwPEYIoPazC36JChXjdtD/YNEcZyz5amc9WIAi8yiAQDTuMxwPtmH4XBLqctOoSHFwM0ziIXngvrbu4wvsHZ7AhqLAIaO0vh1b4+YO8PGmn+MpzX12VC20boiUvcEceJyCahFdZXhhPsafICIUfCjLn6dbSd7qyf5lo1/HpzC8kYKSDm7ANpQOyIYTWMKUty9YaFwML20pmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PR3PR04MB7372.eurprd04.prod.outlook.com (2603:10a6:102:80::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Tue, 2 Jun 2026
 10:05:16 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:05:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:21:45 +0800
Subject: [PATCH v2 6/6] usb: xhci: mvebu: Use dev_read_addr_index()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-usb-v2-6-a587ab36b906@nxp.com>
References: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
In-Reply-To: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>
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
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PR3PR04MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3b1435-8be7-4311-901c-08dec08e7211
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|52116014|376014|7416014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BfrQCGPcheVxGJyzHdz03RCyb9Bp48sZ4KpI2/3Gitihm0yUhaij7nnmSH3IuhKtpoTM1fy81K+/6YpFC05+3Ym2R1D44ysYMlcLobmeNGqOLLpUdz82GXY3n2XYl9jjKWyiMGObgqbSEiUs8YIYGC1zWpIOjyv5Fj913x0KcLWzeEIsYNrPrwf9QBCexDSCSPGSka70WC4S3OBDjAkO5kCwJ/1UfaPmdi7jLs5GULoyCJ6qnZYpclrstNdoSGCkWoHE6BdxiW+jwq35AKOK00X6aUH9JXwf+AflAn1Wq+HID9kak5i6LrpRFrRt2MxTocF0HJdftax0pf9OXfjPoa+yHQI4aPDnahgCRtupmv3udvE8rbxsxCtnbRBQeRIBRxBNj2YTFrDulMoSVfwziHJ4zzZS+5CA8s7EIRvlXwVDi4Acg56lnA/BbsLB3KR/WkEFD3kIcoQdMRzCeYX2MpEMFWszDkWBJEfzC70jiZxixwsO0Punf9dc+1liPuDCspH+oziLVlapxDxZjUAH6HmzFY3+SUwNs+JwTeFZ9WH5j+yYJAp8l5u81m7ppOgXkdYf/PrQO5rTAjIenQw+UH0Cev81EDfL5n5/5MznNqMqWHET9MqykFZUYNLES+2p4+UoPMfe97DlEi9zSAK00CzC6KcgAD83pGUF7G5DYkhE2UNXarEPcXLhHs9tcPyLnlz3LvE9TDIUxJgPfUE8Xyxb91fIA+aYovtwu61SaUWBBLpnhQGnDsgM+UDJn6pT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(7416014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlUrMWZmS0Nmc01yVkNoby93ck1PUlBzbDBoR0pKSkNOSU9ML01lK1F5U2ZF?=
 =?utf-8?B?NHBWNGgwVm0yaUtpQ0Znb29MQ2ZRVUQraHI2L0dEWnZOenltRzg0NXE3VkpS?=
 =?utf-8?B?MGZWejY0M3ZkSFVHUXFCUzkxcnRIOS9DUVNIZ05FczF0aVRtWXlNQms2clR0?=
 =?utf-8?B?akZuK3RUSDMwa20xSEJudkFPTlhmVWtrYnNIY0syVnRjRTdGc1ozQ3Y4M201?=
 =?utf-8?B?a3FOeHhsaEJsOE4wL0ZLbHZDTmxhRGh1aE55OEhSTVY3WTBUU3lsaWZ2bEIv?=
 =?utf-8?B?ZWFncDJ2UmVqSmhacjU4S2FkRXlLMVQrVkNGcVpVWGtocWdzOTEzMXhna1I5?=
 =?utf-8?B?allhL3dBa3pJclVJL3lHNVlzMXoydGV0ZW9CeEd5WCtpRjR2SWpmQ2ptUi81?=
 =?utf-8?B?ODFrQnEwWWdraEZreWpBd3JLdEZzZkpJNjdaT0JEb3BQdXdPWVFoZERGWGlM?=
 =?utf-8?B?a0lyREVkVDQ1NW1qMDJJSEd1aFB4SnRLSnhncmdVMmgzYTNMR281V0hQa3JT?=
 =?utf-8?B?b1lMM3VuZzljSnAwdmN3aUhMTU56aC9oTFprZXhMcldEdXVRMVBUN25YZ1Js?=
 =?utf-8?B?NThGQ1BzNGhVbHA1V2pCNUJsamc3V1RMKzNCdGh3WUhoZkVXRFBodURMRHFU?=
 =?utf-8?B?akVMZHRzZEtWTnErNHBxeUY2UHg2NWFuQnlDaHVKUUNjeXlvQ1YvNFVuKzJ1?=
 =?utf-8?B?QWhVeXpzMGx5bHFQV05COVJMblc4SEZaaTQ4VVlwd004d3lyd0Q0RzBKdDMr?=
 =?utf-8?B?K3hSMC83U1VIam0vd2pDKy8wdGx3UHdwL1ZjYks0WE9EekZWbElIQnY1RjJZ?=
 =?utf-8?B?elNnK0M5OGZSS0d4RUJodVlwRE1Nak9XYmNSMTRUSUhmdStFcU1RNms5YlBw?=
 =?utf-8?B?L0ZxbkFRZkhkMzVDMStRZDEzZHVCdjcyWFhkdElzcG0wSkplMWRRTE5ONnZY?=
 =?utf-8?B?MUoyTHhZZWZyRmhvbGJNMDJlM2VaaDVKa1NJS0NGbzhGNU85QmcwMjZLYWhQ?=
 =?utf-8?B?am5SV0JNbFNMNTZ2blJlaHBTQzRoWGZBM2VWeEhwc0JiQnc0UUhQMEdYUGpX?=
 =?utf-8?B?azhvanVINjRLQWYyeUJPY05xTVdUcmNjL28zOGZreWg3ZVBHVDZ6VzFjQWtK?=
 =?utf-8?B?S1VtR09lV3V4MDZQRGtPWkNYVmtNbmNub0VzaVFxQ0lPSnkrNSs0NHZUMSs3?=
 =?utf-8?B?QUt6K0g1MTIyaEw2RmVyYXVMbFdUTzNkTlRqQzZ4d0Nha0gxdkNMVTQrMWZH?=
 =?utf-8?B?UFcrZDE2VzNjUHRhM0NZZnMwZFJFN0FaSmFQNkgzY1BnYVRmUlJkZy9GeFN1?=
 =?utf-8?B?L2dScy8zRGNjbEQ2RjFLRTFOSk9CM2FLSUsvaGFDdVQra3l1MUlqZmJsdHRt?=
 =?utf-8?B?YVJ3UzBvcTM3dnlETFNQdnlYQlRSUkdGT255NXozSXNyVGNha3V5KzR1WFRQ?=
 =?utf-8?B?clA4QVpBUGtNSEE0SHRma050QWIzY20yR0JLL0VqRjY5TjE3aW4yb0RkSFhq?=
 =?utf-8?B?VGhoMUlFRjFzc1RDRkVMYlhBelp6eTRONDZZaExudk9nQWdVaXdNQ2lGKzgy?=
 =?utf-8?B?cnU2WWVvZkUzN1dzYzNVUERJZWNLcEd4Y2FVYTRtNVR0Yk91bDkrMGtUWnZq?=
 =?utf-8?B?TzVWVDIyaVZGT2RteWxoaFlWNjRaNm42QnIvV1pRd2dqamNsdlFBaE1pZWlM?=
 =?utf-8?B?eC8vdE5NNG9OVlVJbTBUZW53S1BPMzdYRFBlWVF5SnBLZXhsN3E5b0Q3STRt?=
 =?utf-8?B?RGg4OSt3Nnd5VGg5M2NKcFhqdi9URjNoTW43Q0RoK0NMc3NGVnMxbDdYV2hP?=
 =?utf-8?B?clIvNUFtcklKdHVzZk5NNFRLWm5uUzFnQVdMMzFMK09LcXRiSnQ5RUZYNi96?=
 =?utf-8?B?QisyZzVhcC9KUlRwV0IzclpJcTdCMHEyQ3pWOCtjMzFnd051dDBGZkZneEI1?=
 =?utf-8?B?aHRqa1lvRXhvdFBuVksrR252N1F3K2xkaVVtVzRzUG1vL01zTHExSWcrZnZs?=
 =?utf-8?B?UzJMZTNpMmhiYVJ3MFhKeGpvaGN5SWJRbCtjVzk4bS8xL1BjOEcya0Z4em5m?=
 =?utf-8?B?STNPYWpGcEpyZkljUFdvNVJEZ0NQcldoeGw5SEd6TmdRdi94RlNoMkw3dXp5?=
 =?utf-8?B?S212QW5zdUlQVTY1cm02dUEyVkVuMWt0aWF4bDNpMkVuUDdhUUdKN0hMOHk0?=
 =?utf-8?B?ZTM0WExPY2tWTVlzdmFseWRKeUFQcWlaOFVJYVhFa0RmY3BoaytUc3dDR0Z2?=
 =?utf-8?B?UFpJUEVGUXNBdGM5VHlabDZSeUQ2MXdzMWFIUnBhVXF4ZkpaL0RtV2FrTGVG?=
 =?utf-8?B?OWFsNlFlNCtGV1NlZ3VhUFQzVWs0elhzUGdPS28xaU1LVzRpRjY1Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3b1435-8be7-4311-901c-08dec08e7211
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:05:16.6040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sklZqKkaCbM82gOkiSzyqu1ReeoXpfKkU48TWWzbRy1rmqjOSgefjuKaxAJzVALJ8OBc80A91JHM4LsvnqV49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7372
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

Use dev_read_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/host/xhci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 12dc61aee9d..bd17fe717cc 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -59,7 +59,7 @@ static int xhci_usb_probe(struct udevice *dev)
 	}
 
 	/* Enable USB xHCI (VBUS, reset etc) in board specific code */
-	board_xhci_enable(devfdt_get_addr_index(dev, 1));
+	board_xhci_enable(dev_read_addr_index(dev, 1));
 
 	return xhci_register(dev, ctx->hcd, hcor);
 }

-- 
2.51.0

