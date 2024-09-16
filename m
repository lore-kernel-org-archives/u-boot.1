Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED5AC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 20:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1224988EA8;
	Mon, 16 Sep 2024 22:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GpMX8l3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2BFE88F15; Mon, 16 Sep 2024 22:42:13 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D5D87873
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 22:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-458320b30e7so34761481cf.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726519330; x=1727124130; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YLmettxYdCPAeeZHymqi630CybuHVwDfbc/fd0My6XI=;
 b=GpMX8l3rgxMhIkqhWZKrUAbNpQWV8gZDDwxCa+7bCfyYzBaxMjcUSWV57LAdInKspd
 fWzPXP+D3kMwt4V5XdlJYVqlvIrXgEVIOQ2Ki5Ad5hRjBlImV15wGQMs2gnzYQOuEQ48
 R5YrvMUQGZI7l1HHYy8gt9Jo4KP0P9YTBB6VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726519330; x=1727124130;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLmettxYdCPAeeZHymqi630CybuHVwDfbc/fd0My6XI=;
 b=Ljw04mE+VT2TPHTbMGLcEUq1S58SUeeS0+BpjOz6QdmSOqHsyGpEap0PgNngvan/YW
 F8Rfcui7VcvozgYrmoPcRIk7bOWubd5+JoDBe1WsagFaW337MJbIAXYE6phNLvRIVuCW
 C80N00PxRgUP4wEJ83POBmFAooqvGSwUfoHCJdyFuxmY/ZpBe5+ML84KbqoGiFQCCA8P
 O3mLJymm8Yw39exCCxKqkSrQdiuwDUkKv/8rsM5o1w/ypEK6jS0KvKLvoyla3c3jg0Ys
 bsImIMgpI/wpV0Loh749Mdu2oQJSUu2KJTgow2ZTMqmGgGSX+brmNoI3WcO87jnsbL9c
 K0EQ==
X-Gm-Message-State: AOJu0Yz5oxObeGERBoS9N3lgXOYHMUFKUQB2tOmhhg9zqvO41pBHrgw1
 AQdyp66li+dzAXV1c+Z7JdUHz5VDspdG6vt/ZDzXUehSN+E8LZPJPqbsvlxmJUU=
X-Google-Smtp-Source: AGHT+IGbGi4pi9uqc4f+qi+uREkmu3NVAFFCJiFyZci8S4qW+bdEVmhk67SArOvzcYYgq3G8UIgxZg==
X-Received: by 2002:ac8:5994:0:b0:456:7d6b:7605 with SMTP id
 d75a77b69052e-458603fbdc0mr251304231cf.41.1726519330303; 
 Mon, 16 Sep 2024 13:42:10 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aaca55absm31114831cf.54.2024.09.16.13.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 13:42:09 -0700 (PDT)
Date: Mon, 16 Sep 2024 14:42:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com
Subject: Re: [PATCH 3/9] ARM: socfpga: add Enclustra AA1 SoM support
Message-ID: <20240916204206.GI4252@bill-the-cat>
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-4-l.rubusch@gmail.com>
 <20240912174507.GV4252@bill-the-cat>
 <CAFXKEHYQ+Z1nQ5-=ZLH1Nd+Yv43tv=S-5bzUzBLhYEQNe4X81w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zupEddcSUlUfodZZ"
Content-Disposition: inline
In-Reply-To: <CAFXKEHYQ+Z1nQ5-=ZLH1Nd+Yv43tv=S-5bzUzBLhYEQNe4X81w@mail.gmail.com>
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


--zupEddcSUlUfodZZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 10:03:02PM +0200, Lothar Rubusch wrote:
> On Thu, Sep 12, 2024 at 7:45=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Sep 12, 2024 at 06:06:43AM +0000, Lothar Rubusch wrote:
> >
> > > Introduce initial support for the Enclustra SoMs:
> > >
> > > - Mercury AA1
> > >
> > > Cover general board files for SD/MMC and QSPI boot modes. Integrate t=
he
> > > boards to kconfig. All build variants will depend on Quartus handoff
> > > files, thus they depend on the particular Quartus design. The approac=
h is
> > > covered in the according documentation part.
> > >
> > > Additionally add configuration for SD/MMC boot and QSPI bootmodes. Re=
gister
> > > additional targets in kconfig.
> > >
> > > Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > [snip]
[snip]
> > > +U_BOOT_CMD(altera_set_storage, 2, 0, altera_set_storage_cmd,
> > > +        "Set non volatile memory access",
> > > +        "<MMC|QSPI|EMMC> - Set access for the selected memory device=
");
> > > +
> > > +#endif
> >
> > The entire file seems to be for just adding the cmd. Perhaps rename this
> > file to reflect that and have the Makefile only even build this when
> > CONFIG_SPL_BUILD is not set.
>=20
> Agree. It looks cleaner now. I prepare this in the next version of
> this patch set. Thank you for the hint. I would name it as
> aa1_set_storage_cmd() is this ok?

Yes, the name sounds fine. Thanks!

--=20
Tom

--zupEddcSUlUfodZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbomB4ACgkQFHw5/5Y0
tyxGkgwAhq5C1x5YNRaRT3JUyIihvpgQdioq7JyitFQMdSAzzZkQewwe31+r7k7F
QIaXk5qUIJvOvWzJqjrZ40zKtrW+NOIG4LZ+P+s9H5CQLQc2F/MoNJEoRVCcp5l+
nek/E6LurefOz5pajQxbpL4yIR5mFSrs6cNdvSOLOmo/WTyINkA+1TG+5aFJex6d
Hsj8+Sifm9h/NRaZQyJ9wb0+hNWTlxz2hndTOOn+8K6y6Ua4r11/mS8r1gt+rfLP
GPg4lDx54zkJ84lty1DbQLRWbVohpxwE10rCgVzTw4025EByTeRNYt+Ji7yZSf91
+BAeLUB5eU/343hobm7F9/ExL37i22ZsoDLzkdg4YXDUv9T2iuLbwSVt+VU2Jh+y
9befDWUnYd0irvHaYgembRG/H9CBXj3eytnPV4/2SVreRsDpjvxdWSZ9gwZIgPom
QST2lHI9xT+GNUCWpkUk2mbnbnVFtGKNA0AaqKjZb9TD4FfSpRqhLTukxDm+LfA5
hAT7kI/R
=VUbt
-----END PGP SIGNATURE-----

--zupEddcSUlUfodZZ--
