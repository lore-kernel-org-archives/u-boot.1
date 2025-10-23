Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E57CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C7F883631;
	Thu, 23 Oct 2025 09:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="olberxUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A19C7832BC; Thu, 23 Oct 2025 09:34:07 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BB982E34
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOqwxCvM0DX+V/6+kWz6XFdyyaAg8eWl373s+wgKy60bD8ZrhappwzR2vozGIqrAjBn5f087fId81FXkfpTeb8+joOhGBjSjJPMQuo6AWowRCVTqbrDXiBxuw1GUiqtfrcNAOKn3MuFbpiaFhz80gufSBn9c49zsjFNTHyFMFc3Tky88Y7FTmWdEBOk3UZeeByiL1mCDkHcQ+uozKNKuUzeS+DpNM+VJHXfeuRDSXvreUYqnayMILvSrS31WMP26jBowCtVMCT+8w8KTQJ4pslrXVCTmqtXmcSclCIMTSYzO4nOHFtuzR/U8tmE4OpwTfi6qO9zHsxEvegoKZCeMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtQPci6lYpAfAFi2g51LYQ6kxD0eeoEPqTIyNQAKka0=;
 b=t0WB+V6UMYI8dRF+xjqalt9EMTOJFtHS+okqCb/9V0SF/nQxwD16bsgQ2vYtQbV5l2kmfcfkApf4vPkZxKbuYsrMN+Pr+R4NIzIA1kfBvYhnD5umQQ9H1UOkEDfv+78V4iT7BuyxOV0bvixnBv0M0G8jSX/CwTCgmVlMO1FYlmsaVImsOvkZi5O921ds0x954Y3sT0PKuCkafqeG+/Iv3H8rXK6hjRjUxSqsl3+PWfmGKYxshGGzxk2W9AiaCnDsPi4+G9gj1ad/01dswdQWEQoFU/wmIRDJ5cueuSoqyoBE+WkypRdGrOACnzUJhaM5y6YgddQvv1vsRoHkgIKo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtQPci6lYpAfAFi2g51LYQ6kxD0eeoEPqTIyNQAKka0=;
 b=olberxUIOoENLg4BxumTckNH0EzXeL8iigb5PXFAwYmfxyKa4lkg1Iv1+C8xDUs9XAWYPK6r86T1kGO6uFX0fdEbCjzSWL5+wKAkiEFx1JPifP+fKb1orHqKgGeX0oUSMOiaHSovJbXjyipPWYRb22P6rkEFrRs1+BvzSyDidmb7VLlomzK0u86brz4m65lQsx53GmfrplntIy8txydArs6ZDMpj1tli+qURhwSU8ZnN2ivcQjBq8bHlCMYoIrVCjenBPwATVSlaW+QHsrEbsDew/8ZxbCRPyiYg9ADr0KM7D2AgKApsd+bnAg5tWBr8vBGgh8yajuasBL0mhWdPmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:34:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:34:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 0/6] Support for Samsung S2MPU05 PMIC device in driver
Date: Thu, 23 Oct 2025 16:46:03 +0800
Message-Id: <176120893102.2124.15908337744071968316.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b0b6a2-dd9f-4bd8-a39d-08de120689d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2xPOFBiemZoTTRTOGhNcW5JSWl1R0ZlSEtURzEvUnRDTHR5a1hxaTZQV2ZH?=
 =?utf-8?B?VUZ6OXZhK3FkZDRyTmlBT2FpS1NBanl5RkdBd0JWL0xSUHBHV1BrMU01bzFX?=
 =?utf-8?B?OFFVanFZY0FiK3dGOXJlUEVIUjhmSjRuaXlKNk9neXFjaGJYZUdySFJ4M2pD?=
 =?utf-8?B?RVNFeHRYUEFpTzNEN09iaXhicGNpYmVuQ3E5L0VDMmQ5dVhyMUF6WEYzZTls?=
 =?utf-8?B?VUszdkRXeXhqMHVXSUZ4aW9WakJ4S0RvcElNV0htSDZaeURnRE1ERm1YNXFG?=
 =?utf-8?B?dG8wNndVSHFXUUtpRFdDRzFIOENVVjFwelJZYzlPRHA1T3pOdGlTaVJ3SUU5?=
 =?utf-8?B?ZzZWcFZwOFNNM0V1QjBtRzkrVjVWaExmZVE5emNlbEU0cUkwaG1xRUp1OTFk?=
 =?utf-8?B?dHdVYlVybEtGT3Y3dW5WR1oycm9YU1RlQWxweldpcnFwYmU0WWswbE4rdXpz?=
 =?utf-8?B?cnZqbUV2UmpSZnl6TUJxc2pPTmhISXR4bW8rbll6ZnFVTzJmNGtZSHBEZjh3?=
 =?utf-8?B?OERkeGQ0OHU4MTl1S3lxVjNGYnlYMFYyNjZ6TlpIU09RSVRLeGNvdytvWFU1?=
 =?utf-8?B?ZXVpOHhnZjJQT2V0ZDcyaEZJMXk4UnNtYkxPNHk3cHM0RlJONERmbVEzT0pY?=
 =?utf-8?B?OXcxcENYVjN3MFJPMVNWQ3pVbW1zVHU5elhBZmFvTDlTME9qQzdMcjNLNytE?=
 =?utf-8?B?NFRESU1YZDNBOFJLTTUxV09tbEVINWdwaDlORmNISC9WdU85c0w5SG04aTBW?=
 =?utf-8?B?Rmx3LzJRRngwNUdiZEIxc0xTdkZOcDVrVnAzWWlKNU1sODhtcHBwZDJuWEYv?=
 =?utf-8?B?ZW10L0F1R1dudTlPMk50MEgrYldnMWYvWnM4OFR3dHcrWURocjdIY0lwenE4?=
 =?utf-8?B?R083aHh6VE1YeW1qc1VDdWhxSmhxdU1sd1MxUElhZkJkQWlSSzhxcktZRk5u?=
 =?utf-8?B?L2FIQzdBUVJINWozUGtabll6dXpjblVoN1poS2hUY1ZyTUxVVFdtcnppWmtX?=
 =?utf-8?B?RnV1RXg3VHpCaG0wZERWMGRBQTJEM0dMcHRJT3Bkei9icEJVUjBmQTRTTzl5?=
 =?utf-8?B?UjJnNkVETjZOL2dUN2dXajJTRG9NQ1NmVFlVMnhDOEVzUk5LbnQzZ1VONzZJ?=
 =?utf-8?B?aWhuL2xTUnVVVEtRaC8rUjh0SC9YMmVKWXAxQ0hPUVIxc2ZkYUp2S3NkNlBI?=
 =?utf-8?B?ZWZCVC91VERNRXRDcnFiendmRU5oN3hseG8rVlAydDVJc0U4NktQWEtNNkVD?=
 =?utf-8?B?MWNwa1UvTU5DdXI2K2VFVlhyaEpwdzNpMldiM0I1MHVlR1Y0UGRSMmxqM1VU?=
 =?utf-8?B?ZGFLM29QR2lSNkFuZFdUeFg3LzRqbFFmbzJOOWFuWGs2WlNyQXR0ODRNSG10?=
 =?utf-8?B?YlI3dVRXZHZNTzdhemExWlp1VDAzb0xDcDVVUnp2VktTRm5qOWMyRVJRSWNl?=
 =?utf-8?B?dEFxRWthTWZ6bVF1cStWZ2Njc0hITmU2anh5TDBEbHNoaWxDbEIwVU4rWVVN?=
 =?utf-8?B?ckZvRzVCZWZ1bExxeHlDNnZyZjhOM3Uwd3VTRkhpOUpzZmhvUmU3aFZERVdt?=
 =?utf-8?B?d3BBc1dVSk4zTERoRkpIa0JrWXhXU05DUGROVlRWOWsrWmZCSDhYbmkwTDN1?=
 =?utf-8?B?SlExeW5GVEJQMngxK3NZQ1Q4dXlQemJNa1FKQUpXWjQvRncvdnNWcTZPNlBC?=
 =?utf-8?B?Q2ZDcG1DOGxtL1l3OVl2UGloTHhPclpqeW5uSkQxZ0R5eVBOc28zT2lRdnZZ?=
 =?utf-8?B?OGJLODUyZVYvQVozRk44eXNuYTFkY2pPRG4ydm1NMnZPVXllQ051LzBjWTly?=
 =?utf-8?B?MjBJeWNXOVNZMDZ4eHU2NzJ2WUZEdmpuOFVJWDVXNUh5MFVDQzRKSDFvVjE0?=
 =?utf-8?B?V2Vxd3hvVForcWY2K1VONExUTGNnVzR0OHRCeitkTmRQYW1vYXRSQ0tqNzRs?=
 =?utf-8?B?VDlFU2xpQ2k3eWkwazN2dCtSOXRQRyswc3RBWmUwTXN2cWFHZUhoN0VyWkUv?=
 =?utf-8?B?empWdlJrNDhpUllnenhLMWNVZll1RHdzNFNTYlE1Ny90NS91MkY4Rkt0Z3NS?=
 =?utf-8?Q?dOpXKQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRRKzRXMHZMTm9RejlsbWtrMnVDSGN2MEg5cVU5T0VBZ2NSYUtFT1h0Y2hE?=
 =?utf-8?B?UGlEbGtIdnVEQ2RoZ3lkVUtQNSs3bFFxTGlIVkFFeEpKZDVQbDJHSVBialJo?=
 =?utf-8?B?L0doSGZZcmxqMHRhcU5VbXNxb0c3ZkltSEp1QVY1SFFKekJGbko5clNXYlc2?=
 =?utf-8?B?VGdRUEdTNGxLWGNlem9vdngvWkdXWHhORTN3NWUyTEFjUVJiaFE5ZTd4VXZX?=
 =?utf-8?B?RXdCQWR3dWdJZmRFYzlCVkVYSmlJczdTem5uSDNxMVdHZjhoZUFtYnJtVFI1?=
 =?utf-8?B?Yi9VNm1GZml5UVdBZXpyTWVwRmVWeWZtTzc2YVc2UHZveE1IQzl0RElmVkli?=
 =?utf-8?B?dVhsYlg3WDQwNUg3ejBFSEVLa0lJTG5PSWFGVVp2TzNDRzhYMm8vWGFFOGZn?=
 =?utf-8?B?OFNGUW9sdlNYS3QyZE9TQ1U0VUdBU0JMbFp5TFRrUEM5ckluV1NBSmhjM0ZR?=
 =?utf-8?B?cUM3QXJWcG5Md0x1NXpsSDB5WmlsUmsxaEtRK2V1bERYSG1WNW9MbkZIWlFV?=
 =?utf-8?B?MDgvOE8waU9GOWErZnlQWWVydUJlaEh6a2E4Wm9Wek1xNFlRUWo5ellveWRq?=
 =?utf-8?B?STI5eWV3SFZtbGQ5aUVrd0ZUZEYwZ09pcjloZmo0a1NnQm1XeGc1RFJoYW1v?=
 =?utf-8?B?S3IrVWtRM3hqQkFIdDdSVnhMSERSRXlaekpPWVJRWEZaOWlxQ3NJZTZBaGJ3?=
 =?utf-8?B?M1hjUC9LSU0vMU5YYnNDbjVobEw2WU8wMmNTRlo1cE9tWUtTWFF2ZnhzOSt2?=
 =?utf-8?B?bVd0a09ZL3Q2eW1YdU5UNVR3a3NRMUtvYnJQZWh3dU1wSGRGRkZ4MHVheHRP?=
 =?utf-8?B?YU5DS1JScmlvZDNuN1lURHpCMlB3VG9TclVtQ3JRbXRtRVg0TkFEUnB3WU1r?=
 =?utf-8?B?ZXp3MllCNFJTZk1GbHlZZXdubDBMYlYraHMvK0E4dWc4WXR0NVdudnRibWRB?=
 =?utf-8?B?TlkyQ1ZnTzQvV3FhUGhheWdzNFh4bGRTVktLQWZneXNCWk5QdHN6VzRRZ3U1?=
 =?utf-8?B?b0NRU0ozYTlGVUoxRDN6cmh6M3QzWFJVSlpqckJVZnAxYjk3UE9HZWlDcTJz?=
 =?utf-8?B?TDhCVlZGSDhQSkgrRjNlLzYrbGJudjVXOGJOc2Fjd3FhTEpxRmxwS1ZTWkhC?=
 =?utf-8?B?MmZhMTBlMDRkYkZSQ0pNdWRwcVlBOE4zZFJEaG45RnlRSEpkMkhLMTBnN04v?=
 =?utf-8?B?Mm40c3E4eFR0ZEthcHFlc2pVeVZiN3BDSlNvWGJuSHc4cHBxMkwrMUV5TFRk?=
 =?utf-8?B?T1B2Qmg2ZlpvWUxJVUtreHFOOUNvaTVjdko2cytNTkR4WllXVzBhNFFzRXFP?=
 =?utf-8?B?QTR4dHR4MDhNTXE1MlhNbHB0QTNzYUtVU3NURmVCZUQ4cEdxYWlvbWRXQTA5?=
 =?utf-8?B?L09VQW5OKzVWM0JVY0RxalFLL3NlNXd3TW5TVjRoMXQ2RmkxYVhNWGpFN0Uz?=
 =?utf-8?B?RjNlVkJ4OWM2eFFObjQrNGdwbWV3TEo0Um5yWHZaZFd4Z2o0VGs3M1lYVHBS?=
 =?utf-8?B?eG5xMHo5YWFFa0FxZVVJbDJaMGFaNFFaMGJOMXp0YXJzSHlUd291dVUxWXpt?=
 =?utf-8?B?RW1LUk9QUGUrU2d5emFxdXpRa0dVUy9ka1p5UFlhUFhXcXlUZTB6d3VTZXh2?=
 =?utf-8?B?YkoyeW9NekpOMW83TDVUL1VoSndxdTk2WExFRVl0dDkzSHFBblFSQXoyVTVF?=
 =?utf-8?B?NDdSdUFaRzQvdUh4RWU5by8ySEQ2bDkzUjRTcXNIV1JoV3F5K1BWRU43UGtp?=
 =?utf-8?B?Wkc1a2hVTmlFbXYxUi9YSnpBZHM2RVA0SEVRUWZML0txTEFScmRHU1JkMlQ2?=
 =?utf-8?B?NnZhNWRTQ2hETTFOUFI5aW5oaExlSSthNWRPL1l0SXJnNE4zNk9KWHNvaFk5?=
 =?utf-8?B?eTJVbWcra1FHVS9VOXFTQ1JpTEhSdVNMSkMzelppeTc5OTJpbmJvb09FSjJL?=
 =?utf-8?B?SzJ6NENvUi91MHRrUEpaR1A1b2dUYWx0NTRjSFhaMlNoOXFKNGo1aGYwWUZu?=
 =?utf-8?B?cHlCNGRHVnpNL1Q4ZnV4OXdMVStyZEVLREpoOXRVOGs3RXZneGp3d1RGbURq?=
 =?utf-8?B?dEx6OUxNNTVSNlhsVGR0L2sxWXBNNjZzREl2V05HU2JUUjVsUnFJaG9MZUJQ?=
 =?utf-8?Q?IRZ+FyX+kAUaEcb8B1c4LWNjl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b0b6a2-dd9f-4bd8-a39d-08de120689d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:34:03.0079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCo01/8gE78ZUwGTHGLCWwSwFqIr5rLobu8eQn0PxfA8WanAn5V9uvtPF+nTzjvelMBzd2tRUjzVU0optBj8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737
X-Mailman-Approved-At: Thu, 23 Oct 2025 09:57:06 +0200
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


On Fri, 17 Oct 2025 20:58:15 +0530, Kaustabh Chakraborty wrote:
> This patch series aims to add support for the S2MPU05 PMIC. This is done
> in the existing driver of S2MPS11.
> 
> With the PMIC, voltage regulator driver support is also included. This
> includes significant changes to how the driver identifies regulators.
> 
> 
> [...]

Applied to mmc/next, thanks!

[1/6] power: pmic: s2mps11: change the probe function to bind
      commit: c84442f034fa0901e2decc5e59e559c7b970fab3
[2/6] power: pmic: s2mps11: add support for allowing multiple device variants
      commit: be0ab4089a6e51e724b49398165b222b9089c627
[3/6] power: regulator: s2mps11: declaratively define LDOs and BUCKs
      commit: 35f61d2858eb70744494c219e54d9f43535caa28
[4/6] power: regulator: s2mps11: declaratively get/set regulator mode
      commit: 62f83e5b385c70b8e1adc883ac8caca0f410976d
[5/6] power: regulator: s2mps11: add support for S2MPU05 PMIC
      commit: bcb122b93cb4c47065d481ee3af034d1b8305ee6
[6/6] power: pmic: s2mps11: add support for Samsung S2MPU05 PMIC
      commit: db004ed84f8580cfd83e29c50d9e261ff031035b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
