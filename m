Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBFFCD4F26
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 00:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70CE484A04;
	Sun, 21 Jun 2026 02:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gXkX9GEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8510F84A04; Sun, 21 Jun 2026 02:50:50 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8865383FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 02:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RamEnpkR/4Uak/a1pwXR4K6sy7v2gYoo4JJZG7fpiIjvkXfV706cCsmlOis+6kuhjhzWVMJVU5bOtBqg8f5Yuch9e3LM1PpTzetwwkJ9Z+AiRLWZJwdACWqp1bAKYe6sAa7dqBUgxDLzE3Dsu+YygKezKrs+Ami7KdojDkTDFVL0QhduDWsBqMzF5KLr7I+E5FBJbZIjj7bbJP1CntU9GUrfKewcsPuqr/L0DU7NXGmWX3Bt9e7YFFGjK/5jjK7auTfLCWt3CDh2kJZ9yCh/wWgzBsC9pRa+z0MnsoaRByKnSI5kiZA2Wmm3CftvzpwjZmASBA8OxPFvw4O381e6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtpmbUsgdBVyKGNB0ttTj4Mnq8dK7xGmQQGm6s8+czE=;
 b=niw7UZPmx8aQiXPJRrj9NNMB6linfdsf+ZSsATN0wAWpP+eG1CAuT7zXiE4ZQZJlQ9iByaL9WlhRzNk8OWnwsqnW0dgoSGjfKBn3TmBgnDOpx+jrm/jnbzrFl4OPo8jq9XQ/jmjyhHbar9Awp7ufUstkl3uCaCPdZaM8j78cjS0+jtLmZIEkXERIgU6iO7mz2kR8Mk8BWnV+y3YPDtolwBi/WaiIOMAiDZOL6KXBU5xgEK7+ElJxT3FpAwdBJvsgG4Cgwl2uEYVGoWBQQ7OCQqbbPOEYxOt+VvJcnH7IxDkUnZppoB2dzfNFAaCyJ+Xg6bJQb5wC4nFrh8BDwDLUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtpmbUsgdBVyKGNB0ttTj4Mnq8dK7xGmQQGm6s8+czE=;
 b=gXkX9GEa12DLi0QuQV93jrq85UovhVDRyK438cOXXVGNTTVXHdSIp0EM8a0qSM6u/+df1pfjWPxbknQIrsWAH35HRhs1VoT9Ot+0gKC4jiOtZ1uya8Op/2hKeZc0BQIbFm/+lW1xP6M8Woz3KUeyw8J0TLcS+nA19oGOWsmvwWXVzkyzs46FYSCqzgNouLOuM9DNAlHF8D5PQRa7VcAXfgmdS8ZKdGzC+RaEIIfeZ+gyUSBqiH/Jzr1U7AIbniC4TeCzZChFUUCUFhA0eH9MepCeyvz69RM02Tknon8SzSv7cxY6K75AAOKDvGT3Yb/a7vOHjYeccoIdkuEmpbteXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 00:50:47 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 00:50:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jun 2026 10:06:46 +0800
Subject: [PATCH v2 10/10] board: imx8mp_evk: add USB Type-C OTG support
 with TCPCI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-tcpci-dwc3-v2-10-990ecacc111c@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bc806e-3a0c-484c-f729-08decf2f21a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: 9rdbGNjeZkgIqc0028IpV2MKOfcvSev1hzLX3j6X5Avk8lzLG3WKNFNpZa2jw4hIlBDpHTT19ASrCgb6FYZknLJ6J4GkwTSjg8GSYnkkk7Ym1rqfsBWBi874TTAWT1aZ6QuRfLHfx8IaMsS8QA9lNU/irD6xsiwwDiUdV0opWHa8rk2yNt3jprOawQGHqIRTEMh7CETUjeleGEKUbAzI+o4RYC4fRjfzk+A/G6Ux8uMBwLjFbCqBED6uR1SLJ9ntcS0JoRkOrG5gpYWentpkmQmSsTe06E67CVuwHkA5Xs6/xOT6oHS1uzyDIua+6DtKxvLmJ+lbtHq/sCg7pFGokXRGvLNlXjSBkzL6M+SUxKGnr4i6uRzYgaK57K/mtbt7soVRC3AUcFcUAvJ3zHm5bGNTTncTlzUKwWbdWb7IEbGAouU0+L01cBwO4rc24S0tl04Q2pnC0/2soUBi3Za11kH+LibvNqcZgLldvgfLKMBz7QX6o8FJpd8NtcgzvRX5RUhs6mM0gFe9hoEVnO8GslPlA6TmqrLVzf3VlfmF0qDtMhYyhDlAm6qmpYLVGhcnO1UJzhEyrLNjuryt1jE+z3/APhYuiiRgMStgdjRcGOlIdAAWSNmq3JhcLJzyjaBpgu7dv1EtexrFvRmicuxGyujuF77VZArr6z4dw03XA+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJBcHlnR3JTdGgwVUp1OW9LVEhBaGZJK1FRUkoxQ01SaC9NYUxnbHZTMGFa?=
 =?utf-8?B?Y3d6cDR6ZUFBMmtpNU9hRDdPZlgyNDJMODQra0pVRWVFMXpvVnBTYi9IcG1w?=
 =?utf-8?B?dGNmMzdxdXlBckZIa1J0VGRlcmo5R1RmRUdTaGdLS3MvSmZ5elRaWUMxOW1V?=
 =?utf-8?B?a1FaUFpnd1I3aE4xOEFDVEhHblgwejd6cGlOcVZlSWR3cDJBUWJ4bTNVRVJk?=
 =?utf-8?B?QmNPRUZHRnlneVRrbzZOUkdOTHRBandDRDl3WFZwRnJIanU3VkN3UUo3aFgv?=
 =?utf-8?B?d2VqUW9WVnF6eWZTbnlCWWc4NGNGcmdLQjJTajBMbjRjUU9hZ0tuSzFxYUJl?=
 =?utf-8?B?UURLelpIblRTQjEwd1V4TXl0aDBVZUg4SWszSXNiV1diUkRPbS9VTkVmZTB3?=
 =?utf-8?B?WE5UWExFRjhnbzVMVVhGR3RoUWRhL25oanBLNEJsSWxhejV4VG5kSXVFZ1NZ?=
 =?utf-8?B?R1dHbStLL2crVGlpME5hdlBqOExtL2N4cDZMVVVyV3dMd285MlBrbW94cklD?=
 =?utf-8?B?THJ1aVkzYU5qMmVXMmZMQ1NpdHRtVUtKbzVQQ1lkcWkzeTYwbXRrRGFjS293?=
 =?utf-8?B?Yyt1SWt4eGFqbDBoc1dpZU9KVHVUMGgydWFwa2x2YUNGQko3d29FUnYrWkoy?=
 =?utf-8?B?VEtzVlp6eTJIUXRQWlg3Q1VUcHNUYXRodnc1dUMxUEdXY2ErYVBlc3MzMm52?=
 =?utf-8?B?b2NHUWtnem1pU0VEUnl4SXdIaHJweUdYL1dmbDF2UFlMTWtUWll0UTYvekZY?=
 =?utf-8?B?aEs4RDlkS29NdFdHVEtFYlMrZlBpd0tSN1U5QzJOYkZJcDlsSFhDNEJTcS8r?=
 =?utf-8?B?M0RkTnRPQ09Mem5jRFFBOUFrdG5sVktNQ0JPUzN4WW9Pd0xzbk9nNHFlQzlF?=
 =?utf-8?B?a004ZU9VNmRoK1I3R2tUYU0rcTgvVndkRDVFWVY2MzBkendrT1dNQU9BYXhw?=
 =?utf-8?B?ZlRRV29vSTNMVmpCc3llVFF4S0htLzdNY29xcFFpR3pHVzFYWldrUHdMTGxH?=
 =?utf-8?B?MDBIc3FIRWFpc0t3c0Z0aEVORjEwajVwemRIWEJlSzhQUGtwWERsOG4vQU9z?=
 =?utf-8?B?cGpwOGo5c252N1pLY3I3Z3ZwVGVjRjV2bFVaRU1DZmEzMGxTb3UzZWdNZE5w?=
 =?utf-8?B?Lzc5MkoxRjk3Z2xlZEdSNXVKRVkveXNPS0EzaVBKT2dtNGhERmhRcU1wNXZT?=
 =?utf-8?B?ZXlYQkJJN0xEemNCWm9qNWNQQlU5TXFTWDZ1OGQ4dTN0L3lCOGtySlF2Y1Q0?=
 =?utf-8?B?Zng0QWMxUms2eFp2bERmeHBCSlM1c0xpNmZXSHBWZTU0dzhGR1ZMQnlDNmV3?=
 =?utf-8?B?dDltNzMvQ1A2ZXE1K2x5WFAxU2YwSFNZUVo1aTdIVkRsMEJhNnpKTUJLMElu?=
 =?utf-8?B?bHZ1TU9GazZUK1lHMDltMmZQeUNuZm8wdm81WldlUkdMeFI0dCtIQWh6aDNm?=
 =?utf-8?B?RFhUMGdlcVNId0F5YTNiMlNmT2orenVBUWV0dFNrbkUxcmpOc2JXdHVqNmFa?=
 =?utf-8?B?UVo4VUNQM0RsWlJkTHVLM0NYU3ErTUlSQmhNelB6eXhCWTFxeEZIbXo4akFH?=
 =?utf-8?B?RWJhbjQ4UGlEbGJtRUhJTlgzcWk5UjZYYnZUNDRoVXQzZ2J0Q1pqY3d6aVNJ?=
 =?utf-8?B?em54K1pVY3hvNDdiRGZKV3BCekpXemlCNVVwREkwcW0xMFpsbGU2YkN2eGd2?=
 =?utf-8?B?SWk5UG9xU3gyT0tNZFMyMmF4L3lLeW83NUpxbTJMNVhxOG0wQWMzNVdTeXpQ?=
 =?utf-8?B?THZBKzBMejQ4bTBaTzJRK3FxZ25QRHM2R29YS2Q2TDFoaHppRU51QTFUT1VN?=
 =?utf-8?B?T2k0YWd2Q2VvUEwweTdUb0w2K2xiaExkR1VmQURNRDVVeXRNU2JVUUdBOE9m?=
 =?utf-8?B?TGRBRlRiVjBybUtZMzN6UStHSE1uem5Jc0xhdS82alYvWVFpMjJ4RjRNTzk2?=
 =?utf-8?B?dTkwaDlDLzRFNUEwZDkrSDZabUpDQjNEZ3l4eTQxclgvZzFHMEFiYTdzM1Jw?=
 =?utf-8?B?SnhtK3ExbWxBelU5Q3NOYWV6OGRYSjBJZEh4R2V5c0JhbmVUUGljMUhTUVo0?=
 =?utf-8?B?d1l3ZVprVXZ3eU1RRW1ZSGQvUnB2YktxMURxT2xHNmUvKys3SEgrSWpHWi9k?=
 =?utf-8?B?ZitNSTg1SHVubFlJQWhOUGFaNmZVdURKOGN4R0hzYnlsSGlhMlBOVWFOQ2hB?=
 =?utf-8?B?RlpDUS96ZXg4V1RKV1lleGMwdG14a0VQbXF6bHFqUnVHNDR5SFhqa0FLR3g2?=
 =?utf-8?B?UjBkTVNJTkI0NlM2MHNiZnRLVzNrSFdidEZ6K0VXejBDb1JQM0RHdjRldkgv?=
 =?utf-8?B?YXExWlVYYVQ2Y3ZLaVNwdkJUK2RLaXloTmlTcUtCMEVCSmVQb0habjQyT1h5?=
 =?utf-8?Q?5ofheqkHMxuunS2/WwZ84Uz8zwf+a7UbfnIfT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bc806e-3a0c-484c-f729-08decf2f21a4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 00:50:47.0112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCAuq9vMvfusIKPh0E/LSqHh4R/C0SJ94IZSvAgvQE9gGeK0WaBFj2OVQ1cU9fcDndo+jdv8s29G0M/FK9rCYbtfPzehoQWna8v0wamHl4Q5aiMnpcUXb1ch/pgfMCCo
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

