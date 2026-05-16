Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4113CD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 11:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4F284659;
	Sat, 16 May 2026 13:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NYPit6dG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 290A28465D; Sat, 16 May 2026 13:44:38 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC5B83EF9
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 13:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQhGiAUpPG5u3nG4PaC5XaMmjraYcYHhuc33rfunSnBNQvp9P620/mFdcH+ZKsY5tzn5yrAXxTEEbOMVz5Pbs7pPsWWsbm/hQ/Ob2TMykhvkPnRNJapPluRG6AGpAIVWU6GT9eI7VDO5YGtKVnKcdIpY+2JK/c71zhaLPACQgPkg4BV4E3rCd6euktlrvAuJDO0Eqzh+OkuKaaZ5Nadz4+2ug6+sSFUUjXnoFWqP/M8+hr9/W7Uib7Q90eBxZfcIBT3UTK3OAfPWrZbd9mRSnbOhGK8V9tAvFEfxH6iJ6xi+0pt2Bn91Zb4Ske8kOqp5RBK7XvDVB6XOSUNFxR7wKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jpk2N+bWrpPPuQ5UpuSIwm9DJr8v96DqDGfGZace7X0=;
 b=EpA8ObHHIDit3ngUIvC/XzOO1pspucHGyVZcNFnolfr7g2HyUT7yJZbX5ee+BDLDGquvQdxLxEXQeQOINWHoaDhMIXIvIt01avbSLkTxGFZLaoqTn8xwp076k9xgvt0bekZiiV082p620P4tmViql9MEMwy2gHo62akDGQvXIkicYRPw1RUoVqyplp5KDRORYIPMWtRrOCXqZ7a0a/W6t2WpJ8ijq3nNGdpjg62QPrWcxf7yADjjB5j6TQx8AWqTy0bRfm2rzZ5Iib1QamdXxnJvhzFel8hMVEUY25Si4BjYXraTrN8OUXzPUk91XTG5ec8td9CkeI3M3Kcffr/KUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpk2N+bWrpPPuQ5UpuSIwm9DJr8v96DqDGfGZace7X0=;
 b=NYPit6dGwG2MLtTKld9mna0MOnELusSYPj/Z3k09ILy4wEVerCuQ5zp8awFblW0k/na/FaZsfGkLnE10pggpe9lkr7/f4Ienwcjl9/lsq18FYZrhICzb0F4ejo7KxVdCj7oNeRsPEVXtBerY4mYyKHqSSNjS2HvfTsbwYgURqeo+Mtd+vyiOHPbbfveOC6ufnINLgarOxCmqYKH3/+5i0LO4Sjx0FFEWhNQLjEdGGD9uIFlHg+RFNTi5JwbXhu94Te5Y0CxkiS1IA4fFi0lSukWkjRkqJQU3fX0/wy3eRmxrYABn72xceUJAX59sRADeXiV7jVhGpl9KOsR4lOxW+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BN5PR03MB8054.namprd03.prod.outlook.com (2603:10b6:408:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Sat, 16 May
 2026 11:44:31 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0025.020; Sat, 16 May 2026
 11:44:31 +0000
Message-ID: <f87d4c47-8675-4b43-b076-52325e2c00ca@altera.com>
Date: Sat, 16 May 2026 17:14:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
To: Peng Fan <peng.fan@oss.nxp.com>, Judith Mendez <jm@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, marex@denx.de, tien.fong.chee@altera.com
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
 <agg8f-Q_RnVI9Gyl@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <agg8f-Q_RnVI9Gyl@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::7) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BN5PR03MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a12dc14-ff5e-4926-67fa-08deb3407d95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|55112099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: oU5mK/RXCvsWvBbwNk+FWIIMIC8bAdiL/RBwd+n8GzYfBoZkbQAA4CjhpXFvZxOc14Z9Pq19VUushNaPVEeY0B6wRM8YK5PmgQfjNrwU2V5WhbxPYw9stLJZrHWF6Smr1jxzHCuQnuPAOwupBShch2DPPwQp7EwoF97nvulY3PiHwbp1soU6kIP1n6S/InnUG2+sYB47dDz7E3NI/eqYOxdzOZomSUapeUwGIpzIs+0c0ckTXCbkx5ebbdQaWmO1+NwBiRm/kUhqjw4DuB5LJ76WUX//3U/dTTv+CHRfydoyaHFkDUswgg+Y/WMyKclkmsk4sGF/h0kXue2Ut7coR+fS1O9x9Md6HR/B2Lv6OLxN/X1LhuMzc5YiDN82oco7ThS+61sezzMBNiU0DFpLzYq9zT8IFNBHCC9Lo+N7dEUdaru2FYpHzVJZRL1jUH4NdQesCfmogLCRskEeQs+dGbXpuQsRG9M9uh0co7Z4Uw6xCvb1OMs+Y8X1bbgdJKojOh7AExV6Uuq61ra/hT0XfZ+2AwbM2wxKuVH1Y71SnnYSNWYpJ/cXayqKNExewu3QYigSJsI34kjmGgCgXECzEmhOJCuoGK98lVe7YPyQEAgAtcl4hHkmFgOTUfnfOC/m+T06OfgKTJ0pZunoN6Ap8q3+/6AvnVszkncCI/aRm/gS55149QvRA8GxqavscBKCk1w0G4rEa+4HUwtVEu1Asg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(55112099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3VXUGpaNDRPUkVBcVJoeSsrWlplM090SStjTWgxK1g3WlZ5MDBqOG1EbWFu?=
 =?utf-8?B?UThvVHhkbTVuNDVRWkxEc1Y4a3U1TGpKY2REQlJvZm9oWkZjdEx0ZnYvZnR4?=
 =?utf-8?B?WGc5dnZudVpabkc0RkRXY2RzV2U3Q05iU2k1SVVsTGcwalNOK3ltbGREOVIv?=
 =?utf-8?B?S1RibVpNZDhNWFFxblk2N3A0SmZQQ0pmUGtpZ2haWFF0aDVoZzBpYy9LTmRK?=
 =?utf-8?B?aVVqRHQ1L2FZcU9TeTJ4K0E2K0sxQmNYSFRLMTF4NWd2d0FZSUV2L1pJd2Vj?=
 =?utf-8?B?bk8yQjhYWnc1NzVUK2ozeFA4NU1rdzAwY2V5SGdQWm94ZEl5aFFHVWJoTDU3?=
 =?utf-8?B?cXRlYlhTRUxJT3R3VnB1Q0o5YmozQnR5Z3pDWXVtcXBRTkhGZEJwNmZtUEtQ?=
 =?utf-8?B?a2FPaGwrU0JRZWkyNUNheWFscEhlM2kyME1JM2pya3hVbDVGb2d2UVJRVU0y?=
 =?utf-8?B?Q2dYRDJpWkpGR3NRbTRFa0JnL3VuVnZLVlFvMzRRNnYwRkZIT2h4dHNydVk3?=
 =?utf-8?B?VXlQOVBsakxYZ2xoQWV4UTdzejBrK1llVDZ4QjB2a05VRXNrNkxjVVdzRmND?=
 =?utf-8?B?MHFxSk9uMWJaaEM2NURDZjcrd2k4ZHNPczhLMC9QWllwZzFteC9HVFVQeFpq?=
 =?utf-8?B?QSt1VlFzK2ZtZ3pLZGxITWhyUHlaZ2VRYXp4TjVXaUkwTDNxMDVrdlJaam90?=
 =?utf-8?B?S0xOMzVLaGU1aEttWVlJdVgxdGF2VTI2M2ZNYXhuRzFzTk8yS3duZGlVb0FL?=
 =?utf-8?B?clhhVDFBbjlQQ0p6RU1xdVlrR3ZES0REeGovRGw4emZPNENtMDY3blRtVm5I?=
 =?utf-8?B?WmlLSjBySFJlQnFzWGZiNmFnVEdwTVF2ekpUYitXdUNOdjBjRWRqZ1lydWtl?=
 =?utf-8?B?U0E0VW42N0F0Qk4reEVMT1ZVRk1iWHFZWXVXT1NMbUtqK3ZOT0xKODNtY2sx?=
 =?utf-8?B?d3RpT01QazA4Q2VRUFNYMTlrOXdLR0svaloyclpEV2tjZ0t5MUxab1N4WWpz?=
 =?utf-8?B?UEFlS01rUXlUQlRyckxQRThqQTJZSXdPekh2V2cwK1paYUYzZ2hWRGF6Smc0?=
 =?utf-8?B?UCtKNERTeHBDdDJsd3Bta0hSVkhaeXhMNjNZQUhkUkpjcElYNVVhekdnUWFC?=
 =?utf-8?B?ekJmVXJKeEI0ZnZISHBCT1MreWJlOWo2L3A3a3FNMlQxYkpyc29xa3BVQUlB?=
 =?utf-8?B?dWxZRE00NVpoZ3liYU5IdXFrWWpFUTJadUd2UHZma0lDOXB6blVOTUNjektH?=
 =?utf-8?B?Q1J0ZVhTZGEzV1I0NzRGV3hqTVZkOE56bXN1M2ZFMHVtbHd3U0w5U3BFRjRL?=
 =?utf-8?B?djhIT1dkQjdaZWN3N2QvT2tLWmgreXZYK2hIeWVZenUxcGMvdmcyOERUMERn?=
 =?utf-8?B?Sy9WYVFIU2J4OVhHZzgzT1ZrTzgvZG5aM0dEZGJPd3lCQnZjOHBKSE9aRWc0?=
 =?utf-8?B?QkxGVTZmNVdNZjlQZEhKTzdWQXJSMzJlek85NnVaeHFhekJNWkVPalZ0VkZC?=
 =?utf-8?B?dGxIVnZTaTFuRjUrTWxjM2pOdmw3VFlVa0VhVDFFc0tVeGRYS3B6R0dNOFIv?=
 =?utf-8?B?NEMyOGlsK08xRGJ1R0tpK3NQTGJ6SDdCSElXNHpzTzdXOEo1bG5kMUhSUDRG?=
 =?utf-8?B?bWRxSVN3eU94RElpcVNEWWZFZ2NzZktCaDFCWTNZMTMyVVZLcnZIaXA4cytx?=
 =?utf-8?B?SEZabUk0UEtUZ09McFgrY09oYjNTemdoQ3kyQkZtVGpjTDREWVF1S0E0eGl6?=
 =?utf-8?B?OXdraCs1UEJhNk9CaUhYam1DRHhiK2RyL2RqMnJOYndIYWtkKzNZekc3ZFdS?=
 =?utf-8?B?Y09xcFZhN2ZoQWpTNTZZZm5XbVdkRDdpaG5zYWU3ZlRLakRFNWN1LzFuZVph?=
 =?utf-8?B?Wm9JNnYydE5UTVdCUk9GdG41ZVZNOUc4RTZpNERWM1VhRkFZWGtxbW81eWtG?=
 =?utf-8?B?ejhCRnQxemlwNkhqdUtuTk5vZVFLTzZYTmlGcnBFNnJmT1R0bnRLTHFMQkVu?=
 =?utf-8?B?cUQxcUpQRUZiZVg4Vkc5WENaeUFwc0F3RDR5dHBSYTl4cVR3U3JjRExEZW1P?=
 =?utf-8?B?T1J3U3J2bHU1ckRBRjVRaExEcDdNay96dGE3SnV5ZXZDcU5KZktSSW4wYzVN?=
 =?utf-8?B?SDJ3UUp4eGY0Y2FDRU5QOC9vY1I3TzJ5UnhiU0RrUHZIWlROM3pOMUNVK0lE?=
 =?utf-8?B?NGgzUUp4SWZhTnRNSnJHWGZCMTNhOEFHSmxWRVd5b3JmY3RVOWk1cXpUNkJk?=
 =?utf-8?B?Nk43a2RKTm53eVdtQ1JBNEpPM1BSdGl3TFBDdnlNNXVhNFA1RjNuZWJDdnNt?=
 =?utf-8?B?c21oV01PVEcxRHk2djhwdDQrZytkaE1yQTJUQW92dDUrWEF1MHp1ekxBQS8w?=
 =?utf-8?Q?wimksHBnAItNk+3s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a12dc14-ff5e-4926-67fa-08deb3407d95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 11:44:30.9360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrArWyTs+eTq2z6QAfbyf2sCDonZ7E2n+43DZ1+IbtlRLZCuKcqde9TrQJML16A9XFh4i/yQujW14otMVQgZe67wx2mG4tCAxD56Dq5JP3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR03MB8054
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

Hi Peng,
Thank you for reviewing and for the detailed feedback. Apologies for
the resend — my previous reply had an incorrect timestamp due to a
timezone misconfiguration, which caused it to appear out of order in
the thread.

On 5/16/2026 3:14 PM, Peng Fan wrote:
> Revisit this patch, since it break one board [1].
>
> [1] https://lore.kernel.org/all/52ec8007-ce50-4f12-b796-4b8c2aa1822e@ti.com/
>
> On Tue, Oct 21, 2025 at 01:45:26PM -0700, Tanmay Kathpalia wrote:
>> Some boards have SD card connectors where the power rail cannot be switched
>> off by the driver. However there are various circumstances when a card
>> might be re-initialized, such as after system resume, warm re-boot, or
>> error handling. However, a UHS card will continue to use 1.8V signaling
>> unless it is power cycled.
>>
>> If the card has not been power cycled, it may still be using 1.8V
>> signaling. According to the SD spec., the Bus Speed Mode (function group 1)
>> bits 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
>> they can be used to determine if the card has already switched to 1.8V
>> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
>> transfer mode.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>> drivers/mmc/mmc.c | 55 ++++++++++++++++++++++++++++++++++++++---------
>> include/mmc.h     |  3 +++
>> 2 files changed, 48 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>> index ec61ed92e86..e1f62a5d0ad 100644
>> --- a/drivers/mmc/mmc.c
>> +++ b/drivers/mmc/mmc.c
>> @@ -643,6 +643,19 @@ static int mmc_switch_voltage(struct mmc *mmc, int signal_voltage)
>>
>> 	return 0;
>> }
>> +
>> +static bool mmc_sd_card_using_v18(struct mmc *mmc)
>> +{
>> +	/*
>> +	 * According to the SD spec., the Bus Speed Mode (function group 1) bits
>> +	 * 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
>> +	 * they can be used to determine if the card has already switched to
>> +	 * 1.8V signaling.
>> +	 */
>> +	bool volt = mmc->sd3_bus_mode &
>> +	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
> This is wrong.
> sd3_bus_mode is sd supported bits, not the current running bits.
>
> To detect the sd card running bits, need to use:
> (__be32_to_cpu(switch_status[4]) >> 24) & 0xF

You are correct that sd3_bus_mode stores the supported bits - as can be
seen in sd_get_capabilities() where it is filled from the CMD6 status
response:

     mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;

However, the intent here is not to read the currently active function
code, but to use the supported bits as a proxy for the signaling voltage
level.

According to the SD Physical Layer Simplified Specification v9.0,
Section 4.3.10.4 (Switch Function Command, CMD6): the UHS-I speed modes
SDR50, SDR104, and DDR50 (function group 1 bits 2–4) are only available
when the card is operating at 1.8V signaling. When the card is
initialized at 3.3V, those bits read as zero. Therefore, if any of bits
2-4 are set in the supported field, we can safely infer the card is a
UHS-I card and, when not power cycled, retains 1.8V signaling.

Using switch_status[4] to read the currently active function would
actually NOT work for this scenario. After a warm reboot, the card
receives CMD0 (GO_IDLE_STATE), which resets the card's selected function
back to 0 (SDR12/default) — even though the 1.8V signaling level is
retained. So switch_status[4] would always return 0 in this path,
making it unsuitable as a 1.8V indicator here.

>> +	return volt;
>> +}
>> #endif
>>
>> static int sd_send_op_cond(struct mmc *mmc, bool uhs_en)
>> @@ -1369,9 +1382,6 @@ static int sd_get_capabilities(struct mmc *mmc)
>> 	ALLOC_CACHE_ALIGN_BUFFER(__be32, switch_status, 16);
>> 	struct mmc_data data;
>> 	int timeout;
>> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>> -	u32 sd3_bus_mode;
>> -#endif
>>
>> 	mmc->card_caps = MMC_MODE_1BIT | MMC_CAP(MMC_LEGACY);
>>
>> @@ -1451,16 +1461,16 @@ static int sd_get_capabilities(struct mmc *mmc)
>> 	if (mmc->version < SD_VERSION_3)
>> 		return 0;
>>
>> -	sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>> -	if (sd3_bus_mode & SD_MODE_UHS_SDR104)
>> +	mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>> +	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR104)
>> 		mmc->card_caps |= MMC_CAP(UHS_SDR104);
>> -	if (sd3_bus_mode & SD_MODE_UHS_SDR50)
>> +	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR50)
>> 		mmc->card_caps |= MMC_CAP(UHS_SDR50);
>> -	if (sd3_bus_mode & SD_MODE_UHS_SDR25)
>> +	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR25)
>> 		mmc->card_caps |= MMC_CAP(UHS_SDR25);
>> -	if (sd3_bus_mode & SD_MODE_UHS_SDR12)
>> +	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR12)
>> 		mmc->card_caps |= MMC_CAP(UHS_SDR12);
>> -	if (sd3_bus_mode & SD_MODE_UHS_DDR50)
>> +	if (mmc->sd3_bus_mode & SD_MODE_UHS_DDR50)
>> 		mmc->card_caps |= MMC_CAP(UHS_DDR50);
>> #endif
>>
>> @@ -1830,7 +1840,11 @@ static int sd_select_mode_and_width(struct mmc *mmc, uint card_caps)
>> 	uint widths[] = {MMC_MODE_4BIT, MMC_MODE_1BIT};
>> 	const struct mode_width_tuning *mwt;
>> #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>> -	bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false;
>> +	/*
>> +	 * Enable UHS mode if the card advertises 1.8V support (S18R in OCR)
>> +	 * or is already operating at 1.8V signaling.
>> +	 */
>> +	bool uhs_en = (mmc->ocr & OCR_S18R) || mmc_sd_card_using_v18(mmc);
> In theory,
>
> bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false; is correct.
>
> OCR (including S18R/S18A) only reflects voltage switch negotiation
> capability and intent, not the current signaling voltage. So your sd card
> should have OCR_S18R returned per my understanding.

I think there is a gap in understanding here. The scenario this patch
targets is warm reboot or system resume - the card was never power cycled,
so it is still operating at 1.8V signaling.

In that situation, when ACMD41 is re-issued, the card will NOT assert
S18A (Switching to 1.8V Accepted) in the OCR response, because the
voltage negotiation already happened in the previous session and the card
has no need to re-negotiate. Per the SD Physical Layer Simplified
Specification v9.0, S18A is set only during the initial 1.8V request
handshake. A card already running at 1.8V will not set S18A again on a
subsequent ACMD41 after warm reset.

This is exactly the corner case: OCR_S18R/S18A will be zero, yet the card
is already at 1.8V. The existing code misses this entirely.

>> #else
>> 	bool uhs_en = false;
>> #endif
>> @@ -2701,6 +2715,27 @@ static int mmc_startup(struct mmc *mmc)
>> 		err = sd_get_capabilities(mmc);
>> 		if (err)
>> 			return err;
>> +
>> +#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>> +		/*
>> +		 * If the card has already switched to 1.8V signaling, then
>> +		 * set the signal voltage to 1.8V.
>> +		 */
>> +		if (mmc_sd_card_using_v18(mmc)) {
> To switch voltage, ACMD41 is required, see mmc_switch_voltage.
> Forcing switch to 1.8 here has some risk.

Agreed - ACMD41 is required to initiate a voltage switch on a card that is
currently at 3.3V. However, in this path the card has already completed
the voltage switch in a prior session and is still running at 1.8V. There
is no card-side voltage transition happening; only the host controller
needs to be reconfigured to match the 1.8V signaling level the card
retained. Sending ACMD41 again in this context would be incorrect, as the
card is not in a state to re-negotiate voltage.

>> +			/*
>> +			 * During a signal voltage level switch, the clock must be gated
>> +			 * for 5 ms according to the SD spec.
>> +			 */
>> +			mmc_set_clock(mmc, mmc->clock, MMC_CLK_DISABLE);
>> +			err = mmc_set_signal_voltage(mmc, MMC_SIGNAL_VOLTAGE_180);
>> +			if (err)
>> +				return err;
>> +			/* Keep clock gated for at least 10 ms, though spec only says 5 ms */
>> +			mdelay(10);
>> +			mmc_set_clock(mmc, mmc->clock, MMC_CLK_ENABLE);
>> +		}
>> +#endif
> A proper redesign is required. So I am going to revert this patch.
>

I would respectfully ask to reconsider before reverting. This patch is
specifically targeted at the warm reboot / system resume / error recovery
scenario where the card is not power cycled. The check in
mmc_sd_card_using_v18() acts as a guard - it only triggers when the
card is already at 1.8V and the normal OCR path did not catch it. On
a cold boot with a fresh 3.3V card, the UHS supported bits will be zero
and this path is never entered, so it cannot regress cold-boot behavior
for any board.

Regarding the reported regression [1], Judith mentioned that he will
debug once he is back. If possible, let us wait for him to conclude
before deciding to revert.

This problem is not unique to U-Boot. Similar discussions and solutions
have been proposed in the Linux community:

https://lore.kernel.org/linux-mmc/a367a679-28f7-898a-c043-27df8c9c9aba@intel.com/ 

https://lore.kernel.org/linux-mmc/1506328144-13666-1-git-send-email-adrian.hunter@intel.com/ 


I am happy to rework this in v2 with a tighter guard condition (already
addressed in [2]) once we have more information from the regression
report.

Please let me know your thoughts.

Thanks,
Tanmay
