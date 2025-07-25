Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C87EC87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E9C839AC;
	Fri, 25 Jul 2025 15:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WX+nT4jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 081E1839AD; Fri, 25 Jul 2025 15:29:43 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E3C83993
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go2QAPMhc4L/YfMFDFAo7vThorV3cUeapPHcLgdUJZBTqHmyyciZ7OboJRm7r5bGosRuAgxfGLbdw0rGiWoz3SW4iAF+F+Olp0xLNqDCAYvy8Fmx3zM6SXS0EMJegH3GYkAcaNI9X3HzWgvQJn1oNSDdPEOLuH2iTtjtyXkNorFMZPnJqogeX6s1kvHBrdfHfrnRJRhGJDsAZDEMTpPNwqYCrXe11z6K4C5y41kpCCXLXq+z2FcfnWe7jYmcb6Yszrzpxm0KTiipjLtG2U14S5UdC+PZRCk+pf9ZChV+pgmvYM5gnrw4PWoe+HubQlFFV5b32zFhabZby6hoSaxB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvtbJiSKYZWXUezE/lr/rPh5Oxg40lewBjvnELyRt08=;
 b=Pm1GNaJ1nQ3j8RKDD9PV3UOY5GHwh0k6Ut2dsxcM6+dolv5mCM3NZFL7DH9xMoUQeuZYcPKCUV0xOFy9DyaoKTrZ0D8ObP9KeI6CoZdU996HFX82V3j9YOi+QnUQmxJf8RISueyGMBbFCIB3ct0Dbok6PduUG7l5X3PobumMzTErN19Z1I6UfTTgvTwDeyKxVLcIEdGhzz/hiP35dEcAHFwnWcePFwlWW9BAqqIqZhg6gVASc3rga5vpGbkstNGqhrAW8kN4RBlCkmgFFuE7eylHQ2RNWwHWbU+Cj55b6bArFMIxWtH2cpc98w8tva0VbUrwmkZiAl3HZWYgSc5saw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvtbJiSKYZWXUezE/lr/rPh5Oxg40lewBjvnELyRt08=;
 b=WX+nT4jwAVNvVeNh6QbUcJyvp+PITCLqAXWzNw3O+FrDDqsOlZqfSQcgza4YJ+Wa1PW2ibUba6rIeT+0O8Mo6a5YJdQ7KwvC31TazKUp5un20nQYT+TCt+ejAv5/WSxle2LPJBpyoMbBP8O7mMve114nPtbIJjgcZy3fIf3/3Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 13:29:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 13:29:36 +0000
Message-ID: <7aaba571-eb98-4e54-a11e-2cd05a1cc035@amd.com>
Date: Fri, 25 Jul 2025 15:29:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exception: Add missing string.h
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, git@xilinx.com, u-boot@lists.denx.de
References: <e9b3fd74e233ea783e64fe1d1c3de5d4f3c6610c.1753447310.git.michal.simek@amd.com>
 <a745fa32-44cc-4671-811f-c9eae8a092e7@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <a745fa32-44cc-4671-811f-c9eae8a092e7@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c33987-8a0a-4f74-3807-08ddcb7f4cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTFISWhiL05nYU5hbE9jMnVjUW5zTDdzL25Ec05zYUh2VUJOT1RqSEh1Rjhu?=
 =?utf-8?B?TlZxTGpkRVdXcHlVL1Q3eHV4ZHFCdmVWcHdmSmxLbzVkS1NwaDA2TE44WmVm?=
 =?utf-8?B?UXEzN1JmeEVwY1JERHNEVmd5cEUxVklrQklYcFBQV3BrL1RDdWtwb3VKam14?=
 =?utf-8?B?bGZhK0JZakRtOXovWFpRMnk3Tm0vS3VtN0s1NnZCTW5xMFVkWndzQVQ1TEdB?=
 =?utf-8?B?RXFlS0NzQzFQNU5uZ2xKT01zKzJzYVJENlFCTXQ3RFJTSHJIZXpBSmt3ck1J?=
 =?utf-8?B?NTJMVkplY2llRG84aUtldWJUQXN1UnIzOE1JaFBKd2R6eE13Q3dYbDFneFVU?=
 =?utf-8?B?cG8xUVh0Yko2LzYyNnZhanNURlVaakJLTHJGYjZkaklyTjdraUVvR3BVWEZH?=
 =?utf-8?B?UUZjcjRGUGRMM0RtaXlmaEI5TGpqekg4ZEQ2NW4ycU9XR0dQWnZmSEhzZ3dj?=
 =?utf-8?B?WExPbWZvNDRzZFowSGpWeFJmeFhhblFUSFBSU21EUTVxbmYyY1ZmS0owbmlN?=
 =?utf-8?B?c0JEK1FNVUhIZnlWck05SGFJdGJCOWdzbWRjSWJtbHJpbXJaeWp0TXZwaGdN?=
 =?utf-8?B?aE9LUGhQRUJDY0tpcDBuR3laYXVzbEJBY2FCTXBZNkE3S2tER3Q0aGh2Uzdh?=
 =?utf-8?B?aGJ5a2JHbnZPa2ZRRlVVQzd5eDJXNTVaUXBPVm44R09DcXNmWHo4SUtCdUQv?=
 =?utf-8?B?M1ZNMW1aL3Z6OGJhck1ETnRvZnZSQjBxcDBXNzJ5blNuV1FxSitVNDFvSTdT?=
 =?utf-8?B?b3FLQmFoaTg5ZlRjZHBWZUVYbVZtQXRTVTZnalBieWNOWWtXeFJIUTVtczll?=
 =?utf-8?B?TndQSVpIMDNpZXdrcS8zUjNoeS84bWRaekV2UDFQS1lTUjdabXNBdHpwNkJW?=
 =?utf-8?B?UVRpc0xVUURvUkJyUFhSSE5NR2JZTG5TUTdQVFd2QzNyOGJKN3k0K21ORTNq?=
 =?utf-8?B?Tko3YUsrZ0gvM2ZEeWpzNjBIcFpCTFVkYmJuczZtV1dia3NYYXk2aE5ka2JO?=
 =?utf-8?B?b0tWTE1FVGJHSE5COHVCQjlOVWdvSVpaNm43M2RPOG14VXVDbG9RYys2SElq?=
 =?utf-8?B?eGZIRVg3ZUYrVHdDU1RWbmtjWWZ6M1cvdm9FaTdEUzBuYmgyTWorUm1pS1Vl?=
 =?utf-8?B?MFJoUGJERnZOVVd0b0dBamNtV3NtMklKRTFjdHNaL1VmU1Bicyt5ZjhGNkxH?=
 =?utf-8?B?YVFScnJQUDFaZ3htWlMvUGkxRWtnTHpSOXl1RkdvVjZxVWJEaGdlSDhnM1RX?=
 =?utf-8?B?Wkg1OTVWWE50eG4ycUVaT3kvM3V0UHRML2QzaGNVVG5RU04zVDFQNWw5WW90?=
 =?utf-8?B?anNUT243V2haTlJ5dTFQeml2clcxbnFBSmdTa3duRDV4UDFaVHkzN2tVSzM4?=
 =?utf-8?B?YmtlUW1mN2NldlVvU1dlT3pYVG1qd01MMlJvbjh5SkdsOHcxdFE2bE9qNjZ1?=
 =?utf-8?B?QnMxUUhqRDM5K2xub3dXSEtybTBLN0RmK1FpTUtKUlVnWFltTHhlUUVrSTdY?=
 =?utf-8?B?OXVYa29DM0ozQnV1cGdZYVJmSFhNb0VYK2sxN2RMTm9ITTJhbW82WlNKbDdO?=
 =?utf-8?B?ZFd6eGtEcXNEMlh2TXJmbHVtZmtlZkszdVJpSS9UakhRT0dDWG12N0ZhNTVp?=
 =?utf-8?B?c1ovUlBKcVBoSGhqMlk1QnJJc0RzRFV0d2dxc3owb21hS0w1bmpkZkxCeDFk?=
 =?utf-8?B?ZS9sMHEwcG5UYXVMVHVxVEZvYUFnTGhGaDJqSk04S1FLU2lSNHE1ZGxCVklK?=
 =?utf-8?B?czJFb1ROWC9QSXlXOVFnZ1dhWjZMQktabHR5VmFIV1Zqc25tUi9XR1krcCtE?=
 =?utf-8?B?SDRHTXcvcWM5Zm0yRS9oM3JkMlFRVnRab2ExQ3plNmRPcjB0K1pwZE8zUFEv?=
 =?utf-8?B?S0hLd0lONitwU3dFWFVDcDJ4T0ZvSFA3ZFFzYVNvbERGRkJ3UERTZUNBRTli?=
 =?utf-8?Q?4jx9hCAaxZo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTlZUmVrVU5CN2lxYTU5ZFFoaDF1OEdoQUxLdUNhb1graDRZQnNOTStCbXBz?=
 =?utf-8?B?Y001L3lVclZId3lxeVozK284eE9oeFkwdElCdkFDNXg2VzdQWGdiTmEvT3hG?=
 =?utf-8?B?T2NhTVpRNmJQQis3aFFIVEtMMWEzeWpuQ29sUWRlUEd2U1NjRUJNNkV3WmVT?=
 =?utf-8?B?RUQ1Z1lxOTMvWmRsZldkeE1xQ2pQeVNoV2dVOWNFcDl4Rk1TTWJ4Q2o1Vmg1?=
 =?utf-8?B?OEd0djg1RXZkcCtwU2J1UDczYkdOVVV0U1VEZk5sS0RzK0hLY0hCdHB6aFN1?=
 =?utf-8?B?bGJOc2t5TEZoWEVQNzByd1MyeDN5ck1wNk5FNnJ4a0wyK0hEVkhXcEFWVlor?=
 =?utf-8?B?KzVib0w5YnU3cWxaZ0kwSHhub016bkJUL1JnbndZNTlPUGlvZHZjTDZVeWww?=
 =?utf-8?B?SmcyUlJvRzVlT3BBN1FDK1hZNktzbWRyRkNWL0Y4b0dNN2RsUFJvaWdZUXBo?=
 =?utf-8?B?K3hiR3o1WUI3SWFaZTBvWm5DeTRKdHBwYzdveFBtWjltUUl2Slducy9HN1Q1?=
 =?utf-8?B?OERTVjVhVi9pL0NWdnptTUg0K1NWTStrZEJSWXNseHZJeWlrMlZoN01Lc0ZI?=
 =?utf-8?B?UG84M2FCQmpoVUQ5dnlyZEEwSlB5VkRJY0s4MktCalViY3dyZVpBYUlBMjVk?=
 =?utf-8?B?eXVFNytGSEU1V0E3OTNMZWtoSTN0ZWNwWG5sY05CME92OExnTCs4b0MzNG5w?=
 =?utf-8?B?ZmZrWThuN1pwU014ZDVWanM0WHZyQ1IyMTN2bnVlQnVrdUoxMktyV0hiSk1m?=
 =?utf-8?B?N0Rmd0NvZnJWZmJKYmFJeHZSVmM1SzVmdnVFU1J2MXVheDNSM2NlaFd1T2xI?=
 =?utf-8?B?dVNERHBtczRzTjhzdjlJeklwUzhJVHZxU1ZqSzFNbUF0NEgrNm9mWHRZYVhR?=
 =?utf-8?B?MjFwTE54MUVxUXlSZmVFTEp2MjhaSVJ2NUNaZStteVllZ3RhNFdMRTMyMUx6?=
 =?utf-8?B?L3diOStvUFdmenMrczdHdXpXWS9IaWFXZ3gvNUs1a3RDVEhBdk1DUWpQQlZv?=
 =?utf-8?B?cHNOVVZCaVEySVNTbnFQRXpVSjdOWVBBUG1SMWJXcFFrZGxOZnp0MSs2RGhC?=
 =?utf-8?B?SXVTa2o0M0o5T05Sd09XNitiOGlCQ3hrc2FrUm1JOWRQK2RTcXhLckM3eWdJ?=
 =?utf-8?B?RHVHSGlnNTZIWEEvVEhhYksvTGxxWDdubVlmaUx1dFhwa2Y5TzlzeUJNam1l?=
 =?utf-8?B?ZFlNMnJoOXViTk8xRjl2NTJhWmw4ZmJYaWMrTHgvdHZGWGJLVFVRTlUrMlJU?=
 =?utf-8?B?NEdnVWtsUEhKbDJKNnhTcnMzdGxMZFI0UmFYclV0cVp0RWdnRC9RbDBoaDR5?=
 =?utf-8?B?Y28raGdaNGZyVEd3WUtmL1F5dHE5d1dUVEQvZExHUG1hN1hkOHZSNzhRZEV4?=
 =?utf-8?B?ei9FMkJ4Rm1xYUlNQmpJUmFCaG56bHgwQm5TQ3JORVpHZFBMT0ZpZXFOQWt4?=
 =?utf-8?B?MHUvTTIzc3JGNEdMeWhvK1dXQ3lBMVZnTFhEVmtER3F1Y0FaNS9UVlg1aUpB?=
 =?utf-8?B?OE8reWhwTUV0cUgxVVVMdURCWkpMVDFhK3o5NnBsOVNjYTlpMkk4QVJVOEcr?=
 =?utf-8?B?MllYZUtOR2FWUEtRMWxxd21YQXRzQ2JnampvQVlpbDhNcnZlZVF2QUlWR3U1?=
 =?utf-8?B?dHZZa0hnMUVRWjJuU0JNd0JwUGNsWnE0TGZMS0tLRXpZZ0lIL1AvakJCUURC?=
 =?utf-8?B?LzF3TWhnSmZReDhVVTJ4eFpqbG1JUVR2NVlUZUFDRDJza3lhYk5ucFN6b2g4?=
 =?utf-8?B?ZjNxVFRMRURPSHJYQ1ptZGpyMVpJdUdFVDZRams5SXlrakhrZHllb0lWS3Bt?=
 =?utf-8?B?Zk1KM3g0V29YMkhaQnlzUTJjaVVGTjZ0U0pVcFJ5SDZ3cnZwNUlrdXhYenYv?=
 =?utf-8?B?YVo5Q05RNXNuV1dPQ2NMTG9PaWJTUWZ0MGRVZmcrdXZ2a3pVS01DMVlXRWts?=
 =?utf-8?B?TjdlVi9XVU1tSVVhYzAyZzJWRk8yNnBTb0twbGJwMmlHeWJRQmJPTXFiMXNa?=
 =?utf-8?B?ZFpFb2lSWlQrZDY5ZkdybVFVNVRCTDZrb2FRaENHOHFENzVjZHNwcEc1Z01T?=
 =?utf-8?B?MndoQ2IxeVpaNXhtUU1sQ3pELy85aHpGbWpBb3NsT3Q5WjdaZXVkWE1td0o1?=
 =?utf-8?Q?6oigw+G31VAQ7bi+2qqe8e0aE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c33987-8a0a-4f74-3807-08ddcb7f4cb3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 13:29:36.7226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xemWan6LDThPmRD2jdeJdyWeCV/Nk6aaBbtRb0PjLffoQ5cmNjiFag9b/a/SM8qv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932
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



On 7/25/25 14:46, Heinrich Schuchardt wrote:
> On 25.07.25 14:41, Michal Simek wrote:
>> The commit 1e50f7457fca ("include/command.h: Drop <env.h>") removed env.h
>> which also included string.h which generate compilation error.
>> But because none is enabling CMD_EXCEPTION it by default it hasn't been
>> spot.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>    CC      drivers/mtd/mtd-uclass.o
>> In file included from cmd/riscv/exception.c:91:
>> include/exception.h: In function 'exception_complete':
>> include/exception.h:41:23: error: implicit declaration of function 'strlen' [- 
>> Wimplicit-function-declaration]
>>     41 |                 len = strlen(argv[1]);
>>        |                       ^~~~~~
>> include/exception.h:1:1: note: 'strlen' is defined in header '<string.h>'; 
>> this is probably fixable by adding '#include <string.h>'
>>    +++ |+#include <string.h>
>>      1 | /* SPDX-License-Identifier: GPL-2.0+ */
>> include/exception.h:49:22: error: implicit declaration of function 
>> 'strncmp' [-Wimplicit-function-declaration]
>>     49 |                 if (!strncmp(argv[1], cmdtp->name, len))
>>        |                      ^~~~~~~
>> include/exception.h:49:22: note: 'strncmp' is defined in header '<string.h>'; 
>> this is probably fixable by adding '#include <string.h>'
>> make[2]: *** [scripts/Makefile.build:297: cmd/riscv/exception.o] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>>    CC      drivers/serial/serial-uclass.o
>>
>> ---
>>   include/exception.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/exception.h b/include/exception.h
>> index a7f21e73d753..0d4dff49954b 100644
>> --- a/include/exception.h
>> +++ b/include/exception.h
>> @@ -6,6 +6,7 @@
>>    */
>>   #include <command.h>
>> +#include <string.h>
>>   static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
>>               char *const argv[])
> 
> This patch just looks like
> https://patchwork.ozlabs.org/project/uboot/patch/20250702205818.44188-1- 
> heinrich.schuchardt@canonical.com/
> and
> https://patchwork.ozlabs.org/project/uboot/patch/20250703051951.43372-2- 
> heinrich.schuchardt@canonical.com/
> which were positively reviewed.
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

yes it is the same.

Tom: Please drop this one and take origin one

Thanks,
Michal

