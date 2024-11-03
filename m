Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C70AD11194
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 22:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF38588F12;
	Sun,  3 Nov 2024 23:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iqmdkAxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E142588F3C; Sun,  3 Nov 2024 23:46:27 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EABB88EE1
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 23:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46101120e70so29017231cf.1
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 14:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730673984; x=1731278784; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uO7lskVC1bTcehMW5OIrULwnRAR6q8h0ZT4R8IzhJk8=;
 b=iqmdkAxvJptfShgYvqytVEw+3EbFOBjgb1+sNs1C2DjIec1Rw7FW2aXd9pTX9EIIkC
 dfgW7ELf3QWlCRAEsR92KJFYCbEqDH2LvV/wGTuTS6ydmJGq7eYsG61OWweWsfUESCuv
 H9rEGUQejiKKt+/s+wXpdfKrA8R6lC6DbsDxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730673984; x=1731278784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uO7lskVC1bTcehMW5OIrULwnRAR6q8h0ZT4R8IzhJk8=;
 b=Kh8H+wQof31a2yjhMbouFi+iThRnIUxfxb3Z2lgTYSfct73IKmO40oeD7vAj5iXy55
 sbMkFw0b8d19wOhpmWQS4fGjWgYAEVCNRjyTSmEhQLbyYxdMTdWPRFzoUDj+aJJQWXxf
 SWbefhqxW8QY9XUY34MVwx5bQsWnT9TkIZVXCn5g2OKQw1fxdFtjVOl1FJWHhUcYh988
 l+3/fVbilfWhRkVoq3Z5W7GdlTNpG28cGIjjEKpEETOTIrcX0HMgCUOB0qnko9WG0zos
 C9g98XxQsNswfoWNNzUfAjlIRstpqOylQZXOa4ZGa5dnhWbKMZuxF1i28ngJe3iB8hCb
 wBaQ==
X-Gm-Message-State: AOJu0YyWSpP6CxDIWFGa5HYHQINnsw9rKN81ov9wOakwEf4qMse87GE/
 QPbkfCjRJQB2CwFmNoot5E5H2K+8oa6ScujlkcP1hRZaZSMavbQO4IWP4f6T/kM=
X-Google-Smtp-Source: AGHT+IFrv6mkFY3Wxq67zWotYpUzXc76SK9dwb41Z8mWLRXCJRG5qjRU3VYuJWbs5r3X6+nGsMAOow==
X-Received: by 2002:ac8:5483:0:b0:461:73d4:c930 with SMTP id
 d75a77b69052e-46173d4cc13mr199807611cf.20.1730673984182; 
 Sun, 03 Nov 2024 14:46:24 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad1b53e2sm40785461cf.91.2024.11.03.14.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 14:46:22 -0800 (PST)
Date: Sun, 3 Nov 2024 16:46:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20241103224619.GE3600562@bill-the-cat>
References: <20241103165951.109723-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w+TfkTyYAwJCFYZP"
Content-Disposition: inline
In-Reply-To: <20241103165951.109723-1-marek.vasut+renesas@mailbox.org>
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


--w+TfkTyYAwJCFYZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 05:59:27PM +0100, Marek Vasut wrote:

> The following changes since commit 8e5e64d55de9ed97875a0c1b7f293a0286d643=
12:
>=20
>   Merge patch series "fs: ext4: implement opendir, readdir, closedir" (20=
24-11-01 13:38:05 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to e2635570e08199bb5644ce164def2a46d1dee9c0:
>=20
>   ARM: renesas: Deduplicate common Renesas defconfig (2024-11-03 12:25:57=
 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--w+TfkTyYAwJCFYZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcn/TUACgkQFHw5/5Y0
tyzF5Qv/Tjsy6Zf8jZhZ6K9zMI9uLqKsSnVNa+7MEc91sf48apTfstPlsfiNi5iH
YDWjsyNpdO0APMt0qj6DRXcAjG5JXKM+50w2uciItuLVTRhCh6jngrcdSDRSqKfb
7hMxRTdTVbVXhgURD2IGa671bW1jaiYE2yYVZ2DDIM8+fNBdy66+aSHxoQBgtKza
yQmsmx370zASBQiSryzvY/rGhjK5VXZkHqiHvPzgwmn0RkfI7UXwThHJtO+ANy0e
9d0nVckuc+rU/Ob/oHseuNL/qCytAPoPRjTfaR7d/5nbxii5UVYTuGNlwkvMs6v0
xvqNG4ca3sXo14osC1/3ADRXguJra/6zHwvYUcj2EpySrT37fyzBlDdxvc+9SuZM
HgnFDEzWzFAvWEoKNDFJfJBJ/V4V6aOfrIg9dxRVSjTOzmCJJrs24MHS+jZAsdkX
1PM9seW+azTWa1lCA5wp8w+P/Zq0OMuqlFd8JEa5FG4zBUk15wRSXFQ/McKgQHSv
zou5bWuq
=ZLqd
-----END PGP SIGNATURE-----

--w+TfkTyYAwJCFYZP--
