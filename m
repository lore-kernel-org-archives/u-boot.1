Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3524ECD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7F9C838BB;
	Wed, 17 Jun 2026 09:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mxmF2qqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E049484954; Wed, 17 Jun 2026 09:06:22 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05AA5803F0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeF0IvCXVtjeETTrOLhG0LAC4vV16lay057cZftTxdMt0GOYdkAPeeL0iVUgdHKLbTEWy7Wh6+HmVq3strbYjoOb4rVDom/+ONgfeXgoEBBf6gYuUO88dg8B4zYYzzw8YBDT+GDL0iFVkTF7y/ClqwxVXk6o8qPS1Ud0Qg1V2nbi47oHUPyM7g5DFHH/l4f9yzZexHr1yyg7GJep5rGYippSsr4Rz2YUg0ek8OSsxXVorXOgM7+hwJxBS1jI1DE+aaVvoA7s6ATuag4CPIEvev1/QkMeu1uYjODL6EEmjgrrshoMMIXnkw3UFBgoxEMa6E1Dg2QQ2sPp+1Hjlc9etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcYYhTqjxzSz2wBLRp/CNf+2WRYcAhpFLYQ8RagNtYU=;
 b=DlL9vjdnV6hT1mBVgDcv1unN3HXfi+rOeNx6NbyWCF4V/s315QoVVp4UuxcsXna0NXUqfgRsXLHsXV4ErGkhozFz1oqGX8mg7xs4qPDzxvCZ0huQdW8W8dS0ho4Q+UE6MkYB24x6W8YbuzILtKClSGozlD7bULurDwyDjsSXrfXMfHakcC/0zwtUz8Hz2TSCl3UuD3k1TEM4lVJWpwvt1ljemOmt5DKmUEzngl4+phlDY6Vnpxzg2wwok49y6FqDFbZKXW94RzOxEJeNIUTWgqvtqHkLY5WpjcCruvVPau/eUpz2wfFRJ0Uy+KED/h6AtKQEINQM84X54P73J8YwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcYYhTqjxzSz2wBLRp/CNf+2WRYcAhpFLYQ8RagNtYU=;
 b=mxmF2qqOqpSGN8xI7zjIP3+8NHDKJ5Z12S9ln7iKqjn9KJTz70OdEadN4IZGsX2o+MY4JVQthVy2gpTJ79OfWNVnALCv0rnO7niljrvFGqROIcpPVuAVX6bHZZWlRvjdZIjoSsYg2GYNBsHTSOGSwERvdDAROoke7+qbqZF8Z4x3B8rlPSH263NwW6m9F35EszGS8Mkg0t6/Rb2YV0+JMUKms62DXwXUw4JdGYGlJZGFNV1K+n4mB2rChw5qBw+Taqtf2HJe/P/k+WnBuXPu3+eRMjKRDJ7qz0qahuYlNTRO57GIo5bqBDkTpd37T4K0FOlcJ7y5DsmPbT5TaAkPYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:06:18 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:06:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:02 +0800
Subject: [PATCH 03/11] usb: tcpm: continue polling after PD negotiation to
 handle source messages
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-3-b824fe1e9299@nxp.com>
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
X-ClientProxiedBy: MA5PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c726b8-4676-4dd4-5d25-08decc3eedcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mAf67oP8kLIZWRzHk4ABnFGfh+B4sI8aIq07ooWK634dJBcnaDP5fN+/K6laKp7HJE+8X4Cr20xLWt6/ZQooX2yHJqVlI0133XCU4WoSO3ULhqfKVzPCI3+dy8GWtCMqBj1Xj5R2FP93hG89iZEuf+FO7M6u9UNbl+e1wkLoIoyeZEDr9PISPPvaMONyk+Z2NTD8Mq0jmPGTBrCUC/n2sNUXbhPZQyE70TLiBmFdzjmt0ybgMa21Frt+uDfpu7PnbNqIvJ/r2dZloeW/xi2LQ2HSn72TLwEPyzQGq9mWmzskm50yu01xT2TCp6RR46R7Y1Xb7ktL2bevVGCQYmk4jkSDalPJ0N3+NmTVDqjGudeubsmcL65taC25nKyKKL8kR3a09OYQO9WghNN1Vd1VYFJ0+P9C1liD6r+I7tZhWTOImZ43X/KfsXhIqXN7VlpVm6fXaAor5rNDXODHMKH9XjGeqLWk4DlklW3Q23JrLMmCOuRr/s6+LrzkwlxidlrOSaY8sHvO3oJV3quAaSjbllUU9Eaw8A9H0koIsZcY8R+bgXeLkjSqFXdr07/rmxiynORhcYEG6s1pB7zTZJF8Ei79ydL1U8dC7PTeAAp575e+ywxQ0BtqKAO5cuMu6qRMlpCnDfXOZT2jtJJ593rvak/fzVpnCGmUO815jeSmvsd1bbVcwMpCweeNv8QBdEok
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUhHdW5rc3Jid2FkYVBFNXhVMld2T2tMb1BVc1FROUhERWI3Y1R3aDB3c055?=
 =?utf-8?B?UTVraWJ6SGVmZnF2TEFwWE5BWS9IOWtFWUxTTWxQcm94Z0g5TXpsKytzVXNk?=
 =?utf-8?B?R2hFakEwdHZaSkZwVWpvWWREYzNONFNnQXY3cE93ZWNWL1FQeUlNYktlT2JS?=
 =?utf-8?B?NXZJdk84M0ZFUlFGcUFmdGl1YU0zNkdqdGlMRkVYd1EwaTU3SGcrRDFBMGJo?=
 =?utf-8?B?TmpvTGkxaDgxWUwzSk1YelVteFVyd29tT1hOMnF2M2FGQ3BkM1BHRFRjVUFk?=
 =?utf-8?B?TzZFRHF5ZTh4Um9zZ3g1cEc4Nm4zVklWUUE3cE8zcVNZa2h4OEFTd1FLOXNy?=
 =?utf-8?B?VWdncXNkR3JVRTFVL0Y2YitoSE5NelZwTDZNOFV3OWw5MFJiOEFDb3JKck9i?=
 =?utf-8?B?WVlQVm5TeGIrVEl0QnBFNkdEbjVxT01GOHRjQUlRTlFvY0VUdHNMOEJBVHEw?=
 =?utf-8?B?d0ZZUWkzdDV3M05QZ1Exbnk1ZnNlaitKZWh0NDNkaHF1czBoNWdSbkZidGho?=
 =?utf-8?B?ZURLcDIrTGNZZi9mN3h3Z3p6OUdsZnpMOHFyeHc2NFVDajZLc0tLYWNuU0JQ?=
 =?utf-8?B?d3FFSDQ4WTcydnpRdUhBcnZFWEZzem92UmQwNk1mM2ppR3VHR1N6eXRrSmMy?=
 =?utf-8?B?MWtKTkR6bmhaQ29HUFFtWE8wd2tKdFhjendVZnByR0lxdm1xaSs2NmVwWGdt?=
 =?utf-8?B?eEhKcE1sakxZSkJyQ3l3YVhuMm0rbVFUdkVXbWVQbjgvM2NMajlDL2tLSzdj?=
 =?utf-8?B?c05YUDdPSE45ZlQ1YldOckJvWEdoT0dJRXBhV1R3bXFRSEdub05EcDV0R3BC?=
 =?utf-8?B?ZE0xQnZ0bzh0RzdOWUdENU0wWlQ3amprcWVVb3B3MkhuSklMdHRETkN5T2d4?=
 =?utf-8?B?QSt1c21EU3gwdG5zN1E5Szd0d0J4MnpLYWt5VzF0Qmd5MTh2Z0ltNGYyQzRx?=
 =?utf-8?B?VGFFYitXS3hwYkNpMkVNMXhHUFU0cFJQNlF2WkNnemQyVlkwWlNuQUJPZy9L?=
 =?utf-8?B?Vmw5NXpQTEhMd29JM2w0KzNyR1Zxa0dsZVl0MytMOW9CNDlPQVlRbm5jWXBZ?=
 =?utf-8?B?L0N5bm1QZm9JRk45OFBjKzVuejFGR29xampFQjQ4cW5RbEVTRVVhakdSUmpS?=
 =?utf-8?B?WWk3eWZ4N29wcWY3K3NLbFJIWGhrK2oyWDRrbzFvTEF3cTJFUTVjK1ZLeC9O?=
 =?utf-8?B?b3NzaldQeDVTeld6RTVsdDdOY3g0eGVodnF3TXpMNVpiMmlYNVo3M0Y3b0pF?=
 =?utf-8?B?ZSt0LzFDbGpYdW9HVGtKZWxDNlJMMnM5akNySmw2ck1BMkdPeW1RZXNBQS9T?=
 =?utf-8?B?cEtUTDNKRGpNOGRVWDFNdTYwSXIvZkI4clk2c2NQeVJHUUs5ZlVpOFNvL3k3?=
 =?utf-8?B?UXc3SXhDbjl4Tjh1bUpiUEVXSktKeWVLVG9ZbWxxVUxqWEM3N3V2Z3V2dXZG?=
 =?utf-8?B?dFNXQ2R0MXhZUzJZR3o4dURpTlhXUVU0WDFhaDBXanZPb2J5SUR5aVFISG9Z?=
 =?utf-8?B?VGdtcEpqNVdQOHRUcTVRTlhHU08yYTUwREduMVhNZnBsMkErdEVXcEFMVW1i?=
 =?utf-8?B?QThYcmtxSi9XYTEvSjR0ZWhnUE4zTWlRUktBS2czMkpDT1FCcHN6bHNZNVB4?=
 =?utf-8?B?K1dMeDQzdGUrdEgrM3VpZUViWExrbzd3ZmJzRnIxS2trMEFqV3FGOENxUDhF?=
 =?utf-8?B?NEd3MkVTd25XQ0NnRUExQ0Ryc0NTRXRXWTFOV21abllCVmEwczBGcURoK1lV?=
 =?utf-8?B?SDQ1MTM3Mk5ncHRIeXJHOG0vSmlZSDBFMjRQOXRrbVNxbHZoS3lrMklYNkdU?=
 =?utf-8?B?OUZJTnFsQUs0T3J2bDQvS0NmbG5BcmxkZlNlT2tGRGRyaGhvcGxtbWxkOUdT?=
 =?utf-8?B?cGZVUzcwblRVK055ZUZ0RVN4S1hKazlDMjZPQk1zQmxScThnRmhEeG9NdG9X?=
 =?utf-8?B?T04xZVlVUHphV2ZhVjdQOEIrOGNWQ2Nxa0tEVnorakdLaEJxNC84MGUwbG1y?=
 =?utf-8?B?RG5mWWcrUUtCRFp4SVVFSmpJdnIyM0VlOVhLUk1CbU92V3lCVStobkp4ZzB5?=
 =?utf-8?B?L3R4TGtIek1zNWVPVG9PN0JzTE5TYWs2UmU5aXFYckxJUUFiY2R2cVduMzNK?=
 =?utf-8?B?eEsxZkZ2alBEaEx4UmJZaGpSTzQ5ZTdLRXptRWkwR1NFZnVFTkNhTGRzN1Ex?=
 =?utf-8?B?RDdvcVNXWE1LWjRjZ21RYVI5NXVvWk9YM0ZTeXdYNHZCVlVPSXdCVm9Na01B?=
 =?utf-8?B?K3hDaWtSKzRtekExcldqM0tvajJVYkltdUkvYWJZNXQrSlREb2lTTXVJL2lO?=
 =?utf-8?B?RTNXalF4MEhvSXNrazZWVkhRTXA1WEJ4YUNMR1JQT2o3cG1xVXZtTzBGTjZl?=
 =?utf-8?Q?+AX+khUzWJzbJnwL/iUxV9NBKJ/G2wBdLZ9Ws?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c726b8-4676-4dd4-5d25-08decc3eedcc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:06:18.4323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPKs7czPie7w4fXBctbgMazEzOeNDEgQHVKXNH0/ZO48pT4OjbJPPGSdnJFJEdKi0vQvCViSIC9M8t0qQwhFZVxNKOrfXts3PFwLELooVnh42zopF1NEoxvw8wmvVki5
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

After reaching SNK_READY or SRC_READY, the poll loop exits immediately.
However, some PD sources send follow-up messages (e.g., Get_Sink_Cap,
Get_Status) shortly after the explicit contract is established. Since
the TCPCI hardware auto-sends GoodCRC for received messages, the
source expects a timely response. If no response arrives within
SenderResponseTimer (24-30ms), the source sends a Hard Reset,
causing VBUS to drop and resetting VBUS-powered boards.

Add a 500ms settling period after reaching Ready state to process
any follow-up messages from the source before entering low power
mode and disabling PD message reception.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/tcpm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 25ff0926cdf..d6af0fae7c1 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -2252,6 +2252,16 @@ static void tcpm_poll_event(struct udevice *dev)
 		tcpm_check_and_run_delayed_work(dev);
 	}
 
+	if (port->state == SNK_READY || port->state == SRC_READY) {
+		int settle;
+
+		for (settle = 0; settle < 1000; settle++) {
+			drvops->poll_event(dev);
+			udelay(500);
+			tcpm_check_and_run_delayed_work(dev);
+		}
+	}
+
 	if (port->state != SNK_READY && port->state != SRC_READY)
 		dev_warn(dev, "TCPM: exit in state %s\n",
 			 tcpm_states[port->state]);

-- 
2.51.0

