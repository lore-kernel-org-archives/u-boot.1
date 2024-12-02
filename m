Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E02CD7831E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 13:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0F688DB1;
	Mon,  2 Dec 2024 14:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hj8fRFi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A33D88E33; Mon,  2 Dec 2024 14:27:47 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0C988969
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 14:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-466897883dcso41643831cf.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 05:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733146064; x=1733750864; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=17sErm0M1wVxrsEiojMlD2DL0pmZah+q4STAf6AFDPo=;
 b=Hj8fRFi0vUbpKW4xLoc/jEBXSneQhALoSftZ5UgUVyPgHjcVG/Zadg4H9YNUmGxsFH
 +KbmPi4ahk3JdQEI8AEuWXGkDoRAd2S1js9IXcdo3dJc3AEmgFil1m53kXEzjuQ6iCre
 fv0QB3IaaJj3oq+xExf78BtIi5fVJNLT5k2sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733146064; x=1733750864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17sErm0M1wVxrsEiojMlD2DL0pmZah+q4STAf6AFDPo=;
 b=IiQF36Z2gjvfcrem1hYkowxpy49GRK3I5T+2qf/GOEXDV23tc6kGrO6gENytPqYKcj
 SZuFxoHSGPtkb9mMGebnlM7cSZu33WboVWPp2PTYFVPN1eHFArs+GphtJtbcMkxzDq1k
 3AWZi1hR4/mVTPynScIFxLjgCB+tJyTcZjG1GTfHAuTYJJmJgkHIV5mqoRUPAXE18g8X
 QfByLlNmpE9zgVnZKqn0IhfO3EI3wOD0U/cswRwwsoBiShW7KAZZP5PtnMp3El8ic0CX
 +nIHzQORISoroPZAWszI2GqCPZ0+4b6ZN+jIXcXIobLG25vHtwBGbipVa0ripTi1uBwL
 ykbw==
X-Gm-Message-State: AOJu0Yxz/nuLu6wpU3wUoyFkbEQsyAb5yQAG3u18DY2adlxlg5ckPOYe
 B82Gs4g5Wf6wQbQIMFFKnExh/+pQjIDT2CVqz8VjMpn5leFvn5S2XQmSJzJNewg=
X-Gm-Gg: ASbGncs78sAbVVZNyJeZZBqxVEBsJ33dJqqzai7wRF2bQWwhQvR5I7sFA/dDtBlL0f0
 U9fw4JDEUfYSSbJS9DBOUN8//BkKKAIYnkAdPISShAi9MD/VgXIXAAA/qasN1T5s+895KM7ZTP1
 6B4FuhfZawVPUmDQg+7ZzXQ0lngBP20o4aXp/KkrC3riF5s+UaN3dIyxXwur2OnBKIkktgcLhRj
 s3+rvEsu68zdXPg+jSdzawM1GlzPDWHac7UD4Re+iX6IRPVxw==
X-Google-Smtp-Source: AGHT+IHfngvjMJK3KFc+pMGmcnuCjaBTYw0RRnlPZkq0X+CC1hZ2CLhDplp9M1uAgPk4K1uSDM6tzw==
X-Received: by 2002:a05:622a:5c17:b0:466:9615:b21 with SMTP id
 d75a77b69052e-466b32e095emr358504821cf.0.1733146063851; 
 Mon, 02 Dec 2024 05:27:43 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421e466sm48327681cf.65.2024.12.02.05.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:27:42 -0800 (PST)
Date: Mon, 2 Dec 2024 07:27:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Andy Yan <andyshrk@163.com>, Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 christophe.priouzeau@foss.st.com,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 etienne.carriere@foss.st.com
Subject: Re: unable to access 'https://source.denx.de/u-boot/u-boot.git/'
Message-ID: <20241202132739.GV3600562@bill-the-cat>
References: <a7df8a2a-78c8-4542-8af8-dab3c4b59392@foss.st.com>
 <22662f2f.bf56.193874ce608.Coremail.andyshrk@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uaJm6KkIVNNcz3E5"
Content-Disposition: inline
In-Reply-To: <22662f2f.bf56.193874ce608.Coremail.andyshrk@163.com>
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


--uaJm6KkIVNNcz3E5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 08:16:24PM +0800, Andy Yan wrote:
>=20
> Hi All=EF=BC=8C
>=20
> At 2024-12-02 17:08:48, "Patrice CHOTARD" <patrice.chotard@foss.st.com> w=
rote:
> >Hi All
> >
> >Since several days, it seems that U-Boot git repository is not accessibl=
e.
> >
> >Fetching or cloning u-boot repo leads to the following issue:=20
> >
> >git clone https://source.denx.de/u-boot/u-boot.git
> >Cloning into 'u-boot'...
> >fatal: unable to access 'https://source.denx.de/u-boot/u-boot.git/': The=
 requested URL returned error: 403
>=20
> I also see similar issue from China these days:
>=20
> git fetch origin=20
> fatal: unable to access 'https://gitlab.denx.de/u-boot/u-boot.git/': Fail=
ed to connect to source.denx.de port 443 after 135047 ms: Connection timed =
out

So, the problem we've been having for a few weeks now is that a number
of crawlers have been scraping source.denx.de (and ignoring robots.txt)
excessively and making the server unusable for anyone much of the time.
The only solution thus far has been to implement some region-based
blocks, and see what the fall-out becomes. Andy, in your case it's
probably best to switch to https://github.com/u-boot/u-boot as that's
kept in-sync. Patrice, I'll follow-up off-list to see what needs to be
allow-listed for the ST team to access things.

--=20
Tom

--uaJm6KkIVNNcz3E5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdNtb8ACgkQFHw5/5Y0
tyy9Xgv+K8h6ShLEFExF0iX+Sjs+BeK2MgVkMwRIaqrbRulKcShUqEi+B4cLv1Ni
Xy2VL0hxMfBcVZ8xLKGZlLDf8IpfZfDSfqGc9bRAdRqLy5iAyCeehcW7ntnv3QvK
3q65MU+jpWH7Df6LITyeVMgC8dFIUysQLceSAO9/FT44eg2cNI5AnAXzIBBbKhn3
99Byo2pi47T+Us0R3pQoATS2ooZEmKibjtzUNMpqHUFt40KTEbBP8zYJ+jpuyT/B
qRLFbAPlVL39761ySg2HSuObW5MsPZh7EZC54+3UPxz4UB8Qq6Pu6KFdyzxnOu1f
+w37J/E1PD62tfBlbEktrwB++fP9G3avZNxkDf6tcO5+vP9ZR3O/pSjrn2oybkMQ
6zDFAaJOaDZ7rpGOqEFj2j7292Pr+Uc67CoZWoywK4CLz2JlRyvrrMv/yCv/vAWb
QzCW5qtcNYSviXjFZYM8hFUjqBIw+MtJOm/3njddfWlLASy/3syxyg9PHFqDwexj
E1K7RISk
=Zd/w
-----END PGP SIGNATURE-----

--uaJm6KkIVNNcz3E5--
