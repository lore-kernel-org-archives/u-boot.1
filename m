Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEE3CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 09:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6742809A5;
	Mon,  8 Sep 2025 11:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mU78cvxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934F182AE9; Mon,  8 Sep 2025 11:01:55 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 851C5800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 11:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peIW3BlKJhEopNG1mNkWg25jT0ZRrAddgXLldgVvS83mu3R5hjn6dPIJsbxHy7EV2E0BZ8k/OLtuqROseJKCzIk4+HtYbZqk73Uo0kwNZAuD2NJAUM/YobQz0mJ/M4rodV2tszfSezycTcNnROLxfyabs+vD1CRRH7GMOHqtxEYmgb+2y5t4RxLzJJZNeKdHHXPqJDwbMB+iekLThfez5fX2BvefXN5Ttd0mUGNY3S/J9U0lsIboFN30Od0HSnfDLRlbfgW1Jn/KONXGZEjjBPwgsPH5JNpkqCUnRp0ufTWr3TOKOx9S+kpwSOzScyoli/TnofH101P+9uSjjxpGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+RbdPzLMMItHZx9PPZs0N02/XPXZFA1/FT0jHJ4RII=;
 b=rvAnPNkUzUczpefIa6I1nqWMUhBXE2cVvJUKAUOHSxIHbyaNxMkALTIiKL6zcNQX4BWCeDnte8YJDPn7sbbb59yagS8iIfFp4qerkBpFhh8aYHAS/UDwD+csgBfKRFd65DKTN4LGzmp1xj2Uhz0bESwhrV1Cs1Bz4z/vN6OrDG5NHxeNszOttiKXBIsYUMUamZgzCWkeDR3Cu41f+uo7EtpZWyDkJ1rgQkWZUThcvtELDBB8St5VCJI716HLhDqOLSAyOEyq9owx5dC3wG7oBHWDmnPmE5GPZ+tTn99jIpVr9HtlnPtbvBuSaqAfTXmEFJ6t2/mnAvUbuhDVmMFPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+RbdPzLMMItHZx9PPZs0N02/XPXZFA1/FT0jHJ4RII=;
 b=mU78cvxlSklEg/lv5x9zQlhxvhBMUComicdp/h6JW4wm6eiUEpQ2Jr2LDY5GwMoHEWkuzIoU7M/fqkCgLlflgTp8evJr0PL5DCD3CdFQ/DworXYMMOZQ/RzsoWD3YbOH0j7v1irBbgl9oho66e7+ORlk6M5vH4uKDtPTYSGJvNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Mon, 8 Sep
 2025 09:01:50 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 09:01:50 +0000
Message-ID: <bf02f69e-7385-4046-ba2c-3aeca132c744@cherry.de>
Date: Mon, 8 Sep 2025 11:01:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: add README.pmic guide for PMIC/regulator framework
To: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, u-boot@lists.denx.de
References: <20250902050730.5289-1-bhimeswararao.matsa@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250902050730.5289-1-bhimeswararao.matsa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: eeba0815-c924-4448-9fce-08ddeeb658c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aW5ZbklwU2N2Z0w1MittK051WkxPYjhGZkZpeXRBT29uY1NzVi92TnBuaXlk?=
 =?utf-8?B?NWJxL3dqa0dMZmt0aXVacEVsSmNqTnBadnNQSjZURzlBNWEwcWlJZFM2U2tR?=
 =?utf-8?B?UFpNOVhHeldoWWxWVktxOVVrQzBNekVrY0pIMGt4VW5TM2xXZGJBM0RBZjcw?=
 =?utf-8?B?Q2pFYWZYQzVmMkpVWDRtdUFJTjlWV0xhUG02WUsraFF1VFlFRi9LNC9MVUZs?=
 =?utf-8?B?YVg4RVZZbFkzNTRxNmhOMFJMZi9oWDNYZUpHTUxPSmJvTGdod00rR0J2UXkv?=
 =?utf-8?B?MVZuOEJ4MmVJUWMwbCtMMm5GQjZITVpkVlBTTmxES1Jxa3g3bUNYRUtuS0c5?=
 =?utf-8?B?dGNCUHBDV3pSRU9RNkNlWU9HWk1Tb21IbzMwVnE0MHZ2aGhMc3F0bmx6blRp?=
 =?utf-8?B?Y2ZVVFFCRU0veVEybnQyQUYreG95SkhRaG9JS25kdTR2YUhwY3Z0Y1kxcnhK?=
 =?utf-8?B?MkNCKzc3TlUxNk5ZajVhajNhTEIwNWtVbnE3OFJ5QUdQY0h3TW1VeWtwNFJS?=
 =?utf-8?B?OVRudk1ZVkJUcUR5U0hWTzAxL1VaRUNnbHNYdkdzeldwS3VCWTBZempVQnpa?=
 =?utf-8?B?YmVGdUxqTkw5a2tseG5SWk0xcDN1QXRxZ2hPVTdHdm9sNE03M2xZdy9QU1pa?=
 =?utf-8?B?WlRtajFmVFR3RHF0YjBieHIxeThxOEFQNU9Dak9RYUNxVzc1anhYV0puMGJu?=
 =?utf-8?B?WEVjMlUxbjFmcXZtdDBCWXl0RUpYbzd2WFVSbkM0MHlHSzBXWDZiOHBtT1VY?=
 =?utf-8?B?VWN6TXViSDRjOGZUYVBNZVdJOEV0NVVrbHRqVlVvM1oyM1d6VnVteENFQ015?=
 =?utf-8?B?dXhmTUtWMGEyTXVBek5GaXVMbDF4T2Rxb1NQK3JIdi9lK1lIa2c0WVZiNExn?=
 =?utf-8?B?WlBVK2FaRXY2VSt6eFVtWDBqWDhSYUJaWG5TWkZGZzcwMG5taE02bjFCak5u?=
 =?utf-8?B?cFNOeVNPbDkwYU00cXNnZW5aNTFYbUJtdWVSQ2lveUV6ajBLN2cvRUdESWVu?=
 =?utf-8?B?emNHNXlOVW5vU25ESWsxa21uL096dm9WSWpFaTVsOURpNWFzOW5idk5Pc1hp?=
 =?utf-8?B?ZkZQZXhnY2Y3TCt1Z1hsek1oU0gxdGFWQnNWNTF2NkVjVkdBQmp1dFV0clpX?=
 =?utf-8?B?NEJkSG9Fd0lsRlNSeDlETnVlaGdDdmJHMHBTYTB6TVZWYTFGNW0xTHlLRnBO?=
 =?utf-8?B?UG9SMEtLOTNiOU9kQmlldzVrZng5eUJ1TEdYUmVLUTBFa3l2RkZIbHU4YXlJ?=
 =?utf-8?B?L2Fib0FuazIva3VvZ1QySzBmVWp6a1Z2c3loWVhZc3dCSTVXbHhJVk4zWG01?=
 =?utf-8?B?cDFmTUh5NjlwMzU5SWJyeElFMDIyQ0JHc1FEVmRxOE1WMjhKUENlVnk4M1Y0?=
 =?utf-8?B?cGtkczNPMmN0Q0FWbXlDcndCdnN6RFlQb1YxcFJ6S05iS0NSY1lBQjRGWmc3?=
 =?utf-8?B?OWFOUTMxUFR5Y0xLZlBvTEQxNkZ0RVhtRjEwWVRHV1c0ekhSM1FPNS9CTDBw?=
 =?utf-8?B?WTBlaHVpVmNmbm1VTTd5Ym8zU3Y5OUxkZEw0UmtsT2V4UnRPTUswQnVNNm5W?=
 =?utf-8?B?OXBEeGVMYWFwYUZsNXVTWnRQQy9CcU1YZk9HbDBMOHJZV0tYV2dHVEh6WHdN?=
 =?utf-8?B?VFJKTlhBWG9BSkk5bHJDWS9uM0lBaFlCRHhlZ3BkMnFqVkF2ZEYreXdoSm9w?=
 =?utf-8?B?OUJlemczeUxJaHNkcCsvbGozYlpXOXNMY3pYSVhyQ0FtS1d4VXlmVWZQU3Nk?=
 =?utf-8?B?ZDIwVnN5ZEhKdWRyK0oyS1B3cGZVc3pqcFI1Q2kvNUdOMTNkaTBmQkpvT1pz?=
 =?utf-8?B?SDNHaE1sQVNyTUdHaE1YNXcrYWdTMEUxSjdsS1F2eC9oNnVCdVhYUnB6WFA1?=
 =?utf-8?B?OXI0cVRTdThId3RLb3FseWQvbzN5MWg0bzR5UUYrZ0dKNjEyWFNiK0FOZkx3?=
 =?utf-8?Q?DK1ma499eiI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFMTnF0VkRZcTQ4Z3RFczZyNXRzWUVJbTlySmVFa01RUFdwT0ZCVFhyNmJD?=
 =?utf-8?B?V0QwQ2lndk5ubDZsQVZSTXcwcUNwZ09FTHpEWUsrZWowNzZvVVEwV1pnQ2xW?=
 =?utf-8?B?SDVHN3lIVGNMYkNydDdxS0Q5M0E4dDlleG5XM0p3a29na0M0NlB0UXdQc2xB?=
 =?utf-8?B?Z0xjb0xzU09nbk4xV2tPbmZWOFBEbHREdXJOQ2d2OEwwZTFWdWJZRjc2aVp0?=
 =?utf-8?B?UVI0QjJ3Wmg1ckZHdlpMYVBXK2pKWUxTR0p6TGJIQTVHdmU4VDVqZm9kblZO?=
 =?utf-8?B?UEdzdGJTQkxiQStKbGZ3KzZLaFZ0eXRHMTYralpNYmxRemtZSEFITXdzOENM?=
 =?utf-8?B?KzJwTTN0aGtBZ1RLeFQ5ckJjSVErWllmajJHYW1PWjU4Y0dEWEFwMlAybnJK?=
 =?utf-8?B?ZzZZb3BVeGMrdFhZU3B4UnMxTSs2eVJrTjZoSWs3TUhlamkrenFqRzFNNjh1?=
 =?utf-8?B?UGI1d1c1TDI0ZzJzWEI2TVF3RjliVjNybFRaR0pWQnF6OVBjOGFVY0s5UThu?=
 =?utf-8?B?eldYT3ZyZEZMWVpyeGJPWFNDbXFiVXJlZ2l5SlV6dmZkUGdVREVPOFZUbE1r?=
 =?utf-8?B?U1k5b3F5ZU1GOUFSSk51QXJVTUJQcWU5RFRzajNkU0VrWEFsZEs5bnNndzgx?=
 =?utf-8?B?MFlJS2JnSTYyRHhpRlVJd2dFSFhxbkFxckVFdUR3ek4vMlNOZHpKT3lyd09G?=
 =?utf-8?B?eUlwZjFTalhXVytqRktIZzNMa2p0NEs2YlBseGJtTDJEYmhOWXduUzJ5eGda?=
 =?utf-8?B?NzJxdTVMNSs2SVJVWkZpVHFidmNhQjVoSjhsTmZLc3NXTmkrVlNKWGwzQkk1?=
 =?utf-8?B?UzBKWTh6ZG90QmlERlhia2xPTTUyK2RVLzNSa3lkS0JjYzhvMUZndGRXSk56?=
 =?utf-8?B?OFVOeFRaWXdoY1p6Ty9wL3RndCtxVmwyUENaM3MxMWFxd0k2ZnRMR2xXU2xi?=
 =?utf-8?B?M0dtZk4rbEhYV3ZnQ1UvSjdNOU82UTVkZkVCZ1JxWDBYVTRtYW5WMk9PRHNy?=
 =?utf-8?B?WXN2R3BTZDEySGNDWHZlUS9acDQwZldXc0NRMWFKdGtZbVliYW1tS05MQkpM?=
 =?utf-8?B?cjRsQkh1U0szTkMvWGdJdFZ5R1M1R01ycmxjd3piMnJ0K0Q4VlhmbEIrWWlv?=
 =?utf-8?B?UXEwcE1IN2dYQTdTckFsZEs0YWRndHFOR0QxbmtBQURXYUxJRlNvSkxTaUNU?=
 =?utf-8?B?aCtNdjBIY1IxTzFjakFhYUtMRyt5c1dBR1dvRHBKQTJQS2tDU0h6bi9GQUJI?=
 =?utf-8?B?SXBtR2hhcUZEbGpFbmRqVzdEWC9jaVZxVUFkankxbWFjU2gzQ2hYLzhVakNs?=
 =?utf-8?B?UUJkSlYybHVPdVdVdDRKQVB3U1dJUGtCYlVZL0xyWEdLWlFWbnI4c1JDTWFZ?=
 =?utf-8?B?dFoycmNiem4ybkV2aUh4U2x4c0F6UHY3WHhua095Vkp3cGJuMnRKTHpPQWE1?=
 =?utf-8?B?WjFUQnFvVWNXUDgrU21pNU1NQktjVjFpeGp6cmZrYi9GaXgrWldRUkRFNERH?=
 =?utf-8?B?R2pkb0J3T0pxNVhldjR3ZG0yaUpYbnNIRFJJRFBrdWI4VEs4QkkyS3VJQXdQ?=
 =?utf-8?B?T1MrUXRiU3RBS1dNQTRyRWFVYkFtbnVNYlFoNHdyMUNHTlB0MktjRWxWbUJq?=
 =?utf-8?B?eGQyT1diRFRjaFlZNno4NUFOTlZLU2lxdWFHMTN5RDhZWXByQ3BNRFFvMmFU?=
 =?utf-8?B?czJoVEQ2RVpHN2kyWFNiTHNweDVPbEhUaE8veHhOWkVRSjAydm83YUZHN3JG?=
 =?utf-8?B?U1Z4aVNnQzZTRmUwR0lWejRFKzc3ZGREMW4wUVRqeVRBc29Qd0ozOHpjL0JK?=
 =?utf-8?B?RHBTOWlFTjVDRVBMZXNVSXpyeUFiVDZxdTZycExYdGpVclRTY3VvQWhzUnlK?=
 =?utf-8?B?VkZhK2V2ZTUvUnU4ZFhrUTN5bVBlREh1S0haRVBocmQ5Ui8xNG50T2NUeHZY?=
 =?utf-8?B?TUdQWFdyWmtBQVpLa29VdTBNZGhMV3BQZUxoRkxFeUpDc2c4TnMyNG15VzEx?=
 =?utf-8?B?eCtmekRFZXJJMDJNckpNRWgwNlAvMDdRMXRXeGtSbUY1WnoyQzVsZkRiYnZ0?=
 =?utf-8?B?RkFuTWtPNnQzRTZwTUVyMHp2bm1yNVY3YVBMTE1BZjZJNUNGemZMRGJMSU1s?=
 =?utf-8?B?S0dPRkgyMGdWNzhqbzlPTUlpRVljTjUycHJxTnB6K2JBQk5pZjRvdkJFQVU1?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eeba0815-c924-4448-9fce-08ddeeb658c5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 09:01:49.8833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqDXMSsf70AgpSZhOZfPqC4e8R1X+sSO4oeP5MOulocbHfvrogfOf98hQnUHEwqhggzkOTPYG9+T+dM8L8qOoeoCxLKpO2T+ne8BLXBQn+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759
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

Hi Bhimeswararao,

On 9/2/25 7:07 AM, Bhimeswararao Matsa wrote:
> This document introduces a developer guide for PMIC and regulator
> support in U-Boot. It covers subsystem architecture, Kconfig options,
> Device Tree integration, SPL considerations, and debugging methods,
> using TPS65219 + BeaglePlay as an example.
> 
> Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
> ---
>   doc/README.pmic | 345 ++++++++++++++++++++++++++++++++++++++++++++++++

Thanks for the patch!

We're trying to avoid new files like those which aren't properly exposed 
in our docs and would rather see rST/sphinx documents instead. Maybe 
doc/develop/pmic.rst would be a good place for that new file? (I do not 
know).

Then run

make htmldocs

from the root directory and check the output from any browser by opening 
the index.html.

You need to run this command from within a Python virtual environment so 
you have all the required dependencies, hopefully 
doc/sphinx/requirements.txt should contain everything required to setup 
the env.

Cheers,
Quentin
