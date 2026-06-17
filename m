Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFE6CD98F5
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71B28497A;
	Wed, 17 Jun 2026 09:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eLBZ3QJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A29684994; Wed, 17 Jun 2026 09:07:23 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC10838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrZ5MUMUo6DWD2olEyYyZVvgw0zZWMMFy67GRRx0rWMxsMEdSnbg8QFQi76PL97E48h9ORlh60CfKcrEGzN/oNT/Zdj3cZGIje3rGTC8R2yijnyQtDApHoPW4tl/VE+0eoA7ohLnOAEq6ey5Uo00jv2Nrbu32Jn0PIbyNw6ku+gx6+ICp1gZXfblmelyF5Sb8Jkioq2wniUKpyxMCw4Jn5zimLXmkD7fzXHYPHPkI6bhM77ppQ8XSBiuCc/gxqICW8fvtku8WMDeZIK82x70tH+c5T7XJNoJJAwhJPCLm5Tni5Mlo/9xHfU0pNV9xYtBhARsPnaCv4s3qi2e32NNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtpmbUsgdBVyKGNB0ttTj4Mnq8dK7xGmQQGm6s8+czE=;
 b=BPkz2da+oO9wLrr3JZxAcZKr6hoO4XynyLdS8zUvP3Y6MB9M9+sOBo+nvGJ951LI+JwhM4OYTkrBA/thxDaWkatuWYoIH0F5WWaYWVqelN/lsUQ/ltfpVS620NIKqoliXThMJLP+17iv9W9jNw0bLac/8v249lsf88RbejxIJ1u+JRL4So2UbOOB685CFI4h88Z1gmaI6hxPDdGjTAnAQ0mgOz5UJ9XxcRcN+HyceHZv9EWQO09pxEEPrlSA5hBQkIzPRXk7ez+uYtyH6L+ZW+Q4QMHF3du/KNnMlI3EU39QS+LZbghQYDcL+/hZJiyB8nuyQ6oyv2or5Dnh6HJ66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtpmbUsgdBVyKGNB0ttTj4Mnq8dK7xGmQQGm6s8+czE=;
 b=eLBZ3QJFw5PkzKCU9Hhx3ZoIcPMGfKo3nRnZVoAUVoSFp9iZCeHBOF6ps194TIOK8V+FEile2XegSf7hgolH2//VKWJe6tMKDDeQBEIGicnXEItAvYLckf325k07sSpSjwtxUpHG0RnrG7S2ZDeizhqbkCPrU6I6s1e9Ba47qtsiJVcJBWS2DsZ6AUAYqBriGGJRMNnxrVxwGLsaAxzUyZNMbda5OJgI4LY6Jf+ZMIcgZrJ+GXOJQxDIPtcJjavnzjqTB73DuilltUvagJNRyFLMYUScJX1ROR1UJ+qssii/z1Hf28QfgfCxEVDuVXzXrsN/TkWTiJEGVBAitIph1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:07:19 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:07:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:10 +0800
Subject: [PATCH 11/11] board: imx8mp_evk: add USB Type-C OTG support with TCPCI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-11-b824fe1e9299@nxp.com>
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
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 02540d8b-cb2b-443f-8801-08decc3f11f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bMcOiDFspW3cInxki/pQ8VwO/d684wjm+GjDXep4rgRSab6lpn7mgPIamfXj+rNKFurBtq0Iv8j4nVnMc8Kl6uEdzJUfJAOqZftOwk0OFDLCyAI8uWMWz/XC+aSaisoNIjjAz+RC0qeFgJoUVxVFM7URK/k0mO/Yl4GjaDmw037tqmWLMxdEF7XPIguFwEockplvc9B139RQO7dPSZ8gPabAh2Jwi4F8MbBMcuDXsBEH0e32TRryYwbn+ATxKFwxpp+Et1D9hzEJtSnBnpqp6MGQeV4nwh1Nd2DxLedIeXYKJLaU7fhwboDf++bqwIEK0LZrGZkWN6qds51h5mTy0yY2l5d03oUbZUQhub8gl3Sb4BIJmoEbpIi/q35nloUG6oKvR1wc6YTYbAy7TZeIILyVLNbOWGJ3KS5xN/SwPpLJxS31ZbUucJUz3Ds4FjTz+ftQ+StrgaVkUJ/rLLqlScgRMWudxMwJnDW+tr4a53gnQf/Bsqjn76EWAbKHlvcbXZc/DoZxe+8dLHVYXAvLRHcbODt0sg8aUvXU5XeSJmHzOTflOvkg/oyQA0DXEvTBgKNEbh6QSfVIVcb1aQwWK5fyB4iuL+ptbI9arWEwYOZWHRgseo40+xx+VvhIWVRSRH6AW57OEymckB7UvU1q4dio3uw47uyFm0Cr+nTSEZI3FpGDhlPs3YczQAf217op
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3YxcHNHTlEwejN5NTgrMCtoV2YyR0RXRW95cnpiTit1bGkwMG9PWTNSNDZ4?=
 =?utf-8?B?WHBSV0JUR3ZzT1Rucm1KbExzZ0V2WDU3eW90djZwMldnRTN4TWI1cjBFNXBI?=
 =?utf-8?B?UStMSnNTajhMUnkzeU51OUxQTGhKa04rOS8ycmlaengxOG9iMmlJUjA4dGU1?=
 =?utf-8?B?TGtlZno1eXB5OUl4a0VxaDZ2N1djaHc1TFVoK1QxUkg2MjBoejBBbUMwRXl6?=
 =?utf-8?B?K3lVanVHOVlUTDIwd0srYzIxSjRlVUhkRDZibnQweHBhM05Odlk4QnJhNUNu?=
 =?utf-8?B?UGNRdmtlYzR5S3F0NFcyZkpvaDBPSE1oUVRYazNvMTZBTm1QejBnTVZ6NytU?=
 =?utf-8?B?c2RoNTJ3SUtWbWpONDdZMWYwWFdTL3Y3cGZpSWlnZUFHaG5TcElSL2FOczc3?=
 =?utf-8?B?ZVNxTWdZalp0Q0tSL1dSZVFmYit5RnYrR3F1b2FMY0p1VU9jUm11b3B1WHFW?=
 =?utf-8?B?bDBOV1JqVWZOcDJ4WGZVcWFjeGhLcWFhYUlFTG9JbFByUWFNaXFWU2ZMMW5w?=
 =?utf-8?B?YjlndjFoUzl2YTl1emtiMGloekcrWTBxdDJHTFc4SjViV09lWXJlRkYreHZS?=
 =?utf-8?B?SXk1c01MRFJXUEo1RFJDVzd5dWF1emc4RDZwbENldXVPVWZsWjFvUmpUeWdo?=
 =?utf-8?B?citDSXdRQ2luWXUzU3FVZ3UxN0FCdlVOTEFBV1hVQUhnRzltZW1vS3V6cklG?=
 =?utf-8?B?enVaVS9nL25Oek1tamYvVDB4Q2RHSW1IVEQyN3JaUTFPSGhMVXhsWjBqa01K?=
 =?utf-8?B?cUFYaUdPRmpmVEp4YktQeUhFV2ZuOVJzRGc2Wi9adjQ3YkpjZUxPRng0MDQw?=
 =?utf-8?B?RHVyTXB5c2lFcHkzTmFNV2V1OWJnZVJLM3Q0SG9qbU5NWXpWNlZiT2tqVlFi?=
 =?utf-8?B?bWxRY1Y0WFAycHJORG5WRjJIOHJMaDZRNmN6cXNjY0NNUGFTQzg5S1NTbFU4?=
 =?utf-8?B?eG9xUlI4b3F5R3ZTbDZqK1FxWGY5ZXRybkpKSSt6NnVkbE5IN25FREJ0SHVk?=
 =?utf-8?B?S1JOTmhuR2lSS2lOM2RneDFKWVVmV1Erd2pTaUw0UVNlMnNSYzdOV3hjMkh5?=
 =?utf-8?B?S2FPOENsNGJFOW1xMU4vN0FZaWlSYlZ0RGJDM1lpYklSTFR4UVluR0dUWFhP?=
 =?utf-8?B?WGYzMlpqWUFkektRYVJJamxBc0Rqbzg3c29jOXBuYW8rZlFnTDVKL1hTQUEx?=
 =?utf-8?B?UGJ4bFc5c0p4RnE1NXRJUC9XQndsejVBYWhJNUFKdkF1STZhRGdpN1hTK2tS?=
 =?utf-8?B?OW1VWjFxNzkxa2ViTDhjV2tLZGFFZEhmUFZBUFdlZG4rOHp6a0FlQjN4aW91?=
 =?utf-8?B?QzMvRzRuMnA4Uy9aeWtnZ2JKWFNNQWxkNW1odkJXaG1kRm9MK240NStTVzRE?=
 =?utf-8?B?SUxHRjJjZVVDTlIvRitmVTJja1Vnd28rOU9mZnQ4aEFKNnRQNERGQXllcmdt?=
 =?utf-8?B?OUtyT29xOTNvM2dUZGpyN2NJZVFDellJU1c2aHZ1bmlYdnFTS3lnNDV1YU9P?=
 =?utf-8?B?WGdNMGhRclc4K1hWRmNwYzAxS1MyblBEaU52RU02bVJPZzVvZlZ0KzNtZHRu?=
 =?utf-8?B?bUs3WUJzbkVPd0ZHTENGeGRkNjd4eWRwQ2huTW8zM1N1cnRQQ2xiMWpnYkNF?=
 =?utf-8?B?VG1XODNOSmU1WHFjeUcyUnEyOUxYdUIzbkdTczJCZlFrMnltR2hUVWV1RjhQ?=
 =?utf-8?B?VmY3MVZVNnFsd05sbVZITkZnK29uYTdzNVNyRnZmRU5NVXZuMEIxSDdLQnBE?=
 =?utf-8?B?ZUQrcFR0TkdpMGhmUjAxcWxCeWNKbUNaMGpYcmw1dVFKZ1FDcm5rbEJEbnVN?=
 =?utf-8?B?bTlOOXEwWE1QZ1d0VFdBdm1tQmVXblJmUFRFOEo4YTA2dHIrTzlmUlBnd0gz?=
 =?utf-8?B?QjBpdlA3bGZ6RENUSWhNajQyNWI2a0xkbzI1d29uMkJSZ3BoVkRGeVdlUUdk?=
 =?utf-8?B?QmZuWXFBN24vTkNkbW92RDZrOE5vWXRLVThIUVE1MmRiTFFIUGJUaVJ3bjM0?=
 =?utf-8?B?L3gvNitUaEIrZHlJYWtGU056WTd2OWlySVUzOTRmZkU5RHJXcjBiS0xnRlIw?=
 =?utf-8?B?czBRZ0kzSk9FWGxFZW83MC9ZU3BORHRnamdSbnRKdWczT1hnUlpTelpkQXdZ?=
 =?utf-8?B?R3FSZVMzaW1na0hWWUlMdXVzMzU3VXNjNGZDaHl2NE1wc3RPNXRkVVg3Qko2?=
 =?utf-8?B?WjUwcHl6VklRVVRXZHFpV1BCRUx2UWlYMTdaVk9BSmtXdE96dzRIV2g3N1lN?=
 =?utf-8?B?VHh2dzFGUENTSzRDVTVyVW12eWlPY1pXQkprU3RTU21Ub3I2LzNnUTBhUlBH?=
 =?utf-8?B?Y3B2WFBkMmJCaVJoQVR0QVR1VHNOSkVaRkZtQVk3RlVCY1ZFanVhMStjbHNu?=
 =?utf-8?Q?ZA1R4oqmp88cYfCgpVBl2z5dOhq2zui7yVRXF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02540d8b-cb2b-443f-8801-08decc3f11f9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:07:19.1591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUyPnJG+Q7BILk1vYTNX+qzSosY4eTqf8zTryV9jEXnxLtcx22u13hTl6/4Em0hIVaiwI866wHDXqkqxV7kq6M9FrPo175C2K9GdXi6q/XeuIb9ZnWdMZbZGfMLG/0jB
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

Enable runtime USB host/device mode switching on USB1 Type-C port:

- Add PTN5110 TCPCI node on I2C2 with pd-disable (data port only,
  PD negotiation handled by port2 on I2C3)
- Set dr_mode="otg" on usb_dwc3_0 with USB PHY tuning parameters
- Add board_usb_init(): host mode uses tcpm_setup_host_mode(),
  device mode uses tcpm_setup_device_mode() via TCPM uclass ops
- Add board_usb_cleanup(): disable source VBUS on host stop
- SS mux GPIO (GPIO4_IO20) set based on CC polarity
- Enable USB_DWC3_GENERIC, DM_USB_GADGET in defconfig

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mp-evk-u-boot.dtsi | 34 +++++++++++++++-
 board/nxp/imx8mp_evk/imx8mp_evk.c   | 78 +++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
index fc9e9da09dd..d315dfb3d03 100644
--- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
@@ -88,6 +88,24 @@
 
 &i2c2 {
 	bootph-pre-ram;
+
+	tcpc_port1: i2c2-ptcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C-1";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			pd-disable;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <15000000>;
+		};
+	};
 };
 
 &i2c3 {
@@ -124,7 +142,15 @@
 };
 
 &usb_dwc3_0 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	role-switch-default-mode = "none";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
 	status = "okay";
 };
 
@@ -133,6 +159,12 @@
 };
 
 &usb3_phy0 {
+	fsl,phy-tx-vref-tune = <0xe>;
+	fsl,phy-tx-preemp-amp-tune = <3>;
+	fsl,phy-tx-vboost-level = <5>;
+	fsl,phy-comp-dis-tune = <7>;
+	fsl,pcs-tx-deemph-3p5db = <0x21>;
+	fsl,phy-pcs-tx-swing-full = <0x7f>;
 	status = "okay";
 };
 
diff --git a/board/nxp/imx8mp_evk/imx8mp_evk.c b/board/nxp/imx8mp_evk/imx8mp_evk.c
index e17100e51ec..37a391908c4 100644
--- a/board/nxp/imx8mp_evk/imx8mp_evk.c
+++ b/board/nxp/imx8mp_evk/imx8mp_evk.c
@@ -4,9 +4,14 @@
  */
 
 #include <config.h>
+#include <dm.h>
 #include <efi_loader.h>
 #include <env.h>
+#include <init.h>
+#include <usb.h>
 #include <asm/arch/sys_proto.h>
+#include <asm/gpio.h>
+#include <usb/tcpm.h>
 
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
@@ -35,6 +40,79 @@ int board_mmc_get_env_dev(int devno)
 }
 #endif
 
+#define USB_TYPEC_SEL	IMX_GPIO_NR(4, 20)
+#define USB_TYPEC_EN	IMX_GPIO_NR(2, 20)
+
+static struct udevice *tcpc1_tcpm;
+static bool usb1_gpio_inited;
+
+static int usb1_tcpm_init(void)
+{
+	if (tcpc1_tcpm)
+		return 0;
+
+	return tcpm_get(0, &tcpc1_tcpm);
+}
+
+static void ss_mux_select(enum typec_cc_polarity polarity)
+{
+	if (polarity == TYPEC_POLARITY_CC1)
+		gpio_direction_output(USB_TYPEC_SEL, 0);
+	else
+		gpio_direction_output(USB_TYPEC_SEL, 1);
+}
+
+int board_usb_init(int index, enum usb_init_type init)
+{
+	enum typec_cc_polarity pol;
+	int ret;
+
+	if (index != 0)
+		return 0;
+
+	if (!usb1_gpio_inited) {
+		gpio_request(USB_TYPEC_SEL, "typec_sel");
+		gpio_request(USB_TYPEC_EN, "typec_en");
+		usb1_gpio_inited = true;
+	}
+	gpio_direction_output(USB_TYPEC_EN, 0);
+
+	ret = usb1_tcpm_init();
+	if (ret) {
+		printf("USB1: TCPM init failed: %d\n", ret);
+		return ret;
+	}
+
+	if (init == USB_INIT_HOST) {
+		ret = tcpm_setup_host_mode(tcpc1_tcpm, &pol);
+		if (ret) {
+			printf("USB1: no device detected\n");
+			return 0;
+		}
+	} else {
+		ret = tcpm_setup_device_mode(tcpc1_tcpm, &pol);
+		if (ret) {
+			printf("USB1: no host detected\n");
+			return 0;
+		}
+	}
+
+	ss_mux_select(pol);
+
+	return 0;
+}
+
+int board_usb_cleanup(int index, enum usb_init_type init)
+{
+	if (index != 0)
+		return 0;
+
+	if (init == USB_INIT_HOST && tcpc1_tcpm)
+		tcpm_disable_src_vbus(tcpc1_tcpm);
+
+	return 0;
+}
+
 int board_late_init(void)
 {
 #if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)

-- 
2.51.0

