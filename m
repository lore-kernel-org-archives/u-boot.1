Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CCDCD4F26
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 00:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC6E849DA;
	Sun, 21 Jun 2026 02:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cUSw/BaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EE6849EB; Sun, 21 Jun 2026 02:50:27 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0741C83FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 02:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL3mFy4a25lhO7zmiNJpclyQuaQCZbZ06UDJCCAOvED/7wfZtrwBYdlwiRtvB6Q2VQATj6iFpfSveZkETEXtO9rSNSKFnDO6mrAiORhKtnJmkGibu8spBiQsslVD+xBpy7Ch7i+LBVZ4DMELTK/0plILeE+uUGzZnCF8sDZwY9WWkAX5HmwcDv4vJzaXE38rn4ATMPTkidM1f1Gzf0ky8f/MENrGrwCWDJ2VmdNsGwT2rlRr1iMTF8unmd0Xg9YtShLUjH22la6k0OY8k7oewbsfZ969qEflkShszm9dQ7bTzT/8Qxcpcdze4ZyobWPuyirBe47E+2w+0Cfvo2Y1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N24EeAp3W32/JP1H4H0XitvhJfTfZ1/YiBf02eVv2Lk=;
 b=Ql/AR4NelenBRZP62D9XsV+NIJg6B4KyUTar858LsrmXZdfW5c2OgeyAGNOl04Iz18LsTtXA5wU8olLMw/6e6QfVXSQoN7POcxU+u7JbUqxS3geb6B+cQn+kGwjUpoJo6xk04P8MfXdTm+DyDK59guCJrzPsLL3fIA5lhlSor+LazguZB6r+6ByKg67Krg5uppGFBM1ZgG/6i79rNJMPZHnu+c81I2R6e4glLC7NoQqitUOiPAGDmAl1/6RaMXR4YSzVOs8o7CUsfvxobrdpfMJyiOjXQLMupPLmkxDET+nFi3xFkbmJYAWX8j4/n/s4nO3T0agWj1cTGIb2YALrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N24EeAp3W32/JP1H4H0XitvhJfTfZ1/YiBf02eVv2Lk=;
 b=cUSw/BaFjOI8+SKNtziI0S+DLizZot6RUMUDGRDqhscRwMmRNmm7XCZyNI60TlujU+/pNwbllsJzPiv+Bv+KwKesC/vo2n2o2BIKFQFwlfim5jfAwPNJCQi82Stq5AZci9q7oqSaVyIZJKOySxkwXBN+K2j8xGmlJO7tsKTZ/gkWh44S78zxbq3kxnEgJnz7B9JS3qCWNONgJSS9r3yKfo1mRVudUZTg/Bl6HOomR2CFAmo2REwGrp2T1L/YAqGwhUfgxKG1CZ8WiSegokDKIuTziJ4HgeNzKt7dTicIrdLo+B2cLYc+hw+xTsSEqfF4TJUHOzdhYafZJ+C9nogVTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 00:50:24 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 00:50:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jun 2026 10:06:43 +0800
Subject: [PATCH v2 07/10] usb: dwc3: generic: add board_usb_init/cleanup hooks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-tcpci-dwc3-v2-7-990ecacc111c@nxp.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
In-Reply-To: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e22261-9647-40c8-a232-08decf2f142f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 3BRH2j+J65CL1Ln4nFl8lj5KMkymPGr1ck2e5Qtz2di01iQSr7jni9jGCs4vUYtDLhoRfXDO/axr1YzRAXa5Bn45P66+dgdFtQOp4L/k/BIhq9mT+YoYV9kAcZAQCUgAhDEH+aqFZq4QGMH9HTQ8ezpFJr7w2kijHxyP4FxMTJ/DBCNmUpJDmQOFJCVn9YxRR/DFYNd3yXvU3gRQQkLTe35ylBsl2pqCQqVfU6QoSO0N02k3z7gaTZ4VInLnUAFCFcTXJIxYSe659v4ciUlyBRJSSEPi432XucRMpOWoF332wQ6bwZV99eCzoHW/F1yy0gosYxGWl3hXniIbbU+aM86gmubIzrCGD3uCB358LEiz+COrtvTXGmGBvqvtNNfxO6F/3LO3Cp36DZ44rA4DuGP8xdB3/7ARFgpamab7FeeI/o0ksBhrNIEfCTBfkJmzmf0aAvDCz2SHOPtSsyjUOCe1nzLDCTlCZD7SHON7x89TdrBo3WKSiZyXdGmnlUgJ0MOy0bRxgdwbqnfLbtL4yxuo/WsUiJXrOj8+7/qvw05ZhY0O/LZaB+YQKv0DyBVl8jSAIrqwOfzdkJb1zWSl21HHcQty0juHHfd630Xdyom09jzA0m0uXoXFG30grWMs1t4PB4ZBpuJ2UYoolIUlZigo40mBGWiHvUSu9z5HebM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk9MYUZXRDBvcllMUEVvWWdLY1JrS1crNGhpOG92M0czOGkrdjJuVk90aktq?=
 =?utf-8?B?cnRQSlpiTisvUi9KQWF4UEcwL0VzVXdyV0NCNEJvYzBnTDFsektJLzU5cS9X?=
 =?utf-8?B?bHFVZy9COGpaaFZwc0QrZktSUnlwOG5GbFVMYW1XeStSTkJoTUtnN01pM1BJ?=
 =?utf-8?B?cDltMFM2eWhsOUpFKytTc0o4b0pDRk9yRlpLaTRwQ3NTY3YyN0YzcnlINkNB?=
 =?utf-8?B?enFUcldFbWN5UkQ3Um9rWGo0Q0ZTRTd5elFYWDhFNTdwQ0xuSUw0WUgwOUFW?=
 =?utf-8?B?dCs3c1gzR2FZRmZTWW1ZOHEzNjdCRTdlaFplQkdHdWE3T1VndlpjTHhEdktx?=
 =?utf-8?B?S3VNSG1xL3lTVEQ4azhyL3R2a29oczFJSUEybFRsUjQzai9LbXBkTU5SZ2Jt?=
 =?utf-8?B?dVc5dERvdTdyMXEyWW9yQTR2UVdRS0RqbkR2ck9YRFVwakNPNng1UGpVcytq?=
 =?utf-8?B?U3lZRVg3SmlsTVdDbndaZEd2d1orT3BlWmNweExGK2pFNW5SQlNjbDZKUmZO?=
 =?utf-8?B?VC9BMjFuWk1aS1NOSmpaU010MDIwTTBleHh0VUtwdWhpVmFQLzRLN2FUaXNi?=
 =?utf-8?B?WWt5WnUzaFdWeGhLNEdXakVjNGd3K3pDbVNHUGxQR1krTVhHNlM5bTQxSlJE?=
 =?utf-8?B?MmRTbjAxNnkxL1VMZTc2YWU5eTJqcDNoL1hWMThYeHFCOEVLR1pXaDQ3bmty?=
 =?utf-8?B?WEcrc1pxSzFUdW9rLzhNM1IxSnoxNEdUaG5IbGxlWTdNeVd3UW9kdEp2TUJF?=
 =?utf-8?B?QTdXZ3FUZ1NwN2pCNzZMUjBncldPQjZwa2grV0pOUlNOS0xqWVdzSHdtNCtD?=
 =?utf-8?B?blpFbDNOSHN0MGg3L29OMnlSZkNUNkJmKzdma2JzaEFRb1VId2Y0WGtoaHg2?=
 =?utf-8?B?aWsvaitiZ2w4Z3Uzb0RnbUpVZTRZd0RXZFlTY1JLRXJ0VlRwQm8zNlA5UDhB?=
 =?utf-8?B?VDVZWTVadCtOTlV5V294VzhMRnhVT0txakdTdHk5OERST0QydEpGMlZDOG1N?=
 =?utf-8?B?VGN2L1ZzV2dJRjN3dHEyQzYydElqUEdEbisvb0g2ZTg4dmsvZm9URERtSUVF?=
 =?utf-8?B?WDFpOXg1RHBudFRGOXBXVWxNWHZMd1FTRFpVUG9HUC9qd2doVStOSFJRcVJF?=
 =?utf-8?B?WVU2dGQwa2JDT0Jmd1pBNjd0L09Hb3NNY1pEMDBMa2U2TFQ1SUFoTXpvN0Y2?=
 =?utf-8?B?OU9MamM1VmJLSUwvMVJHcW92VFpxaGRyUExZbW9kc2N1cDJSakw2V0l0RW9D?=
 =?utf-8?B?OUw3RjIvYmF3RXpETmlXZTRRWXJHZ21RTVNHeStvZzdPQzZyTUVOM3hneXJM?=
 =?utf-8?B?cVFrTWRBNjdUMVk3MGdwcXlRMDBrLzFweEFSMy9iNlpaMDFYcEhweGtWd1pr?=
 =?utf-8?B?VWp1aHFWWkcrUlhkTE9YRzN4RFZkdzdRREtMMTVFNmV6MmNRNjc0S1B5NWxu?=
 =?utf-8?B?UnZib1pCUGwrKzZDS1NtWVRWQXdLYTVueU51c255N3h1amdQM2JuRCthYU1i?=
 =?utf-8?B?ZFRaWlFlUnpGdkJTZ2lKbEJMSHBlU0F0SEZyZ3puR1dlT3pZNWJTQ2VKNG00?=
 =?utf-8?B?Y3JCdjkrTHBxZnJ6UWo4ek15ejJjbzRuVjY0Zk1Hci9KQnZHWDJJYWZqcW1W?=
 =?utf-8?B?ajlxaUVDQjg4cmNIcHVmTnRCUlU2VThlcC81cW5UdU8xcXEraXkzNnhSZThz?=
 =?utf-8?B?NUFnLzlmY0IvVVhFYVZ0Z3A4Tnd3bytGVGZvUng1eFd5ZWxwUUNTZitXTEV1?=
 =?utf-8?B?Mi9yRGtpV0hRTHhEd3N5Vk5SYlJadkhGeVAyLzRGRWxaR1UwNUpMZHplM0V2?=
 =?utf-8?B?eXllNzYrY1BEbG5KVjB4U2N5UlJJTFpzNmtBSFlsNGJTYjhObmFrUnVZQ1J0?=
 =?utf-8?B?YldzT3Q5aHZhUkJnR08zVmJ3bDZqZ0cwMzdOZndRdGtnZU5aU1lmNTkyQ0ZQ?=
 =?utf-8?B?RzZlSVRmM2ZubnZ1bjJsdVdYT0J5M2pLOEVncVRvQ2FWQ2NUOG5RNWpRSms2?=
 =?utf-8?B?NnVpcFZmQ1FIMUk0MEJrUlpmOUZaenhNcUIxNlVyY1R4N3NJMjhtczYrV0p6?=
 =?utf-8?B?RFVyaHlGMUQ4azFzb0tZOWlhdWZTckk5OHBYVEZoS3haMGJyNk1nSXRQZWxm?=
 =?utf-8?B?eWM2NW0zWGRLWHhRVmJ6MUYweHhUNXd6bkEwTW1yQW4wd0kvTlpaUGdxL2ZL?=
 =?utf-8?B?c3ErZUFRNWlseUF0N3BrbWVIVXpaYVVtZ1RMNFowaEY2eW05SHdLbFJjRHBY?=
 =?utf-8?B?ckkydnRXZ0ljcFg1ZFZRZWo0UTlRMXpmd1gyaTBuODcvbXRZRlZ4VVdaVFVL?=
 =?utf-8?B?OGZIOVZvQmpLN1pQTGhLQlBTOUZDR09LSXhKVlc1ZkRCeUl0dzRBOG9nU1dD?=
 =?utf-8?Q?hLo9tGppGGOB1Gy6qi1BXJN0FM6zWWFrKMpBm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e22261-9647-40c8-a232-08decf2f142f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 00:50:24.3250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9PpfVkKURu7STIgIIZUQZCSpQY+CeYFQRwN7hOeX/b3gGexP6TzZ6alGi/VPomW9XC4r202n6WQBBP8ZPH/gepukypnliFqahwPBABsfbSMP9flUZv+04MTRWVFJXpY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
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

From: Ye Li <ye.li@nxp.com>

Call board_usb_init() during dwc3_generic_probe() and
board_usb_cleanup() during dwc3_generic_remove() to allow
board-level USB configuration (e.g. Type-C CC role, SS mux,
VBUS control) before DWC3 core initialization.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2356b3bc0aa..2c6f8e6d8ba 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -9,6 +9,7 @@
 
 #include <dm.h>
 #include <reset.h>
+#include <usb.h>
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <dm/lists.h>
@@ -118,6 +119,11 @@ static int dwc3_generic_probe(struct udevice *dev,
 	if (device_is_compatible(dev->parent, "rockchip,rk3399-dwc3"))
 		reset_deassert_bulk(&glue->resets);
 
+	if (mode == USB_DR_MODE_HOST)
+		board_usb_init(dev_seq(dev), USB_INIT_HOST);
+	else if (mode == USB_DR_MODE_PERIPHERAL)
+		board_usb_init(dev_seq(dev), USB_INIT_DEVICE);
+
 	priv->base = map_physmem(plat->base, DWC3_OTG_REGS_END, MAP_NOCACHE);
 	dwc3->regs = priv->base + DWC3_GLOBALS_REGS_START;
 
@@ -134,6 +140,7 @@ static int dwc3_generic_remove(struct udevice *dev,
 			       struct dwc3_generic_priv *priv)
 {
 	struct dwc3 *dwc3 = &priv->dwc3;
+	enum usb_dr_mode mode = dwc3->dr_mode;
 
 	if (CONFIG_IS_ENABLED(DM_GPIO) &&
 	    device_is_compatible(dev->parent, "xlnx,zynqmp-dwc3") &&
@@ -147,6 +154,11 @@ static int dwc3_generic_remove(struct udevice *dev,
 	dwc3_shutdown_phy(dev, &priv->phys);
 	unmap_physmem(dwc3->regs, MAP_NOCACHE);
 
+	if (mode == USB_DR_MODE_HOST)
+		board_usb_cleanup(dev_seq(dev), USB_INIT_HOST);
+	else if (mode == USB_DR_MODE_PERIPHERAL)
+		board_usb_cleanup(dev_seq(dev), USB_INIT_DEVICE);
+
 	return 0;
 }
 

-- 
2.51.0

