Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A84C35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 08:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F344808A2;
	Fri, 21 Mar 2025 09:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v2nKQmuv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A2F2810FE; Fri, 21 Mar 2025 09:39:11 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC0D807D7
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 09:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqkrmiiT7KTqaSmTIPksMadmzP8qclWq0hm+thlfdNOaUZTRIUqXaNa44huQdmuPGRz9KzRh6urwcV/agAYJQx+7KWcnGB31Q3Mjg8Rqs/Ti6eX5jYa4K2ZOtu3p1Q5En/m6691j01Ud2OuB1oiS9Gr7OHunLAOOS847QhZtO5mtv5boTg5vkM4zakIgb8sBVfUtnOgn90egK52U4+KVBaKx9XCIXIDV0ccgcMR/czPRRNCMjWG+WN0pahbgTeoj41OdSleuIfYutn1BlKndTc/FAnbk3r1s3DBOtHpLUvUZaGAsavaRwsXi/ipu5JnU7eFk6YFDggQzh7FgBwz6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h8KM7qN3eB/yAeR8Hhd0kvJ97aLly+c1RJ+fMvawoA=;
 b=HBoos9IqUxFwJXpdleD0UEO1w+VAorPvIimIaSdWfvQN06gch+KRtGMuwSAmwVBem1uJ/aghPy3fe4+2TTuHgjgr3ZOlItO7seE2roVHlm6pzmYvxgPJNQONE0yQt+DYAXHLA8Dr8nY70ZTCHf9hs9qKl7WeWWA25sZ90cXFQn32e4RPefhn79RM1C9sA8YnZTJ/+Ket77MxVtWZZin/lDekJnL8RXViJW0v7bQjye2sYf0zpzMuMDu+SUVSuanGpESH4NfeqjqSWXBx8zIdlQAxZQNUA5jXkmIR9Nem5kX5FRETsPw3pTcRjmc/2evmLkz0hjGvZJaHFD6ABKOiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h8KM7qN3eB/yAeR8Hhd0kvJ97aLly+c1RJ+fMvawoA=;
 b=v2nKQmuviqDkXWAEWSITDStONGTuMAfnt9/njeGy5rzeuHT9PSCNJQlDkNRb4WTpy3MZI0Zr8ZcKzf3WzOcry8YvnRtlV5JRpYTXe57iPl4T823MB0acEQUEL6IWCsZYMVoCZYLBZyJ7vW5pEtWvYewQ3XGKVR6QmgOx+5ifquA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 08:39:02 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 08:39:02 +0000
Message-ID: <fbad5d5b-2b69-4004-bc13-9bd0e73d3278@amd.com>
Date: Fri, 21 Mar 2025 09:38:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cmd: fwu: Dump custom fields from mdata structure
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Tom Rini <trini@konsulko.com>
References: <75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com>
 <CADg8p96oba52R=nSKFg8hprE-BYNNtSuOkswLNi4raW1W770dQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADg8p96oba52R=nSKFg8hprE-BYNNtSuOkswLNi4raW1W770dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:8:2b::15) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 391cfeac-6f58-45e8-2f89-08dd6853d4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXJHUUhtY3FKZlNzRDM3bUJCNGl6QkpocnNrVURrYktVeGNpYUtGOWdPZXBz?=
 =?utf-8?B?WVI3Y2E4alk4a2ZPVEc2SisybzQrOUpIb3NLK0E4TlVzRDdkYkhLbUZoUExM?=
 =?utf-8?B?cHNVcVh6V2tQRDhSL0Q3ei9jT3dHTzFCZjVNdDNaSUw2TVBKZUZXLzJsRDZh?=
 =?utf-8?B?UnFHNWovdjViSE40WWZad3dyVXBqQyttOGY0UVFJbDlxYXBhWk82UkZZT3F1?=
 =?utf-8?B?OTVvOW5mTk5NRlZCZjdVbnVpV3JjRWNKbm1BaTRucDE1eVJrYjNOWTNKNFFi?=
 =?utf-8?B?Si9PZGhvYUozYVg3TzFpKzBNamRvTUJJTlpRU0hpUnFnWTVwendEWHBBQmlw?=
 =?utf-8?B?enB5SXI3WDVhYkdCKy9aTTQ5bGU0K2pOTm4yQmJVU1ZBaGxpc2xhMXRHdDYr?=
 =?utf-8?B?MzZOUWd4N2JBSm5HbWd6S3ovQUQwaEx2OHo2S0JLb01MSzdCdXUwUkZHRFFZ?=
 =?utf-8?B?NnFMUnppUCt6bG1ZSWhNVWRhOWlNb2VHbFR4R1JjT0JaNGNNd2U4ZEJGYWVV?=
 =?utf-8?B?NUU2Uy9Sd2ZucUNVZ1htbmxuYmx3d1RjNW9kRng3WS9HZWFIM0RHNHptdkVU?=
 =?utf-8?B?Q2NqbWZIdkdGejZnS0JyYzltdm9ZRGlFRWdORHhVcGRZUTNYaDZ1ekNMakxV?=
 =?utf-8?B?M2FtcjhXSjFTeDVmbGhYM2w2UXVsaWdDYTdvSGVYa25EYUxJM0s0THJFZGRw?=
 =?utf-8?B?S3Y0Q1hPUVJYT1k3cjFFV0JHVXE5RW9DY3pNakFTT0I0dW9xbnZMTXZIdStM?=
 =?utf-8?B?OUhWWDBUeXRmM1d2UGFidjB3MHVUSHdLTmg5bUhBM0ZtRW12VEpyYzROcHhu?=
 =?utf-8?B?OGtrV3d6M0pscWt6NmZGOUhWTGZlR2FEWWtBNVppVncrT09lMXlmNThnN0k3?=
 =?utf-8?B?bFBpYVJNMndRK3dGZy9WM0ZvVGFEbjIvN1pLT1l3MEl6VHNhcGIzUSsyZnhD?=
 =?utf-8?B?dFhJZVhRa2ZZeVk5S2I3L21reXcvb2lyQzc0amRGK2NCamxSK2FqT0ZMdXBU?=
 =?utf-8?B?MEtiOWQxNWxmVWxBUlhuT3YvWVgyMFZQcjdmVlBUY0ZldzVCdmdTbE1NRWtQ?=
 =?utf-8?B?Ym1adTdOZVJFVlhESHFOcTBzY1ZtdzZlTXNYMk5pRjhRakdOVzRic093bzBZ?=
 =?utf-8?B?dUFpUHNxMlVOQkFCNFhEaGp6MEJ5aFI4MWQ2QmUva3NYZW9WUTN6QjllRWEv?=
 =?utf-8?B?MkxlS21BUDh1N0d6Vzg3UUdjdmFWVlhET2ptU0ZOZVdLREdRaVl2RjRRN2JN?=
 =?utf-8?B?cjcwbjVYZEU1alpmQjB2Q2F3T1dCb2ZPMXI3eVQ2ZFNua05sOE5uc2pMQmIw?=
 =?utf-8?B?b3Myb083RTZQWW1wbXBzbTk4aTNJWHNQcGwwSXllYW9yMm5WRmpabWNWMVJF?=
 =?utf-8?B?SG0vbXlNUE9YQi8rMTllZVh3dlpVSjRTT1JPT3lvQVhBVHZtZWZUbTRLSEpL?=
 =?utf-8?B?ZVBUbVpzYW9PVlMyNXZUbXUzL1RtQ2lHbEJGU0FYb0RnWDN3bk5JZWFyK3ZX?=
 =?utf-8?B?Mjl6dHc3bnFWZ0k2TDJHVHFUTS8ybDRjY1RIc0x0SnQrQXZpdURSNlN2RjA2?=
 =?utf-8?B?QVBGQ2ZBVDdLT0RGQUF5MHoxNjNlSSt0OVZkaG5WU2pmY1cvOTcreDFWeG5n?=
 =?utf-8?B?UzU2VGUvZDBodHR2QkJCdkdFb29wT0R5aWg0dERDQ1EvYktDWlRTNXFtc2w4?=
 =?utf-8?B?K0l6bDBKZ09LdDcxaTNVc1BsaUpWazJybW8xWkdDMy9POHE0RGlURVhrQ1J6?=
 =?utf-8?B?SXZRVVFWRFUxQ09MREptTC9GblRLUStHTGxUQ202TnpqYjJuVnJXS2Ircm5n?=
 =?utf-8?B?ZlBzNHMzcEw2S0lGamtCaDdrd1FuUGlTVVN5N0RIdVhJejFnVTdTVUIwV2xY?=
 =?utf-8?Q?hwsso1yFIrVMl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFM5RysybE51TlBZNFBNU3daUmhjUnpOZzhZTDFZd1R1MjYweFQ1Q3JCYkdC?=
 =?utf-8?B?azRyVlp0Sy9jMzc4UjB4aXU4QnBRQktwMFdQb0tHUXlRbHVaSi8vWi9IdzdB?=
 =?utf-8?B?TGJWZCtOWkkxNFJEM25UNFYxWmdnc0x6emhWSHlqMWQzbUhLS3RTMzVpNkFk?=
 =?utf-8?B?alJNcGhjN2F4bXdvdlhObmwzaGErNFpIRFc3WWRMTTdvbW1ZT21YamRrMkt5?=
 =?utf-8?B?NHI4MklDN2RWUXdrSVVNdVNqL1NZd2RXSVFyNGM1Rm51UERIS3FiWmpPek0w?=
 =?utf-8?B?T3VMUlRxcU1mUXNGdmQydVo4aVZvazY4RlRKS1VTUkFXVEhNY3FMRjd1WGNh?=
 =?utf-8?B?ZzduMitMaHMrQWt0L0RreE8rSFVuUDBHQk1UK3c0Y21HbGJMbGZVOW5WUkU1?=
 =?utf-8?B?clJEYk1wbkdQOVRKQkhLTStkRGVqbGR5WlZWWkIySkN3UVdBWHp1Wk4zVkdl?=
 =?utf-8?B?Vkg3TXN2aVgvOHJKT0FkUEZtK3NRa1RtZTcxcTJ6OW1rbzluaW93ZjZVM3JT?=
 =?utf-8?B?TnN3dHJKRGdwcXlaMi9aT3dUZ3RlenNvN3Nidzlsako2VksrelovcmFENmk3?=
 =?utf-8?B?L28xSllkZ1hwb2lqZ1RLNXdCeXdJUytDcFZwS2JUWmZXZUhlVzFhS1R1L2pY?=
 =?utf-8?B?WXpFMWFlUjRTQ2p4S3o0MkJBK1doUkZ0Qk5PNmF0KzNTS3dwZDBBV0NOMHRn?=
 =?utf-8?B?cVJOVVFwYXF1NnF6V3o4SzVKWEwwdVJjNlRvSmdXUVUvSzlPWTNOakFucURF?=
 =?utf-8?B?U3lvc3hYMENLZkR6eUNlTDBBV3RuNmQ3eTF0VVk0c0cvVzNpSnZLMEZxbDdp?=
 =?utf-8?B?Vjd0bm1ReWF1NUFKTzhiTzJnV0Qva1FIazhqeFhpODk5amt1K2E4V0w5L29z?=
 =?utf-8?B?TVBFWlJwdXEyM1pYOUpMTm9KV2pvQUFsMlJKWnpIWUw0NCtaTnRtY29wTTJ2?=
 =?utf-8?B?bDkvcHk0UC9oUkwzRVpudndXTDJmTzAvVE5PanlrNmxUcVNubWUyRGg1MDZw?=
 =?utf-8?B?M1F5ZkoveWRhSlR6Nk0rdURUeGRkTnY5alFDbFVkeWhhZG9Wbit6U1djRFRi?=
 =?utf-8?B?cFNKZmpBelFJR2wvMUE1eUdnS2c5SmpaMjNURUZ6VHZ0elRNWXd0VWZRNk1v?=
 =?utf-8?B?dnpvM2lKRDVZV2xlM0ZpbCs0L3YzSTdKVTVHZUYvOThNdE9vdHB2Smk3SWZn?=
 =?utf-8?B?bXNXd0lmVjVyVWw2ZGpWUkR5elUxaFljVWk4ZUg0SjZZbWtSNGNwTDJ6azdB?=
 =?utf-8?B?YnR5cDdUWlV2TlZLU2ZIYVpJV1N0NVFsbUw3Q0RoL2hCRlhIS2tWSVNHcUo5?=
 =?utf-8?B?dGFpeFJnc0NabS8wNkJzZUhuUkVxL0RHcHBjN0xib3ozUVVrOW1WdCtJcFMv?=
 =?utf-8?B?dHhlS1c4SjhyRHlxSXFGQ3dTcEljdWUrRXpLc1pXTUcvR0k4V2c0WXNiY2RC?=
 =?utf-8?B?SEVWZGt4QTE0MFVHaVoxd1FCNmhZOERWWFNxSkphYmM0Y0xVTTZCT3RBNm5S?=
 =?utf-8?B?ekp0ZnBoSGdIVVNxcnVOd1E2eWZmQnVlNVM2VDU4YkM2bE8zNnBFS3RRMTdJ?=
 =?utf-8?B?NkYxaTJMdnNHeXAyWDRVR3ZSbGJnS3NWeG1wTWY3N2pxMXhMbHRqN0VUVm5U?=
 =?utf-8?B?aFQreXNoQno2ZXFkUHVBQS85eXRJY2RUaS9keFNyOUR1UlNIb2gvS1BuWUto?=
 =?utf-8?B?Qyt0R3hLMjdOU2FzUTZsajBzSlcxL3lHZFJwT2pUalhSTk11dStCS1lBMWRk?=
 =?utf-8?B?YXBOZDMwQzRPNTRyVHJGU3d2ZTZINllzQ1hWQVg5ZjBCL1JMU3QwZzMyR05k?=
 =?utf-8?B?TGpVS3NFeStRek9oV08xR3d1T3lUZFl6YU04VWZKc3NDOEUvNWxlZHczSVNL?=
 =?utf-8?B?bDZzMlludDA1cFluR0tWR2pkeWwxRG1SdGhjaVZFNDZyaEJVaG9ZaXBkUnY1?=
 =?utf-8?B?QVpVSnh5WjRpWCtrWTczakNYSnhzcHU2Y1B4K2o0SEp0MHpDV2ZCOUI3SUli?=
 =?utf-8?B?T2FhTVV4YkNRaStyTE9keFJqaHRGcE13V0Fnak9oYVJxS2R3bUxqdTQzMlJx?=
 =?utf-8?B?QXNDeVZhOUJjNWRUZ3Y4ajUzS3UycVUzTE5lSEhNdVdzRWJuSzBHRWUvTVZy?=
 =?utf-8?Q?ko2dgZr43kAhZRnDXFPvpFDeD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391cfeac-6f58-45e8-2f89-08dd6853d4fc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 08:39:02.2462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJUBXR0qUXqoif2RkuvwLkc/VS+PJDiQ7Rvr6kPEe9EnKLmpVjanxDg0d2/1RcQu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
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



On 3/21/25 08:40, Sughosh Ganu wrote:
> On Wed, 5 Jun 2024 at 20:25, Michal Simek <michal.simek@amd.com> wrote:
>>
>> The commit cb9ae40a16f0 ("tools: mkfwumdata: add logic to append vendor
>> data to the FWU metadata") added support for adding vendor data to mdata
>> structure but it is not visible anywhere that's why extend fwu command to
>> dump it.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
> 
> Looks good. Just a couple of nits.
> 
>>
>> I am using this for some time to check various configurations that's why it
>> can be useful for others too.
>> Sughosh: Maybe there is better way how to dump it.
>> ---
>>   cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
>> index 9c048d69a131..ff6435505167 100644
>> --- a/cmd/fwu_mdata.c
>> +++ b/cmd/fwu_mdata.c
>> @@ -7,6 +7,7 @@
>>   #include <dm.h>
>>   #include <fwu.h>
>>   #include <fwu_mdata.h>
>> +#include <hexdump.h>
>>   #include <log.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>> @@ -45,6 +46,30 @@ static void print_mdata(struct fwu_data *data)
>>                                 img_info->accepted == 0x1 ? "yes" : "no");
>>                  }
>>          }
>> +
>> +       if (data->version == 2) {
>> +               struct fwu_mdata *mdata = data->fwu_mdata;
>> +               struct fwu_fw_store_desc *desc;
>> +               void *end;
>> +               u32 diff;
>> +
>> +               /*
>> +                * fwu_mdata defines only header that's why taking it as array
>> +                * which exactly point to image description location
>> +                */
>> +               desc = (struct fwu_fw_store_desc *)&mdata[1];
>> +
>> +               /* Number of entries is taken from for loop - variable i */
>> +               end = &desc->img_entry[i];
>> +               debug("mdata %p, desc %p, end %p\n", mdata, desc, end);
>> +
>> +               diff = data->metadata_size - ((void *)end - (void *)mdata);
>> +               if (diff) {
>> +                       printf("Custom fields covered by CRC 0x%x\n", diff);
> 
> It would be better to mention that the value being printed is the
> length of the vendor data. Or not print the value.


printf("Custom fields covered by CRC len: 0x%x\n", diff);

> 
>> +                       print_hex_dump_bytes("CUSTOM ", DUMP_PREFIX_OFFSET,
>> +                                            end, diff);
>> +               }
> 
> Would be better to do a 'select HEXDUMP if FWU_MDATA_V2' under the
> CMD_FWU_METADATA config.

I think select is too hard here because hexdump is implementing empty function 
if HEXDUMP is not enabled.

imply HEXDUMP if FWU_MDATA_V2

Thanks,
Michal
