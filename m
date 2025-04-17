Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9312C369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 10:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E998282EAA;
	Thu, 17 Apr 2025 12:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0fst1hm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 136E482F8C; Thu, 17 Apr 2025 12:11:21 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3450682CD2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 12:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/zKxAmXy7IhWIfGtqmSieWtqLPsOrO4L2I75CC1fFndKz0asHx7DfqGirQfOOgHy0Xq8MulNmOWn8tYmk54+TYFF3oIHJUTRmkaeR2Lciuk5EW3S5mRcXRkKWq5wZcmF7p/VZ5tmPs+AvAbhOnLssgt90AsA7EOeVlBqX193m6M0W43NLdjy7/6RQYGFJR29wwdL5g9Y6crewH7TTMwJaDcnW9+OLs5rS9ld7skFsw8AqR9Kecnuzo/O1IapHJ+7CC8oDchfyJq+D373royQPcEm8KJP3oMBuoYJl9ZkZvLFd3J4IAAFAv2h3q4+7Vkw3N9NA2JkXWh9hfdzGZHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Ma1nHA6gySrZ5RUFFY+r1eEegZ0rYbbuVRyknZBbg=;
 b=J4RnHCzza9RBlI6UASkZFoVMxBMFadEAioaCVlw6X+oU9FZBFy7Ay/0vg22WHGO1Ur/fbFWoGcdvfXTF5zOcySP4S5RESqi+d7QWKQWgEzrXK+W7iHgsgx93YtaPRpsCi2zOTR+4JqNkYWyrZ7XBgiViMP65GMGowfkXSWUa6uIn1Q3m0s1pwvkSqYBph1ovs+BrEOoXTB5bMGELDF+JUr6ben9HBhDJaqjNemN23BTiNkUz/KMIbRRipS3QD2IByM7w75MBxM9Q3qLdAwBwP8AQeQSdiwoLg7B5xdErwhjj2YuVx5SreUFYdK1BfjyVC51TUsVtcAkKudUB3939eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Ma1nHA6gySrZ5RUFFY+r1eEegZ0rYbbuVRyknZBbg=;
 b=0fst1hm2gZXEz4+j+027zRbyYpSc1A76ANHLz+0BJ8oY6sBnEIa6TqcBtLKrAu1bOfuLcqA1j9whdjJUTsI88bpj/SNzXxmU/QZUK/Ccvy7ywMeykAeftuHazk8G+h3bkMPhWbepV2NNXWffJhka4BYHpyFaYFn2DObQSv1oV+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 10:11:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 10:11:14 +0000
Message-ID: <7a98ef06-1ef0-4ef7-8aba-ad84b99612af@amd.com>
Date: Thu, 17 Apr 2025 12:11:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support for BR Xilinx Zynq boards in mainline
 U-Boot.
To: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20250404072819.69642-1-bernhard.messerklinger@br-automation.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250404072819.69642-1-bernhard.messerklinger@br-automation.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 395addb5-c0e4-4ee7-8d47-08dd7d982f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGhlNDZDYm5RSmJ1US93RU42eTFSb3UzUGlzV3VhYTl4eFNKbGJXa1g0a0Ix?=
 =?utf-8?B?ZDBBNytYeHdPUGV6YnVZeWRHNHFrS3NrVnZCOEs3WFVsV3NwVXNSOXFSM1VD?=
 =?utf-8?B?SkZTdndySFBlVk41bnRiMGtzdVpDUXFNQjdTaXIvY3VWMWlaaUlETmhPbEZC?=
 =?utf-8?B?SGhwOXB3ZXZXWEM5WStvUEtVZlV5YWZzUlNpZklSS3JncUVXSHNLNVlBb1N0?=
 =?utf-8?B?YjFXQnYzZWtXNzRKK1BjT0JuSTNUQStycWZQK0RQSDNMdnV2Y2VqTzhpNFJD?=
 =?utf-8?B?RHBNRExQT2ROTVVqbkpaNUdWalRVMUFGOXprc2JvZW1vRk1UWUhob3ZzeUVX?=
 =?utf-8?B?bHVhZ3ZKMmxhZjBPSmw1ekoxQlByTlhYaUFpM004YWJmcXg2QTRhUWtNbGY0?=
 =?utf-8?B?Z0NyM3k5UnEyYUdSdlNPeW9tLzVWSnpvTHpvNGkyMXYzMHNvb24wWDdWbmlS?=
 =?utf-8?B?VnBsbk1VbXMySU4yZDN2ZVZWYTY0cURST1VsdVhBeVpMN1FTUklYUUltdjc3?=
 =?utf-8?B?L3JsOERkOUk4UnVQdzlaSEsvT1ZGL1pBNCs1bkdwWGkzUCtDVHF6d0dVM3RT?=
 =?utf-8?B?U1ZDZXJJSVNDT1E1ZzBuQzhEYVIxd2ZlMHBJTTk0NTJQa1JhUHNYU25sSmNY?=
 =?utf-8?B?bkJGRXNPL1pWK2VSUU94bkl4d0tITTBUbTkwYnR6eE53TkxvUm9tUkttTjIr?=
 =?utf-8?B?cVQ2cUQ2NmppdWhkekNiTW5CNzA1S2JVQ0JtM1NFZTZieVJpT0RTV1NybWtW?=
 =?utf-8?B?eXlvaDRsemJXZXNYU09PY2g5dmtnblBXQjV6bEhzb3RTWEpCeUJUUXFyY3B3?=
 =?utf-8?B?MXBISUNacUVubnZvYWt5bW1vZWxmNmRFS0dlWWdxNXB3YWJzZDhvSStmSHE3?=
 =?utf-8?B?aDQ5RGM0VlRBRm1DS01BcHRYTy91NmNBYjZBVGx2NXQ3Z3JVbm9HWDB5cG0y?=
 =?utf-8?B?MXp1YWh5RkZGRTRmdkhLZU5FbnFPemJKOUJ6b3FoYy9XSEtmRGZsbU1qNTFJ?=
 =?utf-8?B?QUdJZ0lzVDMzdzJrQzF0N2FVN1Q5UnhONU44K1Y1S25NSFJYWUI5RFRFNk95?=
 =?utf-8?B?SEcvL2tsM3lxL0gyWDA0TTQxQUVpZEVaMDczVlcvcE1ncjQwUlBjLzlCTFBl?=
 =?utf-8?B?YmoyKytjTmRDaFd5ZDNTR0hadXo3cURBazczTlhJVXp5Ymw5T294VkFuSHVR?=
 =?utf-8?B?VkUwTEllWU80V0VmNUtuWDF5NHJVeDh5MXlIeU9TM0lHeUxsSVZ6RVNpR0tx?=
 =?utf-8?B?T3RMWWNaTVBhSWRqekVQdVgvdEx5M1NmK0FVUzJtRi9NVEsrYkNxYXZQZlBU?=
 =?utf-8?B?azg1eVoxbW15blZxeVRFVjRrdHdCRnA1UG9mQUE3L3NlcURXNWxoZEp1dy82?=
 =?utf-8?B?YkhYK0NiSDQrWkpTTC9IcXArdEpicFdMWXptRkVCb3ZNdmVIN1l3MHhiajBK?=
 =?utf-8?B?SS93bitqaEZMQWZLSWFPbFVIZWtYTmdJSjVkRktnSnJsbnBacjl0WXJxd043?=
 =?utf-8?B?a3FTS3Q0OElYRkx3RGM1cWErbU44SGpwd0VaYTI4SHJ1WWJaaS9mVTZwenBJ?=
 =?utf-8?B?RXRuRnVqcjJtR1lwUW9QZTB1YzZkWVdaL1NNSXlGTnRoQWJTc1RoR3hXdWts?=
 =?utf-8?B?eWxhaVFVYzB5cHBsWUg0cGFIdGlpM0RranJVeUJlaldCdVdTMFFiY3FGWXhv?=
 =?utf-8?B?SjVGYjhESU9aTXZ4Y0UyWDZNQlFSWEIrWThwWXJJbW1IOVUzQ1UydlNqbDRl?=
 =?utf-8?B?bXFnWVRNYitaSHNaZnRUZ1RPNkZYbnZuZXYxd0ZMRWE3dzF4RjlrM1hBZUJH?=
 =?utf-8?B?SXJYODNKeTNkMFJiem1jM2RiNGhFMUR4dDdXYkR5QnZGOUlYSHVOWFUyMHF2?=
 =?utf-8?B?QkZGSXlVL2hFcHRJK1lGeEczUHBRdWtJLzVQb1dqekNmN1Z2bVR3VWhtbVR5?=
 =?utf-8?Q?YX4R9cuhKww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJUR2VDWisrUjJvUXhWT09IMnZzS0NCQ0IyUmEvSys3WE5lSktPZ2oyWkQ3?=
 =?utf-8?B?bXpybjh4OUpWOTVoRGRCRFU2MmkyVWZRY1BEdUYvWW01blFnNVZKUVpiZWF1?=
 =?utf-8?B?eU1ncGtOdzB6V0FWbVVNNUZqdHlxL3BQZUZHTzlmaW5iSzJTbjIvRXp0QzFF?=
 =?utf-8?B?Um1wZEZzalF3U01tZi9wVGNDMGM0aWpIZE56MG54Y3piVFRSNGZob3dzbFdX?=
 =?utf-8?B?aDNYaENlWU5lYTVZRCs3bHlxc01WRGkxbTZ0Wk9McGFXR0FPdmppeGtESTBJ?=
 =?utf-8?B?ZkRROUVtZW9vOStVcXRkNlRwUzgxK2ZwdFRpcjA1VWhaTFFlQWRRYmNwL21Y?=
 =?utf-8?B?cEtVV2pZWXFETVNjVWJUV1hjSFc2UFROeEpaOVN5aTI5ZDFsZjJTK3Jwa1dD?=
 =?utf-8?B?R1A3aUp4U3NaTHJhVFhIbVBPR0lVVlB4L0wzdXRDYjNSV2xGK05JZ245a3N6?=
 =?utf-8?B?VVpqejcxMGR1NG5iWjY4WnVvV3VtOE9zZ3d0TEJBd3pKL2Fpdk1LRkkvcUNn?=
 =?utf-8?B?dzV5SWlVSDRhM3JuWWo0Vm4zV09JWVVUUnJvbXlVMjBxOU5ZeGl5YmNpRlo1?=
 =?utf-8?B?VDY3RldQWUJQb3c0ZjFaWFJnTHZWaHpCVElraFRtem9mRnJZUzBDZDEwNkZY?=
 =?utf-8?B?RE5WT0gvVWpyWTAzcjVBQVE1M0ovMG8zekNYUCt0TUowUVZ1Tyt6OURIdEJP?=
 =?utf-8?B?SUtrVElMU3pJMnRjSnRJOUs4RnU1MUJvaEwxRFRjVktyV2hET1R4RXpvcUpS?=
 =?utf-8?B?QWhNNnczbTZKMTlKRGxpcGlaeDMzanhpa3F2RkZOSk40NksveWprVGZweFlK?=
 =?utf-8?B?WmhJS2xyWU00MUxyQ1VXekxZOWZDZGVOZURXUHFQZlRmelF4MVFmaHp0WjRP?=
 =?utf-8?B?K3hIVlVZOGlIZllNNzFnSW1BQi9uVXpxS3hxeWNIVkkwNlJvWnNvZ1hLTUg0?=
 =?utf-8?B?YlN5WFZJdDZ6S3pwczdjNXB2ejcwVUpReE03K1F2bGx4SjBYNGV6WFhaUFdB?=
 =?utf-8?B?V2dLZ3Z6bVpDY0dvdEk5K1BEd0xocTJqWm1OOXRhd2ZMZS91L2JLbG1CdVJB?=
 =?utf-8?B?dEU3Nmg2clRsYlZpQVd1c2NnQkVpS1UzRVJpR0orVUt6SVVzN01pYTlEWUxX?=
 =?utf-8?B?M0IzNXd6czI3WC9lNnNreTA0WkRuYXdFUnV5TWxCRCt2dWpSRWFkSU9rc1VC?=
 =?utf-8?B?NlhnTWFTY3lnaWF5bTVCMVhyaDhhOGRiWGJtejJrK1h1bzdUWmNWWkYzZUdp?=
 =?utf-8?B?TVpiaURqU2ZnWlpPM1Rqa1FiSTlPVE9ReFdmcVpaNGd1VFlHVlVyWWNhSmZC?=
 =?utf-8?B?R2JnNXJwaFMzQzJNUmpqNjRXbTcwOEJNRTlTVk9yeFVkaGY3WmRIL29JbUZE?=
 =?utf-8?B?TXA0SzQ4QThEcmZQK2FMQmtVaGk4RjFGa3dvaXNhdFV1ZGcrRk5vZHNnUW9C?=
 =?utf-8?B?RklvTzA1UlVnMHozUmxCTlRIZHZsTzNZVkgwY2trTDRlM3dvMVVZRXdhMng4?=
 =?utf-8?B?NEZIamhzYnRXTGpWSm1ZL2J3a3I0SUd3ZmRYeUc5RzlzRWg5MXN1am0ybDQx?=
 =?utf-8?B?WFdaWXlOTC8zOExqcTRObWV2TGZScGNRaFpIb1ZSSm94TjJKWUdFVW1aNDVY?=
 =?utf-8?B?K3AvQStpVUpXOFZkTUFCcHl5elNFWHk5QkhCVmZrdit5ak1KOHlaY3VQK25S?=
 =?utf-8?B?ZUNYQUN4MStMRVY1ZnFDa2V5eE91bVdKSlg4U2lUL0wxbS9RZUN4OFRoQXdr?=
 =?utf-8?B?YURzQmxpR0RDbHJUZ0MvaDlabWRSaVNLem9yRDRkZ2d4Qm5Ec3ZycGhGWHli?=
 =?utf-8?B?MUhGb0s0dzBjSW9saTR4ZitYQ1ZWVjdzb3JhbGdOcjFidTZ2eG4yeVdLQi9x?=
 =?utf-8?B?VVp2S2NuMGozbjlvUkNpZ0NCcGQrL1haT0ozYUFZQUNKSmNuSUhaRmJsN3hG?=
 =?utf-8?B?RUNKbExRNVRXWGw2dVlwcXdGNnczVk4zZWsrbEh0NmUyMEJsbmdpNjhkbzhS?=
 =?utf-8?B?UHpodUIzTzN3WlNHQnE1alpJdng2TGx0RXhxZWM3cWgxSEhQa1Nya042eW9B?=
 =?utf-8?B?cTZBQUpBRWZ6WGV0SElOc1AxS3JSSXJ6bytBejBFOW1VaDFsTDZKcVJHd1E0?=
 =?utf-8?Q?ZIn2u7nILoJFrdpjM5xfRJoqW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395addb5-c0e4-4ee7-8d47-08dd7d982f49
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 10:11:14.1246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7F8aAY2QjDvHDUpp6DGGRQlrOo+AMu/F00ZDllE2dY3jCx9xOPW7AsQ21CnQIaDn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
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



On 4/4/25 09:27, Bernhard Messerklinger wrote:
> 
> 
> Changes in v4:
> - Fix device tree Makefile to only build B&R Zynq device trees
> if the target is from B&R.
> 
> Changes in v3:
> - Split spi_flash and qspi controller node in device tree for the usage
> of bootph-all
> - Merge binman descriptions into one zynq-binman-brcp1
> - Add links instead of manually including u-boot.dtsi files
> - Remove empty MAC addresses nodes from the device tree
> - Seperate B&R Zynq device trees in the devicetree Makefile
> 
> Changes in v2:
> - Move BR_RESETC_I2CBUS to Kconfig
> - Remove all unnecessary device-tree entries
> - Reviewed led names (no pattern restriction found)
> - Fix maintainers file
> - Cleanup of code
> - Move preboot variable to env file
> 
> Bernhard Messerklinger (4):
>    board/BuR/common: use strlcpy instead of strncpy
>    board/BuR/common: add parameter for reset controller I2C bus selection
>    board/BuR/common: split br_resetc_bmode function
>    board/BuR/zynq: initial commit
> 
>   arch/arm/dts/Makefile                         |   7 +
>   arch/arm/dts/zynq-binman-brcp1.dtsi           | 102 +++++++
>   arch/arm/dts/zynq-brcp1.dtsi                  | 131 +++++++++
>   arch/arm/dts/zynq-brcp150-u-boot.dtsi         |  34 +++
>   arch/arm/dts/zynq-brcp150.dts                 | 173 +++++++++++
>   arch/arm/dts/zynq-brcp170-u-boot.dtsi         |  26 ++
>   arch/arm/dts/zynq-brcp170.dts                 | 139 +++++++++
>   arch/arm/dts/zynq-brcp1_1r-u-boot.dtsi        |  30 ++
>   arch/arm/dts/zynq-brcp1_1r.dts                |  28 ++
>   arch/arm/dts/zynq-brcp1_1r_switch-u-boot.dtsi |   1 +
>   arch/arm/dts/zynq-brcp1_1r_switch.dts         |  30 ++
>   arch/arm/dts/zynq-brcp1_2r-u-boot.dtsi        |   1 +
>   arch/arm/dts/zynq-brcp1_2r.dts                |  21 ++
>   arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        |  30 ++
>   arch/arm/dts/zynq-brsmarc2.dts                | 157 ++++++++++
>   arch/arm/mach-zynq/Kconfig                    |   1 +
>   board/BuR/common/Kconfig                      |   8 +
>   board/BuR/common/br_resetc.c                  | 139 +++++----
>   board/BuR/common/br_resetc.h                  |   1 +
>   board/BuR/common/common.c                     |   2 +-
>   board/BuR/zynq/Kconfig                        |  14 +
>   board/BuR/zynq/MAINTAINERS                    |  11 +
>   board/BuR/zynq/Makefile                       |  15 +
>   board/BuR/zynq/brcp150/board.c                |   4 +
>   board/BuR/zynq/brcp150/ps7_init_gpl.c         | 278 ++++++++++++++++++
>   board/BuR/zynq/brcp170/board.c                |   4 +
>   board/BuR/zynq/brcp170/ps7_init_gpl.c         | 274 +++++++++++++++++
>   board/BuR/zynq/brcp1_1r/board.c               |   4 +
>   board/BuR/zynq/brcp1_1r/ps7_init_gpl.c        | 274 +++++++++++++++++
>   board/BuR/zynq/brcp1_1r_switch/board.c        |   4 +
>   board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c | 270 +++++++++++++++++
>   board/BuR/zynq/brcp1_2r/board.c               |   4 +
>   board/BuR/zynq/brcp1_2r/ps7_init_gpl.c        | 277 +++++++++++++++++
>   board/BuR/zynq/brsmarc2/board.c               |  30 ++
>   board/BuR/zynq/brsmarc2/ps7_init_gpl.c        | 276 +++++++++++++++++
>   board/BuR/zynq/common/board.c                 | 231 +++++++++++++++
>   board/BuR/zynq/env/brcp1.env                  | 109 +++++++
>   board/BuR/zynq/env/brcp150.env                | 119 ++++++++
>   configs/brcp150_defconfig                     | 121 ++++++++
>   configs/brcp170_defconfig                     | 120 ++++++++
>   configs/brcp1_1r_defconfig                    | 120 ++++++++
>   configs/brcp1_1r_switch_defconfig             | 121 ++++++++
>   configs/brcp1_2r_defconfig                    | 120 ++++++++
>   configs/brsmarc2_defconfig                    | 120 ++++++++
>   include/configs/brzynq.h                      |  21 ++
>   45 files changed, 3943 insertions(+), 59 deletions(-)
>   create mode 100644 arch/arm/dts/zynq-binman-brcp1.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp1.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp150.dts
>   create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp170.dts
>   create mode 100644 arch/arm/dts/zynq-brcp1_1r-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp1_1r.dts
>   create mode 120000 arch/arm/dts/zynq-brcp1_1r_switch-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp1_1r_switch.dts
>   create mode 120000 arch/arm/dts/zynq-brcp1_2r-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp1_2r.dts
>   create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brsmarc2.dts
>   create mode 100644 board/BuR/common/Kconfig
>   create mode 100644 board/BuR/zynq/Kconfig
>   create mode 100644 board/BuR/zynq/MAINTAINERS
>   create mode 100644 board/BuR/zynq/Makefile
>   create mode 100644 board/BuR/zynq/brcp150/board.c
>   create mode 100644 board/BuR/zynq/brcp150/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp170/board.c
>   create mode 100644 board/BuR/zynq/brcp170/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_1r/board.c
>   create mode 100644 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_1r_switch/board.c
>   create mode 100644 board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_2r/board.c
>   create mode 100644 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brsmarc2/board.c
>   create mode 100644 board/BuR/zynq/brsmarc2/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/common/board.c
>   create mode 100644 board/BuR/zynq/env/brcp1.env
>   create mode 100644 board/BuR/zynq/env/brcp150.env
>   create mode 100644 configs/brcp150_defconfig
>   create mode 100644 configs/brcp170_defconfig
>   create mode 100644 configs/brcp1_1r_defconfig
>   create mode 100644 configs/brcp1_1r_switch_defconfig
>   create mode 100644 configs/brcp1_2r_defconfig
>   create mode 100644 configs/brsmarc2_defconfig
>   create mode 100644 include/configs/brzynq.h
> 

It is assigned to me in patchwork.
Applied.
M
