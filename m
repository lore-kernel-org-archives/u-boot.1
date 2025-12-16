Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39F3D5B87C
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 06:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6B583869;
	Tue, 16 Dec 2025 07:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F2+JHEX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5147E83710; Tue, 16 Dec 2025 07:40:08 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C838003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 07:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0/euLrZkAOyJql9/CGAyhQ//6MSc0LHt8HEgvP8BKu983UZ0w2XRijyh7UiLjKRaLU7JrxeHOiecp3YE9ZsH2gOfMULpyPfSxsLn4A3jMGcoZ0ynmySivxoAoQK9VT7cUuVCQTPGwFWcO/QpWabUscuNvdduIDOIqIpdBvwMxYcxfsF6j54CQeuPivnvoBx7vCftkROyhozeL28b+UUurMEIxnvq0s3Ah0hMtcL6wCq7shoDFDyGvp+UC2qxi1CPOc5Hrcn5OzTGm9i2Pb0OdDxrkBOZ3hc+YbfRvQVxvwY3l5ZiJe6UjXh+/T2wF2RjpLFAWXkFSVaogOzg6cqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ljnpq7W7HrkLp46qo5UVWxo7SP3dRt3iqZ7dceAoZPU=;
 b=vRpwiauF2pIvjNxgf6rIbaHR8o1AfBDkumujb4GQnfenozIDVTRtTLIGFedcJAtOnqS0F0aDYir36f+jlCBBDg/bfyiE++cTOfOLfQcytmL9nufKy3EC6KF3JD+ZAKfrMnM81F6m+JojKhgO6VtP4mOrPgyCF7fpOgsw/TYUvdzDU5LFV46v+9lPvFTWyxIFfefbZoC5nUc82OUSh7rZYawt41UUnFOgPwy3dNqI2iw9b3mLJoz4gfTGr2qf31gRJ9lgLvz4SYnEsAUCbdF+o7f0cpEZntdLh/Wx2g1BwdlB6muvbxbUUwtmAkf6mG+xuXXvmctAUZLhrtlxmHyL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ljnpq7W7HrkLp46qo5UVWxo7SP3dRt3iqZ7dceAoZPU=;
 b=F2+JHEX6ixJYBn75YOY7r9DIizA24zxQ9Jjq4VCpte58METlnB8rAO4oWqbZbzOuQ4fkjHAAIE1n6Y/iPIoQfKDxf216lMmro15eWc4herx+VVcdYUwHnwWHcVkF0fszMrOM9Q3TT7yx42ksUPzTz+SXL11gXGnnl31+nhhUcfr5mvF6a6pirkhAOYkJTwezMDezIzizYTfr8YtSKhq369hIBlt/JwpeDUxHstcHukDFnpF9BR0crVhOPcHLgcPCMj6BBkYn59yIiZz5Nv8QopTE1W6sE42tUfZFPKQu4SXbol24lvnbgPUOBvIaUiuy6qHM8hKGb6xjDX53pVOJVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:40:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 06:40:04 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 16 Dec 2025 14:38:37 +0800
Subject: [PATCH v1 5/7] usb: Kconfig: imply DM_USB_GADGET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-imx8ulp-v1-5-504115a53020@nxp.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
In-Reply-To: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f06abfd-8b70-445c-f833-08de3c6df24b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGo5UUhSS3pBODFwbXBWcCt3Nk5YL05UeFhzenFDSG54QlVnYWg1VTF3Y0hI?=
 =?utf-8?B?Ni9TVThPeW1YK1c1MnAwa2cvRVBSSFBZL1hoSS9TV3lLQ20xdktTK2xYWE8z?=
 =?utf-8?B?eE8rd2hHTEY4bXVUT0VCdEVOdzZaMHg5UmFGUWx3NkxvZjA5TDErTDNvYzVW?=
 =?utf-8?B?cVhlZDRURFYrQlArVDdRajM1RlMrejR1V1l3empsalVwRWw0bFZZSTZWTEsw?=
 =?utf-8?B?bWlOZFNmQy9vN3YxenNwYWpWWWI2Tm1hVy85bUVWOURSazNLYVZiQ0xLQTZ2?=
 =?utf-8?B?UlN2WTVCNThydE9DeFA2eGNPUUVoelRMcHBSaVkwOVc0NnZTZG1iMGtKbTlF?=
 =?utf-8?B?TUpxN3R4cjZweU1XM2JTczRHSFVvcVA5Mmc4MWM3K1RFamFOdk44ZVRzcXdH?=
 =?utf-8?B?c2lZL2dmdEZHTFZlOXFnK3Z4QmxYWUdJQ1FiTEFpQkZDRHFJOHJJdmJNdGZq?=
 =?utf-8?B?aW5VSjhBeXRqM0N3RlJoQ2gxSGR2U2RkbmhSVWtYRkMvT3lzV0JXb1ptUGw3?=
 =?utf-8?B?WWxrZW5SZTUzbDJWdWFXWUN4K0NPYU93SitWZlUwVE1ucENwMFVMMEwrK0l2?=
 =?utf-8?B?RlFqVU9oVkxVOGxXY0YwWHU3Rm1zSzhSNEs5Q3VxMUlCWUZaQU5Db29vM2pF?=
 =?utf-8?B?ZXlQWk1RTWdVNFBVZ3p0eTVJclc4QzVUSmpwL2lkbnpta0dBQldwTEdYdUFB?=
 =?utf-8?B?SXZteHVTZHdIWk1yK0w1QVZZcXNXN2FFVWcxMHdGeDFYaktzQ0x0eEJVdWov?=
 =?utf-8?B?L3Exa3dod2NWUTVyc0ZmeTFJbnVNdzR6QUd1bTZUQVR6WEg1TzN5dEo2dEFL?=
 =?utf-8?B?SjBQczRxWVRSZ2ZVZ2NVNzZUaDUwQitBSjByTFR3c2gzTVc5S1lYNFhUMWR3?=
 =?utf-8?B?QkZwMndtVGU1TkdTZFIzeTc4dmNwWC9PWDFSZUllY29Vd0xueTV5YVEzY043?=
 =?utf-8?B?ZDg1YkNCWlJQNHZtWXhJUDdhNDlpTFR2Y3Z0RlFWUGgvSktpSHdkMVA5U2Z3?=
 =?utf-8?B?WTUvS09ZRzZQMzlTQXNtcVl4eTQyOTR3QjQrY0dOOHNwVDZIeWNpYllib2lx?=
 =?utf-8?B?UURQOWwrc2Z1VTJ0OGNPRGtkUXZ1WkpjQWFTUFE4ZUk2c0ZMNFhTdWFiRmdD?=
 =?utf-8?B?U3prKzU0RkZVSnVlRDNSZkwxWDliSmw0TWVERSs5aS9OemtDZkhRSlBVR0VS?=
 =?utf-8?B?YjI4dUl3NEVhbDRpS3QzbW16Q2tGcEVpZFgyY0ZvQlZhSXFXdjJvZUcwUi8r?=
 =?utf-8?B?aFQ1K3JOWm1MK0lUd0xYdmIzOUtrVmN2OGhuMFpwYzd4R0hTdU1FSjNwTkta?=
 =?utf-8?B?QkFpUTYwNzUwWnYyajI1QkhJWi8vUkUvWlhvK241Wlk1emJ2MDcrUHJLb0Iy?=
 =?utf-8?B?MVBZNFAwMW14Ti9CYVlaQ1FaTVI0bGo4M3FZYys5TWNEa3VBT0xUZEwzUFMw?=
 =?utf-8?B?amZUOEZhYVVKSzkwQzNUMDF0SWlJUVVrWU9iL1BhZTNjUjVaM3pRRnYwdWN2?=
 =?utf-8?B?bWZwUW44RVFRczdETUJHMmJEMmVacFpESXgxTGRLUGR3SWRpbll4MFVwVzJl?=
 =?utf-8?B?aGd1VFB5dzhiTk5tL0F5WVpBR2JqbklOWDh5YjNYcWF0bmJLZlB3allnYU1J?=
 =?utf-8?B?SEJMcjNlZGlhQVZORE9QMHRjNWI4WEM4WjNXVEhHemNaRDhTWnZyVHhYQnRW?=
 =?utf-8?B?ZlVFMHN2RGNpWTYwdE9FdlBDVzNCdVVBbCtDcTZ0THg4MFB0b0JKeUs1bFRu?=
 =?utf-8?B?TlB6OFR2Y2QzUUpjNHlRTXVwUmtUcFZSSUhqOE1hRmo0cWQ1SnduaGwyZlEx?=
 =?utf-8?B?cHlKbHp6bVRuQnBOclNiNnhxNGF3SG5Rb1NtQTdYUWxkOVBteTk0cXUyOEs2?=
 =?utf-8?B?TDg5VjkyRlZTMFJiSW1sMW9mdTNXaEFzUDJ1QlgwUG1XZUpLeU1aMUpONWFv?=
 =?utf-8?B?YVB0ZDNvOHhXN1N3eWRmazgyNHBrV0M5eFdWOWF5ZGZkTlBBbXhmcVZLWFdG?=
 =?utf-8?B?amY4YUcvendYemxsNThpdWdsdVdMM0VEaTI1WW9UbEdZSU5hd3BWajgydWhP?=
 =?utf-8?Q?IZYNIE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXdSQXIzbS9QZXRvcWpkMWhGN2QxVENYbnZVWlhwVHlQTXZyb3BpRDVtcmlZ?=
 =?utf-8?B?czQ4N3pxYU1TMUQ5eUZzUXJySzhINEZPOFpaQ2tuM0k0aFdSRHVudG1RZVpF?=
 =?utf-8?B?enRMam1LUnplOTFNK2YyOXVEVUxCaVRaK0xxSWxQWVFvK0dMdFROSnYwaWJs?=
 =?utf-8?B?QlFKeG1aRkx3SFJjeGgrNVN5alNqV3RjajVRNFlUcEt3MUlSSmlmSStOR0Ey?=
 =?utf-8?B?aGpwUnROb3pKRjdITTExM2oxM2dmejZDZDZONXZuVXBiZEpPMkpPZDBEdlN3?=
 =?utf-8?B?UW1GSGp0eW9oRW5TYS9VMWVNQmJaMFVVUUQ5cnQzbHJrTjFFNHhaWUI0WUUw?=
 =?utf-8?B?NG82OTBSQXg5Z3lkbEJ1TTZ6cmE4N0JvaEZtRGlLR0JrZmhKOUVnbVB2Ukt6?=
 =?utf-8?B?eEFlNStmSXhPQm5STUFad2tXT1dVMTJKUlVwcWczbjhVNkcvbHJoam5wZEhu?=
 =?utf-8?B?ckVkZjd3dmRRbWVNU1JZMVoyTVdwdmNWT2RnNmQxM0lFN2ZtbmtKdmlVVmND?=
 =?utf-8?B?Y0w2ZVVSd1hrVnpCWStvMHAxaytwWVlpQ0ROczdkclg5aHhCVlNtUWJ1UjZ6?=
 =?utf-8?B?WmZHT1BYbzhycEVVVjY5YnJibW1rTXdqbFllUXdaQ01NbmFWS0RqRFYwQmN5?=
 =?utf-8?B?RFB4cHdsRUVrS2JRWkxxSG5PSUt6aEZlcDZIU2dFbFFSbWJ4MFNnUlM2UFFO?=
 =?utf-8?B?TXVnM2dZK09kMGJnU1Q2RDlBVDlHOHZrYldPZkpGN2MwNVh0eTdCalN5YWdh?=
 =?utf-8?B?Y3JrWFY1TmpUVFdQTVRHYXpQVUJMdlcxNmtYa3oweGwwQmZIRGtrSWVJOUh4?=
 =?utf-8?B?dlpWMmhGREw4UjVTd1FMdnZQRUVXdG1KQWxpNlhJVFNUWXlVYjAxaVdWaDhv?=
 =?utf-8?B?UmYvVmUzbnFBeU9LRHYyM29TdTUxamJaRWNydWhLTkNGa1JEYmlidjZOYmsx?=
 =?utf-8?B?OXJQTWpSeDQzTWtSbW5SK1RuNEp2SThqcks2bkVJeFBZSXQwM2x5VmlXNGtW?=
 =?utf-8?B?d0NTMno3bnR4OGkrbkprRUJST3lvU2xMSEtLZW1Rd3E0NDhYd0lSN210Mlk1?=
 =?utf-8?B?TkJHc3dwYjk0STZsRWNHNTZWUzFBb01UNjNTNWJ2VDhKb1o4L3dkNW1XUVda?=
 =?utf-8?B?MXlNR2M0UldBbUFtc2E5NjBkaHhQOU9oN05wTWdIa1RyL0JTOXJiU2Fwc2hp?=
 =?utf-8?B?UzJnbERLNHBCSVZjT01aa0R5UjVlN3pWa28vUFpxMzF2K3lwTlZ1REI4UGNl?=
 =?utf-8?B?ekpJUFZ0RktSY2p1RjI4bURnYWVMUWloelU4UkxpcXV5QUZsZGxaQ1BxRFBx?=
 =?utf-8?B?R0Q4amM1WDBMS3F6S2VKZGhjVENZNFdlZ2dML2wyYjdEZkhJMUlFU0xaMVZF?=
 =?utf-8?B?a3FDMlRVWDRmUUhPcXNXbUJ0Q0RpRXdyN0h0cy9zTk1yRkxWS3EveXZyRmlo?=
 =?utf-8?B?NElNeGx2VkN3SmZsZTI0bXQ0RitoMENOZTRuWGhvdkFEbkpSb2tCZE8rV01n?=
 =?utf-8?B?WG5CNVZ6YmQvV3dCemFrQWZkbnExVHlPS293Qis1Sm9mai9ZbndvNkp1QW9C?=
 =?utf-8?B?bkJ4ZW1sNlgzdFArd3h4VTZmZkpqWEdXWTlZSGw1cVEvM0g3R01kMzViOFAw?=
 =?utf-8?B?RHl2ckMrSFFiMms3MUNrYXJ6NnA4RmoxWFRqcjkxclA3ZUR1WEo4MjZJOTAx?=
 =?utf-8?B?ZWxUcW1NV3hRV0NVcy9rS0dFYmVTaUhmNlRxbWY2Z2h2WFYxZ3V3UWwyZlJ3?=
 =?utf-8?B?NGVSTW1CZTlYZHhLMzIrNnM0VjNuL2d2Zzc4ckl2VUh3cnFZTitmbkRkd1FO?=
 =?utf-8?B?ZzRRdEEwTnArRkRSTHViL205NjlUZVFLRGdwRGRIQnFtYXBUc2s4MVlmN3d4?=
 =?utf-8?B?SU1vMW96Q0sxMmFHQmMwUkJQUXpyKzZ3YXZOQmR4R01lbGVMUG91blBINFNT?=
 =?utf-8?B?elhLMEZDeE5NUDdDZDEwcUN4SHk4b283MFA0b2VheU8xUm5ETDIrTTVXSnhJ?=
 =?utf-8?B?RHdNb0h1NExxVE5tTjJVclRGaDRSdE9TQ2k3bE4wOUQwM2dYakJvcnR2V3V2?=
 =?utf-8?B?aEhrS1o0U2dSZ3JJYXFCWjRNZ2tGSkVzSDF6TDF3V2F3c2VaNXFqZTdIWnp0?=
 =?utf-8?Q?COalL1VRnZAT18M+zQRErvTkZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f06abfd-8b70-445c-f833-08de3c6df24b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:40:04.9078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8gOAZNCAtx7mq+aW0OT97UyyhqizQGE+9Rs2AmDuO/UJlocc9Q4opjpQx79btN8pu4L30Ki4JFkIczyPXVHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794
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

From: Sherry Sun <sherry.sun@nxp.com>

Since the ci_udc driver has been converted to DM driver, the
CONFIG_DM_USB_GADGET should also be selected when CONFIG_CI_UDC
is enabled, then we can use DM ci_udc driver.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/usb/gadget/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 7e08aeab904..f85bf3d66b2 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -151,8 +151,8 @@ config USB_GADGET_OS_DESCRIPTORS
 
 config CI_UDC
 	bool "ChipIdea device controller"
-	depends on !DM_USB_GADGET
 	select USB_GADGET_DUALSPEED
+	imply DM_USB_GADGET
 	help
 	  Say Y here to enable device controller functionality of the
 	  ChipIdea driver.

-- 
2.43.0

