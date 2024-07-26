Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CFBC3DA63
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 08:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5383788361;
	Fri, 26 Jul 2024 10:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IoiFY9Dv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 551418853E; Fri, 26 Jul 2024 10:12:07 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F00E87CF8
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGk2k6uHHAs+QruqsQZKbSZKQX59eEgZY2CXcbjt5/C23TMtIW/5slb37Tp6WtzXhkWyNYZY/Ud2TSGpAGMSd/aOF4GuLF90c1BE5P1Jl72yTYZsz949Oj5s1PqintyoJn4RUZOipy4/CZ6kY5TnRyX5MeXE/hyOAn4olLnkGbDYsBQGtHxTYY5Yn6RWu61mcHKCEpTL6uwpIqJ3OE7B9qjc5zO4Xi1qFEzAgtCsncWItvUEvuPP++bzQBlmKjQpG923GnCeq/3h5HuXojMEK8HVvfpF3xlNnPkEn1hOFkrSaMqKtSO8/4aD+C5sQZh9LaZ09X0OO7xp3w833ZBluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Kxkbhl78z65ZQbKRRRbxjselKzpwUpmzHmQRAC34tQ=;
 b=HpcIFiGgQTJwdxYOuVEcd4vfnjTrHjCFUvYwLHXkHDcmoiLHgmOVGJ+PWQJ4xGg2QJey4A8gnPvUWH+YawghPmXlkV2DY8z2d11bRfAueArRGgVhD7pT8n0fj3UmWiuuyP3xb/chKPNFWNb9uPaHT7u4anwkzg53BJZtebeluILshcC8mS41Zb7LL1pgt1b9g0QQ0dGRRPHn/c5EpWIdZ4/mjmA2EGGCbzpxVrpFEMmJ3MEL/ldBkjNiipJPi1kqCjWwBAAmVgB0DQ0DGDt70fSV83711qFP6PaB7V5zpQlbfhgakdDrB8DtoNM3aFEqQ7Vrp3dKkymkDI7ZFhv1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Kxkbhl78z65ZQbKRRRbxjselKzpwUpmzHmQRAC34tQ=;
 b=IoiFY9Dv/iL73khxwNrRXPqVmG8HsZIYmvEpITeSOIk1RDtzbUSmaC4O8e4xlLLlIgkSOZT1TfXtCmbB42mSc/aZkdJ476wiYEFqrKusrC8DG4O0DbhqP4pJKjbIOBlCix/5UTbKrkSC4zmGlWRVJr9sVIYRDarVPpA1FJ02vhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 26 Jul
 2024 08:12:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 08:12:01 +0000
Message-ID: <b92cf69a-d8b5-43e0-b145-e5a87b55357e@amd.com>
Date: Fri, 26 Jul 2024 10:11:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: dts: Add rts delay property for rs485 mode
 on KD240
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Harini Katakam <harini.katakam@amd.com>, Neal Frager <neal.frager@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <0e0c4c067236e11f661c1d067017e1ca975c9ddb.1721297721.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <0e0c4c067236e11f661c1d067017e1ca975c9ddb.1721297721.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:802:16::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: a72c0d5c-6888-42e2-18f0-08dcad4aa05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWt6dC9jazlLSHZnMjlMLzdabEM4TE55S3NxMkd3SlNONEFNeG1OaExVN0RS?=
 =?utf-8?B?Qk1Cckc4VzNobTl0dlUwbjd5R3V5SjBkN3FJcGZOTDd0RGNqNTgwaDlvZVM3?=
 =?utf-8?B?Qys1UWYxYjNDdkNnOHd0WlA1U0hzTmhUOE14OTBSamNZV3k2dTU1b29EWmEx?=
 =?utf-8?B?eFQxUkNzZTlSWnlPMy9EZklUa3Q3TmIrb3JFTjZuNU1WRCtjU3RrNmhTNjVZ?=
 =?utf-8?B?eEtlcUJXdGlOb3hoK1ByKzljd1djRUVGNUd3MGxXVVd4ZHFyL3hKYWJnTHVm?=
 =?utf-8?B?MmNxOVlyWTJVVndORkVmRmtCZGNEWUt0WkVITHZtdUFFbS9pQmFLamIxSTkx?=
 =?utf-8?B?OFZqZ25CcXlNdkFqOUZqTjVFSGxqK2xidXN1Z2VYTGZLU1dHNUVsbk9Hekx0?=
 =?utf-8?B?TzBpaDdteTVJaTN2RVJ2ays0a0ZFa294YTFiendvMGlKajd3OFRWTXZtcDRM?=
 =?utf-8?B?Q1M1L3Z4amVDYnR2Q3crUkdnTHptcm1ZT1RGVzlJL3I4bHUxcHVkNUp3Z1g3?=
 =?utf-8?B?MmJoSmhpWklwS3Fmc3FNYWRzU1cxVS9zMjFJR09qd0daRlQxQUtTeVlmeHZJ?=
 =?utf-8?B?Nyt4NjlpWTYrRkhhWGpmS0R0Ri9lc0MzQ2FDd2FwMThNWGlmM3JmdmxkS0Zy?=
 =?utf-8?B?UjdNbFdFQmZ0L0FWVWViNEV4eTZWMG4vdkFmT2o3N2VxUFVpb0tCR1pmWitZ?=
 =?utf-8?B?VklZaUcyVEVTRUtuRGwyRmNBTVp6bkdrdWVNekRJNzB3WUlZaGhzcmJPUGNT?=
 =?utf-8?B?cjFvZTlzZm80QUMwUzBjaUJZa3p6K25zQ2dWVkdhdGtVMUY2WVZjZU1Nd2dP?=
 =?utf-8?B?R3o1ZVgzc2N2L1hCb0VuemZSeVpZbmp0dWt2SlhIWWJYejNMQnVHdTNQN2tP?=
 =?utf-8?B?RFVEc21OM2dVV2t6NktxLzZPdjhMa1QwZEw0VURnNVZ2R05rdnZrM3V5WU5O?=
 =?utf-8?B?UE8wUGNZTnZTT0QwQ0NZZitGSCtjM0JpWGMrdU9yVVBIb2VLNE1KVWhwa0x3?=
 =?utf-8?B?TGlhRFNOSDdZRVQ2V01rbVZrbVQ0Sk9HTGc1bVBITno5c1NKZFBxa25OUlBi?=
 =?utf-8?B?bkNSRUJVVno2M2d6SVByUGJEYVp4NDlMOTFhL2JLZ3pheTlQelBpUmZqenE4?=
 =?utf-8?B?b0tIakIycnBIRk84L1B1RnBTa3NhOUVlbUpaV28zQitNV3J5aXRmNEFIVlN3?=
 =?utf-8?B?VVNkU09rM0VDSGRlb3RpUFE1bzhiWGs3QzNJcUUvcnVicTkrY0dFU2hxN1RX?=
 =?utf-8?B?YkdHZFRKOFpFVTQwenp4OGM2NU1WSHY2TExIQVBRSjdnTzg0dEVhWWdIbE42?=
 =?utf-8?B?MytzVDZXUTBLeGNwbktxc213Nk50TTFReXVGOTErS1NSTUpsdUhZQi8wQmhG?=
 =?utf-8?B?M296RFFtMk51ek5ZTVZ6Z0JldjVMd2gzMXFTa2dqYkNldDl5ZDdVVUNVMzU3?=
 =?utf-8?B?QnJkZjlrMWJrOE8vR2RiVEQvQmxHWkYzTTBDd0NmczMwYVVIR3VVcWFYdWx5?=
 =?utf-8?B?U0ZndVdCQ2FOWllKN1EwdlFmV1pTSUVQeXdtaWFyRkFMV0hRYnoxVC9jMVBt?=
 =?utf-8?B?bXZoK2lqMWdIMjJxWWg5UUJVdTA3WWdYZWZQV1FKZ2l2TW9PQk5rR2c4aFll?=
 =?utf-8?B?OWdoYjlldDRpWmdnaG9mTkZoV1FuVnJzN0VjTldOdHBzSHFKb2VRN0JxandC?=
 =?utf-8?B?bUJ0alVsamVDLzcyVzA1VnhLUXBJK3hPaTFBWkNBbUZvbXBFVU96T1NqN1I0?=
 =?utf-8?B?Rk5HK2U1NmZnVEl5V2lBMVNVa3FnRTBOaloyY0puMDcrYnBtT0ZQZmhWSXlB?=
 =?utf-8?B?cEJmdTBrSitnYWI3MUd0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWFYY1BYNHJzQmM4bVExRUFSdzkvZVZUSkEzR01KTXNhTHRINU0vWE5pTWdQ?=
 =?utf-8?B?WGFGc1NteVh6eWdUektDcWdnMURidDgxUVdzcTdRd1B0bjNBR29BMm5reHRZ?=
 =?utf-8?B?cnNSWk1yMEJ3WXI1aVBNMXBYMjMwaTJ4SXFqcUJYSFNFUWZwMk5rSk9DRGcx?=
 =?utf-8?B?dkkvSCtJWWloRDVaaXN0MjJjQnpHdDhkaEExVmNmRUlxQ0tWc2RuNWNRSXJE?=
 =?utf-8?B?bHNpa1pEajVOamZpa3FqWHJDc29PRmhWVG90NTl2VlFsd3FTQ1o2eUIxcWdo?=
 =?utf-8?B?YzdpU2pyRjJRK1JXSWlRam1HMm5zTzhCUUhldWZmU2w5QXppTjRTbHh4QUVM?=
 =?utf-8?B?UE9HeEkraWhaSmFZRm9qQXdxSUNaWlNvT3JpT0xCdkhJZjN4NjYzYUtTWEM2?=
 =?utf-8?B?aHBDbU4xdFNFSlpEaEtDUXU5eVNnV2p4OTZ5RzBRbkVDYkRCOC9kMXZGUlYz?=
 =?utf-8?B?SEpKRHFKTnNvK1NmYTZ6R2hESnQ2MHVQZ3FEanZnYXNCOXF5VW91NHBVUkUx?=
 =?utf-8?B?MVdoQk5wYVFjV2Jyd1kxaHlEcmlXSXVjV2FhQjk3UW9mL0JPbUE0Tkc5SHlu?=
 =?utf-8?B?QWdqWU9RMVhYN0hvQnNjSHNTOVhRTlBiWTR4bmtkbW14N0xJM3N0ek54eVIx?=
 =?utf-8?B?ZmZma2Q5YUp3SGhWckJwU1FLVUtzOXJ5cjhUTU4zNnY5RVByWndWNXpPTWNN?=
 =?utf-8?B?ZnFadHNvNGRTTDVNMmdOd1JnVmdQVzM1eEthSVBvODF0ZG9HeHAvZVV5WFR1?=
 =?utf-8?B?M25DbEJrNTNDd0MyTmJmdmo4dW5zSkwvdTNod1NsSmdFTm5xVVQ2VE5ZaTdt?=
 =?utf-8?B?dHk2ek81a0Jyb3VSYnZaOU5hU2k5UUE4K3dlZjZlcEphOWhFcHkxRkplU24y?=
 =?utf-8?B?RnlwOWcvNTludnZNN1c0VFdnOWhuSFZNazMzTlVhWnhKYVQ2SnRvNFFxc3li?=
 =?utf-8?B?KzZRazJiTGROY0xKd0NPRG1ocERyUTZiTXNYeHpWay9rUzZjbkRlZTFXaTdo?=
 =?utf-8?B?NCsrbXpGN2FybENDYVU3STFOWmhZYU5VRDhoeFJDeGtBTFFsUXlnMVBQdlhy?=
 =?utf-8?B?Z0V0VGszY3phTHNTRmQxWGFYQ24yNHp3UlB1MVBrcmxjUDZFUTNZVm0yVEY0?=
 =?utf-8?B?ekR4cmxmeXo5Snp2by9hR3kvazRUVjBxVnBNcSszRUtXS1I0VWVMMENzSWJY?=
 =?utf-8?B?Z2NtVXBNSkRSalQrb0FFcmZNcFFJSFpMeXFGSnRGT3U2aURxS09obFc0YzdS?=
 =?utf-8?B?SHZZczdkVmNNMDBoYkxMSFhxVWI4cnlTd0VucUx6R0kzNjk1b1FmZnpHdDhu?=
 =?utf-8?B?TFhIU2kwek1nYTFnL3FldkEvdDFKQytqL1EwZTJNd1BJY2tJN1pyeFRsc3gw?=
 =?utf-8?B?ZTErSTFtNW11TmhYRlR1b2tzTU5tLzB0dlJoWG03UUpmUVBudW5GUHRVaFdQ?=
 =?utf-8?B?Q1A0aEpObWhiOWpxR01SenpaR2NkL3ZZMTduL3dzODZXQVpWdXFXZzhud1Ra?=
 =?utf-8?B?cXNqMVFHanNWb21KMmFGVmxiMXgyNjBROURqczh0UytCak9jK2grcTNnTnYz?=
 =?utf-8?B?WE13aHJJQXBObTl5T2p4cUV6ZWZxVkZFYklCc3NRWkFsSVIyL0tDd1hGckNl?=
 =?utf-8?B?Z0tPaFAwMVlEYlYzNWZBRW8rbmZrWG14dWY0ZEh1U2E4bFBRSHdaYjNqR25h?=
 =?utf-8?B?dXpJTC9RR3FWOUl3L0NoUTRndmpUcUZ3SHRnNDR6bUdrUFdyckdYTkNtNmIr?=
 =?utf-8?B?aXRqUld5ZjFpNldJN1VValdxcUNHaE1JaDBvTkkvdzVrdndtNkNURGUxNDlv?=
 =?utf-8?B?RTlYZHd0bnB0bEpnT1QzUW53SlBkM1AxaFpLNVdMZ0h5UjF1alVFQWFYNkdM?=
 =?utf-8?B?cnowdjU2b1FBT0dHVjZBdmtqZC80cTdtdllZdDdURExVanRvc1hXckMzTUlQ?=
 =?utf-8?B?NHNpKys5U3J6VEZoS3BWZjRMcFg5TnpQb0pRSDVvNGs2YkhESHVUK1NVOXha?=
 =?utf-8?B?VDV5UTFzMmJHWFpIRGZjME9pV2VwSytucGRobVI3UzBjN3RTeWZsRHpNWnh4?=
 =?utf-8?B?ZVpEcFlRNm95emt0bTFpWjA0eGs1YzAwa2ptWm90djVuM3FONy9TRkN5ajFM?=
 =?utf-8?Q?6QKqZDVH8GGyLq0vEIfvD1H2T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72c0d5c-6888-42e2-18f0-08dcad4aa05d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 08:12:01.1615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7gXARQZ8xtj6oV0pltAndzcNQeOrb6+GJ+fz65YeJIqqIiyxUxpkhPrlbsOXtT6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
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



On 7/18/24 12:15, Michal Simek wrote:
> From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> 
> Add "rs485-rts-delay" property to uartps node with delay_rts_before_send
> and delay_rts_after_send values as 10ms for rs485 mode on KD240.
> 
> 10ms rts delay values have been chosen based on testing with rs485
> temperature sensor (which is part of the kit) as safe minimum value
> for reliable operation at a baud rate of 9600.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> index 1727a1cc15c1..4de29d5d3ff6 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> @@ -358,6 +358,7 @@
>   	status = "okay";
>   	rts-gpios = <&gpio 72 GPIO_ACTIVE_HIGH>;
>   	linux,rs485-enabled-at-boot-time;
> +	rs485-rts-delay = <10 10>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_uart0_default>;
>   	assigned-clock-rates = <100000000>;

applied.
M
