Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A09EE498B
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFCA86F24;
	Fri, 18 Aug 2023 19:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IG6BuWd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6305786F17; Fri, 18 Aug 2023 19:49:55 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA29E8082A
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-58d41109351so31783807b3.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692380991; x=1692985791;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G2G0gcFssZJ1vN2VsSuZT4PJBptriMerskDbHGBkKyg=;
 b=IG6BuWd2q7hvrJ8dhN1Z660z0YZu+4Y6kylAjiXeVf4EG+2PPdCQ2GYKfBBNSD0ub8
 isDo7vYmRZckLfbsu5F7bkm9wOby1sK7Rqe9rm493s2AYfxcTeLY4qQjyFW8VsMtNYSp
 pkTERcuLpx6Ok7obweRfkM7b0zDPP96LjkNyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692380991; x=1692985791;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2G0gcFssZJ1vN2VsSuZT4PJBptriMerskDbHGBkKyg=;
 b=TCVQuqRtrLsqyhcadDr/rhUpViaK+wED2BoDvvlNh+75pgqwK0UZuYjn9rVoeEmcyQ
 X/fTY2dB7UTBtgXsbO0RW5bP9bugxGAr+4xB/0+8W+LXEr8qco9lZvQd5ZHvl/sZZNfr
 dpzprocpjrwxV710GmobiPY8heGFV8CnJk19F+lgv5hyPbxoxtKjx27Py5XkqdTx73Bz
 wP+FzWTJ5X0ZhqdxeAYrigrCG2vmeg6SN9eU9UvdjgBjfZQ4Lh8GYwh1lMvTM97XN0nW
 w+1Pm2M/Qa6SlVTGtkzbYVJjQfmyaWKGUxKVxAMn12qzV7IJtBqwsgQdYyz+E0ncPa/i
 YNBA==
X-Gm-Message-State: AOJu0YxRlKhlk64pnJ6QMMbA7erTwzNATxfiVag7pMIuX8tBoWencYYi
 XyNQEoCSdTqf4pYcHqCrTtuEps5U1nA5+nNlDm3qLw==
X-Google-Smtp-Source: AGHT+IFuQ/NhQn0c35rFGDvSOx7DfYar4ZLXzNgfjMQxUkLiI709AFWAnBCDY5SnMwAJwdM/axqNpA==
X-Received: by 2002:a0d:e645:0:b0:589:a4c7:ee40 with SMTP id
 p66-20020a0de645000000b00589a4c7ee40mr8710036ywe.2.1692380991444; 
 Fri, 18 Aug 2023 10:49:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a818901000000b005869d9535dcsm636828ywf.55.2023.08.18.10.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:49:51 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:49:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <linux@fw-web.de>
Cc: u-boot@lists.denx.de, Frank Wunderlich <frank-w@public-files.de>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] arm: mediatek: add usb support for MT7988
Message-ID: <20230818174949.GG1515023@bill-the-cat>
References: <20230803180001.22130-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BcmaVQwj1AgGo7iY"
Content-Disposition: inline
In-Reply-To: <20230803180001.22130-1-linux@fw-web.de>
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


--BcmaVQwj1AgGo7iY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 08:00:01PM +0200, Frank Wunderlich wrote:

> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> MT7988 has a t-phy and an x-phy controller. There is already a driver for
> t-phy so we can add USB support for this phy type.
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied to u-boot/next, thanks!

--=20
Tom

--BcmaVQwj1AgGo7iY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfrz0ACgkQFHw5/5Y0
tyzdpAv+M15ViocupcoBx6M5k5NbtkqEgOjjtJ/72sUQSB5kqS12swnHziLty3ks
I1LUIPG1Gml0b+sgvajYzcDRqP6IOoOD/Gcx6ghR+KYEZiMW1XtOg+gQZ6tAHY50
rzcuOftNEq8HvT8485emciZMduYlxsjaBD+jMeTd1ClfGmIKNFpMPzRalcuXmWWr
U3K2RmyXiR6VLAYeWwvdmwffrOLuDirMJ408fCJzeYBSaQEErkWWNdKa4c6ZMEJm
eDkay/nrES5E95ab41mEHZOywacKsDOcwsflTPYEOxg5hdymixEMcV6AWVCOHbff
QG0IQ+0li26i2XDcbSAxvOwH3WQZ5irGOuTYzF5miifGa/YmBcn7ouD2eAo/jhQW
vxGAzgYC1r4L+oPFI4scCrs4hlWhUveEGV4GoGS8dqkEdo/icEnGoHiazRRbI7Fs
BIG9QnXveGm1KDU7MMCRIBbLR3q8Q4vuKw1hFzonI40/owozK3zmc7zdgBJxlxnE
bDwAnywP
=gqCN
-----END PGP SIGNATURE-----

--BcmaVQwj1AgGo7iY--
