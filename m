Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E65AC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACAEB801BE;
	Tue, 29 Jul 2025 13:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WwBktBPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2F38304F; Tue, 29 Jul 2025 13:20:01 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22EF882BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuE7KVqE5n7FY0nUtU5j7uhDBX1vmRyjMgRwojEotwwTyq34Y3imvV7FR8ElkKDkcHIZ4DIxxNpyubZGc0nrOi+mdqTqsGhw4kaQ7ZC23TTwK8jc6jvfsWoWMmVKPZdYbFf9WHxTSaiRiOo1vKysoRWybgRR8RAv+IcxUWIkzJ72kEZBGFVxioeA7/skQPpnWzs/klHPo3Dt8GPVsmiT12nLh/8BnSr7pue+o/d2QYXaTgFL2+58t8iPXoJrvIi0rWmCfW/2U6vfMRi22jrFEKxHOozqcMHXTo7m0jo7b51TY+Pcget52g/JOA0kIEl5T3kM2xOtSBwXLWO9nTO+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB01zrYX9LxPUoEeAm/9Yp9e9U0vsTxpq8eLAHBIPSM=;
 b=pmCy1G7ouwqu3X9LyYhQBI1ldzRGJ5IIThAajG6Yc72/cXVWp3ZecLflmkucOuq8fbAsE6SIy/3rx+uSnYbpviPW+Gxckc8jL8KjOmF+lIx5WA0ae0qKZ+uhowXyIqbqnp0ZwQFS48VKliH6XRhgbUmyDrfmO9gxVodWl/6mY2wfVFgIABO4s9JlFcCyG52aQFjY+k5Jl0CG6qhK9kVbCYggi68Fxc7DI4DgaEQcANs+2Jq6R3SydS/fZVISW1NA4rVSw9oki/p+jM2regHlhZokIqkK3bo+G2Ch6SNfD45WlCQq8ZNdVxNgk7lJLAwA6VK7Q3lWzXeZMP4fgGFWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB01zrYX9LxPUoEeAm/9Yp9e9U0vsTxpq8eLAHBIPSM=;
 b=WwBktBPlJDDICZXkphFlBvUFTVcNJtgVWckmJCyC8kd1S+5Tc3N8EtRb6hGAnuOOtpORGdMc0c2q1fSEs4yvVSIgH0vvf8MNzT6dueUi8qawYNdbS2vMJlspOpg1f/r/nc79wzX7QrQP1LpD0RIqdSDFIRzTAdgxpIWbeTfik9xz4LfOk74G8c3GakMFD6/idfGr9lsDMN/DJykuhLvFQ+x+NubheI4OrPFuyk2lNKeqwAr2TWGIFEo6Q9bz87kQriIKfz3HTb8+VHD6ds4bvKiUBPLjyh6U38S6jB0nZPIgQym77WA0qm+n19pusz/Ni6DBt74DEJBT0qh7WViyWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10648.eurprd04.prod.outlook.com (2603:10a6:10:586::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 29 Jul
 2025 11:19:57 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 11:19:57 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Sun, 20 Jul 2025 06:13:54 +0800
Subject: [PATCH 3/6] usb: f_sdp: Update SDP driver to support PQC container
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-imx95-v1-3-759619b47b1f@oss.nxp.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
In-Reply-To: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
 Adrian Alonso <adrian.alonso@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10648:EE_
X-MS-Office365-Filtering-Correlation-Id: cb21a300-5081-4b55-7423-08ddce91d951
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3FKR011NUh4d0xRbU51WXlzQ1Znbnp4TTd0U2cxVG5TWGdVVFBIc3ZBSEZp?=
 =?utf-8?B?aHkvVk9MUkRLT2crYytQRnQvbXAzaElWTHAzVm1qM2d4R2FIbUtRU0lhN0xv?=
 =?utf-8?B?L2N6S010dVlpaktjdUE3VXA0Mmhoc2VyVjVWRDBHYjBlcEs5RWF6RE9lQUho?=
 =?utf-8?B?UHlCUG0zRS9MK2FmNTNNZzNPYlJDb3luNEMyZjYrRUl5UG03ay9DcFBqTWJ0?=
 =?utf-8?B?OFpDN2h6WXNaNUVXM1JHRkU5d3RxcTArdENWeWc2K0tjV1crYUJkZlF3QlJ1?=
 =?utf-8?B?aGJtZkx4bCs0RGgrUkN5S3gvaWphbDNzb0p0K1p6TlBMMTMyazdHdlc0cG9l?=
 =?utf-8?B?MTFCQnpqTWVBMThCajhZWDNONldwcDZWQjhZRTZ2ajR3Zk1UVnZXOHJqRlpj?=
 =?utf-8?B?cFZXQkl3bTNpL3R3Qm94U0l3U2xQTnk5U2NTWk9ZcXd4OXU3bEtqWFNJb1Np?=
 =?utf-8?B?QlRLeWlIZUQ5RGZnRjU4T1VPZWFzZm43WGYrOGNtU3JYSjJkU1VCMDIzVXNs?=
 =?utf-8?B?SW9sd0hyZXlnTlNUSjUrR08yeWozZytxeTE5bEpoU1FOeDU5cEs1OXdzVjl5?=
 =?utf-8?B?Q1ZKMFBsY014WVJjbkFGbmRnZVQ5ZmpSMVJKOW9IWSthenNrY1JYNS8vdGRC?=
 =?utf-8?B?Qy9CUFRnNXRtTUdQOElFaU1uY05sMk82YlUyUVl2Q2hwTE5nK21id0xUV0dI?=
 =?utf-8?B?Mmw3RzVyNlJLaGlJQndpcmZkaW5RNU5UbWkyZTdMQ3BpQlJXTGF5YzAxTStT?=
 =?utf-8?B?aFdGNGdZK1lIcHVPZkFQRGhuMWFuWDBLL29Vb24yVWFCakdWbnA3ZmNjWFll?=
 =?utf-8?B?cG1oZ2doZXdBbWJvOWtyYU1uSjR1WUNZZmJ4bG94WXRTVW9YQVQrV2ovR05K?=
 =?utf-8?B?ZzBCeFJ6VTNmbFloLzBDQk0wOXp2R1VLWnZyTWhpaUNOZmdPM2ltV0hVOW5T?=
 =?utf-8?B?K04razlwSXBnOUlKSkdsNlIrTkt3c052UVVqT1ZJaVQ2SlllWUw2aXhyKzJZ?=
 =?utf-8?B?RUYvdGdjblFHK0R3M2MvR3ZwZlJpbGlPK2tsdTdPSW5rM2lwOXlhYnVqOWFZ?=
 =?utf-8?B?VkUxRDFjcU9RckJLN2NhdjRVL2J5Rm1uczRpcURPNmZKaEl2cFVZU2lhZkp5?=
 =?utf-8?B?S0FuZkdCTUs3akNmSSs4MElvbVNMa0kva0hOdlFRenN2amM0aTF0eHltckI4?=
 =?utf-8?B?cFB3MXBYb2RBbTlPMVNMUzVTL3NyNnRXY2tnK2dFKytIRStMWWxCaEFRWDQw?=
 =?utf-8?B?alFpbEorQmQ5ZFRvd0VwSythMlVsS3c2RExrYlpteXIrTmV6NVR6Wnl3Yy94?=
 =?utf-8?B?Q1pXSGNQRlgxK0hBcGszUUxKM1RJam9Sa1M2MSthd283ZXdBVVB0YUZ2TmxB?=
 =?utf-8?B?K1BUVjhlNFZJTUcrTXRYT3FQY1d5MjVCSDc5bHQxR1RoYlUrMHhsREl0eUdh?=
 =?utf-8?B?U3B4N2RIcnRGRm1OYmkxbGY3NU1icGNFY2EvYysyYVQvOVNCN1BMZWFialAv?=
 =?utf-8?B?UG5QL2F5ZjZ0NjdFN0FCRUVTdjFsUnhmNUI4ZlVld0YvQ1NiRHk1Y3pkemZk?=
 =?utf-8?B?bE1PMWsvR1BQMlBTdHBmbk5NUkhQWUxmeWdLT0lMZE5IVHdXMitmWCtoV1FN?=
 =?utf-8?B?dkZVYzlQNmNaRWZtZUNidTVPZkpxTGMyRkVjRSt0K2pObC9UN0xBVVBTejhH?=
 =?utf-8?B?dmROMmZVUHFuUklnSFFYWEF5VDdjY2syVHIwNWRmVU9oWmx6a3dlYU41dWU4?=
 =?utf-8?B?dEI0bzVkK1lVeFU1cGZIMXJYMkU2bnpqWmZTZCt0by8rclBGVi83ZzVnQVI1?=
 =?utf-8?B?OXdWRkFRYUNWUEpQNGJFU0pReVY0L3AzaGdNdnc2V2JqZ0ltUmFUVlJtTUNW?=
 =?utf-8?B?S293OHRRc3B0cnFFd3ZvYXhUemFFN2JHVTNnblFoMm9talhoWTZxQU9RL29m?=
 =?utf-8?B?WEJiSG5iRiszZGZOUWxRTmN0cFlqWmMwdStXY2k0OVBvTDBpbUhjcDJzTXhE?=
 =?utf-8?Q?/0oB6v1leoGACVDCOByHzSJ9ckP1aE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BROWhsVTd5dTBKckI5aGRpUytmd3NFNDhtZEIzMnNMT0xjTCtxbS82ODBT?=
 =?utf-8?B?NlBmUEJscWxtU1ZBUGNyMzYyZWdBbTFIR0ZsenVLRTk3MnRudFIxay9qeUhP?=
 =?utf-8?B?dUprK0ZTNEZHQWtaVmpGdC8wNzduczFpcHEvV3V2TWJHcUZxcDVnQVVQTXE4?=
 =?utf-8?B?YnBiRkd0eEduMnJhaFdXdVVjbGVoaW8rZC9Qblh3OGZPTldyQlVRZm1OYmlj?=
 =?utf-8?B?RHhVZkorNGk5V0RpVVl5TDNtVnZydG9iWG41aTE5eHplTm9ueDR6QUR6SzBB?=
 =?utf-8?B?WHFMek40L240cWp0Wm52Q25RUkVTRmtsd1B0WHdHcWNxRDZENFl1Q1FVTWt0?=
 =?utf-8?B?OXBrMWJGb0Rjc3pGMEJqeldTa0dobGh2OCtQRTBVNUppM2FDejRSa3VsMS9h?=
 =?utf-8?B?TUtnT2ZuVFhQb0U0UTFEc2lpNkpiRzBKQXBEaGpDWkllNXFjTnVXNUtRcllv?=
 =?utf-8?B?d29JQkFEMytYOExwV2YvSDNxTHVwaE1BMWdjMVJLSTRCeGs2OXBGQjdLZmR5?=
 =?utf-8?B?QUFqY3lwUnpLek9YN21uNndSUlAvSTJXcUl1aktvT1VaSit6cjhJbUZaYVpD?=
 =?utf-8?B?K1BxSERpTUtyWmtkR1gxWHhoaFplOWx1ZmxHK0U1d0pnVkJaRXVGeWdyaHRH?=
 =?utf-8?B?S1FQU2lQdE94aEJrdFFBNnFHdlhSOFNNY2lyb21QTC9kZFRWN1hkK1pGWTJn?=
 =?utf-8?B?eGlRaDVWazJ1dUJlbVdXU2h0TGkrajg4RG1qNzRJL3FFWk5qVDBpdFk4SGRi?=
 =?utf-8?B?VHBmSUFzMzJmU2JZV1VBS05kck5DUVZSWXdLQThBSXdkS0xWOWsvTjBneU9t?=
 =?utf-8?B?WlBwZHV5T0RodVNiblpRaFprUkNyNXlTaG1QNW8xdGJlY1hpS0lUWEVLaDJw?=
 =?utf-8?B?QlFZSGdOWHIrWllqb1JrTS9POWw3QmQwdVk2M3liOW5keEwweEtCd3V3d0Zi?=
 =?utf-8?B?bXJ0Zm15emNveHpMaUtYRHJQVVZqZVQ5ZjVISkVLUVpLNnZnVjJPRHJzR0lP?=
 =?utf-8?B?bzNLQzFwNW1PaXByN0JETE1FMlZqaTJFa052NGYvVnVSRFVwSDJtL0xYaEtM?=
 =?utf-8?B?MTMvT0dRS3B3K3BKbHpwWFExakptc1hQTDdjajNLMnF1LzFLa2VJUlpYS1lM?=
 =?utf-8?B?ZUFLb2M4ckJCZTJRT1ppUGo2bEF4aEQzNnpscWNsU09TZFA5VWpSMG5NOVBI?=
 =?utf-8?B?eXVSOWhQTE5tV2NsRUNiZGlFWDBDd0Z3MnNPeC9wVG9PTjhLRGkyczJMV0py?=
 =?utf-8?B?NG9xQWNjOGdwUm5Eckowc2J1bVZ0OGhlWFlaSGtXalZxL05oQXQwZHNiWVdq?=
 =?utf-8?B?YVB5dnN6anZtKy9XOWRRcHByUGlmUFQ4T0xzcnR3RWJXMkZLVzFhTldmcGRQ?=
 =?utf-8?B?VWVrbVNsQlF1ZGhubFBwTTB4TCtza3NsbWJQNlhxVjZGUmcyUnBwRlV5azZm?=
 =?utf-8?B?UThLd0daVmNKUmtGaVZCdUlhdkFRUVI2TjI0WCs0U1NLSHVKOFRqVS8zOFRT?=
 =?utf-8?B?bk02VlNvMFE2QVQ1RSszUFN0cWFReWpadUZTa1Nnb3BzUTlmR3VDd29VeG9L?=
 =?utf-8?B?N2ZyUjFVZlFqMm83MG8zOUdZZXJXVVErTS9WWDBYaFpFTWVJdDBXSDZQbm4w?=
 =?utf-8?B?bTREQUtCdkFQQ04xUXdlRVV2bzBDa2oveDFJVmpCc1NaUmE3RWNYeko5d0xQ?=
 =?utf-8?B?OTV2bitZVWJ3d1djSml5UDVSZW1IZVhnajZmYjkvK1BURGdiNWVoOU1yK2pR?=
 =?utf-8?B?VmR6WnA4K2JQb2VqZUlaN05Gdm9IWlhMaDh4UndoUXhBZTBHc3hnLzZTekdp?=
 =?utf-8?B?RDNpRmFtc1F4ckFvS1k2RDBaSHJ3dThwandKWGk5TjdONWd2K0pqRURRUFB2?=
 =?utf-8?B?dlZweFFWUmZnV0VHZzFEcU1ZL2JkVXBwbm5kbzFpMFJQVDYxVUI4MUhQdkFo?=
 =?utf-8?B?dFR4eitCdlNvWEd1ZHFPMmhXZkRvcXVxTjhwYTlDYTRkZVYzZnB0b0NIS3Ry?=
 =?utf-8?B?elZGVVZ6UGo3YkJCK0JPR0dRa3dPMldFMVZQcVdvUG9lWHhLQlhRMmtVbVpP?=
 =?utf-8?B?ZTNhSVV0ZGZDemppdTBZSlRCU29XSlBDbC94WTRST2srMGVTYzVSdk5iZTlt?=
 =?utf-8?Q?4iAUo+8Wp6YLa2GhRW2T0Kua8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb21a300-5081-4b55-7423-08ddce91d951
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:19:56.9906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj4xeapMGzP/RbC8UfKTFBfH25qcZntKCU0xYpsIT9V6h9JqB1sNm0QdDqDabGy7o5MVnrx8L7qxBKzSyd2QgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10648
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

Since PQC container has changed version to 0x2 in container header,
update the header's check.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/usb/gadget/f_sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 647001d8dd0..f72e27028b7 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -765,7 +765,7 @@ static ulong search_container_header(ulong p, int size)
 
 	for (i = 0; i < size; i += 4) {
 		hdr = (u8 *)(p + i);
-		if (*(hdr + 3) == 0x87 && *hdr == 0)
+		if (*(hdr + 3) == 0x87 && (*hdr == 0 || *hdr == 2))
 			if (*(hdr + 1) != 0 || *(hdr + 2) != 0)
 				return p + i;
 	}

-- 
2.43.0

