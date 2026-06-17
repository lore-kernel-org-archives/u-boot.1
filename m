Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F47CCD98F2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A61B484987;
	Wed, 17 Jun 2026 09:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dbgxc4sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71FCD84987; Wed, 17 Jun 2026 09:07:16 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F74D8497A
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUrixpZCf2zt9RMPsdjw7Q0DJhtwBY30eUOBtcj3Mt2aN/h0qCxyuNLaV/0rBTRhj972u4a26CN76vGV7/ODVafFZ0quh+gkdXkafTISO0fsRCBqm+xNGieCTQXCBpuBdq4zNSiG45ou5SxV7e7kdjqqqCAJquPE1i/TjPwYGR9mwvd5X2oScOcwA53LcqZvydY6z0haid3EbvmuuOW6lX5PA6H7THmpJaOtC3ordw0RqhdbdvBZkYhKRbyI5a+plDtioawixl4FmA1vmPVobWws5Ik+VdeC0mFjPGGKUXPXg0zk83grMK8nv+cLzDg3dAnjQ4DhHlBX74x2unZJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyGT7NZSR1oABfWAWX2DtpNvl+lZkcZnVyqOLqYksRM=;
 b=Gudqp9HHeTA5AO/JJpcG3miv5BMDEgH58c9aG5pCReQkZFYfqrpk34HYLDlUzXF5QmFGXakNeiIcpVOaVngbRMZK+3sywVUHuQKrwWaaAAXluQt1sI3OKkgYWEf+HN7XMpiRNy1e0Nw5mZI/Glsx9uD6QivrJ+lZgk8dqkSIk9bt2UvlLCTKXsqXt5iMcON8CmZ7699iKTNHhUwL7w6dYEbFAau5jH4wIrACSA9IANWlijZwn66r4xAfp/Iu05Rrbj0rS6VIDcdSHu9RSGcEMSo8z3hTvKdTR22aDEBHjCqUfskKuFx6up4m0L0ACz0DKV0iDKOFCdJ/RCvenX/56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyGT7NZSR1oABfWAWX2DtpNvl+lZkcZnVyqOLqYksRM=;
 b=dbgxc4sfHiFQZOVsw1IWuLmCDBTKBKtPsoiUnOXOEXqvgP8RRYjaGxbrAofVGIUYH6Whi8sLsDI5UCSgWyxGzHCF9zxrZp5y3pE5gEDbEArbw+iqLopbp5A+xQHu/35LOK1VOaS4fdQoBz59VQ6pwFMEAQ7Mg4gEOT2aAJ5GcLAFwYlURiyh7gLoBsYQtdSJp7RxUWcEnVbM7/U2BFhHFdnkdib/jJXhxMm/d3+GUdy17NYOZYLYiYhEb2AzsxNbt8XpMmtrrrILHktmzUr4ugAN3k5g6NZdyFXqGjDUohmMq2iPX8oZzsfYC12JrqiRFNf0v21+sLYVGvJ4sa/W0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:07:12 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:07:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:09 +0800
Subject: [PATCH 10/11] board: imx8mp_evk: enable USB PD sink via TCPCI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-10-b824fe1e9299@nxp.com>
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
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: e0892ea3-1865-4b65-3ef7-08decc3f0dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: P5vtXPleqE+hmAmGGH5bvPhNfz6VclvezIt56CcFswd84MojZratgFnC3v2StpOTneKC/ZP0CfUNyuQSbvAEWnj8v9aDA8dmDxOVOJEYGeAxz5J0hxsQ0+mW+muKoTLwi+GeW5FfyRNI5S6lZ/3P7ubFk575u4wzZY1xQrMMUZNcm7Bm+Zu4gj7fNNGpFqsohrTaejm9nQnOHEf5JDk/n9quyqnPnfb4HgLKVEbxtmGuez27/F4K5WCRNwHyajV5AZeqn2MdMOmDhd5rITlw/8NhzVPUxbCV4XDpBbTnrnUNHFYzz3Jxl/BMznY7FBWtp5u8GoQvdUx+ZbDDh5lw2NLyWLJ3mYsLpmw+TET7/9b9orCINZYAxqWc6hBZx/sMLbEp/XdCh7EkbJfyYA/xgs1rGewm1aGAH6G/swG9wCpnmiJBRTb/jdTICbHflt0mkruDeIee1lVmjaL6GljFSkeCOzx4EZU4bUFo+c+BTUXi1QOHHHXowOVAk7QrNi1LK9sMMtXO2yfG5WJV4umx13E800dEx8xTFY11VM4Y26XDlIuF6YcwFnooysmkv7E8qxMHXrnedEH9SyIJUNgSn/IpXs1nKbU0yD1Lq/CPW/KGuRQ2Pr1ZsdUvHF/0uu0WDGu0rtXu+HS25QfSCcpIJpixlpghi30jiGEgBGdbrycDOZQwtX6LxBAVxpOO+Is1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZ5RXlYZkpJNCthRkhYVnhtZUJBTFVUUVhmYzk4clhXL1kvUzFobVdWTitR?=
 =?utf-8?B?SGxLeTNiL25kdEpEc0VLb21WUlVWc0RjTHEzZG01NjRTb0lVWGR4dDdSN0J3?=
 =?utf-8?B?cEovcUFob3JKdlRORUtHUUNDZ0l0K0p4TTNya1Q3Q2taRmo4VzEvNmwvVmFm?=
 =?utf-8?B?VGhhRlZSbGl5RHlobS9WbWdWK2liLzExWXlQbVN4MUdiemthNllYYWdEcFhl?=
 =?utf-8?B?dG4yWnp1RVVSeGFNTDBTeTV3Uy9kSHVHVmRwN2FrQmRzdnlVTDNmR1dyRDRT?=
 =?utf-8?B?VlBucGxRTmhXNE41ejRsMkR6TE5PenN2VHNiL095N1ZpNlNBQm5DcUJRZUp3?=
 =?utf-8?B?OFpHL3IzL1R4NWV4a1Iya2ZSdHRIdExkazBJR0dQa3NEU1pJNmtDWDdGWUZ3?=
 =?utf-8?B?S0RJV0RsaXdVNVlQZWNmdEM0OW1CYmkyZk1zRkxvMHl4M2FJSmhSUStnQWZ6?=
 =?utf-8?B?aG9YY2UvbThEazVVNlFoSXAwUXFPUWRGdndYcURRYTY5QlJmOFprMVlJTkta?=
 =?utf-8?B?Z3Z0czcvQkJqdG82ZklZMXBMM1I2eHZUU0J1S3VqT1VSUVdORFlNQVJ6NkpJ?=
 =?utf-8?B?L09uZlNQN0NCZGhxTmVLcTlpNzI4RHN5dlJxYzhWL0gyenlhaElvWk1KZjBu?=
 =?utf-8?B?ckZRUHJHVVJmQ2FIb3NyNWUvaEc1M3hzM1RNZWZSNERrdzJHaVR5cTJmd2J4?=
 =?utf-8?B?SnE5em8vUFpzTTNkeklKcDQ0Y2ZaQ0VxTjIydUVTQzVpQ3QyTkEyZFlCQWhm?=
 =?utf-8?B?TW9GMEowZjBzTU5FREdPQytPU0lqZ1RYTVduUnBkbC9MMTRPMEFmMnJpSVUz?=
 =?utf-8?B?UUZLWlVMTFROK0hRWTdib3RLY1cxNTh6TUhuUGNiRmh2K3c3bzBKdTdHNGs1?=
 =?utf-8?B?NjBsVSt0cU1Rcnc1ZVFxQ25UR0xvR3B6eFNoRUU3MXkvNnpVREpQWlNxZ0FW?=
 =?utf-8?B?UnNkMEt3MUlaOFM2V0ZCUUJaV2h6YXpMck1mbVNIK09tcG9UV3BVbXBYVytT?=
 =?utf-8?B?a2NMcEVtSHF1WlBtUFN6cVR0enBHZGY3enNOY3d3UXdldGxsTStZVzl0R211?=
 =?utf-8?B?bE80VjlKWWdEbGRacWxoTlY2OEswS05yZ0pKbE85Y1pkZmRFUjJCYkVldmQ2?=
 =?utf-8?B?cjd4RG1KQ2hNcGl5Y3RTL21BbUYzOGJxRitYSVZBWlZuMGR3TWdNYytIMHNp?=
 =?utf-8?B?VG1UWDdkdEphc0N2OU1zd0tlbjJLbUZyTDFIeitUMUw1d1AxS09RaG1TZTBG?=
 =?utf-8?B?THdFN2pWN3lOT0dyUXlubCtHK1llM0EwcjRtQVZ6cWkrdHdVbGdIN2VQTHVY?=
 =?utf-8?B?MUwxZnF2OFRoZkRWRSt6MklPUHdnVnZld3VoZnFPV2VQaUZ6WFg4Wkd2eWxQ?=
 =?utf-8?B?bzc3eVhycklsNm56WGgwb1dVMTlhMDFnYVRUc2hYcEI3dWhFb3psR29Pc1Fl?=
 =?utf-8?B?TUZQbE4zSzR4eHZnaEx1UHFTNjZvVUxzZGl3Wi9JRmViTDdPd3AwVkdCNURW?=
 =?utf-8?B?ZWx5citDcDg2ei9DT3ZiMXJ0akV1SVhsNVZxWURqK0tXQnh4OXBER2ZQQ3FN?=
 =?utf-8?B?b2gxWS9GN2dXZ3liSit4VWtwY2hwWVlWa2hsMmFZSmFjZjErbnh1U1Nsd2Ex?=
 =?utf-8?B?Vm05eXB4SUxjTUZOR1prMUhwaWd1NjhUNWcyUUZKVUt4YXdPR21ndE9rMTQr?=
 =?utf-8?B?Zm1OMHdSSUgwS0l3eHBmenJHOHU1R2Z4K3pxTkN3QmwyTWhjdmFDSHlLNVp3?=
 =?utf-8?B?enI0anpnZ1dMTU5PZ3NKSE9DQ1ZVNXJjVnBvTmN1TjBxM3BqdDZ3WmlVZm5Q?=
 =?utf-8?B?YlFGdHRpbSszOGwzTHpFRmdFZ242eXAwWmZhQS9FTmtua2xnYjN6M044aUl2?=
 =?utf-8?B?UWpKMGFXWU1WcTYwNlBjOHU0bkNhMnYvd3hyVGsyb2UydGN5OHdBb1l0blZX?=
 =?utf-8?B?Q0RRQWZ0cmorYWMySTlETUVMVXBKbDF4ekJxczlJNUhnWkZxZ2FvY29PanVy?=
 =?utf-8?B?S2VWL0pmUVJnQy9MRS9tQnZueXNXK0FocExTT01ZRXRoZ3lJaWlsUGY1STJB?=
 =?utf-8?B?cVo4aEplNzg0aGxmTVZNMEpIRENrUDgvVFRXb0VSQmVZaVdmQXhhNWcxNVhp?=
 =?utf-8?B?eFowQThZQmpTcUlmUDRRczlCSFRvUkllWjlOZEFlNUE2NlhseXF0aERpTzYw?=
 =?utf-8?B?RjBqbHhKcVBNbnZpTVNxdVIwbC8xUUVVWWVLTFNoQUFXaXIrby9vdnBBcWdi?=
 =?utf-8?B?NStoMEh3NUNMeS9ENXNSaSs0Zm02bVFQZ3Z5b3NIRlNnZmtLbjExdXZQZC85?=
 =?utf-8?B?NXpKQmgvQ3JUbzlhT2gxbXhQMmR1K1RRRHBEanBWY0VoRXAyaDIvcGdiQ1N1?=
 =?utf-8?Q?lN4do2/ZWNWjikJgnn5cGtFWR8arUBawszY8k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0892ea3-1865-4b65-3ef7-08decc3f0dd2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:07:12.1312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMMwvQ+0y5L7Y59S3fuKSMN4OXVkuTPnha0aDxd/KS9ocpCwkqIxHgK7+dFzwTCrDHTrthQLyigo9HnJWYIBmsTvJNfkaRh3JwskbAycK6hNq0SbkyLAgYYP+BYfWlB/
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

