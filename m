Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91184E6FE27
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 15:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E7888D16;
	Fri,  6 Sep 2024 17:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qlqVHgR9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A2388D1A; Fri,  6 Sep 2024 17:29:17 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E63488CD8
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 17:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4581d2b0fbaso1542011cf.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725636554; x=1726241354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OJnixdtbihiCL1qzclA8Q3nbDmpTvQFHQXxRsugtV/8=;
 b=qlqVHgR9R9OWHeWUXm+y+b4o9NYxDab4bo+vlLF7+Lg+L2qkMr49d8dz3Emk0tWf8h
 SOg5MgaHkb3Lb0v2T/Ov7DHmMM1x4X27UHJC6QTnBfkQE+Ts9q7Iop9+fxVvqEU0k/aY
 i21JDOeGqMDF8VJXtL+0DVDzhDoE6ICl9MNPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725636554; x=1726241354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJnixdtbihiCL1qzclA8Q3nbDmpTvQFHQXxRsugtV/8=;
 b=kgVUd406lidkbsZr2kSvsF3ZMvztWZu0CCMoQd/iVKdWyHdCn7OFbn/xoDzodgIan9
 +rx3yywBuiQTglhpcSFecOa4GuhCQXgV2BYYtqkB8CroZdpcmVF+NUSTCIXvtroJdjT2
 nW8bpyU2hRfN28hkmoC6YRV7xh8uMzvu89ThyszLKf6fwfpmugITwV4W0VOfGzpiGACr
 XZHy2Y+0tnNMDtkXelhUgHTXGZ6rRZl9/9dDmg8MUJZchvZypzDi18Cs/hvXmPnMeTnz
 PxLYuoYrOV7D2ouWL3QqtOUPq6Hv5s8QkVtceWwrspVNEbE5x+0ohICI5T0JcNvcpCF+
 wjrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpM/5ETJkvEhlekgCcWKWOvHf2mIyyFAl5LAKyf3ZhmCyb8gSAChEX5xBw9vZdTnUe0RifGzU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxyg36innspw3m+Dh/wpCv37EvlFFHNVHGatSzUgfId6u2vbHCO
 RXpNtlks7aN0rOc/h4XsRk8amg7Jkc4PyEb7hki1nPAZJvaVJPnM/4NSEgAgWZU=
X-Google-Smtp-Source: AGHT+IG8Ut2af3emi7+ridk9NixZ6siVJFQoeXh0ScHGKve0FC8B4FAGqr8ijWX3onVoKdfv33CRrA==
X-Received: by 2002:ac8:7f8e:0:b0:457:c6a3:acc9 with SMTP id
 d75a77b69052e-4580c7599c5mr37519001cf.38.1725636553873; 
 Fri, 06 Sep 2024 08:29:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801a1524esm17006571cf.4.2024.09.06.08.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 08:29:13 -0700 (PDT)
Date: Fri, 6 Sep 2024 09:29:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: fdt: use U-Boot's FDT by default
Message-ID: <20240906152910.GC3879073@bill-the-cat>
References: <20240831164639.2298097-1-caleb.connolly@linaro.org>
 <20240903191422.GM2479150@bill-the-cat>
 <722e2465-bd96-4fe5-a154-d48fbe78a975@linaro.org>
 <CAFLszTiXkq5=E_O8Y1o3NrAN+Y1ZoDmqrwSP9QwzF3pSoufZKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kscdu5ULsk0Z8geR"
Content-Disposition: inline
In-Reply-To: <CAFLszTiXkq5=E_O8Y1o3NrAN+Y1ZoDmqrwSP9QwzF3pSoufZKg@mail.gmail.com>
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


--Kscdu5ULsk0Z8geR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 09:02:25AM -0600, Simon Glass wrote:
> Hi Caleb,
>=20
> On Fri, 6 Sept 2024 at 03:31, Caleb Connolly <caleb.connolly@linaro.org> =
wrote:
> >
> >
> >
> > On 03/09/2024 20:14, Tom Rini wrote:
> > > On Sat, Aug 31, 2024 at 05:46:19PM +0100, Caleb Connolly wrote:
> > >
> > >> When using the FDT command to inspect an arbitrary FDT in memory, it
> > >> will always be necessary to explicitly set the FDT address. However =
it
> > >> is also quite likely that the command is being used to inspect U-Boo=
t's
> > >> own FDT. Simplify that common workflow of running "fdt addr -c" to g=
et
> > >> the control address and set it by just making $fdtcontroladdr the
> > >> default FDT if there isn't one.
> > >>
> > >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > >> ---
> > >>   cmd/fdt.c | 9 +++++++++
> > >>   1 file changed, 9 insertions(+)
> > >>
> > >> diff --git a/cmd/fdt.c b/cmd/fdt.c
> > >> index d16b141ce32d..8909706e2483 100644
> > >> --- a/cmd/fdt.c
> > >> +++ b/cmd/fdt.c
> > >> @@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int fl=
ag, int argc, char *const argv[])
> > >>
> > >>              return CMD_RET_SUCCESS;
> > >>      }
> > >>
> > >> +    /* Try using U-Boot's FDT by default */
> > >> +    if (!working_fdt) {
> > >> +            struct fdt_header *addr;
> > >> +
> > >> +            addr =3D (void *)env_get_hex("fdtcontroladdr", 0);
> > >> +            if (addr && fdt_check_header(&addr))
> > >> +                    set_working_fdt_addr((phys_addr_t)addr);
> > >> +    }
> > >> +
> > >>      if (!working_fdt) {
> > >>              puts("No FDT memory address configured. Please configur=
e\n"
> > >>                   "the FDT address via \"fdt addr <address>\" comman=
d.\n"
> > >>                   "Aborting!\n");
> > >
> > > Setting aside the behavior change (which I am thinking about), this
> > > makes the next check of !working_fdt dead code which should be remove=
d.
> >
> > I wasn't sure if we could safely assume that fdtcontroladdr always
> > points to a valid FDT, if that's true then yes this can be dropped.
>=20
> $ ./tools/qconfig.py -f ~OF_CONTROL
> 11 matches
> integratorap_cm720t integratorap_cm920t integratorap_cm926ejs
> integratorap_cm946es integratorcp_cm1136 integratorcp_cm920t
> integratorcp_cm926ejs integratorcp_cm946es mx6memcal work_92105 xtfpga
>=20
> So yes, there are boards where it would not be set.

Well, mx6memcal is special. Perhaps all of those integrator boards need
dropping? And I'm not sure what's going on with xtfpga...

--=20
Tom

--Kscdu5ULsk0Z8geR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbbH8YACgkQFHw5/5Y0
tyzkAwv8DP+ELZLzPam8V5J7ckOZNXaOMGtnOKdGmgxBdUwNelBpZf+uARIepxCl
ydQLXBn3WowAITRKo9XeMV8A5mKB+Sq33a6EJanTGxG7bVztP0yO/vM99wFs82c8
Wh0yDLuBVKLBaKcpNEcYgxmr7sBRxI4hCXxNySvnqQ2T3tly/cqunZ0bMTFlZXya
rooKUvHxGnTwERwV5vQTQnXEyKmRlN3juV/libH3Adl3GLtQv5yc1IuIg46rWecc
QscCBOjFc1k3JE1XTnphx0HAec+Q4ujgt4ulsU0tiOmMeDgIes68QgvCfaQBzT1g
gQgBEI13puh+HJjYch8pe56LkJ8XIbGNsM0C7vwrnVlExy9FuIYTajZP7hDoxzN1
S4kKw7gwaw+T65LPI3MKkuhkzSSyxes4pd7JhBsHlDDR6wgjSbnKvKs7aWLcgvzH
trbCA+MhhLaqLQ4lAL4G+PB7k9Tw6V0A6SrP5yUDn6IZq6iP9Ose3O8VLYV9H3CI
4s0cMDiX
=R+Yw
-----END PGP SIGNATURE-----

--Kscdu5ULsk0Z8geR--
