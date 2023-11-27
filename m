Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33159C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 14:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E43887771;
	Mon, 27 Nov 2023 15:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rntSatkn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D0687585; Mon, 27 Nov 2023 15:10:46 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB51687759
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 15:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b8412723c4so2801527b6e.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701094240; x=1701699040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/RJkUlRW3a8om+FJ9YHoikd3yIdfHokOV8RzLSFVx8g=;
 b=rntSatkn0I/Qq4OprGd3ZM/RpvpznesHyPBB6hg3BZodmZE5KmMk9q8GGh8bkZhm7K
 ASt6HgjcnGFq9pg9ojBmuaU5dO0dM6TLvLC5NybiRiHeGmZ88GDVHLIA2tE8vKBpGmYx
 QYqOiJTnMvtrL3QhxYoKItsaoiP828djXEWvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701094240; x=1701699040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RJkUlRW3a8om+FJ9YHoikd3yIdfHokOV8RzLSFVx8g=;
 b=edRzBd6N9G47K9hOiPHKqezMjsadapAOfQ/D1u2fhn8TkwEi60aPdtlhk0wYkwCgBu
 E/H9Rqej2ZvurAuyboJ8gAVcDgjI+CuQv6/5DPdM0f+ae8LRi6gHzCopFKAfZPo4BTHc
 Ql4nF/Y2tkeUcbavFjYP0wPJdFmaUz9cHbz0VPsP6Ex5ZmZh4+W0Zndl0fzi5LUYF4Rn
 RmLgACntu9c5z6fEhdXvLPrVpDAFZU6jLQWL9z/yAQsPW4HX3uImjdWRTORxbij8RNWI
 Tm8fPu1J40Dj0hNcHeh+pjxNryjVU5GuXm8wfi0yPrNFhnDbqWkop85d54rrvWCkLEI6
 NWHg==
X-Gm-Message-State: AOJu0YzW8B2RQDPq5jMSTK51nIofSEhuy2Ag0qln9bhs2a1s3G6tSmdc
 whFoHBNhC7fMEJE1oJvCe7QD7w==
X-Google-Smtp-Source: AGHT+IHaK6r62dVSfiGSqWoezOrThqgwhbqWM7BqAqcae95zD/L/TcKojUCEdINrlqz1Im3X9NpWTQ==
X-Received: by 2002:a05:6808:1b2c:b0:3b8:5b3e:ac92 with SMTP id
 bx44-20020a0568081b2c00b003b85b3eac92mr10824735oib.11.1701094240388; 
 Mon, 27 Nov 2023 06:10:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a25ef52000000b00d9cd730e4d0sm2951124ybm.26.2023.11.27.06.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 06:10:39 -0800 (PST)
Date: Mon, 27 Nov 2023 09:10:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: "Winker Matthias (HC-CW/ENG-PJM)" <Matthias.Winker@de.bosch.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Philip Oberfichtner <pro@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sergey Temerkhanov <s.temerkhanov@gmail.com>
Subject: Re: [PATCH] boards: Disable NET on platforms without NETDEVICES
Message-ID: <20231127141037.GG2513409@bill-the-cat>
References: <20231117154757.777827-1-trini@konsulko.com>
 <20231125223809.GW2513409@bill-the-cat>
 <PAXPR10MB50858692C89D451A7A18F7E4D2BDA@PAXPR10MB5085.EURPRD10.PROD.OUTLOOK.COM>
 <CAEGM6axzOkySNu7uSmsWthiTQhTb_vMOY_Mjj_iFKKgg_Y=Vqg@mail.gmail.com>
 <CALeDE9NO4UB2fBwAK+dD2J3_nN=+rSeKuitD7dMOcrt3J1U+cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lODwbf3MVdIvatJh"
Content-Disposition: inline
In-Reply-To: <CALeDE9NO4UB2fBwAK+dD2J3_nN=+rSeKuitD7dMOcrt3J1U+cA@mail.gmail.com>
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


--lODwbf3MVdIvatJh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 02:05:35PM +0000, Peter Robinson wrote:
> On Mon, Nov 27, 2023 at 1:06=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, Nov 27, 2023 at 5:45=E2=80=AFAM Winker Matthias (HC-CW/ENG-PJM)
> > <Matthias.Winker@de.bosch.com> wrote:
> > >
> > > Hello Tom,
> > >
> > > Just to be sure. In the past we had NET enabled such that the fused M=
AC is taken over, although we don=E2=80=99t use NET CMD.
> > > With your changes, does I.mx6 evaluate the MAC fuses and forward it t=
o Linux?
> > >
> > > Our board: Bosch ACC.
> >
> > I honestly don't know as I don't see how it's doing that today in
> > current master (which does not have this change) so you might
> > need to start by confirming behavior in the current tree and working
> > from there, thanks.
>=20
> It's usually reading from eFUSES and populates details via DT using
> alias bits, whether or not that uses/depends on code in net I'm not
> sure.

Right. The regular (to me at least) hook is fdt_fixup_ethernet() which a
few boards call, but not board/bosch/acc/ code.  There's a couple of
other calls in places, and then also a few places that modify
"local-mac-address" or "mac-address" directly.

--=20
Tom

--lODwbf3MVdIvatJh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVko10ACgkQFHw5/5Y0
tyx0sQwAlvNTd5AtuFVA1dGgbaUTJZ/ben0sD7govKuJgleVmUccMp+WvGbOJdUb
KQAKS+i76daKEYlANkEd1cd3x61JOerOniXol/6g3mpJ2LQfocwO/JYNUV0109DI
/h7HortM0j/DGOQsu0bu8uI82BtKMKvBW8wd7jWL1x8FlbgueVNzRDdTOZRAqk0a
A3y8qloRcXmrZshBVKlqvSXGPQBf/hIu4gNmvxSt/gawneVNYURuxu9F4Z+birRw
vi3u2lm96JXZN4mFDeB9PN7461MyrXPcQJNKhYkuazayp3JkQKVPgpoCjm2ty949
nphLPPtCVQxEISAfM8nt1Cex0tfmYfuAwfUHlOGu9sEKua2+AkopniQo5Bd+2m8j
ux4XrfybSxlqTMxohcXPcdyHTrBWGSMYzfmXnB73ZA06I7863910IHM6HolUm+YZ
q4Pk7301G5Hd0n8Y0Zo5aaPPc7/WNtKUEOahVNG22hgpJ8LvnVqEGTMiRSSKLXPN
qtmRpQnW
=VP7N
-----END PGP SIGNATURE-----

--lODwbf3MVdIvatJh--
