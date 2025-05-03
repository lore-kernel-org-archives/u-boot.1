Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEA7C369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 16:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 448AE822D7;
	Sat,  3 May 2025 18:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="noEe2u2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F02BB82163; Sat,  3 May 2025 18:37:10 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61949826AA
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 18:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7311a8bb581so2461962a34.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746290227; x=1746895027; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2vT814dn2YcK6OE7UX/czou/j7NmukAj6VZWgcA6gMU=;
 b=noEe2u2IsviSnIkXMwO4VlheA1Hzj2Dx/9iJPAgK1VdZJYW/oDTI0GCfOjorErLFP4
 emGEan1a3PjLVLhqqEllc3Eh4dktmPbkckQisz+bMfqNx4+ltwTM282t/kSV4Fy/jgq4
 ddBDCJ/Nz6NMgGb9tIyLEjAhYSBykLNDZeYcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746290227; x=1746895027;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vT814dn2YcK6OE7UX/czou/j7NmukAj6VZWgcA6gMU=;
 b=PTnoZx1CNb25+J8qM1Ep+/3BMwXkcQAGiH8wat/xi4G7iXGNPNYXLM5C2taBZ7FNVe
 92xeSevRhF1lyOM7zL/R9XDbeJJNjEBD810gh+eYFG8M5cJ/b8qzdmOEBREuBGKjYWzw
 Y1hGXvG56J7jDvmgbPjjTcTfxvn5Jc9PxP8GCStUq2at1cYqKM3rTGLj/Mu5vcWQbot4
 YhU64CYQUiRLcjp6YWhSvNWltr+gzVyZ4JXDfoAOtUiaSg8MY83XVWTrz8n6wMwfZL1S
 2QI9Mvw0EZOnEIfvWFSUx1pnzcMG/wT+7GuKfRZ336Sx8cQogYRU36knVU4x4Uq6ObuS
 5ECQ==
X-Gm-Message-State: AOJu0YyRaS+m1Aek3OgxWd2wpBRX9ku7pnlB2EtPxvq47K56sTX9WzyD
 v2DumHcdePlWe6Mb/+tl3pVg0l475IkTGxAMyLbWGYr/TKcR+ifT58Vbuy00bSDQoFQ5wEtyqj8
 l
X-Gm-Gg: ASbGncv5p9qvGBzDAgBvM37lAtyfCo2cXI2TGin6ZVRBGj5xr6CcbfajOTCKo0IJD9/
 Ad5FQjM+inq+Iig7R/koJrjWJiqjCSGGeLz07SD86TTcKzehDl3UktUawaVzfbz7SPsaG950o9v
 3LS/VIQ7eh0gRV0+C4MfxvXJk4OJ3yUVMdX61gG7u4NEmnQCTNGf+OYu+B4sbh0SMeO1Qc4gnIT
 K6YM1zNUwZ/VuShKQIZZczaWK4NjvPeqCh3W3jCdg1SLN5KfqA9kYVhDLHTEzebvsr+W9e3/JD2
 k5RUMO4wiBxdyNFsrGq66fW25x5vM1q01X0vncSvPxALOm5AQSkVeUfzHM0DOWKcD3UBK7P0eY4
 EJw==
X-Google-Smtp-Source: AGHT+IHtq0HiEccJSTUOYoQ7/gMJmnCwdEakeLvR9b8g/VzBx2uXv0EY7gJWlRWzgVhPBKKoNGmrCg==
X-Received: by 2002:a05:6830:3509:b0:72b:9c34:1361 with SMTP id
 46e09a7af769-731eadc6c08mr942853a34.15.1746290227069; 
 Sat, 03 May 2025 09:37:07 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d35051fesm891922a34.57.2025.05.03.09.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 09:37:06 -0700 (PDT)
Date: Sat, 3 May 2025 10:37:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oliver Graute <oliver.graute@kococonnector.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
Message-ID: <20250503163704.GD1261075@bill-the-cat>
References: <20250501010456.3930701-3-sjg@chromium.org>
 <20250501140617.GD1261075@bill-the-cat>
 <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
 <20250501153316.GH1261075@bill-the-cat>
 <CAFLszThcmQYqXO8rqiYKS-1TdyXcTbfTuaOTa3W8vWMTzKn-YQ@mail.gmail.com>
 <20250502140649.GQ1261075@bill-the-cat>
 <CAFLszTjqhnJNvzRUx5UD0ibSOnu+fFUCJa8CUDrTYy7vw1cjyw@mail.gmail.com>
 <20250502150429.GV1261075@bill-the-cat>
 <CAFLszTgKn9pbDs365Vztj+-gpcu=PUx5W2dRzpSS=qLdgD6nhw@mail.gmail.com>
 <20250503163035.GC1261075@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zs4vDnh9wlMmudoN"
Content-Disposition: inline
In-Reply-To: <20250503163035.GC1261075@bill-the-cat>
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


--zs4vDnh9wlMmudoN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 03, 2025 at 10:30:35AM -0600, Tom Rini wrote:
> On Fri, May 02, 2025 at 08:10:30PM -0600, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Fri, 2 May 2025 at 09:04, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 02, 2025 at 08:52:37AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 2 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, May 02, 2025 at 07:11:56AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 1 May 2025 at 09:33, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > > >
> > > > > > > On Thu, May 01, 2025 at 09:04:45AM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.com> =
wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wro=
te:
> > > > > > > > > > This file reads from the environment but does not inclu=
de the correct
> > > > > > > > > > header. Update it.
> > > > > > > > > >
> > > > > > > > > > Drop the unnecessary config.h while we are here.
> > > > > > > > >
> > > > > > > > > Are you sure about that? It was explicitly added in commit
> > > > > > > > > ab61cc7d98f6 ("board: congatec: Remove <common.h> and add=
 needed
> > > > > > > > > includes") probably because of CFG_SYS_... usage.
> > > > > > > >
> > > > > > > > Well I assumed it wouldn't build if it had it, but perhaps =
that is
> > > > > > > > incorrect? I understood that CFG_ things had to be values a=
nd you
> > > > > > > > couldn't #idef them?
> > > > > > >
> > > > > > > The cases where in that series I added config.h were for good=
 reason,
> > > > > > > either failure to build or tricky size change reasons. All we=
re
> > > > > > > intentional. An audit-and-remove of config.h would be it's ow=
n series as
> > > > > > > yes, there's perhaps not the need now as whatever complex cha=
in was
> > > > > > > unwound.
> > > > > >
> > > > > > Oh dear, OK. I'll respin the series.
> > > > > >
> > > > > > Hmm but I see you have sent a series that does some similar twe=
ak[1].
> > > > > > What was the goal there?
> > > > >
> > > > > I fixed your problem. Please don't bother re-spinning this series=
, it's
> > > > > not clear what problems it's solving correctly.
> > > >
> > > > OK thanks. The problem was trying to include net.h in include/efi.h:
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/cover/20250501010456.393=
0701-1-sjg@chromium.org/
> > >
> > > Adding headers to headers needs extra care (so that we don't end up w=
ith
> > > massive implicit include chains).
> > >
> > > > So long as that works, we're fine. Having said that, even if it wer=
e a
> > > > problem, we could always refactor things to put the Ethernet decls =
in
> > > > a separate header.
> > >
> > > Yes, if there's some problem down the line then some refactoring is
> > > likely the thing to look at, not adding more headers to C files (the
> > > right path is to unwind the header chain and fix C files, your series
> > > doesn't remove env.h from any header).
> >=20
> > I hope we haven't got confused here.
> >=20
> > My series removed env.h from being *transitively* included. I had to
> > add it to C files due to that.
>=20
> Yes, which may or may not be helpful. A transitive include in a C file
> is not terrible, otherwise many files will have 20+ includes. A
> transitive include in header file, which in turn pulls in another which
> pulls in another, is a problem. And the header should be unwound and C
> files then fixed.
>=20
> > Your series doesn't help with including net.h in efi.h - you can try
> > that and see that it still fails.
>=20
> Perhaps I took it out too quickly then, I'd have sworn I build sandbox
> with that change added.

Yeah, I guess I removed it too quick and missed fixing
drivers/usb/gadget/epautoconf.c still, along with whatever the right
answer is for unwinding the exfat oddity. Likely seeing what the pain is
over using the normal byteswap headers instead.

--=20
Tom

--zs4vDnh9wlMmudoN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgWRjAACgkQFHw5/5Y0
tyzdOQv/QO0JNKeAXBCJ5D/Opem+I2hfQsQy6QbYOCi6j1tkFg+BcUC9SHrutjLV
NwWQtDuiNjV3cThYMoKwLM6KZ0vM3qyndL42hmjAO1rgA1HQyWUNnj0beSqgyChM
miITcvpElJNDlbzCH58W1Qhp8r3Oq+OiNrd+L7+3aiCAVA5pMepsh9CbyMLeipON
vM8fCDNzWyd/U1pm2R97RUqlwIiXN19/dvVFIaQGOgYjKJamaRifUJPVwOPdrSPm
28FPyoLbVcU7qP7mM+OrBROLJRa3FFM3rtmND8xvyphGT2iO8Da4OVRQyH3jsWOu
r7Tsr1INP5/Hshbt/sm4OHFfyiSYjLzrri5ttiwHWpvF2BrNW9G171A4mjrBnUwL
MuQNz1k3W/BwKrp5c3aRYcEsUj+Lw64Xm9HuHSYXpWp7dL4fnFLKXSeNha8xKyND
38uzmKkWNb9PMv6YVTGa3u2PEHCGYci3LZITKiF3lICTDB8UvW/m2d8A068CDcuj
3cEg2AD0
=D1PW
-----END PGP SIGNATURE-----

--zs4vDnh9wlMmudoN--
