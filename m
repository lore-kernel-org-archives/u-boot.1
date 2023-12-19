Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28953C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 19:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1CC8718F;
	Tue, 19 Dec 2023 20:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i+DJATo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B5F8718F; Tue, 19 Dec 2023 20:32:05 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DDF86EA6
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ba10647a19so3885741b6e.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703014321; x=1703619121; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NQCz7gjlAE4kyFB+HYUp5mDvnKcAVLnmcBmUDUEv6cM=;
 b=i+DJATo1fYw1gNQJtjGLnG8z9PmvtxpiKTwZCCYrgWWngh+pgij9vgZR1+11tKeiyT
 5cBmIKwd5/YyK4FBwW/vc3Miq8FMi8F0LeZIdt7pj5NS7U6ZNSL29SWIBp97xaXpptpL
 zgy2BUvM3K3yTxkTuSQgxZMtF5viQJBP9MjTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703014321; x=1703619121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQCz7gjlAE4kyFB+HYUp5mDvnKcAVLnmcBmUDUEv6cM=;
 b=QL7Ru7ZbPYYWNgr4CBJUSTotVdEynXLBJ2jdRflXIQ599nq3HHBwsPCqTZRUpAYGK1
 GgpP2WQzGarxH2ZVZKSRVM/9lVD4lO+bT1jRW+yZvtrrL/wXxli7/Od3Ac4RwiY9iZZF
 B1wUi6Uq44AB5FpMLP3vAMlD3Y/HSlDtk4hgeNTtu/k2nn+dnzqYrlzNnCFpm/g4PpGa
 Dm3njXZnhmZnc9ouOzVblBhHEr75oalp2oM3mQw2DZtkXAKzHILrMEORCpVJIktPNaXs
 97m94V+h25ccCZH4VqsYoc0fNX7jwt9VHkahISh8piG+PIxJlnedfG2H/ZS+Sf9GY40P
 Q+SA==
X-Gm-Message-State: AOJu0Yz0RlhMoFTw6qlh+Dt0ZUN1iOPBM5bXGzDpVMzxAituBbMrV6iR
 dBS6LXY+Pv9ISQADykT5bbM2YEeLRin+bYmfn/E=
X-Google-Smtp-Source: AGHT+IEFC6US9dxDWJ/gqbdkHeSGotTV4gsnMyIo3RCCrvzu/ctAVfQ7rWPX+R3UAu/nhlhz0tYPGg==
X-Received: by 2002:a05:6808:1307:b0:3b8:3442:8d99 with SMTP id
 y7-20020a056808130700b003b834428d99mr24148641oiv.20.1703014321611; 
 Tue, 19 Dec 2023 11:32:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 n75-20020a25404e000000b00dbd5bb05b16sm490067yba.59.2023.12.19.11.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:32:00 -0800 (PST)
Date: Tue, 19 Dec 2023 14:31:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v12 00/24] Modernize U-Boot shell
Message-ID: <20231219193159.GA3259099@bill-the-cat>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0JlbHfjNDYwGTr0M"
Content-Disposition: inline
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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


--0JlbHfjNDYwGTr0M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 11:30:01PM +0100, Francis Laniel wrote:

> Hi.
>=20
>=20
> During 2021 summer, Sean Anderson wrote a contribution to add a new shell=
, based
> on LIL, to U-Boot [1, 2].
> While one of the goals of this contribution was to address the fact actual
> U-Boot shell, which is based on Busybox hush, is old there was a discussi=
on
> about adding a new shell versus updating the actual one [3, 4].
>=20
> So, in this series, with Harald Seiler, we updated the actual U-Boot shel=
l to
> reflect what is currently in Busybox source code.
> Basically, this contribution is about taking a snapshot of Busybox shell/=
hush.c
> file (as it exists in commit 37460f5da) and adapt it to suit U-Boot needs.

So, here's a problem.  With:
commit a4bee0b45504397d71302cd1b186f5651424a332
Author: Simon Glass <sjg@chromium.org>
Date:   Sun Oct 1 19:15:25 2023 -0600

    bootstd: Add a menu option to bootflow scan
   =20
    Allow showing a menu and automatically booting, with 'bootflow scan'.
    This is more convenient than using a script.
   =20
    Signed-off-by: Simon Glass <sjg@chromium.org>

We now have a test that checks for a return code getting populated back
up to the command line. With the old hush, we eventually get:
Boot failed (err=3D-14)
And -14 means -EFAULT which is what's expected. With the new hush we
get:
Boot failed (err=3D1)
Which isn't right. Can you please see what needs to be fixed and post
v13? Thanks.

--=20
Tom

--0JlbHfjNDYwGTr0M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB76sACgkQFHw5/5Y0
tyyXOQwAlpqgj6nRuRlfMBEcoldbtvTRwMtFx8DKZdA3w4kOHDcL2kQ0b1yg7CMy
2o083OPjPUHnRdaKT9OJo++FpmC3ek8yc9WfI+SlKiuvMBrSLuY9GuV+Np8+ArbE
mDtb3G1GEFCHMrRj+eNFBa6sDtzX8rF0aSq+1Lmilpg77WaZkPBYArUrfKr5zybu
PY0nZfx8PxKRVTWJm03Zi0kKnJznERB5Lv3N/uzskDT2Q1f2l+nma7HZshPR1Ssb
Ifj5+OLJ4b0T0ZLYQo3XLecM5wAQYHv1G3/OFzA0nhcD7cJqJ4gy3lkMfIFSAvzy
hB55ZryhZvkfZ9wisZuNqyLh49AubgBvU1bai8Q5FyWM05DIrDQSMs6AZh/3uL3Y
8ml7/IkJNfpzULEuvK1XNFcaC6FzxPmsUDAicnbPAsrlWCLqfEXyrYSCjdI5qH7j
3omxe3L+K3m3wB13dY3JJTLMBDTMdroVVaO+uLqbhp9n4/97U8ydlH6+gOFSOF/R
jhF69Wdb
=jFQH
-----END PGP SIGNATURE-----

--0JlbHfjNDYwGTr0M--
