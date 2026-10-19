Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3AE606A319
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RW+b2T+Y;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=q3NeKjgl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85D9A407BA;
	Mon, 19 Oct 2026 22:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TLenh7vWfEOr; Mon, 19 Oct 2026 22:52:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C5F64407AD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792450328;
	b=qffzoCUSX1vp5PbKDqUAcnU20+YlyUcPoyBduu9hWN2tKsXD5w2NoXX1wbbDbZ+Khxjs
	 ZCQ92WblxBRCiHDg28Br3DZr0WoRB5qiVoOONqGVgAwhelH+5E1GxH6EMru6Q9SyBaKrN
	 PAIXTbkxnvz3zTldPPHItEIaHzv4T8wAXmGjBjB+hjFIMBiVmuPvozviObk8EIhLpbaei
	 uEtol6wy+XWHD4iVrBDn3oFy7gfjSHLLxfj6+0oZFpsufzlfOU9lMPw9HGfguZjCaiPWu
	 Z8CG5FtsGbmEJ0xj6ln/oIhxqvYV2lT6sSRWeG3d7t12TSb0Xf0g4Kgu5cyChTn9Sbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792450328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sx8IxFxzV3n/txdW8BBcs0yBlEFqgjvyEMALx6mtIZs=;
	b=JvryvSccfc5KsbYE/SAwYFoi0M6VTpHS2jSdcMrNX5OCLsOxxDulGuK7z9tTm+LT24B5
	 AmMzrIg7vau5kkOR+auCiidQpX7a/5GV4GF55kofwHOXwICtVWjiS1zRICzhIfP0S2nv5
	 xuhY59aJ2JKJ6S3d+uHK4Ja8/gxlRwdtyRU86YWch9cqE41/EIaZaj7e3UVkn4msC4MV9
	 iNRpevVUyxu0rQB3VYToPj5vxgB9Q1AGEWQWJexDmOz8CSi00bIJ7bzTUKu2vJfGLTuFz
	 7Ai1f+ly3ahCIfL5SRLiW0oBw360d92q4OfmpXcT3Nzu9oy9pedjArkTANC+5txx8qA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792450328;
	bh=sx8IxFxzV3n/txdW8BBcs0yBlEFqgjvyEMALx6mtIZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RW+b2T+YrIsjSIJwumNeoLsm/2ftKyzZw9WTASTAFZJz48UWqMS6fugyTrwK6Az50
	 D0571WdN/I66jWICkqnlK9mQ1XCSkCAVIMsWWfQxrqWyKle2zIz5p7xaVXRHi64nah
	 6zA2Ey2v+GKPvjvgUQ7Xrx7ouXBZL6Ms/9J6pphEyQtcws9qoeVIS1n9DXSOBbWUMY
	 OkUZ5pqPvdD4cBvQwIn+0rPEn00Ivw156xgGjAnSFY65n/OVCCH2uANXmmEfeElj78
	 3zLKfa3emg/Y/zCooh89qG5YOBGDlKT5ltCOlaENIMAJHvCAl6AHQKo7SBkpceQf3v
	 8c/zilnhS5Nww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5F64407AD;
	Mon, 19 Oct 2026 22:52:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 55AEB279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 22:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4754A402C8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 22:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E-RQq_S2FuUl for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 22:52:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 81068402B7
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792450326;
 b=HFgg5UlgLqk5WtKQaXFl9ug5a5CgQHXQrGfCGEsItmCElwVAep34sbONgyTZOfME73sa
 Psr5mOWCWDehZ+jgz32f1JhADQf6F+ioQKWmpJQ9fdF/tIFRJ0a1RgNesd4nbWR0zWW7R
 qs76kkGUjwKsdBAUg8vm9RC2JjRCkk/vE1aysiX432SxWct7LiZnlcPQEpLroB2GWq+vt
 f/hkvCOv4c8/JgXPbKTQC8MWjh6/UY0wxKGt3hkTScwfpXd6rIDEAZdb6F8oEmUb4057K
 pOKNtJd+tB7clTToHt0G0Czj60KsedH1HR8+rGMkkxGU5Z0lAZPxQSgHPGL+FERyYgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792450326;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=sx8IxFxzV3n/txdW8BBcs0yBlEFqgjvyEMALx6mtIZs=;
 b=k5zHxAryi5NX7crwKlp2AEKZiWyZ3ZeflOW2p8V5jAa8t2XaQYM5BurVzJOqKtNtzU3R
 qCnAo1cSgtvXTQarFKlfItvUivrjuaSj3J1HIzGyMBuKtoYaF19t1E1UFfBqXYyHgB65e
 GsatW7TvFSD8wz/zRQMglAYULFx4EVbi9Ana0rGgzlASqtcK21D4tP4UdIvkfSt/XY70w
 M5X/Td8fdkWQuUSSd4Oi3h9SRbU1qjqoUoPJDm0cgGjqF+U49n73p/RAnoFOhBt9qYwm+
 ObR8CtMwleXNFRiW7/JGIl3D93YyHQHY91k8EMt10jPnVOL50BvyJIeIlBYGQfuFolw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=q3NeKjgl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=q3NeKjgl
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81068402B7
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 22:52:06 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-8241a56cd70so1702723a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792450325; x=1793055125;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sx8IxFxzV3n/txdW8BBcs0yBlEFqgjvyEMALx6mtIZs=;
 b=q3NeKjglaodDpyNb4SIhscIhqOW7K6PyjXSjLoMjH7vp5BTTeNeWzbSefYAT9Ebukc
 Ju3R/ILAjFVIHL+DxbuyJNQnka64/1kSPVJniY71EMsBgPf4YHsuHdI4X/l6f5E0DGuv
 ISMuShCO50WZjPOjPsx656D3XN+vXotfuyDPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792450325; x=1793055125;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sx8IxFxzV3n/txdW8BBcs0yBlEFqgjvyEMALx6mtIZs=;
 b=iIkKdS55x9xKlYKyuUmkUlU9Fbv2qts3KLdGV9AD4INctKH1YB9pv7JuKdkplVmp04
 vAZBOR+I6m+aE57WCKokklaPVdv7qskuZ9OoiuqLOfHpNQ/m2+DLf9YVHXJkuyevAKJh
 lG6qXVC3xZD1fBII7e1kt07OTe3BZPlWW/eSeKgMFrVVG9DmQMkcE1Q4q57CeOWCITWo
 xjJApO/0BBVe3WljDy0nX/m2lJmfJcvlUdmQbRZ0lpQHf/LsVCT4IxWnz93pEb/4vtQP
 THro/GjCeE37Fb7OHs1UdoxkvrhhmkHjNy4pdNGMBfM7KtTpQ5boobJtvqiYHhxx9u3K
 NEBA==
X-Forwarded-Encrypted: i=1;
 AKwUvByNfHyUt9icjM59j7cJoiC1AsnnIZtyfZ/jdQDSo9WiDLCv3JkUaOWSHuMr/2X6JtFS8eYBAX0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ/l5UVQ/N0POcP71EkbsQopq0SwcW0s3YlxL50OHu6E3Xw7l3h
 Psj7sLa0Y8L3R2BOxNhzRvXlM1oQ1qT/nDmkJcIBTk0dFkys/V/EQuBbAT95CskuXG0=
X-Gm-Gg: AYBFou0Iqpj7Bq3lC68X5KNP90XygVF4m6T53AWWOr8vmBaSiD9rJyrSbCgBMHnvHKC
 mOfu5JbTzdPayRxnOWa08IjXZ7sCHJ7oQ2EN8b4fksu7IMGLedj/l5lJUbel+sl6Ox7fIAnJNuB
 8xKSKXSjXDaqqnQaZFQXIsDWENDdP3TKCIFEe4/vwVyKVGLV3aWjT3DtPkZRlw4hMmnKEgbN2KB
 bKVtyoKxluzeJpwYpUiZq7LFMWUWnLki5Stj3lxIyT5gXsLJtNxf3EJYT5XnXjkR9i5SZlfVZs4
 x7w7a2zHBngddPoIMCnY619F78c927JY4yYT146NUsoa1WpDoyW49i3zydIsxUxMuSEXb/SdN0o
 2sL3Yn9zLs/P9bLF3TUd0hl/hJoTcMg1navXFn9IJ3BiPICPd553FiYcJASQC8IbVj5y0QuO4Nl
 EhNtvoYBdsGQ8/OIN0Sl8pIuOBgY4dXoR55ZarArMuyAkQ99ufofPk3f8PXf6BI51vQ31OBdYPP
 18Gav0LtCAWYeom06KSmO7jTW1LNACRXuqoMIzfSU367Hj7UwNdJaU8HYKEpQmXai3QdEKKzuEU
 D6/XyzNL9BSFrYx3clQ=
X-Received: by 2002:a05:6830:4391:b0:823:e626:2764 with SMTP id
 46e09a7af769-844fd106688mr9368869a34.5.1792450324447; 
 Mon, 19 Oct 2026 15:52:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8498d39b1ebsm3766067a34.9.2026.10.19.15.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 15:52:03 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:52:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: khaliforce <kforce@gmail.com>, u-boot@lists.u-boot-project.org,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] serial: ns16550: make probe clock enabling optional
Message-ID: <20261019225201.GA856715@bill-the-cat>
References: <179128521949.5.18128894373298117517.uboot-uart@gmail.com>
 <asYTozF_pL1xVHfr@pie>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e5UhjzcjFfJCXAjC"
Content-Disposition: inline
In-Reply-To: <asYTozF_pL1xVHfr@pie>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--e5UhjzcjFfJCXAjC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026 at 09:40:51AM +0000, Yao Zi wrote:
> On Tue, Oct 06, 2026 at 08:14:01PM +0900, khaliforce wrote:
> > From: Samuel Holland <samuel@sholland.org>
> >=20
> > Some platforms need the UART clock gates enabled before NS16550
> > register access. This is required by the downstream Allwinner D1
> > port used on the MangoPi MQ Pro.
> >=20
> > Add CONFIG_NS16550_CLK_ENABLE to enable the UART clocks during
> > probe when explicitly selected by a platform. The option defaults
> > to disabled, preserving the existing behavior on other platforms.
> >=20
> > The clock-enabling code originates from Samuel Holland's D1 work.
> > This patch makes that behavior optional through Kconfig.
>=20
> I think the appropriate way to model this is introducing
> devicetree-compatible-specific behaviors.

The problem with this approach, as I evaluated v2, is that it causes 500
bytes of growth in SPL/TPL on arm64 platforms and ~200 bytes on arm32
platforms and we're link-time overflowing at least one platform.

--=20
Tom

--e5UhjzcjFfJCXAjC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatafDQAKCRAr4qD1Cr/k
CmcBAPwJBHXvKnpoo3pSkZL/LOtuMKoqjRtpUge/jQv78jMOWQD/VfHa1UT5HYoW
EFZIg1YtvXVIwaqThiI9gf+ucS3ctw8=
=521c
-----END PGP SIGNATURE-----

--e5UhjzcjFfJCXAjC--
