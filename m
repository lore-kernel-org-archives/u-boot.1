Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E92606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=anrVBc0I;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mImQimop
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E503409A9;
	Tue, 10 Nov 2026 15:47:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZOq4FgFBm_vz; Tue, 10 Nov 2026 15:47:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4839E40841
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794325627;
	b=PURVdreQZy5r0GbFlYcIULoBZy2gcLZPj6hF8B86eAQUkAJDVzjGFDa3K7XMQEQs6DWa
	 Z9zPo5PBmsb1gPKJQIyOwRDulHUodlgemb5ZiADnd++Un8Qd03P8mGbG352C+piOns0WH
	 WsZRKHKJ9S/6chiZJZeYpu9X4I1RE87vxn13idxqAUNmCJ+D8ghZX35A3HBsE/9eQ5eZD
	 b5LgGX0bMTv4Jk71WdptABfKiSy0UKxmG4HwAMS94n7kgGD6DCpbpb8GVVraAbTPSOtWc
	 lrVeykAByxA3U7cXtp9GqvfOvMr9W3onuBF0kwZSYj8qPb+rYuYtj+jNrYvPKPTaNgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794325627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uwpo48QphzqXr0e/JpHeaJhCwt361Gt8f+wNH1A/grM=;
	b=d7zOVhLGlhkxlMJRcA3AXmyTkqv7ytn9ArugpJ3/5DNCnYvIhopEeUqk/mueLJc55N4Q
	 gUePavLfzz7ncWhAZMpYyU8R9QXkKAwBCogC6yZ00IZZgpUyBzrLgbaBBWn73vXYUZYNA
	 DE6IBrBrhiuxI9e8W/0ubU5ccHgqaJemNbgXmySK9kgcOGe6W94yW1JhI1/H2saA0WkmY
	 5U1OIBgzQXToQybHKCmHZFR4w046+ghLGgX+rcud2bZISO3Tdfo4cRFwruz2gE7Hh6/W5
	 ogQlHJiLDVPpheYKEbZPyHID3ja9cSrB/OS9MemlJ5bPMwJZN3Unoas8LJULIisw8rA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mImQimop;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794325627;
	bh=uwpo48QphzqXr0e/JpHeaJhCwt361Gt8f+wNH1A/grM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=anrVBc0I7oYyVLyLlm21oJFjollYjTfE+JST/wMLRlJp9qGUB9mxVhNX+v0UFIiuQ
	 SIzuJbEQu1zKIodYu3/08NBsIDevt/OPy/mcqcczvYk18tQW1UUG3FD8wEUMU4scTl
	 YgNDmB8nGJRyo0HFFrQnXHFLySvu/gdERmldkTozV0YHaOydMVWLRGRXlJYatHWGVa
	 /7s0lLUYLO7hT4/ke7pjQySMkrSSiI6l/rZEsNwRc96XrNybHMKXDQSUAau3IhRiNj
	 sGadYHZqbB8H+A2kcOaJOZsQUJ0iFqFRoiv1qDMCEDb7CyfGyyk8jfFKmFri/2BAy/
	 wY3MUhiwkiaXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4839E40841;
	Tue, 10 Nov 2026 15:47:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 56212388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 479F540841
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:47:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iSOfOtJxAc2x for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:47:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B08F140562
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=mImQimop
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B08F140562
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwpo48QphzqXr0e/JpHeaJhCwt361Gt8f+wNH1A/grM=;
 b=mImQimopIJemeAD0lhYZOc4aup/23bb5RlLv6EDWRXV8riljYWQThv0F8SHsuLQ8EchxMGVj+tCbGk7IrRaDddzISHFUo6hzlW4jVO1u+EcpqECID2kAjGt9CQk7EKDmULrR/rJ3SYPh6V4SUacBXxjifX6qFL6LCpC4RH0aNoM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:46:23 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 15:46:23 +0000
Message-ID: <33dd491e-cd22-4765-8c65-eede31a8249a@cherry.de>
Date: Tue, 10 Nov 2026 16:46:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] arm64: dts: rockchip: Add devicetree for the
 FriendlyElec NanoPi R28S
To: HystericalDragons@proton.me, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
 <20261103-nanopi-r28s-v3-3-ae8664fd168f@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261103-nanopi-r28s-v3-3-ae8664fd168f@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF000001F9.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::907) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ebbf67-3b61-4552-f69c-08df3f41c59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|4143699003|56012099006|261022075727099003|261021121427099003|261022105027099003|261028144727099003|10067099003|261102123227099003|261026140227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 7V/JrdP6q44UPMsfC4vdFULohgdQoKLmblcrg44dQkxIQgVNtaM3Tr1hDWAhLdCgKCY/2BlEanNWrfIglQtNArEl2sX1TBEBoJ2SG9/khrPQS75m0d/Po0MrDOiWFW0n+e3U0xSqS+VOfXGL8RVeoApnhOvgcloLwilxwBYIN2OZWVMkpfPPJxgWMvAXbxaKRsswemCDxhg1MAATmL5mVDFqiUaX976GAiAmHBbtOU9pUKVBTwB3fuiuEUv/xKbIQ3tcjuPOY6+ZpjGQWQzpTQQ0yiz6YuDGe0fEPk+LJdQXcRkI9dg7ZDiWKI2I51c8VornxEx10VNwLjDDIzB65scaakT99voLxPAJwDPrllVyClsNokrXYfXmvU9JziHsdCCBfCnGXt/PywUimeMy41byei43PkL44FnSRNXR48b5GLFzn+8F9CKtxCCZJRlCxO8hy0dX7TS8Rj6haqDh2B4k0plhP73EkUcpXUVLiQtIjl8hLmdWVrkQHewP97Soa6RpxJkkMl38/h9wVqCdxthpicg6r0dUJ9qoNOhLQCH+1iqsDfgAuZyAyqkgj0UD4N7XONUC6ilgPR/5mATyeIdn3XbiBCYutEvLogHxBoR3IFJrBedHP9Z9lVuB/0EH+ESf8ZfBXzMwc6N+CSvdwblanpjWqN7qptAS/LKJtqftJOK0SQq1TvnHN43lSmn61yarzPQrtMye1KHp8xpEOSMXl43ByQ+HLOP/KQ7JaQwgsaYSeKhBqVaLtHRVOPi8LcIjWoAhky0o2OvnxsBuxdls/vH1EnfhTauEjDtudiu86xNJKYTei/WHtyEh9Fpj71/Jksgr6Zu08XqTMScVC1WJAgbefPzkD8GT9nPvCZC7vrr7V199wjoBvhr1UyvP8jpv1g5nt4358uQvWG7TP7hYUp85FxZONTG8/MED3eA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261021121427099003)(261022105027099003)(261028144727099003)(10067099003)(261102123227099003)(261026140227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZvdmVMWW4wUEE5eTQvbDJ0RU1DT0JVbU93NFljMlkxa2RkU0JhU005Sk15?=
 =?utf-8?B?Rk83aGU3T3VWd25FZXlzb2N5UTZqTkw5cjFUUVh6di93TDIzRmt5bWU3bHRF?=
 =?utf-8?B?NkhHM0RZaGNtKzFrR1k4Y1lEdzk1RnVtdWxyYzZKTmgxcFFta3BLbVNTWFBN?=
 =?utf-8?B?RnY5VmkxMllOdHZIV3hKcW5GakxiWlZYcmhJWWZZRHR2cUgrL0VzTGRMQjlL?=
 =?utf-8?B?U2dEOTRXYmE2Z3hSMG13ZzFWOHZZK1N5N0doMU5FWGlMWWVTOFVvRER5LzR4?=
 =?utf-8?B?VEx3cVZ0dHFqUnFJZmVETFZ3dWxlVkNHVnp0SFcxYkNKV29mdkh5cnFhVFVI?=
 =?utf-8?B?SzYzZ29rOFBnS0ZSRkxYWGNHRkRSbmUvNGpyQzVhN1k4blZaSm0rdFVKMSsr?=
 =?utf-8?B?Q3JJR3JQMUZoT3pEb1dQVEVQQzkwK2xrYnhnRUE1MVNOSXFRbjZSMWFNa3RT?=
 =?utf-8?B?aW1YWWFFNjZNUTd6T2xoRUJ5TmNUdXl0QkVUdUFtU3JxRFRKQkNXR1lEdDlo?=
 =?utf-8?B?d2hqRGpjSmxPYVFEZ2dGLzliL0pURWNyK3hGY1Y0ZUE1M0Ixc1ZacnhUcDNT?=
 =?utf-8?B?VHorNGZna20wdWdIVUtJclUvYnV0bzFXcGthbHdNcVhHcEIyb3dnYXhsUEV2?=
 =?utf-8?B?TGJQajZKZHRjeXlhNDlCUDd2THJJQnlZUDM0WTlwNmJ4MFQvYk9jeUR5UDVm?=
 =?utf-8?B?b1dlZDhpa3VjVWdmSDBCQjlEdXBNNlU1bUQ4dExuU2ljZytROW01amhpak1X?=
 =?utf-8?B?WVoyT2Q5S3pXOU4rMFlhSlJoUVN6OE5oNnRJMmZHQ0NhQmFJMENjc0syK3BH?=
 =?utf-8?B?aUpZZ251ZGc2WnkxN1d0WEFNSGdBSE1xTDRqQ2VtU3d1SGFNNTdaOGNkNjJM?=
 =?utf-8?B?N3BkTGFIVFBjZHlVcHY5dVVvYTIrSGlCWXB6VGFWWnA1UlZDZi9UdVp2aDdH?=
 =?utf-8?B?SjNSbzVzK1V5UU9UQUJHdUJ1UjA2dUxCWXpPU3dTbGxlV3VRS3hNK1o0TVg0?=
 =?utf-8?B?V25BS3RpcVZXVmF5blkwS2ZNeG1nVFd0eERScnNoVWRwbURFaGVZcmRYcEpp?=
 =?utf-8?B?KzdtdGhrZDk5c0ZxaEJRNGFqNUdkNENtRE41dlVBNkhFanJBdlVCRXVtL0xy?=
 =?utf-8?B?NUtrSnBjaW5Sc3VPVGtUWkx2UUNmUnZERHcyTVdrQmdXa001WEVIQmtjTWN3?=
 =?utf-8?B?VHRTYTdOTkF4dzNmeHZ1MmJVMUtIWkRqMi9ZWlRQK3JRdEdJMk1rdmo2RWla?=
 =?utf-8?B?WEVsczBOOFYwVjR2dVZPTGZwVVNvdHVGRWhOdnh1azV6cThzU3VFN0cvQlNM?=
 =?utf-8?B?QmtCOXN4TlQ3aUI1KzV4Q0RIbW0rOWJIVnJqYlQ5ZU5Hclo1MEFCMGNpWXM4?=
 =?utf-8?B?MHE5eUpEL3VxUWtzVjA0MmJ3MXZFVmFKSkgrTFFWQUtHQ2l3eGg0eFRiRG9Z?=
 =?utf-8?B?VTJGYXJXV3E1ZFU5dng4bjArYmJvd1g4QzM1NWdxaHlBQWN3ZkQ0MStINjhB?=
 =?utf-8?B?MU53eHNFR3BqSkJuTzl1a3Q1bnVTVWpVaFdTdWljNjRFeDZNUkc3d0JPSllj?=
 =?utf-8?B?RzVNdVcxZzVVMUFESkhaSG9ReTJ6cFhaemdXYThHUGVIY1lxd3pRTEFtQkY4?=
 =?utf-8?B?YUdkanZFMDhnekFUaUFRemJHSW1IL3g3R3hHeHJhOUlUSWtmMHByaHk4ZldU?=
 =?utf-8?B?MTE3OFY2c0dDRG8ydDVhbjdlQ2hLNUJSOCtiMkJ0Mm93ZHl3U1kvZnUwRDY2?=
 =?utf-8?B?RjVNalM0L1ZyL0htTndmTzA2aUt0dGpWQ05JcjdvZC8xYUpCdUM0LzhKUXln?=
 =?utf-8?B?UkhaN3B5ay81YlU1dDJYN0UxdHpoTjdKMXBzR3NOdUxaTEYvcDNSbXJkeDZo?=
 =?utf-8?B?NTlJZlE1N21VRGQ5YlRlbG1GdENpT2JCRnFKQ1NBeFRNbjI2RGNvZHNESmEv?=
 =?utf-8?B?Wk9nOUFJY1dKbUJMdmw2UjhEbHJEcnJRb2R2WDEreU9wYUVVbE1uOW1QV2Fl?=
 =?utf-8?B?L0RYdFA0QTAybzFHWUowbTdudzlHR2hMaTUvcGxNRVJiS1BBT0JHcWliR2F1?=
 =?utf-8?B?V2VNOUFselFncm03bnNQeGtmUmp5Ynd4eEI3MmQvK1RqYXkxYXEyRUVCVWtY?=
 =?utf-8?B?M1gxeWVBaTgvQi9xTm1jQ0NSSzdWUE1YRkZkb01OeWtsVUh5cjNLM1RMenIz?=
 =?utf-8?B?dHBJQk5MN1VjTGthbGRGTnBUaXkxTkNzK2M1ZVRtMEFTa2hYVGd6L1pJVGpL?=
 =?utf-8?B?amZwZVFid1VXSEpwNVQwSkQwUGJRTTlHRnd6Z1VLZnZzWm45V3J3Q2VVeCtZ?=
 =?utf-8?B?TE5TQURCTnFtVkswYlJucWNISDZLUVd3S09ZN3JRdjR0eE1wTVN6Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ebbf67-3b61-4552-f69c-08df3f41c59d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:46:23.2039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4M6c9xWAcjLkmeGdKuqyQFBK+DGKWsrfYWTT/7lo1Mz9Wu8xcBnzsv4Imo66JpUcn4MIg2N/uxaGbfjao3hNS3IGFtjkvXvZqPp2/XwXvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi 安容,

On 11/3/26 11:37 AM, 安容 via B4 Relay wrote:
> From: 安容 <HystericalDragons@proton.me>
> 
> The NanoPi R28S is a dual gigabit Ethernet router board based on the
> Rockchip RK3528 SoC, designed and developed by FriendlyElec. It shares
> most of its design with the NanoPi Zero2, so it builds on the common
> rk3528-nanopi.dtsi.
> 
> Specification:
> - Rockchip RK3528
> - 1GB RAM
> - eMMC socket (optional)
> - MicroSD slot
> - 1x 1000Base-T (GMAC1, Realtek RTL8211F)
> - 1x 1000Base-T (PCIe, Realtek RTL8111H)
> - AICSemi AIC8800D80 SDIO WiFi + Bluetooth
> - 3x LEDs (SYS, LAN, WAN)
> - 1x USB 2.0 Type-C OTG, shared with the 5V power input
> - User and MaskROM buttons
> - Haoyu HYM8563 RTC
> - 1x USB Type-C debug UART (onboard WCH CH340E)
> 
> The AIC8800D80 has no upstream driver yet, so only the SDIO and UART
> controllers it hangs off are enabled, along with the WiFi and Bluetooth
> wake and power pins taken from the schematics.
> 
> Assisted-by: LLM
> Signed-off-by: 安容 <HystericalDragons@proton.me>
> Link: https://patch.msgid.link/20260919-r28s-upstream-v7-3-e80a6f8ef521@proton.me
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: c1e23f3425c49fe22e9598f8eea2fcf693950d50 ]
> 
> (cherry picked from commit d0f6e37c635be183ff10d8a0291f54afd1365f30)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
