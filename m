Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F8BC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9309782DA1;
	Wed, 16 Apr 2025 13:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ixaDoHmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7297C82E26; Wed, 16 Apr 2025 13:36:38 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5865982C96
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glFcYlST4Jv8EeYTSxONWpNPamDM4ES/DN3x8r9YcOd3nDq3uupiTuLGiL51TG1rWhUaiOo/aGfJXAPy9+7Ss0dJjdcDXVBPLSCrT4KCQyfrOwePBdwOJa+ihIZfdp6qb3kFc/2GxJwQZums0N5ixKsEQtXWNBeeQxn82zIULI0FF5XpwV7jN5ovuHcI54CmKPvT2NNWhbO0roHS9BWDyfAtumnnQZhr4zZq/7pSnzWLlylMU73QIIVGUVlqpV+fO4yoIXKjAW8tlsWOEONYJmtz12iP/apDXMSDwpDAbLAlgJi7CWc21QlUskHSTAl9g6NT70441qc7oUA8LCr66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUWLSleBms20RdrJB9YdYAQBa0SihpO4cU7BuGxFbH0=;
 b=SPhpuJ77A+t9j2ctR/Ovmjsz64W9ChhpUzBcO2UoHfer76h75Qe722gnpqvYgy5H5fAtuF1BBDY3wgqIQdhB5W9uK7HxZ9mNSzVTUTyrjZfJS8zO6ngscz9dbiq6zUMJXHI8JN5wEeZ+2tPRQ+CwflFqjzktSZhHMZvxI9iiCNiW8SLdiSliE0JU4xyd6OM+hQofbZnhJQWZxj8MfLbG04vQ3E6P53Poat8cxi7nhVOI5sL/naAIyUmskJ0LZFRruN6A+aHoC7IWZ8W5GbQg+eex4s17Xpd92JjIZb7Hkp1VIKq2RflFnRAOMYVtDjDVBbcSZ/ltrVP1W9u4CCjf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUWLSleBms20RdrJB9YdYAQBa0SihpO4cU7BuGxFbH0=;
 b=ixaDoHmFfZnKzL+oqvaYlRdQNaRPxW5yF+MaCpmbX5PisHEY9mKAvBGRTWwmKDARW5Cnr+Smyf0mXPK7bjzFC9bblRAGecRGvAoIDqAtRZlOir0JR6KLaSq7qVLnVs9pZJe/LrRc6tRMdc1vH5Iu8s1SW0Nnu4/M1v6Q2GtvCFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 11:36:33 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:36:33 +0000
Message-ID: <abd2256e-7741-4d13-a422-e7388b6a7f07@amd.com>
Date: Wed, 16 Apr 2025 13:36:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Start usb automatically via preboot on Kria
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <180c9776b03d57d8218d161924363906ef354394.1744272843.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <180c9776b03d57d8218d161924363906ef354394.1744272843.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b13da99-b753-4489-1eb8-08dd7cdaf059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjB2WElSY01SeVFWM3M1SnRJbjNkeGtuc29JNTkyYXQvZzlLS0pWK3ZkT1J1?=
 =?utf-8?B?VmZoQUhoSVFQOHFZK1EvMThsOFBoaU90bk94SlV3RWxiQnJuR2xVNHFpbzBX?=
 =?utf-8?B?VmlCcmlMMmtxMis4Vmh5L2pnbmpZMDQ5NFY4eDArZHMzNHFtYkJXVytUbWdN?=
 =?utf-8?B?WnhDeHJEQzNxNkFES3Z4SldjVGxhL2x1VUFHRGdBaVFkbS8ydThuM0hTOS9W?=
 =?utf-8?B?TDdTRjdILy8rRlJnWkRzSmNrKzB2UFdqL01DbkxUTmhWS01KNC91TklSVmlT?=
 =?utf-8?B?aTJhczhDNmxvM2VZbDVDeWxBWGxzTnM1ZTRFUytaSmtYWXZOWDBqTDBna01F?=
 =?utf-8?B?eWJnZFlXMHVUY2l0Z2lRQUY4Z2VlY3VFdmNwZWNUN2g4QVlCTERESnkrT1p1?=
 =?utf-8?B?WDJyVENUZm9rdk00MS82VnlnRUladFpTQTc3THdFamZQdEwyM0xpTHpaZGlF?=
 =?utf-8?B?eCtoZlAwY2Q5MmNUc1JKZE1Ua1hncEV4dmRNL25UK0lPOVNacmphRS9Gakpo?=
 =?utf-8?B?a1FkWjRSZVZaSUJjMXU1R3hESTdmWmRTakVLVmsyVTZ0VEhoQldvbm1jbkpB?=
 =?utf-8?B?Q0hFdjc3M1owNDBDa045MUJWaS9URUd1SU1SRTIvcWxDNDBuUEl0cTY5R2xF?=
 =?utf-8?B?OGJ0ODVGOU1VQ0FnZC85c2k4NHMyYTBUbkFRYXFZTVpJbStoMFF5eEdFanR1?=
 =?utf-8?B?c0VabFVGaldzNUY0THF5aUltNmJyUHVTSUI2WFUxQ2tpU3RxbDVWL0c3OWho?=
 =?utf-8?B?Q3YwWGRXdEpZU3JzLzA0R0VsRFVZR1BGblJqcGZwZGdhZjFnRSs5Q1FIMnd1?=
 =?utf-8?B?YTJXQnVEYWN5VDgxdmR3TjZkTngxVWNMVFVHN3k3UzNrZk1zODFsTmFMWjRt?=
 =?utf-8?B?UElTVTFHVkpjNWtzeTlrVk9NVUdrSmhkWFFJZldNQkdsY0xrLzFUV0d6NkRa?=
 =?utf-8?B?OXFqRSs5RzFrdDdlK3BERGxsRzhmT1pEY3RTNmJ0YnRwWnptZUFka3d3ZHgr?=
 =?utf-8?B?RmhvVVNBczZOS2o0N0NGaUE4L2RPRHF2bWZhL01Xb2tiNlVsWlkzOE5EWkR6?=
 =?utf-8?B?Zyt5NW95VjNoUE95eFZEWXV6NWM4Y0J2S1NlNUExRFJhNXhEQk9NN3EwN09M?=
 =?utf-8?B?NlhKZUo2eGtnY3liY25RcmFWMFBld09WMUxWcVBHdStTNEJnelBRcWhDT3hS?=
 =?utf-8?B?TjdERHd3Q09keWVna1J2TjBRVnFkeEJNTU03NEdCTlVqOWMwcnREUkNVUU5K?=
 =?utf-8?B?MDhtRHkvNGJFOTdmM21SMVpaQ1JKeTM4dG1zU3ZNYmpUd0Z0eFY2MVhKMEU4?=
 =?utf-8?B?MHVoR2VmMVZVY3c5TktWU2Qxa2FmOERMSFVIbXM4Zk1nQXZGSnhOeHlQWkRl?=
 =?utf-8?B?T1l3eTdiNXpVNGVyV2ZSQkZVMlB1VzMybjlxaHVGMjFDYVdRR0V3dmVXNCtQ?=
 =?utf-8?B?cVdRUHlSdDBMenFHQ1BGbEJKUmpZRlQ1ellZS1p3djJpMWVaYkdpd2RJY2kx?=
 =?utf-8?B?VWlvcHNoNkliMFFVRlBaKzBVM2IrOG0wV0MxQUJOZE1XQk1nOVdnOGNXMFpG?=
 =?utf-8?B?UENsVjNBbUNCZHM0Qjc3OHFkNW9DdGVkdThxSGR1OEw1OFBEQXJtdHBCbHJH?=
 =?utf-8?B?OVd0UW5ZSGZyMTZHWmg1d3FoMndWU0Q4cTltNXBCNmZNMHl0VWorL083S01n?=
 =?utf-8?B?d2p5UXFpU2l4eUtWNUNQd3M3ejNpSmFNTHlkNlM5SitGYk9VVHphZ0RqVDJl?=
 =?utf-8?B?V3RucnRaR0JpV1A5eGRkT0dlTU84cUpraDdPSGdXRU1WdzcwZW1iSFhKek9h?=
 =?utf-8?B?WWJxZmNkR2VGaFpVUWo3RzUyNUovaEtlMTRWOEYycEVhb0ZlZFo0a3Y3TWlo?=
 =?utf-8?B?R3lmMkRncTRGUjZ4bWVsUzBUZURpZXpWN3ZKSDZycXVlQWd3L2NHNkUvcXFN?=
 =?utf-8?Q?AyoHaqSWD7s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFJDU3VxUm9YSVpVQ2tyaFhleDIzbXB2OWcwZWxaTXpIZTVQTmk4TW4rSGcw?=
 =?utf-8?B?VFlKZkF6cFJQMUdIMDJQaXVQemlDTUpJeUIxazdVTnVpTklmclpJa3BTeFZy?=
 =?utf-8?B?TU82dHAxV1dGQ0tVVEJHQXl1WEhkOWhmWHdxbmhzQVJPMHRZMUpwWWVpbjJm?=
 =?utf-8?B?RXROODhIYThSYjBacmpKZXJQL0JObUMxUXlrK1JJOURCbUh6Q2pCTVoxM3Nk?=
 =?utf-8?B?WkZRVmpJYlpsVVZ0SkROV1NaUitxTlQ4KzhaaFhYMG9QOW8rN1Q5UW4rS0h6?=
 =?utf-8?B?TUdBNkZCdERDR0Zkd1VDVFErMjV6Y3QwMVE2SG44Sy9nUmJYSkduNzJMakFL?=
 =?utf-8?B?aGhZRXlMNzhvY3RnUzI5cktNdkFKdFZ4cHRkU3NyTDdZOUlreDIxR0NjSlQ1?=
 =?utf-8?B?U3Q0ck5qbTdFbTNJSXYxclhDSFFEbXZPNitsNnNhZ2Vua3pyN1dlaDQxTVVO?=
 =?utf-8?B?b0tWOWg3dlF3ZjBTVklObVVNYmdzVUNvbDYzbUNYZGttTFBOa0dhNkRlU1hx?=
 =?utf-8?B?WVRRamcxQmtjT2g1Y1BIS3gxa3ZOTU1oNHJheklLV3dnZDdtalhGR1FrSk9M?=
 =?utf-8?B?SFFQMnFzK1crT0E1bU1rcTNkZHBmNzhCaEVaU00rR1E0cEo0dUY3ak9NWW1i?=
 =?utf-8?B?c2NOMG9sMW5kRWpzODk2NkUwRm5JSzhlT3Z1djJsTXBTVElOeThUY0xUb2sr?=
 =?utf-8?B?cytVeXdZQlFkNWZ6TENOOXN1bTdoQjcxem1RbUVDRDdXUjJ6M2RCZlh2b296?=
 =?utf-8?B?WWwzWDBaeG1LRjlKUUpXaStzMmdTbFAvV1c4N05pY01WcGFLTlZDLzQ3RnpB?=
 =?utf-8?B?U0Z5bTVpRmFKc3Q2cHVXaktMcDduV2pWWVdOMi9KU3hGTHBlanRYS2o3RXNr?=
 =?utf-8?B?M0xvR21pOXBKeGcvVy9lbi9ySGZQRnJFbkp0VGFQeUVTQnhVREhNUDlucnZI?=
 =?utf-8?B?K2M4eXNEek92cmNyWUM4QnJNOGV1UC90YzFqUmg3V245SjE0MWFwMnpLb2RK?=
 =?utf-8?B?SUlFRnhxaFN5bnFYTnoraHBELzVOMUFGRFlNRWVncDBpYkVkYTFnVWw1b085?=
 =?utf-8?B?NzJUa3ZHNzZhRGZvczRKU2gvS2U5cnVsN2loYngxeEI0ZC9nNUhmRklEV3JJ?=
 =?utf-8?B?ckVqNnRZR3ZnYnVlOHVLLzFtMmdQb3kzYzZUanFJa0dMOUk2QXhodm11Rk5Q?=
 =?utf-8?B?eWEyMmorRWRyK3JDU0VOSmpKd0lpdFA2bUlFSDFRVjY1aU5YdUdYNjZuN1hs?=
 =?utf-8?B?em9YeHlwcmI5YitmZ0pKNmNyYU1sZjFzRG9RUUNpTXBsYUQwWC9aY1R0WkVl?=
 =?utf-8?B?ZGYvaWxuVGZSaWUza2dwdDg5Z0RsemdjWUkzNE1ZWThxMHZKMy9YTFJQMGtt?=
 =?utf-8?B?aWRBOVVkZGJVM3U0V2tzb25PcE5MQ0FrMWU5MjYxU3JGay9VR01NZjVQZHRR?=
 =?utf-8?B?TTc3QTUvclFYTURHTVZpMmJMZkNzQi9GQXZ2cy9HN04xL1VCSS9MMDhqUk9Q?=
 =?utf-8?B?MHJEbjF3dWlDKzVuZStWREhodlV6aWtkWElRNWpWMW5aelp5S0s1N1F2Qmw5?=
 =?utf-8?B?eUxXK01hanpjNlVpeDY4YkhBN1NkK3lQWHdlQkU3SnZYcSswRHJQMTIxcHJD?=
 =?utf-8?B?L0lDRmZMRU5HZk94WDJDVHd3Zis3NUhaL3JRTUZCSFQ2SXh5SlYzelJIaG5R?=
 =?utf-8?B?TGlGWEZXU21nVVlpV1h2ZGY3MWpXMmgybVczS3Z0eWVmR1NRaVUvOUxNV2NT?=
 =?utf-8?B?UFhhdGJBL3J2cUhzVkxaTk8vT0lwYmFEM0JqQVoybVFYNWJUMVowSHh2NFJ4?=
 =?utf-8?B?R0dpSGNyeG5sYklLalNDaC95MWV5bDNrZjdMaFM4bnRnSDJJR2ZucTVBYVB5?=
 =?utf-8?B?cGR5dHFETTJMdnJoNEh1emtYcm80L1lpVkk1MkkwdHdqZWwzZ3daeFZhbTN2?=
 =?utf-8?B?dGpsbVBxVzd1NENvdjhReW14dU9wZ1ptZkRQM0U1NzRYeWpiTW1XalZYMU1Z?=
 =?utf-8?B?VG1UMmJlN2YvM0RpUkwrTnZWMlRmcGVqRjRBZkQwRWJ1ZDBwZEVZZFh3VnBF?=
 =?utf-8?B?YmN3VW9pY291WkJFcmoyeVRPS05EM1JscGFOZFd4QXJrUGpiclMvRWpQN3Vh?=
 =?utf-8?Q?HO/QC/Ww4NNtdthD/POZEIXg9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b13da99-b753-4489-1eb8-08dd7cdaf059
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:36:33.5925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiHCjD9ucD/Cvq3jL+FHXmZaVmenaaRSZsMaTd2TS2dpJ4bo3dtolwc03bXQv5dA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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

On 4/10/25 10:14, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> U-Boot configures the USB config object which enables power for
> the IP, without this the linux usb driver won't work.
> So add "usb start" as part of preboot command.
> 
> Fixes: dd4a82201694 ("arm64: zynqmp: Introduce kria SOM defconfig")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp_kria.env | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 75b604a1f767..89f48c035863 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -42,7 +42,7 @@ script_offset_f=0x3e80000
>   script_size_f=0x80000
>   scriptaddr=0x20000000
>   usb_boot=usb start; if usb dev ${devnum}; then devtype=usb; run scan_dev_for_boot_part; fi
> -preboot=setenv boot_targets; setenv modeboot; run board_setup
> +preboot=setenv boot_targets; setenv modeboot; run board_setup; usb start
>   usb_pgood_delay=1000
>   
>   # SOM specific boot methods

Applied.
M
