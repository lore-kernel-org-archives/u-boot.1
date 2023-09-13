Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1F7EE0211
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 22:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16E686A27;
	Thu, 14 Sep 2023 00:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uFPW/jo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A4748676C; Thu, 14 Sep 2023 00:04:30 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1337586EEB
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 00:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59254e181a2so3470607b3.1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694642666; x=1695247466; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QOLP1vVlV3qL5Z5Z8y2X7pbuej2VWu+taQ33WMjqCak=;
 b=uFPW/jo3Av2IucWrTGuKRp2/1yNSMEN15tx7Ww2b3o1wqa++TwfdMqRt0SxXjd/Jya
 AdPAW9HbGJ7E7o19mGK8MDDLH54B0Vg4dkP5phgB4QUOT0IjSgmvrHPXKiPWTY+gXKYR
 FnXi4sBNI4a0J9wZya14sCuHxgzPTIb+qlrxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694642666; x=1695247466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOLP1vVlV3qL5Z5Z8y2X7pbuej2VWu+taQ33WMjqCak=;
 b=APrOJ84owzrp1+/5ZMkNUYubhpwro7UUkqLWY0iUsCYqTvS3AnQtgk9MAxdGJ1ZDoc
 87THtXYEXNA41g7T8bQCs7jfGpCp5H/zbg/IOMDyYvF9XrKP8qnX+N7awwy1AvETf65U
 9qZZgRV3gIAtiiUd8f8OgwJZP3ENrmiUEPGOUEYhsPF6JiYTPMncYHgnCnplvixQK1OB
 8l6ANC85qOBBLHFMStiTB7nndlLpMHC9BSW9t+Z9a4hTgRroj3Za3fZauasLuPZ43ge3
 s6+eiuhBEgbuxY28tnUZELgbQPfWYR9yh/cxfe7J1eJgrKQTn1QJxEgaui4mtVkPBSKl
 /Uew==
X-Gm-Message-State: AOJu0Yy/ZyHB1u0pwNKDCNTb+IpNMf6Li0+Lr0ZxtXFD5GcAuL3rkaqm
 E4dv7A5/uCwmaCT1vv+CTjGITQ==
X-Google-Smtp-Source: AGHT+IF8ZQgc4WtcbVCbCCYw5wvZTHehLu6+/M4it4cTHZrH7FiAj6xEnjabWndT7IyPIBl1F4idPw==
X-Received: by 2002:a0d:e807:0:b0:59b:1b87:a95b with SMTP id
 r7-20020a0de807000000b0059b1b87a95bmr3585663ywe.20.1694642666638; 
 Wed, 13 Sep 2023 15:04:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 z185-20020a8189c2000000b0059af9f2ee68sm6403ywf.66.2023.09.13.15.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:04:25 -0700 (PDT)
Date: Wed, 13 Sep 2023 18:04:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] phy: Refactor generic_{setup, shutdown}_phy() to
 reduce complexity
Message-ID: <20230913220424.GX305624@bill-the-cat>
References: <20230831230705.1040105-1-jonas@kwiboo.se>
 <20230831230705.1040105-4-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zSps7wbMqBuEf5uS"
Content-Disposition: inline
In-Reply-To: <20230831230705.1040105-4-jonas@kwiboo.se>
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


--zSps7wbMqBuEf5uS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 11:07:11PM +0000, Jonas Karlman wrote:

> Refactor generic_{setup,shutdown}_phy() to reduce complexity and
> indentation. This have no intended functional change.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Applied to u-boot/next, thanks!

--=20
Tom

--zSps7wbMqBuEf5uS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUCMegACgkQFHw5/5Y0
tyzMlAv/fNEYcLBtn69C5sCvaXjXQYdRBrZQIXL/waUVWcbyzphyS9vPXRsMThhZ
R6wTdhnYKBXHZdhG/6S/8Di+XyNIXmJDLegAeNW7sNUjGXfHEW9RZelTMFTPVpWc
XDa4a0e5BuzMzRsZkQfAct4kMn1sULXYxFyxchhQibQIZ6r+/frwUpE1j1JTIPMe
rjT+WsW7vtkrmELdFZebzWr6NA8SrPUVlwjmOkw0t93ID6S4F0ZNsrTQHeILEqZ9
oZd+CbrdnPiWiARn7r/XqLenUHSmzwrBh9KRz+3ySDfG6Jvx4qpocsG8QD6SlLkt
osAkFvyrMPT28fNx47E0jMab9LXpDUJpS9lK/qBOh44KIDNpdofGO94xu5hjNr/p
az4GrisgMLUMvwPkATQsgfkTygGULU58sC3lqWC/Zzl30Qo7CDQjYzwkH8Ze8jxd
TBdtPxgSDz2Pz9sHcu8F1S9LxsgATBeJmfMHDcbSM5Mm/93L9AMwcFiIVc8CZDCC
CF/tGVWr
=s2pp
-----END PGP SIGNATURE-----

--zSps7wbMqBuEf5uS--
