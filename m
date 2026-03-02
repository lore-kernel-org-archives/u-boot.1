Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F000E9B37C
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B3583F5B;
	Mon,  2 Mar 2026 14:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fPonZmf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B89A583F14; Mon,  2 Mar 2026 07:41:04 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB4C583D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnBQyx8qgm9mcefsJ2L54uGsIpJlmPczAw9Mt3kR+j8ARWTHoMm3fTznH0oy95rgKRsS2IpXsxFgD9A03ZfV8mDUWT5Oy1DnjddK95qcTjEif+MfTjkYnygwXhE8xSad8wFD7kfs26uzEhKtEpjz1/2c7m+F23WvCBr0bsTST8gBVTtRVusAZZXxjAJjzK/BxAuXDmAOxmtf1iMdzwYRHjnMoPDXt7ZyHeGoIFgbUO7gdUa7a63ZUlM/WFnc4LBT1QwCHI2m339VCwyU6KjgEXxln8ejnm6D6hx6sD982WFUHHsGMK73svu6XId9b7q36a22K/hbHDijk7Ke2ui0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kvssIqfh/RQXbbzNRHHMCNgVlcHOIILKb6cYYBZ1Ic=;
 b=TZjltpxR5ClYxRGRt5w5SkhjixZrsyYoVrrzgr0mJAdkk6fr423QfWmjO1XIKya+t9Xa7ej9nQOSyJQjhV/62u0Pkh+yzhZoLaT4g5cWf+nx2xBSCd3ZFzz8a4T32f9e17d19JBJYReo2nXsI+R4U/PD1U3moc+6g1KQQm3Cj0Lx00iYF9F/zHFyJD9C8oAO1VS71k7KjGH++g5SPRFRdULStWQE0SN9AxhcJUmPX8KnKkQs5+LgP/vLeJhCrpirQFdpq9pg5m4AujpcDffEZjpdivnykTmU5EqSEFLitcXnkxB+kU4Qikhoor8vClo9c/WQOWLlnB7Ik3S/I/Bzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kvssIqfh/RQXbbzNRHHMCNgVlcHOIILKb6cYYBZ1Ic=;
 b=fPonZmf+wPBT9voC0hVV+xZa8sBmwFDMfuRcpuBABXidIRKKGiy6cG8IPsCB3wwYyyx+8+qsSg410Smw8a0rH5vpOwAxBzVw/crtzW0i+ICRPxkbwwoexuqSBufaxuVo6iUgQcOM0IIglpzr05glxlYZUu0XSau3i91zcExMK5PLobwcuUmFWjEiwQKbWYa2BPUU2Gfo5j26nkNny0x20xR78PXfEs9iRkJpUc7EnseUKPuzGvGWZHR657eQV3QoWgI99YhYZ7K1uiX7yGf4fe12y5dPzE1oqNaaBjgOw/t9OhoKge5onNwWyCoprHPKwrpRkNNXAripAOgGGnuf8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:41:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:41:00 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:06 +0800
Subject: [PATCH v3 05/13] imx: ele_ahab: Add i.MX952 support to
 display_life_cycle()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-5-069d6167c0cb@nxp.com>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf53b15-ce26-4ad9-8764-08de7826aaf0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: pzzxiQ62d0FPp+Y3iVUDU0744RgTHivKCR4o+QoHsvPIQMSXjgEtOt7ODF+j+h82e+MFy6OS5nvAshHdNk6nDcwHPlppe4CEgWiM5jwNRwcBhPLw0qnFEw+qh+eN7RUiHOkBbtl/ppAUgSwmDs2jegQYRFW8sIMs7ZZBuePDFuZ1cJ4oGz1/B8bydWj+CsiSwRWCpsJv2m7SCLhATpvOd/JZstRe+CejTrfyjB6dJxuSBzePCVc4uxXR4ecslXR8GYyFQxcCzNQHWuZOtPH4/SIxaUGb2iBkMdzrcP+kJGMhjwvvfw+GGZCNz5u5mK9YlISXig/mJgsy8QzZ2p6a8K0Aido5KCR4LN5I0AVzxaLLeb8i5vk2OYGzuqkcJNirQ+U/ufLudsRNUSIl6dZiOb/q79IHC3Cpb2//8U++27o/Rncb9kIfK1i8I+mimcYxFtPsac3CTdJxstPDQj9tRcHbgEg6NrmbZmxHHSOaYjmLX/8yPlMMpIU1eLJSmHzsUDUg5eI7GVR+h4rN4+0EM3lUAgM+Y1PuKeccY8h2TH8fBMCn2rOv1qHVMxbjkm2gQ7cLAIobftED5Ug4A5QK2Xuy2UzsXxtRbpEBQWpWxuqYxca1f3TUL720Z6M70NAdHcI/n0EV62kojgGjEdpC6HWaN5lJYaCTbntN5etZ4allkYCAKMt9AbUFVBhn0EwXZqVU6PoHUmjdwq7474/Z4Z+maj5sNKSYgbzd0a4yz9p+3B2gJSrl78mpbRzVuy3VhnJTf2LYHNEctzRTHOfzslpu9LTX0ftaTFk7CxBh4u0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmtMYjRRN1B3WjVWczBMK2lIQjd5dTBKQnRTVXBha3ZUWWVlZzdQcU9pa0FT?=
 =?utf-8?B?ckJybXh2aGZUdDlpSHRHbFY1MVoxMjNmYllYRDVPVW42UTFSeHBpa2lTZlJT?=
 =?utf-8?B?bVo5NkVEL3kwWjc1aEdJYnlmellsYXo1VEYzaGtWbzM5K1BVNXNUMmphY0px?=
 =?utf-8?B?RDg4VURYUWVIeHB6cmpQWEx1aVhpT3lHYlZTSWZwSlJudS9LaE5Hb1ZqU0hl?=
 =?utf-8?B?SHZJdFhrMzRKWmwydTZyWkVONVRJNW5pbUlYbzZmdW9yemFTZ2NGT2g5U3g5?=
 =?utf-8?B?dE9nVXNYNmhtcVFpMGhHTENmV01lZ0JydVdiMzlzckJpRzE3ZmFTanZVQWFG?=
 =?utf-8?B?N0xWejZKSVdCajJUdmZlS3hFTnVTL3dMOUt3d2h5UnZVOW8zUWtNdlphWDBq?=
 =?utf-8?B?Z0IvVTA0OGNFS052UTFtcXUzbWh3QmVoVTl2RThpL3JjbWh0UGlLekJ4UnFL?=
 =?utf-8?B?Zll1VlpraFRwUTkrRGZlWkNhemx3MzRnTHNJZ3loSExIdnp6bllkbldmbUE5?=
 =?utf-8?B?bS8vZjd2dmlnTEwxSEtqRVBaYzAzcUJLb0l4RDh1NDdRMEw0WHJoS1BzMWRh?=
 =?utf-8?B?aFhHNUFXMklGQmlWWHA5RmJSa0taZlQ1TEJDSmxUU1VrUksrOVVsK2lqL2RY?=
 =?utf-8?B?VGkzUk95aFI4S01WcWs2V0d2RkpjVncrYmdoR2FUbzg4elJnK1hyUEJBeE1V?=
 =?utf-8?B?MjlMTElIem91cEh6cDBrYm9FWmdETTc0cGZCNklncFVGdzM4czJHZGhBczlz?=
 =?utf-8?B?RDhWVEpWNkFnWTVQenRoSmR4SWVjaGRGV0pkRW1rM05lajVKRkJxOU5IUHN3?=
 =?utf-8?B?QkJia0JKWnB4M1A2REhlQ0NzbWkwaC9KeWx2NjlYQi93SFRBWUNqakJXOER1?=
 =?utf-8?B?STY1SHB0eDFHVGU3empRbnNuZm1aSjdWajkxeXEvV3hHOXBoUkhibEt3Ym1Y?=
 =?utf-8?B?S3RhN095R2dOVU5iL2pHT2lXNjNRQm5tekJFZVUvenU1NDQ1MXNPNW53YVEw?=
 =?utf-8?B?bVYyRDBSNzZCcXhYVFYwTGVYUWkvcE5wd1RFNHRqTGF4aElaQnY5cjVlNnl4?=
 =?utf-8?B?Zm1vTDFkZDlwcDMrM2JlNHB6TFNISXhFMGxIZ1JzcEdVS0pLT1BLandHRURr?=
 =?utf-8?B?c2E5NjRuTEpRVGg2VDF4QlBXeXg1Mk1KdDJiUXd3aTRqd2paODdENGd0TkRQ?=
 =?utf-8?B?d091VWY5VU9BaWZTYnNpaTFuUFBoTFBtQkkxYndLcEcwa1dUbEtOblVqVndO?=
 =?utf-8?B?amlHZ1pOTzBXUUpPSXY4YnVyNDVLYk9BYUhBdDRCaVBvYUw2TWI0T2JaTG5v?=
 =?utf-8?B?WEJvYkR5aDVtWjlUaXdWNzVXT2J3WWRuYUNIZWQ0RFo2ODAxbGlnbkNKREVy?=
 =?utf-8?B?N0RwN0FwOERQVGdmcjdrd28yampIVGVIT2k0U1Bva242amJDYUdrRVk5KzhL?=
 =?utf-8?B?MGxPbnVGRFdaTVdYektGTGM5T0FLZmZHc1VKTkRYZVZ3NzAzV0I4S0Y3OFRV?=
 =?utf-8?B?TG5RVmxtSkN2bzlNU3lyNTdqM1I3OVhkUENWYzV0d2ZvNk9Lc25wbW15T0pu?=
 =?utf-8?B?SHg4Y1B2NjJqdFRSMm9rbTU1a2ROV0pGU3ZIRTFFYzB4TDFDb2NTQzlReTlu?=
 =?utf-8?B?U3JJdStQRjBlTUxuSkZka3VvT3AycXlsN3hsYW1HNjBPeFpKRFI3V2lYN1Q1?=
 =?utf-8?B?V0Y3b0RnZFN4N0RxMy9pdExUdW1DQ3cyMXNLVWRJajIzSUZ1M2YwMG95QXZ4?=
 =?utf-8?B?R3UxM1VKZnhVSW9oM1dIQTNCcHNwVHRvR0pRVlkxQ1ZmUFNwREFNV3RDcmZ0?=
 =?utf-8?B?Y0E0OXIwbVVmQWV3bW5aYkwvYmFicSt2cE4zbWJJZ01maE1Ic2NnYXNLbm00?=
 =?utf-8?B?MVA3Wkcwb3pMSmx3UHNDWS93MlpWM3ltYWR6WFVCMFB4MHRIWE42ZlFjUUNE?=
 =?utf-8?B?WmxHbExsYnFHbSsyK1JqS0Zrd1QyYWZPaHVhekh3UFkyT1hneXlzcE9vSTZJ?=
 =?utf-8?B?K1lLbFRSS2tvYml3VzlvYVlLZ2RBNEVnRUZRWnFqQldYUnRqNjBOa1pCVk5D?=
 =?utf-8?B?TWI1UjIyWUpFZVZXSkNVaHFicWdaeDJKT2RmUktEOFhVa3hPU2NPVEJadmxX?=
 =?utf-8?B?NDJXdkFBakxkVU1FcHJ5VE5OZkxmc2xLQ29iVkM5aWFPS1ZudnBrbndxTXBM?=
 =?utf-8?B?WmRSVldiOUhzZE56NXJDOUhqejF6eTg2ajljT2MrVHhkNzRxR3hwSnVhM1FK?=
 =?utf-8?B?WDJDT3JHRml0MDkxS3E2TGtmRFRaZ2pBNkNqdE5MYmp5VmZNV0Y2Y2ZTSkNK?=
 =?utf-8?B?K2FrYjJxcHdLNDBDeGZEQjR3Q2FYdUM1N3dsY3hTektyZURScTluUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf53b15-ce26-4ad9-8764-08de7826aaf0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:41:00.6675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln6hSe28Qa0kWL/+ELCe1IYLmjIo+57Unp82UDahab7fOsoxvJIsJ1qHOFqjtCAZiKqqsoMn3aUN/l+49aF8cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

Extend display_life_cycle() to support i.MX952.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/ele_ahab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 4d4620dcafd..9794391fb35 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -412,7 +412,7 @@ static int do_authenticate(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94)
+#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) || IS_ENABLED(CONFIG_IMX952)
 #define FSB_LC_OFFSET 0x414
 #define LC_OEM_OPEN 0x10
 static void display_life_cycle(u32 lc)

-- 
2.43.0

