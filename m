Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E651C35274
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 01:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 719928713C;
	Tue, 19 Dec 2023 02:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SF/dGqGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C29AA87053; Tue, 19 Dec 2023 02:26:07 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 560FE8744F
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 02:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5cbcfdeaff3so32560117b3.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 17:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702949163; x=1703553963; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zv1cyza+SxMu8h3qAcsHVxK3OxoNykYS+Z588yJ9gek=;
 b=SF/dGqGsARHw+RGAQwGfCuQPO+jjUTlUXv8MVfLwmaQcTE+fpsm5SSq48yGvauP9Ap
 paxMDL4VwHqlkfblaiOlFWR5aOX5i/RIgL7nMF1pv0k9+yFJena2sLBuFNTwHIoylNcq
 hDOUBZ9ThuYJPaxybMclAfSNq3hZNFKrQJK2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702949163; x=1703553963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zv1cyza+SxMu8h3qAcsHVxK3OxoNykYS+Z588yJ9gek=;
 b=YK48niI6vsjEXAf60+JpFt+h7TTLzueW6mo19TozweztOVc1cSanCy7sEdD8JCdbEN
 aGoQgiRQarBHVz0fegr1N8SQdgScp6hW4KuQPk9w5ofe5Kv0WWeTo8JXT1MBJyvk1z7s
 rtDNWnuIGpekvnmcvvnQEIldcUXhIiKkdlQS8ARJvToBhS4ZKaQdlL5U7UA9scp2VcPe
 JfWmr4yqgvSl19UrQ4Thl0NAU/Pf/dxVRLpzAFj23GUYdwPrzWlF0nSuH8eYo+mgX3RV
 5TSE/HInPkdcziTzCVBRCyWuYDhSWTqLoL2ojzdTQjYev3Wf4uK+Ap7i2b7yF+tCmPEN
 Bytw==
X-Gm-Message-State: AOJu0Yylrtxi33lH/SCcOsrZNNbywansSjYEQVQi6Yk8uy+ke16iTgWK
 VYrLjV+IMyALzlyXa8ta3oH70A==
X-Google-Smtp-Source: AGHT+IGMecFDEhJbc9dvp7zyuIBfMLb9P+9DKg1P2K8r5HvYtaJrg5cQzyXBQwS83WTKCWLt21aebA==
X-Received: by 2002:a0d:ca8f:0:b0:5e5:a519:33e4 with SMTP id
 m137-20020a0dca8f000000b005e5a51933e4mr2943380ywd.53.1702949162895; 
 Mon, 18 Dec 2023 17:26:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 g184-20020a0dc4c1000000b005a7d46770f2sm9299949ywd.83.2023.12.18.17.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 17:26:02 -0800 (PST)
Date: Mon, 18 Dec 2023 20:26:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231219012600.GQ2513409@bill-the-cat>
References: <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
 <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
 <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
 <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
 <20231218224108.GN2513409@bill-the-cat>
 <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
 <20231218231640.GO2513409@bill-the-cat>
 <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
 <20231218233130.GP2513409@bill-the-cat>
 <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8khRpa+oPc/vD037"
Content-Disposition: inline
In-Reply-To: <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
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


--8khRpa+oPc/vD037
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 19. Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchardt wrote:
> >>=20
> >>=20
> >> Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@konsulko.com=
>:
> >> >On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt wrote:
> >> >>=20
> >> >>=20
> >> >> Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@konsulko.=
com>:
> >> >> >On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt wrot=
e:
> >> >> >
> >> >> >[snip]
> >> >> >> Or take:
> >> >> >>=20
> >> >> >> load host 0:1 $c kernel.efi
> >> >> >> load host 0:1 $d initrd.img
> >> >> >>=20
> >> >> >> How could we ensure that initrd.img is not overwriting a part of=
 kernel.efi without memory allocation?
> >> >> >
> >> >> >Today, invalid checksum as part of some part of the kernel fails. =
But
> >> >> >how do we do this tomorrow, are you suggesting that "load" perform
> >> >> >malloc() in some predefined size? If $c is below $d and $c + kerne=
l.efi
> >> >> >is now above $d we can throw an error before trying to load, yes. =
But
> >> >> >what about:
> >> >> >load host 0:1 $d initrd.img
> >> >> >load host 0:1 $c kernel.efi
> >> >> >
> >> >> >In that case (which is only marginally contrived, the more real ca=
se is
> >> >> >loading device tree in to unexpectedly large ramdisk because someo=
ne
> >> >> >didn't understand the general advice on why device tree is lower t=
han
> >> >> >ramdisk address) I'm fine with an error that amounts to "you just
> >> >> >corrupted another allocation" and then "fail, reset the board" or =
so.
> >> >> >
> >> >>=20
> >> >> Our current malloc library cannot manage the complete memory. We ne=
ed a library like lmb which should also cover the memory management that we=
 currently have in lib/efi/efi_memory.c. This must include a memory type at=
tribute for usage in the GetMemoryMap() service. A management on page level=
 seems sufficient.
> >> >>=20
> >> >> The load command should permanently allocate memory in that lmb+ li=
brary.
> >> >>=20
> >> >> We need an unload command to free the memory if we want to reuse th=
e memory or we might let the load comand free the memory if exactly the sam=
e start address is reused.
> >> >
> >> >Our current way of loading things in to memory does not handle the ca=
se
> >> >I described, yes. How would what you're proposing handle it?
> >>=20
> >> If the load command has to allocate memory for the image and that allo=
cation is kept, any attempt to allocate overlapping memory would fail.
> >
> >So you're saying that the load command has to pre-allocate memory? Or as
> >it goes? If the latter, in what size chunks? This starts to get at what
> >Simon was talking about with respect to memory fragmentation. Which to
> >be clear is a problem we have today, we just let things overlap and hope
> >something later catches an incorrect checksum.
> >
>=20
> I don't want to replace the malloc library which handles large numbets of=
 allocations.

I'm confused. The normal malloc library is not involved with current
image loading, it's direct to memory (with some attempts at sanity
checking by lmb).  Are you proposing a different allocator with
malloc/free like behavior? If so, please outline how it will determine
pool size, and how we'll use it to load thing to memory.

> Closing the eyes when the user loads multiple files does not solve the fr=
agmentation problem.

Yes. I'm only noting that today we just ignore the problem and sometimes
catch it via checksums.

> Fragmentation only happens if we have many concurrent allocations.  In EF=
I we are allocating top down. The number of concurrent allocations is low. =
Typically a few dozen at most. After terminating an application these shoul=
d be freed again.

OK, so are you saying that we would no longer be loading _to_ a location
in memory and instead just be saying "load this thing" and picking where
dynamically?

> When loading a file from a file system we know the filesize beforehand. S=
o allocation is trivial.
>=20
> The loady command currently does not use the  offered size information bu=
t could do so.

We should be using that information to make sure we don't overwrite
U-Boot itself, but I don't recall how exactly we handle it today
off-hand.

> TFTP is problematic because it does not transfer the filesize. We would p=
robably try to allocate a large chunk of memory and then downsize the alloc=
ation after reading the whole file.

Reading from non-filesystem flash also has this problem, but we at least
specify the amount to read too. But yes, it gets back to what I was
asking about on how you're proposing to handle network load cases.

--=20
Tom

--8khRpa+oPc/vD037
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWA8SUACgkQFHw5/5Y0
tyxzxwv8CEDc4AnxzIMS+PuuyAwpsfqlqSKAZDKfPxUs8SfZGLp+1nM2h03Galah
lJNPRJ7xZujGD7crlCzjmNs1T2fOFdJXRdJjZXcuGGaps3Qn8SgTogxZi20nKbMx
robXNTOEWwhvv4m0lKw6llQtlFFBpB0I2XiC8E9Qn6NuAPCyYp/XIMKr8n90pIhz
vSU2QwJoKI1TFgdWFesoVlEmN8+ifhfdoTh/boUsQGpclN8BbkprhJWcq7d9KrPm
fAgaFvTqa807/QvCkd8xquGr6AaDN8Rvhg5slZlffqr+nQ4swlWG/HHj8QoaYKSy
Utv8qCm3z/ZRdc7A4jo5ByGjJwkMdQO+FFKC3/fiXHpsYje010+E7lXcWZzLcRHR
6LEh/D+MJ5hV9QVRkY5GxzgYrSLgCd8zkAGc+EdRnQoDkJ6iuO9oUMRqBbogJ/0R
AAAen5fG0LBVE2ftO5dZRCHkYyIha56jTpY9D8vcnz8IWxC3BgEIV6yw4lqpsq00
6sGBaNxv
=YkQS
-----END PGP SIGNATURE-----

--8khRpa+oPc/vD037--
