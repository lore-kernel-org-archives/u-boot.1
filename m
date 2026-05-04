Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3793CD3423
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 09:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D06698394E;
	Mon,  4 May 2026 11:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iBAWWFEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20AC83EF9; Mon,  4 May 2026 11:00:35 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F72A80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 11:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfyCCUnC7e2Fj5Igl+D3o1ay1Ve8AFVeH8OxBODl3aGcAj1CmfoMlzSxwBSEn2hxlNSBLewR65pz3Fx+v137M3kB0544bnfP8W8jyyhKBfJyiQHfe4cQGqfmuVMbNkFfXV5/Q1x6F+wYMjJUFynnT5Xhe0m7w87XduCq/0HA56w1inlKcQ/wkFCnf2WhZov5za8vySZf6tPKpVBruzxFRAS1P5xbCiyHHLtmQrYzkyWOHrdPDUS2Unoh3o1vyEq72UZoHiyh34mX9l5M5/v0YSziGqvuR5XgJtPIrD8SEz83wY7dZz6dbpnqsA63wkbbpJbXUws7mQdaVVEgTiDcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGzGFDNfTCdmm5IJ9CerI6cxCZht/bM2U1Negs/Aw4Q=;
 b=CBJ8yR2FASaBmaeRq5R+XQS4m8lQNPXoUdAyzqhC3eThn1nB6liL9j/gz1nBfjJUxAQ5b62EWM4E3JXwq3dJj734SxZGMsZ1ML7af6/S30y6fcrN7czRxv/yPCdkMT2s6YTH9djeUsbnmKUiBiAixRrcst55F+Hvsq2Z5NO6tTlzZyH4QQ+6NIobiqh4Q9UoVgNnfvoJzVNK9XmCataX3cOgYwfcWouZurahE9N3KoufWYf0t1T/m3DJxYnTGAkSOrbAp3NYzwGq7UmZs+oclb//F6/eOsxD/rDNj8BXYh7QKLQgOMWRnc7HVfFH1UgyWBxiLLcTZLstV8Esp0rhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGzGFDNfTCdmm5IJ9CerI6cxCZht/bM2U1Negs/Aw4Q=;
 b=iBAWWFEVoJpgGbXxYl+FYnx5FaNAhIqzBv/P7P4myyKOdFIdvpGhso7QnLzKFFmMZKNvzankqe+S/dRc3T28gfBfeoOFx8oGmkW+QK0/5NEQn8KzHnKphxN3n0UFn8LOXjf9tZx0BQykASiq/W0zi6DTXIOqcincS6Hp1HMBwZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:00:26 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 09:00:26 +0000
Message-ID: <45470f5f-f0f6-47f4-b87e-4c4c5d0cc9b8@amd.com>
Date: Mon, 4 May 2026 11:00:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Skip riscv_cpu_setup() when CPU driver is disabled
To: Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de, git@amd.com
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
References: <0d875f98e9d81b68265ea26c379dae8ce5b1f5a9.1777550269.git.michal.simek@amd.com>
 <afRqUJZF81_y5K_O@pie>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <afRqUJZF81_y5K_O@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:803:1::26) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a03d879-bc3a-44df-f082-08dea9bb9515
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: VqCfZKqPOVO1jS6UGMfFmbnxX0DuIb15Ed+P/IFHov8cvRzuAeZ6tiviCuro19Zu27qsH8RSgUhOflCk5xnLE9rrt/j30W6MHlaN5b9XDkEX0fjbNNgl/YffOORB6S9HLt0SxtnokDD+Yx4cY/qnjk3Bn3bfx9LhWx3fK3FEOkOPhPSwQtROqoyz34onjyBxeH26Ju56S35zx8cziTUSSzCk4q4JSTVhZMq4fGptfn+ltBFRAwLQKq9v+A2KpBhneDvpL+VYbDHXsuBgBEkvcTUmo6Qm2nRpv7q8PJG2wwRaX7MaGfepAGBFvWG5s7SOjyX9lGG6HMCiBmagx3T9KEHw1fgGfZfdqNm4x3Xx4XPfkyty1z6kfZFVwqo+ug7QCcJidMjPxnMpbXNCBYbmJSw0Tk8cDSVxB24Ov/8wN6IcG+30SOjboYVY3+vGgwvd/UImyPezkK+v0TzZxmfaBgpRQHJTSA4po8D2IuHRh02toOvBhgltLdzJM275t8ErwfttJzfR+2hfs2tfz+yHotqg3Xd7MVtvP6SV7P1IBLgCjBu7dHdbZzHz0F7F/PXxkbpsooZ+DT5v7dgnmWdgnySS/8md6+LqcHbXbijE78sQSLoLzxK73PokaMItG5Vz+TCsgyA58u73i3yTWtf5kpaXf5sFvgLCBgY59Hk6CPaNkzZGGXX5+qRZHFfeusRt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJRQW5EdmZWQUZzVVIwQVJJVG5ndzFTNmtnR1dqRFE0RDBlSlRJZHVicFNJ?=
 =?utf-8?B?azdKNzdTRzFZUGpzOFU2clRMTit6a1dUSmJuby94K3RZWEM2TG9QaHBkSThV?=
 =?utf-8?B?U0FNL09uNkNKTERyaGVBczArTWxucHh5M1hnN3NWNnFFZjYwalMxUnVENkNw?=
 =?utf-8?B?ZDJUNCtvUjgvRjUzZkhKZGZKeEV6TzVTeGZXZXo1UFhTNEx2WmZlb2lzQzN1?=
 =?utf-8?B?a2c3R2wwZ3FSQkVWOTdxaTFjYUxOM0ppZHhHa214cmZmdENEYnh0UDhHU1Qy?=
 =?utf-8?B?QkZxT1FiMTgyUXN6cE04bFVlbGtiWk82Z3BQd0lxdGtCV2FBbmpjNGRLeUkz?=
 =?utf-8?B?a3pmVW8zTHVPMkN4YWIwNUpWb0lxakxNS0tVZTQxODN4dndBNklOeGVJdUt0?=
 =?utf-8?B?cjF3N24xR1FIK2xPczBsTXoraEx1M24zTmpxaE9rSjZSOVV5ZHhNZFpONkJO?=
 =?utf-8?B?LzFjYmlpNFh0OGd1cGxPUDlGSnoxSmVBK1M4ZzBYNDJjSGlWcVVuZHBtQTh5?=
 =?utf-8?B?RDcrbmMyZFk5bWhHR3Z6RVJDNHJMUWZzZldPUDE3Q3M3bnVlYWhEZ1RUbXo2?=
 =?utf-8?B?SFJtOVZTNWNhNjlPcVQ1cUlKMnZKT0VjYjNGQVpuS0JJcUUvRXJvVUZYZXpv?=
 =?utf-8?B?VmpmT3NWMVJjUnFXNnRrWC8vZ0VKS0t2VzNiSkNBa2V4TUR1VXhsUDBJVGFl?=
 =?utf-8?B?bWN3cmZjU1JVQ0Nuais4aUhVclRWYUNMekhUVjZzcTc2YTEveUpYSkF6YkNz?=
 =?utf-8?B?R1ljWkN5TTdOUjQ2QXdBanRnUnNWNVpLdjdBaER0QWRham0rMXhtOTNXUU9I?=
 =?utf-8?B?VUJONko0WGdSV0N4UDNRNXV4TlRJSkRzV3Vna2dmY2pLMnZncDV4aUNvZjRt?=
 =?utf-8?B?YVc0amNMRkRmUjFkNXdMVzM3V3l1TGw5ZmlmY2pPNTI0VytObjFKVmpwY3Qz?=
 =?utf-8?B?S3h2b2VIVWFoMldKazY2TW91T0hleWpCVm03aFJrSFd1NTR3S2FkbHlnOEZk?=
 =?utf-8?B?alEyWDN2M3VWaDMwZkxNai9aSkwzalRDTGZkVjI0Snc4QjM4K1p3clVibjdl?=
 =?utf-8?B?bVlBK0NBTHNSVC9FQTN5UGJsck9UTlVQN2IyekI4U1lHMnRxYyt6N2lxMVRJ?=
 =?utf-8?B?NDVwY3dDUDFnN3h2dHp5TkQ1QmdxSmRqcnpzUmNaWS9ERHFaQkNJaFNYY1Zs?=
 =?utf-8?B?WDRrSEZpMDY5bEx3eEFMWk1LTGRIWWU5bzRwUkpjT0pZZ1pSOVhWTGNVTXBL?=
 =?utf-8?B?N2pPM3orbGtPWDBSM3MzOS81WVZhR1o2SVA5ZFg1NnAwQi80dWtlblh0WjVO?=
 =?utf-8?B?UnlZZ0tuSkJvU2hVUkpFdnZ6VEo2U3ZWNnVtVXdtbVpZSHNpblZkNVR0U3ZI?=
 =?utf-8?B?WWR5eGYxbGVKeGlCbzBKMCtOMXJKbzV0dEFJWnc5YkpvOTIrN216U3hybFNq?=
 =?utf-8?B?dEJXaitBSVc4OUJKNGdoMkdaRXdLZm1nM0R0aXFvV2hRSmFuUWNxUzRuNW9t?=
 =?utf-8?B?MVJsZGs5Q0JOajNTOERVWVluTkhBOEJ2cTlLcFlSVm44WlFXckR4ekJlUTM2?=
 =?utf-8?B?T0RST1BOWVRURVJBY29PZFIxVHcrdXBiTkpFL01Eci9uSUdvYWc4dUtQZDFL?=
 =?utf-8?B?OHpKRk96eUtoK1oveW9HWG9tOEhsM3QrZ0R1TDh2SkhkUm1XRXozZ0RrbnhQ?=
 =?utf-8?B?U1JqVVc5OHZVNUh5NnRNTFhFMDl4aDNScVY5dFBaZk5lSEptdGtKR0x1NUpZ?=
 =?utf-8?B?K3VPQklxZmJLY1hFdXVCZW1YQ291NzExdmcyZ3ZEWGUyKzBkcUdnMXZTVjBJ?=
 =?utf-8?B?NUQrdEdCbDd2ZzF0cUQwTU41aDhWUWFrMU1EbjdBREFaY25iWElhNU85d1BX?=
 =?utf-8?B?Y3U4UnR0ZFNpQTdhblpsUnpBdTc5SWRWV0RtdUcwbzVURk5YejNBMmNnWFho?=
 =?utf-8?B?Y1RWWTIwa3c4bkR0NlZQRnNGOFZ3bkdRRkhLbUVtbUdnbUxoMjNQZC82RXZI?=
 =?utf-8?B?ZCtNSU8wUkhIUkRRRHJTdzArZndKSUkrWHM1Y01LRHNKWWtyM1NTZEtJNGxW?=
 =?utf-8?B?VGlFVHUvdXZxWDBTeERwWVZQWVBpcjNYVHN0NmxsNEx2Ri9paXZUTk5Zb1VU?=
 =?utf-8?B?d3JaU1RUdDhReFFaYzZSY3h6c0FLSHNTUGxGZkJFODlaMmk4WStubFRiZlZ1?=
 =?utf-8?B?ZHhra09wbVNqWTZOa1JHR0dRenFwNXpic1Y3RXdQU1ovV1RzWWlyV1daMzdT?=
 =?utf-8?B?eXcvTlJWM1NFZ0JUc0FnRGtPMEk1Vm5MeFJvVjhBUFIvbHhNNUl3SThoRUNh?=
 =?utf-8?B?azZMQVVCRldSUDB6bm9iSzkrSDllUzdDMU5nMmw5NGVWOW9EUXo3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a03d879-bc3a-44df-f082-08dea9bb9515
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 09:00:26.2023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jM/sAtKWd0WnFMAuVgPAFlXx3huLiqco0fJCdyHpJqwh6KCM+6IQLUbwRQxxNmBf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
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



On 5/1/26 10:54, Yao Zi wrote:
> On Thu, Apr 30, 2026 at 01:57:51PM +0200, Michal Simek wrote:
>> Building on commit c64fc632a86a ("riscv: cpu: Use CONFIG_IS_ENABLED(CPU)
>> instead of plain ifdef"), add an early return in riscv_cpu_setup() when
>> CONFIG_CPU is not enabled. This allows platforms to save code space in
>> SPL by disabling CONFIG_SPL_CPU.
>>
>> The compiler's dead-code elimination combined with --gc-sections
>> removes the unreachable code and all associated static data,
>> achieving significant size reduction without preprocessor guards:
>>
>>    spl/u-boot-spl:all -4332 spl/u-boot-spl:rodata -2872
>>    spl/u-boot-spl:text -1460
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/riscv/cpu/cpu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
>> index bbadd0c9a469..3bec7c7cb6d0 100644
>> --- a/arch/riscv/cpu/cpu.c
>> +++ b/arch/riscv/cpu/cpu.c
>> @@ -638,6 +638,9 @@ int riscv_cpu_setup(void)
>>   	const char *isa, **exts;
>>   	struct udevice *dev;
>>   
>> +	if (!CONFIG_IS_ENABLED(CPU))
>> +		return 0;
> 
> Should we return zero here, or -ENOENT like the original behavior when
> no UCLASS_CPU device is found?

if you put there error value then when CONFIG_CPU is disable you get boot hang 
which is likely what you don't want to see right?

initcall_run_f(): initcall initf_dm() failed
### ERROR ### Please RESET the board ###

Thanks,
Michal
