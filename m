Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295A7C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F2A8070F;
	Mon,  3 Feb 2025 10:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="spmKYDtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D6B807DC; Mon,  3 Feb 2025 10:33:51 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FAFC80608
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqXyJ+CafSKleNvkzacxFJNmf/4djOspz248LzPtiHdrDp7XkRehZUGjyOdL19Q2+Ytonc4mqZy4VwbX3PkHJw6GHhOWB23oOdIJd3n2pCG+MBgtLY0HITI7DjEEPBWDM7PBUCgL9ulkAPhR2xhOhKY4+hMxzODURdU3HEedVYedAEJkWwvt8KsnNQA7kqWsBcEeocgiqfJPT0frBF8X4sRlf1ITje+PVnCNvKJTzOTsqHCanZ/oFO0nDlsxlu1ca2oh5BhmyglPc3hbJz1zLRM6WkzyIPMuPvxQaR3cVPbqD0hT1MljrQAmGkTL1ySlBFSy8gPa6SEOOgDf3X5V/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwhAwFUgSRVjYtJzdH4O4AFsbe3LrkHmpMcstgJ3/+0=;
 b=KYtIIfN/W1qQX3N7nnMQ//wlhWRZBjorITXCclEpO+BUYmAqz1MhgY0vFPltSqi1RknNNEzVn7NibeYn1M1nrNj74IEQlVKT9a3Z7XyqlMUQ6UD4tlujP3euuDU76NWtGkj3wHt9jnSlTyjFsn1XtqEtCH4pIQO1G6GFIKCSdflLPmMC0o7ypdJfZwkvw2BxKqe85Ljpu3BrZAZc+MyVKu3pd+V+MA45cFh7pZtARghJ7v3rFg5ih3lPq4nl1kK2YUTbxQlzB1pI/wgv9xgngrBIjNlRbyKXT4cO0D48CrMMOyEczyUa7A6XjyyklbRT5LHYxo8XZy7SGzfx2skH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwhAwFUgSRVjYtJzdH4O4AFsbe3LrkHmpMcstgJ3/+0=;
 b=spmKYDtYKQ9ZVOogmW7XQu//HlYCeNcELH3/id7e9W9QHnTgdvlvUDTLtdZNsF1sf/SIXvP/ea4VM7UrWrFM3LcL00Y6YaUt3npEp+8pn60gw2QrGI4xMhFXvG5N028s35DOHEpjfubqhrSqXM6BHuw/BXlhV5CkdaVg/Qio0/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 09:33:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 09:33:46 +0000
Message-ID: <ccd53865-de4e-4958-bf56-807b33466d68@amd.com>
Date: Mon, 3 Feb 2025 10:33:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: Enable meminfo command with mapping
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Srinivas Goud <srinivas.goud@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <b7f9f5e18e16a945277d4b8cfde5a7f057e77676.1737976295.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <b7f9f5e18e16a945277d4b8cfde5a7f057e77676.1737976295.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 34af2c5a-088c-4d2b-8a7a-08dd4435db70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGtnU3gxTTRyWGIrdkU4NmpmY3V3aTB4UGhaYk1kTVl6anZOWndibzcwUk1a?=
 =?utf-8?B?bzI1RjNHRzRkOWpRTFJzSU55bnhhdDBrRXZzWXRPZU5Id2FaRWhwOFBXNUlh?=
 =?utf-8?B?eGNRWlBOVUE4eTNNVmx3bHRPQ05XY2RyL2hITEV0M2JwMkkwUXRqaFEvREZu?=
 =?utf-8?B?cVkxd1k5alZFTlE5UWE2NVBmTTk3bkpqZi9CZHBMYzY1a2dKVWdvZlhMY3lB?=
 =?utf-8?B?d09Lb29SeVZlQW5mYiszbUxaeGJpRHhubGV3cEo4MDdVOUNCUFczSGhDWFd4?=
 =?utf-8?B?VmlvNjhoc1YxUEM4OVFTOFIwQXJNQlp0ck9qVngwVHpTMVEzeXVBV1U1SGFi?=
 =?utf-8?B?aGtxRy80MnFlZWl1UGxOM2pZL0dlcGZwd08raFB6d2xaT1FnMm5oN2pqbGY1?=
 =?utf-8?B?OWRCMDB6dDJUcm5ud3g1Q1BiTThqUHBPOHF0UnNtQ3liVSszQk41cVk0TG5Q?=
 =?utf-8?B?OFRvYnlRRzdMMDFLWndZNmVzYzBjSFUwMUsrWGI5T1ZZMjZsb3lRUU44YzMr?=
 =?utf-8?B?MGxJUG1qTlVrMFVMQjNNc01NZFZoRDhNZjRSWDNDSkdzU2hEaEhXZnNtSjZw?=
 =?utf-8?B?U3o0ek9CZHovTnVBeXB2bVJzNGRHWEpra0xsWnhRR0tGMjl4WktLc2YyZkRn?=
 =?utf-8?B?bzVXYXZHajBtWTBqOGpERWx4eTRWbE5mTFI2Wk1zS3NjeDhkVSswTXFiNTdZ?=
 =?utf-8?B?NkQrdGJqSnpZTWNiOXQ0NWpPQm1EcWtMVVB5ditJMFNXN1pKQ0p0ZFdFY3VZ?=
 =?utf-8?B?MjViYTR4Nk1KRnlyZWUxT1VQSmtCVnVLN2JjL0dpU3J4MkI1MFovcE1zQnpR?=
 =?utf-8?B?THdKa0VHbjl4SUlGTEZ1NlliNkxicEdVdWx4T2pPOUJVOHhYQXNiOHhlbVZ1?=
 =?utf-8?B?SlJqRVEyWU5FdG9VdEZTVmdhZUFmK2lyVXlFeDZzNSs5T3BTT2g5LzVYWUNh?=
 =?utf-8?B?WHk1SmVpOTN1aUdiMlowMDRESmtKc25KYXlWdzU3cGtxQ3UxVWpPSEUyaXFI?=
 =?utf-8?B?cFdZUzhiNy8yUlhTZGdOdCtkSVA2djY2eU9jZkRnSlYrbS84QTc4Sk1NU3Bj?=
 =?utf-8?B?QkhTdURScFcvMFp1VjltaXFLcWtvVGsxUURpVkt4bXZjaHM5c3AyL1UwekZp?=
 =?utf-8?B?TWVEZGpVYTZRK1VnT3lCZXllMGthMlVzS2h4NDM5QlhxUUk0b1pCa2hDN3lu?=
 =?utf-8?B?cEJwMmNxdWVpei9uZ3hkSGFkeG9GMGZHbjRSRVFOQkhFd1BseU5lbUd4U29Q?=
 =?utf-8?B?Q05TWlRmS2I5S0graFNsSnhBOWxFbmw4d0d6bHNId2Nmci9YOXpSdk9aekFi?=
 =?utf-8?B?U3ZxS0FUZ2JYOHR2RTh5Ym9zNDMrUkwwQUdWSFNQZjllQXBIc2l6Z2krOHFT?=
 =?utf-8?B?bktGVW5XbTlEZzBSSzl5Q0lQd1JURDdDMzIwYlMrcnh0MGV1VXZiQjY3OTIy?=
 =?utf-8?B?c3dwM3J1cGN4S2xpSkdpblMwZkhmTXc2eUxsWTdWYnEwejZXU2d2L1hQVC9W?=
 =?utf-8?B?RTR4RHJaRlBnNG51ajJqNkVwZmowd29VWWhxVGZXdHZWRzhEeDM0QVQySGpT?=
 =?utf-8?B?UUhraFdJYUFVdVRJOUNQelFMeWtpL2lnazZvYXQ2UkZNUHlTczdaeEhVSVNz?=
 =?utf-8?B?NmZwVnFUVGNJN2MydW9pbGRyTXY0ZjMwRFp0WnRjdlAvdUhvN2R3QzNVQnVT?=
 =?utf-8?B?KzJVZHJhTVVlQlJiMzQyWkp5b3RUMWJyVkFOK3dPTE5ZMGdpa0pEUDYzM0RQ?=
 =?utf-8?B?ZTNwRW5BdzJLU3I2cDUzRDZYblhGTno2NEFCVUtRck05VzU4R1o3ai9HenJI?=
 =?utf-8?B?WEw3RUNNWXJrem9tZGdtRktRTFJiWmovanJ5Q0FIN2duUHMwWkt4TFFucUdw?=
 =?utf-8?Q?4/BCfavFZIi1g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:es; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1JSQTNzS0hISzRKbUR6dVU4TzUzMlZsVy9uTjhYMjA5eXpGenlHd21xb1U3?=
 =?utf-8?B?Zkd0SExDcjlBWFA4VFBjRHdSVXQ0RlIxWWlNTWRIY29BVDlrOTUxR1RMeFN4?=
 =?utf-8?B?Qmc1LzErcHpxSEhJR1hDcHdGeXdLckN0aXVWRzBJc3ZUK3doN2tYNU9NQnBp?=
 =?utf-8?B?US9tMjZicE5jR3preFUzNVJtdGpaeU15bnRWWVg1Mkl3dWhkVVYveWpHQnQy?=
 =?utf-8?B?QUdBamw1Q3hXUVdzdS8yQVN3UkFxMXJGQzNKTWNhSWZDQml1RVdYTi8wMW96?=
 =?utf-8?B?M3ZkU1BUSGR3UDEzcXZQVVl6WWo2ZE13VEhIUGZSYXNWQmJTOEJyQTlFYTJk?=
 =?utf-8?B?bnhDQ2FqNFBQeG9vR205OW84OWlBU1ZrYStQTFlzdE5KL0svMFBQRGxyT29y?=
 =?utf-8?B?N3lISWtiblBFREF3bDJ2UlY0bXJMcmZyOUZJQVJkQ0FJSngxZU5FNjN6OVVF?=
 =?utf-8?B?MUhWWmlMMkw2bnVnWTFyamJnN2RNNXNPSHZ4TGZtRVBZVjFkOWZPN1FpdDhN?=
 =?utf-8?B?K2cwcElLY3NsNktEWEU0M1hIbGt5RDJrVWllSXhlVGt0Z3ArOWRkOXNRRU14?=
 =?utf-8?B?VHJ2ZkZ5dXhrQVVDYnhObm8zaXVIRThWd1RSU1grdTg5WTZLUFpRNWF0bmpq?=
 =?utf-8?B?TDdoSEhzWS9VcGRhT0RBRUYyYkUyeGdKRXZIdUREaEg2Wkl2ejJUWGJqUGZn?=
 =?utf-8?B?RVNZaFJMZTlYMlg1dzMyMlp5K2JvSDFPSmc2WFl1eS93eTMvd3dlbFV4QUFl?=
 =?utf-8?B?aWtLbGM4bG9SdlFSODlBSWhRQjg3cFdjcXQxZ05BVWJKZDNIRVZBYytQd1kz?=
 =?utf-8?B?VjF4VGRwd2FKTzNVSGdEVHFMTThNMTArNWJzdEgzQzUxdHZLZUl2a3VnSTBh?=
 =?utf-8?B?MzdMV3hTUmNGMml0a3k0M3VxbU9JVURLbHAzWXBhQVllYnBhMjk3ZUN2VGlo?=
 =?utf-8?B?SWdVRWJCaTZnTFB1SGdZZUdhVkMzSmRrb09qL3hpR1lOTys0R2szZzAyNkgw?=
 =?utf-8?B?MnZOUTZEazVlcC9FVXpDdVZjMVhSYjR3aXpLWS9wZFAxbU9XcEF2UURLcWow?=
 =?utf-8?B?eE8vc0dXd3BkYXM3TU5ZSkxCcVRnYzcxUWNVV20rUCtRVTh3dGdHbloyWmtN?=
 =?utf-8?B?YnZ0cHZhMUJyNjV4clUrTGtLOTRYOEI0SnowZGNTOURqVEhnWXZLUkIxZXl1?=
 =?utf-8?B?ZXRiQjdFUStCSy9YcXZxMHU5U3NQNC85VXpwa3ZFVEtOTVpjZFg5SWhyV3di?=
 =?utf-8?B?UTR4OWtDY0J5VVZuUFVhQXdKdEN1VTFXd1hZUjRFMyswUjUwSCs1eW5lTW1j?=
 =?utf-8?B?bGs5NVFub0JKVWpZT05QYk40NEJlcE5JbjFiQlp3bUVkcDZ4d2xjK3F5UE1C?=
 =?utf-8?B?MzZkekR1VDdOMjVxbUs2dmczNG1SeTBtWW5wemRMRnlxUklyVnZaRFNLSHdL?=
 =?utf-8?B?aVIwS1hMMUdDVGlaQXpWU1VwWFhiUG1wT2dMRVRmS1BUY2wyRVg0NkQ1S1RN?=
 =?utf-8?B?bENNSUhZQW90ZDBnUS9uUWNUVm9lRjFrWFBEMzhRSkRSTks5TDJmSm41OU5S?=
 =?utf-8?B?enlJb1NVSjVzVjlkUWxUMjNoQWNXdEdHTFFOdTNzMnBUQWpuOWRGemNTNVQx?=
 =?utf-8?B?NE9PWjR0NHUvdDN2N0w0a29OQWdkSVE0eUdHRW9Qc1RSS0pwQVpLRytxUnVi?=
 =?utf-8?B?YXc3ZWZQTlZuNkZYd2lHTnZaVHU5UCtyTnczTUVENnNJc3h6TVlpQVpoUDQ3?=
 =?utf-8?B?dWhYSzhwcW5wcDBHLzMrR0Fhc2FuTitGUktCbTI2RzYwT3h2d3UrZVVqNVF6?=
 =?utf-8?B?TlFPaEl4Y0ZGdG1FaStLUnpUb2dGSXFpblg5MDdjcVA4Sks1dTNxTkVPbnJj?=
 =?utf-8?B?bFBMK1RuTjVRNzg1MTBiU0RhR2lXVkVYc21NVnI3QzZHc2hmSFh3cUpJSUNt?=
 =?utf-8?B?Nkx1Q2NTOEdPUGo4ZU5qcVkyOEpiUHV0eHlFcjFjQzVoYlJrdkZoMEhEM3RP?=
 =?utf-8?B?TUFpRVVrWHVZdHJHSHpqSzc4N3YvNGRrbmF0SFpLeWJZcmRwd0E5SHBKdXkv?=
 =?utf-8?B?RlB6ZENSRmZDL2UvUzc3VmVpUW00WHRaalBlc3pnUVNlWVpIaVBBRjB5TzFP?=
 =?utf-8?Q?PQoDfo/9uqPVIJAX5WKYASjFe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34af2c5a-088c-4d2b-8a7a-08dd4435db70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:33:46.4623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvlP7aKnw6KKJzcGRQp9XoBzNGBeHgRJ1kKx8KXKQBywQiqmfKgdYeq2xykNfoZT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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



On 1/27/25 12:11, Michal Simek wrote:
> Enable meminfo command to be able to see where things are mapped.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Also cover Kria
> 
>   configs/amd_versal2_virt_defconfig       | 2 ++
>   configs/microblaze-generic_defconfig     | 2 ++
>   configs/xilinx_versal_net_virt_defconfig | 2 ++
>   configs/xilinx_versal_virt_defconfig     | 2 ++
>   configs/xilinx_zynq_virt_defconfig       | 2 ++
>   configs/xilinx_zynqmp_kria_defconfig     | 2 ++
>   configs/xilinx_zynqmp_virt_defconfig     | 2 ++
>   7 files changed, 14 insertions(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 22dad1b7076b..a7d8b035a714 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -30,6 +30,8 @@ CONFIG_SYS_PROMPT="versal2> "
>   CONFIG_CMD_BOOTMENU=y
>   CONFIG_CMD_GREPENV=y
>   CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_MEMTEST=y
>   CONFIG_SYS_ALT_MEMTEST=y
>   CONFIG_CMD_SHA1SUM=y
> diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
> index 2e618d81544d..87756cb26df5 100644
> --- a/configs/microblaze-generic_defconfig
> +++ b/configs/microblaze-generic_defconfig
> @@ -42,6 +42,8 @@ CONFIG_CMD_IMLS=y
>   CONFIG_CMD_SPL=y
>   CONFIG_CMD_ASKENV=y
>   CONFIG_CMD_GREPENV=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_SAVES=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index b40f7b7f8556..081ad424a9aa 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -32,6 +32,8 @@ CONFIG_CMD_SMBIOS=y
>   CONFIG_CMD_BOOTMENU=y
>   CONFIG_CMD_GREPENV=y
>   CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_MEMTEST=y
>   CONFIG_SYS_ALT_MEMTEST=y
>   CONFIG_CMD_SHA1SUM=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index ccbd33ee1cf7..dd6e3ca34660 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -38,6 +38,8 @@ CONFIG_CMD_SMBIOS=y
>   CONFIG_CMD_BOOTMENU=y
>   CONFIG_CMD_GREPENV=y
>   CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_MEMTEST=y
>   CONFIG_SYS_ALT_MEMTEST=y
>   CONFIG_CMD_SHA1SUM=y
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index ed3d10194857..c2422c5b4dcf 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -56,6 +56,8 @@ CONFIG_CMD_IMLS=y
>   CONFIG_CMD_THOR_DOWNLOAD=y
>   CONFIG_THOR_RESET_OFF=y
>   CONFIG_CMD_GREPENV=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_MEMTEST=y
>   CONFIG_SYS_ALT_MEMTEST=y
>   CONFIG_CMD_DFU=y
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index a68bd522f90a..ce44148dc0bc 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -63,6 +63,8 @@ CONFIG_CMD_SMBIOS=y
>   CONFIG_CMD_BOOTMENU=y
>   CONFIG_CMD_GREPENV=y
>   CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_MEMTEST=y
>   CONFIG_SYS_ALT_MEMTEST=y
>   CONFIG_CMD_SHA1SUM=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index b13079cdf707..05ead1a41b4d 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -63,6 +63,8 @@ CONFIG_CMD_THOR_DOWNLOAD=y
>   CONFIG_THOR_RESET_OFF=y
>   CONFIG_CMD_GREPENV=y
>   CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_MEMTEST=y
>   CONFIG_SYS_ALT_MEMTEST=y
>   CONFIG_CMD_SHA1SUM=y

Applied.
M
