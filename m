Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D265CD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 08:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83DF2846CF;
	Tue, 16 Jun 2026 10:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="m/4NODVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7376A8484C; Tue, 16 Jun 2026 10:35:28 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0757C846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 10:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX1ysbQ5yR++TTIEuJyWJz9NVqbunvpYccZ1NsrEUwLWPE8gdm56sPJpYbMdpyRdwLqvPFRfHjl3kEYO6Fw9Ni6MXi1exvdwBEdUZ1BC+d5Kb3GDBGDJe1m7pCYbBDszxVSVa96XmVngv1wxBdF/FfcRybIVX8oM4/8Hn9OEzy9KBz34OUGlR7G06Mx7w5H8GGjzOZfumTXAD+MfZTNJeD0exrT0/VLt8dcvkW74MTjgTcZH5wxAeKsVkztF04olyZ9uCtcmqqHg0m7mMf7izm6MinK7/rGXwgGKESra4QlKGeVXm+D9XuxYgrfyqiEAhXImH/6bRx4uE0tCytMqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzXinbs2pBSs0B8KcEtOEdxVBfKz/QWOUaejjJkKZXM=;
 b=qF2E+CQDbpSti24cqvggzDReMZIf7TSrhFqbrP4h32Ti1PAKl7hJNziPqOkPwpmIjn3JVkx9PpyFWz6lf22lh4Lsov2j+2hVG8WuJoaIyZ/sNBEvkxHHUdIF2NnpxDKqd9wEloECvVvg2i5b8GAvcNesMlrhi42gndEoLKoQOcK2o9YhA3+dbus8WooWfCKdkEz0GyaSa8Itd3kw6o8Dwy9L1ckTOhEt4eeZbM1Ag/cOV1+hZxIanJIQFjvjLHl6f7XyxhkbJeh0XUtu4hBbUvywUV+xJv9/dTPmq1F87xtvN33zXU5dU0np9xDK+MXzBFOyYUTS7PWRVy7su0759Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzXinbs2pBSs0B8KcEtOEdxVBfKz/QWOUaejjJkKZXM=;
 b=m/4NODVy6RtJnvEchF1s6SHmDIW+2H1vwqMzmsRN+k0WAVfT6vYT6wRvG+85uAR3lVqz1MUo2Ed2mUTqF6ATpm8mJF2rNlwtPuMe3JIG+pCK4+m0xZ3jLWwWMH2jBcm2xlxwtKwrCVwDPiRknvx9zP9qL3IfazuwwkLZnirW+cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GVXPR04MB10492.eurprd04.prod.outlook.com (2603:10a6:150:1e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 08:35:21 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Tue, 16 Jun 2026
 08:35:21 +0000
Message-ID: <b25761d2-594a-429e-a3cf-3f0cca996f1d@cherry.de>
Date: Tue, 16 Jun 2026 10:35:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools: fix building with OpenSSL 4.0
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 u-boot@lists.denx.de
References: <20260615160718.94366-1-heinrich.schuchardt@canonical.com>
 <20260615194632.ACNju1Qi@breakpoint.cc>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260615194632.ACNju1Qi@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1PEPF00005B8E.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::62f) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GVXPR04MB10492:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c45555-581c-46b2-97a2-08decb8233d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|4143699003|4133799003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: jnVAGMzLeJkDls3S0pjGnzZiwQvmeLq5aZoOoCa/x1U5hOrMaPWjzLtmDcXCLwAyjIyGw8O6ArOrYeABh3XI4S4Jpop35ncd0h0pZteqFysmSi7oO/4d0xXy23PGVXNuRoK8OnRQwYUSEgbyzcDB6q38epud4GQ66qTOwD3M7pPNGhKUAivP49lD8/8YzD2hZRZehCg6UONChf+mvG7d3h04hjvz6lrrfQ8K6yOqhMOt7+5RONCN0h4rqbW/EYujxifJAmYoPjkOsWmzT1QKaYuIRK+t35IXK8Ab1JXtmOcKK7h/d5dcKiNUlqCKmxEM1xDdtV5pJQf6VkGbPu7Rc4Um4jjx6517p8WPkLIScX3ne27FDQHt+82dXy9UhDVn1cBfeLjKAfY+y1lID7WKQZnN+pNxibsM8Fc2pbTe1qKO9EJfjzsrfkMLS2M0Ja/Tj+by75xsLc89ZaSI20Kf1i4LNgqqVf7KFOemk614Q63GXO+s5fOX/85RiNgENwMlnXpRoRlnD4SNb+Xz6JiTgIMx22SpXh4pazfU7xsZWcKBx1Qqrz7NrgFNOUZCLnAfwIjyKfOYDPmzkuO2O7qMueKmovuLNHXXFdJyHT3Mc6s8GPQ5LZPNXTlNSYMSClF7knkZ0mdfMsc0FI26bQdCX/we+ANWQzwmkExWSIRtu8hFdevO+2BMFHlRi2qWEmwend/Bbi/4c8OniFwWVjaZtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(4133799003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1NCOW9zOHdEb0RjTDZlNFIybDZLbGxDU0lyb2pyVHFQeEd0eE9BZDhibG1D?=
 =?utf-8?B?WVdSaDZWU0ZRNHE2TFh4RzVGVEpOM01aSG5yZ1YxYVZiSTJES0tJWEhpNzFO?=
 =?utf-8?B?SUxSQ1RXbHk3a1Q2ZmV2Y0w4UWxYYm9WQ3ZGTEN0Z29rQ3hPd2hrTEFjb0M0?=
 =?utf-8?B?dTdRUVZTdkg0b3E2c0NDMkxGbWtrcUJDbTRya2RkY29hZXdiSWs1bHpiMmVq?=
 =?utf-8?B?MGNMeVQ4cFdmYkJqN0ZWTnFuWXNzQzEvZmJJOSt5WGtMNzRUS0duaHNDQ01x?=
 =?utf-8?B?clhZS042WW8wcWh2c0FwWitoMEpiSDRvNS9xOWt6dUljVCthaGxaNDBJdzQz?=
 =?utf-8?B?eWY4OGJ1MUVHS3FDT21UelpaTmRWSm94UitJam5TR0IrWm1jWk52Mjk3dW9P?=
 =?utf-8?B?U3dKRWVkZXM4M3JESjVqYkM2QVpNMUY4VG5IWlZPL0pPdWJSb21SbFJhUS9h?=
 =?utf-8?B?U3NILzRadVE0RCtMTStsZWwxc0diNWZDUnkxdE1MeEEwT2hFL2FuVXNRNkxZ?=
 =?utf-8?B?RnFYZmlFMzFzekYyWUp3dFZCRHMzSHVYUU9OdFZWc1ZpYmZ3NDRYa2RGQnFS?=
 =?utf-8?B?YkZJMmN2ZHE4UXNjbE5oUE43cWNxSzFpb1hYRGRKS0ZJMDU2SHdSQmNjRXY1?=
 =?utf-8?B?WmpSMXNiQmFKdkxjOGt5S3BLL2NFdmVpWGNBMGQ0Yi9PVWNWSVpxcHI4NG82?=
 =?utf-8?B?ZTlSQ1Q0YnFXNUJ2aUpadnNnNHJXWG9IR1ZhNldpMW1ReUV3NnBsQnN0SS9Y?=
 =?utf-8?B?ayt5R0ZSSmlkNDdJekNWL3o2aDdIKzdmM3lxdyt0UkJmMmNMdVFQZ21PaHM1?=
 =?utf-8?B?NVhNM0pYVmJiVThzM25XNmZackFqMjdqTENoQ3VJOUp4SHIyMUtCVnE1YzlQ?=
 =?utf-8?B?cFRDcnlmZGZzSS9yRU5Zd2ZSS1laOUU1MGRMazBBTlFlbWZMOE9WbmQzK05J?=
 =?utf-8?B?dmRVWkY2QlNFRUJtQ29aQmliV095TnRvVEMrL0ZwSi9mRzlnQVk2VTNSRmk2?=
 =?utf-8?B?MUVNWDhhWGYxWjduM3NVd2dCMlI3US9IdWEwRDJ1M2N0UVdSenN6V1dzSXIy?=
 =?utf-8?B?eVp4ZkJhYlRoTU5UMENqVzBia21PMXpZL1pIRzBpQjdlTlBGZHIvMnVwRWJu?=
 =?utf-8?B?QzJ2aUEwdW9RZ1VEblZBZU8yZFUzTTlqL2xkOU4wKytodDFlMURoV2dIa2hh?=
 =?utf-8?B?S2hiNWFtUzNJamFPQ2FEZExycDJOcE9JeHVHTm5idmVxdEdsR3BYQzVWWG5S?=
 =?utf-8?B?NGZLTTVWNVBFcGJYbXNFZzZvWU1YQlh3ZS9nTVo5T3FiTVhlQk5rTm11TDVF?=
 =?utf-8?B?Mm9ENVFGY0s4cTZzVFdpQUpBNXE3bDBTK1BPcHBMbTRMb2xKTHN4R2NlRzI5?=
 =?utf-8?B?OHRNMkhxS2dGdTRjVnJxYXp6S1Y2USs3TGVROFlEdzV4TWF0RHFkcnVkSE1X?=
 =?utf-8?B?bnFQbnRaZGIxRlNKY3lxV3pjSzhlWGZoa0xVZ0NjVDJ3NU5uTldjY2RxSG9w?=
 =?utf-8?B?QndwcE15cWhZcm4yeUlqNDQ3ZTdUVFYzbVh6WThad1U2TktBS1pVSGVFai9p?=
 =?utf-8?B?SFVFczl4Z3dlYWNxZUs0cmdoMy9MckFSdWdyK2VPVmQwaWRjVnF1OEhFZHNZ?=
 =?utf-8?B?blc1czVtalBMR09WOEVxT3BGZXhXTCtJek4rcXJLZHJiVjJSZXdRYlk4SVNy?=
 =?utf-8?B?bmNRV0d0OVVKYVd2KzhTNUx2YnlkUUlkcEFweWFTRktyVTR3Yk9QM01QS1Rt?=
 =?utf-8?B?QzhlUlpJTmFRa3lqRk9rRjIrTGNITnUybnJZZXZ2dHF0di9tK2dRTU5hSmZC?=
 =?utf-8?B?ZDVBM1h3VDI4V3hPelFROERZbGtNckkxQnZFMnpBb01OSCtLeWw0NUd1QWFK?=
 =?utf-8?B?WWNTd0hkZ2F2NHM5K0RBbUJsVGJGbGRha0Zzd3VmYW5zQnViVFExUFhJenNX?=
 =?utf-8?B?Z0wvSm9WNytJYlRoc3ZJTFBuemsvRitnbWZUdjhibTRNeW91NElvZWlGUVRC?=
 =?utf-8?B?SXliN3Y4M0RScnJyTTkwbXgvRW1CQmV5Q2tQUk9wTXRuMVEvT25JSDlHSGN0?=
 =?utf-8?B?cDVPRC9hSGFnQ1JxQW80RHhhVVdRVXdiMXlaa05RbzRocmcyeENSdVZuU3VZ?=
 =?utf-8?B?WWFvSmxkQWNQSnlIUy9TN1VZV01LYWxaeXgzT1g3eWQ4KzVGeTl4MXhPYXI3?=
 =?utf-8?B?ZTcyY1RmSzdzNWU0Y3RraVd0WnQ4UnJ4cnppblh5SnZwYW5VbUlNSHdSS1Qw?=
 =?utf-8?B?NXZmRDB6aWF6M29jcmpBRWM1eXhjeGMxdFFHeEI0NUdlVWlwYjhoRVIvSEM3?=
 =?utf-8?B?amV0T0NiV0g5TGJxNDdONWtFMGtOVlFqY2lWaDY1dUZhNFV5Rytsdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c45555-581c-46b2-97a2-08decb8233d2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 08:35:21.0393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HB1vWeux++7neWxfvUF5WlB3/aPkAbi2/tCNxQNp7IIKTyHZ/WPIxeVzULdia4drFV39yWrqSzSkqnz+XgaCdeiP1JoIBjzYphxLZptAmBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10492
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

Hi Sebastian,

On 6/15/26 9:46 PM, Sebastian Andrzej Siewior wrote:
> On 2026-06-15 18:07:18 [+0200], Heinrich Schuchardt wrote:
>> Add -DOPENSSL_ENGINE_STUBS -Wno-deprecated-declarations to the
>> rsa-sign.c build flags.
> …
>> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1138297
>> Reported-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> --- a/tools/Makefile
>> +++ b/tools/Makefile
>> @@ -90,6 +90,9 @@ RSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/rsa/, \
>>   HOSTCFLAGS_generated/lib/rsa/rsa-sign.o += \
>>   	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")
>>   
>> +HOSTCFLAGS_generated/lib/rsa/rsa-sign.o += \
>> +	-DOPENSSL_ENGINE_STUBS -Wno-deprecated-declarations
>> +
> 
> I suggest to ifdef the engine support for OpenSSL >3 away. Also maybe

Yes.

> removing it since the "provider interface" is available since the 3.0

We could migrate for OpenSSL 3+ to the provider interface while 
maintaining support for OpenSSL engines (via the org.openssl.engine: 
prefix). OpenSSL engines are supported in OpenSSL 3.x. As a matter of 
fact, **I** am using an OpenSSL engine on OpenSSL 3.

OpenSSL 1.x can still receive updates provided you pay support for it. 
Bullseye still ships OpenSSL 1 (and is in its LTS phase for a few more 
months). According to pkgs.org, RockyLinux/AlmaLinux 8 and Slackware 15 
are also on that ancient OpenSSL. The former are supported for three 
more years according to endoflife.date. So I think it may be a bit 
premature to remove support for OpenSSL engines via the engine API.

> series. And since 1.1 receives no FOSS support it might not hurt anyone
> to drop it and keep only the provider interface around.
> If the engine support was introduced due to $HW then there should be
> matching provider support.
> 

Not necessarily. You can have custom engines and not have migrated to 
custom providers. The interface is entirely different and the migration 
is not straightforward as far as I've been told (a colleague of mine did 
the migration for our custom engine).

Cheers,
Quentin
