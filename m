Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A05B103E300
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 02:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CEF384083;
	Thu, 12 Mar 2026 03:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cx8FokOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5542840B0; Thu, 12 Mar 2026 03:17:49 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6986A8407E
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 03:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIbW4lTaddtU76iZYjpP3qerB2VYdCj2zC6nrba5jhD3GenozWJEhjHLsqcnG+RncK+NjaVise5ZW49vHDBDbwi+5bnMhm5JPGQfjS+HkqZ3MAynhvyOUvaPuo+07iVYYd9KD0DIEvAsZGSjqsQd2qP/tgbHUgR/6EYrZjx3/hk6VtvbycCRdsnms20pkBpyMQtTiYWrUf3eDyHN9N4sMPm4HlmxkMoVjXjN1G72o67gMvrP111WY3JajyE2XDHyex13mErinK7CP642HPwhEkw/8CjP9QV6SYUwYLmf5GQgSYyvn4BJsCIqgqfJPiaVKuC43VjIrMGmo1OJV1AT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7Zcx7zX/9MI1dg6ejegjQWng7BhUhzMExrs3BIlVrQ=;
 b=LcCN4mpozMQVB43rtDCEeXjS34YtYD0AN2g+6tAuIhHS6/DxwsVqrZgz1lXnnRiDrwZHUgdJ3EEzUp6AKS6CahrKBwPRdiqRg7XuL3QrJ+Isvv3Sygq+/C23oNEkTjgX+fWvnKCctOsbcXgSjgj04F8pWmUKjlAXXh4VUZHX/5fjl4tS6irpcBxXU7dncsSa6ZM7QjBGmqVAwOTyV+o+tQ+k818Ub+hMeJviSPwi/eF/Vg1L98BM+IZdUg2sWqZSX/W448XSTvqDjdvUcIXUC3JCwhy/omVbhzIkYVgHU9gMy+bE4MQ1tFPLJH+ZuPtXF4unC2hQwVOynPtnX8EKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7Zcx7zX/9MI1dg6ejegjQWng7BhUhzMExrs3BIlVrQ=;
 b=cx8FokOgVeptqtVApZSBTTR3x8EFY8Hl1AyoA+4USJfwVaul5Dl+3c2e5AKWYngrnv8zDxCmpL1lsYq81vZ9evZKcuC1yZ8PlRSXvNpZSzmI2jWiKJUWKkF3yd779lZMWSk6UKomqNR+oid3dLLWPqYc8HSqOQz/g76K1cr/kGBzRBtGEdDGJNQI4bVrGNrlsQ1HJ0bSm9Ib9fyHFHQn+RLQ1OhL7apVn2lxl9nSGJQhdwEdDaVN9XVGl8l+Wb2+I1QPyIAQiywmPVQgdUz3FtHVRf5oZmXEmgLQTHrOfI8Scfm/XD/uvfF0CAO+C2dY8eEdPFEITRslfCQnjMGudA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PA4PR04MB9246.eurprd04.prod.outlook.com (2603:10a6:102:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Thu, 12 Mar
 2026 02:17:45 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8735:53a0:b36f:f559]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8735:53a0:b36f:f559%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 02:17:44 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 12 Mar 2026 08:57:25 +0800
Subject: [PATCH v4 4/4] imx943_evk: Enable XSPI1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-xspi-v1-4-375b8c444dbf@nxp.com>
References: <20260312-xspi-v1-0-375b8c444dbf@nxp.com>
In-Reply-To: <20260312-xspi-v1-0-375b8c444dbf@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9636:EE_|PA4PR04MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f1f951-21b2-49c9-5f43-08de7fdd8be4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|52116014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ICYhA8GC6tCEDHVCBq0j7f/aI8zUFV3mDpvO3diFDxx1rPcS5F2r8BQJLj6y6HOgRvGUgoG7gFRZo7BYuCG7ZVMWvRCQSxIZXyAKNDbKBZ1OvuTiU0+4B3c1g43d8GQBF37reB8ipbQq+6+X9rW0MXgXtWAs4PU55IK3QWNs+iMtZwDEueWeGthnzRJ8Ngn5rXnM4v2XPqCAO93eOJ4kvQYJUwJdOtUIfeFIm83gqBnMxVS3HMTaoUnmsePhc3e4cXyyeJSWOZSCEIzt9o/TPzRwliQ6CKH1z0aR2uFv8HlmhmJvD4d/XKv48+NxS5Id55C4JcF6e31cJJuQz72+u2rhcpnbyqW04RtjZK8Fu28xnIpYXLZyK69TFOd6GYzzXpXycPsIf8dlz3UrAKi5eJjWy4mWN3PDqEzPiru95CAI2hTNySdt0DU59V1KMS1lC6onSO2o3qCwxQDIhueEwSgir7aR/Hopb3kaskqCbuv7FvPA2dL19q0vB5Z7pKIaVMZtF4Lebw/EWhg90dWZlhd1gUJxh4eRqZy+wKeQBTzb2XioOuhZODOwIHQfcGvyLBhcNbSns14bKj2IjhYUfmp4etSNpmSxakoooyvnU7fkOXwYr6aG562IJp6z+x4ioyEjgLayG3Kam6nyoEZ56WbmdYVLHv6e5DVWKgSskz1Hk1Ytqq84Fu4ERjqIujgr5DCfFqRexsJQ8EXc69gzRDxrJq9OUh7lr5m4Kaux4O7xcRjkLdLv5xuW2ODLRZXLzGDLysh3Z+pZqz7VrgwZOXxa6KW6YT1jKt/AeZNgbJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUdjZ2V0U0Z2MHdXdkhwVTJIRE1zNGpjc0Y5U0JvRjJWSlZFYm14RHVDd1FE?=
 =?utf-8?B?Q1hyUWx4K21QcWxvVGpLZjl2b1dwek1Dc0MwR2V4S01DelBKUmQ1RlhLWE9p?=
 =?utf-8?B?V2hUQWdsNnVDeVNCRUUzaFJMc3I2RUM0TDI5L3U3eFRJaCsxTlRMQWh0ejB2?=
 =?utf-8?B?WVJMam0rNzlpYUhUb0dFQnhoZWdOZEwvU2dUZ2xzS1Z1ZjgzR0o0R2dvWGxz?=
 =?utf-8?B?UXhNT0NYZWlqbTAxaFpZUjdBcktuZHJnZ055VUtpZGxsaDg0Y2NaekJsSFMr?=
 =?utf-8?B?NkhEZlp2QVlkdDA5UlJHSGF1bGljdm5KMHJkNklWbkRtTmgrcDF5MFpSSEhM?=
 =?utf-8?B?NTVqL2NBRnQrSm5BUXZIVmxXdTZvTlVyR001aC95VEkzQXR1bWVtbFpDTklD?=
 =?utf-8?B?Q3ljUERDVkkrZVpnSUJudkVVc2JYSnp3MVVJYkUrajYvS3I4aXV3NkJ0ZTJV?=
 =?utf-8?B?aVBCSmF6TjhGcFdIalk4SUw2bkRsOU9HVDJ0VUdCb0t1akFGWVJKb2RYT3h3?=
 =?utf-8?B?NnZjdXJ6dW91RmhnM3JoRHlja3VDaVJOaWtyTTVFV3F3czhHb3BsSFZpaWNO?=
 =?utf-8?B?VXVjOXpKSVJxTTFHakFzdnBlcWVjcDVibjZRUGM0T25jcFFmbjFWSVVKOEhs?=
 =?utf-8?B?NEgxTWg4MDgvSDJuWUtXcXdYT1U3ckwxcERqYjBuVGpaSHNRMHRKSjdDSUwy?=
 =?utf-8?B?T01tTGNmdWh6UzJUQXh3ZnhFUk43TDllc1hFSmdVd2w0Y081V0YySW9ublEw?=
 =?utf-8?B?clAvTUF2S2tGZ1p4VXFQcGZtZlNmL2R2QXpNeGo3eWVzNG5GOTFEWUF2OVFm?=
 =?utf-8?B?K1JhMDlmNll6aXN3c3EvUXFTcjZ4ZkNLb2pxRUd2WS9Ua09tMGVzQ2RpNVU1?=
 =?utf-8?B?YTBsaEcwUW1XRk00MCtGUzN5Y0Zhb3J3b3U3OGhiMGN3TkMxb1I5UldrcllS?=
 =?utf-8?B?UU55YkdSODF3VXhTL1JpSzdSZVRiZDhEajZUWUJWeWhYQk9FZFVCcmtxUmxV?=
 =?utf-8?B?bUlnVDN4V1I2UzJUQmU0aTlNMHlEMUNBRm8wdHd5TlVpWVcxVmlKTnQ4V096?=
 =?utf-8?B?OUp2MUNsZTA4Y0p0WmZpWkZUY2YwYmdGL3hLWEZEOHZUeDl1eUMxQ3RFUEd4?=
 =?utf-8?B?UUpqb2txdWZpTUJmY0o1d3NUbG9KNVJwNGg5MTJ1a0NyQ1kxamF6RmpCSElP?=
 =?utf-8?B?RHJ3WDd4OWdOejQyQ2JJUUtpR3hHQnphK1R3QnhEYnN4MUZiZ2F0QnVoRExp?=
 =?utf-8?B?MVNMRmlRUUpjUUk5bEJtQWhldkV1UFdLQU5zcGh5U016UUh0RXhqS2NUems2?=
 =?utf-8?B?OXduSHZjYmVQUEQwZmIzem0vYm1PRlc3ZjcxbWc0VHUxWkZrbzdySGQxWW5L?=
 =?utf-8?B?T2NWaXk4K1pKMGFUR1ltdGkxdmlqOEZzS1Evakk3N3ZiZzFMVmdFMll1Y3hN?=
 =?utf-8?B?UC9GRjlkTDVmSUNMcXpNTHJOV0x1eEJJYTJVejBBMkNzTGFhcWJkMURTTzN5?=
 =?utf-8?B?d2s0bGs5cjFJQXR6RlA2aGV0OGw2NmF1Rmg1VDRIenhuU2FmYk5CbkI5Z09F?=
 =?utf-8?B?MDBPRGx0QVRUdjl4eW5ncXQ5SDlPVHVlRlMzTWRZczJZYy9HYlJvSzcrelp0?=
 =?utf-8?B?MndvYnZ4WDJrd2FHNG9xNklGemIvUHZ2ZGpKSDlwam1hSVp1VHMybFBXcEx5?=
 =?utf-8?B?aWl6dHk1VmJBVVhHOW1UWlBkZXVkZjV3VGJUUjJjQ2NEVVNzNGZTRFNJWWwv?=
 =?utf-8?B?cldyMHhsVVl3QlNtMjNUUUxvSVBlUlQxT29aZnAyTDkzWFR5VXNJb0VFUDhB?=
 =?utf-8?B?eEtmTE5kRzBsUlV1cWkzVi9aNUI5Q05YTnRDa2RLRTF1SVJpUjZKdFRSMGFP?=
 =?utf-8?B?dkNlUzNrWG1tcytieTFFUk9WdXpVbkt4TVloYWdtQk9Nd2hNdWVRTDJKcHhq?=
 =?utf-8?B?dnFVMXdUSmpGVTg2aEEwQ3VZdXBHeDRGS0dUeHVhL1IwLzdyVUVwMU5LSjdZ?=
 =?utf-8?B?U2Vnc1FCZVFnd29uYXY1L0R2KytOcCswQ0IwM0xTU1AwRWM2Y3NLNXRCYXI4?=
 =?utf-8?B?MmRqbUMxZG5CdDdDVFY1S0JYQ3hDM1lXL0tSdUt2VTBhaTdxRWxLRGpJa1Vm?=
 =?utf-8?B?UWM3UDIxQW5ZWDNVRVFXS0ZGVGFNeEhEYWhTSUlkSGRtWmVLSm1STWxXVWZa?=
 =?utf-8?B?c24xa3ltUXNqOEVsd1RleWxmTE1XVFNrQnMxWmR1a2xjdG9ZRGJBMlpiWkky?=
 =?utf-8?B?dEpQZnB3eEx2MW1JUGZtckpaUzBqV0Q3QjFZKy9jTzA5VHNwZkw2eW9hQXhx?=
 =?utf-8?B?RnB6K1c5Vlh2OUs0SmsvYnZGM2xpMncvdlc3MDhueG50VUdnY1RNdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f1f951-21b2-49c9-5f43-08de7fdd8be4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 02:17:44.6233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCoUaBlsJkbuuGVD2Uf6dJ9lXQidywUaIy0CvapMIgr0fdjm/G+rCnBW1VoZBNh0jB4wPCgxAbkKAePPBwAqBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9246
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

From: Alice Guo <alice.guo@nxp.com>

With this patch, XSPI1 are functional on the i.MX943 EVK board.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 16 ++++++++++++++++
 configs/imx943_evk_defconfig        |  9 +++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 528b3b02a3f..247a7ed6838 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -157,6 +157,24 @@
 	status = "disabled";
 };
 
+&xspi1 {
+	bootph-pre-ram;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_xspi1>;
+	status = "okay";
+
+	mt35xu512aba: flash@0 {
+		bootph-pre-ram;
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &scmi_iomuxc {
 	pinctrl_emdio: emdiogrp {
 		fsl,pins = <
@@ -205,6 +223,22 @@
 			IMX94_PAD_GPIO_IO17__LPI2C3_SCL		0x40000b9e
 		>;
 	};
+
+	pinctrl_xspi1: xspi1grp {
+		fsl,pins = <
+			IMX94_PAD_XSPI1_SCLK__XSPI1_A_SCLK	0x3fe
+			IMX94_PAD_XSPI1_SS0_B__XSPI1_A_SS0_B	0x3fe
+			IMX94_PAD_XSPI1_DATA0__XSPI1_A_DATA0	0x3fe
+			IMX94_PAD_XSPI1_DATA1__XSPI1_A_DATA1	0x3fe
+			IMX94_PAD_XSPI1_DATA2__XSPI1_A_DATA2	0x3fe
+			IMX94_PAD_XSPI1_DATA3__XSPI1_A_DATA3	0x3fe
+			IMX94_PAD_XSPI1_DATA4__XSPI1_A_DATA4	0x3fe
+			IMX94_PAD_XSPI1_DATA5__XSPI1_A_DATA5	0x3fe
+			IMX94_PAD_XSPI1_DATA6__XSPI1_A_DATA6	0x3fe
+			IMX94_PAD_XSPI1_DATA7__XSPI1_A_DATA7	0x3fe
+			IMX94_PAD_XSPI1_DQS__XSPI1_A_DQS	0x3fe
+		>;
+	};
 };
 
 &pinctrl_reg_usdhc2_vmmc {
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 2b93ba9a38b..3457442a3b0 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -141,6 +141,22 @@
 
 &aips3 {
 	bootph-all;
+
+	xspi1: spi@42b90000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,imx94-xspi";
+		reg = <0x42b90000 0x50000>, <0x28000000 0x08000000>;
+		reg-names = "xspi_base", "xspi_mmap";
+		interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,       // EENV0
+			     <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,	      // EENV1
+			     <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,       // EENV2
+			     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,       // EENV3
+			     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;       // EENV4
+		clocks = <&scmi_clk IMX94_CLK_XSPI1>;
+		clock-names = "xspi";
+		status = "disabled";
+	};
 };
 
 &clk_ext1 {
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index ef4f9a8fcbc..6acb49e47e2 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -107,6 +107,12 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
@@ -127,6 +133,9 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_XSPI=y
 CONFIG_USB=y
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y

-- 
2.43.0

