Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B4BCD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D3B8063E;
	Fri, 12 Jun 2026 20:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XPiqieSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4873784877; Fri, 12 Jun 2026 20:25:40 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A529B8056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6913fb25322so1611655a12.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288737; cv=none;
 d=google.com; s=arc-20240605;
 b=ZuaSGh++NLNiRn4gwxrsiB1oGRD6qAGVdJcPVQkjjJyMmZ9xIzaYOrcgSmfBRhy64s
 BGhzqvyOceHuqDug2emiEKTz8KClY3RMRq+HPFO0eOYhsQ3Cx+tkgAMAhsAE1mg4Dr2w
 pEKphCmR644mKGwFh7W346ExTuWir07TuiLaBhZw33Nx8bSrOxYmzOhQOcoPELZgnSJb
 I/ZEBaOCSokdurvFLOLTHxkHks6YTV2Svcsw0qMZcXEKv5e37yY21XtENxbCMgxk2q0D
 +Va24HT04ltebOIOyFNpapmccxJ8NFEPC57d5aNz153LRYyp8/ZIaWjhykelJRN95OGA
 AxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iZT6UYFXAvKnobwR1Vj58dhaC5p56zXq8sNdnfRbCn0=;
 fh=EMfPPTq3v5RZ0lZKVhTPXVKRoHOlClJSp2YUV93+qls=;
 b=aycQ7L2EVcHX4KEIWPHaE4qMwHzhWQi26B6SWh2yUH81Ey8/ROuzTv2O4+4xbK6m36
 GBDGafaAj4VyljegnhFpiDQeowonroHDr7d5TZHEULdPACChgXOMESjJVnJD6Ia38jLo
 jSAXDr3Y+/Adyn3wa7Z7645EYOXX4l62EHgqN+n1AQiAoElLKcxSk87CppJow+lNIAwS
 axC5k4w3Heq2k2Nrdy1PHOQE4wbsgQ0L+JeupsFWaUY9WC4zPRdzYnKt+Pd5qiebWD27
 XNW2Yw77goDN0srB7Up+U83Vw4mlKlErgoN9X5PeOSokypa0bgsIyuMgLrCq9sIFeLos
 W5Kw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288737; x=1781893537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iZT6UYFXAvKnobwR1Vj58dhaC5p56zXq8sNdnfRbCn0=;
 b=XPiqieSzkq+LdPoe/zHUXuJa/bHNZZGs8ZzFWIHkQGtdODPwDK1Bb6iEBdQeoMLcRp
 jKS5BMr5EWBTGDTKtFWxTHH54UU072mF2MJcWRTXlXykfodjZAOGDvFc6oQ6fbN3I7PL
 sCf8xE1JdKdByGHVeCRrNQGcRzaZTj9GbTvhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288737; x=1781893537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZT6UYFXAvKnobwR1Vj58dhaC5p56zXq8sNdnfRbCn0=;
 b=s2+4f4r6a+4QI+fwZzR8egFaGFcUlAAoUsCb43JeIB/M/RpvTjnExueiJRDzGzhITd
 Yh65WggoZVYi9/SnPP/QlL/nnnN2qKEeqCANch5dbjY8vVfk6tO68O+WYJfNUYe1xa74
 ggeZVMa+7oTGYZ8VgAgbzfZ1tzhsaGcqtb9iDKPV3w5XmpRvJEgLK4f3x5i7rCj4Shv0
 FzKoIeG+W+2GU0cbvDEwDOJkikYjiYXpjG64Qg3yv9NG2pWTOAYK8U5PbKAZqxjlVaFG
 0PfGfGrbTclr6fzBYa/SRyMKNQ6X26GRKfzuzQFmbxoILe3r+LsSJE6CNVrF/EAiumPJ
 iqfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pxJ7JH5KbRQZ63cNFjr5bpN1/5goXd/56Q9guziySN3TvphkFhYw8OLz1RaEYz7oVrPJ9N7o=@lists.denx.de
X-Gm-Message-State: AOJu0YxBFOgtQw+ZYcpqsq+4sIBJtWujUY/vaQYlhxM+swKt+6ulFeYN
 0applz7GvMIuQ9aQmSs6tJz+uwOOxTTBjsjbJvL+YPqSYqGC/ZJ2Vf0P2ugcKH/BNmEDAEgCiuu
 IAGO6yRB56oxg/NGh4QcHxK1KHE0Nx+ezPBPzwi24
X-Gm-Gg: Acq92OFk/94DIReJOZYJnCplaXIHdcvWDBDUZvpHImjpctnCZdjkQgcNTZrR2UFJnXY
 1ry2BB4st8LrFWyCas4tNb5Swfr7mcz3WR5KJGgcgrO0jSNrte5u5akdSqCRsrcxZgHNiAnMHjl
 WO1OITlael5DpXG5mXYevHZOvbbNa96bx61GbsstmgOI/PDahanMJzzSOhe1RJUKdw3D9LInD0r
 vuRcbaRZeR/7EzY9hA4XhBwGg95O6Q38g1wqGsTmjXoejItJX1YRy++uxeLRxEXtTqUbtSI7Cxx
 o6EWmQ==
X-Received: by 2002:a05:6402:2696:b0:692:500f:f91 with SMTP id
 4fb4d7f45d1cf-69378a03aedmr1990230a12.10.1781288736850; Fri, 12 Jun 2026
 11:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-3-ravi@prevas.dk>
 <CAFLszTgmEKG7+8RJnXbdfy67pJ3U8u15-NcmT2Y1K2L5uSt+8g@mail.gmail.com>
 <20260525152254.GM1858239@bill-the-cat>
 <CAFLszTg5QevFu2C9GvMazd4ioi9msvjiFy_rK4on_YfXHki2zw@mail.gmail.com>
 <20260525154623.GN1858239@bill-the-cat>
In-Reply-To: <20260525154623.GN1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:25:25 -0600
X-Gm-Features: AVVi8CdTD3fgy_KLUfERBvJp5YUA0hUbSXmyWyOLu0RdFRYKKP5r9FO3_TKWEK0
Message-ID: <CAFLszTgBaKkoY=2FU06r=6URZSc=fKiqZA3OLpQ-Kfj=ywG5HA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] linker_lists: Do not set "unused" attribute
To: Tom Rini <trini@konsulko.com>
Cc: ravi@prevas.dk, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Mon, 25 May 2026 at 09:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, May 25, 2026 at 09:33:24AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 25 May 2026 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, May 25, 2026 at 09:02:02AM -0600, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> > > > > linker_lists: Do not set 'unused' attribute
> > > > >
> > > > > Whenever we declare something to be in a linker list, we want it to be
> > > > > included. This is why all of our linker scripts have a line similar to:
> > > > >         KEEP(*(SORT(__u_boot_list*)));
> > > > > to ensure that any linker list found in any of the archives we are
> > > > > linking together makes it to the final object. Remove the places where
> > > > > we set an attribute saying that it is unused, or maybe_unused.
> > > > >
> > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> > > > >
> > > > > include/linker_lists.h | 9 +++------
> > > > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > >
> > > > > diff --git a/include/linker_lists.h b/include/linker_lists.h
> > > > > @@ -69,7 +69,6 @@
> > > > >  */
> > > > >  #define ll_entry_declare(_type, _name, _list)                                \
> > > > >       _type _u_boot_list_2_##_list##_2_##_name __aligned(4)           \
> > > > > -                     __attribute__((unused))                         \
> > > > >                       __section('__u_boot_list_2_'#_list'_2_'#_name)
> > > >
> > > > The commit message conflates two unrelated things:
> > > > __attribute__((unused)) and __maybe_unused are purely warning
> > > > suppressions; they do not affect whether the symbol is emitted, kept
> > > > by the linker, or seen by LTO. The thing that prevents removal is
> > > > __used (and at the linker stage, KEEP()).
> > > >
> > > > The real reason removal is safe is that none of these declarations
> > > > would have warned anyway - ll_entry_declare()/ll_entry_declare_list()
> > > > produce non-static externals (no -Wunused-variable for those),
> > > > ll_entry_start()/ll_entry_end() take the address of start[]/end[]
> > > > inside the same statement expression, and the symbols from
> > > > ll_start_decl()/ll_end_decl() are referenced by the caller (cmd_ut.c
> > > > is currently the only one). Please reword the commit message along
> > > > those lines; the KEEP() stuff belongs more naturally with patch 3.
> > >
> > > I don't think your analysis is correct. They are not unrelated things,
> > > they're very much related and were really incorrect at introduction a
> > > decade+ ago (and pre LTO) but I don't think it was worth adding a Fixes
> > > tag.
> >
> > I mean that the compiler will warn if you declare a static symbol but
> > then don't use it in the same TU (hence the need for 'unused').
> > warning != inclusion/removal. I haven't quite figured out whether
> > those warnings have gone away, or something else has changed. It will
> > be easier to see when I can build this branch.
>
> It has always been incorrect to have these, and there's no real value in
> having more commits removing incorrect code.

After more digging I see different behaviour in Clang and gcc. This is
a bit of a mess. It this patch builds without warnings then I agree we
should just go with it.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
