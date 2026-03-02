Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB73E9B37D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1351D83F6D;
	Mon,  2 Mar 2026 14:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OHNcv6U+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8239C83F14; Mon,  2 Mar 2026 07:40:58 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6071C83D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoslksioatYQJST25+KEitFzRGKx2z2jGjkdiUEGSeYx3iqPhY2XwaRemdhE/oIzfvorHL5HVvVCvKg5wPO1k1lXDR9BU03jTPeWIcWrCEUtvCAPXZvcvsuq+X0A7yKTbjzJjiZVXfsfcu7jmEkMrNMfV9WMIKSSMUzhEVTKs28lQpJirgjydnskZWbSOf5E78/R5/6mF2K1sxReIZxnE2fTQ/SfOXZRVOQf+3NG+x/hT4NOaX2VgKKkVHAhz+IJxHVpkm/Fwn2x0vKWd4kv0sm58tdPUuyj5wQyFsy3TY7aTAg241nrwdxGa5Cuu8Vi6je+LRDL8xtqrb4gh2G6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3Qloh/qhWh1CavL899+6nyPtAmWypvvttNjShtZynw=;
 b=Ike/DXqMCTN/x5W/4t2W9UNcI/oWYl7/EvvBFDeZWMncs11ZgjmPxjhdlKmbuqe6H2u1nOsOkkcwAHrbyWDWcj63SaXJgrtcBlF44Li22Foqory5yiZ49V+TUVdqSthkcO2DYFwSeZyyyrE56Id0SWUgfk6/xvHVBvVfByPDJy80rLFf8ynqhOcozP9mR77FPmR4IKBjUlix9PsKBiHBtRHZeYgVO/ZFIb9rmZDYKPaPBRGpsjRS4XSBRuWwS/7GmYOC+LB0r1O+qZbiuoT5TjCrnB1dcVoN5bNlF8EIcYb3Omzp9vxFRZ3CMlx82gfu9dsvayleIFuNsXsYOXr5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3Qloh/qhWh1CavL899+6nyPtAmWypvvttNjShtZynw=;
 b=OHNcv6U+tJ7rV4Zo3tBF5G9IyPrtg+K+jLfRtuKKD1y0496Mbbnx+RieciJ3pTBjEahj+MPvfGtvNLnbQqNmbHQ6TAg1HR1Ug7OXR1RKTH7BQP+ujK9ORerhsUdOSt1eGVpcIT9XFPytFNEeFPsie4INz54DUUbB6ll8iKbeT9X/Rb3RGYupziSPk8rU8w6Z58pF6/bWSqX0Xi4IhDGwtkoy3ZLrQEJ12BptwQfud5m1OLeWrvSFJUjRsrWm7S1vIOJbUL0jjxAxwNeU7mun8vd9zzf8kx1g/2T8/XSliIitojJpQuU/s2+GsK2OKP0XTcfpHjZU7oV+T1LpxF/FVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:40:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:40:52 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:05 +0800
Subject: [PATCH v3 04/13] arm: imx: Add i.MX952 CPU type support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-4-069d6167c0cb@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c210620-a5f5-4d64-f5fb-08de7826a63e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: ksU02/xesiJR46oGsIFbixPGlDG4wpjBeZI9zevcA9+8BtcN6XUhn6ZbnMXS45LcFeCRV6Sx1P182AzTb1UU/7heQaHN0jMel7MlG3vadYj9PfIKa9A7im7I0yeOWs6tDBIb03Mc2zvtp+WjjdS1YmPqdWBRGdbVmrN7I8fhKWkjq4LWmw2mhyIlxlIc/xbUsNNw8n+m6b14w7L1GvYO+y7G08p/fZaS8yyFvKvNtlDFglXpWmAeJdyFNgFDNYGqcOjM0SIc38L0vjOLdNUM0LzhX87EbTUhmpZ09DY8XVSX8NoGHUGZhEtq/F49quI1vrFmCcHrzOMFkQEt+ZA4gxi80uKvfl1OSfEsvmfPc7mJTgjyosoUf66hZBpv83c89JhqaFSwi/8ewjiMLrfKro/FWdfqDVPU3HyljuaeDlBm1Vn3YH0qkMYhqr8a3bll2In0fF24mHmWgCND1IgkVRyo6sA6huGo3DBbpX9n2Vw4lRAfT6GmdOKnEfM9zYvYpEAbwkH8L1O1MmJbzxrg4oge6lMqqcUclfj7fWExqRRoOqVUk+H+Ies7ZCZHXbeM4EwGYPmFN9BB0JAFrWUVKZ0iuxClcQ3rZzsPHia+6rw6Oe9mZt7vaCyFCMNrQ8DUQxTOlqPaRMH6Hj44hXUjr1PlQTirI+vFTff8BcA0iEDZgCarYRQkYATy8U5trNrxALpY9JKCTNmUTHK8fO8PtIAfn0wIwHf1Z1rglFoihF7WGK3r/zC/OYAuBnoq6LL4sxEqzK7QacyVVD0Ky5u5CmAHSvP30aBuJb1OAzbi440=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzRLaE1DVmgvVklOYnRoSnphbUh2QzdleENVTlpONzBEZEZ5UlJkcFpDTnpW?=
 =?utf-8?B?SHVqSC9nYUlqYlh1cEVyZFgwZlE2ZlJ2MHhXS3ViSTJqWFBYZnhnZSsrTUdq?=
 =?utf-8?B?eFAwVTg0QlhTUmNmMTNiNXhuQklRZDlSYkNBd2MxOXREcjRLcTZGM0RIalpI?=
 =?utf-8?B?N280VXFjNjJXY2VKTUFSZ2xPaERzL3dZaFRnUFpIcEU0MElZVGoxL0VBb0lO?=
 =?utf-8?B?d1pMSGRLc2JINkpiWEJIVDlQaWhmK3dNSEdIbkU4Rm4vY1hsODFtcWhFVi9t?=
 =?utf-8?B?MTU3UVVqVUt4UDlxSnJ6YXNQZ2lPUDRITXdHYVJzSVdDVHBIN0xtSzV4dlNR?=
 =?utf-8?B?VTZWUjhpZ3BYWTl0Si9MN2JlU2ZqWXpxMkY0bUgxK002V09iQzBscG0xSTRO?=
 =?utf-8?B?VWo1M3RPRjJLNDFDai9KdVVWalN0Wm5ySmh4QktlbHZUMzVhVExrNUJ1RUh4?=
 =?utf-8?B?Nm1UM0gzbW9yWmR1ZFR6Q1dxNlRxTXFnb0tBQ2YwN3NlN0xJK3NNZ0tYamdY?=
 =?utf-8?B?UlpDYUpWc2JmMFQ2dlNiYStJeWFDKytDSEFVVTJkVmtUbDR1WE9TYTJQNDV6?=
 =?utf-8?B?Sy9DblhjMC8wUkMyenl5R0h5ZjR3MXRjMmhRbkkyQ2tNRjdkaTJKcU4zZGs4?=
 =?utf-8?B?NWRtdjNxTmk5dlRNbzJqSGRuV3phMGg5cDJLSUczYURGNnZQb1lUTlFyTHp4?=
 =?utf-8?B?Q2xZWStEVzhHcFQwMWhwNitMTjRjeU1UczUrVW1LcjJqSFlRRmZJS0NXRDkx?=
 =?utf-8?B?VThiMGdlMmE5TmVjZmN0aWV1eXFWUkdSbXZPT2lHakNCKys1RWhXcWxONlM3?=
 =?utf-8?B?OUJwb2F2emUzNWlRVnpyQ1JGNS9EQVlvWWZEYThUcHpsaXdKY2ZWQVgzM2pk?=
 =?utf-8?B?aVdTSlB0dGRUNFI5TmNQVndqdTJFNk5IMWYrbGQyUlNOVHBCNHZ6SHM0MDlH?=
 =?utf-8?B?eXZsQlFYd0FXaW9WbUpONlZ6VE5nN0M1R0NlQ2xaWHFYWXJ2VW4wMjd4bVRr?=
 =?utf-8?B?ZUtIN09FT2NMekJDS2ozbVpvS01UcmVra1E0bW1ieGVhZDRjUWcreXlzNGFo?=
 =?utf-8?B?M3RRdEg3N3RPQVA1V3kraGh3Q2djY01WN1lZNzF6Z295K1ZuRWljQytnaWs5?=
 =?utf-8?B?OFY3QmRzeUVDSGdwV1VsOWdPenQxek1SRHc3RWdEY3VDRVNYTytKN0hMTzFU?=
 =?utf-8?B?cENxQWRGd09QWm1xQ05zVVp2bDFMU3ZnNFlCc2RrZHU2VlZ3MU1XTGFwNXNR?=
 =?utf-8?B?TnM0MkxmYnhYdGZJUk5VYzFwbXBwTXZLVjVPN0dqOUQrQ3o4MlBrQ2FwM0J0?=
 =?utf-8?B?ckpTMVpTbUZEc1NYNituT0wxMFBFSWQ1UjZUVHFINENCQlNqcjQ5d2J1MHZG?=
 =?utf-8?B?dU5FUjFJc2UzL3g2Z1ZQb0JoZU5SOHkrWXB1clZOaWkvVXQxd21HRldlQ1Nw?=
 =?utf-8?B?cXY3UnFmOEtUTFJlWGtnbTFTbGhQa3FCRHhLV1NvU0o5bmtNK01KZFBySDBy?=
 =?utf-8?B?Y09pOTE2aWNJNklNZk5HOFQvTE5jUjNjZ24vVFUwM2Z5RS8rNjdkRWRIOFNn?=
 =?utf-8?B?TGVZZHNlc2JVdExwSGZReGZWZXg5Skc0dG9qem9xeGZrTE5SaXpPc0x1a21E?=
 =?utf-8?B?T25iYjRkb3JXQUlrZE5UOUsvbExhQzNQL25WeEVDeVVhNFVPQmwyNUhEa1dL?=
 =?utf-8?B?WUJ4L1I3Nm5kVU5YNGZLOUo0a1AwM3Ntc3h1MTl0RE9SbDRXbVU4TXA4QXVj?=
 =?utf-8?B?RHFZczdRWVFuRVdpN09ZWmxmeHlXVERRWFVZWUU2dkFkcStpVjhrOTI4Mnpq?=
 =?utf-8?B?MFoyRlJMN0FMQWFJYUhmNkw1OE9BWWNxejFjT1B0K05WcUxqQUk4TFk3eDh2?=
 =?utf-8?B?NVZSSHpKcVpmZjA2RFB1OC9ZejdwMTZoR0hNK3M2Zll6V2N2ZFYrS1VKSkg0?=
 =?utf-8?B?V3B3dWFkOXQ4QUZ3dXNPWTN5YmVEclgzc0pjSlJZcG5yV1ZraWxNcXZwRTM3?=
 =?utf-8?B?THpXMWxIYXMxZ1hkZUoxZGh0SFNHem9oclFRUDRDSmZnM0FIOXoxM0crSHho?=
 =?utf-8?B?UklKa2xHanNoWndwdll3Qk03Tm1EWjhlMG1PMWQ5L0luRGR0c0I5Y2lkMUd0?=
 =?utf-8?B?NUhPRFBvVDZYSHZ0N1g0N0lENkZDcExuNmlBWnNaNy9GelE3VExyZEZGYU1P?=
 =?utf-8?B?clJZY3NrR1NjVzJ4RTFTOWx5dUdEUUwrWnc3NnVxVW9OUmN4cURoZUlxeWFk?=
 =?utf-8?B?Z3Rjc3l5VU5FVFRNYXkyMGJGWmlzZ3R4cWlzMW5OdDgwM05pcHU3OTlKUkFO?=
 =?utf-8?B?NnZSaWIwcmdPMFY1cG9WYkJQdU9CSCsyU2h4a1VUaXZLU3NkN2hyZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c210620-a5f5-4d64-f5fb-08de7826a63e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:40:52.7641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRKyk7JvAOKUIpENFRu0NFsIkV2TcrIeT877ItrfDaosXMOPY7RF8cRr+fZaHDX1cNLEWNfys0YQ88n+nMKELQ==
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

Add CPU type definition and detection macro for i.MX952 SoC.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h       | 1 +
 arch/arm/include/asm/mach-imx/sys_proto.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index 1af9778f8ce..25d0f205fde 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -79,6 +79,7 @@
 #define MXC_CPU_IMX95		0x1C1 /* dummy ID */
 
 #define MXC_CPU_IMX94		0x1C2 /* dummy ID */
+#define MXC_CPU_IMX952		0x1C3 /* dummy ID */
 
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 13857b921a0..ab573413128 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -99,6 +99,7 @@ struct bd_info;
 
 #define is_imx94() (is_cpu_type(MXC_CPU_IMX94))
 #define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
+#define is_imx952() (is_cpu_type(MXC_CPU_IMX952))
 
 #define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
 #define is_imx9111() (is_cpu_type(MXC_CPU_IMX9111))

-- 
2.43.0

