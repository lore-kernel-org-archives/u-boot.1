Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383CAC44500
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 08:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8686F8341A;
	Wed, 21 Jan 2026 09:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Th3Bqoir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8F7D839D5; Wed, 21 Jan 2026 09:26:03 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4895782A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 09:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbYP/L42yG3g9y+wP2Hh3Bp7DgvjdAcS7cutuS9vF0SIk1rZyw16XFflIR653Hwub1a+2LOGCA2jLf/8P4UrgW4gYm/LVw5i4kvX+ENxvTQAgfVR9NxSyfW9K1RDFTaMKkshGmIaHcwQTvppROko0NRV2chNd6zpc0UpRlLif3t4+91F4KhL1CE6PGY3FUz5FgwvJD69YaGPMWiNqL6D68UElvmhnNnytIu1kIcca9dsorXgxvKJDBx6nWhL1NTGl3EyaORinBEW2dRBSp5rTK+vpJLtF1VSW5YdBviCX9PaE9weS+comQZtJf7C3zFxZ9lPFnHQ5C0l7N41ZFJvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG+kdB+ANFyOVXl4JL3/976xgXyMmQfpD4iepBRkkYQ=;
 b=antumHCmX+Btn4vYZqCsCnMcWTRPoGLN1unLerYn+DUINzliNmMk4xp0f5HRIhClJW+CwCduA8WJwPG0LK4KUwXjZ2UZMZu08C2DgPOnmqV8d1AoEKeJnw1WYxEZ0GD5iROpDKJ7j4AnKArywygm8myoE6Ch+c1azg+d5CLV1XDPANeXNtZKD/iUUjY9+Bf81uz4onmOfj/iXcBnsR769K2bccmTtCbaHlcfII1IRp1F17/TLj/egejGNZH1zscSHqDV4qRnWdI4XiWnn5cLBh8ftEjFet4+4kDPfOwMrw+V33Anjk5T5JWOFBSlFr+B8EoKvCyzHmJmGiWUJ0QoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG+kdB+ANFyOVXl4JL3/976xgXyMmQfpD4iepBRkkYQ=;
 b=Th3Bqoir8DYvBSWtCRg/Tkb0qO7K1TvZIeV93mpfKi+kexOkxDkqeEgF8mMDFyPyi9bJ/5Ui9UVY+bu7DJVNETHp1mkQEaSQ0yxOM1NC0Eq0sXwCSZ5aLzINGtKpN2deYD//U51a/yLvrnQ10ST0Qg7Ida/PO2ElI4SCwpAahD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 08:25:56 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:25:56 +0000
Message-ID: <683f7dc5-bba6-42ff-a403-dae963041e8e@amd.com>
Date: Wed, 21 Jan 2026 09:25:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rtc: zynqmp: Add clock framework support with
 calibration fallback
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Padmarao.Begari@amd.com
References: <20260120110056.3640303-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260120110056.3640303-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0153.eurprd07.prod.outlook.com
 (2603:10a6:802:16::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a197bb-9d09-42c9-cd9a-08de58c6b303
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXpTdW5UK0ppZTArNUZnTlF2ZHNLT25FZEZnbkNwQUJlNC9JaVZZUS85cW9D?=
 =?utf-8?B?WjJuMjhxZzU0Z2ZRNWthTDJtNnJQb1F5dlljWUVZRkUvYzd5N2pDa0NjNE15?=
 =?utf-8?B?UDR6bEhaS05FTVZsVGdUdzU3MDJiZUhUU2hMdzhLQm0yR0tVejhBNFJsMVVV?=
 =?utf-8?B?SGF5VkVmaHJtU2ZydWNtUkxVbFBpODZZcFRuYnRxWnNmQWxsdG1xMzhNL0xw?=
 =?utf-8?B?NTROT2tVVXdmUHZIS1pLdlN0R3FHamdFK2FYTWp5dGdyYUNmeURUeE1xallU?=
 =?utf-8?B?TnAvdGtneHdtekFvcUpLUStWdG9QL1lwYk9GWGI5RUpBWkVMSUQzRkZ5QkxF?=
 =?utf-8?B?eW1TVjBzdGJqMk9aemdlMlpzUmpvU0ljQ1RrTXlrdW51K0oyUmZQdnFXWklJ?=
 =?utf-8?B?cHNoaCtXU1BMTVZKRUh6YzJObzNDZG55M2xGNUt1NXdPaGVqQ24yVDJtam5K?=
 =?utf-8?B?YWtkR0gxUWFSdVEzS1VJMTQxK1lqWVRXVzk4U2NBdDhyU1hacktrV20wY0dL?=
 =?utf-8?B?d0xjYTZFbkFDalB6Zkl6ZEc0TTNTKzQzZEtURkd5Nm5RTnpFMWxuM3h2NWlV?=
 =?utf-8?B?V2p0S2hiTVNIalJYZVpoU1N5Q2RDVkJnL0FFRG5pNUVkcFVlNXJwWmpZQjli?=
 =?utf-8?B?TW5QblJqWFJtOTYrakVTNUl0OWNpWndFYUp2T05PSmtIQzJaeE5hWUNFUUY2?=
 =?utf-8?B?Zm94c1dVNGxJeGZ6eG9ldC9IRjJXQTkyak5NSU83Mnp1aEdkaEFLZUo1VFlU?=
 =?utf-8?B?YzNFbVVJVCttWFB3TmhSVitCN0xacTlkTFhna3RxaGIydml4YUlaTzlNWkZi?=
 =?utf-8?B?cEN6eUZFYUVDRVpBY3QrR2dhb3FMOTMvN0Jaa2g5b3lybkhvTkZ6QVd3a0p3?=
 =?utf-8?B?ZUcvaHR2cUtDNzRDcTJtL0FIcW1mcTVDby93ZkZPSzVza2c5Y3VlL3NWMmJU?=
 =?utf-8?B?SVFjWExJNXM3c0JybUUxTURTOFc1cTRnR2k2OGRYcUtoQ3hidzlGMVM0RXVN?=
 =?utf-8?B?ZTd2alNqZ2tPdnVQdHR6WlFvaHhySlQwcEkxNlVWdi8vT3R4UC9RU052Z2ty?=
 =?utf-8?B?S21nL2d0VFQ4M01IYTNxZXI3Ui9IbkRwMG1sWUY0eXhXR0V1RU0vR2k2ZjlC?=
 =?utf-8?B?RjZUQ2ZMUGVtVmk4SUxLQVYxL3o0elMvR1VlNGZVOWoydDFTUitDNkkraWFY?=
 =?utf-8?B?Slg4Nlk0NjBtTW1JbTJDYlNHMzd0UUVsN2tUQWd1QmR2anh1ZDgySWpLVnFl?=
 =?utf-8?B?dWM3ZktaQ3ZUQ2lpY21PTjMzeUFPME9vMUhUWXJGa0FFRWxOZ09kakhsUkMw?=
 =?utf-8?B?eHF2QnF3VFBzbGpVamp5Tk1oenc5dXkwSmpFdHBTYlBOOTRLWkpBMnNjckt4?=
 =?utf-8?B?cGI3TE9zbjVtSlRGdGtVaEw2a1M3Wm1rbmtyN1phU0VaczhlK05TdllSVTh1?=
 =?utf-8?B?MkFPUGNmVllJT3ZaSndpZFU4S2FuV2JXSS95LzZCZXp0aGJJYjhxdnV6RDJ5?=
 =?utf-8?B?cnA1TkEzcFZvUG5mdWJhMSsrOTk1ZTUyV25Lc0xPZWxNcEFJRmRSVVhDOVNh?=
 =?utf-8?B?Z290THNxWkMxMGI3cXFLcmlLdXZwWEh2d3NnTVI1dWh1SHJRZkZEekw1UzJ3?=
 =?utf-8?B?ZWJweEhhbDh5c1NoTXp0Tmwydm9LWnBCRkxLTnJGSGdtQWtZMXZtb09SOFM0?=
 =?utf-8?B?R3BEK2VZVUlWVUtCdkFFNnFoWGRuNVNLOW1pRi9rcEZmckZ4UjNtbFg2L0RC?=
 =?utf-8?B?WVB2ZVhVL1BGSXdlcjIzalN2TkxDd0txVGx2Qzk5VmhzalV2OTRmdGp0OTd6?=
 =?utf-8?B?YnpiNU5EVHEzNnRMU3kzRHlBVkYrUlBzMk5kcDF2ZHljQVQyeEJ1aVZkTGRY?=
 =?utf-8?B?QmpnY2dIZkRxYjRuWktWWVRzL28zZkVXTlRQeE0wMVkxUVVUYWRBL0NJNGRG?=
 =?utf-8?B?L3MvN1BreHdtbk1uMGJSTk9qSms0aTh0Sk5waWJIZ0lmK1N6K3h2YWNxOFNR?=
 =?utf-8?B?Ukc4UTVhNEh1b09iR2paalFKaEg5U3oweTFvZ3lSclVvd0g5U2NIaGRBWVY3?=
 =?utf-8?B?SGVncnUwMXo5OWRwRjNGUFRBQ2xWWUFEYWs3L1l2Z2tlV2NCRTB3RCsyclZY?=
 =?utf-8?Q?8pSU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFROa3hLYkliQlMxL21uYk9TcG9TQnE2RDA5Vkd5cGQ2bEdMZEt5MThtR2FW?=
 =?utf-8?B?MlpZaDB2dEtrdXRvRkpaNmRlaE5qU3pza1ZPdVFFaG9IN3h4dE5TanRUbjRV?=
 =?utf-8?B?bW1BSnlucEZpOGFBYkY1UzM4cEI2S0k0cXNqMlZxS1hUZzdrNVB3VWVOdkIv?=
 =?utf-8?B?SnRtMExPbkpDOWpUYyszRUFJWXpnV211MFV0VS9COXNja3VFS0k1NnpmQUFm?=
 =?utf-8?B?ejNDejV2Wk5Rc3VoK1JQbVcvYXRHRWIyUGxDVVZuT2RrMFBLUHAwWTJydnQ3?=
 =?utf-8?B?N2tjd1BpUlVQOFZiRTU2RkFIZHBDUVVZY0tXUEZnUEZiYUVuWmFMRnRKN1kv?=
 =?utf-8?B?UldxMGl0dnNuMklXSnBlWGlTYkJDZUlaT0cxOWRxbUFycVdaazZiMTU1Z21J?=
 =?utf-8?B?eldSTk9PNmpSSVE2SEl4eWxnRXdjWlliQlpTbnVPaEZSYld3bEh3bVI5RWxs?=
 =?utf-8?B?QWExbG5CTVpUdDJiUkFySldtdFJRcjQ1clc2RVROWHM5TldrTkV6WUF5UHZx?=
 =?utf-8?B?SC84Tzl4ZHlKTHFUUVJUUGh5cHhXbGJpdTdJT2pISHdGVENwbDV4a1JOcFBW?=
 =?utf-8?B?akE5S2tIS0JNUkdCNm1YZTJnTzJGTjQ4YUNjRytvaWZnL1ZVSDVlekFPbXNo?=
 =?utf-8?B?ZmVDdm44V0JVZDBKaEcrUFM0Kzl5TzQwY0FIMGF4eTNsZkIvSUR5bCs4Mm0v?=
 =?utf-8?B?eEtueGVkQU9qbWR5Qm11Ynlzby9PN1g4Q0FubWtjTHFVaitBS1NlSU5iUFZy?=
 =?utf-8?B?RGtncis5UnRDN0R1S0VEMyszRWRhOGVsYWpZa2NLd1huMWhCZUdNR1MyZC8w?=
 =?utf-8?B?VTA5VFhlWHZjSFBxNFRLYlZYWFA1bmFuenhNUGs0U2NlRk03ckcrL1VJMWNJ?=
 =?utf-8?B?VXVQOG4vUFozcGt0c3RxaEF1VWFLYUcrZDkvc0ZZSnIyQlAxY3A2aGkzMzdO?=
 =?utf-8?B?M0hSeFU4NWxkbVZ1MGsxUGx3bzdsaCsxTnpVN29peWJxWnhvYlJHSEVoUGxi?=
 =?utf-8?B?RldJS1JqYjVyd2p0NGcvaENSYWErQWdWZVFaTHlKR1lrYmU1VGFtNjNDRGFT?=
 =?utf-8?B?WnlhZTltRFVVazFnSHBmTkJkK1FIRUdoNXptZlAvZHNYa1NsMGJ1TXFFcHl6?=
 =?utf-8?B?M1M5aDNBRENSYTd4Y283anc1dmFWU05sQ1RENXRUZEVjZFJXYmoybTV2cHNL?=
 =?utf-8?B?OWc4V1FJZzl3SkxoUVBybnpKQkJrTW9yY0JlVTMya0EwNkczVkJiYVI2bWtE?=
 =?utf-8?B?Tmx4RWozU0U2Y3FFdTFMYUg2cVA2ZTN1SkxENEdkcERFbGxHQjdTSkRMTFRZ?=
 =?utf-8?B?TlpnamVrRTlWSjIzZzJLTFNvRVVyYkJyb0pGa25ZK1hrc2RrY2w0VFcvdlJH?=
 =?utf-8?B?R1FKRFYrU0s0eWsvUUZObWlyVk5kZ21sZ2ozUzVSWWdoeVJsSklXYk9IRTRV?=
 =?utf-8?B?VmFwQ3R1c29EZzFuM2Joa2hUWDYvNm1KOXFtVlNlOWtqSEZMY2tqRytLTkZF?=
 =?utf-8?B?N3lMcTlSUXFzU1RlekpzdCtIclpmcmZSMXIwbjZNQ0lmcU0vZ1FRZ2hEbkNj?=
 =?utf-8?B?TFdBdG03RU5vS2xZMWJ5YmZtdnpuRVhrWkFsek5UTjdaK3hvSGZIaU5ENjFH?=
 =?utf-8?B?QnIxQ3dHdFJHZ04wZThOSm15OE5GQmtSbTZGckt4dWdKOUJRakRQaFVrNkVp?=
 =?utf-8?B?RWp1S0lhK0d2ME5RdjFGVVh4dVEyejZDaE9pdVhtb1F3L3htaXcyNVpMbGZF?=
 =?utf-8?B?cEhQY1V0bGJPd3dwZzc2dHY1eXp4UFdDZ1V5VWRpeEUzdFdZVE1xcGFKUFR5?=
 =?utf-8?B?WFZOOGFidG9CM0pEeHovNGc4TGF6eFNrT1RMYWZ3UWdiOGdEaW1wRlN6bUN1?=
 =?utf-8?B?SENOc3VRcnR6ODFTajNBQ2RQcnhsT2krTVlxamIvVDhFUll3eTJoSnI4emE5?=
 =?utf-8?B?NkdzMG04L3ZPb3o4NHhwM0FualZLOVVPNFJlQmRJbURiNkpnRW1GR1NRdFI5?=
 =?utf-8?B?UDQ0WEU0NVZIb0pDMzdZcDZseVd0dkVHbnVpQjBCN1FpQUI1WEhpbmpTdzBk?=
 =?utf-8?B?THZuR1VlaDVKTlZkU2I5UGhVNkl4YzJickI0TVd2V1pEUmFmaGNnQUNTRXB4?=
 =?utf-8?B?dXA4VEhjUTQrbStxUmZhZFBLaGJPeVN0UlRNU1VCL2o5bGQ2SitiQVY1SDFO?=
 =?utf-8?B?VG1Wc2xsQWxqZ2NJUUsyZS85WVMydVhVSkppRW9jZE5FWFYvUWdRSjRUK2du?=
 =?utf-8?B?U29FT2ZIaStVYkV4L3AwaVJLdFJGWDkvejdFYmFZSWlYRDV4ZC82dTR4LzI2?=
 =?utf-8?B?MnpsdnZlQkczRmpObHE1NDBwSUVzb0d4Tnl6dTMvQVV6d3Y2VWMwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a197bb-9d09-42c9-cd9a-08de58c6b303
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 08:25:56.6813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWv9vjENrsFaz+6FD5nANUXj1KUY7TJKwvnBhXpdbK8RULt4+Uk1i3VJFAEXuTWk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204
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



On 1/20/26 12:00, Pranav Tilak wrote:
> Add support for reading RTC clock from device tree using clock
> framework also update the default calibration value to 0x7FFF
> as per RTC specifications.
> 
> Falls back to 'calibration' property if clock unavailable, and uses
> default calibration if neither is present. Only writes calibration when
> hardware register reads zero.
> 
> The calibration write previously in zynqmp_rtc_set() has been moved to
> the probe function. The earlier implementation wrote calibration on
> every time update to clear the tick counter, but since calibration is
> now dynamically configured from clock framework or device tree during probe,
> it only requires one-time initialization. This avoids repeated tick
> counter resets and unnecessary overhead.
> 
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
> Changes in v3:
> - Reorder includes alphabetically
> - Update the commit message
> 
> Changes in v2:
> - Rename variable from clk_freq to calibval
> - Handle case where clock node exists but has no clock-frequency
>    property
> - Treat invalid clock frequency as error instead of warning
> - Move calibration validation outside if-else to apply to all code paths
> 
>   drivers/rtc/zynqmp_rtc.c | 64 +++++++++++++++++++++++++++-------------
>   1 file changed, 44 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/rtc/zynqmp_rtc.c b/drivers/rtc/zynqmp_rtc.c
> index 15122a04838..4fee75bf9cf 100644
> --- a/drivers/rtc/zynqmp_rtc.c
> +++ b/drivers/rtc/zynqmp_rtc.c
> @@ -5,26 +5,30 @@
>   
>   #define LOG_CATEGORY UCLASS_RTC
>   
> +#include <clk.h>
>   #include <dm.h>
>   #include <rtc.h>
>   #include <asm/io.h>
> +#include <dm/device_compat.h>
>   
>   /* RTC Registers */
>   #define RTC_SET_TM_WR		0x00
>   #define RTC_SET_TM_RD		0x04
>   #define RTC_CALIB_WR		0x08
> +#define RTC_CALIB_RD		0x0C
>   #define RTC_CUR_TM		0x10
>   #define RTC_INT_STS		0x20
>   #define RTC_CTRL		0x40
>   
>   #define RTC_INT_SEC		BIT(0)
>   #define RTC_BATT_EN		BIT(31)
> -#define RTC_CALIB_DEF		0x198233
> +#define RTC_CALIB_DEF		0x7FFF
> +#define RTC_FREQ_MAX		0x10000
>   #define RTC_CALIB_MASK		0x1FFFFF
>   
>   struct zynqmp_rtc_priv {
>   	fdt_addr_t	base;
> -	unsigned int	calibval;
> +	unsigned long	calibval;
>   };
>   
>   static int zynqmp_rtc_get(struct udevice *dev, struct rtc_time *tm)
> @@ -70,13 +74,6 @@ static int zynqmp_rtc_set(struct udevice *dev, const struct rtc_time *tm)
>   		 */
>   		new_time = rtc_mktime(tm) + 1;
>   
> -	/*
> -	 * Writing into calibration register will clear the Tick Counter and
> -	 * force the next second to be signaled exactly in 1 second period
> -	 */
> -	priv->calibval &= RTC_CALIB_MASK;
> -	writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> -
>   	writel(new_time, priv->base + RTC_SET_TM_WR);
>   
>   	/*
> @@ -107,15 +104,6 @@ static int zynqmp_rtc_init(struct udevice *dev)
>   	rtc_ctrl |= RTC_BATT_EN;
>   	writel(rtc_ctrl, priv->base + RTC_CTRL);
>   
> -	/*
> -	 * Based on crystal freq of 33.330 KHz
> -	 * set the seconds counter and enable, set fractions counter
> -	 * to default value suggested as per design spec
> -	 * to correct RTC delay in frequency over period of time.
> -	 */
> -	priv->calibval &= RTC_CALIB_MASK;
> -	writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> -
>   	return 0;
>   }
>   
> @@ -128,8 +116,44 @@ static int zynqmp_rtc_probe(struct udevice *dev)
>   	if (priv->base == FDT_ADDR_T_NONE)
>   		return -EINVAL;
>   
> -	priv->calibval = dev_read_u32_default(dev, "calibration",
> -					      RTC_CALIB_DEF);
> +	ret = readl(priv->base + RTC_CALIB_RD);
> +	if (!ret) {
> +		struct clk rtc_clk;
> +		unsigned long clk_rate;
> +
> +		/* Get the RTC clock rate */
> +		ret = clk_get_by_name_optional(dev, "rtc", &rtc_clk);
> +		if (!ret) {
> +			clk_rate = clk_get_rate(&rtc_clk);
> +			/* Use clock frequency if valid, fallback to calibration value */
> +			if (clk_rate > 0 && clk_rate <= RTC_FREQ_MAX) {
> +				/* Valid clock frequency */
> +				priv->calibval = clk_rate - 1;
> +			} else if (clk_rate == 0) {
> +				priv->calibval = dev_read_u32_default(dev, "calibration",
> +								      RTC_CALIB_DEF);
> +			} else {
> +				dev_err(dev, "Invalid clock frequency 0x%lx\n",
> +					clk_rate);
> +				return -EINVAL;
> +			}
> +		} else {
> +			/* Clock framework unavailable, use DT calibration */
> +			priv->calibval = dev_read_u32_default(dev, "calibration",
> +							      RTC_CALIB_DEF);
> +		}
> +
> +		/* Validate final calibration value */
> +		if (priv->calibval > RTC_FREQ_MAX) {
> +			dev_err(dev, "Invalid calibration 0x%lx\n",
> +				priv->calibval);
> +			return -EINVAL;
> +		}
> +
> +		writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> +	} else {
> +		priv->calibval = ret & RTC_CALIB_MASK;
> +	}
>   
>   	ret = zynqmp_rtc_init(dev);
>   

Applied.
M
