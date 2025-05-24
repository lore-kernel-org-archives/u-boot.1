Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13B9C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D7FD8310F;
	Sat, 24 May 2025 16:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CD2/NVlj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C77831C2; Sat, 24 May 2025 16:20:31 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F6D82AE2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2d060c62b61so789825fac.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748096428; x=1748701228; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=anMsqdZ1XTeam6Kj+ykNNY+ErmVTHHVOsVgzyZJGwqI=;
 b=CD2/NVljYQH2DXLyZE60CpeH+SJkdJwNDAFRj/EjJLO8li38ZFAGeWMPrW6hVl1Ug9
 hk/9i2aoZ4AFMhxdOZq2vjxaidWpo9fyIcG1SitkApxtDYEQ72ECgsmq3fwedzJmA98X
 f1S4Lbi1upoXrM4Vc+UAqaKPH62i1xECb0A7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096428; x=1748701228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anMsqdZ1XTeam6Kj+ykNNY+ErmVTHHVOsVgzyZJGwqI=;
 b=eCqjBALr45NOIMUyLmUaJTUM6A85AzWf8guWdprlRJtEsGXOljQIjhOLctwzHLY4RE
 QRnAnGLGH+e2YKKjwoUKHSr8Ai8xi4hJaJqcuFabhJcXqIpQrulkdH68M7j8YJTjzfVH
 znSbuKLqCbyYDpy3hKMueQtS0E3m5xxiv5QeTkz44AVhMqFGydMYEMVQU+zzhEgHoAPF
 CQ2mE55leQwOBeLpFBwjcPezuR6rnzCKsrYoNoMcuY0gJYf7Mmiyllc6yPD4NtPJMYgX
 1C5TdrbZfzpxu7CQWUlmXI5po88u7BcqrXPnnAp3RiAp+JIH3ghswOsY2QhAN2FPtTVr
 sENA==
X-Gm-Message-State: AOJu0YyuFBQXz26TvAKCf/wEOWNxqa8ZQCDmnuuUMz5J/THpKOy3cqRw
 kAXPKD0lUZwtOXCGra+e4M/APtUkOP6iq3nOwdX8wQv5WLVv5YiitxM4Xer1I4MAKFXsanbty1s
 9n4GsWVs=
X-Gm-Gg: ASbGncsdwjbB3r6oEOGAuGO2o5QHHNqYfJ86PIPZfEsXeiY+CHlKWBhMK9QLZ5EF9r4
 mSsNHgPp2c5e1nMa6yGZ2/08Y37HMFCmOf/siOMzaLF2CBa10BNtwVAW9zNNO5Wij2DnbuuJlI1
 oGVhTb8LJGQL2ux6hRwaD99FVGr/JT1vtYMg6kCK1GRcYg7LhUGxYCAzrzrPPanpqPF5xAwJRAn
 93EaGy4XTWzpyWkuRj3hxKXpDkTpaWDuhxj7O+GIJ3mrghZy82t9lUw0xNLneUytukdFyKEVOJJ
 siLkMJ9sgUoGUv4rglHmxeFGpHhlIvJx+mYOWmyNHsvxkaCtEppbMvjMtxemwedGBWlU8nV9BmF
 YwTP0o4PVJS6rDToViUo+IBA=
X-Google-Smtp-Source: AGHT+IFcALa6xqLfbhuHWUR3UeGjDHM1PO5U2ZAJEtZV7dqwB4ILnqHRlRNmyyFThVSu8UkXHz/ziw==
X-Received: by 2002:a05:6871:5823:b0:2d5:4898:fbe8 with SMTP id
 586e51a60fabf-2e861e1207amr1581576fac.13.1748096428229; 
 Sat, 24 May 2025 07:20:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0b21f25sm4089511fac.47.2025.05.24.07.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:20:27 -0700 (PDT)
Date: Sat, 24 May 2025 08:20:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 01/18] abuf: Add a helper for initing and allocating a
 buffer
Message-ID: <20250524142024.GC100073@bill-the-cat>
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-2-sjg@chromium.org>
 <20250505203810.GM5430@bill-the-cat>
 <CAFLszTgw6pP7SgRp=C-skUeA_cOhEfoVXD+YNKE9jP8vj0UPXw@mail.gmail.com>
 <20250506194817.GH5430@bill-the-cat>
 <CAFLszTiiM1e_MQHiArK5sRrL-8gpg+DEDg6rs4ONJmz8V8mfug@mail.gmail.com>
 <20250512223540.GU603748@bill-the-cat>
 <CAFLszTiUKyOhGxfEOm8Bj-LvqT=L35Sxa0gprRhA-BE9xsLZaw@mail.gmail.com>
 <CAFLszTgSFoAda_arLJqhojHi=BmODHB7cgOaWcvKJKJEmgvo4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z5el4fjJodhv3aEM"
Content-Disposition: inline
In-Reply-To: <CAFLszTgSFoAda_arLJqhojHi=BmODHB7cgOaWcvKJKJEmgvo4g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Z5el4fjJodhv3aEM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 08:51:43AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 14 May 2025 at 20:44, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Tue, 13 May 2025 at 00:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, May 10, 2025 at 01:27:03PM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 6 May 2025 at 21:48, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, May 06, 2025 at 03:23:39PM +0200, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 5 May 2025 at 22:38, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > > >
> > > > > > > On Thu, May 01, 2025 at 07:37:01AM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > This construct appears in various places. Reduce code size =
by adding a
> > > > > > > > function for it.
> > > > > > > >
> > > > > > > > It inits the abuf, then allocates it to the requested size.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Add new patch with a helper for initing and allocating a =
buffer
> > > > > > > >
> > > > > > > >  boot/cedit.c          |  3 +--
> > > > > > > >  boot/scene.c          |  3 +--
> > > > > > > >  boot/scene_textline.c |  3 +--
> > > > > > > >  include/abuf.h        | 11 +++++++++++
> > > > > > > >  lib/abuf.c            |  9 +++++++++
> > > > > > > >  lib/of_live.c         |  3 +--
> > > > > > > >  test/lib/abuf.c       | 22 ++++++++++++++++++++++
> > > > > > > >  7 files changed, 46 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > > > This just made me look again at the abuf implementation itsel=
f and
> > > > > > > become filled with regret I didn't reject it back in 2021. We=
're
> > > > > > > introducing wrappers around standard functions and calling co=
nventions /
> > > > > > > patterns with something homegrown (and so not intuitive to ot=
hers) that
> > > > > > > mainly hides the "sysmem" challenge we also have  and I wish =
you were
> > > > > > > interested in revisiting how that part of sandbox works inste=
ad. And
> > > > > > > even if this is a better design, for the sake of argument, it=
's not
> > > > > > > something everyone else is used to. And that's important.
> > > > > > >
> > > > > > > If we *really* need something different / new here, I'd rathe=
r see us go
> > > > > > > and wrap common/dlmalloc.c with kmalloc/kfree/etc and so give=
 people
> > > > > > > something even more familiar-looking.
> > > > > >
> > > > > > The purpose of abuf is actually not about hiding sysmem - you c=
an see
> > > > > > that if you look at lib/abuf.c and the tests. It provides an ea=
sy way
> > > > > > to manage buffers, which we do a lot in U-Boot, particularly wi=
th
> > > > > > standard boot. It deals with whether the buffer is allocated or=
 not,
> > > > > > so freeing is easy. With expo I want to be able to manage a buf=
fer
> > > > > > containing an autoboot string in high-level code, say, without
> > > > > > worrying whether it has to be realloced.
> > > > >
> > > > > It's a wrapper around free/malloc/et al, which then also includes=
 the
> > > > > sandbox-specific requirement of *sysmap* stuff. This is best show=
n by
> > > > > the next two patches which convert from standard malloc/free patt=
erns
> > > > > (which both humans and analysis checkers are fond of) to a home g=
rown
> > > > > invention.
> > > >
> > > > Yes, although I should point out that most of my code is a home-gro=
wn
> > > > invention, if by that you mean it wasn't invented by someone else a=
nd
> > > > then posted by me as if it were my own invention.
> > >
> > > Well, I'm referring to the cases where solutions to the problems exis=
t,
> > > but you're inventing a new one instead.
> > >
> > > > > > For sysmem, I don't see a viable alternative, which keeps can r=
eliably
> > > > > > keep addresses consistent across multiple phases (e.g. sandbox_=
vpl).
> > > > > > Also, I don't believe addresses like 0x7ffff7fbc000 are
> > > > > > human-friendly, yet that is what we would see in tests if we dr=
opped
> > > > > > the mapping. The point of sandbox is to test U-Boot, not expose=
 the
> > > > > > system internals. But we could discuss it if you like?
> > > > >
> > > > > I'm not sure how this is relevant to the general high level point=
 of
> > > > > "sandbox should be able to, in 2025, be designed so that special =
macros
> > > > > do not need to be everywhere for the sanity checking it can do to
> > > > > happen". If my web browser is going to suck up 11GiB of memory al=
l the
> > > > > time I can live with sandbox using 1/2/4/whatever GiB of memory w=
hen it
> > > > > runs. The "this is not a pointer" problem sandbox can solve could=
 be
> > > > > done differently these days.
> > > >
> > > > The special macros have several purposes:
> > > > 1. Allow sandbox to have a contiguous region of memory at address 0,
> > > > while the pointers are wherever the RAM buffer happens to end up
> > > > 2. Provide an indication of whether code has been converted to sand=
box
> > > > yet, or not
> > > > 3. Provide a way to mark all casts to/from address/pointers so it is
> > > > clear that the cast is intentional
> > > > 4. Ensure that sandbox seg-faults if a bad pointer is used
> > > >
> > > > You seemed quite happy about it until my EFI test was rejected.
> > >
> > > No, I've never really been happy with the macros and never understood
> > > why we couldn't do the useful sanity checking wholly under arch/sandb=
ox/
> > >
> > > > > > In general I am sensing that there are a lot of things which bu=
g you
> > > > > > about the direction of U-Boot. and that you feel very different=
ly
> > > > > > about some things than you did in 2021. I have quite a few conc=
erns
> > > > > > too. So how about we make time to discuss these and see if we c=
an get
> > > > > > on the same page, at least somewhat?
> > > > >
> > > > > Yes, we've had numerous long threads, and a few calls. You are th=
en
> > > > > unhappy with what I say I want to see done, want me to just take =
your
> > > > > changes instead and "Say Yes" more. I wonder if I had said No, or=
 gather
> > > > > more feedback from potential users, or just slow down, more back =
in 2021
> > > > > if we would not be in a different position here.
> > > >
> > > > I wonder if you had said yes more, if we might have got standard bo=
ot
> > > > done a few years earlier and would not be stuck now on EFI bootmgr.
> > >
> > > No, we probably would have just had more developers leave as I overro=
de
> > > their objections.
> > >
> > > > > > Coming back to this patch though, this is really about a code-s=
ide
> > > > > > win, rather than anything else.
> > > > >
> > > > > No, it's about how similar to the "log a message and return" conv=
ention
> > > > > change you wanted to make and then dropped, how I do not see good=
 value
> > > > > in changing from standard convention of malloc/free to abuf being=
 a win.
> > > > > Maybe this is a case where borrowing the kernel's mempool logic w=
ould be
> > > > > a win instead? Because another part of this is that we want to av=
oid
> > > > > making up our own APIs for things if we can instead borrow someth=
ing
> > > > > from the kernel, where most of the rest of the community will alr=
eady be
> > > > > familiar.
> > > >
> > > > mempool is actually lmb, as I understand it. We haven't done that
> > > > rename. It allocates from a region of pre-allocated memory. It does=
n't
> > > > use malloc(). So to me, that is quite different.
> > >
> > > Then we should probably just drop the abuf thing and use standard
> > > conventions that developers are used to.
> >
> > No, abuf is a valuable abstraction which makes it easier to avoid
> > alloc/free errors, size errors, etc. Python has bytes, C++ has
> > std::byte. Linux has sk_buff which is a bit like membuf. Perhaps Linux
> > would benefit from abuf but its memory model and usage is quite a bit
> > different, so I'm not sure.
>=20
> This series seems to be blocked on a desire to remove abuf from
> U-Boot. Other than that I have a minor comment to resolve on the new
> 'bootdev order' command. So I sent a patch for that.

Yes, I disagree with spreading the use of abuf. Whatever benefits it may
or may not have are outweighed by not following any normal conventions
the rest of the developers use.

--=20
Tom

--Z5el4fjJodhv3aEM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx1agACgkQFHw5/5Y0
tywl5AwAjV4vk75AJT68goywfW6iYMAcwNwX4g+2p1TUEtNYWaghJ7U1hUDslfEx
FYvHxKtfVDCNk0XJ6vWewZpNsInPuiakvvwY5EPGz7p8kUj3oUoNJL1x+wGU6nJQ
XD6sqTzNWmp7RE5yj2taX6hNomwWQ2DKHN9rPXrvPYiVXppq3MWB96dVK2piZjFq
ac+szdZP4vMy1b1iERPUCa9Q/X/KTsf4oCxKaqFju9ju9l6dsFqzHpBSln7eG2u5
/0x/gIYnh0jyKzovKcVI3xoJQR5u1GAgPAxbbcSx4Izq2tb3Y95tq1dURI4ib2Hi
yB5X51CaLEZgEt+rk9yo0BgK/mjlPU1CbqEcQDaKmW1qa0NxOKQ8Pv9K96nCAPEO
IOaYE6Joo4yIy7VHGjhQDjGiXkbYnr4xb3D7Ppl3+eU6W4mLKo5vEJ+lN5B7JVQH
kMqBlfBWjwG6dP0qDmDcn0zGTX9K918SJeD3SfUiNBFbj+2HN6fU626+s2/ZYxsg
Fj3jArWT
=AqkS
-----END PGP SIGNATURE-----

--Z5el4fjJodhv3aEM--
