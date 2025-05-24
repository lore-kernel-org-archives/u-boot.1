Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8B2C54FC6
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12FAC83416;
	Sat, 24 May 2025 16:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l+54HfgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815F883443; Sat, 24 May 2025 16:35:28 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 180BC831C2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72ec926e828so157026a34.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748097325; x=1748702125; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=soJzyxREE2S8kgnRAoSXEplSN3y6bnsep7N+ky+1w9g=;
 b=l+54HfgCweEtB1aSk7CXHirPmRktr0z2efaaIO7bo52z5RBWS1cWn8S3GhB5gBFcT/
 mE1Iy8ADURqxYw1ExV+7S5Ji577JTd8O5E8kbxrVzUP+lcKiXqheR3sIOhnJocC0DwJq
 AqpWeatjekHXxhd54ArM1sHdKWUbqIGJArjeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748097325; x=1748702125;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soJzyxREE2S8kgnRAoSXEplSN3y6bnsep7N+ky+1w9g=;
 b=Iur0Jc/X94kqkRbAaHuwFBT6foMOvPMeB4S1xGqnnebNTbD6cg2XFiUbx+IH6XvbR2
 x26xqLHSEVlpEa5XGIXvy7dvXr0yw3E2Rbhpb9N6t6xO2cK3cFQjPpqjPKP46sqpFzEB
 N/maCbVo1SbNr/kRKXKUOJUV70FEftRgM93MLGBHaOQqa6sin3YKjWb3HVsNllD5Zl/I
 hc+26MO7T3E6avjmmEBe7VQcFB5OWLV2Yl0MAOlmH8jKksr4KuFUoO5yu9XTnG/lnjBD
 nRGj8YTsIBkPVDwPwG3e5hknOZY6D45OYfSoNKP52WioneasY42sCI4jfe2mTfWA1KWO
 rMBw==
X-Gm-Message-State: AOJu0YwgBRxkjwnDz85GOzpSJv+tcml7oknXVW4P1qrXHdm48bwph11m
 h9uGTDz0pNdv63NYrerVo5S6AG4OP5aLUfDGYtV8UdDIdKNTegAtfBBcDDWHw9H+AFo=
X-Gm-Gg: ASbGncvPhSTm3u/uPRkPCGBGQbsJ1E4h8uDZ/NCFw0vgECm9caa61Er65nJ1pQB1Et7
 X6DDzv2MHo830nZDKFkeP28Pgic1EyZeSy27+nFqz5FALz78Cago++nb29CwZiXgzd4Q6EBZS0C
 8p44Fn9FIRh9NM0JVhk7NET4YPd+WjW3tma9TpakgbV1qsqZi/UPU0hrnBUf5nplXVr3EnLfZOI
 V+kYi265Ie2SASHcFXvJyktyh0swnK3EKk5dQuuLyKDCMuAzKa7YQGtB0sn2IPYRK5phcLJv4sh
 afJre0XXuWu2a582AVwSqTYfM2QNX+4JZQaxBMSnm1tOyD/xikLgim+W8/YS7Pz8d1P6HXZFcz/
 zpfAZPr8l/yGX
X-Google-Smtp-Source: AGHT+IFbCaqwYO9hitF/AXbBNGYSQ/QcIOihaB/I/RWjncM/PVfwvaTQqzTZNESKjCjUW1rLC6fVEA==
X-Received: by 2002:a05:6830:6219:b0:732:2633:91e5 with SMTP id
 46e09a7af769-7355d0c84a3mr2471244a34.21.1748097324700; 
 Sat, 24 May 2025 07:35:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a4b0e6sm3316050a34.11.2025.05.24.07.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:35:23 -0700 (PDT)
Date: Sat, 24 May 2025 08:35:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 01/18] abuf: Add a helper for initing and allocating a
 buffer
Message-ID: <20250524143521.GK100073@bill-the-cat>
References: <20250501133726.2627373-2-sjg@chromium.org>
 <20250505203810.GM5430@bill-the-cat>
 <CAFLszTgw6pP7SgRp=C-skUeA_cOhEfoVXD+YNKE9jP8vj0UPXw@mail.gmail.com>
 <20250506194817.GH5430@bill-the-cat>
 <CAFLszTiiM1e_MQHiArK5sRrL-8gpg+DEDg6rs4ONJmz8V8mfug@mail.gmail.com>
 <20250512223540.GU603748@bill-the-cat>
 <CAFLszTiUKyOhGxfEOm8Bj-LvqT=L35Sxa0gprRhA-BE9xsLZaw@mail.gmail.com>
 <CAFLszTgSFoAda_arLJqhojHi=BmODHB7cgOaWcvKJKJEmgvo4g@mail.gmail.com>
 <20250524142024.GC100073@bill-the-cat>
 <CAFLszTg_jptL71am4Hh3wnb3O2PCsWBGMxCqvgN2jbsWOrOA2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pOgZxkEDhyiEU7uQ"
Content-Disposition: inline
In-Reply-To: <CAFLszTg_jptL71am4Hh3wnb3O2PCsWBGMxCqvgN2jbsWOrOA2Q@mail.gmail.com>
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


--pOgZxkEDhyiEU7uQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 03:31:42PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 24 May 2025 at 15:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 24, 2025 at 08:51:43AM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 14 May 2025 at 20:44, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Tue, 13 May 2025 at 00:35, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, May 10, 2025 at 01:27:03PM +0200, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 6 May 2025 at 21:48, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > > >
> > > > > > > On Tue, May 06, 2025 at 03:23:39PM +0200, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 5 May 2025 at 22:38, Tom Rini <trini@konsulko.com> =
wrote:
> > > > > > > > >
> > > > > > > > > On Thu, May 01, 2025 at 07:37:01AM -0600, Simon Glass wro=
te:
> > > > > > > > >
> > > > > > > > > > This construct appears in various places. Reduce code s=
ize by adding a
> > > > > > > > > > function for it.
> > > > > > > > > >
> > > > > > > > > > It inits the abuf, then allocates it to the requested s=
ize.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - Add new patch with a helper for initing and allocatin=
g a buffer
> > > > > > > > > >
> > > > > > > > > >  boot/cedit.c          |  3 +--
> > > > > > > > > >  boot/scene.c          |  3 +--
> > > > > > > > > >  boot/scene_textline.c |  3 +--
> > > > > > > > > >  include/abuf.h        | 11 +++++++++++
> > > > > > > > > >  lib/abuf.c            |  9 +++++++++
> > > > > > > > > >  lib/of_live.c         |  3 +--
> > > > > > > > > >  test/lib/abuf.c       | 22 ++++++++++++++++++++++
> > > > > > > > > >  7 files changed, 46 insertions(+), 8 deletions(-)
> > > > > > > > >
> > > > > > > > > This just made me look again at the abuf implementation i=
tself and
> > > > > > > > > become filled with regret I didn't reject it back in 2021=
=2E We're
> > > > > > > > > introducing wrappers around standard functions and callin=
g conventions /
> > > > > > > > > patterns with something homegrown (and so not intuitive t=
o others) that
> > > > > > > > > mainly hides the "sysmem" challenge we also have  and I w=
ish you were
> > > > > > > > > interested in revisiting how that part of sandbox works i=
nstead. And
> > > > > > > > > even if this is a better design, for the sake of argument=
, it's not
> > > > > > > > > something everyone else is used to. And that's important.
> > > > > > > > >
> > > > > > > > > If we *really* need something different / new here, I'd r=
ather see us go
> > > > > > > > > and wrap common/dlmalloc.c with kmalloc/kfree/etc and so =
give people
> > > > > > > > > something even more familiar-looking.
> > > > > > > >
> > > > > > > > The purpose of abuf is actually not about hiding sysmem - y=
ou can see
> > > > > > > > that if you look at lib/abuf.c and the tests. It provides a=
n easy way
> > > > > > > > to manage buffers, which we do a lot in U-Boot, particularl=
y with
> > > > > > > > standard boot. It deals with whether the buffer is allocate=
d or not,
> > > > > > > > so freeing is easy. With expo I want to be able to manage a=
 buffer
> > > > > > > > containing an autoboot string in high-level code, say, with=
out
> > > > > > > > worrying whether it has to be realloced.
> > > > > > >
> > > > > > > It's a wrapper around free/malloc/et al, which then also incl=
udes the
> > > > > > > sandbox-specific requirement of *sysmap* stuff. This is best =
shown by
> > > > > > > the next two patches which convert from standard malloc/free =
patterns
> > > > > > > (which both humans and analysis checkers are fond of) to a ho=
me grown
> > > > > > > invention.
> > > > > >
> > > > > > Yes, although I should point out that most of my code is a home=
-grown
> > > > > > invention, if by that you mean it wasn't invented by someone el=
se and
> > > > > > then posted by me as if it were my own invention.
> > > > >
> > > > > Well, I'm referring to the cases where solutions to the problems =
exist,
> > > > > but you're inventing a new one instead.
> > > > >
> > > > > > > > For sysmem, I don't see a viable alternative, which keeps c=
an reliably
> > > > > > > > keep addresses consistent across multiple phases (e.g. sand=
box_vpl).
> > > > > > > > Also, I don't believe addresses like 0x7ffff7fbc000 are
> > > > > > > > human-friendly, yet that is what we would see in tests if w=
e dropped
> > > > > > > > the mapping. The point of sandbox is to test U-Boot, not ex=
pose the
> > > > > > > > system internals. But we could discuss it if you like?
> > > > > > >
> > > > > > > I'm not sure how this is relevant to the general high level p=
oint of
> > > > > > > "sandbox should be able to, in 2025, be designed so that spec=
ial macros
> > > > > > > do not need to be everywhere for the sanity checking it can d=
o to
> > > > > > > happen". If my web browser is going to suck up 11GiB of memor=
y all the
> > > > > > > time I can live with sandbox using 1/2/4/whatever GiB of memo=
ry when it
> > > > > > > runs. The "this is not a pointer" problem sandbox can solve c=
ould be
> > > > > > > done differently these days.
> > > > > >
> > > > > > The special macros have several purposes:
> > > > > > 1. Allow sandbox to have a contiguous region of memory at addre=
ss 0,
> > > > > > while the pointers are wherever the RAM buffer happens to end up
> > > > > > 2. Provide an indication of whether code has been converted to =
sandbox
> > > > > > yet, or not
> > > > > > 3. Provide a way to mark all casts to/from address/pointers so =
it is
> > > > > > clear that the cast is intentional
> > > > > > 4. Ensure that sandbox seg-faults if a bad pointer is used
> > > > > >
> > > > > > You seemed quite happy about it until my EFI test was rejected.
> > > > >
> > > > > No, I've never really been happy with the macros and never unders=
tood
> > > > > why we couldn't do the useful sanity checking wholly under arch/s=
andbox/
> > > > >
> > > > > > > > In general I am sensing that there are a lot of things whic=
h bug you
> > > > > > > > about the direction of U-Boot. and that you feel very diffe=
rently
> > > > > > > > about some things than you did in 2021. I have quite a few =
concerns
> > > > > > > > too. So how about we make time to discuss these and see if =
we can get
> > > > > > > > on the same page, at least somewhat?
> > > > > > >
> > > > > > > Yes, we've had numerous long threads, and a few calls. You ar=
e then
> > > > > > > unhappy with what I say I want to see done, want me to just t=
ake your
> > > > > > > changes instead and "Say Yes" more. I wonder if I had said No=
, or gather
> > > > > > > more feedback from potential users, or just slow down, more b=
ack in 2021
> > > > > > > if we would not be in a different position here.
> > > > > >
> > > > > > I wonder if you had said yes more, if we might have got standar=
d boot
> > > > > > done a few years earlier and would not be stuck now on EFI boot=
mgr.
> > > > >
> > > > > No, we probably would have just had more developers leave as I ov=
errode
> > > > > their objections.
> > > > >
> > > > > > > > Coming back to this patch though, this is really about a co=
de-side
> > > > > > > > win, rather than anything else.
> > > > > > >
> > > > > > > No, it's about how similar to the "log a message and return" =
convention
> > > > > > > change you wanted to make and then dropped, how I do not see =
good value
> > > > > > > in changing from standard convention of malloc/free to abuf b=
eing a win.
> > > > > > > Maybe this is a case where borrowing the kernel's mempool log=
ic would be
> > > > > > > a win instead? Because another part of this is that we want t=
o avoid
> > > > > > > making up our own APIs for things if we can instead borrow so=
mething
> > > > > > > from the kernel, where most of the rest of the community will=
 already be
> > > > > > > familiar.
> > > > > >
> > > > > > mempool is actually lmb, as I understand it. We haven't done th=
at
> > > > > > rename. It allocates from a region of pre-allocated memory. It =
doesn't
> > > > > > use malloc(). So to me, that is quite different.
> > > > >
> > > > > Then we should probably just drop the abuf thing and use standard
> > > > > conventions that developers are used to.
> > > >
> > > > No, abuf is a valuable abstraction which makes it easier to avoid
> > > > alloc/free errors, size errors, etc. Python has bytes, C++ has
> > > > std::byte. Linux has sk_buff which is a bit like membuf. Perhaps Li=
nux
> > > > would benefit from abuf but its memory model and usage is quite a b=
it
> > > > different, so I'm not sure.
> > >
> > > This series seems to be blocked on a desire to remove abuf from
> > > U-Boot. Other than that I have a minor comment to resolve on the new
> > > 'bootdev order' command. So I sent a patch for that.
> >
> > Yes, I disagree with spreading the use of abuf. Whatever benefits it may
> > or may not have are outweighed by not following any normal conventions
> > the rest of the developers use.
>=20
> Are you completely set on this?

I sure would appreciate it if any other developer would chime in and say
that they do see value here and that I'm missing something. You've made
your case, I've explained what you're missing, and you seem set on
ignoring it.

--=20
Tom

--pOgZxkEDhyiEU7uQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx2SkACgkQFHw5/5Y0
tyyp8gwAhDXGB+zcHgr91ldVc1DIINZ78+mtOA3mtNwq0PcetBLSqEh8qMVPpGF4
jTB2LbK3S/S324XFJt71fsoHWHAhBql+ZTs1hHal5o+QJtS7J5oi3AGoijewd644
mK1yb055Ai8lgUWgsovhJ82ERcnOLfcqngEO+p8v7cRGXdHdyFyGYtONIcGHBgC6
7aL8cCJRiPb/UklefBXNXfMZhNpbJNzY6GBoH9yi3hT/+LFIvyaRaSp/kM4VWNBP
NTBwGwXuXP2kpO0ES4nAyKGM1bR1rwbIHxQ9zPI2hjRXybzcWPExMKWdxUDLbQHp
exZkfNEDUznRFiiPsxXMGQu9pGRRrGGinUk1jut7uaoUj09eu+ocvmv7PAV/ghW/
YYudYp4XG499wAsustA3VQ5AOPq5kKZSyWFU8ZnIn217jbvrWHt64CNAbwLKk4pK
d14/EMK7NM5z/hf9/2RB2J3JHt39E6wKOERtbgFwe+dG0i5h4I8ujsQWbm00Zwwi
bzt1hjoF
=9sPx
-----END PGP SIGNATURE-----

--pOgZxkEDhyiEU7uQ--
