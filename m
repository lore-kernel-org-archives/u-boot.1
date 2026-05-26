Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C35ACD5BD0
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 22:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A64848E6;
	Wed, 27 May 2026 00:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="OEmPjVQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 797A7848EE; Wed, 27 May 2026 00:41:22 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B57848E3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 00:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZW628z01lSuOwHdF+ABQjjZI46aOBMHJIiFEWPmYgb3IZR0TDYBJIoS8d1QZyHMraqUh2EL+Ov2FAQjSNXI0AwMqX97f15FMJoQMYD71kMsWDIG6mIqJVFqNKf9GAlOcq/VGL5Ob97cS70wC1OuOVCMg/6MxdwAhBceH6yhoMaFzqSOtHvyDjRUz0rhiYM70YHK/Jvnt/967EZrKB7gZA9ikRQ0PAKdDFlDH9yaq2qxEBcGfuSUzsUbr8iLt869SzpqYG+4mMkF9gb//601072pnO6KJ7824h0qBDTw+MRzlNKkFl1Kt48FNf0c8jDR44rcsParR8cdGkXhmly2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ0uPiFcVu91n/kFYQZzRM9/phUkjjDdBnlJ5zTK1ZY=;
 b=OaqN0zl3N0IUxwrvvwbpjJGMtQ1PfeU1eNzdeIEIxMYd1D03dVaj7LYLekl8BIU5Tj3VysHjFgkZJt5lrNJ3QikpyFO8y6oWCRy++TUchHmDU3zMINArThXHqVuX25HlEeLDHZYacw9HTQev6zq6HfPJFYZXP7SdkDcF+e29cZ/45qncnx7lWyqj5Y2RJOuUxodBCwm53ypZ6xwxAbSzcpGrECROwK5kqTUgveOSzsDPhkVu7TYaTrV47RyLPxESftHNieEyZ/BDeLM8boxKYVcWzSZrq9oQyEGC49lfuNTF+2+w7XQAvtad+Kz0ub4BKLw7d0esJZAjSA2bNv1XTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ0uPiFcVu91n/kFYQZzRM9/phUkjjDdBnlJ5zTK1ZY=;
 b=OEmPjVQqT0he3I6NdAlcQw2lFlqlEuQGwb0zfjpEFGur7JQr054aUbYTeKNYuaZqwhqJ8Mp0A/UFJhTPbkHOZ+wfDpqqCNXahNT1QWHBPhNDIQKu8a14Ry5ixEpgKDCtM4uHgJEkWRMNC8F2OPSQ++42t4VRWPQG5GEcMoQM6bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3200.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:130::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 22:41:14 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 22:41:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>,  Tom Rini <trini@konsulko.com>
Subject: Re: [RFC PATCH 8/9] linker_lists.h: emit lots of meta-data for
 debugging and sanity checking
In-Reply-To: <87v7c9erip.fsf@prevas.dk> (Rasmus Villemoes's message of "Wed,
 27 May 2026 00:26:54 +0200")
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-9-ravi@prevas.dk>
 <CAFLszTh61_1vQ3bG29H5xVkrcLTc_meji7nqhqSK+8poHwECnQ@mail.gmail.com>
 <87v7c9erip.fsf@prevas.dk>
Date: Wed, 27 May 2026 00:41:13 +0200
Message-ID: <87qzmxequu.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CPBP307CA0003.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::15) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3200:EE_
X-MS-Office365-Filtering-Correlation-Id: a877fbb3-90ba-4c4c-c522-08debb77e4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|22082099003|18002099003|38350700014|3023799007|4143699003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: eKG2Vhv6OvQ8NB9b7viLpRT8TSFbMNPTmAixU56ilHIcpghlwf81X2lKXS159J4hzhDLepPC38Zho6xl1+zjMsjQ9pcCPWBa5iUbqKKAHUwiiTILWdUwosjY7LZK3U+PGyQPxjUmm4FNBwcOgDG9KD3LUngIMRuU5OPcKq70434BNoxxxiPyXVbkXb3FYK0YlxVRQ81WyRi2xaUI5s1mONjmu1IdwOJyRMuvYGEUg9qNk6lA/oHuAFuIU8E9/NA/8KTALuHMGPUNWOEP4bW8puTk56R6EYk4GZDtW5U6gncVPNYxN9BkFSQJ4Tf3tqxzwdbcFSQo5MT7DhXHsWncwxy8THS+2YUi0sopIMjAi1ouJXsDVbuWvt0ieP4BzBx4iyNouK/A0KyYf7A5UfMxiXILqSf4YgaXrAUIq28tKUGl8ERT8YMgJOWMqrAclqKbBXgV1xQzPrDKZ72/GvX5A7wDmTSLc1vNo2IeB08Z4ty59C/GStZ7eTnMJJmcjFXdCRK1CMK0gFkbYchDmt/RNp1SbFgFREycK87XQd0Q4kT9ydLgCJ+CfLNMDcVtbMcnRS4xxcwNg4RTcgwcocHlrRG7Q7YPLsmoq6FlNma5yA0PtDpM+EA8Mtq0+mrmrs0pDUZ90/sl00gz4niuXyTvEMDPfb5fn3UpQpvzOBdDywRQgKxyLi1Lw8orMYOoqieRPZFa9EOYKY8vRdbZcc3iE+xltOz8msgVJM+sY6lwxn6GRzLlM8S0Nu59L6eSgN5t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(22082099003)(18002099003)(38350700014)(3023799007)(4143699003)(56012099006)(11063799006)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2hUTStFeDhJKy9WZHQvbTlPQXF2MTkrMi9sSkV4YmQ4MU5wZ0VDTTA0WXM2?=
 =?utf-8?B?bm96TVh3N09VVWdNd3pXUXNwVmdpK29EV3p4ODBtNUlhT3hlZnVaWU01dEdC?=
 =?utf-8?B?dDdMd2d4QUlFejA3ZW5Qeit4OFB4UW1oREhhMkh3L1dhWllnNXJqaGxSTENj?=
 =?utf-8?B?US8wS1pvc0I2TjBRVDNvM1dNbDZMN2VrMElMeDdGQkdvTzdkdFZYUE9lZkJE?=
 =?utf-8?B?dFVaL1RQdmFOb05MbmJ0YUMvRDFIM2x1VUx4SEVkMm1WZy9DQU1wMDJxM21B?=
 =?utf-8?B?aTlheFhNS05IYjIxV0dhVUtiVmdCZEQ0MWgrWDg3NXoyOTRGODV3MlkrbFo4?=
 =?utf-8?B?ZEs0WlhPRjk2SjlCcGVIaTB6dE5hMmNWQkROSlNId0IzZTB6U2c4SC9pUVNa?=
 =?utf-8?B?eU1tL3Z3ZlJ6TTRZdkNiNTVBNVZLN2RmS3JoQ2dRVng5aEpOSUlFQTI1aUZ1?=
 =?utf-8?B?OXRqdVMraTRqSERSRlVlRjVkMjZwc0g3aFN1WElWVHd3ejR0aVhhMGRCQUxp?=
 =?utf-8?B?eFVZSDljVTJibkdQSHltdlB0bEV1aXE3ZGd5djZRcDM2YkpOYkpQaHpMVEFC?=
 =?utf-8?B?T29kUENuUzBNRFpBOHhqbmZjUTNZRHdkb2J4cExzcllheXJ3eWVUM3lPc0Y1?=
 =?utf-8?B?WTc1VUZrYnc2VG1BOS9UVzVQcjVraHFtZDhOYml3Z2krZjMvNm9neExnejB2?=
 =?utf-8?B?ZWNwMndKcWZRb2RXOG90d0Q4bC9tT2VVeDhvcENZQzFmbzRiY0xIRDBaaEVV?=
 =?utf-8?B?dDdEQmoxZnZGOXlOditnVC9uTmV3VHo5bmNXUCtnaFluYThrYUtpU1NmRERL?=
 =?utf-8?B?a3NxTEUvRU9VNW1vVnpqR2NkOFNHWm1uQnl2elN0eURHSDBhS2lnZXhGVXpm?=
 =?utf-8?B?dEF0emhhVW8xSDJvRU1aNkpnTDBvbHJiWThLTHNnUWxQMzNXby9ubFlNU0t4?=
 =?utf-8?B?UmpDcDkwTVR5QXhFUE9xWXBmYXE4SldCMksvY0FRQXZNdGY1UzBRdVpHY1NB?=
 =?utf-8?B?Z2hXNUZJaWk2cXhrcW51UmhNSTRCWkluSnR3Zkg5cGxnMHVrUnUwTGxObWlW?=
 =?utf-8?B?Ty85MnQ4akFGR2MrZVZnNUY2Tzd0SEFBcGhwSy9GcmtBcmt4TmZvbWdzcDF1?=
 =?utf-8?B?NGxQcjBnQmhqQXZaeHJ4NXFMb21JS0huNWY0aFI1ZEhTL2p2Ry90T3Z5Y240?=
 =?utf-8?B?QnZGMUFsaFNWbHNMOGFOejZXSnRMZFpRN0dneHhJZTNhK29TMTJjenZtRDFC?=
 =?utf-8?B?ZGJRTXJCL1FTWlovUlJLN0dvNTJwdzlmVWhMd0tTMENEYmo5UVM1QnZKQnBO?=
 =?utf-8?B?M1h5YVg5aTNEbk1TQ0NjaVIyK0tmSG5NZXFCdHdFZi9IT2RERlNYbzFqdkph?=
 =?utf-8?B?QVZqMEszWmFUdmcvM2oxLzR4YVhqLzBIYkdrdG94eEhFUkRpcnZ4aGtQVFhV?=
 =?utf-8?B?bDV0K0UvMDRScVEwWitxdFhMV3JldmxIY1NKOVljZTVxcmdKcjdxOXhBWVdL?=
 =?utf-8?B?R2RsOG1tYzJkdDlBSy9ncm5KNTBEb0FFNkJYK01JYlRwTE1nTWg4NEtUUG1N?=
 =?utf-8?B?SExORis1WWVQdmduZGIzVERybk5vRnI0L1ptVVZzcHNTb0I2MGkyWGhPcWVK?=
 =?utf-8?B?ZjJWQ1B6dWxJbWp6YTR2OUNGZ3hOVlpnK1dRMmszR0Yra0hQVWdYaTdLY01W?=
 =?utf-8?B?NWRoLzNyQ1g5ZEZrMDRMbTJqdHB4Yjl2YkttL0tHcWRoK1gvWFhaYlFoa2tI?=
 =?utf-8?B?RlZvL0YvcjhRUC84aWQvSWZ2aEdjamlQNUZLOFhCWmtVVU4wc1BwWVVHQlFR?=
 =?utf-8?B?eUxVV3Z5VlNKYWR1b2ZpL2JFSC8yVXdHcmg5Z0Vqdlo3MytxaU9kT09ndWJo?=
 =?utf-8?B?aHdBNnhSQWZEMnl3dG5sTjFUNHQxaFBMZEw1VXY3bUtwRlFPbEMxOTV3M0gw?=
 =?utf-8?B?djgwTWpMaDRVcHV2aUVNUUJUdXNZakE1MUR1Tmp6QUE1dldYSzk2dEtPRGJv?=
 =?utf-8?B?Vzc5SFdOakFBRVNkUDVRa2g5c2lhZFJOaTBqQW5pZzlpdms4cVkwaHRqNzQ3?=
 =?utf-8?B?S295ZnB1cUI5ZGl2OTEwRll3UGMrUzdIU3cwc2V0UGNKTkRZZ283VDM0VWhj?=
 =?utf-8?B?UTVIVC8vQTRmUUlMZmdXalRhdS8vMWJvbzRHNUZHWTJEVFhyQUNucnNPekRj?=
 =?utf-8?B?bXQySXIxK0VIWXlka0dENUZCbmExc0V0TjNzVVNXV0VZb1dEN3NyRHVmUGJs?=
 =?utf-8?B?S2ZZMUhTUlB4RTNmNnY2eEM3dU53OCtDRHJDeldmVUo3aWs4akR2TFRDS3da?=
 =?utf-8?B?dU1wKzVnVmg3aUZMK3RTVDFqK1pVVGNKbk4yalQyNHZjSVU1b2ZSdmwvZ1FC?=
 =?utf-8?Q?cl5Qhnt9wo/RQY8c=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a877fbb3-90ba-4c4c-c522-08debb77e4c8
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:41:14.7907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73+UJ17uCoukvhyk8TzX7r1dNF6GqonM9rk8676WzttvLyeWyHIOpovwvdmHHQj+orLvLtm5tXmM3PxpXP1ODtTvTmmQmiKAC5OQ2LNywPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3200
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

On Wed, May 27 2026, Rasmus Villemoes <ravi@prevas.dk> wrote:

> On Mon, May 25 2026, Simon Glass <sjg@chromium.org> wrote:
>
>
>>> diff --git a/include/linker_lists.h b/include/linker_lists.h
>>> @@ -23,7 +24,45 @@
>>> +#define ll_emit_type_info(_list, _type) \
>>> +     __asm__(                                                \
>>> +             ".pushsection "ll_info_section_name(_list)',\'aw\'\n'   \
>>> +             ".type "ll_size_symbol_name(_list)", STT_OBJECT\n"      \
>>> +             ".size "ll_size_symbol_name(_list)", %c0\n"             \
>>> +             ".type "ll_align_symbol_name(_list)", STT_OBJECT\n"     \
>>> +             ".size "ll_align_symbol_name(_list)", %c1\n"            \
>>> +             ll_size_symbol_name(_list)':\n'                         \
>>> +             ll_align_symbol_name(_list)':\n'                        \
>>> +             '.popsection\n'                                         \
>>> +             : : 'i'(sizeof(_type)), 'i'(__alignof__(_type)))
>>
>> This is extended asm (it has operand constraints), so GCC requires it
>> to be inside a function.
>
> Not exactly. My 'info gcc' has this to say:
>
>   Similarly to basic =E2=80=98asm=E2=80=99, extended =E2=80=98asm=E2=80=
=99 statements may be used both
>   inside a C function or at file scope ("top-level"), where you can use
>   this technique to emit assembler directives, define assembly language
>   macros that can be invoked elsewhere in the file, or write entire
>   functions in assembly language.  Extended =E2=80=98asm=E2=80=99 stateme=
nts outside of
>   functions may not use any qualifiers, may not specify clobbers, may
>   not use =E2=80=98%=E2=80=99, =E2=80=98+=E2=80=99 or =E2=80=98&=E2=80=99=
 modifiers in constraints and can only use
>   constraints which don't allow using any register.
>
> and since the only constraints I use are those that provide an immediate
> to the asm, that should be ok (and WorksForMe).

Ah, that's actually new in gcc 15 (I'm using gcc
16). https://gcc.gnu.org/gcc-15/changes.html says

  Extended inline assembler statements can now be used with some
  limitations outside of functions as well.

and explicitly calls out

  "i" (sizeof (struct S))); /* It is possible to pass constants to toplevel=
 asm.  */

>> ll_start_decl()/ll_end_decl() pull this into
>> ll_emit_start_symbol/ll_emit_end_symbol at file scope - see
>> SUITE_DECL() in test/cmd_ut.c
>>
>> One way out is to drop the operands and have the C side emit a
>> zero-initialised marker object whose array dimensions encode
>> sizeof/__alignof__ - e.g. a static struct in a dedicated section whose
>> two members are sized sizeof(_type) and __alignof__(_type). That costs
>> a few bytes per list per TU but keeps the trick working at file scope.

Yes, but this is the kind of growth that I wanted to avoid. And if I put
those marker objects in a section of their own, I'll have to modify each
and every linker script to preserve that to the u-boot binary, but
ensure that the objcopy step throws it away.

I'll think about this some more.

Rasmus
