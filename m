Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1470C3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 09:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E20E98070C;
	Fri,  2 May 2025 11:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="NRLus15F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB02380F03; Fri,  2 May 2025 11:21:35 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::708])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90639803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 11:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgQfoRqtmuEhDrnS79znoWEi6NuMbATXx/r3f5SJtixhk7KsZxStQb/fVi+xuyELYgZY67aH9FUvpFy7GMPZIUS5JANPfWAdYRkchGeskqg2RVzkb8Vcv9Zte1PyqKhp+y5SSRSdTsqxjyzro7FlSaHw7lksqS1RLWIg2Ea/xs70icZH5mmH8+h4t+M1WPnCSbf1N7GpvppdTm5sr3PE1pImCeGKOrvnVHhQ4x6qZQ0uO68BGbII2vfhKT3hZSkLPwWNKaJygUqqmnAVwoKduKkmi0RgWU4J2kOFkH1mc/fUGvl0oY8RK/7A5/m+eREMS6XXHDPmzfZAsfNCurBM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pHpNYFP3HFzZvs8BwWcpfBffTgBLbhRPUNnq4QtLSw=;
 b=YrU66Lh0qErOE0U/rf57jP6Le0gJkN5533OlZYM6mBJoLcYxOHfMbRECyQoYfkOQwt97yugABH+QqFcBy7Qbiteoj2W7BfvzFNMt5/YD00rmQBS3IzkAU+UStre/uUzppOw5hnwlcRpoeOcqs3RKjHjRPqj0AcoaVbFZcoOAcPrUV+m6pKcITwPMxhv0kj2kwsv782GH3Euo09QV2VMcODC3XpP1bwrD7PRiZPCWLeDMBnuFPFoLD0uguMB1P8vYRkehsDNWEy6FwTNzWjBRk3b9BUdO6nxCzqbL3fbm6lG4LaJWkRhLZQ7qFC8fWx9DY76mD6P7rNm/CHpmjJggXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pHpNYFP3HFzZvs8BwWcpfBffTgBLbhRPUNnq4QtLSw=;
 b=NRLus15FgPV1pvfQgYojlHXPq8/jLh6hwRAHUetoO3RjVkTVUHEVpWIuAxAjjFnfO9FvH4SAhFYsAslydCKhWhcYuCMMrQWjPkTc7fqSIqe0xMYfZcM1sVWwvd5sQh/vXjLf0qDSRQkq0TrjpSicS6D/sxUoKf5VVha++JeVlBxwh+2L02BhNdXVt9pOJZETMfNFkkrQbs/Y4MZL0t2rL1bPHHnqQLPjm8o7VBexbUmqRZBdTQwwVPlbxXIqFKfQrLgQoYSlWA9UGrBpTFrjkjI9YpBgJdcl3fLPobMJckM+HmvYNG/nmY+qmQl7W0CV2OvKHj3pfomw1oxBcz08dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by DU2P195MB2440.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:49e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 2 May
 2025 09:21:29 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 09:21:29 +0000
Message-ID: <7380d93f-3bfd-4f68-a779-8b7e180cdb8f@phytec.de>
Date: Fri, 2 May 2025 11:21:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] board: ti: common: Kconfig: add CMD_CACHE
To: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
Cc: vigneshr@ti.com, trini@konsulko.com
References: <20250502050517.3724756-1-anshuld@ti.com>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20250502050517.3724756-1-anshuld@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0354.namprd04.prod.outlook.com
 (2603:10b6:303:8a::29) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|DU2P195MB2440:EE_
X-MS-Office365-Filtering-Correlation-Id: b330beaa-d86b-4f23-fb13-08dd895ab843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjcreXlwNGtsQ1VNdEd4L0F1UzlvK3VoZStZWWtRbktPR0pEK2M1M3o4eTM4?=
 =?utf-8?B?VjlLbUFickhwVWJDNnFyUmJBU1p5cEl2cU9IeVZteTBPV3JFWUI0alRjM2Iw?=
 =?utf-8?B?cE5ORlljSXVlUU03ako3R3BINmF5YzNqdmNTaVI1MW9pRU1oYjNEcjBZZFdF?=
 =?utf-8?B?Q1AyaU5TbHVMQXFhVTB3VEw4dndjOXBoSTVOeEtGZXJHcUxyNmpkRG1uS3Zu?=
 =?utf-8?B?TkpOdTg2aVFTMHFPQ3FzakRSTmdSenkyZXExN0FocXpycWNGbnNOdHNRRlRj?=
 =?utf-8?B?QXlLQ2xqV0tQRTVZWUVLVDJ1NURNcUd5cUJQdmZTZmlIU0ZjL3pDTEJBVllO?=
 =?utf-8?B?TW9oUnk0MldJdHlYSENmdUpaUEVQQTBaNDVSeTBjQUk1TThQSFdGaTJOblcw?=
 =?utf-8?B?VHhwUEhYM0FuSVpKOWtLM0F5bUlJQzJ1SGZockc5UnlHczZmU1Q5b3ErWnZq?=
 =?utf-8?B?UWo0VXprV1ZwYUpDSnlXUmozY2NNNThPdnYrRG1GV3BIY1ZvQ1RGeTN1VkYr?=
 =?utf-8?B?SXdsWkRDZ0xncGFGdGtRQSt0OENOREdONzBxTG1lZ1hNMlRjVHVkVGVtT2VM?=
 =?utf-8?B?Zm1nRXBlREpZN2JuTThlMUhMSk1RVS84dC83Zk5zQXRMQWt4clozbW9qMVZZ?=
 =?utf-8?B?QnJWcEoya20xNGRLRlFtSzQrWnBKbGxmcllHVlA3MHFscXpSM1gzSXJFcU1S?=
 =?utf-8?B?ZEtCaGp1eW5hVFN5eUx4WUUzTGZuS0NJMUpSUFJRamJaQWZJN2lSTE05THBI?=
 =?utf-8?B?YlVWK1FTT0hKU3hpNEY4YTFiZUtNRXI3SVVpaXg0ZVB2VkkrK3hScit4cHZh?=
 =?utf-8?B?c3FhTE9ESHhLZXUyVnhidkJMRXV2czh3K2RTeEkzM2FnaDY5KzNzcjhlc3lR?=
 =?utf-8?B?NmR5SnpWUFB3NkRIOGFTZ3dZbzZ0UHdBM3UvUlMxZnppSytMWHFjdnF1VzNk?=
 =?utf-8?B?LzdBRjdDbDNybG5xcjhVcSt4dzhDZmUxMm1kNVFuRjh0NjlVeEJ2UGVQaHhS?=
 =?utf-8?B?YkxLVHpmc20ybFpHTk1Bd1RWdDgwNGdKN0FzeDhuY2dtdWhBeGRGNTZ1SU53?=
 =?utf-8?B?d2pRQi9jREpreURQTTRGQ2RnZFZWVU80UFpzRDJUNHFFRE5BKzhJZXh2NTRi?=
 =?utf-8?B?OVdYR0NkanIrWFptSnJXRUU1RTRlak4yc1ROKzlKbVRyRjZzTlBPMTk3b0ZO?=
 =?utf-8?B?TC9LK2xWd29aeG05TUhYM1VTQmJCTHNWR2FOaTBlVWFraDdKT3QvdU5TT1Bw?=
 =?utf-8?B?UDVFYUFuMUZMNlZoY0pkUXF5WFJTL01XdW5XZDhYK0dPR2hIbGtCWHplVnBI?=
 =?utf-8?B?SE9uRG91OUFrbjZlalhuSTdrRDVWSlZWRmtlRU5qck1PRUROVy9mU0ROSW1Y?=
 =?utf-8?B?bVNiR0lpd3NMOFlTT2dualh3aVNkUENBUU4rOUFhK2NjNjhYVkxtYUpzc294?=
 =?utf-8?B?VzlIZVJHOFdrVDNrSy9RN1dPZjBWa2dsa294dFdCa0JZNG1odjhnNlVDckhW?=
 =?utf-8?B?d3NtT3A2Y0hWdUFJYTYxNEF2TEdaL2I2RGl2VUI5bW81VDVQNksweFNTYkdu?=
 =?utf-8?B?M3dHVDFqVGpmZ1Q3UTB1cndDdnlrWkFqTE5EOGN0TDV1d0pHQzNZQVlHa2RJ?=
 =?utf-8?B?bDd1Rk9pbXc0OHk0enUwTUNuUTVRNG9PUXJ1R2w1TEw0NmhWT1NwcWMrT0pR?=
 =?utf-8?B?amNocm9YanM5SWdWdDNERVNLK21UaUNZNjYyYjBPLytmS2xUUkpQOW9jUjMx?=
 =?utf-8?B?aThvb1NBUndmNnUwUGhxRU9IaWJxRmpTSUw5dE9LdGw4cWs3MTNodkVDYmVn?=
 =?utf-8?B?SU1zZzhOTGwwaW1ubm9vMXlxTWUyUzFTMGZaeUhOV0ZpcnZXWEZyV0Z2VS9u?=
 =?utf-8?B?K3BPT2hqVENuNkcwN2hRaW11RnZhU09UU2VmZklPK3dmTEF4c1NUYko2RUpo?=
 =?utf-8?Q?zCJSwF6DPYI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTN1WW5NSlJZOEpJR2k4T0xBdUduT0o3SSt1cnlYWmljQXdqKzZJcERJWk1Q?=
 =?utf-8?B?L3A3NmxtZU5ubzRxUUUvemlaY2UvT3dOQnYya1htM3ROdGg5MXNoVnlnYUMv?=
 =?utf-8?B?cDJxSk9SdHBGUE51WjliUzgvY2wzdENFeEhmZEZWRng1Yk8yTGNVbjZFNmJX?=
 =?utf-8?B?TDJCQlZxWWFHZlppZmp4Ym42eTRXVEhTNjR6MzRIb1ZIc0pBYURXMitBRXBB?=
 =?utf-8?B?Y1VZMmpqNnJXcG1TTmdQL0x3YzJ1SFZUbEczaXpVSFM2MzRrUVBvdmRNaFl0?=
 =?utf-8?B?UVNrWDYwWjlaUVV3bGZZYjZmT0gxb1BKSStWcjM1ZzJ6b3NtQTlFUTJ4Qmdj?=
 =?utf-8?B?eWpxS296enVvWUVFVVV3L21TVTlYWmQxcDNHQXNBSkRpTDJOSCs3SG5lWjFp?=
 =?utf-8?B?UUozV3loUnliZUtyTlJmZUVEY3ZYUWpOMTBSdTNSOEgvYzdmWSt4bldLVGJL?=
 =?utf-8?B?NmRXdjdzNkNuT1h3ZU83YWJSZ2Y2QUxoY2hFNCt1aDdNM1RTNllpNnc1QlMv?=
 =?utf-8?B?cldRQzRCdkRLTE9XT25jS1FweFJGK0VNSHkvS3JHNUNvRW96OCtUWE5YRElQ?=
 =?utf-8?B?YldkVXpnemxQUXJZWFJSTHgrWUF0azM5K2UycUQwM0Y3QXQxdTJzL0lCK2dI?=
 =?utf-8?B?d1lSbmNCa0FQRmdkL0xHNzRKeDVMNERwT3dBS3Vkekc3ckE4b1NCTXhvODRX?=
 =?utf-8?B?M1hLVTVYRFl2NFdOdkxzNUlLalRhN2xNSkRENHVEdEI5NnBMbXN6Y3IxK09z?=
 =?utf-8?B?SzJEaDd4dHEzVU5PUFcrdVpuSUI1dkN4bk9RTjBFd3RHRVA5S0Y2aXJCdWdO?=
 =?utf-8?B?R2FuUzIxQm5ESXpFUEpxUVRjSHlwZDA4NDR5a0w2VVF5UFdSUUxNRVBpVWFq?=
 =?utf-8?B?SlFNSm1kZGxYN21NdjAwYXVDR09jUFpWU0krMDRsdndlYXNqSC9Ed29LWjRM?=
 =?utf-8?B?YXozTXNWK1cyUUs5eXBWQkxha2tjd294amFZMSs1U0tnem4yTzB5S1dFVXRE?=
 =?utf-8?B?TEdISVRYRVdqalltZVZLVWJNQnpINUJiVUhBN2hjOVVmTE5ndUEvbThhNnh1?=
 =?utf-8?B?b284YVlpcGZhdzUxK09CSmdNT0w4dHRWWmpnSklrdm9TcmN1NG5uUTBLNVJD?=
 =?utf-8?B?dE5oOWE5eVF5czdzRkZsRC8rRzdldG9LRVRLYkFVMUhOazYwWU9OMXMxUWd1?=
 =?utf-8?B?YUFSSG10aVZsMlZwVEdGNVhEaTVvVWZuY1UvaVFqMGVlQzRlMllQZ1VpM1c2?=
 =?utf-8?B?eWM5NXY1cXQ5czAraDhYeDVJM1RDd0VDdjBDb2Q2Qis0cmJjNnFINC9iWmpV?=
 =?utf-8?B?YjJieUgycG9SQkRJcW1JdDJRbGgzMEpZMWtpc0FpdS9Oa1lONDBibnhScW5Q?=
 =?utf-8?B?MWNvV0p2NkJ3aCtydlpWQ2NJMVcwUzNiM2VBZWRvRGNlUlV6Q25EOUd0OVdi?=
 =?utf-8?B?Q2xIV3NyeExETjAvZmpacW9LeGRBNVZ6bVlLUXlJd1FvWm42OHNlUWVKWHE2?=
 =?utf-8?B?Vjg2azFQRlg3Vi9Pb0tjcktjaXd4SFkwZnQycFhjcjFuN0lkbjNTK0VrNFpB?=
 =?utf-8?B?YmgvYnRoNW5yR3drNVF0OWlQMEZESHFydHVJVzVJV1RUcWlYT0NjbTVDbHdr?=
 =?utf-8?B?V295enlGN2JncFVhRERzM2plcld2NGZxSmhYVXE0T2JuMG1IOXEwUUY0Wk9l?=
 =?utf-8?B?allBd20vV3ZWK0hiK2xmN1IwZWZsSjRWVXpMNzJRSTNTUG9IRlRDemc2QlFy?=
 =?utf-8?B?dDFHWDFRdHBsOFdIOUJDTFlObjVMUVJkRkhlcW1OUlRwTmpTUUE3SlAvZFdx?=
 =?utf-8?B?ZldaWXg5TkZLVy8vdVo2c2FJdWNlVGEzRVQrMDRXc1FPeFFXTDI2RHRIb204?=
 =?utf-8?B?aFI0RCt6disxZzVCOE94cGZ6Q0tVbWZDeE5ONUlhaldTYUx4cTdMSzZZK1Rx?=
 =?utf-8?B?ejBldG1SbVBBUnJyQlFkd2laZURRTEJLVnlkSHpIVEFVR1Jham5pUHhSUjZP?=
 =?utf-8?B?NCt5S2s1L2xNTDFLQWdKZWdFY2M4V1JuS3lJUVNUbHBZWHpQS2ZRVTQweDRa?=
 =?utf-8?B?YXpXQ3pyUEFtQkhSUkVNaldibUp6TGxEcXZjZG1neDRJWHRJSVJROWEzRzli?=
 =?utf-8?B?cnorK3l4WDBTUkZYY3pONXFCWTZ5SVozbDlneWlKd2hoRVdLR1dYRkFZczlL?=
 =?utf-8?Q?+HEeWKE0mnE/jrTx6RNAHaBwttW5dICcF6KxRRQF6Cpp?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b330beaa-d86b-4f23-fb13-08dd895ab843
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:21:29.1872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82oI1jUzkhM5oR3u5gGEOZLZn+4/YVhysOMj9c1Rj2fR5PwYT6KazIJ4yCh78Itq/9TuoSwddNe+uC4DvGz92Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P195MB2440
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

I like this TI_COMMON_CMD_OPTIONS config. We will consider to do the 
same for our phytec k3 boards.

On 5/2/25 07:05, Anshul Dalal wrote:
> Add CMD_CACHE to list of configs implied by TI_COMMON_CMD_OPTIONS.
> This allows the usage of cache commands from U-Boot prompt.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>   board/ti/common/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
> index c03aa3a368f..d578ee44ae8 100644
> --- a/board/ti/common/Kconfig
> +++ b/board/ti/common/Kconfig
> @@ -26,6 +26,7 @@ config TI_COMMON_CMD_OPTIONS
>   	bool "Enable cmd options on TI platforms"
>   	imply CMD_ASKENV
>   	imply CMD_BOOTZ
> +	imply CMD_CACHE
>   	imply CRC32_VERIFY if ARCH_KEYSTONE
>   	imply CMD_DFU if USB_GADGET_DOWNLOAD
>   	imply CMD_DHCP
