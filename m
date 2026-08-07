Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D018BC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:08:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E58A60A43;
	Fri,  7 Aug 2026 16:08:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6RC1ZW-eQpGr; Fri,  7 Aug 2026 16:08:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88414607E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786118937;
	bh=kQnvpJXHRascnKxlZfO9MelnauJYmZb9DftTFTTHgFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n7yzxXrmrgcLdWIJE5KYiYNvesY1XcHvqlmfU4MMEAotQUq8m/0Wdu1Jrm8ZRcCUh
	 zn9LtuGlSdASJ22AfNSaEFK7/4ANGIgYgRvlP9Ju+KWrd6s4GAwhMyedWeECzBdoPf
	 uo1aC/3pcQozIVYN8wxksCCUEXNX24ndHexsjMD3CZIGvl94AYTacoRj5tZ1GmqQDG
	 C2MrAqOC9GiscIkRA/+EU5/DuWS975oMtlRVP/628GzGwU4UyiU8BIzxtnP8gweVjo
	 ovTFcad8qM0KIw9YXC9t5hKuCgw0kCQaPwyAJTuIi/dmUOWdPI4Nb6AIURJ+b7mNig
	 ceXVwGsyZyQJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88414607E4;
	Fri,  7 Aug 2026 16:08:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF34A2F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9537F4010A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:08:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lduopAJctb8O for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:08:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A9C7A4008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9C7A4008E
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9C7A4008E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eR5ErpL56cLK4dS08Lc9S3IqKwtmWPxURagMcz1VjpuPf45pAE9PIPciySHiH2U4we/dWiTTJ1a+tghPErv8pzLhp1Er89JtyxjOHTCrofseMlogotSJLRw4BXqJlWXYy7XlcDY4hZFrIftDIMfou5sy2Uwc1IMkDOQpd647RSTSidFjKgqSutZ7Eep9KIez38CuuiOmSJexGOvQkoDnVT/DDixs1SOEBLYq21S4VKc91UG+X1Fxl4WqSoFIxAJ/CBUAuql+LbFQqPnkMlplvfTTq1VRCz4goF5P//dpcewX9R5EuBQbKK/aYAQASCwkx+UFH0eNOZxmGkd0CQJIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQnvpJXHRascnKxlZfO9MelnauJYmZb9DftTFTTHgFs=;
 b=WkDXLrCrKR+yvO+bAdws9acNmmjq7sHbwNygDBmM5rlpkdm7VE76kJtytg+U3DSB8uwGUdO/mtmCGz8bUtNh29ayg0SkKLNHUochWneeIjpFj6Cb5D/yCzLJbvWevI6PLw3H6L9FLjvVeCYXYsVZxYVHp6MzmifOyqGx7Bs2ij7Nd+/733tcQlZl9iq4NZ8C7Fl+k9boLmtZ6oADNOsSCDuM6DmRmOfr8p6uE4W6RASHCd4D/v60tjhz8PiC0Pmvw72IBpQoEQMUYS0ThmCGTaEJVFcRIpIeEglriJC1AI5+lCjf0EkVu2MyZVhlxikkpXDa5dDck5yZ84MWwh2h5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GV1PR04MB10349.eurprd04.prod.outlook.com (2603:10a6:150:1c6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 16:08:48 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 16:08:48 +0000
Message-ID: <98fd7583-dd79-4f07-bd37-bfaa2c93122e@cherry.de>
Date: Fri, 7 Aug 2026 18:08:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] clk: rockchip: rk3506: Fix trivial clock
 configuration errors
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-14-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::32) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GV1PR04MB10349:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1173b3-e97c-4e11-a264-08def49e29f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|18002099003|22082099003|10067099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: OKiTqkZZbVkObrFAHeMcdvTGi/8+iupIXfCyR76vXbk0TD8HM3nAzoGUVgz9YpxY1/w11fUPgivqXkwI7nQkBBnMeu/7xe98HK/sA0RGuk9aai+eA5jx3CoFdfyM+hgCjWEBb4YMd427x4/R+7CoWHgYFNpIjRx0wWOqnw3IjxnkgzdOpk/XbdSkzCOTNShSPXBrVeK6XDO8coe33mhrr17bc7erDLvEl/RZRSsIRaRTD8bMi9WoM3Nli5xJ++iw+iTt4mqTrBeCwsNvPC2YsKko27skLjS9QVNNhRNErKl9ZBKL23+iCkQ2MHKL6nzcUZVBbzljqJplEFQNrYdKQuZiNl+zwIc/saqozYtHbPBzePUNsuKQjeJ48CNcZUes5gRTxHeDPbwHlyejMbtc9lxZw/CSsWDIC93aec7q/WWsBv+kzPNw8QD+c3d0pTnWwoluGJh/z1xk1ysBcdYkZOJejw1tWgrLRwrLk31FIkOoqtktcBL2bpj+p0k1MHDsE6GHpARi6J2nRfwZqWtRPzjm8GJRSjSyLp/eKoIQAPo4Bt7SIOZLOZoZRLAFwbA9odU3fvDGY3fllLgD5Im1wfD/DZmVs0KJyHxYtNQf8Zz7Dab8r0Hcr44Xsj7u8IYBVjNT9G/JWILkzh7/vGflsW1034DtmMhM1KHfxmrdYeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SER5UmVITUs4S2U0eDBndTZNeFN4ZlV4SDFJSjRTQXAxblN4YmMwWldrYTBy?=
 =?utf-8?B?ZUFjTlhLSEdBRjFuTWJrZEFBZ3ZuM3d6dTdSMGo2T1FzSXdJbXpaM24zcWJl?=
 =?utf-8?B?Z3YzdSs1U3VFYlNpQmp1Vk1KZXVjT21IcUs4TkZ1OG5XNndhWEVVd0x3N2hI?=
 =?utf-8?B?UEtESHVFRVBRSEtaemNHVzhTZHlwQXI1UGtVdlluY2F6cGczNkh2a1VsTzky?=
 =?utf-8?B?RHVwenM0QkZYSFkyZHR2MjF3dFlBN3dyYWFZL1VxS3pheDJxamJabkl1TDJa?=
 =?utf-8?B?QURpTEpMeTV2Zzd4OXRlNDF5RW5VMnZlLysxeEFVYjF2UWF2ZFk3cFBJVk1Y?=
 =?utf-8?B?RzVkWGZkbHYyaXRQakJuRDQyUlcxQStsU1pJa0xNQTZoSkFKZjR0SUR6RFox?=
 =?utf-8?B?bGdQUVNUUGZsOFVJSFJaQ01CbS9MM1BMdzlaUXBuOGxtMUNBSEtWcVlQMGsr?=
 =?utf-8?B?RXBqa3huTVVMa0pOd1B0YnViVE5ScGtodjBvTlQ4UWdxL25aT3Q3UlVWMVZh?=
 =?utf-8?B?MXRIbXdBbTY1Z0JDRHlIQm4zVzFiUnp4OFd4VWJHNGgzcGlVSEMrWGhaT245?=
 =?utf-8?B?QjVWYzJuSTFoM2JyZ25tbitRNkQ4bXNqVndPYlRycWZlTzJLeURYaGJYb2tY?=
 =?utf-8?B?RzRQQTBETjdubmNPV1E1QkZ6ZWZYWEdFQTF0Y2hjUGgzS1Y0bEp5YWM5alV4?=
 =?utf-8?B?NnEwMFpKS0dZeFcwZ2tpenlEUGYvaGFhc3pVTU0yN2RvcmhTWStyVDVNdEZX?=
 =?utf-8?B?SXdVUE53QmxRaU1uMGdLcmhGUHJBRXJJa0EwRlVMOGh6Nzcrbm1PbjdUcVpk?=
 =?utf-8?B?MVVlTXk0cnh6eDFkcDlYM3lCdTdRdUxnQm9pL01tUFFiYms1a1N3djliN0pD?=
 =?utf-8?B?M25XWUZCcDBCM1ZOS1F5S1M5NnN2ZzFaWGFkaTlUSzlLQ1RZSENweWRRN1Bn?=
 =?utf-8?B?aGhxYlNzWFQ4b2RuU3lrbk4zRUI5ZEFJSmlNU0hZMHBPWmpVTFpPVlhMTEsv?=
 =?utf-8?B?SkVIRlJ5WTVrMDVKR1BYRlF5UGliTlNLQjVNdXFWZXFYZDhDb3J0Nkp6UmlC?=
 =?utf-8?B?UWFzd29RMTE0MmtpRUM0S0NGRHl0V2lRY0tOeXJyRG4yMFBEQndGOXJtR2Vx?=
 =?utf-8?B?TkhwNlBQbUVMMHMwVlZ0REFjQmxpQnYwMWtkTmtHREovUm5BTHVTa3pjZERj?=
 =?utf-8?B?ZUVtb0VZSmVNL3hFSXpGRlFJTDI5RmwyOGtvN0pTTSt3OVpTY2RtYWdPSW44?=
 =?utf-8?B?Y2JBc0tOWVNGS2FSNkY4TkNNdWdQbWtHOXVZem9OWGlBQk5Za0NpUU1DTHl5?=
 =?utf-8?B?RGNEWXdMOUM4MEYvTmZMV2dNMTBxLzIxL3h3eUdSV2JGdjBZcVVac1I0aXRV?=
 =?utf-8?B?dFM0MjZKTHpaNk12dXduNktuMDcybktIdmJtTWFKeEc1UTJOclNTeHAza2Zy?=
 =?utf-8?B?dWlKWHFJNnI0QVZpN1RRSUxWUVltbmoybVM4Q1VhSEZRYVlBdXZObW5DY0F4?=
 =?utf-8?B?aHJMakg4OTB5OTdYVzZaeCs1Zk80anJwMmlpalhQZ0VFc2JJQXdZbFNQWnlr?=
 =?utf-8?B?c2ZBL0xvTUNZbkpkS0FCNTJCZ2NxSFRhTWpvZXp1Vy9zSmJ1RXlVQ0dOS0Jm?=
 =?utf-8?B?bEZtUkFNZ2M3UkZBdlRudDhiaVhLSUFKRlJuY3l4ZFRqVFJMY05QRGJtVko4?=
 =?utf-8?B?ZFZkbmpZSFl3b0UzY242RXIzaHJ4bUVxZTVXVmZadTNMdnFDUUR4dHZGZG9F?=
 =?utf-8?B?THJ5ZmhrZE1iR1dFcE1GT3ViZ2ZNQjFPbnM3V2x0blc0ZWI0MThxd1NqTk5q?=
 =?utf-8?B?ZGlLeG0rZ0hPVWZkdjZvZTlyd0pudGoya3ZONHVuUWhTTU9CcWdtMXNXUVEz?=
 =?utf-8?B?RVNzRDk4bUQwS2lWMW9veXExeERPRlVYUFN0Nkl1M1NRYmdOekhkOVpNSUx2?=
 =?utf-8?B?Q3orM1hxTDY1MW55TXRwTjdyRmt2NGd4V29QV0IvcWtib0hyUGRNbzlzVFF6?=
 =?utf-8?B?amdNS2RFYVJ6bDY5OGVEOXZkaTBYTDc1MjYrRmRmTmR4Mkp2emhoV0k1c3Z3?=
 =?utf-8?B?eis1VkJueU9GenZiTXpBL1JOanU3K2tFTVQxSnY2eUMxTCtZMlN6OElKazk0?=
 =?utf-8?B?bEwwazd4ZG9PYURSV2FsMnhpQjc1RXpCSnA2cGxVQkdRSHREdC9TQ2NzL0Rm?=
 =?utf-8?B?aFRoaWk4RGtKN1BSMWtFQVJnYzNyYVVZeDg0S3NpZTZVcnZJbGY0ckFhYzRk?=
 =?utf-8?B?bG5nd0lPZE9EWTFSdjdlSnY3SXMwSkp6NVlDZ0V6ZjJ6aGhGSHl3UmNnN05N?=
 =?utf-8?B?eE5vNHNYMjZVVmlwcUQvUmdlZ1BVRXVZZXdFT2cyS2FBWjVsUkZYVWhOL3Ux?=
 =?utf-8?Q?QbkAOV+9LlfOrmBVxKLXRRW1Oqy0d2YFJnMYGd2hJN4jN?=
X-MS-Exchange-AntiSpam-MessageData-1: Dm17e4mocX0qLQftvjfkemJLhCM1+WDSUoM=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1173b3-e97c-4e11-a264-08def49e29f1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 16:08:48.1589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1CUg0uFzC49N203hTupfwZasLVpr/YkrzaYS8UC6JRV0+uZ5Koe+anQ+J04V63FT2ebmi2jgwobQ0XaWyPkDLavd4V4Wz5k2bb/2ERlH+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10349
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQnvpJXHRascnKxlZfO9MelnauJYmZb9DftTFTTHgFs=;
 b=b/0trSb3Aq0ycYi06ConxY60Xd01lBPcPLz7pq55AMRgY8APXFEEoQCHSF0iR8/jVQCrEUKQluSXwGC4Awv43qBGURP9Vu3rRgi2AE8FalRlEQwRbny7x2dI3FqzPwD0crMY3V9vBCjC7uwEkim67mzr0aFJonYwmzLDztD1rJY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=b/0trSb3
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

Hi Jonas,

On 7/30/26 4:13 PM, Jonas Karlman wrote:
> The RK3506 clock driver has a few trivial copy-paste mistakes in its
> clock handling.
> 
> Fix the trivial clock configuration error:
> - stop CLK_I2Cx from falling through into CLK_I2C2
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Fixes: fbf72dce915a ("clk: rockchip: Add support for RK3506")

Thanks!
Quentin
