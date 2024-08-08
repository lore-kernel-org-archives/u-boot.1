Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E411AC52D73
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 05:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F81A8780E;
	Thu,  8 Aug 2024 07:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qG6gIZxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6DC80544; Thu,  8 Aug 2024 07:31:45 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D7688210
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 07:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMl9E4k+IP1M9hdaskkj3KUF55ldpQXmggslkkFLApw6GIwRdY6QvI7CISr/c8k2BJNTsz1Xm1TGuqHCkY9rQDdu4db8nFKO+5bmH+K739rOeWCk59MV67LSgx+jXMEd3oHiviO+3L3Je2UelU2Yvr/GzTisDaVaITv1tyRkIEmjVwoHdIwozivcHrqEXzUaSZe+WtnuBMpOiUgpxyWrBZPRf/V2StW5bD/STi1BGryqb1AAumemdOqYYjR3tale3Oh97SnxOvbQkH9SUJOgK92LKW9qpOSAXH83ljuudO7XrUQqAwcDAiktUDIFMIEsPDJGiaOBlPZKQsfQeyHB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjwO5crJgXbs1/9Qor0DN0Ms0lwM3hxxrdb/XnmwYOU=;
 b=Wkgy7XEKuHXBqZ2GY4K9nI6ZLafM2/Mh+s2b/JWTg3XIzv7MXNajIlefQkNVsbjys8PbN1IuwkXBbwdC58cms607gHwUnhUtfqDOVjATxUUCC3i0sUbJKfJ+5s/gLDfIGeKBrX4ThGpWSjkPRqvUjce++HHg/T0CPyOCKL6FqOH1pRU+/yTH6xaL4Ats1+XVwqmo7DeshoA7uenCqVwTx+G1vlUMibpUcqLIX2EaScGjmP8NLJkWCEZG9ydwZHk/egtJgtv6mooQcU3c69jmhYM32vJ2E4DbDvCz+H+CvwfWbThWvXm9W77tWDSrWvQ60JTPNahWlxbLAuCZ2qcd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjwO5crJgXbs1/9Qor0DN0Ms0lwM3hxxrdb/XnmwYOU=;
 b=qG6gIZxdQh61EPMNFYBYlxeNW+TR7ort58nv3Re1NyLMQ+GCss61vh227T5VIaorbX2zVMiAHZn5CaUjEXzYQrOEcoTHbfWUpoBGPyzK4acdgnqb9V8GLFB51Af1u4FfLFf/Z/IGWlNyJ6j/5lW98u/3yonaZREZBpVO+199jtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 05:31:38 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 05:31:38 +0000
Message-ID: <9aaf2326-2339-4d9a-b5b8-c5115e844599@amd.com>
Date: Thu, 8 Aug 2024 07:31:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: Simon Glass <sjg@chromium.org>, "Kummari, Prasad" <Prasad.Kummari@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "git@xilinx.com" <git@xilinx.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "d-gole@ti.com" <d-gole@ti.com>
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
 <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0274.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fadeaa9-7ab4-4038-5910-08dcb76b6051
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OStrRVJuTEFrcG9ScVVabmM0bThVU3R1SlVRNzIrU09RS3ZPOGZXWU5raUdV?=
 =?utf-8?B?WW5zYWxjUHlldVRVOE5UNUNleHlTUk8yUHFtaUhYZ3NiLzRTMFVIQ3R5YlZt?=
 =?utf-8?B?R2o3VHlRS2U1c3BYcExLdUgreHBiVWdQeWo3NXkyRUsyZWcvNmdXOTVXa0Rz?=
 =?utf-8?B?SUV0M2s4Y1MyYmNFRGVYSzU3TkFhVlF6OVdjY2RaeEZmZlZWeXZnNmxtWFNu?=
 =?utf-8?B?WENxOUkwRTQzNS9YU2VJNkhSMVlud3RQcytkMjBBbFRzNlZpdUoybkxUVHBE?=
 =?utf-8?B?b1U5ZGRJU0gzSWhmYU9LdWhSZzlKR0VxejNaKzZMeVJjQ1BlRlVrdFF6QlFS?=
 =?utf-8?B?L3QwUkhTNGtMdHZIaktJU2taaFMzZWV2U1FUTmZhbnlpRWJ3MjFLb3ZOeThK?=
 =?utf-8?B?M05BS01rcGptaVdjSlMzRlg2YUpheldHOEoySUkzWG5uWHN0dkJ2K3NCcisx?=
 =?utf-8?B?Z2NISklNd1dSQ2E0cEkzNUhnbmZyOU5YRFF2TkwxdVJFanU4RWx0anhValJF?=
 =?utf-8?B?RFBZSFY1b1FzSmhaUDluc0VLa3poRXhKSk1KYktndFBCSEszbUZ0eGpqMHhF?=
 =?utf-8?B?TDdiRzZqNk9udENaTWltM1dzbVpBTzZGbzREaC9XUm9DajgzcEpCZUR6Yi9x?=
 =?utf-8?B?UmJSMS9YM1MwVlMzZWFrV3pyamFCd0w4Mm13Q1J4OUlsVmhWMU5rcUYwYU02?=
 =?utf-8?B?LzRTazJ1d292MVBSVjcrekJXSVlJdTllZjhUQ1ZJR1RnU0dkeUxZODRxd2hX?=
 =?utf-8?B?RElHRHFnbTRVRHVJN1IwU1BJOU1tS0IyZnd4YWFpQUlzdDkvUTFJalhqZVRM?=
 =?utf-8?B?alVnYnZVWEdkaVFIWmpZZkx4VDViV2p4MlNEZkFrVVgrQWFzYVJVRCtqL0U2?=
 =?utf-8?B?UGN2UlNBSklTR2laanVQbHJRMlVNd0dFa21VYllTdHZqYU5RcTUzWVhaU3ha?=
 =?utf-8?B?VW90RGtmMFJnQ1BDZlRWS1UrVC9VOUU0c1JOQ2YraXkzNjNFdDNWdmxKbUc3?=
 =?utf-8?B?cUVOeXlqSGY1Z3RQYmNxcW04bWFsWlpXeU1QanRUOXo3ZUNjTnRtMHpVZ3Ba?=
 =?utf-8?B?MllFVngvUndCdFEvMnVGTit1STRiV0hEMS80T2Z3d2RhcXh0dlA2UVI1d0N0?=
 =?utf-8?B?MHBXeXZ0aVZRVzVoOW9kWjJmcW5pMCtXVTY2WGFpU3ArbDFZTDk3QzhWakhH?=
 =?utf-8?B?MG5BMVRsT2xpWFFVSzh2eUhZdGo2MVByNEFmM1EzWENFWFhsd1M4anFjeWdH?=
 =?utf-8?B?cEFhOU5Vbkhiall0TWR0YlJEVVZHUEJUVVQxcXA5SFhFZlFZSytMWFRlWnNm?=
 =?utf-8?B?S1RESFg3RzRONU5uRUtWU1NXeGpGN0FrQ2k5YXVGblFXdWhhSXJWODUwS2t4?=
 =?utf-8?B?em1GeWVSS3pXNzBiT1M5R0k2UWFaRVo5aERzaWVhQUR3TVdEd2RsOU1LVTlR?=
 =?utf-8?B?L3JjbmNnT05ubGM0RFlJRUNTb2JWNUh2d3dtOTd0Q2lHb3BDSXg5VGNjc2pp?=
 =?utf-8?B?UCtFZ0RkOTluOUpUTEZqbk9KbFVOakJIZldFa2c0UTJLaDNDeTJvMDF3SWI1?=
 =?utf-8?B?elpyWmE1RHQwbXVYbm1tQjFlbE10b0piSjFwVFgrZ2V4amo2NUgyeTdUREV5?=
 =?utf-8?B?SS96NGpoTFl6anF4cE5vbkJMVERCdWxHc1RBMFlKc1NOR0R2dEtodFJRWWpr?=
 =?utf-8?B?aUhEWm5GOHA3ZG1ZOEcxUFg3TndLam1kMkFVN0V4QmJ0RUdiU2RPK2FNczRx?=
 =?utf-8?B?OW55SWwzRUlFRnoxNGtJYWpuT1FpbmhrVnRQaU5pZUZrTXZJRFZNOGxiYTF5?=
 =?utf-8?B?TUIwSFNvRGRjUzRpcmN3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1ZWcWhYcjQ3OElRWi9kYlI4dVlyN1p3M0dGVkdkZ0VQcUNGSldVYXh0eWM2?=
 =?utf-8?B?VHYxQ3IrbStScDdxYStoZU9ocEZWbTNNN2xJS3lkQktCVU9KVmlVTk5tRlNt?=
 =?utf-8?B?cVpEMTBDdGMvWFVmZ0NIYjFTNUJBamI5Zy80YXJGNys3TVJ4WU8rWWNId1VT?=
 =?utf-8?B?RzY3MXlCMDVEMCt6ZVlPcUJ1ZzdHaUVrK0R2bklGNDAwZEY0V1lkRDNUd3pP?=
 =?utf-8?B?MFpMTDFtTTRiVHh5MmVSL0JPZTJIQ3ZnNytrV2tla2FnalRtU3ZmSXlNb3JM?=
 =?utf-8?B?MzFsSDMzOE9IclcxTHczb29EN1EyU1VTSk1OK3IwRzRHa3BnV1hhWWFKTWd5?=
 =?utf-8?B?dGxRV0I4TE5zVjJmM3hiSFMva0k4UGdHbUI2OXloTTM3aCt3MVFnclc2TEw0?=
 =?utf-8?B?M3pMdGFFTkg3bjlKc1hzeGdKdFRxOWQ5ZjJodXJJTE5JSFFqS2cyUkk3bVlp?=
 =?utf-8?B?MlRjcVc1T3FzRUkyay9VTEI1WFFGSGk4b29mTG83NG9YeFVQcWk2TUFIclN0?=
 =?utf-8?B?VkM1RzF3TUVQNTRtYmtmVVVUeDVSYUdhMU1jZTJUNk0yRlA3TUFNcXRPb291?=
 =?utf-8?B?NjlCejIyZTcwR2RKeXBlZzROTDRNUmxaTzZUTXBEdk9kSUdFVG1RcjZoRC9j?=
 =?utf-8?B?RlFSQVFobjgyTmpHNmZsMk5Cby9OU1g2Q1VZbWlpcHA5cmg1THpyQ3IwYUls?=
 =?utf-8?B?bEo0Njk0MFRuMFRsaWRjVU03cm1lRkYycnRjNVgwU2ZhRk8zQm55eVdsUmJ6?=
 =?utf-8?B?ejljVjk5TGZ4MVNSdGFvbVc0Mlh2a0NTSnZIZGx4eW9nQWd6RisrdnVHQnFr?=
 =?utf-8?B?N2IxQzIrSkxuZVU5VDJwbzh6U3RSVVdBODl1L2tvYmNKUEwyKzV1d2hML2Ni?=
 =?utf-8?B?Q0NBeXZRRzVuSnpyL1g3NCtBTkVtRmJOWTRLQlJvemJSVm00ZlY5a08wNWEv?=
 =?utf-8?B?NG56MlpnY0h2MldKMkt3WHRmc1Z1WWNDR1dvWnI2WmtkMExaZXhrS3VVL0Jt?=
 =?utf-8?B?QXdWUGp2V1EwMHlGM1lVVHFTUWhtcXRyN09WL09CNlhBZEZCNEVsMmh2emdJ?=
 =?utf-8?B?V3F1OWtrbHc4ZDZ1WU5WdVl6NE1GSFZMRGZ6a2dnQXJMYVFFYitLUm4rdldN?=
 =?utf-8?B?MHROa0ZxbnFaUlpTanlWd1RyakNZWlhYMlgyeHA4MmpZTyt2YnZ1V2h3SGpZ?=
 =?utf-8?B?bUpPQWZFUEtlQVBCVDdwbGUzN1RXMXFTQXhhaDVRZTRaQXZtUDU1b08wMjlj?=
 =?utf-8?B?MDM0YVhsWVdiSjRRcnZOSUhubzNFbTU5eSt0ZFBPWmcwNTBMMEJsVEp2MUFp?=
 =?utf-8?B?U0xrL1AvVHAzTVdyb2IvTnd1Rm5saGtOUkF1YTYzRllmYjNSaElQc3dycjU2?=
 =?utf-8?B?ZDVpVVZaL08wKzYvc21PU0pQbEJ4dnNFSUt2NmRZN2lmQytWMGR1akFLWU1H?=
 =?utf-8?B?V1YxUXFhM0U5bGpWNzVXaEpSUmc4RE02eU1mU1R4cHB1NytYc3RCd2tXakpk?=
 =?utf-8?B?SjhGVmJMMGdseU9SMzRQVnp4dnBIVk1nRWJpVnZBbzJ1ZjllSmNGMU81VzZi?=
 =?utf-8?B?UlNoVjZzYlkvQzFET2wrYjdGNm9mMzFWOFNUakdJS3NmV3hEdDVqOVFuUU1B?=
 =?utf-8?B?Z3BlVGRRYndFdjM4WmtLUzA1emdLQ0JyUkF6TzFscUNtVkoxa0RPM3B3eC9n?=
 =?utf-8?B?a0g5WTArK0xiK0wrdVJzV2Y2Tm9rWm9kaGN1NzVIYkNXYzBvQWUrc09pZnhE?=
 =?utf-8?B?T1V6am9vQkM4bTNxMENwM2tURGdXUjlMREJWOFlxL3h4K3lZNUZ3Z1RKamtW?=
 =?utf-8?B?RTM4Ly8yaFh1cTlCMVN3M0NGVjJ0T0c2cU1JQ1VMUXo4dFg2TGE4SHJwUFVq?=
 =?utf-8?B?NElTR1FFV28vbUoybEFKTWFncHZtS3l6VzVDNDNMMnl0dWJTQXd1S3o4WVQv?=
 =?utf-8?B?WWduV0l0dlA0RlY3V216VmdKaWVib01IN1Qwem43TVE4MHY3MXRlZmY0RVQz?=
 =?utf-8?B?dmtiNGErenNxcHFTY1hwcDFuVWZPc2RaQjNVOUF3ZFEyT1FkcG9jTExFSFFY?=
 =?utf-8?B?TmQ3aFVTWEtPaDZZZ2NTODN0MnVoYVlOVXkyL0JXcHpXNlEvV1dqdFV3aXQx?=
 =?utf-8?Q?bcte0ybXYO2+cZHUtBEsfC9br?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fadeaa9-7ab4-4038-5910-08dcb76b6051
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 05:31:38.7807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuYJW5WkBHb5oIeJ6JOwnTS1QlHnOweB+z3IBQZQqy4s9B+Xc9cNSKeRSikJW7tY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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



On 8/7/24 16:36, Simon Glass wrote:
> Hi Prasad,
> 
> On Tue, 6 Aug 2024 at 23:05, Kummari, Prasad <Prasad.Kummari@amd.com> wrote:
>>
>> Hi Glass,
>>
>>> -----Original Message-----
>>> From: Simon Glass <sjg@chromium.org>
>>> Sent: Wednesday, August 7, 2024 3:21 AM
>>> To: Kummari, Prasad <Prasad.Kummari@amd.com>
>>> Cc: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
>>> <michal.simek@amd.com>; Abbarapu, Venkatesh
>>> <venkatesh.abbarapu@amd.com>; git@xilinx.com;
>>> jagan@amarulasolutions.com; n-francis@ti.com; d-gole@ti.com
>>> Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
>>>
>>> Caution: This message originated from an External Source. Use proper
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> Hi Prasad,
>>>
>>> On Tue, 6 Aug 2024 at 06:08, Prasad Kummari <prasad.kummari@amd.com> wrote:
>>>>
>>>> Added LMB API to prevent SF command from overwriting reserved memory
>>>> areas. The current SPI code does not use LMB APIs for loading data
>>>> into memory addresses. To resolve this, LMB APIs were added to check
>>>> the load address of an SF command and ensure it does not overwrite
>>>> reserved memory addresses. Similar checks are used in TFTP, serial
>>>> load, and boot code to prevent overwriting reserved memory.
>>>
>>> The SPI flash may be used to load other things, not just an OS. What is your
>>> use case or problem here?
>>
>> [Prasad]:  We have observed that SF command can overwrite the reserved area without throwing any errors or warnings.
>>   This issue was noticed when the TF-A area is reserved in the Device Tree at address 0xf000000. The sf command is
>>   corrupting the reserved area,  and U-Boot relocation address too.
>>
>> EX: TF-A reserved at ddr address 0xf000000
>>
>>        Versal NET> sf read 0x0f000000 0x0 0x100     ----> Overwriting reserved area.
>>        device 0 offset 0x0, size 0x100
>>        SF: 256 bytes @ 0x0 Read: OK
>>
>>       U-boot relocation address relocaddr   = 0x000000007fec2000
>>
>>        Versal NET> sf write 0x0000000077ec2000 0x0 0x100   --> Overwriting reserved area.
>>        device 0 offset 0x0, size 0x100
>>        SF: 256 bytes @ 0x0 Written: OK
> 
> Yes. There are many things which can overwrite memory, e.g. the mw
> command. It is a boot loader so this is normal.
> 
> What image are you loading here?

In spi boot it can be Kernel/rootfs but at the end of day it doesn't really matter.

We have protection for srec, fs load, tftp and wget already.

c6855195e4b4 ("loads: Block writes into LMB reserved areas of U-Boot")
aa3c609e2be5 ("fs: prevent overwriting reserved memory")
a156c47e39ad ("tftp: prevent overwriting reserved memory")
04592adbdb99 ("net: wget: prevent overwriting reserved memory")

And this is just +1 patch to protect sf command that it doesn't touch reserved 
location.
The same code should be used for other commands(nand, usb, etc) which loading 
block of data to memory because all of them shouldn't rewrite reserved memory.

In connection to mw/mtest/etc command protection can be also done but not sure 
if this is useful because you normally not using them for booting.

Thanks,
Michal
