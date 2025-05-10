Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B71AC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9719A82952;
	Sat, 10 May 2025 13:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ig0KglDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF6BD829CD; Sat, 10 May 2025 13:27:17 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28BE82952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5fcab0243b5so2185721a12.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876435; x=1747481235; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q87rx4XDsY7PK8bBllyTTjJyw0+eLtWmjFjGX59+1FU=;
 b=ig0KglDoQSnWtINrckx+vMZYq9GzyP8hmcErq+3Rj/6GKh+aoyHo66/GDDEwvGILjh
 pLjwNPrWGUC+OPph60d1DK2n9EqMkbgr+w0JWh6LusCj2Qtttwv7NR3uwozQUYBXPfIU
 0PVq7zhWsOYNfatDoxRaoX17WZcMU6T0nqyoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876435; x=1747481235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q87rx4XDsY7PK8bBllyTTjJyw0+eLtWmjFjGX59+1FU=;
 b=a6TovDAgneC6ozk5dPPBO4MzZ0TecWS1Z7NpbVUvtbUnhluxr64EIkUSS2QiNIkQsu
 KbzYnfvB6e72Q87OT3IlXSbbGBkKKF9wDHMTPwrB7kqiJyRnas+JSshjHiWewM3DTklg
 dhciKGbMrGvYzptbJIjT1BV0qMgkBi2Bd7km7hMaxzo8HKkbskQlNMjbOaKXZjlT5rCv
 F+T9mHFZmG07UjHkDw2fVfQHIaXtslMf1tiUKg/JvhnSq4Vc/MnkZLja6HU3zCWcWd8+
 2LJgm3x/z4lS29jDLrL6EVMpPWbV7NOqvrAUGQte1+TC5t3p0hUiP6I+z990yoz5Pkkl
 eKrg==
X-Gm-Message-State: AOJu0YwDbQ6f5bbMsyHTNe9pU42kFeGfcybnJw8NJCGJrLNhZ9Ug79PQ
 JjYmbF/d1IbBYetv80/g3w35Y+D5evB2YY2c9GaZxiNtjd1j+2p+1ywTTr4ch7Lh9+6JqhJhCxD
 tGKWR29tlxrM6W+70ldw/qxaA5c2hVKq+JA3I
X-Gm-Gg: ASbGnctafasNjB30Czb73SOVL2b5jbYlq7StXiGIvBlEx6lkoXpL5F7PsCLHyXlPnW4
 XhY41Ar8yWo2XgP3aPF4gVKJ3vhraFyrPIPdM0DLe4flnzxRPMwefs6fUs+Lji24pYGVEiqfUhR
 z5Wt4kd73/s2/ldhHSa2Rb+ZCIavdJxm4eAQ==
X-Google-Smtp-Source: AGHT+IH2sJ1Vo92C3Iup1Qw+0IID62lh3ipWCuxe5371mR8oKseIlqvvYA4obj88pjvWBes3i6uaiQshLcyBsqn7d1o=
X-Received: by 2002:a17:907:a38e:b0:ad2:39a9:f1b2 with SMTP id
 a640c23a62f3a-ad239aa08b7mr143019066b.59.1746876435027; Sat, 10 May 2025
 04:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-2-sjg@chromium.org>
 <20250505203810.GM5430@bill-the-cat>
 <CAFLszTgw6pP7SgRp=C-skUeA_cOhEfoVXD+YNKE9jP8vj0UPXw@mail.gmail.com>
 <20250506194817.GH5430@bill-the-cat>
In-Reply-To: <20250506194817.GH5430@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:27:03 +0200
X-Gm-Features: AX0GCFuNtG5pd7c7dNym-ku50YjwOLw7-QCe3WSuFz2CGBpb-u6_GqN5YWEGR4o
Message-ID: <CAFLszTiiM1e_MQHiArK5sRrL-8gpg+DEDg6rs4ONJmz8V8mfug@mail.gmail.com>
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

On Tue, 6 May 2025 at 21:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, May 06, 2025 at 03:23:39PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 5 May 2025 at 22:38, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, May 01, 2025 at 07:37:01AM -0600, Simon Glass wrote:
> > >
> > > > This construct appears in various places. Reduce code size by adding a
> > > > function for it.
> > > >
> > > > It inits the abuf, then allocates it to the requested size.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Add new patch with a helper for initing and allocating a buffer
> > > >
> > > >  boot/cedit.c          |  3 +--
> > > >  boot/scene.c          |  3 +--
> > > >  boot/scene_textline.c |  3 +--
> > > >  include/abuf.h        | 11 +++++++++++
> > > >  lib/abuf.c            |  9 +++++++++
> > > >  lib/of_live.c         |  3 +--
> > > >  test/lib/abuf.c       | 22 ++++++++++++++++++++++
> > > >  7 files changed, 46 insertions(+), 8 deletions(-)
> > >
> > > This just made me look again at the abuf implementation itself and
> > > become filled with regret I didn't reject it back in 2021. We're
> > > introducing wrappers around standard functions and calling conventions /
> > > patterns with something homegrown (and so not intuitive to others) that
> > > mainly hides the "sysmem" challenge we also have  and I wish you were
> > > interested in revisiting how that part of sandbox works instead. And
> > > even if this is a better design, for the sake of argument, it's not
> > > something everyone else is used to. And that's important.
> > >
> > > If we *really* need something different / new here, I'd rather see us go
> > > and wrap common/dlmalloc.c with kmalloc/kfree/etc and so give people
> > > something even more familiar-looking.
> >
> > The purpose of abuf is actually not about hiding sysmem - you can see
> > that if you look at lib/abuf.c and the tests. It provides an easy way
> > to manage buffers, which we do a lot in U-Boot, particularly with
> > standard boot. It deals with whether the buffer is allocated or not,
> > so freeing is easy. With expo I want to be able to manage a buffer
> > containing an autoboot string in high-level code, say, without
> > worrying whether it has to be realloced.
>
> It's a wrapper around free/malloc/et al, which then also includes the
> sandbox-specific requirement of *sysmap* stuff. This is best shown by
> the next two patches which convert from standard malloc/free patterns
> (which both humans and analysis checkers are fond of) to a home grown
> invention.

Yes, although I should point out that most of my code is a home-grown
invention, if by that you mean it wasn't invented by someone else and
then posted by me as if it were my own invention.

>
> > For sysmem, I don't see a viable alternative, which keeps can reliably
> > keep addresses consistent across multiple phases (e.g. sandbox_vpl).
> > Also, I don't believe addresses like 0x7ffff7fbc000 are
> > human-friendly, yet that is what we would see in tests if we dropped
> > the mapping. The point of sandbox is to test U-Boot, not expose the
> > system internals. But we could discuss it if you like?
>
> I'm not sure how this is relevant to the general high level point of
> "sandbox should be able to, in 2025, be designed so that special macros
> do not need to be everywhere for the sanity checking it can do to
> happen". If my web browser is going to suck up 11GiB of memory all the
> time I can live with sandbox using 1/2/4/whatever GiB of memory when it
> runs. The "this is not a pointer" problem sandbox can solve could be
> done differently these days.

The special macros have several purposes:
1. Allow sandbox to have a contiguous region of memory at address 0,
while the pointers are wherever the RAM buffer happens to end up
2. Provide an indication of whether code has been converted to sandbox
yet, or not
3. Provide a way to mark all casts to/from address/pointers so it is
clear that the cast is intentional
4. Ensure that sandbox seg-faults if a bad pointer is used

You seemed quite happy about it until my EFI test was rejected.

>
> > In general I am sensing that there are a lot of things which bug you
> > about the direction of U-Boot. and that you feel very differently
> > about some things than you did in 2021. I have quite a few concerns
> > too. So how about we make time to discuss these and see if we can get
> > on the same page, at least somewhat?
>
> Yes, we've had numerous long threads, and a few calls. You are then
> unhappy with what I say I want to see done, want me to just take your
> changes instead and "Say Yes" more. I wonder if I had said No, or gather
> more feedback from potential users, or just slow down, more back in 2021
> if we would not be in a different position here.

I wonder if you had said yes more, if we might have got standard boot
done a few years earlier and would not be stuck now on EFI bootmgr.

>
> > Coming back to this patch though, this is really about a code-side
> > win, rather than anything else.
>
> No, it's about how similar to the "log a message and return" convention
> change you wanted to make and then dropped, how I do not see good value
> in changing from standard convention of malloc/free to abuf being a win.
> Maybe this is a case where borrowing the kernel's mempool logic would be
> a win instead? Because another part of this is that we want to avoid
> making up our own APIs for things if we can instead borrow something
> from the kernel, where most of the rest of the community will already be
> familiar.

mempool is actually lmb, as I understand it. We haven't done that
rename. It allocates from a region of pre-allocated memory. It doesn't
use malloc(). So to me, that is quite different.

- Simon
