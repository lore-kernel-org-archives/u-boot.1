Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8883E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 08:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F5618069D;
	Tue, 14 Jan 2025 09:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QFB7c4K/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 832B4806B7; Tue, 14 Jan 2025 09:10:51 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE78280657
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 09:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldq7/6BOFbdwRcvdBqToeY+Vc2oXwiN7upPICH7cqa6JR+Kh+0ork8Djgxq8hrD5/ibdcDV2lo2g4Mx/MVAeoz1Wte7MZIAzZV5B/5WKSOf6dvtoQLwr1iPG6K1eWX3f+yZfsrbmVIdTQYMnY81PqPJbS/UoEjWb84CQKNr6Bq0sJUyIxL43yLe4SY7Ez+gfFf34fSEuIe9SFo/Qco08VQPC7LBaNYKTJkAcY7fIUe2EQbMRsSSoiHYaOOvHimHQaCj3a3ih869xuwcRZz0IHHh51HOCLjcpa6LwJTOOTxeLPmq2A69Yf9IjH+82/IwnJDfUadORU2KxSphTEMqIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO6AS6gtvUTp9x87CRXuzipkaya+TKA06iAV+mqTF2o=;
 b=tCqXPuPc65OUUM+pyoLLb0Mq1dV7Jy8bBX+lE/CoyuojTejVxtVxwcRWt9C64Ssmrl3f8H6mP+EVEQ0NQ8ipEye7TDtLfaubN9nW10c/fdVwRvKmpVCCRIAdL6zobl1kYYHzT8ymumKX3nk8Er+UqJQvTz9AqhNITQql4cAV1Bnv55stGiksWil7ij2Q7fTcyzMgWxMHZ8RYecWlOflRLx3+Mut+RoGwM6kct57rM56J5dZ8l2FRd5erI596ZHt78L4m272JoRFxTQhcUFEJQZHifXQRLONQifAPgllP8d+mkcTiGcS4vhvbk7RKrA02bB2Sss5hUKgOM/FGr6qOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO6AS6gtvUTp9x87CRXuzipkaya+TKA06iAV+mqTF2o=;
 b=QFB7c4K/Ko09YoRv/s7HcNPk7jpvAlmjo9lwrGtnBr+r+dvBoN3m5Nmn1WywElAyKrsAgHB6fWE2Hd5XWic2X+qFO0PbXB8jUgKeExP0FH1B8zk4uOUBmNijXwUyumBRBlqP0mHBVksqhNW17cxqlmXkW/n8jzRqn2oIUPEEmeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 08:10:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 08:10:43 +0000
Message-ID: <5d81e09f-2cb6-4298-8aa3-1728c954e08b@amd.com>
Date: Tue, 14 Jan 2025 09:10:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot][PATCH 1/2] fpga: fix alignment on fpga cmd usage info
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, u-boot@lists.denx.de
References: <20250108140357.969380-1-ibai.erkiaga-elorza@amd.com>
 <20250108140357.969380-2-ibai.erkiaga-elorza@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250108140357.969380-2-ibai.erkiaga-elorza@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cafe02-c3e4-4500-a091-08dd3472f0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG1zdUhtcHdyVUJjOE4yNFNHTFExNmJUZnB6Sm5nUGhIeWhpWWFBTVZ5eHlL?=
 =?utf-8?B?Tm9OWUp6SVhiU3BkM0pRRnVQbjZTRldGWmFKZVEydjVkUlREbTBuVW1XcUZ4?=
 =?utf-8?B?RkJQelQzeDUzOE1WY0srN1A1dmRFUUZEL1l3MHBVVmtoMGVNYnZXbTIvNEIz?=
 =?utf-8?B?UTR1WjNaUnNXR2NpdCtFQmRTRTQ4a2tvMlZqek1LcCs3UHVKMEdMMmIyaVBB?=
 =?utf-8?B?MnZTWGJXZFFyT2ZGNTBRUFlKd0lva21BV1htdGdER21LSEVXMVRBQ2hoRjlK?=
 =?utf-8?B?UlhOUjlpRmdlQzc5eDlUN09VMEovYzhiNkV0aW9oTW56RjlPdUNYY3VWbmpM?=
 =?utf-8?B?SmhzOWg0eFhPaUp6MEtVQnVweXRma1VuaXM5TDhsRHZ0S2liUjlNU1VvQlhI?=
 =?utf-8?B?S1IxaVFrU0VEK1BBTFFDL1VJZ3cxLysyQTV3eWdUMk9nQ2dEM1NJQWZ3UEdE?=
 =?utf-8?B?eDBqa3UwVGp3Q1RCbXlMVTVNQStudjdHNzhkYW00VVRyUTRnLzNDSFRueWZ6?=
 =?utf-8?B?ZmQ2QzhPQ05mQ0pRRFVianhVWGdVdE12d3dTSXI3TXQ0TG14SFdsam9sT2dY?=
 =?utf-8?B?MlczZmhIWWxaQXFockJ2YzBNSTZ4OE82ZDY1YzFiSVZxeDNvZkltRHRMUVlQ?=
 =?utf-8?B?SkNBYjNJeGExL0xuUzRPYUc1M0M0RTBWRzJ3SnJwTEZaVnpCd0ZlZzZlY1Y1?=
 =?utf-8?B?R0xuZmdGWjhLTk5uV0E4dXFocTJ0MTBaSWhpK3B4a2dmS3FQUmFZUTFTWjVu?=
 =?utf-8?B?QnA0clZoZG9KTmxkMkF1NHdiSCtPUEZidDRBRDRjT09VaEMwNG5PWXFUYXZ1?=
 =?utf-8?B?bVlvWDdtNzFNdDFpZGhITVZjQ01mS1A0Rk8vMkt0aXcwajJodTNjbnFkRFRW?=
 =?utf-8?B?eWdGeTdpMWdSVVRhaklIT2VMckhNM3MxdU00OC9jQzkyZ2tYUWhBMFY3cUN4?=
 =?utf-8?B?RWtzZHVPc0dBWFJNN3ovZ3lDN0NyZlpkVlFBamhEaGkzb29EUkxxczVvamJX?=
 =?utf-8?B?dnU4WXRTQ0ZxQXJ6ZHlPUllnTlIvTGZXVWpyT0lkSUpsdGFxbU9uTUl3L1l2?=
 =?utf-8?B?NDVObThrNzBkbXRFS012SVFOV3cwUjQrUjhIRkoyVStRU28vNVdJbnBnS0R2?=
 =?utf-8?B?ZkFQVUZyUjQxbzIxd2xBcmljV0EzdXpNeG9vb09reUFpUnpOOGptTUZvc0xq?=
 =?utf-8?B?VW5zUGlPWlo3SnhQWm4xZWViVFF3WHBuTEUyQ2RvMWgyWEczVi9SbFhMTWcw?=
 =?utf-8?B?NUFPY3UzbEMyc0JmekRCRTN2Q1lYcHFYRHU4eW5CRTRidFZPRFp0TUFFZE1l?=
 =?utf-8?B?elUvTXBUVmwxS0RRRzFNVzJpNTY0UG8yUW9tcFdWR01HRlZwdFFIK1hrWjZm?=
 =?utf-8?B?M0UwNmtvaG1ONkNkWHAxd0pkU1FwaFZ1ZnRtNUtyV2Q0U0Zmdzd1dXpyMTdo?=
 =?utf-8?B?NGFHZkRldmkzS0VXamR5SnFUdGRxL3R1REFPUTIvUGNtSG41OXJYYjB2VUMv?=
 =?utf-8?B?dTQ1UEpFdUtIeFhzaTVrYWIvK0RUbUIxWFNCM0ovRDY4enJ4bTB4Szdid2Fi?=
 =?utf-8?B?WGJ4aFlNQWhSUERRNTJnaXo0VGpuaW1aZ0xoUTFtWjlpQVZ1UTRvSzRmZ01U?=
 =?utf-8?B?YTlZaXUzUDBQSGJ0VSsrS2xqTnUyc1lETzNEMnEwd1NzTWltRXVSbEc1S2xa?=
 =?utf-8?B?MTBvSTFHSmpFRUF3SVI4NkMzejd1eDNDNFdMZ09wYmJwdGVwNGxZOGt3V0ZV?=
 =?utf-8?B?U0JFSUorSXEyWkF1TjZjTXVRRUpaOG1RZjN2QndTN0Z2amovdWxxdnA5OUE0?=
 =?utf-8?B?R1VwRUtZZ0lDekZSc0ZnMSs2WkVnZ1NsZWdrYktHQ21GWjNPbFAyOUVaTms4?=
 =?utf-8?Q?4IUULsV+U2lsa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHhJMkI0ajJSV3hBR1Z3cGNLM0dEeGplR2d6Q3BOb2VNVUNyMlZwMnVFSGc4?=
 =?utf-8?B?akN3YWVobW1tRytrZXlsMHh4Ujh2WnVjSHhPOWJMY05vT3NNZXVGOW5pN2hS?=
 =?utf-8?B?SlJlUmJPUUVYaVA2azdpQzFvV3NGSTZGektpSnh6QWN6S0FkNktmdlNNMURY?=
 =?utf-8?B?SUw1RncyUjlFazN4Vm1rYVB0bDAyZVdlTC9McjFGTXlPdm5hTTdQdERvS0xl?=
 =?utf-8?B?RHpDamFNNklwTVloRFRDUjhoNDN3S2pIUTkxR0dqbXFRenllcEZaalZYbnQ1?=
 =?utf-8?B?UHlGamh1RzZrT0V2YUQ2bFVaUmNYZHRISWhkWmJvRGY2ckRIOTNiSkFlVVlY?=
 =?utf-8?B?dnhOWEdicUNhVVZnRy9LUTZBTnAwZmJSV2VQcDZGcjJaK2lUSEdVYzlONTRC?=
 =?utf-8?B?Y1NpMDJkQm5QZk1NRzFCeXZxRDBjWmorZXJkcWpzSGQwRmNzcnJkTnJiLzZ4?=
 =?utf-8?B?cDBJZmlDYm1JQklEV2E1Y3YyVzdTcmJFRWdWMmx2dW05eGlRUkJ3MXZVSVdn?=
 =?utf-8?B?dHdORlFkcGRCVzBENFE4Z2ZXUkljZDJLSW9sWGRIaUQ3N0M4TDFZWk5Ib2dD?=
 =?utf-8?B?YVZLOE5RNWNTeThYN2NTZ3JLcXZCbTE1aG5zNnp2bkk2eVdXNXYraHgrK085?=
 =?utf-8?B?WDc2bUVqVjFnS3o2b0Z1d1BZRVNpL0J6Y1VzczlRRjRnTCsyS0V0cTFPU2or?=
 =?utf-8?B?Sndqc3REZWJLMEJaRlA0Um1RK21jenRKbkxQWml4S3F6NTFTQkRFQytXcHBZ?=
 =?utf-8?B?SXQzbGlNb0V4Z3plZkFKSnFQWVd6QUxYNE9VSGhxU1NEWUtMT29xV2J5NTdJ?=
 =?utf-8?B?QU1xNWZUZDFkaUxRS0Y4SjR0cnVzNkRpM1g0ajVOMXJSLzFyL0FON0o4Y1Fn?=
 =?utf-8?B?RE81dFdxTWtVdDExZitOd1ZRWkU5d3RiclVESDJJb2ZVNXJhTkpQYlJwWkk0?=
 =?utf-8?B?MVBRR2Z6K05IR2RXUjdjYThoanJrY2JJd0lzRjZFNjdNWFR4VksyRjNkWDcw?=
 =?utf-8?B?eFRzUzBmb0w1bENSb0dLSU5mMFlLK254aGpXZDlGK0F5YmV4Y0ttVGRiY3cx?=
 =?utf-8?B?Z055TzRpN3QwZjJLTkhESW43bHpnOHFJWTd2NExkSjZ4ejg2NlA1SGR5emdN?=
 =?utf-8?B?VkdNY3NBQkpIKzl4cGdhZUZPU2lQN1JEMXErTGJLK1l1ckw3TDlrQitDbzFu?=
 =?utf-8?B?ZGZiNVpRZUo2NURKZFd3UFE2VWVIR0YwYXhBMm1WL3RNRlFzMHNTd1k3S1Yx?=
 =?utf-8?B?S1R0aVFNZm5jVVJ1blFHWUltdlBDcEp0anRWajN2QzkrT3dOTzFTeGQ3Snhm?=
 =?utf-8?B?b1ZLQkdWR2Y2aktkSHFLNlUzdjM2cDJQT28vS281eHFUUkZKT0ViaHN2eVY1?=
 =?utf-8?B?VEVzK1VOQjNINitVWUc5UzNrZmhBejY3OVkvTVo4bVNPMGZaRHkrMTlEQTd3?=
 =?utf-8?B?T0lwL2wvWmtzWlAzZ2gvNlh4bkVBaFdyaG1Ic0FXdUtrWVVqeGRDNUE2SUVL?=
 =?utf-8?B?VXVFaG9ndGZ1SjZqdTNCY1EyWUhXUWFOSDZzQyt0UGFvbTdhWlhHRGwxRHZk?=
 =?utf-8?B?RVNuSHAzcFhkYzN0Y2UyOXQzcTJ2T0t6WmVaRlZheEFQK0dCSFdhOExxQVVy?=
 =?utf-8?B?dHpuMTAzbEE3c3hVak9OUDBEUnowaE50MVh5SitxUHRhMUt3RzlDWHBXTW43?=
 =?utf-8?B?VnUrZDRKMUdBWm85OTBhVDdhcFAxcllrNzNVZWdsSjJ2eHBMYW9DajJrN3lu?=
 =?utf-8?B?RkVNM3NucmhvdVhmYXlKcEhMOU9IdjFaTzllK1dlelcvQlV2U0JCYWVkUG54?=
 =?utf-8?B?L0JoV1RwVkl1OEVERmpPNE91djhiemRjNVk0T09GVDd0R3l4NjBHRnVYTk52?=
 =?utf-8?B?OU5MbXhKamJYOEVIbXhISFhFRG1QYWNJNEVDRXNYVFhGVVA0VmM2b01JV09N?=
 =?utf-8?B?cTZEb25mNnZMbXR4ZGI5d0VvenhsRUhKMmF5dmxtdFViNWRiaXN6VWVRZDRz?=
 =?utf-8?B?K0tkdExQQmpINmZSU3hQMmRXTE1BeW5zemtiSHl0TnVzWWhMYnZMWGcxUWdv?=
 =?utf-8?B?NTVvVWRUdk9ScjBXUFU4MTcxTGFGcFJDcjRqUjNKRjNBSnF5dDFmTGtkSUk5?=
 =?utf-8?Q?lM/Tk21mjVhZh3TMGAj6+C4Zr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cafe02-c3e4-4500-a091-08dd3472f0d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 08:10:43.0101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kyUGBQUH+is3rzW6udu7ZOKCzzxbIflVPoePcJ26XvzaU2q4uqIjPGLa7ItupI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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



On 1/8/25 15:03, Ibai Erkiaga wrote:
> The current implementation generates some alignment issues as well as
> some overlapping when all the fpga command options are enabled. The fix
> is intended to improve readability of the usage info.
> 
> Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
> 
> ---
> 
> The current output looks like this:
>    loadbp        [dev] [address] [size]  Load device from bitstream buffer with partial bitstream(Xilinx only)
> Load device from filesystem (FAT by default) (Xilinx only)
>    loadfs [dev] [address] [image size] [blocksize] <interface>
>          [<dev[:part]>] <filename>
>    loadmk [dev] [address]        Load device generated with mkimage
>          For loadmk operating on FIT format uImage address must include
>          subimage unit name in the form of addr:<subimg_uname>Load encrypted bitstream (Xilinx only)
>    loads [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]
>          [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]
> Loads the secure bistreams(authenticated/encrypted/both
> 
> The new output lools like this:
> loadb  [dev] [address] [size]  Load device from bitstream buffer (Xilinx only)
>   loadbp [dev] [address] [size]  Load device from bitstream buffer with partial bitstream (Xilinx only)
>   loadfs [dev] [address] [size] [blocksize] <interface> [<dev[:part]>] <filename>
>          Load device from filesystem (FAT by default) (Xilinx only)
>   loadmk [dev] [address]         Load device generated with mkimage
>          NOTE: loadmk operating on FIT format uImage address must include
>          subimage unit name in the form of addr:<subimg_uname>
>   loads  [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]
>          [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]
>          Loads the secure bistreams(authenticated/encrypted/both

this is not the full look. Full log looks like this.
You can see that some of that lines are longer then 80 that's why they are on 
the next line. I think you should stay inside 80 chars per line.
Second loadp is in front of loadb which looks weird.

There should be description about meaning of [] or <> in help message

[ ] should means optional parameter
< > should means required parameter

Below all of them are optional which is not truth. It is correct in fpga info 
but not in fpga dump. It means I think when you are on this descriptions should 
be also fixed.

Also line
fpga [operation type] [device number] [image address] [image size]
is not covering all commands. It means you should consider if make sense to have 
this line.


Usage:
fpga [operation type] [device number] [image address] [image size]
fpga operations:
  dump	[dev] [address] [size]	Load device to memory buffer
  info	[dev]			List known device information
  load	[dev] [address] [size]	Load device from memory buffer
  loadp	[dev] [address] [size]	Load device from memory buffer with partial bitstream
  loadb	[dev] [address] [size]	Load device from bitstream buffer (Xilinx only)
  loadbp	[dev] [address] [size]	Load device from bitstream buffer with partial 
bitstream (Xilinx only)
  loadfs	[dev] [address] [size] [blocksize] <interface> [<dev[:part]>] <filename>
	Load device from filesystem (FAT by default) (Xilinx only)
  loadmk	[dev] [address]		Load device generated with mkimage
	NOTE: loadmk operating on FIT format uImage address must include
	subimage unit name in the form of addr:<subimg_uname>
  loads	[dev] [address] [size] [authflag] [encflag] [Userkey address]
	Load device from memory buffer with secure bistream 
(authenticated/encrypted/both)(Xilinx only)
	 -authflag: 0 for OCM, 1 for DDR, 2 for no authentication (specifies where to 
perform authentication)
	 -encflag: 0 for device key, 1 for user key, 2 for no encryption
	 -Userkey address: specifies the address where user key is stored when user key 
is selected
	NOTE: the secure bitstream has to be created using Xilinx bootgen tool only.

Thanks,
Michal
