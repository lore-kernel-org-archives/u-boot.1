Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96945C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 23:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD5E387525;
	Tue, 19 Dec 2023 00:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SG9yDFDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE28F87536; Tue, 19 Dec 2023 00:31:37 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58DBB87525
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 00:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5e778e484dbso4499787b3.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 15:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702942294; x=1703547094; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2w0rN3FAeWHMUE94zLeKqjnQui+58mbyxocgBEn7v/o=;
 b=SG9yDFDIbCHZUmgdYWlp1Jpqs2qcPdjp6nFY/ea7RdAfoaJy+G1Tceh7LcnUbGzun6
 qDxMP5F4zPwjr95Od6UxU+XpGAtBrZmM3XN04bPWHRw8UCouluPvgPuMDFoSUytBp87x
 ArLQGusNKPsNcxa+ONDYXnlbZEo6JZceMzGOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702942294; x=1703547094;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2w0rN3FAeWHMUE94zLeKqjnQui+58mbyxocgBEn7v/o=;
 b=S34uJTniwSkad5SZUHtVnV8K0V9Y8XYbtkRE+4o+VurgsjKp8fH9taDPNfdXi2zCz1
 99rB1s2rV8rR6SaRO3JXbA5CxBP6TcZExLVk3oNgBvKoRc+Mf3a+Zg70NQo5fh7jTAQu
 O53EQcE+h6SfTB9nLV7k3gn64WsT0YAVYpEs2nD/qjMuzPjLgSiQlfd2MgMVZFrwk4ua
 Ds8NN8TigfA8uOdqfoJ/CmHYmcEPBotvm0XFkf3D+STnVdkDz5dUAacN5bbShBbVTkxE
 FpUcVgHmpkhy6TfOeEch50tCPFKt+NWI5LK+Wrj+Z0TpkgtY8Mv4sUxBck1dHEJN43Jj
 JDgw==
X-Gm-Message-State: AOJu0YwNHLrmV7Jw/3e2+MAGvaN2z6ck14DbzLRJ8Iordw77w+VkhzvS
 lnt5J+mnt+FcuxC5Z3K6PBTcpATHgfsdJRH91dQ=
X-Google-Smtp-Source: AGHT+IESnhfPeVlyAL5nfFa6smwrjdsNNYl46fwDTMBXftIV4pAkuYPsydZibgkbpYuI7Jo9QAs1Rw==
X-Received: by 2002:a0d:d957:0:b0:5e2:b373:7495 with SMTP id
 b84-20020a0dd957000000b005e2b3737495mr8244113ywe.81.1702942294070; 
 Mon, 18 Dec 2023 15:31:34 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 s64-20020a817743000000b005869fd2b5bcsm9268727ywc.127.2023.12.18.15.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 15:31:32 -0800 (PST)
Date: Mon, 18 Dec 2023 18:31:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231218233130.GP2513409@bill-the-cat>
References: <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
 <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
 <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
 <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
 <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
 <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
 <20231218224108.GN2513409@bill-the-cat>
 <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
 <20231218231640.GO2513409@bill-the-cat>
 <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NfNR7dkWpFMq1fSn"
Content-Disposition: inline
In-Reply-To: <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
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


--NfNR7dkWpFMq1fSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt wrote:
> >>=20
> >>=20
> >> Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@konsulko.com=
>:
> >> >On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt wrote:
> >> >
> >> >[snip]
> >> >> Or take:
> >> >>=20
> >> >> load host 0:1 $c kernel.efi
> >> >> load host 0:1 $d initrd.img
> >> >>=20
> >> >> How could we ensure that initrd.img is not overwriting a part of ke=
rnel.efi without memory allocation?
> >> >
> >> >Today, invalid checksum as part of some part of the kernel fails. But
> >> >how do we do this tomorrow, are you suggesting that "load" perform
> >> >malloc() in some predefined size? If $c is below $d and $c + kernel.e=
fi
> >> >is now above $d we can throw an error before trying to load, yes. But
> >> >what about:
> >> >load host 0:1 $d initrd.img
> >> >load host 0:1 $c kernel.efi
> >> >
> >> >In that case (which is only marginally contrived, the more real case =
is
> >> >loading device tree in to unexpectedly large ramdisk because someone
> >> >didn't understand the general advice on why device tree is lower than
> >> >ramdisk address) I'm fine with an error that amounts to "you just
> >> >corrupted another allocation" and then "fail, reset the board" or so.
> >> >
> >>=20
> >> Our current malloc library cannot manage the complete memory. We need =
a library like lmb which should also cover the memory management that we cu=
rrently have in lib/efi/efi_memory.c. This must include a memory type attri=
bute for usage in the GetMemoryMap() service. A management on page level se=
ems sufficient.
> >>=20
> >> The load command should permanently allocate memory in that lmb+ libra=
ry.
> >>=20
> >> We need an unload command to free the memory if we want to reuse the m=
emory or we might let the load comand free the memory if exactly the same s=
tart address is reused.
> >
> >Our current way of loading things in to memory does not handle the case
> >I described, yes. How would what you're proposing handle it?
>=20
> If the load command has to allocate memory for the image and that allocat=
ion is kept, any attempt to allocate overlapping memory would fail.

So you're saying that the load command has to pre-allocate memory? Or as
it goes? If the latter, in what size chunks? This starts to get at what
Simon was talking about with respect to memory fragmentation. Which to
be clear is a problem we have today, we just let things overlap and hope
something later catches an incorrect checksum.

--=20
Tom

--NfNR7dkWpFMq1fSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWA1k8ACgkQFHw5/5Y0
tyyzEAwAoIEFLrHx8K8oS4W7XJ++8zCD+DnRkTSyd4kErf7YB1FkZ+OGA5WPIhrd
cC/8KCab4b+wO9crTH+nPXa3KHtRPpdpiC3AC72rs9zFsjO6+i4kN6KoyMJbM3Gu
wUrQ6TZXaWfPaLM9+WYA4pg0fi3TMz5oo4oEfAu7q2Jr/htpK/9zSTylyM2Qjo2k
pt6Ot1SMHQwcbv8/yw2eT2uQ92m+FwWPO9bbSDF6AtQPN9zkz0qVDh3m/f5pL5xa
qqsQwfZDgNgALhBtjmbu5BEGOXhV7cgfeTeKiDC6g5CL1gICBrtAThVIrmpeVraB
oLelM3Uv8WeqnPoI1CvwwGI8niTSESTGQ+gyu6sp7pAshahCk5ImsCADghvRqy+E
HG3iI7YPhUsWYaOHMDtubK5F9s0C34WVIauLa4RSJQ64PhQmN1+rr1nrAYA+h2g/
XiFgfSHA+w3Kj85iFHG8AvJRl0bZi878GfYXsRUzSwkaCTff7XCOjtoIYOumZge3
YWyQw0Dk
=vnAJ
-----END PGP SIGNATURE-----

--NfNR7dkWpFMq1fSn--
