Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11766D6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E2F88DF1;
	Thu, 14 Nov 2024 18:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a9I0N9BL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 592FA88ECB; Thu, 14 Nov 2024 18:39:35 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCC4088DDA
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3e600ae1664so417170b6e.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731605971; x=1732210771; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4PD+wNDby0aNr6BVVUWBz4GK8cpeiRR6RHb6Bc78h9k=;
 b=a9I0N9BLkbTskge7jau5AtnP2bYTKwnvGWKlhWu0mJT1dP+I6nshoSFI3APtFe52F7
 tZaEJBm1gxryB9eMQWhcap5Qt2EMoAS30r1WcCmtyTOPkYV/r7cOycQrLBfnpI+m0/it
 6p/aa8btYZ7/pUHXv41c4zRfrwJEqYjMh42+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731605971; x=1732210771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PD+wNDby0aNr6BVVUWBz4GK8cpeiRR6RHb6Bc78h9k=;
 b=bzrXgM2wFt4BIX2SND7/yg6DKIuJFVs3//XRIcfQBwvKDFdowOV3t7xH+JlA0LRxym
 PuwyC4lMIKJKBusMwfHQPxlLvixgtZ10Tyi2RN2kCi/cXFyVjncEOxg3VJduMLF4auNA
 vBwwefvucAiNfVXdoX8XCPsb8Z2Wn7W+ZaZskhN707Tjf/zdPHiOHSbKDqkj/AbnFXy9
 ydBZDNQPZD4SLwq+cWhsQd5QA31APSyGZsZs9pJ7tn7vKgb2aojMmdZ3XEoi85TTaIZz
 KDn6sJ685Rw6v4ysG4yHwoAVMdpaScm5bzieawpuFFcgoaZIkNVK05LEZODC6EeEIkbr
 NJ8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKXLobbxMMOxHhhotxAyPNISrtvb48+ba2BZgSkeiGnjE82In9uwq5i3cyOg3syJ1+2WS/720=@lists.denx.de
X-Gm-Message-State: AOJu0Yyx9J6+nYup6/ZQcpI4OPc5/1EB0eZ52abqED9c+yNbM+1GP9N/
 esKpn7pKnhwh5NBVFUe4zzf7hR1hnZ+vd4yNZ5yXiDJumOD9f9wZu+B3Mn4NlN0=
X-Google-Smtp-Source: AGHT+IEtnwyrXhmyVTKekMb/YcQH8b4pjTyZ3bdkDYF7SoTG1DlQqLYC1lZyM2xhsifrKK/BRf0HUQ==
X-Received: by 2002:a05:6808:2743:b0:3e7:ac6a:213c with SMTP id
 5614622812f47-3e7ac6a219emr9386433b6e.28.1731605971489; 
 Thu, 14 Nov 2024 09:39:31 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b85bc432sm470230b6e.28.2024.11.14.09.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 09:39:30 -0800 (PST)
Date: Thu, 14 Nov 2024 11:39:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>,
 Simon Glass <sjg@chromium.org>, Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Dahl <ada@thorsis.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
Message-ID: <20241114173927.GJ3600562@bill-the-cat>
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
 <20241114172654.GA4059396@bill-the-cat>
 <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u2fL8lh6pCe7gfuD"
Content-Disposition: inline
In-Reply-To: <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
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


--u2fL8lh6pCe7gfuD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 06:35:44PM +0100, Heinrich Schuchardt wrote:
> Tom Rini <trini@konsulko.com> schrieb am Do., 14. Nov. 2024, 18:27:
>=20
> > On Sat, Nov 02, 2024 at 05:32:59PM +0100, Heinrich Schuchardt wrote:
> >
> > > The PRNG implementing the random() function only has 2^31 states and
> > > therefore is unsafe to use for cryptography. Use arc4random() instead.
> > >
> > > Fixes: cc34f04efd63 ("tools: image-host.c: use random instead of rand=
")
> > > Addresses-Coverity-ID: 312953 Calling risky function
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >  tools/image-host.c | 35 +++--------------------------------
> > >  1 file changed, 3 insertions(+), 32 deletions(-)
> >
> > Now I get:
> > /home/uboot/u-boot/u-boot/tools/image-host.c: In function
> > 'fit_image_setup_cipher':
> > /home/uboot/u-boot/u-boot/tools/image-host.c:439:17: warning: implicit
> > declaration of function 'arc4random_buf' [-Wimplicit-function-declarati=
on]
> >   439 |                 arc4random_buf((void *)info->iv,
> > info->cipher->iv_len);
> >       |                 ^~~~~~~~~~~~~~
> > /usr/bin/ld: tools/image-host.o: in function `fit_image_cipher_data':
> > image-host.c:(.text+0xb41): undefined reference to `arc4random_buf'
> > collect2: error: ld returned 1 exit status
> > make[3]: *** [scripts/Makefile.host:104: tools/dumpimage] Error 1
> >
> > in the docker container. I gather this means arc4random_buf is not as
> > widely available as assumed.
> >
>=20
> glibc 2.36 is required published 2022-08. Ubuntu Jammy is 22.04.

Yeah, that's likely (a) too new and (b) strange because:
https://source.denx.de/u-boot/u-boot/-/jobs/945810 and so is jammy
22.04.

--=20
Tom

--u2fL8lh6pCe7gfuD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2Nc8ACgkQFHw5/5Y0
tyz0nQv/ataG5B4TdcDpbk7HKirrSrzb6JQlsyMC5hC65+AkP1CBYQVdnnG55w9r
T8mTV8he4DPkSXqA6yShHX07VWo5y247DQcuWCEAMNRB9fRQghnelaDNYsgScy28
VebCUAOlaUQ0d+zmXgLwZHWafUPM0sRjCB36X6aLyeKHTp1wvoaZmkDyWQt+jgpX
sU0/eKlkHPYF4Vqi4evYhcjg0sI/pl8AjK8ZeJW8CWmTXscOCe68Me8RGmdo0/Pp
rCeOqGnphg2GbXM4ZoQPGIukgAAV1tvommR6ce3XefHDLv+8D7ZJUOFB3BzbkxzS
ceEjeVabRt2dzsBD5VSji5PKBQSR8z2sn2iOW74zxcttFICcnseE57/GZ6qOlKIr
1G6SGVUm6Y4Kt/dK7MDqEgzEDQetgnOyMfI/HgjFKebutwyP3G8ZPUIJ8hsY5zEF
2vBaQMnHt7JMmHNAibnd+jWXGIRDanBuTyZPMprf1+OFc+bA4tDL+B+3Mqwpyl/t
GzF2IXVH
=7ITa
-----END PGP SIGNATURE-----

--u2fL8lh6pCe7gfuD--
