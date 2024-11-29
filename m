Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC9BD6EC0B
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 13:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B10F88919F;
	Fri, 29 Nov 2024 14:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tb+/sMD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9176891A0; Fri, 29 Nov 2024 14:36:26 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C498904A
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 14:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46679337c08so10288411cf.3
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 05:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732887383; x=1733492183; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5R+R0ve1V956Ox2iKIc5ATtatiWmbkKKSQ5pOi6VIk8=;
 b=Tb+/sMD4faarlY2am8ikNV1eEPf1ew3I9RfFDWONdbMpLsSMOWwochj2vmGB4SZ2xr
 mhpNJDn/TWJhWYZSz5/qkX6Lt5VXbfKeYfycmz7AqLmjkRD0XNrOJnfwiGo2HpE6UODp
 OKwPyZvP+/PxNx/HIfMD5kYuqSlx/Nqrik2IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732887383; x=1733492183;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5R+R0ve1V956Ox2iKIc5ATtatiWmbkKKSQ5pOi6VIk8=;
 b=wxBoJ+ppUeZNH9TtUIyTEkwwL3AIT5Wz9ltihAbxguhrAHKH4UrgmlWWdQU0s7LNbf
 vaNc7JTk4zFVWM3mbhYIxZk2krfbkWdzPRST7uhKKHCWEQFYkBJCcM+yXpAllIg8HBfc
 lZu7jlFGft4glvHz1Qb5QCk1OhE8m1tnC6nhlXUfoMR/owfw9QtprO4q+OYwknVhszs3
 RznSVIrAxZMFhgrXIty+mQhv7ETeEi0cjLQnQIeqsDiJS77C3HAaDl/Td7P1+X8P92yQ
 ZYbBC/vEiYnRhOSU4PZexW0SLVpjMcOnZixUAMfS0z863CmvGWHNSlIYO86nUS8t8xE2
 dMQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyVulqy98hTz3pZWiZgF9gT7Tkh6s/yipL2xlvleTxHh+ncAxtZrcA9ZbW68IdzDMPeTZSUYY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+PsTOka8Jp9eDg7lf8KWTiZY3qDzCbnXL4ZLZyKDVe7trsTxF
 iBGu/v0QMCpMR/d21KpIkti17gOPvB7KcfGbRopwv6PMwe9w2UNYDR3AN1H+02E=
X-Gm-Gg: ASbGncuhXEqlzJ78W2Cbbly8qOvQIqb49faPsSIV/6eFAceEluGyphuj6MzESbpDpuV
 CMIZn0wXSI9fRoPwD/5xzXxNVwDZmBjGWP6DyxTFP2YbrnaIBKB43aqKwf2NTOOcjhCcxkJNkXa
 6TPVdAPjY4b6EGBFXlA6Gai/SoOGfnjFaaHYzNzvoJ1jOiWme1WvXK0h5WiyuHE7BAYcVzIROXh
 rZNC5W0/4POZ9xIGkcvrtFP8+eDaZrrNyHs2NNHGuuqhE4vdA==
X-Google-Smtp-Source: AGHT+IGugDDN5KmLkzBpTxK2fYShG0ECQDnpOgu0vU9yt5gqWUuKscosC3hTtzLkXcqzO431XWbD7w==
X-Received: by 2002:ac8:5701:0:b0:466:a091:aa34 with SMTP id
 d75a77b69052e-466b36b5063mr207328721cf.56.1732887383187; 
 Fri, 29 Nov 2024 05:36:23 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c4254853sm16661081cf.86.2024.11.29.05.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 05:36:22 -0800 (PST)
Date: Fri, 29 Nov 2024 07:36:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Udit Kumar <u-kumar1@ti.com>, vigneshr@ti.com, n-francis@ti.com,
 afd@ti.com, u-boot@lists.denx.de, nm@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix OSPI boot
Message-ID: <20241129133618.GI3600562@bill-the-cat>
References: <20241119100720.1297067-1-u-kumar1@ti.com>
 <20241123024219.GU3600562@bill-the-cat>
 <CAFA6WYM9esX2VwGf91P9ics419OXq48zH_Taq_0xtHT19HmgUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3thNY3SJI8t/jbMD"
Content-Disposition: inline
In-Reply-To: <CAFA6WYM9esX2VwGf91P9ics419OXq48zH_Taq_0xtHT19HmgUQ@mail.gmail.com>
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


--3thNY3SJI8t/jbMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 12:33:04PM +0530, Sumit Garg wrote:
> Hi Tom,
>=20
> On Sat, 23 Nov 2024 at 08:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 19, 2024 at 03:37:20PM +0530, Udit Kumar wrote:
> >
> > > OSPI boot is broken due to missing bootph property
> > > in pin mux of OSPI.
> > > So add bootph to fix OSPI boot.
> > >
> > > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> >
> > Applied to u-boot/master, thanks!
> >
>=20
> Please don't merge direct contributions to dts/upstream subtree. It
> should rather have been a change via *-u-boot.dtsi or a cherry pick
> from dts/upstream subtree. Otherwise, it is very likely it's going to
> cause conflicts.

I thought this was a cherry-pick, sorry.

--=20
Tom

--3thNY3SJI8t/jbMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdJw08ACgkQFHw5/5Y0
tyzMRAv/TqZBLcPXcGNHTPb68/cKw1IiHLVluY/Wxmmm3dMGiV9g50/WAvo0IGEG
AzG1MoiCwR6vZiq67iEKQX3YTQVVLOSX85BOQVf4UGksi/lCF8fGtPt0ZZqsfYhT
MtB5AkB+vTwHKYXPDhjTPQYC78rhL573/gZNuhQl442vkNuALFudbtoU5Tt+CJaT
kwHxkQB7eJT7HaOKRYxSE5P/4D3fTqg2yeuu3Bs8XLKEQ4Hy+ZeEuweGTVcowZyv
8gdwNvJsJ+yHI/IHwk+9udY0jR0aLgh4VbkV5vd5nz9rf38GWieAtvkA5j3EVA9r
SRYrcrTDnAL2/GfceOvFGqme1Rh/vkBcY1rCNyM8Bajlvy87MDate+bsOnSKvO5p
weY8Auw6PTmXRIlzGIBEpGJdsnEAKe2a6f9a8O42nb/wHizoWkWuYIAER2g5Tql+
zis5QPhJmD7aZ/nd1V83ytcRXAs4IaYNyW8d0K3r8deEI0KFwqq6HFD4Cw6CBr4p
3u1U9crV
=2Gxw
-----END PGP SIGNATURE-----

--3thNY3SJI8t/jbMD--
