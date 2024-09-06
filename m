Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF533CE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 06:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D95B88CF2;
	Fri,  6 Sep 2024 08:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H5dIXuSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 782ED88CFD; Fri,  6 Sep 2024 08:52:59 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BBB885A5
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 08:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTyxEBeI4w/aNYdXdoAONAf3GYksb6QUH9vGA4a3VFxU8mQQVTBr0+5CcThkaAwQaqj3SPE4hMhPwtZgNc7j0mWH2UgJW6rXzSjkBtkMHgdxM2VtvFd8PyHkrsYEbVQ0NrBz+M/zHt3J5IWzqbTJhvBQxZX7m7JP0SO0NWlz+n/H/Mf64OiNN9sXCJ3/V9IHSrL+vriLdIQb+fhn5bBhvvYhqZ0NPr8pXGTdLaKU7I4+LbvRCND7aH8PGZcFuuVg70fn2+rlJNGFEQsnju14jdtgApEA/bjzzmdyvC1F52boL++p9QmM0ni1H/eDwgPDefeKzelI4Dmw2KLECRXZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56nVRlzt4lEVXx8rAwjuBHCY7wRw1kERoeEoN8TuA34=;
 b=U2JF0oqWcVEgc9+PFm4Y+/9kQTAxhvTGv9bvLikrH/92x3jsrvf3mCNQcFezPC9YCjXy4QkF9X0V7rHgLKttFiNv0+nJjIEEsrNd1qUMXZ5WV65ZTMZqMZKUZ6IsmsoKiJc1/NBLZWKxYFplaVEE5m2T/Gc6u6VVPxRS2OZof8fTvFoweDLIMrW31HxqWBkwdgI+zzLBMmlZkuvQvmLcIBDQ6Erd9JHnqwpYIBiBRRC/dzKT6q78hjoV8SCkSYpuixdkEJF5WLuErf3oOgpalp6ukZYe03h5qk0lfmUXDdT6rDSF2SFmHnx0iFk2ce3eA9T59+QIOoKkrX15rnjCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56nVRlzt4lEVXx8rAwjuBHCY7wRw1kERoeEoN8TuA34=;
 b=H5dIXuSUM8S+i5qwxHHdeWke5pd6szqWRobLbP/WvrKPRbjRPVW+czNfz6z7060gKMyyO7xHSJsKkGarutkqU3kXquyOo8D3tC5mtswBXowAwmifDirnS7dS6/7kp1r71eYATrXPXA9TlAsQAjaihGiT95yQXC73OCOzDQxAktg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 06:52:53 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:52:53 +0000
Message-ID: <e66cde3f-1fb6-4b6a-8e27-a650ee2744ba@amd.com>
Date: Fri, 6 Sep 2024 08:52:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add u-boot command to boot into recovery
 image
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
References: <20240827115529.2931334-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240827115529.2931334-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: f587279b-7a18-4d85-905e-08dcce4087df
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnQ3MEZGNFdKTFhNeSs3QUJwT0hzU3ZyMEJOWFdkVGhEbmVyNGhmdldIY0hr?=
 =?utf-8?B?Sk9NOThMWGlCanFRRTliMUZZVEFlZTdsYUdhcWZETHQ2bUNOWDdIVWQvVnN2?=
 =?utf-8?B?dXBpdTRnY1BqQ21CcnVNTFltNk9PVFZzMk1JQ0ZKM3FUTFBPdzdIMUdwK3o3?=
 =?utf-8?B?MEN6V2NTSldxRlAxTndQanQ5ZTFWRXA0c1BsT2hQNllBd1JpekdodDhGYmVx?=
 =?utf-8?B?WE55clc5NTBWbVJtZzZFa1AwcWVBcjdDTHpDYWZIa2NyNkpHMFRDcHNnSURR?=
 =?utf-8?B?djd2Q256am5UaW84L01aUjlSMW5vZiszejYxQmwvRSs5clV2S0x2aVI3cjMx?=
 =?utf-8?B?ekJpOXFvdHBqbVEwU3YwSlpyd29UbkVRcEh0Q2lISjVSRmhyMXBoVGNIZzVX?=
 =?utf-8?B?Umg2dTFKYnZwTjNBbDlHOVNKM0ZKQ2lrcVpCNGRXVXQ2VUFHdk50SzBhMDFN?=
 =?utf-8?B?anZ3Rm9OWDltckR4dlUyTnRyNExhTkxhOGo4M1BuQUxWM2xkRVBRU2t0T2tV?=
 =?utf-8?B?QXZQYkRWUU9jblNyTGtkTUx1SjNpQnZWZnZielJZeG40anIxTnEyTkVEcm1v?=
 =?utf-8?B?L3RkRlRPeGxBRmlaWGNUOFViNGFSalRsMTFzcjhTQnYvSVFvUmwyNTZjRkRK?=
 =?utf-8?B?YjQrUHMwblhkSFJWOG1jUTlQVnI1OEZMMFBienR6RzNWS05OeVV3SEhwUzZP?=
 =?utf-8?B?c0VzUytkcDRtNkZYZE5KT1Y2Q1BHLzZoZTVrTDF1WTBiQStmSlQxRVBkejQ3?=
 =?utf-8?B?ZEhQdWFWc1lTSjliOGhRbHZHSmhpaHBucGRnOGhCYk90MHpmd2dmNDJHbnBS?=
 =?utf-8?B?SVFVa3psc0pNd0J5OUM1b2NjRWdZMzVuT1I3KzVESkZaUURhT0lQR1VRT1Jy?=
 =?utf-8?B?OXlmanNMa1pMdUhSN1ZMZmM5ZXM1WHYrQi9SRkhVUjV3RHYydEp2NkQyQXZt?=
 =?utf-8?B?bTZQdXY2bWFvL3JsVWttc2oxODUrRXR2Vm40Ry9TODBkKzJXMlpybytZL3hH?=
 =?utf-8?B?ckpLREkyNkR1Y3QzQnUveUVlcllKaWF6bWJYRVZaZy9aS2J6V1JDVkRrd24v?=
 =?utf-8?B?WUlqUUp2VzN6WlMxTXpqT1ByOFkyei9CL1JzblphREFWT0ZUV0NxZmlReWVJ?=
 =?utf-8?B?a2k3T2dmY3FEUEg3Q3dKTm13ZDBYNGdtWmdud3hSTDI5NUtSV01wRUh3Nys4?=
 =?utf-8?B?bm54MVNYZmtBalRmcEFKeE5YNFdUbERDL0taRUFoWjF5ZDlKc1RBZ0VTcFVk?=
 =?utf-8?B?dHhnYzZPaXRnOUtiMW13U0VJWWVJcFRyVjhKMXpxNklnN3hEQ2o3Q1d0bTh3?=
 =?utf-8?B?SmduU1ByTGhaTEp4a2NzRkd5QVBZZEFHeGZDRGlmaE5ZVWMvQzRQY203SVlw?=
 =?utf-8?B?ckxDWitPalVMR0pHRjJGMm11bllaR2ZncGNoU1puWG00QkY0b3lsZElQeWRF?=
 =?utf-8?B?RzFhdm1Ba0VmN0Y1TVRxWW9BQzB4K0VPbFNsc0FqSUhnVVI1SGRQemJHT3dw?=
 =?utf-8?B?ZlZNUWwrWnNGZzFCSTYxVXM5ZTdIVStnajZuNmRpWUJlNjQwWXZQK09XcUxY?=
 =?utf-8?B?RkVaMVVJZVN0dXYwVVVjZlJrWkIxZGpoaDRSZ0pXdE83M2E1NXJsb2twbFJu?=
 =?utf-8?B?ZTljdXg0dVFxWjNJTW1OS0swUG5tcmdIbFZ3N1NLTVlKUFJDYXRtekxGOW5D?=
 =?utf-8?B?cU81eVVVTG1UdXVjTmY1UHQzWVJzMlRCdzQrMFEzNGhGOHNjaExIKzN1Rk1N?=
 =?utf-8?B?Kzlla1hxT1lEb3BTdXpFWTJPUnd5a3pQN2t1TTd2UTJWMmdKWWd1RkxhYkt6?=
 =?utf-8?B?ZFh2VHVwanNRS2kwSVk2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elRmeC84WlBWSkMxQkpkemh3ZDlncTdycTlubWNUYzRyL3lobXk4YlNybFAw?=
 =?utf-8?B?Nll0dUZ3OU5VaXpwcVRRN0swQVc3cnRnd2c0MmtWcEpvUkJmdmNuMUxVWnQ2?=
 =?utf-8?B?VkxodzhHR2Z2UnFCZGI4ZVFoQVo3S1pkZ0xmM0ZuV3Z4ZGVZVHVqc0dIamhB?=
 =?utf-8?B?SytWaFR4NFQwK2dXUExzUU1HMTlWK1IwL2FDR2RKMEdQZ2ZUS2NzbWF3Unhv?=
 =?utf-8?B?TnZ3ZkR6VkRvUmdwRTY1bnFzZ0JEdkd1dTA5a09hei81SnE5b0NoY0V1cDlm?=
 =?utf-8?B?UzdYa3dtU3BiODNZdG5DamxmSFpiMHBaY3BSQVlONGtmT2V6ZTVSU3ZZZHls?=
 =?utf-8?B?S2VBMEVRU2N1TW1HVzdVa0hJWjBMU1d5SjUzOWRIMDd3RCsraks1cGFZNVNo?=
 =?utf-8?B?NHlTbEZsaTd3N0xQbVU2NWYxUFFmU1VhY08vQlo1WlN6bzZSU243aG83Ukcw?=
 =?utf-8?B?Z3ZObHFPWlZ1UVh1TUhRd2hDVmdZOTkxRnNNanJBdDhkcDN5T005WlpWeXN4?=
 =?utf-8?B?ZnFHZFhDQnpkVlpSdmFDZmhJSHFRWTdUOWR0MWpYUkJ3MjVtMk1hQVlrbWxq?=
 =?utf-8?B?dlJwUWcxVHVrQmlkY29CUUN1RnhlSTN2Z1Z4VUwrcDZROE9lTGVRSEtEK1RP?=
 =?utf-8?B?c2NGU1JKUjJXYjA2Z2M1c3RwQ0Ryemx2cTA0VmxMKzZPUzhkWkVCa3hzbE5D?=
 =?utf-8?B?Y05XeUpoNUNNT05VV0t4QVRHOHFjY1dWQzl3OE1OTnRNY244MUJvd2ZmWEtt?=
 =?utf-8?B?NTRBZTRDZDhQTmNoYkJFNTBUcHl3QmpZYzBtelRwV3VyNHZ1SUJ2M0FGWGRB?=
 =?utf-8?B?ZWJ0TVVNWVRRR3luN0kvckZHOVdRdWRia092QllTcm5ZM3hlNUdnN2N1dUtT?=
 =?utf-8?B?M1VOV1hJRDFRM0svWEdJSWNtR1R6SVBNSFYxVTVkMzhMeDlpRVNvRDRvTEY0?=
 =?utf-8?B?WWZ5K0paZm1HWnNUUXQ1b005K1FrODNNbzJZUDBibnpUdWl2WGpIYjRwbldT?=
 =?utf-8?B?citURUJwN2J5K2hLUEFLTm10M1B1R1J6R3BzaWVqNXhkdmZVTmZIZkl0MmIw?=
 =?utf-8?B?L3N1RW4wMDRjWDJKWHpKVFk2aFgrV2dJY1g0azFUajZUN21zL25EbG50R3JW?=
 =?utf-8?B?L0dBcW9HWmtkWW1TTjNqTTltNjNYVFE2cHVHandwTDRFcXdSMUJYTlNWT0Nu?=
 =?utf-8?B?cmQvVGdiM2FEVG9pT09wMHpBRk1QWmtpWE1qWDBmOTdxVlpobVcvOTZlc1o5?=
 =?utf-8?B?eUw3MHNkbjloc25EZjZqWWhYRm9IYXdjTjEwU1hDUS8xQkJIYXc5blBTRmNJ?=
 =?utf-8?B?MzdHSXQ5Unk4ZnE4VHlhZkMyOXgwZ21Gc0w5TjJ1bGw0d0puMnVyWkVWN3pE?=
 =?utf-8?B?SzdhQXFEclczZkJlVUVkMmprTkpYZlBZTlB2OFZ6cEpCZDFqUU5FVFJzaEtF?=
 =?utf-8?B?UHFYMmVrQmVxRER4Wks1VjhvNlBYOFMxd0d2OFduaGhZL1ZkaWhoU0lBOWhX?=
 =?utf-8?B?Q0pQSjgzd0pRWG1zZG5zTVVTbGVTaTIzNnFhb1UwakVHZ255NS95S0FnQ0FG?=
 =?utf-8?B?QWMrUWhGQW83bHYycDFYTlVSSDBoT3dxcUFJcnlxMlFCaVdnemJvbVhXWEc2?=
 =?utf-8?B?UUIxbGV0NDZpd253bWVBUjE2TzhKaVp4dXlFbmlKUnJreUMvN2NaUGtPeENW?=
 =?utf-8?B?SjN0NkZPUk5mQ3lqQ3M4K2dHRlN1bHdWYndKcTJ0d3hwZHZERnh0UHVJeENV?=
 =?utf-8?B?Zlk2MEROK1F5YjlmZXpFbHpNeUNRODBmc0ZEb3ZJWWV6azNYa21iVjVYbVV3?=
 =?utf-8?B?Sk5JblczV3kxYW5UTlJIWGFDU0ltbXY1Y2twYkVSUTliMC9qSHNZTWtJUnI4?=
 =?utf-8?B?Tngrem1KN0l1OVNGTjYzaC95aGFkSGEvRkpiNkhyQXgyREpOOUkreWIvRno3?=
 =?utf-8?B?SnBzTS9TbFhqY0lGUzQ5cDYzcEFNYUI2YVdOSFZhNWtJZW8yTU12dnpmb0dm?=
 =?utf-8?B?bEM0bTZjZDBkaXpMTm5OQTVBRk9ZVloyeVR3KzZidGpJcEdrTjVRcmdNckN3?=
 =?utf-8?B?Q0NJaDJGd0ViMzZpOVp1N3l1d0VrYVdYazNKeFgyZnBFYVZZSmJwWC94dnRM?=
 =?utf-8?Q?BHxzXz0idi0bVN6gfI8hPBhzW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f587279b-7a18-4d85-905e-08dcce4087df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 06:52:53.3218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dbz3PdmKD6NAJ3qy5i41sWvS9uzn8Znj9ojddKJP5qAwa/sFYBt8HP/x8D76fG3J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
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



On 8/27/24 13:55, Prasad Kummari wrote:
> To boot into the firmware recovery tool, the user currently
> needs to press a button on the board while powering the
> system up. To simplify this process, a U-Boot command
> was added to allow booting directly into the recovery tool.
> 
> For example:
> ZynqMP> zynqmp reboot <multiboot offset in hex>
> 
> Co-develop-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Co-develop-by: Prasad Kummari <prasad.kummari@amd.com>
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
>   arch/arm/mach-zynqmp/include/mach/hardware.h |  6 ++++-
>   arch/arm/mach-zynqmp/zynqmp.c                | 26 ++++++++++++++++++++
>   2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
> index 8cb6494e52..9228fa3c80 100644
> --- a/arch/arm/mach-zynqmp/include/mach/hardware.h
> +++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
> @@ -42,6 +42,8 @@
>   #define CRLAPB_DBG_LPD_CTRL_SETUP_CLK	0x01002002
>   #define CRLAPB_RST_LPD_DBG_RESET	0
>   
> +#define CRL_APB_SOFT_RESET_CTRL_MASK	0x10
> +
>   struct crlapb_regs {
>   	u32 reserved0[36];
>   	u32 cpu_r5_ctrl; /* 0x90 */
> @@ -51,7 +53,9 @@ struct crlapb_regs {
>   	u32 timestamp_ref_ctrl; /* 0x128 */
>   	u32 reserved3[53];
>   	u32 boot_mode; /* 0x200 */
> -	u32 reserved4_0[7];
> +	u32 reserved4_0[5];
> +	u32 soft_reset; /* 0x218 */
> +	u32 reserved4_10;
>   	u32 reset_reason; /* 0x220 */
>   	u32 reserved4_1[6];
>   	u32 rst_lpd_top; /* 0x23C */
> diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
> index bf39c5472e..3b4d9c60e5 100644
> --- a/arch/arm/mach-zynqmp/zynqmp.c
> +++ b/arch/arm/mach-zynqmp/zynqmp.c
> @@ -340,6 +340,30 @@ static int do_zynqmp_sha3(struct cmd_tbl *cmdtp, int flag,
>   	return CMD_RET_SUCCESS;
>   }
>   
> +static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
> +			    int argc, char * const argv[])
> +{
> +	u32 multiboot;
> +	int ret;
> +
> +	if (argc != cmdtp->maxargs)
> +		return CMD_RET_USAGE;
> +
> +	multiboot = hextoul(argv[2], NULL);
> +
> +	ret = zynqmp_mmio_write(0xFFCA0010, 0xfff, multiboot);
> +	if (ret != 0) {
> +		printf("Failed: mmio write\n");
> +		return ret;
> +	}
> +
> +	/* issue soft reset */
> +	writel(CRL_APB_SOFT_RESET_CTRL_MASK, &crlapb_base->soft_reset);
> +
> +	/* never get here */
> +	return CMD_RET_SUCCESS;
> +}
> +
>   static struct cmd_tbl cmd_zynqmp_sub[] = {
>   	U_BOOT_CMD_MKENT(secure, 5, 0, do_zynqmp_verify_secure, "", ""),
>   	U_BOOT_CMD_MKENT(pmufw, 4, 0, do_zynqmp_pmufw, "", ""),
> @@ -348,6 +372,7 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
>   	U_BOOT_CMD_MKENT(aes, 9, 0, do_zynqmp_aes, "", ""),
>   	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
>   	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
> +	U_BOOT_CMD_MKENT(reboot, 3, 0, do_zynqmp_reboot, "", ""),
>   #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
>   	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
>   #endif
> @@ -387,6 +412,7 @@ U_BOOT_LONGHELP(zynqmp,
>   	"                            long at address $src. Optional key_addr\n"
>   	"                            can be specified if user key needs to\n"
>   	"                            be used for decryption\n"
> +	"zynqmp reboot multiboot - soft reboot to multiboot offset\n"
>   	"zynqmp mmio_read address - read from address\n"
>   	"zynqmp mmio_write address mask value - write value after masking to\n"
>   	"					address\n"

Applied.
M
