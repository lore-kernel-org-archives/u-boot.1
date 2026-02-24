Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8B1F4BB7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 19:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1757283D8A;
	Tue, 24 Feb 2026 20:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P1FcvVgc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA03F83DCB; Tue, 24 Feb 2026 20:33:18 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF3D83642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 20:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so5481697a34.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771961595; x=1772566395; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W8e4IJ0y2xB+EB05szidjlUlws2gliggkao465jG27U=;
 b=P1FcvVgcUg1UfAGvZvergNXutp+zKpFxyYId8o868HDlk3uCMyDaHQhYMvB/5aaOnb
 NoC6MfW2ugDzZSlLorkpXGD1M3AL89a0H/aDTxfw2fcCy7ZybidTPR7GZ/tzH9qR54t/
 ZktCHh/3uTZBW2TrdDFeUZP7WibzPG8L0yiR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961595; x=1772566395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8e4IJ0y2xB+EB05szidjlUlws2gliggkao465jG27U=;
 b=J3yCwvDLCB30sdTN1zbMOKzBeYvKDhZQl1vzcTa4/ELKRb67K3vCRMfABS5h+O9xkT
 iiB24IuZqE2TMo8BV8DueZmmRK8OA7a504DUU+yY4Gbn4tkQbAD2TBhrS/ClbTRGevU+
 Mx/8iYwYcaDhwc49II+BxcNJi7N5uqDtxGbE8/67lOo/Q3mI3oBXfn4uEpJY8wg941G+
 It0kI+Jv0oP4cxeANHOVHDWO5GC7Zn8sNNEhTXY4pzauPB5AFK/hzscJwP+LiuWSdFiR
 FhUn3E7Awc9dFNasji6dqEsb67Z5HLZB/YmmzJSRE3t/r0lTv0nrIK20QV7T/9yGO/YW
 j/og==
X-Gm-Message-State: AOJu0Yzit9S+B//aCgpb0Wy+TSq7Px4dSqQUASvx/iCq3ZAv7ua/YblB
 TkgDOu6ZsssuHDYoVkjr5jSGkVc5epnlelUc9LOb5lY1wDjntbknCSDMGG4s+3LuX/8=
X-Gm-Gg: AZuq6aIq2DOMCJrr33EUTZ4+pgbKPYo2TrthHAJF9DWbFvLgd7qZLyusbhIAZVIS053
 pQ6xBkLmASrToAnjHfO90DujZDg0qsoeRvpjWUtg7bsBcF4eW23aGDheJ5Q7aJrpJ7VDlPBbuDy
 jhWVFkpmvd4jPvd6OQIrMCt8TS8Y9Jm0M1oh2HBelmF7uBxzgmcrWPDEVBYI/3l79x1rrdj6Xzm
 OY21lESlqdbLrf/UpqeU+Sg9igC4dCmdwWll3gwPT438Je9NQjhwemTXhur0C+Ifz6GXbp++DHJ
 OOgwshb+XUYAHbIVWq4P9uHy7znJSI2xCqYgtFWIPrXlxDjhAXfIAkOWnxqkFyTKvBbxoaNUdRC
 rFVhRXsE7UklaR4pclkrdN9Ejmw5EfWF4uuYwcw8wJXEXp1918rY2zojMpQh1zHfcYcGiwEOlTg
 hxCcvYXTwoxtxvVm2zm17a+LoC6oefYfGSrYYagFm7R4NihqMp3fR7ZAhikRT+Vz1gNzdHEROch
 0qjmfBhEbkwPswYAtVtXouxl1bRxTqnY5Fj9OclH573ybnb9RI=
X-Received: by 2002:a05:6830:6aa3:b0:7d1:8ced:55f5 with SMTP id
 46e09a7af769-7d52bf93b2fmr8000912a34.34.1771961595291; 
 Tue, 24 Feb 2026 11:33:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d0386d2sm11673359a34.15.2026.02.24.11.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 11:33:14 -0800 (PST)
Date: Tue, 24 Feb 2026 13:33:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Johannes Krottmayer <krotti83@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: QEMU: arm64: bloblist not found and alloc space exhausted
Message-ID: <20260224193312.GB3233182@bill-the-cat>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+kEooIX1rcIwUXh3"
Content-Disposition: inline
In-Reply-To: <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
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


--+kEooIX1rcIwUXh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:23:54PM +0000, Johannes Krottmayer wrote:
> Hello Tom!
>=20
> On 2/24/26 6:09 PM, Tom Rini wrote:
> > On Tue, Feb 24, 2026 at 10:26:35AM +0000, Johannes Krottmayer wrote:
> >=20
> > > Hello,
> > >=20
> > > I'm tried to compile U-Boot for an QEMU AArch64 environment, but get
> > > some error messages in SPL:
> > >=20
> > > --
> > > Bloblist at 0 not found (err=3D-2)
> > > alloc space exhausted ptr 400 limit 0
> > > Bloblist at 0 not found (err=3D-2)
> > >=20
> > >=20
> > > U-Boot 2026.01 (Feb 24 2026 - 10:22:15 +0100)
> > > [...]
> > > --
> > >=20
> > > Started the QEMU instance with the command line:
> > > $ qemu-system-aarch64 -m 4G -machine virt -cpu cortex-a53 /
> > > bios u-boot.bin
> > > $
> > >=20
> > > Also the same errors when I use TF-A and OP-TEE with enabled
> > > EL3 and EL2 in QEMU and "u-boot.bin" as BL33.
> > >=20
> > > Has somebody noticed the same issue?
> > >=20
> > > I used the configuration "qemu_arm64_defconfig".
> >=20
> > That's odd. We run it in CI, but as cortex-a57 not a53 with otherwise
> > similar arguments. Running with TF-A/OP-TEE is also in CI, but more
> > difficult to configure.
> >=20
>=20
> I have tried it now with the Cortex-A57 but running into the same
> issue without OP-TEE and TF-A. Using OP-TEE and TF-A works now
> without the issue because I have forgotten to pass the option
> TRANSFER_LIST=3D1 to TF-A and CFG_TRANSFER_LIST=3Dy and
> CFG_MAP_EXT_DT_SECURE=3Dy to OP-TEE.
>=20
> Host OS: Debian 13 (Trixie)
> QEMU version:
> $ qemu-system-aarch64 --version
> QEMU emulator version 10.0.7 (Debian 1:10.0.7+ds-0+deb13u1+b1)
> Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers
> $
>=20
> BTW: doc/board/emulation/qemu-arm.rst doesn't mention how to build
> U-Boot with OP-TEE and TF-A. Should I include the build steps into the
> docs and create a patch for the doc? I think it's also useful for
> other users.

Yes, some doc updates would be appreciated and please CC the board
maintainers as well. And perhaps the question I forgot to ask earlier
is, are you seeing those as fatal errors, or just noting they exist?

--=20
Tom

--+kEooIX1rcIwUXh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ388QAKCRAr4qD1Cr/k
Cr8eAQDmfGK02j9HfD/WODo551VAzo8nk93QtVv3K1oa9iEYPAEA0pCiMxlFSSbL
r7ggp5Fq6yAXHDZRvKIEt2/NEY0T+QM=
=3oLx
-----END PGP SIGNATURE-----

--+kEooIX1rcIwUXh3--
