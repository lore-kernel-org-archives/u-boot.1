Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C6DC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 10:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BBCF40AF8;
	Fri, 24 Jul 2026 10:08:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJ8pCaemUljd; Fri, 24 Jul 2026 10:08:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08ABB40AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784887734;
	bh=N1MxLEDW9tqzyd2YS3+Ckc3GpxPKSWvminu6HOv7F6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tjGHNXnrKOzcA6j3dpWA/bxp+gr+CbcWdWArfE7iCBjRp7ZsxZSYhujJcU5uPNhgC
	 3tahNNZunGnNOXwnM+albsIjbiGrrb7+UEDKREOkwtwo+k7tnnCPW22l29VD+DifVg
	 gNXoY+CsU+JZDTm1zBNUpZ2lLRZQxpZnP+mKzxG3VitWnhOTvr2/nAzOe2aUnrqpK/
	 SBPBRvy2Mes9cRnDgE+UBFanILDU4r106ZmtlJYOOLmAFdWIM804AVuKY6ibeO5x+b
	 8sXboW3kcy2gkB1ENks1Q+qu4sTw+qt7Gcl8dgfOnOKYW/zCiYRV6PhES5pyC+G48n
	 tZmIjVMl06x7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08ABB40AA9;
	Fri, 24 Jul 2026 10:08:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 812352E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7303A80FA7
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:08:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7I8_hxgSe5q5 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 10:08:51 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3CA1180F81
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CA1180F81
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CA1180F81
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:08:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D98E83E76; Fri, 24 Jul 2026 12:08:46 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D31800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 12:08:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWAm9/0EPqa8eNVIbPvmvtav0Jx3TZxKlviBbJNkO69xRdjMCd47rT5uVrl4e7Y5BQmz963vSOwsVf+dXvwEW9B39Fe8h5dkPpjyGPf8Ifd6gBUMf0a2L25/Vk+qwJOnDCoIwK+rCr2x/xt+9bSP0uH/PDpKIka+2d2GnLe5e22Puw8R6AAQluTZWXk9jIY5GctsBy0D3rI/NERaSvceToxcat7CBDaAfIlukco9lNUZ8tb6czRqY3BfwxVeOUbHsfxsZ9+RvQdGc7pKCv+imKCQZALePFnJabx0io+IocReeXb8VfIbVBRr+CZeBcuAfkAD0BCUYe4XKXUdNU7ECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1MxLEDW9tqzyd2YS3+Ckc3GpxPKSWvminu6HOv7F6w=;
 b=okV5pqg1CMz3pDgn28JCKosqkd8zl6UQK5FNJzJLT6Vr3QVSNuB4nwsY07dIGw6ZvZOfMufD0IJVbfaurFTyKGdFe6yicS1J+ePGnGd+7sZIpZRTZ57BCCTHTAIWEO8pVaQua/JA2beZwxk9sC9mG6HRDs/jo33SdzS+tYfuJSphVwvbN3FtMOGLGpTiA2wFv9GeSudLu8Y3arv9VxjBJjsTQ5fKSWCP3aW1zZRIva+sIGbU5c5M8CqGe7OCH4gGQRf6OdMsQ1c70ZgEIq1s2LkwjtpqkntM8BtMFCCue3pPLFutrBEx104dWU5eTrgKWM7tTUdrW9FFRaJZc1DPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 10:08:36 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 10:08:35 +0000
Message-ID: <1c507d13-9ad5-4360-bdc1-bae22c53019e@amd.com>
Date: Fri, 24 Jul 2026 12:08:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: zynqmp_gqspi: fix quad mode bus conflict
To: Suraj Kakade <suraj.hanumantkakade@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@openedev.com>,
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
References: <20260709083757.1851446-1-suraj.hanumantkakade@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260709083757.1851446-1-suraj.hanumantkakade@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0084.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::7) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd63cdf-d402-48a9-8ee0-08dee96b8619
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: YV88Qw6liZ1Cx/v3tjWoiorbCpU6/YtC24mio2wRNDLQ5CYWg0uXNioHUq1HvkAxXMAfwKv04QhfXRRCzoIzI4F4me3bCeg9/C6+n//gUJdYghB9dYMHAeQI0HKH43dKuCiPW6eHplmeod7WL04s/D4VuO/VMgvHRjg6wEN4TjIPndjjX47NnqfEeaiqdgAo3YiYEd31qEE1Os8w8CBCG9NO+J5c25JpHxXgQtqM8TQpv0jT4bq/gf9nrx2yJA/YAY3fKRXe2NphuktITQ/DjMaaoACUh/oKrda7xM9toemnVRKM9qJTrMsiTEia6qSEO1lS1hnUnWepFdRsbeEyz5pQ+uCVY6c5rCJdxr2qlXRN4dDQljSD9S+0ev9LFoL4mhTNghmO45K5qhPG3JhWt7jagI5C9b+wlB/AW/XyoCdQDdXGMZE6BEa7l6AmG0sQqHyfU/FjmNRyHfOjK/E/zKUtQFIjMwVtXs/Mr+MLa1LsevccT8Tp5O2tj8PVlB8kmWRoM6d8OtLhBmtyVve9mRWFvXUJ7qu+LXUqBhLGtsVyqAh9H0Ogr6m3J5nYf67p2bQxZI+YmDtJhLVJSaGzmwTLXt17zM065vBplXwV7hqopkX0IJFKYnnAs3LpUUrHWp9bUb0zvsoQX2DVKrw9cghNT/RwoffjHeBKrL3fEXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGErY1NBNXg3d3RJY2lkVlFqaDIyMUdDNk43eGI5cnJlVVhyYkY5eHhkdk5q?=
 =?utf-8?B?UmY2NjBsS0xwRUJEYm5lY0N6SFBoN0tFYW52WEplNzJmeWV3WWFLKzZnV0cw?=
 =?utf-8?B?WE4vSHhhbW9wRFRCODUxRDlpMlBZNUN6YXNXV0J5NitUTzFkNFhmZjdYY3Uv?=
 =?utf-8?B?Q21ZbTZncGVCbUlpamNoK1ZiYzFIS0dXKzR1WFU5NHRwcUhMWXdjcmhvcERS?=
 =?utf-8?B?Ykt3ZkROamY5ZnVUUlFzSDJiVWg4TjA1cDZJbndOT3NSZUp4Y3lWclF0anVm?=
 =?utf-8?B?WVh0eUZaNCs1YWNVT0ZoL2VaNEREbW5oTko0bzEyZ1M3NzlybElzYmNOUmFu?=
 =?utf-8?B?dmlLdlVNK2h3OUpmQS9aRmZ0Y1poSkhnL1lLMUVtYlcxMTcvWVJVWWdpbDBu?=
 =?utf-8?B?WUV6SmNjTDFOUlJsNkV4M0FxNmx2aFl4ZEVTeGQ3Rm92VlNSMVF3R1FzQzQ0?=
 =?utf-8?B?TzR5THFqM3pubjZXQ1lzOGI2VlMyUWVNSm5PMzQ2S0xOdHo0ckxIb3BDcy91?=
 =?utf-8?B?bmhHcTNGUUMvWENsRk5TUHlaZEdnYUdwamZRbnIxajZybVF5YnlMdm9zVlJp?=
 =?utf-8?B?TEJxTGs5Ymw5SVI0eTBvTHVsWlptVlpSc09EdGhOdmpBeVZQWWs4bUVoaFN2?=
 =?utf-8?B?VE0ycmFMTlVZNk5PYi83YmUrNDB1ck9kd3J3STBTMzFFanFCb3lSSi9abUZM?=
 =?utf-8?B?YTlmb1Nsc2hFd3krWVJhMXU1c25qQlYreWJ5eWIyY29hMUJhWDFBb3pXWTVW?=
 =?utf-8?B?UC8vWk5PY2ZzQzFqdVUzaTVaelNaVmVISzErd3NNYXdLRDY5amxBRmg5dE9q?=
 =?utf-8?B?ak5CcjVTWnQ0U3JMY1Q3a2hxUHcrU2RxdGw4YUREMkhEZjdJMDk2djNSaFVo?=
 =?utf-8?B?TUlXbFV2QXlhV3UyQjlZdm1BaWpPUWpQUGl6SDhqWHdFVzE1emhjWmhnZE5B?=
 =?utf-8?B?R0U4Nk1oM3NPZnFOQmhBb09GRW5NNC9kS2xSK0h3eW92MkRlanBCNm1kVHFj?=
 =?utf-8?B?dytQVE9TN1FNMjY3T09UYVRkNE5EeGtjeUE3TDZKN0R4V2p3RzZLbU5OcU8v?=
 =?utf-8?B?a1htcTRPUGVWWkxmTEk5UGJqeWo3NE5BUEpGR0lKck9BVzcrQ0VmVGozN3Vk?=
 =?utf-8?B?dSt2YS9oT0tKU05ZYkliTmI0cFM4Nys4VmF0bnlWSFc5QmFtcUpHVHpiSi9N?=
 =?utf-8?B?SGNtZU1XN1pDNHF4aXc3SXRLQThnakNPWGtIakt0dUJnUmRydDVySUlRbVRY?=
 =?utf-8?B?R1p2T09hSW9OMzh1QkJrY1U2WUwxYUhlcmpiNE84UzhJWXllWkdURHZuVnI0?=
 =?utf-8?B?UXVZcW05Zm4ram1xWXIxNVBWQmdRYURDR3NJTHlzcWhFL3djS05YbFEwZGp0?=
 =?utf-8?B?ZS95QjBCcEVxZmszN1pWSUx6RkNsYlpXc3Fzc3pMM25QejA3RTRYb1I2VWpa?=
 =?utf-8?B?L2ZERkNvS3hYWlpLTGdKd3RBUXV3dGIwOHNzVHNFNTZ0dkVjM1p1eS8vcUs3?=
 =?utf-8?B?dU5QbXZTWGw5YVZkc25HN1NmK25IU0FLN1BndjBXK0VKZlhBZEtINXZmOTVV?=
 =?utf-8?B?bmJMVHduRUoyTVdkZ1BoUVZoeXpLeG1UT1ZyRmFvb0RDcTZnS0RQWHZvWE93?=
 =?utf-8?B?WUZrelJmcGYzRmFFQm8yS1BGWjc4L0RFUmRtUStOUXhKN0gzbUk0Yk5RSlpB?=
 =?utf-8?B?cE1sbmViV1NlYmpUcHd2clY1azB0elNucHBoZnhrNmxqcHRzYldPQTgvVHVl?=
 =?utf-8?B?VWN6djdualRzK2lOZm9ITnBNOGFWOGp3SnluMGhsNnFIZFM2T1RiQVN1Rng2?=
 =?utf-8?B?Uy9lUytqaGlseDhqQUhIUU9nN0pqNjBDYXNzay9CSUI1VGJ1OElZYTdFOHBT?=
 =?utf-8?B?Z1VZQnJRM0xpYTJpZXpYUDdMa3h6Z1VQUE82cXVETnRXNmIyVnR4MlZlVmo4?=
 =?utf-8?B?c3QrWmFvUi9PeUFEbG1JZjV0M1JBQ2tCdHgrd1RsSWkyTXd2YWU3NUh4bVFw?=
 =?utf-8?B?b2FZN3JDcWVQaUc4ZlBDTFNTOWFTRjlQYllHYXZjYjNCN1h0N1FuTWpPa1A4?=
 =?utf-8?B?OStvRUpuYWtrL1gzQisvYzJDdDJaZGJQaCsrTmlSamNmQkJPaUcvTHpTenRv?=
 =?utf-8?B?aGFrR1VyNE9McTYxRWtZa0UvNzMyRnFoME9DMjVwbTJIbnh5MjJZa3F3ZlZY?=
 =?utf-8?B?eS9WcXFUTWNxWEVXVHBhTDl2bmNVL0RVYXgwTi81aTdZOG80Umx4VHczaE0w?=
 =?utf-8?B?V09nMUJzQnF3QnVjWVNCUWZ6N0hhRUtGSVA2NGYvT0s0ZG4vU2YzREFWWHpp?=
 =?utf-8?B?czFKWjRacy9LK2Jud2MyZ1J6Sy9IbWdUbkRQZVJYQ051N1pKMEZqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd63cdf-d402-48a9-8ee0-08dee96b8619
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 10:08:35.5257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDrhUgoT/JBNtSGyN1RuOe+ElabdwBW9sfX1kJJspqIP9zF3zQyubMcE9Z2GeyJl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1MxLEDW9tqzyd2YS3+Ckc3GpxPKSWvminu6HOv7F6w=;
 b=LcHxFN2YGaSI/FYf7HnhKeXIzBkyxVyB6Vst1P+DT87D5IRJAAz/MAj6VIW2JgyQUWX2iXpKShNaw1bZeFKX7HE+AUhDk0y0c6aFLKnPqIMkUwkfkOnBeiGDwVXNRR1LUcIZbbK376MYNgEOY5d41ZiA1MTP+pct/ws99+RjxCI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LcHxFN2Y
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=michal.simek@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="LcHxFN2Y"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
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



On 7/9/26 10:37, Suraj Kakade wrote:
> Starting the GENFIFO after each CMD and ADDR entry creates a gap
> between the address phase (TX) and data phase (RX). For read commands
> without dummy cycles, the controller is still driving DQ2/DQ3 HIGH
> when the flash switches to output mode, causing a bus conflict.
> 
> Split the GENFIFO helper into a write-only variant and a
> start-and-wait variant. Queue CMD, ADDR and dummy entries without
> starting the GENFIFO. The data phase appends its entry and starts
> the queued sequence, keeping the address-to-data transition
> continuous.
> 
> Since genfifo_cmd() no longer triggers after each entry, operations
> without a data phase have no trigger path. Call start_gen_fifo()
> from exec_op() before deasserting chip select to execute the queued
> CMD and ADDR entries.
> 
> Fixes: 22cca1730ec4 ("spi: zynqmp_gqspi: Add support for ZynqMP qspi driver")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   drivers/spi/zynqmp_gqspi.c | 43 +++++++++++++++++++++++++++++---------
>   1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
> index 2a095d0c58e..f572f2b3f15 100644
> --- a/drivers/spi/zynqmp_gqspi.c
> +++ b/drivers/spi/zynqmp_gqspi.c
> @@ -283,16 +283,21 @@ static u32 zynqmp_qspi_genfifo_mode(u8 buswidth)
>   	}
>   }
>   
> -static void zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
> -				      u32 gqspi_fifo_reg)
> +static void zynqmp_qspi_write_gen_fifo(struct zynqmp_qspi_priv *priv,
> +				       u32 gqspi_fifo_reg)
>   {
>   	struct zynqmp_qspi_regs *regs = priv->regs;
> -	u32 config_reg, ier;
> -	int ret = 0;
>   
>   	log_content("%s, GFIFO_CMD: 0x%X\n", __func__, gqspi_fifo_reg);
>   
>   	writel(gqspi_fifo_reg, &regs->genfifo);
> +}
> +
> +static int zynqmp_qspi_start_gen_fifo(struct zynqmp_qspi_priv *priv)
> +{
> +	struct zynqmp_qspi_regs *regs = priv->regs;
> +	u32 config_reg, ier;
> +	int ret = 0;
>   
>   	config_reg = readl(&regs->confr);
>   	/* Manual start if needed */
> @@ -310,6 +315,15 @@ static void zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
>   	if (ret)
>   		log_warning("%s, Timeout\n", __func__);
>   
> +	return ret;
> +}
> +
> +static int zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
> +				     u32 gqspi_fifo_reg)
> +{
> +	zynqmp_qspi_write_gen_fifo(priv, gqspi_fifo_reg);
> +
> +	return zynqmp_qspi_start_gen_fifo(priv);
>   }
>   
>   static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
> @@ -573,7 +587,7 @@ static void zynqmp_qspi_genfifo_cmd(struct zynqmp_qspi_priv *priv)
>   	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(op->cmd.buswidth);
>   	gen_fifo_cmd |= GQSPI_GFIFO_TX;
>   	gen_fifo_cmd |= op->cmd.opcode;
> -	zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> +	zynqmp_qspi_write_gen_fifo(priv, gen_fifo_cmd);
>   
>   	/* Send address */
>   	for (i = 0; i < op->addr.nbytes; i++) {
> @@ -584,7 +598,7 @@ static void zynqmp_qspi_genfifo_cmd(struct zynqmp_qspi_priv *priv)
>   		gen_fifo_cmd |= GQSPI_GFIFO_TX;
>   		gen_fifo_cmd |= addr;
>   
> -		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> +		zynqmp_qspi_write_gen_fifo(priv, gen_fifo_cmd);
>   	}
>   
>   	/* Send dummy */
> @@ -596,7 +610,7 @@ static void zynqmp_qspi_genfifo_cmd(struct zynqmp_qspi_priv *priv)
>   		gen_fifo_cmd &= ~(GQSPI_GFIFO_TX | GQSPI_GFIFO_RX);
>   		gen_fifo_cmd |= GQSPI_GFIFO_DATA_XFR_MASK;
>   		gen_fifo_cmd |= dummy_cycles;
> -		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> +		zynqmp_qspi_write_gen_fifo(priv, gen_fifo_cmd);
>   	}
>   }
>   
> @@ -644,7 +658,9 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
>   
>   	while (priv->len) {
>   		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
> -		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> +		ret = zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> +		if (ret)
> +			return ret;
>   
>   		if (gen_fifo_cmd & GQSPI_GFIFO_EXP_MASK)
>   			ret = zynqmp_qspi_fill_tx_fifo(priv, 1 << len);
> @@ -666,6 +682,7 @@ static int zynqmp_qspi_start_io(struct zynqmp_qspi_priv *priv,
>   	struct zynqmp_qspi_regs *regs = priv->regs;
>   	u32 last_bits;
>   	u32 *traverse = buf;
> +	int ret;
>   
>   	while (priv->len) {
>   		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
> @@ -674,7 +691,9 @@ static int zynqmp_qspi_start_io(struct zynqmp_qspi_priv *priv,
>   			priv->bytes_to_receive = (1 << len);
>   		else
>   			priv->bytes_to_receive = len;
> -		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> +		ret = zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> +		if (ret)
> +			return ret;
>   
>   		/* Manual start */
>   		config_reg = readl(&regs->confr);
> @@ -741,7 +760,9 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
>   
>   		while (priv->len) {
>   			zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
> -			zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> +			ret = zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> +			if (ret)
> +				return ret;
>   		}
>   
>   		ret = wait_for_bit_le32(&dma_regs->dmaisr,
> @@ -886,6 +907,8 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
>   		ret = zynqmp_qspi_genfifo_fill_rx(priv);
>   	else if (op->data.dir == SPI_MEM_DATA_OUT)
>   		ret = zynqmp_qspi_genfifo_fill_tx(priv);
> +	else
> +		ret = zynqmp_qspi_start_gen_fifo(priv);
>   
>   	zynqmp_qspi_chipselect(priv, 0);
>   

Applied.
M
