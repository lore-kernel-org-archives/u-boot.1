Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396D8E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 07:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E03C8069D;
	Tue, 14 Jan 2025 08:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5l9LC+HT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21EB7806B7; Tue, 14 Jan 2025 08:54:01 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF12680657
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8xSxDwrymNUnv2wgM6Rmn3lJxhhdjZmvQ7DOtvS3BVrLkedTZKYdVdSv2CD/gpp21yCnSiLjtxcl+l45UElme2RDWdTL2ELcASENMhf8xF04t7jaxcxgGSdiDuhfLKb4vC+j5C6b7E3kx4dPXtdp9DMDbWOE9mkuB93yE1zqqHD0qQ2RcuUVTC7RMG3k12KXopqVSxDLIsoWt5jtqJHZ44Ux1HutPdm3gWFPZBqDmB184WlEHIo9d1UNbCg5FhquKBiW/tFULyGLfPBTI2RiLL27I+dOXRiwmUMgZ9p4lzM4AmSfkQbcuyEQ9gBYGN15eUlOlOulxfZ/kuBVNMihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGJqGiXWl/IBhqX8MgwRNeY7+Fhi87MTFHrwmq/uaNk=;
 b=yCA7+DadU7yxcrBEok5U5ibfRBOlCcSYi0wiODiCCs3SAGPXm/oVwWYioGRjh78yx3YCP8S77YWaqtlAE+qO44cXVLZX4cKouADASF2mmvpSS/SYtBxpgiYte33YUPfKHXkIhQsU2FUH1ZCFIeu4SqleHcsiy3VIXPhq1b1RkepMLXVojuH4QnQn/HNX7dcPBy5a45XIY33Meul3aHj+usLrNAO5sKqpQvO5vVjEO3qwzpz0Y2o3l/Gn1W6yNCUq0wj/vai/XF7DD5r4xtbo5w9xgU73aHO6wRqL0SenFGVdupz2h3xBw8cYqhegpwXcycYZvcVDjpM/x0RZHrm/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGJqGiXWl/IBhqX8MgwRNeY7+Fhi87MTFHrwmq/uaNk=;
 b=5l9LC+HT0m2l9Lhg5/g/tKf86LDu3hduo3gFyRrnklz0a8nZuf3JeyaDncVka8lVP10W8452YxagK24XWdqJCevbyVUVC+foRxHzhQE04cxXURbb+i3JltYncGGPfgEi+vzfUkF2Vw09kuB/m4sse4etuW36W2mEgVFZKuI15ZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 07:53:55 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 07:53:55 +0000
Message-ID: <92e6fdbd-d367-47bd-8c4e-ba62c4b7745e@amd.com>
Date: Tue, 14 Jan 2025 08:53:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot][PATCH 1/2] fpga: fix alignment on fpga cmd usage info
To: "Erkiaga Elorza, Ibai" <ibai.erkiaga-elorza@amd.com>,
 Alexander Dahl <ada@thorsis.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250108140357.969380-1-ibai.erkiaga-elorza@amd.com>
 <20250108140357.969380-2-ibai.erkiaga-elorza@amd.com>
 <20250109-auction-blob-00a19a40dbb8@thorsis.com>
 <MN0PR12MB600443410FBC58B96C973CD5A0132@MN0PR12MB6004.namprd12.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <MN0PR12MB600443410FBC58B96C973CD5A0132@MN0PR12MB6004.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR02CA0059.eurprd02.prod.outlook.com
 (2603:10a6:802:14::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: d661e5d5-941c-4899-009f-08dd3470986d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjNZWEc0UGhyK0lhallFcFR0cUdsdDhTOGpMZUhSRnJaT3Y2MnVZcVMzdHlY?=
 =?utf-8?B?RDhFVTQzVjIxYVpuNi9jTmRGVm5MWEVPenlUNjNmZ1h4YlRwLzZ5T295a2VT?=
 =?utf-8?B?QWJsTzd5MkEwNmxOTFBnRnVlUW0vRlpCSHpVTHhNUjY1MDJZcDQ0QWQyOTdu?=
 =?utf-8?B?TXpwMEQ4TDZTYTlYTzZubkpIZTNtRHVDTzd0UzFiei95VWdvMEdDME5iejlm?=
 =?utf-8?B?aEIxUHZVakdVN3FvWjRaZGxNWHRPa1VUVnplaGFpaGg4Ui81Y3RYSnFFZGhK?=
 =?utf-8?B?ak94T0xqckVYa0F0cGdqZG5qRWRPSnNTeGZMZ01ndUUwR0JtUHpNc2lhWnp6?=
 =?utf-8?B?d1kzcy9XcEVOSkRac3J3U0pEYytmZGV1NzdodEUzaVJRVU1tOUVzVXIzRHdr?=
 =?utf-8?B?QUFpU01yQk5NYXBEREhHMGRQRXhjNm0rYnVwUVFndFpzelVUOUlEYWJiVVlX?=
 =?utf-8?B?cVlyR1RxWUxzYTdyZFBWQVRiSExUNkViSTlKVk1QSEZBL3FTOERTWCtjQTJM?=
 =?utf-8?B?dlQ1TWU5ZnN0QnZNaUxrTnR5aWxNbVlGcmUzeDJqT0V2WHVKVy8rOTZ6dDl6?=
 =?utf-8?B?M08vNEFFUWJIYzNpR0w4WmRyUkFicXZ4MllLUzdMUjNMRmF5VWxNaUtOWDU3?=
 =?utf-8?B?ZTJyODE1dmg0d3c1L2JZdG5vZjB5bW5ZaWF2RXdCejZqSG9wMjE0S01pQ2RR?=
 =?utf-8?B?SHAwWHIxcWlYc3ZWUWFBSW5mQjdZN1JvaTcxNktvTHFOL2pvMHpYWTBjTlVR?=
 =?utf-8?B?aXEvTmRCSG55aytjeGRXSWlTb05XQmsxNmMzTS95WTRtUGduN3BwdW1mZUhS?=
 =?utf-8?B?bGQ4Q0pKeG1oSWtQVFcrN1VaanRMSCtRUERBbmpkd2YxZUxybE80eTN5aGd3?=
 =?utf-8?B?RXFsT2NpQ1hveVJLRTBaaU0vek8vTHNDaFR0Q01CWitTNXVuR3RleGphWEo4?=
 =?utf-8?B?eGJsOXBCbjZkZGdEMmIyVXRvWmoyS0IzVTQ1Zmgxc3JuczlQK0cxczM5U2pK?=
 =?utf-8?B?bzNVVGpKeDJmOG82dmR5K1Vxa0JQOGZTczViNE1aOEh6UWdSOVVJYWVjaUtF?=
 =?utf-8?B?Z0lSa2J2aW9teVBPWWhDVDlnKzZqTmhnVDFJdkJsdjg4Q2hoaUVzcnVFc3hh?=
 =?utf-8?B?by9XdXJ0R1NzWXhxTTVUVnBjNTZQZ3hpY1QvbStUTy9HUHg3NnJ1dm1ZVmk4?=
 =?utf-8?B?Ni9DOVJnNytOUUlocHlYVTdRaWZHMExHNkRKbEVPdTZmc0xiR01DRWQ5SEhM?=
 =?utf-8?B?ZzRKTk5qQWJNMm5HYmJTSDg4UXF6dlgrZytHZjRHRXgrSXNYUUs2R2Z2V21Q?=
 =?utf-8?B?ZzRSMXZmMVVYR1BoakJZRkVIbzNTdTQxcmcxYXZyUkNUeEIrTkpEN3R5endY?=
 =?utf-8?B?RWtJSjBnRmk1VWthZFl1VERqYlRDdHFuRDZjZXFRenl0bHpIb1grTEpwSVBu?=
 =?utf-8?B?NVhrSUd5MEtWS0RNMlQ3OHZyY0F1RTNSR0VqUHdhSnRNUXBobXJiQjh1Zkh6?=
 =?utf-8?B?aWJkRE5pNm40TDdMM21MbzVScTZwcnlobnp5R09NbG5naWZNTnpMUWF6THRC?=
 =?utf-8?B?WFlwNk91RFFoWWVPUnR4RE8xRURvUlFTNHViNU5lKzNhVnozVWZqYnZqbHVT?=
 =?utf-8?B?NDlvZVZkWGRsWGtnaG0ybXBySjRBN3FiSlVvT0w4Zmw2Q1h2WXUwcEQxZEZS?=
 =?utf-8?B?WkxCMTlQcFpGT0JBRjlVUVh4MXVUNzE3SFY0TjJPSDRMYzFUaVY3UW9DRXM2?=
 =?utf-8?B?RlF4d2cvSmZrNmR2SWJ0MFVQLzlxRTFSL0MzWGtJZGhyWEE5QVdVU3hmSjRC?=
 =?utf-8?B?cWZzVU10dnhId29qM0kwRDRKOTZsQVBNMEhuaFVRcWVWQkJqaGJ6Ylg4UXR0?=
 =?utf-8?Q?Jdjh9zDTsYFj4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdRRkxmNG9VZDZFMVIvMXBUaVFBdVl4U0M5SWYwQ2ppcU96MzVnUnMwZGtW?=
 =?utf-8?B?RHJ4WjRoYzkxR1h5NzZUVkNXd2RDWk90SjdvcWY3Ym5Ga1ZtRXM4eDBHMWt3?=
 =?utf-8?B?Um1FcFZnT3hRdjcrU3BLSElpVVB4Um4zbUtpVmRsRXB4dVdINjhGZmdBS3U1?=
 =?utf-8?B?R1lNYy9Ma3RmUFMxL3dhWUpIYjh5M1VRcTkraGRwajFZNXZubjZ1My8vZ1Ra?=
 =?utf-8?B?alFjY0VrQ2pZOHNmNDR6dDR6WmtUaGRwUXlFNk13WHkwaWNxMHNJVnZXbjVB?=
 =?utf-8?B?Z3hXTUJUdW5jeFpoUDlmTkVQWWcwUUVxVGU5ZlFsbjNsWFdGNXlZcW5WdC9v?=
 =?utf-8?B?SzJVZ0Z0Y2duUGs0WWMzU3ZyRDVmMnI1eDFDMXVRSGo0a01LSCt6Rk5xZHBk?=
 =?utf-8?B?NVBYOXVFVDc5MDQ2VnR0dGlqUktvTFRDdnJkN2pJK0VLcmhwSS8wTFlGQXRV?=
 =?utf-8?B?MGJMb3pta25wdUhVTjMvL1VZNnNKb0tNZit2UXBGOGRQSGZ1Z2NhMGpUTVZW?=
 =?utf-8?B?ODluOGdqeFB6azlNQ1dmQUR4RW16M2ZyMS9RNU93dFB4TW5WbVVhbVJzNERF?=
 =?utf-8?B?WWQ0U1QzMEpUZFo1MyswUDdlalN4Zkd5TFU4Nm4rbm9vNkczbTB6c3VqMjNu?=
 =?utf-8?B?Q0Q4S3FFMFVOL04yckpweXhaRFBPNHFDL2FZY1BleEQ1UVBTUkNiNDJ5MWsx?=
 =?utf-8?B?UUJ2cGc2MUwvZG1Sb0dFMzJFa0Mwc2N3VTBMVVB4bi94c3ZlZExLb2ZtOW5T?=
 =?utf-8?B?anZHQkIvN3dsTi9QSGVDUTNoZ1Y3Vk9mQWxDN3NXL09oK2NrYk9LdlJFOGR5?=
 =?utf-8?B?U0hEOGFSSXJnT2VBZXJwSmo0UWZwUDRPOG5ibE1ZbVlYOXZlRU5HN0tnWVZG?=
 =?utf-8?B?Ty9odlR2Y2huR3hOdzF6UkwySmE4NmI1amN1Q0hJVFQrWUVvVjR1UXJRRUZq?=
 =?utf-8?B?d1pWbENBODFWSHIvMy8yRFVBY296Uzd5V0EwZ1d3MjNQNHg1SC9kQWtuZFZh?=
 =?utf-8?B?eTJwczRYb0ordVJSU1VKSGlSQzVnRHpJZXI4clE3K1p6NW95Q3ZoR0RHT1Bj?=
 =?utf-8?B?VkFIOG9BazRkbmFFaGZIcVRZNmRVR1l5ZUhLVU5FNVhKcmRpNk01VEIzNDVY?=
 =?utf-8?B?Vmg0T0Q2YVZKQ01sM3VLM3dSZzRCU3RnWENLM3hjTDBId0xJeno1T3ZnT3Vi?=
 =?utf-8?B?V0JCYzhnMm9oSXR3K2RQZ2FkSFU1RUY5M3ZCdWhSSjkzQUt6citYN0tPZDdD?=
 =?utf-8?B?NFJGYmpIeng5YUdTa01oZWFweElpeUYwU0pKRWZWSnNlVE5oam5Lb0YwalMv?=
 =?utf-8?B?RFdvRWJ3ZVNOZGE0Y1lNcEVLc0ZBMFJ5aXpITjVOV2lNM3FWL3liNTRoZE5j?=
 =?utf-8?B?bmpCQ0RMaDdLZmpBeVlkOE9aVVl5b29lSWFWZSsvalRIdWxGL2JXMnpEODlL?=
 =?utf-8?B?cU1HWXBqdEgydi8vb1k4Q0lwaDVMakJuVmh1Q3pDazF5RU92d1htMXVadmZP?=
 =?utf-8?B?N0J3ZUFxUXo0Z1h1SmlWN2xkdkJvellEUWxaTkFwOHJKWTV0SlROTExBSVNy?=
 =?utf-8?B?eDlLTDZvdW5tdjM5dFJ0b3FENWhMZWo1LzBYOGxENXZjVHhiaXBZZ1V2Y2ln?=
 =?utf-8?B?MCtYUDF6MFNHUnRjOUx6REZTcEgrVmxSRmx6NWJuSWlIT04xSG9UU01TSThn?=
 =?utf-8?B?amp4SlNVOEV5dytlRlJlNUVLV3dxZ3dycEpvcjdRQ3ArWFhaaXFmK2JXaS9H?=
 =?utf-8?B?Sm05WEtqOFd3aGJ6dHNxNEViZTcwK1FrcWZWaHBYc1Jjak9xR2t3V1NocGho?=
 =?utf-8?B?U1cyMkpTZ1BoaDdmK1lKek5YN3d5WTNtN0taZXBVTXFUT3lYb1ZZTlBtQnI1?=
 =?utf-8?B?YTYvV0JBOGJVNzM4VXhHY29jUWJkeUtoUEZxQ0FsL1pTMkUwcGxFdCtJbVlN?=
 =?utf-8?B?T1o1WkpIOEtvVGNiaVJDNkpKbFdUQy83QW85K3BSVXJ2ZlBuWE56amRLZFgx?=
 =?utf-8?B?T2NoQ3dHWjY0N1VIeTI5OUZpWGYrQjlYd0dBK2ZUczBIYWo2T3hYY3JRN095?=
 =?utf-8?B?eTBjNk5TajNBd0N3ZDR3SDNVL2Jrd3JFUzlDVDJ5VW5xS3F4eTM2cS8wMTNi?=
 =?utf-8?Q?OQXN7DWUwdODkHky7kALD+edk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d661e5d5-941c-4899-009f-08dd3470986d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 07:53:55.7270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJelZHebJOfNSXfN4NkcV+PLxCpqwaH+ETWylK48tjEUc+jEY5ME/5Kc95NLI2cs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700
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



On 1/9/25 13:45, Erkiaga Elorza, Ibai wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> 
> Agree Alex,
> 
> I just used /t to stick as much as possible to the current implementation, but 
> I'm open to change to white spaces if Michal thinks it's better.
> 
> Regards
> Ibai
> 
> --------------------------------------------------------------------------------
> *From:* Alexander Dahl <ada@thorsis.com>
> *Sent:* 09 January 2025 07:52
> *To:* Erkiaga Elorza, Ibai <ibai.erkiaga-elorza@amd.com>
> *Cc:* u-boot@lists.denx.de <u-boot@lists.denx.de>; Simek, Michal 
> <michal.simek@amd.com>
> *Subject:* Re: [U-Boot][PATCH 1/2] fpga: fix alignment on fpga cmd usage info
> Caution: This message originated from an External Source. Use proper caution 
> when opening attachments, clicking links, or responding.
> 
> 
> Hello,
> 
> Am Wed, Jan 08, 2025 at 02:03:50PM +0000 schrieb Ibai Erkiaga:
>> The current implementation generates some alignment issues as well as
>> some overlapping when all the fpga command options are enabled. The fix
>> is intended to improve readability of the usage info.
> 
> Alignment could indeed improved.  One question: the \t is dependent on
> the terminal, right?  Would it be better to use spaces instead?  That
> would also make the code more readable.

Agree. Even other commands are using tabs using spaces would be better.

Thanks,
Michal

