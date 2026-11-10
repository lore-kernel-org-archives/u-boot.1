Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C8606A325
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kfkJGsFv;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qbV6fg3G
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B8DD60A46;
	Tue, 10 Nov 2026 18:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WuSazb3QLLj; Tue, 10 Nov 2026 18:25:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D05CF60874
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794335108;
	b=td9H7nltw8uLJVWtnfjlhVzrOo4JrvrTEd1dQw+kl1iE7xWKXaVKC5gR6S9C99fE8XoK
	 6Rfc+hApfoCdQFQmbJq3o+QpjEH35MojpQW9Vz0NCHiZbK4MltaMG6OzqlzEqF8DPrGvH
	 BvSZQJRa7W1g0AQa+vI9KKU6xjqKoT9h+8ACWU+25+UFBeMmKIuYPul5ZjBXf0WGKuR7D
	 GdKooMRDinNdskXhPR4eOeCRU/7/SByoW4I8LC7oxmv9RyrTH3UGzgEmIEL0QdnuUIDE4
	 SXPbu2EOdB8+7KLDUr9PMxNYsX8Xcte8QcuzRpu5Cg94gLHbDqHY/1FA4+5ySHWkwBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794335108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JzWqdjqVTurKicwYWWxyeR6F+G001z2dcZ62XZg+Q2k=;
	b=MDX7AL/D3m0p7tz57uLD1pWYPMwaaPexXQHK48kbqDs9yRS6EXbxUGlzCqTAjxVRTQDV
	 wdF3to6ONjPL+6NzaaQ1Mv7ct7CqP5y8wvAYdhqGSMbFtWyWDxvUiHRFg2eUyqV0w4j7n
	 0sOAzohQTKt71wlyIbAnULK8q3uXqKJEwVyInzonztEIE9DUJCyam1HsSO5JLEkEAAR0K
	 Eexnqf2gfMOWRkk+S08CbQnW8qfvdGfDWGGw3m8Qg2Z/9TEl6xnjqXB0cVsY3II0Kpe5Y
	 TF4yFhx71eg2i4hqskRft7vENqPQkhbbkrs7vXjX8WDlbl/t8rRe46wWwHOtDzAZigQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794335108;
	bh=JzWqdjqVTurKicwYWWxyeR6F+G001z2dcZ62XZg+Q2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kfkJGsFvsAAoLsT3e6xt2UCE1Xna9cqNVo9m/sNZbYWpBHFGX6xlvFboK7HJt9WLq
	 /BNuOIbe+TGErQledCtjLvGEr3phd4rp/Yt4Bke3cgQ8+Iw7m/nEp6tMgmg1En/dna
	 CDIXq1tuNTSZjY6511QHNcLOIAApuPDAL7OnrhcqChkRXxXTEXnXP4z7Hzb1vxR+yJ
	 f8ITjtGWXJfUOVsDPvcMoIKnY+hLcMBdVYFp3r4lGZ+WXZK3EaCpytDiY6CPZ8v/Re
	 VXJETPZuzOmxrTgQWkVP+JEnkrn2wWFqO2+y05KUlXZBaHYrCHeGnA/7eZqbvcGRjY
	 vw4rTr7EkrajQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D05CF60874;
	Tue, 10 Nov 2026 18:25:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C05A71A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0F61409A1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:25:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkm9LziLzKdM for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 18:25:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79B064094A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qbV6fg3G
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79B064094A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:25:02 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-84a248254f4so1292416a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794335102; x=1794939902;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JzWqdjqVTurKicwYWWxyeR6F+G001z2dcZ62XZg+Q2k=;
 b=qbV6fg3GQZuhyqV7lkDGC3QGAH9SYAwMoBIrzqEjP+P8ZaAkaSYjYZAx3lIc1i9+2H
 5DixeOGhchwI9JcHbBzfa3qESH33I6DC6c6OOfzueIdOKLOZWc3ogO7RzOBfCXwWS88P
 lz4Rek5Z3j8CUzYZk6/z30SBlELkySn/lwkao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335102; x=1794939902;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JzWqdjqVTurKicwYWWxyeR6F+G001z2dcZ62XZg+Q2k=;
 b=U08awpczfetU04gIjtgAuvuqDnAX8/sKoLt4GZOuzKuktmKUilDZ2dgtb+d8FkMqRE
 BxZxVk+yMsI2j2I4oXUCtylbcNCY+vhWuAfQg1xgwMg/po26l0PAoGrMnIoNNCEsxy7W
 zD2QUW93JyNefYoJou6DDJ3jGPZDkfKPSQvu8xoIc6f5CuHql0H/gYzBkLuNLAQd78SY
 vmD3vxLDW9H9Ucs4bTpco6utV8rhCIh0PHZjl5gGZ25by8Jf+KiJzA8D0qW2XBUyj6em
 owJ8PH22a2FYoYKDyF+kWlIT/Q8upYPvTepefsJkDGwVADhQSy742aGTn+YdCv4o2A2V
 Bi/g==
X-Gm-Message-State: APuU4Z80fy9nThDB9jL06i5ydSMtWXLRbGsWfvIXaiT6wPcyqHn2P9XY
 v7RMkxZhQ75AW7XxjBu31SHxOB5+l67A0NZAuOJWXlcC6TCc7h4YE/fFVFgLgTZBIR4=
X-Gm-Gg: AYBFou2H+vYAkOzln4Zh7jmb2fKueUZ02e8OJUm/RI17oghaR4HK24Mp5YtaR8OsVQD
 6+ifwG+YydYpZn14LO9m4q3xDya0ntLgwksPG1B7RkvQfGZ6txrvqt12ybPiKNwj+jfo04+wkG0
 PvzXhBfCuiCoi/mbs7d/aQUzLNrb9baoFNo6z/ZhFZmXia8ViispQbZbxJs68wih4FwI8z2OqOT
 3g2vzRbtVYgsHWOVuoc/3qruAOexrab/DxKTRK++z62x/1U3yrW2NpuDe6Fu17NXTZQD9c32dOU
 1c5RCGZPWHjVmJiySEnkpvLareu0nFGDSuvlBuwYyL0hmrGh6GyAAyChL3SQhvyrtqcWheZF1LM
 uRAALxr3NHPhB9+xYwXdtL3Mx5XFdR1r6aFx7tqpjI7JfHdVbWeG9WGJkW8rxZaxAlaMXxNu6m/
 S1SSgnyWAUlMYr2RddUGvoR7Lhx02iWn1DvssxPk88ADTSyeKXtxcLjlOPKau/VRofmsgoKU6AG
 LsXW37I+mz2gzYGzKwUurMD7jOeuTilCt64dJ0GlpJ/WNf9P2AAZe5ZKgRhycJewhFAyz8NrOD4
 T1DbCy/pwDxE5YkB0/WvkMj3llnqr5Lj44lfph9pEAFPL7PQQUO63tLOqefbd5psajIJB5dOfMZ
 C1hVf03AqA7zLDqUfM4cMUmFYhyz1+Le49A/hnkbe/mMX0mvSrG7H91Vj12FH0Llp4E7mcJsCeg
 qWDDy5TlXvr38bVt9upvBre4KbiuT2KOY=
X-Received: by 2002:a05:6808:1a1f:b0:4f2:ac42:656b with SMTP id
 5614622812f47-5683c73b679mr3170521b6e.7.1794335101899; 
 Tue, 10 Nov 2026 10:25:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5690504fdb5sm2896295b6e.3.2026.11.10.10.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:25:01 -0800 (PST)
Date: Tue, 10 Nov 2026 12:24:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>
Subject: Re: [PATCH 00/11] video: Keep EDID modes and DP lane counts within
 what is reserved
Message-ID: <20261110182458.GG3741582@bill-the-cat>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <20261110180117.GA241351@bill-the-cat>
 <CAJnxHsiC7JPMvQWm09PObjQebw=0d-r66kFVOhaxjZ3Y6MNrSw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NoS5RDE6TMI11mtU"
Content-Disposition: inline
In-Reply-To: <CAJnxHsiC7JPMvQWm09PObjQebw=0d-r66kFVOhaxjZ3Y6MNrSw@mail.gmail.com>
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


--NoS5RDE6TMI11mtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:16:03AM -0800, Ana Bobillo wrote:
> Hi Tom,
>=20
> On Tue, 10 Nov 2026 at 18:01, Tom Rini <trini@konsulko.com> wrote:
> > I would like to ask, given that the project AI policy is "please,
> > don't", are you using LLMs for your series, and if so to what extent?
>=20
> Yes, to the full extent. All of my series on the list were produced by
> an LLM-based coding agent: it found the issues by reading the code and
> wrote the patches, the tests, the cover letters and the replies on the
> list, this one included. The builds, sandbox tests and CI runs the
> cover letters describe were really run and passed as stated, but no
> person reviewed the patches by hand before they were sent.
>=20
> I should have said so when I first posted, and I am sorry I did not.
> Given the project's policy I will not send a v2 of this series or any
> new series. The ones already on the list are for you and the
> custodians to decide on.

Thanks for answering honestly, we appreciate it.

--=20
Tom

--NoS5RDE6TMI11mtU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavNhbgAKCRAr4qD1Cr/k
CqOKAQCVNB4jle0mSI/7/z8dXNFswxoPA8w4fb/xQArpK5P0hAEA8NExuRFTkAZG
Ib61fW9nrl+8GH761yrnWoWpeb6fjQc=
=AEDv
-----END PGP SIGNATURE-----

--NoS5RDE6TMI11mtU--
