Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24985E91298
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 714D483AEE;
	Thu,  5 Feb 2026 16:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s6B2cIll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B3D83B0B; Thu,  5 Feb 2026 16:15:31 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0226E83AEE
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWRqVGzFAODrLVNaJjr5B3fj0bjqaRzZC2BoQ++2HQBuEHeTM9NBvlPDAqYeKGz7uiOvt5TGms7XznRuq0HZnw4J3IWZl1ubcBlCA5fpSHI8b1m7WkaRfer9QBGXb0WIihrOsQ5ud6jPXAleQ11IYOfu4D6Zf4odIoDathEUEnX6WKmgCYuclhs8CWw+UsuRSShUFEOMedOLRmh31W50n9MaUa04vypB8qfufO4xMkJNf+VLEXrQiuB4IYRm6/RmCBYcYrjJTGqQZOCAmL7n3KWFH/oDe5q3BRgePSGEOwDtT0tpG4y6TnhivMb03grUCe1kuuEaapxIwwivuOenoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3OuVoURZ0xKZK1qzh1iTgBLEP18C4f/zEmlLSF6Z20=;
 b=INeJCNIbz7WUVSY6dbT9mv3Crns7uNXlJ0fsjtrdiUQE3W8572m7AuUN8GsQMEOckvHZUOb2f7gQvnQbKTloe3w8AvnS71hgb9UExm4NHZPCFYgtyug2mb177nzqEiVMQVmTQDaHwQ7ABlXWP8XUPSQuZr3vNP5hqbtWhYH5evm22rIMjANeZvwjfey3sKUhzHAcyD8Nx1WQYb/x0TWdwKPATK8cTBoUiCwHDR6Mq7UB7Uptwdp9jSNKaqRWCORHmiGx71Rr64zr3zp+OzMM/k/+FA3tKeS7JocPFaPjiJuaaXlnnP0miuLNTOLUVc7igZ0F/kLxU7M6+R3+n0M6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3OuVoURZ0xKZK1qzh1iTgBLEP18C4f/zEmlLSF6Z20=;
 b=s6B2cIllGNZnWvyq03K4MHPVS1ZGHBWPn9nXOEPy8vCvmlKd+4isIcpyHBP3m/+4c2oVtftuCEP4jG5CrvMoHT2ACpvxtWqdjfpG+c/jQACc7SCk3QCWZpraes/KHfiPljyLtdkGZtPvOmAronQcUCZel8gK9DoR+qW3r8PzDglR1yJAHj1cbeG/xWso73jOvxGxgeYnfzHcrKNLgyySPtKGmYuFFJyOGdouqEmg60tVgWpkffCVfrHVLxL0Ah99TDxw8LWl2frPo0MNjbvcDXExPCuFUdXuRa3vjbgnxYm2faNUNBkGMW8NwJOHa+6h3TZruQWI9TD3rwbfwhduTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:15:27 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:15:27 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:09 +0800
Subject: [PATCH v1 03/12] pinctrl: nxp: Add i.MX952 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-3-2103d0222a0b@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a0fa39-f5a6-447f-51f7-08de64c96472
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDAxbmI3eUY4aUtjVVdHMWw3OVNEQUZOZDNKVi9lZWdITU1oSWF5S3krRWw4?=
 =?utf-8?B?STJsbFFsSXNCUDJnU2E5Z29kY20rNTVQNWZoMW81U25OME1hYVcwbyswWmo1?=
 =?utf-8?B?ZEtPTEsxNnQ3Z0dHbWZoamlKeEFWcVpuVUptcis5eTlvd3VpL1NLN3FnaWl0?=
 =?utf-8?B?MjNqU0NXYVl5LzVkRHg1clJzY3ZuMnl6MjlEQjgvRFQ2LytYUGlleXN0akF1?=
 =?utf-8?B?WW8rYml1SElFV1VNbmV2cUVkSEhFMExkWGxHbTdZL0E0NXZpdFZxTGtmNXpa?=
 =?utf-8?B?R3FZMVBlbnJRVFhvWU93RlUyM3RyOGM4RHpRVDBNRERVNXZpMitiR3VvWEl1?=
 =?utf-8?B?VjFvVzFFSzh2UE9tdS9vVFB3YVdIZHIrZks0d2FiZjBTbmUrZnpQVEtiR0JC?=
 =?utf-8?B?N214TC9kVnU5ZWU5QU96Rm1Bazg2dXd5QVFYTnNuMXFxMzVOUlJoS0d5NSs0?=
 =?utf-8?B?VkFSc2haUldORUV5ZzYwNzJqV2p2U0xBWlVSd1lrUHhtSDFmWkNwK0ZWbEN6?=
 =?utf-8?B?SHhWeWlPTDdEczNuSERYaVduZmQ5Mk1RMVJSaFVnR3Y0ck5abjJnenRqZWdZ?=
 =?utf-8?B?b1dtYyt5WGJjZ1NtOThseXN6aFNIL2ErSmNkYnBkOXRvK1BMRFRaUnRTMWRz?=
 =?utf-8?B?RG5YK2d5ZFYvbTN2SlR1MDM4bFljQXhLaFlNTzkrYTQ3VkRqclFIZytVRWtB?=
 =?utf-8?B?K3ZMNHBaT2VienFwTjBqaWlXWnhsOTQvTE1OVGljWkdZNHZ2bk14THJLbERk?=
 =?utf-8?B?dVJsYTV3V2oxUm1qdS9rTHNmWVVmY1U3UE13eGw0WERiUGRwR2MrZEpkRVZj?=
 =?utf-8?B?TWYyU3o2SGFLa2dKYlBGTWtWdkNoamUwUWpwVm9FT0VKTkpxd0JPWUExTUpZ?=
 =?utf-8?B?YnZpMnlTai90SU5mZGJkZ1NvNlZ6cDNKcUxuN2M0VlNqbjMweHYvcWc5aG45?=
 =?utf-8?B?Ti91WnhvUTBEb0xVcUUybWN1SWR1bThXQVkrbzdkTHJBbTFLSDdnV0N5N3pp?=
 =?utf-8?B?WU56d1k1aVVqaXZPTGgzU29HeENVc2d1OGdWMG9SQTFiMW9YdVo3Q0NKNDVS?=
 =?utf-8?B?UEJIVWZMdDJuQktUSVl0VWlhakNKNEJXeDZPbVdLWVNML0tCRWM3eGozOFlh?=
 =?utf-8?B?TVVVTG4yQzg2NHpzZ0RlMmwrY0FxbHl6RGY3YmRqdmxiV3JWc2RvWWphYjhC?=
 =?utf-8?B?cThDTTZiMFYvN29TZXErZWs3d0V5RlczSjJ2b2FmcCtuMENUVWVPV0dXci9B?=
 =?utf-8?B?UnJqSzB3TEM5ZGNaRkxwR2VIYzUvbFIyaVp6U0t0QTZjMUFrbG1JN1dHcjFp?=
 =?utf-8?B?TkRNRDQ0N2ZIZ2FiWmtuQ1kzUFlwSnJSWjdpZ2p4NWhadmFLNjJzUDNveFRB?=
 =?utf-8?B?WEkvK1dTWGJTclZHVWpXdWJUNlZDYk0vRVU3aWZJOU1pdTRRN3BXd1RKeU1k?=
 =?utf-8?B?NzJqbVRHVndSL0l5Nll4NzllOVdvNG84MWxiL3pwZFQ1YnVlMm1kcEdKUUEy?=
 =?utf-8?B?N3FiZ0VVM29RZ2pmTmNkQnhpSUprZkVHTDdjWkk1a3h1UzdaelI4ODNpQ2Fy?=
 =?utf-8?B?dXFCcEkya1h6dzJQSThKOVlQZUJYM0JGRTdGTnZIZ1ZzYlB1cHlFcXloYkh3?=
 =?utf-8?B?V1VVbDRPMTNPUTBMNW05Z2xNZ1I4RGpIc01SZlBSb3pkejk0WFJaNFVaM1Rs?=
 =?utf-8?B?clZKMjV4dEdDbnhIS1Jld0pSOC8ycVhZSEdjMjhkbjg4QWZlbStRNHA0MzZs?=
 =?utf-8?B?WkpDOW9MQWtpdGZsZFAwSVJ6QjRockpZdDlJbTkrcWxRZFFLcXM3bjVaaGZ2?=
 =?utf-8?B?ZVkzOVhMR1M1ZmJUTUFzcXRxNWV6YlpQL3JZbG44cnZtamtUeFRjMWJTeCtR?=
 =?utf-8?B?KzNQaE0rczl2ZFExbzVxamM1bitvM0lYWncwNHFMSWk2Q2NCaE5JZktXQ2pn?=
 =?utf-8?B?eWVFb2tSRjlTYWI3TER0VWowdm4xM3ZZMzk1UElLOS9EditONDJLeExqWUR5?=
 =?utf-8?B?bTRGQ0pvZmlyRzlYeElSeHZyc0VBZnhZTUlmdFltTmFleC80ZUhMMDBUekdT?=
 =?utf-8?B?YmxMVDVEOVdUU201NVRIaU5xTVpVTzQ2SFc1Skh5OTVZL2hiSnVyY0E3TDh2?=
 =?utf-8?B?STJQRmpxQ09YS3NCVEUxamIrWHZTV2xveWptNWNjWDk3M1JnRmEvaWIwNkFG?=
 =?utf-8?Q?+1axn6DYayM23eIKtdPAmjQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(1800799024)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0pYVXRObEN4c3JidkFWN1lPYW5aSGwvOVFNRU01YWdZdXhLZnlLc012V1Mr?=
 =?utf-8?B?a1VwNjJWc3lFRE8ySkEyenlyQXdpYzZrYmtTQkJaZU5BUmRveGNJUjJiK2NW?=
 =?utf-8?B?ZHdDSy8vb1FyNjB3QS9zbWRmL2hobElsV0htNWdiRWd2YUgyRDJzRjBjMVBU?=
 =?utf-8?B?SCtJTno1WkZ1ZGNzdHl3dWRPTDB2Mk1XcXJJS0FpS2RjZTUvZXZCZEJRNmZt?=
 =?utf-8?B?aGRwYW5md3VKUmhmMUl4azdMK1dCTGtIR0F6UUFwNENWOTkzQkxDdTJrZUx4?=
 =?utf-8?B?eUwwa3I3OEwxNFVUMms2Z01NZ3dwY2xZTWJOY25DcVMvTjdMaUp5bUNQSmRi?=
 =?utf-8?B?UnllSlJOSEdFMzJTSXNsRUJDWmd2Q0RnWjUvdE5BNWRBWFpkR1lHSFBldzFZ?=
 =?utf-8?B?cWhlb2U5cTFmVXY1WXY4Rm1CaXJXVGl1eEV2aDdxZEZiM3JKWEVBa3ZmN3dJ?=
 =?utf-8?B?Ni9FZk9uK3MvcUJ2YmxSUk11R2VHSEh2L1V3b1ZMZis2UGRGd01ZMkZGUk1Q?=
 =?utf-8?B?YWZoOXY5U0toajhnakx3b0owaE9KSVhKSDd5ZWZkemp2NlE1V0RkQnhMam5a?=
 =?utf-8?B?LzEya1djRFcySERpVEhHcU9xWWw1STZlMjl3aSt2Tjg0Uko5SHBSNllYN1N2?=
 =?utf-8?B?MFZvYjNXNFRReDhxVkhxeThCVXdRWVRVc0N2WktOdm5GaEJ2RlcwZTVVdzQy?=
 =?utf-8?B?a05rYiszTWpiU3NySkI1dGR6amVmeUFQWTl1RlJyQUg3bytXbm93ckFWYkdN?=
 =?utf-8?B?eXROMndXcTBiTUF5VmhaMzY1MkZBemM5aXlmUFdRZzNrYUZnOWRURlczang2?=
 =?utf-8?B?a1J3N3c5VTdJZ0hQSUJLRzc0d2g3YlYrUHVsTXlIczB0c0o2ZTBJSGVOVVR0?=
 =?utf-8?B?UXc0T21XRWo0TW8wQjU2dVZkUXAwTlcrWm53bmR5VlVSNzJKdGJHUVZseHU0?=
 =?utf-8?B?VWFmM1pzazdwNnV3L3pIT0xVdjBEVy94YlByUDdDcG5qTUJya2NBQ0pBRG9p?=
 =?utf-8?B?NE5WMWdMRnJucWZpd2ptbnJ1dzU2dFNrT3JYakRCdHZpT2JVaUNBODNNbVov?=
 =?utf-8?B?OXNNMWtMTzRyYWJVbEhsR2xLY0RabVl0eGwzN1E1eWRwblpvNUk3VGsvZENI?=
 =?utf-8?B?c2Q5Y0hWaU9Rb3VCUVpxaWdLd1BaVDFsSmNJdXMwUzVBU2RBVHI3aDRmL3Rp?=
 =?utf-8?B?SW5VaHdHQ1l2SlJUMmJJbGdraE1RMllNb25nc2VFT2h6dktRN3FvQkJpbjVW?=
 =?utf-8?B?MnNBL1g0eFdVbXp5K3p2dktaNUZlM2hOSTlHY1U2RThiMWJicCtPYXZiOS9F?=
 =?utf-8?B?d3NkK2NyNjZ1WFFUdmNFRHp6dENxa3hMQXJqY1dSL3JyQWxUd1djdEw3blZ5?=
 =?utf-8?B?d1YxaDBIcUNhM1hTYittSFNPMVBPak5jRldud1R3S0tMUDlNdUwwTEE2Unhj?=
 =?utf-8?B?MjhQU3V6NWV6aVNmM2dQSUswaGZuOExQbkhreHFMWEVsZ3dOd2crVFlDbzQ1?=
 =?utf-8?B?WG5HT0pZRXgrYVcrbW9oYkhVMU9Qc1JOUmZjd3JLNk53UThzbUhCVWVYL2g1?=
 =?utf-8?B?anR6eGZ0YnF4NGFacy92UVFKVlZ0ZkxkK0RNUDNCQmNIWnBKanFzMTJjY3dx?=
 =?utf-8?B?eXk1RWxTTkhBZ0NRa2hoenViNmpuRHNwM085VXdHSC83Y2cvR3RJUmxiakVm?=
 =?utf-8?B?U0ZCYkRVUmd2VWo0dTdNRXZnZWdnTHdzelF5ZUIwTTc5RW9aVjFHeG1wVlFy?=
 =?utf-8?B?ZXpKdzdwYWFreGdJTDg4eXU1bHpZeENjQlF3QjFTczJMU1BIUFlyZ0FkcitK?=
 =?utf-8?B?OVFkWCsybGlHLzR0NXcrWnRaRDA5bmNsVVRHSXY0cXJ6OEhZOC9zRG1nOXhS?=
 =?utf-8?B?QXdaK0Q0ZVhVZVAwdS9yNWpsQkpNTU1PczJDUzNlb1NXVk4vZkMxbVM2VlZj?=
 =?utf-8?B?QnBXR3RaZmV0U2pYU2JUdUo2ZlhLRTMyazlBeUI0TjBmcWV6ME83OGpHclRD?=
 =?utf-8?B?dWJuUjhCTlA3eXA1S3N6QmxGS3hra3owVnE1SmlxWm9ZVGZZS09qZDFiUHVO?=
 =?utf-8?B?WWFaLzk1VU55bWtpaTUzNlloM3pMZ2JNWkpHQlkzOWozOXBYeU5aeEZOTWJm?=
 =?utf-8?B?ZnUxTS84cGV4dmhSa01jRWRtMktla29SbTlFeEE3VFhpeEllNFo1UFRjYUR6?=
 =?utf-8?B?NkFCV3dZODM0RzRIdVRGMkxJQVNGd1d4SUhvVUpzYVJDQzJHSENRbEdNY1pS?=
 =?utf-8?B?ZytKNC9IRWVLaFNVMHJBNTJ4L2FuU3FxenoxU3Y5S2FYdGJUeHJKSytmZVZr?=
 =?utf-8?B?cFNKWnhFUWxjbDNWZUh2VFpwYmtST2ZSREM4eHpWRUttVEE3aWtFdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a0fa39-f5a6-447f-51f7-08de64c96472
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:15:27.1251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42WNqGEw0TJD03dGdBlJ2fyhhnni/cZQaq4rzMNah34ovLcsx0C+5SWAwzGpw5dxcGktIEtLJUo+3YwxQbB3jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233
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

From: Ye Li <ye.li@nxp.com>

Multiple pads can drive the same module input pin, and a daisy chain
register is used to select the active input path. This patch defines
DAISY_OFFSET_IMX952 (0x460) and allows binding on i.MX952.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index 781835c6852..3cc2b85e151 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -17,6 +17,7 @@
 
 #define DAISY_OFFSET_IMX95      0x408
 #define DAISY_OFFSET_IMX94      0x608
+#define DAISY_OFFSET_IMX952     0x460
 
 /* SCMI pin control types */
 #define PINCTRL_TYPE_MUX        192
@@ -136,6 +137,8 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 		priv->daisy_offset = DAISY_OFFSET_IMX95;
 	else if (IS_ENABLED(CONFIG_IMX94))
 		priv->daisy_offset = DAISY_OFFSET_IMX94;
+	else if (IS_ENABLED(CONFIG_IMX952))
+		priv->daisy_offset = DAISY_OFFSET_IMX952;
 	else
 		return -EINVAL;
 
@@ -144,7 +147,8 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 
 static int imx_scmi_pinctrl_bind(struct udevice *dev)
 {
-	if (IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94))
+	if (IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) ||
+	    IS_ENABLED(CONFIG_IMX952))
 		return 0;
 
 	return -ENODEV;

-- 
2.43.0

