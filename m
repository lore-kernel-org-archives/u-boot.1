Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49553C5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 08:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06BEC81121;
	Wed, 12 Aug 2026 08:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id meT3Xm2iiWci; Wed, 12 Aug 2026 08:13:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3120C8119E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786522414;
	bh=ZbzkRzCRoYagW+btJT7jp/k0bn3n6k57Qtil0uqdNdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9esFwuP83Dkn/yCYOhcq6gUueNQcsEgrPpECXuTkl2oPteAkNPTSChxdAMHZkLcq
	 YbxsOnVAg3g4EDLovGmHLKkDS5nAq2qnXABhoMwkIzdkWSFqfmE0X2nuyb2RQV8wgO
	 33Tc3YMxolnSpYWE6WQE80yv6+SNj7w39DuC1mThE5EOfXKCjZ1NB30egvVcHRMo8L
	 dn98HUsdbvTey8CHKPNIY1Ywh1ERHwR9ny13OxCGHfq//m5v8c4GAXXt2H6iO9W6sI
	 HNYhrTCm6DERbuxgX76RaX8hfr+hpJ8Yiyd0ndcTiFRdAJTMJTk3vw8POSLWL54dUV
	 /OQv9UZkrv+LQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3120C8119E;
	Wed, 12 Aug 2026 08:13:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B878B198
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5F384083D
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KJWfDxZHZrC for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 08:13:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 72C2A40824
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72C2A40824
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72C2A40824
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0WXLzSrQhIZt/LooZw2TeX5miO3YJRIoXLc2nhVl/2N8UCTPIrfySb7Cb88onbx5WW/cHcFa6F6gLqvPc750NtJ6HMy6wmaaQpNP3lVt005pab+HpWBwq9QYh31lSPR7LsEipgVNJ152EeOIzxIwtZoMFe7wO9qSv9riBP36zCoRU4EHIfiaxMTxBe2XqfNZ83E4RI3k5fUbllClostWYVYCvrALyJDtg6X9htpg6UXgHYloIawxJ05Lg3wxddv6ZjMDaIn82j8L5Jdc2AbTN9KZdRLDHNKH/LjTZaxqQ3SvhbdINgj7/7a8uk3aUFq7C6OSLBz84pgUXII5kO/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbzkRzCRoYagW+btJT7jp/k0bn3n6k57Qtil0uqdNdA=;
 b=RFLvNA9dk8wJmhPI2lOpPYFO3i7t2tMPlUwgmZ48KZK+ZpXogIdwHciG1wVb73gMzdF0eJVYoH2Fcs0GoDdJtxAFNzLhGLBPk2D/eSMQAOu144t/B9zL/gD9Fbw3DarpOI7Tp5Ycgh9XRJvnX0wy1zxbDfwGr9CG+BiLv7Y8cIM7KtKLyJAlPNHtZcjfEExhwpedB1fSpFjAmArtFos4gprC/6JHBcZ01aPzFslql+QLs1bZ+CxC4hvL6gx1SV9LL12frq5yga1n7HUJvb2n9BTyN8tIoij5CFQjd23fcoNjsQxOdtJHb6BOmgvLKaP/91xXgcBdx3DthL/8Cje4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA6PR04MB11885.eurprd04.prod.outlook.com (2603:10a6:102:513::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 08:13:18 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 08:13:18 +0000
Message-ID: <dc49740f-865a-4eee-8153-96676fd6269c@cherry.de>
Date: Wed, 12 Aug 2026 10:13:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: rk3576-rock-4d: Enable XMC SPI chip
To: Martin Herren <sputnik@on-the-web.ch>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>
References: <20260811-rk3576_radxa-rock-4_spi-v2-1-515b2880999e@on-the-web.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260811-rk3576_radxa-rock-4_spi-v2-1-515b2880999e@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0105.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:351::8) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA6PR04MB11885:EE_
X-MS-Office365-Filtering-Correlation-Id: 80beed94-a6d6-44d5-51d5-08def8499060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10070799003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: nm05fd/v1TtwrXJCMF2wTioovd44r9hI1A9qJZLxP6wzKLtzdEysL1o86Xoes2PJVoopFdDfRR3lFzUKq+Vqmh//QJEwblk4crJ19stJvBotz6gdExIsxhKm15qjNHfMtiupgP+5hsCBkh8eLdU2NULrTi+Ak6mhwoE0KGNy0T9knRrhRQHVc4nEceaUdXO9iNt2I3VxYW52jutvi0u2pnb6ZKYu+HE0Vx2yfwX8mGXEq4QlKF563Sy7c6+VdIfUvq/pAjiLj+T/BC73WN+tUfT2m7GJbI6VU6hd8bL+jFpUjz9iD+Fopk0FIT8np0ecUvkeGhAL3d51CxJ3dhdfaaXAgSdzPcGTqCoF5lqZWJEcE6LMChczCRiSLOyVClsKVSjj2PDfJzhjLER7yKhjRRWnqtNJW7G/lbv9k6P6DLJZNcIlmmUvpZ0q01mrDs/x4skzlyBjVebG5CIxd7r41MY1uJaxPJOvC/D96Lem90/g1nNsAgFf76pqBwjAzU/Qwlb58n7+lnlToT5LfMjX8ekl1v2kSpn+ej7s/rnjh+q+cXa9u/0xunmEil2+wfG7f7XFkgIULYGcXt3uIQ4J1lWNyV+7+7FgpctubG5fpMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10070799003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUFWbWQxYXB3S211SnZYQ3gzUTFFVnNacFZwU1FaQ2JIeitvaWx6eUtjSFhI?=
 =?utf-8?B?cWR6NG9zM0RrendseUlMWVkyejFWaDd0MDdwZUo1VVB4dXk1eHJuaEZYZmdY?=
 =?utf-8?B?UzVrRCtmRDlkeC9HTjVxd0l4cHJXaXJxZ25sZytqZm9ZS2NkVjIyUXM1MGVx?=
 =?utf-8?B?UFFFanRoZUFmdnVBdjRkdjBoajc1anYxbmpTOUZGZlRBN0lENFlkZCtLYTk4?=
 =?utf-8?B?OFB3VWxPOXQ5SXRXcit5TVlHQlErTjVoRUEvK2hkcWZkWE5kVmJaQ1NOb05s?=
 =?utf-8?B?Z2ZnQVk3bmtqTmtEZGYwSTEvSmtuVndYbmhIaERkdndSSy92UXAvVGRCWmlj?=
 =?utf-8?B?bkNHWllNbm9BQkpIZHZNWS9YUFR5cWpsbXNDUjErVHJxMkIwY1RVQXltK1BP?=
 =?utf-8?B?QjRGSitxL253NUc3UkFOSFErci83WnU1UkxEWWJtcnl0Nkd5WHJiaDNQNnU5?=
 =?utf-8?B?aFpMYUZXNGUzQjVBNzM0Y0ZzZUhOUFhqTm1KNUFOMjdzMXJHQUxZSU1lZDVJ?=
 =?utf-8?B?cEJIR2JzcXU4MkRhSmg4MDF2RHBjV0NvMWhxR1JWcWh4ckZpTVdYQThQR1Rs?=
 =?utf-8?B?dlNwbFlkUTFVbmNtc00xWER2R09ONEdhbHhab0EzQTRBUWJoWTI2Y3IvVGdF?=
 =?utf-8?B?WWROVVFiNGNMdWVuSmJGTEF4WVowQTd5amJXZjV3Q1FiTzFjU1Y1ZzY3Nk9E?=
 =?utf-8?B?SkwxcGtIdTFORWUxMWxyNWNhMUFTc0VFRjExUzd6bk1IaUxlcms0cHVobzM0?=
 =?utf-8?B?cmc3b3REUmExS2ZCT3lFaWxOWFFiVG5vekM4cnYvSEVBNnZNeFRzNFZIa0dr?=
 =?utf-8?B?NWFKNTF0L1dodFdKaXRSWmV0ZjFsMlpST1NKRzlndnRqQ2NPT2dCOVpWR2J5?=
 =?utf-8?B?Vk1xUXB1NWtIajdnVllkc3NJYll6QlFYZURORFI5aFFJZWF3elZMdEQzOFE4?=
 =?utf-8?B?SUw5Tlh2UFBPMUpMM3BLZm9Ud0ErR21tTm9HamRQYzlFK2NHVFpsa3UwM2t4?=
 =?utf-8?B?UXZMakYydVR3dGxSVVR0bWFyNU1GSktJakVXb3poK0FYUHl3OHVRMkEvekpI?=
 =?utf-8?B?VW04RXIwSWpRMUlNNXFxSzUxMG9FSE1ja1JsMVBFWlRhdHdlU3JnOE1Sd2hF?=
 =?utf-8?B?bHVpTW94S2dhRjVMSWR6bmNvUCs0Ylp5bjIzV2wxai9RZGxSdjVUeExIVWpV?=
 =?utf-8?B?U0RaRTNkdDZrYitFZ3pscWtvS2g5Wjg4Uzg1d05XVTN1bU1aMHJxTzRJTlJH?=
 =?utf-8?B?dkVDdzVDUjIybDlxQWZGZU9WL2lsNFRrbjlXUFh2dmRkWmFuVUVkM1ZicjdK?=
 =?utf-8?B?T0F2YlNLN1JWZW4xM1NlMDVvOTBRdkRIU0ZzejFobk1MRTdpUXhNUEZwam5Q?=
 =?utf-8?B?TG10LzBQcWhQSktrMXZqS0paemNGVFhvMlNIV0RTYjhBWi9GQ2J1TmIxNWoy?=
 =?utf-8?B?KzR2L2d3eUpwZlJkWEtrdktwNmJhLzBIRnB0L0wwd0NIdjBiR1NaVHl3Vkcy?=
 =?utf-8?B?aU04OUxCTms5SkE5T0F6MDQydHlTcHVob2FYU0phdWIvdzZ4d3Y1b3RZV1R5?=
 =?utf-8?B?RTJ2T1hRZEdlOG5Obk9JTEVjUkhDUVNiRWRVeVR4bFEyTWJaVGZNUG5nU0ZB?=
 =?utf-8?B?UnI2R3FiT2VsWkYyRG5ka0YvNk5CbzBzTW5POG1oY1A1NDlIYWdRaWdKL3pK?=
 =?utf-8?B?Qi9aSHkwN3gyWUpteWNZaXZLNktFaldaeVNtMndWSjU5NUMvNGgrL1hnUjd0?=
 =?utf-8?B?OURVeXpJdjZCQ0lBUFVvUDhuS05GbWxtMGtHdzg3a3cxUkxhdlI3US94K01D?=
 =?utf-8?B?TS9HYXZrQVJYd0dXSHdFMzFEVzJPZjFNRUxNZjVLNGZCQ04rakJUSzQ4a0V0?=
 =?utf-8?B?SFZTeGFJRWd5R3dJOXZHZ01OWXhtb0JYU0s5aVo0cVp3WnFPNzZySTRsc1Q1?=
 =?utf-8?B?QmIvUTdUZ2owUE5aZTZaWkl1SVVmYUkyZnhveTRCZVJQcE9ZQy9Db1NxWWdV?=
 =?utf-8?B?WXZURUNvUzZLb3ZBbDhJYW1IdDhMcjJ1elAzV094T0x4bzJUdDdNdTYzak1C?=
 =?utf-8?B?R3hPelhPU3BMZnJNNXB1M2o1c01PY20vcFFRQ1lJREhwRzNKYlFaRFJNbWJZ?=
 =?utf-8?B?Yi9wcW92Ujk5QVdLTzB5SWhmeGs4T21HNUpxWGJkUjBEYUhacnViRTd1NXUx?=
 =?utf-8?B?QUlNa1dPUFUwbFpjNVBtbmtkeUJqMVpUQkxDeFBYcTVxRFBzN082dTBlYWFm?=
 =?utf-8?B?OEZNeURWbDVFRjhuQVcvNzBVaCtQd0c0U29Na3NyUXB2N3BvM29zSWRzTU03?=
 =?utf-8?B?WUZzZ0VSY0hWc2VwSkFaVG1HejN1dlJtdW1oSXdpWmsyZzNVcHlHSXhZbWlC?=
 =?utf-8?Q?TKjV7hvzYehWiWqLcurOUnLmgVvvRj+EYTMU2FDiwj6Ji?=
X-MS-Exchange-AntiSpam-MessageData-1: qmZdI9T1dHF4VW13w5bY/TOLZ2zXz395CyA=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 80beed94-a6d6-44d5-51d5-08def8499060
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:13:18.1962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBB+mFk70fxzTjRoGeAa3RjqHgvDXcVva0tIByLkLcPI7oHCeFWVfVJxBk1ZlTcFTQy5PFW3Wy5ETv14JgWVv6vDc6QpTomyw3WIjEUl6pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11885
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbzkRzCRoYagW+btJT7jp/k0bn3n6k57Qtil0uqdNdA=;
 b=LqIQNTlFaoKx0TUb4pnb6qHYv4X50wfArEJJgUxkbpk00hy9Q1shWXXfaU0fRHVT2JSRPS4YQPmJ8G5kfPHcdIOj8K1vxRXLTQS+0TXEGLRvvBcYqE8pgmc40sXvgoHehpXW0seUruHSj31W40D9YrdYE1Kc0VfkbjbiORLVs7I=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=LqIQNTlF
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Martin,

On 8/11/26 11:05 PM, Martin Herren wrote:
> The Radxa Rock 4D exists also with a different SPI flash chip than the
> one specified in the schematic[1]: XMC XM25QU128C.
> At least board revision V1.12 can be impacted.
> 
> Enable CONFIG_SPI_FLASH_XMC Kconfig options.
> 
> Without this SPL fails to probe the SPI flash and thus fails to load
> U-Boot proper from it.
> 
> Vendor U-Boot also enables CONFIG_SPI_FLASH_GIGADEVICE and
> CONFIG_SPI_FLASH_WINBOND so other hardware configuration might exist.
> They are not enabled by this patch.
> 
> [1] https://dl.radxa.com/rock4/4d/docs/hw/Radxa_ROCK_4D_SCH_V1.12.pdf
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
