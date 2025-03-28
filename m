Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68621C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 14:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5DE28070C;
	Fri, 28 Mar 2025 15:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WzgVStrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A93A81273; Fri, 28 Mar 2025 15:46:29 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D85805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 15:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEd4NVGcXpfPuDn1QPYYA6iO5h96h1WjZezvWwtdW/8ijkqidzaQopq5koips3thZRbYRPhPn5vBJHo7lQkT6Yu3tfjlgWspTMDQR0D3iEAIFG7fVNOfl8yZNNRMHtuw6L97velpn+xDl0egHmhCGVl+MMGEA/B/pD01mv2Hxz0+7C8zPmg2l7oMC6Eo49PA0sTVhFYmkD47TIMSocOmpzsQlSLXXFPE8dDnZnhyr+nO0F5yvMAvocsKDx1Mf/+w0Bnguxa3mGskKwfxuoBshxfwj8HSKod9/Jlt/UarjgrrloJ1kwPoCpOYesc4OzT/hNL7fG+pjrY4gsml2DW6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dlo3rIph+9VYAisOWu2sbrzK+LLIGOl5+8pLm8OtSw=;
 b=E0roytEvb0Nx9Y+xQ0zNyB/dhOANGBJcUAmSbaoxcmNWa5//gBz2qhBcWfk/MLvx0nvma6SddBXP2aI1Ue0wC0fMDQ09hxYqWZQNlNG99BHi/w7hUcSayQe5dzsY8ZqJGHLdIayEPbvMK7pCdkpti5hJqkh4qO54VEDK+BCESRyDLcAHoagBwri65Q24NHy+S6M/5j4O4bKiUPD+G+zcYStBMsdEZZnav4l1DaexuIYxKCsgtURaeOfwdixYyqLuzdg9SEBJEr1llmLsjz3U5lfjX5Gnuo/yrBXLyzTAdX4aOFdh+wIo1P2jgWfIjEyOpYBhSzFQJfbi6WiBQCQ2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dlo3rIph+9VYAisOWu2sbrzK+LLIGOl5+8pLm8OtSw=;
 b=WzgVStrHS/m0tH6NwLR7ZA65UBO/S6Zfn82k0NM1jcFKvjp4v5A404I442KAU3RPmi97oxiB/PuP7Aijl3y+pqmGml5ZyjDGagWZvnFl7FhCL/a9RZt+wKAGm3v4TgAlWb+9xzFm+TSCN8sp1iB7jtLnlOwvNkMbgSbrUDUUGcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB9974.eurprd04.prod.outlook.com (2603:10a6:150:11a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 14:46:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:46:23 +0000
Message-ID: <ac62affe-7c37-4f35-915b-79d1acdd8ab8@cherry.de>
Date: Fri, 28 Mar 2025 15:46:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2 v2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com,
 a-chavda@ti.com
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250327080642.2269856-2-m-shah@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB9974:EE_
X-MS-Office365-Filtering-Correlation-Id: 351f2f70-67cd-4772-bdb0-08dd6e074f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFlOdC96aUVtTGRIemcrV2JGNUEvbXJxdlhjTFJmV1U1N05VcWo5ZlpGWUVl?=
 =?utf-8?B?WUJkbTllZDVKR0dWZlA5cUtaenppNTUrWDN1S2ViWnZwTXBjZDQ5QkxMVWNH?=
 =?utf-8?B?Zm5xbERFTktCdWgyYmJNTEVrdWNDb0JMYmU4ZEFYZDBJQXAyQ2dBRURNWGx6?=
 =?utf-8?B?VWNuWUJQU1JiTjk4Y2gwcnBtNldxZW1qZUZrcnFYbzNpL1c5U1dGelJ4Q1VH?=
 =?utf-8?B?ZzlxMlpsZHNQWUNEN3RQREFCRlZUdkpuV1NIQXlvb1FMclN5QlJxK0ZoQ2M4?=
 =?utf-8?B?akNmdERRRWRNZVZIeVdlRHZJNm9qbzQ0WlN3NlBBcDZpOGRKTzBxc2lFc01s?=
 =?utf-8?B?K3pYZkpJWFFrVHF0Qk5WZitheTZxc3lvV25SbExnaU5UQ1J6cXJKczQvTWxu?=
 =?utf-8?B?Q01zTVFiWWluaVArQWlPN2E0d1ZOQWk0OUtNWmtBamFENE9KWWZQUzlwS1F1?=
 =?utf-8?B?cGNvNi8rQml2OEZUWFFqdHR1eTF3aWlhOXJDbG16WFZBb0xDOTA3Q3FvN25v?=
 =?utf-8?B?ajNnUnZRRUVOU2Mwb3B4Q3QwV3VtSFdZc3VsMjRaWE5aZURrVnRuMTdvemN2?=
 =?utf-8?B?L3dhUm1nRXZYT0pnZXEydDV6WE5sUjBBUERBTklXVmQ1ZlR0SThCWkpCWjMr?=
 =?utf-8?B?VVdDWVVXY1dpQ0NtTVVtc3FFWEliRFp4WEhKeGswRnBERTVqNTZNaWwwL1pa?=
 =?utf-8?B?bW5kM29QM1VnY09aMW91VG9UMStja3ZGNmJrZnhZQ1FwQzlidmtrV1d4UjJw?=
 =?utf-8?B?SmsreW1uQTVwU3lUbWdzU3lMM0pMMUpNclNKZElZa2ZZSmtxNXJzNmp6Y0ly?=
 =?utf-8?B?WkVxOTd4SjJVUkcxd1VpU3R6YXVFT0NWS2x0cTZoeFdsUmpYclFhTTBkN1cr?=
 =?utf-8?B?dFVabmNWY0tpeGRxZCs5VjUvTjNwajB2NEVXcjJHdjZNaGhYd2dXNGt4WFVq?=
 =?utf-8?B?bnY2YjhrYzFtV3VGZWhSUzdtd09wc3crbStqQUg1a2pVVFREOGV6OGZvemFT?=
 =?utf-8?B?Tm1HcUhiUmY5dXd2c2xSRFJUVzFQUEhadnlrclg4bTJaaHVBYjd2MHdaTTJ6?=
 =?utf-8?B?NENFZFJLWUk0M0VoY2dPNUdFWHptRTc4UHRBME90TVdhRDV4Z1ZXaGNVNDhP?=
 =?utf-8?B?YXNLeHBZZS9JdkpJWUlDdVdSL3VGMU45NDJ4VzNMQ2J3bXdFaVZXRXhOSEc4?=
 =?utf-8?B?THlTazJDN2haWWphL0Fmb3MyTGVHLzlKVlJwblh5U2JPekxqMEdZWlUyZHoy?=
 =?utf-8?B?clpxV2JXMWR6NUJBT1p6THQ4aFMxdi96QTNjMjJlZDhMQzZ0NVhFZjZCZUpQ?=
 =?utf-8?B?NWlkTE9KTXhuV05lRGVmMW1VYWF0c1ZJeGs0TmlCOEIrUWdhQ3VGWlNXUElL?=
 =?utf-8?B?bjhHVTE3cGpJd05aT1ZORUxxdVVkdndnRXF1aCtBUE1tc0pPdXVYcHVta01Z?=
 =?utf-8?B?QVNld0ZiWEZoaG1sb3M5UUZxNDY1bnFRVUttV0Q1QTcyd083WDFnRkIvbVB5?=
 =?utf-8?B?ZzJ2Mm5yZTBUVGJPRVVlNlJzTm5sa1pVSmYxNDJWS01VTnFQb3ZkN1ZWS2pB?=
 =?utf-8?B?dDRWYW16UnVRRVZ1WlVyL1c1SUs1bDhXc0tDcThTUE1ZRkl4S0g4aXdZaTZB?=
 =?utf-8?B?bDhjTTJESEJKY1NBZ0RCaDczeHBtU1FNOTNnSGFaNE4xUUVMOHVzR3Q0cHFj?=
 =?utf-8?B?dW9rb0gyUG13NlgzSXoxK2xDbEpTV08rZXFTcERmV2g3VGJscUlXNEN4Mksz?=
 =?utf-8?B?ZHZXTmZiV3FDOVhjTmJEZXJxc0VLazJ2dXoxSmw5ZkVTRGFRWXArTlRSZlpw?=
 =?utf-8?B?MkhqZUZlbGx2WFhmajU0Z1pmSTVMWEhHTkVmVmxSM3lOYzgwYWE0Z0VlQ2c3?=
 =?utf-8?B?aFM2clZFUHpMQWV0S2FlR1FFUDI2TFdZRVdVT0NvVENadkFXZ1dIMWNKcW5n?=
 =?utf-8?Q?evoIE2dJMjw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDNLU1p2eUVxNlJ5YlFwaXhabktUTWp5QnlwdnpsRHlzUHpkc0NadCtKcE85?=
 =?utf-8?B?cjdwandibHdqNDRGV3NQcE1JZFlFbnUvNnk1UXRRdy9US2VWTW4zWUVKVzd4?=
 =?utf-8?B?a2c3dkNLVU9TVUZLVnhwSzRlZVhLa3A0QTlNOG4yRWhHbGF2RStKSmpaUjJj?=
 =?utf-8?B?SEJwdHFZZ1FLbENHZzM1VFhZMU95TDBXRWNGNFl6Uzk0cWlzUkk5NDJVWUVx?=
 =?utf-8?B?NlVZNHIrZFlaMmhQa3R0OC9Zck1OVkNwOXhuWGZlY3BrdUJBUDNyNFFUOXow?=
 =?utf-8?B?enNKdW8xVE56ZjRDZDdGVHg5ZTdQTkM5R0tkMnFWWDdGS0hGMnp1akc0UDBD?=
 =?utf-8?B?TlREeitxbSt2VEpYWm01SHc5ZjNBK1ZONG1FYnAxRi9WcGJ1ck1CclB6T0ly?=
 =?utf-8?B?bWMxL0x3UmRleHYwbWNmalZlcWVzTHU3T3k2VkJKQzlCVitoUzFrb0NlalBk?=
 =?utf-8?B?emZFeXcrM2FKNEhPTUdhSk8zM3ovSHlab1g4dXJCZTQxMWcyNExFSTRKbjJV?=
 =?utf-8?B?SS9Kell0ZCs4UDdoMmFBUWcrSUh4WG5QUmt3L2FKSGJHMnBCTExNRy8rV253?=
 =?utf-8?B?amR2LzdTcStsYXpjWnR0N0p2M1d2Z3JJUkM0M3YrWldyK2JrTkRiQllGbjZj?=
 =?utf-8?B?U0V1NU5FMWNlaHhsZE5VcGdqVTJWRkMwT1FNYm9rZGovdFl0MnQwS1dZWUJZ?=
 =?utf-8?B?ZFhxQ2VVYXFScExLOFViL05aTVFhaFFOd2Q0c1VtKzVhZm9hMmd5WG82YzM0?=
 =?utf-8?B?em1aVnBkQk5jWjdqOHVIYnJhVjZuNGxmS0ZnM1lOTnNwMGhCYVdqZlFESUdB?=
 =?utf-8?B?Wks4U3hyejJsWWZ4anJoY0xpMjVwS09GT3hQbDVUZGY1YjJ2RjFnTjZPNnBD?=
 =?utf-8?B?aEV6OE1MbkIwbW0rMXU4bzB4ZGhwYzhrcUYrYytXaDZlVURoVlU5eGQ1N2VC?=
 =?utf-8?B?KzVkK1BTVitmbHZmbkE2T2RCV1VUQ1Vpb2dONHY0YWZURW9ZTjNVNUJUbXk0?=
 =?utf-8?B?Q1VEODdDblQySWRTdGJSSGtEcTFhS0RxNXhoYUs0TG9CWnFTSno0L0VmK2xD?=
 =?utf-8?B?TGJDSWdpRUJmV2h4K2VreXI0TjlxTUF6S0QrU3BVV1VqK0FXTnBPcDJqUGFW?=
 =?utf-8?B?YlY2RmZSeVJ5YkdhdFRKeTdhVHlnMHF3TVRYUlFJWC9SbjlRNXpnSzVmYXBB?=
 =?utf-8?B?WHRiTE91bUdLN2hUcVljR1VaMnFjOEpoUHZSaDA0YWhOU2d4WUdUVTlIb1I1?=
 =?utf-8?B?elRwUjhmdXlYa2NzdXFwN09PcHFPYWc2dllxQ21MMlV4Qy9MQU81TVJKNG82?=
 =?utf-8?B?cFBPeFplM2NJczZReHM4OW5PaCtUNy94eHZ6VXJ2S1dLakdidlM5NkpIVWVV?=
 =?utf-8?B?dW9uVWxIUmFrSzg5SHJIMVU1cHhHSGVic2dXcDdxYUFuaVdzUEdFRWszcHN5?=
 =?utf-8?B?SDNFMHFib3lBQjdVUE53Q2F2VytMcklMblh3bWVYWmFuS2NXdUZHc0VSMy9T?=
 =?utf-8?B?L2pSMWE2L0xVckNPZkNRbmp3VUpwN3hpVTQ5VjFvZ3FicnNHRlZrUm16Y2Z1?=
 =?utf-8?B?bXBNcVl2N1RNWDFVTktXWHJHU2lrLzBGTWFvbkZ2OEFkcUtpNVhWbmEybDha?=
 =?utf-8?B?K21PUGNSRjExOUhkZGtVNitSNURLYlRGcHVLOXY2Y3FoSFVhSnBVajdKNTJi?=
 =?utf-8?B?cWo5R2pLeWFuamFyZE5oZThMTlQ2a1JFenVoby9PWTNZZHBaOEZRTmdZUm91?=
 =?utf-8?B?QVFPK2U0aHVWb0pPNDBWWjlOODJDNDlkMFVDVnp0RkJpcWtHTS9MaUVmMjM4?=
 =?utf-8?B?Qkpvcmx5VXJXTVV1MTNwZ1NSMzd4Q2xRUDVVKzhOWDVjYmozOUFoNmk2Ti9W?=
 =?utf-8?B?aG1GVWhiN0g1Y0F5Q2ZaS29UU2kzdGhmTFRCRTAxQVRQQWdudUtleTJ2a3Q1?=
 =?utf-8?B?YU9pL04zK1k3RjRTcHB4RXk5Z3VHVEtvV0swYUY0THpqelROOWt0ZW4reks0?=
 =?utf-8?B?alpoYzBaNTRCQVJBU2ZyREVKVWJ1bXhjU2FXVjR2UHNweGxjOTR2M294dUZp?=
 =?utf-8?B?UWgvVXg5TFdpZVgwNmdmbC9WUnc1Y3BxYlYxd3lTN08yNE4wSUNaRzZJKzd3?=
 =?utf-8?B?R085MHc3UGxsZ3R6OUxYQWp1SUxSQlFqOEx2VHR0SXQwOUszRHFDYVI3NWZr?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 351f2f70-67cd-4772-bdb0-08dd6e074f2f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:46:23.0215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ0Nug2YOIySLIEcjYm8bgJfNEbZVt0UTIV7NFYa5TeabttiQv7zakktvC8rqEr+3ZqvWYiWdgIsiyokT8O8hGfdj5n3vophWCyB39MHlrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9974
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

Hi Moteen,

On 3/27/25 9:06 AM, Moteen Shah wrote:
> Add a function to scan through all the nodes in the device-tree
> recusively for bootph-* property. If found, propagate it to all
> of its parent nodes up the hierarchy.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>   tools/binman/control.py | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index e73c598298c..e739949d366 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -526,6 +526,35 @@ def _RemoveTemplates(parent):
>           if node.name.startswith('template'):
>               node.Delete()
>   
> +def prop_bootph_to_parent(node, prop, dtb):
> +    """Propagates bootph-* property to all the parent
> +    nodes up the hierarchy
> +    """
> +    parent = node.parent
> +    if parent == None or parent.props.get(prop):
> +       return
> +
> +    while parent:
> +        parent.AddEmptyProp(prop, 0)
> +        parent = parent.parent
> +
> +def scan_and_prop_bootph(node, dtb):
> +    """Scan the device tree and set the bootph-* property if its present
> +    in subnode
> +
> +    This is used to set the bootph-* property in the parent node if a
> +    "bootph-*" property is found in any of the subnodes of the parent
> +    node.
> +    """
> +    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram', 'bootph-pre-sram']
> +

This should only be done for U-Boot proper DTB I believe, otherwise 
it'll cause FDT size increase for TPL/SPL/VPL/whatever where we may be 
extremely size-constrained. Furthermore, TPL/SPL/VPL should not need 
this since they get a subset of the actual full DTB (see 
scripts/Makefile.lib and fdtgrep_props), only containing the DT node 
that are relevant for the stage in question. The only exception I can 
think of right now is if we use bloblist or any other mechanism having 
the full DT passed from stage to stage.

Maybe the solution is to have it as part of 
tools/binman/etype/u_boot_dtb.py only?

Also, I imagine we want to support this for systems which do not use 
binman (yet?)?

Cheers,
Quentin
