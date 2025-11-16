Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891F7CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A16F98398C;
	Sun, 16 Nov 2025 15:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WiBk5UrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7185D8398C; Sun, 16 Nov 2025 15:09:20 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1976883979
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-450c9057988so31529b6e.1
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 06:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763302157; x=1763906957; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s8K9s1UmBJUMsuZrhkWgWSumAlKW5Klcee6h9IaOlC0=;
 b=WiBk5UrPs6Fq1oD6D2v1c+nOTnb1TuaAoWkW3FsDLFmsZFS1UnCr0kb+Crz+jaF46C
 +n7HBqh9xC3vzD7NptkOGk2/wHvnoJNkjWH4k0nKRP2j9jYHvlcyuS9nfWNc+a7Sj7JC
 2cQ8UFsb/6rKLJvOki//ChPFibe+NyERlao3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763302157; x=1763906957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8K9s1UmBJUMsuZrhkWgWSumAlKW5Klcee6h9IaOlC0=;
 b=aeT4mSfg+NMEBASKAkP7kQtGE1b40Mngb7xtdwAbRqd11kOgo02L2pqotSc+MV+X8X
 MnsGTiXJ1EQrYLEVTeSWqA54kMEcywb+fqB2ZyOVrWHQxXbeqKqoij9RzK2ASrj/LDE6
 Xc98D20YA7LsRYPgNe81bcx9t2UQdHc5RoH+5oUPL9zuDL0m9YBt0m3INUPNsy4ITi50
 gIvnpLpFYy2v00fNU4gJE5ogBhFQN7iccgqfE7ozpjLHqCp3G7OYb3Fm+WHIDDIcqYIN
 ojJOicTuBxXRFCem+lBbCP7CDhj/IR7mFfsWUMoUpuWHkJl/y7dTFrZ62wEnAH5ZKPbx
 41Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdD3xXZ/ZbgnAO/V6/I7eK5Yfz+U6jYhz4V7LEMvoxER31kVOFFZuWrHhPJpIu24bCRSrFY0s=@lists.denx.de
X-Gm-Message-State: AOJu0YwCkoYxWJ6grlN2s98LOKoRuZJff+7a7vLRpg0f60tXdliKfaGh
 PridCovtZXAaTUnbog5A8TUUv0tV00JS6mweiFcIWp74YggU5PfHoaiB+d1FwjymSho=
X-Gm-Gg: ASbGncvz4UEnR7ZTp+qrBd9LdzKEMnrbTMl0Rmu6tGyZbC0shh7U7gRfX4nKOci75GR
 g8xDrf5Fj8Qb0C+fUB4+4TRIYjs0tSx/B4r+0bQKW7v9b91G1pZDS3z+7j9JOETUls0CPUhG31R
 15X6RsYXK2hdRsoWy/RHH/WzFqfqMhO+U/xpH01ap0Enb/hRUfnNFAhyRKCe6PpD1pY4/1qonXg
 6k7Af+pPcFsgZRmSyDQZJVbwsLyDU13Z0a+N30ewFBZ5u6m8pBV2B6c+0U7UmOf9M6Q/RJmuH5i
 D1Hp3+NyXCc64xRWXXCz7Rox+r9gjNOxhGFOXViekhjCGXdePJMtTM+8VyNds7zg7wtpzbvfjd2
 DHcroq/K6w5rnyXrksceKAykqsgvkCmfxA616CABT7+GQOxQK2Bx+m9HjlCZZmW+aYhdA3om2+9
 9ie5Wd1H9viIg9pIY8ls35rcZouTMdTsY/B1vjbZI=
X-Google-Smtp-Source: AGHT+IHJEDoxqolBaN5xYNQLdRxDStpXQX3i0xhmpWRvJCkmzUh8/iBsTn8g+sDFVlSvtao/kTY0BA==
X-Received: by 2002:a05:6808:4703:b0:450:32f0:4887 with SMTP id
 5614622812f47-4509751b179mr4283395b6e.31.1763302156788; 
 Sun, 16 Nov 2025 06:09:16 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a6d3218sm3579466b6e.20.2025.11.16.06.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 06:09:15 -0800 (PST)
Date: Sun, 16 Nov 2025 08:09:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] boot: Warn users about fdt_high=~0 usage
Message-ID: <20251116140913.GB2125796@bill-the-cat>
References: <20251113142957.1069909-1-marek.vasut+renesas@mailbox.org>
 <20251113154900.GJ6688@bill-the-cat>
 <07424e88-16f8-4332-b93c-f0baeed5758c@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F1reAYFAFq6Bu5Yo"
Content-Disposition: inline
In-Reply-To: <07424e88-16f8-4332-b93c-f0baeed5758c@mailbox.org>
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


--F1reAYFAFq6Bu5Yo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 06:34:24PM +0100, Marek Vasut wrote:
> On 11/13/25 4:49 PM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > > diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> > > index 3f0ac54f76f..e88525a3846 100644
> > > --- a/boot/image-fdt.c
> > > +++ b/boot/image-fdt.c
> > > @@ -189,6 +189,10 @@ int boot_relocate_fdt(char **of_flat_tree, ulong=
 *of_size)
> > >   			/* All ones means use fdt in place */
> > >   			of_start =3D fdt_blob;
> > >   			addr =3D map_to_sysmem(fdt_blob);
> > > +			if (addr & 7) {
> > > +				printf("WARNING: The 'fdt_high' environment variable is set to ~=
0 and DT is at non-8-byte aligned address.\nWARNING: This system will likel=
y fail to boot. Unset 'fdt_high' environment variable and submit fix upstre=
am.\n");
> > > +			}
> > > +
> > >   			err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
> > >   					    of_len, LMB_NONE);
> > >   			if (err) {
> >=20
> > I think we need to yell about it sooner.
>=20
> I don't think so, for two reasons:
>=20
> - If the user uses e.g. bootz to boot their kernel, which on arm32 is sti=
ll
> sadly happening, they wouldn't trigger this problem at all and they would=
n't
> care about whichever way their fdt_high is set.

Which part of the problem? If the dtb is not 8-byte aligned the kernel
will fail. All the accessors require 8 byte alignment.

> - If the user sets 'fdt_high' as part of their boot command, they would n=
ot
> get any warning print if we warn earlier, but they would get one when they
> boot and trigger this affected code path.
>=20
> Maybe we need warnings in two locations ?

Maybe? I was thinking it should be around this in boot/image-fdt.c:
        /* If fdt_high is set use it to select the relocation address */
        fdt_high =3D env_get("fdt_high");
        if (fdt_high) {
                ulong high_addr =3D hextoul(fdt_high, NULL);

                if (high_addr =3D=3D ~0UL) {
                        /* All ones means use fdt in place */


As that's where all of the code paths end up calling, I think. But if
it's multiple paths, yes, multiple warnings if we can't abstract it out
to a common path.

> > Today (and for quite some
> > years) if you pass a 4 byte and not 8 byte aligned DT to Linux, it fails
> > to boot or breaks in loud
>=20
> Worse, not loud, but silent.

Also true, yes.

> > and odd ways. This has in turn lead to much
> > time spent and some of our older threads with the libfdt folks years
> > ago. So I think we need something earlier in code where we're seeing
> > that fdt_high is set to ~0 and that's where we say "Stop doing this, it
> > will be removed soon".
>=20
> We cannot remove this functionality, someone might actually depend on it =
for
> whatever reason. It is part of the command line ABI now.

The valid use case is boot time optimization. It's also a
micro-optimization (as actually megabyte sized device trees like when
people wanted to pass FPGA bitstreams in 15+ years ago are not allowed)
I think really. I am loath to break ABI like this but I'm not entirely
sure we have a choice. Maybe we detect disabled relocation and
misaligned device tree and fall back to prompt? Or if it's too late,
panic with an explanation? Or maybe we just move it 4 bytes higher. The
device is in a going to fail state anyhow, so trying to recover it might
be OK, and since the device tree needs to be modified by us it has to be
in writable memory.

--=20
Tom

--F1reAYFAFq6Bu5Yo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRnbBgAKCRAr4qD1Cr/k
ChRcAQC2+MFY5PMfprD/ySG2Hhii6td2Osn8wmP9PsuCU3D/qQD+Lil73QxGl/5n
8mHVlGGOPPpxoN5CDDDZ5OH8QU15fQA=
=ZsS2
-----END PGP SIGNATURE-----

--F1reAYFAFq6Bu5Yo--
