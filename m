Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3DDC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE1080040;
	Wed, 15 Jan 2025 11:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aTSmgm3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32E1E800C2; Wed, 15 Jan 2025 11:27:29 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337B480027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuNDWp0x2/xxjwz4Yosr6dITryhF1S+WFuEsjj/7qdcFZlym+JMW1/WfB+9DG6IMzb2F3dS48GlUbUgNYvPq/uu1XofzX723+dPmonA0CtWRSfKfqbXezXPhOzzUMrTZ0w+Loak+FplelBCEmqMXb0EiXV1rvt1BFOZZWvSeAGSkWv6VKVYwenC4WLZFOEprsE/Eb7mYnAJZc9Uf1hbNtZK7peH6S1q42ODDrl6tZ1MtixuzBmzPEcjs7vB8VPlaWG0KP65puLz2PwdVg496ZuQvgJm6Zc7kAwLiXkUi7Fir9jBt3iYlpzueuwPv1WEv0AIksYOP8bFAShHpjjGvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4klyxL350V4QSRt2FHbb6aAjp07ojjipJeif4XaRLqU=;
 b=hOoJScoWom8NT1zIHkEv8yE4yZYgcTjv/C+g/8iiPsgBHuR/0kiAjbpmTAdksWIu3+XNxKu6IKQz1qND2pLm+YeNfozDaseOZ6dmauB+bNfpmUP+K9xKgQh99FdON2TOzzbzelmJd0SSIVwYBfpY6DFiHLkmWLqHnhibyCK3llzM4sqHehW+75+Y0z9MMiLRRr+77vrQHVF6I/5m67NyiHzqj7vtQxPrpphHdoNrtMLQe8OVEfUaoDRKrEuYvlGNAfwESE5Ack7nax2vf8MRa4rVlMdGxKSVHsOJj9lIrL1XJY5gDGTtDJ2jgmK41rxZTCWnzNHgWyVeXFX5f/WLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4klyxL350V4QSRt2FHbb6aAjp07ojjipJeif4XaRLqU=;
 b=aTSmgm3RuldwOIPMLo/eiZtauQ8RgAp14Augp5hYEHA+APA89OJH0JpeutJqtZXOrVrIhKLvrpBSjSMuQGP4G4kjLfUikbORIWU/5YpCN8npPLSq8xsr4ry5dUODqyPwHZxREJ7Rngvr33LtrwYJhrhqLJEb/59DQ4cB3WtaZoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8202.eurprd04.prod.outlook.com (2603:10a6:10:24f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.19; Wed, 15 Jan
 2025 10:27:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 10:27:25 +0000
Message-ID: <de1d81bd-caf4-4604-89ad-68f7c1f180c4@cherry.de>
Date: Wed, 15 Jan 2025 11:27:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] ARM: renesas: Rename common/common.c to
 common/rcar64-common.c
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
 <20250112223528.179828-3-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250112223528.179828-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0123.eurprd09.prod.outlook.com
 (2603:10a6:803:78::46) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ed64cd-310d-4056-ab46-08dd354f343d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXoremFRV1h6aTBwYit0NU5yNWU0UjZnTjFTSUFlSGx5NWk0RThUR1RZUkk5?=
 =?utf-8?B?aUxQTUlaWW50WGdIcVp3Y2hqTWlSOEZiS3ZMUDFZUU1WQUdGeWJKdzB6R2dF?=
 =?utf-8?B?S1BQYnFDQWFDaG1VZW9lc1FVVmpSbzlrM01PWVhkbm9NRkkvUDdHS2h6ZTJN?=
 =?utf-8?B?dmVsOGJqWWNkYmJRaVIwSXZUbDRIelZ6UTJqQmw4TFpGOEVvSWFpQ0NETVZC?=
 =?utf-8?B?OWN1M0kzT0o2d2Q5UXM1WjJHVU15cTRCNGRPTGJ6K2lVM1NVVDZwdWJ3ZDlJ?=
 =?utf-8?B?ZHpvalBaeVFpQnd2RUpRTTYvaCtSaHlSRmR4WnFaUWFFV3pob0VmSksrdHdz?=
 =?utf-8?B?N1drZC9rOGJVUDQ3bWJNZ2NQWCtaZTlsUXlkN2dNeFBaaUgvQ1hqWHI0Zmd2?=
 =?utf-8?B?REJ5ZkNidDFBYXdPcFJkYnZzZVJSV2x3OGJ1TDlXeTRSSm9VYlR3dHpjMEhw?=
 =?utf-8?B?WE1CR3ptdVpORVRIOHlpK05lalh0S1AyWU5ha3MybU5STE1LcGFEcGdOa0NV?=
 =?utf-8?B?N0RuaU9kOWQyRlV4MWFWM1pwUk41YXhHYlNBMkpJRklybEpiclFiTXliVmxu?=
 =?utf-8?B?bnBqQ2xNRS9WMUlFNzZiR28xT3c5ckl3YXlNLzJYMFZnZ1B3T05UdHZWWmZO?=
 =?utf-8?B?eWVXRGNBUENoZ1BJVENQaVZtWFRoRmFiMGlnem9xbzZTWjIwSktDWE0yVFVi?=
 =?utf-8?B?MnR2SlQvUk45RDFidGlmS1FXVmRaOFZGSnFUVUN3WE8vYXZTbnlUQWZHU3VY?=
 =?utf-8?B?MGQ4dFJsV1VwWTZ2eDBXNmpZckg0MFBweVpvSlpaM0M0TWxPNG82TnNnR0tF?=
 =?utf-8?B?ZFEwMEhBZURxQmVkVU5pc21mbGpyd1lJTlVwbHduTlZkdHR2UUVPYUhtUlFQ?=
 =?utf-8?B?ZmIwblN3RnYzVXNGTktNbE1aMmcvVHJpd0NlQmV5aWtuNFpVb1BjTzl6VlFL?=
 =?utf-8?B?Q1hFS25obTBiaGFKbXg3R091VDRTdHZlcytmcXJxNTdpK1dEVEN4TFVzREFM?=
 =?utf-8?B?elYwVk10STJTcE9xUDlkWUFjY3MzbjJRTGhmbkdhMTFkUlNiYmpwcjIvcW8z?=
 =?utf-8?B?b3BmQno1S3drUDdFL0xmV3ptMWpyVWZRdldicHlCNWxnU2JuNUtPZ01XVmZ2?=
 =?utf-8?B?MUZzQXl6TXhnNzRQbjBYN2hTc2JQUmZDclltZEw0WmxwMHBFNWJkV2VsdTU4?=
 =?utf-8?B?QUxLZGE5bVJyOTlGZ05TR0ozSWo2ZE1PTjBTVkM1M01vcGR2R2ZwbE8zSUc4?=
 =?utf-8?B?ZEhRNWM1TE9ROThhREt5b3dPTS9YOXVmb0EwbTRXUzNjTEF2VC83cmRzWkw3?=
 =?utf-8?B?MTFLY01jVmxXYzc1MUUxM2hKSm5abWk2MlJrS3lOSDc2Y3U4MGhEMWtEN3pG?=
 =?utf-8?B?SktDZzVybzJQZm9sSnlkbHBVcktMdW1OUWxNTzhOSy9FeVJXbUViQVA5Mk5Q?=
 =?utf-8?B?M2M4UEpVOTd1UFJ3MzBZcVEvRzByNnRMYzlQcTk1SjF4N1NyYUhweEp4OEY3?=
 =?utf-8?B?a0RhckVta2tVZy9RNEd3QlV0QjMvYlIvQ3o5QUNKTHhQUDZhODVHK09sT2xQ?=
 =?utf-8?B?YmRPMVR3MStVd21PWlUrVGVhSUlsZlBqTjNab1hTc3loOHZwYUZzeDBUZGh5?=
 =?utf-8?B?YUdFL25sMlRtSjRwZ2FNb1pveVRIUklXTzJLZ3JGZEpGZElIWWhIS2tBVWd2?=
 =?utf-8?B?UUNzZDBzZEhEZS9sL0NWR1dGRHM2N2l1ZlJJU2FsU2pLbVlHbHc0ZGJhb2I2?=
 =?utf-8?B?N0ErWFA3NjdmTWx6WEdMajFYSGhPcUUvV200YXBrVGRuWExHQjZFalRabWlq?=
 =?utf-8?B?Q2w2UXRkNGxDYlRsbWFOb3pFTmFFcjFOWHVqUTVOcDh2SmZNaVluWS9CZUcr?=
 =?utf-8?Q?ZArv+l/R6YmAS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjYxeEhrUGoxQTFjOG9lVzZVWWhpNjgwM3BvVmZKVzBSSmNwbkdveXhYb0V2?=
 =?utf-8?B?bGdTazA2QjdubmhxWCt1VGR5ekpnaHRyNVlub2kxZUg2cyt2b0ljc25CNWN6?=
 =?utf-8?B?UXBZNzkyRGZ5SWFZUkRDb3U5UzBTZ29aczV5akE0R0l2LzQ5WkhRZ3BpdlpC?=
 =?utf-8?B?b1M1N1lLM1FoOWhhS2FLaXowcDZkMEt5YTBZNWw2aG40RXQ0a093YzRGajFx?=
 =?utf-8?B?aUNsNGZLZFdhRkV6UmcrcTRnUGR4MXpZczJKc2pmako0eS91TGE0TVFMc3dD?=
 =?utf-8?B?dUdKWE11dlZydHZDbEVMMHRpbHpRdDdrcFJySXBFWXkxUkFXTHVvTEU4VVBX?=
 =?utf-8?B?dHo2TmNZM1RRU0ZycU9rVW10a3RqczlRMklkVXZDTkRHb0Rtc0J2VHZCR1Fn?=
 =?utf-8?B?aXVlQUJNNkJneVNlUkIrRlluRVhkNG1Ca09GcnU0c0NaSy90SHd6ZnloR0lm?=
 =?utf-8?B?V2NqbFFtYkZMRmkyY0hpdlVXQUpnbjV0OXBGdEpkU2xRKzBHSlpGYVprcUs2?=
 =?utf-8?B?d0o5Qk05NU5GVUVMajlUejJFTm5UVUdpZzB0Q3hrZkpRZWZuQW5ZTk9SQ1d3?=
 =?utf-8?B?Q0NjQmg3eFBBbEhKQlU3aWJsS1BTWG92ZnBzOCtxME9uVFJOTHJ6TjN3anVB?=
 =?utf-8?B?MXo3QmdvcDVqN0lnbnNzS25UV2xocFQ0bWg3eUxpeEFtalZhYzNXNUcxZm1l?=
 =?utf-8?B?dnVXSUY0WnR3T21wNUc3a3pjRnllSFRBNFpQZmVGeU5VTkxYZXhVdVBIU1lU?=
 =?utf-8?B?R3lTc0grUW9EekZOeUVPc0w2MGRPWGtzSVg1NTNpaEhDWkdVcmlzdk5ycytS?=
 =?utf-8?B?dzcrend3RHd2ME8vR1E5YnJLZnpDbVBqb0dJdld0b1RaNEsyQ3JBaUtGeVRI?=
 =?utf-8?B?YzdJUnJIWHprNG9nUW4zd3hkc3BBY1ZEaXdueU9sTUpMeTVCVEFTUlhtSGJX?=
 =?utf-8?B?TGIxVmV6UUJJYnltNmM2akk5ZDJHc29IUG9saHhwMFo3ZjkxV3o3TGRJcjNK?=
 =?utf-8?B?aTF3TDRtNVh3b1k0b0lWeXp6UUNoNXhvNDIrNCs4eEtrUmpnMWkwallMQXlm?=
 =?utf-8?B?bWJ0NVQrWjVodjJOMkowbmFXekRERmU1cy9Zd1R6UmhoK01LSFlEc3haSStN?=
 =?utf-8?B?TzN2V2lsWitKYnVEWi9QcVc4VjJYV3h4ZHVtTnh0VmV2c3dwVUZxUExheldK?=
 =?utf-8?B?Vmk3ZnFBenB6eVBRMFdHdXRxdmtXVW5TOXRVRFZ0eWE3SC9VQ3R3SHNsMzZw?=
 =?utf-8?B?R1E0RXJaQzV1TGRMVkJUdStSK3NvMHU2cG5GeFJ5ci9VTnVGUldPVVBzem1J?=
 =?utf-8?B?VjVrSkRITjJXdUhrc2ZkYlhRMktuN21QSHBtM0JCNHRTMWVuVk12V0NLL04y?=
 =?utf-8?B?clZMdEJkaGN6N3Y0bmVjazZPUmYxVEFVeTJDOHc3UmVKQTVsakhuY3o1Zkww?=
 =?utf-8?B?S2dxeXlLNnFtTGNSM2FzNkl0bkhKai82UnBnTTZZaGRqNUZCaTNjcGlWNmNr?=
 =?utf-8?B?cjZpZ0QxcmNqK2NQbklOS1BUL0EvWWlkOEpaZFc1WFpWWW53WHJidU5XaEx2?=
 =?utf-8?B?bDNEb2NibFNiNWFmZFZma3pWTU5TLy9xM0c4K0lBaGl4amFPRThkMFQ4UnBh?=
 =?utf-8?B?VnRhcmxIcVJoK0hZVmJReEUwbkZjekpyQStyeUNPOFU3R0g1amEwOWxMMHYw?=
 =?utf-8?B?M0pOaU1ndEduTlpzY1dDc0pjZ3FGRExWNnp6ZHdJMkx2OVdZOXdEZUJLbFlO?=
 =?utf-8?B?bTh5MUcyMldDQjd3QTlwUEprbFlNbFJHQ3Q5TFM5QWhTQVcxQW1XcjlqS2JG?=
 =?utf-8?B?c2ZScEdUbzZnWjkvL0lmSmhEdVVrL3pGVzRXT2V2b0s2ZHJIMEtkekMrV2gw?=
 =?utf-8?B?amdpY0Fack9QdTBTSVozaVRqWGx5YlkyUG5aKzA0Q1o0djd4RDRGdHh3T3h4?=
 =?utf-8?B?cWlKZnNQSEw2UkMwMnhxenRsVjRGRkNTcnovZjlzTTJEVVNBcTRTVU80blZi?=
 =?utf-8?B?YVVlbTFadFpYa3Y4ZENoTVhVWHNha3MrWjJIT2lmdXZJSWs5OGlreFFCWmhj?=
 =?utf-8?B?djhDbkpEUnpYWDkwNFREaGt1N1kzLzlJN2R1WlovcW9WNjZkYkUvTFJIQ3kw?=
 =?utf-8?B?MkdPL1krRUNobWs1TjgrYjRpVlp2Z1QvSzBDWkVsRDM4TmcwV2hqVkVZc1Ft?=
 =?utf-8?Q?vrbSMxV/9P23Vbfzjjo13OI=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ed64cd-310d-4056-ab46-08dd354f343d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:27:25.4642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtNKA6QCPXF1N9n8rJTf5SrJrQ3CyLswON535h6P0uNOtbqti+HJtaj7qeYxVKUj2Tc4NdEWzePv1lW6t5nPzg02+49MMJifTdpO92may6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8202
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

Hi Marek,

On 1/12/25 11:34 PM, Marek Vasut wrote:
> The common.c content is specific to 64-bit R-Car SoCs, rename
> the file to rcar64-common.c and remove R-Car 64-bit ifdeffery
> in the file. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
