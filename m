Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E68C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 06:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A7888291;
	Thu,  6 Jun 2024 08:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HAAM4vZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BC988276; Thu,  6 Jun 2024 08:38:35 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80D25883CF
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+PpDqijAPaiefulxpKMqtCdjOmkCmEvQjjjfnctHiDCnr6IQxvuTIr4/oqoEB1ADioPoTeGrCN13NO0qX5ZPEud1VsGpxuXP5o1oIK7yeDhunvoM5G2aVuY8DY4agQzUupu55QhmP+MM/tj8ohRWSNIF5PW1ZySmReQR6jrWj/Wbl4IA74u6XIa9oYBtT7SQB2phDyj2n9ZQpVgf2uWwkcYE8DToMYvriSHAorL8Mo6Hg4xhBiLyH1qRZoMCxzwsTuzOXKPzsd7i+s1OFgWI/9Bg+22uI60ofb1w/EK1ezWsqolds6NYcX2BOy+vjB33ashXJrHLCAYQM+UYNW/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klLOUKKY6tSavlL/8j9wziHSdL3hauLPEVJ1LRSniJE=;
 b=F04sh4ecoFidhWKk71D3Ch103Lq8yWQkdQS58bqQwkkmlvAayxxBT+DLSLR5VOCJAFuUk5GLDeZgN6yyChSXtoGNmIOBHrFn8z8Y1Sh1Q/gsp2z+WRUev7mS9hexF0MF6jpzqfUVNjogTu1rEWXTB2lotVy0ByegVn7kYubazpJTRvJuw+wQo963chWfJ0t7ijhxWmAksZi3MtjRabB1AArhFTM2DXemSZDbob5YHspM0dk2a6L0Rm6Q+qaOUg2k6SoHUTYJ/30wj12vqjQFRxUmze7AT2VcDutDOeOUvjnslv8u1o4yHdMqnR56d3pwhh8tyL31Fhke2moJFG7odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klLOUKKY6tSavlL/8j9wziHSdL3hauLPEVJ1LRSniJE=;
 b=HAAM4vZgLG9IF16grccuzacaCB6cfEy34Fkih3h/Au6VFXt/o4iESJyRcQ8yngHgJhQqln940KOtlHJBVwkhkqYTRvFmyYLfBHNz6I0yJzm7R30KANQ5/tTyaqIVEMYcifaoUJtvfvRhPTXpBz9NjYErUa/dqifTJOmsg7iLg/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 06:38:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 06:38:30 +0000
Message-ID: <6ecddda9-0823-4512-b33c-787eef615181@amd.com>
Date: Thu, 6 Jun 2024 08:38:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: fwu: Also print information about size
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <0513d382abefaa0cab02bd85e120f544d1ef8e6d.1717599504.git.michal.simek@amd.com>
 <CAC_iWjJc5gO1W8GeNRG3Oo24hVzPope3cisz0R=7_pUTjJLWVA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAC_iWjJc5gO1W8GeNRG3Oo24hVzPope3cisz0R=7_pUTjJLWVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5847c7-9110-486a-905b-08dc85f3478c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzlxWGE0amVKa2Y4OGlVUVhFdGhyTVRjUWtKWHRqenVNeDRGVXYydnhZVVc4?=
 =?utf-8?B?NHN2TWc5M0FTQlNEN2dnK00zQ0FsZWI1RFpKYndKNDQ0dUV4L0kvMEw1RGlI?=
 =?utf-8?B?K1JZV0Y0VjEzS2d2VWlBaUNHY0JtZFNFOFZmRHZua0JBU3NIK2p4RzJSSnVk?=
 =?utf-8?B?c1YrM3BHbjNUWkVUT0YxUjZoOVFFTEpZVzZ1RGZtdUsrVWV5VHg0TjZpTDZ0?=
 =?utf-8?B?OUlDaGNCN2dXOFZDL2NCMDBUTXFQcXo5emhrVVRocWdWZWNtTXMza0tPcTJX?=
 =?utf-8?B?Q3VmRDdmSG1yNHI4TndENHh5MEczNXNYK0o2aGVqTFFiaC85L2dtNzJTbEtp?=
 =?utf-8?B?VlVMTkVVRGNEd2gzYytDYnFGOHdXN1BHb0sxQnV2UzU1OGxIR2hsc1JTUnVi?=
 =?utf-8?B?aGFEREFxOTZFNXJBdkRvdnVJUHo2V2ZDdTRqcGsyTC9PVUs5SzlNWkN6bGJm?=
 =?utf-8?B?QXM3ZDRDYVp2UUljUEt5cTY1aitHOFprbGd1bDVlSzlnQlBnU2E2Tmd3eHBP?=
 =?utf-8?B?RVQ2b0huUUZncFJ4ZHZBV0FPREFzZVF4TW1WVUw5UlFhb1p2M1Z4US9ZRm9J?=
 =?utf-8?B?cTYxNHRDcTBqaDdIRmZ2QnhjbituR3RERHhmeGNrTjRDOE1XeHJ6dDlJMWQ2?=
 =?utf-8?B?N3NaYUM0ZmJrSVd0OFJvaUIrb1BzY2NaQUxnNFh5MXFjOXE1MFI2YUF3ZU0w?=
 =?utf-8?B?NEVvNGI5UW02cElTRlFtWGRwTjBJdzV0L3oxTUVEUWNmMEpQR1J5VFZ3Q05K?=
 =?utf-8?B?ZklFV2Nua0NUbEUxVndSaWJhQThGdDlxNGlhajI1a3grWHBaVGFzL2pROHQy?=
 =?utf-8?B?dy9pRHR2bzlCSkpvanJyVEhYRzBaVThhQVBoNm9NVExOeU5yZkVEZ3l1bjlu?=
 =?utf-8?B?TVNTdW1MUHdNTlNKVDhXaE9Ucm90SmNzMFhYTERvODFUeU40dHYzUk9iaTZs?=
 =?utf-8?B?dEtPaWFaeWNGVlhaUk9yWk5GSHVwRllWNkJaRjJhQTYybnF0aHJHUWRweW1S?=
 =?utf-8?B?S3QxenYvb3dOWkREbG1xa3VOZlB3ZG5MNnJMY1VRN0lhbmhZWTQ0eHRjOXlD?=
 =?utf-8?B?MGRjYTlnLzRWWTN4Z1dZSHc4NUprYkJ2aXFlUFY5Ykk4TXRVbVMyU0k1STFK?=
 =?utf-8?B?NUZFSThaYUdHQ25SSUdsUmJXSU5UVnJseXN2bk1FaS82TjAveGVLY0E2WnFk?=
 =?utf-8?B?K1ZETENkNzlaOUU0ZTE2VDVhdlRRYmdlWExud3M4VUI1d3JGKzFlL2I5bU9U?=
 =?utf-8?B?aWpMcVZHdlc5MzJOZE9zcUhhU3pIVVBnbVZVN3VZNGRTbnRxbDhOZC82b01S?=
 =?utf-8?B?ZWFMYUtVRFhNam9KVktyc2tUbXRzaDZHN0ptd1NvMXBnbmFaTEM5WDJvSnZz?=
 =?utf-8?B?U3dNZTZhcytrZGx5THVNdVNuQlk2ZlVwcTRVT0tXUDIwK3YrZU5NOUJCcmhF?=
 =?utf-8?B?WnZ2Q3JKK1lrR05BMm8xV0hobUs4L0hRZ2ZQKzYyUWxDOWlkRVVldElnMnNE?=
 =?utf-8?B?SjVKSThJMTFrcldkYVhtVGc4aHB5MW51RWpqWE01a1ZlOCtwekYvbkRKSVpI?=
 =?utf-8?B?bXhQMkgzaTBjR3RUM29HRHowalBRTnJqczhCNWNSZHEwRDNUM1kzV3pZSkFk?=
 =?utf-8?B?WGg1YndiK0Y1Q05CSVdaSm41cjNjcE9LcUl0UjkzWDJ4ZDByT29LWXI3cDlv?=
 =?utf-8?B?VWplSUJoTXp3cm9WUFAxQkVtNng1QXhqR2tuWU1WVzZzMDBhWEpxVTdvZHAx?=
 =?utf-8?Q?WX8OYaOMtzwRs3szBBXABy08+rQkOuXb2xIGlzb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blAxWVo4b0JES09PQ2FWZFJERGtlL2NESXpuMFNpbkRRTDdlL21WUVNNeVB2?=
 =?utf-8?B?RXN1azV3andwZEZwdWxIZTBZZHNWTEVGV1ZtaUYzMmxsTm5sSjdjVVhhVUp1?=
 =?utf-8?B?ZVk1ZUZQMG1KSnRIMnlKVmg1VWRzU0duMjdNVFhNdCtRZ2J3eUdPdjdUVEo3?=
 =?utf-8?B?NHBZSUYvcy82UzNVNTVCNG1BaGlVaklwbGhKK3hjb0xCa3pCT2NCdDJpa2hp?=
 =?utf-8?B?eE9HbG1uQkFVU0EyZnBDcHpMdE0zUFFnYnlVcGlxZjZJZHR2K1lPbjFQYlRF?=
 =?utf-8?B?NExwM0FpbnR5dlExRzlTdzVkN1JnQWJNVEY0VmtLZ1pWd2cyVVVmTDZ3NU9o?=
 =?utf-8?B?ZEc0Yjk5UTI2MUFubDZMUUFQZk8zc240UE11bk1rUzFYRFRoOUpybHBjRFhV?=
 =?utf-8?B?S2kxa092cklQVUZjMTZLNUFxVjlpZllTY3ZKcVBhRVYxMDFJaUFkYk9uV2tB?=
 =?utf-8?B?N3JnNjVUdUpIMHA5djdpcHBaWU82OVFqcE1EQVQwZkpVSTgwZUppODQ2REFG?=
 =?utf-8?B?dnpUZ0tpOVVTaHFWZ0QxaitOKzNpMDFESnNibWxsQUxGaFhDWGE5WTUzZFZG?=
 =?utf-8?B?eElLTWM4UTN0L0ZKVEI3ZVc5RTA5M3Q1MW5FN0tDak4vOGl0RWFSOUNuUFdy?=
 =?utf-8?B?c01vUWFOV0phSnlqVklCbjRNUnh2YmdsRnJDVjFYSCtGN2E1N1IyYS9pbGsr?=
 =?utf-8?B?ZnJLUzF2Wjh1UC8zZzVUWWUwZEt0N2N4VDRaeW9pQ1BmTDFvbWViUGE1ajFN?=
 =?utf-8?B?ekpvc0N5QnQ2enQ1Tmd2eWl3bVNPbFZTaFJONm9aSzJDY2NzaXpUWTdZclgy?=
 =?utf-8?B?U0NqWXBjeDg2dHZZTjBabnc2QU8vcnptem8wNE41eU0wRTdTTUV3QVhyY29L?=
 =?utf-8?B?ZEdpVTJxUDBVZkgxd1ZLcmNZZGlwMFp3eGMrV05wanlqTFQyR01mbnM2bmYy?=
 =?utf-8?B?TDNWclRXbHU1RWdON2x6bGdwWlF1NUUrMjNDckVhbjUwTUxiOUF0RTEwaHQy?=
 =?utf-8?B?dkFXUHhwOGxCYWRKMUt1aTdScEFCNXRnNHFKREU2RGVmUXFuQXNWRloyeUln?=
 =?utf-8?B?T1RIUVNsWlpzSVY1Wmd3Y0VQUzNzYVlLZlBHUzI3R0dLYTdZRStwUUtWWG96?=
 =?utf-8?B?dnVFY3c0dWh0b1NZSExueTdXNU9tUXVvQWpicEtGOWJsQkZyK2JDU2NQaG5i?=
 =?utf-8?B?WGJ0VDFMWitJMVM4ZlJkOHpETEtieWVUTW9GNFFpQityb2lBUFNhZmR0bW9J?=
 =?utf-8?B?UHcwcE43bWprUU5CTWhmREJrUVh2WVErb3JtS3k1bHFqYThkSVFzbnAzM09X?=
 =?utf-8?B?MElFbDVZbFlRTHV5TTExNUFPaXJkZy9waDVCT0xseEhDenFXVkR1RG5udC9l?=
 =?utf-8?B?YVpBNGJYb1lYZzRqUWZIdlFwMXpNL1piaW54Y0RRcy81N2NTa3NCWkQydDhM?=
 =?utf-8?B?bVhscXNDYlFHcG5DU1pmQit1cE10SmZ1NUY5UHhsZVlnM0Rha3R1T2VtQk54?=
 =?utf-8?B?V0xxWG8yaHBTQ3FMQVpNL1dEcmRocHpUU3ppbDFQSWpwN29FaXMyem5SWFM2?=
 =?utf-8?B?QjVnRVVsQlg5SlJUYzZvdzVJZFVrajhrVUF2QWFTOU0zMDBUdTBIMEd5cFhi?=
 =?utf-8?B?QzFOOTgwN1AveVJsUmV2eTFscEhvc0hXVzNGRmd3bndDV1Y4ZHpGR0ljUEdk?=
 =?utf-8?B?Q2YzSlgzTDRvUkIvOTBzZUhWSm02bkdBUy9JVjUrbWJxU09vMTVvZEJVbmcz?=
 =?utf-8?B?YmhPV09DcU9ZSkdUd3hMcHBKcXZybS9VUzQyTGJZemttVTJiZzNldktCTG1Y?=
 =?utf-8?B?d1JWTnZzS0VINDNoRXJUUitFbFFLMzRuczhCZ0oxZU5NY00rcDJtNURHTlhJ?=
 =?utf-8?B?emsveUkrNnJ4S1NxSXVscHFKYkVySjlJbndyWklyNmNRWDlXRkdKb0hnT1hz?=
 =?utf-8?B?Q1JvdXlWQW51L3ZPdGtDY3RuL3J5OXRneHlBbnlKS0NvRmdJcUZROGR6dFha?=
 =?utf-8?B?VE1zMmo1VElUam4wMElyRlNTaXpvaHJVOVZMcHowQzJwZkVPSkx6UHFkZG1Z?=
 =?utf-8?B?VE4ydDBoVXd3N053L2YrNzJIaEFFNmQ3QktnVGRXMFpKNEVXRGxPT2g5WUdo?=
 =?utf-8?Q?E+yWKO7k55S3f+UdbZdZAe0dM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5847c7-9110-486a-905b-08dc85f3478c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 06:38:30.6122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnkxgfmR9p5+D/1Z0OyeEyFfIuF5d+O3nkK4zIkvUb604HfgIxdFtlwAvQGTrW+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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



On 6/5/24 17:09, Ilias Apalodimas wrote:
> On Wed, 5 Jun 2024 at 17:58, Michal Simek <michal.simek@amd.com> wrote:
>>
>> It is useful when structure is also used for saving vendor data covered
>> by CRC32.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   cmd/fwu_mdata.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
>> index 3c8be576ac7a..9c048d69a131 100644
>> --- a/cmd/fwu_mdata.c
>> +++ b/cmd/fwu_mdata.c
>> @@ -22,6 +22,7 @@ static void print_mdata(struct fwu_data *data)
>>          printf("\tFWU Metadata\n");
>>          printf("crc32: %#x\n", data->crc32);
>>          printf("version: %#x\n", data->version);
>> +       printf("size: %#x\n", data->metadata_size);
> 
> That's only available in v2
> IS_ENABLED(CONFIG_FWU_MDATA_V1) etc?

This field should be present in v1 and v2 case because it is the part of 
fwu_data (u-boot private structure) not fwu_mdata (which match the spec).
But I have sent v2 and only printing it in v2 case.

Thanks,
Michal
