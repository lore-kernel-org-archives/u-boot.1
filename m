Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D75C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574E381F4D;
	Thu, 24 Apr 2025 08:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BJg44DBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1331F81F4D; Thu, 24 Apr 2025 08:34:07 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA21180FF7
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFktJFCUuHDZssemFJVhJrHU/Y+2pUj3fmNbov0Hx97/WJt0gaEUa53yGO8I481bFzMbdGtbCNJhuOJiIwY45FgGfjHsqIflcHON07uBbLpPqEJLqBHSDAIOSbl9WgwcDJUGz5nXxLa27QT40RmrkrYjbRE32j8uYqw9nSZyXrwYzekOV4TCZ/3+2KL96bIDhLshHoXLf+oLK5V9SBjaeNYUzfiVAM6LnNuYZ4kQsaEl5QckbPLADU8gRElnQY/9dDyOsHOJvnShSDVBYde/PAmBDutKvH6TOF+nYJhR9TH2hbDEPpqIQ45hndTOxcxW8Vk/KVjfZx5dS3xBBcqmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t3KYe6uAPJZ2aZ82fbgEZehFB+sxzS9i1r7pAUI1Jo=;
 b=r74tumN20CEqYBtRE8gQ3N0sh4lnWe6ZmAbdchsCXXJSBjjdZENsNF8ypCb8K2RBcUg3VFPcAkS2g0/00wcTdU9TSEfP5yoQkFSuhtomRB4QEGKWZiA+jwWYJlxg/RkGN6hFtA1MMFSKJxZh5zCBwpkGa1qwDxMGPqA5eQNJuheit4Ti+2WZzkhqDQqZl2MX/Nh48n5hIWxHT3XC6RvUIHxTS2uDZeR5wrBXoepNnzEKhJxNGra6xLZ2p1nlDxRh0OAsofu+aiqqsnAYbZK/Rp9I5Z4N4eCLdFMbleEvlvI0dBUoUPBbSHdGCW/DliACe7fFis9pZzjWYotRmrvSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t3KYe6uAPJZ2aZ82fbgEZehFB+sxzS9i1r7pAUI1Jo=;
 b=BJg44DBM06OZ1990tUyuMqfl7FKT4sWw4Y2AC20qCHULd2SKqmDxey5pd8IvlLhQtWR7LjH7Ic2bRYCxCxXyS5vlXhJnYMaMgUECe0Z//paTYF5UaWBjFEM3fSdsv4qAU7xIb2+LdTeEgDKtT5w03LbuXBiudPk/Btmmu8xP188Jkvx/VOZS5YlwZDdT96axZ//eXI0QC+DwMUvHeJeLd7RKQrnEOvqEb0L9LjO9J5rz2nNXGzL8ERtcZVsShDPWQIVv4OAfTqDvwogvy9BRCbXjFmfklwe29P8XBREBkoc+KCvC//PAsafUdcKSHd0jBLtj0SalTdVRmFQW+6lQxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7738.eurprd04.prod.outlook.com (2603:10a6:10:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.24; Thu, 24 Apr
 2025 06:34:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:03 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:32:59 +0800
Subject: [PATCH v10 03/21] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-3-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fa2a3f-1aa0-4a1e-1530-08dd82fa014c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3BjZTVvODZsREFxazZhb1VidTB2cjYvUC90UmlyLzJTSk9NNndKcnFaMGQx?=
 =?utf-8?B?am4vdFJyM1phNnlBYTFwR3krQzF1cGlwaXRwc3FHTmlTejZSN1FQMVhqeVB2?=
 =?utf-8?B?RW1uTVRXbVEvU3QwQXNvbnF1UzA3UHd4VXpSSGhrU1hzcW96WlJkS3FPSXYx?=
 =?utf-8?B?aEdiOW1hSkdpcVMzbitaQW81NG5GR0pwNVFFZVdBZUh5VDdQcVFvU21ldmtH?=
 =?utf-8?B?WklHRTZERnI4bHpQMUNqcFpnWUE5b0czSjFtZ1VTTXdEN0pFQy8ycHgvMUhX?=
 =?utf-8?B?R0RaU2VIYVM2cU5oS0l6M1l4eU5ndWMrSWQwQnVZZkdsNU9Ub2xtWFZWOWI5?=
 =?utf-8?B?T3hnTHJ2WGIwdnhwMlhWMXdmT3Jab0w3Nzc2Wk5aWVBiS1lpRVhwcnkxR2s3?=
 =?utf-8?B?aVJWUzlSbWMyVldjNVlETTFwZGh6WEVJaFJyMXVhRjg1T1FtUlFjMENWNUEr?=
 =?utf-8?B?UmlvUi9nK0pWdGV0dm9LeUl4aUVNc0hrcCtSQXhPQzBqWE1adFZaTzlpQS93?=
 =?utf-8?B?KzBacDdwWGVjWnREVDVReVE5cDJiNkwwQmFtdmRUT2duZjBUb1VkZXUxQ2Rs?=
 =?utf-8?B?MWgraHJBNnFaV1ZPNUthekhWVXgzSVVwREQ5RjlMSU5BaVRtRzFrTWp6N0lr?=
 =?utf-8?B?UHRBZGRocjkrZVduWUxkTlp2bDQrOWRTa2x3MTlPbHJvSFNOMW1XYi90SGQ1?=
 =?utf-8?B?QkxPTnZYQURnQXYySjY3enZCTGxwQmF3VGdaWFFEQmZhcjdDb0hBemltaUU2?=
 =?utf-8?B?c01COGhPS0RvQ1VNd1Q0V210TEhLZ29maXd2eXJYQ21SNDBFL1cwNko4cWRI?=
 =?utf-8?B?MWhrTEpuZ1luMldncGd3c2o0bjRNc3hBbHJ4dWZoekZiVXYrb2NIVTZsMEV2?=
 =?utf-8?B?dk1YVlBpRGM5Mnd2YS9wVisydy80VHd2dHJlaUFpV29QMW8rTFNzcjdrTVpQ?=
 =?utf-8?B?R01HZ0JxSFRjakJuR3pFckRHbkRIbmtvL0VsTzlZa0huaVlmSkZOYkJ0b0Nz?=
 =?utf-8?B?RzQrcHNJVDJiaVpyZGxvbjkwdlo3LzkrTUMrdGl5akR4ek5ZNlRMSTZWZFg3?=
 =?utf-8?B?ODl4N0pRM0I3MFordDhsVXdma1UwdjIvK0tDQVhITHFKaXNYeElMRlhKNnV5?=
 =?utf-8?B?NDZOV25KVS9NaTNMVEFKbTN0a0tIQmNOWExsTzJIRDRCYnZYdzI3VmlBZCtl?=
 =?utf-8?B?dUY0OWZ1aFdhTDRTUWZzTEtaNVIybVV1WUEzU05SblZTZDNkSll4Qm03ZXRM?=
 =?utf-8?B?clZMS1ZPRCt4RkVCZjRoYzgxVE9Xa0RQRmJ3NVFGNFB5ZEpMRlVMbTVVNkdw?=
 =?utf-8?B?SE51dGkreWpETytoazJuREVBMUg1VmZubDhSUDg0ZHJkenY4M0QyTU40ZWdJ?=
 =?utf-8?B?ZUNLb1lSUjFESEM4ckd3M2syWlpiZmpFSlhNbUprd1RON0VFUnNQRjlnSnpN?=
 =?utf-8?B?S08venJrZEcxYUluY29TSC94UWVpSEc4Lyt1eXc0MHkvRUJWQ2NkTTdBZmts?=
 =?utf-8?B?OFFWTlNabjNTaXNBbU5mcjhMZEFRcXlYTWw4blpmY21HbUZKaWNNSzY5bGJB?=
 =?utf-8?B?UTN5SkFVa0NVWXQ2VEZCWGFNeGJZclFtU3FCbDJORTd2QnFSNFpmeGRRd2hj?=
 =?utf-8?B?bHJpZWVhckFjalFpZk9XMHJySGpxRDExdDloUnpKOVQ2b1hNa1F0WXI4b1Iz?=
 =?utf-8?B?emxsaXpSNXlDM005YWJldnl3TVUyL3lJT0pWTkhSZ2FUS0JMd0FseENRWFYx?=
 =?utf-8?B?Rk01YlRoK1lHRk1JOEhFdFN5L1V4cU5MTm5Rd1hmTmduSnJqRDllSzY2WVlV?=
 =?utf-8?B?K0RjTHJjRkZzN291WjR5WlR0K0FtRGJvRW1XdWxwUUQ3NVl3Q0twWlQzdVkv?=
 =?utf-8?B?MmdpdlV4MXU0OUk0TFlJNjB6bEJ5dWMwS0dIMmcyQVl6Nlg0OC9Dd1o5THVq?=
 =?utf-8?B?NHoyREdIb0wyNUFnMytQazFhNHErNTVNc2JhZFJGU3BIbGdmd21jVjhVMWpq?=
 =?utf-8?B?eHRycWJJdnpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGFZWkUxTlg3M3UvdEVNbWVvdThZT0FBa1ZMYWlVdWhoVjZHcng4Nnl1SUlH?=
 =?utf-8?B?TElVNSt5U09OcmZuZ0FVTUZjU3VXdXBFb05uUGtmQXRPVVMxYkpqYTcwK3cv?=
 =?utf-8?B?YVVkY2pZZjVLQUFvbGgxOWNkYVlLODZoWlM4Mm5nZnoxYWhET1dqdXpSMzVm?=
 =?utf-8?B?YTBMM0paK3IzSC9ydzZXMy94Y0UrUitveFJWZGpoTzc0cGdSSFZaQmh4aEVl?=
 =?utf-8?B?aGtzVGxXcmZ1TnFaV0VFYWhYVjMvazRPMTliaGZzRXFuTkh3bi9YbkVLK0VS?=
 =?utf-8?B?eVA2U0RIcUh3YjdmUjY0aVU4U20wMWF0dVpYQ1BCTnMvTHZPL3VHZXpwUUdY?=
 =?utf-8?B?NzZqZlhieFRMQTNyWXVhZnByMXJDaklDTlpZeGhsMmxmc01YM0FsVHY5S1lx?=
 =?utf-8?B?TnZ1TGFrRC93alBEODVTWTQva01WTGRLa0NnL2REWkEyNCswNGcvTHg5RXZj?=
 =?utf-8?B?Q3hWUWttS2VreWM4K3dVNW5PMVVlZmFONUtDL3RyckM3RmI4ZXBsVlptc1Vq?=
 =?utf-8?B?algwNVF2WnJuUkUwQTFLN2lubmNOVytvN0xTblRrajVTK0hjZml2VlU1QTNk?=
 =?utf-8?B?amlzYXVibUJwdU5sTmFsRE41SE5RUnpmUnd1TEViQUFFcjlnS2kyaUFvVExG?=
 =?utf-8?B?N2N0UGVWbjJQNjZtSWcxcENuNDk3S2s5Z2Z3K2owaytkcTB1UFVsWFo4b1po?=
 =?utf-8?B?QXFBYnZsM0RsVEwyV05Pd2VsMzRSaFc3T2lxdHVMd0tuUkR5cUh3SndWaTFq?=
 =?utf-8?B?VFY3eFBScEtILzh0Z3Z4UTJZWloyV29pa1pjMVlMQ2ZEOEV1RXp4MmFWSHJM?=
 =?utf-8?B?Vk1tTXFDeFo5QUZscHNWcW1CUVg3UTMxNG5panNWbU51UzdhSFN2U3hlRTJu?=
 =?utf-8?B?VExFSEhQcjJxOEtWakRhYXBQMnFDQjZGcjlTNWxCbVpiSVhPTXBYQTZoWXFJ?=
 =?utf-8?B?ZkNISy9oZmJLNG94eENJdURTaWxpeHRLa2l3UERDSjkrUkd4QjZwNVREYTN2?=
 =?utf-8?B?Qk0weVhqeW1NbFh0WHBTSHJVaG1Td0lLcjdNUkdsdG0rYnlJYXhpQndyT0NJ?=
 =?utf-8?B?b1lvUlFyalRwUndmWS82YmZTVzdrb2g2dlJnM3VHR1M1U1VGckVHbEVVeG02?=
 =?utf-8?B?bFZPV0Q0TFRGWVMyL3RWeEJKdytqaklVQXB3OVlvYWtyNVVQRUxQU2R2Tk9s?=
 =?utf-8?B?eDI2OUcwZGgwWEJlc05IR25KTzdMc0E4Ny9DdDdSV0ZPeTlsZFcwLzFNM1Zr?=
 =?utf-8?B?T2hLVDNPVmttNUdRWnEvdUxOVmdNYklBSU1sUTIwcWx0bndlQ1BGMDJNTjlY?=
 =?utf-8?B?cGowdTFJMTkyeGZLRmd0M1JMWjNpNTlMR3plbTJxSzlDUUpkT0IzeEI1R215?=
 =?utf-8?B?ZVdoUWU4MW9pdk1PM3pUUTJ1bTZNelhCNUI3d21HTTh3OFV4QXlXeFdMV1lB?=
 =?utf-8?B?eXBVWEJwT05WcXAveVpuZ2hjQk1CaTZpRHIzYnJvTG5tQzRIYlBEMHNmNnAv?=
 =?utf-8?B?UmV5Mkc4OU1NR2xRWStad3N5YkRGbFl6bHE1UTJqbGhTaTU5SWxRcWJSMWZH?=
 =?utf-8?B?Wk9iekVPYlpnSnlDaEdzSWxuZEVKTzV3VEdaeXl6UExJMlViTHZsNXpwSlo4?=
 =?utf-8?B?blRrSWZLLzU1cUlQRzYzdXBrcWVOTHR5WlhLZ1IyZitGSDVZSWc3TFFFMGpz?=
 =?utf-8?B?eW8wMFVRa1B6dGtYUTR6dUdXWENYMHhEcTZCdjUwN1EvNkNDczNPVFJIbnRR?=
 =?utf-8?B?Q1hTT0tUdzZ1ZmsvdDhKakh0emVQeXRmb0VDeEloQjhLTXIyNzVEdC80Z0U1?=
 =?utf-8?B?dFBTTWt4bXpEU3FmY1U2Y2N2RFBMU3VINnRjOHN0K1BEaVVyK3NRdmR2Y3dG?=
 =?utf-8?B?dXkrRFFocUk2ekFlTjdxamp3SXIxYTdVdGpEb2t5Q3lWT2Ixb1pBQ29FV0lY?=
 =?utf-8?B?TkRRZkVpM2p6NW1BVjNJaUNBYzNqMEZwUGV4WkJGWDhxdzI0M3ZoSWlBcWZB?=
 =?utf-8?B?Vjd2ejVkbjR3R3NhRXpvd3JDdGswOURyOTFXRGZPU3hCWmFTNEQzTVBMTDUr?=
 =?utf-8?B?VmJZRUdoUERoVzNBVStwN3I3Y1d4ZTFDKythd1VPZmtKbHd0bHNQdUlzTVV4?=
 =?utf-8?Q?sXFGnjFgsGYQJDOGORXocRTug?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fa2a3f-1aa0-4a1e-1530-08dd82fa014c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:03.3523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfyX9ayHCQUUPtxkg3HRjbpJ0jTtF9OgJH6mJrjqcu0maM8OqHC9ej3I4JtiCUDJby9aPThjD+Lr8TF88qG5fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7738
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

This patch provides a pinctrl driver based on SCMI pin control protocol.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/pinctrl/nxp/Kconfig            |  13 +++
 drivers/pinctrl/nxp/Makefile           |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 154 +++++++++++++++++++++++++++++++++
 include/scmi_protocols.h               |  36 ++++++++
 4 files changed, 204 insertions(+)

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index d13c5f2a6d5..84d9a3641ff 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -139,6 +139,19 @@ config PINCTRL_IMXRT
 	  only parses the 'fsl,pins' property and configure related
 	  registers.
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
+	  Say Y here to enable the imx pinctrl SCMI driver
+
 config PINCTRL_VYBRID
 	bool "Vybrid (vf610) pinctrl driver"
 	depends on ARCH_VF610 && PINCTRL_FULL
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index 44e37c631e5..7d861ae52c1 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_PINCTRL_IMX93)		+= pinctrl-imx93.o
 obj-$(CONFIG_PINCTRL_MXS)		+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_VYBRID)		+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_IMXRT)		+= pinctrl-imxrt.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-imx-scmi.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
new file mode 100644
index 00000000000..20ea55d40ae
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+
+#include "pinctrl-imx.h"
+
+#define DAISY_OFFSET_IMX95      0x408
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+struct imx_scmi_pinctrl_priv {
+	u16		daisy_offset;
+};
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret, num_cfgs = 0;
+	struct scmi_msg msg;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+
+	if (mux_ofs) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+
+	if (config_val) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+
+	if (input_ofs) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs -  priv->daisy_offset) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+			  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret || out.status) {
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n",
+			mux_ofs / 4, input_ofs / 4, out.status, ret);
+	}
+
+	return ret;
+}
+
+static int imx_pinctrl_set_state_scmi(struct udevice *dev, struct udevice *config)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	u32 *pin_data;
+	int i, j = 0;
+	int npins;
+	int ret;
+
+	ret = imx_pinctrl_set_state_common(dev, config, FSL_PIN_SIZE,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM) {
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+		}
+	}
+
+	return ret;
+}
+
+static const struct pinctrl_ops imx_scmi_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state_scmi,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+
+	if (IS_ENABLED(CONFIG_IMX95))
+		priv->daisy_offset = DAISY_OFFSET_IMX95;
+	else
+		return -EINVAL;
+
+	return devm_scmi_of_get_channel(dev);
+}
+
+static int imx_scmi_pinctrl_bind(struct udevice *dev)
+{
+	if (IS_ENABLED(CONFIG_IMX95))
+		return 0;
+
+	return -ENODEV;
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.bind = imx_scmi_pinctrl_bind,
+	.probe = imx_scmi_pinctrl_probe,
+	.priv_auto = sizeof(struct imx_scmi_pinctrl_priv),
+	.ops = &imx_scmi_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36b..279ebbad440 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,39 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:		Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled
+ * 			for the selected pin or group. This field is set to
+ * 			0xFFFFFFFF if no function should be enabled by the
+ * 			pin or group.
+ * @attributes:		Bits[31:11] Reserved, must be zero.
+ * 			Bit[10] Function valid.
+ * 			Bits[9:2] Number of configurations to set.
+ * 			Bits[1:0] Selector: Whether the identifier field
+ * 				  refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.43.0

