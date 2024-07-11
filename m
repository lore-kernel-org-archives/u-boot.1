Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6673BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 11:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBD2886D7;
	Thu, 11 Jul 2024 13:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PfiE6NCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663BC886B6; Thu, 11 Jul 2024 13:28:11 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B3488025
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 13:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBo7x3HVfmSz7c1anyQgkRhrKVzSqWflIPrhFwdk527vHwYdN3YEu2j51NljJrUEr5ntmBpH1ZQzVhuL4MUzLwSEhTkjy3JmzUn8TH33fJgcEuAunwZuZMjtRKA/OUY0g5iAaoPyVcSl/A+q9C+gIi0orPdnzp3jP7zY2oh+PX7ZRBhjSoMgOOvmkjteQviaM1c3HQ/JcHjyEkfCvovXQLJc9FEuFEr9CuvEVFp/D1H5+mB76cBxsyvX3AQRpQrR5yBzHOYKBucN8PJRxNo0CdDv0B4ivgkh1hVWcEQueX5nHJgwXH2rpQq663cj+wwTDaEkppt3oqlFvsnd9poSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjha4qIaOk5/dcnaAGjlkrJSLQak+65NOZYaP/tVuZk=;
 b=HiX3AHBAhXs68ki3JE6t5NGKUfaXCgcsh/K9i7H2XlOtdvU8cjKwEegNlfj4LdGqL6EqGs8ppKxkKbd7QwQZ576F3ac3Kbo+IzaKUpkU3N1oz4fpBR28ltBmb+RN/RGKHoS0nwQIoHujiTEqnjUFc/pqiBtLLy4S5xMYGy+uz34A6P3638qbl9ZmTAt5bo/58hzN5WotQeSVs8riaCCP9Ki+7pEwqF6q6/c4LMd5wjW48DkbAJv4jHZSjFbaj8giD05VazFzFbugnBY3azwwEitcinSjOYkt3mkM4dV50uWNaXYmJcJr2U+ojd3LBeAXICHp+HRaZOagAI64f5aOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjha4qIaOk5/dcnaAGjlkrJSLQak+65NOZYaP/tVuZk=;
 b=PfiE6NCP2tjk7siv190i8IG6zV/0kH6GNOUA9F7O06Otj6Dj128m6lziYj2FGsQaD50Eh6aidhCUdZ+zSrP0HqG+HRrdU04U3hOHGtLFlWF6kLi+i22GHtTFG2ZNzuzdznGy8uDO0PmNfyKgz6G4pGoKPZk5i3XVZ0yEjDH0VLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:28:02 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:28:02 +0000
Message-ID: <8f1a16b8-bf8f-4d3a-bdc4-5c14cc41bc1e@amd.com>
Date: Thu, 11 Jul 2024 13:27:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd: Enable the NFS command for Versal2
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: venkatesh.abbarapu@amd.com, git@xilinx.com, jagan@amarulasolutions.com,
 n-francis@ti.com, d-gole@ti.com
References: <20240709115106.936186-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240709115106.936186-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0226.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::47) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: a2249ee9-455b-46e6-ab54-08dca19c85a0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWJDSDJVckswT2xFTVVrcEsxb3JSZXgyekVMaFBFTkV2MDEraExCQUt1Ky9h?=
 =?utf-8?B?UzdJNG1mTWJYSU5zUnUrMVpLRElib2tKdGEvazJFRmhSWFBCcHQxSG9lU05E?=
 =?utf-8?B?RnpJSFdTNE1KSWhyZVRMcDhuc01lT29SVnhUalYxNFN3VXN3Ym0yaXJtOS9t?=
 =?utf-8?B?cTlJWWpQcUY4N0xtN1RRa29nUDFXSWdBak9lMlpJMUpoNWZmenBEb2k5emc0?=
 =?utf-8?B?TWRveTVieW10QXg0azF5VnIyRUNKd1Z4WGJZK2lTNEhkMmw2bitQZVlhOXRY?=
 =?utf-8?B?VklIZGJjbzhFN3VRRUVJbUw0RkF4L1VCSGlHcHc1VEEwVUhjSDBFUG5QYng1?=
 =?utf-8?B?bjM3VFJ1VG9GRHNZcjFrakxzM0t0dmowRTdneTNXLzJNaXpoelBydDliR252?=
 =?utf-8?B?Vjl5TDUwVm0yT2hhY3Nqb2pYTlJKQThOYXptYWlXeHJXQUgwV1hLOVpweHZ0?=
 =?utf-8?B?N1FFTldib2tvL1JBUlBZRUN4M2RoY3lJaU8zVUdPU0dBQUgzM09ZV1o5YzE0?=
 =?utf-8?B?dG9SZXdaNW9FV3VSVk53MUhYaHpURzlWSEpyVWNXbEdMbTUyY1dVbFhlNDBm?=
 =?utf-8?B?ZWhCYlk4OWl6RHNVN2NHeThza3F1eFBzRGNkb3FzMjBTbno3d28wcmVDQllZ?=
 =?utf-8?B?RTdtS3l1V2U3QzBtcElWWlptNmR3VzhDTTd0UWczdUNQQjEzUGdoZjNXWUkz?=
 =?utf-8?B?TGdYUWE0dDVkaElHZTRuVFlVUEhiS1ZxeWZQcWozVnNiNHVNVWdOUVRkdUJ5?=
 =?utf-8?B?T1gvbk9YY3N2S3k1WWZBbnl1SlV1a2ZOWUdsM3FDbFJvMW0rU0tkK2Z5VVpS?=
 =?utf-8?B?Nmlib25Nc0hVV1FzSVdkU0pEZDQ5eTVhZ3JKcVdEaVYzYVd5VTFoQUFxTWFl?=
 =?utf-8?B?VUE0bm14NlIrYjZQYks4ekpUWmlhMFhQZ1YxMGlwVTFBSFRoVHg4SHVERWhy?=
 =?utf-8?B?SWpRWnVacU0rZW1BQnQrUFJXZFFNaFRvNjlMYXlCV3lVT0VQNDlMa09HeHhq?=
 =?utf-8?B?NHBNMnk5N2x1Q1ZrRGVad3lWUFJDL3FvVktPVmg5UFRpeERNQkdQRW5ob3ps?=
 =?utf-8?B?dkE2TzJmUHlVaGdEanpHRDFmTDdRS080RmdhcjU0R284ZXBuWjNxZmxOd1hm?=
 =?utf-8?B?WjdPVXlCbUJ4TUNkS254TFRwOUVwWVBoaU5qbUdnWWdRZC9jY1Y3bGdiVmVL?=
 =?utf-8?B?aXVMaUJjMEt2M3ZpR295bjk4T1ZzSWtSZ0wwYkswTnE0UEV5NVZ3am1oSVFl?=
 =?utf-8?B?Y2FtSFdReVF2cVBWV1dTZUVPcXZpR1EzNlJhQmZ2emkzUnZjQWlQTHNpNUd2?=
 =?utf-8?B?dnpmT1l2bkRIRktSNHNTeHgySGlsUTdBajcwNTBjcFVwb1JhZ3cxWEQ5YmZX?=
 =?utf-8?B?Z0pLNXRESFEreFBXWUxtQjJZWVljcStIZ3U5VktPNnRmS0ZicTRiN0oyZ3Ex?=
 =?utf-8?B?ckVWcWc5amdrbnhDS3p1SjhZWFVUejFQd2U0Z0Fzb1NDV0FreXpNMkZXbkZC?=
 =?utf-8?B?RGdjb1Zoai82N3pYcFVzS0Zzajhqa0NJKzNQZGlHNE10RlFWbXZpZWNSbndw?=
 =?utf-8?B?L2xFMUx5aEtWQnVteEQ4dElvb05jWDNhbjNEU2dDV1NIUGdHWTlnVzdCM0RS?=
 =?utf-8?B?cTV4bkt3N2FabSt0U3lDK01BMlFaNmd5dWlzVGdEQnZldEI4cTJEQzlzVzhN?=
 =?utf-8?B?dVUvWEF4Vy9QaURVOWEzakR4RHNMNVplTU5SOVdubkNFYUhXYk5kRlZUMmt1?=
 =?utf-8?B?RXVHYUNvWWFZaDgxb0t6VjR6UnlHcUE4dnBveFlCTUFiQXczUHZSNm9WTGRN?=
 =?utf-8?B?Y3RpWjlRaXN2cjNNZDk2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUc3azJuSHYyTkgwOHdHbDRCd0pwMEJCOE1sSGxvR1pjLzhHSytoS1RFUUE4?=
 =?utf-8?B?YUxSSnFTR0dVUWtGM0RHdWkwRGpoV1ZkQzBlaEh3V25rNmRMUHJnRHplUjk3?=
 =?utf-8?B?OVdMZkNid05HRlM1N1NDbTZIU21WUFBKNHJvY2FJdjIrbVNnWlAxYTRxYmFz?=
 =?utf-8?B?Z2thZU40eDBwUWhzMlNUZHdZUUN3akVVajVjeDZSb0phVzYxbFo0VkN0RWlm?=
 =?utf-8?B?bVF2M21oKzM4MWk2cU1ZNjNkaG1GL21mYStFS2x4N01LdXYvY21SRTdyVGZX?=
 =?utf-8?B?ZFVuOVpyTm5vV0d6dUVrcEFqaHZyNUxmaXM1R3BzNnBBc2lLVDhPRXNIWk9B?=
 =?utf-8?B?ZlQ5VkxKekdod0JZOW1hQzYrZ0djb2lhVTVmZkR4WVNWc0lFV1hNRW5IMXFU?=
 =?utf-8?B?QnAzT0NkYk53M1JzaW5LRDRKVk9Lck5hM2NQZlgzYllidW5hVlFnSEtManZo?=
 =?utf-8?B?N2h3ekRxTFp4NjRJVWVtVHdJSGErZWdMZVNTYTFqeS8yc1FTRE9hNVVKcmZX?=
 =?utf-8?B?VXdKNWVkQzEvL2NhZGljL0pVazY0ZFFhQ1h0TmsyWXoyRVRYc3FqOGR5RE1X?=
 =?utf-8?B?YWx3SVNVSFhCK21ROFE2QnJlNmllT09jY2RWWUxtNkNpMlpJMXZ6UGV0Zm1k?=
 =?utf-8?B?ZVZKUVdHbXNkeTBRQ1JNNmRUUE41L0FXS2RpOGtKNVlQaEhDOUZkUnRTa3g4?=
 =?utf-8?B?YkZyZ1IwZlFhKzk5VUR4dWRGSXM3bjhaVzkzTjVYazFOY1Zmd0M0bFpNQTlI?=
 =?utf-8?B?WEhBNThYT2JsVHpSTE5xcXBXMEF6VFRCY1hJbm1pUUJJczBIVXVPd3pUL2hm?=
 =?utf-8?B?aVZ3MDlMbVo2M0ZwMmNUdFJxMjBMRUpQemlTeEpjMnpZNW00ajJLMUxndmNq?=
 =?utf-8?B?Q3Qwa09PNzVkREo2ZHYvNU1kNFppTEhFdFpYdlNOYW5QMk5PVHAySFdqTmk2?=
 =?utf-8?B?ak0xOVB3UkJkUElEUUhxS2FTR0p5OFQwRGx3eDFLNFpRVSs5dk5MaTBBWjhs?=
 =?utf-8?B?YlBaYm5PYTBZOTUrcmtndmRXRzRkNit2bWZLUmhscW1OS2MyL01ISUVIKzhh?=
 =?utf-8?B?M1hPUHQ3U0EzUS9zMVRKd1hkanIzRVg0Qk1NZmpvaGxyZmh2dUxkd1dYOE9v?=
 =?utf-8?B?VUw5Qk9BazRkbklUb0JOTzFJYjVwZnhNYmZraWxvK0s2eEtRNTloelhTMGdF?=
 =?utf-8?B?MnFoSVYvcTBLaGRHQ01IbENZRnI0TWUxd2Q2UzRiWUxrYmtZbWk1Q2hHMHc0?=
 =?utf-8?B?QURMTjBwSFR5cWErbXFpa1VoTGNVWERoYU9JQlZyWE1odnVJeVV1TmJxeW5L?=
 =?utf-8?B?eEU1RUsySy94QTlFNDh4RkxQZW9KYUxHSEVHOUJqK2gvbzYwVFAwM0lRek11?=
 =?utf-8?B?dis4bzhrMDVuUm0zeEtSR05ETzBCQlJKYkNjUVFXUFJHeGdmWW80VDcyZ1Q1?=
 =?utf-8?B?ckNIWE5MUldCT0ZQT0tVQlJ4MSthN3N0ZHFZNUJBZms1UXZjcHBzbkJNallH?=
 =?utf-8?B?MDBTYzNXRkQvRW9IYStYQjdMWW16bDZtcCsxNzNQeHVaWFRzN2hFV0tpNkpY?=
 =?utf-8?B?RW5nT3c0UjQxV2UyaDUxdUZ0QTNUWStGZHdOUDc1RjFsR2REM0VybndwL1RT?=
 =?utf-8?B?M0xTZ3dlQkQrNTVNTEprQjdMRTNUTmN0RVZzRTlwSXgwcTJ0WDhhT1pwbFNU?=
 =?utf-8?B?QnF0ME1aOUx2UHlvcUUzZ1NiWGRzaTRLbklucGw3WlM4aHZ5RTUyRHczVkFa?=
 =?utf-8?B?aGsvbkNMMWdxK1ZGUG4wSVVpV1ZROGJkWkRJdkhMUS9ZODZWVEJTaWNYQjRu?=
 =?utf-8?B?SWMwZHBpQndnZEsrU3dKVnBCUEx5VlhxZG1oc3RlaDQrTWFxd055LzVKZ0g3?=
 =?utf-8?B?a2ZzUVRUelJ1bWJzRzh3am5XcS9vS3BRclh2NEUvaWxqeExVbUtNMDUyMlB5?=
 =?utf-8?B?ZkRvR2dMTElmbFVSUllTMjNEcXRaeVBKUWwrMVM5SWlDZ1ZMQ0xGWUZDb2NX?=
 =?utf-8?B?SWhRWGhFbTJveWhTVFJJUC9hckZpbzlxSHRsbDlObHZKeW4yYXA3aTFEL1BM?=
 =?utf-8?B?azdyRkpBZWNFTHZsME9pMFo1NVljSDd1UC8xVkRCQlE1aFBSTDI0TTJGVCsr?=
 =?utf-8?Q?1QTw2ctstFNRmwQWU5ICquUZx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2249ee9-455b-46e6-ab54-08dca19c85a0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:28:02.1363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOcHaLSxIBgt1cZwTHnTmaGF+xDXA8poHKQ3DhgZGIg05eW/gLiAFy2YNiIdYy8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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

please use official Versal Gen 2


On 7/9/24 13:51, Prasad Kummari wrote:
> Enabled the default utilization of the NFS command on Versal2

Versal Gen 2

Thanks,
Michal
