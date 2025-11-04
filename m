Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC07CCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 23:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC83483990;
	Wed,  5 Nov 2025 00:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SpfqTw+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD9B8399D; Wed,  5 Nov 2025 00:07:52 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE9E183981
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 00:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3d47192e99bso245106fac.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 15:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762297669; x=1762902469; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7FEWlvGe7WdPK0DvQObR5b+EEC6MBZcZ56BYswg3iQ4=;
 b=SpfqTw+Rz1uixHhYDoFfWO0ueL36FdsQMBb3QOuhBXOWbBxqzcJlnHmdzxSgGiTqv4
 RIVrs1k7ozGfTvqdE5CN5c8efI8gZ7oGPW+w+jQyulicPQNKh86BnyN0dfHkYo6CeveN
 iC2qhWbfcLX2/7ljJ7cUgbdn4YI0IqapKooXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762297669; x=1762902469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FEWlvGe7WdPK0DvQObR5b+EEC6MBZcZ56BYswg3iQ4=;
 b=TNIby6bTCbW1dKL4dVGjRGunwxqPtlfOWhWuOXGvEcAgr6DUbhVVD72DAjSuuEqiNe
 s+SQkhgr5AoUAJ5ggWMX5F73lbUTcXooOMm5tFLof3eGyPWgOtQbMcYwV/juHLst9ZlH
 TKhQTMlX2YmxChjaCuTRWcya/r1K8Zjz+fvDb3FmF0DBBY5KaYXLEkueoNtpPwDpQPb8
 YaFLxkBa3dTOYPwSxfjW8uqO36YJoYjLP9h7huzOq+fPf4iRyhfj4hyl8OjbL+zpncx2
 0Qi4Bw6n3EX2/xbG/cprVvxI71tBcOzr1RGt6KL6sQE4mydaBxzIqUR2YG+stwRASZhV
 NUmQ==
X-Gm-Message-State: AOJu0YzxXETsIWvk5aDyCGBMEcRvojhx6ymNfh/PdqX8xUU9in3oP23v
 nNw3lv4TTNYwCS8Fvm0xhSmoWUDixWpleIP7l9g8itOMnee7gRYDAir6YWEl22hPncw=
X-Gm-Gg: ASbGncub2wMAm/VDCPzIz2KsS54qHPpE73WJ5tbaSiI+FpPtcc9WzHKRLYSF+fmdllj
 5vOtb3Tu+ZO/URg7HDCajalK0W+XBpQQWzn/NPF9EOoYYPbXS6CAXq/LKbhulZToFdw+uLrFVwk
 +BJscLHbErisR+JqXKK11kFRIAm8ZGmT5awgF5lgBO2d9NWvdKmb4jUg3XSmjv5aK8+R+srsP0H
 HuIfYYuqdS7ZIDsE/WI/ueo7jHeX2NMDqztyU+yizUKuEfBPy8fyPJimtZc321BjT4RIlSJ7eTy
 UgkwHHfWxIVPwVSFG4p8y2dxmvJWjOqR7xY0kF/qbHTfI5r3nEp00xY30Zbem1sHOW2tCTyJQjg
 DYpef6XsMSmbEJ0fb/b797lVRWwyjrVEom05WxqfWSGzeYqb+dDM5IC0xUIXDrBgFXilGUOinaq
 ynzBeQmXfvK/AW6HpPAE+xH1ivmH2zw2BbKlgb1nI=
X-Google-Smtp-Source: AGHT+IHX5n8XIPoe17PJQFQjYbKs26B1uDPk0LPqPtndtreyy75VgguNXelddFG3+j7GDmE221OboQ==
X-Received: by 2002:a05:6871:71e:b0:3d2:5d68:71cb with SMTP id
 586e51a60fabf-3e03c6d514amr2342649fac.22.1762297668608; 
 Tue, 04 Nov 2025 15:07:48 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff6f61187sm1526372fac.13.2025.11.04.15.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 15:07:47 -0800 (PST)
Date: Tue, 4 Nov 2025 17:07:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6] Add optimized Makefile support for SoCFPGA handoff
Message-ID: <20251104230745.GK6688@bill-the-cat>
References: <20251104010003.525-1-briansune@gmail.com>
 <20251104175123.GE6688@bill-the-cat>
 <CAN7C2SAvyfUyTqy8sqKxPWPG9Bu+aYiXGjMzfVJxR+mc59TD4A@mail.gmail.com>
 <20251104211832.GI6688@bill-the-cat>
 <CAN7C2SCLbo-9=QS8qURd=zwWyOYidAsCtb6E-CGbCmh7yrN9nA@mail.gmail.com>
 <20251104223753.GJ6688@bill-the-cat>
 <CAN7C2SDnm5cK-J=DocOk5hS8k_7565RB9yg5XNVu_kaNb3UjvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ihmtczd1RIOrRMoL"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDnm5cK-J=DocOk5hS8k_7565RB9yg5XNVu_kaNb3UjvA@mail.gmail.com>
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


--Ihmtczd1RIOrRMoL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 06:48:19AM +0800, Sune Brian wrote:
> > Yes, it really needs to not be in the top level Makefile, the more stuff
> > we have there the trickier upstream merges get, especially when this can
> > be hooked to archprepare and work just fine. Thanks.
>=20
> Done~ see v7
>=20
> Now back to the documentation you want.
> Where and what should be included.
> If possible, a good example can help me settle things faster.

Well, doc/board/ti/, doc/board/nxp/ and doc/board/rockchip are all good
examples of how different SoCs have provided a pretty good level of
documentation, some of which includes various external blobs or tools to
also use. That might be a good starting point for better documenting
socfpga and then also including using this tool.

--=20
Tom

--Ihmtczd1RIOrRMoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQqHPgAKCRAr4qD1Cr/k
Cn+IAP9quG7km6ykSQ1Vbb7F1HrWjzM2/8UnXCvIXxVz9Gb3eQD+PguxCRgnkK3v
S+Ty1lBq2h4fy4oILjggMM+JMNEQvgc=
=ngdH
-----END PGP SIGNATURE-----

--Ihmtczd1RIOrRMoL--
