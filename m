Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDC1C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 14:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF32D82F9E;
	Wed, 21 May 2025 16:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pw7sTH98";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9854482F8C; Wed, 21 May 2025 16:34:50 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1151C82F9E
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+4+m3VjJUdZSIs77Tl/uF6og50AyTuIlVb/OoSfYVTMs3jbTUX4h1Rt0gV20BxowuYRPKPATbAOlDoGw6B2uBpAtyBLMPNkLxGjrDC0H+y6tQDO6KKY51ArOFINb6iZiyUjaXNoctj34+P5pIA6VQ7Ku43eBMHVOkJth5YUaXVBHmIuVB/HG+pC4PruyN7Xs8oKFpHA/9GoV4p2DPggxyG4Fs6eLZjR+z5NHgdbZOLYXDeMPMnGFEduCHATMSUcUJpih8zsywha3avIaCoUddKeVJgoNWNH/ndDEIfoXswnVpX3pE3+1tqtYlpaPb5qWpJHbA6/faRHB4Paw9497A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCmT4RSKvWV0D6QwHMuWmxKQtJ0QIXEu1Qa6XmrEAI0=;
 b=ndgc5geM806z1h7bnpGf4XIoQSHwbG83fLZcQdY8UKUew/jUCEJkiKNTKm/ogKVXUCYbuKwGhXe3ORthQuKntFB7hD/NxSnvsQ+4fhp0ej+5HdHbZM6t3AjtWvXbiIhXl84R6PuzzodAJndREOBM4hdH1UwAzSsCa04EYfJbeJ8D7eJBADPqvnsW2BRVLPXKSZna5iSouIPzml+RmSvnnFEELdizgUzfl5R3y8UP8GUoT0u0lJJGuThGqUjCIuoNcfYPud6hu6c8DdkU3+HH3IyN6HGW5e5YRl57uiijekW5QKVBX7gz45omxTILIJzd3z5pycEEB1z8fwv4K0tMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCmT4RSKvWV0D6QwHMuWmxKQtJ0QIXEu1Qa6XmrEAI0=;
 b=pw7sTH98t0x2ApHkrBQQr5C3t14pgr2s/MuwaRXerYd+lmLxtEXuRX6oqppcMW52iJKfGWQ9fG8b9C7k08+HrYnXm5X6bSeiiqnZoehiIrSq45whiN+pf8cDC891L0Zz9ZH3tF8bWnADmlD7xBOIlTTVLrY1yzxWNuZ3xikntGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 21 May
 2025 14:34:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 14:34:40 +0000
Message-ID: <5c8a4460-6d11-46d0-8863-739c94682120@amd.com>
Date: Wed, 21 May 2025 16:34:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Anand Moon <linux.amoon@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200"
 <u-boot-amlogic@groups.io>, Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
 <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
 <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
 <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0093.eurprd09.prod.outlook.com
 (2603:10a6:803:78::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: fced3426-efe7-4abe-f0dc-08dd98749e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEkxZGpuUlNTL05NS2hKVUdMUjVQdlh3TllXa3ZoT3h1aVVpV215N1NQaVNn?=
 =?utf-8?B?WUNGZEF0SVU1Q1o1a2t2b2JSQ0hhRkZoWEJHdkxZV0ZVcjc3WGtqOGFFNVR0?=
 =?utf-8?B?RVYwN002K0krUVZGbkdxM09hMy9qL1dUZ29oVitDK2x6eEtnQWExRHo1bmZ0?=
 =?utf-8?B?UHBLd0JRdG12cnFpc0NvOVBUNHJyRVFWYk15Z09kQ0Jac1JxbTFSdDhZMndJ?=
 =?utf-8?B?ODE4TXVsMjNOZkphZGVKOG1Jc3liRUM5RTFiT2pxOFQwQ2VBb095N05keEJi?=
 =?utf-8?B?RUNhZUcxcDhaVjlnWVpWYXB6SmxaWitheWZnQUlodjg1RVZPZ2FmMkRQaWxG?=
 =?utf-8?B?ZUR4eXhLSE5xQWVYRW1NVDJpaWk4bjBLZm5hUlVZRDhKbG5yaTdTSVNORDIx?=
 =?utf-8?B?ZitieCtlSEo0WDNwL2JFVUdyWjVCcUtwZndqQkhZWEswbTYyU094SFgzQXZa?=
 =?utf-8?B?Mnh3cTBURzA5OVZEcnJlWjFYSUNRdGFib1l2LzV3TDcya2FJWnVGeGdQRWg3?=
 =?utf-8?B?VnhOZ0g5MkhzejExbzQzcGp3VkU1d0N5WGJ1UEhzb2c2Zk1NZ1A1cjRLZTV4?=
 =?utf-8?B?dGdEd0MyenNkOUh4QWxSbEI1c01yU3ljSHVRQUowYm1LMDViN2xDTnJ6Vk1z?=
 =?utf-8?B?Q1VCeTYwUUROK3prZkRKeTkvZHJWQzBvUzV4Y1FJWU5lNE55UVJZMWxHMFp4?=
 =?utf-8?B?UjAwcG9Bd3hTNFlHci8xUjVOZTNVM3Vic3QxVWRmSmw5UlRWQWhVb1FxRDVy?=
 =?utf-8?B?REdNUXdzVVhSWVpraUNsTU9UVm0yUEZIT2kySWNSRkdVR0xTUzZzQ0t6MGs1?=
 =?utf-8?B?Z2hMbGpOVHU1YUQ1c1FSSWh3UjdUY1B6Q3VIRGJhdng5ZjZsZjR5NUtaQjU4?=
 =?utf-8?B?NGUyeWxVSFpKeG5Fd2lXQWtZSnRlRnNWN2s5alFXT3V0aUpyWXZ4MnFwOHhQ?=
 =?utf-8?B?UENWT3NjY0JtNmRmRUdZSG9IbGc2NllyRkxUVnB5YzV5VmRqSVk5bmMvRDJX?=
 =?utf-8?B?MDVQOUIveS9sU1Q2TDZNS2ZuMERWWnAvMHdzVWIzSXRkMHlNUlFWdCthNXh3?=
 =?utf-8?B?dG80MWx5UkVRR0tjL1lUUnQ4UzlxK1dzRnRDellBTWdQUmNxbUlyOGNDaTFk?=
 =?utf-8?B?dWVzK0dscm9BdmQrcGVsNTRqVndBdzJ1K3VvbjJRdXNSeUFlSmdnbGoyQXhm?=
 =?utf-8?B?OTJ6TTZXc1ZaN2hGVjhtaEFlY2xKYjVMdEwySjRnSW04b053dE8vMENQUlVv?=
 =?utf-8?B?WEpZaEx2VVgxekNlWTIvZmN3OGNKTGRNK0lCQnhzdHI0T2oxQStJTkhodVR4?=
 =?utf-8?B?ZS9SNHFWQmprN0xEdUltRTlMNFJJcFVPOVliMjN3b2h6anNQZk9PZkFCdCtV?=
 =?utf-8?B?Z2J6YjA4b3hjaUp2dXc1M1J2djloTjJCN21jUTFuclZvOE9VL1hLT1orMFRF?=
 =?utf-8?B?MjFNb1JkTVh6Tld4b01NdHlOZWJBS0pDNkVIczFUZWtpUUxMOXhMSFV1RU8z?=
 =?utf-8?B?UFJwZFNXRzV5d2gvWFhTVC94bnQ5QVp1Yndmb29TT2hXOVA4Z1FJTzJJMWpK?=
 =?utf-8?B?bFFTUFlqeWR5MkFybldzUzdpc2lPZTRpN0lNZzFFWWdiTmIvS210TFJRL3p3?=
 =?utf-8?B?NldIS3ZCMk1yQ1JrTngyT1FDOUtoOWZIeHNMQmdvb2NQc1ovUjkvMldYMXBR?=
 =?utf-8?B?dGhPTmxMNXFIQ2granVSdXBlRENHb1V2UXpqNFpVYmxvcVpVYU9wZzhEdjBZ?=
 =?utf-8?B?T2JXZUE5UUxWeEJqdmYwQUt3VzVVMi9uUzcxUHh6NDh2Z2NVeFdMY2I4S0V3?=
 =?utf-8?B?TnVoM1k4aW85TVR1eXB6aFdUMi9lQ3lCTk5BYnc0TDRNbEpzbEZMclIxVGlh?=
 =?utf-8?B?OHJzZ1ZvanFnNnlzS1NOTkVSMkM3bC8wbjBPTVF3OGtFUExqb0NCQWZ1NmNq?=
 =?utf-8?Q?HZPi5dd+0qw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0poNXVpbExnNGQ2R0FHdnRWdmd2NXhPYTVHb2pOTzlEYVhqZ1ovUWxoNE1p?=
 =?utf-8?B?Q0RlYkVtR1FlL21mY3RpMzZrUTR0NERhT3FNL2JyV2xOMndiMGVCMjdSUEFx?=
 =?utf-8?B?UVVmdGZuMEdSZ2xKOU9wU0preE5ISmN6YUVmV3I2TUxRVVBlUVhXTTc0RjM1?=
 =?utf-8?B?czRPQjlRSFltak95YWl2VXNrVnFNbmxiNHlkS1FMTWd3dWN0RDZPYUdsU1Zs?=
 =?utf-8?B?THNveUt1QVl2RGZoWHdSODBGQWhjL2doRnNCaTBWVFoyZHd2eVo4TllhdTdH?=
 =?utf-8?B?OGZsOGFWRkVqUi9NdFRLNjRrRkpadUtDTVc4S21RanhDREpMTzU1VVAzeHFu?=
 =?utf-8?B?TDJyanZ4TjduWWgyOWdraXJkVkhIMHJROFFFQUJHQUhJY0JHSkJRazFKK2NF?=
 =?utf-8?B?T0RpVE05Vkg0ZXlLdXNBS0EzNGJQVTZpOC9TQ0xmdXNlYVN5R21BT1NTYWpC?=
 =?utf-8?B?U0pYVjdqWUJsSmtJaXRmQ3k2TndtU0VLWmFkeVNWSW50SEp1NUhNUnlXek5z?=
 =?utf-8?B?T0FJR3pxQnpEVXp6QXZLVk9udE0ycCtVdVFaZk4vcEd6R0g3OG9ZbFgvQ2V3?=
 =?utf-8?B?SzdQK1JoempOVXFXM2NsN0o1bjRJOC9KcE9PaHM1VWlVUVJOdktIaEV2WU5t?=
 =?utf-8?B?aDdNdmhGbkoybXFqYTZ4RjY3RTU5WXBZNGpnQ3JwNW1tMU5XcTZrNENwVnVo?=
 =?utf-8?B?TFB1MWhacHpDQ3JBY3NLbktVQ0xobGtvdU9RR1ZtbS9hU0Mva1ZjZy9oV2s3?=
 =?utf-8?B?eEhqRDJ2S2NKQmlUUU9NRTI2MWxaQlF1Mm5kWXZ5NG5BOWJDa0VtWFRFVDV3?=
 =?utf-8?B?OEVpbldOT25NcXVLN2pEL2R3UFVJTHMwVktqU1h3Y1d5aGk2eDJHNUpOb1hQ?=
 =?utf-8?B?MTV5SklNNnJVZG1GR2ovVDlOdFFVU2l6eEdWVk9FL0VhQ0RMaTAwRWhwVkNX?=
 =?utf-8?B?R2FWQ3htZ0VXbGdUbEZJMkJoblVGaXErQWY5KzZDTVBONmtBQVhYTTNQZS9o?=
 =?utf-8?B?bkRwaDdtSzhtS0JKdFF6QWNUak9SR3dJK1kyNkwzOUlZVm1SbHlDZXVac0Zy?=
 =?utf-8?B?U1p2eGsyRlVLa0FYckgySG9ORm9JTjBaKzc0Qis1QTBqeW43RU9ISlo3Slk1?=
 =?utf-8?B?SlFSN3JTZUc5REN6NENVU2NlRTN2ZHREaHV3VURURjdGQ2ZScHZrd3BzblBv?=
 =?utf-8?B?L3RlVDlrSlltdU1ZaWNLREd3UHNkSmhQRkI1akYxWFB4VDVxVytMWUFwZzBX?=
 =?utf-8?B?cUplWVlEdlJVem52alFBd0N2OTV4eHlDYk9aVHg1SlExZFFGeUJlcGZKUm0w?=
 =?utf-8?B?ODV6akhhYVZiTVVabWc0bUw0cHg5RmFZV0k0ZTJJQnF4a0xzUW4zNER0M3d3?=
 =?utf-8?B?bi96YzhsYmpMbm9WZmxPT0lSL1hSbEpqS2J3TGVwRzFDaXR3RkdxWlNNU2ow?=
 =?utf-8?B?aFg3bWx3UlhOQnRhMkVuUHRNK0FuenBDS2M1Z2x4eTRxeXpuK3Z4S1B4bk1Y?=
 =?utf-8?B?VjBFbnFQN3pNVDNtN2FmRWZNdk1HTng4UU5iZ1NTWFhadHN1YVNqQWx3N2cr?=
 =?utf-8?B?L1Y2WDhEV0o3ZWlVMC92VFo4WnpmbEh1VUdlQ0drRXU0bEpoeGFMTlpyUU16?=
 =?utf-8?B?STFKMTFKdWJnNjNUeXdxODM5amx6Z2xabnczL3YxY0UyZ040UmdXOExQQ0Ez?=
 =?utf-8?B?ZlZ4R2M3ZGJPT2Nxd1N4RjRkWmt3RW1MYUZCZDkzM2RUSlVJWEF1VXIvRk9K?=
 =?utf-8?B?VDExYmhUVGRMWHhDVlVxQjAxOW9tUFpTdy9QNVExVXpSa0JzUkJER0UwQ3N1?=
 =?utf-8?B?LzR5dVkvL3krVlU0ZUZhbjBvMkNRSHVMZDl1QTI5Qk0rRGx3SnlNQ3M3Uk1n?=
 =?utf-8?B?bkNRelhHcTVwaEkydGVvYnRLTkVSZzU0MUR3ekQ2UWs3eWkwbWlaekNJL1Vx?=
 =?utf-8?B?TXVtM1h4ODJRUFRGTE5ZR210empNdThERzZTQzZ0amI3eWhocE9EcjlZbVU2?=
 =?utf-8?B?YVFUZDVwYUdhWVJZSWJpOWI0dVMrSFltRzJJL3Y2eXpaYzlna0RteXlsd1d1?=
 =?utf-8?B?dWdyYTBPdzhtdnVkU0tXNnFnR3ZNQmVycFhzeGxYMExXN0prRXZTRjhqK3pm?=
 =?utf-8?Q?gt7j8rXXkcb0IDh/zGLih5YEr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fced3426-efe7-4abe-f0dc-08dd98749e5d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:34:40.0304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YmfoWeoU6Rf4IyzFR8/TIWYUDfkTqHBE7ukRDtKl62ggOE2gyRzocshSctB+jTp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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



On 5/12/25 09:06, Quentin Schulz wrote:
> Hi Anand,
> 
> On 5/9/25 7:45 PM, Anand Moon wrote:
>> Hi Quentin,
>>
>> On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>
>>> Hi Neil, Anand,
>>>
>>> On 5/9/25 9:57 AM, Neil Armstrong wrote:
>>>> On 09/05/2025 09:02, Anand Moon wrote:
>>>>> Add conditional compilation for the usb5744_i2c_init() function based
>>>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
>>>>>
>>>>>     CC      net/net-common.o
>>>>>     AR      net/built-in.o
>>>>>     LDS     u-boot.lds
>>>>>     LD      u-boot
>>>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
>>>>> `usb5744_i2c_init':
>>>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
>>>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
>>>>> reference to `i2c_get_chip'
>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
>>>>> undefined reference to `dm_i2c_write'
>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
>>>>> undefined reference to `dm_i2c_write'
>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0):
>>>>> undefined reference to `dm_i2c_write'
>>>>> Segmentation fault (core dumped)
>>>>> make: *** [Makefile:1824: u-boot] Error 139
>>>>> make: *** Deleting file 'u-boot'
>>>>>
>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>> ---
>>>>>    common/usb_onboard_hub.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>>>> index 1242513c631..92e3f3a92c9 100644
>>>>> --- a/common/usb_onboard_hub.c
>>>>> +++ b/common/usb_onboard_hub.c
>>>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>>>>>        int (*init)(struct udevice *dev);
>>>>>    };
>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>    static int usb5744_i2c_init(struct udevice *dev)
>>>>>    {
>>>>>        /*
>>>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
>>>>>        return 0;
>>>>>    }
>>>>> +#endif
>>>>>    int usb_onboard_hub_reset(struct udevice *dev)
>>>>>    {
>>>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
>>>>>    };
>>>>>    static const struct onboard_hub_data usb5744_data = {
>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>        .init = usb5744_i2c_init,
>>>>> +#endif
>>>>>        .power_on_delay_us = 1000,
>>>>>        .reset_us = 5,
>>>>>    };
>>>>
>>>> I think you should completely disable usb5744_data in this case
>>>>
>>>
>>> I would recommend to go the same route as the Linux kernel which has a
>>> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
>>> the necessary dependencies.
>>>
>> On Linux kernel, it needs to parse the device node with i2c-bus.
>>
> 
> Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with 
> dev_read_phandle_with_args with i2c-bus?
> 
>>> We probably should be careful and figure out which boards are actually
>>> using the usb5744 and add this symbol to their defconfig so they don't
>>> regress.
>>>
>>  From my initial analysis configs/xilinx_zynqmp_kria_defconfig
>> which use CONFIG_USB_ONBOARD_HUB
>> I believe using DM_I2C to guard the code is the best approach.
>> it should be around .init() callback to guard this to work.
>>
> 
> I disagree. The driver clearly supports the USB5744 and the driver is compiled 
> regardless of DM_I2C support which is required (as far as I understood, maybe 
> that's incorrect?) for being able to use USB5744? I don't like hidden dependencies.
> 
> Also, I believe Neil's point is we shouldn't try to probe the USB5744 if there 
> is no DM_I2C support, simply excluding .init() callback will probably just 
> render this "support" of USB5744 non-functional?

USB5744 can be configured differently. We are using two configurations.
1. no initialization over i2c
(but still you can have a need to have driver for reset or power)
2. initialization over i2c to start the hub

And there is also one more configuration via SPI.

It means I don't think DM_I2C should be real dependency on getting usb5744 to 
operate.

Thanks,
Michal



