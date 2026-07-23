Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2EBC531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 12:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67E3A80FFD;
	Thu, 23 Jul 2026 12:04:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O0X3Qz1IAj-Y; Thu, 23 Jul 2026 12:04:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E32480F6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784808251;
	bh=g8E330CAEnuxX/X2kfFL21ZknB0a7YPBSuZL16S9SI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lQOTTRt/2xb5T4R+usLSBcJSey8I9b8qMzUJ/xwqTZYsyyZFmNm8PSSVaVmSTC5D7
	 PjKoG6C6BNqSufWnPabN2FD1xz5EJfxa5z/eMmx0mTIA460tpGr6lI2leeHi94xE4l
	 RcRhTR+5eIhI6m0d0xDa9O0vjpelz96VMswYlgef9Otl7B3GoABq0+2HX6OTG3TSKq
	 ED2sWBWUodshqGfXljyNhzyLn5dgh6b9NKZewcsDjGx0wa8ctTRytJYpZ0vXHA4o3v
	 ZI1GCDneC8xM+ghrvcJD8GVRDaEqg5eLicbZW8U4kKr8NuTBExy2dt9nGaWQgc5Njv
	 aFV+HQpWl7R3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E32480F6A;
	Thu, 23 Jul 2026 12:04:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6377C1B8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55331406DB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKg7Lb_tKOt8 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 12:04:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C240840552
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C240840552
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C240840552
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgvKHrV6ysHYtjr0/6o2NqWbepCBhkh5lymKGOlYLhPou56kso8VeNF4Ej1Cb/Ev6B8+Wm+VgWeIzEpMwKPyve//yMkA8qf9n/kiYz4iF5oDhLerxJwuL9qAhdHwbZzHfRGl7hwg677jouVne0ZrGsuL3A9X7c9e20rbcXy6C15wiU5JjSS2glechCTsh+RMyUklUW7qWK29y28nVY0hk9jaa4XaEnotTljWgDZUrPKJh43JcIwOZv8TvLZUrnxnYbDzaBdv/sG61IRb0OKg7gY2XfJQ2ckms3FJaR/EVu0v80W+JoZUCtYdmnciXv+VK58wO5JYJ8JZeMJ4//Tnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8E330CAEnuxX/X2kfFL21ZknB0a7YPBSuZL16S9SI4=;
 b=LiaZXiInbf4lpgFBNa0nOfn+aYAZQhjZtQN0udhD8C9JYt72IJZi0PQq/NuGS6wn87dh/fTWdOwO0lMa8gyIRbPlBifr6eKTDswRRxlwQD/ezjfHmxfQsRxwkQPHX5rf0xMujpMC1TMSfZ400TNiD0HiTOKUL4ifnV2ef+zZYCfjzrZrGkteXjG7nPRDm8KMmkgixmv8BWt7KFEXK0/mZ623ncTOQhQaZig4+Ny6m6fXKPwjCEdzfuwNSQd+SNDYL9z93uD4VO1f4vm4ezwy5UoNilcVlREoQ+wiBQrP9kDeZWWDb3rLU0aAAsuxW2MeTmtBDjtDyatTJ248xNittg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by VI1P195MB0542.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:15b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 12:04:02 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 12:04:02 +0000
Message-ID: <413fc6b3-504c-49d3-b401-b7a53e34d9fc@phytec.de>
Date: Thu, 23 Jul 2026 15:03:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] arm: dts: k3: phycore: widen SPL overlay load
 address spacing
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Garrett Giordano <ggiordano@phytec.com>, Suhaas Joshi <s-joshi@ti.com>,
 upstream@lists.phytec.de, u-boot@lists.u-boot-project.org
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
 <20260721152110.283998-5-aristo.chen@canonical.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260721152110.283998-5-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:803:1::37) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|VI1P195MB0542:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fc09b0-e74d-427a-aacd-08dee8b27c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10070799003|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WnGDM2rkGz3fILpPeKLO4dRghLTERjKSjF2FniFQWAOTSCIW0gTQp5sw1qi1PeHyKaYXuK8KVN9wzE1J8aY74BzD520FM0M7LUHRD5cONwwV9Ejp0nVzLTF186pCfLMiWwnhKi1G1NhepAszP2nqrZLXHR5DGA848/L8NT0sslmPxLb6V983drCbJhS12CUIsMnULQOZ6PtAt/bfDU6/B0X6v1pxqPuZBsmA9RxNHYpE+JmC6cQ8fhU0uzuyU1Alh7i3vzWfY3YeXl5Ie0XL7zP4A+wdJsccD3kbuUI3qUTmK8/owgG6jRKZoactwgPt/rGk0UGjJOLNhnoWILHZPyvjTfErhyz9sZoLVAOUFPM9Ryyzpi2/hSZogzk6QjlRZfC6KTu6DdbEBEh2/nX/IPuapJDmxHsBRE6Q5sbrDDxmSjVgPqpbZ2ynSf2B8gpWNrUkcjJcRBbUMDHrkogAsPz9WXtVJZHerfjLmL81HiKLvsS32I7nbhe46Th8Z5qfrRJkOoLfyuaBiW99m8bJc5yJCznTt4PoMwTwp32zND1b6/3VoFZzA7DV/1pnCxy4hA6wU2qNlNsJhF6F2s5jOjhYQ7GFQ7uCVN/alVqehDo2vIiPauahmh4Us2ZV/l6pREf5oO5XdPO3hYK6arXnIBfQurzRxBNZC34tqUqwRbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10070799003)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVQwQ2dTOTJYeEFiK3piV2cyMk9sOXhmaGZBZU9BaFd4THgrSGs3NWRjNEJ6?=
 =?utf-8?B?S2hyTDU1Um54aktyNFJ3clYrYmtZaEY4KzBsRmx1ZC95S2ptUCtpNkJxSXZk?=
 =?utf-8?B?M3dnR2RnbkxOSlg0ZWVQVTJKVHVDSlFLamVGOXlHRStuRmNGbmYwTnVZWXNH?=
 =?utf-8?B?VXZJWHBjbVdEV2tNRVgvT2E1OWlML3lYTmp6K2tqUTE2VkFPYTlKMVB6d2J5?=
 =?utf-8?B?Z3VNSG1CS2t3L2RRTkFlbjRxR2E4d2dTdkY3aTdCempYaHZoclIxYmRMRzht?=
 =?utf-8?B?ZVVqcHo5QzVCNC9seE1NeUo3VnhFSUQrNitDcWVQSXJ4a1dvWHBLTDV3NDBl?=
 =?utf-8?B?T1NNMTk5WFBhZTIwY0prT3dXTFVzaFljSm9MNzJxQUFKWTB5Z205WVc5T3hj?=
 =?utf-8?B?RmR4M09INHVDR1gwV3paYlRodnNOVlErMzJMdWttQ0gwZUZucEM2bHBNQ0ZY?=
 =?utf-8?B?NzVIU0VnRHd4d2NBNVI2U0toTVFHa2h0OTdPMzlqdjlFV3RHdFU4MUxneTJ2?=
 =?utf-8?B?WnFBNzNnU2NqOEY2ZXBKQkJNWjRJTEZtZzBqdklRTGRObi9md3gyUHNTSG55?=
 =?utf-8?B?M3dieVBUelZkN3JZcTlKTnoxN2NPdHBkVWR4RUs3REJmSnhRVkdIdnBVSkpa?=
 =?utf-8?B?V1U0aGRyZXFuVXVUY0x3Um9rUktCY29TbFFUenhZS0pvWjZ5SkJRRzdMSWFl?=
 =?utf-8?B?aS83Z0Y5VGZoNG5OOWs4YlhjSkZraVZOV3AzaGczaEtCS1VKZUgwc0IwSlpz?=
 =?utf-8?B?REt2WElGMFZNMVlZaExheGdkd1REWEs1M0hBQVZIOVBFdEhQUjhqUm5maGtM?=
 =?utf-8?B?RkIwUjNsbUtvNlVFL2lmVStOYVpuY3V1MmtDNkhlMlBVcU56V0pjdnA2bmtp?=
 =?utf-8?B?V3BMSkFsd0ZENHRub1F5NVc2WW5oeFJLcjdJbDlJSWM5NWcvekJwZ2h2b2sv?=
 =?utf-8?B?MzEwTU1WUXpGQ2puV2VTcDFMcEJjS3FpZUwxSkhhdW9CanJ0ODFhYmkvL0hm?=
 =?utf-8?B?MFpuU3h5QmtCY1loUWpsdUI5RHROT1VyY3hMclRmQVBnMksvdHdialMrUngx?=
 =?utf-8?B?UFVhdTIyR2U1RVhhWDZpK2NEZWIyOHNOQUlBN3lrV0xFdW5nbTVOL1VnRi95?=
 =?utf-8?B?djlHQWlBLzRuaTFEMlduQUcvQ1JTa3g3dlJ2R0JCTnRGQktFRVRpT1h2Yi94?=
 =?utf-8?B?N2U2dlJsSmNnYkNDNnlnRU5sTXFIWCtaMGtwSW94bUF3RGhMY2w0T0NTb1RT?=
 =?utf-8?B?UGdYZEl1Z00zckJqT3NMSG5HMFMxRXVMQ1JXZkltQ01FN2RwYXhVWVhGL2Fm?=
 =?utf-8?B?NkdvbWxnaDFTL003OHAyYVM0dEdOU1psWmt3dEM1Q242RnJlSkR2aHFMMFM4?=
 =?utf-8?B?b0dRa21uZlRVTG5BbmhjME9jYUJ6WFQrVkxtOEptN1MyQjZJOXRYdi9GSGhw?=
 =?utf-8?B?aG5FVTZRQVRGdGE5bFlqNkx0ZjJHOHU2ZnRuOHdCWitkSlZacHdrYXlpUm1Q?=
 =?utf-8?B?a1U2ZHNsY215S2M4ZE8vZnlYWHlKSW1QVWRxWVQzSEErdDRRbHBLVzY5Wmd6?=
 =?utf-8?B?YWdVSit4cGtEZENVL3BXZlAxNUJ6SlFhbm5BQkVCaWdpZDA5UjNQTXhHQzUv?=
 =?utf-8?B?Z2U0OC9GdVM0WjduS1dKd1ZjcFYyRFRjK0RlRHVvNXRtSThJZjJ3eGwvMld1?=
 =?utf-8?B?cDNzdUFYamFaUEFDQkxKTW5zMUZCd043MUNBU3ZVRldsR2IxUEwvZ1VZUnh2?=
 =?utf-8?B?bHlRVVBkQjdvaUNiZHNKQlA1UWNnRFVRdjdSaUdXREwxN3FFOXo4eVh6TERr?=
 =?utf-8?B?b0Q1Q1Z6aVI5TFNhWjIrZGhucVJ0SlBqTW15U0cyVVNBa1hLWDRvbFFOaTdJ?=
 =?utf-8?B?TExDUEdFcXpjdGt6NVMxUm5iUTRzK1drYlB2cjBYRnNPZmR1YWlaVHVIb01C?=
 =?utf-8?B?WDJ6QlBJMkNjN08vcGh4UmJleEJuQ0hISVJncGpoU2g1QkxlV1R1alFXK2hB?=
 =?utf-8?B?Z2tYdm5oQy91U1pIdWtiWmc3R1ZUaytlT3o5a1VxL1pLNmVaTVJlUGhJMVRT?=
 =?utf-8?B?T2Q0S01KcjRCcW1sbGhoQ0h4NUF3d2V4ZnRBU0duTFBQMDNOQUxuMHcvK0Vl?=
 =?utf-8?B?OGlYWlFHS2d3SzJwSzFYem5ERU1mUDgrYlp5enJreUhIbjQyaDJaSzRWcFFY?=
 =?utf-8?B?TmNQemdmM3NyL3ZLcWVORyt3bUsxU0pOOW5ZcDlkUFFHNE9tUUV6WUlhdGp1?=
 =?utf-8?B?MU9EMTdRR0hzank5L25KSU9TSE44S08xQzJkM3R0cThGUnpncXNPYk5vaGpC?=
 =?utf-8?B?T0FCcUJUTjJWcTVuK3JYWm9EZ0Nad2lVdTlMY0N1M3daZXZ4VllmK0kzaHhO?=
 =?utf-8?Q?dKrbi2dpC3N7Bh6Js/gwslERgveTNDaY4HI/HJiD7lxB+?=
X-MS-Exchange-AntiSpam-MessageData-1: mBmev3Cl0PO6Ww==
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fc09b0-e74d-427a-aacd-08dee8b27c35
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:04:02.0776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iYUfqn2EqrUYRaAdnycASTYi+n6PdFmbLXTWvGZC0w50bGfB/0q7YqUkAJWQl4HbcDXDv/nR9N4895byH6EkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0542
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8E330CAEnuxX/X2kfFL21ZknB0a7YPBSuZL16S9SI4=;
 b=tEmPAoW3fcFn1ufOFwaYqa7yIKPzcXO52XRvV4kcz17sITqcPj6tFNvvIH+3xUpESpLRnzmvHD/IYvLnCe06kItKCdBtt34+61ZldBK5wTKYbhViaEB/TO5ZsRG8BllHOOqO7AczSId9z/QwpVjL23NewtQHQY1sXNjxpPV2u6zAL0Fc9xYBhFxM285nGb4BcUYjTil93svlmxDZ2POfPGt07wVWvVH2W0tGZDGGvl5xNAxZuRJXrB6Q80xeRrU5zaY7OLbvNDc76/SxwBMFAVjGtnreRsEGMB8pM4cvxNyt9C5UIvoGmxqushDLnDDevB0UD4iF+JksNwAYj4j+Fg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=tEmPAoW3
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
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



On 7/21/26 6:21 PM, Aristo Chen wrote:
> The phyCORE AM62x, AM62Ax and AM64x u-boot FIT images carry four
> devicetree overlays (som-no-rtc, som-no-spi, som-no-eth, som-qspi)
> that SPL loads simultaneously as loadables of the same configuration.
> Their load addresses are spaced only 4 KiB apart, but each packaged
> image is larger than that. Measured on a phycore_am62x build, every
> overlay is between 6035 and 6163 bytes including the prepended
> ti-secure certificate, and the raw dtbo that remains in memory after
> the certificate is stripped is still around 4.2 to 4.4 KiB.
> 
> Loading the images back to back therefore overwrites the tail of the
> previously loaded overlay, so by the time the board code applies the
> overlays from the recorded /fit-images addresses the earlier ones are
> already corrupted.
> 
> Space the overlay slots 16 KiB apart so each image has comfortable
> headroom. The addresses are only consumed through the /fit-images
> records that SPL writes while loading the images, so no other code
> needs to change. This also allows the upcoming mkimage load address
> overlap check to pass for these boards.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Tested-by: Wadim Egorov <w.egorov@phytec.de>

Thanks! Interestingly, I never hit any visible errors. The overlay mechanism appeared to work and the nodes were removed from the kernel devicetree as expected.

> ---
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 6 +++---
>  arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 6 +++---
>  arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> index 6d57a5d9ffa..d0eaa7dd992 100644
> --- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> @@ -368,7 +368,7 @@
>  					description = "k3-am6xx-phycore-disable-spi-nor";
>  					type = "flat_dt";
>  					compression = "none";
> -					load = <0x8F001000>;
> +					load = <0x8F004000>;
>  					arch = "arm";
>  					ti-secure {
>  						content = <&am6xx_phycore_disable_spi_not_dtbo>;
> @@ -383,7 +383,7 @@
>  					description = "k3-am6xx-phycore-disable-eth-phy";
>  					type = "flat_dt";
>  					compression = "none";
> -					load = <0x8F002000>;
> +					load = <0x8F008000>;
>  					arch = "arm";
>  					ti-secure {
>  						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
> @@ -398,7 +398,7 @@
>  					description = "k3-am6xx-phycore-qspi-nor";
>  					type = "flat_dt";
>  					compression = "none";
> -					load = <0x8F003000>;
> +					load = <0x8F00C000>;
>  					arch = "arm";
>  					ti-secure {
>  						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
> diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> index cdc9a100a04..2c98e16b00b 100644
> --- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> @@ -295,7 +295,7 @@
>  					description = "k3-am6xx-phycore-disable-spi-nor";
>  					type = "flat_dt";
>  					compression = "none";
> -					load = <0x8F001000>;
> +					load = <0x8F004000>;
>  					arch = "arm";
>  					ti-secure {
>  						content = <&am6xx_phycore_disable_spi_not_dtbo>;
> @@ -310,7 +310,7 @@
>  					description = "k3-am6xx-phycore-disable-eth-phy";
>  					type = "flat_dt";
>  					compression = "none";
> -					load = <0x8F002000>;
> +					load = <0x8F008000>;
>  					arch = "arm";
>  					ti-secure {
>  						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
> @@ -325,7 +325,7 @@
>  					description = "k3-am6xx-phycore-qspi-nor";
>  					type = "flat_dt";
>  					compression = "none";
> -					load = <0x8F003000>;
> +					load = <0x8F00C000>;
>  					arch = "arm";
>  					ti-secure {
>  						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
> diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> index 07cb79fd04a..64679195e72 100644
> --- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> @@ -402,7 +402,7 @@
>  					description = "k3-am6xx-phycore-disable-spi-nor";
>  					type = "flat_dt";
>  					compression = "none";
> -					load = <0x8F001000>;
> +					load = <0x8F004000>;
>  					arch = "arm";
>  					ti-secure {
>  						content = <&am6xx_phycore_disable_spi_not_dtbo>;
> @@ -417,7 +417,7 @@
>  					description = "k3-am6xx-phycore-disable-eth-phy";
>  					type = "flat_dt";
>  					compression = "none";
> -					load = <0x8F002000>;
> +					load = <0x8F008000>;
>  					arch = "arm";
>  					ti-secure {
>  						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
> @@ -432,7 +432,7 @@
>  					description = "k3-am6xx-phycore-qspi-nor";
>  					type = "flat_dt";
>  					compression = "none";
> -					load = <0x8F003000>;
> +					load = <0x8F00C000>;
>  					arch = "arm";
>  					ti-secure {
>  						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;

