Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C419FD3760
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D940183E8E;
	Wed, 25 Feb 2026 15:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="n3f6U43K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B305383F59; Wed, 25 Feb 2026 15:27:46 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47FBD83642
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLIpY2SYJGalmsOUY+gjXwN9KzNrd93609IsHeXguQGyLGeqYw4ssltSvJp4nIkaEfohkVHJjpArW4cGTqOqc57cTRlYSFp55BzPtslsKJQ+ejwozEAv/yFNodPtXLzZwz+Ige+KWtVxRVTsJ9CAAOYymz8rAzTUUzNJaEkkXzWiZ8JMbRJfUwStUJ2A02/Ok+GWXN5Qcdwq9oU/BOnRZcgYQv/JWO0dwP0K6D/pLeCeVI3XB2jC/OzMPcgROoReF7EDgbOf+yY2MX0vNfeJbhyxXycpDxTpzI/fv+tE+hmRC0tbsd7K9la21LEX8y/8+BVUpyMinML/tZMw170oYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+kTimlZirF+w5DmGwHkCsCLa717pUUBaVe0uX6vq2U=;
 b=x531bJdMxo9JN3RC7UhDi33b6dEWzfIMxZ+Xe0YqiTSOGF7LC9xQDjuVHX/JH+mx/sPG8WcLOlagwGNF9n3hKIY3EXMY1a8mgvNmejV1DL9hXfOaZJSnXPS1oO8EwIqDnV7q/yJEp33t18oUMULxI/PLqVep/j2zwV783hyXvOde7KH8V/eAwTSNIh715dfZQSIRsWuX9/z8Z6pYXgIDyFBCsP8SibrrGOqXydeX8lkztZB2vIS/+6swKrPA8DFuOOTTOQhp7rAgi9qK5+EiRdvuGSOX3PEkuxdrBEpZYyDkoHDYoxKD2G8qpuMFg5nHHKD31wYualzDzw9aA0Ii6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+kTimlZirF+w5DmGwHkCsCLa717pUUBaVe0uX6vq2U=;
 b=n3f6U43K18dyhsmqrzd6rAjPI31p1BKphAEbgjmQWpfaLJpjeM/SDnWB0YUknwuheSb9bBiJg3ZjJ5Fvd2R5jcfjb8QTq6r0zzAnDYxxmPa0MSy2ZNtWcgqtW02S/Mjr1b395fyXvmm1iNwRIsk1B+GuJhEbjBM2oJZhMXVvuGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8350.eurprd04.prod.outlook.com (2603:10a6:102:1ce::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 14:26:14 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 14:26:14 +0000
Message-ID: <a278f2ec-4ed9-4574-8d9e-ad5b90fb6e09@cherry.de>
Date: Wed, 25 Feb 2026 15:26:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drivers/power/regulator: add SPL_DM_REGULATOR_FAN53555
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Justin Klaassen
 <justin@tidylabs.net>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de
References: <20260225065714.48562-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225065714.48562-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 438af068-b765-4120-b004-08de7479d4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: vYqGHigjYVRkB1N0uzmU3SCrBKlcOBcTHvCjEWt0pAMug4qK96W/pmbrNE5Ct8BXnA+ixSZtfrbSQPy5S1VRvIRnwx6IUfiPA8lup31Uv7YJHzKjKn/QaCs4Qld0JfaSTUSFIw22UdM5/curyQqylxfAbg5hLtDCpAl/M1p1HwaqlzgsK9j7HTnA0xw3NA4uzwj7ySUTRfJMHuoca1foFiwxBcQMYR/387lrPi4uFl+0+s6R5xDWcfVsBrIlmnf7Vf4x4ZJ/TyrFg9aMg0n6rWgnPfaTqPFGPK4f7uXjWR2B4GXOAExludX26O3+cU0i7C41Cw/X4QA6EDvNIScZT7ceHV4frLZGoHeHWGAZHj3Fm9uORlRezrOpXX4P2JDPWz2mbhFxg54ZpCgWdgE3pRRb3aUgEMPO+bFpWpZjUQU5AZzAkbKmrbGjTnbO9FcJJRSqA5bC3+OIMmpB002v/SE9u1lMHdTNdf0xhHWir76Ho2i64Rf213yvS3yIQt8a1BB5iwPKL+RLGjneD9VQUd1VOhFNeaqznbNlXzS2guB0KWWYqM9oXiv7jZyZlsa02LokNhtAeOYpCKyNyA/SCmeL4x0qv4287FSfSCP7VpggeuvmSVhSTLc9/6W2WVAI4PaE2p4/oEVFnp134AuWwV7eDwIibYjyEOjXBEsgEe1FkUCmFR+hPltnKcFqanatPvppbH/NuNDWWCAYjWZ5c0pM4KGXhmSWm5wIL2uDfR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2RCazNXa1piNkxNekg3OEh0TWpaVDBVWW1Walg2anBremtLeXR0QkR6Wmo1?=
 =?utf-8?B?QXE0dDZ5VEV6aTI5YkVpeEtnS2gwYzFCVzU5dGx0Ky9kYmpNWlFRQnlsL0ZR?=
 =?utf-8?B?MVMrby9sYWVoSUUzMko2VXc0WmR3ODFMR3BvRWcyaHRmM2l6SjB4alBNSncr?=
 =?utf-8?B?S3pEQWxiZkxQeDIxeVdqWUtXQkt6OFY3b3ZGU0pyQXZoOXM1MVpNVjRaKzla?=
 =?utf-8?B?cXo4L2VxUzVMVUZubXhHamhhVVowN2IwS09Ga2o3Z0lLbC8zaGdmVjRTeWpt?=
 =?utf-8?B?MDROOVI3eEVNQUNTWkdPMlJTNmkyaTRrOGlqejRKdVVYbDg3UHdXNUV5QUxE?=
 =?utf-8?B?T1FaZy9PbjQrNEpjV2hWM1lhK0gvK1c3OU53V1ViL0ZhaEx1Ykc3NlhNRmkz?=
 =?utf-8?B?dnhrRjR4RFBEL1ZkM3pKWjNVRnRyRHdWeGxLaTRRVmpleHlwVTRoUlNxZlN3?=
 =?utf-8?B?M0QySjQ5dTVQM2hJQUN5Tlc4TzJFdlhQbDROVm5XZ0I5UHVxYXhnYmxvN3c2?=
 =?utf-8?B?TjVNYnpCbHBGcDdieWZuS2ZVRkFQeW5rRW1TT1NDdTFJcmlCY0V3QmdxaWZF?=
 =?utf-8?B?YnUwZC8va21Za2lieFIyam16dXAvZ3p4cXFiVWhqYzJSSk5XUEptZ1BUbVFX?=
 =?utf-8?B?dE9aeExPaEFHek9WeU55amRUVTdaVXdXM3REU3B4Uk5XZHpndFYrclZuR3lL?=
 =?utf-8?B?Q3plQ0ZoWjZFVlk4TWd0cXdnQWY5OTZpYk44MHlIZkVVUnVsbWtMUWNiTTNs?=
 =?utf-8?B?VVprbnMyNWkwbVpLV0FqS2QzMUx2K1NnZHRxcTk3TGNpMk5TOHg5SmFvYUlF?=
 =?utf-8?B?cGFJc3FpdXpoV2lIWmt1ZlAwb0JTZTlWbFY2V3IyTFdneEprYXpNeXhHR1dr?=
 =?utf-8?B?MDhZUENVaHJqWldtWE1OTzhEWEhNYmlqWld5MUZhUFFnQkFCZUhkVXFUODha?=
 =?utf-8?B?VnBRWnNxL2JMOFNHa3kyM2o0QTVlTVhNem9YbGlOLzlnWVpWTXp4bGlEcDZL?=
 =?utf-8?B?NlcycGZtYzhhbHZBbkJ4YWEyam9jRTRQSGp4K0FNaUN5Z3I2bW1panZOOStx?=
 =?utf-8?B?S0R4UnZZWlNrc0JkOGtVblA0dFlyeStXSCt5aE1JSitmVVlJZmtNbmxjT1Bq?=
 =?utf-8?B?UzdRUE15VVJpWTFaZ2VlZTVzellqN3J0eWJFZk5McklqQmRqN3RzQ1Q5Vnl4?=
 =?utf-8?B?T3liZm1QQmtsWFVROUlhVHRQOWtoNHhXWE9PZTRRdXprN01hRTdTU3VwTkht?=
 =?utf-8?B?YXhmbW55V1lqQ2JKMEhCcG4vQzdFeDluUTN4NHhVTUJQSnNEQ3dheGFpTkVp?=
 =?utf-8?B?VmVXRVQrQ3k4cFlqT2RJOHVSbzZPVjlud3dOWWZaYTJXSVBrWFBLVkd4Y3Ry?=
 =?utf-8?B?YlM5RW5hVU9Oamo4bmVUd0xDaTJPVlozczRiSlQvdzZZWmxiT2JQcFZQQUdJ?=
 =?utf-8?B?ckNLRHhYTXZ3WFl6VjNDeE1aWUdQTU90em1raGRVV0xGSmF6YTE2VVIyR0F0?=
 =?utf-8?B?WlY5NWlvdTQxdHVOeUZIQU5zOFpUR3VjYkhWQmg5TEtvVVNQNnNWRm1xdjhV?=
 =?utf-8?B?TmxlaGc0ZDNnNmhHRGEyVDExN3QyYzc0RG8yTnhHL01PdjJJRXhLamlYQnhq?=
 =?utf-8?B?UDByeW1FUHJaZ2prQmdpb1ZVc3hpL2RTbXg4dEtwWkE5U2trOFYzVFRTS2Yy?=
 =?utf-8?B?NkdsdkpWY3E3NDBXQnNFcWUweWIvZHpZS1pXMk8wUXJWYnFDNkswR2VudE1Q?=
 =?utf-8?B?SXNSNHpqRFluY2F3WUphVkw4b2pPYXNSRlZ6YWo1WTlkNVJVZ0QvWWZqZ3FD?=
 =?utf-8?B?ekQ2OUNkQzFTU3JObDdWWVU2V1JlQlowTFFmNzkrQnU2VFBNRGlqVWc5TlZv?=
 =?utf-8?B?VXJ6OHhyYmN2RHB2elFzNnI2c3UzMjJXdGx5RmJPM0ZUWk5tMWxtV1NHN0sr?=
 =?utf-8?B?c054VXpJZFdsa3NaT1VBZGZOSUFrQWdwQnNuNEpQamJxOWVlb281emtLZ1FW?=
 =?utf-8?B?U1EvSXoyZFNNSmQ3VHMrRjg0S3JrcFIxbTJOMThybXdZcEpncEdXME9QOEZa?=
 =?utf-8?B?S1FQODBBcmlpbEZWdU1JWlJVakd6VUU4Q0RJTHdhYXpTQ3llbVcwczFvckt0?=
 =?utf-8?B?cmtwUDRGMnZvcG1lNG9rL2pLeVZkRDJWZkd3S0lwdUVSTzd6KzBDaGdNZmxK?=
 =?utf-8?B?cU03QjZHSU5qakU5blM0cmRpZUdkOU1DMEtzQWI1ZThIL0dsT3Avall4amkz?=
 =?utf-8?B?Z0NQTEFyRzZrWXQ3N0ZtT1BjSFlBNjdNRFZlKzVnOTJLTHdUUFliSkZYQ3l0?=
 =?utf-8?B?QVRreXJPMnpEYWlPUytjTHozK2VHNXU4dE1nbVRTdXJZOVNoWjY3UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 438af068-b765-4120-b004-08de7479d4fb
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:26:14.7650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iK1WaX2orFS4ARWkN/vH/tupS02XUZpTc8xszLwu7ThCtJg7nMkj9VewmTiYmZH+isEOxmTR3gFq/4B+hra1D0+eJIjeZRqpixc4oBQP6kM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8350
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

Hi Heinrich,

On 2/25/26 7:57 AM, Heinrich Schuchardt wrote:
> Symbol CONFIG_SPL_DM_REGULATOR_FAN53555 is selected by
> SPL_DM_PMIC_FAN53555 and used in a Makefile. But the
> symbol definition is missing.
> 

Well it is "used" in Makefile simply because I wanted to be able to NOT 
build it for xPL stages. I'm thinking we should use $(PHASE_) for most 
symbols in Makefile, even if we don't have an xPL symbol in any Kconfig 
file such that one would explicitly need to add an xPL symbol and enable 
it for the feature to be enabled in the xPL stage.

Maybe we even need a PROPER_ prefix for PHASE_ when not in xPL for 
example for things that make sense to be stage-specific. There are some 
symbols that should represent something enabled across stages (e.g. the 
CPU architecture) where the PROPER_ prefix wouldn't make sense. I'm 
often confused as to what is a symbol that must apply to all stages by 
design or simply because someone didn't bother to implement separate xPL 
switches for that (yet).

Anyway, we don't *need* an xPL symbol just because we have $(PHASE_) 
somewhere in some Makefile.

However, another symbol depends on it so this is clearly an issue.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
