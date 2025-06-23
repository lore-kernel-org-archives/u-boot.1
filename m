Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7E9C7115D
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 05:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA99481F66;
	Mon, 23 Jun 2025 07:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GJi1WOHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F1CA81FEE; Mon, 23 Jun 2025 07:52:19 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A16D8006D
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 07:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAS6JugPpppNzSUxbJnATx0YQxiAOLlfB+ytlGRpEVD1qmPsomJyzo/BXJA7NVY40MNl2FNLyda0oywyEk+pKkWQfpQzbzzBtAgbw8Ft6CH9BrE/EHwVOoI1iZhJH/PCYQLeV8YAwKbaMJY+Dw+inA2LmLfXodWyF6I1d7XrK+C40bxCG1+XWz2uJ+Jom1mLWAUffybIijIWEPlIcWkctJ8d1xEg5hszy2N00ZCbp26fBQhZs8+QLqbutfluFe++gQPrGQsfxxpvDBEbBCIKtEE/D6oWTljQXSOLXRd+/l96Jdcps3jqU0bl3oxoxEyIN44AalS5H/nQ6KR6GtKWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTRmNZhHCFWzgYKVjVhPsBUX/a3MB0tuGL3HEJ7Zb+w=;
 b=DfyFD3t5idip1VIBxRK6ipUk6wf5PWnSf/Av+ZfqnDDRDddy2KI/rTvitCDIPxw2ELj9z3KgBfZINWW3dRWJT/m3Np7PM/+DTC4beoZ6vvGRjPHgbEcc949As49Ub+/Jc+JsN15Via5CTL/8kx94PxrHMYFSHz0f77I1mVzOvLfZjpmZwll9c+89acIWKz6qNNruWAc371MY++AQCuvpyLJl5AD13RK9igSrCXO7TwTd6YdtOZA8G7b1PHo4snDKCl3INI2VbYBQeeWH0Ad7LLu7fNZkpmv48zOBbpQWQW6viOeNSV2GLk4k/JyRb4Lb5DIFIdjRjwHbjSjYJbcNkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTRmNZhHCFWzgYKVjVhPsBUX/a3MB0tuGL3HEJ7Zb+w=;
 b=GJi1WOHySS2tid64iZEccDpE8BxABGvIVjbfuSqp/Dwt7VB280aKjXz/bAvm9vtBg8wUKYrlyaQ9s2pEJXei8f2BGeaTJafHNH/vJNXF5jf1rMgotGMEk1oDsA0WvDszUmU+wOZ6Wot7dBCUfrr9OAtzL7oxu52VZYJZA0I2uMW6xuYKLykQGHlihJXIjuKxeqQ5J8P0ZDDA4hQn5sIuSI1yGu5TKn62yh5eOXKAHXSfkD2H0npJS9Ve+EMwGDLL16yelqmUnhb8AZZ6JSmXiOfO0qe09y6i6UNvdsQxUNWO4tq0asGvAh66dIeTwIBVsF7P6y5GUR3aJJVP/+S2Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10671.eurprd04.prod.outlook.com (2603:10a6:10:582::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 05:52:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 05:52:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/5] imx: Support capsule update
Date: Mon, 23 Jun 2025 15:02:28 +0800
Message-Id: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAX8WGgC/zWMQQrCMBBFr1Jm7chMQgu68h7SRUxHOwuTkkiol
 NzdtODyff57G2RJKhmu3QZJimaNoYE5deBnF16COjUGQ6angQ3mhNYJ+Qd7P5FAOy5Jnroekfv
 YeNb8iel7NAvv61+/7HphJBwsM5Fjtq6/hXU5+/iGsdb6A21Lp/2SAAAA
X-Change-ID: 20250612-sr-3ae0cb1ccd0e
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10671:EE_
X-MS-Office365-Filtering-Correlation-Id: df757566-f621-417c-dfca-08ddb21a1aa4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEdkOVlYendXMEIzQklwTHJ2c0hRNXpTTFdOa2VVaDdvbHJhS21tdUQ0QnAy?=
 =?utf-8?B?UUNZRGw3OHFseVpmWWhCakVJSWVMRVk5YnprZElBeklTeU5WUUJnQWdmWVVy?=
 =?utf-8?B?dS8wREppSHlYTFYzYUpja3N3OU9Za1NPYUQ3cEN2dXpBK0R4cGJnOVlQcDhw?=
 =?utf-8?B?WVlBbEt0R3EvSGFpQkordVNmd1BBaU1KbGFEYzhaV0hsYysvN2NkRTA4Sm1B?=
 =?utf-8?B?T0REeTZtbkNON3hZSVlvTVdSMWpUZmpxVjB3bCtJZ2V1Y0xtaVRGWVU4eE4x?=
 =?utf-8?B?a3F3L3IyMU8xMlIydVV3YlRPY3UwdGtRUjRPNjdnckJDS2pjZGJyS3ZoRzBC?=
 =?utf-8?B?ZTdtZVRWaHJuSnh3dmIzMUJuTGxsdHQvZTFvSTdBeTBsSGdGWUJWQUFQaDkw?=
 =?utf-8?B?ZVN0UytpNm80eDMwbzNZb2RvajN0VzR4V0ZENDIzNGl2ekZMeDFybHdrWWxz?=
 =?utf-8?B?Z1kxNGVXZzAvUnVXeFREYkplWmdtTFF6YXhYR25KU2xRZytnem9oVVZDNEJt?=
 =?utf-8?B?U3hBU1dXYWpUZFQxUnQ1Q2U4eDlOdENvNVFBcElPZlRvTnUzM0ZLRzRxTmhz?=
 =?utf-8?B?SHdkV2ZKdEZYSlcyd2NsQVZLSnE3L1dtdDFGVFlHZUx6MmZqZzZGYk1ucGxi?=
 =?utf-8?B?V0JsR3R4K24xTFAxSERONHFuYzhhVSs3cDNKRXRQV3hoWVZhODNVSSs3aUxH?=
 =?utf-8?B?QmtnUEp0MFBPOWJyU0FzQ0wybkhCZ2pvYlh0eFNvSGcyaUN5dG5xTGo4WHhr?=
 =?utf-8?B?czY2Z0plQVlWd1VsQkpITmQvc0JCbHZ2NGlia1Z0c3ppYmdLbEJ0YjUvL2ZH?=
 =?utf-8?B?YWt4REtUZlNhQkE4U3pveXNiaE9VYUJydEFZdGd0R2Y4bkwwYjU0SnZ6R3dw?=
 =?utf-8?B?OXJpaUozSHk0WGNHb1lWaTJKSDhWb3RESlE4aFNiV1hqTkNXbHlEQWZINWFH?=
 =?utf-8?B?dzBwYWthREpuaHF0d2UyZmlEeFlkSEdFMzBSckFnN3B0TUtIekpHTHdLOXcv?=
 =?utf-8?B?ZXl2bDFUSytpZjArK0g4QllTZHlNWkJXc1Fxay9mY3RPV1lIYVBkcmp4MlJu?=
 =?utf-8?B?b2k1dXBvMkZKdGdtSFlzdkhZK214YjFXL2RFMGxzU2hGdlBvcjVtcEwxZ0JY?=
 =?utf-8?B?L2ppMHc0eWZha1VyOThIWW1KODREbmc3R0FNZWg2UjBqb2taSGRjSk5ER0pm?=
 =?utf-8?B?dW1la0ZkU2RCc1BCbklqaFZoZlVUU3FSSmZYQWJRTDM0SXlwOUFVMzQ1ejdG?=
 =?utf-8?B?ZjJXRm5Sa0h1d2d0UHFScHZ3WjAvV1dTOGl4OUtYOUJrN3gzU09BWjdackJh?=
 =?utf-8?B?b21LampNbkxZdTd5RktWbzBQZ0tMRzVQUU50alBTOUZ0ZW8wVkhQWnJLby9q?=
 =?utf-8?B?SFRHT1p6YnU1UUhPL0FXWW5Ba3RSOUtReFNpdTFKOERyYkFYbGZGMGphbEg4?=
 =?utf-8?B?amZHS2NoZlZLenV1cnpjZ1VldzUvWi9tRklsajArRnNnRy9Jei9uZDMwSWlQ?=
 =?utf-8?B?Zk1PNmpMWnpSRXFibDE3VFI1cGk1RUJvYk16K09tSjd3c3RSL0QwMForS0h2?=
 =?utf-8?B?ZHpJcXJVcjZsQjRaNktvSW1MVzFjZlVWM2hQYVlGejBjSGFLLzVKb2JnbkQ0?=
 =?utf-8?B?VHFiYmpLSEwvdnpkR1cxbnJMVG9BVy9JeGlKY0V0TGlCbWlGN2ZPQmxZc2I4?=
 =?utf-8?B?R2dxMlBGQTVQZy9TcWVOUjBVUVVhV2VZQ0VJTUdkQTlnUXZhSExnMEJZM1dv?=
 =?utf-8?B?cW0zRm9uSmpWdGVDK0pWL2V0Q1lNOXhSRXVJNjM0Qi8zZ2ZJemZTd3NvVGFZ?=
 =?utf-8?B?YnNOeDJjT2Y2RDFRMVh3VVViWmhPL3dKTXlPNjc2MkpyTWxKM0FOcjdDb1lr?=
 =?utf-8?B?NUMxWWEyMTB6dXc0UXhKUVIreWpQbzBrOUFPZmVPTFZBRk9pL0g5aWlrQVpK?=
 =?utf-8?B?RUx6clhOci9xbkM2VTJGTC9DUzJBMjdmbTlXL3NvMVVJVm1HWk5mRmZ2QTdW?=
 =?utf-8?Q?5SDWhikhZt3Cm3C/D3wtgAGauhLjQM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDROb3dWWG1ZNmFsSkV5R2c5ekl1RDMwVmo5UUJUakdMbjVKMmdtcjA1Ky9U?=
 =?utf-8?B?WWtFZklwOVFsdTFUQjFscnVKQU9lQW1leVJINnVLT2VLZE9ZekJ4eU0vQUVl?=
 =?utf-8?B?TTM2QWp4alJPOUVOTit2RVZUTGloQmNHbEJVK3Y4RUNNMzQwU3dOOEN6T3Z5?=
 =?utf-8?B?K2ZVdWJjRTF3S2RGdCthRUd5ZnVsdm5mL3B3Z3gyVktneEpiTFVoblc0WE5u?=
 =?utf-8?B?QW1XaGVlSnZLOEU0T1Q3b1EzdVVFMVRlRHNaekN5RVBGR0tLU1BGU0tSOXR4?=
 =?utf-8?B?eEdLcXUvQmZ0aW5UV3JUR01aRDBHQ29VVDZtTjB0LzUwR25DMk4xeE9yaTA0?=
 =?utf-8?B?V3RaZTJOVHZkMHh1cEt4TnVveHFwUjRSdFVtcittY2ZveDVmalhjWFQ0U0li?=
 =?utf-8?B?TGpjdURZWXBjc1VXdXBtcitIMEJjancxUy9wVGsrZU9jVm4yVDYyWG5Jb2Jt?=
 =?utf-8?B?cGhraUJIaGRDd0NKeUhNVjFnYThaTUJjUllqTExSV2JrdFFRK2FXbWlDRi9p?=
 =?utf-8?B?MlZuS0xZZXdiS0xqTDBTWDZtcGlkVDFySk5ZWURqSlhDaGxGZ0NEcmljWC93?=
 =?utf-8?B?TkZ4RmRzR004THkwZWppWW9GbTF6Q0ZWbGhOZVFxcW9KTFJwbW55WHNUMVZO?=
 =?utf-8?B?Vys3K2lBTXhSSjhUenVJNnYrZEJkbGJldU8vQjJYMzJ0dXhiY3N0NE5VUlZm?=
 =?utf-8?B?cXlRVE9QOFRYYldleFl6Q0V4MzR2MFc0SVFCTDU4bGx4OGI0SXY4aHpCV1BD?=
 =?utf-8?B?NThKODd4ODlnRkRzY210eTU0VHhNRFhsakpJbnMxdWZWL1Z2d3pmU28rRWt3?=
 =?utf-8?B?TXBmS0JMOGVyVDJiMzU1V1lpNzlBQStTalBWMXpnbWtQWUlZNy95MCt1eFJm?=
 =?utf-8?B?WlVDcGd1bXdIMzRRMkpRbGpYYWNZcWxEc1pSQmF1N3pUUVpMVktkdkhDWENX?=
 =?utf-8?B?WXYyY0RRcWs4bXNncjFPb05OL0JDN3NRZHVOdDhRKzVVaVBCeXdTZkZTSjhU?=
 =?utf-8?B?UUkyenRXVm9yektmM3J0ZTQxRG0xb2RkWTBIVEdZd2RHbEdoTko4b0IyOXR4?=
 =?utf-8?B?ODJNak5US2hKYXBxaTlYdk14SDdtSUdaek1WSmYyUXV2VmtPZlJpUVgwMitR?=
 =?utf-8?B?VFgzbmxUMVhYUVNiYnRvejVwU3IzQ3ZlNVZBR2lYWlkrZWsraTdUSmVmalJO?=
 =?utf-8?B?SnMvU29nSjRSTldjYitjRXdMd1F5emtXNmdTblVudXM5Z0I2SzV2VGY2cGdQ?=
 =?utf-8?B?TlBNLzZpa1FwRi9VcFBJVXQ5ZjF5dm9XUDJQRUxtekYvTFU3L01SWUc4UUVt?=
 =?utf-8?B?VTRuQ09oT0pmVnNRbVBpMktnZzJrNTFLcnNLbUxEeXdYMGVsUDdEUTJ0TU1C?=
 =?utf-8?B?Tjcvai9tQVlSSGhOQUZ0WmtiQjJLWXZMSU1Mall3cEx0RzR0cG5naGVLclFq?=
 =?utf-8?B?NVNvRWdSUmVoM3o2VGZWR0NQN2N6OHBiZjFNV2dTKzRPZEFTYlF4R2NQam9i?=
 =?utf-8?B?VEo4VEkxQ2FZdHdYWXczdk5UMDdoWjd4V0RvRUxkSVluVit1N2szNTJ5ZFlV?=
 =?utf-8?B?YVI0aE82MTdsdGpSTzF3eXg0ek4vbmlwN0x4WDJRYk0zUHpBYnJTRWx2U2kx?=
 =?utf-8?B?QU9KbWFFRDNOc0lxNklBS21RWk9SK1R4STJ3THFveWZDWkJZMmlmbkVLN0VT?=
 =?utf-8?B?SEZhMk9LcnJtdjVma1FNRDFNQzNZRTdmQTlyNGJ2V3VMTTl5SW10V0dieG9L?=
 =?utf-8?B?OVU0M1pyVW1BbFlWdTV0U25ZYzNPa1F0Z0J3NE5OUUxwMkRlQTBnMytLSGRj?=
 =?utf-8?B?MmlqMVd5M0pSZnFnQzZOUEdJb3FwbVNjb2JmQVppUDNVdFErNTM4UmgxZkww?=
 =?utf-8?B?clBpckh0dlg4YTZ5aUNoOGNCUjlpMXdvenk4Y0lFa3Bua1VzRWRMb1BqbjlE?=
 =?utf-8?B?VFZaRnlhRDNpNmJLZEpLNHpycEhicmJSZnJoNU0zSW1ON05DNlBIUVNwaFBN?=
 =?utf-8?B?dGtqbnd5YldHc2xOVkkwSkMzWjBLR0ZMMjZOVlZmdVRVWFJqT2RIYllSSHBH?=
 =?utf-8?B?MERXRE8zVlhpMEdmUHh2S2JFS1dGbkxJemNWVytBc3ZlVWVxdjR1Wklrai9D?=
 =?utf-8?Q?AvP9P5iBxWNfBWxR0MmLThy/Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df757566-f621-417c-dfca-08ddb21a1aa4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 05:52:14.4330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37Oy0CZRLiCAvQhelJFpwC5AEH+AP088jSNY3S5+vVg3UDNCBAaPN3U15U6guRdNyj/Uy+7/xIFQxPtsyGEDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10671
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

Support capsule update for i.MX8M-EVK and i.MX93-11x11-EVK.
Currently tested on i.MX8MM/N/P-EVK and i.MX93-11x11-EVK.
Capsule authentication not enabled as of now, this is on TODO list.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250619-sr-v1-0-631100a113a5@nxp.com

---
Peng Fan (5):
      imx8mp: evk: Add support for capsule update
      imx8mm: evk: Add support for capsule update
      imx8mn: evk: Add support for capsule update
      imx93: evk: Add support for capsule update
      imx8mq: evk: Add support for capsule update

 board/freescale/imx8mm_evk/imx8mm_evk.c | 22 ++++++++++++++++++++++
 board/freescale/imx8mn_evk/imx8mn_evk.c | 22 ++++++++++++++++++++++
 board/freescale/imx8mp_evk/imx8mp_evk.c | 23 +++++++++++++++++++++++
 board/freescale/imx8mq_evk/imx8mq_evk.c | 21 +++++++++++++++++++++
 board/freescale/imx93_evk/imx93_evk.c   | 21 +++++++++++++++++++++
 configs/imx8mm_evk_defconfig            | 19 +++++++++++++++++++
 configs/imx8mn_evk_defconfig            | 23 +++++++++++++++++++++++
 configs/imx8mp_evk_defconfig            | 15 +++++++++++++++
 configs/imx8mq_evk_defconfig            | 13 +++++++++++++
 configs/imx93_11x11_evk_defconfig       | 14 ++++++++++++++
 10 files changed, 193 insertions(+)
---
base-commit: a239cdc0bd4bfe5fce82368627fc55a5fa632e3a
change-id: 20250612-sr-3ae0cb1ccd0e

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

