Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5F4CD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 10:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819818487C;
	Tue,  5 May 2026 12:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="T1P+MGPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A2684897; Tue,  5 May 2026 12:46:24 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FEB28486B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 12:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAs78w18bMCJeB1BiGVPaJWtTrH5mSqq4Fl+laibykDEkIwdMNIcWlBH6keOe3Kij2o8+v+IadNBZRz8+8t9QeY71AoxvJlqvSuap+VLWNaUatgvWqIRL3zxPJjTLybzzn8/QG+nroVE58GJQkDk1e6HF/qwu71GTubCNFO8lz8dPq8wDg8EMuECB1Y7ticI7nWRbOkcNtsVNSwfKYfX0Ss1aVbylG7M92wShVqmmuNsLj0f1e55xzuhRpCHqlwrn+KzfOgBCCbdt5QkASZrbdaA+U2wTXzn5zpqHaps0k5zYmYzjbWz1V6mZsW92TfVU0j8H6bD1llImbeMIHWQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0XlUJ/Zu5+dyZdud3rv7jIIn2mEv11H9UJXowN6BnE=;
 b=HzXNJDCb+cj5u6+0HLdMDIE5QWmOccfFuyYRHko92awgc4pGMraEFeC4QbKrHsYxiGV13GFt+f8XA5pAzV4VVjrVwFJdABSR/UoEjY4ouw9l8+iMIb869Pn8NB+2bxKDyGc72fWJl2VWxXg2o+A5tWRMQZYp6DmEH+fNz/c2kBexYYfTPp4uUwX0yCfGfWi9WErPihvbyJX6OI1tbnk9yv0Q+0JIOg+YM/k7ayPX+xTbPt4OA6hUP01vjEgmE47lqN52Z6HBkI/Da9eTja50Lm7/42Gnml+8mrtfrwL5k/mGPRSay1PkA8a9NW8GonAY8zC7K62XS2y/3zBlRo1ziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0XlUJ/Zu5+dyZdud3rv7jIIn2mEv11H9UJXowN6BnE=;
 b=T1P+MGPrRUdFYpCSAIXZ0/m9ET9abgUsS0YRHAUdbaMK1nelRKJIoCVdG+uuD+I4AF1llZ6kMIFXwiBXmPLbCgRRRlilMJ8lz1HzdDUB0C671pHXptzQg8ur80WWjI00X05XUz/RfhIcCfov18cDvbcbopArhXr1VCnHkJ0MPw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB8848.eurprd04.prod.outlook.com (2603:10a6:102:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:46:18 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:46:18 +0000
Message-ID: <48121be4-3675-453d-b2a8-839c46756fb6@cherry.de>
Date: Tue, 5 May 2026 12:46:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC next 08/18] scripts/Makefile.extrawarn: sync with 6.1
To: Simon Glass <sjg@chromium.org>, foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-8-b19301d1948a@cherry.de>
 <CAFLszTjS4guQy-sW4SL3fzpbcNNqJKxMYn1qDDjpUhdP05YwVw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTjS4guQy-sW4SL3fzpbcNNqJKxMYn1qDDjpUhdP05YwVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e0f612-05c1-4628-6ad4-08deaa9389b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 71+ZSpSdbXwtSVcUBD6IWWhYqokPpWsGWDsUMfrdjvGArpyJnTEWgh+3iO+V7HfiGHFebPg7VonWil6Y0u+o5+YSek3lAr7MHppBNawhEQ6EEegxEL53kAGSMQZhF6M98pZLg87Eps8yOXTp3/sh59xwOrSDg0SdXWcmIv7xUqiKb+Zu/YSl263Y7+FCMwkgsF/+vuVeUChyrnWTO+4jmUHvPdCWb7dfiV+TtpFIpS/yYS6d+JK0CSO/bWSg6wWbn0jtUT4gVXEdFt+DY1lZVw9dPehQn9fToWnnkV0A/r96K7nDQWsp/UqkvzTACPwNWFo0PkLaHh6JtIqNiVOIXQBBA09EaGA9KfG9SQkO4qs2rOKHAPNnmg+LTN+nMAsk2kZ3t1fi/YQrk4R8WbVsZWwGdTm43O217Y7anAL5wrOCfsL/JoFomLnBeOan5jt7Gy9I5GqqJ8iAZiEd0DgBuUnMVNYLqRuhjPA/JflIJFZ6aenhf/Qedl9PFZ4162vn37fZSbYvY8Wft5AhczsbcNDk3Z9BEEKQX3+KqNBX0YIxzpOM6Gm7b1PTORRPyFPmtJMr8wxacRn26UBcFEPh48qCssmX93gr8eMOgeagFutdYTBnmcByILo2UbTS/5DsGzAGIg3zeC8+3sGflNOT1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0dQMUFERXVSTkdrY2VPRUtpcHhKV2hiSkFEMjMvMGt2TjJWQzVlbnp0V2Fa?=
 =?utf-8?B?MVNWR3NsUDVBY3BHR002WGNwa1JwaUI5ZjlHblNxd09PZUZQZ082UGQ4NElH?=
 =?utf-8?B?eVBiZkxGb2xvZ0dCWE1pQVJEOGZoM05YMWYxRkNkVjIwdzNyWSt5MGZSRFRh?=
 =?utf-8?B?eUNlSkFIZm5rSXhTNFBPQlFqZXRGMHc0eGN5ZnBjcC9WWFZ3TU1oTFBLaENR?=
 =?utf-8?B?VFc0TExRMXAvcmxxU3UrOTQwc0lieVY5N2NONHluV1Rpei84QWdLSE9sS09E?=
 =?utf-8?B?TlprNVRNNEJlQVJKSjl6YUtkU2ZQdHJLMDBNdlQwV1FQeFp4MFEvdzBOTjBF?=
 =?utf-8?B?UUx6MEM3VHdqWWtoK2Y0TGNOQ3cwNElRZEdlMTBZUExkM2ZVakI0KzQ3TmIv?=
 =?utf-8?B?ZXI4dStiWmljdEVGV0tKL1ZVZ0NQcTFhR2hSQlV5ZFZiY0ZveVZuT1N5Z0s4?=
 =?utf-8?B?bm1QWG9Icy9UMGZBU25JR1Q1NGloZm4zRElQbUN2UGg3RzQ5SmlUMTFURTNZ?=
 =?utf-8?B?WnBsTWt0UjlmcEZsTndMaEw0Kzc5SjhkVFI3eEczUnRQeGFFTUpmVGVnbldP?=
 =?utf-8?B?V1N2KzdxUTMySEVXcmJRRHpWS0FSWkcrRHYrNjdXT2kyVTEvQWtEdFRtV3lj?=
 =?utf-8?B?c2lkTUlFNFQ1cWpHRndOQTZ0R04waU5nb0N1cUwyd05nTitJRnJ0Ni9xKzJK?=
 =?utf-8?B?M2lkUzhHVzUvOWRpelA0UnRLVm54RXpibUNla3d4TEI0TTBPVkdiRUxBTlNo?=
 =?utf-8?B?OUlKdE9pa2hITnh4WW0vZDAyK0FCUkg4Nit0UWJ1SUtCYnVDSHJSVkhlN1Ez?=
 =?utf-8?B?bjdIMUN2K1lSNGYyTEd1T2FaMDRaZ3dwWklpaXlTdlh1ZHoxRllvRmlxajBi?=
 =?utf-8?B?M0hQYTJpUjNkQXBUemRqVVNjckxhOXJ5Sm9jemtEcHpadnpSVFZFUjFZSW9G?=
 =?utf-8?B?Wm1wbExDL1FGTTlsK3lGWmZsS1RTd3ZRVTM3dGw3ODBuRUkwcTB0cTJkNzlv?=
 =?utf-8?B?UFRsSVRQWFh0RUJRa2VSY1hYUXYwQzExUXlDc29hMnRmdHUxb0tvaGd5OWdG?=
 =?utf-8?B?dzFFTklLeHJrWTdhTlQwcHF5cGlsRmd4SWcwR29xa3dmazdCeWZVOHZYRnB3?=
 =?utf-8?B?eCtzcG5tQkZMdTNLRnQ1WnhjdndtbFZnNC91L1lnMjBRSEVlaGtxWjBVNVND?=
 =?utf-8?B?eUJJMjE5R2N0alp6ME1ubEpma05KUmZiN1lOcjhGRTY4R1dOR29haDgvYnhG?=
 =?utf-8?B?cmtMSUZYMHdKMU5NKzRIRXRScjR5WDJXaXpoU2g1aXM2aHBDR0ZTRmRZUVNh?=
 =?utf-8?B?M1loRmZrUmF4Q0Q1MHNSdC9nNkVtdzB4aktLUjVSVExnbFdjR0hqN2lBL3Rn?=
 =?utf-8?B?eExSWjgza0JTRDZWSGprcy9QNHk1b1U4VThNNWFDNFp0R0Z6ZFdCQ2o3bi82?=
 =?utf-8?B?Y2syVklRbVowWG5hYlkyWGNmSGxGUGxGUjZIMjJVOGY1N0V3SDNxeVZoRzN5?=
 =?utf-8?B?UlVJellJMUdqZTN0QTRXOE1pRXJKQk45dXg1SjZSYjdqM0tPWWlEZTF3Z2F0?=
 =?utf-8?B?ZC9Lb1V6SkZueTF2dHF6a0VvaE1BU3p2c2sxNmRwckkrNHVFYkhZWDhsTDJD?=
 =?utf-8?B?cW1XZVRlQi9Xb0pkYjhENDUvcHpiTC9ROS8ySUM1V1RvTGwrMWVpUUlibk5i?=
 =?utf-8?B?dkJlMDRXWkp1Z1J0Y3lxang0cDZPa3RmVk1NRk1wclQyT3RTelNibFVJczlO?=
 =?utf-8?B?MWp0aE5zMDVQeW5wNVhBclhBN0hscHh5MlcxSUJrTGdEY0NqcnRybjJVM3g2?=
 =?utf-8?B?bVJ3bkxBV3NYODZkZXJqR011eUR3QXhuZmZMMHR1cW9LQmF2Y0lNdXF5MTVj?=
 =?utf-8?B?VXNHT1oxb2JCM2xjcmdsRzYwd0Jib3RIOTI2VDNaWTRhbjBvSlorWEoyTzdp?=
 =?utf-8?B?N09GTDByWFY0YWk4TzU2VzdYOXZFc3RsdHBidDVtTmFrOHlHS253UjlTaTZK?=
 =?utf-8?B?VXdrOFJuR0pwYmMrNjRGQVozcWo0Z2N0MXMramYwSXc5UTRtUW9mTWdZNmdm?=
 =?utf-8?B?akdQVGkyQzJBcFNuTGRnMU9McnpGOGRPTk51azRJanZTZDZmb2d3N0hMQTJq?=
 =?utf-8?B?N1BiZXBZNDZzQUw5Mm1qWkZxNEdBWjZqWm9yU0NXYnpjWEUvaUFvNFlnTnVs?=
 =?utf-8?B?U2FLZHdCSmV0UlZtU3RyU1JnQlhYdDZPTS92TVhLVG5jSFhLVCs4WTVJK2xY?=
 =?utf-8?B?Q1lnNzc1UlYzWUdtREl0SnB1b3cycUV5UW45cEkzWnNkblZwWHVhMzBxdzlJ?=
 =?utf-8?B?djVMdUFiZEtJbXpMUVVkVGxndWtHTExKWFJwYVZBZDhvbDkyenk0Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e0f612-05c1-4628-6ad4-08deaa9389b2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:46:18.1833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdatcuJmxtcGsVZaAY1fW8xuTUTSv0tcWCfo3C0oXwSX7TflAjhIiZIVCuLx3ttmDBhkvwsFo437y/82y/pP6mwMtCSpJxnKQNxuo5RoLiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8848
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

Hi Simon,

On 5/4/26 10:34 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
>> scripts/Makefile.extrawarn: sync with 6.1
>>
>> Sync scripts/Makefile.extrawarn with Linux kernel 6.1's.
>>
>> Since it adds a new option for KBUILD_EXTRA_WARN with e, document it as
>> done in kernel commit c77d06e70d59 ("kbuild: support W=e to make build
>> abort in case of warning").
>>
>> s/gcc/build/ in Makefile as done in kernel commit e27128db6283 ("kbuild:
>> rename KBUILD_ENABLE_EXTRA_GCC_CHECKS to KBUILD_EXTRA_WARN"), part of
>> v5.4. The rest of this commit was backported with commit bd3f9ee679b4
>> ("kbuild: Bump the build system to 6.1").
>>
>> Our scripts/Makefile.extrawarn before this commit is Linux kernel's from
>> v5.1 with the following diff:
>>
>>   # diff --git a/proc/self/fd/11 b/proc/self/fd/13
>>   # --- a/proc/self/fd/11
>>   # +++ b/proc/self/fd/13
>>   # @@ -13,17 +13,8 @@
>> [...]
>>
>> Makefile                   |   3 +-
>>   scripts/Makefile.extrawarn | 154 +++++++++++++++++++++++++++------------------
>>   2 files changed, 95 insertions(+), 62 deletions(-)
> 
>> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
>> @@ -22,64 +17,101 @@ endif
>>   ifdef CONFIG_CC_IS_CLANG
>> -KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
>> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
>> -KBUILD_CFLAGS += $(call cc-disable-warning, format)
>> -KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
>> -KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
>> -KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
>> +KBUILD_CFLAGS += -Wno-initializer-overrides
>> +# Clang before clang-16 would warn on default argument promotions.
>> +ifneq ($(call clang-min-version, 160000),y)
> 
> clang-min-version() is not defined anywhere that I can find. So I
> believe $(call clang-min-version, 160000) always expands to empty, the
> ifneq is always true and the inner ifeq always false.
> 

Thanks for catching this. It seems scripts/Makefile.compiler is also not 
sync'ed with 6.1. We're missing kernel commit 88b61e3bff93 
("Makefile.compiler: replace cc-ifversion with compiler-specific 
macros"). I'll add that to the v2.

>> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
>> @@ -22,64 +17,101 @@ endif
>> -warning := $(warning-$(findstring 1, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
>> -warning += $(warning-$(findstring 2, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
>> -warning += $(warning-$(findstring 3, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
>> -
>> -ifeq ("$(strip $(warning))","")
>> -        $(error W=$(KBUILD_ENABLE_EXTRA_GCC_CHECKS) is unknown)
>> -endif
> 
> Dropping this silently accepts make W=q as a no-op. That matches v6.1
> so I'm fine with it, but please note the behaviour change in the
> commit message so anyone bisecting a "my W=foo did nothing" report
> finds it.
> 

ACK. This was told in kernel commit 64a91907c896 ("kbuild: refactor 
scripts/Makefile.extrawarn"):

     This commit slightly changes the behavior, I think all of which are OK.

     [1] Currently, cc-option calls are needlessly evaluated. For example,
           warning-3 += $(call cc-option, -Wpacked-bitfield-compat)
         needs evaluating only when W=3, but it is actually evaluated for
         W=1, W=2 as well. With this commit, only relevant cc-option calls
         will be evaluated. This is a slight optimization.

     [2] Currently, unsupported level like W=4 is checked by:
           $(error W=$(KBUILD_ENABLE_EXTRA_GCC_CHECKS) is unknown)
         This will no longer be checked, but I do not think it is a big
         deal.

     [3] Currently, 4 Clang warnings (Winitializer-overrides, Wformat,
         Wsign-compare, Wformat-zero-length) are shown by any of W=1, W=2,
         and W=3. With this commit, they will be warned only by W=1. I
         think this is a more correct behavior since each warning belongs
         to only one group.

>> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
>> @@ -22,64 +17,101 @@ endif
>> -warning-1 += $(call cc-disable-warning, missing-field-initializers)
>> -warning-1 += $(call cc-disable-warning, sign-compare)
>> +KBUILD_CFLAGS += -Wmissing-prototypes
>> +KBUILD_CFLAGS += -Wold-style-definition
>> +KBUILD_CFLAGS += -Wmissing-include-dirs
> 
> ...
>> +KBUILD_CFLAGS += -Wno-missing-field-initializers
>> +KBUILD_CFLAGS += -Wno-sign-compare
>> +KBUILD_CFLAGS += -Wno-type-limits
>> +KBUILD_CFLAGS += -Wno-shift-negative-value
> 
> Several flags previously wrapped in cc-option / cc-disable-warning are
> now passed unconditionally (-Wmissing-prototypes,
> -Wold-style-definition, -Wmissing-include-dirs, -Wno-type-limits,
> -Wno-shift-negative-value). That's the v6.1 behaviour, fair enough.
> What's the oldest gcc we support?
> 

Pfew... That I don't know. We have an explicit check for GCC10 on ARM 
since commit bb1c2b463265 ("update GCC version check after Kbuild 
bump"). We have GCC4 min for PPC in arch/powerpc/config.mk with 
checkgcc4 target.

mbedtls specifies they test against GCC 5.4, c.f. 
https://github.com/Mbed-TLS/mbedtls#tool-versions. Some parts in 
lib/mbedtls/external/mbedtls/library/aesce.c and 
lib/mbedtls/external/mbedtls/library/sha256.c require GCC6. 
lib/mbedtls/external/mbedtls/library/sha512.c requires GCC8.

lwip's CI tests on ubuntu-latest GitHub runner, c.f. 
https://github.com/lwip-tcpip/lwip/blob/master/.github/workflows/ci-linux.yml#L9-L17. 
I don't know which version we've been using but it was merged for 
2025.01 and at that time ubuntu-latest GitHub worker was Ubuntu 22.04. I 
believe GCC10 was the version by default, though 9 to 12 are available 
in the Universe package feed.

microMIPS requires GCC>=4.9, c.f. check in arch/mips/include/asm/compiler.h.

include/linux/compiler-gcc.h requires GCC>=4.6.

For the rest, I don't know. Maybe Tom does?

The Linux kernel states in Documentation/process/changes.rst that the 
minimum GCC is 5.1 though "The gcc version requirements may vary 
depending on the type of CPU in your computer." (and I'm assuming "in 
your computer" applies to the target device, not the host machine).

Cheers,
Quentin
