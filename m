Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB6AC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C7B84112;
	Fri, 11 Apr 2025 17:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ygwb5RCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE0968411C; Fri, 11 Apr 2025 17:01:27 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27DF184107
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7272f9b4132so1496158a34.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744383684; x=1744988484; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T825u2BreeXdwPq3TaiBqFWoxFmEYcEeCJCvykxuWyc=;
 b=Ygwb5RCUYJJGXNKiS5DZWX/yUg7Hir2NyOllNxLIVT/2IEXsEliRdzs5APSu2kDMLj
 gPeeOYjxGjMEKQqmb99JX8qK3TIxX/x5XN0bb+K5PwouH0iS8L3EoXq2FQnFadkQwgZd
 F4zwnkSBKORJKgJiPR4hyvQMeFMBTTPoOLaMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383684; x=1744988484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T825u2BreeXdwPq3TaiBqFWoxFmEYcEeCJCvykxuWyc=;
 b=ciCgIC6TQgnLpRByk9YDmTaMx4LL7aTuHqz5ykGrDxUApTwKLo6rxF2DwpxeY1Y+YI
 Tpjiie10ggoWRrqIQ5NvZXOu3m8gaL+18v8VHjZlxsW393bASNMK1KXAhExuHRD+s6t6
 5vvDDzsg9HCXyxHU5VTfma6GaAK8G0RArPBVt05ehmEeyszm43ndeI7dpk9WOEciOJM8
 TMV1jaWFOB+Oj//Q3ABd+OsN5950WzqCnRlz6Z/lIdaTuSD4nZoNMItF1XxBtPIJ3ng4
 uY+XL7Cq4gXvBR+2C4rxWegykgXNvh7RIpHm8kBXvTkKBnImK65OYuUPsarkGkCE4Tvp
 bjNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPP77qKsSHjztk2b9WkdfjCx2ppKSZ0k6KDxCS1cbTOhEfACkqY2ciGKCFseRKccTW4KYuXAg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw88NkzP90dakVXPI4ga/CefHUl/oC+2EVAHa1Orf/HmnU3yhnn
 eRJMGSPjLMdhzYNanAEfE3UyfFQ21sP/CA8d8huAZ891DpN2AHGh94ZIf2j1sOV/jay/CYT8jy0
 mABw=
X-Gm-Gg: ASbGncvwkFN1kf8qVMvjsBdX1zUXQRsc46Zm7DRtGGg8cu6wPIB+Eae0sB/gYbzkF5y
 Rhe/rjYOv3o0GjJG0iaMSBZNz2Y+kbnprdom0Br6DomIcd0BKChN0mkEpeH1b9XVAxDUvBCwYY3
 3E9l/ZkaxEA7kEBk46LM5eLpFN00fcfjOAO8fTsR5UJ0A449gVOCYvQ0rJiiv9uiejX4IPsEOl3
 b2r0nfE5UmvrQq9Wutudkfn/edTooaducNyB12JyXmSwP1X8o48l9tIEGdGcxZLtyjxanaLpquM
 MuUly1HUm6mFpPSF4JraHs9UKTQKJ8uDrfxqIhR5AONqjGjf2S+h+ZsHIX3YrGNvdQtKrwD6sJb
 CBQ==
X-Google-Smtp-Source: AGHT+IEUlQub/A0F9N22nmeAqjM8X2nhPyQ5yB6kg1zyasZCagZWd1lvOBvdCTSZHcc3r/lLIIKwjg==
X-Received: by 2002:a05:6830:4708:b0:729:ff76:5166 with SMTP id
 46e09a7af769-72e8633b149mr1802684a34.14.1744383683003; 
 Fri, 11 Apr 2025 08:01:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d7140esm957585a34.22.2025.04.11.08.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:01:22 -0700 (PDT)
Date: Fri, 11 Apr 2025 09:01:20 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>, Eugen Hristev <eugen.hristev@linaro.org>,
 open list <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: Gitlab runner timeout on evb-ast2600 ?
Message-ID: <20250411150120.GQ5495@bill-the-cat>
References: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
 <CACPK8XeCDU+-6+zzJe4=uj=Lduh8nGx6pNr=yWCsM+k-rov2UQ@mail.gmail.com>
 <20250410231444.GK5495@bill-the-cat>
 <89f2eac8-4e76-42a6-b56e-fc62abdaffe9@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wCR3YJmUqAu2hUgy"
Content-Disposition: inline
In-Reply-To: <89f2eac8-4e76-42a6-b56e-fc62abdaffe9@kaod.org>
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


--wCR3YJmUqAu2hUgy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 09:23:59AM +0200, C=E9dric Le Goater wrote:
> Hi,
>=20
> On 4/11/25 01:14, Tom Rini wrote:
> > On Fri, Apr 11, 2025 at 08:07:15AM +0930, Joel Stanley wrote:
> > > On Mon, 7 Apr 2025 at 23:25, Eugen Hristev <eugen.hristev@linaro.org>=
 wrote:
> > > >=20
> > > > Hi everyone,
> > > >=20
> > > > I keep getting an error on running the CI loop on -next on my tree :
> > > >=20
> > > > https://source.denx.de/u-boot/custodians/u-boot-at91/-/jobs/1090517
> > >=20
> > > Thanks for the report.
> > >=20
> > > >=20
> > > > ! _pytest.outcomes.Exit: Lab timeout: Marking connection bad - no o=
ther
> > > > tests will run !
> > > >=20
> > > > Any clue ? It's been like this for few days. It doesn't look like a
> > > > faulty patch.
> > >=20
> > > I can't see that link you sent me, it 403s.
> > >=20
> > > Do you have any other traces or information to share?
> >=20
> > It's been intermittent recently. I was able to put qemu + gdb together
> > and see it's one of the early initcalls that fails and hang()s but
> > didn't see why. You should be able to use commit 1f0281294d8b ("Merge
> > patch series "Annotate switch/case fallthrough cases"") as a starting
> > point of failure.
> >=20
>=20
> Do you have logs ?
>=20
> Things look ok from the QEMU side (latest 10.0.0-rc and 9.1) :
>     uboot_build=3D/path/to/u-boot/
>     flashsize=3D65536
>     flash=3D./flash-ast2600-evb-uboot
>     dd of=3D$flash bs=3D1K if=3D/dev/zero count=3D$flashsize
>     dd of=3D$flash conv=3Dnotrunc bs=3D1K if=3D$uboot_build/spl/u-boot-sp=
l.bin
>     dd of=3D$flash conv=3Dnotrunc bs=3D1K if=3D$uboot_build/u-boot.img se=
ek=3D64
>     $ qemu-system-arm -M ast2600-evb -net nic,netdev=3Dnet0 -netdev user,=
id=3Dnet0 -nographic -snapshot -serial mon:stdio   -drive file=3Dflash-ast2=
600-evb-uboot,format=3Draw,if=3Dmtd
>     qemu-system-arm: warning: nic ftgmac100.1 has no peer
>     qemu-system-arm: warning: nic ftgmac100.2 has no peer
>     qemu-system-arm: warning: nic ftgmac100.3 has no peer
>     U-Boot SPL 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 09:08:40 +0200)
>     Trying to boot from RAM
>     ## Checking hash(es) for config conf-1 ... OK
>     ## Checking hash(es) for Image firmware-1 ... crc32+ OK
>     ## Checking hash(es) for Image fdt-1 ... crc32+ OK
>     U-Boot 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 09:08:40 +0200)

Please note that it's inconsistent about what commit fails. I would
expect 1f0281294d8b in U-Boot to fail but I don't know about
cb7555e93075.

Also can you please check QEMU v8.2.0? That's what we're on, and I can
try and test 9.1.3 or 10.0.0-rc and see if it's a QEMU problem instead.
Thanks!

--=20
Tom

--wCR3YJmUqAu2hUgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5LsAACgkQFHw5/5Y0
tyyEdgwArUv7kRU00h8fobBYdeMIPqkE3w5dwx/DEkdgoa6H1ZBR6fVh8q9vEaDX
FZueFkFQJjLHKvSqvRT/xo37mQpRBbTUjDjlmgmD9ZEX+M5Y4CZpf0/0M1hQhgNJ
3agQRsjyyOy7IhQPYhEU40v+ZQxrWt0q3vFEqI8DsD/67TonoB8e2c1n3QOH7qzS
XOM2h+J1CfJIQ+y9ciS4CDquqothboZ7MQslgtPjxdMHEla14v4qNjS3yvjcyLxC
1fK9uCLZM54cfN4k7VPMGO7FDpa9c44B+XBPQT0DZ6Da61ovGcbQ2FsIRXAMh2pU
WpiSMq6/r9hRvky1PgEveqxwQMqKtFiggt80AYmxUnsiVLj42olalFIzgU5PfFfd
teEAkidbBTiKeOwQmrv3cz5D1hdNpvQdXsSoppDKAgVv5xzv8GyYT4B8KEbhlWeN
jf0K0rCLUZVN03h7cnzq1b2gFXGnLjRIiJm0/xm2Z6jJpoqmaDu9o2bvzwEauwrm
LDa8NqxB
=rGzO
-----END PGP SIGNATURE-----

--wCR3YJmUqAu2hUgy--
