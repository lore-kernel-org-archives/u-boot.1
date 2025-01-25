Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F883C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3A5080F56;
	Sat, 25 Jan 2025 23:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="plEXuZ+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF44380F4E; Sat, 25 Jan 2025 23:50:49 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A555080F10
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7be8efa231aso329343085a.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737845446; x=1738450246; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/vgFefg2sZ48Ty8A8NOKVpuEadZLtBXNjGC4lAKD1Ts=;
 b=plEXuZ+PQDugqIsakFisiALq1m/9bHeHJiQgeuU/YHsv1uuQxeqsq7BR4/H0fdRpTS
 VmsmJyTT2zdG+//fKZTFnYV8DRlb0wnTmEYDlQOKzgjdRhHAFctB2PtuD7U0cEubeINa
 TzNBQ+T1JvGZ36bz/EpiSh3jJZbfGzo20j8ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737845446; x=1738450246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vgFefg2sZ48Ty8A8NOKVpuEadZLtBXNjGC4lAKD1Ts=;
 b=WEy1igeg/gOi66ydmJDa7l7OuIJNa69vDS57uVLivaLOunzpdp2R71cbCMarNqWCZi
 pp4dP30vU6qfzI9bilh/mnKrAybgZewFYW3Jn2EoYO7HnxgknDUebC2Nfg0NJLAH+ekC
 YiPE/ZfC6lDB/2qCurj0tJ493jerlFFTJACQRz9RHdDgPxvfJgbyeAyiYjGcW0Icwxes
 D79bgQeBpwLwGXT4KMWIdFQxJf4MRwJMikGu8ZrmlPVK9K9E9mjdm3Wxzu6FRZUhruec
 +fl5eSXSgBbSfIs0pnVsgs3frTwz02QaVCxAzG/oM2pe/lpWFn75V1/ko4J8mhxWkcYE
 SOLw==
X-Gm-Message-State: AOJu0YwxOhZxCs2sEI/+NsWrzqnGFdGy+i2yVmhlci/PCmvBKvURC95I
 R8cddrUFTYAyUm7i4wxWRdEmwvH1569CleCAjvGpH+svMOWhBu1jwGWN+ez/O3Yx5xgP6qRU1c7
 g
X-Gm-Gg: ASbGncuiwg2L5jhb8zbLGAMzlu9cunwEjipWYy6ave9hY4Hnj3Dzb/2eee1tVV/lv08
 p8WnbqBV4h58BZR+c6eJrxGol4Rxgl+JFcQoQSosNeMWENpvBSCJCErgBvJfr4cIp+KuVj4w9qV
 cPlD8o3fF3ArjjXLxVJvVXLG+Lc/SYhtyA7smw1rYjGpmf3J/BnReXmv+T5Vsr3ecSm2Wy9uSmY
 Pe3mWw3Cik5UusH3JHWNIlL1kfKS4dtpJzMQgcqgyF5CJzUWxdD5FycgPB+VzVd5N/kxkzrI7Pr
 2qux
X-Google-Smtp-Source: AGHT+IEk/sWhh4O08/PsS6RIz8wfvLV+dVpN1I4qU6u9j2fdnSMvhAlY9+TFYS2IF2/b3WTGgu89Cw==
X-Received: by 2002:a05:620a:f01:b0:7b6:da92:fcd0 with SMTP id
 af79cd13be357-7be63210312mr6116367185a.8.1737845446492; 
 Sat, 25 Jan 2025 14:50:46 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae8aa00sm235402585a.41.2025.01.25.14.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 14:50:45 -0800 (PST)
Date: Sat, 25 Jan 2025 16:50:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Love Kumar <love.kumar@amd.com>
Subject: Re: [PATCH 4/4] test: Make net tests depend on CONFIG_CMD_NET
Message-ID: <20250125225042.GH60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-5-sjg@chromium.org>
 <20250125214443.GD60249@bill-the-cat>
 <CAFLszTiqhKn4DF0CQg7egocvvVTu_NhC4BgGaOV6j8zbDXkoxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YRroz4wAvK8DbWGC"
Content-Disposition: inline
In-Reply-To: <CAFLszTiqhKn4DF0CQg7egocvvVTu_NhC4BgGaOV6j8zbDXkoxw@mail.gmail.com>
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


--YRroz4wAvK8DbWGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 03:47:26PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 14:44, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 02:31:39PM -0700, Simon Glass wrote:
> > > This fails on samus_tpl as there is no 'net' command.
> > >
> > >    =3D> net list
> > >    Unknown command 'net' - try 'help' !
> > >
> > > Fix it by adding a condition for the test.
> >
> > For this part,
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> > > Add a blank line to keep pylint happy.
> >
> > Can we silence that pylint? I don't look forward to the churn of adding
> > more blanks everywhere especially since imo it doesn't improve
> > readability either.
>=20
> Yes, but we would want to do it globally. But it isn't really a good
> idea IMO. We are trying to use PEP8 which loads of tools expect...e.g.
> my IDE shows warnings in this case. It might be better to just fix the
> problems.
>=20
> As to readability, I'm on the fence...in practice it doesn't matter
> much as few non-trivial programs have a lot of top-level functions. I
> would rather keep the tool happy and use the Python style that people
> expect when coming into the project.

Yes, we should do it globally. Can we not globally also tell tools the
deviations from PEP8? I remember back when people would argue about if
we should tell file editors what to expect for whitespace, etc :)

--=20
Tom

--YRroz4wAvK8DbWGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVar4ACgkQFHw5/5Y0
tywszAv+NGRIJ30j31XBaNXkTye7epmzf3GaU0AjuCb9OZ03cmMN/OMEXw3F0BX2
bfIqlbQMc8r2R1e0n4/hXppO/652dOgWejZqcwwT+LEFzAQkXKIZZZU24GIG9nqE
qotUV9NrREuh+9brzM1Fbri3C6B3siDhI3ga91v09RGf+Lh3cO6oitJdLpW59wJk
gniGFWVDxOx+Ivjj/dVQqL3IRdqYVnytHUSS7OTgJ9xg9FoDXHzMYnPRzBEfNjTO
yGpgs4JKL37/CU2IJWOj061rfTMSMe5moadaVlg9tUxnwk3Jv/Zk77B3sTXMBlba
fD82MFjkOgV1bY5b55c75GgGLaPruO92c1KxeV07EyK+Dn/ypN/tPhq3OfHlOcpZ
RwGsNjv6fha/uLJjuTdWjGvB3rmKFMCobaeGLjzwGK29V8xwHMGO5hJWKEW7GxF+
Fv5xajn+NeBglejKNlSlylBxcjBczCG1mC9t7+Hfr7IJgRHj7o7JhWrE/ClIP0B5
i1NG3AQE
=JoVA
-----END PGP SIGNATURE-----

--YRroz4wAvK8DbWGC--
