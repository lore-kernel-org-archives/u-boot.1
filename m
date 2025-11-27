Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5A1D116E7
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 02:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E589883B72;
	Thu, 27 Nov 2025 03:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RpfqYuuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73ACA842AD; Thu, 27 Nov 2025 03:21:17 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB9083A64
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 03:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNOvZ+Zn4C8kvdSq5MxejDWNdoM2WRoJN65lmzdyVODCZQ31VmK7yP3BZYx38JDzUShqzIXjU5NsSiJnqgIY3SzU5WwA6DcNE3vINXQNdz435WVXKyhFghccEFtPagnrj/yfDsE5EKs4ppzPGgCt61WMP4NCoA5doKCGXtUfbv297mNONy1mpnyzIOLc9G0mdElwSwenBt0p1eXBEB2a6DtBh0GqVD5UHhLXhicXVoCY6BsUybxivujAEQipiisE31aJTPmMMm8nin7GLW9CVXCrD3IdvTPP9mDnBTdZQooM04b/HDVtZRc/U4NRDmp+DWe7OzBUA8bsPZUh5BF4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zbK6N1xoLf/8QaLuoMpUqwkv5PeaTexFBGueU5Z8+Y=;
 b=oXX5PrUctFWgmN2zEXTlWQrrt5N/god4dHFrBENXD/oyVOiMFIKoeoLO1PfA2Ra7smIoK4w3/NuWEhNbcMT9eUkIOTEuEWWDNQSe7o/MlartKqVas1gZZTJPkCGBM8cegN8/HKCC5TCrzRIWgMB3rrAoK0RqCahIHKkWQiv5BzHYoICiP+IPiT6k+3+OWeRmgb4KFQeMVrvuBp8y8wAmgS0w9ncq+3GSFu6BTO3bK9ttu3JzWClpnQ8pxfbAWou2eGYgdL5l1qDNnI+enuuXGVMMBiC9GVLx+ZdH5i50PrSd5dlZcEJcXNPCbAvQ5IOXr1gkdpquM7lnm+qRhIiFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zbK6N1xoLf/8QaLuoMpUqwkv5PeaTexFBGueU5Z8+Y=;
 b=RpfqYuuQpjPPmzvSmdceFrJakDQ4Ynge3kgjGGtnIKhMigIRLEqUEem8qawIhUjotS92KUb9kmVMNyw1dO4SErpKWzX9zPALzzrvE7k41NXNI7Fm+ZhsxS6uUVeCUkuEB3UtUs8wikqSmZo/qafNiYvPEKbpa6DeV6p9ybU9c+e+JddWNyXUYhbHXe8tTrQmKD1hduh2XPqiHC3nGjUMDn3g9RPKvVNnz1LvtmR0pOTVUTSKIn7omT9gGCjS9QmaS744G+bGgG8qX+/aAfzpM9BgNiUmnRHvosRDMEY2LmfzCQyMC/0MlOQ9gzaQ4prPUOWg+hQobNnGpxwCkBm5Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by LV9PR03MB8392.namprd03.prod.outlook.com (2603:10b6:408:366::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Thu, 27 Nov
 2025 02:21:11 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 02:21:11 +0000
Message-ID: <9b840161-a1cd-425c-a262-174dc621b9ab@altera.com>
Date: Thu, 27 Nov 2025 10:21:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] mmc: socfpga_dw_mmc: Restore legacy clkmgr address
 retrieval
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-5-alif.zakuan.yuslaimi@altera.com>
 <e7640e90-8bb0-4f6a-85ec-4f4700393bf9@mailbox.org>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <e7640e90-8bb0-4f6a-85ec-4f4700393bf9@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|LV9PR03MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdfdf3c-6328-495c-ed6c-08de2d5ba13f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGZ3Z0t1UStvdTR0MGlHV0lvTWh2NzAzajhCUkVyS3h5d3ZSdVVMa3pLa1M2?=
 =?utf-8?B?NGpCZkVjMWJsak8rbmhGb2RzcHVabTQxcTVTUmZuZS9Ba0hkT0RKR21lTmFC?=
 =?utf-8?B?a3JTcWxMSzNBMFRrRi9tT2Vmb2UwZEZQZjZ6SmN6KzRuM0lZMnFsQVFkclVu?=
 =?utf-8?B?WjJDZDhLOHpXd1IrZm9vUVdML2dkWmRWTDNhU1I4ZmNRaUFwOHpZMGJxSkhu?=
 =?utf-8?B?bUNtc3NVdnc3bStqSG9JbjJHbGo1SG1tZXFRSXE4OVVDL29WMHVNemsxZ1M3?=
 =?utf-8?B?OHRmYWFZQjEwVksraVFhUllzZEg3Rk0yS0FvWWZ3RDUwSmJzOEc5ZS9VOVNy?=
 =?utf-8?B?THNld01mVzR3Nkk3U1UzRjRMSUZWMFd4cElrWWMva0dSTE0zcW1SUVZPbU5V?=
 =?utf-8?B?NVZoZFNLT25zT29YVS9hT0V0cVZOMml0ZGxhWVdraWxQRE0yc3hCQ1Q2OVhT?=
 =?utf-8?B?Y2VKdUY3WlJBK0N2WTBwdzRGbkxWdnpoYmVyN21lNnl1RGFGMjRGR0wrTjlE?=
 =?utf-8?B?ODloWHJkQ1BxYkNESXhDYkhaUk5BV1hBdTdPRVZ3TGdUbVlQSlc5THl3aWlG?=
 =?utf-8?B?MG96a1UrcURXR05iTEViUzNKQW4xcUF0V2dTcnJPa05laWt4Y0FOR1U3Q3JK?=
 =?utf-8?B?cFFSYm1LUTFUdkpPKzArS1FJMzNyWUErUFYzUlZaQStLYUdkTXphbkFUdm85?=
 =?utf-8?B?SWRNdGlsZDM1Q1A1dkIrM1psMUhUcGhrcllYRjIwQVhVWmhORXNxOVBmRWRE?=
 =?utf-8?B?UGVkMm1HNU1Edm8yZjl6Wk80dElIcFVuSFcrVlJmNnVqTXhNK1FRbFZxa2E2?=
 =?utf-8?B?dlN5V0lNd2tQbUp3RW5heE00Q2NObFBJUzJra1k4c2RGcUQra3lCdkEzY3d5?=
 =?utf-8?B?Q0F0WmJ6UG1rMzlrWWJ5VENRanFkN2Rkc3g5NjNsZVBFd2JPRUQrbUtxZDda?=
 =?utf-8?B?UVJwdHBOTUFQRWV0VTZCZW94YzA5V29SNHlTVTdFNG9lLzk1OW0zVlh2cmMx?=
 =?utf-8?B?Mkh3MEQxd2VvdHMybDFvWnl2elRQbzlid3VFVHBBS2YzZ0UvMVFKRmtjZUNN?=
 =?utf-8?B?aG1IRWlzR1pGL1dvaXdzYU5XUG9zSGEzTnlGMDZmNCt0eHE1R09VcmFoWnQw?=
 =?utf-8?B?Uk15RnkrK1E2L21SYTFjSFRrOEhnbUllUWNaWnpyREVWSGFoNXZxTEtPTHZZ?=
 =?utf-8?B?NGR2Z2lQcjdTQ3MzNGVESzR6N0xrRXl5STQ5T05TaExjVnA1RXQrOUg1aDNL?=
 =?utf-8?B?WTdHTFZiR24rNGlyc2tUWlJqcWloMUx5MzMxYUxhTDhtL0xQdGhiVk1MeTgr?=
 =?utf-8?B?NmtXV1JkS0lMMmQvYWJlUEpPdkc3UTB4ZVNWODMxejdEbUhqaC9Tb0l0R1lV?=
 =?utf-8?B?ZjcrZjVOS0NTUzVndkJxTVFyMDhYWEo0YURsQ1oydTAzYkNLWVpTeXJhRFVB?=
 =?utf-8?B?KzdvK2pZbWpLMVc5cG85Y2syVVNHTkp3NlRlU2dBL1p4eGduaFhHWFNUcEM2?=
 =?utf-8?B?RHk2QUl6V3I4dE5yckNDck9HbmtTMWVuQTFCWjltak5oQU9LVGVXbUF0eTRi?=
 =?utf-8?B?dzBUazlDRS9YQVZLTDlrdnU5WnZFT1RtTGlwelNqamd5M01LWEhSOGVvZTFW?=
 =?utf-8?B?TWtVQ0NpQVovL0E4TzZ4QWN0aVIyUUp0M2lFcUw2N3ZiZGV1OFVTYUtEeEh2?=
 =?utf-8?B?dkJaZk1wQWpkV05vVG12RXBzWWFGNFdvTVpBYmhqNlpMS3U2UnRrNGF6eXdO?=
 =?utf-8?B?UEE1NGsvcnB5cGREVWFCMGdFdzV4eVR3SnFqa0ZuUXlxWTEyZ3RsdHVwdE8z?=
 =?utf-8?B?ZjVpNW9GU0h6RndlbWxabzdFbG1BczFwbGhqOS82Q1JZNXVBQ3N3MCtYTVdI?=
 =?utf-8?B?T3NUVGV4d2hxMHRQcldFaHZHQzdRcFB3eHN1cWhkWUhibkFMQ3RrSEwzbU92?=
 =?utf-8?Q?w0opV5RAe73c/fQzwrfzYIRVIqBArYDm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDZEYktCRmI3NmhyMkJ0Q0NIdEpncVpvb0wyd0lGZ0lMWng4T1Rmb3NENTlH?=
 =?utf-8?B?VGxRVDJBUzdGaHBRR082Q0gxWGYxWHRaV2VRTnpFTkozT1NaczJwd0Z2aXBs?=
 =?utf-8?B?U3NnbWFsSDRXTzlKY05YeGFETitOYTQvOHFmWFhVanJNNzRPeFpocGc0UWh1?=
 =?utf-8?B?NkxwcndKemhlZFU0K2FOV0hWQXlOSCtOa25WQ2oxc2FZV21zNkUza0J2Ny90?=
 =?utf-8?B?OHorZ3YvTm9OaTY4RTNvTFJtTDlWNVlzNEpOZkhONzVHWXF2VEVJK0tGMmtR?=
 =?utf-8?B?dUZuZGJjSUtlNnJrendpY1hmUzZrSi8rR1MySXY0YXc2MjhKVEdjd3kycURJ?=
 =?utf-8?B?TkV1MkdodXlpd3BJdlI1VGJqTjhkVDVGdE9rKzJ0U3Vrb3g5NXVmdEJxdGhk?=
 =?utf-8?B?azdRR1hsUTkzTTFPM0I3eGpMczFoWVhKS092dXlrdjJqS1dKNWdHVFlhRm00?=
 =?utf-8?B?OTJxUjdXZWpPeWRHeERRbVJRT2c2TGduK2podk9mQzF5KzVVbUJYTDE3RG9p?=
 =?utf-8?B?MmpVenZHcHB0Y2pyTFNsL2UrN001cU92OU9DMVgxbHhwRHZrMjhFS0RMMUgr?=
 =?utf-8?B?MVE0NnhWekJDeXJ2RWFrdEJIVGdJRHFWaVRZSDRsMzN3RDJZc2Y3Q3hiTEFN?=
 =?utf-8?B?ZmNNdFRTYW51Rnh6ZlFvSzZMYTdHREZ2alJWL0s0WVppUWNsVlEwSmtNV0dJ?=
 =?utf-8?B?Vm8zMDh6OWxsSzV2bzRjQ2NmY1ZFMDFDVHQ5bXR6ZEt0M1V3bzZrbEdkbVdy?=
 =?utf-8?B?SFFaSldNVFdwYjIxbWxQejZESm0xNExMVlJ2eHF6U1BwR1gwQU9Dc3VqUUlW?=
 =?utf-8?B?ZHVaZ1dZcXB1Q3dwYUlld0c1TWt6Q0ZzSzJnOEJkQmZpMlpPRE0rM3MyVVdu?=
 =?utf-8?B?NFk3NlE1Yy9SNlV0TnowdUNRR1lWTWRZK0U3SzF4U0x5RWJuQWdudDZJalc4?=
 =?utf-8?B?Qmh2M2hRRlBsSXQ5ek9vd2oyYXQyL29pS3RudjgrYjhjTzA5SWpwbTFZeUNJ?=
 =?utf-8?B?ak1XcXRCWER3bTVVbHREK2hIUGRRWGh0ck5zUU5vSis1cElqdnhVM0NwNFli?=
 =?utf-8?B?cWJ0b1ZFeEU2RWMyYWI1SjJQVmJDVkVaNHhNc1RpUFl3UnI0cUduenV3c1Ru?=
 =?utf-8?B?UGRZUUNoQ3FxTTJQcjFWbmcxZ1pZTS9kZkxkemx4M3hxT2l5N1JONzlkdnYv?=
 =?utf-8?B?UWtWeTFrUlVWN2YrdDdBWTFzbDlDKytnVTQ3RGZOalBQbURkSXpnRjRhRlMz?=
 =?utf-8?B?cWFOT2ZrWHcwUjdqOXlrMFYrYnl5TEMyU3grZHNiZElEZmRkZ2NIQ1RhVUJ4?=
 =?utf-8?B?Y1JhNjVvVE9xMzIrYXhiYk93Q0U1b0RDaW5TbFNTSUVHTDZScFFqUmxDM0hZ?=
 =?utf-8?B?TFlsa0ZUZnNJSEpWMHRlN0N0VUEwbDVjcFo3ei9zdXo0aElyeXhiQWhvTUxm?=
 =?utf-8?B?d28vZGVnQlNGcjM2d1habkkxYXJOS0oxMDk4M2NoanhlMmthNUd2ZDRtMHFk?=
 =?utf-8?B?dlJ1bk5JcmhkdGRLaUJCb0Vmb2RVZUtUOCtBK1orT0dGNjZXaS8rNHQycGJ0?=
 =?utf-8?B?Q3Q3cWxyL2FMMHVxSm5JS044cmtHV29VU3dKRjBNSnV4ZkFnR0FXOVJvUlNQ?=
 =?utf-8?B?eFRmTmR5RXB6TVFLcERCMXc5TGk5RHI5amRWWGlNV3htZ3JXY0pBcVhxRk1V?=
 =?utf-8?B?N3J4ZWRDOVhiWmhQc1Z0b1ZPb25ONFpuK0lzQkgzeHVOeXZZM2twU1Q2QkV1?=
 =?utf-8?B?cDF4UVkva2traGl1WERhWmpjVmdBZHJMSFpYSkRuTk5QTlBhbjd1dXB0TzlB?=
 =?utf-8?B?aW5VYi9xWENpRVQ4Zk54QVpJMTBNYlZmUVZNZHU5QUs5UHl2TjV1WjNUemZo?=
 =?utf-8?B?N0tSTWVSRldXMHBEalZXSGlrY2o0cDdJK1FJUUVTNG9TLzF2ZytLaGFWRVJG?=
 =?utf-8?B?WlFRRU4xK0xOQWMvRDE3ZW8zQzhGMDZtcUhqUXZHQ1hSN01tLzZwengvL2xa?=
 =?utf-8?B?QkVjbkRLS0ZjSk1QQ1JuN3JydGFJNkdDdDZBN0FoakFST2MzTnJjWWRZb3RR?=
 =?utf-8?B?WHdGcTFMbkMzanRIUWtJNmphNENRZVZneUU1YmVVYjI5N0hTa3RuY2U5MHFF?=
 =?utf-8?B?UnR1ZzJvQkRjK3pVWGplZVl3Ui9NWmUvQTNPREo5NTNvcmFUeFVMMUhiQU5B?=
 =?utf-8?Q?W8zc4YaqmQGZO3lNCwxn6Z4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdfdf3c-6328-495c-ed6c-08de2d5ba13f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 02:21:11.1803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kHNwDL+37NDPpAv6gxusY5jEds+PkT14QgY7eQoI6N+LltYgToLT0f9ebKBeGszD122A/Mj5VRm7QWp/QGxLMrRhfvJDn7e80YWCWlJCf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR03MB8392
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

Hi Marek,

On 25/11/2025 8:24 pm, Marek Vasut wrote:
> [CAUTION: This email is from outside your organization. Unless you trust 
> the sender, do not click on links or open attachments as it may be a 
> fraudulent email attempting to steal your information and/or compromise 
> your computer.]
> 
> On 11/25/25 9:13 AM, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Restore legacy implementation of retrieving clkmgr base address from
>> mach-socfpga/misc.c driver for our legacy devices.
>>
>> Excluding Agilex7/7M from this implementation as these devices' clock
>> driver is already following clock driver model and is supporting
>> enable/disable APIs.
>>
>> The legacy devices' clock driver will have to be refactored to support
>> driver model which enables us to support enable/disable APIs for these
>> devices.
> Ideally fix the clock driver instead of more ifdeffery.

This is intended as a temporary fix to unblock our partners which are 
using our legacy devices as we work on refactoring our clock drivers to 
support the driver model.

Once the clock drivers for our legacy devices (Stratix10, N5X, Arria10 
and CycloneV) are ready to support the APIs, we will clean up the code.

Thanks,
Alif
