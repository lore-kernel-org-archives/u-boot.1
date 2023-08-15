Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F55C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE0386874;
	Tue, 15 Aug 2023 16:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jebr9AMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C73D86863; Tue, 15 Aug 2023 16:42:56 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB1A2863E9
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-589addee1c1so48791737b3.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110572; x=1692715372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ULq8Ve5fIduV96tG/u5ZeZ+7Emss1z853PiN+IeQowU=;
 b=jebr9AMK+po6GiVJrsar3V8Y8aUhq5s91ANkhciNH6tJ/nWyD9FFnwhzyQ7hoi1f8j
 2iH/m9mzN8GA8HlYZjNuZeBUkSwwA7eSyOPPB7tDc9yQOqUwUbrVb3h2AHVF6c9/9f9Z
 dc1nc3n2FLJOO7tJZ/9PTkN2wVRNhJJeIx4Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110572; x=1692715372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULq8Ve5fIduV96tG/u5ZeZ+7Emss1z853PiN+IeQowU=;
 b=jVWZydl4pDDVWNHCMsK8Fwa/NLcgWFgak5oJJayTNsyqA4Ts8qGgsZ4SO+YKA58e82
 wnbWe9p5TCUgQtiPfQpx12QOfquit2/SAAwT9aeiqioCrsrU5fdu+J0b+Gurjktew8QH
 T6T+FDZstNYXSRyQuOpX7tJt7xIWZy+7bhJvMP5S7vBWMZtYxJKpttbMfwC7APY1vsN3
 enqwZQ4iR3nM/CxgB6JlVocy+hwrppWePmMaKzeFjNcQg/CCE2PIW0avCqdc+aKCkGu9
 XBFsmP9L+hStcQiEjgA/on7Axmd1+k7tonG45KvqKaKmQ+blpUVbrqXqPT0mtWjtQuCi
 nwgQ==
X-Gm-Message-State: AOJu0Yz01D4BlQj3Gue2FsIqYdshubYlE6P05fnyjWZFdPMjZVQ+uv/p
 7+lEXeArvl1zhos9ba3ORopsrA==
X-Google-Smtp-Source: AGHT+IG1GAF997dqlUJYjIzQX8wqeqa1fA9W0r11PjnDoC7gsAgAnsa8fE2wDoIlGKdrcehxc4L9MQ==
X-Received: by 2002:a81:834f:0:b0:570:28a9:fe40 with SMTP id
 t76-20020a81834f000000b0057028a9fe40mr10630392ywf.5.1692110572469; 
 Tue, 15 Aug 2023 07:42:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a818407000000b00589f590be00sm1304892ywf.66.2023.08.15.07.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:42:51 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:42:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@redhat.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 goldsimon@gmx.de, lwip-devel@nongnu.org
Subject: Re: [PATCHv6 03/14] net/lwip: implement dns cmd
Message-ID: <20230815144249.GM3630934@bill-the-cat>
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-4-maxim.uvarov@linaro.org>
 <ZNo3+qhKIEqmdMTh@hades>
 <CAD8XO3a-C1oiZdcy_sk0DOzKwPEq7pBW6CsDeSHM-bmLE=RXHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zvMa4AkhIi8EK+yK"
Content-Disposition: inline
In-Reply-To: <CAD8XO3a-C1oiZdcy_sk0DOzKwPEq7pBW6CsDeSHM-bmLE=RXHA@mail.gmail.com>
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


--zvMa4AkhIi8EK+yK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 06:42:14PM +0600, Maxim Uvarov wrote:
> On Mon, 14 Aug 2023 at 20:19, Ilias Apalodimas <ilias.apalodimas@linaro.o=
rg>
> wrote:
>=20
> [...]
>=20
>=20
> > > +/*
> > > +* This function creates the DNS request to resolve a domain host nam=
e.
> > Function
> >
> > You need the name of the function as well.  Please have a look at how t=
he
> > rest of the code is documented.
> >
> > > +* can return immediately if previous request was cached or it might
> > require
> > > +* entering the polling loop for a request to a remote server.
> > > +*
> > > +* @name  dns name to resolve
> >
> > @name: etc
> >
> > > +* @varname (optional) U-Boot variable name to store the result
> > > +* Return: ERR_OK(0) for fetching entry from the cache
> > > +*         ERR_INPROGRESS(-5) success, can go to the polling loop
> > > +*         Other value < 0, if error
> > > +*/
> > >
> >
>=20
> Is there any command to check all the files for the comments style?

I suspect if you included them in docs, htmldocs/etc would note
problems, Heinrich?

--=20
Tom

--zvMa4AkhIi8EK+yK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjukACgkQFHw5/5Y0
tyxYxgv/eSnaZaNRxc6rZxf/l6x2cu9Erk+huIr0AcuWwc/u5/lgnG4mGe8J14wg
gyPLDhlLe1+JRHYAjp7CRegUo81QkHY1hio/s7Q0ssg7+ERDwBG8oP+L/rZCmFsm
TmkRaasqby5cO5Zf+laWRczoLZJe0Cs1bHIibhhyO068PmhMoflu50jDPLmPD0Qt
4sv2WBhiT5vsPq+84CyxaKrw5ukFqb1mqr2AlX/O3HZgdSgps/M7OzoBfuG5ejnr
NqQtddXJuIpq1TuB6BZ7dGXhR19M6afKXotqVEm2nDqCJl+ReKVnM+0TWOCiomJZ
9zLOL5GuY0i7xbFu9yf9kr0WtDmZmycyhS+gv45U2tuGPGF3cl3mxQRBdNk01WSj
BKEmBeWO8vGT568PQHLg65xvZ/KgYM3hIG4UpInQkDryLQcH7Ip0FI+B/gLlahiR
0/eZDS98Huiey8Ky1ROuxvj9SPk6XCiV7zD7eyTTv3HOaLnD1KuediYraFuHnbxx
lQngvIpL
=fOKc
-----END PGP SIGNATURE-----

--zvMa4AkhIi8EK+yK--
