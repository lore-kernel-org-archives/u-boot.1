Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF944CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4DB984903;
	Wed, 27 May 2026 03:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kvHIAf5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A9C848AA; Wed, 27 May 2026 03:18:56 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB888493F
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBxvbwsXxLXE+cxqum0l05fOuQecLT7IBUn9GSChYhYchwB5XGqpgL2Db+ZL9pIFTjTW1B4HoCvG/b6/igNNDjYl0QPNpUaHDoLzm4riE9+53kVQS4G9q185oY+fT1KyMkW5wT8GQ3J8N2oRv6X7dHY6v28cpzpRiv0nBFib89mEzFBSl/JAKU85JBJheO+/30aIRkuwmlIoVbxxJTGP/mybEte+RrcHdMI42SXxdybaVXL+Nv2oPu3I3B5Aj0BbiK6S8NsnvtGPNlJoqQhNMZlPvg3OtRFgdfwgj+giWeRQW5vCKE62z+zwfMB/tXgDkrPUJGgpq4dsdmUVnuUsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCZwwrdVz9bnnlC8cStNavZ1BpjwTkLHJ8kiSTrhTeU=;
 b=MGjXcd+wQr7wFzReVqhpzfQYmaOysIDcCGt95Jh1DsXTatT5K0MNOmt8lffcx55r4USFbdzgEKkhiSfp/b9JZ+XoCCO0uN4QnBWz+91S9la9bXPdvAJkuObqP0exgs8h6RgeHx0h18Ce1sK8WRrjQQ05T2KzLBMqCIeiPOu2vbVi+iBnKXdvMOZa4wIGWwB73fac1QaKw9Zhh2HBpLr5f/t8MuOd+OtxDEJG++xmLM0gXjEpDGTxN4/8QPWnpTbmpxFnlOwt965IojDAV4No4xSyO/uAF9dqkSMDqyEF1jCxVKbHw6bJeoRy4RaOxWH3MQcBN1wCtFDzaYOenSuYvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCZwwrdVz9bnnlC8cStNavZ1BpjwTkLHJ8kiSTrhTeU=;
 b=kvHIAf5gDvZEu2yGaQicVDbVZDoA4tfwNl2sWYmXR5c63+zd3U/7u6dnbWweG4mlajYckjnbKIDUIpS6U8L3fULv4SNpThNNiOf9NgnxE48MDe4uH4mHdbnJ2lUHhJJQ4QKaQxYSs+xNqN4gWGnwxOkNNY7NUKINFENY9TcpYi+qPEAOX3sA+sbprhnq4aZZ2iHsTEKDrEU4Q/vNI0XBY5Hec55Aus76Cff/sPr0n0CSwDsuNjdB6xVtvxV+exVxBg9RK1ldtDlsiCxS4a0QAgLaIzXVOn8I8b6U5J2VISZktjKCovvAx27omkgNg2Jr7VzhfRpTkr/sy/daaWDduw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10208.eurprd04.prod.outlook.com (2603:10a6:102:454::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 01:18:52 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 01:18:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 May 2026 10:35:24 +0800
Subject: [PATCH 1/5] spi: spi-aspeed-smc: Use dev_read_addr_index_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-devfdt-spi-v1-1-37db1f6c168a@nxp.com>
References: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
In-Reply-To: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10208:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d7c75c-0ba1-4024-d280-08debb8de9db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: AM3XJI+g1Mr3gua7oNnS4Hvq0PyG4SLxcmpzgrcicaltLvZSw8XaRj1AHkOZRK8RBEZAQMmDrFfPocB2Oa9wsxOMBoGHgGIyAFz21DBsrkoiH8WCj2rUJUXPsGAtrTgQXR1esUbWbvQhSh3DD4kmDRs3xgZ1xoFp+8+pKxSN6F3VAou9WXuB5qkd4me1+aYBuOLsVBnhF5+4u3kAByB8p/PXGgEsInm6rskBHPYYUEkCvPZVTzAp84RCuTKCcenNReq330EjKL9zTrge+nGrk5XWLf7Qnu8vvW4OVLKTV5TmWl0lvCGonPT4jbj0l7/9NnTxoQgGsdgzhEjA6WekGwzx9uLpB9yJENk60Nqoi9X7fLFbXMMlK0IxZ1xurgJEIaEmsNf8jfko3BioZBaXTgUDJOQULNXZLstTN0VbwBQ6+i3FCYo4kUauKpt/5G0djLYvpAbkCvL0Wn+VZEgE2HpNWE9UU3SQzzc8BUo0eXfbljz/3BKoKwfue4/NG28+mSNI+I24PT6v9a2Jif1lfDi1REHP3GAIZVFYoxjd6z63XqxbZaAzXoWmgAIWbRIvRnzYIlSgVp8LT4K/TtRz3+vxtc4KW7Z7c0lpyHjVByXpwVhVH+rQK88hykBE/akOs0MiJWjFCDn1+yY8g/pPY6SrlrXV7BkbPbH8yMJckFHCz/iSGQ5C6xKXjOQSFBt9qIB8aWATkbwBLI/h5TP6WKw/O3VR+Mz48bOTB51Pkt+T899bmSBks6H7SMqaPmUO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0o2UEFqWVNpcFVDRW9ER2NBdWRoekVNS1BhbU1wS1lwSmpXSWF2aXkxcWxE?=
 =?utf-8?B?UmM3SXpDeXpGQ2Z5aFZTVG5Rbmw1ak8xb2ozNm1Ja0loSnJORklWUnFNQXZ6?=
 =?utf-8?B?dTc2Vk8wU2xNbzhDeUpROVdJQU9ZZFlORUNPOXFDQXFNWW9DZVVPYW5YaFk5?=
 =?utf-8?B?K2lhRzFSSlB5QkRocW5jT0g0VGgxUlBJenhiVFQwZDRCeXlyS0dveWxBTU5O?=
 =?utf-8?B?SjJtczdXOWhXbHZtRXpOMTRqOEF0L2h0UThza0xhSVRHNWE3NDViYVRXWXdj?=
 =?utf-8?B?aHczQTBpSkRmbG9pV1JMTFhlY2Z6L0lzMjVLSTI5Mlh2ejhWNDBIMkhkMXN2?=
 =?utf-8?B?amFYOC9MT2ZVOENZTHEwb2cwOEdQZjJkanZvZUt0dm5OVDI5TEIzSlhNTEhQ?=
 =?utf-8?B?dFVvNS9jcXVkcU85NndEV3BpM3Q0VUFZeVlNMnloV2xzUW9GT3I1Sk5lYnRt?=
 =?utf-8?B?NnljaDNpYkx3SXByeG9aWURROEhVK2xCWmVBZktjUjhIOFdWeGFGZVcwaXFQ?=
 =?utf-8?B?UkVpRjRyUkR5S3ZqdnNTaXdjZjNQQlZkcllhekxBOVZvL2xaRENRampKbFVV?=
 =?utf-8?B?MDBXajl1VTA5NXoyOXdkdUdBUjFEQlBjNXNiKzc3TmM2SXZMY0YxR0xVMWkw?=
 =?utf-8?B?UGRPZDNJRFBPQWk0S0Y1WFhNY01oRDJYVzlubmxBUWhXT25BaEo0aVNNZ2hX?=
 =?utf-8?B?UFRDVVFjZm5uTFR2b2QwdXlmSVRyS3krWkxUNGpmZitjNzMyOVd0R3ZkMzRa?=
 =?utf-8?B?M3ErY1g5c0lXdEFOTFV3UHhobE5raFBNb3hWZGsrQmIzN1VSdkUzTmhDQWht?=
 =?utf-8?B?WjNIUlhWK3Z0Zi82ZW1RMHRpS3ZuazNKUUJUVW40bElNWDhsa212MzFmZG13?=
 =?utf-8?B?bFJFTTl4anZ4bHhWSUxLZ2RUTU02NnZhUU8zeDhHRk50M3RUSVBGYXlldWdF?=
 =?utf-8?B?emllMTRxMWZEV3JFUWttSlhTSW5VYnV4anFjVEc4NVZhdkxmeWQ2NXNaVmsw?=
 =?utf-8?B?Z2U4ajZrTHdFZmwvcnZUWEJQMCt5UUJud09uVVJ0bzZTMzlmaS9peGJ5bmt1?=
 =?utf-8?B?RSt2YkdVZ1RzbVVianpGcHJoZy9SRWhHM1VlNTU4NEh5cUFSRCtGeGxVT0FK?=
 =?utf-8?B?R3NMbVdXbE1qRlhVVlJmV3lUQ0VBUW1HRU5zMkZqQVJCYlkxTElyTU9CdG1W?=
 =?utf-8?B?TlZmaWJSVzJ4SXRTa1orc0ZXWW9iOSs1dmszVnpBbnlqaUJqS3dtMm9DK1Ju?=
 =?utf-8?B?bk03b2hxZVRiWitqdnFZTzFzZFlRZWpwOGQrQVUzYW1waGZVM3JWR2EwVytU?=
 =?utf-8?B?MCtnVzFCREkxTmlwZWk4UmRaUXU3d1RpQ1d6dCs5c0dzL2M4dm95czRiU21l?=
 =?utf-8?B?dGJGUGdFa3hFeklZUkVFWW1EZkhQY2lIbFhnYVliQkJ3Ym0vMkx0UnZQZ1li?=
 =?utf-8?B?RnUyUVpyRlRYK3NvMFNqU1Y0Qktjcy9TdXlZYjNSTWlVL3Vtdk1yVUxkY0pK?=
 =?utf-8?B?WUFiaU9FTE5CVHVnQjNZSjkyYm9SSWl4VmlJRXdpZGlacktIdXZNYUNlRkdR?=
 =?utf-8?B?VGp0TEN2VDdKTE8xaVJmR2p3bkdHamhlN2VJaDVneVRWNm8vV0wxei9xY1NB?=
 =?utf-8?B?bVVsKzFVNmxUUmVPTm0yTXJQK2hLdThyNWV0OVZqQXJKWTVYOG5mSHhLb1hC?=
 =?utf-8?B?OE9tRDdld0ZSZEkzR241UzJUN25rUTJSSzRTSjl2eEtYTWRPN3NIUGhXcE15?=
 =?utf-8?B?V052aUFNWldta0lBTUhQWStMSk1UbFYySGNKMlUwME5JRUFPUUJNRnZ1REF1?=
 =?utf-8?B?ZEpVMUJ1NDN1VWF4Vk9LSDVPYzJLZTcycUlMQ01wd0I5M0ltZXl3cEFkTjZp?=
 =?utf-8?B?QXA3R1NFbEJpWVNjR1lnMUhyQ28wSHd0RnBRcU5pb1JncXpzSGZBQ0c0aEN5?=
 =?utf-8?B?YUpNY283WDhhUm9aWHV0eHNtTTJWeUdNRWxCbGRraFltQkVpTVZKaWdGa0R5?=
 =?utf-8?B?bURsN3FJUHdjdHh0WVlLWHNVc3YycU1KSWdUYUtiLzhab3drTEtsRjIycDlX?=
 =?utf-8?B?cS91eWhDWCtQMVo2b09VV2ZmT01qY2pDNlZMb0w3eHBzM3RIOENUVFhiS3RN?=
 =?utf-8?B?ZFpVaUtxWXYzQ1BnaHZuNDFWMnUwek9pV01mQzdHYnhsamxIVlZNSSsyNHVn?=
 =?utf-8?B?MThnUW9obXZZRHhDMjh1cFJMZVdlUlAzNUdJME1WaUpBd1F3S2l4eWJxMXIw?=
 =?utf-8?B?TDNWTnpTM3l0MmNLd2ZGaWYzamZ3SFo2ekhaU1VzbWZ5SktWMVA2M05vMElJ?=
 =?utf-8?B?Z0Y1K1ZnTitkb1JmeERualpMb0l6L3MvYmpuVm5RL2JMTzdWUlFIUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d7c75c-0ba1-4024-d280-08debb8de9db
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:18:52.3982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z6bsEJpF/bRIZpduAv7EOhdiSqn4JyRDvzTS7UEzHLy/zEpeh4jIhF3tIGXlkM+DBmGT40zNNsNcWEonMKC+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10208
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

Use dev_read_addr_index_ptr() and dev_read_addr_size_index_ptr() which
support both live device tree and flat DT backends, avoiding direct
dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/spi-aspeed-smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index ca29cfd7c88..22668c1aff5 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -1123,13 +1123,13 @@ static int apseed_spi_of_to_plat(struct udevice *bus)
 	int ret;
 	struct clk hclk;
 
-	priv->regs = devfdt_get_addr_index_ptr(bus, 0);
+	priv->regs = dev_read_addr_index_ptr(bus, 0);
 	if (!priv->regs) {
 		dev_err(bus, "wrong ctrl base\n");
 		return -EINVAL;
 	}
 
-	plat->ahb_base = devfdt_get_addr_size_index_ptr(bus, 1, &plat->ahb_sz);
+	plat->ahb_base = dev_read_addr_size_index_ptr(bus, 1, &plat->ahb_sz);
 	if (!plat->ahb_base) {
 		dev_err(bus, "wrong AHB base\n");
 		return -EINVAL;

-- 
2.51.0

