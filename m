Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBD8CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 00:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B17849CE;
	Sun, 21 Jun 2026 02:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qVzPidWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B1EE849F0; Sun, 21 Jun 2026 02:50:42 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E2983FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 02:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYbOyxuk8WGEJgrWhH9LAd50cKBB9ntjENxoa1lY3f049N3MbO4A4YL5dw09J6k0DpmPmbe51/8MDaQfuWoXNYexp6PGHlAbe3BHmgZNn6LfoJq7jlE6b5NVAi0XxUh6EukeHkVBbD44OQiTjUKRp9LfwRwSMz5bOw1yp2ksF/BhrjDtxokIlkz5CGOjNe6v+E9newI60CUmHDXJV0BQi8sWB+jpLd+3limyKoytBC/ym3FKRmco1B9dv/FQFmv/FHo18LZF8+q0WngNN+jnl01Z9y6fKkuzHW2dkUTZ3nNla0S0w4qwwPTy655CSO1l25vdJay2yt/QUgA0Oy8law==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyGT7NZSR1oABfWAWX2DtpNvl+lZkcZnVyqOLqYksRM=;
 b=v5UxSZiho1Qzi/gi9PJIbmbmZ+33tdYS1IijsUVHPhUb5aDAaSTHxvJ5PWOPrUeuG0wSsut0rRdCuQhV094mWl+PqXF23AjQkMve15A9uoFymFtMXLUOVIdv1hx5o0+/bR9J5XR8uOz1q5TXJCHVCca7E3Yi3nsBC/trlzHDEiSRhqkFc12hwx+q7AjIAntoxnQYBLGZQFS8irhO5hlGJV64da0LWAj5xrQlspAsX1QxKNJL1NAtz48WaCelSFQqP+2BVetBFaYaNnPW9GC9L2nguvnlHzTnOrdcxP+BOtENmQPioGCE8liiRHiWTG4icQtlyBKwJn3NxIGlaet9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyGT7NZSR1oABfWAWX2DtpNvl+lZkcZnVyqOLqYksRM=;
 b=qVzPidWVe8x07sNNFkB51qkdpZxT6bLXeJB6qNl68Ux+p3gWzGdSw698M7zbYQJlI4g2w4BBSbX93i8NUcaDqK7W3r7nLKl4bI8fB1ELyCV6k2mmK1eW9G+z/Eau9OMsIbH+ZTh5nlnIYZ1+0ZSM3U72IzAPTu/eVL+NW/qxZ+SRZySorT4XHdmg24Pz4rA7znEgtJV5A5vEA65rwU5VQVVGKp+bNCmCLLY3cPA5c7e2EBbGiMXCGta106BNHnrQ4nSZ/IzPjpEIWnfKj2U83VStfSTFUPL7Jqjpo19t/ZvuqyAveF/B3O+0dDMfQh75W59bU9KgQ0DNdWsHqPEQSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 00:50:39 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 00:50:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jun 2026 10:06:45 +0800
Subject: [PATCH v2 09/10] board: imx8mp_evk: enable USB PD sink via TCPCI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-tcpci-dwc3-v2-9-990ecacc111c@nxp.com>
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
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a2ae69-83ec-4308-c9ec-08decf2f1cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ppFqIQNh1McqObbZX7vpdmOfUtgsAuoH/LFD9eem7MgMM4rNdETgCVg2+VoAttGnLPpiLth6ULxwhEXwPToPGUAAIpVjgOsUR5fe6g5OYaJpI0tG0vU4Ly4KkMmxejdcTpfWp3jqN5YWzSrG4gE2NJEQzEgEmdYHySv+cNcgWEmbE9VxQZnAL0NF2PVHVH5bDN4hRxxwXy4fc/Dhx6Cl8K8BnOFbxXy2poMASLucOywt5Rl7wleCfIm0pvI0W/pg2/ZPiI7j80AldVjA3+N5LZr/sy2UDXUGGU5BA7ujOYx/KH8s5XTZmxinQQwMqoIqjDHl6Cd9fcYwb59RLMnODSFVgYqO9iuygAj01kqkmHpQWZkJMPKdzCbLI4T2Mv/gTurP3ztFmffLZQBMVZASs0UHkm4jDLWfnW1SBN9gfHqG5p2PjObv9u4mtzcpdbu8DNbbYMt14xlnEd70o+gJ99t1ZRVunZ1jm92Eb/JtIoI/pg1u4QT9mjyMsSBz34iifZ1poiZJ3xfYBuGliBO7oYl6SIA2hr7/NdRtc8ZdLjD5kTvOHARfVdMU7TmuGg2+dCopCu+MZzIEVfwJPkW6kk29XcTK1Ja8x1Au/jm2I+jANLqqkPn+ynUKucn901ym8jC5VYh5JMEmnZeLEwT4LsC1WZl//MSCzMuvonwumYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNqZjI3aHFZNldGOHJ0dytlTFVpZ256aDRKVVVUUnV2K0V0T3FuS0JnNzBm?=
 =?utf-8?B?NWl2aFBnV2lCcU5hajNSSEhBVUp0dWdsVWhhUU1mMEVVYlg0U1RNVUVhRnVP?=
 =?utf-8?B?aEN1ckN3TWN3dHdBNFRNRGhEQlc0aG5ZUmhpSTEvOHNqRUdxOENUUWlQRTVB?=
 =?utf-8?B?WmZ2NWhpN0RnZWdaTkY2S3g2RktXQUVCdnREZXpjMWM2a2czVW11bmlNSFN2?=
 =?utf-8?B?S25BOW9XbzAwRytqVUtxeTRjQ056VGpaR21tVno5R3JHV3VJNlU5ZnlDYnRh?=
 =?utf-8?B?amdYanU0SXdWQ2JCc3FmV2hPRk1ERzZaSXk5clJpaitiSFVhZnVYaytlblFl?=
 =?utf-8?B?ZHpkbGlDaTV5eXkzajI5SDh2dnk2QnRiQ0tOY29iaW5kczhYQ2d0TnFxNHBz?=
 =?utf-8?B?U0JIUVpyQW1SQlZmZGlUbUZmUEZ2TCtuUjB2bmVhaDM2Nk1qSlRXVmJMNnht?=
 =?utf-8?B?Ni9NaFNaM3dpTG83SnRSMWNaUGs4V2ZVVk81OUJYekY1WTBGeTk5M1BUOGFG?=
 =?utf-8?B?MFdSTGVuSmpCR2dkYiswQWN5cmZQWm16ZHVqSWlFM0hsdmFJc1pjdWxHejBH?=
 =?utf-8?B?ajJFSzdOTENFb1ZvdG5wZGEvb1RDRERNejRPTlk2U2RsSmhpL29KWXNNZ1dh?=
 =?utf-8?B?aFZHclNFUDdxc2lQMCtwNlYvY2NEQzBYRkhGVzUvU28zV1prRW04YStZSHl6?=
 =?utf-8?B?TmVYQ0RhRWpSNURFWUQxUG1qeVRwaWhlSXFwY1hxZk40dk5aZWhQeHplTWgy?=
 =?utf-8?B?cjhCRElwWFIxMVZzc0JaOEMzbWFjcWFCOU5BcWRtSWFwVTA5MStwYk5LWkFu?=
 =?utf-8?B?UTh6L1gxZGNjWEV1amZRRHVXcEEzc2FRV3pqeWFjbWs3cHlpaUpSZGdyMU1J?=
 =?utf-8?B?dzBJWDNIUkhZalhGOVYyLzJ4eW93UGJSQ1FaVi8xV2pnQVYyTDlQWjhzeXB4?=
 =?utf-8?B?em9TbjdJQTkrOXIwK2NCcDBsUDZwZ2VJLzVaYTJhSEY5SGpMYmE1TEFqY001?=
 =?utf-8?B?S2s0aXpmT1hJb0hNY0RkK3I5L09LT1M4MCtZRGRqL3B0cjVhaTgwMUd6Wmlq?=
 =?utf-8?B?V1crbXV5cVBnT0F3NkZ4T1Jiem93MytCRGFnVTZNUFpsZzVoTlhnTW1Ebjcv?=
 =?utf-8?B?NERvdHE2OTFUaVpyWU9VNU81YWNkanV6R1FtcU9VUkduakFGOXBOOCtxSDhv?=
 =?utf-8?B?ekc4S2dvSnQzdk1NdzBPcWJ2RUwwaG15ejlJZ0FYdEFtTmY3TDB5ZHJrdmp3?=
 =?utf-8?B?TWtvWmt2dElxbXJRYnl0eHYzYWpEb2J1ZEJHbTNxa3JEcXJaMERMWDI5QlJF?=
 =?utf-8?B?bnkrTW52TTFRUm5EMTg1ZG0rVDhETkhPVlk4VXBZRWJlQUVyVjZORDFyMzda?=
 =?utf-8?B?Tk9jUG9uNEtLMS9VSkxJcGhUQUV3T043ZVA2NTh5ajZBOE1IMjZXWjFwd1FM?=
 =?utf-8?B?eFdUL2xoRzNhTlVKZ0hndWo2RXIyQ1JOVjJsNUNycGNlaEpOUlZqcXJDVGE3?=
 =?utf-8?B?ZC9wNXlaeVRMWDJMLzllK1B5ZmI4VU4yZldQUnpwaW1vK2N1UnBvMjN1a0N0?=
 =?utf-8?B?dEFCRUozdisrUkNVYTBicDY1eUg3akxsM0tPTUp4UHJncEJzKzBndy9NOGtj?=
 =?utf-8?B?VEN3K3g2dnQxaVdmV3oxOFF4d0tIYVQ0eU5MRFFDdU9xNW0rY0NrNnlZc0Vr?=
 =?utf-8?B?MzI3S1ZmeHNrMEdjZEVQQ3VNVndFNzBOdUFDQ0V0SHJiTVhTQ2wyZ0NwVlNh?=
 =?utf-8?B?eG5vVHZwcHNDQ1FpMktURjV0RmN4ckVuendQVy8zVmNHUzM3d2hWM2xFSnhF?=
 =?utf-8?B?OXk2NlgvdHM4TTJJTmRYdHRWQkIzNEh5S2lCbllhK084SGpVU01xOXlySk04?=
 =?utf-8?B?Nk5jOERCY3Y3Z1g4VXV6ZmF6N0s4d2c3L0NNZ2I2RjE2Mkx5dzdPcksvRy8y?=
 =?utf-8?B?NmNlSG16dFVxV0FETzNUTlpETHZ6WG9YVWpQQzRnbXFINTh2YlBaU1JNSE10?=
 =?utf-8?B?Q3dWdG1MbkNISEFyajlDZUhaOE5NV000cGM1b2N2TjZsNkI2aWVPMU1wbjFw?=
 =?utf-8?B?NE5PcXRJamliOW5PZzVjT0V0TVlBdEg2UHowZnVOanVkK3dmYlowcXBmcU9F?=
 =?utf-8?B?Mk5XV2hnMWgyYVFWZTNrMkZPYkdrTEt1M1BIcWs1SU1ZUkxGWmZnWHdoQ3pL?=
 =?utf-8?B?TjJEWFRiZy8xSDRVaFhOQ0tuYi9BeTlBeXhSOVR4WTRwUlBqZ1VFSkRBVzlY?=
 =?utf-8?B?R1lscFh3ZytvSDBEWUNwSS9PZkFtOG1VT01VaCt1RjQ2anJyNzdLaEl4Si9Q?=
 =?utf-8?B?ZkI5aVYreDd2alEzbkhNdlJKU1UrTDlWSlNOK29YN2JTcGRxRkNrNTJSYlFP?=
 =?utf-8?Q?Huy41+ysW/+ITJZF2v23ux2v2HQwmNd5vqnB4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a2ae69-83ec-4308-c9ec-08decf2f1cfb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 00:50:39.1449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAGvhZ+dRHzAw0+8NRcxeSLe2LpwpHKU+pzRoEysmTPpipENoYgXkn96dcWhmsn/vuptcXwzcAprEzBrLDPGQE1IPbcTfmT1nbIaYB4YhDcQn4jh8Cc6n6RX9yKAbNVV
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

From: Peng Fan <peng.fan@nxp.com>

Add PTN5110 TCPCI node on I2C3 with USB-C connector configured as
sink-only. The sink PDOs advertise 5V/3A fixed and 5-20V/2.25A
variable, enabling PD negotiation up to 45W.

Enable TYPEC_TCPM, TYPEC_TCPCI and CMD_TCPM in defconfig.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mp-evk-u-boot.dtsi | 18 ++++++++++++++++++
 configs/imx8mp_evk_defconfig        |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
index 51c84383673..fc9e9da09dd 100644
--- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
@@ -3,6 +3,7 @@
  * Copyright 2019, 2021 NXP
  */
 
+#include <dt-bindings/usb/pd.h>
 #include "imx8mp-u-boot.dtsi"
 
 / {
@@ -91,6 +92,23 @@
 
 &i2c3 {
 	bootph-pre-ram;
+
+	tcpc_port2: i2c3-ptcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C-2";
+			power-role = "sink";
+			data-role = "device";
+			try-power-role = "sink";
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
+				<PDO_VAR(5000, 20000, 2250)>;
+			op-sink-microwatt = <15000000>;
+		};
+	};
 };
 
 &i2c4 {
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 7af538ee367..2849d910538 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -150,6 +150,9 @@ CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_MX7 is not set
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_TYPEC_TCPM=y
+CONFIG_TYPEC_TCPCI=y
+CONFIG_CMD_TCPM=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525

-- 
2.51.0

