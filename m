Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F071CF531CA
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 21:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A4CC839D5;
	Mon, 13 Apr 2026 23:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="T3cSryLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF96839DF; Mon, 13 Apr 2026 23:08:06 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 630738352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 23:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMZTlTbMMppcBqMfO7EEofGf4s0YVUsQsKtcgb1FhvAG+ZwdXU7VEsqc1PVMDye2vNhfc4KUnjXZkylkjVHRk2zuYrIxKiNCyXrm19UMBjNy8xB+mxsuvbczJVXGP8g4rdvUEzD0vVGz+PReaiLF27T+X2pT26ej5YL8hDJijoiF0tgNUgJlgK+IC50r8fST4wlFEnRmaclmYS8dd1fyN6sbkigz89pdUsMUFAPXCWEKbWD321yVOz4xcg1gj2+Q7616ayciYzXmPo6V61cBtjQjJHbvCt8j8hiFR1I7vl3vIzj8K+4RQZ4gRPHGOxGNQBUX/73jQrIW2JZd1tdBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jlF2QCt/RJUtAJZkzDxAmhQN1nPuN7lSV8z9jCNhvc=;
 b=EBJygiHWX2/7PxiDYxyBO6PDRgZMfN2zAQwppv+TSX1E/3n3/+tQq8TMRb+LPnl9Z+idpb6gHBdUiE/7P7//8SfefXMztvjXHkBbLWlAfUoHKstCV42P8g8/vstFJWjnzpDwWzumoDitR9gAEnFe3ulTD1qfOqhFPHhzDdHEPAfnyMMHyPTL/f4VsRUE1DgyOZUnRcBQhPVkhwPprkhFnx+8i01sLZeRTA/RMqPRdsNKNZ0YljOEpHLdDDjB29HoKEiQMNCtjOgzjS7Z5xqh8KpMIDScuYaSqYGmowCqRBwY4F2EcY3XV0quMSsueyfnaUaUoftj7vBWjml8XbE67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jlF2QCt/RJUtAJZkzDxAmhQN1nPuN7lSV8z9jCNhvc=;
 b=T3cSryLR5vXg2iC7Mvd0ZPblNCo5Gm/DNgEsM4NimlRL29XBr2iznbqGXdnAjaZFfoeZ+aTR1hPPi4wi2XyzSvZ8qU4pM638hdShY3pg5R6X91mFKOZI3IE9GdzBlN108cbcAd6Fly1Oo9InTOlMqoynkJcq0SRWpQtuI0ormUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DUZPR10MB8051.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 21:08:00 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 21:07:59 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Simon Glass <simon.glass@canonical.com>,  Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] linker_lists: Fix end-marker alignment to prevent
 padding
In-Reply-To: <CAFLszTi_U4xS_6kW1VUqaKVUeP+sweOfQvAydXM5F0nQOGSZ+Q@mail.gmail.com>
 (Simon Glass's message of "Mon, 23 Mar 2026 10:17:17 -0600")
References: <20260321134626.516665-1-sjg@chromium.org>
 <20260321134626.516665-2-sjg@chromium.org> <87jyv2oon5.fsf@prevas.dk>
 <CAFLszTi_U4xS_6kW1VUqaKVUeP+sweOfQvAydXM5F0nQOGSZ+Q@mail.gmail.com>
Date: Mon, 13 Apr 2026 23:07:58 +0200
Message-ID: <87se8ymuvl.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0023.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::36) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DUZPR10MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 860d32ff-b2bd-4b81-d75f-08de99a0be03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LqErRicEtVAKZuZ4zqF0CBOFcUp0qr5oNOaSYofqJM1wDe6CKm/HUp0sMtQR+xsmEbAGOuX1DYlaCPCgMMO19iNGfrq/KsUtZulvElWaLaFVz0nCCW6Unhzrt9S/DGPwsiHpwAMGjUDGGXms0G9UOwwnZ6Jn6UrrAqNebkqlt0JLn9tZzf6gkxWZ+SXsMa9+9+Z/O1Mog5WS8u3WR8fxi+iEdaEXNZlW9AqpfuBDs/SfvEt/LJlAPP1e2ciWHbk1qkIzAnJ7S43ogPqn5Hw3QM84tVMvBu2wbTwwP8S3S7niwl/q2nSkXpIbcNtCAvvrT6SzBavKLUgGpG/5qex7AmEHYLE7GQByYsh+lGO5fW3pXWr76/YndFz/qJSLG/cdhEIMN4b/zKDnB3q8TYFcQmTpLvzaD/r0hzTAq36k9YZYsOgCcN6ZdZU+3tE9K/PnsBoKokpBQ6+qzUEA3ebWNHG+mFT85cdxErNpXZmj7nqOM+WfqkjS8OVALy7SqYcI/YDEWzJv8YssZzfKSEBAJispO5mXhcyzC6Zo1Ui/zeMyTPSnF8WcMRWksRLtVXAIQIL1g2Q+Ao4pwGbBfCe++EwFVJ1pah0vXmtWYITjlTRZ2huHPa0ZsSs8Fuk/TUEWNnHBRxspXqhrl7wGVZ55sLV/Kel0KrD0zG2+D5p7Zy88EYqvI/QisldjBEPQGZFwhTy3Ne2k8QOjLyNhQAmbqTKqONryqrmg/KbyoxQ7JwXhcSFioWh1JrRSqyRBHKjNEEzmBCnuqKmFDT1UUQBtkVbbbqQwnTZKUNBIBEdszzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?97tXxIrUIDcRD6iTEcZBP9mvkLSJ3MCc3peeMaJwnl7mncQ6A/VBecQWJhYh?=
 =?us-ascii?Q?BoWnyygj+V1dUL0GPXuwz/oOZeNtWawJreeK6ThyC5XdqzXEzyay+KNMAyOz?=
 =?us-ascii?Q?Viah8o+K4SBmmiHV5cEcNwhUPrBJR6amxMbozkFjTDiGp3My0uZgo9AQlFxv?=
 =?us-ascii?Q?Cf446vcajHVFDxpGElRvYq9+yFdCjuixLFEDR2Ni1KQOTIfAT8Owp1RBzSmJ?=
 =?us-ascii?Q?s+EuqEEszQEm7pN6VPi9XUB947sI9tfLzUf0VjL4Umlhh9XIV3p3qr3YGhdL?=
 =?us-ascii?Q?ECMxWfE/KhV9XXXLSAVXXr/Br4ffwhMoT2eFRnWDeXDeJ4cYosrNYzXPpySB?=
 =?us-ascii?Q?hO8rj82yDtt05Ucft1cDBVlkP10yVILXlj2/LtyigEYFZNXWWwc59wCNyJjd?=
 =?us-ascii?Q?plbDhylUxCO2WYxaBpRStI+oqSGIdh7zO7qbX0u8WA7retiVyS6Yj0+T2A8w?=
 =?us-ascii?Q?fnT+KUkbre3NOOJFAXnC4TUoLh7ZiR45AOHBzB8afqz1LW/EZn4U/Za7pn0Y?=
 =?us-ascii?Q?xNM0bdH5gtA/5fXbbrjBYnL9rnsnG6HnBcK1qIcNyaZq8ngzgSlZ+5WKrbLN?=
 =?us-ascii?Q?K8QIAEXwTyc4D5wrUi3gAobS425PSPxW75Do5j/Tkug6fXoYj+kYPMCLTK1M?=
 =?us-ascii?Q?RNVncjD1MQbV6weDhCV+/U68u1fhdvFIuHCwdF3lhUnPwbHVJ4hxA9kBEUqD?=
 =?us-ascii?Q?XHlELsnCpeHdWy50dDWfbVsA7upPbHWwb4nCLxTs+2KmrXnju+QRtP4LWPO/?=
 =?us-ascii?Q?n7Co8NAcbBc8stctscBKJV9FoYTraG8dHrrh5bYtXAEo/CtTpbBasmMcpVgA?=
 =?us-ascii?Q?TIirM16sLfkVicLqF7uw0xM4DdnMxJwJEPWCUkfZ9ZdAkdt5t99342U99trm?=
 =?us-ascii?Q?WpqxHr+UuPjOj2wX18OUdDTKeMsox64kaCSt1Ca7wPQz9pmPE7Xo1E0oT2Co?=
 =?us-ascii?Q?PIjtSCY+IHheFWDmpVhTWj2bvyPBtGmZUlX5PTKfJJj/eZL8JD/I3L1C5Cgu?=
 =?us-ascii?Q?spXF9q9hqGJwtShGoCnw/buOwI5X3ztpywFQPfwfLZiEhMZoVBcjlW+HB0Sf?=
 =?us-ascii?Q?DAZSZkcjDp67ZwzQa7IMDWp4qRX0Fn3ghu62rdBOu0TfWuKh0qaSVct2mHTp?=
 =?us-ascii?Q?B11HAuoRSJV5tnccqOM9y/pdhkzBm1PUXp05TyviIB2W5NTYWlqJgWYc9nUy?=
 =?us-ascii?Q?Gd3mEQTplS2TkuiWe8KJARtH+v9KYHPnGtmQq0v8+vmcpguso/9qhb/p+eC1?=
 =?us-ascii?Q?QYf+lFVk6uHgxrDWB8b6PMZp0L8G0F8EExKvYiX33NYAybSYipXRZgaRe4sA?=
 =?us-ascii?Q?pRxsvAGuEYo8FyV2SPRYiOB2y2yRPh9eEdjcOyOnPqc8SAiHI64UYiCcMJ8P?=
 =?us-ascii?Q?l5cIle66bEPORcL8kB12XRuaR5zIDqUjwpfGcm6ytnYlPts5f7eiIBn7l1X0?=
 =?us-ascii?Q?p0ftbPFRGJ7EOFIRFC9ghpawxzSQ8Vil9Fnbe436mw2xu/no6HLwSAA1KHHk?=
 =?us-ascii?Q?XdtDpDzsJ3/0fqTTF9V4dK+5WifqssmWCoc6fDg0+j74SU6l89Cx3KGCC1n8?=
 =?us-ascii?Q?Rnn1fiAgtXbx5bGHRoHmjPoyBW2rZO4x9YBT7EW+Jc3VP3p4vl6RqjE0ww0J?=
 =?us-ascii?Q?Nd7J1FPGsOfa0XAskRX2bD2vCssdgDNYJLZ2iYBhRHMqaFFFQ1WnwJ9KR/vd?=
 =?us-ascii?Q?SgE7mzrimAvp0Wsdp1vpSK7umCCrai2PRpREi+Lmx6UqjhAukzgCFkqs+KUd?=
 =?us-ascii?Q?OyseqSKKWTxbuR4lZUlRb527ULteZUs=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 860d32ff-b2bd-4b81-d75f-08de99a0be03
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 21:07:59.6474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJATxlhwMwBtfUp/Y2nfL4CuUeERZw6kVKTb4Kz1MH8PKe2IEU/6twRVDUBK174KUctM8EzNRv90V5AnI8hiqMrgsD0dwiu7y80veGZSBoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8051
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

On Mon, Mar 23 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On Mon, 23 Mar 2026 at 03:56, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>> On Sat, Mar 21 2026, Simon Glass <sjg@chromium.org> wrote:
>>
>> > From: Simon Glass <simon.glass@canonical.com>
>> >
>> > Change the alignment of end markers in ll_entry_end() and ll_end_decl()
>> > from __aligned(4) and __aligned(CONFIG_LINKER_LIST_ALIGN) respectively
>> > to __aligned(1).
>> >
>> > The linker places zero-size end markers at aligned boundaries based on
>> > what follows them. When the next list's start marker has a high alignment
>> > requirement (e.g., 32 bytes), padding gets inserted before the end
>> > marker. This causes the byte span (end - start) to not be an exact
>> > multiple of the struct size.
>> >
>> > The compiler optimises pointer subtraction (end - start) using
>> > magic-number multiplication for division. This optimisation only produces
>> > correct results when the byte span is an exact multiple of the struct
>> > size. With padding, the result is garbage (e.g., -858993444 instead of
>> > 15).
>> >
>> > By using __aligned(1), the end marker is placed immediately after the
>> > last entry with no padding, ensuring (end - start) equals exactly (n *
>> > sizeof) where n is the number of entries.
>>
>> So I'm wondering why that is guaranteed. I mean, the linker is placing
>> these sections one after another in order
>>
>>
>>   2_foo_2_last_foo   size sizeof(struct foo), alignment max(4, alignof(struct foo))
>>   2_foo_3            size 0, alignment 4 (1 with your patch)
>>   2_bar_1            size 0, alignment CONFIG_LINKER_LIST_ALIGN
>>   2_bar_2_first_bar  size sizeof(struct bar), alignment max(4, alignof(struct bar))
>>
>> So clearly the end of last_foo does have 4-byte alignment, yet it is
>> observed that the linker sometimes makes 2_foo_3's address coincide with
>> 2_bar_1's address?
>>
>> What I don't understand is that it seems that the linker could place the
>> zero-size object 2_foo_3 at any 4-byte aligned address between the end
>> of 2_foo_2_last_foo and 2_bar_1. And the same seems to be true when one
>> changes it to have even smaller alignment requirement.
>>
>> So why does an align(1) stop the linker from placing that 0-size section
>> at the same address as 2_bar_1, or even force it (as we need) to put it
>> at the first possible address, i.e. immediately after last_foo?
>
> My commit message was a bit confusing - alignment of symbol is not
> based on what follows an item, just on the item itself (despite
> appearances to the contrary).
>
> My understanding of this is that the linker processes input sections
> sequentially within the SORT(_u_boot_list*) output section, placing
> each at the first address that satisfies its alignment. So the
> location counter advances forward only by the minimum needed. But this
> isn't specific to alignment 1.
>
> I've used __aligned(1) in order to make it clear we don't want any
> alignment. In all current cases, __aligned(4) would be OK too since
> the structs we use are always 4-byte-aligned. We just want the end
> marker to go at the current location-counter, i.e. immediately after
> the last entry. I suppose another way of saying this is that we want
> the end marker to be a 'multiple of the struct size' higher than the
> start marker.
>
> With ll_end_decl() using __aligned(CONFIG_LINKER_LIST_ALIGN), the
> result depends on the struct size and the number of items in the list.
> On sandbox the value is 32. If the last entry ends at, say, 0x103c
> (4-byte aligned but not 32-byte aligned), the linker must advance to
> 0x1040 to place the end marker. So then there is a 4-byte gap, i.e.
> (end - start) not a multiple of sizeof(struct), and the compiler's
> magic-number division optimisation fails.

OK, yes, I agree that the proper thing to use for the end markers is
aligned(1). But I can't help but feel that this problem is somewhat
self-inflicted; I still don't understand the rationale for
CONFIG_LINKER_LIST_ALIGN, even if I've read 0b2fa98aa5 multiple
times.

The ELF format includes an alignment field for sections, so if gcc emits
a symbol to some section which requires 16 byte alignment, that section
should get an alignment requirement of 16 bytes. So I guess what I don't
understand is how gcc can end up emitting a section containing a "struct
driver" in one TU with an alignment of 16 bytes, while another TU
contains a section with a "struct driver" that only requires 8 byte
alignment.

So yes, this commit improves things, and you can take my Ack, but I'd
like to have some very concrete examples of a set of complete TUs (not
just single lines) and compiler invocations that exhibit some of the
problems that this is all about. Because I'd really like to look at the
intermediate .o files and see what's going on.

Rasmus
