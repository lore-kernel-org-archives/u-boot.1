Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04938CD98CC
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 19:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCA88489D;
	Wed, 10 Jun 2026 21:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="usHGey6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957D6848F0; Wed, 10 Jun 2026 21:07:52 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D85984852
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-486621f0adbso4998617b6e.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781118469; x=1781723269; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r4innw74wX3cWAGTKmxOBFhPjCvS1vUOnfGHSChnw5k=;
 b=usHGey6cZD9TMHeR9hfzST6UM1gcQpk7qACTBAL+nqTHMLqf3u6VG1E1sm+08XP9W5
 Npde39MqejCwobRf+tVkEoAM07fzJ+ltNyrFGbNTlAk6KvBsuAahAdU0lznwbNO5sFlD
 VufGCEY4SVhUQiX+8YBNyolQInaOt1iWKsVG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781118469; x=1781723269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4innw74wX3cWAGTKmxOBFhPjCvS1vUOnfGHSChnw5k=;
 b=Kt3xkM/vlrPbT1wkFvxCXp1mS1NAgriT0RiI+MNFGUb8EtopsqQ7Htwhdz1pvn80I5
 8NnBgqZYxtuAVq/8A88a5c/PydWQuvjYS32fd97FafOLjQCDU7PpE2QOe54OlXaagV3E
 IvgkNvp/0cad+Bohio62aIWNr3gPOayRGLe+Gs7eXms9dp0/bW9HDdMYBZh4hnpgxTvy
 8Z23pTDHG3S0ROP5rH9cobylFsYd4qvIAUD9qFOUaYPPFfC55sg7BcLbp0MomFj5ACsj
 gC1boa0WUlztq5V8ynlVHcCXRO45iQQNTMhZBGGGZ9jdAI+3J2ztSLgS2ucWwsfzJLAn
 ZyVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+A7dpxyY+tFQSvFY2NuziYS23ZNzYkecs7eytBQacd4uZsIpNZDg1T3uMRoRtJRu0bV3GIVvQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyGIw581uas1vwFVRIWqUd0oX7DCEokh7MxhOpZpsHDbIliUvjd
 wRqKV3NsIGdJ/YdDttYi9a2pk42KUKuNQykTP9etZTL6sDyYDvhPJQ+iSLWHXD8mRoY=
X-Gm-Gg: Acq92OGL7/FSJvnEjTZB3+xu/xeoWoKECqW2AGSU6nIVyG/5ZWgR2EtM7Nv7TpIgOxt
 TSQ70xYzkmvc6AxU0HsFtMgADZsT5v80fVmQuOeNkjqHpBQsaWIwXS5RkT6Q7MMIbaQvKRehGKr
 Qw3/BPgL/ne3TwjcXkwdQQ/eiXmQikhr0rj3IcnaT8UmW3iyQqRv39TqHXhqKL+EDmLHCaXL4F8
 FWwDvN2WqSAI55Yz536cw3Q9YaiN9uFUILKDif1sBWMUqdQpmOmzdwN5gCbbYTDn/5tzPFdUAKH
 kKyhxu6xLVRGOM28LEJHljfCmE0rQFeAc/hknaGRax82suAYHzO27aHmyKC1B4cBNphB7WbOa9u
 xAtDzirZWzI+8kAgB/bbXLuK7VsL/lBV/dtRFjO3bca06DNiBSfDUXkc7osrpasd1n4NePc1/nB
 KxH+HiZ3gdsMzmooUHLbDz+Gw/YRtycXyTxpD+fYtTdQ3yPyccyvumhpA9k1buOODFHR14QW8Qg
 tl44nqpI/E8dkCWM6IN7ISrylxbNjqNAnt3Pe3PIqxZNEJJBwOdnfPGft4NGA==
X-Received: by 2002:a05:6808:4f53:b0:485:6129:10ff with SMTP id
 5614622812f47-4868df520f0mr15792708b6e.34.1781118469198; 
 Wed, 10 Jun 2026 12:07:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b91a9d2sm18892395b6e.12.2026.06.10.12.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:07:48 -0700 (PDT)
Date: Wed, 10 Jun 2026 13:07:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] xyz-modem: Select CRC16
Message-ID: <20260610190746.GE382693@bill-the-cat>
References: <20260608130606.121031-1-daniel@thingy.jp>
 <9b0b5a7c-3a6d-4a54-ad67-10433cbd3435@cherry.de>
 <20260608140454.GH382693@bill-the-cat>
 <0642ec3a-eeac-4d99-bf2c-23822a8d2df5@cherry.de>
 <CAFr9PXn2j1B6WxRdPFabHJg7Ym5KJYgDQTJ16A0uN7Tz-Ot+Vw@mail.gmail.com>
 <364e247b-7cff-4711-9d1a-2a1c9b6544f9@cherry.de>
 <CAFr9PXk+k2yhuxTiZGJ-m7+pAb-rUpGRfrFgTHJzpaOxmgg-xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DpnpQBkpLWPQMGVQ"
Content-Disposition: inline
In-Reply-To: <CAFr9PXk+k2yhuxTiZGJ-m7+pAb-rUpGRfrFgTHJzpaOxmgg-xg@mail.gmail.com>
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


--DpnpQBkpLWPQMGVQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 05:59:05PM +0900, Daniel Palmer wrote:
> Hi Quentin,
>=20
> On Wed, 10 Jun 2026 at 17:47, Quentin Schulz <quentin.schulz@cherry.de> w=
rote:
> > I'm fine fixing what needs to be fixed now and improvements later on.
>=20
> Ok, I'll wait for if/when Tom replies and maybe send a v3 just fixes
> the main u-boot part.

Yes, lets just do the fixes for now, and Kconfig / Makefile logic
cleanups later.

> > Note that we generally do not like complete rewrites in one patch but
> > rather small incremental changes (which may end up in the same result,
> > but is "more reviewable"). We don't have a maintainer for that feature,
> > though Tom is the "catch-all" maintainer, so maybe you can convince him
> > a full rewrite is ok. In any case, I'm sure we would really appreciate
> > tests (I don't think we have any from the cursory check I just made) so
> > make sure to include some (especially for the issues you encountered so
> > we don't regress!).
>=20
> I haven't touched it for a long time. But from what I remember fixing
> the issues in it was basically rewriting it because of the code style
> etc being so different from the rest of u-boot.
> Maybe I can use AI for good and have it generate a series of patches
> from my version. I'm assuming sensible non-spam AI assisted changes
> are ok :)

Since Quentin already sent my answer about AI (thanks!), what I'll add
here is that yes, xyzModem.c is very old, but, there's known (to me)
issues with it either. If someone really wants to replace that with a
modern version (that's equal or better in terms of binary size
(CMD_LOADB is enabled on virtually every platform) maybe Zephyr has
something we can borrow that's appropriately licensed? When touching
code that's enabled in a large percent of the platforms I become very
concerned with the tradeoffs between binary size and whatever the new
functionality is. Thanks!

--=20
Tom

--DpnpQBkpLWPQMGVQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaim2AQAKCRAr4qD1Cr/k
CqCCAQCJgHzsVSMDG6syR1TmMnNe2CHABG5nWpEX7b1uSm2j1wEA86BCFEBBOKw5
DbYHRfJ0kp0NMh5WdPEfQa5kUvOlUAk=
=Sl2x
-----END PGP SIGNATURE-----

--DpnpQBkpLWPQMGVQ--
