Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F64FCA0FFB
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D7688319C;
	Wed, 27 Aug 2025 09:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="JlkPaEYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D4B7831BB; Wed, 27 Aug 2025 09:57:00 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A0883145
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxCYQUAustCObAbozdz2if00f3TiBpEl2wSiZpj0wd3LGIyabycYrZXD1nq6/gevVk1Igdkk7A4mPSDfHiYsThcG6ugefLjpveH79s1gpPUz/hYrtd8DYMZfUd6mUiXlWtBjU0YD2XLN4eJ8AEP9/eIglB446TFuK4ZuQbyi+JATAF3048R/X08uf8mqzhUI0hnjWA4SGNLehPuBnM59+JhR203GTBTFnSa3U9hihZ4JFGVfKwp8XK6U9+VvSmaeE+hUCPgD/0/Q6CdPLdWXLrUQWqdEl82ZBaN9CV1C2ABLPeG17yiIUD7d5ZTIQTtNRyIeV0Vm4/2+FzNfYTRvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ctdr8Aj9lsKH3SCS9UbslGywb38LKPRDAcPcxNVt7fk=;
 b=qy1oYHtOth+ES3E5hD1uQ47rZwlVypVwzP3UlvvZdb509fZZkoXvbsgO0vYi6zEQ6zy+Uy9enO4LT1Z9eX3Na2rE+K4moKSn5xhzQqrUBIvOKRIKpHgwn62/K21wwjT7x8t7BprJP9wexpsiLk7VgonUszh3haWarPuYwOc6mCtZbqmOECGYNhHMoqB7ln2tGo6TJmwnATABwgvldKtJlNmnXqovtzR0o9LLV4qqqXlxjLrG3N7FUnuHvLVS2jVtM54I7rJgqs5BUqyqG/5+9er3ikQ7IucCN3OddGXILv1xlEw1NSpsSCla8yVVI2rBBZZHP4oUy3tWVBuq+wpZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctdr8Aj9lsKH3SCS9UbslGywb38LKPRDAcPcxNVt7fk=;
 b=JlkPaEYr3iJJwjpsyC+325+j0oxjHUDWmvT6+XaWFhOtTEUf0QnrrbhOZ/oj1qRP1WAj85DNOnvSzpPbBkFrKbiOe1oxgmXl7rrM96OerYdz49ArSkyoW7j24qaXCfbDSZRVwbMJns0GpG7zUlMA56Z9ogixUIs5a5D8xo2+hZVeRh84Age2TaB7bThWPaRRRa5dIquGIjzrq270ql5eUifHk/TbW+2lSTQKWXHfOXDY6dQP/s528iuEPMQu6SwOqMy+UWxvViJGNmYY3OB991FzNu2hmE4ZzlAk0I8tsOPgsQppGQAWzUJXygsNajUgk6Dlh+6YOvZ8qR0t/GH/hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV1PR10MB8776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 07:56:52 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Wed, 27 Aug 2025
 07:56:52 +0000
Message-ID: <6a1f7dea-75a0-45d7-9bf1-70c651832438@kontron.de>
Date: Wed, 27 Aug 2025 09:56:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] power: regulator: tps65941: Cannot test unsigned for
 being negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-6-42a4105336ec@linaro.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250807-pwr_regulator-v1-6-42a4105336ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV1PR10MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 5385c110-0a25-4fc5-17fb-08dde53f48cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alQ4Zk1Ja1RZaWxvRW4rbFo4NUpQTFZRMU8wZTV2WnFxZUF6R3VTaUtIa2VR?=
 =?utf-8?B?bGpqSDNGNjdVdHorc1hsUDdXM08rbjQrYVVkR0dISExHbzk2Mm5Wall2RmVv?=
 =?utf-8?B?UkRXUEpscmY0OW1CR2JnNVByQWdtY1VTR0hDOHZJamhXaTJVR21BRWwrWUZi?=
 =?utf-8?B?N205NlZYNlFpbERjcW9nMlRPbVp0eWFjU1M0dE85aVYzTlNyblNwNWJpOW1k?=
 =?utf-8?B?QmFpVmowRHpOYW5KUTE2cmozVUx3YXBxRUhqTGhLd0VvTW50QU5NUlYwVWVm?=
 =?utf-8?B?T3R6cWhNTVl1TFYxbXA5aVorZ1U1Z2pyREFBdjY0bkZhajZOWThvY0MxWUNp?=
 =?utf-8?B?dTNEdW1oVS9JdDQyV1VlbTY5RDBHVjBYSkNPaXdMbE1XV25uMCtyTUJNd0t2?=
 =?utf-8?B?VVBpbUN6Qm5tNGJHNW0yU0ZxbG9OcW5ZNldRdEhvK1QreUY5cEdheHZ2a0la?=
 =?utf-8?B?UUNnNmFCWmo2dWlxb3g1OG8xdU1iS3VTVDhKNUkxdjdUSGZja2VjL3YxZmRQ?=
 =?utf-8?B?QWIrSGVIOWpFdUErWFcydUdIQ2MxY2Q0UE5RM1cyUmpsUXJXSHZ0MGFWK2JJ?=
 =?utf-8?B?Zm81bUsyT3c3ZnBNT2Q1SGtjWFdnbEtlMTlEYy8yWDk3aGd1ZGh0cWxYNmlz?=
 =?utf-8?B?a3RMSnBxbWRDUlk0dVV3VWNrLzhpUzNTUXl6UCt4WGZKMzFsNHFtdjVSL2hP?=
 =?utf-8?B?bld4Vm1lUUxUam9PZVM2TEFibDNzMkN2V1p3alRWU0JMVzhkNmZZN0kyNjh1?=
 =?utf-8?B?VktwSkhqbzhIRE8zSHlvZURSRm9HV2xpZERPNmxmTkxlNm9GUGVFYkVDR1VT?=
 =?utf-8?B?Vlc1WEx6S3MyM1hueGhYYVVGZm9QYmYzbEQxalZBNG1RUDRCdS9aSVFmRDhI?=
 =?utf-8?B?OFNKSW5hY2lwOEoxL2s5d1pFNDlNY096cG9pMHVNVExoN2ZLREJGMVlJSmdu?=
 =?utf-8?B?YVcySXlVWS84Ry9QbTFUYm5nWi9pZW1MeUVMRmpGUlRpTlFVQ0pycjhubnJC?=
 =?utf-8?B?VHlmYWdRUThkcE5vUVBQL1FLbXQ4blBIZElnU1ZYQi9BMkFLSEZ3N0o0UFRU?=
 =?utf-8?B?aFlMdHhYR3NCRktjM081N1VTcUZma0gzMHhveDBQZ0lWWWtQMForMVh3UFhI?=
 =?utf-8?B?YmlVR0dCdXFKV2hqK0xFSGtwNXNublEzMFlzTVduV1pzRWprY0I1Wi8rTnVB?=
 =?utf-8?B?KzBmNy9JOHpGTnM3OW9MbzVXNVhxek9uQnNqQ0FtWHlOUlZ6anh3LzcrQi9B?=
 =?utf-8?B?ekUrb1FEczZiS0RhNThzUmNiRHF4NUYrYWEvd0x0eGVSWnF4R01aSkRrQjBo?=
 =?utf-8?B?WjBZNkc3eWZnMlhhNEV1eEN3MnJBQjFkUlJicGdpVjFTa3lSYlRXVXpPb1Ju?=
 =?utf-8?B?dVlHaUMza0J0VjFQVjd6b2d0a1IxcksvSk5UOWxXUHMyOEtSSFJsd2R3clNY?=
 =?utf-8?B?THhOeTZVdDNpTk9GUFgvR2NDa1NRWUlxTmUrQjE2bFBTM01YRUw0cWRSY2c2?=
 =?utf-8?B?Qkh3WEpnMkpDNWFwblE1VVJpL3RzVkU5cnZWc04weFRkLzJPSDhCSTJDMjdR?=
 =?utf-8?B?QnRPcjMzMTFVOVNZWmx4OGJMM21TNWpkczFib09MTmFDbHBKN1JIdTN6QUZp?=
 =?utf-8?B?M1dVT2ZXQTJ6ejZScXZyUWJybEdldXZxMDlJTDN3bW1GUTlJNi9abFJUS3Ey?=
 =?utf-8?B?MGh5RTdET243dXpyMXduOWJoZWFwY0VZYXlZV2NaSDgvMGcvWnJLamtWVDZR?=
 =?utf-8?B?cC9jTXEyZFpSbUpmMjE1Y1Z1elUvWFU2U09jNXVWTDlrKzZRRTVnNGNFaTB5?=
 =?utf-8?B?TzJiVmpTSzloeTRkTUJNVWZPTmtxUDRCK0JkMjM0dDR6U09xNU5DV0FZRUMz?=
 =?utf-8?B?SkdpWXgzZU9UWHZhR1lWRkdkaEF2ZGtja0F2dnFMYlpsd040eGQrc3piK3pC?=
 =?utf-8?Q?dpUZa2kEUMg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzV2N2thVXhtV1lUb2Qwa1hIR2FFWThvTkdORkNOZVhXZG9uMEhmdnNQVkhh?=
 =?utf-8?B?MG9xQ1ZMS0pBOEVRbTd6MHVmOThOVDJ4TkRaTytnUEx3V0w2clI0QVFIODU1?=
 =?utf-8?B?L0VtZHJmNm1LRm9Ubk5paEZKSGpGSk02RVA5K0krRWhvWHpyOTA5cHNpYkIr?=
 =?utf-8?B?azBobGJHWTZhUW9kUjFJYWNidTk2SjRYUVRzdGhKRTNIZlFIZ0JWNkFEVXY5?=
 =?utf-8?B?NThybU9SQzhpbEprT296QnZIaHpHVXlJbWpkbmp5a2ZzaG0zVi9BVmx2MHFX?=
 =?utf-8?B?c1kya1JBOXBQaWdEK1pwNzFtZFcyd3lJTjRDdnUrTXQ0UndEb21EOUlVeXB6?=
 =?utf-8?B?dUFYK00zVGtjNVBQK04yNnkzZXU3OXlhOTBlVHovSE1iMmRaSmJvc2syTmhv?=
 =?utf-8?B?a3hEUHFOVzVGV1E5WGRGTkhZS0VuMjYvcG1MNDZtMVFIZTdMOHcvQmxkMjdL?=
 =?utf-8?B?TGdyVERrdkFHYkVKQnRkTEZ2UDRnRGs0WWJTbjAxanBPR1gzQlRhSlMrbnV1?=
 =?utf-8?B?RVhtZmR0Z1piMngwSG9kODdHWTJ4TmFSSmhPcmg1VlZiY3BZVW84cWlaOWNa?=
 =?utf-8?B?eEtpdU9Nak8vdnBaQll4UW10TnlWeE9KWjhDQjd0Y0xEeHg0Q3E2UC9YZDNI?=
 =?utf-8?B?L3UzUG41RzJRNUZrZk9MUVFWbjR2YWtuMnpSbFpFVWpHY3JQbS9RcjZnbkU0?=
 =?utf-8?B?RkdObDUvTHpZQTIwY1l0V2J4TGJWYVFNSXp3VWtnVmd2a1dtU1NVbmxXYVox?=
 =?utf-8?B?bkVMMnVGMjBJODMyU3hHdmI1ekVyamJNTHhEK1htY2hUSUZ4NHFXZ293eVVo?=
 =?utf-8?B?bVRITEFVS1poNFBVSWVSRmR0NHlva0x5ejlHeEM4dS84MFNKZHBPeHhqVHVk?=
 =?utf-8?B?REx6TnlGYTB0VDdwNCtiSGRsT3dGWUs2TGNZNy9BQmlVUnp5NnJITURvUG5l?=
 =?utf-8?B?aG9yRDNmRGRmZVZYSEQ5Si9wWFFhZms5dlFWWk14REJCQ2NCNFZFU2Q5UzhM?=
 =?utf-8?B?N0FndkE0bHRxTFFSdWxmVWNZczVoT0JWbkV4QVhZdnBUNUwyeXhKbXdmS1Jj?=
 =?utf-8?B?QXVkbDQrSjQ3R2FRRDRHM1MwV2ZEcGM0b1diaG03Y0E1S0RvUnZJQmJObGhs?=
 =?utf-8?B?VGx6OWl0Q1A3SDZJRU83eFlrWmlsUTRYWlBINUtST3BMUHZsSWFBWEh6Q05n?=
 =?utf-8?B?WEtoejVnM05EMUU4aUNheDlLREFoUE5kRFRMTUR3NC9mcHI5S3FKNnd6Rldx?=
 =?utf-8?B?Rll0eU9qNS9WNHAwY1E2cTVHWVVWTi9TZEl2L2hWZ0VzNVFzYTd3bGVRVGsz?=
 =?utf-8?B?NzhRVFlJQVpvODVNTVFjeUJMeXNQQTlVYlU0Zng4OFNNaGxhOXVDZkZDNXVl?=
 =?utf-8?B?UkFKYlVPcXdOR1hQMmFWclBMa1B1QW5xWEI4MFVXVmZsY0REbmdBUDdUYWND?=
 =?utf-8?B?aHdJZnFTWDRwbEV0ZEx4UnloR3FWcFBLSkRXWmFucXA5ZEZZTjJwVzUvdHM3?=
 =?utf-8?B?SzJPbXhqRCtncmRIWHorTXZ0TmQ1Y0NBM2JYaW1uUTNsT0tCek5JWWlEUjQ2?=
 =?utf-8?B?Y05kRXo0aEdRcU93THQrRXMrTXFkVjFiN3RraTNvRzJwSVp3WE1KWE1sSGxx?=
 =?utf-8?B?NG4vQnBUcU8zMm9GTklYdmkwYmpoblBIcHRPZ1AyL0xYMExKclVWcjlzVkUy?=
 =?utf-8?B?QVJFUkEyMkxDRSs3Z2hPYzZNOUE4SEhzaDM4WGxGbEswZFNVSlhXb1p5UE50?=
 =?utf-8?B?NW1GVlpGeit4ZW1oNWYwZFdJNG04VlJUR1pqTXNiOHdTcUpJb1BvWloyNyti?=
 =?utf-8?B?OFhrZHRsQXlBNnExNWFJTUZYNFdNODl1a25SRDdVMVVlTXBaTFBMeG1FZWs2?=
 =?utf-8?B?WEJQZmtETnloeGpSUEU1UGFCczhjTDN4b0JRU3VqcGxLYy9qYUIzMzdCMHVt?=
 =?utf-8?B?VEVCZncyVzdoaWJESWE3VDUrYkJaT1NyOGZSWS9tMXlLT0JzTjZqS05MTTZM?=
 =?utf-8?B?SWlyc0c5Uis2SllvTkdIY3FBVGw4eXpxNVQrYzFsQ1N2di96RFF0RGs0NUZI?=
 =?utf-8?B?bzYwQTZJUjQwUFlZRDdWV1VtQllpRSs3VzRPSjYybjJuODRiRWJ6OS9wck5R?=
 =?utf-8?B?ZGRHdXJLdWZ6endjc1dENVkzK21EMkJDNHBaSFA0YlVkbGlIODlycTduVmFt?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5385c110-0a25-4fc5-17fb-08dde53f48cf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:56:52.5356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzxtS8/i/jJYCMw6PDhsspUBhZxGDtrOzB+hPRK6oFKfdYfxmRBGeFDH2JD0hdf+0Q6fU9QC3QvMhLEfh0X/EhS1UMfPRzNeNzvcrTYejYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8776
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

Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
> In tps65941_buck_val and tps65941_ldo_val hex is an unsigned variable
> being assigned the return value from a function that returns int. Change
> hex to be an int so that the following test for an error as a negative
> value will work as expected.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
