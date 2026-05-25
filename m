Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B769DCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E2A884866;
	Mon, 25 May 2026 16:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LimBQ7OX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1629F8486A; Mon, 25 May 2026 16:29:14 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E651884841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6896c80480cso1989774a12.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779719351; cv=none;
 d=google.com; s=arc-20240605;
 b=DKBv/cml8AHzomvgPBNM/I1KwmaXgY/lePdThf6Am9eo2F9wooALhDB67LnTb6Ml/V
 tFz9O59lzHHz3RpQimI+wUl2ga4NNzASqB0Zj1w6rbJPlMD2DQLiPHekjQ5BeCXsB0OW
 0Y1M5pdEy00LttvnhKZzV6Wl1Ohw/CrbevjX5ggN2aqooihZ/E9sJT6pbOkDWLGvwHPz
 WF/eh5ZgV4vf00d9O9LI4Z31nJon/CS7h+MXYDoxX9zBAnyaxhMQ0jtfaZxV4TyM9MXM
 pQDRjIfFYHXZeX3eiepmywWHX5ed4R1NOshhInp2lamh/Bb6A9bPsj1NsU9vnSOysq+T
 hhag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BjD5tt/KG926j3B7zaTcR6Isya686w7UUquGhMnMt5g=;
 fh=uEwfVtgWmQ+BpqL3MMm4A4agCJ5OLHBunogpqm9TwOU=;
 b=BE1JXHyGYzV4GJPlGwSXrNJ2G7l0HLNxZibIkcCh7P6meHGmgkQy/blfyrikO7B/cj
 XlnUNJib8FLMmbMLxnSAawJKLAKGIi917Qz2wLNyY9t04sxbwzqyi0ub2w8kMAlBpU3D
 ZTP0NHL0p7U03UtU340jhinyOFfonoew/RqTAUB/2YOCbz08Zh5lD0mGPd3K9kFRHV5t
 02/sF/E3GM7fYY+n/x8rBuFM9qJ4t3QFPCwaLuDbCUbHbSJ9tboQcKl+OND8C+DNOamT
 TwDOUy89o8xOplobGFpHbRBXOs5qk2yZpWQj1y/tYnzymlz3iHbvYkJr4RuWZjOYzRZQ
 6fzA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779719351; x=1780324151; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjD5tt/KG926j3B7zaTcR6Isya686w7UUquGhMnMt5g=;
 b=LimBQ7OXTmuiX0XX1zgD1dvU85GXdSI9Hn2eujy3Qi9myoHQH1iV0sI688EUEY080x
 nD+nIBBB9wZBAVnvJcNCXR6GKIwXPXBwSNrbuhRQZuKTSSapaun0fuATwAoOV1Kv4npb
 KLbfwR40ySgr4PcWXqDGoQaEl+WaGeiMlfCT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779719351; x=1780324151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BjD5tt/KG926j3B7zaTcR6Isya686w7UUquGhMnMt5g=;
 b=mqMfRTdFw+43n3tv4zuCo0ihmx1CgGnGUl3ow2dWo9fZC4JmSQmh2NZBVZjI/0GNE8
 3Q5IPipSUvW4/plcWJbKLRkZMSCshl+e8+Eq8nYswtWP4PQPqNxHvZd00hAzw8Q9FNoK
 wrwEDr2rIL4hcsBPXRNfOg5lcuuKQq0STDxTZK/AMgR3Yd74QHEYU8Nrk2BZkkRMkGTn
 8ZkDO8jAAc6u3Yc3h/YZJztNvFDW3tkYooy+4+ZdsSGaRyxT3pgpIwJb0WW1Gv10RLSI
 kz8ihOyemXm21yjaOvLDRlGbDBZdJnVgTmdLkLahZd+X6MfvKQRmW7HdhBojRfTOv9kB
 MBpQ==
X-Gm-Message-State: AOJu0YyySMcnSoPTIXyvwtVJYo0xVIjlo3IlBCLkawjzBjGfiGKjnkg7
 tbd2xwi3Xf6jS3gKcEbrnFAOBj+cBKY4bD11HorO1xSGreOdMg7cUtKP8a8x3brIqNPHSVoqSGj
 xzgIaM+NifEs1DJN85ZzDeBHGph6CY6IviEyXEM44
X-Gm-Gg: Acq92OH5rnZHqOLpmvTWPlOcAL5Q2X73p1G//5KI+wFdfywnOh+noDUbw6cPhfkrlxy
 fqIaAC+DKIJLLcbzYB/hFOC+byMTI5MRH4cG3Dv+XzAM/EWEsVEf9ndbNblw/UQ0Tw2uYo7D1am
 wrGqnB37vCVPG9LTobPQRKKeCMfrZ9Xg1U9qILQv0fREb/N3ATo/2Ja0UMcEGyK2nvZ5grzK1pi
 X6wZThQzhD+JpolQewB2/qKBRtekNEsti5Vaw8KdG9WjwQVNPfkyi/zDQnDwjmra5XxefbctmGs
 8sJXKOFnaTAx8sLd
X-Received: by 2002:a17:906:8455:b0:bda:25eb:1893 with SMTP id
 a640c23a62f3a-bdd237f21bemr550790866b.20.1779719351172; Mon, 25 May 2026
 07:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-9-ravi@prevas.dk>
In-Reply-To: <20260522212756.3169222-9-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 08:28:59 -0600
X-Gm-Features: AVHnY4IfWcwGR6276af0Lzhs3_W1B3hCUC93k9L_hwfE7w6Gbve9aC5Am-qHumk
Message-ID: <CAFLszTh61_1vQ3bG29H5xVkrcLTc_meji7nqhqSK+8poHwECnQ@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] linker_lists.h: emit lots of meta-data for
 debugging and sanity checking
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Rasmus,

On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> linker_lists.h: emit lots of meta-data for debugging and sanity checking
>
> This is an attempt at to make it possible to catch various problems
> with linker lists at build time, without affecting the size of the
> final binary. Also, I did not want to have to modify all the linker
> scripts in order to not get all this meta-data thrown away by garbage
> collection.
>
> The basic trick is that one can use the .size assembly directive so
> set the st_size of an ELF symbol, without that symbol actually
> occupying that amount of space in any section or the final binary. And
> all of the .size, .type, .{push,pop}section directives are completely
> generic, so this should work for all architecture.
>
> So whenever we declare a start or end symbol for use by C code, also
> emit information about the size and alignment of the type that the
> list is supposed to be made of.
>
> A relatively straight-forward script (next patch) can then parse the
> ELF file and report on any inconsistencies. For example, suppose two
> [...]
>
> include/linker_lists.h | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

I see this:

test/cmd_ut.c:67:1: note: in expansion of macro =E2=80=98SUITE_DECL=E2=80=
=99
   67 | SUITE_DECL(mbr);
      | ^~~~~~~~~~
include/linker_lists.h:45:17: error: expected =E2=80=98)=E2=80=99 before =
=E2=80=98:=E2=80=99 token
   45 |                 : : "i"(sizeof(_type)), "i"(__alignof__(_type)))
      |                 ^
include/linker_lists.h:48:9: note: in expansion of macro =E2=80=98ll_emit_t=
ype_info=E2=80=99
   48 |         ll_emit_type_info(_list, _type);
         \
      |         ^~~~~~~~~~~~~~~~~
include/linker_lists.h:297:9: note: in expansion of macro =E2=80=98ll_emit_=
start_symbol=E2=80=99
  297 |         ll_emit_start_symbol(_list, _type);
         \
      |         ^~~~~~~~~~~~~~~~~~~~

See below

> diff --git a/include/linker_lists.h b/include/linker_lists.h
> @@ -23,7 +24,45 @@
> +#define ll_emit_type_info(_list, _type) \
> +     __asm__(                                                \
> +             ".pushsection "ll_info_section_name(_list)',\'aw\'\n'   \
> +             ".type "ll_size_symbol_name(_list)", STT_OBJECT\n"      \
> +             ".size "ll_size_symbol_name(_list)", %c0\n"             \
> +             ".type "ll_align_symbol_name(_list)", STT_OBJECT\n"     \
> +             ".size "ll_align_symbol_name(_list)", %c1\n"            \
> +             ll_size_symbol_name(_list)':\n'                         \
> +             ll_align_symbol_name(_list)':\n'                        \
> +             '.popsection\n'                                         \
> +             : : 'i'(sizeof(_type)), 'i'(__alignof__(_type)))

This is extended asm (it has operand constraints), so GCC requires it
to be inside a function. ll_start_decl()/ll_end_decl() pull this into
ll_emit_start_symbol/ll_emit_end_symbol at file scope - see
SUITE_DECL() in test/cmd_ut.c

One way out is to drop the operands and have the C side emit a
zero-initialised marker object whose array dimensions encode
sizeof/__alignof__ - e.g. a static struct in a dedicated section whose
two members are sized sizeof(_type) and __alignof__(_type). That costs
a few bytes per list per TU but keeps the trick working at file scope.

> diff --git a/include/linker_lists.h b/include/linker_lists.h
> @@ -23,7 +24,45 @@
> +#define ll_emit_start_symbol(_list, _type)                           \
> +     ll_emit_type_info(_list, _type);                                \
> +     __asm__(                                                        \
> +             ".pushsection "ll_start_section_name(_list)',\'aw\'\n'  \
> +             ".type "__stringify(ll_start_symbol_name(_list))", STT_OBJE=
CT\n" \
> +             ".size "__stringify(ll_start_symbol_name(_list))", 0\n" \
> +             __stringify(ll_start_symbol_name(_list))':\n'           \
> +             '.popsection\n'                                         \
> +             )

These multi-statement macros are not wrapped, so they only work in
contexts that accept two declarations/statements separated by ';'.
ll_start_decl() then chains another declaration after them, leaving a
stray ';' at file scope - accepted as a GCC extension but rejected
under -Wpedantic. Please either fold the two asm blocks into one (a
single .pushsection ... .popsection can contain all the
.type/.size/label directives), or wrap them in a way that gives a
single declaration/statement. The latter is awkward at file scope,
which is another argument for the single-asm approach.

> diff --git a/include/linker_lists.h b/include/linker_lists.h
> @@ -23,7 +24,45 @@
> +#define ll_info_section_name(_list)         '__u_boot_list_'#_list'_0'

Worth mentioning in the commit message that this is matched by the
existing KEEP(*(SORT(__u_boot_list*))) globs in all the linker
scripts, so the new _0 sections end up in the linker_list region of
the final image. Since each section is zero bytes that does not affect
binary size, but it does mean the metadata is reachable from the ELF
symtab without changing any board's linker script - which is exactly
what you say you wanted.

> diff --git a/include/linker_lists.h b/include/linker_lists.h
> @@ -23,7 +24,45 @@
> +#define ll_info_section_name(_list)         '__u_boot_list_'#_list'_0'
> +#define ll_size_symbol_name(_list)          '_u_boot_list_'#_list'_0_ite=
m_size'
> +#define ll_align_symbol_name(_list)         '_u_boot_list_'#_list'_0_ite=
m_align'

The size/align symbols are emitted as local labels, so every TU that
touches a given list contributes its own local copy. That is fine for
the parser in patch 9, but it relies on strip/objcopy not throwing
away local symbols on the way to the final image. A note about this -
or about pointing the script at u-boot (the unstripped ELF) rather
than u-boot.bin - would help anyone trying this themselves.

> diff --git a/include/linker_lists.h b/include/linker_lists.h
> @@ -128,6 +167,7 @@
>  #define ll_entry_start(_type, _list)                                 \
>  ({                                                                   \
> +     ll_emit_start_symbol(_list, _type);                             \
>       static char start[0] __aligned(CONFIG_LINKER_LIST_ALIGN)        \
>               __section(ll_start_section_name(_list));                \

Just to check: is there any reason ll_entry_start() emits the metadata
at every call site rather than only where the start/end markers are
first defined? Within a given TU every call expands to the same
.size/.type for the same symbol, which the assembler tolerates but is
wasted work. If you can move it into the declarations themselves (or
use a once-per-TU guard) the diff for existing call sites stays the
same and the assembler output gets much smaller.

Regards,
Simon
