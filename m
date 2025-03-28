Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C8FC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 14:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D0898129B;
	Fri, 28 Mar 2025 15:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eFJZRbKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19EF8144A; Fri, 28 Mar 2025 15:53:22 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A069810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 15:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKDY97YIwNzxVVkWaMOCOhK1BF2C+3B7FTCmEPRS3ocahBzaOCvKYaKkIT+gb8ToJkcNS9VeCqVYjUOLefkQRP7fd3nXn1TZw3LF5/CzE8iYGoAYQRioAUDcOlWoP7jUE9ePlsHWCYTLDPAxEU1ou1Ug6tsIN7jIX6PsJQqbE0iSRUvdxwDBD5f8ypttW/mvhUSu8m64HwrnKCKk9wDXRI3ryJiyPhs0C91bqVTkjRPiTKoO3LsQMsjo8kdsDvrH4aC4kh0IhmM3sUOLkIO9TcfZYAdCn1Gchqng8P+IF3k7HnNmQXf0oCg1heyWVRIgpBOQR6bMPnfRkijeMvVVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLfRYmXmEz0HJ7+m0sghpzttYK8W83vbTC9D6WNgOEg=;
 b=Ak8bGRDCAjUm+QC22kIIWCUsOHp9Q8bEmOoa4+JAKqHWMpJMlLBOnO3yyw4pcEWhBc1o3nEjVLotLIqMBm0GPE+VHz/+n0tKj21X3tZdHr5a5qqW01EoQQ8uWsihvZt8U9mfvHdTkk5GbTTxFOcUCGKT510Q417Zsa2rHB2TWar5g3aTkPVWzs6ulgoALdU77YFqfL1GvO1h393KvOKlc2Fozd5RTdChko1WDg4c6q1qJUsNIrpStBKdYOzI8Xise2roIpQjZvdtFA8AWgOeUJry2Pj8EFvCmSwS0AfBh6MdiaiNSM/OkmueumeufIOCWNo9EGPcL+gH1rN6sCsQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLfRYmXmEz0HJ7+m0sghpzttYK8W83vbTC9D6WNgOEg=;
 b=eFJZRbKN19ktSBrISIFMJX/sxKHgG5dG0F44Qa3CDMFrcDqk8dvE783ton6iOosqOaCWUtINqor9hR/w21H0ZDNdLpskOR0COPCJtxN67/qzX4525qTlLN8gBAchSVQCPVtscsdy3WP9YDyUSeeJ3RuLxea7kcsOGnLrXFo4zi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Fri, 28 Mar
 2025 14:53:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:53:16 +0000
Message-ID: <6507811d-da14-462a-96cc-d0ec54f18257@amd.com>
Date: Fri, 28 Mar 2025 15:53:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Disable DEBUG uart for mini configurations
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <ff61ec2fc213bb3a9640015c6588e9b48ae38967.1742460228.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ff61ec2fc213bb3a9640015c6588e9b48ae38967.1742460228.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: fe64f208-a187-42af-2be6-08dd6e084583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHd0Z3VXS0oyeGFlOG8yaUZrYm5CUjUrcUJnWnlkRkE3VmFWSXU1ZDVXYm9N?=
 =?utf-8?B?Uzh4V09SQzRjM0JZR0JTSklVak5HSHdxcW45NW9Nek9uTDhwUnB4QjJFOUov?=
 =?utf-8?B?dUUySmYvS2ZrSWk4OFJRZ2xzbW9sMXdSZFNQQjVLZXF0dE1ZZFlkT1NoY2dB?=
 =?utf-8?B?WGt3OU01UlVTUXVWTHRxWUIzTmh1dFhzOHVtN21WWXZCSDZuWDB6SkJOZ1lB?=
 =?utf-8?B?eStVR0JiZ3N2V1M0blZrOVBBckRFSCtHMFpGMktVY3U4WUxrRmZCVTJqNk9P?=
 =?utf-8?B?NnJhbE9lT2RWWlU4T2NaUGtXNmVYYXk1ajY0Q3oxOHdacUhoa04zdjZqSys4?=
 =?utf-8?B?UkdKclBFd0c0NmJOVGZVc3NTSngybysxTW5FcXlYQmJuWXRvNFZpSkpMQWRh?=
 =?utf-8?B?Y3lZWmV4Tlo5K0ZQNC9QSXJKR1dCdlRSajIrVGhhSWZrTkVVNW0vdXhXQ0Nl?=
 =?utf-8?B?RExWR2hUNFpmSVUrZHhzdS83Mi84UzlwT2dSOW5XWXVlR1BDUTk4dVlVSmZk?=
 =?utf-8?B?RGpVbXdhWllXZlVjbVNOblN6TEMxZnpJeGVpMGc2OThHY2Z6R1dnY3d5ZGJU?=
 =?utf-8?B?YkZ4eFNHekFWZEsyV2JHeE9YU3RhYXc1eXFTWTk1OUpyS0liRXROU29MMUpV?=
 =?utf-8?B?R1p2cUlzcVlnTThlWHZSbUdyVy9xc3NIOHM0cnJkZlQ0enp5WVJMWjlYUkRB?=
 =?utf-8?B?Z3RJb0ViNWY3WHN5ZTRJaHpWZCs1Tk42ZjdBUlhIaEhXSDdUUHV2N1NJZ21G?=
 =?utf-8?B?cHQ0OWdieldZcXdNK2RoWkRJdVd3a2xzOUZ6eGZ6bUJTb2lrNGNWcmJQNHht?=
 =?utf-8?B?WkV6REROUXBWSU9WZGxLR2w1bDViOS83a0pMM09SMGNOSzFOL2k2TjlHcFRW?=
 =?utf-8?B?azNaQmlVYW5qVmhPQWxBR0tSOWV6YVFRdktrd0UxNGM0ZnVVL3d0SHpRdGJ6?=
 =?utf-8?B?QVJscVpaTWJpZXJ2aHk4K0pIa29UaGExWVAwZWR6THRSbUpvdnFMUEVhbjJn?=
 =?utf-8?B?dVAxSUdId0EvV0NjY0F2QlF2S0tHbFR2RFg3WXBScU9saEQ1TXhQZzV1NHNS?=
 =?utf-8?B?TTR1alZsTitVeVRxMmJUSFRySWZUeGZaYkY4RkdNQ1YyNVZ3SDdyUWVML1hJ?=
 =?utf-8?B?azVvRDhhQzU0cU1KRmxYUXB1V1RhYVlPV1J3WWFXK0J0Nmo3TUx2bzdpUk1m?=
 =?utf-8?B?Nis2UmpEaC9iTVdLeSs3MTBvTmJjMkZTam5xYkZJVVBVYVVGZXlxWlRpRk0x?=
 =?utf-8?B?aXNzRlpSanZEWTEzakNJeTc4Wk9ZYVFYN09yVUlRMDRYamxRZW1SajkrY1BY?=
 =?utf-8?B?allOQWNZVFc0LzdtUHpFZmw0NW5TeW8rTmpqeVdEeUc2ZThscWRRaVRUQ0Zk?=
 =?utf-8?B?SXUvNEhnVVV6aW83TFhxVFF1eXY2UFdzY2kwdnVpZ08zV3E1WGt0UHBtc1RX?=
 =?utf-8?B?cDNPbW5EcEE1S2hpenE1SFhGT0tWRlZkenl5OVpsUmJNWEdsdXdXaW5ha0pp?=
 =?utf-8?B?cEo0ZDNqdTVtVlJHQzNTZGFONktOK3dlMS8wWmlNdkxIQmNnN09ja0YxeXFM?=
 =?utf-8?B?TXdISHNqanhlL0E4blp1MjVXcStjdmgzZ0szT05MZ000cGZNZU1USTFVU1dN?=
 =?utf-8?B?eUFMZ3pRam5tMnp2aG1lSUtmOXpEekhaU2RMWTBKaVJ3V1FJU2tTcUlCWkhx?=
 =?utf-8?B?U24zcGM2cHBhNURPWmdjS21oYUN5ejhKQ3luVUNxM3J5NE9xWjl0ZVE5OFRX?=
 =?utf-8?B?RWZhdGhiT2xNUkhMUC9QRE1NQmFlRHVIeUxEV2o2ZVp3TUxZSzltRzc5NHo5?=
 =?utf-8?B?dnN5eVJTelVPSnJ6U3JnNTZpNlVWN0Q2eGFDbC9abE5RUlg3WWpHRFRDTHAr?=
 =?utf-8?Q?Qh13gGzBHgJsc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFE2ZHlMbjREQ2N1VVI4N29OZi96emhiVEYzUTd1cnJpZEVQVTQzMlNCK3NV?=
 =?utf-8?B?STF2OUJXUkQ5VTE3c2dmM1NIakVnYUFJNjV3MDZOd1JPdWVrVXFZUlp5MEhw?=
 =?utf-8?B?OU1ZUzRDSUZRZEJVMjJFNHFScTRUTjdzckF5SWFWbGhzTHhsT3dKb0p0TWxL?=
 =?utf-8?B?YmJ1Q1FhMi9uZmQxcVRSOFMwV0x3UFVzcWFKdVEwVitWWDgvUXJjU0k4Nmpa?=
 =?utf-8?B?QmZMNXNCOStmR21oOEZjdUNjWGJJVTEwTEd1ZStFVit1Z3Z6RzJ1MW1LdEc1?=
 =?utf-8?B?TFVGNXZwZklVY1BWeG9DOHlORjl5c3dtVHRGUktNanczZ2hCQzE3QW9jQWVp?=
 =?utf-8?B?dEF5eDBpN2ZwR2oxSnBGSnRWY2ovWDB2bEJjK3FEeWtvQ3pqWm9ab1ZjblJv?=
 =?utf-8?B?cW9UVEp0L2NnYndwLzBXTHVjd0twWUZpdUFpYWFKQjFtTVViZEdLVm9DSUlG?=
 =?utf-8?B?ZU1veExpYXY5WEMyS0hjdFBIbnRkdjZRTXA5czRaajVyVTJKdkhWZW9GSUhv?=
 =?utf-8?B?KzFMSCthR0c3clBmSk9pMmEyNC9KTjRod3QrY0dxd25OYi9hdlZIOWhvYno4?=
 =?utf-8?B?cXh6b2h2QkpTVzVaZDJmWFdDYUQrRzlkUmtHRDJGK0Q3cVdxblR3ODh1eURL?=
 =?utf-8?B?bE8zZnFVaUVYaS9yOXRwdmppSWs5WnRsZ1JXaEtqY2pzNG1rN3JNMHBPRUhn?=
 =?utf-8?B?bTFZWXowcVVtbFRYOU1USnpRYTdyeHo2MWFTWVRlQjJUT05BVWFJWDRna0pT?=
 =?utf-8?B?TjM3ZkNLOUZ0WFFOb1Y2QTBXN3dDQzc1Si8wQVNXTlJGL3prbkFRUlFpc0xJ?=
 =?utf-8?B?bkd1OEdDWXpnUFVvczR4R2doUkxNRUpZZ29LQ1ZJeVFrWDNiS0hxdU5xZzg0?=
 =?utf-8?B?aGJGeEVJTGlPd3JzenMyeVVGNmtjbFVaeGd4WnpyN3plWmt1WDBMcFc0dGdE?=
 =?utf-8?B?TzVPSE5GRVk4ZFQ0bFFPT1g2RGNGa3BscVJJSnNkeFBhUzVjNHg2U0JBQTRq?=
 =?utf-8?B?YzRBeTIxdEEzY2xvL3FwN1VlK2R4aTBGUGVjSVpMZFN3bDlSamdkWHpQa0Jw?=
 =?utf-8?B?NXNpMG05bm8zejRQUS9YU09UN1VrYUVzT3p0Vk16TVY4c2dBc1l6dXYrZ1lJ?=
 =?utf-8?B?TXpFUjZQR0FyV0xoWGJUZ2JXdjZ3UkV0clpOWmxibWpOa2pUNFF5eHJMRE55?=
 =?utf-8?B?bzFhZW00dlJlUnV3T2g1eVVidWJlcmYvVnFORTdGZ2NwUmhUcXlidmZKMkVQ?=
 =?utf-8?B?aElGMG1pblpJSDVYaUFiSXg4bjExd1JOdzlIbTlSRzFpNzZMZFRrWExNVEQy?=
 =?utf-8?B?K0VUOUlzcjV4T2pZYzRlWG1QSldaZTZTbkdhNllQazRIYjh5N3Ruc3REbDV4?=
 =?utf-8?B?ZHRlWHFyR0JwR3prejdZbWk0ejFWejFzQTZyeHlsT3BlSjZzRkpWTk1hajc1?=
 =?utf-8?B?VVhKTlJYRXZjMklkRmxJdktoNjRPaW9NQzFTRlVuWlRKM2JDaWE3aFBuL09x?=
 =?utf-8?B?Tjg0NGNuNm5Ta1p4RXVzQjV5R0oxcEJuY3lhVmNKcklEZGxzSHd0TTdxYmF3?=
 =?utf-8?B?OXNCaHFOaHhNbFJRRklHeHZQSkhDQTVNZkxWK2M0bk1aN2NwbmdZWU01K1Ni?=
 =?utf-8?B?djBKeStGY0FRTTBWU3NmNXd2MFNLamhYZm00SGZ3SmI0NmxNNTFiRi9jR21H?=
 =?utf-8?B?dXpmTkpJN2FUL1k4RlFFbGdyR2FIZjlSMEFUUm4vSy9sZ0tVMmM5SGlDNFZE?=
 =?utf-8?B?eVpyK09MOUJWaDdYOG5YdUlIc1BvdjFybnBkS3hndFhjTExYakt3V2VKOWdT?=
 =?utf-8?B?SkFMRmVOQmZOS0U2WmZhemo2aGExRU5kUXJ4Z0p6VjBjS05kc1BLZkthSWNB?=
 =?utf-8?B?a2luSmtEaDhIaURWVUN2d1JnbmRjSVBpaWRKbHFBZlRIeUQwVWZjNGZZdUNK?=
 =?utf-8?B?TkM0TVpTbThScW0xdTh2S3dIMkVUQmhkaG1hcHpBa2NUT29oR1M5YXpiZ244?=
 =?utf-8?B?dGZiL29WaVgvYUFwMFZPMjhjeGVkeG9OR1cyQjdjSWcwakVBdVArSXNNUUJy?=
 =?utf-8?B?cjErZTV0c040VnZBTWlXNjdEZkdVTFVtYzh6SDdNUHBhYXhCUkRNSFNpUWVo?=
 =?utf-8?Q?fBW1NEiBuIPNQvsf+yzA71yRn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe64f208-a187-42af-2be6-08dd6e084583
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:53:16.4333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWPZZmvPna9EGeWLVreMwV9V0K4HOrobrV59IhFAyArZwmDLu8vgy0OhvctHXkRe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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



On 3/20/25 09:43, Michal Simek wrote:
> There is no reason to enable DEBUG uart used for early debugging by default
> that's why disable it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_mini_defconfig      | 6 ------
>   configs/amd_versal2_mini_emmc_defconfig | 6 ------
>   configs/amd_versal2_mini_ospi_defconfig | 6 ------
>   configs/amd_versal2_mini_qspi_defconfig | 6 ------
>   4 files changed, 24 deletions(-)
> 
> diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
> index b6571186030d..d224583f56ae 100644
> --- a/configs/amd_versal2_mini_defconfig
> +++ b/configs/amd_versal2_mini_defconfig
> @@ -13,12 +13,9 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
>   CONFIG_ENV_SIZE=0x80
>   CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
>   CONFIG_SYS_LOAD_ADDR=0xBBF80000
> -CONFIG_DEBUG_UART_BASE=0xf1920000
> -CONFIG_DEBUG_UART_CLOCK=100000000
>   CONFIG_XILINX_MINI=y
>   CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   # CONFIG_PSCI_RESET is not set
> -CONFIG_DEBUG_UART=y
>   CONFIG_SYS_MEMTEST_START=0x00000000
>   CONFIG_SYS_MEMTEST_END=0x00001000
>   # CONFIG_EXPERT is not set
> @@ -71,9 +68,6 @@ CONFIG_NO_NET=y
>   # CONFIG_INPUT is not set
>   # CONFIG_MMC is not set
>   # CONFIG_POWER is not set
> -CONFIG_DEBUG_UART_PL011=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_ARM_DCC=y
>   CONFIG_PL01X_SERIAL=y
>   # CONFIG_GZIP is not set
> diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
> index da3eebe3fdfc..3afc6cb2736b 100644
> --- a/configs/amd_versal2_mini_emmc_defconfig
> +++ b/configs/amd_versal2_mini_emmc_defconfig
> @@ -10,11 +10,8 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
>   CONFIG_ENV_SIZE=0x80
>   CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
>   CONFIG_SYS_LOAD_ADDR=0x8000000
> -CONFIG_DEBUG_UART_BASE=0xf1920000
> -CONFIG_DEBUG_UART_CLOCK=100000000
>   CONFIG_XILINX_MINI=y
>   # CONFIG_PSCI_RESET is not set
> -CONFIG_DEBUG_UART=y
>   # CONFIG_EXPERT is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_EFI_LOADER is not set
> @@ -60,9 +57,6 @@ CONFIG_NO_NET=y
>   CONFIG_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ZYNQ=y
> -CONFIG_DEBUG_UART_PL011=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_ARM_DCC=y
>   CONFIG_PL01X_SERIAL=y
>   CONFIG_FAT_WRITE=y
> diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
> index 8b9c44017eba..54328e85784a 100644
> --- a/configs/amd_versal2_mini_ospi_defconfig
> +++ b/configs/amd_versal2_mini_ospi_defconfig
> @@ -13,12 +13,9 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
>   CONFIG_ENV_SIZE=0x80
>   CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
>   CONFIG_SYS_LOAD_ADDR=0xBBF80000
> -CONFIG_DEBUG_UART_BASE=0xf1920000
> -CONFIG_DEBUG_UART_CLOCK=100000000
>   CONFIG_XILINX_MINI=y
>   CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   # CONFIG_PSCI_RESET is not set
> -CONFIG_DEBUG_UART=y
>   # CONFIG_EXPERT is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_LEGACY_IMAGE_FORMAT is not set
> @@ -72,9 +69,6 @@ CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_SPI_FLASH_MT35XU=y
>   # CONFIG_POWER is not set
> -CONFIG_DEBUG_UART_PL011=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_ARM_DCC=y
>   CONFIG_PL01X_SERIAL=y
>   CONFIG_SPI=y
> diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
> index e17ca8657251..48fb7ae0e7f3 100644
> --- a/configs/amd_versal2_mini_qspi_defconfig
> +++ b/configs/amd_versal2_mini_qspi_defconfig
> @@ -13,12 +13,9 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
>   CONFIG_ENV_SIZE=0x80
>   CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
>   CONFIG_SYS_LOAD_ADDR=0xBBF80000
> -CONFIG_DEBUG_UART_BASE=0xf1920000
> -CONFIG_DEBUG_UART_CLOCK=100000000
>   CONFIG_XILINX_MINI=y
>   CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   # CONFIG_PSCI_RESET is not set
> -CONFIG_DEBUG_UART=y
>   # CONFIG_EXPERT is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_LEGACY_IMAGE_FORMAT is not set
> @@ -65,9 +62,6 @@ CONFIG_NO_NET=y
>   # CONFIG_INPUT is not set
>   # CONFIG_MMC is not set
>   # CONFIG_POWER is not set
> -CONFIG_DEBUG_UART_PL011=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_ARM_DCC=y
>   CONFIG_PL01X_SERIAL=y
>   CONFIG_SPI=y

Applied.
M
