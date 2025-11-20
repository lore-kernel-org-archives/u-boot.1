Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E693BCF8861
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 14:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BAC583F1F;
	Thu, 20 Nov 2025 15:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wztUkMFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E72F83F33; Thu, 20 Nov 2025 15:31:33 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE9283A6A
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qs9L0+cHv45Y7ok4aOIhT113LB58onJMkpv7gdUj43zznS1PsZ5dvcKvs8ubZKINlUyWD0QiMeIUjxNPzZ1rbEiV5Inuetg5ObN1aj34e4BAWp+XIm6V4YqfEPz/wsJgUH2jzNcNYwZdwPKngRBgh8FQFhl9F6cEq+qA3EZ5QdQ47emwXHoTrTtOhSZfKqnTSWeclJDS1RZhTTEwq4XKhMbH3kpBwUhP28Fy9IYdtYIYGSf4BOxjeNxt8PGhIa/J5Gje7nSmF0ETuMN0CrBV+5wA+GErbDvzGdH67HXOf+h1vl14ic2zaXn2jeoFWAH9HzmC9ilJsWFyDX/liE3MoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWIS2uXOuJ8eVyUNKHsj+JMlzPE0srd58Eb4Ke6yEMQ=;
 b=OT5XhpvdNjVGlX5EW4HjYxHK/UEB5VyUMkYVPA+smOT9Ai+4TWZ9cFefiBR+PAkU0ZKMtQZOrnsxPKcZC/9j34ALHDx4Zms3XGUdyjbpKd9hkRZ9jr68dLvi4NTOvKdIrKm/p8ACt7ApOGCVQiGJk/k4GTvxyKd1t3G3X120h5xoR4oAG8tCImgbojA3j9OLoOLNySbgntCExdI2aY8SXKQbm9s2e+BMcOZ87uU5j1l3zRis0eWJZAr8o8zH79CWRRMhk15IYFoGo7lSFjpMslclH51RgtzxDjmwXoah9ONY9IaA/F6VNUzlc/6A2bDhvxVSUQT3AxtvRUZpH4juIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWIS2uXOuJ8eVyUNKHsj+JMlzPE0srd58Eb4Ke6yEMQ=;
 b=wztUkMFvZJtua3YpLs5BiLZDz5PeoVNQN5LwQzxq48m2kMg9Zhpa87UUYHX34g7Fd6qKEyN6/EZe8uiduKCpU2aU6nV80dl7Z6fcVnqMeHwS5gCNLcX8v8CX8iYj4qXm0NaIHAubZA7RButV/P9NS2q26liA1BsLUG7rUOZnn7yzsb0wpXn6jRcOj+/R1A/uVJCWYYDYxx7X6l2thaN6tGuNlpD+4m/HJV6IEmFM4l4rMjYEirKbnXxdQ3BsmuaK4Oy9NYtrj5k3psoD7lCqzxVI+dL8NMEveXsbRSUfFq70a9iyZW9Rs2LNwoe+3g9bduhsfSCdLYnCpAuM6E+jLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7830.namprd03.prod.outlook.com (2603:10b6:806:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 14:31:26 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 14:31:25 +0000
Message-ID: <099ad344-80c8-4f88-8ddc-8ff6012c5974@altera.com>
Date: Thu, 20 Nov 2025 20:01:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mmc: sdhci-cadence: Use max-frequency property from
 device tree
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-3-tanmay.kathpalia@altera.com>
 <aRwOmpXU5__RLICN@nxa18884-linux>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <aRwOmpXU5__RLICN@nxa18884-linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::9) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: f720a382-6670-4427-8076-08de28417b90
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3VUNi85K0lJUTE4eWlJM2x2S1pXYjRCN2Z4a1dMVVdJOU9NQWtyL1dmNGpl?=
 =?utf-8?B?Zk9WbDF3YVlzbjQ1c1h2dzlld2E4YWltSWhLK0dmanN2Z2MxaDRFaEl4Qmoz?=
 =?utf-8?B?WXNFc08yekgyRENBeTlyV0txV0tJendFQ044SGZrRkx6d1NCSW9OUC9RVU84?=
 =?utf-8?B?L2JBNXp0V3g2ZkluMitydHdpTWFjNDZRc1JVa1drakJrV04vTUlHd2pPK0F4?=
 =?utf-8?B?eGpvZ3llYUEzUmJwazFWeXVwbXFYMEM3MkN1RG5pdUl0YmwzZnpaMlVZYndZ?=
 =?utf-8?B?UWJrYWJaZXhXL3JNc29lNzhMVnlPdmN1a05ROVd3c3V3VFZibTJZVFJ0WTB1?=
 =?utf-8?B?RUdNMDNXdUYzRzN3MS9VYXhLbWdDTGJGQ280c2pWQUlwTGlYSmFXZEE2cjRX?=
 =?utf-8?B?Uk1GRFQxVDlsVGRBR0t2RGVDeUVyVzQ2ZUI5dTdIZ3ZmTzBxZFZXUkREWUM1?=
 =?utf-8?B?bHdlL2s5V0pCN3R3aE9TYW9HS001OWJwbk1TdTZBV3QwQjN1WGVvd1F5bEFO?=
 =?utf-8?B?ZVJZZndoK056Tm1PN2h4RFRaK3RTbGhVcTdNVk0rQnBBVFRuM2xDTTZHeXdw?=
 =?utf-8?B?NVRLWUUzSHkyYTdjSkJiTmd2NnRTN2RPUlBxOStQbUhrbzNkWG94M1FNdWRC?=
 =?utf-8?B?bmZsVkg3anBHT1IxNnJBU1hweCtWQ0lINHFyRlNoRERYRXgvWi92amhleVho?=
 =?utf-8?B?RVY1dHlIbGVsV1kwMTBVczNvbDVCL1ZDZHRPWVFHRDlaeHBpM0hVcitPMG85?=
 =?utf-8?B?M3VhOWpBQ1RLRkdPSUlTNC9Qa09Cc3hKeFhYR0lHc2pPSHp4am85ZUE0OFE2?=
 =?utf-8?B?M2RDNEtkZEpxRE5ZSW0yU3d3V3h3LzhOTzVja1RURmxybUh1NktnbmpXMWM5?=
 =?utf-8?B?U2Zualc0cVM1VktCMXlONE9hSzVmZDBVYmg2K1hIb1BHb3lWdFRUSTRIcmw3?=
 =?utf-8?B?YytSbGpFSG1ycnZjWW1PcWpRTG1CSXJKeUtiMDdoclorUERLSlNNYzJYN3pO?=
 =?utf-8?B?ekc0eE8ySHFjam9RaGd3WkpmMmdqTi9SY1EyUTRSSGxPb0dWMGI2UnY1dTB0?=
 =?utf-8?B?bU5zRDBaTmdHU3A3Q25QVkROYzRpSUdXNHFIT3R1VzkyeGJ0TVM5eWc4Unh6?=
 =?utf-8?B?S0FoYmM1VE9pVGg5aUwyTHduUEpCUUpjcTFQNjlyVno4Rmc3UU5CdWtSeEsw?=
 =?utf-8?B?WmxzaGVpQzk5WWNCNXRsSWlCVzN1eElwbDdXMGREWmlCM091ZXJ3Y1JnMkVG?=
 =?utf-8?B?TVAzbXQwYjkyZWN0UGJzbHJrVmpzNmRYeFZyVUd4cFV3THkySnoyLzA5Z052?=
 =?utf-8?B?SUJKWFBpeFJiK3Rpb0VOeHY3RzcyREVOT0Yya2cxUVFWOGlYa3J3cDBVNjNC?=
 =?utf-8?B?WXlvWThRTFBBZERWVlBFS2RpOHk1RThIai8zcTQxdWxaTkJMSlpzeHlRQmQx?=
 =?utf-8?B?MTlFSUZmNjBudGdSQmNzQ2F2OHNBNm5OOWowWUE3aUUydW13MXZmSGUwOTBW?=
 =?utf-8?B?SXAyZHJoQXJmZWN3eXNlQktkNldlTmp3d3VKR3NQVXZuM0JMVDgwRHZ6TFYr?=
 =?utf-8?B?aTduQlg4dXV5S0FqSFA5OUZjWWxPTG1uZ0pOek5qZmVFbTgwUmxjbEE4Tm1h?=
 =?utf-8?B?NkV3MlNYVTNsakJWZGx4OEhGZ1owbXhtd3FNZVZBSVR3YjVxMXpiZ1BMVStY?=
 =?utf-8?B?cFllNkk4NzZVSnVPYkt0SEhuVWpBRVNMVS9mWmNqV2ZscTlDV09ZV0VHdmxG?=
 =?utf-8?B?aHh5RjFxWlBMZ3Rva3k1eTRCM3Y4NWVnMjF5aDg1SzN1aGRBRlpVdEtMUzdP?=
 =?utf-8?B?WXRhVUo4cyt1T0FUeTFHV2x2azdIVm9HN2xpaVNkK1R1UWs3eVhtMGVRN2d6?=
 =?utf-8?B?anhuNUF4OU50UlREZ3pkWkhHa3hWeEtNYWFVT1J1aGFHR2lxR2FKbHJtTWlQ?=
 =?utf-8?Q?VIm4s5LrBz1UH6bgL0Q5ldY2tC8nVeXA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxXTmExblN5Vk8xck9kU3hjQ2Q5cGdIVXVuZUZmWURhSSthR2J3ZWJCVmx5?=
 =?utf-8?B?T3ZwckFhNEQ3WmdHZmpyQTB3czVoU1lVUWxVMlllK0dQMU5FZS94SHRnR2Fs?=
 =?utf-8?B?OTU3YjM4Snd5Y1NtbGtoUW9kNC9iOHRxNkliVmNodUNNQlM4MVhoVkV4bWs0?=
 =?utf-8?B?SGRSQXRiVEdmUlB1UFZDRUU1Ti9yRlRLYjdpOVdWY1dTTkVOY0ZOQUtkZWZF?=
 =?utf-8?B?VFl4WXpCS0l5RmJHVlJraER6VExOWW14bVpsb3cvVkVTK0kyK1liNlB6MSti?=
 =?utf-8?B?SjloM0xJOUNKWXJHSFJqMUVONWNjYWtqc1RkRDlrZkw3a285bTlWK1llYUY2?=
 =?utf-8?B?emJiSHNzdm1rNE1wNjhKWkNvM3pzYVYyZFA5VWtPL25oWThyYmVLeENtL3JQ?=
 =?utf-8?B?eXJEMFRuOHJqeENrMVBxbCt5M3lVQW9BQlNwbFJSNkd1YzUrem9tajlaQkxX?=
 =?utf-8?B?UHRad2FFcFFCYmR1LzF1Y3FPUXdUMFp3ckNOdUh0TDVCdFc0UHVCQVM4YVJ4?=
 =?utf-8?B?VUxFbE45Tk5Vb2JZZEwyNzkxbGtCcVBOOUdJLytzQnVXNUN4MmViNmxxa2Vk?=
 =?utf-8?B?bG5BU2F0bi9mTFNoZmtuRlBrcUdzN0IvSUlCZ29rL0xQcnZIVlV3dnB6TjVT?=
 =?utf-8?B?RTRXY3orcFhxODRDbU1YajdVSDhtV2Q1NEpNRlBiTjlSd0RFc1FaQWt5ZmJ3?=
 =?utf-8?B?SlJOUllmcElSaHNYUTRQSXZ0bGdFbk11VFVseFlzeFNJQSsrWENJTU5SZ0Nr?=
 =?utf-8?B?ajUyY0phVjJza3NLUW5Pd1ZpcVRSbFlxRzVuQ2hUdXFwN1NzWGc1eVVMdSt5?=
 =?utf-8?B?VkNlZ2F6RlhoN1dHK3AzblpNMDJvVGgwUmFwWnFGdWs3K0FzTHlwTnNYeXJN?=
 =?utf-8?B?NnZ0aHdWQ09aY3dTd3VVVnpmSW9EUVlUNGpVOVhkSGtFdkhlK3UwdGlBT3VQ?=
 =?utf-8?B?QjZFbWFRNTQ1RFA3T2J4eUllZERicldKZnJlQVZoemlCWERrNFI0eStTeUY4?=
 =?utf-8?B?dTZHQmtza3dPRCtxbTR0R1h1aGJBQTJhbHFBRDRKKzRSdy9ud1B1NWVrUjJN?=
 =?utf-8?B?Nk9wVWg3aEVWM3ZIUUVSWmNrY1lqZGhnKzRRY1M0NnpzbGxGdzFPdHhiZW1r?=
 =?utf-8?B?NzBlZm9QdWJPaDEvZXhwK3dheTh3eGdmaG9RK1FWZ3RuY2VGRkhMT3FTa3N3?=
 =?utf-8?B?bTVUL2swRVpwVExoY0huVHJ0TWs1aCttYzlFKzliNWxyNlZXdCszSXR3WVFn?=
 =?utf-8?B?WkVsNjVCeFc4Y2RtVjVYWDlzWEdNT2xHRnhFODVZSnI4aUc4T3ppNzFvTWZp?=
 =?utf-8?B?MGRmcldIVCt3aDR1T0dKSWxhMUFzSlJXakxiamFWQVNmazRPaVJzL3BYTjE0?=
 =?utf-8?B?U1c0UHpqQXZrVGVkcTVmRXN3aS91YnA2aWRqb1BwaFhSc3BrTnBHK3N3TWo2?=
 =?utf-8?B?Syt6eC8vdXpiYnpDbE1MSWx4NkNHdE50NHlJeWM4L0N2M2l2OXczSVg5c1Zj?=
 =?utf-8?B?a0tTTm1jc25tREp2Rm5YdUxYbENaeVhBUHZOdWdjT2xieG5HNytPSlJKV3Bu?=
 =?utf-8?B?bFRnNVN1Q2dIYXhUeWM2d2JHUTVEMWJFRVJkVk5WRkU2VFVIdXVWaWxoTklx?=
 =?utf-8?B?RUQ4Y1g2cUhtWjZOTHVVUWR0dzErRTRwQUVyVjlLbTUvMk13YjNLcFVFa2c0?=
 =?utf-8?B?RWdGa1pSVFNKcnFFdDlMS2VGU29PYkxJVzNFbFNFWW1IdlpzTDVyaVVYUjRi?=
 =?utf-8?B?VXRXdTZjOUd3U3dubktFaEtYQVc2TXQrUlVaWGZkTzY4M0dTdERsN3UxbWV3?=
 =?utf-8?B?UERhK0VPR2tGaENCSHZRTFZtRnh5T1hoNStNcy9MTHZKWGxBNE85SlprSVln?=
 =?utf-8?B?T21BOHNWVzAvSkI1OWNyTFlUdTUxb29ZZ2pOTVF5RHpZMU9tZ3l0MytTdUZR?=
 =?utf-8?B?QVdJSkdnN1MvcE9mS1JFMmF0alZISmc4eWJZbWhyMzhWbDdEWnltSWpKZ0ZF?=
 =?utf-8?B?Y0xnNTBMclBjUzNZbVdBVWJmaVZRczdsK1drUUZHQUxYQ2VXelkrcDk3Tk1M?=
 =?utf-8?B?aXlVb0syUGtSWnBTOXJEZkhaQXRaTmJCVCtYVkdPTFMvOEFkZ0NWS0FJR0dn?=
 =?utf-8?B?dyt0STlmdlFwaUhVcmJxVUVQYzh2T3p6Vm1zWjduV2JMSi85K0t5YmRZakZE?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f720a382-6670-4427-8076-08de28417b90
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 14:31:25.4752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuST2o4OazYEAXIKK/twuWoafpunxBbLBGnIJ1ti4+M+WfM8IW6xvk3W8mbgIKmi0SEef6qjeAZV9jE/i/i5yIi8/5OLBoyfrLo8wzQevkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7830
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

Thanks for your feedback, Peng.

On 11/18/2025 11:43 AM, Peng Fan wrote:
> On Mon, Nov 10, 2025 at 09:37:31AM -0800, Tanmay Kathpalia wrote:
>> When f_max parameter is 0 in sdhci_setup_cfg(), the function defaults
>> to using the maximum frequency from host controller capabilities register
>> instead of the max-frequency property parsed from device tree.
>>
>> The max-frequency property from device tree is parsed by mmc_of_parse()
>> and stored in plat->cfg.f_max, but sdhci_setup_cfg() was being called
>> with f_max=0, causing it to ignore the device tree value and use the
>> host capabilities register value instead.
>>
>> Fix this by passing plat->cfg.f_max to sdhci_setup_cfg() to ensure
>> the device tree specified maximum frequency is respected over the
>> hardware default.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
>> ---
>> drivers/mmc/sdhci-cadence.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
>> index d9fda902076..f31437e5eeb 100644
>> --- a/drivers/mmc/sdhci-cadence.c
>> +++ b/drivers/mmc/sdhci-cadence.c
>> @@ -255,7 +255,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
>>
>> 	host->mmc = &plat->mmc;
>> 	host->mmc->dev = dev;
>> -	ret = sdhci_setup_cfg(&plat->cfg, host, 0, 0);
>> +	ret = sdhci_setup_cfg(&plat->cfg, host, plat->cfg.f_max, 0);
> 
> plat is allocated by setting plat_auto in U_BOOT_DRIVER, but it is not
> zeroed. So f_max maybe a random value if max frequency is not set in
> device tree. You need clear it before mmc_of_parse or
> change to use dev_read_u32_default for parsing max frequency in mmc_of_parse.

I agree with your suggestion to use dev_read_u32_default in 
mmc_of_parse() for parsing the max-frequency property. This will ensure 
that plat->cfg.f_max is correctly set from the device tree, and if 
max-frequency is not specified, it will default to 0.
Since this change affects mmc-uclass.c in the MMC subsystem, I plan to 
submit a separate patch for that update to keep the changes organized.

> 
> Regards
> Peng
> 
>> 	if (ret)
>> 		return ret;
>>
>> -- 
>> 2.43.7
>>
>>

