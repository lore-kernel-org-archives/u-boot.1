Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8068CED273
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A452688E36;
	Tue,  8 Oct 2024 09:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z6aKxK8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42AB988E1D; Tue,  8 Oct 2024 09:23:07 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1AC788E07;
 Tue,  8 Oct 2024 09:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GET3eTztDjflenT9Iw2H0G60wtAxasMzs10xlSaE6NdSgHN9UKiCcoHtdT8gPTfMvFNih/8bUv7MtNQG+Urv3wS98p+cPGioFqd3EEGkm+jsiqHLxJPzRzjeRKmcYuYNU3ShIPE1GdrnvZdZdfX6RUkO3zBctIaSsPdZONuOZGABHGOH3UMUH6egDNBkJk1o3VQ4IOx/QnIodlGL8K4QoKELDWEglZnrmi+oaUe1MvfKB9eRUJq34hj1b/iGdZdA3BsitVKDDcDqHCzgZrrw+ISUPyQIu3smoj7/HogeodFcHD6SDSprJZh3bbAJHuxaloMiILvHqgufZrCcU7aGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QD2PBOUqSBpN0COnZBv2icllbyA/JlW4BbSnWkYb9I=;
 b=SH0JtGIF42eFyw1BkH1m54kwBVveD5mFcKXGypf7WwTeKhSLV3WRfYUb0U4adAZr6vKp4lQYtURDDxZZV6UxCQn3vwuSs2IYt92WyjvsQtJpQWxlWms67CyQP5CG/J5o9SwFuKfq2ye0i5lFWhN32zvhtqKTmhd2b4m1WGzLvwUucFVkW68tvv/EF6X2oB/YJGyXOCijL/YcBrdO/MR7U4qEz/WC7JwSyLN1KQKUjzpPcmrcWqFfI5FdrCgw+F3dcllSYHRqkuhZ3BUsqdoD5x7qy9nqCRdzrJHIx7+RREhQtj1bSbTEtkOZcbpJzIJZTDZQ9Uh7yhLCn4OQ2c0kKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QD2PBOUqSBpN0COnZBv2icllbyA/JlW4BbSnWkYb9I=;
 b=Z6aKxK8qlOqU9vFpaNvPGYpirSf7HHlLelqFpW4O5IA86N6oJme5PAZMD/vlyFeuVQOio4AxpraARtC0zjrscLS88tWYKHYMyz5QHyJtplDJK5qfs28hF52LvGq8aAyb6Jt4+Byj59ukmHJYZD8P/icULepdeNFiIbuwTlljgL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:23:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:23:00 +0000
Message-ID: <8d4f1b21-3e5c-47a4-aed0-790db8cc6331@amd.com>
Date: Tue, 8 Oct 2024 09:22:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2024.10 released
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
References: <20241007145651.GU4737@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241007145651.GU4737@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0287.eurprd07.prod.outlook.com
 (2603:10a6:800:130::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 4848c44a-8dc3-428b-8e48-08dce76a0a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elBoKzVPMjBGQSsyMVpKTi9XVjdMV1l0UWtxU3JqWFdoS1Q3cHNHZk9MN0RO?=
 =?utf-8?B?SldKcDNxQUtVcmpnZ0VDeGFNdjVSZzVVblNYYWhxd252a0J1YWRZMUMzVlQ2?=
 =?utf-8?B?UDViMjhkY0p3NVNEVjBuVCtiT1l6V0xJdUVVYTIwZWlHR2I3NjNtNklSMnBQ?=
 =?utf-8?B?NFQrd1V5VzFSMjRKbFVDNVQ0WUpSV2xFUDRtcVQ3amVlTy9ZdWQwdndhQWh1?=
 =?utf-8?B?YVdCNUNyWXdSSzcxVXIxOWIxUmNFZlVpOXJ4VUR0WklDNFVSR3hJYkhCdzRG?=
 =?utf-8?B?NFhZNE5SU1gyS1VDZnJoVVlvaW45NDVHQ1o5cHdpbjJFRXRuSWxaRUxaNXFI?=
 =?utf-8?B?VGd5enpHMlBlV3hPci9hVTYzQm14T3hoYjVRa3huZUJ1TzFnSFhtaFBQbnRn?=
 =?utf-8?B?RDN5SkpVN3V5a2krR3dzNVVVZ3ZqQm5zNzFBTlJXZTFpZENwRlNMVVNleGJr?=
 =?utf-8?B?OXE1eXB1cGZtVDJNUHpxa2M1SVhmSm11OU5MckdRZUxsOEdHelBnYkwyR0to?=
 =?utf-8?B?UmNwcjdpQkwxWmVUdGZoSW45TWtLTzJXM01WeU4veVREQUhsWkE1SkFZbmZa?=
 =?utf-8?B?VWxab0xmNHpPenp4d0VwNUZoTUZHb1pZZHh6SW9nbXJVN08yRjJnQ0Raam5C?=
 =?utf-8?B?MUVSN2JWaENSYTh0eVBOdmg3T1hkYU9GdjRYcE9lTEpHdmlKblQrQk5EaDlu?=
 =?utf-8?B?WjFFZ3B3NkR3Um5sZ1pka0d4TmFIVENWL1Zyb2FEemdHc3M2S0ZiMjlYOSs2?=
 =?utf-8?B?UE5Tb3NoY0M0NVlHdDhGOU90eVRUMTlqTzB3aWVLRHA3UDZLVmIxK3ZaS0sr?=
 =?utf-8?B?V29LNGc2ODNrRXhuRWVtcHhRZmk2aUtJNTVsZnJxN0hOS1kzQUgyUXRmeFBF?=
 =?utf-8?B?cCtRczFBeU5uM2pDcGFVRE5ha3lHVXN6ZTQ5SE12d3BqaXp6a2NPb3Vydzkz?=
 =?utf-8?B?RExEL3JWdDNWcFgzUDNoc1l6amx6RW9nYXlrTkF6SFgwQ3pMUHhJQm1MbEIv?=
 =?utf-8?B?L0FIdWQyWEFIbmJHUi9lZXlpVVV5NE5jRGhwZC9CTTEzOWlOZGNnMG5nLzRE?=
 =?utf-8?B?MWdNYzJ5c0lKc3QvVUpTWlRqUkhEWGowcTNRSHhuSDJxZTVyUlU1cE9DaW1G?=
 =?utf-8?B?Nmh1b1hGYW96d0FNa0ZEc0ovMWhnc1BKcDk3QnByYWpwSGtZQ3JnSnJuK0JG?=
 =?utf-8?B?Z0M0bnQ3YXZuOVYzOHhLd1BoME9jOVlxUG8rZWgyNmFrSDcwUjJOOUZ6V2c2?=
 =?utf-8?B?QlBlUjNJejcxVkNMdno1bUtwcUtFdmlXQ3FvQnIrZ2ZzY3JWMytkcncxYUpI?=
 =?utf-8?B?UmU1a2VMQm9lOFI0UzhwVEpMMDZ4QkE2VHg1RTNYQVNKWlRpY0d6bzZvY0Jh?=
 =?utf-8?B?a0VqNWE1a2svL3EvVzgrby9VdFVwTHNGVFhod2hoTS93d3pXakZidVBHeUVt?=
 =?utf-8?B?dGJ1aGt2cEJndWJGSEt1ckhpd3R5eUlJakxQQzNLN3hjaUpxSUhXVHgya1Ni?=
 =?utf-8?B?azQ5V2ZTRHQvYko2ZnFSOWVzK0tPb1Znb2lhV2xHS0xzclF0RTNUMDZjb1Q5?=
 =?utf-8?B?Z2dVUmdZd0FFeHlBU1dNRGtyTHZzQXo4QWpmeHByM05lVzRKekEwdzJQQWVs?=
 =?utf-8?B?ZldUbHhjN0tyUm5WY1Y5elRiUkRWVXMvZm9yamdZMUxqaGI2RVNpaVFtcVA4?=
 =?utf-8?B?MU9qbktBVFpyWWs0clJWbG9WV0YycmIyT1cvMHRHUGpJeFV6ditrRDdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFqczJjL1prZUNFVEpKdG91akRJeEd5U0kwaVNMcXMxTGFZb0MrTFU1RGxL?=
 =?utf-8?B?dWJYSjZ1eGsvYmJMYnpuK3lyRzE1NkpNenhIaDBLci90dUFJZGROMm56Zng3?=
 =?utf-8?B?OGxkbFVUY1hIRGlkclhxTUxDZnh0OTVTNUF3anVJTk5rWDZiU1hOWllSamlO?=
 =?utf-8?B?S2lrRWVoQmJDTUp6YWxGT05GMnJFZjR6dDBBWWhsMk9ZaXZGQUdOd2lPNUVO?=
 =?utf-8?B?ZWdhN3JlR3YyWVhkTTJOTEFKSTh5Tllnanhzd3VFdzh4SFo1M3NNdEFSUlhr?=
 =?utf-8?B?L21VVWg3UnFpR3NJVXh1bHJlUnRrdVBTTzVkUFBHalVvMVJhK0lKNVJEcWFC?=
 =?utf-8?B?UmUyWnJ6QXRiK2pQaS9BZFhacVI4TWpmVXhyc2R0YXNNSStHcXJablRVZGh1?=
 =?utf-8?B?QUprdnNFRFd6TkFyMlF2NzdZc2ZmNmtrYkcrbzhFTU43d0tIcmprcVAyWnJQ?=
 =?utf-8?B?dlBlWXNyYnUxSWdjVW9XVjU2MzZ5TnJrT0lWNmlJa0ZBeU9ub3hWVHpPZGxU?=
 =?utf-8?B?Q0FHclNabzE0VDVCY0srMmoxb2I0UHNLVTRyYWgxV2l0SU90Y0NPa094WDV0?=
 =?utf-8?B?aFI2L0Z1YVNyK05MZUY2ZGZQd0RqNTY0eU1OWWlObW1CMXYwQ1h6ZXFpbGFZ?=
 =?utf-8?B?K1pnNG1sbFN4WmZRQlZjcjJNZzFKOUJ1c3RwNmdpaXBjS0l1ODNUTlVCOWxt?=
 =?utf-8?B?QUhYNDdXR3IwclFSbXhVdHVOWXExWStqL1hVTk50Rjkxak5CdUlHTUdaUDdi?=
 =?utf-8?B?Qk1iek1qODd4ZGpFYjdEL3pobW80S3UwR1VlOGh4NDNlK08vM2VSMzhjOXpE?=
 =?utf-8?B?UWQ5SDZEMEg5Wk9HeHdLeG1tSE85c1M2T0FKNnBpR0lTMlFGVVRoL0NMU2My?=
 =?utf-8?B?YTUzVkFrSXNHL0hPZFhoSGplQ3Zkd2pNbTI5MzA0RnRaaktUc2FNZWZKRmFi?=
 =?utf-8?B?Mm82QlVkd2Myc1ZUb1RGNklTZ3M0eTk4ZEI1L3ExVThja1pWVU1uTzB2cEk3?=
 =?utf-8?B?MEVUek5adEFNNi9vZzhidHJGQmJVT1N5WFBJM1dDNVhtY3gxcEFIWEczTHBR?=
 =?utf-8?B?RThTd1MrNmhEeWppckkwOUQ1ZjZMeVZmd3hBNDNicVgvblN3dlZlbWNiV2c5?=
 =?utf-8?B?bmQybE16R2lsK01mSXFCSWJnRStSZ3JMUEtXbnN5aHRlN0tydE1qODFxMFFB?=
 =?utf-8?B?ZjNFcHpGeU85OWhOaDcyeTZ4NllXV2l6YUtWbnJWK21MTGZnWllKZmhleFc2?=
 =?utf-8?B?dFBtRG43QmkzWTc2YU9DbTdaZEJhS0ttbWpwUFB3MTk3RTZRdm5TeXowTzk3?=
 =?utf-8?B?Sm84TWEzVkFmUzdYOUtpeWg5RkFSUzI3MEpZTnZKTEN4YnVKbFM1N2VDcjFj?=
 =?utf-8?B?QXhaQmNaSG1NRlFtRTh4LzdJdHhRcWJMNC9MQU01Q0lNRDFxMFVwemdMMkM2?=
 =?utf-8?B?ZGVGSnJxVm9tYm5haCtsTmtxTGRRMjVaRUt3M1NuK01IUUViVnRTYnptclk4?=
 =?utf-8?B?bUxabUpSUktjMlo3SjNlVFFiQ0ZtUkRjQURTWkFiWkQxWUZMS0kybFpud3Br?=
 =?utf-8?B?OExjUnBmNnV2RDhSODJXZVA2ckxzWHVaUVloeml5b0wwYmszd2dlSnc4eU1Z?=
 =?utf-8?B?MElqYyttRnFYaURoU0FJb1hOZzd2TVZDWVJTQTBjMFZFTmF2QWM3UWlXRnNn?=
 =?utf-8?B?bWNoYTdpNzVTWjVQRXJueWJxalBlU1JCcUdhRE5aTTkzU29WQk9KdUtRZ1hl?=
 =?utf-8?B?UTdJQ1FRR2ROalN6aUMvRFQ0VTdKYmdxa2ExWFJkUnJHQWZrVG90ZW5NM29O?=
 =?utf-8?B?b21rOU9Fa2RQODl0ZUxNbm1CR0ZWSmU4K003QkZ5UStUYUR0d2FoNFpUU3F6?=
 =?utf-8?B?a0J4VjBQNW9mMXdEb2dmd1luYXoyMmJQaHlLUG1td1F1UjNjTmg2ck1vMlB1?=
 =?utf-8?B?UkllNzJxM013UmljRlV6Q05mWGFNUkRSWEJlUmJlejYwRnZsQVB1OG9pbzdU?=
 =?utf-8?B?WjNITXZxdklFTkEzN0U4emJDdnBEejlGeUNVTmVWWG4wU2VsbmZ3ZFFhM2VB?=
 =?utf-8?B?eHp2ZzVMeWhndFBTZ3JZK1Q3SVRxNHRMRFFvQ25wVzQxNUNkYnlRVGRwSHdM?=
 =?utf-8?Q?SBnGIyJVFK/bkAMnN252hpUbg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4848c44a-8dc3-428b-8e48-08dce76a0a1e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:23:00.4789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AV93pclj7aJGcMeiwYDqU2u+6ldePMZFncbbwExKtn06V740NC2QPurelTKUv5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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

Hi Tom,

On 10/7/24 16:56, Tom Rini wrote:
> Hey all,
> 
> It's release day and so here is v2024.07. We had a few last minute bug
> fixes come in, and while I'd prefer they come in earlier in the release
> cycle, I'm still happier people are testing before the release comes out
> instead of after the release is out. I want to thank everyone that's
> contributed to this release, not just in terms of code, but
> documentation, testing and otherwise ensuring things go as smoothly as
> they can.
> 
> In terms of a changelog,
> git log --merges v2024.10-rc6..v2024.10
> contains what I've pulled since the last RC or:
> git log --merges v2024.07..v2024.10
> for changes since the last full release. As always, more details in
> pull requests (or the tags referenced by them) will result in more
> details here.
> 
> The merge window is formally open again, and I'll be merging in next
> shortly. v2025.01 is scheduled for Monday, January 6th, 2025 and the
> merge window will close and -rc1 will be released on the 28nd of
> October, and then the next window will open with -rc2, two weeks later.
> I'm also trying something slightly different this release and I've put
> -rc6 in for Monday, December 30th to have one more tag over the end of
> year holidays, to see if that helps with people finding time to test.
> We'll how that went in January.

Great. Can you please also sync up defconfigs after next merge?

Thanks,
Michal
