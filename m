Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09432C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 700D980214;
	Mon,  3 Feb 2025 10:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ir0WJ7pT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815D2807A8; Mon,  3 Feb 2025 10:29:10 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F2A801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q24U1Ohdt6cuz/qmgmPmvrIs3YgWYwgSe4O4MhTmhjKXZI9ENFIBdMH5vuKrXvKlO55m3zUx4H36I0cZ8PDUkXIkkuvLPWCW1+CB1fpQjBrC8DCOteniyHB1AtoJzNHqnv9cQUxJMfBRJ75IveibpfV1rQiFMIckC88g/TfggNxNs/jr6bGZfRt7Je2DfOSzNSazqsP7yFUymdKd0CnmlAmZvFVTgAB98EY+gUdfgVBdaT+zeUJVHh7IKUxGgIn/DoDe9VXjbDe8Bayyv/TJ0ZQIyS1wzcEy+O4fDMsTjq6n/h10XpRj0hD58VdIDQ4taXen9Ndz9ZOIos7vt+lnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvTkynHmmf25LTiEhkRgTUxHgFzUMS70aWRcnzIZqVs=;
 b=FdZcko6xF7KpirEF+BhXRTQZeIDh9QDUC4h8ddzRnL4rMzoVVpxm2XYTXX9amV8EIrYjLoZOk2XtznenJ3SHqVTcJkxgDsMdEcrFXtmZ5XctuOElw1ZtjewkJ7O3ZOeBFvZsbdtSNeu06J+nyy95+8HGy01mGMq4q4rFFyKol6VYaaARWZclc0X3MxnhbXiiXTCc5DwwCeaw6ihnkuu2lSXGBnhF0egswxqOt7RqUEKnr8nkZYymKGEbnqFnb/CX1Xgxgj5KwWy5LH0pTyULp4qBxzD+nGNu8BfIWePrMNDPwB9e88rzkMiAZdCdE4LM3cPQj+wV3VGKRfqaMcW5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvTkynHmmf25LTiEhkRgTUxHgFzUMS70aWRcnzIZqVs=;
 b=Ir0WJ7pT4jXazx+XRoKbRXFfExfLJInn+GmFeK8ptJ+NJROKo9t9sZD3uMq+Q6fwTLfQz7kF5kdHA53Ywpne8H7lT8+hQbAvG0MCbEAXc8pzgcbcjPo9Ul7PHUpAtCUHtHrbKnVe6HuFgQS0YJkuUCgtW580jX7PLAVHUY6j5Ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 09:29:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 09:29:02 +0000
Message-ID: <c0d6fa82-b448-4a47-86a8-e44914d4fdd7@amd.com>
Date: Mon, 3 Feb 2025 10:28:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot][PATCH v5 0/5] Improve fpga cmd usage information
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, u-boot@lists.denx.de
Cc: ada@thorsis.com
References: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1b1732-b167-4880-7a3d-08dd44353263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWZrYnhlMU1uODQvUWhNMFFBci9YT3NSaDlRT0MwMGZTUTk0UXJXVENCWHJx?=
 =?utf-8?B?dTVrZHNZTGdsNUo0K01GMERCOFY0dU5OYkNKS2I4amtUVTF1NjFZMUFJdWdF?=
 =?utf-8?B?ZWVvbUdSa3J6WkdEVEdxUmJTUmZYa0NhbWdQL25PQmVYQTJMSXh4TVRJV1V0?=
 =?utf-8?B?R2dpbS91a0R0L3RyQitDQnZleU1uTUkrOHhIR2l0bitOd2lKVm5GTEg0YmRx?=
 =?utf-8?B?SmtoTHFqMVpWaDdRamNBbFpuWXVPMlFIKzhaYTlkdk1YUWVZMzlDbSsxQW90?=
 =?utf-8?B?SkcwU3NPM1habW04VDAvWDVpV0RTamJzZjdhSHN6bzJZS0lZZnhEd09XWTVi?=
 =?utf-8?B?cEsyVXoxUk4zVGw4eUtwZUlxYVcxVHZ4bmRrVU5pRUtDNU9pTWFxUEdtZU1V?=
 =?utf-8?B?N0puZktmeTRzWXZGdUZtUEtWODh4cVdhM1duMGlTdVFpc1QzQTdIR25hZHN0?=
 =?utf-8?B?SFZoT01lN3JMSTc4SVplT01tV2xMQjBjMDJoc0tNcTViT0Fua0FyUnduWWcx?=
 =?utf-8?B?MzN3SlVZOUNKb05sWHVaZnhBUGpnT0l6R1kyb3p0TlBVZXdxSnpBeDhmTTBo?=
 =?utf-8?B?bXJVcU85RXA5UG0rSktOazBOWER4MkJiTnlIRzkvbUwwVEtRTUwybEM2SkJC?=
 =?utf-8?B?ZXBmRmc1ME1uOW1xTUJiaXZ2Q010SkN5S3hDZHpWaUR0ZVhQZ1FmNVlUYkUw?=
 =?utf-8?B?R0l0L3FEUmh3ZzE2OTdJaWg2RXQxOTdPWjJsVmNHd1ludTkrdGpJZXZrSjN2?=
 =?utf-8?B?dTRlWW1rSWp3Rk05WlBPakoydnd2amZ4S3hMeklELzIrZzJ1VFRlUzdMU3Nk?=
 =?utf-8?B?NEVaQTBvS2VMc3o3dlJTUnN1MERIWnBvNmdoVkRNM1VsR3hDUkUzcS9XZ01X?=
 =?utf-8?B?RUkyaUZTV1Z6bklaTkxFZm1qQVU2VndUYkQwdnBDaWlXZUJQbkZLZzN2TUxj?=
 =?utf-8?B?SCtEcWhJYlI3M2gvT0d3NVM4YkxmS0l5bjdFeXBIMWUvNmFsZmhYUkFLUFU3?=
 =?utf-8?B?cVFuTDhXWkhqa254TzZWZFVDdmYvZCt5TWYwRndlNVh5c2V0Z3VNUllUQ2hS?=
 =?utf-8?B?Q25rTkc0Ulo1RkNQcnhEZEpYM3BBWVV3eW1lOGVYc1FPSmEraEhhcE5tK01T?=
 =?utf-8?B?VUNMZC9aREtOVklab0R5bEEvaytDMGRkMXhyN2diclYrUjJKemk5VTRGdTR2?=
 =?utf-8?B?TjN2U3pyK01RRW9UdDN5eC9iY1p4Y2Y2bElYNkc4K2Z6djdWSFhwMVVCdDlZ?=
 =?utf-8?B?L0UrMFpZZDhTYXpBeWlCdFFJZnpVMFpSSUFKN2sySGNQM3JNMCtiME5uZEZS?=
 =?utf-8?B?MEEvbzlCVWRRa09tRFBxUFFuSWFXWnRVQkxzaXVQSERpUkVXOVRCb0F0bVBQ?=
 =?utf-8?B?dVV2Rm5QRFZUUHRDbk11Z0cxbUxzSjV0N2EwT2pSSjZVQXllUnRzZlhYVmUr?=
 =?utf-8?B?bk5WdDV6Smg2WFN0U2s3UmN0TXRGVGdSa0FuVmgvYmoyOCtmaVBxOC9QTS9K?=
 =?utf-8?B?ZVJUcm45dUdaeGhNTFkxdDNlNm1vd3VDNy9OTHpTODZEekRFNDFuR1E4bWtB?=
 =?utf-8?B?bmZtT2MrTFFIQUlzZjJTVExvWnNjeGFBREVYUmpUaFMyT25IbUp1djFOT0w4?=
 =?utf-8?B?WHNMTWIxTE8rVVN5NE1rRU82ajlCWDhHbzlDR2poNlZDaC9NaW41WksvbHp2?=
 =?utf-8?B?SElTTXdjTnplaW1lQjNvTFc3NDlCOGg3SkZSZy9qclFYdE9NT0pFNDlna0tD?=
 =?utf-8?B?eFZRTnkvKzBsQmtsNzgvTHl4Y0hKdXJOR25WQXlqR1hPazNRWW1oMkluYVlU?=
 =?utf-8?B?Q2Zpb1QwM0xHUFlzU1hIUDEvUkZxWStEYXFjTVp6V1BUekx3SW5JZGVNd3JU?=
 =?utf-8?Q?Ipn3OtS5LNISr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lNQU1ic2NBT1NTT0FvWFVHalFHcTJ0ZS9HcWNMZE5KaVpNd3U1L2RkNThr?=
 =?utf-8?B?MDV0aTlOTUk2RTIrb0ozK01zT01Ia2VESXZTR2dURU9lNGRRdE1qWC9lNkIz?=
 =?utf-8?B?djVpMTlOblcyekRkV1dIV1hYNVl1OGFGekNBbUVuNWNDd09RVXBoQ1RYZlFt?=
 =?utf-8?B?NTNMR3NyU2RBVGJuaWphV1pibGFZbFBHWWZtNjZGZW1Rekh3SG8ycmZsWXJx?=
 =?utf-8?B?M1lSa29WNlpGQ3BYaWF5Q2ExeGhoQU92MFNDajBPZGI4eU9DcGR3MTNCM1VR?=
 =?utf-8?B?aVNEYU8yWmpFVU93aG5xTHgzd3luRTVFLzJwaC91NVhzUjI1elJxMDdheDJ0?=
 =?utf-8?B?OW0zcDN5SlhGYmdZZDNVTG9LMnZwcVRRbGhkVUlUemNYVHVYaHEzc1R4WnFw?=
 =?utf-8?B?VUVBeHpzSk5VbDVEUUJNVHh0UDRiRjl3UEJscWxXZWRCRjRhenRobDh1Zlds?=
 =?utf-8?B?YW5yTnpScnd3bGVuL1R0NGRTNmthZHhvckFHTzBBQWNBMjkya3VrRGU1M1Vu?=
 =?utf-8?B?TkMyUWNxVmNEcloyYkx2M3RnSnk3TkQyRGtyN0FCMEMzcUtydWw3YjNSa21S?=
 =?utf-8?B?aXNkd1BSRnVGeElQbDg5MFladWpWUzkxM2hpS3FFNmVOMnBqL0J6KzdCTWlt?=
 =?utf-8?B?ajFSMVBwU3VWeThvYTh3eU83ZjJMdy9iKzgwWkc5Mm1PMXNwRnBsN3M4RFdx?=
 =?utf-8?B?UUZHTUVvRC9FdmJQY2JBRXYyWDhIc2M4VXVqckxRbVBINnVoQU9qbVBIVmF6?=
 =?utf-8?B?TVkrTmp4V29OV0RIbTZpVHRKbnpmS0NsYzMwL1FQMXNPYzgvcGN3TU5Od0sw?=
 =?utf-8?B?TG1QODFhSmpXMnpJV2tzaENKM0hlaUtvdVNpaklsOU5BaG9kNUNoTS9QKzlG?=
 =?utf-8?B?T3VEMVNHd2gzc28xUnMxSjE2ME9RTkJDM0d4YWllQUtRUm9GRW92MDJUNnJB?=
 =?utf-8?B?cDRWeDRDd3Z5VmpGRjUyZUJIRndQSWdRNzQyMzR3bHBxa053VUVjN0lVaXNX?=
 =?utf-8?B?UTlaUTVUM1NETWpKYU1QaGZTSTBrYlZ1aWV5WkpaSGROQVo3Rk9HUlpmUERy?=
 =?utf-8?B?d2JwcklIR082Z3ZCWUcrR2ZoTWg3eWNhRU1rUlhPcEdNOUoxTnIzajREOU1C?=
 =?utf-8?B?ZVQ1V2hhNGZLeEhraXAxTVowSnEzaVFPVWNqOUpEN3Q1MjNpRGpXQVZzWEdr?=
 =?utf-8?B?S1VjcmJtdFZnZ21XWVhTT1d2UE9yTVFEa1V6WDNOd3RsRldqbW8zYmMvREhO?=
 =?utf-8?B?T2VqcHVNKzZsbDZTc0pBcmpjQkJWVTZIMlpoalZndVFPcW91dFVQRmJjVlJp?=
 =?utf-8?B?WG5CYTN3ODNMM0c4a2hpWUxnT29oNklLdGNEL1NzUjhXR0JZWGkwMTVtL3Ri?=
 =?utf-8?B?UVh1U2hGT1duQmdiOTNLeWh4dGRRVUh3SEpaYjZWMjlsTjNNT3lZLzBUYUJt?=
 =?utf-8?B?N2RqT1hUeVMweXVUQjlNY3RCMWkwM1V5RDFPSFJGdTBhcy9YVk1mU0VuTkVW?=
 =?utf-8?B?S3FqRGxUTlo0RWFwbHdPbDJlbDlLTWZtSm1CejZXcnRwOEdzVUdqMGdoOUZF?=
 =?utf-8?B?S0loNWNzQUQycWo4MDNNcDREK2pCVTFvMU5RY0ZBdTJWbVcvU3U2OUMzUmN2?=
 =?utf-8?B?U2l5cC8zK1BvdFU4SEFSNWZBSlNIOUFIMThwdjBiZ2FIQ05xRllhRnNnVDZP?=
 =?utf-8?B?WTNOS3hEOFUzYmFGc21kQm9ucTM1ZTlZZ1FOMmo0Wmt6MUFXOWd5TWVUM0pi?=
 =?utf-8?B?SVZxVDNTdDNzbkFjdlhPWERJbm93NGRQVFlGcERodjhwd05lMUY1SjljMHF3?=
 =?utf-8?B?MHBFYnI5OEpESk1YSUNRQ0xYckZWYi9UQUR1c2hnUEFmK0x3NU9OY2VRcEtl?=
 =?utf-8?B?ZnBwbjJ2Z1p0dzd4UGtqNXpQNkpWVGtzZnZjcFBnb0pJa0ZHTXExc1VKK0hr?=
 =?utf-8?B?YlpiQndlbUVPK0NpTUJBUWsvTTYxU2dQTXJ4MGxNMU5QZmZzeGFBZUhtYzZk?=
 =?utf-8?B?S3AxODhkRTVjSkZKcWxsK2xxSyt0UGdXa29Fc2VUdHlLQ1ZWQ0xZc0JmeWZC?=
 =?utf-8?B?cWJ4eEFqV1dtczh5dlpYT0VGWkJtR1luRnlrNVFCRjRxTUcvSjVBNXIvcGhU?=
 =?utf-8?Q?ta/axEcHOfwCvmBGD81THbUst?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1b1732-b167-4880-7a3d-08dd44353263
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:29:02.8446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9VBZ2RmrEWPFBF93GKF1pD9T5Nx3GjlXS5q9ZiU7dMOLQncNVQ61GOuFsuClHuq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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



On 1/21/25 14:01, Ibai Erkiaga wrote:
> 
>    Current usage information is not read friendly specially when all the
>    options are selected. This series fix some of the issues in the info,
>    aligment and overlapping issues, excess of verbosity on the loads...
> 
>    Additionally Xilinx exclusive command dependencies are included to
>    remove text stating Xilinx Only
> 
>    The output looks like this now:
> 
>    fpga - loadable FPGA image support
> 
>    Usage:
>    fpga info   [dev]                  List known device information
>    fpga dump   <dev> <address> <size> Load device to memory buffer
>    fpga load   <dev> <address> <size> Load device from memory buffer
>    fpga loadb  <dev> <address> <size> Load device from bitstream buffer
>    fpga loadp  <dev> <address> <size> Load device from memory buffer
>                with partial bitstream
>    fpga loadbp <dev> <address> <size> Load device from bitstream buffer
>                 with partial bitstream
>    fpga loadfs <dev> <address> <size> <blocksize> <interface> [<dev[:part]>] <filename>
>                Load device from filesystem (FAT by default)
>    fpga loadmk <dev> <address>        Load device generated with mkimage
>                NOTE: loadmk operating on FIT must include subimage unit
>                name in the form of addr:<subimg_uname>
>    fpga loads  <dev> <address> <size> <authflag> <encflag> [Userkey address]
>                Load device from memory buffer with secure bistream
>                (authenticated/encrypted/both)
>                -authflag: 0 for OCM, 1 for DDR, 2 for no authentication
>                (specifies where to perform authentication)
>                -encflag: 0 for device key, 1 for user key, 2 for no encryption
>                -Userkey address: address where user key is stored
>                NOTE: secure bitstream has to be created using Xilinx bootgen tool
> 
> Changes in v5:
> - Reorder KConfig to ensure commands are listed in the same order as the
> code.
> - Clarify the bitstream file type for load/loadb/loadp/loadbp commands
> 
> Changes in v4:
> - Split 4th patch into two, one for existing symbol dependencies and one
> for the new symbol
> 
> Changes in v3:
> - Split 3rd patch into two, resorting commands and Kconfig changes
> 
> Changes in v2:
> - Tabs replaced by spaces
> - fpga command added on each option similar to other commands like sf
> - Dependencies to Xilinx only commands added in Kconfig
> 
> Ibai Erkiaga (5):
>    fpga: fix alignment on fpga cmd usage info
>    fpga: improve loads usage information
>    fpga: resort fpga commands
>    fpga: xilinx exclusive commands
>    fpga: add new symbol for fpga_loadb
> 
>   cmd/Kconfig | 35 ++++++++++++++++++------------
>   cmd/fpga.c  | 62 ++++++++++++++++++++++++-----------------------------
>   2 files changed, 49 insertions(+), 48 deletions(-)
> 

Applied.
M
