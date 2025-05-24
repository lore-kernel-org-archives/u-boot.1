Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0D8C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 07:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD5B483409;
	Sat, 24 May 2025 09:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kxn3kSxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5199983416; Sat, 24 May 2025 09:51:58 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD6683327
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 09:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad564b7aea9so314504866b.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748073115; x=1748677915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sYGn/DGvyJ+SdjyF/rkzuhyJE3yxIXlSJWlcO5hDXac=;
 b=Kxn3kSxAq1mn6JDT5k8HzdOOPUZ/qbudEQQUGGi2WR9dshIWCLc1UA25dZl4qFLONc
 AFmolUFwseLNjij8hudw1Ty7UIP0MdlH957KPa73/FUbdA2xOzSloSMwhTuaccgVI112
 cIVS2f3Y5RZ18vL7g4YWqqPrEe7joepiaCWOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748073115; x=1748677915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sYGn/DGvyJ+SdjyF/rkzuhyJE3yxIXlSJWlcO5hDXac=;
 b=JQqJfWqJxSBqLNK8SpcMRMOQIJtz/jdzPHmmZER1/7jkRD1sE1Cv0ek9ooLhwByPJV
 wL0d815mo2DR+lDhJb/YjvYN+EMBzMqeZ0xEi/hERdgN9DiHEJ3DmIi3upmJDFXJsVZz
 PNFA4To3omIFpN8ARsoeZdBUlqqGQYLHcCxP5GAzuT0Jub0CQEdiGz/I51ak+iE36+y8
 /ym1Hru7Jl1j1oRfiftxHADHCpmwsnrB5lYiScdIZMRhFqaShVaIjAJs+minNUAZOCaU
 KK+f8e/DcXQLJ2hbo9G4UM6MBF8XaBzE16eoD7nistAjzHgifJGEtz78jzgUfQKBfLa2
 W/Ug==
X-Gm-Message-State: AOJu0YwzaIVZVfYPSgMNfcNtdzw3WMPj1oNAxYFANX/SQIbJ+e6h9LwE
 Copfh8gKNsmdSrLcmchu2X3DEGhuQjKatGyf5WnXPEUQn4FsixpTK75fbFLSifXBtj0Su4bm3ep
 kxtzYM7GcU/RSzSItCMPU+cBZV/ipQPBrEzg5SRtTkAe+8ViZoyKZV63THts=
X-Gm-Gg: ASbGncufKzt/8HYgxMhds2EqZPIyjn/U4A8xfu4MDrg+2EXBeAtXRhqaYcbpFnFSatI
 B9t6813oMGXAzXkzjTiEeVKHltvEmGbAvnVIG1/NXHiGWyUjeKR1LQAJT+2kMq9H2LLcsh6QFLk
 diYnE0FdF1zCIxYQvFn+bL0Z1Dy01d6OE=
X-Google-Smtp-Source: AGHT+IEGEK3RQbU/wMxdp5dsg3M1ZQrcDap1U4UqBjddPo0O9JIU33W6e02ZNd+BvW9NllC7TVLdx910u2Py0aHIzBU=
X-Received: by 2002:a17:907:3e1c:b0:ac7:81b0:62c9 with SMTP id
 a640c23a62f3a-ad8599eacf9mr173283366b.20.1748073115311; Sat, 24 May 2025
 00:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-2-sjg@chromium.org>
 <20250505203810.GM5430@bill-the-cat>
 <CAFLszTgw6pP7SgRp=C-skUeA_cOhEfoVXD+YNKE9jP8vj0UPXw@mail.gmail.com>
 <20250506194817.GH5430@bill-the-cat>
 <CAFLszTiiM1e_MQHiArK5sRrL-8gpg+DEDg6rs4ONJmz8V8mfug@mail.gmail.com>
 <20250512223540.GU603748@bill-the-cat>
 <CAFLszTiUKyOhGxfEOm8Bj-LvqT=L35Sxa0gprRhA-BE9xsLZaw@mail.gmail.com>
In-Reply-To: <CAFLszTiUKyOhGxfEOm8Bj-LvqT=L35Sxa0gprRhA-BE9xsLZaw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 May 2025 08:51:43 +0100
X-Gm-Features: AX0GCFvDNQnfk3D3IqP-ihNiO_p9J_Vdiqzevo3jaEISITXwOWdF7w-5Zv07OYc
Message-ID: <CAFLszTgSFoAda_arLJqhojHi=BmODHB7cgOaWcvKJKJEmgvo4g@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] abuf: Add a helper for initing and allocating a
 buffer
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Wed, 14 May 2025 at 20:44, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 13 May 2025 at 00:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 10, 2025 at 01:27:03PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 6 May 2025 at 21:48, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, May 06, 2025 at 03:23:39PM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 5 May 2025 at 22:38, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, May 01, 2025 at 07:37:01AM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > This construct appears in various places. Reduce code size by adding a
> > > > > > > function for it.
> > > > > > >
> > > > > > > It inits the abuf, then allocates it to the requested size.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Add new patch with a helper for initing and allocating a buffer
> > > > > > >
> > > > > > >  boot/cedit.c          |  3 +--
> > > > > > >  boot/scene.c          |  3 +--
> > > > > > >  boot/scene_textline.c |  3 +--
> > > > > > >  include/abuf.h        | 11 +++++++++++
> > > > > > >  lib/abuf.c            |  9 +++++++++
> > > > > > >  lib/of_live.c         |  3 +--
> > > > > > >  test/lib/abuf.c       | 22 ++++++++++++++++++++++
> > > > > > >  7 files changed, 46 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > This just made me look again at the abuf implementation itself and
> > > > > > become filled with regret I didn't reject it back in 2021. We're
> > > > > > introducing wrappers around standard functions and calling conventions /
> > > > > > patterns with something homegrown (and so not intuitive to others) that
> > > > > > mainly hides the "sysmem" challenge we also have  and I wish you were
> > > > > > interested in revisiting how that part of sandbox works instead. And
> > > > > > even if this is a better design, for the sake of argument, it's not
> > > > > > something everyone else is used to. And that's important.
> > > > > >
> > > > > > If we *really* need something different / new here, I'd rather see us go
> > > > > > and wrap common/dlmalloc.c with kmalloc/kfree/etc and so give people
> > > > > > something even more familiar-looking.
> > > > >
> > > > > The purpose of abuf is actually not about hiding sysmem - you can see
> > > > > that if you look at lib/abuf.c and the tests. It provides an easy way
> > > > > to manage buffers, which we do a lot in U-Boot, particularly with
> > > > > standard boot. It deals with whether the buffer is allocated or not,
> > > > > so freeing is easy. With expo I want to be able to manage a buffer
> > > > > containing an autoboot string in high-level code, say, without
> > > > > worrying whether it has to be realloced.
> > > >
> > > > It's a wrapper around free/malloc/et al, which then also includes the
> > > > sandbox-specific requirement of *sysmap* stuff. This is best shown by
> > > > the next two patches which convert from standard malloc/free patterns
> > > > (which both humans and analysis checkers are fond of) to a home grown
> > > > invention.
> > >
> > > Yes, although I should point out that most of my code is a home-grown
> > > invention, if by that you mean it wasn't invented by someone else and
> > > then posted by me as if it were my own invention.
> >
> > Well, I'm referring to the cases where solutions to the problems exist,
> > but you're inventing a new one instead.
> >
> > > > > For sysmem, I don't see a viable alternative, which keeps can reliably
> > > > > keep addresses consistent across multiple phases (e.g. sandbox_vpl).
> > > > > Also, I don't believe addresses like 0x7ffff7fbc000 are
> > > > > human-friendly, yet that is what we would see in tests if we dropped
> > > > > the mapping. The point of sandbox is to test U-Boot, not expose the
> > > > > system internals. But we could discuss it if you like?
> > > >
> > > > I'm not sure how this is relevant to the general high level point of
> > > > "sandbox should be able to, in 2025, be designed so that special macros
> > > > do not need to be everywhere for the sanity checking it can do to
> > > > happen". If my web browser is going to suck up 11GiB of memory all the
> > > > time I can live with sandbox using 1/2/4/whatever GiB of memory when it
> > > > runs. The "this is not a pointer" problem sandbox can solve could be
> > > > done differently these days.
> > >
> > > The special macros have several purposes:
> > > 1. Allow sandbox to have a contiguous region of memory at address 0,
> > > while the pointers are wherever the RAM buffer happens to end up
> > > 2. Provide an indication of whether code has been converted to sandbox
> > > yet, or not
> > > 3. Provide a way to mark all casts to/from address/pointers so it is
> > > clear that the cast is intentional
> > > 4. Ensure that sandbox seg-faults if a bad pointer is used
> > >
> > > You seemed quite happy about it until my EFI test was rejected.
> >
> > No, I've never really been happy with the macros and never understood
> > why we couldn't do the useful sanity checking wholly under arch/sandbox/
> >
> > > > > In general I am sensing that there are a lot of things which bug you
> > > > > about the direction of U-Boot. and that you feel very differently
> > > > > about some things than you did in 2021. I have quite a few concerns
> > > > > too. So how about we make time to discuss these and see if we can get
> > > > > on the same page, at least somewhat?
> > > >
> > > > Yes, we've had numerous long threads, and a few calls. You are then
> > > > unhappy with what I say I want to see done, want me to just take your
> > > > changes instead and "Say Yes" more. I wonder if I had said No, or gather
> > > > more feedback from potential users, or just slow down, more back in 2021
> > > > if we would not be in a different position here.
> > >
> > > I wonder if you had said yes more, if we might have got standard boot
> > > done a few years earlier and would not be stuck now on EFI bootmgr.
> >
> > No, we probably would have just had more developers leave as I overrode
> > their objections.
> >
> > > > > Coming back to this patch though, this is really about a code-side
> > > > > win, rather than anything else.
> > > >
> > > > No, it's about how similar to the "log a message and return" convention
> > > > change you wanted to make and then dropped, how I do not see good value
> > > > in changing from standard convention of malloc/free to abuf being a win.
> > > > Maybe this is a case where borrowing the kernel's mempool logic would be
> > > > a win instead? Because another part of this is that we want to avoid
> > > > making up our own APIs for things if we can instead borrow something
> > > > from the kernel, where most of the rest of the community will already be
> > > > familiar.
> > >
> > > mempool is actually lmb, as I understand it. We haven't done that
> > > rename. It allocates from a region of pre-allocated memory. It doesn't
> > > use malloc(). So to me, that is quite different.
> >
> > Then we should probably just drop the abuf thing and use standard
> > conventions that developers are used to.
>
> No, abuf is a valuable abstraction which makes it easier to avoid
> alloc/free errors, size errors, etc. Python has bytes, C++ has
> std::byte. Linux has sk_buff which is a bit like membuf. Perhaps Linux
> would benefit from abuf but its memory model and usage is quite a bit
> different, so I'm not sure.

This series seems to be blocked on a desire to remove abuf from
U-Boot. Other than that I have a minor comment to resolve on the new
'bootdev order' command. So I sent a patch for that.

Regards,
Simon
