Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5221CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B314160724;
	Tue, 29 Sep 2026 00:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yE2pjOCtq8a3; Tue, 29 Sep 2026 00:49:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0C72060707
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790642965;
	b=UiCPCGgUVeqR8l2/MxaCsXOSsJO70p7FJJ8GNjq3lzU7Fdo8k6vH0TF5sG3qt6B+lHHp
	 2IitwGGz8uXEQ2DFQBpfRes+APjjMJseXvylEdBxGI+zbTWEZqmxh4TzTpUCpiB3avXqJ
	 6/DHKE3CXFTAJPNug9+VkyIUGKucmWiue2eYTMcDDLmDym8ZXOzNwOi9Rq+h5+/exDQ/f
	 oayYa+YNMPsTT2QM52QwA2d8zEqV7lwZXjohFKOGjPYzABDa9wehwqbg/3uL1ObJ0JphR
	 DSglPzPQyFavgSZPLubbSPkTtHiZPq4gsUJ1MGomntldrTJbO/R9vOKFCIcCmQjvvQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790642965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JteeRaOWBTUcuKbs+qghf46J/GjbKQ5PgwLabTFHA9Q=;
	b=WAINK26mE7bEjTOa/nnvEUCiHsHyIbP21h3ZA4mgvdmlHGJS8s9JQyhIDocgrLSJQ0ys
	 HuOsnwNiyjfDcwMgzDhfzC4ibM2M26VdeKcZDZk+YLrSGld9Yz6gGLlBVjDfvhsywzCbH
	 jnEnZTpaPxSi4CGQ7UAjxYavfdC9mlnK+aHz8jMtK9IEtU4idIHZMAcGx7c11LInUBjuP
	 R+wFinm2rH+wsiWJv4bf3mUsN7kKZnkSt0pDG6WvLWk+kM2kdVqPW0NXyXX+LuRAUpq/x
	 JGSN7aWyphMQo/wmOCtScBEuCae1BDawM2+d+FowsXz/gmgz7avWoebeo8n2l3bf4Lw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=R3ikjfiM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790642965;
	bh=JteeRaOWBTUcuKbs+qghf46J/GjbKQ5PgwLabTFHA9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eLenEJZIx+LyuLQokmpQuLvsvfOgY5yrL4ZU2/b71Q7HZ5KO5WYTQjuW9UpxzfjaM
	 HfHLFWMA1hhxLfJlrE44YOBodm+yJqg3tXi6Iwu60Y8mDNGGBK69RmWvaJjns3k3V9
	 KpuUHxpz7pMlwhWj8558tRJ1UrFcBKcX5DqLvT18SAIZCQY6+znhhxlZ0i2qokgfDD
	 Li5qDJvaNPd5HX+VYCGKQK/Cj7bFv2gn70z2cPwSyzhiGpBh2q2rMeO2DL6E0hf8ix
	 8aW1y0gkK9UKSaJEWJv97uGfsct1m/o7u+NUPWjMdHcidheR6el5Wh2rShSwVuZ27z
	 wx0RQEG1ijv0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C72060707;
	Tue, 29 Sep 2026 00:49:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7901F335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5ED3C60707
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:49:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wtqLNPuDiv3 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:49:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 88EBF606F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790642963;
 b=Ur/9aDadM4RPdHCUFoQOYR3WQ1NxMWj92xWt7D/PAnjeCZBB95G9TGQi5BnpMh++o8Fv
 MyRO/8yy2pFQqCLiQXO8ox2V0oRwB6xqAFSkADj5z8OUXP8wFv09eDzyMTLqgNJ4wmOgk
 SK1CJn2C+63dgqfQdfAzmp+fBdwqCGjQ/XdTUkKi9rDkf1H4R+OuJMfpHFGOMamvYNjT0
 K/pZjN02YLJyHyMMv3hnglbzemqXN0fB9gIXG39OQuyIpQ7sVnjw7qIjItaNt7wQ5ly6I
 P+QmPCdG4jHjrhaoruqvpP/cd8wMqZL7aubOxJWXAxAa90v/FGtd+h86DdJs51Qyxww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790642963;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=JteeRaOWBTUcuKbs+qghf46J/GjbKQ5PgwLabTFHA9Q=;
 b=DfP5pXYd59mHJCLnP8MOuBqPlMQFZG+BaZShU4qwHwrThmlEvJP2iNShkNSEkO1nencV
 k8bPGmFshqlndlN6FDaRB0jbUa4I3sI8/NIHBgmrcdndNKx4ysW2ogBFUAFdZPrlDwxQo
 jfB0syBBiz9WxnkD8lyLofM5JXYvT4D6VogU/XhTnrxd+RWjCOVwUxeerPghMpjBulgs0
 GNmQwa/8a1iZuZ3nIkWiZm7EyJUDe7R6aJ1YGO2TvKsYlpaD2iqZih4X2/cWyfXCGyiZN
 RsMdqIRh+FI1EWhq3tOk2KSY9GEU9pUTmlgNFWzJqEa8PESakxP8s0baLfL94xREgpA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=R3ikjfiM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=R3ikjfiM
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88EBF606F5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:49:23 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9ab667so3071343fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790642962; x=1791247762;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JteeRaOWBTUcuKbs+qghf46J/GjbKQ5PgwLabTFHA9Q=;
 b=R3ikjfiMmLb5tKHg1ADpVmbxrhAmNZhBvRef2EmBWQ2637vvMlxQe7LQbnddemBFmQ
 6YESK+hNHpjqnob3woBU+4xmduisBM7rwUvTfuAn3R1S4sPnLzT4nwF1o0zF4khTwpZA
 0A3KV3F1Q3mXMIgypeQLmkwhV5T7Bw7Fy5vso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790642962; x=1791247762;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JteeRaOWBTUcuKbs+qghf46J/GjbKQ5PgwLabTFHA9Q=;
 b=A3mndmaPFeZRyX7UR8w8GvlNC4xioBZ/LQzSlJ275fEJI8V66d5urXaGvypCDtnqQp
 ZvW0wXpFKzqfs5jsgB8jQLpwmvaP29KhK1CwVp5HhCxuYWl6hEOW7XEFk9v/WbvnO1O1
 xWYcTD8My45AOKSCspN20rxq+5pNk/bZRlt0aKCKUqNDUQmTCa/0zpdzNv0/DcLGrjRS
 rDZh8u2PkkZrYsaPvDpP/HxM1u6HF73cThNkUyzt6CZqwiS7PHXNdI3WDAAGNSpAgWyh
 2z+Cwtkb2N6SkKdwCj+DHr/bd084pORvlPFlnDTQQZ5yWJts186MwADl/89QbzbZ+3+M
 DOnQ==
X-Gm-Message-State: AFuF++kd1mZQMKy84PiWz99OvKIZVVpIElIxiIs09T4D0YcwOgHbdrYy
 pBsmCMZeUzynamO2k5dWLYhUlof4AWoRKm4AS3sqHwrdVKgmzQVPsOIcbmgt4BEhfMo=
X-Gm-Gg: AYBFou2htXKTkZGraAplP0msBpFY1jAENRgchWLCsn6QwSlMTgpdFx1f6HJ87MxDbFv
 KkHub8d00iFfGmhlTu5D7Bi3W3UciK3bhTi4fM2gk9ndHqCt1Ms5TqpSO7V+SA2uvWOymIAKy0o
 I2L+pUW9Onww9iqvxUDvM2EFkUJeozp83O2N+W15lK0jt5lNGYuEw0wgdqYtJHj10iletzRSeQP
 q+7HSroBCCZBoakf7wokNI0f1f+ahBw07SVcCba7gwVUmwOuwkNLJjnhtZrTHVDVCxnCZbdyuRq
 BgH7Uq57SxliqFEWL14TLOfibvUEPDrg1bMDxPHfGhg/hEW7xJDjprdgxdNIMmRw6SnAIAmhiUc
 OcYhgPJjq4EoIrxSm2808xkU8fAWE3autiCPPGDgqL4Swqy8ZmY2XzOsXOvy2qFxxwkci2Zi4xC
 ost5aqaiH+8JAZYSk+xNndWKyqOJQwAhiDMAMy/8l7KowJ/HIVj1hW+rVR6nqwSovaxuGOJ5Jxp
 jCSQQbzxhI6IUZevJN9uNwr+Uan6wWTNllGuxLJhsywSElDW7ysKA/FKv+K1vw3UkyKyvboA3iE
 kYDxdoML+F26j2L2Z3um
X-Received: by 2002:a05:6808:221b:b0:4ee:2dc6:418 with SMTP id
 5614622812f47-4ee2dc6122bmr589755b6e.37.1790642962222; 
 Mon, 28 Sep 2026 17:49:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ebbc7b9453sm3480204b6e.13.2026.09.28.17.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:49:21 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:49:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] board_f: fix use of uninitialized variable in initf_upl()
Message-ID: <20260929004919.GA858934@bill-the-cat>
References: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
 <20260915184953.GA909517@bill-the-cat>
 <CAFLszTgwv8dDCbgfWHBhToR=e6NHW2FD5Lk7t1xbSte_4fdUBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wKLK26BjjBZZV7HQ"
Content-Disposition: inline
In-Reply-To: <CAFLszTgwv8dDCbgfWHBhToR=e6NHW2FD5Lk7t1xbSte_4fdUBw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--wKLK26BjjBZZV7HQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 08:39:37AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 15 Sept 2026 at 12:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 01, 2026 at 03:50:35PM +0530, Naveen Kumar Chaudhary wrote:
> > > If the malloc() for the UPL handoff structure failed, ret was checked
> > > while still uninitialized, leading to undefined behavior: either a bo=
gus
> > > error code was returned or, if ret happened to be zero, gd_set_upl() =
was
> > > called with a NULL pointer. Bail out with -ENOMEM on allocation failu=
re
> > > and only read ret after upl_read_handoff() has set it.
> > >
> > > Fixes: 0fc406ab20e ("upl: Plumb in universal payload to the init proc=
ess")
> > > Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> >
> > I've seen this a few times, I'm curious why you have 11 chars of the
> > sha1 for the Fixes tag, and not 12?
>=20
> I probably copy it from the short log, which currently uses 11 -
> sometimes I forget to look it up and add the extra digit...

Why would the short log be 11 and not 12? That's what the kernel (and
us...) moved to from 8 forever ago. But also, that was a question to
Naveen...

--=20
Tom

--wKLK26BjjBZZV7HQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarsLDwAKCRAr4qD1Cr/k
Cmm3AP0d2ed+7jnc/F83kBSN4HtHZy71h13okvyntACk99xItgEA2ML5gy5OnPdU
HQ4Jaq+jJ+EyvkxObq/MXZBFrinmTgI=
=DY0o
-----END PGP SIGNATURE-----

--wKLK26BjjBZZV7HQ--
