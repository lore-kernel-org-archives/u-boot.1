Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96922E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0171D8022E;
	Wed, 11 Dec 2024 16:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rJjNKHpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845A9802E6; Wed, 11 Dec 2024 16:17:25 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B738021A
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b1b224f6c6so721214885a.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733930241; x=1734535041; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lPUaYz8e+lfT7IJ0EJ2fmQE6vA0bZckUH6a5QOOLPys=;
 b=rJjNKHpy65PLom6AIEQQ4N/FH7y0W77qqKdJJCdD08tlD4pjxndrUN6DLLHTAFA2Sq
 UniqVZHrE/tNPlQmzJ+zGMGKlzvTEaPHOOd7Gbu36Mzm1X597rQgWRSF7cGqJdHMLkB4
 GJDH0E0DPCYjIJOmRsSohsED94yx12KhhRKlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930241; x=1734535041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPUaYz8e+lfT7IJ0EJ2fmQE6vA0bZckUH6a5QOOLPys=;
 b=e+ZWxhof8/evPc2GVT3tv9DBIhtIrEXGw4xJktmcQFX58dlXyJ6CK3+RLmXXOGvZBV
 N8X5oyZyBK5YFPNSV84eswDuqbZ0+k1j+buvEecFZVrAbudUoVCYOgRjWmw2uCD5FkZi
 9nzDFo3Z7bfPjDKUUIcTyrLDD+nvCgQ0cuqXaC9C+e/KUvfsob0pAtcOfB3UifwZn5xZ
 NMXbAz4jl0f8cHGXhXAgI33AnPKtjzpoNRZmvwJDMhpGa5HdMhKQ0a9UggZY5tVcz4T0
 eESLRrxXrORjdaEP2NRERKjXIUCCaKhao3US9lmKFnyYxt3xt+J3vYMgBwLPwYrQl16f
 QrEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxSryECzEkT5k6XTQ9jWU2WsUPvB3fX94vqJLMq8lDn3Jr7T9/NljgJE5MPcPafRXAYqt8eqg=@lists.denx.de
X-Gm-Message-State: AOJu0YwmW3EB0lWirb8N+qt27NFiBbryjbc+bkZytN22B8rym+JcYhCT
 svOZsadkd55kjcBjaKl1I1P/Lg0RTb7LC6qGz4lZGLqDkQ1X+VJphVUIFCST6hc=
X-Gm-Gg: ASbGncsgTWHujfLafhGrhc1aFKNEZK2RuQNrwRlqbmhEoF9xnFbUEd7ACZjOLbhEfKK
 f8G1avfkg+g6RCQhXhO6CqX4rG1gzMHRxOhk2yhROpDZRuHsRIATyTgRJxGG15C8EuQGobgLL5v
 ZOo6ldXGrTISKHk1x7UiKQYGZCZ2ij85yUl+O0lht9cMv6LN5ffdAhWX7GNKSxFqzy77qGR0tNI
 wuEVoZgozUlVQ7JpxQzmEg9+4bhvzwv1PeyfKxRlnw8ubCxvnKx7Q==
X-Google-Smtp-Source: AGHT+IG1S2c/zGUTe6Hn1CEYZ7Aas12hZPEQZmb250onksxngeZIaeU2IsQBLGEXqdvQ/MDMNrm4uw==
X-Received: by 2002:a05:620a:372c:b0:7b6:bbe8:7d6e with SMTP id
 af79cd13be357-7b6eb5245fdmr511276685a.40.1733930241605; 
 Wed, 11 Dec 2024 07:17:21 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a9e5ffsm641840885a.111.2024.12.11.07.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 07:17:20 -0800 (PST)
Date: Wed, 11 Dec 2024 09:17:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v14 00/10] net: tcp: improve tcp support in legacy stack
Message-ID: <20241211151716.GA1339438@bill-the-cat>
References: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rrMxHxVlcKeAVMyP"
Content-Disposition: inline
In-Reply-To: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
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


--rrMxHxVlcKeAVMyP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024 at 02:00:39AM +0300, Mikhail Kshevetskiy wrote:

> Legacy TCP stack is bad. Here are some of the known issues:
>  * tcp packet from other connection can break a current one
>  * tcp send sequence always starts from zero
>  * bad tcp options processing
>  * strange assumptions on packet size for selective acknowledge
>  * tcp interface assumes one of the two scenarios:
>      - data downloading from remote host to a board
>      - request-response exchange with a small packets
>    so it's not possible to upload large amount of data from the
>    board to remote host.
>  * wget test generate bad tcp stream, test should fail but it passes inst=
ead
>=20
> This series of patches fixes all of the above issues.
>=20
> The benefits:
>  * A lot of bug was fixed
>  * Better and more reliable TCP state machine
>  * Tcp clients becomes smaller/simpler
>  * Data uploading was fixed (now it's possible to transmit a huge amount =
of
>    data from the board to remote host)
>=20
> Modification was verified with
>  * firmware downloading via u-boot wget command
>  * fastboot over tcp
>  * netcat linux client
>  * Firefox/Chrome/Edge using example web-server implementation
>=20
> Changes v2:
>  * cover letter was added
>  * some patches were removed
>=20
> Changes v3:
>  * better cover letter
>=20
> Changes v4:
>  * fix bug in debug output
>  * add more comments
>  * code style fixes
>=20
> Changes v5:
>  * old patches were occasionally sent with v4
>  * add back web-server patches
>  * fix bug in debug output
>  * add more comments
>  * code style fixes
>=20
> Changes v6:
>  * fix the wget test
>  * improve description of "simplify tcp header filling code" patch
>=20
> Changes v7:
>  * fix include ordering
>  * improve option descriptions
>  * fix a lot of extra brackets and comparisons against NULL / 0
>  * add empty lines before final returns
>  * fixed a bug with zero size httpd uploads
>=20
> Changes v8:
>  * [tcp] add function to restart rx inactivity timeout. This may help
>         in the cases where remote peer waits for u-boot data, but u-boot
>         is busy with long executing action
>  * [httpd] add function returning underlying tcp stream from request id.
>         This (with the above change) allows avoid connection break
>         for the long processing post requests.
>=20
> Changes v9:
>  * rebase all changes on top of origin/next
>  * update test/cmd/wget patch description (bad tcp ack/seq issue was alre=
ady
>    fixed in origin/next)
>  * tcp: add rx/tx packet counters to a tcp_stream structure
>  * wget: use tcp rx packet counter instead of own one
>  * netcat: use tcp rx/tx packet counters instead of own one
>=20
> Changes v10:
>  * netcat: fix bug appeared after rx/tx packet counter addition
>  * rebased on top of v2024.10
>=20
> Changes v11:
>  * fix spelling in cover letter
>=20
> Changes v12:
>  * rebase on top of master branch (3df6145db0e)
>  * slightly change tcp->rx() & tcp->tx() callback declarations, this
>    allow us to terminate a connection if something goes wrong in rx/tx pa=
ths.
>  * set net_boot_file_size variable in httpd_upload
>  * set filesize env variable to a proper value netcat and httpd_upload
>=20
> Changes v13:
>  * rebase on top of master branch (8573ea41058)
>  * remove netcat support
>  * remove example httpd server implementation
>=20
> Changes v14:
>  * fix issues found by github CI

Sorry, I waited too long applying this to -next. There were a few merge
problems. I got as far as CI *almost* passing, when also applying
https://patchwork.ozlabs.org/project/uboot/list/?series=3D435653&state=3D*
to fix "bootefi hello" tests. But I could not get
lib/efi_selftest/efi_selftest_http.c to pass still:
https://source.denx.de/u-boot/u-boot/-/jobs/972270#L360

Can you rebase one last time please? I'll apply it to next once it's
posted so we don't have to do this again, thanks.

--=20
Tom

--rrMxHxVlcKeAVMyP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdZrPgACgkQFHw5/5Y0
tyzGwwv/bldWtXndoxYqc/cF6NVqIuE9UqsuHPKYpXLlauPc+EXNZDbN+doVTb2D
R9BTx7GHEkz0fkg9fTAr5voQTdadFe0L4JGSnL4FUQ0Bmsg/Bn51NSgBSx88c1vW
eiG1xjq/XXTE7AZSoFA1eXIGEe0aeZTe64M4mVfxDQtnQz1/gXQ686wKL+U4HfaX
qCsHyiRrBoZVsPGuhIIUk80hC+5tshlgu5d9s+x+y8+qfO0o53ZWBxHEIwQdMBq5
3kz7ZuFMhB+Pp+jXeDoeAsV9iVYF7YR2Ax+RjAJLP1SkwiNtR1/tz+dSywXkZ3qR
/BS9VLKE2L/cZNbbbAwXms9Jd/TnDz1WcNQ/Pai7AaARodIB66mduuQmx6qexHCO
uz+OMiPisvDUX51w/KfaKs3m5AQy6T7lhWWGO7hdP4TE81iYI3VB4ho1E7GO5mu2
tCsk8GB89vUgTq4P2rEg6+n5KXt17RpHEtBFYjBnhHyO9tXBkpJ4znA3HjVOVU0b
ilJ+/8cI
=6v6u
-----END PGP SIGNATURE-----

--rrMxHxVlcKeAVMyP--
