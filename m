Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BE9C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 19:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA1D5875C3;
	Tue,  7 Nov 2023 20:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SdU/E2LX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C5E87584; Tue,  7 Nov 2023 20:04:49 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C1FB87485
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 20:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7789cc5c8ccso590685a.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 11:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699383885; x=1699988685; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aOoY8afhbSNgUbAHQjKIKT8bwkvupwpmuTokunBb1ok=;
 b=SdU/E2LXDpFhXyenDe1J9OgZNlQd7bYoz2DS/dR+6Pf6lgwBut0dtUdi5v6D+hS7xY
 j+bTyjhWdiO6CAR6ybRHBo8mhL2h93mZV8X5mImIplYqkptOtXJPcEh0NsnZrKiqA0zw
 2kQf7oKdl4jNkFa05WBcBq3ds8MX/93HY6I/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383885; x=1699988685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOoY8afhbSNgUbAHQjKIKT8bwkvupwpmuTokunBb1ok=;
 b=ikPF2H4r0t0Cphfmb/BqDhSOfxzGYoTyb+TEsarhNpzDK8Fj28FxcbYONaErNpM15G
 75eOtx/JBpU8AOmaTmGyOi+JZniZz4OA6WgMreDiqCsJ1hqYA3m2ruWVYjbx7n4eOFBZ
 UxQc/RQaQr0AdQJpG4pfRzSD0DsALNJJqSVIf30uMxjpIO0GtsEsMq9JcC0tJ8lig5FR
 4gCFbYNax2YVLltqOGMxaa0jDWsQh3s3hL313FQtMM8oRTMr/4D9YwfkGUmk1ewAtXW8
 EGjmDdl8UK/O0z6N3F1Fyx67KcowpkrmTq6q1dsG6hkI32MYHRfroM6IrKSkATQUR575
 4MxA==
X-Gm-Message-State: AOJu0Yz3P8SjPLZuX0XXAwoyhldNdDpO2LHa09DocKpB9t73BFUi4JcR
 4cnjWzuxZVkezcv6BiTgBZOttA==
X-Google-Smtp-Source: AGHT+IFe3pFpr601t2eOdzHtO38hUVUYyKlX9drxCOnx48gcym/fv8/WegaJpu6uF2b51Jm6M+43Jg==
X-Received: by 2002:a05:620a:2989:b0:77a:40ae:2e71 with SMTP id
 r9-20020a05620a298900b0077a40ae2e71mr4620112qkp.28.1699383885010; 
 Tue, 07 Nov 2023 11:04:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a05620a0a4100b0077703f31496sm176346qka.92.2023.11.07.11.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:04:44 -0800 (PST)
Date: Tue, 7 Nov 2023 14:04:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 0/4] bootm: Handle compressed arm64 images with bootm
Message-ID: <20231107190442.GM6601@bill-the-cat>
References: <20231105200453.1887418-1-sjg@chromium.org>
 <7a1345b9-8844-48e9-a1b5-8c7508cefeb1@prevas.dk>
 <CAPnjgZ1BbpM_Ksr5aKg2zWLv1FPy-N_Kz6fbrkZoh=i7LfpMUA@mail.gmail.com>
 <20231107130450.GA6601@bill-the-cat>
 <CAPnjgZ0jFTG-Rq0u5yaMjSxcxdQvr578W2P+nzFx0g0GbQHjNQ@mail.gmail.com>
 <20231107134946.GD6601@bill-the-cat>
 <CAPnjgZ2L62r2V7jtYGA2s6tKQsbYGj0q92BHhfo11UKKmWbLfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lye/J0jIYBvumkA9"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2L62r2V7jtYGA2s6tKQsbYGj0q92BHhfo11UKKmWbLfg@mail.gmail.com>
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


--Lye/J0jIYBvumkA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 07:30:33AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 7 Nov 2023 at 06:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 07, 2023 at 06:31:15AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 7 Nov 2023 at 06:04, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Nov 07, 2023 at 05:23:05AM -0700, Simon Glass wrote:
> > > > > Hi Rasmus,
> > > > >
> > > > > On Tue, 7 Nov 2023 at 02:56, Rasmus Villemoes
> > > > > <rasmus.villemoes@prevas.dk> wrote:
> > > > > >
> > > > > > On 05/11/2023 21.03, Simon Glass wrote:
> > > > > > > This little series corrects a problem I noticed with arm64 im=
ages,
> > > > > > > where the kernel is not recognised:
> > > > > >
> > > > > > The $subject is misleading, bootm works just fine with compress=
ed arm64
> > > > > > images, with the type set to "kernel".
> > > > > >
> > > > > > >         Type:         Kernel Image (no loading done)
> > > > > > >         Compression:  gzip compressed
> > > > > >
> > > > > > Isn't that a non-sensical combination to begin with? Decompress=
ing the
> > > > > > Image.gz kernel image to any location (however you determine th=
at
> > > > > > destination) _is_ loading it.
> > > > >
> > > > > Yes, I agree.
> > > > >
> > > > > >
> > > > > > If you want XIP, obviously the image must be uncompressed in th=
e FIT. I
> > > > > > don't understand what you're trying to do here.
> > > > >
> > > > > Hmmm, I think I have just got confused about all of this, perhaps
> > > > > because ChromeOS uses kernel_noload with compression. Is that an
> > > > > invalid combination?
> > > >
> > > > Yes, that sounds like an invalid combination.
> > > >
> > > > > But then how does loading actually work? We don't want to put the=
 load
> > > > > address in the FIT, since we don't know what it is...we want to u=
se
> > > > > the address provided by the board. Which is kernel_noload...so how
> > > > > should this be implemented?
> > > >
> > > > What do you mean, provided by the board? With kernel_noload we XIP =
the
> > > > payload, because the board provided (by loading us to) a safe place=
 to
> > > > execute whatevers in there. In the olden days, that would mean (alm=
ost
> > > > certainly) the zImage which in turn was already compressed and
> > > > self-relocating. I know technically one could use the raw vmlinux
> > > > instead. With the Linux Kernel and ARCH=3Darm64 (and a few other ar=
ches
> > > > now too), they dropped the self-decompression part and the whole pa=
yload
> > > > must be decompressed. We handle this case in "booti" today by havin=
g to
> > > > have the board (via environment) say where to decompress to (and how
> > > > much space is available). Then we move it back to where we started =
=66rom,
> > > > which is likely not necessary.
> > > >
> > > > Looking at
> > > > https://www.kernel.org/doc/html/latest/arch/arm64/booting.html and
> > > > https://www.kernel.org/doc/html/latest/riscv/boot-image-header.html
> > > > stating "we're just like arm64" we can do better than we do today f=
or
> > > > this format of OS image. If aren't compressed, we only need to ensu=
re
> > > > that we are correctly aligned and move (and tell the user) if not. =
We
> > > > can even put the 2MB check under some legacy kernel CONFIG option (=
3.17
> > > > is over 9 years old). With respect to automatic decompression, if we
> > > > don't have something telling us where a buffer is and we can't pull=
 from
> > > > the environment, we should tell the user and stop?
> > >
> > > With the booti command, the kern_comp_addr_r and kern_comp_size vars
> > > are used. Perhaps I should update my patch to use those too?
> >
> > As a fallback, perhaps? But what do we do today in a FIT to handle
> > compression =3D "gzip" to know where to uncompress things to?
>=20
> In that case we decompress to the (kernel) load address in the FIT.

And handle overlap, so there's some small window where you just need to
not load the FIT to memory at that address as it's just Not Possible,
yes? I think that's how I recall how it works out.

> > > Do you understand what I am asking about, with bootm? It should be
> > > possible to ignore the load address. In fact, load addresses in FIT
> > > are mostly bad these days, IMO. If this is not kernel_noload, then
> > > what should we use?
> >
> > Well, your use case needs to be valid. I don't think "kernel_noload" is
> > valid with anything other than 'compression =3D "none"' because that's =
our
> > just execute things in place option. It's very dangerous to use and I
> > do not recall right now if we fixed the case where it will just let the
> > device tree be badly aligned and break the kernel, or if we say "no
> > load, but still fix THAT alignment". And your use case isn't "ignore the
> > load address" it's "ignore the load address and decompress the
> > payload(s)".  That needs _something_ to be known somehow. And I'm asking
> > how we do that today even, before saying we can or can't support
> > "kernel_noload" along with a compression of the payload.
>=20
> OK I see.
>=20
> >
> > > "provided by the board" means that the board knows the memory map, not
> > > the FIT, so only the board can provide the addresses to use for
> > > loading the kernel.
> >
> > To be clearer, where does the board document that knowledge and provide
> > it to be used? I'm not a super fan of environment variables especially
> > since we aren't always consistent with '_' or just nothing between
> > "words" of the variable. We have much better documentation these days
> > (once again, thanks everyone) so we can document environment variables
> > used here, and also what CONFIG options are used (as
> > CONFIG_SYS_BOOTM_LEN is part of the equation here and badly named as
> > been said in other threads about issues wrt decomp and overlap).
>=20
> I agree about env vars. We have CONFIG_SYS_LOAD_ADDR which seems like
> a better model to me.

Maybe? Looking at the Kconfig entry for SYS_LOAD_ADDR the defaults here
are some really really really long-standing inherited values (why so
many times are we at base of DRAM + 32MB? It was probably good enough to
not be where we are or were running). Sometimes we then use that for
kernel_addr_r, sometimes we don't, and in turn that's because sometimes
we thought harder about how to avoid memory moves, and sometimes didn't.

I'm not immediately sure if this is a good idea to re-use, or a bad idea
to re-use, especially if we're then assuming the rest of the use case is
XIP.

> At the moment we have these, which have carried over from the
> distroboot scripts:
>=20
> https://u-boot.readthedocs.io/en/latest/develop/bootstd.html#environment-=
variables
>=20
> So I think we should be using kern_comp_addr_r as the buffer to
> decompress to

In that a lot of effort has been put in to documenting and setting these
variables, yes, re-using that variable as where FIT can be told where to
uncompress to and how much if we have no other value, is good.

> , with kernel_noload. But as you say, having env vars
> affect bootm (and boot ) is not ideal.

I'm still not sure about kernel_noload.

> Another thing we need to clarify is what kernel_noload means.

Yes, we do. I think it's unfortunately on the list of things that
weren't documented well enough in FIT and people assumed what it did and
didn't actually do.

> I have
> taken it to mean 'ignore the load address in the FIT', not 'no loading
> is done', since if compression is enabled, we have to load it to
> somewhere.

OK, but that's not what it means in code. The first step is to document
what cases do, and do not, work in a FIT image today, for a few
different payload options, probably at least
kernel/ramdisk/flatdt/kernel_noload and how it handles compression. I
know at one point there was some confusion about what happens when you
pass a ramdisk.gz and say compression =3D "gzip" and then what people
expected that to mean instead of what it did, and so what it does right
now.

> IMO 'ignore the load in the FIT' should be the normal situation with boot=
std.

Oh no. That's getting things in the wrong order. We need to document
what kernel_noload actually does, today.

And we need to also look harder at our code for handling
Linux-Kernel-arm64-and-riscv-Image files because in the non-compressed
case the Image is probably at an XIP location (2MiB alignment is pretty
likely, we do need to check of course) and the initrd can be wherever,
and we only need to ensure the device tree is 8-byte aligned in memory.
So I think we may have some not-required moving happening at least in
the compressed case.

Then we can see if kernel_noload can sanely support something other than
'compression =3D "none"'.

Then whatever bootmeth is looking for and finding FIT images will take
whatever valid FIT images are found and boot them. And that may or may
not include having an Image that's compressed. I see that for example
the default v6.6 arm64 kernel has ~1k modules, but the Fedora 38 kernel
has ~4500 and so the distro Image is about the same size as the v6.6
Image.gz. As just a general size example.

--=20
Tom

--Lye/J0jIYBvumkA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKikMACgkQFHw5/5Y0
tyx4jAv+KfhVu9Gc1LB3MqOP+wXXJkzOybkDi9+tjaKL+U9ri1k6gGCCtxB8mdHA
ladHtllIN0mfkhnV71BaOglMXiJIZ0eRqMD37Waln3N4T9AcqGubh9hQkFaYgTPr
qDR9bFzIdW3wFf5PHoZUpKeTtbTLH0cFo4LAVQGoeYaUAslQdHwQe6X+ShmWu4ns
3FQj6/aQXUY02XVCpzlKDEulP4fyPmZDKOsz3qPhOvKpX5YKGmVkqmgy4oHfHKPI
bOfmZyJY/J5jb6qEJuZJCT0wzK9MJEKDxROpq6REjhysopi6Qm6cLh1nIcGrRhIM
rW2z+wPew9l8Qs2LW4UHn3W8EpOmH3jxyxvDo+UEBnyELaECsgo8ksZrYC29mt/4
GfGEfIkTUR9X1bTGoomei9nGPbCKuhntDxtO2FEaWZVyBSIYSGm9qp7KO8UeM67s
wqSJFSDVFQz1R663jF6ltuodsmizWs3WDazaK64f1pdYUlQsmtwGXk+BjpZw6t7o
lYcm98Ir
=j1oa
-----END PGP SIGNATURE-----

--Lye/J0jIYBvumkA9--
