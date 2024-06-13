Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F66C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 20:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85908887FF;
	Thu, 13 Jun 2024 22:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MSBVvLfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B9C8890E; Thu, 13 Jun 2024 22:07:02 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F9F87DEB
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 22:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f361af4cb6so492292a34.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718309219; x=1718914019; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RkMM5EVPOBGa6MB7IvIXiZLDsZFbZuW1X0lHK4S2Lc0=;
 b=MSBVvLfnz7+aBM9z0k1MVrfi2ZSrGo3G3T/ggYfTwNlijoaFeLONmHOOJceseBoKnl
 NJTQ+W6wwccpCHcNJzExHbLFEsjvTdjiilae4B0IbAVXEUP+feYQ2Lbily1rZ9+wcJyE
 iVlwmQE6KnCIbYaCXBGjPxFbjsfM9cx9yV/gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718309219; x=1718914019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkMM5EVPOBGa6MB7IvIXiZLDsZFbZuW1X0lHK4S2Lc0=;
 b=hTDcwDD5L5Syx0dPFRjW+XR9nrsTI6hHXdkKbFL7Wxb/KZAczmCcqLhE5djDxXkBaw
 kkkyVicYP9LMR5xo0EtgwWcuTAQGcFVRXwB8cFltR371qubyOvQBynHa/4Y2M8bHyR2K
 KKlBcR3dagpefSnVOV6O41v0+FjBgCsJ36yVYrNscggHVg/uJZ3U9785E3xxp6MP+s5c
 1b/A1HqVcRTYQFbgg5t+8SGEZy1HmlVd2oGFvZrVMGG5/9DxK6Dw+vCf8TvoSEDmR8bB
 YS2i9GEgWn1ibqu3NnBDJvWSSlgUs8Cqa6sChztHUQ+8A5XQQ7LaJgb2hm9b4RRFiCFD
 11HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5rwaXyUgLtWmmmoLCTQST7cAl1uXtIh/HmmjTqwMOwqQqsZoX8xY7JTDsZkwlOg5iLs0A8uYCgnIcWRcQiJcbfzXFDQ==
X-Gm-Message-State: AOJu0YwzXLdRMl96QR5DiQ3t2L0v4Ok5x9rotoIrdvIiqGykZzfoLGoS
 KIfrl3mOssWl4ASzFvfPt+0YgQhNWF1FRZo+oLF1tL9AOiOpOLyUVU2gnHqu/x0=
X-Google-Smtp-Source: AGHT+IEtMO4nOcqCbsdH1OgH040pXfKTs3+Sqny9jOKKFkx7yS1dd7eYfXwDhKN/Gqcr7IVZM6SruQ==
X-Received: by 2002:a05:6830:1202:b0:6f9:90de:c67f with SMTP id
 46e09a7af769-6fb937665b7mr817160a34.10.1718309218728; 
 Thu, 13 Jun 2024 13:06:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b1eb6c8sm337028a34.43.2024.06.13.13.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 13:06:58 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:06:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
Message-ID: <20240613200655.GP68077@bill-the-cat>
References: <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
 <20240612172244.GG68077@bill-the-cat>
 <CAFLszThj1wmF4zOLDjSjHX1cg8RfiHMGgpbRccJ-VJu2dtihNw@mail.gmail.com>
 <20240612214001.GI68077@bill-the-cat>
 <CAFLszTiZSu+aN53kAPd2GXosXv09Ams+jFDi2xGU0wh+faO=dg@mail.gmail.com>
 <20240613154206.GO68077@bill-the-cat>
 <CAFLszThvhYKpxLhJOgXOkW244Cj6Au=+LqhzHTtYHtri_+tmEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z+B2SGd+lzrwWCx+"
Content-Disposition: inline
In-Reply-To: <CAFLszThvhYKpxLhJOgXOkW244Cj6Au=+LqhzHTtYHtri_+tmEg@mail.gmail.com>
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


--Z+B2SGd+lzrwWCx+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:59:48AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 13 Jun 2024 at 09:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jun 13, 2024 at 09:22:15AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 12 Jun 2024 at 15:40, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Jun 12, 2024 at 02:24:25PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 12 Jun 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:
> > > > > >
> > > > > > [snip]
> > > > > > > Also IMO there is only really one LMB list today. We create i=
t at the
> > > > > > > start of bootm and then it is done when we boot. The file-loa=
ding
> > > > > > > stuff is what makes all this confusing...and with bootstd tha=
t is
> > > > > > > under control as well.
> > > > > > >
> > > > > > > At lot of this effort seems to be about dealing with random s=
cripts
> > > > > > > which load things. We want to make sure we complain if someth=
ing
> > > > > > > overlaps. But we should be making the bootstd case work nicel=
y and
> > > > > > > doing things within that framework. Also EFI sort-of has its =
own
> > > > > > > thing, which it is very-much in control of.
> > > > > > >
> > > > > > > Overall I think this is a bit more subtle that just combining=
 allocators.
> > > > > >
> > > > > > I think this gets to the main misunderstanding. The problem isn=
't
> > > > > > handling bootstd, or EFI boot, or even assorted scripts. Those =
are all
> > > > > > cases where things are otherwise (sufficiently) well-defined. T=
he
> > > > > > problem is "security" and that a "carefully crafted payload" co=
uld do
> > > > > > something malicious. That's why we have to do all of this stuff=
 sooner
> > > > > > rather than later in our boot process.
> > > > >
> > > > > That's the first I have heard of this, actually, but a bit more d=
etail
> > > > > would help. How does the payload get loaded? I'm just not sure ab=
out
> > > > > the overall goals. It seems that everyone else is already familia=
r -
> > > > > can someone please take the time to point me to the details?
> > > >
> > > > Well, the short version I believe of the first CVE we got (and so
> > > > started abusing LMB) was along the lines of "load an image near whe=
re
> > > > the U-Boot stack is, smash things for fun and exploits".
> > >
> > > OK. I am surprised that LMB does not catch that. It is supposed to add
> > > the stack and various other things right at the start before loading
> > > any file. So even if it clears the LMB each time, it should not be
> > > able to do that. Having said this, the code may be buggy as I don't
> > > think we have tests for U-Boot's overall functional behaviour in these
> > > situations.
> >
> > Right, LMB does catch the example I gave (because we made all of the
> > load from storage/network functions init an lmb and we always make sure
> > a new lmb gets U-Boot stack/etc). The next thing we didn't catch was
> > "what if EFI does the loading?" and we've kludged around that, and in
> > turn had some of the thorny questions. Some of that is what I think
> > you're asking about in this part of the thread, to which the answer is
> > "EFI spec says you need to place X in memory", so we just need to
> > reserve it when it's asked for, so that something else can't come along
> > and smash it maliciously.
>=20
> OK I see. Of course it isn't just EFI that has this issue. I believe
> the answer (for small blocks) is to use malloc(), which I think we do
> with a few exceptions which Ilias pointed out. For things like the TPM
> log and ACPI tables we should probably use a bloblist, as we do on
> x86. For large things (like loading a kernel) we should use LMB. I've
> been thinking about how best to tie this to boot, as opposed to random
> allocations in U-Boot itself, which would lead to fragmentation and
> strange behaviour. I think bootstd is a great place to have a
> persistent LMB. It can be attached to bootstd_priv.
>=20
> My hope is that EFI is just another boot method, where
> already-allocating things are presented to the OS. Apart from the
> Ilias exceptions, I believe this is how it works today.
>=20
> Where I think this heads in the wrong direction is using
> EFI-allocation functions before we are booting an EFI image. EFI has
> no concept of what is 'in empty space' so it leads to the lmb
> conflict, the subject of this discussion.
>=20
> This is all quite subtle and probably worthy of a VC discussion.

But it's not tied to "boot". Again, the problems are with potential
malicious actions. So if we're in some function that says "I need to
claim $THIS range", it needs check in with the reservation system so
that it can be told "Sorry, already reserved" if needed. It's not a good
idea for $subsystem to say it needs $THIS range, but then we don't make
the reservation until later because someone could have acted in there
in the interim.

I see there's been further discussion between you/Heinrich/Sughosh and
I'll otherwise leave it until the next iteration, but I want to be clear
that I see it as important that when something says it needs $THIS
range, we put it in the reservation system.

> > But that also raised the more general problem, and why we need a
> > persistent reservation list, of allowing boards/SoCs to say they want to
> > reserve a block of memory for whatever, and have that obeyed, for real.
> > For example, the mach-apple logic of "just pick some memory locations to
> > use for kernel/dtb/initrd" isn't really as safe as it should be since
> > those reservations aren't really seen anywhere once the function
> > returns, it's just setting some environment variables.
>=20
> Yes, that part of it I understand. Somehow I either didn't see or
> forgot that board_late_init() code. With the script-based boot it
> makes some sort of sense, but with bootstd we should have allocation
> of addresses dealt with there. I have held off on retiring
> kernel_addr_r etc. as the scripts are still in use. But perhaps it
> would be a good time to convert bootstd to use lmb instead?

I'm not sure I follow you. It's already using lmb since that's been part
of the normal OS boot flow since forever? If you mean make it easier to
let the system just pick where to load stuff in to memory for you, yes,
that mach-apple functionality would be a handy fallback/default.
Especially if done in concert with double checking on what needs to be
done to minimize copying data around and around and around in boot
before we start the OS, since that's where much of the hard part of
deciding addresses is.

--=20
Tom

--Z+B2SGd+lzrwWCx+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZrUVwACgkQFHw5/5Y0
tyx4ygwAtLs1/3uFCSyTgx900IdRHyYz1PKlxBI5EyNQJYfVHr+bzA0FHkk3CWTU
aldqdWPKiWDDh+fE3mRwRpUwyehCRCGTg1FIwhiKERMwtstcyxRI9ICzH8PshgRE
5GJbEkhagS+cw+/dZNOzy+MGFkz3RCD+qdlxxHcfrvPA5xrOrNzMUzVIopYJ3LD9
f7PDvXyMWDG7XZy4VhRYyuVM15BwSFgsgH9BVahwlF+DyFFsrhZIfkzRi7Uogxkf
tqGoIp9d4JWyDLcFHfv/f6HTWt04Cmc3S3vQ31Q+bz3NC5ePHEUW4cx+e76h6k94
C/AKXxlu+eyWMGRdSXwq1BhnSewzucYpvjwpH99d/a32Kn9N3p0HTft42Jnf1u34
pHLsCdulcqZT21huqeba+yJjZLkjd5MkWiJs0Oqz8ZiL0GZ+fT4/nxkif21qyeLH
q2+dJYL/eLLv8t75geeLgWQCLqmqLeHHxRzyCIv10FdgZoixiowA/RhQCH+Kq9S3
TK6zLDRf
=n7GG
-----END PGP SIGNATURE-----

--Z+B2SGd+lzrwWCx+--
