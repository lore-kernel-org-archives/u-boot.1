Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB30E91298
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 701EE83C67;
	Thu,  5 Feb 2026 16:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tXqT94Qo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5E583C67; Thu,  5 Feb 2026 16:16:36 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E7E83C54
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqjvhrZLLUe3YD7GGUZnwL5/l0uK83c1hCxMDbS+9WKhezXU7xgFoicSyo5J4cd0M4z3rcF9N1WlklqmfR/Xj+SB9NyChR1Z5dqGh5yOoYGtgEvp1ZVCOmq0AkU/CV8+kxNbmXI0YTYFRS2fvbz8+Km2D/62GbprxprLhDUVmDPwhJD/tZDOC0EcCqT98Xvmh8MBBMB76Ph15O+UeI8sOWMRmQQdd2JkCKG6CivIFnlnJU/427oD9NSf3kpCs6HhvuQqdlZ6l5sHc3rNiJMFeh6iQ6wt34n3BNbPRothSSXxfVttbQc6CdHbcfHXpvwb/yqb1g2nmBB3E6eLxPAtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnwyVwNmhe/ywd0/qIGaYe7e6XNvikNu98m5PpmBAsM=;
 b=zTvGVzybHQHOvnALH4g4t3PdKbs7veKfd/2L4vHXkirao+BKEP1VOkWJ56DI8t34RY2iASfSAkQIfLT2zc+PRIDOQm6gAf4F3CDoyLaB/U1hIqhZWH5W86l3ItfFDvvKTked4TtrMXcIMihGNpi2tjUtbl3lGSfGqXOo0/7840zqteYK8RF27a4KCmIge2SD4S8pDb23bzm8pd9sIe2AOy5lPfC6Wmiu+GEA/4ss9qq0jzve6QDX5wQupsR9samOzLay5z8ri+wT7CP2BKQ9CdmppxyVdukMmtdkVx9dV72YVHRgPY53XF3+UNYTc04+SOSy5F8BMI/wrWyQWstLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnwyVwNmhe/ywd0/qIGaYe7e6XNvikNu98m5PpmBAsM=;
 b=tXqT94Qow4pTGF+9G2ViSHITuwmiYP+SE0D4IxCqY6gg7jx3NOiUQgluWi5v/tfYPyg9wOMP4xMrFbEuzc0SzXm7gK20KCGcy552+RpwAzY4p8BzXw747w0NdyZ+PSoFICp+wBr+rnzSWv0PaHbuSIovgKl0pyX8wnNKgzYKzzZ/4oSd7RjxihOSOYQDZct8B8EOlNZ+FjQWwx0rQgnVdrq2wuNgoTHbrPA/jMM003uSXqaeIL7LZx08FlftpjsL1Hmf8zIVScGUF3UIM+gCMKrtcdbqJXAotAqrz0vdipo/YM2hnHivuqKfVNM3KauPY/Es/N7YNKNeTwuN3Q2I5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB11038.eurprd04.prod.outlook.com (2603:10a6:150:211::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 15:16:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:16:24 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:16 +0800
Subject: [PATCH v1 10/12] dts: upstream: arm64: freescale: Sync i.MX952
 device tree from Linux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-10-2103d0222a0b@nxp.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB11038:EE_
X-MS-Office365-Filtering-Correlation-Id: b0fc2515-e710-4250-0513-08de64c98627
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUVmQ0YxUi8xbi9zSTFVZXlrSm4xUENrWGRJSFpkMFNGUit1eWY2SDNDcWdh?=
 =?utf-8?B?L1d4QlZSb3NpU2tRTDJZdGQ3U3lDNjM4emlHbnloSys5RGlmcGM5aTJuNXVO?=
 =?utf-8?B?ckRMRXN6d3J2VXBmTm1jSE40M2pyendZa0dEMjh4S1VzV05ncVprcngwMFJt?=
 =?utf-8?B?cGNqeHZUZitsWnArZjVQMFNtQlNDRzFFVXc0MkdTL0xBYThNT25CR1hMNmRN?=
 =?utf-8?B?QWI3Wk9GR0RaaDZzbzVORGZOZC9hQlFVWnZ6K2JDVnZlaklsTGhlUElESUZX?=
 =?utf-8?B?L1pPQjhSaVhqWmVNNGpXMjBzQ0JSMXdhbUpGVU1QUGQvNHB0eWUxZGZnZ0Zp?=
 =?utf-8?B?dzkycXdYZ291MElvdDRQWjl3WUxDN1ZucmdDUXg5S21XK0hvK3FuMVJENUpH?=
 =?utf-8?B?QWtBWU1aWjE0aUFHS05VZG5sK1NkM1dnbkpsSlJ1TDdKTmpaWlJUS3NsYVpX?=
 =?utf-8?B?b1VIWTJvVWNLb3JPalFwL2UvVEozMGE4T2pVUlplck9hTkdURDNpbkU1aFNW?=
 =?utf-8?B?MXJvaWMyakN4azEwa0tJdWxqcll4ZVNFRHNaclRlUE10ZEJwK1N1YTZmOVU4?=
 =?utf-8?B?Wm5sdlozT09VRnJRRHRmRXlsamhXNjNNWE1OOWZ5cFd2SlpKTlpFejVNeWhY?=
 =?utf-8?B?c2V4bVArR1p3MktiZldQaVJXZENJK1NRZkJpa3VVeW9kRHArd2dReC93U2hn?=
 =?utf-8?B?Rk5PeU1PbG1WNkVmZlMrNTJrY2FoaHpwdmxaUGJzc0NQVHJFc2pUUHoxNkkr?=
 =?utf-8?B?bFVhSFY2dHplNjhSVWlnSEd0RFVDeXpUOUJ4c1BYSjRYcEpIYnpONkdxMklw?=
 =?utf-8?B?QmxEL1NkcGp0Wndubm90TDdEclVrNGhtZDNpL0txcWxRR2RlUmpHcTZPMExj?=
 =?utf-8?B?b0szUEVYRXdUakd6bkJSVzkvSTBTOW9IVjV0cDV2OVgwellURUpoenZnRzM2?=
 =?utf-8?B?S1RJbnE1d0pjcEpuQXYyc0FEQTlZWWk0QVBZNU5hM0NYdVNzbHlzeG9jYmJ5?=
 =?utf-8?B?YVJIWFd0MkpLWmdodXF3ZkNiNWhVajFEbFk0SkRUdStNZVJKQitHRzF3MmFL?=
 =?utf-8?B?cE1xYjRHMWFjSnhEM3hGamJkTHk1RHRxN0kvWmtKeVlwUFIvck5FTGVvcEpI?=
 =?utf-8?B?eU5zOHZSdGY0aDh6alRsUnk4VEd5dytOeDI5TVZsYzd4aUNRd2hJYUhwYVpT?=
 =?utf-8?B?Y0N3cDRyVHprTEVRQ3ZIOUN0emI1WWM3WmYyS0VBNjNzQUtlbWRUc1dOdGQ3?=
 =?utf-8?B?cjgzSmszUm1RZkdTclBvbFhqM3krZCtvcUN2dm5ySTlEUTJpOVo0OXA1TGw1?=
 =?utf-8?B?MjNHVHBtRGU1cG1vajUxTW1nVkx4K0lQaENHTnFxQ3BtRFNMVThpQ20vanpm?=
 =?utf-8?B?R1NyWW1ObDlTaDh1R2tWN1U3WGVGNmQweE82b2xHZGpMTzlhUEhmZVVWSWQr?=
 =?utf-8?B?MkJHNlhxRUFZQVVSK3doN1pXaVpIenM0Rndjc2ZpUHN0L2FERVhSa1Y4WUp1?=
 =?utf-8?B?MWUzREFXR0U0cmVoVVlNN0FZVkpRRWhmR0JCajg5azNHTmFkRHREMnRSbzhn?=
 =?utf-8?B?c2dCT0lPZ0VqZUxIazBXYXllRzV6K3V0c3ZQdmU3dnFrdURzNTYyanA3YVJt?=
 =?utf-8?B?a3VCN2RIOGlTdHN2aHIvYytTZHdnKzRrUWcxNXhPVCtsNzVrUlFjaHY3T1pv?=
 =?utf-8?B?eENDSUt6aEtiR2p1MGdJV3doNnVCZGlXclc2VUVJWno0U3d4ZGxsdjhWNkpq?=
 =?utf-8?B?cEZ6VnYrVC94cTVqWWlSOERvL2hZN1M1eDBYRUVDTmswa1FYdDZ2Q0tmOHRv?=
 =?utf-8?B?YjZyL2dGL1pSUFdmT0R3Vm1BdDI4NDVpbUV4V09jQS9zYnA4ZS96S2UvNmVN?=
 =?utf-8?B?QlQrYWZVVFNOMldOT0tWY1Y3V0c0VWlGeEp0U04xNkxKU1g5MzJnSlhudkVn?=
 =?utf-8?B?U0NGQkRBdWMwQ2tQR0xSZzlBa2R6djd6bFpiTmIvN0E5Uk5HdXRrT1RyTDI0?=
 =?utf-8?B?OWNNN3ZzR0cxOFo5QURUZFgvUUpRYVM4cWVwbk1PbWZPbDdka0J6SEhsWkxu?=
 =?utf-8?B?T0EySkpNbUVlUU1yTXVNeFo1SUNiLytLSmFYck5VMXZyVE1peWhQUDJhWlVq?=
 =?utf-8?B?QWRkcnViTVg3QmtGTlczQUtrOEl3NVh4WXdZeHdXVS9uNmxNcEpFU1doYi9H?=
 =?utf-8?Q?6Vi5Dv4s7G8e8WVFOlf9qs8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDgxVStadlZXU2dVd2NDU0NVUnF6Yk4vUTIwYi9uU1U5VFQyelZZbUtYRUow?=
 =?utf-8?B?ZXVBNWtCUFdySGM5UDBTL21XLzF2b2lFZitRdW1PNmxVNWMzNUhucitjV21m?=
 =?utf-8?B?ODVJQXhpM3NlRWtUVlNIZmdLVHJFL3F0RUtGcXRDTytrTGV0a3JMVnBXTUpN?=
 =?utf-8?B?OUtoc2UzUjdUNDI1OVNYS3VRait3UTdQMVBRYVZhanVnRTV0R2lsbTl2TERT?=
 =?utf-8?B?N0tFZEJyS2NEd1hXdk9DRkJaZ04wWVh1cTc2U3doTERxNStkNk1CSkE2UnlR?=
 =?utf-8?B?bWpvRFdORjRZZWVaOUFIcWFKT2t5cmRxQ1p5R2tLeDNWMnNYNjNWV2ZEcWVz?=
 =?utf-8?B?K3FSZkFSbnc3Z09BTDFTRFg5aitmK2xIcVJvOGFVaWdxRTdmTDY3UzdzMG40?=
 =?utf-8?B?eGFSRWhPaGRXbmpDQVNjRlBVU2RXdWNQby9zaDN1eTFMSEkwUDFRa3FPZno5?=
 =?utf-8?B?Z3V3c3hQZHVYVldpQnVrNHhIbWVCSnQxakVaK0xjTTgwbEVISHFOZVhDbDVD?=
 =?utf-8?B?UVdyaTRVWkk3SkFiWDhvTmc3dm13QWtzMjZoNVZaQUoweUxvZ1l5TlROMUQy?=
 =?utf-8?B?V1BtV1Rjclhsc2tNRGZPOGV2d3JwQVh6UmluUWJMNk5xUDJuUldoM1ZuRUJD?=
 =?utf-8?B?dE4wTzRXb3luMENqQzZCaWJnem1yWTNYaGJCVnhSOWU3aWNZVGIvcWdvZUxQ?=
 =?utf-8?B?QlhqaklBT1dwbGV5N1dBUlIxOVdWemxDRGVFOVRPZTFoWENwVFcvNHFzenpT?=
 =?utf-8?B?MnNsdnlmWm11VU1hZDdhL0dpMzRxV2Ixc1NadUdzYWxnck1SMzhHQllpWGVo?=
 =?utf-8?B?WGRBT3k2NW5zejh0cXo4Vm9BR0k2VnpSN2ZzeEN5S1VRaFFYSWg1VmpmMGNn?=
 =?utf-8?B?SmhZYkoyOWQzVHFoYnp1QTMrMWwwTEtTNVZoSmU4Tkh3dDB2bGgxaEhXN0pU?=
 =?utf-8?B?dGlvTFUvV2pOS2haZ2ZKdnlrSUhmVy91a3J5a01LM0hhQmtCcjdxa3M3YXhj?=
 =?utf-8?B?ZDlNdUNOTUJHN1dndG5uek9kN2x3Wi8yeTRmSmxWd0xyZHduejMwWTRaV1NL?=
 =?utf-8?B?Tmg0TDR5RGl6anZaWC9idnRjbkhiUGR6dVdmN2R6dnZ5NnpHOEZmZU1KYll0?=
 =?utf-8?B?Rk1PdU9jRVNmUkI4YlBPOVNmS1Z1bHVqWFkwUHdRbXNBNWlMV085UlNTYUN6?=
 =?utf-8?B?MmFlQWUvS1dMaTVVV2tiVWppcURNRUtWMjFMUmdSSHpld0Y0SFFuRWF4ZXlX?=
 =?utf-8?B?Z0ozU2pjSlpQblNmcENwU0ZXREV3M0tmWHJuRVNTMWZSRC82Y3hadnhvMjRK?=
 =?utf-8?B?bFhidlJQWWVBMStFcDFSYjdtMVZ0NStpUE5obHB3R0FjNDJMbDlHNFdPSCtR?=
 =?utf-8?B?Z3dONE5iSzlSeVpQSjVFaVdqb2FOOUlaeFg2UWZtRXluc1hxbXFsc3JwdFpV?=
 =?utf-8?B?UGZWY0dvK2tLSDVCYjQ3ZW1nbFMzeWl3azhWNmJQMDBVb082RWdoZjYyTldR?=
 =?utf-8?B?ajVSMGZyK2VMK0MzQkFXSC9QNVdXU0xNTlZPMTNETnZBZ2VCZ0hGNG9RRStk?=
 =?utf-8?B?eUJEaTliSzFPTG5pS0E5bnJpdFZJdCtQbjFKaXZPaFdFL1RPUmRYeHJCWjlv?=
 =?utf-8?B?YlBRYk9ZYjY1UzBTVDJHVERRM2xLdXdkTlhwS3BCNXROamhIamhJUjduQVdE?=
 =?utf-8?B?aFhqMWlRMDVDeDNKV3JoVU53V1lxTmltdDNQRHNBQkExQVVlK1R0U3FYVFEz?=
 =?utf-8?B?SXhwMFN4ZWVCcUxhUEVRaGNVMCtsL0hqOUkxKzVuM3M5VkdxUFM5ckxSYUJO?=
 =?utf-8?B?TzZoY0lYVUJGdW9kWWpOekFMd0t4VlBMdlI1NFIwY2dqY25oZDNxc3BRN3Ja?=
 =?utf-8?B?ODdqbkJOdk1Pd09uOFU5RWovVzZrYVEyS0pWQmZTZGZTaW85Rmw2c05YQmlX?=
 =?utf-8?B?WnhnZEpqaDBtUUM2TDd3UXM1czI4ZTlBbXhsb2ZrVmhSNlhsVldhN0E1VXk3?=
 =?utf-8?B?WTVLSG9Sa0dwOWNVeXo5SHV1WUR6Z3VseW1rSlhadXU2bk1JMjcyZTFJeFNV?=
 =?utf-8?B?dEhSNHlBam1uaTBmVEEwZWRNTTFxazIxZnFpL0E2bXNrdTVsYWJLVUpwYnpJ?=
 =?utf-8?B?OU80VEkxTUxrS3h3YjJRZFFESTdIUzJUd1lTYmhRcEhqMWU2TG5SMnRoankv?=
 =?utf-8?B?ZGlNV2psVitTL2FFejNPcXY2UExwUUN0a2Z2RzhlYjRLMXJDUE12RCtzTWVP?=
 =?utf-8?B?b0NRSmVXQW5aUVVRVmp3WGw2Q1RJNjUzYWRYUVVwcktGU1FnOVgrVUdZTS9W?=
 =?utf-8?B?djBidEh1ajVaU3dqaTUvL2lHSFpLNkkrc1RldnJhODZ1MTlFWmZydz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fc2515-e710-4250-0513-08de64c98627
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:16:24.1038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wR3TfVxFbwhA7CHFy+/pL+xYjrUA12Wl9Fj/Bzn6Doj2kaP/gVTiYRqt81R2usrHpl/2qIHJGUnyuuRMnlyviA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11038
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

Sync i.MX952 device tree files from linux-next next-20260202:
- Add imx952.dtsi for SoC
- Add imx952-evk.dts for i.MX952 EVK board
- Add imx952-*.h headers for clock, pinctrl and power

Imported from linux-next commit 193579fe0138 ("Add linux-next specific
ifiles for 20260202")

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 dts/upstream/src/arm64/freescale/imx952-clock.h   |  215 ++++
 dts/upstream/src/arm64/freescale/imx952-evk.dts   |  596 ++++++++++
 dts/upstream/src/arm64/freescale/imx952-pinfunc.h |  867 ++++++++++++++
 dts/upstream/src/arm64/freescale/imx952-power.h   |   44 +
 dts/upstream/src/arm64/freescale/imx952.dtsi      | 1266 +++++++++++++++++++++
 5 files changed, 2988 insertions(+)

diff --git a/dts/upstream/src/arm64/freescale/imx952-clock.h b/dts/upstream/src/arm64/freescale/imx952-clock.h
new file mode 100644
index 00000000000..7d6f6635dc0
--- /dev/null
+++ b/dts/upstream/src/arm64/freescale/imx952-clock.h
@@ -0,0 +1,215 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __CLOCK_IMX952_H__
+#define __CLOCK_IMX952_H__
+
+/* Clock Source */
+#define IMX952_CLK_EXT			0
+#define IMX952_CLK_OSC32K		1
+#define IMX952_CLK_OSC24M		2
+#define IMX952_CLK_FRO			3
+#define IMX952_CLK_SYSPLL1_VCO		4
+#define IMX952_CLK_SYSPLL1_PFD0_UNGATED	5
+#define IMX952_CLK_SYSPLL1_PFD0		6
+#define IMX952_CLK_SYSPLL1_PFD0_DIV2	7
+#define IMX952_CLK_SYSPLL1_PFD1_UNGATED	8
+#define IMX952_CLK_SYSPLL1_PFD1		9
+#define IMX952_CLK_SYSPLL1_PFD1_DIV2	10
+#define IMX952_CLK_SYSPLL1_PFD2_UNGATED	11
+#define IMX952_CLK_SYSPLL1_PFD2		12
+#define IMX952_CLK_SYSPLL1_PFD2_DIV2	13
+#define IMX952_CLK_AUDIOPLL1_VCO	14
+#define IMX952_CLK_AUDIOPLL1		15
+#define IMX952_CLK_AUDIOPLL2_VCO	16
+#define IMX952_CLK_AUDIOPLL2		17
+#define IMX952_CLK_VIDEOPLL1_VCO	18
+#define IMX952_CLK_VIDEOPLL1		19
+#define IMX952_CLK_SRC_RESERVED20	20
+#define IMX952_CLK_SYSPLL1_PFD3_UNGATED	21
+#define IMX952_CLK_SYSPLL1_PFD3		22
+#define IMX952_CLK_SYSPLL1_PFD3_DIV2	23
+#define IMX952_CLK_ARMPLL_VCO		24
+#define IMX952_CLK_ARMPLL_PFD0_UNGATED	25
+#define IMX952_CLK_ARMPLL_PFD0		26
+#define IMX952_CLK_ARMPLL_PFD1_UNGATED	27
+#define IMX952_CLK_ARMPLL_PFD1		28
+#define IMX952_CLK_ARMPLL_PFD2_UNGATED	29
+#define IMX952_CLK_ARMPLL_PFD2		30
+#define IMX952_CLK_ARMPLL_PFD3_UNGATED	31
+#define IMX952_CLK_ARMPLL_PFD3		32
+#define IMX952_CLK_DRAMPLL_VCO		33
+#define IMX952_CLK_DRAMPLL		34
+#define IMX952_CLK_HSIOPLL_VCO		35
+#define IMX952_CLK_HSIOPLL		36
+#define IMX952_CLK_LDBPLL_VCO		37
+#define IMX952_CLK_LDBPLL		38
+#define IMX952_CLK_EXT1			39
+#define IMX952_CLK_EXT2			40
+
+/* Clock ROOT */
+#define IMX952_CLK_ADC			41
+#define IMX952_CLK_RESERVED1		42
+#define IMX952_CLK_BUSAON		43
+#define IMX952_CLK_CAN1			44
+#define IMX952_CLK_RESERVED4		45
+#define IMX952_CLK_I3C1SLOW		46
+#define IMX952_CLK_LPI2C1		47
+#define IMX952_CLK_LPI2C2		48
+#define IMX952_CLK_LPSPI1		49
+#define IMX952_CLK_LPSPI2		50
+#define IMX952_CLK_LPTMR1		51
+#define IMX952_CLK_LPUART1		52
+#define IMX952_CLK_LPUART2		53
+#define IMX952_CLK_M33			54
+#define IMX952_CLK_M33SYSTICK		55
+#define IMX952_CLK_RESERVED15		56
+#define IMX952_CLK_PDM			57
+#define IMX952_CLK_SAI1			58
+#define IMX952_CLK_RESERVED18		59
+#define IMX952_CLK_TPM2			60
+#define IMX952_CLK_RESERVED20		61
+#define IMX952_CLK_CAMAPB		62
+#define IMX952_CLK_CAMAXI		63
+#define IMX952_CLK_CAMCM0		64
+#define IMX952_CLK_CAMISI		65
+#define IMX952_CLK_CAMPHYCFG		66
+#define IMX952_CLK_MIPIPHYPLLBYPASS	67
+#define IMX952_CLK_RESERVED27		68
+#define IMX952_CLK_MIPITESTBYTE		69
+#define IMX952_CLK_A55			70
+#define IMX952_CLK_A55MTRBUS		71
+#define IMX952_CLK_A55PERIPH		72
+#define IMX952_CLK_DRAMALT		73
+#define IMX952_CLK_DRAMAPB		74
+#define IMX952_CLK_DISPAPB		75
+#define IMX952_CLK_DISPAXI		76
+#define IMX952_CLK_DISPLPSPI		77
+#define IMX952_CLK_DISPOCRAM		78
+#define IMX952_CLK_DISPPHYCFG		79
+#define IMX952_CLK_DISP1PIX		80
+#define IMX952_CLK_DISPCDPHYAPB		81
+#define IMX952_CLK_RESERVED41		82
+#define IMX952_CLK_GPUAPB		83
+#define IMX952_CLK_GPU			84
+#define IMX952_CLK_HSIOACSCAN480M	85
+#define IMX952_CLK_HSIOACSCAN80M	86
+#define IMX952_CLK_HSIO			87
+#define IMX952_CLK_HSIOPCIEAUX		88
+#define IMX952_CLK_HSIOPCIETEST160M	89
+#define IMX952_CLK_HSIOPCIETEST400M	90
+#define IMX952_CLK_HSIOPCIETEST500M	91
+#define IMX952_CLK_HSIOUSBTEST50M	92
+#define IMX952_CLK_HSIOUSBTEST60M	93
+#define IMX952_CLK_BUSM7		94
+#define IMX952_CLK_M7			95
+#define IMX952_CLK_M7SYSTICK		96
+#define IMX952_CLK_BUSNETCMIX		97
+#define IMX952_CLK_ENET			98
+#define IMX952_CLK_ENETPHYTEST200M	99
+#define IMX952_CLK_ENETPHYTEST500M	100
+#define IMX952_CLK_ENETPHYTEST667M	101
+#define IMX952_CLK_ENETREF		102
+#define IMX952_CLK_ENETTIMER1		103
+#define IMX952_CLK_RESERVED63		104
+#define IMX952_CLK_SAI2			105
+#define IMX952_CLK_NOCAPB		106
+#define IMX952_CLK_NOC			107
+#define IMX952_CLK_NPUAPB		108
+#define IMX952_CLK_NPU			109
+#define IMX952_CLK_CCMCKO1		110
+#define IMX952_CLK_CCMCKO2		111
+#define IMX952_CLK_CCMCKO3		112
+#define IMX952_CLK_CCMCKO4		113
+#define IMX952_CLK_VPUAPB		114
+#define IMX952_CLK_VPU			115
+#define IMX952_CLK_RESERVED75		116
+#define IMX952_CLK_RESERVED76		117
+#define IMX952_CLK_AUDIOXCVR		118
+#define IMX952_CLK_BUSWAKEUP		119
+#define IMX952_CLK_CAN2			120
+#define IMX952_CLK_CAN3			121
+#define IMX952_CLK_CAN4			122
+#define IMX952_CLK_CAN5			123
+#define IMX952_CLK_FLEXIO1		124
+#define IMX952_CLK_FLEXIO2		125
+#define IMX952_CLK_XSPI1		126
+#define IMX952_CLK_RESERVED86		127
+#define IMX952_CLK_I3C2SLOW		128
+#define IMX952_CLK_LPI2C3		129
+#define IMX952_CLK_LPI2C4		130
+#define IMX952_CLK_LPI2C5		131
+#define IMX952_CLK_LPI2C6		132
+#define IMX952_CLK_LPI2C7		133
+#define IMX952_CLK_LPI2C8		134
+#define IMX952_CLK_LPSPI3		135
+#define IMX952_CLK_LPSPI4		136
+#define IMX952_CLK_LPSPI5		137
+#define IMX952_CLK_LPSPI6		138
+#define IMX952_CLK_LPSPI7		139
+#define IMX952_CLK_LPSPI8		140
+#define IMX952_CLK_LPTMR2		141
+#define IMX952_CLK_LPUART3		142
+#define IMX952_CLK_LPUART4		143
+#define IMX952_CLK_LPUART5		144
+#define IMX952_CLK_LPUART6		145
+#define IMX952_CLK_LPUART7		146
+#define IMX952_CLK_LPUART8		147
+#define IMX952_CLK_SAI3			148
+#define IMX952_CLK_SAI4			149
+#define IMX952_CLK_SAI5			150
+#define IMX952_CLK_SPDIF		151
+#define IMX952_CLK_SWOTRACE		152
+#define IMX952_CLK_TPM4			153
+#define IMX952_CLK_TPM5			154
+#define IMX952_CLK_TPM6			155
+#define IMX952_CLK_MIPIPHYDFT400	156
+#define IMX952_CLK_MIPIPHYDFT540	157
+#define IMX952_CLK_USDHC1		158
+#define IMX952_CLK_USDHC2		159
+#define IMX952_CLK_USDHC3		160
+#define IMX952_CLK_V2XPK		161
+#define IMX952_CLK_WAKEUPAXI		162
+#define IMX952_CLK_XSPISLVROOT		163
+#define IMX952_CLK_AUDMIX1		164
+#define IMX952_CLK_ASRC1		165
+#define IMX952_CLK_ASRC2		166
+#define IMX952_CLK_GPT1			167
+#define IMX952_CLK_GPT2			168
+#define IMX952_CLK_GPT3			169
+#define IMX952_CLK_GPT4			170
+
+/* Clock GPR SEL */
+#define IMX952_CLK_GPR_SEL_EXT		171
+#define IMX952_CLK_GPR_SEL_A55C0	172
+#define IMX952_CLK_GPR_SEL_A55C1	173
+#define IMX952_CLK_GPR_SEL_A55C2	174
+#define IMX952_CLK_GPR_SEL_A55C3	175
+#define IMX952_CLK_GPR_SEL_A55P		176
+#define IMX952_CLK_GPR_SEL_DRAM		177
+#define IMX952_CLK_GPR_SEL_TEMPSENSE	178
+
+/* Clock CGC */
+#define IMX952_CLK_CGC_NPU		179
+#define IMX952_CLK_CGC_GPU		180
+#define IMX952_CLK_CGC_CAMISI		181
+#define IMX952_CLK_CGC_CAMISP		182
+#define IMX952_CLK_CGC_CAMCSI0		183
+#define IMX952_CLK_CGC_CAMCSI1		184
+#define IMX952_CLK_CGC_CAMOCRAM		185
+#define IMX952_CLK_CGC_HSIOUSB		186
+#define IMX952_CLK_CGC_HSIOPCIE		187
+#define IMX952_CLK_CGC_DISPOCRAM	188
+#define IMX952_CLK_CGC_DISPSEERIS	189
+#define IMX952_CLK_CGC_DISPDSI		190
+#define IMX952_CLK_CGC_NOCGIC		191
+#define IMX952_CLK_CGC_NOCOCRAM		192
+#define IMX952_CLK_CGC_NETC		193
+#define IMX952_CLK_CGC_VPUENC		194
+#define IMX952_CLK_CGC_VPUJPEGENC	195
+#define IMX952_CLK_CGC_VPUJPEGDEC	196
+#define IMX952_CLK_CGC_VPUDEC		197
+
+#endif
diff --git a/dts/upstream/src/arm64/freescale/imx952-evk.dts b/dts/upstream/src/arm64/freescale/imx952-evk.dts
new file mode 100644
index 00000000000..b838323468d
--- /dev/null
+++ b/dts/upstream/src/arm64/freescale/imx952-evk.dts
@@ -0,0 +1,596 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/usb/pd.h>
+#include "imx952.dtsi"
+
+#define FALLING_EDGE		BIT(0)
+#define RISING_EDGE		BIT(1)
+
+#define BRD_SM_CTRL_SD3_WAKE		0x8000U /*!< PCAL6408A-0 */
+#define BRD_SM_CTRL_M2E_WAKE		0x8001U /*!< PCAL6408A-4 */
+#define BRD_SM_CTRL_BT_WAKE		0x8002U /*!< PCAL6408A-5 */
+#define BRD_SM_CTRL_M2M_WAKE		0x8003U /*!< PCAL6408A-6 */
+#define BRD_SM_CTRL_BUTTON		0x8004U /*!< PCAL6408A-7 */
+
+/ {
+	model = "NXP i.MX952 EVK board";
+	compatible = "fsl,imx952-evk", "fsl,imx952";
+
+	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+		serial4 = &lpuart5;
+		spi6 = &lpspi7;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		pwms = <&tpm6 2 4000000 PWM_POLARITY_INVERTED>;
+		cooling-levels = <64 128 192 255>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x7f000000>;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+			reusable;
+		};
+	};
+
+	flexcan1_phy: can-phy0 {
+		compatible = "nxp,tjr1443";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+		enable-gpios = <&pcal6416 6 GPIO_ACTIVE_HIGH>;
+		standby-gpios = <&pcal6416 5 GPIO_ACTIVE_LOW>;
+	};
+
+	flexcan2_phy: can-phy1 {
+		compatible = "nxp,tjr1443";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+		enable-gpios = <&i2c4_pcal6408 4 GPIO_ACTIVE_HIGH>;
+		standby-gpios = <&i2c4_pcal6408 3 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VDD_SD2_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <12000>;
+	};
+
+	reg_usb_vbus: regulator-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pcal6524 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+};
+
+/* pin conflict with PDM */
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	phys = <&flexcan1_phy>;
+	status = "disabled";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	phys = <&flexcan2_phy>;
+	status = "okay";
+};
+
+&lpi2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	adp5585: io-expander@34 {
+		compatible = "adi,adp5585-00", "adi,adp5585";
+		reg = <0x34>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-reserved-ranges = <5 1>;
+		#pwm-cells = <3>;
+	};
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	i2c3_pcal6408: gpio@20 {
+		compatible = "nxp,pcal6408";
+		reg = <0x20>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		vcc-supply = <&reg_3p3v>;
+	};
+};
+
+&lpi2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c4>;
+	status = "okay";
+
+	i2c4_pcal6408: gpio@21 {
+		compatible = "nxp,pcal6408";
+		reg = <0x21>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c4_pcal6408>;
+		vcc-supply = <&reg_3p3v>;
+	};
+};
+
+&lpi2c6 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c6>;
+	status = "okay";
+
+	pcal6416: gpio@21 {
+		compatible = "nxp,pcal6416";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x21>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6416>;
+		vcc-supply = <&reg_3p3v>;
+
+		pdm-can-sel-hog {
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+
+		mqs-en-hog {
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+	};
+};
+
+&lpi2c7 {
+	clock-frequency = <1000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c7>;
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ptn5110>;
+
+		typec_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 0, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <0>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&lpuart1 {
+	/* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&lpuart5 {
+	/* BT */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
+&lpspi7 {
+	cs-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi7>;
+	status = "okay";
+};
+
+&scmi_misc {
+	nxp,ctrl-ids = <BRD_SM_CTRL_SD3_WAKE		1
+			BRD_SM_CTRL_M2E_WAKE		1
+			BRD_SM_CTRL_BT_WAKE		1
+			BRD_SM_CTRL_M2M_WAKE		1
+			BRD_SM_CTRL_BUTTON		1>;
+};
+
+&tpm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm3>;
+	status = "okay";
+};
+
+&tpm6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm6>;
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usb2 {
+	dr_mode = "host";
+	disable-over-current;
+	vbus-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			IMX952_PAD_PDM_CLK__AONMIX_TOP_CAN1_TX			0x39e
+			IMX952_PAD_PDM_BIT_STREAM0__AONMIX_TOP_CAN1_RX		0x39e
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO25__WAKEUPMIX_TOP_CAN2_TX		0x39e
+			IMX952_PAD_GPIO_IO27__WAKEUPMIX_TOP_CAN2_RX		0x39e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			IMX952_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL		0x40000b9e
+			IMX952_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO00__WAKEUPMIX_TOP_LPI2C3_SDA		0x40000b9e
+			IMX952_PAD_GPIO_IO01__WAKEUPMIX_TOP_LPI2C3_SCL		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c4: lpi2c4grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO30__WAKEUPMIX_TOP_LPI2C4_SDA		0x40000b9e
+			IMX952_PAD_GPIO_IO31__WAKEUPMIX_TOP_LPI2C4_SCL		0x40000b9e
+		>;
+	};
+
+	pinctrl_i2c4_pcal6408: i2c4pcal6408grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO18__WAKEUPMIX_TOP_GPIO2_IO_18		0x31e
+		>;
+	};
+
+	pinctrl_lpi2c6: lpi2c6grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO02__WAKEUPMIX_TOP_LPI2C6_SDA		0x40000b9e
+			IMX952_PAD_GPIO_IO03__WAKEUPMIX_TOP_LPI2C6_SCL		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c7: lpi2c7grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO08__WAKEUPMIX_TOP_LPI2C7_SDA		0x40000b9e
+			IMX952_PAD_GPIO_IO09__WAKEUPMIX_TOP_LPI2C7_SCL		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpspi7: lpspi7grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO04__WAKEUPMIX_TOP_GPIO2_IO_4		0x39e
+			IMX952_PAD_GPIO_IO05__WAKEUPMIX_TOP_LPSPI7_SIN		0x39e
+			IMX952_PAD_GPIO_IO06__WAKEUPMIX_TOP_LPSPI7_SOUT		0x39e
+			IMX952_PAD_GPIO_IO07__WAKEUPMIX_TOP_LPSPI7_SCK		0x39e
+		>;
+	};
+
+	pinctrl_pcal6416: pcal6416grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO10__WAKEUPMIX_TOP_GPIO2_IO_10		0x31e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO36__WAKEUPMIX_TOP_GPIO5_IO_16		0x31e
+		>;
+	};
+
+	pinctrl_ptn5110: ptn5110grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO34__WAKEUPMIX_TOP_GPIO5_IO_14		     0x31e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_RESET_B__WAKEUPMIX_TOP_GPIO3_IO_7	0x31e
+		>;
+	};
+
+	pinctrl_tpm3: tpm3grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_TPM3_CH2		0x51e
+		>;
+	};
+
+	pinctrl_tpm6: tpm6grp {
+		fsl,pins = <
+			IMX952_PAD_GPIO_IO19__WAKEUPMIX_TOP_TPM6_CH2		0x51e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			IMX952_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX		0x31e
+			IMX952_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX		0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			IMX952_PAD_DAP_TDO_TRACESWO__WAKEUPMIX_TOP_LPUART5_TX	0x31e
+			IMX952_PAD_DAP_TDI__WAKEUPMIX_TOP_LPUART5_RX		0x31e
+			IMX952_PAD_DAP_TMS_SWDIO__WAKEUPMIX_TOP_LPUART5_RTS_B	0x31e
+			IMX952_PAD_DAP_TCLK_SWCLK__WAKEUPMIX_TOP_LPUART5_CTS_B	0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_USDHC1_CLK		0x158e
+			IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_USDHC1_CMD		0x138e
+			IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_USDHC1_DATA0	0x138e
+			IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_USDHC1_DATA1	0x138e
+			IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_USDHC1_DATA2	0x138e
+			IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_USDHC1_DATA3	0x138e
+			IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_USDHC1_DATA4	0x138e
+			IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_DATA5	0x138e
+			IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_DATA6	0x138e
+			IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_DATA7	0x138e
+			IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_USDHC1_STROBE	0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_USDHC1_CLK		0x158e
+			IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_USDHC1_CMD		0x138e
+			IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_USDHC1_DATA0	0x138e
+			IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_USDHC1_DATA1	0x138e
+			IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_USDHC1_DATA2	0x138e
+			IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_USDHC1_DATA3	0x138e
+			IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_USDHC1_DATA4	0x138e
+			IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_DATA5	0x138e
+			IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_DATA6	0x138e
+			IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_DATA7	0x138e
+			IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_USDHC1_STROBE	0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_USDHC1_CLK		0x159e
+			IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_USDHC1_CMD		0x139e
+			IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_USDHC1_DATA0	0x139e
+			IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_USDHC1_DATA1	0x139e
+			IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_USDHC1_DATA2	0x139e
+			IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_USDHC1_DATA3	0x139e
+			IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_USDHC1_DATA4	0x139e
+			IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_DATA5	0x139e
+			IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_DATA6	0x139e
+			IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_DATA7	0x139e
+			IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_USDHC1_STROBE	0x159e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_USDHC2_CLK		0x158e
+			IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_USDHC2_CMD		0x138e
+			IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_USDHC2_DATA0	0x138e
+			IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_USDHC2_DATA1	0x138e
+			IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_USDHC2_DATA2	0x138e
+			IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_USDHC2_DATA3	0x138e
+			IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_USDHC2_CLK		0x158e
+			IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_USDHC2_CMD		0x138e
+			IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_USDHC2_DATA0	0x138e
+			IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_USDHC2_DATA1	0x138e
+			IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_USDHC2_DATA2	0x138e
+			IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_USDHC2_DATA3	0x138e
+			IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_USDHC2_CLK		0x158e
+			IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_USDHC2_CMD		0x138e
+			IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_USDHC2_DATA0	0x138e
+			IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_USDHC2_DATA1	0x138e
+			IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_USDHC2_DATA2	0x138e
+			IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_USDHC2_DATA3	0x138e
+			IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX952_PAD_SD2_CD_B__WAKEUPMIX_TOP_GPIO3_IO_0		0x31e
+		>;
+	};
+};
diff --git a/dts/upstream/src/arm64/freescale/imx952-pinfunc.h b/dts/upstream/src/arm64/freescale/imx952-pinfunc.h
new file mode 100644
index 00000000000..debe6ede2d7
--- /dev/null
+++ b/dts/upstream/src/arm64/freescale/imx952-pinfunc.h
@@ -0,0 +1,867 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __DTS_IMX952_PINFUNC_H__
+#define __DTS_IMX952_PINFUNC_H__
+
+/*
+ * The pin function ID is a tuple of
+ * <mux_reg conf_reg input_reg mux_mode input_val>
+ */
+#define IMX952_PAD_DAP_TDI__WAKEUPMIX_TOP_TDI                         0x0000 0x0230 0x05FC 0x00 0x00
+#define IMX952_PAD_DAP_TDI__NETCMIX_TOP_MQS2_LEFT                     0x0000 0x0230 0x0000 0x01 0x00
+#define IMX952_PAD_DAP_TDI__NETCMIX_TOP_NETC_TMR_1588_ALARM1          0x0000 0x0230 0x0000 0x02 0x00
+#define IMX952_PAD_DAP_TDI__WAKEUPMIX_TOP_CAN2_TX                     0x0000 0x0230 0x0000 0x03 0x00
+#define IMX952_PAD_DAP_TDI__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_30           0x0000 0x0230 0x0000 0x04 0x00
+#define IMX952_PAD_DAP_TDI__WAKEUPMIX_TOP_GPIO3_IO_28                 0x0000 0x0230 0x0000 0x05 0x00
+#define IMX952_PAD_DAP_TDI__WAKEUPMIX_TOP_LPUART5_RX                  0x0000 0x0230 0x059C 0x06 0x00
+
+#define IMX952_PAD_DAP_TMS_SWDIO__WAKEUPMIX_TOP_TMS                   0x0004 0x0234 0x0600 0x00 0x00
+#define IMX952_PAD_DAP_TMS_SWDIO__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_31     0x0004 0x0234 0x0000 0x04 0x00
+#define IMX952_PAD_DAP_TMS_SWDIO__WAKEUPMIX_TOP_GPIO3_IO_29           0x0004 0x0234 0x0000 0x05 0x00
+#define IMX952_PAD_DAP_TMS_SWDIO__WAKEUPMIX_TOP_LPUART5_RTS_B         0x0004 0x0234 0x0000 0x06 0x00
+
+#define IMX952_PAD_DAP_TCLK_SWCLK__WAKEUPMIX_TOP_TCK                  0x0008 0x0238 0x05F8 0x00 0x00
+#define IMX952_PAD_DAP_TCLK_SWCLK__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_30    0x0008 0x0238 0x04B4 0x04 0x00
+#define IMX952_PAD_DAP_TCLK_SWCLK__WAKEUPMIX_TOP_GPIO3_IO_30          0x0008 0x0238 0x0000 0x05 0x00
+#define IMX952_PAD_DAP_TCLK_SWCLK__WAKEUPMIX_TOP_LPUART5_CTS_B        0x0008 0x0238 0x0598 0x06 0x00
+
+#define IMX952_PAD_DAP_TDO_TRACESWO__WAKEUPMIX_TOP_TDO                0x000C 0x023C 0x0000 0x00 0x00
+#define IMX952_PAD_DAP_TDO_TRACESWO__NETCMIX_TOP_MQS2_RIGHT           0x000C 0x023C 0x0000 0x01 0x00
+#define IMX952_PAD_DAP_TDO_TRACESWO__NETCMIX_TOP_NETC_TMR_1588_ALARM2 0x000C 0x023C 0x0000 0x02 0x00
+#define IMX952_PAD_DAP_TDO_TRACESWO__WAKEUPMIX_TOP_CAN2_RX            0x000C 0x023C 0x04A4 0x03 0x00
+#define IMX952_PAD_DAP_TDO_TRACESWO__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_31  0x000C 0x023C 0x04B8 0x04 0x00
+#define IMX952_PAD_DAP_TDO_TRACESWO__WAKEUPMIX_TOP_GPIO3_IO_31        0x000C 0x023C 0x0000 0x05 0x00
+#define IMX952_PAD_DAP_TDO_TRACESWO__WAKEUPMIX_TOP_LPUART5_TX         0x000C 0x023C 0x05A0 0x06 0x00
+
+#define IMX952_PAD_GPIO_IO00__WAKEUPMIX_TOP_GPIO2_IO_0                0x0010 0x0240 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO00__WAKEUPMIX_TOP_LPI2C3_SDA                0x0010 0x0240 0x0530 0x01 0x00
+#define IMX952_PAD_GPIO_IO00__WAKEUPMIX_TOP_GPTMUX_INOUT0             0x0010 0x0240 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO00__WAKEUPMIX_TOP_LPSPI6_PCS0               0x0010 0x0240 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO00__WAKEUPMIX_TOP_LPUART5_TX                0x0010 0x0240 0x05A0 0x05 0x01
+#define IMX952_PAD_GPIO_IO00__WAKEUPMIX_TOP_LPI2C5_SDA                0x0010 0x0240 0x0540 0x06 0x00
+#define IMX952_PAD_GPIO_IO00__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_0          0x0010 0x0240 0x04BC 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO01__WAKEUPMIX_TOP_GPIO2_IO_1                0x0014 0x0244 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO01__WAKEUPMIX_TOP_LPI2C3_SCL                0x0014 0x0244 0x052C 0x01 0x00
+#define IMX952_PAD_GPIO_IO01__WAKEUPMIX_TOP_GPTMUX_INOUT1             0x0014 0x0244 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO01__WAKEUPMIX_TOP_LPSPI6_SIN                0x0014 0x0244 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO01__WAKEUPMIX_TOP_LPUART5_RX                0x0014 0x0244 0x059C 0x05 0x01
+#define IMX952_PAD_GPIO_IO01__WAKEUPMIX_TOP_LPI2C5_SCL                0x0014 0x0244 0x053C 0x06 0x00
+#define IMX952_PAD_GPIO_IO01__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_1          0x0014 0x0244 0x04C0 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO02__WAKEUPMIX_TOP_GPIO2_IO_2                0x0018 0x0248 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO02__WAKEUPMIX_TOP_LPI2C4_SDA                0x0018 0x0248 0x0538 0x01 0x00
+#define IMX952_PAD_GPIO_IO02__WAKEUPMIX_TOP_GPTMUX_INOUT2             0x0018 0x0248 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO02__WAKEUPMIX_TOP_LPSPI6_SOUT               0x0018 0x0248 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO02__WAKEUPMIX_TOP_LPUART5_CTS_B             0x0018 0x0248 0x0598 0x05 0x01
+#define IMX952_PAD_GPIO_IO02__WAKEUPMIX_TOP_LPI2C6_SDA                0x0018 0x0248 0x0548 0x06 0x00
+#define IMX952_PAD_GPIO_IO02__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_2          0x0018 0x0248 0x04C4 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO03__WAKEUPMIX_TOP_GPIO2_IO_3                0x001C 0x024C 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO03__WAKEUPMIX_TOP_LPI2C4_SCL                0x001C 0x024C 0x0534 0x01 0x00
+#define IMX952_PAD_GPIO_IO03__WAKEUPMIX_TOP_GPTMUX_INOUT3             0x001C 0x024C 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO03__WAKEUPMIX_TOP_LPSPI6_SCK                0x001C 0x024C 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO03__WAKEUPMIX_TOP_LPUART5_RTS_B             0x001C 0x024C 0x0000 0x05 0x00
+#define IMX952_PAD_GPIO_IO03__WAKEUPMIX_TOP_LPI2C6_SCL                0x001C 0x024C 0x0544 0x06 0x00
+#define IMX952_PAD_GPIO_IO03__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_3          0x001C 0x024C 0x04C8 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO04__WAKEUPMIX_TOP_GPIO2_IO_4                0x0020 0x0250 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO04__WAKEUPMIX_TOP_TPM3_CH0                  0x0020 0x0250 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO04__AONMIX_TOP_PDM_CLK                      0x0020 0x0250 0x0000 0x02 0x00
+#define IMX952_PAD_GPIO_IO04__WAKEUPMIX_TOP_GPTMUX_INOUT4             0x0020 0x0250 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO04__WAKEUPMIX_TOP_LPSPI7_PCS0               0x0020 0x0250 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO04__WAKEUPMIX_TOP_LPUART6_TX                0x0020 0x0250 0x05AC 0x05 0x00
+#define IMX952_PAD_GPIO_IO04__WAKEUPMIX_TOP_LPI2C6_SDA                0x0020 0x0250 0x0548 0x06 0x01
+#define IMX952_PAD_GPIO_IO04__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_4          0x0020 0x0250 0x04CC 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO05__WAKEUPMIX_TOP_GPIO2_IO_5                0x0024 0x0254 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO05__WAKEUPMIX_TOP_TPM4_CH0                  0x0024 0x0254 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO05__AONMIX_TOP_PDM_BIT_STREAM_0             0x0024 0x0254 0x0464 0x02 0x01
+#define IMX952_PAD_GPIO_IO05__WAKEUPMIX_TOP_GPTMUX_INOUT5             0x0024 0x0254 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO05__WAKEUPMIX_TOP_LPSPI7_SIN                0x0024 0x0254 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO05__WAKEUPMIX_TOP_LPUART6_RX                0x0024 0x0254 0x05A8 0x05 0x00
+#define IMX952_PAD_GPIO_IO05__WAKEUPMIX_TOP_LPI2C6_SCL                0x0024 0x0254 0x0544 0x06 0x01
+#define IMX952_PAD_GPIO_IO05__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_5          0x0024 0x0254 0x04D0 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO06__WAKEUPMIX_TOP_GPIO2_IO_6                0x0028 0x0258 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO06__WAKEUPMIX_TOP_TPM5_CH0                  0x0028 0x0258 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO06__AONMIX_TOP_PDM_BIT_STREAM_1             0x0028 0x0258 0x0468 0x02 0x01
+#define IMX952_PAD_GPIO_IO06__WAKEUPMIX_TOP_GPTMUX_INOUT6             0x0028 0x0258 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO06__WAKEUPMIX_TOP_LPSPI7_SOUT               0x0028 0x0258 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO06__WAKEUPMIX_TOP_LPUART6_CTS_B             0x0028 0x0258 0x05A4 0x05 0x00
+#define IMX952_PAD_GPIO_IO06__WAKEUPMIX_TOP_LPI2C7_SDA                0x0028 0x0258 0x0550 0x06 0x00
+#define IMX952_PAD_GPIO_IO06__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_6          0x0028 0x0258 0x04D4 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO07__WAKEUPMIX_TOP_GPIO2_IO_7                0x002C 0x025C 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO07__WAKEUPMIX_TOP_LPSPI3_PCS1               0x002C 0x025C 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO07__WAKEUPMIX_TOP_GPTMUX_INOUT7             0x002C 0x025C 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO07__WAKEUPMIX_TOP_LPSPI7_SCK                0x002C 0x025C 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO07__WAKEUPMIX_TOP_LPUART6_RTS_B             0x002C 0x025C 0x0000 0x05 0x00
+#define IMX952_PAD_GPIO_IO07__WAKEUPMIX_TOP_LPI2C7_SCL                0x002C 0x025C 0x054C 0x06 0x00
+#define IMX952_PAD_GPIO_IO07__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_7          0x002C 0x025C 0x04D8 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO08__WAKEUPMIX_TOP_GPIO2_IO_8                0x0030 0x0260 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO08__WAKEUPMIX_TOP_LPSPI3_PCS0               0x0030 0x0260 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO08__WAKEUPMIX_TOP_GPTMUX_INOUT8             0x0030 0x0260 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO08__WAKEUPMIX_TOP_TPM6_CH0                  0x0030 0x0260 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO08__WAKEUPMIX_TOP_LPUART7_TX                0x0030 0x0260 0x05B4 0x05 0x00
+#define IMX952_PAD_GPIO_IO08__WAKEUPMIX_TOP_LPI2C7_SDA                0x0030 0x0260 0x0550 0x06 0x01
+#define IMX952_PAD_GPIO_IO08__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_8          0x0030 0x0260 0x04DC 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO09__WAKEUPMIX_TOP_GPIO2_IO_9                0x0034 0x0264 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO09__WAKEUPMIX_TOP_LPSPI3_SIN                0x0034 0x0264 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO09__WAKEUPMIX_TOP_GPTMUX_INOUT9             0x0034 0x0264 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO09__WAKEUPMIX_TOP_TPM3_EXTCLK               0x0034 0x0264 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO09__WAKEUPMIX_TOP_LPUART7_RX                0x0034 0x0264 0x05B0 0x05 0x00
+#define IMX952_PAD_GPIO_IO09__WAKEUPMIX_TOP_LPI2C7_SCL                0x0034 0x0264 0x054C 0x06 0x01
+#define IMX952_PAD_GPIO_IO09__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_9          0x0034 0x0264 0x04E0 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO10__WAKEUPMIX_TOP_GPIO2_IO_10               0x0038 0x0268 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO10__WAKEUPMIX_TOP_LPSPI3_SOUT               0x0038 0x0268 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO10__WAKEUPMIX_TOP_GPTMUX_INOUT10            0x0038 0x0268 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO10__WAKEUPMIX_TOP_TPM4_EXTCLK               0x0038 0x0268 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO10__WAKEUPMIX_TOP_LPUART7_CTS_B             0x0038 0x0268 0x0000 0x05 0x00
+#define IMX952_PAD_GPIO_IO10__WAKEUPMIX_TOP_LPI2C8_SDA                0x0038 0x0268 0x0558 0x06 0x00
+#define IMX952_PAD_GPIO_IO10__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_10         0x0038 0x0268 0x04E4 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO11__WAKEUPMIX_TOP_GPIO2_IO_11               0x003C 0x026C 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO11__WAKEUPMIX_TOP_LPSPI3_SCK                0x003C 0x026C 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO11__WAKEUPMIX_TOP_GPTMUX_INOUT11            0x003C 0x026C 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO11__WAKEUPMIX_TOP_TPM5_EXTCLK               0x003C 0x026C 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO11__WAKEUPMIX_TOP_LPUART7_RTS_B             0x003C 0x026C 0x0000 0x05 0x00
+#define IMX952_PAD_GPIO_IO11__WAKEUPMIX_TOP_LPI2C8_SCL                0x003C 0x026C 0x0554 0x06 0x00
+#define IMX952_PAD_GPIO_IO11__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_11         0x003C 0x026C 0x04E8 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_GPIO2_IO_12               0x0040 0x0270 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_TPM3_CH2                  0x0040 0x0270 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO12__AONMIX_TOP_PDM_BIT_STREAM_2             0x0040 0x0270 0x046C 0x02 0x00
+#define IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_12         0x0040 0x0270 0x04EC 0x03 0x00
+#define IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_LPSPI8_PCS0               0x0040 0x0270 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_LPUART8_TX                0x0040 0x0270 0x0000 0x05 0x00
+#define IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_LPI2C8_SDA                0x0040 0x0270 0x0558 0x06 0x01
+#define IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_SAI3_RX_SYNC              0x0040 0x0270 0x05BC 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO13__WAKEUPMIX_TOP_GPIO2_IO_13               0x0044 0x0274 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO13__WAKEUPMIX_TOP_TPM4_CH2                  0x0044 0x0274 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO13__AONMIX_TOP_PDM_BIT_STREAM_3             0x0044 0x0274 0x0470 0x02 0x00
+#define IMX952_PAD_GPIO_IO13__WAKEUPMIX_TOP_LPSPI8_SIN                0x0044 0x0274 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO13__WAKEUPMIX_TOP_LPUART8_RX                0x0044 0x0274 0x0000 0x05 0x00
+#define IMX952_PAD_GPIO_IO13__WAKEUPMIX_TOP_LPI2C8_SCL                0x0044 0x0274 0x0554 0x06 0x01
+#define IMX952_PAD_GPIO_IO13__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_13         0x0044 0x0274 0x04F0 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO14__WAKEUPMIX_TOP_GPIO2_IO_14               0x0048 0x0278 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO14__WAKEUPMIX_TOP_LPUART3_TX                0x0048 0x0278 0x0588 0x01 0x01
+#define IMX952_PAD_GPIO_IO14__WAKEUPMIX_TOP_LPSPI8_SOUT               0x0048 0x0278 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO14__WAKEUPMIX_TOP_LPUART8_CTS_B             0x0048 0x0278 0x0000 0x05 0x00
+#define IMX952_PAD_GPIO_IO14__WAKEUPMIX_TOP_LPUART4_TX                0x0048 0x0278 0x0594 0x06 0x01
+#define IMX952_PAD_GPIO_IO14__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_14         0x0048 0x0278 0x04F4 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO15__WAKEUPMIX_TOP_GPIO2_IO_15               0x004C 0x027C 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO15__WAKEUPMIX_TOP_LPUART3_RX                0x004C 0x027C 0x0584 0x01 0x01
+#define IMX952_PAD_GPIO_IO15__WAKEUPMIX_TOP_XSPI1_INTFA_B             0x004C 0x027C 0x0624 0x03 0x00
+#define IMX952_PAD_GPIO_IO15__WAKEUPMIX_TOP_LPSPI8_SCK                0x004C 0x027C 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO15__WAKEUPMIX_TOP_LPUART8_RTS_B             0x004C 0x027C 0x0000 0x05 0x00
+#define IMX952_PAD_GPIO_IO15__WAKEUPMIX_TOP_LPUART4_RX                0x004C 0x027C 0x0590 0x06 0x01
+#define IMX952_PAD_GPIO_IO15__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_15         0x004C 0x027C 0x04F8 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO16__WAKEUPMIX_TOP_GPIO2_IO_16               0x0050 0x0280 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO16__WAKEUPMIX_TOP_AUDMIX_TDM_OUT_TXBCLK     0x0050 0x0280 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO16__AONMIX_TOP_PDM_BIT_STREAM_2             0x0050 0x0280 0x046C 0x02 0x01
+#define IMX952_PAD_GPIO_IO16__WAKEUPMIX_TOP_LPUART3_CTS_B             0x0050 0x0280 0x0580 0x04 0x01
+#define IMX952_PAD_GPIO_IO16__WAKEUPMIX_TOP_LPSPI4_PCS2               0x0050 0x0280 0x0564 0x05 0x00
+#define IMX952_PAD_GPIO_IO16__WAKEUPMIX_TOP_LPUART4_CTS_B             0x0050 0x0280 0x058C 0x06 0x01
+#define IMX952_PAD_GPIO_IO16__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_16         0x0050 0x0280 0x04FC 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO17__WAKEUPMIX_TOP_GPIO2_IO_17               0x0054 0x0284 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO17__WAKEUPMIX_TOP_SAI3_MCLK                 0x0054 0x0284 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO17__WAKEUPMIX_TOP_LPUART3_RTS_B             0x0054 0x0284 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO17__WAKEUPMIX_TOP_LPSPI4_PCS1               0x0054 0x0284 0x0560 0x05 0x00
+#define IMX952_PAD_GPIO_IO17__WAKEUPMIX_TOP_LPUART4_RTS_B             0x0054 0x0284 0x0000 0x06 0x00
+#define IMX952_PAD_GPIO_IO17__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_17         0x0054 0x0284 0x0500 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO18__WAKEUPMIX_TOP_GPIO2_IO_18               0x0058 0x0288 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO18__WAKEUPMIX_TOP_SAI3_RX_BCLK              0x0058 0x0288 0x05B8 0x01 0x00
+#define IMX952_PAD_GPIO_IO18__WAKEUPMIX_TOP_LPSPI5_PCS0               0x0058 0x0288 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO18__WAKEUPMIX_TOP_LPSPI4_PCS0               0x0058 0x0288 0x055C 0x05 0x00
+#define IMX952_PAD_GPIO_IO18__WAKEUPMIX_TOP_TPM5_CH2                  0x0058 0x0288 0x0000 0x06 0x00
+#define IMX952_PAD_GPIO_IO18__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_18         0x0058 0x0288 0x0504 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO19__WAKEUPMIX_TOP_GPIO2_IO_19               0x005C 0x028C 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO19__WAKEUPMIX_TOP_SAI3_RX_SYNC              0x005C 0x028C 0x05BC 0x01 0x01
+#define IMX952_PAD_GPIO_IO19__AONMIX_TOP_PDM_BIT_STREAM_3             0x005C 0x028C 0x0470 0x02 0x01
+#define IMX952_PAD_GPIO_IO19__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_19         0x005C 0x028C 0x0508 0x03 0x00
+#define IMX952_PAD_GPIO_IO19__WAKEUPMIX_TOP_LPSPI5_SIN                0x005C 0x028C 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO19__WAKEUPMIX_TOP_LPSPI4_SIN                0x005C 0x028C 0x056C 0x05 0x00
+#define IMX952_PAD_GPIO_IO19__WAKEUPMIX_TOP_TPM6_CH2                  0x005C 0x028C 0x0000 0x06 0x00
+#define IMX952_PAD_GPIO_IO19__WAKEUPMIX_TOP_AUDMIX_TDM_OUT_TXDATA     0x005C 0x028C 0x05F4 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO20__WAKEUPMIX_TOP_GPIO2_IO_20               0x0060 0x0290 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO20__WAKEUPMIX_TOP_SAI3_RX_DATA_0            0x0060 0x0290 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO20__AONMIX_TOP_PDM_BIT_STREAM_0             0x0060 0x0290 0x0464 0x02 0x02
+#define IMX952_PAD_GPIO_IO20__WAKEUPMIX_TOP_LPSPI5_SOUT               0x0060 0x0290 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO20__WAKEUPMIX_TOP_LPSPI4_SOUT               0x0060 0x0290 0x0570 0x05 0x00
+#define IMX952_PAD_GPIO_IO20__WAKEUPMIX_TOP_TPM3_CH1                  0x0060 0x0290 0x0000 0x06 0x00
+#define IMX952_PAD_GPIO_IO20__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_20         0x0060 0x0290 0x050C 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO21__WAKEUPMIX_TOP_GPIO2_IO_21               0x0064 0x0294 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO21__WAKEUPMIX_TOP_AUDMIX_TDM_OUT_TXDATA     0x0064 0x0294 0x05F4 0x01 0x01
+#define IMX952_PAD_GPIO_IO21__AONMIX_TOP_PDM_CLK                      0x0064 0x0294 0x0000 0x02 0x00
+#define IMX952_PAD_GPIO_IO21__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_21         0x0064 0x0294 0x0510 0x03 0x00
+#define IMX952_PAD_GPIO_IO21__WAKEUPMIX_TOP_LPSPI5_SCK                0x0064 0x0294 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO21__WAKEUPMIX_TOP_LPSPI4_SCK                0x0064 0x0294 0x0568 0x05 0x00
+#define IMX952_PAD_GPIO_IO21__WAKEUPMIX_TOP_TPM4_CH1                  0x0064 0x0294 0x0000 0x06 0x00
+#define IMX952_PAD_GPIO_IO21__WAKEUPMIX_TOP_SAI3_RX_BCLK              0x0064 0x0294 0x05B8 0x07 0x01
+
+#define IMX952_PAD_GPIO_IO22__WAKEUPMIX_TOP_GPIO2_IO_22               0x0068 0x0298 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO22__WAKEUPMIX_TOP_USDHC3_CLK                0x0068 0x0298 0x0604 0x01 0x00
+#define IMX952_PAD_GPIO_IO22__HSIOMIX_TOP_USB1_OTG_OC                 0x0068 0x0298 0x047C 0x03 0x01
+#define IMX952_PAD_GPIO_IO22__WAKEUPMIX_TOP_TPM5_CH1                  0x0068 0x0298 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO22__WAKEUPMIX_TOP_TPM6_EXTCLK               0x0068 0x0298 0x0000 0x05 0x00
+#define IMX952_PAD_GPIO_IO22__WAKEUPMIX_TOP_LPI2C5_SDA                0x0068 0x0298 0x0540 0x06 0x01
+#define IMX952_PAD_GPIO_IO22__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_22         0x0068 0x0298 0x0514 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO23__WAKEUPMIX_TOP_GPIO2_IO_23               0x006C 0x029C 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO23__WAKEUPMIX_TOP_USDHC3_CMD                0x006C 0x029C 0x0608 0x01 0x00
+#define IMX952_PAD_GPIO_IO23__HSIOMIX_TOP_USB2_OTG_OC                 0x006C 0x029C 0x0480 0x03 0x01
+#define IMX952_PAD_GPIO_IO23__WAKEUPMIX_TOP_TPM6_CH1                  0x006C 0x029C 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO23__WAKEUPMIX_TOP_LPI2C5_SCL                0x006C 0x029C 0x053C 0x06 0x01
+#define IMX952_PAD_GPIO_IO23__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_23         0x006C 0x029C 0x0518 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO24__WAKEUPMIX_TOP_GPIO2_IO_24               0x0070 0x02A0 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO24__WAKEUPMIX_TOP_USDHC3_DATA0              0x0070 0x02A0 0x060C 0x01 0x00
+#define IMX952_PAD_GPIO_IO24__HSIOMIX_TOP_USB1_OTG_PWR                0x0070 0x02A0 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO24__WAKEUPMIX_TOP_TPM3_CH3                  0x0070 0x02A0 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO24__WAKEUPMIX_TOP_TDO                       0x0070 0x02A0 0x0000 0x05 0x00
+#define IMX952_PAD_GPIO_IO24__WAKEUPMIX_TOP_LPSPI6_PCS1               0x0070 0x02A0 0x0000 0x06 0x00
+#define IMX952_PAD_GPIO_IO24__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_24         0x0070 0x02A0 0x051C 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO25__WAKEUPMIX_TOP_GPIO2_IO_25               0x0074 0x02A4 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO25__WAKEUPMIX_TOP_USDHC3_DATA1              0x0074 0x02A4 0x0610 0x01 0x00
+#define IMX952_PAD_GPIO_IO25__WAKEUPMIX_TOP_CAN2_TX                   0x0074 0x02A4 0x0000 0x02 0x00
+#define IMX952_PAD_GPIO_IO25__HSIOMIX_TOP_USB2_OTG_PWR                0x0074 0x02A4 0x0000 0x03 0x00
+#define IMX952_PAD_GPIO_IO25__WAKEUPMIX_TOP_TPM4_CH3                  0x0074 0x02A4 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO25__WAKEUPMIX_TOP_TCK                       0x0074 0x02A4 0x05F8 0x05 0x01
+#define IMX952_PAD_GPIO_IO25__WAKEUPMIX_TOP_LPSPI7_PCS1               0x0074 0x02A4 0x0000 0x06 0x00
+#define IMX952_PAD_GPIO_IO25__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_25         0x0074 0x02A4 0x0520 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO26__WAKEUPMIX_TOP_GPIO2_IO_26               0x0078 0x02A8 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO26__WAKEUPMIX_TOP_USDHC3_DATA2              0x0078 0x02A8 0x0614 0x01 0x00
+#define IMX952_PAD_GPIO_IO26__AONMIX_TOP_PDM_BIT_STREAM_1             0x0078 0x02A8 0x0468 0x02 0x02
+#define IMX952_PAD_GPIO_IO26__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_26         0x0078 0x02A8 0x04AC 0x03 0x01
+#define IMX952_PAD_GPIO_IO26__WAKEUPMIX_TOP_TPM5_CH3                  0x0078 0x02A8 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO26__WAKEUPMIX_TOP_TDI                       0x0078 0x02A8 0x05FC 0x05 0x01
+#define IMX952_PAD_GPIO_IO26__WAKEUPMIX_TOP_LPSPI8_PCS1               0x0078 0x02A8 0x0000 0x06 0x00
+#define IMX952_PAD_GPIO_IO26__WAKEUPMIX_TOP_AUDMIX_TDM_OUT_TXSYNC     0x0078 0x02A8 0x0000 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO27__WAKEUPMIX_TOP_GPIO2_IO_27               0x007C 0x02AC 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO27__WAKEUPMIX_TOP_USDHC3_DATA3              0x007C 0x02AC 0x0618 0x01 0x00
+#define IMX952_PAD_GPIO_IO27__WAKEUPMIX_TOP_CAN2_RX                   0x007C 0x02AC 0x04A4 0x02 0x02
+#define IMX952_PAD_GPIO_IO27__WAKEUPMIX_TOP_TPM6_CH3                  0x007C 0x02AC 0x0000 0x04 0x00
+#define IMX952_PAD_GPIO_IO27__WAKEUPMIX_TOP_TMS                       0x007C 0x02AC 0x0600 0x05 0x01
+#define IMX952_PAD_GPIO_IO27__WAKEUPMIX_TOP_LPSPI5_PCS1               0x007C 0x02AC 0x0000 0x06 0x00
+#define IMX952_PAD_GPIO_IO27__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_27         0x007C 0x02AC 0x04B0 0x07 0x01
+
+#define IMX952_PAD_GPIO_IO28__WAKEUPMIX_TOP_GPIO2_IO_28               0x0080 0x02B0 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO28__WAKEUPMIX_TOP_LPI2C3_SDA                0x0080 0x02B0 0x0530 0x01 0x01
+#define IMX952_PAD_GPIO_IO28__WAKEUPMIX_TOP_CAN3_TX                   0x0080 0x02B0 0x0000 0x02 0x00
+#define IMX952_PAD_GPIO_IO28__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_28         0x0080 0x02B0 0x0000 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO29__WAKEUPMIX_TOP_GPIO2_IO_29               0x0084 0x02B4 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO29__WAKEUPMIX_TOP_LPI2C3_SCL                0x0084 0x02B4 0x052C 0x01 0x01
+#define IMX952_PAD_GPIO_IO29__WAKEUPMIX_TOP_CAN3_RX                   0x0084 0x02B4 0x04A8 0x02 0x01
+#define IMX952_PAD_GPIO_IO29__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_29         0x0084 0x02B4 0x0000 0x07 0x00
+
+#define IMX952_PAD_GPIO_IO30__WAKEUPMIX_TOP_GPIO2_IO_30               0x0088 0x02B8 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO30__WAKEUPMIX_TOP_LPI2C4_SDA                0x0088 0x02B8 0x0538 0x01 0x01
+#define IMX952_PAD_GPIO_IO30__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_30         0x0088 0x02B8 0x04B4 0x07 0x01
+
+#define IMX952_PAD_GPIO_IO31__WAKEUPMIX_TOP_GPIO2_IO_31               0x008C 0x02BC 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO31__WAKEUPMIX_TOP_LPI2C4_SCL                0x008C 0x02BC 0x0534 0x01 0x01
+#define IMX952_PAD_GPIO_IO31__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_31         0x008C 0x02BC 0x04B8 0x07 0x01
+
+#define IMX952_PAD_GPIO_IO32__WAKEUPMIX_TOP_GPIO5_IO_12               0x0090 0x02C0 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B              0x0090 0x02C0 0x0000 0x01 0x00
+#define IMX952_PAD_GPIO_IO32__WAKEUPMIX_TOP_LPUART6_TX                0x0090 0x02C0 0x05AC 0x02 0x01
+#define IMX952_PAD_GPIO_IO32__WAKEUPMIX_TOP_LPSPI4_PCS2               0x0090 0x02C0 0x0564 0x04 0x01
+
+#define IMX952_PAD_GPIO_IO33__WAKEUPMIX_TOP_GPIO5_IO_13               0x0094 0x02C4 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO33__WAKEUPMIX_TOP_LPUART6_RX                0x0094 0x02C4 0x05A8 0x02 0x01
+#define IMX952_PAD_GPIO_IO33__WAKEUPMIX_TOP_LPSPI4_PCS1               0x0094 0x02C4 0x0560 0x04 0x01
+
+#define IMX952_PAD_GPIO_IO34__WAKEUPMIX_TOP_GPIO5_IO_14               0x0098 0x02C8 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO34__WAKEUPMIX_TOP_LPUART6_CTS_B             0x0098 0x02C8 0x05A4 0x02 0x01
+#define IMX952_PAD_GPIO_IO34__WAKEUPMIX_TOP_LPSPI4_PCS0               0x0098 0x02C8 0x055C 0x04 0x01
+
+#define IMX952_PAD_GPIO_IO35__WAKEUPMIX_TOP_GPIO5_IO_15               0x009C 0x02CC 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO35__WAKEUPMIX_TOP_LPUART6_RTS_B             0x009C 0x02CC 0x0000 0x02 0x00
+#define IMX952_PAD_GPIO_IO35__WAKEUPMIX_TOP_LPSPI4_SIN                0x009C 0x02CC 0x056C 0x04 0x01
+
+#define IMX952_PAD_GPIO_IO36__WAKEUPMIX_TOP_LPSPI4_SOUT               0x00A0 0x02D0 0x0570 0x04 0x01
+#define IMX952_PAD_GPIO_IO36__WAKEUPMIX_TOP_GPIO5_IO_16               0x00A0 0x02D0 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO36__WAKEUPMIX_TOP_LPUART7_TX                0x00A0 0x02D0 0x05B4 0x02 0x01
+
+#define IMX952_PAD_GPIO_IO37__WAKEUPMIX_TOP_GPIO5_IO_17               0x00A4 0x02D4 0x0000 0x00 0x00
+#define IMX952_PAD_GPIO_IO37__WAKEUPMIX_TOP_LPUART7_RX                0x00A4 0x02D4 0x05B0 0x02 0x01
+#define IMX952_PAD_GPIO_IO37__WAKEUPMIX_TOP_LPSPI4_SCK                0x00A4 0x02D4 0x0568 0x04 0x01
+
+#define IMX952_PAD_CCM_CLKO1__CCMSRCGPCMIX_TOP_CLKO_1                 0x00D4 0x0304 0x0000 0x00 0x00
+#define IMX952_PAD_CCM_CLKO1__NETCMIX_TOP_NETC_TMR_1588_TRIG1         0x00D4 0x0304 0x0494 0x01 0x00
+#define IMX952_PAD_CCM_CLKO1__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_26         0x00D4 0x0304 0x04AC 0x04 0x00
+#define IMX952_PAD_CCM_CLKO1__WAKEUPMIX_TOP_GPIO3_IO_26               0x00D4 0x0304 0x0000 0x05 0x00
+
+#define IMX952_PAD_CCM_CLKO2__WAKEUPMIX_TOP_GPIO3_IO_27               0x00D8 0x0308 0x0000 0x05 0x00
+#define IMX952_PAD_CCM_CLKO2__CCMSRCGPCMIX_TOP_CLKO_2                 0x00D8 0x0308 0x0000 0x00 0x00
+#define IMX952_PAD_CCM_CLKO2__NETCMIX_TOP_NETC_TMR_1588_PP1           0x00D8 0x0308 0x0000 0x01 0x00
+#define IMX952_PAD_CCM_CLKO2__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_27         0x00D8 0x0308 0x04B0 0x04 0x00
+
+#define IMX952_PAD_CCM_CLKO3__CCMSRCGPCMIX_TOP_CLKO_3                 0x00DC 0x030C 0x0000 0x00 0x00
+#define IMX952_PAD_CCM_CLKO3__NETCMIX_TOP_NETC_TMR_1588_TRIG2         0x00DC 0x030C 0x0498 0x01 0x00
+#define IMX952_PAD_CCM_CLKO3__WAKEUPMIX_TOP_CAN3_TX                   0x00DC 0x030C 0x0000 0x02 0x00
+#define IMX952_PAD_CCM_CLKO3__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_28         0x00DC 0x030C 0x0000 0x04 0x00
+#define IMX952_PAD_CCM_CLKO3__WAKEUPMIX_TOP_GPIO4_IO_28               0x00DC 0x030C 0x0000 0x05 0x00
+
+#define IMX952_PAD_CCM_CLKO4__CCMSRCGPCMIX_TOP_CLKO_4                 0x00E0 0x0310 0x0000 0x00 0x00
+#define IMX952_PAD_CCM_CLKO4__NETCMIX_TOP_NETC_TMR_1588_PP2           0x00E0 0x0310 0x0000 0x01 0x00
+#define IMX952_PAD_CCM_CLKO4__WAKEUPMIX_TOP_CAN3_RX                   0x00E0 0x0310 0x04A8 0x02 0x00
+#define IMX952_PAD_CCM_CLKO4__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_29         0x00E0 0x0310 0x0000 0x04 0x00
+#define IMX952_PAD_CCM_CLKO4__WAKEUPMIX_TOP_GPIO4_IO_29               0x00E0 0x0310 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_MDC__NETCMIX_TOP_NETC_MDC                    0x00E4 0x0314 0x0484 0x00 0x00
+#define IMX952_PAD_ENET1_MDC__WAKEUPMIX_TOP_LPUART3_DCD_B             0x00E4 0x0314 0x0000 0x01 0x00
+#define IMX952_PAD_ENET1_MDC__WAKEUPMIX_TOP_I3C2_SCL                  0x00E4 0x0314 0x0524 0x02 0x00
+#define IMX952_PAD_ENET1_MDC__HSIOMIX_TOP_USB1_OTG_ID                 0x00E4 0x0314 0x0000 0x03 0x00
+#define IMX952_PAD_ENET1_MDC__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_0          0x00E4 0x0314 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_MDC__WAKEUPMIX_TOP_GPIO4_IO_0                0x00E4 0x0314 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_MDIO__NETCMIX_TOP_NETC_MDIO                  0x00E8 0x0318 0x0488 0x00 0x00
+#define IMX952_PAD_ENET1_MDIO__WAKEUPMIX_TOP_LPUART3_RIN_B            0x00E8 0x0318 0x0000 0x01 0x00
+#define IMX952_PAD_ENET1_MDIO__WAKEUPMIX_TOP_I3C2_SDA                 0x00E8 0x0318 0x0528 0x02 0x00
+#define IMX952_PAD_ENET1_MDIO__HSIOMIX_TOP_USB1_OTG_PWR               0x00E8 0x0318 0x0000 0x03 0x00
+#define IMX952_PAD_ENET1_MDIO__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_1         0x00E8 0x0318 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_MDIO__WAKEUPMIX_TOP_GPIO4_IO_1               0x00E8 0x0318 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3              0x00EC 0x031C 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_TD3__WAKEUPMIX_TOP_CAN2_TX                   0x00EC 0x031C 0x0000 0x02 0x00
+#define IMX952_PAD_ENET1_TD3__HSIOMIX_TOP_USB2_OTG_ID                 0x00EC 0x031C 0x0000 0x03 0x00
+#define IMX952_PAD_ENET1_TD3__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_2          0x00EC 0x031C 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_TD3__WAKEUPMIX_TOP_GPIO4_IO_2                0x00EC 0x031C 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2              0x00F0 0x0320 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RMII_REF50_CLK         0x00F0 0x0320 0x0000 0x01 0x00
+#define IMX952_PAD_ENET1_TD2__WAKEUPMIX_TOP_CAN2_RX                   0x00F0 0x0320 0x04A4 0x02 0x01
+#define IMX952_PAD_ENET1_TD2__HSIOMIX_TOP_USB2_OTG_OC                 0x00F0 0x0320 0x0480 0x03 0x00
+#define IMX952_PAD_ENET1_TD2__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_3          0x00F0 0x0320 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_TD2__WAKEUPMIX_TOP_GPIO4_IO_3                0x00F0 0x0320 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1              0x00F4 0x0324 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_TD1__WAKEUPMIX_TOP_LPUART3_RTS_B             0x00F4 0x0324 0x0000 0x01 0x00
+#define IMX952_PAD_ENET1_TD1__WAKEUPMIX_TOP_I3C2_PUR                  0x00F4 0x0324 0x0000 0x02 0x00
+#define IMX952_PAD_ENET1_TD1__HSIOMIX_TOP_USB1_OTG_OC                 0x00F4 0x0324 0x047C 0x03 0x00
+#define IMX952_PAD_ENET1_TD1__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_4          0x00F4 0x0324 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_TD1__WAKEUPMIX_TOP_GPIO4_IO_4                0x00F4 0x0324 0x0000 0x05 0x00
+#define IMX952_PAD_ENET1_TD1__WAKEUPMIX_TOP_I3C2_PUR_B                0x00F4 0x0324 0x0000 0x06 0x00
+#define IMX952_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RMII_TXD1              0x00F4 0x0324 0x0000 0x07 0x00
+
+#define IMX952_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0              0x00F8 0x0328 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_TD0__WAKEUPMIX_TOP_LPUART3_TX                0x00F8 0x0328 0x0588 0x01 0x00
+#define IMX952_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RMII_TXD0              0x00F8 0x0328 0x0000 0x02 0x00
+#define IMX952_PAD_ENET1_TD0__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_5          0x00F8 0x0328 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_TD0__WAKEUPMIX_TOP_GPIO4_IO_5                0x00F8 0x0328 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL        0x00FC 0x032C 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_TX_CTL__WAKEUPMIX_TOP_LPUART3_DTR_B          0x00FC 0x032C 0x0000 0x01 0x00
+#define IMX952_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RMII_TX_EN          0x00FC 0x032C 0x0000 0x02 0x00
+#define IMX952_PAD_ENET1_TX_CTL__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_6       0x00FC 0x032C 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_TX_CTL__WAKEUPMIX_TOP_GPIO4_IO_6             0x00FC 0x032C 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK           0x0100 0x0330 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RMII_REF50_CLK_OUT     0x0100 0x0330 0x0000 0x01 0x00
+#define IMX952_PAD_ENET1_TXC__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_7          0x0100 0x0330 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_TXC__WAKEUPMIX_TOP_GPIO4_IO_7                0x0100 0x0330 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL        0x0104 0x0334 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_RX_CTL__WAKEUPMIX_TOP_LPUART3_DSR_B          0x0104 0x0334 0x0000 0x01 0x00
+#define IMX952_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RMII_CRS_DV         0x0104 0x0334 0x0000 0x02 0x00
+#define IMX952_PAD_ENET1_RX_CTL__HSIOMIX_TOP_USB2_OTG_PWR             0x0104 0x0334 0x0000 0x03 0x00
+#define IMX952_PAD_ENET1_RX_CTL__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_8       0x0104 0x0334 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_RX_CTL__WAKEUPMIX_TOP_GPIO4_IO_8             0x0104 0x0334 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK           0x0108 0x0338 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RMII_RX_ER             0x0108 0x0338 0x048C 0x01 0x00
+#define IMX952_PAD_ENET1_RXC__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_9          0x0108 0x0338 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_RXC__WAKEUPMIX_TOP_GPIO4_IO_9                0x0108 0x0338 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0              0x010C 0x033C 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_RD0__WAKEUPMIX_TOP_LPUART3_RX                0x010C 0x033C 0x0584 0x01 0x00
+#define IMX952_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RMII_RXD0              0x010C 0x033C 0x0000 0x02 0x00
+#define IMX952_PAD_ENET1_RD0__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_10         0x010C 0x033C 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_RD0__WAKEUPMIX_TOP_GPIO4_IO_10               0x010C 0x033C 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1              0x0110 0x0340 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_RD1__WAKEUPMIX_TOP_LPUART3_CTS_B             0x0110 0x0340 0x0580 0x01 0x00
+#define IMX952_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RMII_RXD1              0x0110 0x0340 0x0000 0x02 0x00
+#define IMX952_PAD_ENET1_RD1__WAKEUPMIX_TOP_LPTMR2_ALT0               0x0110 0x0340 0x0574 0x03 0x00
+#define IMX952_PAD_ENET1_RD1__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_11         0x0110 0x0340 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_RD1__WAKEUPMIX_TOP_GPIO4_IO_11               0x0110 0x0340 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2              0x0114 0x0344 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RMII_RX_ER             0x0114 0x0344 0x048C 0x02 0x01
+#define IMX952_PAD_ENET1_RD2__WAKEUPMIX_TOP_LPTMR2_ALT1               0x0114 0x0344 0x0578 0x03 0x00
+#define IMX952_PAD_ENET1_RD2__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_12         0x0114 0x0344 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_RD2__WAKEUPMIX_TOP_GPIO4_IO_12               0x0114 0x0344 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3              0x0118 0x0348 0x0000 0x00 0x00
+#define IMX952_PAD_ENET1_RD3__WAKEUPMIX_TOP_LPTMR2_ALT2               0x0118 0x0348 0x057C 0x03 0x00
+#define IMX952_PAD_ENET1_RD3__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_13         0x0118 0x0348 0x0000 0x04 0x00
+#define IMX952_PAD_ENET1_RD3__WAKEUPMIX_TOP_GPIO4_IO_13               0x0118 0x0348 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC                    0x011C 0x034C 0x0484 0x00 0x01
+#define IMX952_PAD_ENET2_MDC__WAKEUPMIX_TOP_LPUART4_DCD_B             0x011C 0x034C 0x0000 0x01 0x00
+#define IMX952_PAD_ENET2_MDC__NETCMIX_TOP_SAI2_RX_SYNC                0x011C 0x034C 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_MDC__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_14         0x011C 0x034C 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_MDC__WAKEUPMIX_TOP_GPIO4_IO_14               0x011C 0x034C 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO                  0x0120 0x0350 0x0488 0x00 0x01
+#define IMX952_PAD_ENET2_MDIO__WAKEUPMIX_TOP_LPUART4_RIN_B            0x0120 0x0350 0x0000 0x01 0x00
+#define IMX952_PAD_ENET2_MDIO__NETCMIX_TOP_SAI2_RX_BCLK               0x0120 0x0350 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_MDIO__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_15        0x0120 0x0350 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_MDIO__WAKEUPMIX_TOP_GPIO4_IO_15              0x0120 0x0350 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET2_TD3__NETCMIX_TOP_SAI2_RX_DATA_0              0x0124 0x0354 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_TD3__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_16         0x0124 0x0354 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_TD3__WAKEUPMIX_TOP_GPIO4_IO_16               0x0124 0x0354 0x0000 0x05 0x00
+#define IMX952_PAD_ENET2_TD3__NETCMIX_TOP_ETH1_RGMII_TD3              0x0124 0x0354 0x0000 0x00 0x00
+
+#define IMX952_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RGMII_TD2              0x0128 0x0358 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RMII_REF50_CLK         0x0128 0x0358 0x0000 0x01 0x00
+#define IMX952_PAD_ENET2_TD2__NETCMIX_TOP_SAI2_RX_DATA_1              0x0128 0x0358 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_TD2__WAKEUPMIX_TOP_SAI4_TX_SYNC              0x0128 0x0358 0x05D0 0x03 0x00
+#define IMX952_PAD_ENET2_TD2__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_17         0x0128 0x0358 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_TD2__WAKEUPMIX_TOP_GPIO4_IO_17               0x0128 0x0358 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RGMII_TD1              0x012C 0x035C 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_TD1__WAKEUPMIX_TOP_LPUART4_RTS_B             0x012C 0x035C 0x0000 0x01 0x00
+#define IMX952_PAD_ENET2_TD1__NETCMIX_TOP_SAI2_RX_DATA_2              0x012C 0x035C 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_TD1__WAKEUPMIX_TOP_SAI4_TX_BCLK              0x012C 0x035C 0x05CC 0x03 0x00
+#define IMX952_PAD_ENET2_TD1__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_18         0x012C 0x035C 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_TD1__WAKEUPMIX_TOP_GPIO4_IO_18               0x012C 0x035C 0x0000 0x05 0x00
+#define IMX952_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RMII_TXD1              0x012C 0x035C 0x0000 0x06 0x00
+
+#define IMX952_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RGMII_TD0              0x0130 0x0360 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_TD0__WAKEUPMIX_TOP_LPUART4_TX                0x0130 0x0360 0x0594 0x01 0x00
+#define IMX952_PAD_ENET2_TD0__NETCMIX_TOP_SAI2_RX_DATA_3              0x0130 0x0360 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_TD0__WAKEUPMIX_TOP_SAI4_TX_DATA_0            0x0130 0x0360 0x0000 0x03 0x00
+#define IMX952_PAD_ENET2_TD0__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_19         0x0130 0x0360 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_TD0__WAKEUPMIX_TOP_GPIO4_IO_19               0x0130 0x0360 0x0000 0x05 0x00
+#define IMX952_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RMII_TXD0              0x0130 0x0360 0x0000 0x06 0x00
+
+#define IMX952_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RGMII_TX_CTL        0x0134 0x0364 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_TX_CTL__WAKEUPMIX_TOP_LPUART4_DTR_B          0x0134 0x0364 0x0000 0x01 0x00
+#define IMX952_PAD_ENET2_TX_CTL__NETCMIX_TOP_SAI2_TX_SYNC             0x0134 0x0364 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RMII_TX_EN          0x0134 0x0364 0x0000 0x03 0x00
+#define IMX952_PAD_ENET2_TX_CTL__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_20      0x0134 0x0364 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_TX_CTL__WAKEUPMIX_TOP_GPIO4_IO_20            0x0134 0x0364 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET2_TXC__NETCMIX_TOP_ETH1_RGMII_TX_CLK           0x0138 0x0368 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_TXC__NETCMIX_TOP_ETH1_RMII_REF50_CLK_OUT     0x0138 0x0368 0x0000 0x01 0x00
+#define IMX952_PAD_ENET2_TXC__NETCMIX_TOP_SAI2_TX_BCLK                0x0138 0x0368 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_TXC__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_21         0x0138 0x0368 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_TXC__WAKEUPMIX_TOP_GPIO4_IO_21               0x0138 0x0368 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RGMII_RX_CTL        0x013C 0x036C 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_RX_CTL__WAKEUPMIX_TOP_LPUART4_DSR_B          0x013C 0x036C 0x0000 0x01 0x00
+#define IMX952_PAD_ENET2_RX_CTL__NETCMIX_TOP_SAI2_TX_DATA_0           0x013C 0x036C 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_RX_CTL__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_22      0x013C 0x036C 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_RX_CTL__WAKEUPMIX_TOP_GPIO4_IO_22            0x013C 0x036C 0x0000 0x05 0x00
+#define IMX952_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RMII_CRS_DV         0x013C 0x036C 0x0000 0x06 0x00
+
+#define IMX952_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RGMII_RX_CLK           0x0140 0x0370 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RMII_RX_ER             0x0140 0x0370 0x0490 0x01 0x00
+#define IMX952_PAD_ENET2_RXC__NETCMIX_TOP_SAI2_TX_DATA_1              0x0140 0x0370 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_RXC__WAKEUPMIX_TOP_SAI4_RX_SYNC              0x0140 0x0370 0x05C8 0x03 0x00
+#define IMX952_PAD_ENET2_RXC__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_23         0x0140 0x0370 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_RXC__WAKEUPMIX_TOP_GPIO4_IO_23               0x0140 0x0370 0x0000 0x05 0x00
+
+#define IMX952_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RGMII_RD0              0x0144 0x0374 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_RD0__WAKEUPMIX_TOP_LPUART4_RX                0x0144 0x0374 0x0590 0x01 0x00
+#define IMX952_PAD_ENET2_RD0__NETCMIX_TOP_SAI2_TX_DATA_2              0x0144 0x0374 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_RD0__WAKEUPMIX_TOP_SAI4_RX_BCLK              0x0144 0x0374 0x05C0 0x03 0x00
+#define IMX952_PAD_ENET2_RD0__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_24         0x0144 0x0374 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_RD0__WAKEUPMIX_TOP_GPIO4_IO_24               0x0144 0x0374 0x0000 0x05 0x00
+#define IMX952_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RMII_RXD0              0x0144 0x0374 0x0000 0x06 0x00
+
+#define IMX952_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RGMII_RD1              0x0148 0x0378 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_RD1__NETCMIX_TOP_SAI2_TX_DATA_3              0x0148 0x0378 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_RD1__WAKEUPMIX_TOP_SAI4_RX_DATA_0            0x0148 0x0378 0x05C4 0x03 0x00
+#define IMX952_PAD_ENET2_RD1__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_25         0x0148 0x0378 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_RD1__WAKEUPMIX_TOP_GPIO4_IO_25               0x0148 0x0378 0x0000 0x05 0x00
+#define IMX952_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RMII_RXD1              0x0148 0x0378 0x0000 0x06 0x00
+
+#define IMX952_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RGMII_RD2              0x014C 0x037C 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_RD2__WAKEUPMIX_TOP_LPUART4_CTS_B             0x014C 0x037C 0x058C 0x01 0x00
+#define IMX952_PAD_ENET2_RD2__NETCMIX_TOP_SAI2_MCLK                   0x014C 0x037C 0x0000 0x02 0x00
+#define IMX952_PAD_ENET2_RD2__NETCMIX_TOP_MQS2_RIGHT                  0x014C 0x037C 0x0000 0x03 0x00
+#define IMX952_PAD_ENET2_RD2__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_26         0x014C 0x037C 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_RD2__WAKEUPMIX_TOP_GPIO4_IO_26               0x014C 0x037C 0x0000 0x05 0x00
+#define IMX952_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RMII_RX_ER             0x014C 0x037C 0x0490 0x06 0x01
+
+#define IMX952_PAD_ENET2_RD3__NETCMIX_TOP_ETH1_RGMII_RD3              0x0150 0x0380 0x0000 0x00 0x00
+#define IMX952_PAD_ENET2_RD3__NETCMIX_TOP_MQS2_LEFT                   0x0150 0x0380 0x0000 0x03 0x00
+#define IMX952_PAD_ENET2_RD3__WAKEUPMIX_TOP_FLEXIO2_FLEXIO_27         0x0150 0x0380 0x0000 0x04 0x00
+#define IMX952_PAD_ENET2_RD3__WAKEUPMIX_TOP_GPIO4_IO_27               0x0150 0x0380 0x0000 0x05 0x00
+
+#define IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_8            0x0154 0x0384 0x04DC 0x04 0x01
+#define IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_GPIO3_IO_8                  0x0154 0x0384 0x0000 0x05 0x00
+#define IMX952_PAD_SD1_CLK__WAKEUPMIX_TOP_USDHC1_CLK                  0x0154 0x0384 0x0000 0x00 0x00
+
+#define IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_USDHC1_CMD                  0x0158 0x0388 0x0000 0x00 0x00
+#define IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_9            0x0158 0x0388 0x04E0 0x04 0x01
+#define IMX952_PAD_SD1_CMD__WAKEUPMIX_TOP_GPIO3_IO_9                  0x0158 0x0388 0x0000 0x05 0x00
+
+#define IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_USDHC1_DATA0              0x015C 0x038C 0x0000 0x00 0x00
+#define IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_10         0x015C 0x038C 0x04E4 0x04 0x01
+#define IMX952_PAD_SD1_DATA0__WAKEUPMIX_TOP_GPIO3_IO_10               0x015C 0x038C 0x0000 0x05 0x00
+
+#define IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_USDHC1_DATA1              0x0160 0x0390 0x0000 0x00 0x00
+#define IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_11         0x0160 0x0390 0x04E8 0x04 0x01
+#define IMX952_PAD_SD1_DATA1__WAKEUPMIX_TOP_GPIO3_IO_11               0x0160 0x0390 0x0000 0x05 0x00
+
+#define IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_USDHC1_DATA2              0x0164 0x0394 0x0000 0x00 0x00
+#define IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_XSPI1_INTFA_B             0x0164 0x0394 0x0624 0x01 0x01
+#define IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_12         0x0164 0x0394 0x04EC 0x04 0x01
+#define IMX952_PAD_SD1_DATA2__WAKEUPMIX_TOP_GPIO3_IO_12               0x0164 0x0394 0x0000 0x05 0x00
+#define IMX952_PAD_SD1_DATA2__CCMSRCGPCMIX_TOP_PMIC_READY             0x0164 0x0394 0x0000 0x06 0x00
+
+#define IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_USDHC1_DATA3              0x0168 0x0398 0x0000 0x00 0x00
+#define IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_XSPI1_A_SS1_B             0x0168 0x0398 0x064C 0x01 0x00
+#define IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_13         0x0168 0x0398 0x04F0 0x04 0x01
+#define IMX952_PAD_SD1_DATA3__WAKEUPMIX_TOP_GPIO3_IO_13               0x0168 0x0398 0x0000 0x05 0x00
+
+#define IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_USDHC1_DATA4              0x016C 0x039C 0x0000 0x00 0x00
+#define IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_XSPI1_A_DATA_4            0x016C 0x039C 0x0638 0x01 0x00
+#define IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_14         0x016C 0x039C 0x04F4 0x04 0x01
+#define IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_GPIO3_IO_14               0x016C 0x039C 0x0000 0x05 0x00
+#define IMX952_PAD_SD1_DATA4__WAKEUPMIX_TOP_XSPI_SLV_DATA_4           0x016C 0x039C 0x066C 0x06 0x00
+
+#define IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_DATA5              0x0170 0x03A0 0x0000 0x00 0x00
+#define IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_XSPI1_A_DATA_5            0x0170 0x03A0 0x063C 0x01 0x00
+#define IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_USDHC1_RESET_B            0x0170 0x03A0 0x0000 0x02 0x00
+#define IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_15         0x0170 0x03A0 0x04F8 0x04 0x01
+#define IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_GPIO3_IO_15               0x0170 0x03A0 0x0000 0x05 0x00
+#define IMX952_PAD_SD1_DATA5__WAKEUPMIX_TOP_XSPI_SLV_DATA_5           0x0170 0x03A0 0x0670 0x06 0x00
+
+#define IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_DATA6              0x0174 0x03A4 0x0000 0x00 0x00
+#define IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_XSPI1_A_DATA_6            0x0174 0x03A4 0x0640 0x01 0x00
+#define IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_USDHC1_CD_B               0x0174 0x03A4 0x0000 0x02 0x00
+#define IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_16         0x0174 0x03A4 0x04FC 0x04 0x01
+#define IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_GPIO3_IO_16               0x0174 0x03A4 0x0000 0x05 0x00
+#define IMX952_PAD_SD1_DATA6__WAKEUPMIX_TOP_XSPI_SLV_DATA_6           0x0174 0x03A4 0x0674 0x06 0x00
+
+#define IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_DATA7              0x0178 0x03A8 0x0000 0x00 0x00
+#define IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_XSPI1_A_DATA_7            0x0178 0x03A8 0x0644 0x01 0x00
+#define IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_USDHC1_WP                 0x0178 0x03A8 0x0000 0x02 0x00
+#define IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_17         0x0178 0x03A8 0x0500 0x04 0x01
+#define IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_GPIO3_IO_17               0x0178 0x03A8 0x0000 0x05 0x00
+#define IMX952_PAD_SD1_DATA7__WAKEUPMIX_TOP_XSPI_SLV_DATA_7           0x0178 0x03A8 0x0678 0x06 0x00
+
+#define IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_USDHC1_STROBE            0x017C 0x03AC 0x0000 0x00 0x00
+#define IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_XSPI1_A_DQS              0x017C 0x03AC 0x0620 0x01 0x00
+#define IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_18        0x017C 0x03AC 0x0504 0x04 0x01
+#define IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_GPIO3_IO_18              0x017C 0x03AC 0x0000 0x05 0x00
+#define IMX952_PAD_SD1_STROBE__WAKEUPMIX_TOP_XSPI_SLV_DQS             0x017C 0x03AC 0x0654 0x06 0x00
+
+#define IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_VSELECT          0x0180 0x03B0 0x0000 0x00 0x00
+#define IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_USDHC2_WP               0x0180 0x03B0 0x0000 0x01 0x00
+#define IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_LPTMR2_ALT2             0x0180 0x03B0 0x057C 0x02 0x01
+#define IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_19       0x0180 0x03B0 0x0508 0x04 0x01
+#define IMX952_PAD_SD2_VSELECT__WAKEUPMIX_TOP_GPIO3_IO_19             0x0180 0x03B0 0x0000 0x05 0x00
+#define IMX952_PAD_SD2_VSELECT__CCMSRCGPCMIX_TOP_EXT_CLK1             0x0180 0x03B0 0x0478 0x06 0x01
+
+#define IMX952_PAD_SD3_CLK__WAKEUPMIX_TOP_USDHC3_CLK                  0x0184 0x03B4 0x0604 0x00 0x01
+#define IMX952_PAD_SD3_CLK__WAKEUPMIX_TOP_XSPI1_A_SCLK                0x0184 0x03B4 0x061C 0x01 0x00
+#define IMX952_PAD_SD3_CLK__WAKEUPMIX_TOP_SAI5_TX_DATA_1              0x0184 0x03B4 0x0000 0x02 0x00
+#define IMX952_PAD_SD3_CLK__WAKEUPMIX_TOP_SAI5_RX_DATA_0              0x0184 0x03B4 0x05D8 0x03 0x00
+#define IMX952_PAD_SD3_CLK__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_20           0x0184 0x03B4 0x050C 0x04 0x01
+#define IMX952_PAD_SD3_CLK__WAKEUPMIX_TOP_GPIO3_IO_20                 0x0184 0x03B4 0x0000 0x05 0x00
+#define IMX952_PAD_SD3_CLK__WAKEUPMIX_TOP_XSPI_SLV_CLK                0x0184 0x03B4 0x0658 0x06 0x00
+
+#define IMX952_PAD_SD3_CMD__WAKEUPMIX_TOP_USDHC3_CMD                  0x0188 0x03B8 0x0608 0x00 0x01
+#define IMX952_PAD_SD3_CMD__WAKEUPMIX_TOP_XSPI1_A_SS0_B               0x0188 0x03B8 0x0648 0x01 0x00
+#define IMX952_PAD_SD3_CMD__WAKEUPMIX_TOP_SAI5_TX_DATA_2              0x0188 0x03B8 0x0000 0x02 0x00
+#define IMX952_PAD_SD3_CMD__WAKEUPMIX_TOP_SAI5_RX_SYNC                0x0188 0x03B8 0x05E8 0x03 0x00
+#define IMX952_PAD_SD3_CMD__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_21           0x0188 0x03B8 0x0510 0x04 0x01
+#define IMX952_PAD_SD3_CMD__WAKEUPMIX_TOP_GPIO3_IO_21                 0x0188 0x03B8 0x0000 0x05 0x00
+#define IMX952_PAD_SD3_CMD__WAKEUPMIX_TOP_XSPI_SLV_CS                 0x0188 0x03B8 0x0650 0x06 0x00
+
+#define IMX952_PAD_SD3_DATA0__WAKEUPMIX_TOP_USDHC3_DATA0              0x018C 0x03BC 0x060C 0x00 0x01
+#define IMX952_PAD_SD3_DATA0__WAKEUPMIX_TOP_XSPI1_A_DATA_0            0x018C 0x03BC 0x0628 0x01 0x00
+#define IMX952_PAD_SD3_DATA0__WAKEUPMIX_TOP_SAI5_TX_DATA_3            0x018C 0x03BC 0x0000 0x02 0x00
+#define IMX952_PAD_SD3_DATA0__WAKEUPMIX_TOP_SAI5_RX_BCLK              0x018C 0x03BC 0x05D4 0x03 0x00
+#define IMX952_PAD_SD3_DATA0__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_22         0x018C 0x03BC 0x0514 0x04 0x01
+#define IMX952_PAD_SD3_DATA0__WAKEUPMIX_TOP_GPIO3_IO_22               0x018C 0x03BC 0x0000 0x05 0x00
+#define IMX952_PAD_SD3_DATA0__WAKEUPMIX_TOP_XSPI_SLV_DATA_0           0x018C 0x03BC 0x065C 0x06 0x00
+
+#define IMX952_PAD_SD3_DATA1__WAKEUPMIX_TOP_USDHC3_DATA1              0x0190 0x03C0 0x0610 0x00 0x01
+#define IMX952_PAD_SD3_DATA1__WAKEUPMIX_TOP_XSPI1_A_DATA_1            0x0190 0x03C0 0x062C 0x01 0x00
+#define IMX952_PAD_SD3_DATA1__WAKEUPMIX_TOP_SAI5_RX_DATA_1            0x0190 0x03C0 0x05DC 0x02 0x00
+#define IMX952_PAD_SD3_DATA1__WAKEUPMIX_TOP_SAI5_TX_DATA_0            0x0190 0x03C0 0x0000 0x03 0x00
+#define IMX952_PAD_SD3_DATA1__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_23         0x0190 0x03C0 0x0518 0x04 0x01
+#define IMX952_PAD_SD3_DATA1__WAKEUPMIX_TOP_GPIO3_IO_23               0x0190 0x03C0 0x0000 0x05 0x00
+#define IMX952_PAD_SD3_DATA1__WAKEUPMIX_TOP_XSPI_SLV_DATA_1           0x0190 0x03C0 0x0660 0x06 0x00
+
+#define IMX952_PAD_SD3_DATA2__WAKEUPMIX_TOP_USDHC3_DATA2              0x0194 0x03C4 0x0614 0x00 0x01
+#define IMX952_PAD_SD3_DATA2__WAKEUPMIX_TOP_XSPI1_A_DATA_2            0x0194 0x03C4 0x0630 0x01 0x00
+#define IMX952_PAD_SD3_DATA2__WAKEUPMIX_TOP_SAI5_RX_DATA_2            0x0194 0x03C4 0x05E0 0x02 0x00
+#define IMX952_PAD_SD3_DATA2__WAKEUPMIX_TOP_SAI5_TX_SYNC              0x0194 0x03C4 0x05F0 0x03 0x00
+#define IMX952_PAD_SD3_DATA2__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_24         0x0194 0x03C4 0x051C 0x04 0x01
+#define IMX952_PAD_SD3_DATA2__WAKEUPMIX_TOP_GPIO3_IO_24               0x0194 0x03C4 0x0000 0x05 0x00
+#define IMX952_PAD_SD3_DATA2__WAKEUPMIX_TOP_XSPI_SLV_DATA_2           0x0194 0x03C4 0x0664 0x06 0x00
+
+#define IMX952_PAD_SD3_DATA3__WAKEUPMIX_TOP_USDHC3_DATA3              0x0198 0x03C8 0x0618 0x00 0x01
+#define IMX952_PAD_SD3_DATA3__WAKEUPMIX_TOP_XSPI1_A_DATA_3            0x0198 0x03C8 0x0634 0x01 0x00
+#define IMX952_PAD_SD3_DATA3__WAKEUPMIX_TOP_SAI5_RX_DATA_3            0x0198 0x03C8 0x05E4 0x02 0x00
+#define IMX952_PAD_SD3_DATA3__WAKEUPMIX_TOP_SAI5_TX_BCLK              0x0198 0x03C8 0x05EC 0x03 0x00
+#define IMX952_PAD_SD3_DATA3__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_25         0x0198 0x03C8 0x0520 0x04 0x01
+#define IMX952_PAD_SD3_DATA3__WAKEUPMIX_TOP_GPIO3_IO_25               0x0198 0x03C8 0x0000 0x05 0x00
+#define IMX952_PAD_SD3_DATA3__WAKEUPMIX_TOP_XSPI_SLV_DATA_3           0x0198 0x03C8 0x0668 0x06 0x00
+
+#define IMX952_PAD_XSPI1_DATA0__WAKEUPMIX_TOP_XSPI1_A_DATA_0          0x019C 0x03CC 0x0628 0x00 0x01
+#define IMX952_PAD_XSPI1_DATA0__NETCMIX_TOP_SAI2_TX_DATA_4            0x019C 0x03CC 0x0000 0x01 0x00
+#define IMX952_PAD_XSPI1_DATA0__WAKEUPMIX_TOP_SAI4_TX_BCLK            0x019C 0x03CC 0x05CC 0x02 0x01
+#define IMX952_PAD_XSPI1_DATA0__WAKEUPMIX_TOP_SAI4_RX_DATA_1          0x019C 0x03CC 0x0000 0x03 0x00
+#define IMX952_PAD_XSPI1_DATA0__WAKEUPMIX_TOP_XSPI_SLV_DATA_0         0x019C 0x03CC 0x065C 0x04 0x01
+#define IMX952_PAD_XSPI1_DATA0__WAKEUPMIX_TOP_GPIO5_IO_0              0x019C 0x03CC 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_DATA1__WAKEUPMIX_TOP_XSPI1_A_DATA_1          0x01A0 0x03D0 0x062C 0x00 0x01
+#define IMX952_PAD_XSPI1_DATA1__NETCMIX_TOP_SAI2_TX_DATA_5            0x01A0 0x03D0 0x0000 0x01 0x00
+#define IMX952_PAD_XSPI1_DATA1__WAKEUPMIX_TOP_SAI4_TX_SYNC            0x01A0 0x03D0 0x05D0 0x02 0x01
+#define IMX952_PAD_XSPI1_DATA1__WAKEUPMIX_TOP_SAI4_TX_DATA_1          0x01A0 0x03D0 0x0000 0x03 0x00
+#define IMX952_PAD_XSPI1_DATA1__WAKEUPMIX_TOP_XSPI_SLV_DATA_1         0x01A0 0x03D0 0x0660 0x04 0x01
+#define IMX952_PAD_XSPI1_DATA1__WAKEUPMIX_TOP_GPIO5_IO_1              0x01A0 0x03D0 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_DATA2__WAKEUPMIX_TOP_XSPI1_A_DATA_2          0x01A4 0x03D4 0x0630 0x00 0x01
+#define IMX952_PAD_XSPI1_DATA2__NETCMIX_TOP_SAI2_TX_DATA_6            0x01A4 0x03D4 0x0000 0x01 0x00
+#define IMX952_PAD_XSPI1_DATA2__WAKEUPMIX_TOP_SAI4_TX_DATA_0          0x01A4 0x03D4 0x0000 0x02 0x00
+#define IMX952_PAD_XSPI1_DATA2__WAKEUPMIX_TOP_XSPI_SLV_DATA_2         0x01A4 0x03D4 0x0664 0x04 0x01
+#define IMX952_PAD_XSPI1_DATA2__WAKEUPMIX_TOP_GPIO5_IO_2              0x01A4 0x03D4 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_DATA3__WAKEUPMIX_TOP_XSPI1_A_DATA_3          0x01A8 0x03D8 0x0634 0x00 0x01
+#define IMX952_PAD_XSPI1_DATA3__NETCMIX_TOP_SAI2_TX_DATA_7            0x01A8 0x03D8 0x0000 0x01 0x00
+#define IMX952_PAD_XSPI1_DATA3__WAKEUPMIX_TOP_SAI4_RX_DATA_0          0x01A8 0x03D8 0x05C4 0x02 0x01
+#define IMX952_PAD_XSPI1_DATA3__WAKEUPMIX_TOP_XSPI_SLV_DATA_3         0x01A8 0x03D8 0x0668 0x04 0x01
+#define IMX952_PAD_XSPI1_DATA3__WAKEUPMIX_TOP_GPIO5_IO_3              0x01A8 0x03D8 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_DATA4__WAKEUPMIX_TOP_XSPI1_A_DATA_4          0x01AC 0x03DC 0x0638 0x00 0x01
+#define IMX952_PAD_XSPI1_DATA4__WAKEUPMIX_TOP_SAI5_TX_DATA_0          0x01AC 0x03DC 0x0000 0x01 0x00
+#define IMX952_PAD_XSPI1_DATA4__WAKEUPMIX_TOP_SAI5_RX_DATA_1          0x01AC 0x03DC 0x05DC 0x02 0x01
+#define IMX952_PAD_XSPI1_DATA4__WAKEUPMIX_TOP_XSPI_SLV_DATA_4         0x01AC 0x03DC 0x066C 0x04 0x01
+#define IMX952_PAD_XSPI1_DATA4__WAKEUPMIX_TOP_GPIO5_IO_4              0x01AC 0x03DC 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_DATA5__WAKEUPMIX_TOP_XSPI1_A_DATA_5          0x01B0 0x03E0 0x063C 0x00 0x01
+#define IMX952_PAD_XSPI1_DATA5__WAKEUPMIX_TOP_SAI5_TX_SYNC            0x01B0 0x03E0 0x05F0 0x01 0x01
+#define IMX952_PAD_XSPI1_DATA5__WAKEUPMIX_TOP_SAI5_RX_DATA_2          0x01B0 0x03E0 0x05E0 0x02 0x01
+#define IMX952_PAD_XSPI1_DATA5__NETCMIX_TOP_SAI2_RX_DATA_6            0x01B0 0x03E0 0x049C 0x03 0x00
+#define IMX952_PAD_XSPI1_DATA5__WAKEUPMIX_TOP_XSPI_SLV_DATA_5         0x01B0 0x03E0 0x0670 0x04 0x01
+#define IMX952_PAD_XSPI1_DATA5__WAKEUPMIX_TOP_GPIO5_IO_5              0x01B0 0x03E0 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_DATA6__WAKEUPMIX_TOP_XSPI1_A_DATA_6          0x01B4 0x03E4 0x0640 0x00 0x01
+#define IMX952_PAD_XSPI1_DATA6__WAKEUPMIX_TOP_SAI5_TX_BCLK            0x01B4 0x03E4 0x05EC 0x01 0x01
+#define IMX952_PAD_XSPI1_DATA6__WAKEUPMIX_TOP_SAI5_RX_DATA_3          0x01B4 0x03E4 0x05E4 0x02 0x01
+#define IMX952_PAD_XSPI1_DATA6__NETCMIX_TOP_SAI2_RX_DATA_7            0x01B4 0x03E4 0x04A0 0x03 0x00
+#define IMX952_PAD_XSPI1_DATA6__WAKEUPMIX_TOP_XSPI_SLV_DATA_6         0x01B4 0x03E4 0x0674 0x04 0x01
+#define IMX952_PAD_XSPI1_DATA6__WAKEUPMIX_TOP_GPIO5_IO_6              0x01B4 0x03E4 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_DATA7__WAKEUPMIX_TOP_XSPI1_A_DATA_7          0x01B8 0x03E8 0x0644 0x00 0x01
+#define IMX952_PAD_XSPI1_DATA7__WAKEUPMIX_TOP_SAI5_RX_DATA_0          0x01B8 0x03E8 0x05D8 0x01 0x01
+#define IMX952_PAD_XSPI1_DATA7__WAKEUPMIX_TOP_SAI5_TX_DATA_1          0x01B8 0x03E8 0x0000 0x02 0x00
+#define IMX952_PAD_XSPI1_DATA7__WAKEUPMIX_TOP_XSPI_SLV_DATA_7         0x01B8 0x03E8 0x0678 0x04 0x01
+#define IMX952_PAD_XSPI1_DATA7__WAKEUPMIX_TOP_GPIO5_IO_7              0x01B8 0x03E8 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_DQS__WAKEUPMIX_TOP_XSPI1_A_DQS               0x01BC 0x03EC 0x0620 0x00 0x01
+#define IMX952_PAD_XSPI1_DQS__WAKEUPMIX_TOP_SAI5_RX_SYNC              0x01BC 0x03EC 0x05E8 0x01 0x01
+#define IMX952_PAD_XSPI1_DQS__WAKEUPMIX_TOP_SAI5_TX_DATA_2            0x01BC 0x03EC 0x0000 0x02 0x00
+#define IMX952_PAD_XSPI1_DQS__NETCMIX_TOP_SAI2_RX_DATA_6              0x01BC 0x03EC 0x049C 0x03 0x01
+#define IMX952_PAD_XSPI1_DQS__WAKEUPMIX_TOP_XSPI_SLV_DQS              0x01BC 0x03EC 0x0654 0x04 0x01
+#define IMX952_PAD_XSPI1_DQS__WAKEUPMIX_TOP_GPIO5_IO_8                0x01BC 0x03EC 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_SCLK__WAKEUPMIX_TOP_XSPI1_A_SCLK             0x01C0 0x03F0 0x061C 0x00 0x01
+#define IMX952_PAD_XSPI1_SCLK__NETCMIX_TOP_SAI2_RX_DATA_4             0x01C0 0x03F0 0x0000 0x01 0x00
+#define IMX952_PAD_XSPI1_SCLK__WAKEUPMIX_TOP_SAI4_RX_SYNC             0x01C0 0x03F0 0x05C8 0x02 0x01
+#define IMX952_PAD_XSPI1_SCLK__WAKEUPMIX_TOP_XSPI_SLV_CLK             0x01C0 0x03F0 0x0658 0x04 0x01
+#define IMX952_PAD_XSPI1_SCLK__WAKEUPMIX_TOP_GPIO5_IO_9               0x01C0 0x03F0 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_SS0_B__WAKEUPMIX_TOP_XSPI1_A_SS0_B           0x01C4 0x03F4 0x0648 0x00 0x01
+#define IMX952_PAD_XSPI1_SS0_B__NETCMIX_TOP_SAI2_RX_DATA_5            0x01C4 0x03F4 0x0000 0x01 0x00
+#define IMX952_PAD_XSPI1_SS0_B__WAKEUPMIX_TOP_SAI4_RX_BCLK            0x01C4 0x03F4 0x05C0 0x02 0x01
+#define IMX952_PAD_XSPI1_SS0_B__WAKEUPMIX_TOP_XSPI_SLV_CS             0x01C4 0x03F4 0x0650 0x04 0x01
+#define IMX952_PAD_XSPI1_SS0_B__WAKEUPMIX_TOP_GPIO5_IO_10             0x01C4 0x03F4 0x0000 0x05 0x00
+
+#define IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_XSPI1_A_SS1_B           0x01C8 0x03F8 0x064C 0x00 0x01
+#define IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_SAI5_RX_BCLK            0x01C8 0x03F8 0x05D4 0x01 0x01
+#define IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_SAI5_TX_DATA_3          0x01C8 0x03F8 0x0000 0x02 0x00
+#define IMX952_PAD_XSPI1_SS1_B__NETCMIX_TOP_SAI2_RX_DATA_7            0x01C8 0x03F8 0x04A0 0x03 0x01
+#define IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_GPIO5_IO_11             0x01C8 0x03F8 0x0000 0x05 0x00
+
+#define IMX952_PAD_SD2_CD_B__WAKEUPMIX_TOP_USDHC2_CD_B                0x01CC 0x03FC 0x0000 0x00 0x00
+#define IMX952_PAD_SD2_CD_B__NETCMIX_TOP_NETC_TMR_1588_TRIG1          0x01CC 0x03FC 0x0494 0x01 0x01
+#define IMX952_PAD_SD2_CD_B__WAKEUPMIX_TOP_I3C2_SCL                   0x01CC 0x03FC 0x0524 0x02 0x01
+#define IMX952_PAD_SD2_CD_B__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_0           0x01CC 0x03FC 0x04BC 0x04 0x01
+#define IMX952_PAD_SD2_CD_B__WAKEUPMIX_TOP_GPIO3_IO_0                 0x01CC 0x03FC 0x0000 0x05 0x00
+
+#define IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_USDHC2_CLK                  0x01D0 0x0400 0x0000 0x00 0x00
+#define IMX952_PAD_SD2_CLK__NETCMIX_TOP_NETC_TMR_1588_PP1             0x01D0 0x0400 0x0000 0x01 0x00
+#define IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_I3C2_SDA                    0x01D0 0x0400 0x0528 0x02 0x01
+#define IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_1            0x01D0 0x0400 0x04C0 0x04 0x01
+#define IMX952_PAD_SD2_CLK__WAKEUPMIX_TOP_GPIO3_IO_1                  0x01D0 0x0400 0x0000 0x05 0x00
+#define IMX952_PAD_SD2_CLK__CCMSRCGPCMIX_TOP_OBSERVE_0                0x01D0 0x0400 0x0000 0x06 0x00
+
+#define IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_USDHC2_CMD                  0x01D4 0x0404 0x0000 0x00 0x00
+#define IMX952_PAD_SD2_CMD__NETCMIX_TOP_NETC_TMR_1588_TRIG2           0x01D4 0x0404 0x0498 0x01 0x01
+#define IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_I3C2_PUR                    0x01D4 0x0404 0x0000 0x02 0x00
+#define IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_I3C2_PUR_B                  0x01D4 0x0404 0x0000 0x03 0x00
+#define IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_2            0x01D4 0x0404 0x04C4 0x04 0x01
+#define IMX952_PAD_SD2_CMD__WAKEUPMIX_TOP_GPIO3_IO_2                  0x01D4 0x0404 0x0000 0x05 0x00
+#define IMX952_PAD_SD2_CMD__CCMSRCGPCMIX_TOP_OBSERVE_1                0x01D4 0x0404 0x0000 0x06 0x00
+
+#define IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_USDHC2_DATA0              0x01D8 0x0408 0x0000 0x00 0x00
+#define IMX952_PAD_SD2_DATA0__NETCMIX_TOP_NETC_TMR_1588_PP2           0x01D8 0x0408 0x0000 0x01 0x00
+#define IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_CAN2_TX                   0x01D8 0x0408 0x0000 0x02 0x00
+#define IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_3          0x01D8 0x0408 0x04C8 0x04 0x01
+#define IMX952_PAD_SD2_DATA0__WAKEUPMIX_TOP_GPIO3_IO_3                0x01D8 0x0408 0x0000 0x05 0x00
+#define IMX952_PAD_SD2_DATA0__CCMSRCGPCMIX_TOP_OBSERVE_2              0x01D8 0x0408 0x0000 0x06 0x00
+
+#define IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_USDHC2_DATA1              0x01DC 0x040C 0x0000 0x00 0x00
+#define IMX952_PAD_SD2_DATA1__NETCMIX_TOP_NETC_TMR_1588_CLK           0x01DC 0x040C 0x0000 0x01 0x00
+#define IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_CAN2_RX                   0x01DC 0x040C 0x04A4 0x02 0x03
+#define IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_4          0x01DC 0x040C 0x04CC 0x04 0x01
+#define IMX952_PAD_SD2_DATA1__WAKEUPMIX_TOP_GPIO3_IO_4                0x01DC 0x040C 0x0000 0x05 0x00
+
+#define IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_USDHC2_DATA2              0x01E0 0x0410 0x0000 0x00 0x00
+#define IMX952_PAD_SD2_DATA2__NETCMIX_TOP_NETC_TMR_1588_PP3           0x01E0 0x0410 0x0000 0x01 0x00
+#define IMX952_PAD_SD2_DATA2__NETCMIX_TOP_MQS2_RIGHT                  0x01E0 0x0410 0x0000 0x02 0x00
+#define IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_5          0x01E0 0x0410 0x04D0 0x04 0x01
+#define IMX952_PAD_SD2_DATA2__WAKEUPMIX_TOP_GPIO3_IO_5                0x01E0 0x0410 0x0000 0x05 0x00
+
+#define IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_USDHC2_DATA3              0x01E4 0x0414 0x0000 0x00 0x00
+#define IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_LPTMR2_ALT0               0x01E4 0x0414 0x0574 0x01 0x01
+#define IMX952_PAD_SD2_DATA3__NETCMIX_TOP_MQS2_LEFT                   0x01E4 0x0414 0x0000 0x02 0x00
+#define IMX952_PAD_SD2_DATA3__NETCMIX_TOP_NETC_TMR_1588_ALARM1        0x01E4 0x0414 0x0000 0x03 0x00
+#define IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_6          0x01E4 0x0414 0x04D4 0x04 0x01
+#define IMX952_PAD_SD2_DATA3__WAKEUPMIX_TOP_GPIO3_IO_6                0x01E4 0x0414 0x0000 0x05 0x00
+
+#define IMX952_PAD_SD2_RESET_B__WAKEUPMIX_TOP_USDHC2_RESET_B          0x01E8 0x0418 0x0000 0x00 0x00
+#define IMX952_PAD_SD2_RESET_B__WAKEUPMIX_TOP_LPTMR2_ALT1             0x01E8 0x0418 0x0578 0x01 0x01
+#define IMX952_PAD_SD2_RESET_B__NETCMIX_TOP_NETC_TMR_1588_GCLK        0x01E8 0x0418 0x0000 0x03 0x00
+#define IMX952_PAD_SD2_RESET_B__WAKEUPMIX_TOP_FLEXIO1_FLEXIO_7        0x01E8 0x0418 0x04D8 0x04 0x01
+#define IMX952_PAD_SD2_RESET_B__WAKEUPMIX_TOP_GPIO3_IO_7              0x01E8 0x0418 0x0000 0x05 0x00
+
+#define IMX952_PAD_I2C1_SCL__AONMIX_TOP_LPI2C1_SCL                    0x01EC 0x041C 0x0000 0x00 0x00
+#define IMX952_PAD_I2C1_SCL__AONMIX_TOP_I3C1_SCL                      0x01EC 0x041C 0x0000 0x01 0x00
+#define IMX952_PAD_I2C1_SCL__AONMIX_TOP_LPUART1_DCD_B                 0x01EC 0x041C 0x0000 0x02 0x00
+#define IMX952_PAD_I2C1_SCL__AONMIX_TOP_TPM2_CH0                      0x01EC 0x041C 0x0000 0x03 0x00
+#define IMX952_PAD_I2C1_SCL__VPUMIX_TOP_UART_RX                       0x01EC 0x041C 0x0000 0x04 0x00
+#define IMX952_PAD_I2C1_SCL__AONMIX_TOP_GPIO1_IO_0                    0x01EC 0x041C 0x0000 0x05 0x00
+
+#define IMX952_PAD_I2C1_SDA__AONMIX_TOP_LPI2C1_SDA                    0x01F0 0x0420 0x0000 0x00 0x00
+#define IMX952_PAD_I2C1_SDA__AONMIX_TOP_I3C1_SDA                      0x01F0 0x0420 0x0000 0x01 0x00
+#define IMX952_PAD_I2C1_SDA__AONMIX_TOP_LPUART1_RIN_B                 0x01F0 0x0420 0x0000 0x02 0x00
+#define IMX952_PAD_I2C1_SDA__AONMIX_TOP_TPM2_CH1                      0x01F0 0x0420 0x0000 0x03 0x00
+#define IMX952_PAD_I2C1_SDA__VPUMIX_TOP_UART_TX                       0x01F0 0x0420 0x0000 0x04 0x00
+#define IMX952_PAD_I2C1_SDA__AONMIX_TOP_GPIO1_IO_1                    0x01F0 0x0420 0x0000 0x05 0x00
+
+#define IMX952_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL                    0x01F4 0x0424 0x0000 0x00 0x00
+#define IMX952_PAD_I2C2_SCL__AONMIX_TOP_I3C1_PUR                      0x01F4 0x0424 0x0000 0x01 0x00
+#define IMX952_PAD_I2C2_SCL__AONMIX_TOP_LPUART2_DCD_B                 0x01F4 0x0424 0x0000 0x02 0x00
+#define IMX952_PAD_I2C2_SCL__AONMIX_TOP_TPM2_CH2                      0x01F4 0x0424 0x0000 0x03 0x00
+#define IMX952_PAD_I2C2_SCL__AONMIX_TOP_SAI1_RX_SYNC                  0x01F4 0x0424 0x0000 0x04 0x00
+#define IMX952_PAD_I2C2_SCL__AONMIX_TOP_GPIO1_IO_2                    0x01F4 0x0424 0x0000 0x05 0x00
+#define IMX952_PAD_I2C2_SCL__AONMIX_TOP_I3C1_PUR_B                    0x01F4 0x0424 0x0000 0x06 0x00
+
+#define IMX952_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA                    0x01F8 0x0428 0x0000 0x00 0x00
+#define IMX952_PAD_I2C2_SDA__AONMIX_TOP_LPUART2_RIN_B                 0x01F8 0x0428 0x0000 0x02 0x00
+#define IMX952_PAD_I2C2_SDA__AONMIX_TOP_TPM2_CH3                      0x01F8 0x0428 0x0000 0x03 0x00
+#define IMX952_PAD_I2C2_SDA__AONMIX_TOP_SAI1_RX_BCLK                  0x01F8 0x0428 0x0000 0x04 0x00
+#define IMX952_PAD_I2C2_SDA__AONMIX_TOP_GPIO1_IO_3                    0x01F8 0x0428 0x0000 0x05 0x00
+
+#define IMX952_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX                   0x01FC 0x042C 0x0000 0x00 0x00
+#define IMX952_PAD_UART1_RXD__AONMIX_TOP_UART_CSSI_RX                 0x01FC 0x042C 0x0000 0x01 0x00
+#define IMX952_PAD_UART1_RXD__AONMIX_TOP_LPSPI2_SIN                   0x01FC 0x042C 0x0000 0x02 0x00
+#define IMX952_PAD_UART1_RXD__AONMIX_TOP_TPM1_CH0                     0x01FC 0x042C 0x0000 0x03 0x00
+#define IMX952_PAD_UART1_RXD__AONMIX_TOP_GPIO1_IO_4                   0x01FC 0x042C 0x0000 0x05 0x00
+
+#define IMX952_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX                   0x0200 0x0430 0x0000 0x00 0x00
+#define IMX952_PAD_UART1_TXD__AONMIX_TOP_UART_CSSI_TX                 0x0200 0x0430 0x0000 0x01 0x00
+#define IMX952_PAD_UART1_TXD__AONMIX_TOP_LPSPI2_PCS0                  0x0200 0x0430 0x0000 0x02 0x00
+#define IMX952_PAD_UART1_TXD__AONMIX_TOP_TPM1_CH1                     0x0200 0x0430 0x0000 0x03 0x00
+#define IMX952_PAD_UART1_TXD__AONMIX_TOP_GPIO1_IO_5                   0x0200 0x0430 0x0000 0x05 0x00
+
+#define IMX952_PAD_UART2_RXD__AONMIX_TOP_LPUART2_RX                   0x0204 0x0434 0x0000 0x00 0x00
+#define IMX952_PAD_UART2_RXD__AONMIX_TOP_LPUART1_CTS_B                0x0204 0x0434 0x0000 0x01 0x00
+#define IMX952_PAD_UART2_RXD__AONMIX_TOP_LPSPI2_SOUT                  0x0204 0x0434 0x0000 0x02 0x00
+#define IMX952_PAD_UART2_RXD__AONMIX_TOP_TPM1_CH2                     0x0204 0x0434 0x0000 0x03 0x00
+#define IMX952_PAD_UART2_RXD__AONMIX_TOP_SAI1_MCLK                    0x0204 0x0434 0x0474 0x04 0x00
+#define IMX952_PAD_UART2_RXD__AONMIX_TOP_GPIO1_IO_6                   0x0204 0x0434 0x0000 0x05 0x00
+
+#define IMX952_PAD_UART2_TXD__AONMIX_TOP_LPUART2_TX                   0x0208 0x0438 0x0000 0x00 0x00
+#define IMX952_PAD_UART2_TXD__AONMIX_TOP_LPUART1_RTS_B                0x0208 0x0438 0x0000 0x01 0x00
+#define IMX952_PAD_UART2_TXD__AONMIX_TOP_LPSPI2_SCK                   0x0208 0x0438 0x0000 0x02 0x00
+#define IMX952_PAD_UART2_TXD__AONMIX_TOP_TPM1_CH3                     0x0208 0x0438 0x0000 0x03 0x00
+#define IMX952_PAD_UART2_TXD__AONMIX_TOP_GPIO1_IO_7                   0x0208 0x0438 0x0000 0x05 0x00
+
+#define IMX952_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK                        0x020C 0x043C 0x0000 0x00 0x00
+#define IMX952_PAD_PDM_CLK__AONMIX_TOP_MQS1_LEFT                      0x020C 0x043C 0x0000 0x01 0x00
+#define IMX952_PAD_PDM_CLK__AONMIX_TOP_LPTMR1_ALT0                    0x020C 0x043C 0x0000 0x04 0x00
+#define IMX952_PAD_PDM_CLK__AONMIX_TOP_GPIO1_IO_8                     0x020C 0x043C 0x0000 0x05 0x00
+#define IMX952_PAD_PDM_CLK__AONMIX_TOP_CAN1_TX                        0x020C 0x043C 0x0000 0x06 0x00
+
+#define IMX952_PAD_PDM_BIT_STREAM0__AONMIX_TOP_PDM_BIT_STREAM_0       0x0210 0x0440 0x0464 0x00 0x00
+#define IMX952_PAD_PDM_BIT_STREAM0__AONMIX_TOP_MQS1_RIGHT             0x0210 0x0440 0x0000 0x01 0x00
+#define IMX952_PAD_PDM_BIT_STREAM0__AONMIX_TOP_LPSPI1_PCS1            0x0210 0x0440 0x0000 0x02 0x00
+#define IMX952_PAD_PDM_BIT_STREAM0__AONMIX_TOP_TPM1_EXTCLK            0x0210 0x0440 0x0000 0x03 0x00
+#define IMX952_PAD_PDM_BIT_STREAM0__AONMIX_TOP_LPTMR1_ALT1            0x0210 0x0440 0x0000 0x04 0x00
+#define IMX952_PAD_PDM_BIT_STREAM0__AONMIX_TOP_GPIO1_IO_9             0x0210 0x0440 0x0000 0x05 0x00
+#define IMX952_PAD_PDM_BIT_STREAM0__AONMIX_TOP_CAN1_RX                0x0210 0x0440 0x0460 0x06 0x00
+
+#define IMX952_PAD_PDM_BIT_STREAM1__AONMIX_TOP_PDM_BIT_STREAM_1       0x0214 0x0444 0x0468 0x00 0x00
+#define IMX952_PAD_PDM_BIT_STREAM1__AONMIX_TOP_NMI                    0x0214 0x0444 0x0000 0x01 0x00
+#define IMX952_PAD_PDM_BIT_STREAM1__AONMIX_TOP_LPSPI2_PCS1            0x0214 0x0444 0x0000 0x02 0x00
+#define IMX952_PAD_PDM_BIT_STREAM1__AONMIX_TOP_TPM2_EXTCLK            0x0214 0x0444 0x0000 0x03 0x00
+#define IMX952_PAD_PDM_BIT_STREAM1__AONMIX_TOP_LPTMR1_ALT2            0x0214 0x0444 0x0000 0x04 0x00
+#define IMX952_PAD_PDM_BIT_STREAM1__AONMIX_TOP_GPIO1_IO_10            0x0214 0x0444 0x0000 0x05 0x00
+#define IMX952_PAD_PDM_BIT_STREAM1__CCMSRCGPCMIX_TOP_EXT_CLK1         0x0214 0x0444 0x0478 0x06 0x00
+
+#define IMX952_PAD_SAI1_TXFS__AONMIX_TOP_SAI1_TX_SYNC                 0x0218 0x0448 0x0000 0x00 0x00
+#define IMX952_PAD_SAI1_TXFS__AONMIX_TOP_SAI1_TX_DATA_1               0x0218 0x0448 0x0000 0x01 0x00
+#define IMX952_PAD_SAI1_TXFS__AONMIX_TOP_LPSPI1_PCS0                  0x0218 0x0448 0x0000 0x02 0x00
+#define IMX952_PAD_SAI1_TXFS__AONMIX_TOP_LPUART2_DTR_B                0x0218 0x0448 0x0000 0x03 0x00
+#define IMX952_PAD_SAI1_TXFS__AONMIX_TOP_MQS1_LEFT                    0x0218 0x0448 0x0000 0x04 0x00
+#define IMX952_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_11                  0x0218 0x0448 0x0000 0x05 0x00
+
+#define IMX952_PAD_SAI1_TXC__AONMIX_TOP_SAI1_TX_BCLK                  0x021C 0x044C 0x0000 0x00 0x00
+#define IMX952_PAD_SAI1_TXC__AONMIX_TOP_LPUART2_CTS_B                 0x021C 0x044C 0x0000 0x01 0x00
+#define IMX952_PAD_SAI1_TXC__AONMIX_TOP_LPSPI1_SIN                    0x021C 0x044C 0x0000 0x02 0x00
+#define IMX952_PAD_SAI1_TXC__AONMIX_TOP_LPUART1_DSR_B                 0x021C 0x044C 0x0000 0x03 0x00
+#define IMX952_PAD_SAI1_TXC__AONMIX_TOP_CAN1_RX                       0x021C 0x044C 0x0460 0x04 0x01
+#define IMX952_PAD_SAI1_TXC__AONMIX_TOP_GPIO1_IO_12                   0x021C 0x044C 0x0000 0x05 0x00
+
+#define IMX952_PAD_SAI1_TXD0__AONMIX_TOP_SAI1_TX_DATA_0               0x0220 0x0450 0x0000 0x00 0x00
+#define IMX952_PAD_SAI1_TXD0__AONMIX_TOP_LPUART2_RTS_B                0x0220 0x0450 0x0000 0x01 0x00
+#define IMX952_PAD_SAI1_TXD0__AONMIX_TOP_LPSPI1_SCK                   0x0220 0x0450 0x0000 0x02 0x00
+#define IMX952_PAD_SAI1_TXD0__AONMIX_TOP_LPUART1_DTR_B                0x0220 0x0450 0x0000 0x03 0x00
+#define IMX952_PAD_SAI1_TXD0__AONMIX_TOP_CAN1_TX                      0x0220 0x0450 0x0000 0x04 0x00
+#define IMX952_PAD_SAI1_TXD0__AONMIX_TOP_GPIO1_IO_13                  0x0220 0x0450 0x0000 0x05 0x00
+
+#define IMX952_PAD_SAI1_RXD0__AONMIX_TOP_SAI1_RX_DATA_0               0x0224 0x0454 0x0000 0x00 0x00
+#define IMX952_PAD_SAI1_RXD0__AONMIX_TOP_SAI1_MCLK                    0x0224 0x0454 0x0474 0x01 0x01
+#define IMX952_PAD_SAI1_RXD0__AONMIX_TOP_LPSPI1_SOUT                  0x0224 0x0454 0x0000 0x02 0x00
+#define IMX952_PAD_SAI1_RXD0__AONMIX_TOP_LPUART2_DSR_B                0x0224 0x0454 0x0000 0x03 0x00
+#define IMX952_PAD_SAI1_RXD0__AONMIX_TOP_MQS1_RIGHT                   0x0224 0x0454 0x0000 0x04 0x00
+#define IMX952_PAD_SAI1_RXD0__AONMIX_TOP_GPIO1_IO_14                  0x0224 0x0454 0x0000 0x05 0x00
+
+#define IMX952_PAD_WDOG_ANY__AONMIX_TOP_WDOG_ANY                      0x0228 0x0458 0x0000 0x00 0x00
+#define IMX952_PAD_WDOG_ANY__AONMIX_TOP_FCCU_EOUT1                    0x0228 0x0458 0x0000 0x01 0x00
+#define IMX952_PAD_WDOG_ANY__AONMIX_TOP_GPIO1_IO_15                   0x0228 0x0458 0x0000 0x05 0x00
+#endif /* __DTS_IMX952_PINFUNC_H__ */
diff --git a/dts/upstream/src/arm64/freescale/imx952-power.h b/dts/upstream/src/arm64/freescale/imx952-power.h
new file mode 100644
index 00000000000..1d0fb8c93e2
--- /dev/null
+++ b/dts/upstream/src/arm64/freescale/imx952-power.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ *  Copyright 2025 NXP
+ */
+
+#ifndef __IMX952_POWER_H__
+#define __IMX952_POWER_H__
+
+#define IMX952_PD_ANA		0
+#define IMX952_PD_AON		1
+#define IMX952_PD_BBSM		2
+#define IMX952_PD_CAMERA	3
+#define IMX952_PD_CCMSRCGPC	4
+#define IMX952_PD_A55C0		5
+#define IMX952_PD_A55C1		6
+#define IMX952_PD_A55C2		7
+#define IMX952_PD_A55C3		8
+#define IMX952_PD_A55P		9
+#define IMX952_PD_DDR		10
+#define IMX952_PD_DISPLAY	11
+#define IMX952_PD_GPU		12
+#define IMX952_PD_HSIO_TOP	13
+#define IMX952_PD_HSIO_WAON	14
+#define IMX952_PD_M7		15
+#define IMX952_PD_NETC		16
+#define IMX952_PD_NOC		17
+#define IMX952_PD_NPU		18
+#define IMX952_PD_VPU		19
+#define IMX952_PD_WAKEUP	20
+
+#define IMX952_PERF_M33		0
+#define IMX952_PERF_WAKEUP	1
+#define IMX952_PERF_M7		2
+#define IMX952_PERF_DRAM	3
+#define IMX952_PERF_HSIO	4
+#define IMX952_PERF_NPU		5
+#define IMX952_PERF_NOC		6
+#define IMX952_PERF_A55		7
+#define IMX952_PERF_GPU		8
+#define IMX952_PERF_VPU		9
+#define IMX952_PERF_CAM		10
+#define IMX952_PERF_DISP	11
+
+#endif
diff --git a/dts/upstream/src/arm64/freescale/imx952.dtsi b/dts/upstream/src/arm64/freescale/imx952.dtsi
new file mode 100644
index 00000000000..91fe4916ac0
--- /dev/null
+++ b/dts/upstream/src/arm64/freescale/imx952.dtsi
@@ -0,0 +1,1266 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#include <dt-bindings/dma/fsl-edma.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#include "imx952-clock.h"
+#include "imx952-pinfunc.h"
+#include "imx952-power.h"
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clk_ext1: clock-ext1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <133000000>;
+		clock-output-names = "clk_ext1";
+	};
+
+	clk_dummy: clock-dummy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "dummy";
+	};
+
+	clk_ldb_pll_pixel: clock-ldb-pll-div7 {
+		compatible = "fixed-factor-clock";
+		clocks = <&scmi_clk IMX952_CLK_LDBPLL>;
+		#clock-cells = <0>;
+		clock-div = <7>;
+		clock-mult = <1>;
+		clock-output-names = "ldb_pll_div7";
+	};
+
+	clk_osc_24m: clock-osc-24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "osc_24m";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_pd_wait: cpu-pd-wait {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010033>;
+				local-timer-stop;
+				entry-latency-us = <1000>;
+				exit-latency-us = <700>;
+				min-residency-us = <2700>;
+				wakeup-latency-us = <1500>;
+			};
+		};
+
+		A55_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0>;
+			enable-method = "psci";
+			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
+			power-domains = <&scmi_perf IMX952_PERF_A55>;
+			power-domain-names = "perf";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l0>;
+		};
+
+		A55_1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
+			power-domains = <&scmi_perf IMX952_PERF_A55>;
+			power-domain-names = "perf";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l1>;
+		};
+
+		A55_2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
+			power-domains = <&scmi_perf IMX952_PERF_A55>;
+			power-domain-names = "perf";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l2>;
+		};
+
+		A55_3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
+			power-domains = <&scmi_perf IMX952_PERF_A55>;
+			power-domain-names = "perf";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l3>;
+		};
+
+		l2_cache_l0: l2-cache-l0 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l1: l2-cache-l1 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l2: l2-cache-l2 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l3: l2-cache-l3 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l3_cache: l3-cache {
+			compatible = "cache";
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-level = <3>;
+			cache-unified;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&A55_0>;
+				};
+
+				core1 {
+					cpu = <&A55_1>;
+				};
+
+				core2 {
+					cpu = <&A55_2>;
+				};
+
+				core3 {
+					cpu = <&A55_3>;
+				};
+			};
+		};
+	};
+
+	firmware {
+		scmi {
+			compatible = "arm,scmi";
+			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>, <&mu2 5 1>;
+			shmem = <&scmi_buf0>, <&scmi_buf1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			arm,max-rx-timeout-ms = <5000>;
+
+			scmi_devpd: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_sys_power: protocol@12 {
+				reg = <0x12>;
+			};
+
+			scmi_perf: protocol@13 {
+				reg = <0x13>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi_sensor: protocol@15 {
+				reg = <0x15>;
+				#thermal-sensor-cells = <1>;
+			};
+
+			scmi_iomuxc: protocol@19 {
+				reg = <0x19>;
+			};
+
+			scmi_lmm: protocol@80 {
+				reg = <0x80>;
+			};
+
+			scmi_bbm: protocol@81 {
+				reg = <0x81>;
+			};
+
+			scmi_cpu: protocol@82 {
+				reg = <0x82>;
+			};
+
+			scmi_misc: protocol@84 {
+				reg = <0x84>;
+			};
+		};
+	};
+
+	gic: interrupt-controller@48000000 {
+		compatible = "arm,gic-v3";
+		reg = <0 0x48000000 0 0x10000>,
+		      <0 0x48060000 0 0xc0000>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		dma-noncoherent;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		its: msi-controller@48040000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0 0x48040000 0 0x20000>;
+			msi-controller;
+			#msi-cells = <1>;
+			dma-noncoherent;
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <24000000>;
+		arm,no-tick-in-suspend;
+		interrupt-parent = <&gic>;
+	};
+
+	usbphynop1: usbphynop1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		clocks = <&clk_dummy>;
+		clock-names = "main_clk";
+	};
+
+	usbphynop2: usbphynop2 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		clocks = <&clk_dummy>;
+		clock-names = "main_clk";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0x0 0x0 0x80000000>,
+			 <0x0 0x28000000 0x0 0x28000000 0x0 0x10000000>;
+
+		aips2: bus@42000000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x0 0x42000000 0x0 0x800000>;
+			ranges = <0x42000000 0x0 0x42000000 0x8000000>,
+				 <0x28000000 0x0 0x28000000 0x10000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			mu7: mailbox@42050000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x42050000 0x10000>;
+				interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			wdog3: watchdog@420b0000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x420b0000 0x10000>;
+				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
+			tpm3: pwm@42100000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x42100000 0x1000>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			tpm4: pwm@42110000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x42110000 0x1000>;
+				clocks = <&scmi_clk IMX952_CLK_TPM4>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			tpm5: pwm@42120000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x42120000 0x1000>;
+				clocks = <&scmi_clk IMX952_CLK_TPM5>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			tpm6: pwm@42130000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x42130000 0x1000>;
+				clocks = <&scmi_clk IMX952_CLK_TPM6>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			i3c2: i3c@42140000 {
+				compatible = "silvaco,i3c-master-v1";
+				reg = <0x42140000 0x10000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <3>;
+				#size-cells = <0>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX952_CLK_I3C2SLOW>,
+					 <&clk_dummy>;
+				clock-names = "pclk", "fast_clk", "slow_clk";
+				status = "disabled";
+			};
+
+			lpi2c3: i2c@42150000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x42150000 0x10000>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPI2C3>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&edma2 8 0 0>, <&edma2 9 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpi2c4: i2c@42160000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x42160000 0x10000>;
+				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPI2C4>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&edma2 10 0 0>, <&edma2 11 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpspi3: spi@42170000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42170000 0x10000>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPSPI3>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				dmas = <&edma2 12 0 0>, <&edma2 13 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpspi4: spi@42180000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42180000 0x10000>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPSPI4>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				dmas = <&edma2 14 0 0>, <&edma2 15 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpuart3: serial@42190000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x42190000 0x1000>;
+				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPUART3>;
+				clock-names = "ipg";
+				dmas = <&edma2 18 0 FSL_EDMA_RX>, <&edma2 17 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			lpuart4: serial@421a0000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x421a0000 0x1000>;
+				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPUART4>;
+				clock-names = "ipg";
+				dmas = <&edma2 20 0 FSL_EDMA_RX>, <&edma2 19 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			lpuart5: serial@421b0000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x421b0000 0x1000>;
+				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPUART5>;
+				clock-names = "ipg";
+				dmas = <&edma2 22 0 FSL_EDMA_RX>, <&edma2 21 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			lpuart6: serial@421c0000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x421c0000 0x1000>;
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPUART6>;
+				clock-names = "ipg";
+				dmas = <&edma2 24 0 FSL_EDMA_RX>, <&edma2 23 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			flexcan2: can@421d0000 {
+				compatible = "fsl,imx95-flexcan";
+				reg = <0x421d0000 0x10000>;
+				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX952_CLK_CAN2>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&scmi_clk IMX952_CLK_CAN2>;
+				assigned-clock-parents = <&scmi_clk IMX952_CLK_SYSPLL1_PFD1_DIV2>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source = /bits/ 8 <0>;
+				status = "disabled";
+			};
+
+			flexcan3: can@42220000 {
+				compatible = "fsl,imx95-flexcan";
+				reg = <0x42220000 0x10000>;
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX952_CLK_CAN3>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&scmi_clk IMX952_CLK_CAN3>;
+				assigned-clock-parents = <&scmi_clk IMX952_CLK_SYSPLL1_PFD1_DIV2>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source = /bits/ 8 <0>;
+				status = "disabled";
+			};
+
+			lpuart7: serial@422b0000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x422b0000 0x1000>;
+				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPUART7>;
+				clock-names = "ipg";
+				dmas = <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			lpuart8: serial@422c0000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x422c0000 0x1000>;
+				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPUART8>;
+				clock-names = "ipg";
+				dmas = <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			lpi2c5: i2c@422d0000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x422d0000 0x10000>;
+				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPI2C5>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&edma2 71 0 0>, <&edma2 72 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpi2c6: i2c@422e0000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x422e0000 0x10000>;
+				interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPI2C6>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&edma2 73 0 0>, <&edma2 74 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpi2c7: i2c@422f0000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x422f0000 0x10000>;
+				interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPI2C7>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&edma2 75 0 0>, <&edma2 76 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpi2c8: i2c@42300000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x42300000 0x10000>;
+				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPI2C8>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&edma2 77 0 0>, <&edma2 78 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpspi5: spi@42310000 {
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42310000 0x10000>;
+				interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&scmi_clk IMX952_CLK_LPSPI5>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				dmas = <&edma2 79 0 0>, <&edma2 80 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpspi6: spi@42320000 {
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42320000 0x10000>;
+				interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&scmi_clk IMX952_CLK_LPSPI6>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				dmas = <&edma2 81 0 0>, <&edma2 82 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpspi7: spi@42330000 {
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42330000 0x10000>;
+				interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&scmi_clk IMX952_CLK_LPSPI7>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				dmas = <&edma2 83 0 0>, <&edma2 84 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpspi8: spi@42340000 {
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42340000 0x10000>;
+				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&scmi_clk IMX952_CLK_LPSPI8>,
+					 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				dmas = <&edma2 85 0 0>, <&edma2 86 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			mu8: mailbox@42350000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x42350000 0x10000>;
+				interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+		};
+
+		aips3: bus@42800000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0 0x42800000 0 0x800000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x42800000 0x0 0x42800000 0x800000>;
+
+			edma2: dma-controller@42800000 {
+				compatible = "fsl,imx95-edma5";
+				reg = <0x42800000 0x210000>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+				clock-names = "dma";
+				#dma-cells = <3>;
+				dma-channels = <64>;
+				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; //error irq
+			};
+
+			usdhc1: mmc@42c20000 {
+				compatible = "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
+				reg = <0x42c20000 0x10000>;
+				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX952_CLK_WAKEUPAXI>,
+					 <&scmi_clk IMX952_CLK_USDHC1>;
+				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&scmi_clk IMX952_CLK_USDHC1>;
+				assigned-clock-parents = <&scmi_clk IMX952_CLK_SYSPLL1_PFD1>;
+				assigned-clock-rates = <400000000>;
+				bus-width = <8>;
+				fsl,tuning-start-tap = <1>;
+				fsl,tuning-step= <2>;
+				status = "disabled";
+			};
+
+			usdhc2: mmc@42c30000 {
+				compatible = "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
+				reg = <0x42c30000 0x10000>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX952_CLK_WAKEUPAXI>,
+					 <&scmi_clk IMX952_CLK_USDHC2>;
+				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&scmi_clk IMX952_CLK_USDHC2>;
+				assigned-clock-parents = <&scmi_clk IMX952_CLK_SYSPLL1_PFD1>;
+				assigned-clock-rates = <200000000>;
+				bus-width = <4>;
+				fsl,tuning-start-tap = <1>;
+				fsl,tuning-step= <2>;
+				status = "disabled";
+			};
+
+			usdhc3: mmc@42c40000 {
+				compatible = "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
+				reg = <0x42c40000 0x10000>;
+				interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX952_CLK_WAKEUPAXI>,
+					 <&scmi_clk IMX952_CLK_USDHC3>;
+				clock-names = "ipg", "ahb", "per";
+				bus-width = <4>;
+				fsl,tuning-start-tap = <1>;
+				fsl,tuning-step = <2>;
+				status = "disabled";
+			};
+		};
+
+		gpio2: gpio@43810000 {
+			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x0 0x43810000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>,
+				 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+			clock-names = "gpio", "port";
+			gpio-ranges = <&scmi_iomuxc 0 4 32>;
+			ngpios = <32>;
+		};
+
+		gpio3: gpio@43820000 {
+			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x0 0x43820000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>,
+				 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+			clock-names = "gpio", "port";
+			gpio-ranges = <&scmi_iomuxc 0 115 8>, <&scmi_iomuxc 8 85 18>,
+				      <&scmi_iomuxc 26 53 2>, <&scmi_iomuxc 28 0 4>;
+			ngpios = <32>;
+		};
+
+		gpio4: gpio@43840000 {
+			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x0 0x43840000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>,
+				 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+			clock-names = "gpio", "port";
+			gpio-ranges = <&scmi_iomuxc 0 57 28>, <&scmi_iomuxc 28 55 2>;
+			ngpios = <30>;
+		};
+
+		gpio5: gpio@43850000 {
+			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x0 0x43850000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>,
+				 <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+			clock-names = "gpio", "port";
+			gpio-ranges = <&scmi_iomuxc 0 103 12>, <&scmi_iomuxc 12 36 6>;
+			ngpios = <18>;
+		};
+
+		aips1: bus@44000000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x0 0x44000000 0x0 0x800000>;
+			ranges = <0x44000000 0x0 0x44000000 0x800000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			edma1: dma-controller@44000000 {
+				compatible = "fsl,imx93-edma3";
+				reg = <0x44000000 0x210000>;
+				clocks = <&scmi_clk IMX952_CLK_BUSAON>;
+				clock-names = "dma";
+				#dma-cells = <3>;
+				dma-channels = <32>;
+				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>; //error irq
+			};
+
+			mu1: mailbox@44220000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x44220000 0x10000>;
+				interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSAON>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			system_counter: timer@44290000 {
+				compatible = "nxp,imx95-sysctr-timer";
+				reg = <0x44290000 0x30000>;
+				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_osc_24m>;
+				clock-names = "per";
+				nxp,no-divider;
+			};
+
+			i3c1: i3c@44330000 {
+				compatible = "silvaco,i3c-master-v1";
+				reg = <0x44330000 0x10000>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <3>;
+				#size-cells = <0>;
+				clocks = <&scmi_clk IMX952_CLK_BUSAON>,
+					 <&scmi_clk IMX952_CLK_I3C1SLOW>,
+					 <&clk_dummy>;
+				clock-names = "pclk", "fast_clk", "slow_clk";
+				status = "disabled";
+			};
+
+			lpi2c1: i2c@44340000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x44340000 0x10000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPI2C1>,
+					 <&scmi_clk IMX952_CLK_BUSAON>;
+				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&edma1 12 0 0>, <&edma1 13 0 FSL_EDMA_RX> ;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpi2c2: i2c@44350000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x44350000 0x10000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPI2C2>,
+					 <&scmi_clk IMX952_CLK_BUSAON>;
+				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&edma1 14 0 0>, <&edma1 15 0 FSL_EDMA_RX> ;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpspi1: spi@44360000 {
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x44360000 0x10000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPSPI1>,
+					 <&scmi_clk IMX952_CLK_BUSAON>;
+				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&edma1 16 0 FSL_EDMA_RX>, <&edma1 17 0 0> ;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpspi2: spi@44370000 {
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x44370000 0x10000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPSPI2>,
+					 <&scmi_clk IMX952_CLK_BUSAON>;
+				clock-names = "per", "ipg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&edma1 18 0 FSL_EDMA_RX>, <&edma1 19 0 0> ;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			lpuart1: serial@44380000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x44380000 0x1000>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPUART1>;
+				clock-names = "ipg";
+				dmas = <&edma1 21 0 FSL_EDMA_RX>, <&edma1 20 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			lpuart2: serial@44390000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x44390000 0x1000>;
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_LPUART2>;
+				clock-names = "ipg";
+				dmas = <&edma1 23 0 FSL_EDMA_RX>, <&edma1 22 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			flexcan1: can@443a0000 {
+				compatible = "fsl,imx95-flexcan";
+				reg = <0x443a0000 0x10000>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSAON>,
+					 <&scmi_clk IMX952_CLK_CAN1>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&scmi_clk IMX952_CLK_CAN1>;
+				assigned-clock-parents = <&scmi_clk IMX952_CLK_SYSPLL1_PFD1_DIV2>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source = /bits/ 8 <0>;
+				status = "disabled";
+			};
+
+			adc1: adc@44530000 {
+				compatible = "nxp,imx93-adc";
+				reg = <0x44530000 0x10000>;
+				interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_ADC>;
+				clock-names = "ipg";
+				#io-channel-cells = <1>;
+				status = "disabled";
+			};
+
+			mu2: mailbox@445b0000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x445b0000 0x1000>;
+				ranges;
+				interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				#mbox-cells = <2>;
+
+				sram0: sram@445b1000 {
+					compatible = "mmio-sram";
+					reg = <0x445b1000 0x400>;
+					ranges = <0x0 0x445b1000 0x400>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					scmi_buf0: scmi-sram-section@0 {
+						compatible = "arm,scmi-shmem";
+						reg = <0x0 0x80>;
+					};
+
+					scmi_buf1: scmi-sram-section@80 {
+						compatible = "arm,scmi-shmem";
+						reg = <0x80 0x80>;
+					};
+				};
+
+			};
+
+			mu3: mailbox@445d0000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x445d0000 0x10000>;
+				interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSAON>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			mu4: mailbox@445f0000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x445f0000 0x10000>;
+				interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSAON>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			mu5: mailbox@44610000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x44610000 0x10000>;
+				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSAON>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			mu6: mailbox@44630000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x44630000 0x10000>;
+				interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX952_CLK_BUSAON>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+		};
+
+		v2x_mu0: mailbox@47300000 {
+			compatible = "fsl,imx95-mu-v2x";
+			reg = <0x0 0x47300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		v2x_mu2: mailbox@47320000 {
+			compatible = "fsl,imx95-mu-v2x";
+			reg = <0x0 0x47320000 0x0 0x10000>;
+			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		v2x_mu3: mailbox@47330000 {
+			compatible = "fsl,imx95-mu-v2x";
+			reg = <0x0 0x47330000 0x0 0x10000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		v2x_mu4: mailbox@47340000 {
+			compatible = "fsl,imx95-mu-v2x";
+			reg = <0x0 0x47340000 0x0 0x10000>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		v2x_mu: mailbox@47350000 {
+			compatible = "fsl,imx95-mu-v2x";
+			reg = <0x0 0x47350000 0x0 0x10000>;
+			interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		/* GPIO1 is under exclusive control of System Manager */
+		gpio1: gpio@47400000 {
+			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x0 0x47400000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&scmi_clk IMX952_CLK_M33>,
+				 <&scmi_clk IMX952_CLK_M33>;
+			clock-names = "gpio", "port";
+			gpio-ranges = <&scmi_iomuxc 0 123 16>;
+			ngpios = <16>;
+			status = "disabled";
+		};
+
+		elemu0: mailbox@47520000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47520000 0x0 0x10000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "disabled";
+		};
+
+		elemu1: mailbox@47530000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47530000 0x0 0x10000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "disabled";
+		};
+
+		elemu2: mailbox@47540000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47540000 0x0 0x10000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "disabled";
+		};
+
+		elemu3: mailbox@47550000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47550000 0x0 0x10000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		elemu4: mailbox@47560000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47560000 0x0 0x10000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "disabled";
+		};
+
+		elemu5: mailbox@47570000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47570000 0x0 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "disabled";
+		};
+
+		usb1: usb@4c100000 {
+			compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+			reg = <0x0 0x4c100000 0x0 0x200>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX952_CLK_CGC_HSIOUSB>,
+				 <&scmi_clk IMX952_CLK_OSC32K>;
+			clock-names = "usb_ctrl_root", "usb_wakeup";
+			power-domains = <&scmi_devpd IMX952_PD_HSIO_TOP>;
+			phys = <&usbphynop1>;
+			fsl,usbmisc = <&usbmisc1 0>;
+			status = "disabled";
+		};
+
+		usbmisc1: usbmisc@4c100200 {
+			compatible = "fsl,imx95-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+			#index-cells = <1>;
+			reg = <0x0 0x4c100200 0x0 0x200>,
+			      <0x0 0x4c010010 0x0 0x4>;
+		};
+
+		usb2: usb@4c200000 {
+			compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+			reg = <0x0 0x4c200000 0x0 0x200>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX952_CLK_CGC_HSIOUSB>,
+				 <&scmi_clk IMX952_CLK_OSC32K>;
+			clock-names = "usb_ctrl_root", "usb_wakeup";
+			power-domains = <&scmi_devpd IMX952_PD_HSIO_TOP>;
+			phys = <&usbphynop2>;
+			fsl,usbmisc = <&usbmisc2 0>;
+			status = "disabled";
+		};
+
+		usbmisc2: usbmisc@4c200200 {
+			compatible = "fsl,imx95-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+			#index-cells = <1>;
+			reg = <0x0 0x4c200200 0x0 0x200>,
+			      <0x0 0x4c010014 0x0 0x4>;
+		};
+	};
+};

-- 
2.43.0

