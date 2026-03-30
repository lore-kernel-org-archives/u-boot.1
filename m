Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EA2FF494F
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 12:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E706C83DA7;
	Mon, 30 Mar 2026 14:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EfxQLp1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA02C83F5B; Mon, 30 Mar 2026 14:48:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9F583DBF
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 14:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5FRW/RFQoR99mTFE00bG4rL1Yj4D3uR9KOFCvxffAVb33m6RNRhdcm0UiioA9wpxbFeRXkLOCUr1ahSVRCDhrmqxFBJVu+F3+nHbnSZ0kVvdXN171bxMXitRY0YEUBUFU5Ts5yNOO41VoXJ0NnYR3/Q2XKdfwdvxwy+lFa121kTLTKNHOAJCuFUKKzqTAFrUNuIjnk2GFx6Qh2VrY5+0VPNzfaWA3Ixfs/eGc0Oe39mn0lyVU7qh6Le4FEmhnPvom72tO1/rtNk3oiNmDtTeK9KCQUm9/AlI1k+D+zn8ad+QO49cRrteOn4XnFEbujAXrq3vn+h5qq4AsWsRU670A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g6WWZVurNHEok8rYp0tHtEDwXkXaXaSFYi1DHluDxY=;
 b=aTBmL+1IIPcaqXb/Z+iqMxhjsdGJ+hHGR7Z8lwo75AcSI5LvghOyP5wEMqs7h1H7KvQVJy+xEIzrmTRfOHu1I1jd/lW6uvf+Wtkkla9rMUI+FU+IZD/DbaXC6hvbQSWqQgDJXs9F3lITYuOJofV2ngdd9mPg7/yqPQGcD/v3YNY5jNwwcqin7LzgBGjdsEZnprnohLH+c4l6Yeal2j7+AXGKplvlLgdsgTg6vH9m08Q85cxpX8TPFcnBIBZkJSZsIgla1lmpB98OHZDhy1kiTWM1c7/GdsycnKS0i6U07i+rNhpTPYzfaRDn+cHvmeemEOlmQCFdIf7cLbuJnKuzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g6WWZVurNHEok8rYp0tHtEDwXkXaXaSFYi1DHluDxY=;
 b=EfxQLp1z5TehziHzZikUd+arns2ebaSMgdhqvafwpDvcv4yadzrjPWcuyhiM3+9qTR1bshJk/3kBarrv2bMBsKy3aTYreOQHFStJr2+6TeX6sC5af5cQbKMyKnsgAP7t8jtecDfcdKdCj7D2DLHMwxTFWkJRCMTzcYZsdAcsGyEEPH3dQi101WaklTQOyFewIMDvqwYU1nHd+ELWvMi26AyyF7RBlzg5xQ2d4fwxQbnNI7iPAq1PlCSvPNY8VozkSDxtYSJy4Cq3EziIKPnwTleCFMXiW4QtniUIoKX0WWxkJWxVVa3QB8bWuZUL3aPjGzzbgko5gBuwMtDN+ngRsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:48:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Mon, 30 Mar 2026
 12:47:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 30 Mar 2026 22:04:03 +0800
Subject: [PATCH v2 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-power-legacy-v2-1-47dde3182a2c@nxp.com>
References: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
In-Reply-To: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: ceeaee9c-30fb-4eaf-5c9a-08de8e5a89a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: LMaTma4V3b0cXKP/ugvFEnpJjUbUk4lH7+ybcuB3Ha07iU2JoncShG45i2sDdHMmjTBkA6WFw44A40B0ClTqlLNr53weTNDaZfSRWX8PxFwT/pxskauhMasKm4mjU41wadg4ciexwV0v94xKoBlJcQwR+QrZK6MlpwaqM1OUkqBl7RmeAmMN13VOcS6ToVzNNlfQwRzMu/2y2cNDUqI27mSvOwHV3TCh52UZKg49AsB4F7gKse0PQJ/CaKdIuMfO4mi3ZZuNJrlGFzQUQ5GXaNG2KAKUBTwT1qIK42FuqoaJlYRiE7B9j6ciaA/zvj3dlSiczUV2sRBjz1/49LFm/JfebrVDKhhGGjejkrURlIKawUYZdwy64Baj08ldLIrsyC18OhGgTmW83ZbIopHSGOed3TctYDHlYbnXW/b+8UdpXSB+2ALs/ojWJruhILiZGkZiO+V2QdDFjwufi66kA6DbaocNLlVPZMX107a6xN370x8Rr/OBnVljqxGWKPbv6eYzIfi8//W+5xaOU2pZqlAlkE/qXKLb+HH28O93DVMgjtUsxPPin35XieB6NXWLIinFi9o2LA8LKEg7DKCLHs6MClVr5x1pCeAoF+usACr6uIvWkYxEentL2Ojr10og6APymGH+Qf5GAGXq1MXcC0E1ydcT3KzAR0hNGC4EDvZo5Uu0nuNts4EbPoyqSVUbCBdyvZfpPHqI/aT/jIO6j4eqYZxTOHbB+CvF+6DM2ZOfqJnDpWR2u0GyGP7sdwjRUQY54CApjUFbFRREGthODTK1DM8X4rq1veW7Tc4q2ZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1JFQ0ZpZC9XaU1ZVEV5bG16TkNFdlh0TCtITnVsMjFydGkvTXZzOHp6Yjhv?=
 =?utf-8?B?Tzd0L1EyeCs2Y1c4MnYxMFZVdEVVb0d1UXRGaHZsQ0JVSDR6TXZtRFFoQWU3?=
 =?utf-8?B?d1I4VmNNZFhReTk2Tk1TeHByWjNiUEUwRjB5OVBxYksxT01aUVFDUDlGOUta?=
 =?utf-8?B?L1FxUkxUUGdZVE5rTW9scmtXRHEwbDE5WHA5bysvUDJLTGxqNFlhOWxybjlx?=
 =?utf-8?B?Zk5HRHFCWTJCQlFTTk1XRUVQMUlGOWhkdVNSdmdYbHl0Q2FlUm5xK2xJQ2VH?=
 =?utf-8?B?cyt3Y1Nhc2ZPOXZFM2V4OWZqSXY2TTA1Vys0UWIreWszcGRrMk5ubjZDQkw0?=
 =?utf-8?B?aXkzT1BYL0xEOW04NGliQlJmdDU0cE5CTVNDSkNVTUJnY0ZaYWdEUkUzTXFX?=
 =?utf-8?B?T1dIU1pidUdaVCtNMUl6cFg4SllBcSsxZ3AyYXAvT1hRc0l4TE1vd2N0U1hw?=
 =?utf-8?B?WmFPQnJXeEZXUkJkdEliSEJZaU8vNjlhMHdTUkZmMkxSR2xNdWwxdFM2dnZR?=
 =?utf-8?B?Q0Vma1lVOWlEdDNoR1R4SFQ5Wmg2Wlowd0ZnbEVzVXByWXREVWVqRGJLMWFn?=
 =?utf-8?B?alRQcTBEMFlqMXh6OENpSEVZdTdGTjVOOWxUVi9mWnNLdTJNSElxd3FmVmVr?=
 =?utf-8?B?dzRKS3ZxaHU2cUhycEVGU3VXc05OWndldXJhenY4RSs2SHhEM2xZM3lZUkZs?=
 =?utf-8?B?MVFVaHQxeWIzZWF0U2o1UmdsZGF4S1loSFl1UUJQRjN1c0xyWkdvckNVMnZj?=
 =?utf-8?B?QzkyRlZjSVJqNnJFa05oK0dLcm1MSlNRaUJUZ0ZQUmJCSXVzNk9HQmRtbmcw?=
 =?utf-8?B?eVNyVU0xTU1UeklNWkFhbFN5U3Q0eVdvbTg0cW1iUkh1MWJmc1FYVTF1UEFq?=
 =?utf-8?B?bnJDcW8xbHZxdFJ2U0phZURIODVhRER3SHZwVWRaU01sc1VMSFVPc1FEeUdB?=
 =?utf-8?B?eDhZUjhwUmVVNUlIOVhabDBiQXUyekwwVXE1ZncxYllTUkcxOUMwdUFYZTg4?=
 =?utf-8?B?OWk2VmFMM05MWGIxMGRiTDc3ZWxYcHR3bmNITHF0eXNwNTVXS3pzaU5MYUk2?=
 =?utf-8?B?R3JicFRkK1YzL3NtY3k4SUl4MnRTRk1HK3pENmJuOWVmRmZURXNCbTVadWkw?=
 =?utf-8?B?dExNSDFKNE5pRWsyZ2wvUkdmZ0pZaUhobXlnWkxISG1KUmMrL2dXYWFtMlNB?=
 =?utf-8?B?REQxK1MzalBuTHhnUGdmdyttV1A4blhNNCt4aHIxNExTSG5URk1zRXBpRWM0?=
 =?utf-8?B?ellSUnhLQXRFOC9EY250VWpTeDNpTzAzU0dDaENBQTlPakNKTmk0UXBnSU9z?=
 =?utf-8?B?Q0Z0ZGxUb2wyMHBIZ3FVb3dVVStqbjFRbHAyMXpCQU1neUFqVmRkYmtsajV1?=
 =?utf-8?B?UVNWMi96YkV6bTJmeWZoU0o3RklVWUtXcndQU3dlSWlwN2ZuUkZWbVl3SWJQ?=
 =?utf-8?B?RjJ2MHBKYlM1SDZoMkJZencwcXFzbDk2bGJVRFZ3WTUyelJJTDVLa1VSM1Qr?=
 =?utf-8?B?RDdwTWJFTDBkYnpHcCswZEVYRFpPTm9LL2MrSURBTTlNTlRxWEZMYldtVDdj?=
 =?utf-8?B?L0hDWlFRWXVhNC90eWcrY2U1bE9vYkZMenpSZjNWYUF0MzZlamhaOU81Z3Rz?=
 =?utf-8?B?M0NuNHFteXFKVUJpajV4L1FhRHpNaklWT0tVdzNyOGovTzZNVU5wYytxUlJh?=
 =?utf-8?B?QVdlK0l2RUZqSXl0bE1uamNndXN2amNIYTZpV2xUMUZPM3BFQXc5NDFBZ3p0?=
 =?utf-8?B?QmZhNE5NSzBDOUIrWU5PZzdsMW5jV3FYL1o0dWpMaGhjYit6UnNzYlgvZzhw?=
 =?utf-8?B?WU1iRjFod24wNk5tSlFDQmtmREIyazVRcXBKeis1d3p1SDVkNEdTbVBPR1Yv?=
 =?utf-8?B?N2RoU1hpVEM2RmVEVDFiU2VMYytBYnZibnZyNnlVNExyWm5vbFRQenVoNVVV?=
 =?utf-8?B?T2NyMUx0OC95TkJhejRsV0dWUHhHRjVmNW9hZEpUaDMyeHJoamppdWN4VE5L?=
 =?utf-8?B?VUlBMGQvSDdkbGJqcHVEU053RVVGaEtoVnh0eWh4RTllaFZtODNaQVBSNWM5?=
 =?utf-8?B?MEs2YVcybkxDOHllQW5GNmhPYzdNalFyS0ZhbnpBQlNwcFRha1JrVUFlT2NP?=
 =?utf-8?B?MVg2dHp4Nm9EcTZNcDlMOVozWUszUzFkbHB6Nm9pWm5wZGRyZEdRaGxZdnpR?=
 =?utf-8?B?V2JhRG1NVGJlOG82bThGKzJBZHJabXc2VmFISi9VaDQ4Z2V4dzA3Uk1QanhC?=
 =?utf-8?B?MG5JUnpEZmt3MW1XMWI5N0IzLzNFQ0FNR0JlUEZFMk1lSnJXQWdRVUlvUitP?=
 =?utf-8?B?dStpamgyMXJNOThCdFMwR25RTkhnNGZEQmdQVjkzNkVFc01iazgzZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceeaee9c-30fb-4eaf-5c9a-08de8e5a89a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:47:44.2729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4Vz98VoqnWGjD0CAuPFJe9p8gH0NXo/iCPkOmT9cXdOvpVm8BRjps2pVXwpBoOhmYHKDjKkgwSsrv6jf9Jkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962
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

Convert the board to use DM_PMIC instead of the legacy SPL I2C/PMIC
handling.

Changes include:
- Enable DM_PMIC, DM_PMIC_PCA9450, and SPL_DM_PMIC_PCA9450 in defconfig.
- Drop legacy SPL I2C and PMIC options.
- Remove manual I2C1 pad setup and legacy power_pca9450_init() usage.
- Use DM-based pmic_get() with the DT node "pmic@25".
- Update PMIC register programming to use struct udevice API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi | 22 ++++++++++-
 board/phytec/phycore_imx8mp/spl.c                  | 43 +++++++---------------
 configs/phycore-imx8mp_defconfig                   | 10 ++---
 3 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
index 4804a204e92..e9403d9ea82 100644
--- a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
@@ -34,6 +34,18 @@
 	};
 };
 
+&pinctrl_i2c1 {
+	bootph-all;
+};
+
+&pinctrl_pmic {
+	bootph-all;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	bootph-all;
+};
+
 &reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
@@ -83,11 +95,11 @@
 };
 
 &i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pmic {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usb_dwc3_0 {
@@ -96,6 +108,12 @@
 
 &usdhc2 {
 	bootph-pre-ram;
+	/*
+	 * LDO5 output depends on SD2_VSEL, but no way to read back SD2_VSEL
+	 * when using SDHC controller VSELECT to control SD2_VSEL. So drop
+	 * vqmmc-supply to avoid fsl_esdhc_imx read back wrong voltage.
+	 */
+	/delete-property/ vqmmc-supply;
 };
 
 &usdhc3 {
diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index fc7aefd0073..fc6f5104925 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -117,45 +117,32 @@ out:
 	ddr_init(&dram_timing);
 }
 
-#define I2C_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PE)
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = MX8MP_PAD_I2C1_SCL__I2C1_SCL | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SCL__GPIO5_IO14 | PC,
-		.gp = IMX_GPIO_NR(5, 14),
-	},
-	.sda = {
-		.i2c_mode = MX8MP_PAD_I2C1_SDA__I2C1_SDA | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SDA__GPIO5_IO15 | PC,
-		.gp = IMX_GPIO_NR(5, 15),
-	},
-};
-
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	int ret;
 
-	ret = power_pca9450_init(0, 0x25);
-	if (ret)
-		printf("power init failed");
-	p = pmic_get("PCA9450");
-	pmic_probe(p);
+	ret = pmic_get("pmic@25", &dev);
+	if (ret == -ENODEV) {
+		puts("No pmic@25\n");
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
 
 	/* BUCKxOUT_DVS0/1 control BUCK123 output */
-	pmic_reg_write(p, PCA9450_BUCK123_DVS, 0x29);
+	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
 
 	/* Increase VDD_SOC and VDD_ARM to OD voltage 0.95V */
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x1C);
-	pmic_reg_write(p, PCA9450_BUCK2OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
 
 	/* Set BUCK1 DVS1 to suspend controlled through PMIC_STBY_REQ */
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS1, 0x14);
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
 	/* Set WDOG_B_CFG to cold reset */
-	pmic_reg_write(p, PCA9450_RESET_CTRL, 0xA1);
+	pmic_reg_write(dev, PCA9450_RESET_CTRL, 0xA1);
 
 	return 0;
 }
@@ -193,8 +180,6 @@ void board_init_f(ulong dummy)
 
 	enable_tzc380();
 
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-
 	power_init_board();
 
 	/* DDR initialization */
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 2fcf7db9e5c..51d9737afb3 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -10,7 +10,6 @@ CONFIG_SF_DEFAULT_SPEED=80000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-phyboard-pollux-rdk"
 CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x7e000000
@@ -113,8 +112,6 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_FASTBOOT_MMC_USER_NAME="mmc2"
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-# CONFIG_SPL_DM_I2C is not set
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -144,15 +141,16 @@ CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
-CONFIG_POWER_PCA9450=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y

-- 
2.51.0

