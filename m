Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F43C0218F
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 07:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C703F800CF;
	Tue,  4 Feb 2025 08:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fdOp3tMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB39F80104; Tue,  4 Feb 2025 08:11:23 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB9B2800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 08:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpodStcrSBTCFb1QagtHpUQrTU1dOiXNIUx1xHIv95/fNEADk1I9lCV2ji2Bc9sg4BTzkzId6EUidKWnWUaFfmhbWqq9BMdDpBXTXiERFVrar8Yc0PdxG0zviE5XlnHyTquX0EfTOuiKUd/IUDZF4DnNWuVBRafOGVyJBT8Mh+5iJ2XGzffbIa0ZUcdmtnYexDrHstbvypXwf44BmG6+vtXfJFvdEolqStdalkjI7JiGbksnKXpisoxDSr0aeXD1T0+ll4CucdJTMzwnrnsw9m0PoBG8AUYRVOfxTCYVLCJs+1eyfYIHsLmtbJDKryZhP8EbYJsFfDJkWZfhbAIPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2NduItmQv2vyjY8EOzzi+qBHhv3zBM0Kvp3nNclJjo=;
 b=qnHApNH9bTGGBd7VDl8w0AqjGENPmr8SjzgdgJsfDWWiipHFjkXkDfausA8ZySC38sdmEDfIlHjfFPjoBkjb8OArNKQOLyosOaVxNPsk3JQepJi5Jx0T06SvsIOLayZb99AYCmdejDUWVBHC8SIyv2LyzN9uoACfL2PgkDUi9cr/wvQsE++rKPSptPzoHIkPo50jpeQXWp0UcgQbwzLSg1lgfrTnLPKd8w6S+h28oHWyXee2jHnsDfqEUbNptiuN0FnliAiN2PtWT1ZsDX3jo6/R2u9GA6QTTZG3Bvvp7IZUg9JX5XHxEfgHw8nKAfuY2B53r40Rhj468Ifi76p9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2NduItmQv2vyjY8EOzzi+qBHhv3zBM0Kvp3nNclJjo=;
 b=fdOp3tMeDJXbDVY2i49LMCCvupy3H6inj2MX0fi2vDuFjYilHM4YzrkrF84+mfBCU+JGdIDcu9EJAVejte+DM6D6AXIYYsyjX0eAnuuMCFxlrzE/UmAxvj8RMtyxHygU624km+nR90HYtHJsRcE5ur8yQ8z3VI+ji9TmSKWEfAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB9496.namprd12.prod.outlook.com (2603:10b6:610:27e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 07:11:18 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 07:11:18 +0000
Message-ID: <22b39012-0309-495b-aa63-54b2473115f4@amd.com>
Date: Tue, 4 Feb 2025 08:11:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zynqmp: Save "bootseq" environment variable in dec format
To: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, love.kumar@amd.com
References: <20250203163250.1618-1-egyszeregy@freemail.hu>
 <CAFLszTg9NgXUYB_LpWidXruzrV5YoS=o2Mn6m0DQNSHxefTWMg@mail.gmail.com>
 <a332585e-8af6-4c54-8a1f-ced1a9164d21@freemail.hu>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <a332585e-8af6-4c54-8a1f-ced1a9164d21@freemail.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0043.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::32) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1e6e74-fe38-4805-7b38-08dd44eb1ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym1uc05nUTZqQW1UZTNNOVVoOXVKTU1WUHlxZUw2STkzejFsditrd2tsaUl2?=
 =?utf-8?B?OGVrYzRIdys3dU5STHhWVVBtbWMxZi9SUmRUZ3FTTE9kYmxPNXFtR3dMZVh1?=
 =?utf-8?B?Y0Y2RGQyTzFoV0tyekliL0pXVmNTaHFqWlZwaDQ4N24wblVSdVRWK1Z3ZWp5?=
 =?utf-8?B?c2E2S3hjbUZtckh3T2oxNHNFQzZ5di9XbHJuVXUxc0NwajRwMFo1bDBCWFYv?=
 =?utf-8?B?RVlIeC9MemhQUGR2N2xndHJ0c3MrOTl2RytzQU4vOHE5MzdWaTJ6QUNuSWtC?=
 =?utf-8?B?SU82Vy9SVmpHV1NhUGx3ckFma1lOYjJtZk9HNHdpbmxyamJDdEp2TE1zVUs1?=
 =?utf-8?B?OW5HYWhiRVpqNG1uWkw2RkgwSytDc2pSbjlueElqR0NzRDFPMXZWNjNMdnlq?=
 =?utf-8?B?NmdwQ1k2VG9veXRCMWtSQ21rT0JzSkxUaWRPcUQreFo1N2hJNTRwWWdmZTVY?=
 =?utf-8?B?WEtzTDAwbEZiclNCRDdYdnZWaXdXOGxSYnF3MXhNeFEzK1A2T1FnaFBzUFA0?=
 =?utf-8?B?eVpneHZXNnJQVWNkbGxYWG5SbmNCU3U1TVBhbTFUTnpvdnBMd29lUEszNzVn?=
 =?utf-8?B?aU1DT0dYZE5FVGZ3cW0rMDRxRk5wWlZReWdaT1VNRG5JZllBNzk5OWpLR01x?=
 =?utf-8?B?Q3pLSUNEWmZqVW5OVFJ3NllOZ3JmZElBV0QyWGdJZVc3ZmYrdFduS09QY0ND?=
 =?utf-8?B?ZysyRzJPaWhvS1dqZHoyc2JJaUE0cWdPazI3MzhSWExCeHR0Vy9xL0VlMFYr?=
 =?utf-8?B?OTQ3UmU0WWppbDhCT0I0anNndHF6WXBBd1VkeUFEN0lzdk9xQlp5ZVBsV1A1?=
 =?utf-8?B?TnBteVpNa0JYYzVsR0JVUEpoaU1MNUU4dGFKUUhRaTljT2dJemd0d3BqYXRE?=
 =?utf-8?B?eEUrWHQ1M1ZmUyt2UmVMUnBTWDNwZm1GNHRFVG9iZzBCdHgwaXJtZTM2cDI4?=
 =?utf-8?B?d2ZPU0pyMzA0dW16N1VKVmZMRVBLa2RPeUU4dkRUQS9tSGl2Q3VhWTJKQjR3?=
 =?utf-8?B?bjlkWm1Wb0xIaWI4NGd0YWdod0E0ckpkWVFPNC9rY1BHbVJXR3FGQWN6VENx?=
 =?utf-8?B?aWpLMVI4SWdLYkRLNTc4d3UrbVdCK051RGhHdlNPeFQvVTlFMERVSGp5TVhR?=
 =?utf-8?B?N1dnV3ZlbHZUVjB0WWwyc2MxUFNTTjRqdUF4cmVVUGVodFhxQXZjTEh6MUJq?=
 =?utf-8?B?QU8zQWpEOGxJb1QrZFJDeFNlOGphR2dUTjM5b1VJSk5EYTFxYWsyb3U3Q09w?=
 =?utf-8?B?QkJNeXB4UDM3aWpCV2xKamhHU2VmQnlEMUc2N2xlV3gybHR2cTcrcUxCZk5J?=
 =?utf-8?B?eVV4KzdIRllzR2tTSUY4WHRvajRVS1Zya2VYQzQrZkkrUEg0c3BCalNZaWZx?=
 =?utf-8?B?VFZaOHAvK3lhbHQ0bkxJSW1yQ014a3dabEZrWjB2UGZtN2tEOVRKMVNOL2Rm?=
 =?utf-8?B?ZkRzeGtLTmZtTGFzQy8weGNob0dCb3NRN1hMZ2dGa2Qza3FZcHhBZmpRSWdC?=
 =?utf-8?B?aTVvajYrMXdQSEFNZXZXbkFyRXlKbXpBNk1wVHhodDIxUVpRdkJpZVEvek1p?=
 =?utf-8?B?VlhJZ2tzZURocWUreWQ1amJxYmp3WGNSc0I0ZTJ5TVliN1UyTXZjcml5VkF1?=
 =?utf-8?B?Qy9iczF0TzUwM2hEMGxDOTNwSXhuU0Z6RkhnaUltampzQTZFa1RvMEZMRGI0?=
 =?utf-8?B?eGlVZ3Q3blZTVTQ5K2xDRFF6UmhOL0dnV1ZGWlRjeG1telpRbnR1MTAwb013?=
 =?utf-8?B?N2dsWG94emRHVXkvSnpsK3RnU2RvYUJWOFc0ZzZCbEJsZUo3K2Z0U0JCR2xk?=
 =?utf-8?B?Z0xobm5QMWNzbENTK1M3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0c3cW9teVhKdkc2V2cyRWJsekJJbE10V0YrNmpwQXFLMjBnNURMMGhDZ2xQ?=
 =?utf-8?B?cjYveHdWYkVNb25DbUpzSmJxU1BwdDcrTE5vb3d0RllSYVRLQlBZQVBUM2pL?=
 =?utf-8?B?WkFMdHhWd3NMWjJGWkZTc2VFajczdHRGN0RSZ2dzNEFuajdBTFQzVUxxMzRz?=
 =?utf-8?B?cXpNZ1BXKytac1R0OVJ3cjhubnc2ckdZZ040UnpnUkxjTEZlajNOem4zOFdC?=
 =?utf-8?B?WENJUjkvK3gzNEV1ZW01MDF6ODVMdnJkRGZkc2lEcXNCOEFadTl1YUc2c0FD?=
 =?utf-8?B?VnhGWEkxUmpLbDFWcGNtVVpGaWJod3JtaGsvLzJ0UGxWQkRuak54QUpMN1hG?=
 =?utf-8?B?bWY1UEd2VXJ1YUFNSmd5ZU9zUkhPMjQxa1hjMU1hSU8zNDJBR2huY0IydjhH?=
 =?utf-8?B?Q3B6Z3R6TU4zRFFBcHNDYTBkUmRTbGc5TVBhdnJQUnhLeTI5OEgyR3lnSFkz?=
 =?utf-8?B?VXF3dTQxZlJMWWpqeC9FQ0dYbFZGcTZIMzFvNXpyS3BHQ1hjR2hrRU01dkpX?=
 =?utf-8?B?eGdJSzZhYXFCUStzTEdDTVY0Z2YrdGpnaFYyUFFVMVM3YUFjSUE0NnBVM21r?=
 =?utf-8?B?T0Zna2tJaERsS3dQalZoL2tlUWhNMUFnNGZmZWpQdkpPemF1MzdCTzV6YnUz?=
 =?utf-8?B?cmtyT3VCTERUNXBhNllCSi9zZ2wva1AyaVVYcmNyRnBJWUlqbi8rcHZvL0ha?=
 =?utf-8?B?UzNrWURreHNFcDNIWFdWc2ZtWUZXazRxa3NhZEtXQ1BiQWhLSU9lb0RtaFh0?=
 =?utf-8?B?T0pIM2QxNi92bk01Z0E3Tk1tcEc5V1lTSFRxSHpvS2RFR0w3SGd2T3BycW9H?=
 =?utf-8?B?c0hVMm1UcXlkR1VHMDJvcTNlWWczbjJZalpoSU1rVG13S0xVU2Rjak5pYzZu?=
 =?utf-8?B?ZEU2dzhRQmhEMHJrQ0ppLyt4SXN6OU83V1F5SksvUC9EZ0lGVUJMQW4wV2N6?=
 =?utf-8?B?RHJVN00xcURIREs4blhSRUNCTmtreGFId1VETGVtYVdraUNnQ01lWEF2ZmYr?=
 =?utf-8?B?VHozeXpQTi9LMU9IOEdsOUdyYXlGekZ4d3I5cThhTFVLUTMzTTd4c3NaL0FN?=
 =?utf-8?B?Q09vWkRZUnhLQXY5RGRWWlFTdk0vVWE1U1JIWXRXR0ZXUXFSVk5NYWYwcWlU?=
 =?utf-8?B?K0tVd3JHV05MT2xjdkJ5cUliV25WVXBuRjV2Rm1CMjBNSWxrVkYwbTV5T2Y1?=
 =?utf-8?B?ZGNlb0pNWWk5Z05KUnlCTDBoOUlyWUpoR0JYdTlRSXZPOGxOempmTHFhSXNW?=
 =?utf-8?B?WlBKcGNZeGFCdjE5TmFkSjhQamZibnlWMmdJQk5qN3lGM2wvS3RlU2RZcVdY?=
 =?utf-8?B?SGM5elZpNWpIMGM2SW90WWdOKzdGVXB2L1h6YmprUm1YYmxUWExOSG1KRklr?=
 =?utf-8?B?L0hzdSt0aWVGL0wxM3FnbVFmNjd2M3QwdFVPczM0dkgxK2N5WjVoVGtYcWtj?=
 =?utf-8?B?aHdmcFQyMkR5bWRrTy9zTTM3RThERG1pTGNVL2VRUzc3eER0cEZnUmtvb1Vm?=
 =?utf-8?B?TEpFdzlVbGxmZGhyc29ybGVCLzNSWjlNZStPRmYxV2ZIaWZHRWdQeXp5K2Vj?=
 =?utf-8?B?MnhCTUJLY2JDeTh4NUJUbWxRazZGWVRHWnJEb2hldHZXSWlTU0p0UjhhR0Qz?=
 =?utf-8?B?RVhLNDNZTkYyQWJOM3A5U3h4R25tOWNiOFhqUUltOEFrZHFGbGUvcjBuSHV4?=
 =?utf-8?B?VWJKKzg4a3BuWWNaeGE4UHdyM3oySjlEdkJnSXhOaVdhOHFnSFJUdDNVY3lU?=
 =?utf-8?B?WmhIS3VUcTlrOTBUSjQ5dERUSzhBVTFPT2xMS2MrdG5BempRUW8yS3dqOEZi?=
 =?utf-8?B?NnVHR1Q5TmpaWmZhYlVqTFJuQnExRkoyaTZXRUlXSUtEQ2VQM0NrWDZadjRi?=
 =?utf-8?B?dXZjS2hRUWR2ODIxblByTXdYWVZnSXBDOXhyMWxOK0g4Y2JKVHZOTE5iUFRS?=
 =?utf-8?B?cGp5d28vU1R5NithNVp1cGw5NnVCd1ZEOWdhckpNUHJXOFd6Y08vcjVQTHd4?=
 =?utf-8?B?VmQvZHRwSk4xRDdHa0ZmU1lqZFhCMkRZYWhaK1ZCdDFYRVhlYWdJWlF3a2RU?=
 =?utf-8?B?ZlErZ09weGs0aThaSFhTNk12cHhlZWo4MVdERm5EbGQyaTdVaWFXd3BLTXAv?=
 =?utf-8?Q?s68qu4BUTiDo+B/C2rOH7w/zg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1e6e74-fe38-4805-7b38-08dd44eb1ea8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 07:11:18.1322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5/9qYp4lBwvA36+iN6ci+gfw5QQW2NeEmcoSUReXJrSZCsy2ROym4fX3KPocKym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9496
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



On 2/4/25 02:15, Szőke Benjamin wrote:
> 2025. 02. 04. 1:38 keltezéssel, Simon Glass írta:
>> Hi Benjamin,
>>
>> On Mon, 3 Feb 2025 at 09:33, <egyszeregy@freemail.hu> wrote:
>>>
>>> From: Benjamin Szőke <egyszeregy@freemail.hu>
>>>
>>> Save "bootseq" environment variable in decimal format.
>>>
>>> Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
>>> ---
>>>   board/xilinx/zynqmp/zynqmp.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
>>> index 8cdd9d8600..820fb252a3 100644
>>> --- a/board/xilinx/zynqmp/zynqmp.c
>>> +++ b/board/xilinx/zynqmp/zynqmp.c
>>> @@ -488,7 +488,7 @@ static int boot_targets_setup(void)
>>>                  if (bootseq >= 0) {
>>>                          bootseq_len = snprintf(NULL, 0, "%i", bootseq);
>>>                          debug("Bootseq len: %x\n", bootseq_len);
>>> -                       env_set_hex("bootseq", bootseq);
>>> +                       env_set_ulong("bootseq", (unsigned long)bootseq);
>>>                  }
>>>
>>>                  /*
>>> -- 
>>> 2.47.1.windows.2
>>>
>>
>> That seems confusing; why use decimal?
>>
> 
> Because in a U-boot command this variable have to be used in decimal format 

U-Boot please

> sure, like "mmc dev ${bootseq}" or in root params of kernel arguments like 
> "root=/dev/mmcblk${bootseq}p2".
> 
> Here is a conversation about it:
> https://lists.denx.de/pipermail/u-boot/2025-February/579253.html

As I said from my perspective the patch make sense but what needs to be improved 
is commit description to justify this change.
That's why please send v2 with better commit message which will also describe 
reasons behind this change to make it clear for everybody.

Thanks,
Michal

