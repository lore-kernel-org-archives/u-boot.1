Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DD4C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 09:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 282A480E47;
	Tue, 21 Jul 2026 09:12:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ley4Faee84qQ; Tue, 21 Jul 2026 09:12:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83FB480DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784625177;
	bh=tb/T2fBhovJ5WrVfBFDhxdWiPW0ZtMd+vjf5tInx66A=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AgMydwFV2mWxAamREO99Tfzb4KTtYwE4sXFyvvPUsoSU5AHqAmd55KGsoKIk2pYuu
	 Ybk4K/GCgZ88XIZPcjA3vRpq0PPkg2x0RcCEIJkcvHgdXla3rMeq9GSoaW9vxLLMJ/
	 OKJer2rAuKDRVvgvUd0TxBVBcyUY8HB38kkUIVFLlV6+sIUeVY+gCUUzSHGU8i+8b/
	 1KFmISFeXgaWuQ0TsPra4GfKX6TmD2UsjrD3FNY4dAMpN69M/OE/Rp+iUu6CgdY32P
	 qSqS2xniqTSOm5c1faZqMQmh3OxDk1UUoXxvYz2Nydk2dH1t2yJW3XkZHjLahETG9S
	 4XdorE6rmr7Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83FB480DF3;
	Tue, 21 Jul 2026 09:12:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EA7FFCE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A36680DDB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYoEZNk05iIw for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 09:12:54 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 28BAA80DD9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28BAA80DD9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28BAA80DD9
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:12:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98584844F6; Tue, 21 Jul 2026 11:12:52 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A39803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 11:12:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyqMmcl/8l2zZbkEep6j1ppjWj2LLuB6IroXaxi926RZV5zIGTvTeJT/UFwUkc4AXzI1/Ierw9rZJgAIC7U4xP6AoKrmMCa2kQ3ja86bdE1mubpUVGQWVE0mQONBa0H+edZXIUQl/qCWZKa936dd5i6esWoff6FRucYzKf4/uTV6NHn2GYa/CjjUbjBvo9iK92bV4Q066wCd/6ttwUCwTamHSiwKM55+hvRVeHiRCSK1rmgg3Ifbo/kMfQI3vQ77wytJuTgorsgDUTxyhrEnq03i/Hqzkbk1nn5LaBJdEINrfiQm6EsN/dTwWC7HcPfRPw5fsRdfMB58sxFTyWtD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb/T2fBhovJ5WrVfBFDhxdWiPW0ZtMd+vjf5tInx66A=;
 b=Pv9s7sOM/HZRIbA7t7xUIHA8Qki2iZNESFSPZXolVyABRE5MKu8VVUB/WvmU0z+5bv5fEKXv2HkHZ5jhK+PPtKSaVd4373KVopPnnPy2BMuZn2O0pXayi/NGGzqFgTEYeCyDQtOWgpjcAlHjM5c2+kHDFMkadSstWx80Zw6h04EOz2bPuByO8d25HJaag2fZxGskb8OmvcgmoPJOIhdD8pNqYazXYwNR0BcVRwCDAg42V9B07LpsUcLpX+qy/PuBRM/BtxWXW4ViQBut6834q5L0JOhfkb03ZAvfms9GtSWRKTwCbMeYBnr6wop3S5aIY+FkMHYh3VHUpxRY5xPCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:12:47 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 09:12:47 +0000
Message-ID: <2642a791-a148-4229-945f-76a5dd36875d@cherry.de>
Date: Tue, 21 Jul 2026 11:12:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] x86: apl: fsp_bindings: Drop redundant
 CONFIG_TPL_BUILD check
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-5-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260708220540.3368825-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::6) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c04b9e3-4fc9-4b67-3762-08dee7083b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ifBXQ442vVwlfP1ZsYjUoAi2k3RQFZNxpEyH6yrzyZo5xQKqw2vbLVKTXHwJltkFwFswc835shDK4SZvzBABcLxoFfJaYlHsab5oVAsd504dYCQq6SilZHNlfMMuTIgfzaHV5ofitLZDI5EWp8QHKWXAlqO6GMfapcOsgLYiTPBzDJgnBqZLWpmhUxbNXG0DX7dXqUfIBCiitrTQXaR7hjzIeZ7WJuiygCbytNFeI0ZTteRVHrNT9W11pwiwmn1dHjeOdDAMA9zjenYg2wm11lzc4LCbXbwlWji36WO30fgE8qd1M8Cy4xuMvddL1m7sU9Z0RTaD1m1z1L1+6zHrVtIJ4i880vF2X3Y5c3yaI6lWEA+GnzheKDWfuUjGiBPSGdAyDIwWiHj7ikmGuVp33WDPjjGtV/B20zSQYlZ3mtQdwWavNQ+o4ZrFjeU4ZrRjthD0sxBTAwo70n+2aveL7vfbP1KW6Mewuqs+9rpJXfORui/+xp05Jkdezvzgx0vlJBcPPMR9Tk0GITK5ICMDIF3TztXPKMQ1BwTGgh2HK1wzYMN6KB9UbiJA08EiXCnkXZY5YwKeM11d2iaT/Fvo+lF2HFHKTsFaqqAb9qAOXB9eeQ0as6pUorJ+U1/orui7yeb9jYClwY8VHRDbPGjX27kYjhsGFyJ2Kdup4B2AcHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmJpVlhSL0JrQnhXTi8xNm1idFNSVWpReVFBc1pSYXJheDU3SUtudENaOVpG?=
 =?utf-8?B?OUhSMmMwT2pQU25LNUFhb29Qcnh3c29RN2dvMmR4OVhETmJiTzZjVjNFd0xS?=
 =?utf-8?B?MlY3UmNDejV5bVBnd2ZmUmtBZnBiUHI2cWhrN1l6WWEzY3RBMzRpQjFjTmdx?=
 =?utf-8?B?N1RuaDVnRy85blVsVmRCNkVyV0g2YUppYjNsUTJHZkhRSFZZMDZ1MjZBWm5L?=
 =?utf-8?B?N0I4MWxkS3MyTzQ5WnVIeU9jZGNITjU1UXh3RDJXQW81RU1nL2RSeEFyN1dl?=
 =?utf-8?B?eElTb2R6czMrQUk1VnF6T3Vlem13U2NsYnlKaDhaL05qeWk3QlZ4ZmtiTkkr?=
 =?utf-8?B?STA2ZmVzRW9UdWFLaW5LQnJiRnNpRXBGbUsyQjVkMGNCQmRnckJ3b1ZFYmkw?=
 =?utf-8?B?am05VU1ZQmg3WkRKc3pKODB5c0JBSVBlNGtnN3RjSzZVcDd2Z1RtUFNRTytP?=
 =?utf-8?B?VDlWQ3FIT0YwY3Q4M1RmclZGd1Q2SkxiMzVldm4yQTAvb1gxY21XU0Z3ZnIw?=
 =?utf-8?B?dnBxSTdqL0hCOFF4aE9STjhROW81UDVwaWYyMFJaazQ4OEIyZ0NSUFBadEdq?=
 =?utf-8?B?S1N1eHBJMUdETjl4T0Q0U2lZZnEvYUw5K2J2YUI1R0txWHBZL09Cb3NTeGFp?=
 =?utf-8?B?cUdQRFVxYU9EYkpYbVVoeE83dmpvOVhUMUltUXNpZ0QvKzZCeG9qNXBJc3F5?=
 =?utf-8?B?RldOT0hpdmJ0Zlk1bjV6QkdmbnlEWVEwRklHWEJNTDBJSFBJdW0xUndsUk8z?=
 =?utf-8?B?cUlzWU5CdUZHYnNrRkF2MTZRcVdIY3Z4ei9VZzhDNFdpd3lvTHhsUzlzZEJt?=
 =?utf-8?B?QnkwZUtGM1prOFh1c1VKTFVyWUJMeVpDeS9GL0wyWnZYNVN1R2h2U3ZQUDdH?=
 =?utf-8?B?UWwyN2lUM0VLQW1lMEZJTEl6ZUxLclpXOEM1bDVUazlGMUhKQTR2ZzhCZ1R5?=
 =?utf-8?B?d2JLZ1FnSjE0bmZmTjl3Y1k4b2ZtRUcwTEJzMXB2Z2NTUE5hck1lVWlFQk9Z?=
 =?utf-8?B?TkMwdlNHNjNCTE9wdjVNdC9zZmpCaFNETWtsNnRyYkViZllPalNUckRBZU83?=
 =?utf-8?B?eVdKdWpnZVlvMGxPSWJmbS9wQVJsVW5NaUJ0RjErOHFOdmVMSHVDLzhWczdK?=
 =?utf-8?B?RSt4OUk4MUhUSGxSZkpweWtpMEkyTytvYmh6SGI5cm4vb2Q1RkFVNUdkUTEy?=
 =?utf-8?B?VWlVMTZnRHh3LzloRWJPcVdHeHQrV1gyQzEvTkxDbmIxVHBtVGNnYzBjWXdm?=
 =?utf-8?B?ZFBqRCsxWDZQVW9ManlsZldKSGlEZkRjK2dML3NzVDduS3hrbU5oU0EzYytj?=
 =?utf-8?B?ZmdpeVJad0N3M0p4V3laVS93WVZKaU9rMXN5QXQ5VmR0Q3FUb3pLbWJma1BZ?=
 =?utf-8?B?RFo3czVMNlhwVTNFMTFyRklCdkcrbVU3WSs4Z3JrWkxVT2dwdkNxSVFIMm5k?=
 =?utf-8?B?U0N1OG9QbERScTFCNnBvMjlUQXk5Q0JQOGo0QmtXVnFybis5UVV5YmU1V0Jv?=
 =?utf-8?B?S1dBUUp6R0VjQWNyd0E3N0lraWowdEtsVCtBWm1uTFR3QWtwUkhwdkZvTXlo?=
 =?utf-8?B?WnFqTTdIUjlOZHhtaEpWTXpOaVd4TVU3bDV6RWFxa0V2d0QxQSt2aDlycWdl?=
 =?utf-8?B?Z2FMQ2FUUEt0ckZQZ2lqeEUrSGI1VkR6ZXhoanJ3NVl1QnRMT1Vwck16Z1g1?=
 =?utf-8?B?cC9DejNaUGNWUHE4NWhvekdxc0tsWUpzYVdEU2dMa2hiQ0hVWXRFYUl4TUNu?=
 =?utf-8?B?aWRZNWZkWlhmcGNKZGk3Znh3cENWWmZwTFFEb2xGbTBvVktCQ09mZC9nemxi?=
 =?utf-8?B?d2h0eTBhakZQNENaeWxnL2svQU13WHpMQUp2SW5qeGorb0FwUGREektldjR4?=
 =?utf-8?B?QUp6SUVrK3o4QmRRb2s5dzYzMWdOSjVYL3Z5SVJXMXZhTGxxaGhGaDhub1FL?=
 =?utf-8?B?SXRFYitRSEZoR0VXOFVCdUQ1cTJpd1NJdncyRElXTzN6ZnZmOWpGMTRMRUZN?=
 =?utf-8?B?L29zWUx3c2VOUnhYQjc1ZlhBYjJUQW5ZcUZoL1RkOUo1b055Z1lpVk4vWFk4?=
 =?utf-8?B?NHE1ZG9jazZ6OEdFbnlKQjU5WjRFMWJ0V1UrbmJwbUQ2VlQ3TmlCY0FBVVhv?=
 =?utf-8?B?bXlxUmlwcGh0YWR4U1ZZZVdjWDN0enVuQ3ZlbWU2dHNpNXk0bjVCZzljUlRu?=
 =?utf-8?B?bGwyZ0VtdFF5bUt1K1I4S3pLVmtnNG41VVk1Z0pFOWxtMmZpU2JnNUJOaUxD?=
 =?utf-8?B?dmJ6V0R4Rlgzd3NNNVBzMlFwTnIyai9BMjVOdm5sdlRFOWpzY3Fid3NUbmVy?=
 =?utf-8?B?MWk1a1VuQTJPcGdCT08rZ3VVeWRlWk53TXV0YzVWSGwycG96aEt4UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c04b9e3-4fc9-4b67-3762-08dee7083b4c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:12:47.5469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGofEI/WfYIiatMEYqDRNfZ6LZCZpZr1hSsXCh8HL3cwUwjGYNOrsVifkKF1j0TEvVUCXQU8MUxhsBNu190u8Z50YMwmL11262PglG8bGpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb/T2fBhovJ5WrVfBFDhxdWiPW0ZtMd+vjf5tInx66A=;
 b=Z0nSA1liJPDbN+MaC66E/KqRKPLmfG5H/gFFToNlf3yVDGhYrUPeC16BUQMDSCxVzloOPxTT4vqCviL5tF5QiJuH/IwCy0tnfBAcHqWjS0/Al8qDpngSdvYeUHhLf7LheHqus8+L7f/97FOer1KLvK31CvKrbUD2iNQJZ3UO720=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Z0nSA1li
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="Z0nSA1li"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/9/26 12:05 AM, Jonas Karlman wrote:
> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
> 
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
