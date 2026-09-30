Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AF8CA5FC1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91668607E4;
	Wed, 30 Sep 2026 17:39:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OcpXoO0M57TS; Wed, 30 Sep 2026 17:39:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EB95860B63
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790789966;
	b=sMx+y5+i4SwjJ5/9EYXWPCBxb6oDcnj2fuG7SqlcQAyGXJla9E4Wg4Ci4NAnTmNnGTHM
	 OmKyqsQwYoYklMFcdXoyApSHIXAgXtV5FkIXN2xaN/Oy/gZpYoyvizB3gU3uxQQofTyep
	 jtqDrQ1FRqT8Q3lU+rJuShiQoF+lOCGD2ftILt6LsXOMax47veXK4y5O5g2pExs6AbZGN
	 8fry3cvgdn3cB4gvseHLu+agFbz8cpLlks14AZzo/RBT6QO7apPkPpSrifS8y/sdFxqX5
	 4pcII8NiCyEaKD0a0CGrkVVASzq3dsG2chwcE4m+cAtRA0I10UEf2oO0eyy/s3CaFvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790789966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jWvEZ7QOSOoxPJJsP7WfbFrfXwDyo8MBwm1NIXeL1zY=;
	b=G8U06buto4sPaCydcBKIBbGimocytk6rYPDDYZ+injqwRkKljcMD3jkw8ywaQFPKAjh5
	 1kFzFmxD6M1RqCvppJDWJMLZbT8WDDKIhTgdCCVlCkRn8MVuZD2jFBrZs4B0KD1EIrBCl
	 d+EYRqvX1ihi7WpLMiBPlES6QqsEX7X8/i78Xv15s7vpv0R5uhWZIBh3ENOOjP8T+LnVH
	 B+ngtBe+cYhTCI9O1NSql8Y39zUsCRSkP4HlSbZnZ4kTxAp5tsBdKXHmok322DwJTFJB4
	 Eu2ogwx57Iy4nyuoILkBH/SwRnDZ1GlbJooHQzY0cVzhtnwFRxFyE9eRsNSXvbGhaGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790789966;
	bh=jWvEZ7QOSOoxPJJsP7WfbFrfXwDyo8MBwm1NIXeL1zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y2qMm5fCqwfpvUTMkwIkYTrzu7cwaIR+KTGhkes6SUZb3MOYmHIZTuVaqanZKhrEp
	 bCIvdeaweZdlZ+SS710kqsUuALvhsnHOTOYZqwVREqq1PsNsNOI7sOzFfSEKjt2qz5
	 xlVhbLYL2LsQXKISLfViRmOV04usoFaW9wmDLHmLTY63sIvLmSC20jN5NNTcIkqRrI
	 rnOSFOgyW5xKqEWYhpvlwfDXIdm45gA/LPKsk6QM0JifCcoJXiLGC51baKkvijBegU
	 OtQJLQqW+d1mIt7Rqt4PYM6OjYTXuZeN/v5iAjvumq+3/uKILSrFUPEwwc88JfvhPf
	 9FKs4akEWi+pA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB95860B63;
	Wed, 30 Sep 2026 17:39:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFE23380
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A16E940ABB
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:39:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8pYFMekcV1JG for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:39:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DE5D340AB3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790789964;
 b=jU1UModzZpMlBPyJQtffWBCgmehLBNYOmHBD552Ppek06CDIlsLlVUtxj/738JbAc9aY
 GxbDCYGAYhdWBNKVszUgttULS3VumxIw1C2bQUYnBqDLJ1QbjEI4zYX5UrIQuTYhFoH0A
 u7Yt7BpypkagPumUWv1JKQ/InFhmTWFPHQWpr26j3CUThYq1dY0CC2BbEEX0YbNi2U4yc
 UEqbr3cjqVLgC3wubEIhCLxNdnKgi4TmWchzAIkj6NkBdbK7g6XGpjPpw2Xff1rND9eD1
 mWGvZ+xFmWNsc9E2B8dNhm8tjye2Xunf2ucRcPWr5+3ygQk4tepoR4P+PYc6TwWUW1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790789964;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=jWvEZ7QOSOoxPJJsP7WfbFrfXwDyo8MBwm1NIXeL1zY=;
 b=tYuhTyR6oUE0WtrHO22EC1Sp6w2z6J4zG35lK/YIucVITmRk8Ab2IU5aO17w6cUQubC2
 DExbgKL8KL8wDkkd121EN2xt+t7JasKNDVdlprJdiz25GfD5WWDTbMhYv0Hlnvoc2ZasM
 atybh6bY44cAPB/fv71ix6PxSvcM1zpuezWgxAsIem0UwttDuDJbSw7wN1gMYiw4iexC6
 unbUjX2IMoFNcJPwh+vpPy8y4spX6kJc+zvFmg71k02wG68niriY6BBhM7NTvzxlLYTH/
 1oZ5iY7QY2/5lzGvbgz6L/kpfEgAZG2QHCvjMRRFH39rfRXbfBIONbsndmjGbZAj4NA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UT6QLECi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UT6QLECi
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE5D340AB3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:39:23 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-81be26ba237so2246022a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790789962; x=1791394762;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jWvEZ7QOSOoxPJJsP7WfbFrfXwDyo8MBwm1NIXeL1zY=;
 b=UT6QLECiP4DMHLwv+cYCTPUQQFJwdloIPpqhQmmyESry3hl8KX6GOvFN3WDQiipD/H
 eGnqGdbNK8XcGP92G9phqn/3xg/ymEC9VHUttpFwWtJpf8UlQLc1UU/Sm3hf2evPpPoD
 Ar1cvFF9zBcAogYgstucg7vaV3iQ9keCD0m1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790789962; x=1791394762;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jWvEZ7QOSOoxPJJsP7WfbFrfXwDyo8MBwm1NIXeL1zY=;
 b=WMROplDbxwQS05hqQ1V82d4edMFAkpUZW5hGG4drhqVul1MB/jJzw193Z8QkzSndCW
 f/s4K44f+VJ+ze1sgUJtdk8xt1iJN2sa5hhT4w0mYM14MHOYBqdVpHWTHPlRzfhjIyEx
 rrwIStbTHwHutJ8vgq8ASyHZ3pvPfA0WmdlhG3KlBxDZHaZmdVbA6wr2R3H0bYLdJu0m
 fYQKfj+pqLleE3jcLSR8LL/H++fhPJOE3xDs41VYVcjJNdpXX6lUAPBp3vaCR/Jk/ZPg
 KmmHVCw838fepn3PZdQ2gcpwLjS9iHIEnjdpigbfumrzUaauA/9rEp4pCzKVKzak9HH3
 QnGA==
X-Gm-Message-State: AFuF++k+35cpvE/aoNuyqD/nqNUrd/7VAoQN1R6tDgVYJrFE/vZ4UNWU
 mUYsfluklCW5Yk8fgMxWbBw3hsQqH2ByUj73Le9Molvkzi/EuXGKZ09CIk8YwDfe16E=
X-Gm-Gg: AYBFou0YLrVbaU2hNSRp7zz01ejGaIgVC8wl1UtZXB2LG7B6nHhxEokeBh97Y+JwH5f
 AlqEpr52mihXcH7CpnLINhHphiYHAFnh5gD57BCYIfoVlVL/N8Ksco2EwVgc8opTtKglRvtzz2b
 F0Wu9NRpeBOdT8v/1nyOTlwqbw5U8GEjp2mu+wfpMUTj9BzCtPnQ6R+drl+Zj7tR4pT/CSXfQJg
 F53zmyTEwGdBb+lQ9ilt9fqH2zd7lmfvg5eoZGOMLXG1OOJPiDkBgFdNy8dN/XakC27wPEBgmma
 l4myhSf2Os9DWhiJDCeEyGFo+pF6aT1cGQgSo0mXLlkAYF/4sdlo+UYJXUBrK+LNQASnV2H7pLZ
 eGzeRKxMf5H33KhvbnG4+d5lERexzCJmb6Rh7ZskZjuENWN5tLidj7GgX5EwYT2Sf6NID7eG+6X
 jX0KnLcglwv25QJDqKof39jNuvDYbVLWTcqGa4q1OxD8x4otBIL9njtB2oFxkO5MiVhrs99DXLI
 mR35t9jU8vsLxAJl9m/4Wo3Ji31NKMlsFkRQcdRQJa9RSDaMRyP2YHtjSiOHW7wU3a4/bZd9xVi
 dIJ5ntTyGl9v6+JQtDw=
X-Received: by 2002:a05:6820:4df3:b0:6d3:402e:1fca with SMTP id
 006d021491bc7-6dcf1ea95cemr2388063eaf.9.1790789962351; 
 Wed, 30 Sep 2026 10:39:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd989cd088sm618108eaf.14.2026.09.30.10.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:39:21 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:39:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Huy Bui <huy.bui.pz@bp.renesas.com>,
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev Kit
 support
Message-ID: <20260930173919.GI858934@bill-the-cat>
References: <20260913155253.84181-1-aford173@gmail.com>
 <179078865386.467656.9091674646926534530.b4-ty@konsulko.com>
 <60d018d4-fd00-4c26-9b0b-f1ce288d65d2@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+i9RA52Ts+LFzQOE"
Content-Disposition: inline
In-Reply-To: <60d018d4-fd00-4c26-9b0b-f1ce288d65d2@mailbox.org>
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


--+i9RA52Ts+LFzQOE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 07:37:58PM +0200, Marek Vasut wrote:
> On 9/30/26 7:17 PM, Tom Rini wrote:
> > On Sun, 13 Sep 2026 10:52:53 -0500, Adam Ford wrote:
> >=20
> > > Remove the Beacon EmbeddedWorks RZ/G2M/N/H SoM and Dev Kit board
> > > support along with its defconfig, config header, U-Boot device tree
> > > overlays, the leftover pre-OF_UPSTREAM DTSI files, the Kconfig target
> > > and the entry in the Renesas board documentation table.
> > >=20
> > >=20
> >=20
> > Applied to u-boot/main, thanks!
> >=20
> > [1/1] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev Kit support
> >        commit: 3f31d496ecaa6240f1e578cce389a06798d66c30
>=20
> This is unfortunate, oh well.

Yes, and I'd like to thank Adam for all the work he put in on these
platforms over the years.

--=20
Tom

--+i9RA52Ts+LFzQOE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar1JQwAKCRAr4qD1Cr/k
Clb6AQCIg7xwgjrtIXVT4sEhGOF/SeVHwFQ1MJEvoDcOglrfmQEAg3pFck9rG4wu
e9kDDogKKCyMWvoO6P5K6YHMSga6gQQ=
=mGz/
-----END PGP SIGNATURE-----

--+i9RA52Ts+LFzQOE--
