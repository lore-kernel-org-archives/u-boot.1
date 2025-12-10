Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96756D2CE17
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020A283B48;
	Wed, 10 Dec 2025 08:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyLOntGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E167383BFE; Wed, 10 Dec 2025 08:35:51 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9703383655
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lh0+e4FhROlCgzne5foZXiVx9qflvuCXT1c8q1j8+IXZCoy0p5NJ2upL1+fXE/GvvA8IEhtj93fsLbQZKDyXdsHDoNJLTyEopSM6XMEmnSQhyQCn+18beeZRtNbpU7wBMK/CdwzUgTl40R8eUDxrEX+s7RuELgZ36P79lZGXMN981JDgwQL/RmGCfieBfqEdSL8Z/nUbEHMATHeWoivQOv07S3th4Tu8n2HRC6s3YMR3KDRfPHBwAFWCjJjdPMmhU2iFo4GVRLSDSjYYsF0CXf1TOCsvQDCNNQ43URoNba8b5N5YSqz+Q6Ac8QJ5T7emyAgP1m4zycunnuIMZJDBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yiIsSfI1tDB2ZjXRLNU+5bc2qlvnhsE0Dy1h0qzAnE=;
 b=aCLxmG1bXbLxv1YMQsAfo1+ytiXR7pB3Go2HAg3XuyUz52hj9M1rQ6m5unrFDfw3+CT+h88DRVmw9Crv10ZhrSaHukHBW+kQVBIwGEk61iHQ4OzraWLb9xjJpodVSLp2hsQM/YTnZThdJt0kJ118tD5QS3tlM+wh6OcPZUP+60zgzc/MLNJqGyNFjhVPScajY17sNXK3W8qIyajVG9FiUps8xmsOx18SaE+TGT++5XpdtWX8bcpys1jOs0oBzazdLnV3cYRgIPvXGFPX8OcapVNAKbPdnhSv89tfx+ySbE2I8xCg3CINYem4/8/7hIrKunYnBg48pnH6GyXRDCjcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yiIsSfI1tDB2ZjXRLNU+5bc2qlvnhsE0Dy1h0qzAnE=;
 b=zyLOntGYYVaudGgmGmnn6IrHlEMs6j1DmpFjtfJFfrYb6j7SBHjRzCbuaR1rPfkpU8Ha7uiJaPZ/QU1txgtF4R7wuvxqAs54u13UBppXtg3Xvyqu2YfiFy5nUPsrGrRb7gNhbNXDVrY+Cn/nkGgtly3+L5ATjvY8lK8KD5EQ3Rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:35:45 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:35:45 +0000
Message-ID: <11601776-40e8-4a5c-b3fc-8668c7bbb001@amd.com>
Date: Wed, 10 Dec 2025 08:35:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] xilinx: amd: Enable the PCA9541 I2C Bus arbiter
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <edfb7e7a6e800484d3ac3bf45a4f83adfcdd1754.1764170621.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <edfb7e7a6e800484d3ac3bf45a4f83adfcdd1754.1764170621.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::29) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8147c3-b6c8-4252-092d-08de37bebad0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCtORXNZZzVSUUxjOHB0M0h0MHltUDJ2aFg1RGwvSGpTenBHTnd4aytEUWVp?=
 =?utf-8?B?cmY0N2VadUtvN2VvRmkxOU9ZOXFEZmZ3anlzdWxWSHV4cm1vSXNNRUdHdHdR?=
 =?utf-8?B?ckhGUGM1UlQxd3kvY2FRZ1Q0SW42M3JiWllFbVpXby8rRy9zaXozK0k2YzBz?=
 =?utf-8?B?dytoWXl4YjBUdlBZUVBqbkJYVUtOeXloZHNPUnZQbkZOYjkxMTZRTkN5eHNT?=
 =?utf-8?B?VE9adGxPc1NyMUUxa3llSWVHYlVqcmlqYk82azNTVkJtTndyb3VuejZDSjBq?=
 =?utf-8?B?b1Y4U0tBMThmK0N2TkE5OThvRjFLUHZlWEhBTmJ0eDBqQklJRGNNYTBJTURQ?=
 =?utf-8?B?VXJUWi84V0hpUEd5bldoVDF6dUEwczJYSmVPZmZacFJGVXJNQWdjVms4Z2Jp?=
 =?utf-8?B?Q0dMTVZRWlRCLzI0dHhSc1hhNm1xYlBybkx3NEVNSVQ5WkRQRStOWkZoWUhR?=
 =?utf-8?B?WWpDYlhrZ0ZDNExrS3VzUVo4VWdNUTNheE9oRWFoZFVVcXJpZzNZdFNUaHhp?=
 =?utf-8?B?c0dlN1lBQnhTanJuM0h0Uk93UzFpcDNVelU2RHNuaDJnVUcyRk1YMllFTUFJ?=
 =?utf-8?B?bERBS2g1Z0JjTGhiS2tmZkpxSXpNOXRLclppdkMvNnVTTEZjL0pHUjdweVNE?=
 =?utf-8?B?NVNlZTlQWkNaaHZtclExZnZreTVpL3haanlEenNYcmkyNHl1VFV6bEhjMktn?=
 =?utf-8?B?b2hPUHh0clJzVnFvU2RyWHFvWUtrUi9yZXQ4QldnRGFNb0hTNWFpaHpua2pX?=
 =?utf-8?B?YU1SQURnM2puZ2lmaFJwaUtnZHZ6OGNoTzA4aGxBN3JuanE1aW5QdGQ0V0tj?=
 =?utf-8?B?WGEydFFjZHdkVk9zREdhZVg4MElOSlBZeVVVOXowMzlCUC9IVXhxOEdmb3Ew?=
 =?utf-8?B?UEcrU3hqUElHaEUvY0xWOENkYkt3akZEaWlzWDVyMWRjYUtvV3IxUmNLT0Jh?=
 =?utf-8?B?MDJlZzlMd0NSc1kvQTEzK0ZzTndtc2lZRnMzRW9VdXN0UUdYcldyYW5yTHg5?=
 =?utf-8?B?YTcvYW8zZFJTZC9JQXhYc1IyRm5QOVBGMk8vYVpBUzBoR2lkNWk3ajRBbW4w?=
 =?utf-8?B?ZjV4M1lkQlB3MHppYWY2RTRiejdmczgyck5SOXFIcVEyWU1jaFBhVFJQYXJU?=
 =?utf-8?B?eVIvSW5nbERDaVZhN2ozczYvckR6QXdYQlhYNHNtQWwzYm9qcyt5NVlTck9a?=
 =?utf-8?B?ZUxTMFpwQVV6TTBkYk9JSXdoZHBCQllWd3NmSlFsL1ZOaUFFaDNtT0piU0tz?=
 =?utf-8?B?ME5iTFZUNGFpTEFSK2lCbWdpYS9pR25aaDRWTldEaThNM2Y0N1NtdjBiTkd0?=
 =?utf-8?B?NXNMQ1JQZ21kbVNtcVhBNTdaSXBVOTRRVXVSU3A0T3NFamY0ZkcrQy9PWVN4?=
 =?utf-8?B?UGZrNkNrSkNSbWE0dWovaXNRSGZRYUFkMUtPcnkzZWplMFRZVHRrTjJENWt5?=
 =?utf-8?B?T3k1K0hwa3Q1amVwR1BVNTJvUXNuc1NMMmxLazZ2QjdmSUppWWlRdlI4am9K?=
 =?utf-8?B?Qy9pYkZKMC92L0RwaDVUWU5XMXdSMnlUQVFicFdiT2w1amJKSGF3WWNLMDE5?=
 =?utf-8?B?djY3MWI3WCttVUVDcStVaXpoaFRnTjMzSU9HQytMamVlWEExTHZCeUMyQ0Zw?=
 =?utf-8?B?OWNrbzhDWnVZNzJUU1pxSXJjWFh4TU10NEI4VlFZRlRqemYvazBsTGhmdTgz?=
 =?utf-8?B?UTZFZmJqMzdjQ1c1MXBvQU9IQjJpYmw0cThMYVd1WUZvUFFXWTdTZ0xiMmZv?=
 =?utf-8?B?ZUJaMjl3T3RVQnBrV2F3c0FRK1JSaVFhYStzZzhuazB6dU5FUVpXRFl3Tzho?=
 =?utf-8?B?cGo3OWVEd3ppY0dlZTNQZUluVHhpbytGbnVuejJ4YnlPM2hlS3Q4R0FWamtn?=
 =?utf-8?B?M3BGaU9tWXM0a3V2YUZ1bWFuWktHUHV5UTgrczd4RkFHSjYrVDh6ZVVMTG54?=
 =?utf-8?Q?TDkd3yD06tjMrBp4iRU1+jCCg3c3lNTQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVdLOHBHSC9sWlNXaGczZmtWdHNRdURhek1hK1czVmlsRHlDR3ZpcWdsRU4y?=
 =?utf-8?B?ZGFxQkIyZXR4MlN6M05VcGtuN3MwUGUrKzRYbzJKYURXbkVEby9CSGc4VXV3?=
 =?utf-8?B?M0JUMGVOZkJmNHA4OWZDOFczZWI3QzlYNGZJUTB3YUVwdTNTRkkwcFhsZGlY?=
 =?utf-8?B?TDJBRWpOeHFEYTZMVy9qQnlWNU1IT3VkZFBWR2Ntdkc5bTFFaWJFM05aZE5t?=
 =?utf-8?B?V2NIRldDUm4vb0ZGRXdJVTk5YzJhVDZoa01GY0VrM2MzT0VPejhjYThkNGI3?=
 =?utf-8?B?ems5TGxDWVA4TGxsYlNQMzMxUWh6NzdKRGtGWkxZZDJCV0VZajhHcDg5ODJQ?=
 =?utf-8?B?MHdmSXZpZFI3VWhhd3N2dVJEWGNjRm5aQ1RzclV3WVpEOVJMM2x5T3Fack5J?=
 =?utf-8?B?cFNZM1ZIeDZWVVJKMG9wQnVEN1VNdFJvTzRaa2hVWktOVU9XSUJwaCtxckV0?=
 =?utf-8?B?dzd1SVBZcHhheVNnYU05SVh4RzF3UlQ5Q1pqbFhSNnlKcWF3cDNkRWFURzRt?=
 =?utf-8?B?Z2VwQnQ3enlpcFFJSFN2azJzQXlUQzBKeE9Ea1F0akNhNEYrREFabkt2Z3V6?=
 =?utf-8?B?UEpnc3U1Ui9pSlcwdWpsc0Vwb1d1NGRIVDNza2lXM3pxRU96K01yNHQ1RkFU?=
 =?utf-8?B?a3AvM1hLbW1XcXhVMzlBckJCTXJnU0g4ZVVGdzZmZDdwOEltZFQrckRkbURK?=
 =?utf-8?B?dFROUmV4TGxGR3Q4SjR6K3NtQjFkQXRRU1gwWTVZL1RIQW43aFN1a0xlV0R1?=
 =?utf-8?B?VUlWUk5EZTFva2VIbktYRVRVK3VCMXhRcitYYkhPU2g4V1o4QXFzSDhYdmJP?=
 =?utf-8?B?Vy9kVmNoSmtHVUVqZ2RLZEZqUm95aHgxblp4eTI3WTVnTWt0OTRBejFzWm9k?=
 =?utf-8?B?K0d1dllXZkNVQzQrMW5hRkxFRmNzcHBKTU90S0QydW9aaHI4M2J4Q0FONHhU?=
 =?utf-8?B?K3BIVG5oWVcyTkRUbVVOcldVWHdVWDJFRHRGc3ZHcXpXLy9OeWlnaEh6UnNB?=
 =?utf-8?B?T2lHOXUwU0FWeHU0bUh2ZEFjSU5JK1NuSlFOa0tnQUlBbTlUaGgvM0ZiMkQy?=
 =?utf-8?B?eWY1MFhEWEVNeE1ZZTlsMXN5Y3hTWU1iRHY5NHBXK2RSTGNIcjdOd1I5ODQr?=
 =?utf-8?B?S0J2Ty9nZTlIdUxyalozUlp5NjQzNnc4WHpIQzRjZ1hhRTJBUTNYRHIzTHhY?=
 =?utf-8?B?b2ljVm1TY3pFOXIwL0gvc3QvUXAyNmlKcnROeFowWEYvOGxWZTloYjhVVi9V?=
 =?utf-8?B?cXFseE83ckJTd2gwVFlJNi9Xa09zRkJMOU9vUDRqL3dVUThGNmc2eEZXUHB6?=
 =?utf-8?B?R2pnUUN1K3REQUtaUFRLUm9VdmdHYmpSQmlwTUpqZjhiZnMzbEJKWmwraldx?=
 =?utf-8?B?VnA0TWorbVZ0Nm1HQk96YVg0U1U5cFlMYUQ5ZWtseVFzbXlESTkrUy9KaXFM?=
 =?utf-8?B?eUFWTldwT2V4Sk5ab1lZd2VpNEtEYlNnZ1ZuSjM1eWJqdkwrT3gzZ3lvN2lN?=
 =?utf-8?B?dFRZQzVlaDM3UVVUeUdvT21Ub00ramxwUFZmei9uMU5pOWgxRHpPaElWck5h?=
 =?utf-8?B?eWttRjk2NzlOdkJDdGEvTHNTTVc2dCtWR2hQRWNEN1p6UW5XYjNncU9VL1BT?=
 =?utf-8?B?bDdJb1dRRVMzWXBCQU1sQ2Fxdzg4U3ovTWo4L3JLT3p6cVlFaXZrNFlHclM0?=
 =?utf-8?B?R1RlWTMxZTBjbmNzMUpVbDNKNno1ZkdYMEpwZzhKU0dLRmcxeEFXNnAwT2VW?=
 =?utf-8?B?TkVvcENQSHo0eEg3RTZEN3Q3VC9QZUsvTDNmVkcrTGFSd3VpUTJBdHU2M1g3?=
 =?utf-8?B?bjFGenpyQU9jN0dTNXRVa2ZodTEvZVcxTkhmaHF0NnBuMng3aGxUVjdYdzBO?=
 =?utf-8?B?YVhXV29FSGE5TWFOTXhSM1Uyekhqa25hN1FSK3A3UXNlUzlBTzhzTkJpRWdD?=
 =?utf-8?B?TVNzN1FYaFhFZThEdmRaZ3VFRkthZ29Pa2FmVGZ6OGhON2pqNlQ2UlR1NEZX?=
 =?utf-8?B?WmJBOVA2eDVhUW85cVV4dTNKMU5YTU9kVVhxOVhoekhtM0ttemxoMExsSU9p?=
 =?utf-8?B?NWhpOFMzeXBXSW41ejlWVXdVdnhZLys5NWNmcjN5dVlRb3VyelNZZlZ5SHBw?=
 =?utf-8?Q?HvZmtqQveqVY0V/xUcX69KH2X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8147c3-b6c8-4252-092d-08de37bebad0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:35:45.2380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLQW26rt+7/8V1R2Mh9S5y2Ml41JCu8o3/ahz5MPh6PI3NH0CgBgZauahTt2bsUI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
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



On 11/26/25 16:23, Michal Simek wrote:
> Enable the new PCA9541 i2c bus arbiter on AMD/Xilinx SOCs by default.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig   | 1 +
>   configs/xilinx_versal_virt_defconfig | 1 +
>   configs/xilinx_zynqmp_virt_defconfig | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 4f0c4ba5c967..416128fa937f 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -83,6 +83,7 @@ CONFIG_FPGA_VERSALPL=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_CADENCE=y
>   CONFIG_I2C_MUX=y
> +CONFIG_I2C_MUX_PCA9541=y
>   CONFIG_I2C_MUX_PCA954x=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_ZYNQMP_IPI=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index bd6bfb7deacd..652121e27a0c 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -89,6 +89,7 @@ CONFIG_FPGA_VERSALPL=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_CADENCE=y
>   CONFIG_I2C_MUX=y
> +CONFIG_I2C_MUX_PCA9541=y
>   CONFIG_I2C_MUX_PCA954x=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_ZYNQMP_IPI=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 525744b0f61e..fc610fd4af5f 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -140,6 +140,7 @@ CONFIG_SLG7XL45106_I2C_GPO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_CADENCE=y
>   CONFIG_I2C_MUX=y
> +CONFIG_I2C_MUX_PCA9541=y
>   CONFIG_I2C_MUX_PCA954x=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y

applied all.
M
