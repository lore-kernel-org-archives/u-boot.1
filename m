Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0E6C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D369740B33;
	Thu, 30 Jul 2026 14:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0BqDBN-NYRx; Thu, 30 Jul 2026 14:17:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1A8B40B35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785421039;
	bh=B3bF601XrkX8xb+BXjgq5n20ivAbtUnnjW34YBCSMwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r4BrOwKq4fC62DposRjwxvFpdaaIlQFOZNzfWagmV5zJQeM7DPN5tWPb32sGJ70WS
	 lgxCF3a6An1ehIaF74byJTV9MICcTBQMhoTjLfaIwjVQC47yW06lgxxINq4Tvn12fY
	 kDPZccV0wrX2hhof0HeBI/ko0MbWLG8bL5Ys6aFeGe9zTUy6KNwytNohnausH4Eweo
	 kEaANSmJL3INa4AnATSS62hTMv/uJDAfbc9vIgwz2xY/i6/Pf3XyWMU7UDK/igArSb
	 h5FQeUPg0/+Pw3KsuXLq+xevcskGayXgJ5PASABWV7mAulOe7t2etVnzFl/yIM2Yzs
	 uEhSA6FT3dCpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1A8B40B35;
	Thu, 30 Jul 2026 14:17:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73F5727C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 653BA40B35
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pcPw2xKNBPBg for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:17:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8383340B33
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8383340B33
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8383340B33
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxQUXaAwpLmP17Rm7hzjSVJK8YthnUcyEQlDw/ff1QTZ2FX4ixFZR71SwFKqTLfRsio3F8548+KJfvybnheXzjLxkhBUfqFqrG/ZBK1B0xKnH0gM9LBjiGQQWIbGFp6KxFnsD3+X9evD+UiNmT2KCk2SlhzzdjWu3uUECGXRNu1tUfCoZQih0AcLVT+fy43UdGln42QTGeEhFZwJdDu9EEqozPbRE8BsLwRiLHlY6EDFhRcdUQsY/FyDqBDj3frSvjGOG4u0dmLUR3vftukKbO9b+4Ofw4CAs7BnmY55uCxcY1CzEsXb7qF7ijwqyJRCbEwmu0sBSsC6PkrZQRKKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3bF601XrkX8xb+BXjgq5n20ivAbtUnnjW34YBCSMwY=;
 b=qS4gnTV6MyyazGTB7mYpL6MaFj9NZZE5uiCueeY4heuJPtbcIh0pHh6zuUyeraHaMMGOlmffm0b5CM9ij7IDw1RbPGuhpRE6inr7mureWEyHpO5lhSNdxMtbGm9uRBtXc+vGKbu8HkPloP2hSrz3fC/0M0Je2AIwq6ozYgk90s1YJuhDpWkZLV0sgT+Hm6hIsHJ2pHjbnhSsHSpxTAVM1G3UpRDcraY8iYfh6TLtCX+uNnppKa6eBoRz7aXu5pJ4POMa1Iv7gLpqUENj02q8VcpokyvHIyL5MXDFGJgg6a1zsG16KQMEoKvuDLBPH5TC9TsMDxr76cqjMlYTogk2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DBBPR04MB7609.eurprd04.prod.outlook.com (2603:10a6:10:1f7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 14:17:10 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 14:17:10 +0000
Message-ID: <dd4b848e-6007-4299-8889-56f020c7eb80@cherry.de>
Date: Thu, 30 Jul 2026 16:17:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3576: Disable force_jtag by default
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730123001.1211166-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730123001.1211166-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0012.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::17) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DBBPR04MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6be017-b213-4e2d-384c-08deee453ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FLCAA0gcfSTnnS4c1rPiTKfjVS+cg3RKB24TUPBPlF8r4L1sQ0v+bckNaxwKQS6OJCqzo6TAGt19PXUbWtr3nB5PBbTQsCV2oUDN3z7s1Mb284xu+ujFhnRvwHAP66ceI5cNPaRPXhVftlEMh+RpWFsLZMXn0VYxtb5OPKHqUou2V3t0ml2dEPivgd3DQf7f6LPSviF87THq6OUCbrSsZq0AqBymaD00h5BRqDHA5ijFhwBCnZlBbk0cc28qc5JMdmuP6Pm4Iz/YUlb0nulI+4B1HGMzZkphbTvOPA4iIP6IHbRoyyW0+zZBSJHO8kHTJ2YC+BCKBplwT7rnftcbne7CXhuSvkk54HAbU88mlRVhCxzEMWdDzgadNG+kRmyv9Ml7hxqjzc3WD3K6qFSIqfeiuLc5r9vKJ5V7gAOtUh0nI7bk5WCtOcJ3OuGvpEMVlyclC9qXv5na6x7c94OvTHk9x+5Hu/Csvi2SigmfKEl0PU4+dLkzt/qgnNI8Q3eZ5TN9hgE+36w+DCHiveGvS41Mo7F9r0+Ej+IckkmYQGek0QWA/5SszEKS32df2hffLjazfWWywu3oRW/whO79QUCc/qlBYK8BGI9bo359W1Aod0DR3xxjwa6taa3Pfok2aw+iwu4uHzv1Kv6FbwEfOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkEwN2NxSjRKak9aY0pxb3dTNHBxemdtQnV4QWliV3Z2Vk1TRHRERnZQdWs1?=
 =?utf-8?B?OEtsZWROM05USDBSM0FwbWtJRnRVY3NnamZ1bFJka3VBaDRxZ3Fia21oSTN2?=
 =?utf-8?B?TG5vWU9BVGxLSUdKaDZVM2I0MjBtMThGS0o2bElNVUtoOVJrMjVJVlFNQ3Vt?=
 =?utf-8?B?VFlQQnNZK0dKNEVSNzA3WXJJN3FIdmpQMllTK0pubmYrNGpydUYrODdBTS9K?=
 =?utf-8?B?Vkdta1hOYVJqVjN3QzBKTjRVdTNiREQ3YkJua2RMZy91dHFwbit6cG5qUCtz?=
 =?utf-8?B?SXljSC9XV09CNGtKZGg0aVZzazl5bVFXblJPZjlENERkZ3M5em1ETG5pRU1H?=
 =?utf-8?B?WFVkN2duMWxLRmMvWnNuOVJiaHloaVRQeFk1RFBQZ2d6NnhtOTVWN2JrWnF5?=
 =?utf-8?B?OXFFUDdjT2c0UEhLWUljd0grMlc3Mi92T0lxcS9kS2pVNy9Ca0lhVUJJanF0?=
 =?utf-8?B?WEhaNmk5MnBhdGR0cCsxWmhXTzVGUUozM2crVlFpQVBEeTZZQ1dOeHAvWVB0?=
 =?utf-8?B?ZE4vVGhiNGhBdWRHb3MyN2hvMTU0dEswcXhnUHRwdDV5RERvNXl1NldRdmdv?=
 =?utf-8?B?eTlBQjVuL0hhZEdoTWd0ZjRQWEY4aVBYMDBhRnhsTGRKakxkcHowMS8xOG5Q?=
 =?utf-8?B?OTl1NUVCQzk5MzVJbUhEQTFocmpNcmZwUWRYUUhBNXJWaUNRbG5XN1paNVpq?=
 =?utf-8?B?NzZwV3ZCdTU4Vkc1NEtubExmWEJFYkZPNEdjMFlOQUxZMnBJdjNrdE94WW9l?=
 =?utf-8?B?TGp3OHg1WkxUWWxpWFpQeVhHSjJKelNacG9KSGpxSUFBSDlRRk1CM1FyelIy?=
 =?utf-8?B?bk1LZjZkZklDWkFLWmJOQm9sZEU1b3o0bmdSWmx0dFk4RnlLQjd3bGpqd3RW?=
 =?utf-8?B?SVpld3RVSjU1OGVIamRsdlN4eVRkc1BtZWZLMTVhRE9nLzZhSUF3eEtJQktS?=
 =?utf-8?B?dHhxYWFIWVB1dFRyZDFVaWxZY0t1ZnFiUmtrUS95YkpZSGl6d1RFY2F5bDZh?=
 =?utf-8?B?anhkWGY1aGNuV0FIUTdJRGR3amI4VGYrcUsxZzQ5d1ZaRDBMRjRlMjVxUVNx?=
 =?utf-8?B?eUh4VTBWSHpZTGNBK0lwREFwT0Y1UVBuempCYjcxalBkdVpsV2d1c1ZnUEVM?=
 =?utf-8?B?M3kzME92Q2svU3JOU2JSUmdyTkp1cUtrUzRDU0NNSkg4Um5XM1VYN3F3WHht?=
 =?utf-8?B?cGtLb2xuc1lXcmo4bVJFaktPQ1VjRm16YndEdmx0ZUdITmx0Y2dxNEVyWTVs?=
 =?utf-8?B?ME5TV2RyZ3c4UHg5VklrRjY3WnM4MTVxMVN0d2lXWm9jbTlRZU5KWGtybXNU?=
 =?utf-8?B?ZHZtOThzL3hEY3Z0bEVGWllrQVovS1VCTVFpK2RYeE9GZTlsaFRqMGpSVDRZ?=
 =?utf-8?B?NU5OQTRIRUJ3aTZEZDVla1lYejh6dFBUeXFDd3B4VnNWRTd5aE1TVUpxalNv?=
 =?utf-8?B?dWxjcUtESzlrak1KS1h2VjVMRGtKaDFPOTNtVmFhbWttSmxIRlRJVFl4VkpH?=
 =?utf-8?B?QXNWRmQxa1Jyd0NrTkJHdm9ReEJBUXN4dUVYek4vaEFPdXB1Wms1d0hOOTE4?=
 =?utf-8?B?NHZDSFR1d1Z3WWFSS3dDQlh4M3p2YXgzM2d6YmpaWFo4MXZKMWg5MzJDMWZr?=
 =?utf-8?B?NEt5YitTK0liMHNCVloxOEppQW9XS1ZMTE9LUlNuTW9hd1VIWUxialJSWjFR?=
 =?utf-8?B?Y3k3b3YrNFgzT1ZvVFhFWHZVa3pmY1U5Y3doYmo4bHhSOVB1Qm5mcHA2UWVL?=
 =?utf-8?B?VG9NbFZFd2NBZmIzeUNMK3hKanlxc1VmNEplb2wySVl3SnZReEZwUGlQTzJL?=
 =?utf-8?B?MmR1RzNaMU5GREdGbnZwQStBc0JpMEJMSk5rMnIzb1FNVHh5UlFRS014bGQr?=
 =?utf-8?B?eGlyVDVkcndSZTJwWEg4VC8zRmRlWk9JdGdkbXI5Q0prNmRCN3NuK0RRTGJy?=
 =?utf-8?B?aWd5c0FLSFJIWUxNY0RpRmxBc1g3ZWNNRUhOMGdUNVNyTzNBRENxREVGTTZ1?=
 =?utf-8?B?UDZKVmlFQW41TUxBS0xHNVBtcy82VkhBbGFXaStvMWcvNlRkWU42OTU2T2FB?=
 =?utf-8?B?QnBmWnkxNHlsTnA4enM4SVF0Z2NDdFZyT2Z0M0pVSHJkMHpkSkt3STIwcVFp?=
 =?utf-8?B?Y3VqQUxjQ1FSYXdtV0ZSR2tWRTdpSis0UDZOcnlBTkwwNEZRTTgrOVEzN1VY?=
 =?utf-8?B?SXVwNktEZlRHRHFFdTR1RWVvN2FQcmhxR1hiZ05oT2RzTVZtNWhmL1VLWGth?=
 =?utf-8?B?WWZ4ZXFKOFVzYWsrSDNOWjhVbXYrMW5abXpqTFk4V2srYjVlekFIYXNxVEdZ?=
 =?utf-8?B?ZnJNNnkvY1J3ZHRpcjc4T1lpeXpEV1pFd205U0oybnU0VlRGT3EzZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6be017-b213-4e2d-384c-08deee453ea6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 14:17:10.6636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqOTl7lcwXHqsGNFcjTscrudse+fL3FRXy+Pfc+5q3z1N1r2K+x+Xw9WA1caxkYckGF6AtFue4uvx5CjJg480vHV4yBDwZ4MYf0xmZaKf1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7609
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3bF601XrkX8xb+BXjgq5n20ivAbtUnnjW34YBCSMwY=;
 b=iQ6uH9dK5mlc/HXbejlMK2WnjRC5+lRV6Pr/GXLoFk85UTuG2VmT9GH51XYrJH7zxExKxCsNiEYdDT4tfUDB57sP81XsGbPMTGeBDMf7S2NJK8pbNT+u+Povq6ynMCAsIS5Be6IXdxXHYpXw7TlS2sUYIZHPKo3MjMhfriNtdLU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=iQ6uH9dK
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

On 7/30/26 2:30 PM, Jonas Karlman wrote:
> Rockchip SoCs can automatically switch between jtag and sdmmc based on
> the following rules:
> - all the SDMMC pins including SDMMC_DET set as SDMMC function in GRF,
> - force_jtag bit in GRF is 1,
> - SDMMC_DET is low (no card detected),
> 
> Note that the BootROM may mux all SDMMC pins in their SDMMC function or
> not, depending on the boot medium that were tried.
> 
> Because SDMMC_DET pin is not guaranteed to be used as an SD card card
> detect pin, it could be low at boot or even switch at runtime, which
> would enable the jtag function and render the SD card unusable.
> 
> Or boards using cd-gpios may switch the SDMMC_DET pin to GPIO function,
> which would enable the jtag function and render the SD card unusable.
> 
> With commit d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1]
> into dts/upstream") there are now RK3576 boards that have changed to use
> cd-gpios for the SDMMC_DET pin, e.g. NanoPi R76S, that may have issues
> detecting SD card unless force_jtag is disabled.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/rk3576/rk3576.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index e3e93f663959..0f41f210a9a5 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -26,6 +26,9 @@
>   #define SYS_SGRF_SOC_CON15	0x005C
>   #define SYS_SGRF_SOC_CON20	0x0070
>   
> +#define TOP_IOC_BASE		0x26044000
> +#define IOC_MISC_CON		0x00F0
> +
>   #define FW_PMU1SGRF_BASE	0x26003000
>   #define PMU1SGRF_SLV_LOOKUP0	0x80
>   
> @@ -190,6 +193,10 @@ int arch_cpu_init(void)
>   	 */
>   	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
>   
> +	/* Disable JTAG exposed on SDMMC pins (GPIO2A2 and GPIO2A3) */
> +	if (IS_ENABLED(CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG))
> +		writel(0x00020000, TOP_IOC_BASE + IOC_MISC_CON);
> +

Please:
- use a constant (e.g. #define TOP_IOC_FORCE_JTAG BIT(1))
- use rk_clrreg(TOP_IOC_BASE + IOC_MISC_CON, TOP_IOC_FORCE_JTAG)

It'd be nice to be consistent here and do the same for other writel all 
over arch/arm/mach-rockchip/ but that's a different kind of task :)

With that:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
