Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F41CEBF61
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 14:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDC183946;
	Mon, 17 Nov 2025 15:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tA93n4Jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD4B08399B; Mon, 17 Nov 2025 15:32:51 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1865A8391B
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 15:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c75b829eb6so1018348a34.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 06:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763389968; x=1763994768; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OSmB2ChVvYEE/+XoR0XZAbV+5fsjVNgMOsj2vBDRwt8=;
 b=tA93n4Jj7HRnSxWQb5jbe3qDauIQbYfX9cReLN22B5BDQ7f7s0bCtiNK0/bsm2RwUJ
 MTbVxs2PJDDSMvApxa4/klP2X7jJGMI1ZsWq/nBTps2/nhpOr00F0hC5B42oSGoeX2td
 xvYbsiul73D+jrsAn8hP7T0LLylh6RbcaRwR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763389968; x=1763994768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSmB2ChVvYEE/+XoR0XZAbV+5fsjVNgMOsj2vBDRwt8=;
 b=tSqoQ4uYRr7FJmV9jWqRaukTgi0sX9qQ+e9B/pWl61XhSLaG2d3tONtsTsA1BJPbkH
 MKlAzKVF2wMhlKRhO1UtrvrXWp8IzMdc/Y+mS1wm3JcKMSZgpZVMnBbiJvmtlgwJ2jBu
 BJiJ5fr32RpDMsUA9IDXhM68lfBNQKD6HkZz7y3QqXZ4j2weDzaBuixgQCPD+rXm8DGD
 OJVgGQO7Zww9KUTe/sdtepPoRowcfU2GUPb/tiwRa/loMt+TbVn2xUR1fBzNseYvCGZ7
 T+2ST973JjYOqahaJD7DiauuHsOkhuD9LTrbkqnxqBUvkN7o8MXwJ9AYBZZqoMIIBE1k
 t+OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsuZ99QPAcu+q/NlKnxHU/7FVFrsJnUF6cWQ+qITsO/bGrz3VCUFFjszIv8sepq3lPd4HHLgM=@lists.denx.de
X-Gm-Message-State: AOJu0YxeAV3No9glOWGltgoYLV62S2E0jk+mcE0lt19MTip1aKjTI58f
 RIO4lgHTssm95ud9hPvZfKFW5tXmxdagqgmV1u79x8PBi+VXM20g6lHNsc/hphdPkR0=
X-Gm-Gg: ASbGncsxnzmL5R4Q87tTb0/LU4nsFJsqnOmzIFXkJRKu9Fs56drbiGYkLDebroL5ho4
 c7tp8siXZQZBeW37vj7+XHUBJ5RSn3KTNPHhKk+QPZHYjuWEjNYIYDxGPgJpNr/kxE6sMWETLdF
 wzNZDw51onZ0NqSDLbbKbzMGOdZDyczwMqE2jl7ZBKsSlq6rKE4nuN8XehK838CfoPTC9ayGplv
 ZBD185S7BE+36OL6idxGEYTfm/krvCG7/3S0ezz89d6ZxH3m53hGzCuu8qDbIJMVMdNiKFuPxxD
 c2nKo2n0lML7Uu6HpRdpRz06ZES7EGCg73HV+N4/ARYrLFv6uLPcd7ZQN1O9E1nEo0uZ2JamFWH
 d2K/n0jacnNCTOGvQqBYPDekjn1N07lPCVhUAGAw6OomN6Zc4rBtzfTtpYJify+xGhjIsz3lWwK
 gRMPARUFiyBK2ASfpHr6nvBmkGB0UF72f4j7JpP9wL8Uefe4DXYA==
X-Google-Smtp-Source: AGHT+IEeFXNZnBwe2rz8EPvvKpk4SO/3kHY35FWIJc+1FW8Ix9XNmIa+b+mBzS06BfRv8Q7hrkQR0Q==
X-Received: by 2002:a05:6830:3081:b0:7c6:cf19:1dec with SMTP id
 46e09a7af769-7c7445fa032mr5369054a34.33.1763389967595; 
 Mon, 17 Nov 2025 06:32:47 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a3bddd2sm5419101a34.25.2025.11.17.06.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 06:32:47 -0800 (PST)
Date: Mon, 17 Nov 2025 08:32:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] boot: Warn users about fdt_high=~0 usage
Message-ID: <20251117143245.GH2125796@bill-the-cat>
References: <20251113142957.1069909-1-marek.vasut+renesas@mailbox.org>
 <20251113154900.GJ6688@bill-the-cat>
 <07424e88-16f8-4332-b93c-f0baeed5758c@mailbox.org>
 <20251116140913.GB2125796@bill-the-cat>
 <e619b3ac-d99a-468c-8275-a8db5b406e62@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tM1NHUK/1gTVbeeY"
Content-Disposition: inline
In-Reply-To: <e619b3ac-d99a-468c-8275-a8db5b406e62@mailbox.org>
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


--tM1NHUK/1gTVbeeY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 10:43:47PM +0100, Marek Vasut wrote:
> On 11/16/25 3:09 PM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > > > > diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> > > > > index 3f0ac54f76f..e88525a3846 100644
> > > > > --- a/boot/image-fdt.c
> > > > > +++ b/boot/image-fdt.c
> > > > > @@ -189,6 +189,10 @@ int boot_relocate_fdt(char **of_flat_tree, u=
long *of_size)
> > > > >    			/* All ones means use fdt in place */
> > > > >    			of_start =3D fdt_blob;
> > > > >    			addr =3D map_to_sysmem(fdt_blob);
> > > > > +			if (addr & 7) {
> > > > > +				printf("WARNING: The 'fdt_high' environment variable is set =
to ~0 and DT is at non-8-byte aligned address.\nWARNING: This system will l=
ikely fail to boot. Unset 'fdt_high' environment variable and submit fix up=
stream.\n");
> > > > > +			}
> > > > > +
> > > > >    			err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
> > > > >    					    of_len, LMB_NONE);
> > > > >    			if (err) {
> > > >=20
> > > > I think we need to yell about it sooner.
> > >=20
> > > I don't think so, for two reasons:
> > >=20
> > > - If the user uses e.g. bootz to boot their kernel, which on arm32 is=
 still
> > > sadly happening, they wouldn't trigger this problem at all and they w=
ouldn't
> > > care about whichever way their fdt_high is set.
> >=20
> > Which part of the problem? If the dtb is not 8-byte aligned the kernel
> > will fail. All the accessors require 8 byte alignment.
>=20
> On 64bit systems, yes. On 32bit systems it is not so clear cut, they might
> boot with 4-byte aligned DTs. I might be wrong about this, but if I recall
> it right, bootz is very simplistic and it doesn't handle much in terms of=
 DT
> relocation, and ignores fdt_high, so the users on those 32bit systems that
> use bootz to boot also don't care about fdt_high much.
>=20
> > > - If the user sets 'fdt_high' as part of their boot command, they wou=
ld not
> > > get any warning print if we warn earlier, but they would get one when=
 they
> > > boot and trigger this affected code path.
> > >=20
> > > Maybe we need warnings in two locations ?
> >=20
> > Maybe? I was thinking it should be around this in boot/image-fdt.c:
> >          /* If fdt_high is set use it to select the relocation address =
*/
> >          fdt_high =3D env_get("fdt_high");
> >          if (fdt_high) {
> >                  ulong high_addr =3D hextoul(fdt_high, NULL);
> >=20
> >                  if (high_addr =3D=3D ~0UL) {
> >                          /* All ones means use fdt in place */
>=20
> This is exactly the code that this patch modifies . Where in the above do
> you think this change should be ?

You're right and I did post the last line of context that's the first
line of your patch. I really meant that we shouldn't even be checking if
the current location is misaligned. We should tell people to stop
disabling relocation.

> > As that's where all of the code paths end up calling, I think. But if
> > it's multiple paths, yes, multiple warnings if we can't abstract it out
> > to a common path.
> >=20
> > > > Today (and for quite some
> > > > years) if you pass a 4 byte and not 8 byte aligned DT to Linux, it =
fails
> > > > to boot or breaks in loud
> > >=20
> > > Worse, not loud, but silent.
> >=20
> > Also true, yes.
> >=20
> > > > and odd ways. This has in turn lead to much
> > > > time spent and some of our older threads with the libfdt folks years
> > > > ago. So I think we need something earlier in code where we're seeing
> > > > that fdt_high is set to ~0 and that's where we say "Stop doing this=
, it
> > > > will be removed soon".
> > >=20
> > > We cannot remove this functionality, someone might actually depend on=
 it for
> > > whatever reason. It is part of the command line ABI now.
> >=20
> > The valid use case is boot time optimization. It's also a
> > micro-optimization (as actually megabyte sized device trees like when
> > people wanted to pass FPGA bitstreams in 15+ years ago are not allowed)
>=20
> ( not allowed where exactly ? fitImage is a DT too )

I wasn't clear enough. I mean having the FPGA bitstream as a device tree
node, for the linux kernel to parse. Because that's what fdt_high is
about, not FIT images :)

> > I think really. I am loath to break ABI like this but I'm not entirely
> > sure we have a choice.
>=20
> We do, we simply warn users and remove the usage and fdt_high=3D~0 assign=
ments
> from the tree. The functionality itself does not have to be removed.

The problem is the functionality has always been for a hack workaround
and bootm_low/bootm_size/etc were the right answer.

But maybe step one is just remove the in-tree usage and a big loud
warning when it's set telling people to not do that.

> > Maybe we detect disabled relocation and
> > misaligned device tree and fall back to prompt? Or if it's too late,
> > panic with an explanation? Or maybe we just move it 4 bytes higher. The
> > device is in a going to fail state anyhow, so trying to recover it might
> > be OK, and since the device tree needs to be modified by us it has to be
> > in writable memory.
> Keep in mind, on arm32 it may not necessarily fail to boot with 4-byte
> aligned DT.

I'm pretty sure it is. It's not a problem about doing misaligned reads
it's that the data structure and it's accessors require 8 byte
alignment. That's what I recall right now from everything around:
commit e8c2d25845c72c7202a628a97d45e31beea40668
Author: Tom Rini <trini@konsulko.com>
Date:   Mon Jan 27 12:10:31 2020 -0500

    libfdt: Revert 6dcb8ba4 from upstream libfdt
   =20
    In upstream libfdt, 6dcb8ba4 "libfdt: Add helpers for accessing
    unaligned words" introduced changes to support unaligned reads for ARM
    platforms and 11738cf01f15 "libfdt: Don't use memcpy to handle unaligned
    reads on ARM" improved the performance of these helpers.
   =20
    In practice however, this only occurs when the user has forced the
    device tree to be placed in memory in a non-aligned way, which in turn
    violates both our rules and the Linux Kernel rules for how things must
    reside in memory to function.
   =20
    This "in practice" part is important as handling these other cases adds
    visible (1 second or more) delay to boot in what would be considered the
    fast path of the code.
   =20
    Cc: Patrice CHOTARD <patrice.chotard@st.com>
    Cc: Patrick DELAUNAY <patrick.delaunay@st.com>
    Link: https://www.spinics.net/lists/devicetree-compiler/msg02972.html
    Signed-off-by: Tom Rini <trini@konsulko.com>
    Tested-by: Patrice Chotard <patrice.chotard@st.com>

--=20
Tom

--tM1NHUK/1gTVbeeY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRsyCQAKCRAr4qD1Cr/k
ClOHAP4j/75Simyw1wunYnG27ApyLBEzOUSqNXEUNiWGHR6QIQD/bEDNTqIS0QOW
sjiTf+ceekZBwgd1JmH6UlfWI5lRGAo=
=f7hL
-----END PGP SIGNATURE-----

--tM1NHUK/1gTVbeeY--
