Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2915E77184
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 00:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 184BE80214;
	Wed, 18 Dec 2024 01:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oQgXNtOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBDC28021A; Wed, 18 Dec 2024 01:18:13 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B119801CE
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 01:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d8adbda583so70459716d6.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 16:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734481090; x=1735085890; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/kDXXSwFhCYkyzpIWplH33s880gM+3VeR5fk1JSupSo=;
 b=oQgXNtOSWIzfiU2fiAhErIWR7DehoE52HqRuen5b/qUNVb0OmjsSSJVJKadeCgG+B7
 sPddY6XCMfMlQfavtPitGP9pD1oY7yFBPpeg6AtuH66P1tFOo42j5vUM9tuubfEWhftU
 MLcSIAjW4KkJv/Ke5j9sUhgw+6xsr+SSLsMKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734481090; x=1735085890;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kDXXSwFhCYkyzpIWplH33s880gM+3VeR5fk1JSupSo=;
 b=eplJFXnYQoHY29gk8VrEXCaM1DIY0SxSy9gPwfpjjsO5KbZ19xuq5UFXzv2AOJuUrI
 p3iwVdH3ZwnUPWt8KtDGjlEFKynVHolT/ZL8bgxbpASzYfYjGkk3M7+QmoqrNZiak6rb
 uTtM26cJH5OmHk4A67VpEy4ZCTwgzexRKiNTN0L0XvzSZNF9r1mvbEEyM3sYc5oEVU+i
 y/3NoEyyAJE2RvoE+TzHNbh5b8DUsui+fjj0G4HMj7dLyD/32p/VVjwWMW9J6l4Z9YPE
 boHWSyIhsR6IR3ZDE4ROkmsfdumpr67jPJuKg8dezx+VBFhZMsv9A9GZVq9H7NQs+vuO
 /bLQ==
X-Gm-Message-State: AOJu0YwVQczkIraQchQO2GpcJOVjOiZ1r8Fn0eZvNC7xky2/K5+kfgWJ
 y/MBrZB4hvV5Ou+3rF/4pecNStDE5KGygvUALzA8WDFjjsKx13ANmQUFB2MdTQU72mUq7+gykMQ
 L
X-Gm-Gg: ASbGncvS9k/5Xp7v2OFBKXCMMTL2Mz1IAKDzpQ7GykdS2W099dNeQqXSAPirVT4d74L
 ccr+5wollLNCbCMciqSYpqptU44bsPyzrxF22ly2Uo0KB7pzpCGIkavNsFFvWgM5H08TcyVFkiT
 EK+PWQHUKha16jCDjfZJP6L2KFPqfRVA1EDELVpjWr9up43h/t1K18fX6t+ZzsuPrzquNOnZhFd
 MUO1hbosFbEebiYV+ma3kLr6CoFmp/vIoEXu5oeQ7aqujxQjAYLqbVV
X-Google-Smtp-Source: AGHT+IGftFEUcNjCU8jwzpeaPhRXgjCl99Rj+xgKh3yzrziXldCsbxTWbigp07q1W85XKDS7v0WZ9w==
X-Received: by 2002:a05:6214:2aa5:b0:6d8:8f3d:4d82 with SMTP id
 6a1803df08f44-6dd0927906cmr18278026d6.46.1734481089859; 
 Tue, 17 Dec 2024 16:18:09 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd257297sm44389376d6.45.2024.12.17.16.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 16:18:08 -0800 (PST)
Date: Tue, 17 Dec 2024 18:18:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
Message-ID: <20241218001805.GW1505244@bill-the-cat>
References: <20241212151142.1562825-1-trini@konsulko.com>
 <CAFLszTiF8m7P8mBCNRhhiRQt=bcfRB3ddaaumF_EXETTXbUmDQ@mail.gmail.com>
 <20241213170736.GW1505244@bill-the-cat>
 <CAFLszTiPxTDqB9r+rdT4gARCA1HPx9ELO+tWELB1eKuijFvAeA@mail.gmail.com>
 <20241217040040.GJ1505244@bill-the-cat>
 <CAFLszTgaVwvJVoN=io-Djso1MuahhR9wr35VVORzQTYPLW9FFw@mail.gmail.com>
 <20241217201546.GS1505244@bill-the-cat>
 <CAFLszTh6euHToEvwF_Trmr0fhotxCVipj=wYafOkyx-6jujo-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XYYe0m7d8CM7EMDU"
Content-Disposition: inline
In-Reply-To: <CAFLszTh6euHToEvwF_Trmr0fhotxCVipj=wYafOkyx-6jujo-w@mail.gmail.com>
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


--XYYe0m7d8CM7EMDU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 04:42:26PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Dec 2024 at 13:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 17, 2024 at 12:45:46PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 16 Dec 2024 at 21:00, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Dec 15, 2024 at 05:25:24PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 13 Dec 2024 at 10:07, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Dec 13, 2024 at 07:32:24AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 12 Dec 2024 at 08:11, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > Introduce an option to control if we expect that a prior st=
age has
> > > > > > > > created a bloblist already and thus it is safe to scan the =
address. We
> > > > > > > > need to have this be configurable because we do not (and ca=
nnot) know
> > > > > if
> > > > > > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or s=
ome special
> > > > > > > > on-chip memory and so it may or may not be safe to read fro=
m this
> > > > > > > > address this early.
> > > > > > > >
> > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > ---
> > > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > > > > > >  lib/fdtdec.c   | 11 +++--------
> > > > > > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > > > > > >
> > > > > > >
> > > > > > > Since this is the essentially the same as my OF_BLOBLIST patc=
h, which
> > > > > > > was rejected:
> > > > > > >
> > > > > > > NAK
> > > > > > >
> > > > > > > The issue is not whether some 'previous stage' set up a blobl=
ist. For
> > > > > > > example, if VPL_BLOBLIST_PRIOR_STAGE is enabled, that presuma=
bly means
> > > > > > > that TPL set it up. But it doesn't mean that TPL put the FDT =
in there.
> > > > > >
> > > > > > This is wrong. The root problem is saying that the bloblist is =
in
> > > > > > possibly uninitialized memory. The code is quite happy to NOT f=
ind the
> > > > > > device tree in the bloblist and continue searching other paths.
> > > > >
> > > > > But until the bloblist is set up, it doesn't exist.
> > > >
> > > > An almost philosophical statement, yes. How should the generic code=
 know
> > > > if it exists, or does not exist? That is the question.
> > >
> > > U-Boot code 'knows', since if this is the first phase which enables
> > > CONFIG_IS_ENABLED(BLOBLOST), then the bloblist is available
> > > before/after relocation as well as after RAM setup in SPL.
> >
> > And when U-Boot isn't the first stage?
>=20
> The only case where that matters is for the devicetree, so we have
> OF_BLOBLIST to control whether U-Boot looks for it. Eventually we can
> drop BLOBLIST_FIXED and use registers, perhaps even on x86, which will
> make things easier.

The only reason it ever matters is if you're picking memory that's not
always accessible. Which is a bad choice and should be avoided whenever
possible and practical. Which it is here.

> > > > > We should not be
> > > > > looking for a bloblist that we know is not there yet. The bloblis=
t is set
> > > > > up by bloblist_init(). You seem to be imputing your own semantics=
 for
> > > > > bloblist.
> > > >
> > > > We don't know if the bloblist exists or not. That's the problem. It
> > > > could already exist. That's the whole reason we're in this particul=
ar
> > > > argument.
> > >
> > > See above.
> >
> > Yes, you seem to be missing the case where U-Boot isn't the first stage.
>=20
> I really can't see how you came to that conclusion. Just enable
> OF_BLOBLIST - in fact we can enable it for almost all boards today and
> it won't harm anything.

I mean, there's very few places using BLOBLIST today. But we can't
enable OF_BLOBLIST for any of them unless we say that the BLOBLIST
exists in always accessible memory. And that wouldn't be most of them.

> > > > > In SPL, init happens in board_init_r(), i.e. after RAM is set up.=
 So don't
> > > > > look in the bloblist until it is set up! It doesn't exist.
> > > >
> > > > Unless of course it was setup before. We don't know if it was setup
> > > > before or not until we look. A big part of the problem is that for =
prior
> > > > to U-Boot bloblist we don't need to use main DRAM, the bloblist is =
tiny
> > > > and we have some other persistent memory available. Unfortunately, =
x86
> > > > does not.
> > >
> > > The only situation where this matters is for the devicetree, which I
> > > why i created OF_BLOBLIST, a way to indicate that the bloblist should
> > > be checked for a devicetree.
> >
> > Yes, you keep looking at this from the wrong direction and seem to have
> > backed yourself in to a corner. Why are you insisting that for the
> > normal use case of memory infos and maybe display parameters we need to
> > carve out a hunk of main memory? A bloblist is perfectly capable of NOT
> > containing things. We can avoid having to care about what phase of
> > things we're in too.
>=20
> Devicetree is the only 'strange' thing here because we need to look at
> it early.

Device tree is also "strange" in that it's the only thing we read (not
write) today prior to U-Boot too from bloblist.

> For Raymond's patch, it shouldn't need any conditions.

Yes, and I replied to him that way too.

> > > > > In U-Boot proper, we look for it before relocation, so we can rel=
ocate and
> > > > > expand it for use with ACPI tables, etc.
> > > >
> > > > I'm not sure that's relevant. This means we've taken what we were p=
assed
> > > > at a fixed address and allocated more space for it and are using it
> > > > somewhere else.
> > >
> > > Yes
> > >
> > > >
> > > > > Take a look at this patch, too:
> > > > >
> > > > > 3d6531803e1 bloblist: Support initing from multiple places
> > > >
> > > > I'm not sure it's relevant. It does show we have a problem of not
> > > > knowing if the bloblist exists, or not. And I don't think we're sol=
ving
> > > > that right today (nor does v1 of my patch).
> > >
> > > OK
> > >
> > > >
> > > > > > An alternative here would be to better document the requirement=
s of
> > > > > > BLOBLIST_ADDR, and then just disable it on chromebook_coral unt=
il
> > > > > > someone is inclined to move DDR init in to TPL, or someone find=
s a
> > > > > > non-main-memory address to use for BLOBLIST_ADDR or switches to=
 using
> > > > > > BLOBLIST_ALLOC.
> > > > >
> > > > > Coral's TPL runs in cache-as-ram, with a 30KB limit on code size.=
 It cannot
> > > > > do DDR init in TPL because the DDR blob is large (160KB?) and the=
re is a
> > > > > ton of setup to do first, in any case. When CAR goes away, its me=
mory
> > > > > vanishes, so you need to have copied the bloblist somewhere else =
(the
> > > > > bloblist holds the MRC data which needs to be written to SPI flas=
h later
> > > > > on, when possible). This all works perfectly and there is really =
no need to
> > > > > change anything.
> > > >
> > > > Ah, so there's some of the details finally. And oh goodness, we're
> > > > writing to the SPI flash on each boot? That's not good for longevit=
y...
> > >
> > > It writes a sector each time, across an area which can hold quite a
> > > few writes. It only writes when the details change, so it is fine.
> > > This algorithm has worked in the field for years across tens of
> > > millions of devices and is common on x86.
> >
> > To be clear, I wasn't saying that its your design.
>=20
> No, it isn't my design, but I would be happy if it were. You were
> suggesting it had a longevity problem, so I wanted to explain it.
>=20
> >
> > > > > Again, you seem to be imputing semantics to bloblist which don't =
exist.
> > > >
> > > > Unfortunately some things were missed along the way, and are still
> > > > missing.
> > >
> > > Well we should have started from OF_BLOBLIST and then dealt with
> > > problems as they came up. In fact, so far there are no problems which
> > > it can't solve.
> > >
> > > As it is, we have Raymond sending a patch to push the prior-stage mess
> > > into TPM, for reasons which make no sense to me. It is just adding
> > > confusion.
> > >
> > > One other thing we would have likely done by now if my patch[1] had
> > > gone in a year ago, is moving away from BLOBLIST_FIXED to using a
> > > register protocol. That is more deterministic.
> > >
> > > Regards,
> > > Simon
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.3=
15916-31-sjg@chromium.org/
> >
> > I think once again your obsession with OF_BLOBLIST and device tree is
> > causing you to miss everything else. Today we can take a *bloblist* via
> > register. Linaro wrote that, even. The next problem really is that we
> > can't pass that bloblist along to the next stage because all of the
> > U-Boot side of things assumes fixed address.
>=20
> Perhaps if we had applied OF_BLOBLIST a year ago, so my special 3
> ancient chromebooks that nobody cares about or uses apart from me,
> worked, we could have got bloblist to where it should be today. You
> are missing the big picture, but stopping me from pursuing it.
>=20
> I am disappointed that it is only at this stage that you have shown
> any interest in getting my special 3 ancient chromebooks running.

And I am disappointed that it's only at this stage there's an
understanding of what the actual problem is with your special 3 ancient
chromebooks. Everything last year was read by me as you arguing that you
need a way to control passing the device tree because that's where the
device tree is:
https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.315916-31-s=
jg@chromium.org/#3174895
And if not every at least most of your other replies in that thread are
about how device tree is passed in. This is why I assumed that your
boards were working after having a way to enforce that the device tree
comes from bloblist.

So if there's some "big picture" about bloblist being delayed, it is
because once again your vision isn't communicated to everyone else
you're trying to work with and that is the big problem.

--=20
Tom

--XYYe0m7d8CM7EMDU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdiFLoACgkQFHw5/5Y0
tywpjgwAtvyNUymQx2kutWevl4PDNOmc7OTNADsIEXldzTRzTBPvonHyU7DutFeF
GDLi1/2+W8z9flEGQl1BShqPamQi2rOCbVGb5YSgdcHoS1qtV+IdzWLtb5+3dIu0
fvllc4l7FOw2+n0FZoI6g/qQSk2AKgVduDzlVZsyUFqKmH7hPSufdy2OTmT/Dzl8
7tDM1Ba3G9OVPF8JGz/IEWwsq0dTz+gza+CMlQwaUC7J5HO+kN2HsWK4BQv9hh03
cKs1MoC5Cr/RNOQmxCQH6VcYzSIY6KHVLlWS6v+iUxq3fh+1MdnbinAhT86vRYJR
zO889re8CrgSq+YOuHbQxHDuHBVewKsFriPN/wO+SNq6etVdrCv1HGEPMUKWE2lJ
40aVYaC0E2XZlu00itD0741HCz/BnFWW/Ee3SjNyfwEr/Vy/SMHIIblPpnzBMN1t
zTJVNfjsuibe0M8TjcEkvxbshXsXg9mtvXXnRvly/VTjx28LYwQo7w9P3d6uGD1S
DyBoIBIq
=g0Qo
-----END PGP SIGNATURE-----

--XYYe0m7d8CM7EMDU--
