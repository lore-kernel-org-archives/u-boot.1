Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79893CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9012D846AA;
	Wed, 27 May 2026 06:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YNDNEJHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B9A846DE; Wed, 27 May 2026 06:09:47 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA1B846BD
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bcd3c190f71so1819558966b.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779854984; cv=none;
 d=google.com; s=arc-20240605;
 b=d3x9K3mXxz1C1SPX354Fa/2/sHFam1y06XSGt52Ymj6w1PNkKOzhsNPgErqxG/K/sR
 lL5WrWHjhas0PgdhvGhlB9wpvhnWbE03FquivGLS7XRY/vUqpBplv636yGAWydjqLe0q
 FEyvIL3R3svj9E8fWaYp2Dg8cI2Sjj0yn4/+mTpdKToaGp2c9MoRh08GsbKwfwNhSyfN
 TP3+HU9+5rHlfQIpNa68jpNBtz3wkg3KX7gEkq8OT9JQ3jwpnXSeoYbzUJGgYyHjJqDy
 Ofpk+OBZkWDuB2ZmxEOSxdKPqxk5LAAcPAknBjfI4arFtbe2FOaRu9jVJo4/ANOVNJyo
 uwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uIW43xXiCusdyJiywSQUsCjkOSK14ZFSsd/tqDdNuOs=;
 fh=77GWSjT2mlmLf3PtBjW8TPqEIXbpJQfI8TB2+BGo2u8=;
 b=PlSDol6rQrzXsumZc8z27YMWq3zLe5ADES1aA2C3hYXwLbzn0ALsYpgIW89AR4tzxW
 09NIgFSkDmvU6xxE039xBdXxdg+Kj1aYi1Zsm+teZvcVsdveY2jj/u+ygDkoR83kWiDM
 34sOnz5akJ8e3HLgum4j4QYpBMZBLJ6hRKhQ2MKnWavOKSw2gxrwdVO+ucZ7/mSB45O2
 8iyadUmdnxqrcd+FywocMS9tTw/InruegwCCMwjodVYXg911F918rWgEnwrDiIunVtfu
 InVA4QrIDVkxHNfGpackAdp0MnI+LskgOW0jc5k2pPiGG2nZoJPAUjqoSbbxpatTEaIK
 tyyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779854984; x=1780459784; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIW43xXiCusdyJiywSQUsCjkOSK14ZFSsd/tqDdNuOs=;
 b=YNDNEJHqf9EJX0I5QDv87fXDWdJsIFbAgmshTiO1SGeI8qogNqcDbIEjVUU/6rb0oi
 uq+vPlfrlfBJVUpbT8s7K0ZVGi+YBXyR4QDPXNJD2mGPhPLGTlXtUv+jjUmLvrStRmWZ
 MyQ1erkd877R162kizCQJ8JtTUrMZ5Ai366Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779854984; x=1780459784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uIW43xXiCusdyJiywSQUsCjkOSK14ZFSsd/tqDdNuOs=;
 b=GyF9lB4ToSEpEdoi+ZoDOFEbw0fn8GKjPGaS5rf1uK0DEoBgoulH7ng/MBJWYJwCjh
 hE+aMPgjjW13fMXlR1Fn0USWzTWtyPRIFSd/XVDiOAVD2MXqj6BSwvuc+4PxZw5bbiA9
 Uj4YcO1LNonP3f/EVzY9v68EM8KZ3M+PAMoLM55uiwoq3eNlrhJfivJiRfbUwc0a2g9+
 hyiQhjkeFGcLblzTTo7l9UzrtBrmNv8yELgPw+fut2ZlyoIE8t7EzrXos11aiIldxsfq
 gPD0bFMBA6OfiUGi7JUIGEwuJT/OkA8EVmjfDiDxzzkbk60ptC+BXwqilL6WFkON+x5g
 fDtw==
X-Gm-Message-State: AOJu0YwJyRb5qYRTdjAs3qDOq7NZLSIuJevD+/E04fz0kEpy9gjHlODN
 rsvZJzq1YkKaPvTTiV+5BxtGHs1D+UYARA4+a5iJF+T/hX5q4xHi3y28ua0442W7qKRecf7ye0P
 f+rxnuapXuvvUg5hUcakzoIjCc1Enp3WdyOGG1PaJHxFJ4IJxPqE1xLCiKgHx7w==
X-Gm-Gg: Acq92OHarbPKcVFpoY/X8f/v4/dhC4UsZ7nfBnYrxQIr+FqEG5XCzDaA7kNAJ6zdhbM
 bDUN9s7IbG/R6uTs/SwungwKrGEK+Mk/o9bmFKIbx6MwmYw0ci3qku4DRnfjDL98uXv19l5IaWb
 xixAbyPBcW3gySDtr8LwIbpTi+h6VxY3IORHRCHNo+ocvkBlYyj3OKaT/O6lUVYhoHBI3/uIEii
 wtOBH/gfWPt1r2oku5pFsvtbp/JcrHhHmOAjD/fXDG7anNWgXFcEZxVa2acKeJXd2andJ0PpZKU
 9lcphw==
X-Received: by 2002:a17:906:8474:b0:bda:8e57:5639 with SMTP id
 a640c23a62f3a-bdd25337f07mr958778666b.20.1779854984368; Tue, 26 May 2026
 21:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-9-ravi@prevas.dk>
 <CAFLszTh61_1vQ3bG29H5xVkrcLTc_meji7nqhqSK+8poHwECnQ@mail.gmail.com>
 <87v7c9erip.fsf@prevas.dk> <87qzmxequu.fsf@prevas.dk>
In-Reply-To: <87qzmxequu.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:09:33 -0500
X-Gm-Features: AVHnY4KfTwEB2voJsgJUb_0Y8qB1MWfWt1TsEYG-vWfc6iGpzyKhd4TuebN2Jqw
Message-ID: <CAFLszTj0pW1GDSy5QsR+3+Z113iXApa2i7f8r3v2mHZHWB_41Q@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] linker_lists.h: emit lots of meta-data for
 debugging and sanity checking
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, 26 May 2026 at 16:41, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Wed, May 27 2026, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> > On Mon, May 25 2026, Simon Glass <sjg@chromium.org> wrote:
> >
> >
> >>> diff --git a/include/linker_lists.h b/include/linker_lists.h
> >>> @@ -23,7 +24,45 @@
> >>> +#define ll_emit_type_info(_list, _type) \
> >>> +     __asm__(                                                \
> >>> +             ".pushsection "ll_info_section_name(_list)',\'aw\'\n'  =
 \
> >>> +             ".type "ll_size_symbol_name(_list)", STT_OBJECT\n"     =
 \
> >>> +             ".size "ll_size_symbol_name(_list)", %c0\n"            =
 \
> >>> +             ".type "ll_align_symbol_name(_list)", STT_OBJECT\n"    =
 \
> >>> +             ".size "ll_align_symbol_name(_list)", %c1\n"           =
 \
> >>> +             ll_size_symbol_name(_list)':\n'                        =
 \
> >>> +             ll_align_symbol_name(_list)':\n'                       =
 \
> >>> +             '.popsection\n'                                        =
 \
> >>> +             : : 'i'(sizeof(_type)), 'i'(__alignof__(_type)))
> >>
> >> This is extended asm (it has operand constraints), so GCC requires it
> >> to be inside a function.
> >
> > Not exactly. My 'info gcc' has this to say:
> >
> >   Similarly to basic =E2=80=98asm=E2=80=99, extended =E2=80=98asm=E2=80=
=99 statements may be used both
> >   inside a C function or at file scope ("top-level"), where you can use
> >   this technique to emit assembler directives, define assembly language
> >   macros that can be invoked elsewhere in the file, or write entire
> >   functions in assembly language.  Extended =E2=80=98asm=E2=80=99 state=
ments outside of
> >   functions may not use any qualifiers, may not specify clobbers, may
> >   not use =E2=80=98%=E2=80=99, =E2=80=98+=E2=80=99 or =E2=80=98&=E2=80=
=99 modifiers in constraints and can only use
> >   constraints which don't allow using any register.
> >
> > and since the only constraints I use are those that provide an immediat=
e
> > to the asm, that should be ok (and WorksForMe).
>
> Ah, that's actually new in gcc 15 (I'm using gcc
> 16). https://gcc.gnu.org/gcc-15/changes.html says
>
>   Extended inline assembler statements can now be used with some
>   limitations outside of functions as well.
>
> and explicitly calls out
>
>   "i" (sizeof (struct S))); /* It is possible to pass constants to toplev=
el asm.  */

Oh OK, actually I am still using gcc 14 locally. It didn't occur to me
that something like this would change in the toolchain! Presumably
clang already has this ability?

>
> >> ll_start_decl()/ll_end_decl() pull this into
> >> ll_emit_start_symbol/ll_emit_end_symbol at file scope - see
> >> SUITE_DECL() in test/cmd_ut.c
> >>
> >> One way out is to drop the operands and have the C side emit a
> >> zero-initialised marker object whose array dimensions encode
> >> sizeof/__alignof__ - e.g. a static struct in a dedicated section whose
> >> two members are sized sizeof(_type) and __alignof__(_type). That costs
> >> a few bytes per list per TU but keeps the trick working at file scope.
>
> Yes, but this is the kind of growth that I wanted to avoid. And if I put
> those marker objects in a section of their own, I'll have to modify each
> and every linker script to preserve that to the u-boot binary, but
> ensure that the objcopy step throws it away.
>
> I'll think about this some more.

Also check my RFC which attempts to do this checking with no changes
to linker lists. It certainly found problems but I suspect your
approach is more powerful and will find more?

Regards,
Simon
