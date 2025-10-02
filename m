Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D48CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 08:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1211834D4;
	Thu,  2 Oct 2025 10:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w/5FxBi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B25683526; Thu,  2 Oct 2025 10:20:42 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC35828A2
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 10:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MF30EErMz3TifKdNA8B+LU6EDs5J2/afE30z9MbOyjJdLZ3H7HE6rvK/6oh5GwfI8FYl0VhhDQFnKQLRUr+bvKToqDMAqMWpEoznwJKaNlswAcsU2/eLysyv0AjOByquFkRstQgkEU1TsBgwcdFRFU383qk1o2xpj975smv4gRYt5tHtptmIGcrFDIjoBn87Yv0rMNMvcevnClRP81qt8crocYExEObJc7Ga8ZbRd7CghuBCyeGTV5W3tabFX5pCa9PzQwK/hYU/xclikOhZ7Yt/QqooeYMqFUc3wiMjbhgS7SOZ1HIIapsmBi7Mn/34NfzHaSuxjQnnRtuBBn2QTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gNLSg8vo+rlcmtneEgaw3zb25EYuSTPf5UIwYMLY+I=;
 b=fX6rAmMFWj8ezNg3zVebAgc9O/DJ9oqxo8zJW0lCwAlb0uUmI+3QY0lzCE2xv4upLxAYr8Xj5+WSE3dKoFSZx7YG3Ujag0WbdUCGNbevrRaXn+0Vdo1KnqjLlaUoqbs6v8dFp9Kl7jIZOTXMY1UOzSygZlDSeu9Rus2kywJ5x2Z5BdLtc80u3mmnPJO89VuwGb0eHLpGZbATpo7oh9vyfhyWR2mioDmGxIt1tmDzMIFtbwRdiOiXFyCclannVarPq9ekm/oztNU070PRNeym3otWzFPE6WNeMDanz/SD4ZqBVGSdPgRTRZq7JDjWRHpjcJVDj5lNHXTXk/yDSikQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gNLSg8vo+rlcmtneEgaw3zb25EYuSTPf5UIwYMLY+I=;
 b=w/5FxBi4e2RbEKqUAwa7v02BrFOuMLcwxl9AZW+pdXRuwr6MagAEXbmOq2ugXb6sUlfNJjCkel5p9lwjKoyROtwls47iYz9Vs2WOWIRqhu5Kuzb0idyqGtdOE3PKXAo2bbxhzU36Or17sfLVcaRuP0zPpCrRif2tNcd3cvmI57g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 2 Oct
 2025 08:20:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 08:20:36 +0000
Message-ID: <3d9d3e1a-d904-4479-9f0c-957c121390a9@amd.com>
Date: Thu, 2 Oct 2025 10:20:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable sntp command
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, git@amd.com, 
 Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <8259ca2496dd8f6a25df566c43f16be019d75cb9.1759127081.git.michal.simek@amd.com>
 <7ab73b44-8efc-47d6-9e6e-5ffd9ab0e3d7@mailbox.org>
 <cbf26fe2-1267-4965-807b-fa0805e61bea@amd.com>
 <20250929140741.GC6093@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250929140741.GC6093@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: edb67ffa-cd14-40a4-ad7a-08de018c9055
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTh6VitnYlI1WGR3QTd3S3MxYm1SMVlDNzZQbTdlOGhxcTZRRTMvN3VTdkhX?=
 =?utf-8?B?TUF0R3E4czh6UnNmKzcxWEJ5ZzluTlhGbVdIVXI0dmNmWEIyYzFHU0ZvdnBi?=
 =?utf-8?B?S05xZnk5SkExbGswU3Y5dVlzUU5SN3UvOWh2QzFlVDRDUGl2K2RBQjUreEJv?=
 =?utf-8?B?dWp2bHpXM0p4aFhzNEgvVmgxMEJ3cm5vNUtubC8zRGpYVUpoTlg5ajJyQmEy?=
 =?utf-8?B?Q0RweFpMKytvazZuTk9mclRlUVZ3aENIR1JnblVxQllHYi9Eby9KalFManRv?=
 =?utf-8?B?eHRnRzlsNWd6blJyZ0NMZ3ZiNVlGbG9IdG5pcUUwWVkzQmZCdEMwMkpCMmNU?=
 =?utf-8?B?V2U4QnNEUEppZm4xaEdvZXlpMDczRFAvVEE3TmdvUGVtRTIxd2oramt4Y0xl?=
 =?utf-8?B?L1ZoWmJMdnd0c1lOMU5jV1pzSFQrVC8wNGtXblFHM2dUWW9qK0lYQVg1b1N6?=
 =?utf-8?B?Zm50MngvdFpRakMvdkxJV0E0bWxtaDVxRitpUG5Qa1hkM0RzY0ovaWdKK0hl?=
 =?utf-8?B?YkVBSDA4NWVZOTJ1RHNIa3RVL0gzY2wrWkh2NmNUNWt1Qk04SVd2SnBNdlZm?=
 =?utf-8?B?OEcvbkxkSm02b3RmcDZDRVlhcUtiWlJ5RkQyeEpiSEkrRURSbDRIS2FTdEwv?=
 =?utf-8?B?WkoxdWRic21VOWt0MFppcy96WUxJWURDTkYzUnl1V3pXZE1qbU5PRmxOS0ow?=
 =?utf-8?B?ejZWUVZLQURTaksxcE96bHozbHBBeFZyMUIva0NyckR0bXFlamhMMUQyVDRE?=
 =?utf-8?B?OUJJekZXK2tqRnNFK0x2ckNYWlhmZkgxeDNRNnNXQUJqVTlHbTFBZFlHcWZD?=
 =?utf-8?B?ZzhDblFlZmdaNVY1a011ZDl4UVphZjZ1UjBTSyt5T29hS2NpWE5VNnRMdVF5?=
 =?utf-8?B?NktWZkdHUzR5T2F1V0JibDNFNTRxaUY4MWpaSmdzQU43SnZ5QityUXRrT0ps?=
 =?utf-8?B?T1VYLys3anhiTjgvcTlZZHVDdFR4WmRBQ0ZIaFhDb29ZSlJWUEFKc1F4VkIx?=
 =?utf-8?B?V2MwekJNc3orRlczKytqZ3EwbmoyaHFwTnVjZWhvUGZ5cUZEM3c2RTNJS0xM?=
 =?utf-8?B?T0t1NVVsZlBCdHBFMk5zSUhwWGJRREowUThNS1RaQVFrQVRZZGl2bFVTelBO?=
 =?utf-8?B?bUNVZmgzRitwSGdrMkhKVUJsVTBLTlhqa1RjdzlyUndvRFpaVnVKVkRxQ21O?=
 =?utf-8?B?akdISzZnYmY3b0U4UTZUbTdrNWNuTEJ5c25JRjhIZHZmVWZXNkxXVEU0OXVj?=
 =?utf-8?B?YU9Qc1l0SmRtODcySVNERmJIY2hJdENnRDJoS2djNklLWEdPNUZnNFBPWTBY?=
 =?utf-8?B?UWJHTE5FaTdYZTJtSEpSMWtnSnpDVGJPVnI1V1o5VkRQYUI0aldDamNvYjhY?=
 =?utf-8?B?ZDM3aHRkN3RPU1JqSEozODJub1BtWU1kdFhGam9yVDByM2ZLbENhNitMS05S?=
 =?utf-8?B?bjZxLzl4Q1piaTZwalVHQ0lIdUdudTJyUEZpVS9zWGlUZkp1MHArY051R1N0?=
 =?utf-8?B?d0FYTEhDRHBBWkJFMDBWdUlGQVdJeUgxVUU1amRlN2t4aEFsSDA3VmFVK1NK?=
 =?utf-8?B?dUtUT3hzV1RBdk4yaVNna0VncWs4SHdaSjh1NzBUSUFXL2FVbnh3Q096NDhN?=
 =?utf-8?B?ZW1tWGFKNzVkRkFPWHNIY09rTng3N0VCS0RnU2o1L254dThHQmlCa2s2Z3BU?=
 =?utf-8?B?QURFRGovTEpZUHBNZnZtaW1tcFlBcmFYT3ZKUFh0UmdzaUVhV1VaV2tPYVJB?=
 =?utf-8?B?QUJHdk5naTZiSjdnWjJKbGdOTmxyaEF1OEt4VHkwVUFDMjM4NGQ2MExjd3JF?=
 =?utf-8?B?WFFsZ0gzMVhuK3lZbHA1TVBTS3RoZUhjbFVxVnBXQXBING9LUmIzWVhvRUtR?=
 =?utf-8?B?NkU3YVl4V3BKVFNGa2MvWkpDdll5UzZ5cUg1dmlKSWs2KzBPa0M4dkx5ZjBW?=
 =?utf-8?Q?HVRIufIjq2LCchq43OKQqkAmqFJGeFw7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW9LUTZFUTNlLzBIdWRFQVRZWS9aNDlrK08rN3NHdWtUMWRYTXVXc0pHVGN3?=
 =?utf-8?B?dWxTYlNlOTFVdnZQTEF5TVM2SWVxUElIYUpmWVFyZXBtMFMxYXcrYWdyR2VK?=
 =?utf-8?B?QkxycCtHUXZJK2k4aStQV1ZBOTYrN3RDUnV5aitSQlhROS9YYmhkNXg3SjRJ?=
 =?utf-8?B?SHBZdjFYTGRWd2NYN2V6L3VjZmpEU2ljOFRUWXpMNVhNcDgvMTBBTGZMTkhG?=
 =?utf-8?B?bUIvYUcza01wWERTZ0NrZXcwamtkVmRPSmovdiszTGszVUQ1bU90VXA0eHA2?=
 =?utf-8?B?aGU1TkkzVTNYb2dqUklJYng3Vllpb0NvZE5reGhLSmhNbWlJNVFUaHdkT2RU?=
 =?utf-8?B?bFJ4eVAxQ0xaUUN0aS9tZmZyVTB3a0tTWU1zQTJjKy9rU29yNU9XdE0vWVdo?=
 =?utf-8?B?bUN6VmJxek8xMjk3WXU3aGtCWGxEWmpsWUI5YVJWd256VWg3VjYwN2tlUkZk?=
 =?utf-8?B?V2VoTTdxenREeHhUb0J1T3NobUhqaUZsQlZvSGlwbC91UlZJSWVJS0hvTmxG?=
 =?utf-8?B?ek1qaC9CM0NOaVI2QWZJS2ZpZWN2SVJXYUhrdk1WVTQ0WTk5M1VWQlI3d3Y4?=
 =?utf-8?B?VncwcUprU2gxejFQTDFObkVFY1NnNnlTRWdxNk94TkpSWEIwRHJybEI2cW93?=
 =?utf-8?B?YTdRS3M0VGk3SjkyQ1p3a0pKdkRUSHZ5SDVYalk3MXJ5OTRoc0x3d0lrWnZ4?=
 =?utf-8?B?S0JOWUdCOGVqbTFCN2tXcy9RRldQZU1BVWdYZ1lva282QndTWnFRZmVXSUZR?=
 =?utf-8?B?cGlzTFV3d3h2RHI5QnZnU3VTL0ovYnNjWVdJb2dtaUNVWVU3YTJOZUZFSkh4?=
 =?utf-8?B?MnJuNW5KSVdYSFNYcGhoc09kRVM0YWZCMlpTa05CQ3FPU2F4SlBJRjQ1Ty95?=
 =?utf-8?B?TnpDSlVpU1p6K1JSUkJwWmZzZmt2R0VFT3VXTHg2aWVYZzdsSHRxU3JtL3FD?=
 =?utf-8?B?STdieVN3TVNXYlVMZkpwYlNJWCs4ZGorS0ljenQvaTZBL3RrRUl6aXBVeEs5?=
 =?utf-8?B?N2w1Mnl5RnNrQkdpQklwZnJOK3JCdHZqVURGWGFoekhCSWtud0xXQ3pFZUVJ?=
 =?utf-8?B?amt1dklyaGE5akdYeER3RFI3SjFqSHM1ejFsY1NYclUwdTY0Q1FGWFdsSDRw?=
 =?utf-8?B?Q2FKZ0NSR1hXT29panBCU1RBQS9zdnUveEJzVGtoYmlBQ0hKbzJjUDR6eEJ5?=
 =?utf-8?B?blhKWEFTR2xZM0ZXQkRheEVEVE5aZmpaOWRsVU14Y2NjYmsrM0NMT3ZWb3l6?=
 =?utf-8?B?dUZkWG5hSVJ5RkdnNXo3MkFqb295eE1FOVZtUjBMOG9ncXBzbzE3cTkwUFFs?=
 =?utf-8?B?Y3JOSTY2ckdTN2JWUjVRUTJwcE9Jb1FESFp6RVdCSTVWY2lGSHlrNWJ0dWRB?=
 =?utf-8?B?cXA4NmcxckpEMkpNcTlqTnQ4SXVIQnpUSmZtQUFGdTkxS0tYZzRodW1DTnpM?=
 =?utf-8?B?YU5HZUtSajZ6MXlUd042a2E5cytDdnRaVHpBMU5IbGl3a254YzZEV2VDYVk3?=
 =?utf-8?B?TXZocHA5QzNsTVFCUDhlcXUyT0tMUTFKS1B4d21kRS9od2hqR1kyS1hMMVNU?=
 =?utf-8?B?MEFSLyt6TWR1V1Z3VXVEZkdFQW5JcXk4VG8zbHE0NHRPRUhpS1RRb1BoT3g1?=
 =?utf-8?B?d2hQaHB0RXhKOEQ1V2tpVVBLaVBZOXFqZGpEZ05Qb29meVltSHZ5STc0dDE0?=
 =?utf-8?B?Wjl2K0lrZUNTU2c4VTV1bHpLaitzb1pYRnJrL3FDUm1oQWFFVUpmdUpud09a?=
 =?utf-8?B?dmhwV3BEaDJ1UGZZS1FiOVczS0VCd3dvRUJUNjN5YVVSMThRbGNYRmNGY1pX?=
 =?utf-8?B?VWY3VzZvb0l0YzBSKzFHRjRjeUd6azZXNDRuc09oamhWaGx1clVXMkxGb0Vm?=
 =?utf-8?B?UDBkRFIwbkJtdk1uNHkzWGJhUDBuNllhTFc2MXBMS0U0QkVlTVlLTUdFL1FJ?=
 =?utf-8?B?aThQemJ2NHEweVJVZklwbFN2bWFpT2VHVlZEcDlnVXF6RmpybVBodEsrZ2I0?=
 =?utf-8?B?bExxQ2N4eVZnQUFKOWUxT051NFl3aHZTWlNFMzI4UzVPSWluRFZMWWhsdDZF?=
 =?utf-8?B?bDd3MGJkL25ZZVowM1ZScCt2a2pFSXdVSHpTcDdvb2FaVldjV1pOVFl6RW91?=
 =?utf-8?Q?u1C5KYDVNJsW7DF6z7+VY68Qw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb67ffa-cd14-40a4-ad7a-08de018c9055
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 08:20:36.4734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ml1ggQklm+Wk5Mtq58m+enIU9tdb5etREGVwCfjIzvDoS0gPbAi49cGWKTOQ6ie9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
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



On 9/29/25 16:07, Tom Rini wrote:
> On Mon, Sep 29, 2025 at 02:54:17PM +0200, Michal Simek wrote:
>>
>>
>> On 9/29/25 14:13, Marek Vasut wrote:
>>> On 9/29/25 8:24 AM, Michal Simek wrote:
>>>> Enable SNTP commands on all Xilinx boards.
>>> Look at #include in configs/ , that should let you deduplicate xilinx configs.
>>
>> Good suggestion. We have actually started to use it for mbv defconfig in our
>> soc tree. It should be sent out soon.
>>
>> The only problem is to keep that config options aligned with Kconfig layout.
>> Maybe you have any trick for it.
> 
> We just ignore doing a "savedefconfig" style sync to it. In the context
> of manually managed files, which these fragments are, it's just
> cosmetic.
> 

I have sent v2 also with mentioned changes in mbv. I will look at extracting
some generic configs later.

Thanks,
Michal
