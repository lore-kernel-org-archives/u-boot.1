Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4E4C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 18:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4FC88871;
	Mon, 12 Aug 2024 20:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lzxqDZ+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 223898785E; Mon, 12 Aug 2024 20:42:03 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E10C88871
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 20:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db14930a1aso3466167b6e.3
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723488119; x=1724092919; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CShehd2KfRZ/CdM8cKaeedxWhXoJtgT3ZHxAD2VFz3I=;
 b=lzxqDZ+YEj3Siwtjf/scmFW24dPlcYTrQQr6Q2ZZHoXxfMIWTszLoSwJ/MhT35O84g
 2h+m9q5SpQ7TXu1c5GtnC1WvsFqewwem0qPfbC4A/o+DY7q9TylHVO3yTyLbdskq1mPU
 2TKKNOaft1+PIyW7v4nWnEzYiNMb4U01duL8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723488119; x=1724092919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CShehd2KfRZ/CdM8cKaeedxWhXoJtgT3ZHxAD2VFz3I=;
 b=o8wlOubghY/rhhEaC/0eOmIonZKgcTip+MeVK2Bm7R0l1G/pYAVosAkg4cvyeS0Ajh
 gQJwtkuYAbKkYVudA/rCtRe+xoGh0VDDjcGcdEezEb5aD2FPveVrmtwrE7udjxqeXuN5
 beFwzerToiKp1rvGOBHtyT6TMw7oFC41WzM4YeKytezs3NpC+vFQLmMWixGUk6ePgLeu
 z3G5aLajTXy+PQU+ONdun9wxF3rueYb+jA+o7s5QlUoyRPbk6poaZFgbmUrIIzdaY+Vk
 qZMh4hYk8V6C3G+36Z0YMeay8eDFDEByE175njkVBdZTiiLd4NA3mzMI0M/EegSDfZz9
 ltkw==
X-Gm-Message-State: AOJu0YzWtDfMghL6PmKpxcnhPxUGxlBuZ3+dJTlDVuREg7+mmxni7fjW
 GuV9/V621BRICe9skmZb13CKAZH9+AqQe8xq7hgPxTAkgg4PEc9imw0f5RX9IyM=
X-Google-Smtp-Source: AGHT+IF7IYEdByQoE3o+M3wy0EdeZ1rYD3x8nr2C240A8oeGHhEstmBf8sIoZ7lYAgLrzZrqq3Jsmw==
X-Received: by 2002:a05:6870:c192:b0:260:e678:b653 with SMTP id
 586e51a60fabf-26fcb8a0063mr1142904fac.42.1723488119419; 
 Mon, 12 Aug 2024 11:41:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-26c72090bdcsm1923281fac.15.2024.08.12.11.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 11:41:58 -0700 (PDT)
Date: Mon, 12 Aug 2024 12:41:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20240812184156.GF1626301@bill-the-cat>
References: <20240811214017.73267-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2qCqaPkVxJ4YkQQ+"
Content-Disposition: inline
In-Reply-To: <20240811214017.73267-1-marex@denx.de>
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


--2qCqaPkVxJ4YkQQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 11:40:04PM +0200, Marek Vasut wrote:

> The following changes since commit 7bd2559cb30a4e800db519e88a22a25f13c753=
ec:
>=20
>   Merge tag 'tpm-master-09082024' of https://source.denx.de/u-boot/custod=
ians/u-boot-tpm.git (2024-08-09 14:00:04 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to ef1e322f3e1d9a221a1ee6109f6571429ee9fb4a:
>=20
>   usb: dwc3: support USB 3.1 controllers (2024-08-11 19:45:36 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--2qCqaPkVxJ4YkQQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma6V3QACgkQFHw5/5Y0
tyy7Ywv/cYTLl6cJvv5kV7ZNYNi1YSp7hlsVx4HNanj2z0TscaIs0S7uQwvPpr8S
3giSXUnOWvp9xni4bjQynz0TX8qpp6A4Jrg1MOV3MsJiFm4BrFb8p8LM7QnTgjrl
TonPZ1O6nv7rnvziJzNfw0oJaqHofKMON4fAl+xSQe27yDw82ixulZePdFj8bGxm
QBQW28quzj7xQeoXLKXNHdfC1OSBn/7Z3Ubxr1jOwrcDq5IMhgC562j7YZTrX6h0
2fn7Q62Dp49XdQbF923Bzyz1iAI9znqzEO42oom4eXaSyOsx2+OLx2Htw5wX5a7U
QLuI8aN+EN891DyUJS7kqtLrkaYZcFJeYTg1KIy8/eLLo6ncxudyono2Y4mO138Y
Tx3tTQXonKhIVategHov1KwLWhYUwzZcq85LTIZJsKjc0gc2Nhc3PClylomw57ow
wlbH1XXypWlE8Hzhi4pmvRg6XPd6y5s7rPa8HOhYJDm3nKNqNSUeZxy5xtpT3gS7
UHUE+ocq
=ekoV
-----END PGP SIGNATURE-----

--2qCqaPkVxJ4YkQQ+--
