Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039B5E9B260
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92C0983C8C;
	Tue, 24 Feb 2026 14:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="e7m4gYhr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4979583E88; Tue, 24 Feb 2026 14:23:48 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7DC82A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 14:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbT6KAgwrxJaJkh06BUWQAtp0QcoG4j+QfjX1L3QXpQQvRZ9Zr03WkoRyeJOLnawx3ZJjrhvu6SfEz0449WKbEZXjTxV5JO/pzwDEc4H92RnUNNFaslx+Z/PcjBT+rDroLh27Fgh7wPJcFzGq/lL7Gy6AVYLpqrtuSFm+8bSn1aeev+VX7V3SjQI+1t/oCiU8hLudOJieQ9PGNxAXxJPYKBzRuY1r+kKjYPIu9ElC5Rg1IIXkN2IdmSUC19pxozcGYl+Pd529ays1jr/BvgHjsMlrkQlf1DufTrYxLC3Y8tzFL5AjrDrsJpom18fO5bqSTKZKrobgnHCx3rk6G3tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZL8ay2QYsZOxHDD5y62KQ1xioorNgMABMthMUsIZko=;
 b=fyDTP5i8HbjAASsTeNMT0mCpxDvOprC9FYyj1DDhJWmNUEXRh9yaYtNFeYAWoDSoaGdc8ZVdoMTObxtvX/AxcvKvgyy3zZEtVv5dFFoFV5xpVQCYH6DkMJhUicjy2DxWLNso/3gvksw4UHBKvOUxob1u+kEqzJVF13FBr2OwpWxLtXyE2Uc1d/s5n4SO5E9svP1f4Qizv65ChxM1DJKJeCYr2s+iziWzlnT4mCwc/Z0mQRw0i96Dlj/7cqTXmb+0yNmtasx3oW2ap+cYyGXD9jZOktLu0T1RM1wQ8b7XdaiRpDik560oT0mdhwA65D7UxhsvQ92RbRrbOcqcWxAKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZL8ay2QYsZOxHDD5y62KQ1xioorNgMABMthMUsIZko=;
 b=e7m4gYhrGzh7sQCKTUgihJkyV9OS/mjdZZUmtBRHFYDv8391y1zcK846kSx9g5RS+NMlEQABuKtxvfAo9W5I+j7BirIJo/3gavFHb5s7uzjBIWJovrCfmTBvxz2fDMbUeCbWH215kn+jDvztWb19jRb23+Sbt7MGtLvjqb74fOEqt7wdkcyBjBgwe4txzLYX3LxkTolcZZwEN5yWrN9T2/nMXUBGph9q2BP0SjWs7SLDgdd0yoDa/6ek2JI+cpZlLhLn9zOklqpH7ZUykk0/JBPuS2NDgklnAezrHX2eH2x3kgHgPv53SNT0kX7A3ILaxj393FH2mLiimuoGcAAzCQ==
Received: from CWLP265CA0390.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d6::23)
 by AM8PR10MB4081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:23:44 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:400:1d6:cafe::7a) by CWLP265CA0390.outlook.office365.com
 (2603:10a6:400:1d6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:23:43 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:25:58 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:23:41 +0100
Message-ID: <d2197387-dd8f-4b87-8580-32d1df19c0de@foss.st.com>
Date: Tue, 24 Feb 2026 14:23:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp2: Update size of DDR entry in MMU table
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
References: <20260205-upstream_ddr_entry_update_in_mmu-v1-1-5495326f7446@foss.st.com>
 <f1fc7d31-ed9a-4af0-b73f-ebe10f8c7447@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <f1fc7d31-ed9a-4af0-b73f-ebe10f8c7447@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A792:EE_|AM8PR10MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 04151830-3682-4d6c-0d84-08de73a7eeca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmViTmFEeEw2Tlh0T3kvRWU5bjl6ZGt3WmxMNWpYOXNBRzVOemZMVFJackl6?=
 =?utf-8?B?d0ZTOUExRUdBT2NOSVVnZVVsRUExczlpSUJDczlSUlp2WGthdkRjNm9QR1Fa?=
 =?utf-8?B?ZUpKVi9DYVFFdjBzUWIyTmwyN3NLRkl0Mll4ZTJVNG1OSUJGM2RZc25oVnlv?=
 =?utf-8?B?d1RldGEyM3QzcmRZZTVNSW5BQmd3aWpETnhpR2YrZzBkU042QTdxZU9NT0Vr?=
 =?utf-8?B?UjhlQUtEb0dobzBxZzhCRXhKWGw5YUhadS9ZazBaVlJCVFQyNkducHhHZ1dX?=
 =?utf-8?B?a3kyTTJ4Wmg5QlN5WmZMMkhNekI0TXRSd054UDNYSFhYMDhKcFZGaVFOVVlq?=
 =?utf-8?B?bmtTSW5jaVpnZkVXVDJQam16UllHWWlWaE9zWS9aOVZjVFR0c2VoYk9Bbk1P?=
 =?utf-8?B?YTZzb2paYzkzbTdJcUxtWHB2RzBsUDE5Z3JtVytIbjc4eXlFeHJBZlg3c0tZ?=
 =?utf-8?B?ZkozbU5rMlRNdGcwYXFuOEltNnZSVjlTK1prWmNMTG1wZDlLaVV4L24vRFg5?=
 =?utf-8?B?SDJEeFFCS2I3T2U4ajNWN2dLaDFoemVjTHAzUjhJYnFhN0t4RDgxT2FzSVZX?=
 =?utf-8?B?TGNVMG5reXVLcHJ1OWhKOU1zZmlXTlpHUExPVUpGb1o3ejJvT3RFeSt1ajFU?=
 =?utf-8?B?RExlRmJNZC8vc21NZUNBTnliMzlnczhabzVSMVVoWTFDYUdQK3BQVlVXM212?=
 =?utf-8?B?OWEvQi9zVHBBSkN5cU13WGFSWFd1R0dNaW40bUtCVEFYeHRhUWJFMDhUZ2Vz?=
 =?utf-8?B?VjFzaXFvZWUvM3prTXAxRkJSd0RQdkV0RE93U3lIYTg3eEFqanNCcCthNzgy?=
 =?utf-8?B?SktQYk1aYUVaNU0xdGljZXJLSmxJbU4vL1ZReURjWmQyc0hOQ1pXejYzNTdw?=
 =?utf-8?B?ZGdDbFZSdUFCZnltU2N3UHdpbjAzZHgxT2YxNHZrRkFzdm9kTzdqRGgyaFBZ?=
 =?utf-8?B?WVJ3SnRocHk3T0tpNWNvM0h2cE4zbURoZ0ZvNUd2UFRCMGFGVnJYdE9BeW1T?=
 =?utf-8?B?MlBTSHZlbHhYeXVFTTgrZHc3UzYxTEZNTjN0STRuNHducjd4MVRpb2tmNEdp?=
 =?utf-8?B?RFRDVS9aS3k2SVdsU01HNjNOZ1FTRDVTaStGbkFHQlkwdFpwQm8vUnRhM1Jo?=
 =?utf-8?B?Q08xWllKWGF6emZRNzM4b1dGbnBvRkJQYzVFaWVldzZDQy8zaEs3SjczVGRV?=
 =?utf-8?B?ajMxZUNNQ2g4b0xaQU53dERyUmxpZmtQU0JGbkxCK20zc1UvZ0NtVk1NVm1p?=
 =?utf-8?B?RDNLNE1jc2RyeFBNRzM1VjlpdnV2QytHM0ZQSHhkQk10TWkzcFk0M3RrQmVu?=
 =?utf-8?B?aFlJR21meFhOS3UycUIwOEpPL1V5eEF3TFdKQTQ4OFJVNnQzdmx1TmMrbXUx?=
 =?utf-8?B?VEJQTXljRXVuT3JJN3FkejJ6OHQvYisyNEhTczVuTHc2Sm1UY2dJUzgxbVZn?=
 =?utf-8?B?dWNZRFJyRlVjZVJhUWt3bWQ4ZzNic1hoUlpSTVBpQTNXN2RTZXpDd1RBZDRI?=
 =?utf-8?B?a24rZEZzcEdyeG1XaGMvVVhEMG5WL1VzL21UeGtrNENMR1FlYzlyMGFrMHlV?=
 =?utf-8?B?M0xqYStZMDNOUmdxanRXMmRWQzN5N0x1YjF6YVVDT1duamJ0NlJJa1ZPS2RN?=
 =?utf-8?B?SGpRRGlpZ205Ykx5aThjTUpWNjdWL2tVaW8zUVVtY3kySXA3K0l1eFhQc3Js?=
 =?utf-8?B?RnB2L3J1NCtsNXJnNFdEV0JCcXJQYjRNaldiYnB3RitEeERyVkxJODhaN0ta?=
 =?utf-8?B?L3I2OTBRazRsVkFRYjZzOWxnRmhNREtUTlJpWjBUdlIwdnVHejhYTnJEYS80?=
 =?utf-8?B?VjZOVE5IVUM1OHZiL2NsYm92M0N5MkRoOUlqdDZ3c0FRdVBKUE12NG9Jc0F4?=
 =?utf-8?B?eE1pNFVHUjB5SEdQREdMdXZVeGJ2NnpLcGIxY0hyUUp4aDViT2NyWXEwMVJv?=
 =?utf-8?B?Rldic0U0c3N3VWhtM3loRTdtTmhoRFNmL09tSklRcXNZZjB1d2QvMTdHKy9F?=
 =?utf-8?B?aGRPRlhPYS9yR3NUeEoxZDVqTHRuaVdrSGFtRjh1RFlyMzEzZG05b2hQSXRY?=
 =?utf-8?B?bis1ZDhYL3JSVzN2TXJ3OVlpaVFaTmZ2ZWFYTFd6NklSYXY4SHVwY0V6Y21S?=
 =?utf-8?B?Qk54RGlCU1lTMDRQSmtoVHM3K1BycTloblNxVlNXdFcrNEpSbTZ1YlAxT2ti?=
 =?utf-8?B?NGFTaWo2N1Z6S29UL2NiZVJpWkg5dk9tSTkwQWt1VUVCVGtuZkhxOGVUVG5s?=
 =?utf-8?B?M2NYM3IxdVNDd3FKQm5JSGRUN1lnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I+ygkSLJT9ZZOeQ1FEaz5CSe1N5PcS0vN0kg0GneJSdrdRmKoiOHchbAVb+RX1o+qBG1c02s8l0gL1B3/Zer5tworv5831e43/wTS9o7mroFFeUETUTtzTcFBVkUE3Uf/xTR1XJnL6PWDqZJkNKuyk41nJqQYUw7h2Ux3QdwN7cK2QjgGdywrHMlpgvSNbpc7qdESnV4zMFMFITKRSCTvkXNvL9zEDhvaN77V+Wy01oIsjigT3MzE8CNcovfbGu6nOO/iXhr+LFOTTOXWRF3stugxFOemhfi4biSKbA4jf00bg4nE0zSwoIwrVLKtGreklXJlWE6fCH8EttqjnQDciCcMPCCrVC3obp/RZHfv2dlj9/ibbxf09uzrdrbnjJtA4+vb0i5JGJ8bN/bKXZLWaas9+ArcJzV8dYkvUJ12CGCxoTEYD7IQhDf0IG5TsTt
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:23:43.5387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04151830-3682-4d6c-0d84-08de73a7eeca
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4081
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



On 2/24/26 11:26, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/5/26 17:20, Patrice Chotard wrote:
>> On 1GB board, in particular cases, a prefetch operation is done just above
>> the 1GB boundary. The DDR size is 1GB (0x80000000 to 0xc0000000), there is
>> an access on 0xc00017c0 (ie 0x800017c0).
>>
>> As beginning of DDR is protected by MMU until CONFIG_TEXT_BASE
>> (0x80000000 to 0x84000000), it triggers the following IAC:
>>
>> E/TC:0   stm32_iac_itr:192 IAC exceptions [159:128]: 0x200
>> E/TC:0   stm32_iac_itr:197 IAC exception ID: 137
>> I/TC:
>>
>> DUMPING DATA FOR risaf@420d0000
>> I/TC: =====================================================
>> I/TC: Status register (IAESR0): 0x11
>> I/TC: -----------------------------------------------------
>> I/TC: Faulty address (IADDR0): 0xc00017c0
>> I/TC: =====================================================
>> E/TC:0   Panic at /usr/src/debug/optee-os-stm32mp/4.0.0-gitvalid.8>
>> E/TC:0   TEE load address @ 0x82000000
>> E/TC:0   Call stack:
>> E/TC:0    0x82007f30
>> E/TC:0    0x820444b4
>> E/TC:0    0x8202dc54
>> E/TC:0    0x82041fe0
>> E/TC:0    0x820143b8
>>
>> By default, in MMU table, the DDR size is set to 4GB, but not all
>> STM32MP2 based board embeds 4GB, some has only 1 or 2GB of DDR.
>>
>> The MMU table entry dedicated to DDR need to be updated with the real
>> DDR size previously read from DT.
>> After relocation, in enable_caches(), update the MMU table between the
>> dcache_disable() / dcache_enable() with the real DDR size.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/stm32mp2/cpu.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice
