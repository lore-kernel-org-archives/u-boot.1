Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17010C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CE587F0D;
	Mon, 11 Mar 2024 18:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lzoNgm9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF9187CBA; Mon, 11 Mar 2024 18:12:36 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C1D87EF5
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-42f2009e559so33530171cf.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710177152; x=1710781952; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XY8Ht0wwlo0HT1bC9kzWIhnsSmQfOJk2YLkyPrJ0gps=;
 b=lzoNgm9ML+6AudnP8tCPWoUXbbOSnFI3LBV8Zs7ZC/kzhurSMU5bX8d+O11et8qaOz
 DhMQPI8bR0K4yvAv9+pPSZLeLGvVeab4Srnx0TtsZXP7voOUe9jJjAH2I75yq6Q81V92
 0GotL7L3IVZRMiT5IvugyrLXgWGmCiD9rnV8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710177152; x=1710781952;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XY8Ht0wwlo0HT1bC9kzWIhnsSmQfOJk2YLkyPrJ0gps=;
 b=h5pfVwwRaeB/aConrjdGcAHr8zbUQOU5aUhEKZXblFxeVDP29ZFrDKXubu3PyB2SSq
 pk8q08vDZRWcESgmuIg9T4SQ4MYiOv+Bn7UclCiyLK2mT0Xlcr55t9RqxByvP0J35J1J
 FQkWdNNo0ksDA9BwwwWAnm80tIeEkEpak2qwqTX8ccoCn5T4YNNeVHHNiVsUJJi4Go4F
 Hy2F790h4cPHnovj4mfakp5Q8jUmgGzZ/dxFoBKeGUm6xsHEhMlL4EPAZ1prYQraPxhb
 FwaX+6aQeveeDdvU/tONuUHg52Xckk6WRIriUo8KsHM0s7Edkwc25COWb/W0yePnvkXN
 B15g==
X-Gm-Message-State: AOJu0YyGJK9jRjY3br3bfLImIB6hRua1gub3r/swCz5O58pkonyUXEx/
 v80TS5/Csro+yftrrHXIItc434+HGFCMPsN0P5dDfBQ4NmL1TRUr7dcC/bViSNgH/mR7E80tcTl
 N
X-Google-Smtp-Source: AGHT+IF51+imK1RUNrKW5LZ6iG9GwU85PL+XbIdXIpCcVB1b3KJNMqOl5mdvsU4GoMSHZY0RkUtkSw==
X-Received: by 2002:ac8:5c02:0:b0:42e:fa89:14b7 with SMTP id
 i2-20020ac85c02000000b0042efa8914b7mr11909514qti.15.1710177151740; 
 Mon, 11 Mar 2024 10:12:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 k12-20020ac8478c000000b0042edf7b7df7sm2887296qtq.8.2024.03.11.10.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:12:31 -0700 (PDT)
Date: Mon, 11 Mar 2024 13:12:29 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.04-rc4 released
Message-ID: <20240311171229.GA1523872@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xwnP3a8d8Nwfki+3"
Content-Disposition: inline
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


--xwnP3a8d8Nwfki+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and so here's -rc4, and I'll be updating the next
branch with this as well shortly.

In terms of a changelog,=20
git log --merges v2024.04-rc3..v2024.04-rc4
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

At this point there's one more -rc before the release on April 2nd,
2024. If there are regression fixes that you know of please speak up so
we can ensure they're in the release. Otherwise changes should be
targetting the next branch. Thanks all!

--=20
Tom

--xwnP3a8d8Nwfki+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXvO30ACgkQFHw5/5Y0
tyxqLwv+MeBhMBIFXZY/FNtrIsP71/O6bwfWYZXAipnQIeiFnYEnO0AyWhGAS1zb
F9wf3idlHaIL+RZHPlgeXlzbgd3DvsCWDlTgPNQA99mBdWIW+hib5jdruKj8F62j
6wqADgrogXPMa5sFLt4oSW/1sD4aQGSZArBVndcHRSlA+J28jiXeYUhraLDxdKul
Nn3/9AMZ6CJq/+F82iGDrEuqkqqD08pBrbahhuWJm4JF6hkT+TouEFqfXfDXXKLb
ILh1sUMYT2tBj+agw/N8srN7nuS1SiGlvSaQ/d89+WXHaaVn2GoIp5uRu77IHa8P
zGN0Ri3jQ1aNXC2MJoS3RdkoftuPqOiJJqq23Ufhdg0bSJBg/mjqce4mZA3/r6YJ
z3UPJgnAItIQtRVS7zWHLS6d/io3qPEtnaHp/jLhwjuHHLi/ytmAehl0obJ39u2o
4mBCdy+SUs8LJw1dCaABcidikWrqIVXEuLtCdHuyAX1HTLoK3jn0KwLicc+DdOBC
NG0poyMk
=7QhZ
-----END PGP SIGNATURE-----

--xwnP3a8d8Nwfki+3--
