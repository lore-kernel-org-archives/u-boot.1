Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10812C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 14:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C7E8829A1;
	Tue, 29 Apr 2025 16:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sbmmdjwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F28B82A0A; Tue, 29 Apr 2025 16:53:57 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F0E82958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 16:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c173211feso1625480a34.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745938434; x=1746543234; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DGBtYfAlTJyjf9Sc7arP/KpuPHLtPnDoafyRXlhQezU=;
 b=sbmmdjwR4tRIiMWP9aiJ7RotgquYhlZ1M5myHseYHVNWNIgdzfiLSh8EYmIASaYo+a
 i0S9SSmsJf0qov6IgMsBIsTQZYSi52W37gu6rGfjnuDPBbdoTnpug614sr056hx8tJlT
 MrO75OAAsMXAtaIXYogvyJ58AIkds7uuuuqoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745938434; x=1746543234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGBtYfAlTJyjf9Sc7arP/KpuPHLtPnDoafyRXlhQezU=;
 b=wY3wA5hiSf+v6uAZMzfS3YhYCHOqOfaobDMnquEpdJ/scSE1WO+zYSTQBffNWnd/o+
 PHN0LDdEqwm7xjyOuAaQc2st5yqfugf0Fr/c5WBcOun4ag1BgqPrOU+zXGF2xg6Ss4ZC
 9IxZK4aFsPku2Ma02bsiCK9DWqr6ljcYKEb1OZNtEZXOTKwH8KR0k+F4S5BNu4/986kO
 pM8nwUR464mFbMytHwdNyT6vNF7Rzs/+ORYXnMuCdMJyg+buvJ/9bXNduGtZbZJ+dUv3
 rAdXlYEE8b09gEW4IPxfnj53jf4xqdORpngz4T7E/EaGT8DXXX9NX5WpbuTyyKpxuvXO
 tDZw==
X-Gm-Message-State: AOJu0YyMQs7+/WIL0kM1mXQCipP0fmolrIc3QQcXlwk8cU7toWMVFJfL
 klG8mhXwnDvrOMtj54thqJGQYW7ISnAx82F5ZBSMY729Clzn2gJk4qpHEZM+9IU=
X-Gm-Gg: ASbGncv9mAZWRzwMFV7ZhqN40rYT8B3sg0cGLip+NXxQJMO8uE3GjtOwdRiMw2/aN30
 oY/hiyCxysbgjhYbgkvuh24PcZp7P7CIO2s+jq4Zu2SLW3jeVX4rQonOSicjGENWdpLa7l9ujnb
 wyNzclxwGqg/JXFa6tHU3861jUobv7uoOUpdAeSiqguAX7iEjTeWJllRUeZo+FXwTACsep25ooU
 f/4C07CiKx6GCXXag+240st/q6BfNwc7SMuSgTTpGJk+dOWeoFOmbGfBcyyg2vg5dU4RIYLenkC
 sE0ZRPt9J3Zue8xcMsr1wbZ9syvPGcPvPbIhMdELKXP3u92FyTYv6gtwkyB47sT8f2X4nGFlSoH
 0cA==
X-Google-Smtp-Source: AGHT+IGkJJKtSVFdsiz7TXEQbEdcGMwz6hQwuRWBcO3iYtM9HsCz2RqEcQMhuu4ZaUEYw+qcHzOIbQ==
X-Received: by 2002:a05:6830:6817:b0:72b:9724:6a82 with SMTP id
 46e09a7af769-7306523084cmr8227646a34.17.1745938433743; 
 Tue, 29 Apr 2025 07:53:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b312566sm306679a34.59.2025.04.29.07.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 07:53:53 -0700 (PDT)
Date: Tue, 29 Apr 2025 08:53:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Douglas Anderson <dianders@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Leonard Anderweit <l.anderweit@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Sean Anderson <seanga2@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH 00/30] patman: Move to asyncio and other updates
Message-ID: <20250429145347.GG1261075@bill-the-cat>
References: <20250429132239.251756-1-sjg@chromium.org>
 <20250429134846.GA1261075@bill-the-cat>
 <CAFLszTgrJvgWJaCXFgefJ1bObsrGfZa6AC8C6ypFRKJQTWm5ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dW8vpOhKeA7aWOCM"
Content-Disposition: inline
In-Reply-To: <CAFLszTgrJvgWJaCXFgefJ1bObsrGfZa6AC8C6ypFRKJQTWm5ZQ@mail.gmail.com>
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


--dW8vpOhKeA7aWOCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 08:35:24AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 29 Apr 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Apr 29, 2025 at 07:21:57AM -0600, Simon Glass wrote:
> >
> > > This series moves patman to use asyncio instead of ThreadPoolExecutor
> > > since it makes it easier to handle requests sent from different parts
> > > of the code.
> > >
> > > It also includes some updates to bring patman in line with the other
> > > major Python tools (buildman and binman).
> > >
> > > With this series, we have a better basis to add support for syncing m=
ore
> > > data from a patchwork server.
> > >
> > > After this, the next step it to add a new 'patman series' subcommand,=
 to
> > > track and manage series workflow.
> >
> > This conflicts with master, please rebase this if you intend for it to
> > be merged to mainline.
>=20
> I will take a look and see what patches my tree is missing.
>=20
> >  And to avoid confusion, while I think managing
> > these python projects in this manner (and not AFAICT following python
> > best practices) makes life harder for everyone else, that is not me
> > NAK'ing taking more patches, I continue to be compromising and "Saying
> > Yes" to things you do that I disagree with on non-arbitrary technical
> > grounds.
>=20
> I'm open to managing them in my tree if that helps. For now it seems
> like too much work to manage them separately, but if someone wants to
> volunteer to help, I could do it.

Again, if you won't manage them standalone as seems to be normal best
practice, we'll just keep them in mainline. It's up to you if they
diverge or not, but it would be easy to avoid I would think.

--=20
Tom

--dW8vpOhKeA7aWOCM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgQ5+0ACgkQFHw5/5Y0
tyyxtwv+LAe9D8+Jzv2+Apfa+dr0JInr5u15E6l7rKB5sNfld7B0Nx72LM/WaX82
4yFVa/FYJDKIIHjFi/NoSEcsjrvfJ5SJ7J+pp1LnN/w/nDs4BiYEEE7sLG5aF2Hh
keBMa7e3sXcgJ8LMJIEe6yg7HgNBW50DWjZli8BZhBzL08NR3MtEI85A2O6Wl8qH
eRzZNn/aZB6KElgXd1HImeqSWi+eBO7dVo0O4mqdGOnqK+4s5R9ZPtkoMO//lPYY
vyzex67TAKdgYOlJux3vnzIooNxVlpjfmg7vBiLkWn3rD0f1ND+J0OtuL0CnuT03
IYwUatAtabq8Qfz+4mdRV+wf6ai9PyzO3ToO9yBaw0VxrZgOOyAWTFy0ew/JaCXf
WoaRyqTSCwPjye6gmpaVfhXVbxgmWY4F2kFhOV4XBbXgG/N6S+5RQiT9bPHC6vtj
tTqFWegsnFJm4MaA/cGGrpxoVrfSujHGn9q13j+9hXotQ/qrtM1cCxmdyBF2Yzcv
ITEwpDfx
=VrI1
-----END PGP SIGNATURE-----

--dW8vpOhKeA7aWOCM--
