Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C67CC5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 06:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CEB181190;
	Wed, 12 Aug 2026 06:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hWTF8sfywGhd; Wed, 12 Aug 2026 06:48:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2EFC4810EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786517320;
	bh=2r+NTVyZ6iJyfe/BmgzxxHPCoj78pQh9gOkI36RCMbw=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F0vHVEuDpUf3xsqioZFPdXKey01CT6IgtCfDY6O0ny54tEVhREYvcebIjaZCpYrzX
	 Ne/ox7tQphxppbYxTIKGjA2XwM6Q3iBIY0c1mCUA4YMfM15Cr3YeTI+hbFvI17fA3z
	 0SuoMlDPlL8ypKdVX1/hMXBNMSLS9ShZrccNvR7mWqK7/HGq4qtjZ86jPdndHdGLsu
	 oQMio70KuBnp5ES6Q5aDfPIc2gsGmFaQJOBAScA8IOGX941LC2vnRC7Ilyh3f2/Ruk
	 XbF1B5M7oy/R0kVln1MzFTBWNopqF0aqqY3QNyDqpOKZnpsbho17G1HGTqYiuF2nvG
	 jawmxw+EmxbZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EFC4810EC;
	Wed, 12 Aug 2026 06:48:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E6A6C259
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 06:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCC544082D
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 06:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n5hZeRx07UoL for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 06:48:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C944140824
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C944140824
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C944140824
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 06:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+BXV03/zjp3UgUqdvBTM0UOTHBEPMt6Cd5eYjc7Shr2uCgK9KntCemYzn4/eOHjVUQofPm+w3glIXdljEgXWKJY/x9uoaEHSJi16pjPiFUO09NK8Dg9KVTMsa0xEBwvuNb2cGg6hdX5WeZ1/iO5pytOoq08YJQJ7R0YZQXUT+fUbPQsguExAMNiWER6uhOBf+5Ar6Apgdm+gRQ0hGMpbjJkDAeXZghWnSs1hSNkXSuVMoqwGRQ01zLBCIXQ3cPZG554HxVbuKkV5/47OMcBlspxn8wrq90RApA+o9tKHF04sH92Gz26swDkzhvbVQ0zdUDU2UOrMg66+nGwwyTvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r+NTVyZ6iJyfe/BmgzxxHPCoj78pQh9gOkI36RCMbw=;
 b=iYqH645rVuF6hqoTX2jJjehKbA5328Ko0P5GhFPYsZtCmT+N76QotT1zCmru0IUM+1AKDR0G1JGOt0gU/WGt7cR3/ylrMslGN6j3frOBNht6YAHgHIq/IHiVxtFadjTNFEjn9Gwlvif+ej2PI9kfezgIIKJr3A0pI34MSJj1rPJSqpGXd+zhEhlLY8cHhDhQzdhHBKlKRTeImhe+C/iTwedVMnAa3QZCe8caQvwR8aWwLgXjmfCwxSVEe4chhw8OAWP+Mca2v+DlQlJesnWb8azHWU0curiQULysTazhSoAtAD5Pty0Em1diBymKaHnjfqjvjJth4RML6w70XpUk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 06:48:30 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 06:48:30 +0000
Message-ID: <422ca380-143c-4f9a-a4dd-082c955ca8ed@amd.com>
Date: Wed, 12 Aug 2026 08:48:24 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] amd/xilinx patches for v2025.10-rc3
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0091.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::44) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f71cfbf-c57c-446b-ec5f-08def83db8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: zcT1U9wvCsZwrrGQBqfmGDz0BUSDxTn70qJNgw3xhkKHdeFx2XTPxN9A+mXLiHDjXUb58A6xjVdK8a+aVHUAktGur/9LQvtp4IyD7slHizBRIs8GTxnyhY/z4WxiIq/eJND+wRddRrU2ylARaLpJvyzjLbK8bdHwCHEm2Fg1ntyPLJsWYrD5Nt3en2gpEUPExxlHy7p0wQCoyZqbsKLmthyj/2Lxt6Buf1xK2x9UK7cUV3Bc0GtNmieUzMaeC1AGh1HxFMVqto141Zxu7yFEy9pDCL1VOdeuQeeeBrBpSB+eGOtJaoSAMu4m5O+eHZEdrWLPV+2G83cQd7dPqdrwfv06xkQ+je1K7Lw1ZGBQNJdJy8lZVwpz4yDa6W/Zzk5w7MGvQxq/Bv8x01AxjKBI5hK5rl3Pzqad0QZVFpsbtxi4+7mPuxVsiWnZqYrbzOoZ3A7D6Z+QOX7U2nu1qKHl3BXFcUScf2YSg89Gq8obAWxG8udxUOw/hyrGVSIQxMr0+vLxZqwj+ta5AwpYvGK1i/l3Kl7UXp+zj67nxnyWCIAZS+BVPFvN9BzeIknm0g9WqniTwmeQWrwQOrw8Lr/v/YT0vh4RNVuWJweKAjpUCXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0FsaEJZZVhNOGZvaGRiOFRHZ2o0cnpzR1VoNVNhWVIrR3ZWZXgrVlVVNEJ6?=
 =?utf-8?B?Uk0rR250MXcrUitNYmJjTk1OSjBrU2NlNHNSWTJhM3VObEl4WjBuQlB2VjBG?=
 =?utf-8?B?QTg1QnVtWFVlUGdvRnBkWUVPZTFGTkZqVlFQa2xaUkVKcVBEb1RNekZZTE94?=
 =?utf-8?B?dk84Vnd1OUpiK2JwQkcyZHIxK2dOLzZ1L2dXRTdJMnNxR2E1NjIzT1A2Uyt5?=
 =?utf-8?B?Z2pLdjdKY3BnSWQyV1NGSE9OM25TMmpwQWt6SlhnbWE2MWRhdVhjK3N2ZkRP?=
 =?utf-8?B?ellFTDRPMURqWjRDUzVQQWdJbHdIUXYvWGVET21ZTGNhRjh5T3p6alQvamtC?=
 =?utf-8?B?azVna3hLK2lDOHlFeWhXQWNQM2g4OTF1b0o0KzJSN3BkbHFNaGRWMkl6aHdM?=
 =?utf-8?B?YzQ1cURYVFhwZVFVNnoyQzhFNkhXaHlhZDcwcTBVQis5SmF2K1R6d1Vxbmsw?=
 =?utf-8?B?dCtFQyszKy9xWW14VUsxb05pRThXYUtZcWpxUHdpWit4MVJzRmF5U0NTekhE?=
 =?utf-8?B?dlhVSUtEN1dHcWd6MDE0OFAzZmV5WWd5QlRnakJCNGFIaGZ1Z0lDQjE0ZktT?=
 =?utf-8?B?NVJPOE93dnJkMk53c2JNaUJTbGN6ZzZjUXFFOVNPMHJzMG5DOGNMZFJsbDVB?=
 =?utf-8?B?SXVzSTRkUlE5U1hZYnNhbFYrQTUzbHloVExIZml0Y0xvc3hrVnk3RTFTSFJS?=
 =?utf-8?B?cDZaWE1CUmk2V0MvZGROOVNFRjRRa1Y3UHZRejBXb2lSdDk1VFZoNnkycG9M?=
 =?utf-8?B?Wk9sc2VpdWZISzRtdHJaNW9TYmpuRFdzNW5TeHNPYjlpQzBLWTlIdkVCNGY4?=
 =?utf-8?B?UEdPczNWR2RsWFVnbkFWWHBGVnd5RXpLSTRrZkpCLzlEN1YrNXU4L2VnQ1B3?=
 =?utf-8?B?R1VTTzFDYU5xY0ljdDFTV0dVekxvT3pBUVJYc1loMEpNa1MrajlxM2NoRzdX?=
 =?utf-8?B?d2lWczR3ekpialMyZTQxa0VDSmRGV2pDbXdxck11QmhaTE0xR05mUTFJTUp6?=
 =?utf-8?B?Y3FXMlBSRkZYanhady9KRGl3Z3JvWDdrbURBTXBWT0tJSk1aUzA0czVod3VV?=
 =?utf-8?B?UXZlQ0xnNms1cW9SRDZXWWtTVlVPU1FsYWtEYkRFUTRETExoMTNNa3o2clZ2?=
 =?utf-8?B?dTV1S2VmZ1liS3VOalpWRUVxa2xCZmcvMzdJdmRTN0tua0xrOWdsaG5uR0lU?=
 =?utf-8?B?QlRFTTJOU3VuUEZHR05tS0tSM3ErZFY0SkhiV3p4R3k5S3MvOUFoc0g0eUVR?=
 =?utf-8?B?ZEJtVWFPYjJIUWFGTmNBbWVWM1ZaYU1XUGN3T1M3TmsrZTl3Uk94NkVUeCto?=
 =?utf-8?B?SzNiaTVQRUtEZTRlRzh2S3QrNFBIQ0xHdytSRU5WQ1diWkltZndjL216am1n?=
 =?utf-8?B?a1RyYnk2RTJ2T3RKQkR6NUNZNFFXVTRDZWM0Vm9FRjVtUTI5ZmNwMUNOQjZR?=
 =?utf-8?B?NTRwV1FoNHhYNFBJSDZBVFRCT0U3QWxBME9nM1FhQjd4UEx6MTBybmdUanhW?=
 =?utf-8?B?c3hlNEhBY2JhOG5pTEtCbVk4TTUrMmhxTWdZaDRZa3NhNnRpcUJ2WGk2Q1Zs?=
 =?utf-8?B?ak82MjRKK1dCd3pYM1R2aEd2SnIvaWZEbTdGNWNtVVlpbUk3YkhkL2tGSVNx?=
 =?utf-8?B?b3R0TXFGWFBtdkpUb2J1YnVyak15bWtCa3o2c2lGTlkwOUphNzBVR3hnVk0r?=
 =?utf-8?B?VTR3ck1DVDAwbmgwVVRMWEpIUERQUnRSZ29BREtlVmtjOVNXQ3ErYmwxSzMw?=
 =?utf-8?B?bEtsSTNqVU5wQUwxVDUycDVFMDVzSjNEcjlVMzZMRnNZMGwyMU9SeWMxMGZY?=
 =?utf-8?B?azNQVDBNTTNIYkliVUs1NHp1ejN6eE9qUGl5czhSdGI3UlkrVXJKWG1OOUxV?=
 =?utf-8?B?b0tmRzJYcGFabkdoWDkydUZ3dEMvMmdmYWFrSmJnQllGS0VJdmN1d0tkUlQ2?=
 =?utf-8?B?b2dGanREZFlqeVJtalVqandzT0s0QlF4dG9adkRqd1FiWnV2YUU5MGQ5MFRT?=
 =?utf-8?B?N2s4U21FUnhWN0dTUXNXeGIwaFg4WUxEa0h2emtvSWtnMU1tRk5lRnZSYXBP?=
 =?utf-8?B?T1duaDgrNFk5WEp5WldiV0syS21rMjB0eEVCNEJYRjNHSVVvZ2tCUFBWanQ0?=
 =?utf-8?B?ak9UYWo4eS9kRFhHTDRDdEJkWVF6U2FIUjd3YlUwMzR1VW9ENkhMMEN2WDEv?=
 =?utf-8?B?aFJZK0FmWm1DSXRybjZNYVFhd3FERjRzODlWVzF1Qmd3b1dzMTVtdFpLaGJ3?=
 =?utf-8?B?YVlVM2JaNXJTU3VoK3Uvak5VeHprK0FyMjNKMjczVEtBbmp2VDM0Rkd0TzNv?=
 =?utf-8?B?UkM1TGxlcDhrMDJlU0Y0Z3V1dlpWbUl4QWtteWF0cngxajJSOFQzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f71cfbf-c57c-446b-ec5f-08def83db8a2
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 06:48:30.9028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGfoR4UnM8y5pzVdvrGnspZ2rLjb670qfEcKbtLtzncZp/P/Dn1BmWATm6HVkehp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r+NTVyZ6iJyfe/BmgzxxHPCoj78pQh9gOkI36RCMbw=;
 b=IChPU8iyqIWki2wtP0FF/J31QN9IDNwyS1ZA5k2VTQO55/nRzC0AD7N7qaveLI62p5Zv0TOZqrgrHQu3X9LnRAHxa/X1grMeLN6cA8B6WwPWhiY8032kOf4FuaPbL86ID8ED9Vrsw9+WmT/t4pID0OXJVm6BZDorXBJDsBB/wL8=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=IChPU8iy
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

Hi Tom,

please pull the following changes. I missed rc2 but I think it should be just 
fine to pull this at this stage. I can't see any issue in CI too.

Soon we will be sending patches to cleanup firmware interface to be prepared to 
move Versal Gen 2 to SCMI. That cleanup should land in 2027.01-rc1.

Thanks,
Michal

The following changes since commit 77bc0326456d9d6a83aa7adac201d1c97a008b61:

   Merge tag 'fsl-qoriq-for-2026.10-rc3' of 
https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq (2026-08-11 
08:49:22 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git 
tags/xilinx-for-v2026.10-rc3

for you to fetch changes up to 86cc9f2fb5637d64e2da78c43fdccf4c50daef8c:

   MAINTAINERS: Add missing fragment for Versal Gen 2 (2026-08-12 07:06:12 +0200)

----------------------------------------------------------------
AMD/Xilinx changes for v2026.10-rc3

Versal Gen 2:
- Add support for 2VM3654 device
- Add missing MAINTAINERS fragment

AMD:
- Fix fwu dfu_string generation not to alter with generic DFU

Firmware/ufs:
- UFS interface cleanup
- Remove ZynqMP firmware dependency from UFS

zynqmp_gqspi:
- Fix quad mode bus conflict

MB-V:
- shrink SPL size and enforce size limits
- remake ELF from BIN

----------------------------------------------------------------
Michal Simek (13):
       arm64: versal2: Make hardware.h assembly safe
       arm64: versal2: Select GIC redistributor base at runtime
       board: xilinx: Generate FWU capsule dfu_alt_info from fwu_platform_hook()
       xilinx: mbv: Disable CPU driver in SPL
       xilinx: mbv: Disable arch-specific memory functions in SPL
       xilinx: zynqmp: Setup BOARD_SIZE_LIMIT for mini configurations
       xilinx: zynqmp: Enable SPL for zynqmp mini
       firmware: zynqmp: Remove duplicated sys_proto.h header
       xilinx: versal2: Add PM UFS firmware interface
       ufs: amd-versal2: Perform controller reset in the init callback
       xilinx: versal2: Clean UFS firmware interface
       ufs: amd-versal2: Remove ZYNQMP_FIRMWARE dependency
       MAINTAINERS: Add missing fragment for Versal Gen 2

Sandeep Gundlupet Raju (1):
       xilinx: mbv: Enable SPL_REMAKE_ELF support

Suraj Kakade (1):
       spi: zynqmp_gqspi: fix quad mode bus conflict

  MAINTAINERS                                    |   6 +
  arch/arm/mach-versal2/Makefile                 |   1 +
  arch/arm/mach-versal2/cpu.c                    |  40 ++++++
  arch/arm/mach-versal2/include/mach/hardware.h  |  87 +++++++------
  arch/arm/mach-versal2/include/mach/sys_proto.h |   7 +-
  arch/arm/mach-versal2/lowlevel_init.S          |  40 ++++++
  board/amd/versal2/board.c                      |  39 ------
  board/xilinx/common/board.c                    |  37 +++++-
  board/xilinx/versal/board.c                    |  39 ------
  configs/xilinx_mbv32_defconfig                 |   5 +
  configs/xilinx_zynqmp_mini_defconfig           |  20 ++-
  configs/xilinx_zynqmp_mini_qspi_defconfig      |   6 +-
  drivers/firmware/firmware-zynqmp.c             | 104 +++++++++++++--
  drivers/spi/zynqmp_gqspi.c                     |  43 +++++--
  drivers/ufs/Kconfig                            |   2 +-
  drivers/ufs/ufs-amd-versal2.c                  | 133 +++++++-------------
  include/configs/amd_versal2.h                  |   9 ++
  include/zynqmp_firmware.h                      |  13 +-
  18 files changed, 388 insertions(+), 243 deletions(-)
  create mode 100644 arch/arm/mach-versal2/lowlevel_init.S
