Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CEECA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E806740542;
	Mon, 12 Oct 2026 20:08:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PpW3Ulz07O-g; Mon, 12 Oct 2026 20:08:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E83E94043C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791835701;
	b=RIWk8V1qiIJ5mN/pARTK/Nz25Fa1szrwhx9nEx0BBnek7qzfFfwUdQi5hwPpDVklRRC7
	 AH8HVc+15PilJHOLcdcwJISKkpqG/i96Bi22ZRG3EvBbiY+aqpug6Ol7ST9YoQsvV7xDL
	 wGbrwzRvwqpby59ufQKeh4w6W/KLgy+gb9FdmHoI06pJ5R6Dnu5NOwKVTb0iGG+vlD7a0
	 M7ZVcXIFMkKEPRDSwiLqbALI6MNIJuqsYVmkjcr0MsbgxtNnl+D/dxHy/6Y54aCRw5/Ph
	 g8Y9PrnD3lIvaAjMaVTtLReKv9BczZVb8kSj/YEYb58cOV843e+Sp8gvAi4g3Nz9wmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791835701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lHFTjVwkL/A5rmAAB8UBOJ9yD7mwz10IK4Im/nT4i5Q=;
	b=pUpDA/AczF9yn19OifEtQ7il/PaOJjpyU0BDls9lpdzm5O/1B7HNhWaZUYL3yUXXY6Ro
	 oiepPa8DjNoVXBVYlhm5rU/IovFqNQG3ClPix3wlGU/RnvXjXo21Isc1CV47USUgF1JWa
	 tWOvDVjavCm9Jgf7fclPq/d2XcmXWaR4ByRJwKCOOhRUlWJuDk29/uNX0PyxUK2ndoL4d
	 stZRJ+HhLbBZfnl3niWBOYqAumq5xVvGSelmzTbeSdh6ADoR7waoYABLr8fR/qTTjaERx
	 M6SYnatGXfpLhnvQZocPsz7V25OJBPDxr5Gvxmh3i5WpuJDmFEHiAHG/byP8/q68n8g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791835701;
	bh=lHFTjVwkL/A5rmAAB8UBOJ9yD7mwz10IK4Im/nT4i5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=urVBSNUxISl6ManYM/gMqNvvqVanfBpuUaGT4Z/aYIgsEgtyw1Y8Zt6LSqcj83tHh
	 mYR3S1kp5UHOz7gRxLJEbqyfvh9IBWXE0cjTI6H1JPbrx9CI2teaSdjvzuv6+LKk6Z
	 mo0A/cAhwOy3/mqnD+fs9shFDdOJMxxoyyUHEuUHzGdKIDKX9vlKwOvUE1e1WcYwjk
	 v7QjJHRfY9mo38ZH28REpxhfsS6bPIeofK7yWTmvnKsTlb4MsisqP2P6pCd0U35KS1
	 ldZHrq9qTQ8jF+wkjs2pZgN72KCQlIIY2fcEJPi0uqw8Cpua0f42yyqHSw0mqawz6B
	 NgSzrym/03ifQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E83E94043C;
	Mon, 12 Oct 2026 20:08:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC5AD2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9936400B3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g2dE5DNKDyFv for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AD67F4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791835698;
 b=FyeRHC54VSdl6vvx0tbbbksL23vwKsb0BrprJ4oeYCCNkPmlBE6Asti0exGesVM+NnVd
 Bzt6VS4FXZtopSoX0J+F0BM3nlx5o36lAo/vDp5wAxC+jJqRzoxXM3woaEE7o291bKurK
 VBKyUkcnu7RQ30czLAPzP5Ip3FDiTG9wTi80FA3t3MUUou9V5DcN+hZtcT4hV6ubZt7+i
 g+YMsU49ygsqT0F/UakejZKNeLNJi+Q5WeZmLCo/Mb1pfwxOHNftua9CnVZKTHg3pBGfJ
 j/DcKY4s2TBecYS1aJ2fdv6Bfeht++Mq12U9zJ6fMdsAn29v+TSrA+pBxn8H3bojx3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791835698;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=lHFTjVwkL/A5rmAAB8UBOJ9yD7mwz10IK4Im/nT4i5Q=;
 b=EWsXPNN18+oTY91LHs0IoftzVvo98KRBUbQUuASSxjE+/lTfN8Xk8LyCN3KOjXFjUx8l
 xU9hwtw5tf4IFEAh7RThOeJe2jGNpbRnE1E+ZW0xYF7Oi0E8tnEwAFVCs8lU+4UZyD/Wk
 30mqN2slc14ZOEPaFxX+4gVbnCMtrbYuwyaJy1Q/TWlm1sSghoxszVeqCtyD30jRIYHRf
 6xLPJd4v3iCsO/GWuSVgMVrwDKMQp37TKTi8q0oRCCAbnECE70CmlijMpdXv+SRi+5Z1P
 Fv61trU9gpyo+fqNpTM1t6O+sG0zG3VS1K4R17xUXDPjUZ5Y/4sY6lwjmjx6/9gpiMg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UwNg4KON; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UwNg4KON
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD67F4002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:08:18 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 006d021491bc7-6f9b24c99b6so4506eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791835697; x=1792440497;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lHFTjVwkL/A5rmAAB8UBOJ9yD7mwz10IK4Im/nT4i5Q=;
 b=UwNg4KONxZ9ksY6YsnWRAaoicUDLyX/SsW7qSgjnz41WwLF4GQOtTRrGtWcsSecMO7
 uBf0kZ5VnjxFc3TGDjCrZNCXvvmPyj0Qn+lG0Yiq0q5bbwzUNbLYgUbSg0rLwGt3I44C
 syFVK/o1nBgJKwBCK4xMdL53+K870R3R1+X+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791835697; x=1792440497;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lHFTjVwkL/A5rmAAB8UBOJ9yD7mwz10IK4Im/nT4i5Q=;
 b=asAKbmAqCy0Ia/w9sEfWjYFJfQTBjXkKaaCXznPoOrhHudw09B3ri/M5Fo5NRe7CR6
 v/x4QmDNwbwpH7/Ns2Er6OixF6VaLvBlR3gk5hrUGM4GK0F8H1gK/mZ5w0shYpW/OVwd
 rzU4t8MjU0tsFazmGCc6H3JP+Sh4CttIiPplX21xbTgDQ7v8TWwza2gN7ZNgy+zkN3kz
 faTWEeiK2ucAlpHrUJUXyN0KZ6VS3KuwhhFIFPsBqN/r5We/khtbGSuiIxOSw34z2HfG
 x3fZyBS1Fb5R2+6iPEVYO3msNq5KXOmO7kWMuPzqDiw5tqLvbHfOWB4xFh6T9s+S0gw6
 kkig==
X-Gm-Message-State: AFq9FYLzeKV/J2nnuPh11MChqCX7JhRBs7vIzmUo157jvgLiaUT6fUho
 StSRhnse9Yn10Ckaq1nHx2qiKpQbopdv/rsuVK17oFtTSc1zBaT2CV3mjgb0yf7FGRln9yDmRvt
 wipiZpdWqb62JZEY=
X-Gm-Gg: AYBFou1Kquw9rYFDdctZ6XN26mTHDVep92tRhHii85nLQ+LFny4vlAcoz3ufhvAb+45
 C5WPgBgW18BPY9A+A+4BXRAJGkcwABJIkGO4MNrRh2ql8HP4rZUQbpPz5q8bIl27tgVwijbWq8U
 l+b4YuRYkrW+qx0nIjxeAre8IQJtJUYC5lCAEDMXSXSzuesHjzaV9pwDqrqznvmN/4UYpnHLIlL
 9d0qytno0vLdlIhmh8YsNozLd624dMb+J2fkdA9HdCq4a5Zos7qEXCc16ibCQ8EY04KVaeHZR1C
 ZnO8jBhQQjaHBWHBG+qILXG7mRQlxsSuS3lTCQRzQxE1JjZykDV0GcNoMicfc2XLLY0ARqo0PDg
 zZXu4jdHovuePCzDKMaOh5jgk6UG+fEQzANT2pYopzhIdA+KHJXPdZTYZ27MzLnEm0VicoWkjKG
 IFUpnd9mcyzlDZlsbi91TQ6uS3Tmxk7CIO3Nyh0fpn8XvGCU/jmhXgRZiv4HkUde0DRvRl/0sZ5
 Y7kA8r1022cGI6d1PxuIgUYSkMdB2XbSXDIlMfPfX1kGptnDDEyO42LS6VIN6ianr3FUcLwuU14
 68/mC+URW0awBS5qNgI=
X-Received: by 2002:a05:6820:8c5:b0:6de:1788:c3af with SMTP id
 006d021491bc7-6ef10b7edccmr8366236eaf.43.1791835697135; 
 Mon, 12 Oct 2026 13:08:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ef011ecbedsm9867811eaf.8.2026.10.12.13.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:08:16 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:08:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>, James Hilliard <james.hilliard1@gmail.com>
Subject: Re: Please pull net-next-20261009 [corrected]
Message-ID: <20261012200814.GA3799261@bill-the-cat>
References: <e38b2ce1-a74b-4266-8d34-8a8eeb9981c6@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qoiWs2gIdSNBoY/h"
Content-Disposition: inline
In-Reply-To: <e38b2ce1-a74b-4266-8d34-8a8eeb9981c6@arm.com>
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


--qoiWs2gIdSNBoY/h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 09:47:05AM +0200, Jerome Forissier wrote:

> Hi Tom,
>=20
> The following changes since commit ed869863c7e2aca50d57a05d843830dd843138=
c4:
>=20
>   Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-project.=
org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/n=
et-next-20261009
>=20
> for you to fetch changes up to 28ddd369e2f7199539cdefe22ce014c592b890bd:
>=20
>   net: dwc_eth_qos: spacemit: add support for K3 SoC (2026-10-09 18:58:10=
 +0200)
>=20
> *** Please note ***
>=20
> Commit "qemu-xtensa: Increase the U-Boot memory reservation" fixes a build
> error detected by CI that would otherwise be caused by "net: e1000: use a=
ll
> RX descriptors". I did NOT send that one out for review to avoid delaying
> this pull request, but if you'd like me to do otherwise just let me know.
>=20
> Similarly, the test added by "test: net: cover lwIP DHCP autoload handoff"
> initally failed CI and I incorporated my own fix (see the commit
> description).
>=20
> ----------------------------------------------------------------
> Pull request net-next 20261009.

Now that I've fixed the sage lab in CI[1] I've found a run-time failure.

[snip]
> James Hilliard (20):
[snip]
>       net: lwip: finish DHCP before starting autoload

Fails on BeagleBone Black with lwIP enabled, none of the network tests
run and the log output is:
=3D> setenv autoload no
=3D> dhcp
link up on port 0, speed 100, full duplex
=3D>
and we never get an IP and so can't network.

[1]: I still owe documenting better, but you can either git push .. '-o
ci.variable=3D"SAGE_LAB=3D1"' or add pushOption =3D ci.variable=3D"SAGE_LAB=
=3D1"
under [push] in .git/config

--=20
Tom

--qoiWs2gIdSNBoY/h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas0+LgAKCRAr4qD1Cr/k
Cu0nAP9sO5yyxIA2m6dGPHrfj8vttBqgilUD/dJAnSKcP3HVxAEA6z4XRA/J+cdr
J1AZUFBJeEyjbXhldM6YpNWjbwQw1wU=
=FfBr
-----END PGP SIGNATURE-----

--qoiWs2gIdSNBoY/h--
