Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A31EF06FB
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D7B83C91;
	Mon,  9 Feb 2026 02:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j0fNU8jD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61A483DA6; Mon,  9 Feb 2026 02:29:19 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BA0483C91
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZrOyUQONxSKErzBVMd5Z3shx334vaVRImeMHd6g7g7jpGBMMweXuu+YK5sQ+rfg9n0fXl7vwDYG0OTW1tO4L5xDJ/xMHnaaCDx+M4N9sI4ZJnEZcsx4tNPiPmsTabdIu9mLu/um39zv8RNm1VgaOWROow+/5ey4KpNqrhsk10T23EPy6K/4Gm8sz1SYdyjJIo9C1oqeoFZtfapdKfw6Idbp11/K6/dGy1ij2elLBfa6d6ecK+00Ic8N1wBx3R/thu/MSaS+9Jsp7VbrpS4LVhjw3Awyg4n3G+g+dvRVU+TKQXWe8tVkycOilQYfD5iGoGNLCZ5sustubfUGpnrWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mARH3HXQvn9H2K9C75Ooeo+YZ9BTcmxpCVUThYGK/EU=;
 b=KPGBHn0BNE/f1hT4h0KoKOj7MTyz528MA8LsEABOLELTY45UImqfrRQT5JAc+Mq1rW2Cdl8tuGr0KwFNjEr3QaEOBgtwrbRcSCMBEigaeMQ3fqzIfLOV7RXdiu3Rb40oDZMQSbfdar/srVXW8UM2fJS26LLiUd+7F/TUnw4wZ0zWfDmWCYr/FAflfBMT0iHDVHF6xD03e+o7wn7SYyNt45w4E05uCKOXPqo7hAKefmjtBRB4DYo3RGB1PnNwmK4tJaDq6lQ4qpmYltaQ0jML24xDgb7vPUpNSOm6bSsNEtMya1zQcF6hMD1TSXE1AAwxXef5B2g5kyB5TzV+rsoZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mARH3HXQvn9H2K9C75Ooeo+YZ9BTcmxpCVUThYGK/EU=;
 b=j0fNU8jDxkn6a0cqWJqlJ6hFRUe4+kUicUkAunrvIdY3daHjZNH6RQbF7tBgQYWSJ5WZzE5P6QFHKYwLrBTUS66E5Lj1zrQGRQQrUEnSgxfiELK+kvskJQyr97f2+JhDbtzaQZXY5HvMJe+I7AusRLJ2TcwnI8OfBbtSF41buyMWkZAVGlW3VP6dOeaMkAZy3MiIVFjx2e5oivH8KPItxrpxbnAufvI6T7tI4x+a5rGfv8BC51ZnPfLa6Sz0h1PxeFUrmVMTyu3KwhTQo+wJfG/OliAt9ZTtRfht/Wd4b3q6RN9941MzBPrQ0Yt8MwV+X0yDQaM1qGMaZkFI6P7XhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 01:29:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:29:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:16 +0800
Subject: [PATCH v2 12/14] renesas: common: Include asm-generic/u-boot.h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-12-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee422a5-d24d-44c1-ee6b-08de677aa281
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUw4WFZUaXZJbTg4OFo3NFpyZ0U1WmZxSXFnR0pEaDBxdzhITFdZbDFSa0lu?=
 =?utf-8?B?eVlsbjNGU0JjSkZyN0I4NVgxWWk0UDFZZkV2TjQ4WUxrU0k5aEs5NlFjbGlZ?=
 =?utf-8?B?MXhQZmFtUUpTQllCaU1ueGxPK1duUExRdzJLYmpjQUxkQUFjYW9QUmdSQ2kz?=
 =?utf-8?B?MUFlSXd6bUZUbW1ROXB2WVhoUWt6NWpWaHRZR1AyTGxhc2U3bGpTWWJ1dm9E?=
 =?utf-8?B?aWJUUFlVR3E5SDlaY2kzZDlmSXYyTHE2NStYR2cwR0dhdHpoRFhYS21hWmlS?=
 =?utf-8?B?Z2V0NlBta3pIYitNREdLMHltQnVrQm44ZSs4YW5QSnlqYzFOR3pKQmZTK0cz?=
 =?utf-8?B?ZDUxQlpBUTk0SXB5RDByMERFU2o5eGRhWml5K3R2b2tpb1ppY2hnQytPdm5z?=
 =?utf-8?B?YmI4QTgxb1JCYkN2QzBKaWNjNUx4ODNKbW4rUk84M2tVc2ZxdE5UK05iQzF6?=
 =?utf-8?B?aFNtN0tZdlozSUtRWkw1QVIzNFc1aUNlNXhrekI1T0MvM1RteCtlVnJwb1dn?=
 =?utf-8?B?UjVVSDZNVFFjbGhZeHdNMDhYUVU1cDVmby9FUnpMditmTi8zSWFTR2JxSEd4?=
 =?utf-8?B?ekpkZmxvRXp0Z2ZVa1p6R2JaeUd5MlZtRUJBWnhkZmcvU0MyS1NOd2RoMkZn?=
 =?utf-8?B?UVR2ek5EYjg2czhqQk4wWER2RXNrZy9aTmhqZ3pQZ0o2dXZqUXlvcUlDTkRq?=
 =?utf-8?B?L1NzcGxZTzVodmpvTEUzVzhDTTRPSVFTaHdOckVkc3dqV3RJcnhCRU1VdXNO?=
 =?utf-8?B?eVA4RTNDVFBOV1N5dWxaNEhpQWlpMU1lWU9nenkvbWVkTzkxVUhjNmR3aWdG?=
 =?utf-8?B?MTg4YlF2SU8rbWpyM1pPV1IyMnRHQ1VESGZ3MytvTDlqL1NHQnZRWHVUbTNi?=
 =?utf-8?B?S0ViLzJmdzFobm1hNmNEZTNjb3hzUndtU1FGKzlYL2xQL293VFVXcXRhTGFV?=
 =?utf-8?B?K2d5eS9ZMXYrTFVHYkVVbk9GTUxDYXRDMXBSZTFEZHFvWm1rRXdKVG5teTZL?=
 =?utf-8?B?T01VYXAzelVMVTJ1OWZiNE55WkFVaG9YRmlqVVhZUnNHWnQ1WWp6bkJjeEhF?=
 =?utf-8?B?QTF1Y2ZkTDdzSDF3ME56dmRvdmh6WTE5Vk5aUXc3VkkwMDd6c25yckpsOWNS?=
 =?utf-8?B?dUlHSGRGUmxMWXNZZ3A0bnVKUFRrTDJMU1Npb3hRZmlPK0ZOSmU3MHVkUlpO?=
 =?utf-8?B?eEJwbEs0bi9QSGhNdTl5MVJidXo5c044VFZOLy9OMkU5U2owVG1JNTloSWlq?=
 =?utf-8?B?bFFOOVRrMkJPZ0R5WVNaKzNIM0hXbEV3RVdjamNNU0lpMFlXbXova2YwL1Rs?=
 =?utf-8?B?Y0Rpa1ZYc0ZzdWdQZ1Mwbit0SjEvMHpUcHVRWXZpUnpQSHBCWjN6aFpwS29R?=
 =?utf-8?B?dGFSemNNV1VIRDZYeXd5T3ZoK2xuUXFZUkNVeHJ4Y0o5WVN6dkxPMTNET1RL?=
 =?utf-8?B?ZmZOelRBVmVFWlArYi9rbFlMM2dpVWtYZ0g1Q2xOaGxPU3E4WkQ5bzQvYU9Z?=
 =?utf-8?B?KzJLWmtMWExvSU13akxTR2plczZJSXVKblhJdHRuaEc2cXJTc0hYY2svV1JS?=
 =?utf-8?B?VXRrL3V2YkpveVl6eFpobTJLQXFrNkJuU2Vwb2NZcDlwc1ZlOThkZzNBVUNU?=
 =?utf-8?B?V05NTkw3UklkS0RrcUhyaWZVSVN3QXVCY1RtOUgxV2NzR09wdDRnalpZNjNO?=
 =?utf-8?B?NStVTUlaVkRhSVpxSW1BUkFhTGM4dnNZUThTTlBIZWpvUFl6MzZRclBFdk9y?=
 =?utf-8?B?d3VtSDkxb1JScDIrUm5sUmo2TnFIV2xzSmQyRzBvdnYxc3lEOEoyck1POURq?=
 =?utf-8?B?WXVaNkUxdkhGRm9wR1orS2xMOWxnS3dnZmtldkpwZFFiRCszbm9uTVpjeVdP?=
 =?utf-8?B?YjRaSkdaZlZMVkg1ZmdxeFBtRFl6Nytkbm1GUlc3QW9MUWN1eVVpM1l6cXBE?=
 =?utf-8?B?TlVtb3BsY25BSXgxOXBqZEtUWWlIUXNWRlZqSnJDa1l5NU9Ra1BDSHhNekZn?=
 =?utf-8?B?b0IwdmIrM05DYXpFYTB4bW42Rlg3MkV2cktCYXQvaDFkZTgvMlVMK2I3YU9q?=
 =?utf-8?B?SjZETDNTcGdjUjlxd0pZVkJvWU9pRmdnVDE5ZmVPeFRDSmNhVngvMzZNMmZw?=
 =?utf-8?B?b2VmVG9zN3BYUGtNSEhhWSs5VFdNUWpqMDA0WlVFRFo0b2FncE4wUnZWRlpL?=
 =?utf-8?Q?hcl0HHsy8qPIfhI0RW2RWFw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZOTWxIYzQwRHJvVHBtSEVxMWpieDFpVGYwR3M3N3dpUXFaOVJEek80MDFw?=
 =?utf-8?B?OU5OZ1JyZVN0ckRrSk41azhJWCtCZFBNQjVKMmlIQ282T2VLNWNkLysrYVR2?=
 =?utf-8?B?K1V5bS9vMVE0NDZ6YzcwcVVmL2pWNEZwTStqdXI2N0xOWnB0ZmROLzdvRjFn?=
 =?utf-8?B?NVRnbWlLci9hSGF0bFMyRlUvOUI4citXRE55MmVOaG5IamMwUlo0ZkhoWURG?=
 =?utf-8?B?cGgzd3lUMC9NN1VwL1lMN2N5UXhYallVMTdDWkl1WlRSZzBLWGJ6ZlFYWjBG?=
 =?utf-8?B?TFFUcWsvckJ1M012Y2gvRVk0cHpUSkhRWHo5amx0WnJHc2lUcXlzOW9rR3FS?=
 =?utf-8?B?QmNwaFlLQTRaVUsrRXQwOHpsVlpseXN2bitBVDllOGNDa2ZWM1dJMDJGZ24z?=
 =?utf-8?B?aHBwQlp2OUsydXplYmRkbWdhODVDSnhTTUp4T0huR0hsczJTK1FNcFN4K20x?=
 =?utf-8?B?TUVPd2tzbEVBZUUvc2lOVFdmcXlTdVRHeHpoaGhnUjVYekVJUDBsSVZVU1dn?=
 =?utf-8?B?V3dRZU1GZUZrYk9MYm1NancrZjZNYlBubWorT1hza1lpWFNpUjBxZ0d4d2lk?=
 =?utf-8?B?QnZRNkgrdzNBcTdXYU9OV3RzNkdQcUwyY3JKZmExVXNPK3RYWVRIYmJ4d0Zs?=
 =?utf-8?B?UVZPOVFHVUJJblRiVjByMStqNWlBbDFRM1Jmckh4dm5mU1M2SEFQVGEySis1?=
 =?utf-8?B?RFN6S0h1YU5RUWQvdXkrK1VKV0QyTkIxU2VTT0dpVk5TOVdyZS9PcEQxdVlG?=
 =?utf-8?B?ZnlNaE8xTEpOUldXRDVpbHJXVjNPUFI4OWJ1dElpWFFXNVlxV3NhYjAwS25K?=
 =?utf-8?B?M25nQ3dkcXY5L3RNeXp2TmFYcGQxVGJrdytkci96MW9rOXJpdWZOVVBwWDFS?=
 =?utf-8?B?bFJXaXVlcVQrdlEyaWR3UlkyNzJZa0UyOUdoOXR6TS9IeFZ0Q0YwR1BxZ25X?=
 =?utf-8?B?KzMzVHRUOGhsbFBUblVvY2FrbXVFRUVFM3N6SnJSd1RYdnExL1ZCV2NDT0F5?=
 =?utf-8?B?OFVTcFY4Y0FJcC8zZXVDWUFDbm1DaldsSU1FV1ZsNG9VbnlGOWxkdkIxeUUy?=
 =?utf-8?B?dDZ4dkNDM0FMNUViVGloR2ZFMjErNTUyZG4reXJ3ekVQSnE2bDhycFNQRjBi?=
 =?utf-8?B?VGpoYVJLYXBDN3dlRTJocjFLSWczeXFsUitmbHlvWTd3U1R3UnF0Sy93ZlQ0?=
 =?utf-8?B?b3g1dm13eEp4YlNkWXlUM1EvS09sdk9QejNXd3BVNFJyM3dncGZwN1FvZ2xO?=
 =?utf-8?B?bG05Z1JGOFYxRlNObWk1c1NWSERNdlZJeVMxd1pFbjhQZ3lWdit0dzY4ZXVG?=
 =?utf-8?B?Zm52T2ltaHF5RjZBZnJ2cE1HMERXQzhnb1JBd3NXM1BOanl4eWY3TlZSSHg2?=
 =?utf-8?B?WUtGS3hKYXZObUg2dnR2MEFTNG1HYlRVZzNLdzVudkJPWWhnREczWFpUOTVM?=
 =?utf-8?B?OHRrcVQ2VWw5WnFSa2xXZG11dldzcEpLZFVQY1UzeWtjeHZJbDFETzlwT09W?=
 =?utf-8?B?SVA0ZHF6aWRFazJ2Umx2WTFPekpXUmdySmd1VG9ubHRod2IxVVdocmt4RE9H?=
 =?utf-8?B?b2FYYmk5RUdRYm03SFBEZ0tiaXhMYWtwV2lpYVJTK1F0ZkgyaGR4U0U4Y25U?=
 =?utf-8?B?N1pja2twaHM3TGxNVlpEeVFPMFNDcmUwc0pvVGxkWk56TFI4aCtJaWRTSUR3?=
 =?utf-8?B?Um9Ra3BKSFZSa2h0aGE1SjlFdVRidkxZQ25WREtTQnJDajJ6dGh4QVUreGVH?=
 =?utf-8?B?TFZIZGZyTjEvV0o0aTBEK3dMY0haUWhUMVFRbkdCSWphRHREeDR4dXVCR2RP?=
 =?utf-8?B?NGJ6RlFsZjNOanZVUGw4VjA4dURwQTUzckMxUlh5cFJYRWExaTBrS1R2WGE5?=
 =?utf-8?B?YXorL2ZTcS80bVFBejg4SXJHS2l5VER4SW5zQ2wrWDFXQ2tFUng1MlY0OU96?=
 =?utf-8?B?K3llY3pLWlMyaDJ0QlowQTVaZnhWV1owSmtveXNSL1VJWUpuTWVBeTB4RFdk?=
 =?utf-8?B?OTgyVkNDZit0YmhqaDg0ZWN3aWo5em1WZ2E3TVdteWE4YjB6SlFwSUVRK09W?=
 =?utf-8?B?UFp0M2tzcFcrb2dQSzE1WUR1NUVtVzBLbC9HRlRhcHVaNVlHYjBDZEZXd1JG?=
 =?utf-8?B?QzN6K2kvSGNMaHFyUytqVm9mUllPS2llVG1WN3NQYzZlN2x3WmtPM2VKRWpp?=
 =?utf-8?B?eHNMaEllbk1OczM0QnZOeUZWS0F2TDdpTDR2NkpRQkJqdDd2Rk5sNUxtZGNr?=
 =?utf-8?B?V0JDTGxZMS8rWnJrUjBNaXFFN0x6d3FBRTJOeUZMS3hmWmJUbjJQdFFpNHgx?=
 =?utf-8?B?OTB3aFVEMUI5bjFpVXIxeTdIaDR3K2NxdHh4alVJb2p4aWl6cjZSdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee422a5-d24d-44c1-ee6b-08de677aa281
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:29:14.4521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+wksDkgpsPqaC2DubHhdT9Zeml0mSR1N68x5JXsAbxqw7+AghThiPBZxEaqR9N/eeJYRYgtUcAF2IveoVFYWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491
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

struct bd_info is defined in asm-generic/u-boot.h. Include it to avoid
building error after asm/global_data.h are removed from this file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/renesas/common/gen3-common.c | 1 +
 board/renesas/common/gen4-common.c | 1 +
 board/renesas/common/gen5-common.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/board/renesas/common/gen3-common.c b/board/renesas/common/gen3-common.c
index 94da00985d34049222a2c5aaec650d03dc2aec85..f89ae81e95ec551b8b254fd0fee0b9839f798b85 100644
--- a/board/renesas/common/gen3-common.c
+++ b/board/renesas/common/gen3-common.c
@@ -16,6 +16,7 @@
 #include <asm/io.h>
 #include <dm/uclass-internal.h>
 #include <asm/arch/renesas.h>
+#include <asm-generic/u-boot.h>
 #include <linux/libfdt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/renesas/common/gen4-common.c b/board/renesas/common/gen4-common.c
index 38fba7a5ea77778383d29f2403a585bdb54994e9..81c6f6f4c6ddbf78f50657bef9a31a4f3e8e6099 100644
--- a/board/renesas/common/gen4-common.c
+++ b/board/renesas/common/gen4-common.c
@@ -13,6 +13,7 @@
 #include <asm/mach-types.h>
 #include <asm/processor.h>
 #include <asm/system.h>
+#include <asm-generic/u-boot.h>
 #include <image.h>
 #include <linux/errno.h>
 
diff --git a/board/renesas/common/gen5-common.c b/board/renesas/common/gen5-common.c
index a05a3e8abef46f55ae649d11741ad45797090728..3b724e59049c0b451b6e346a6ecb9846c3226e97 100644
--- a/board/renesas/common/gen5-common.c
+++ b/board/renesas/common/gen5-common.c
@@ -10,6 +10,7 @@
 #include <asm/mach-types.h>
 #include <asm/processor.h>
 #include <asm/system.h>
+#include <asm-generic/u-boot.h>
 #include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;

-- 
2.37.1

