Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7610ECD5BD5
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 22:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CFBF848E6;
	Wed, 27 May 2026 00:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="cuFAvK/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCF6848EB; Wed, 27 May 2026 00:27:03 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 479B3848E3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 00:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/lbCRFwpkiYkGLq+Xy1duNopfeqOgWHqOzGvqPnsMab3qfjVjxaVFCUsgXDHl9VrHx0nOiiDTiNEPdkRvrRz2cyhLmHQuuk7EoElKZp7Wu9TbAnw0vPE1b4WlI/rsGycd1V+q2Zr/sCal5I/63MzFbn6qGOyGmIxWOIKFs6jJQiv3NwWqD/CL9XFg78Uy0BmR8Y+/jR0uGrygRco8xl8/Ve7F3R+ZQo5BJD+EGPfW8YE52Rn8IEBCFxCCCnziJz9fiyMusljIoffhl7I/BFuBk6iH1JaNzBUlxsLvsyNstdRcpcgO1G9D1yAh3mklkmE783xxHIE3mFjMtwRT2e9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sOhBIdCwbqY6L1+cMT3pAmW1HvGxQ8XAiYtlbc6XtY=;
 b=q8H3l0ZFwc+HXvvNUfNb6D47RdMLYMmam1uyPJQP+gAKNC7xFP51KcJ5/RUzyH3VXWlb+jKIqdGlmEikdU9jMPmrF7mMvHiYCH/XZlkrtbrpIA4LGDfrBx4XfuACBMZD8ZTlf9ZMlTW1ilIcgL0n7SBRr/a68yx13Dd22SIy0rXYHtiHlU37hIBaL7wtW0mqVIyqV9fjNaWQmMPahP3mTCB3bIjBV+aSesdpex2RNhbQPDcgAeJxDshz3x7VC9eQHsoi+YNG/0d99uuG3ZVREoO+y8lTKC2YScD+zzfNJEaMLYAd5T5tJvgtbMXgLnoms8vtB7whP9xMAYqHKUHYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sOhBIdCwbqY6L1+cMT3pAmW1HvGxQ8XAiYtlbc6XtY=;
 b=cuFAvK/c9RA6ZY6QbsTcFwm/6MYbu9dcw08I6BhrAKCzRaBT1oels5nHkDGVELdzAIauk/wZTsOo1Omq309e1XwTGeXgNGOXrKo14EzRfX2Fqm9iE90ULdxXYpBMKPh/JM+AX0DIQVIxUj8IkEnuGUnDZLg+bqyqIUEkVMaN4Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB7063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 22:26:56 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 22:26:56 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>
Subject: Re: [RFC PATCH 8/9] linker_lists.h: emit lots of meta-data for
 debugging and sanity checking
In-Reply-To: <CAFLszTh61_1vQ3bG29H5xVkrcLTc_meji7nqhqSK+8poHwECnQ@mail.gmail.com>
 (Simon Glass's message of "Mon, 25 May 2026 08:28:59 -0600")
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-9-ravi@prevas.dk>
 <CAFLszTh61_1vQ3bG29H5xVkrcLTc_meji7nqhqSK+8poHwECnQ@mail.gmail.com>
Date: Wed, 27 May 2026 00:26:54 +0200
Message-ID: <87v7c9erip.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CPCP307CA0007.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbf1f50-42c1-4665-f434-08debb75e515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|1800799024|376014|22082099003|25016099003|18002099003|38350700014|6133799003|29003799003|56012099006|17096099006|11063799006|5023799004|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: rDjLw0dh951gdoLIBr2az+vAVeMFBDlI8uHMGL0J6dGUU0Gk7VB7J8RNyI71f0evhU3mxTT+nGQSQ2k2J2AraSGNYsgjL6dL5i+aLdWRQRL0YFfADdwbZc75G/1GQ3xWnLviWZw0AkXMf2ICNoGe41tMYGSPw8CQwxiVS7NnjARVigdzpGHDwbfdiuTySTGUBuVqPoR7EZL4BL8ZSgejWwTae0yS5tHd4x2TL0QEwqWvTYzZ06h0m/l9CbQsgeK5sl5UkPbzQCwiS26HizhTPr4BLWz2W+Zmsb8FrAKkjAlhdKuJg49U/C7rBibBNG4x0z4HyW2pvQ3dnaAnzjLOc3LbUUIU0llh9T/yRDZgoWsdWswYV8GS+P3H69838pjj6RNwL9PaElstOYQWEMdDW94fg5SgB/RwSGWXaGEmHe6vcl4b72dOjt05bEH5JXaGHpEHoLmGLqm5DE6ykM+axN8wEKkbMKogM4R8DRj1/AzMUErDpOq9w7VlJJR4cM4X54gck52V77zQhKk8N6YJknNI79NHMfr7NKDK5qkwcMcx4VuqKs/0JWOfpVDpmXux1HLmhb5Wb57mcx7MtBr0n6CdvZiopk5IKqHvNS/GwQaff1Ln0HGH013eKCklQX4WJ8EwWne/fH2wC9q+wA3aQlN6sHdWxImnP2x9xyotVY57YCi6dPu8uvU97qGNKaSBf1ONSc9L4pqcAFfuw800qfJOxHwkrvAnejF6NkWpGhibH/WXEcgO9d3jCUcwDz2l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(1800799024)(376014)(22082099003)(25016099003)(18002099003)(38350700014)(6133799003)(29003799003)(56012099006)(17096099006)(11063799006)(5023799004)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEhJc2tEYXVhMFlUTk9RVG1qUGtrUGdiK0tOWWpYaHBKY2twSUR3SEFHWFVG?=
 =?utf-8?B?NjBqK20xVG1keWkxQUN2cTVhaGdxTUpNWHFKTFkwY01NR1ZZdDBpRk5yQ1hF?=
 =?utf-8?B?bUZYU0V0bnRJamJXb3YyQ1REenlLNzg3RnVoMGd0K3Z1YnIyRWdId25FU1Fw?=
 =?utf-8?B?UTlpUmpXTk5FMDNNNVVLRU9VcjIxVGZ1cWpPMDRIbFRoOFBQU1RXL2IzZWkz?=
 =?utf-8?B?aUQ0UGx0N1daQk91TmNXZTh6LzkwQUFWOGxTQ1RjNGhyazlJb2sxVkY0UGN1?=
 =?utf-8?B?eE85dWgvNnhtWUFYMkZKNmVDREpIeXdjenNLVCsrMVNySU9jakR0bFNBUzAx?=
 =?utf-8?B?eXFyV3JSY2Q0VWEybEgrenhEN2pibHBQWjhoYU0yZVo3Y1hkOFdaN0xxY0xt?=
 =?utf-8?B?Yll4Q29RSzk0bDR3YnkrWW00R3lZRURBNmxWSHF6NUhIOXRndEVwQW1FNTlT?=
 =?utf-8?B?UU9qc1NGYi9lYkc5Q0ZLUkl4bGdPZEdFRE9aRUR2ZUFJeVRXVEZnNjlvMGdS?=
 =?utf-8?B?d24xZGRYOWVZRUdWdHhEbER5eUFicTN4U1F4aTZ6YUczUDlQSDBIalRvVmRl?=
 =?utf-8?B?RExydFEyanhlbGx1b2NjcnNRdDBtdDlwY2ZOY1UrRUZPV1hldEthMkZ0WXZk?=
 =?utf-8?B?SnNTNUZxS0dOSDV6N2VCRitRdGVtdWUyZi90dk1INVJUOVhvczBUVDhIUmI1?=
 =?utf-8?B?MmUvYkVEZWh5TGt5Ynd1dVJqK3pvVG1VWXlZcnpPYU9qNzFlUE5iRU0zSjZZ?=
 =?utf-8?B?bnRScG5odjNQaVN0REpOTUpNdGJCQUxYRUNabFdIQ2l3eHlRczNZc3Q0dVYr?=
 =?utf-8?B?RmJMS2RGSVgxSjBuNEx3NmFJb1F0Y21URll6dW5pWVdGbStWU1JRbWNTZ3dM?=
 =?utf-8?B?dTZ1K0ZEcEdrUHN1ZlQrQVhiTUpQWWl3cnR0cThHWm5FRlI0UWF4UWlNUTVR?=
 =?utf-8?B?NVBrd21HcW1BMERNRkMyTURiRURZQjhIUWUvN3FGQkNtTU1ncFcvVnpGb01Q?=
 =?utf-8?B?ckdOQTVpNkFPVFY1TUIzREVtS2o2cHZqVGw2dVQyWWVWeFQ5emk0NGpQRjVh?=
 =?utf-8?B?S2RNdzJNd3FiZ3hGL2J0aG5KMGJCanRWT2xoc2lWTWNvRVNrZm5scWEreWFX?=
 =?utf-8?B?dVdSL1c1dUhLOVRUcGhSMHVsQU12b2R4ZWY1L3dlNE9QdERxTmx6L2JHeGlQ?=
 =?utf-8?B?dmxIa3VoMFRlMTZWYUttL0F2eE93R2VCV3RjNWVDeVAyUUVZd25yZWFYZCtu?=
 =?utf-8?B?elVNcDNkTVRZNmVwSzA5TDRhanFma3NmcTZhTzIvdysvRVh5VmJ4SWM3QUtu?=
 =?utf-8?B?dVZnNWt2K1owK1NzU1FQYmFhRlRneXJmL0ZSZnVVNm9BY0RFc1JiRU5Zd2FC?=
 =?utf-8?B?amVWZVBOcEppQWxyblRPOVA5dkdZSFZNUVJDOFJadEJLYnV0S3dPYitnVW9i?=
 =?utf-8?B?ZHlaZmNFUmhXWEgwbVk3SklWdlppQkk4ZEMvME9OdDA3TDRMNjc4NUZNN3gw?=
 =?utf-8?B?bVg0UHVZQjFJVWdJZHlKUUdrK1lCOWtYdzltaHJYVFMvYmQvVFliMkh3UUlR?=
 =?utf-8?B?cVZIUjdsWFB4SVIzK1IvR0xMZWlqKzJRdVhjb2cxTnF1RGRHbEJaRkdKU1FN?=
 =?utf-8?B?dTlvSlF6ZjVsdjN6cUpnTDUvc0RTMmJCaisxZUZQNW1LSU9IdmdxVWgxUkhy?=
 =?utf-8?B?RUVmRW5EcCtXc290UjlVY0ZHbUtia0FEaUFpUkJ3bkRnRU1WZjFKcCtnWXhN?=
 =?utf-8?B?ZWxFQXdxNWFOMzB3a1lBZnN2aXFYRkxQdkpYai8vK01QTC9FTGsvYnkxNkli?=
 =?utf-8?B?SUIvdWJVaFJHN2s3NmFoQ201MSt5UlQ0VnJXeWIvRjRieTF1NHdFWnZteUhW?=
 =?utf-8?B?L3duTlBvekpRSE9oZlF6aEFvbzlZaUhZRTdtSTRRRHJKNUNLZElBYTNIam82?=
 =?utf-8?B?cnY5c3JoTEtyMzhlYTFSdzg3a0k2M1lENnY0MWxqV05RWWh6REgvakZ3Mkxa?=
 =?utf-8?B?TnJnUmxLRElwdTYreTExUE14OEhNdHhqVngvUDZNaDJDRkcrc2lrWjVSbkZ1?=
 =?utf-8?B?d2p1OS9zTDlWbkV5QUJOY0tIMWt4Wm9lWVBkWGYzait5cXVlaWxhakI5dE1y?=
 =?utf-8?B?SElCTUk0ZFBKUnFZUVNndHJ0TVdaY3VySHdFL2l3MFRVcVpVVlVNd25FRGNO?=
 =?utf-8?B?bkMzT2FqanlZMlFhdGdWVlNaRnJaWG5EcnBZNUw5YTI3TmIxRnZBTFlEam9t?=
 =?utf-8?B?VXJ5eTRkblRvcnc1dFFrYXhwemtNS2Jzak1NZzdtVXZtZURXUVN2bUtEZWJF?=
 =?utf-8?B?Y2l4U3RCSWVEY0FLMXBMVUdNUURscllhZEdxT3FSbjRrZlpWQ3preHRMeERQ?=
 =?utf-8?Q?SNZ35pbR6I/tkKiY=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbf1f50-42c1-4665-f434-08debb75e515
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:26:56.4452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZL1noLJeweJl9NRU56WUHjiItMJZTi9akbznex5Hiw/jEB7hGf6H6eK1AXBMZ8uTCK0ieGU+ReAe3l/S4AEvnk2hWvLhIXBPk4l0ya2fz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7063
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

On Mon, May 25 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
>> linker_lists.h: emit lots of meta-data for debugging and sanity checking
>>
>> This is an attempt at to make it possible to catch various problems
>> with linker lists at build time, without affecting the size of the
>> final binary. Also, I did not want to have to modify all the linker
>> scripts in order to not get all this meta-data thrown away by garbage
>> collection.
>>
>> The basic trick is that one can use the .size assembly directive so
>> set the st_size of an ELF symbol, without that symbol actually
>> occupying that amount of space in any section or the final binary. And
>> all of the .size, .type, .{push,pop}section directives are completely
>> generic, so this should work for all architecture.
>>
>> So whenever we declare a start or end symbol for use by C code, also
>> emit information about the size and alignment of the type that the
>> list is supposed to be made of.
>>
>> A relatively straight-forward script (next patch) can then parse the
>> ELF file and report on any inconsistencies. For example, suppose two
>> [...]
>>
>> include/linker_lists.h | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>
> I see this:
>
> test/cmd_ut.c:67:1: note: in expansion of macro =E2=80=98SUITE_DECL=E2=80=
=99
>    67 | SUITE_DECL(mbr);
>       | ^~~~~~~~~~
> include/linker_lists.h:45:17: error: expected =E2=80=98)=E2=80=99 before =
=E2=80=98:=E2=80=99 token
>    45 |                 : : "i"(sizeof(_type)), "i"(__alignof__(_type)))
>       |                 ^
> include/linker_lists.h:48:9: note: in expansion of macro =E2=80=98ll_emit=
_type_info=E2=80=99
>    48 |         ll_emit_type_info(_list, _type);
>          \
>       |         ^~~~~~~~~~~~~~~~~
> include/linker_lists.h:297:9: note: in expansion of macro =E2=80=98ll_emi=
t_start_symbol=E2=80=99
>   297 |         ll_emit_start_symbol(_list, _type);
>          \
>       |         ^~~~~~~~~~~~~~~~~~~~
>
> See below

I don't see that, and I did use sandbox as one of the targets I
built. Running the script on the sandbox u-boot ELF file, I get

List                                    Start           End             Siz=
e    Align   Count
acpi_writer                             0x00449440      0x00449580      32 =
     8       10
bootdev_hunter                          0x00449580      0x00449658      24 =
     8       9
cmd                                     0x00449660      0x0044cb50      56 =
     8       242
[...]
usb_driver_entry                        0x0045a9a0      0x0045a9d0      16 =
     8       3
ut                                      0x0045a9e0      0x00461ce0      32 =
     8       920
ut_2_addrmap                            0x0045a9e0      0x0045aa00      32 =
     8       1
ut_2_bdinfo                             0x0045aa00      0x0045aa80      32 =
     8       4
ut_2_bloblist                           0x0045aa80      0x0045ac40      32 =
     8       14
[...]
ut_2_upl                                0x00461c60      0x00461ce0      32 =
     8       4
w1_driver_entry                         0x00461ce0      0x00461ce0      16 =
     8       0

i.e. ut is both shown as the whole list with 920 entries, and each
sublist is also shown, exactly as I wanted it to appear.


>> diff --git a/include/linker_lists.h b/include/linker_lists.h
>> @@ -23,7 +24,45 @@
>> +#define ll_emit_type_info(_list, _type) \
>> +     __asm__(                                                \
>> +             ".pushsection "ll_info_section_name(_list)',\'aw\'\n'   \
>> +             ".type "ll_size_symbol_name(_list)", STT_OBJECT\n"      \
>> +             ".size "ll_size_symbol_name(_list)", %c0\n"             \
>> +             ".type "ll_align_symbol_name(_list)", STT_OBJECT\n"     \
>> +             ".size "ll_align_symbol_name(_list)", %c1\n"            \
>> +             ll_size_symbol_name(_list)':\n'                         \
>> +             ll_align_symbol_name(_list)':\n'                        \
>> +             '.popsection\n'                                         \
>> +             : : 'i'(sizeof(_type)), 'i'(__alignof__(_type)))
>
> This is extended asm (it has operand constraints), so GCC requires it
> to be inside a function.

Not exactly. My 'info gcc' has this to say:

  Similarly to basic =E2=80=98asm=E2=80=99, extended =E2=80=98asm=E2=80=99 =
statements may be used both
  inside a C function or at file scope ("top-level"), where you can use
  this technique to emit assembler directives, define assembly language
  macros that can be invoked elsewhere in the file, or write entire
  functions in assembly language.  Extended =E2=80=98asm=E2=80=99 statement=
s outside of
  functions may not use any qualifiers, may not specify clobbers, may
  not use =E2=80=98%=E2=80=99, =E2=80=98+=E2=80=99 or =E2=80=98&=E2=80=99 m=
odifiers in constraints and can only use
  constraints which don't allow using any register.

and since the only constraints I use are those that provide an immediate
to the asm, that should be ok (and WorksForMe).

I'm not sure how it has happened, but in your reply, some of the double
quotes have turned into single quotes (e.g. "i" has become 'i', ":\n"
has become ':\n'). Both here and further down. I hope you haven't tried
to compile the code in that form.

> ll_start_decl()/ll_end_decl() pull this into
> ll_emit_start_symbol/ll_emit_end_symbol at file scope - see
> SUITE_DECL() in test/cmd_ut.c
>
> One way out is to drop the operands and have the C side emit a
> zero-initialised marker object whose array dimensions encode
> sizeof/__alignof__ - e.g. a static struct in a dedicated section whose
> two members are sized sizeof(_type) and __alignof__(_type). That costs
> a few bytes per list per TU but keeps the trick working at file scope.
>
>> diff --git a/include/linker_lists.h b/include/linker_lists.h
>> @@ -23,7 +24,45 @@
>> +#define ll_emit_start_symbol(_list, _type)                           \
>> +     ll_emit_type_info(_list, _type);                                \
>> +     __asm__(                                                        \
>> +             ".pushsection "ll_start_section_name(_list)',\'aw\'\n'  \
>> +             ".type "__stringify(ll_start_symbol_name(_list))", STT_OBJ=
ECT\n" \
>> +             ".size "__stringify(ll_start_symbol_name(_list))", 0\n" \
>> +             __stringify(ll_start_symbol_name(_list))':\n'           \
>> +             '.popsection\n'                                         \
>> +             )
>
> These multi-statement macros are not wrapped, so they only work in
> contexts that accept two declarations/statements separated by ';'.
> ll_start_decl() then chains another declaration after them, leaving a
> stray ';' at file scope

No. The definition of ll_emit_start_symbol() does not end with a
semi-colon, the user supplies that, so that it reads e.g.

  #define ll_start_decl(_sym, _type, _list)					\
	ll_emit_start_symbol(_list, _type);				\
	static _type _sym[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
		__section(ll_start_section_name(_list))

and the user of ll_start_decl() in turn supplies a ; at the invocation
site.

There's no stray ; anywhere that I can see.

- accepted as a GCC extension but rejected
> under -Wpedantic. Please either fold the two asm blocks into one (a
> single .pushsection ... .popsection can contain all the
> .type/.size/label directives), or wrap them in a way that gives a
> single declaration/statement. The latter is awkward at file scope,
> which is another argument for the single-asm approach.

Sorry, I don't see the purpose, as I still need at least one statement
beyond the existing symbol definition,=20
and by defining the statement-generating macros in a way that they never
include a trailing semi-colon, they can freely include other such
macros. And I don't want to duplicate the type_info macro, that's why
it's split off in the first place.

>> diff --git a/include/linker_lists.h b/include/linker_lists.h
>> @@ -23,7 +24,45 @@
>> +#define ll_info_section_name(_list)         '__u_boot_list_'#_list'_0'
>
> Worth mentioning in the commit message that this is matched by the
> existing KEEP(*(SORT(__u_boot_list*))) globs in all the linker
> scripts, so the new _0 sections end up in the linker_list region of
> the final image. Since each section is zero bytes that does not affect
> binary size, but it does mean the metadata is reachable from the ELF
> symtab without changing any board's linker script - which is exactly
> what you say you wanted.

Yes, and I don't really need those sections to include the #_list part,
I could just create a single __u_boot_list___metadata section. I used
the above mostly so that they list metadata symbols for a given list end
up immediately preceding the items belonging to that list in an 'nm -n'
dump.

>> diff --git a/include/linker_lists.h b/include/linker_lists.h
>> @@ -23,7 +24,45 @@
>> +#define ll_info_section_name(_list)         '__u_boot_list_'#_list'_0'
>> +#define ll_size_symbol_name(_list)          '_u_boot_list_'#_list'_0_it=
em_size'
>> +#define ll_align_symbol_name(_list)         '_u_boot_list_'#_list'_0_it=
em_align'
>
> The size/align symbols are emitted as local labels, so every TU that
> touches a given list contributes its own local copy.

That is deliberate.

> That is fine for the parser in patch 9, but it relies on strip/objcopy
> not throwing away local symbols on the way to the final image.

No, it does not.

> A note about this - or about pointing the script at u-boot (the
> unstripped ELF) rather than u-boot.bin - would help anyone trying this
> themselves.

The script cannot be used on u-boot.bin at all, that has no symbol
information and is not an ELF file. The whole point is that I emit a lot
of symbols and metadata associated to those that _is_ thrown away by
objcopy, so u-boot.bin remains unchanged.

>> diff --git a/include/linker_lists.h b/include/linker_lists.h
>> @@ -128,6 +167,7 @@
>>  #define ll_entry_start(_type, _list)                                 \
>>  ({                                                                   \
>> +     ll_emit_start_symbol(_list, _type);                             \
>>       static char start[0] __aligned(CONFIG_LINKER_LIST_ALIGN)        \
>>               __section(ll_start_section_name(_list));                \
>
> Just to check: is there any reason ll_entry_start() emits the metadata
> at every call site rather than only where the start/end markers are
> first defined?

Yes.

> Within a given TU every call expands to the same
> .size/.type for the same symbol, which the assembler tolerates but is
> wasted work.

No, because this is part of the sanity checking I want to do. If you
ever use ll_something(ctrl, struct foo) and also ll_something(ctrl,
struct bar), I'd like to catch at build time that the 'ctrl' list is
used with two different types.=20

Sure, the sizes could (and often will) match, so it's not foolproof, but
it can catch some cases. I'm trying to come up with some way to make
this part even better, without adding anything that will cause
u-boot.bin to grow (I don't really care about the size of u-boot the ELF
file).

Rasmus
