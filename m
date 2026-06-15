Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC3BCD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 10:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D51E3846B0;
	Mon, 15 Jun 2026 12:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="HyThCsxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C733846B0; Mon, 15 Jun 2026 12:11:00 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322DB846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoMbPJjg3/3v4muSdQStWGNVntgemb0IRT96IUMod34nsf7pWYHRELKX1YvmQK/sTpcvk76MGovTP2d8EsR8NOmubjNzvUd7T9wlllp4cH6jx4M0a0a+bkeDuIo45cpgRx8Ce4neQ3IFLrrnx3mOy6qqjJhQ/AN/QiRpLgQxK5LPJh96iQIvrBykI+TZrmw4M4NXHW5YOoI5XKyq1wKV2jiZCGe1aQwxmshCuHAh41WETrIa6XBZdyLn0DhCXwapR2hky10SMuF6+uyUQ7+usn/k/NdG8XqN+0wt2/ZFydW0tLtkmf2MNT/U4lY+j2RiseypQeiQUb57skIYezuEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSlWuX9afYRbxf1J7fqhL7y5RuaWIFM7nagQNh3yuM8=;
 b=aT5/mO/zWy0pf3pmWuL4oAn9xbzV5CeBDpYTuRIUD7TOTt9dBEs0Mq4VLJjK90RW1BibBg6TjSgJFg18IIihXOKQqfRE/EyikpaVunmBa6VOTDYSyEFrcj+Zd6QnApydge9KMTcaHmSEiRVxwZI2ZUvYNUr+IjBn0oa/P64j3PmCp+se1cox2FNfj4A7t9aO4jzTsfVuGckhW1MK2DozBJmeEn6W6CDoiY+HBcmBkPv5ipqA7Rt43d5nVoRhi/EqqnsBOwb2p2hxP2oghk4JBfd3S/yZoQ9N5fOV97i5Vh0PVH4l2fUv1gCFvGhSqAuZC64EGuhIkI3OXzstoKln+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSlWuX9afYRbxf1J7fqhL7y5RuaWIFM7nagQNh3yuM8=;
 b=HyThCsxqv0kfXBikofFcMk6ZUlmhXl/o6jxyvjYLbjq1+0cFYJXVl5202CXD293PQc7UMAW6NfYrCzusm/5zXEBXpXYP8ABKcNeXGW5GwO8cmLU8gIdKBcdAteED01bWUF6br+uUnWpswTZ6/gu6V+lTZwRKJfQDJO5ptLvsCgmXZQRIwX1Fa0NPuz/uidIF7U1wF2PkQJKdNsnFPxgWGYr7qW0K171dJr5s9gPxrTqjh/pCBHL8RgMmkeZEKIWSzewkH7FuibasPYZgxaLnSnDLJr6Od/C3jOoBcJYTX7FOPDS2bm8oEkOY8jbUig/BrhHl26sMUYhdsESUQoZCCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by VI0PR10MB8355.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:218::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:10:33 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:10:33 +0000
Message-ID: <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
Date: Mon, 15 Jun 2026 12:10:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|VI0PR10MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 299f9909-a359-49a0-12a8-08decac6562d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|56012099006|55112099003|11063799006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 57gwHtf3AYxphFTEbhIo1cyw3j+mUk04Rfxhe0s3vUSTVinEfZx6dHKO3jnAOq1pibBeyFVI89zb4HIqpLz7qG4cdXCZVKrcS7eZV8AlvyUvApMNJOuGdKdYq7Oo9lTaxAToz7xDbgShG/jOii+kTMJVjrZ1GzZg54kW+Iu3ju9qfqNZtemi3b84PmLVWzUxKb1AH3Y8ONbAkakqTN0glgrnApG/3Z573VAgvzFhbMRHzlZFtUQadeJxoi3ZKxo2ozPf7dgFZjAL6pw1yr8AodfCoOQgdjbXesTUBjVSBFHYc8UjAfG3LK1b3Ctou2k5PqcGR9RhuQZ6i+Ffr3SgndMR7EtjIkQmba8oDqasGXRBNYFbDe6brYdroPA5+H7sWTM00V1gt7Urb4fd08CMcdvmq8/bu0FILOx18/x0CdLhRd8SKCCxthhWFLJaQLmaBZKe+5LpM+mMCFrt7zgXy31GrT/gXF/L1IZSAZr5m+s8Mnbny/MXkQZGGqXuYzgVZVBIBAYp1YzeQ7C285R5zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(56012099006)(55112099003)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xKbXN0bnhKelhEQXFuRVpQT3BzVXlpRUxGeGtHM1g3SmVoNjFMNmpsYU01?=
 =?utf-8?B?RENMRzNqb2VoRDIvRk9xTnVnQTgwQlg3UVg1UDhpMGllQldtMXhndU1UTnQz?=
 =?utf-8?B?UWRZZlpkME9oQzNrQzZoV1dwT2ZQZ05kdDlreTFZQURubG5FRkR5RG5VcTk1?=
 =?utf-8?B?VkFhdWw1S2N6aHVyRHRBRDF1YThVOHRmNTgzOWdYTm94dGZOTTZBQjdHRmha?=
 =?utf-8?B?VE9GWkFkYWU0OHgwU1hTZWN3dCs3dkFzSkxma1FTMXJadFE4cW9EMGYvVHFm?=
 =?utf-8?B?K3J5QzRPUk16RURzZnNLNEdUdlZzWHZOUTA3SWJyTW1INFFDeXdQLzNvaHR3?=
 =?utf-8?B?OHl2RFd1Rmh0eGJyWTVRWWhGWUNnQWpNcXN1d2VrOHpuSzNOZ1YxbU1IemM2?=
 =?utf-8?B?L3RYZkk3Sm4rMWpZMlpNYXA0VnJXbnhsZEFvbnJKdFRwc1pjTUlHN3pyN21h?=
 =?utf-8?B?K3FsZWxIbzZrY2FGNVRmTVNIWVEyKzFjYStwNCtlRUV6Q2RLM3ZncE9wQitU?=
 =?utf-8?B?YlR3UXBEN09hMFZMQnQrd1QwWS8xN3I2K2g4NStTQXZ2aTdqdWNSZmhETnZB?=
 =?utf-8?B?ams5MHJIN1ZKRlhRYXZVb0lLUUUxamNxckNoVzI5VWtESVIzcDZjOEF0M0U3?=
 =?utf-8?B?dFlsbyt6cVRzdEp5SUpyYVdDL1AvSUdYVzFxc21SUGZuWXpSSWlDYnoybXJW?=
 =?utf-8?B?VEpzWUp2RVpQQW5YNmVEWU1tZjl3M0RmeW1uMU4yeGRma3lKODdJbHZObnRT?=
 =?utf-8?B?SG5HODFTLzBReXBWQUZHZEU4bHNQTVUxN2U0Y2lqWksvNW9aaEdLVVllUGtR?=
 =?utf-8?B?RlpLK0xEL0tGaS9WS3dlbWhycVE0M2I5Z3BuN2ZlOGhqSnJNQ2p3QzlQWjhZ?=
 =?utf-8?B?MzUrWFo4bGJReTZaN0FWV1E2R2NxTnVHbnYzTm9RTFVYQWhHRHNLVEJ1Q1Uy?=
 =?utf-8?B?VEtOSVhwN0NOYkUyZjBqckk3L1kzek1aQlhEVWJHZFFUQURDRWpSRGtzNDQ2?=
 =?utf-8?B?NVNUTGFCcERxdkw5K05INjI5eGlJSkhYSGVLRDNaYWtveCt0UHM4a0VQTVRj?=
 =?utf-8?B?ZEt6UVV3dVF5UllyaEx4VENxRHZleS9OZVh0SHBYbmhKK1Z3S0NhSTJicnNs?=
 =?utf-8?B?M25PRmo3MWliOWVETkpBRWRuS04xcjJFOUU0SjVCakpQWXhJYjNmVUJ6MS9Y?=
 =?utf-8?B?dS9RZlN2ZHMyOWExenNHTnBtc0NuR0RKbENwcjl0aVl0WW5Ubmw2Qkl3ZTJx?=
 =?utf-8?B?R3c5dGZ3bzRRT1I2d0F0TXdSR09zZ3JQNXI2Y1dkNkVwSzlKNVNVTjhOd3JG?=
 =?utf-8?B?UERmRnAvMFFHdnJnYkltaTBVc0pjeVh6azJRYy9QWWMwMXp0SFpKSHRpQ3Zo?=
 =?utf-8?B?MGZBcGplRFNIamJibmlCN24wOWQvMDFsNFlFMkZRelAwb2pTa3hFK09adWRV?=
 =?utf-8?B?dkVKTDFhczR6elNEVHVndUZQMzZHbStGS3dTQ0t0aVpvaGlsZWVlVFV4a1lr?=
 =?utf-8?B?d2tJSlhGZmUyV2loaVBxYU5EZForUWFRR0t6WWdldDB0bDRYSHFuSTdTVFQv?=
 =?utf-8?B?dGQvNGxXZjU3UTlCTVRhaEsway9JT2ZZcXFQdHJkaFVNZm1WWjd6YnJkUlhV?=
 =?utf-8?B?SWJFNUM2UTY4WkcvUjhtY1c0VkJMQTVYZVBjd2I1L0IrZDh2L1UvZi94b3Y2?=
 =?utf-8?B?TXAwSmtMeFFRYzBDMGtmQkJMR0NPRkd1aEJWTlN6Zm5SNlJ4RW4yWVpoVDBB?=
 =?utf-8?B?QzRYdVBpV05tR3JKV3NlazV0RC9hcXRiWnNqMVN1VkpFR1Z0ZUg5QktxWmpZ?=
 =?utf-8?B?QWxHMmUzYkVpQkdrQXl2ZGtNUUYrMHVRN1FERlNXVUFVSGt3M3NsZDQxcFRX?=
 =?utf-8?B?aytpTjBlamxwU1RxRVArWk9EVWlqU09lZEFKUFVGY3QzNkQ3YmtqWnVMbFh0?=
 =?utf-8?B?alY1bnk2VzAwV1MwWlZLZGJIRUdTN1o3SHBlQmdieHR1MjZuWGJENEV5Z0ZD?=
 =?utf-8?B?akE4czZ1YTR1NlBEUVJaNmNZc3pUZDJGc3pqb3MxOEdmSWZqdmJxcEltd3VT?=
 =?utf-8?B?eWNrWGFUWm9MNFNzVHJ0bGQ0alp0S0NxQ3BjTHR6TC9rWG9BQUZlcldtMjNp?=
 =?utf-8?B?QmJ2NTFESmZIcFNGdDdrQ1RjOUJyNEhKS0M3SkN1NU54Rnc5UW1oL3Fhdndk?=
 =?utf-8?B?aklwTTB3NFJHRXdFTE1SUnNFb1BzbGVRbk1WUTgyTnJwRjRrVDllSzdiZ2t6?=
 =?utf-8?B?SnlxbXM1K1dIaTRFUTJHaFloTjNteHloSjhJcHp0VDIzYko1L0VpWFh4NVhN?=
 =?utf-8?B?d1RKdUMxS0JZL2daQ29laUJDU3BiTG1WWmJmNEJURkNtK0k5V2U0b3hwT2ND?=
 =?utf-8?Q?1dXBkwfRBzC3i4Zo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299f9909-a359-49a0-12a8-08decac6562d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:10:33.2718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqGPZ59RB2GRiJ4FdVlWdD2BXqI8rnSxU5BZFEfhBbpQ1HvgNNndkMDm9exoYCLJVdfNnEieXFI/00olNev7XBqqschDrG5hEqLgFpIkxQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8355
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

On 6/11/26 11:57, Ilias Apalodimas wrote:
> [...]
> On Wed, 10 Jun 2026 at 13:52, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> [...]
>>          if (IS_ENABLED(CONFIG_MEASURED_BOOT)) {
>> -               struct tcg2_event_log elog;
>>                  struct udevice *dev;
>>                  void *initrd_buf;
>>                  void *image_buf;
>>                  const char *s;
>>                  u32 rd_len;
>> -               bool ign;
>>
>> -               elog.log_size = 0;
>> -               ign = IS_ENABLED(CONFIG_MEASURE_IGNORE_LOG);
>> -               ret = tcg2_measurement_init(&dev, &elog, ign);
>> -               if (ret)
>> +               ret = tcg2_measurement_init(&dev, NULL);
> 
> I'd like the eventlog to be initialized before calling this (look below).

What if I removed the log parameter from those tcg2_* functions instead? 
The event log belongs to the tpm device IMO, so should be initialized 
with the device.
I am not sure what the intention of the current api is tbh. The event 
log basically documents when and how PCR registers were extended. We 
have to build that log ourselves as the TPM doesn't do it for us. The 
api weirdly allows to have partial local logs even though there's only 
one set of PCR registers.

>> [...]
>> index d41228f75a9..2270b038cf5 100644
>> --- a/lib/tpm_tcg2.c
>> +++ b/lib/tpm_tcg2.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/unaligned/le_byteshift.h>
>>   #include "tpm-utils.h"
>>   #include <bloblist.h>
>> +#include <dm/devres.h>
>>
>>   int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
>>                        u32 *bank_num)
>> @@ -212,6 +213,9 @@ static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
>>          u32 event_size;
>>          u8 *log;
>>
>> +       if (!elog || !elog->log_size)
>> +               return 0;
>> +
>>          event_size = size + tcg2_event_get_size(digest_list);
>>          if (elog->log_position + event_size > elog->log_size) {
>>                  printf("%s: log too large: %u + %u > %u\n", __func__,
>> @@ -553,6 +557,9 @@ int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
>>          if (rc)
>>                  return rc;
>>
>> +       if (!elog)
>> +               elog = tcg2_platform_get_dev_log(dev);
>> +
> 
> Initializing this here feels wrong. This is a function that just
> measures and logs data. Why can't we fill in the eventlog address
> early before calling this? If we do so some of the checks above are
> also not needed

tcg2_platform_get_dev_log() is just a wrapper to access the private 
property of dev that keeps the event log address.
How about moving the call into tcg2_log_append_check() instead?

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
