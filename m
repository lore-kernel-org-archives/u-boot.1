Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982C8E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21DAA89221;
	Mon,  9 Dec 2024 19:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PwS4HTxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62DFE892A4; Mon,  9 Dec 2024 19:34:55 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5CD089206
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 19:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQlb5bPjE8gQfKdoSySYBlLRzXG/gmsCKBPvuvta3ccypqDI2eagmhDWYBpeLqd25aK9LETkEjJlex2mRnMhmp3mCNDhGp2QzwV99HQenpwZ2WsA1ku7L5o07VfS8Og/NHiTBD6kThd5et+ijAmqU0wPupWf33KF8AacuamDN6lRQZyLL7KGVSDka5F6pJybCln6hUlVjbqvhRVKkq8fzXN8hSrSfp0EITdMdV5Rq842ZV688wvTsknvLAiRumBbI1kCdvzCKHGEJl+Rq3nttbH3adA6DVOODUR9oLjCpqvH9DpDJ2/GMotgpYYrQWYLFN6vaIMo5dZigZDwJ42Rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oggIuK83B+wgVUIxG0AKRTILDs8ASAQpMNp5B2pzLWI=;
 b=HyyK74qMuvK3wtX3cBXkhU/1IPeo0sKkvCxWBnpSnhIy6ZEBUEgh2w+kKcwxoy4HUIAx3/Oz3ZPOVUF+cw1Gv8rgbd1zd3TG2bTrKtDmbED046GOo2kykMJawgYGls3Gbnad8k0z9wJDzvjvMNkGv6w/gB/WCFJ7STqtTh5wzdv/E0edUIvtQ3GV1S5fOb815z3u/8jngB43W/JbUNkIPQpt7up9oMEOqFEf50LtmU4s4dv+WGPh8cHcK3DN/XTy4KqdrHF20p5homPlSh7s1SbIUM2vfA0nddh4qEVws5gxVBkjeFOU3Mwko87F221dQmqG/zNbLYcYLBuLSLaXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oggIuK83B+wgVUIxG0AKRTILDs8ASAQpMNp5B2pzLWI=;
 b=PwS4HTxH3FgLBWd/OZzrq3f3Prk1LxBbWiTBSy8Rc4kcT+YMTziMwMMjHKsoffwT4IBSaIgC7VIFSJYgP3pYQJdJOYK3rpMx/J6R0szc+sIxZ3qlutDyXFjlC7ufd1CAp/KJc53lKWdrDM62se0xADRXFuv6oCoJZerS5m8xPVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:34:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 18:34:46 +0000
Message-ID: <b5145a88-aea0-43c1-8fa0-fe533bd9d169@amd.com>
Date: Mon, 9 Dec 2024 19:34:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
 <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
 <20241209153216.GJ2457179@bill-the-cat>
 <CAFLszTjb23qYBS2YDWjTJDFtJ2OnZZ5OQG56i9DBu_NeUT=FzQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTjb23qYBS2YDWjTJDFtJ2OnZZ5OQG56i9DBu_NeUT=FzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::8) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f24d1f-247c-4384-b728-08dd18802844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXNBRzd5RmVFTzJzK2FhZGx6WmRJa013K3QzZXFMc3pNNjFPeGVxZ3NxL2l4?=
 =?utf-8?B?RkE1T1N2ZzdvQWM1YXFXRURFTTJBak9qWXBhWTMvVG10dm5iWlJ5ZTdRbHAy?=
 =?utf-8?B?ZjJjaFd2Zm1XVmM1cEtLN0d4SGI3dVJZZzFMRTE5OGlnVXp5VFE5a0ZoVXNJ?=
 =?utf-8?B?bS8xTk1KQlhtblY4YTNWTkFRcjR0Y2ZkcndUaVNFSjZORTVoT3M3c05wVFJ0?=
 =?utf-8?B?ZDJMc2dpSEs0aFBnWEppbXBOWkU5OVNJM0o2S3hxckNXK2lLZUJYNzlib3Ix?=
 =?utf-8?B?TzduZFhoVTQ3d0R6NHJadHlEYlVKV1B3TTl5VzBpd1hLRUZmbGk0OS9XTGw5?=
 =?utf-8?B?aG50UnhMYzR2d2ZGRHZLVWI4YitkTm52NHZPaVFrUEx0eTQ3SjNJU0F1TjJN?=
 =?utf-8?B?WXNPN0Q0Y3ZGS29xak9UczlybWZhViswWE4xVkp4SjdXYno1eDgyRThuWEll?=
 =?utf-8?B?R2xDWDhIYnh3am0wOVpoS0Q1bzNtTUtQSHlPTzl5QWhFVnNySldBcEZXQWpL?=
 =?utf-8?B?MHc2SzJwUnJKaERrV1hSWm4vUXdxRGM5a3gxUVBwRmpGaXRoQ0pFVlhsUmE0?=
 =?utf-8?B?UXBsZEdiMVNyTXNNeTNacm4yWlZKVHIwcm5UK2dwYm5tSWlBVEowS0tJM2p2?=
 =?utf-8?B?NEtDQ3h3aGREMGtLY3c3UVZzVXE0SnZsY09SSEJEdHBXZ0VZMEIvcWtBL0Y5?=
 =?utf-8?B?MVV4djBOOFNzazF4ZkE3VWp0VTI3V25EK0R3VTVtNmFXTU9TM1F2MitFa2Ir?=
 =?utf-8?B?dnpVQ3RpYzlFdmhjcWMvQWRrNDJwRTNUcFNlOEtscXI3aWNVeUpUVHZ2RmZj?=
 =?utf-8?B?N2NOWTNZd1hsaWZKTjZjSm5CckNEemZNcEE4bFNsSGFZeFllVDU4ZHBucjRK?=
 =?utf-8?B?YmZYcEErVkdwbWRwU0FCYUVaaVBtbUJRVjIzdUpEcVZKeGxxN1doNEs2eThD?=
 =?utf-8?B?MFBxTWlYRmFZTHdPZE5UYTdFcWJ5MTN2MUIzc0tYSjVJekVRek9jek8zUE9o?=
 =?utf-8?B?M2xOUHdBUGZoZFBUYUZ5dXljZ1ZmT3g3NForeFg5ckZ5Qnh2NFNEU3BES3VB?=
 =?utf-8?B?T2NvcUl5TWVOMHp4b05PRmRLS0pscXU2Z3pyZS80OXhPVjVkTnJ5Z0FENkpj?=
 =?utf-8?B?SW9PZWo1bERWRnF2ZlhSRklCdDFieW4yOEtQL0d0dFhrTFhYcC9JTWZ5TzBO?=
 =?utf-8?B?dlBqbWdnYlBERnFXem9zM2F4YUZRWFI0bnFTajBWaXdqdlJhazArU3FyN29w?=
 =?utf-8?B?cWNod3ExVTh5QlkvbFY5a1Z1cUpFYVo5ZHFnOSs1N0NYc2RFNko3WFcrQ1kx?=
 =?utf-8?B?RkZJeklXNjdHOVRyTGhKckVNNkJEeDJDeXZDanB0NHpNQUM4REhtb2laRW9z?=
 =?utf-8?B?Z2pKaGljb0huc3Vzd0pyQlo4c2pudlBka0FBZndnMmFYSTd5a1Ywd2p6KzJk?=
 =?utf-8?B?N0RBV1Branp4Z1FHS3o0NWs4cVUxaVlPZmlmOVJuNlV2d2t2UHk4RkY2byta?=
 =?utf-8?B?WVdGOTRMTVpBck00ZDZTUENlQTZ3cy9Eb0UzUFM4QnJHK3VkaFEvdUcwQjlX?=
 =?utf-8?B?b1JWVkUrWFE5dFR1V00wQk90b2FDNFZQSGw1TDFhSEJ4ZlA3OEc5bWt0ejNV?=
 =?utf-8?B?ekJFY21oK0dUQ3M2bkZmNnl2ZzRwRUw1bWV5NVV1dGQreHIyTjl0VWI3aCtG?=
 =?utf-8?B?cUpuN3hua1JkY1VGRzh6THIvcFJ0ZmgzdHRWNXkrZllyeTBjVk1jZHhrQVBp?=
 =?utf-8?B?alpQVFc0SFUrbFdadWdwRmdyRy9ubE56Ri9GK0dPZVZsQUlOY3h0V21Ld203?=
 =?utf-8?B?UEVuU3RYTU5sQWFKdFIwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eERTN1JFOVYxTGZkcWtTNUpNWEpwQWIwejI2MVc4b25Ic2R4eGZHWG5hcXRj?=
 =?utf-8?B?RE5vYi95M2Z5bDc2eFVpTE9LRkczWnlVcS9VSDVkeW1wVUFPejloeGJlVzR0?=
 =?utf-8?B?dDloQTFRZWJKalRLTkRlQzFKNGxLQWZ5UFVidUs2ZWVLM0RYNmZldDBrclNQ?=
 =?utf-8?B?K3Rvb3AycDlqSkRMVU5UQS9KL29aT1JPeG1jMlBHZUozeUJJa0haTlFHQ2c3?=
 =?utf-8?B?TEhqV1BBVlZ3ZGxwKzJqZWJNYmdZOWFXSDBkUC9iVnFxdnpsYjllWUt2WlVm?=
 =?utf-8?B?TzkvVm9ITUZvbXh4RFBaQlc1eEZOYkFNN1ZyQjN5Ui9LVmQ1d1pGdmRCMHpp?=
 =?utf-8?B?dFk5anl3TjZ0cHFNZE81aGROR3FqVlRwRjNlQmVYdEY3ajR6ZDh0UEpnWVBQ?=
 =?utf-8?B?UGZ3WnVHRzBiT0R3bWp2Zmk0RUY2cEZUV3Vsc0ZjNTMwWFE0ZU5UVDVKcVR4?=
 =?utf-8?B?Ymo4Mld6YlpCbnUwYUR6a283S2VsOGRPcXV3bHB4b3EwN3BtUjZybmZiSUFt?=
 =?utf-8?B?Q29PS0lyenZERGs1ekQyeG54Nlc0a2ZGZ3VtaGdrcDE5QzlhNFFMLzVmY2do?=
 =?utf-8?B?blE1T3J4SGJ0NVNTbHFtWmJ2REZGWThzdGpDcnFnU3RsV1N2dlBUZG9yQ3NN?=
 =?utf-8?B?K2NjUUJjNFhaYVh5dGlGK2ZRSlNjaEx4NGtuZ3VsU1NYYkJSVUlwVWtNVnBZ?=
 =?utf-8?B?ZVdJTDRQMHkrQ09yQWJXMkdjRDdqMzdsR2o2cEx4T2d0enA4NjJ2VlNIdnIw?=
 =?utf-8?B?UVdtYmg5dkNTL3VyS2JUd2s2YUpGWVFTb0lQM3poSkxTUVcyZ3dQTm16TTJN?=
 =?utf-8?B?cnJqTGM4MFZrMFpuV3ZnZXdMaEgza3hEQmkxVnFtRkdUVGRFdFF4UGdoY1d1?=
 =?utf-8?B?cjNOR2F5a2RDYkdhc1ZBVW9qT3pYUlJvUVN6MGw4ekU1R3pGb0lwcHJRQzh3?=
 =?utf-8?B?VXE0RnA3NEZjc1J1bTkwYlN1dHExRU04K0JXeGQ1aHlMY0tOT2J5RlczRVJi?=
 =?utf-8?B?VmQ4Q0hLbjBEVmhGNmowQnQxcG9pUVNVL1BsQ3Vudm0zVmxFSTFROC9EeHRt?=
 =?utf-8?B?emZad0Z5Z2psWmsydnJOMzYxQWVYK3lWL1krVDdwbWFHQjUydmtPWkJwVTZu?=
 =?utf-8?B?Njg1QzNINld3VE1iUmJMbWdwN1crdGJFeHV2Z3cvQ2QrUlNlQ3Z1TjltUHRH?=
 =?utf-8?B?YmlxRm90NnBMekw2aXJWL2dOdU9NeWY0SGxXV2lhaXl4THFyUnZGU2JrbkI0?=
 =?utf-8?B?TEtnUmpSd1JCRGFuTFZPazhOTFhtbzYxdk8wRGthR2lYS3BPanFXT2ppMkVU?=
 =?utf-8?B?VnlNVUhwdFRzZ2wwOStXLzJxbUlYaXBLaDZkNkl0aTRWaUtKM3JYb3lRUHp1?=
 =?utf-8?B?aUZ1emgzWXF1M2xOV0VES0t5MHkyT0d1V2ZjS2FKMDBCTE96Z1d1VGNvYmpu?=
 =?utf-8?B?bXRPaFVJZTFlTEd6UUxoNXR4UGtFQ0tXNSthakxoU29TUmVvcjRZM2lKemU5?=
 =?utf-8?B?TmI2QndnNjFhV3pNTmtEQ2ptUXRubVRJZlI4Q3dFVUdTYkh6czN0dVFzOW9o?=
 =?utf-8?B?bDk0V2dUSzJFQklKL0NNK29yVDcwVWFHQVlkTnZGZHdidmFSL0tiSEFsVExn?=
 =?utf-8?B?d1dHbWJ4STNDUHNPZlQ1ZlVTUmxnbUI3MmsyLzV1Y3FIUDMzYUJkK1lSbHJk?=
 =?utf-8?B?U1ZQOTk2UFl2bUl4SVoyWHNQM0UvS1JUV2tSbmcxRmRRaHhlUGJWeDNoSVkw?=
 =?utf-8?B?VGVoNWJ6L0RQNnl5am01R3JzdmVFc1F1MVZIcXFuVmZkbG9jRWhJVnRYMnhS?=
 =?utf-8?B?UmovaXN1clA1c2ppeENJa3JVWGdEYy81bUZqd0o5VWphSDVYVkg3TFpiQmsz?=
 =?utf-8?B?bi8vQnNoRjY1ZThXNENKZE9RK0lGRXdyREl2TXNNWklPOU1HRHV4akw4SUwx?=
 =?utf-8?B?U1VTdUtpY2NPcjhaSmxZTUZ6eVBObmNlN21SS1VFamtJRWFGaTZKYk05ckdw?=
 =?utf-8?B?TjZNSGsvRk82L3JXa2tsZjdja3BGL0M4V1Zhd0k5SXo0TWl6NWdDVTZ3K3la?=
 =?utf-8?B?c0wvR3dTMEhzTE5yak1mam5GNXlMS0Z2WUZRaDlhalJ1aExxdmc0enc3R0Zq?=
 =?utf-8?Q?NIgurcDsoJ0pPz+hN+hgxRUOb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f24d1f-247c-4384-b728-08dd18802844
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:34:46.8116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1ymVPSPmoKdviNNW1KsfAidOVwkB5oRQYH9yj9J4sGzVXdEp/bkE47iFU2u2tNl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
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



On 12/9/24 16:47, Simon Glass wrote:
> Hi,
> 
> On Mon, 9 Dec 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Mon, Dec 09, 2024 at 04:26:15PM +0100, Michal Simek wrote:
>>>
>>>
>>> On 12/6/24 20:20, Simon Glass wrote:
>>>> On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
>>>>>
>>>>> Calling empty function when BINMAN_FDT is adding +64B for nothing which is
>>>>> not helping on size sensitive configurations as Xilinx mini configurations.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - new patch
>>>>>
>>>>>   From my perspective there is no reason to call empty function. It is just
>>>>> increase footprint for nothing and we are not far from that limit now.
>>>>>
>>>>> ---
>>>>>    common/board_r.c | 7 +++----
>>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>
>>>> This is a bit odd, though. Do you have LTO enabled?
>>>>
>>>
>>> yes LTO is enabled. And there are other candidates like this.
>>> Is LTO able to fix function arrays which is calling empty function?
>>>
>>> (without this patch)
>>>
>>> 00000000fffc0eb4 <initr_of_live>:
>>>      fffc0eb4:   52800000        mov     w0, #0x0                        // #0
>>>      fffc0eb8:   d65f03c0        ret
>>>
>>> 00000000fffc0ebc <initr_dm_devices>:
>>>      fffc0ebc:   52800000        mov     w0, #0x0                        // #0
>>>      fffc0ec0:   d65f03c0        ret
>>>
>>> 00000000fffc0ec4 <initr_bootstage>:
>>>      fffc0ec4:   52800000        mov     w0, #0x0                        // #0
>>>      fffc0ec8:   d65f03c0        ret
>>>
>>> 00000000fffc0ecc <power_init_board>:
>>>      fffc0ecc:   52800000        mov     w0, #0x0                        // #0
>>>      fffc0ed0:   d65f03c0        ret
>>>
>>> 00000000fffc0ed4 <initr_announce>:
>>>      fffc0ed4:   52800000        mov     w0, #0x0                        // #0
>>>      fffc0ed8:   d65f03c0        ret
>>>
>>> 00000000fffc0edc <initr_binman>:
>>>      fffc0edc:   52800000        mov     w0, #0x0                        // #0
>>>      fffc0ee0:   d65f03c0        ret
>>>
>>> 00000000fffc0ee4 <initr_status_led>:
>>>      fffc0ee4:   52800000        mov     w0, #0x0                        // #0
>>>      fffc0ee8:   d65f03c0        ret
>>>
>>> 00000000fffc0eec <initr_boot_led_blink>:
>>>      fffc0eec:   52800000        mov     w0, #0x0                        // #0
>>>      fffc0ef0:   d65f03c0        ret
>>>
>>> 00000000fffc0ef4 <initr_boot_led_on>:
>>>      fffc0ef4:   52800000        mov     w0, #0x0                        // #0
>>>      fffc0ef8:   d65f03c0        ret
>>>
>>> 00000000fffc0efc <initr_lmb>:
>>>      fffc0efc:   52800000        mov     w0, #0x0                        // #0
>>>      fffc0f00:   d65f03c0        ret
>>
>> No, but maybe Simon would prefer if we marked all of the could-be-empty
>> functions as __maybe_unused and did:
>>          CONFIG_IS_ENABLED(BINMAN_FDT, initr_binman),
>> etc in the list instead?
> 
> Yes that looks better.

But we are talking about using macro inside array at best with using #ifdefs.
Or maybe I am not seeing what you are saying.

> 
> Michal, see also [1] in case you can work out why it 'stopped
> working'. I could have sworn inlining the function was a win when it
> was applied, but no amount of toolchain juggling could make it be a
> win when I came back to it later.

Are you saying that it worked in past?

Thanks,
Michal


