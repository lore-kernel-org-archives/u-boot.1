Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8F9C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 22:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E18C826AA;
	Tue, 13 May 2025 00:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RmedYkvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29BD8294C; Tue, 13 May 2025 00:35:46 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F8C180C83
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 00:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c09f8369cso1451325a34.3
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 15:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747089343; x=1747694143; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZL9OtMDrv43hm2VMH7jYDZ8vFnKKDrOLSf+RB3m0A/s=;
 b=RmedYkvQXZkTiybu0juLA1jWjCYNA21ohElN+7wSrH7IVXoAsFY4AB6s1XWACY1/BC
 bZaANFGEEGDkftL1PCZNjRQftoYq+LXcC+B/phV+7nt4sHK1yrw1GXlKVp36xiBWTIKP
 W7xWeuNEX71TB24zACObzTw0FAYEBewD1JkoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747089343; x=1747694143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZL9OtMDrv43hm2VMH7jYDZ8vFnKKDrOLSf+RB3m0A/s=;
 b=hPS7dnt7+GE05uhmtQ2kAJk3I8i70m1qrILsnC680EU1h0FLXcviidMukOtdyxgChs
 wGk8aM/eOyF/qf3yDl7yjchMcwjoTsdZbu4IQAoG+GWNtxnBFVzG7aBZZ6TQJNvf9Q24
 6NBQZsjaPobSIO7c30VTGOQus57xa0z7nyVVrqmcXqUCTRTzYo3vOKN9jmeLS5kzQ+S2
 bFdkLEvoWD7Y+CL7cLAsiZs3Ey3OEeDkSSVCLKvtSputmWe9ZurNxY0b0G+4HhvVxqK/
 3HVVNN/p0aD5bD6Tnsj7MbMac3a1ybe3OhiQlfUrJyMZWx+Zj2WUEA2gjVD2gnNxcwaT
 wflw==
X-Gm-Message-State: AOJu0Yww2iGeBmeqjveE1fgSUIsV+YP2jgZAyhAg0m0i58MR1HmjSHDF
 VdQKppISkpVOHGRlzRDL4IzRAiRG7U3KUOmny8kcCWCbejr2N5Vsq9MZ1elOgZA=
X-Gm-Gg: ASbGncuGSQld8aJXYiyr0ygTS06c8TIHfd/Xb9e/fZp4qU16HhdeZA0CR7o2s/HKiJ/
 u0aA0JyfYBsnqcPI6pnjsnbzXp5vKXpAMskLn6p1OcvWOxg44Eg8uNQV4bOoa+8tsk1lgn6hDLX
 /KCdbGGYbtckI2dWwSOjxm5JhtuZahJwvsHAooTO7gMw+f6P62/9Q8RJYoO4/iZMOZv2SURvV3z
 wdjsuPyTZPhG+sA6VTu0zyioJ5BUJaqpbottJigYcRxlHFGjNn1CA0R1xWo86RtKe+/7yXPnWj6
 nslgegssiOFxLXjBwdK0ljPSafuPcEUSMa1DSJ60xX20z2m4H2Rp389CglAIKDR1BGS4+KKBIob
 sXbXuVXNolkRE
X-Google-Smtp-Source: AGHT+IF1oCqHKeFDX+QHqGogjw19yAEgk2OwVNFHb+/uLGt+0q2etdCjUn7oT7UHeuKQ+MmCn9sx1A==
X-Received: by 2002:a05:6830:6e9b:b0:727:3111:1416 with SMTP id
 46e09a7af769-73226b0ef8bmr10906090a34.24.1747089342929; 
 Mon, 12 May 2025 15:35:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732265ce4b9sm1727681a34.49.2025.05.12.15.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 15:35:42 -0700 (PDT)
Date: Mon, 12 May 2025 16:35:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 01/18] abuf: Add a helper for initing and allocating a
 buffer
Message-ID: <20250512223540.GU603748@bill-the-cat>
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-2-sjg@chromium.org>
 <20250505203810.GM5430@bill-the-cat>
 <CAFLszTgw6pP7SgRp=C-skUeA_cOhEfoVXD+YNKE9jP8vj0UPXw@mail.gmail.com>
 <20250506194817.GH5430@bill-the-cat>
 <CAFLszTiiM1e_MQHiArK5sRrL-8gpg+DEDg6rs4ONJmz8V8mfug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jrSvKt/ZL20YtYeQ"
Content-Disposition: inline
In-Reply-To: <CAFLszTiiM1e_MQHiArK5sRrL-8gpg+DEDg6rs4ONJmz8V8mfug@mail.gmail.com>
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


--jrSvKt/ZL20YtYeQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 01:27:03PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 6 May 2025 at 21:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, May 06, 2025 at 03:23:39PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 5 May 2025 at 22:38, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, May 01, 2025 at 07:37:01AM -0600, Simon Glass wrote:
> > > >
> > > > > This construct appears in various places. Reduce code size by add=
ing a
> > > > > function for it.
> > > > >
> > > > > It inits the abuf, then allocates it to the requested size.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Add new patch with a helper for initing and allocating a buffer
> > > > >
> > > > >  boot/cedit.c          |  3 +--
> > > > >  boot/scene.c          |  3 +--
> > > > >  boot/scene_textline.c |  3 +--
> > > > >  include/abuf.h        | 11 +++++++++++
> > > > >  lib/abuf.c            |  9 +++++++++
> > > > >  lib/of_live.c         |  3 +--
> > > > >  test/lib/abuf.c       | 22 ++++++++++++++++++++++
> > > > >  7 files changed, 46 insertions(+), 8 deletions(-)
> > > >
> > > > This just made me look again at the abuf implementation itself and
> > > > become filled with regret I didn't reject it back in 2021. We're
> > > > introducing wrappers around standard functions and calling conventi=
ons /
> > > > patterns with something homegrown (and so not intuitive to others) =
that
> > > > mainly hides the "sysmem" challenge we also have  and I wish you we=
re
> > > > interested in revisiting how that part of sandbox works instead. And
> > > > even if this is a better design, for the sake of argument, it's not
> > > > something everyone else is used to. And that's important.
> > > >
> > > > If we *really* need something different / new here, I'd rather see =
us go
> > > > and wrap common/dlmalloc.c with kmalloc/kfree/etc and so give people
> > > > something even more familiar-looking.
> > >
> > > The purpose of abuf is actually not about hiding sysmem - you can see
> > > that if you look at lib/abuf.c and the tests. It provides an easy way
> > > to manage buffers, which we do a lot in U-Boot, particularly with
> > > standard boot. It deals with whether the buffer is allocated or not,
> > > so freeing is easy. With expo I want to be able to manage a buffer
> > > containing an autoboot string in high-level code, say, without
> > > worrying whether it has to be realloced.
> >
> > It's a wrapper around free/malloc/et al, which then also includes the
> > sandbox-specific requirement of *sysmap* stuff. This is best shown by
> > the next two patches which convert from standard malloc/free patterns
> > (which both humans and analysis checkers are fond of) to a home grown
> > invention.
>=20
> Yes, although I should point out that most of my code is a home-grown
> invention, if by that you mean it wasn't invented by someone else and
> then posted by me as if it were my own invention.

Well, I'm referring to the cases where solutions to the problems exist,
but you're inventing a new one instead.

> > > For sysmem, I don't see a viable alternative, which keeps can reliably
> > > keep addresses consistent across multiple phases (e.g. sandbox_vpl).
> > > Also, I don't believe addresses like 0x7ffff7fbc000 are
> > > human-friendly, yet that is what we would see in tests if we dropped
> > > the mapping. The point of sandbox is to test U-Boot, not expose the
> > > system internals. But we could discuss it if you like?
> >
> > I'm not sure how this is relevant to the general high level point of
> > "sandbox should be able to, in 2025, be designed so that special macros
> > do not need to be everywhere for the sanity checking it can do to
> > happen". If my web browser is going to suck up 11GiB of memory all the
> > time I can live with sandbox using 1/2/4/whatever GiB of memory when it
> > runs. The "this is not a pointer" problem sandbox can solve could be
> > done differently these days.
>=20
> The special macros have several purposes:
> 1. Allow sandbox to have a contiguous region of memory at address 0,
> while the pointers are wherever the RAM buffer happens to end up
> 2. Provide an indication of whether code has been converted to sandbox
> yet, or not
> 3. Provide a way to mark all casts to/from address/pointers so it is
> clear that the cast is intentional
> 4. Ensure that sandbox seg-faults if a bad pointer is used
>=20
> You seemed quite happy about it until my EFI test was rejected.

No, I've never really been happy with the macros and never understood
why we couldn't do the useful sanity checking wholly under arch/sandbox/

> > > In general I am sensing that there are a lot of things which bug you
> > > about the direction of U-Boot. and that you feel very differently
> > > about some things than you did in 2021. I have quite a few concerns
> > > too. So how about we make time to discuss these and see if we can get
> > > on the same page, at least somewhat?
> >
> > Yes, we've had numerous long threads, and a few calls. You are then
> > unhappy with what I say I want to see done, want me to just take your
> > changes instead and "Say Yes" more. I wonder if I had said No, or gather
> > more feedback from potential users, or just slow down, more back in 2021
> > if we would not be in a different position here.
>=20
> I wonder if you had said yes more, if we might have got standard boot
> done a few years earlier and would not be stuck now on EFI bootmgr.

No, we probably would have just had more developers leave as I overrode
their objections.

> > > Coming back to this patch though, this is really about a code-side
> > > win, rather than anything else.
> >
> > No, it's about how similar to the "log a message and return" convention
> > change you wanted to make and then dropped, how I do not see good value
> > in changing from standard convention of malloc/free to abuf being a win.
> > Maybe this is a case where borrowing the kernel's mempool logic would be
> > a win instead? Because another part of this is that we want to avoid
> > making up our own APIs for things if we can instead borrow something
> > from the kernel, where most of the rest of the community will already be
> > familiar.
>=20
> mempool is actually lmb, as I understand it. We haven't done that
> rename. It allocates from a region of pre-allocated memory. It doesn't
> use malloc(). So to me, that is quite different.

Then we should probably just drop the abuf thing and use standard
conventions that developers are used to.

--=20
Tom

--jrSvKt/ZL20YtYeQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgid7wACgkQFHw5/5Y0
tywuBwv+OBKhcFsSCj8hTkoP2zJwH4grn0r0JW8gzi4rIeh5rPoZBPIsT+St8/PI
nCA2645CROUUWKSbKmtMXJgqjBubETUGUFl518hPzAme98N6a/DYUyv5f8EiJdus
qrfqk1vx+fvjO/qJ2lRTcl8EpL3Tg41hijldsWZeaZZX45S6qakhjOVVoY2jg2Yk
oBHXnWPv+p8mqwP9nBk7IJHPX0YooznLrGjQP7+TIBSSwQ/LLuTUAI2WF3suLBFa
CfAEYIF50fbrZCElbfTIj4Zj3vbn4YK5rX2seJgudMp/WvdU8G+3LFszkVcROuM3
yIeQwywGW5zg/L2IaLKUo6FSW62y23TT/BEFG5LaEGOYPuo6cYAyuyeTHZWFQSKz
7hJDgBZq4F075T/UcJ5+FqFdRuw2AZaZUHR2YlwPHXrMTnFEWbEDSKWGJ3k0CAQ5
+7qRZp1hT5vxPk1U+JPmHk4WeIILchB+sQUXymNFnhqyrhIcplI70yqIWWfh7Fk6
bf1NMfCv
=8jcO
-----END PGP SIGNATURE-----

--jrSvKt/ZL20YtYeQ--
