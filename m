Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4BC606A33A
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DwI/nsCa;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=kdYaPLdM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 952526060A;
	Sun, 15 Nov 2026 16:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsiGUN817YOP; Sun, 15 Nov 2026 16:01:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F013A6061F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794758479;
	b=ahPkGmUDT/bjjHbD51lgDxxWqO0MP4QbepCfMZZfNRM7dCap0nIUC5dEA15lSOcFty4A
	 RaWlPPV7C3+KBUfV6AP+CNY1ZXz22P9d8Ya9yQ16SKVgv3g7OSIYsyLChxJwENRLGyCdH
	 zJ+ziaWZ8vKLeSpG848OvF0L8aapXPNQC6HF4ZbMNWR2jEfGG2Qubfa3llT/WOWNGHrQ1
	 rMIGq9xYWVqFEOZxpVia1OD5ya4A7XN1N4rc2X4ql5+1r0JBMswX3ZVwjcn9hqb7MQoOf
	 G3DI0Y3gyc8B9FHNBYLKvOQde6nGI1bh2F2QUdTeuGJNlmAskNRrKbN3eo1q8ZJyn6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794758479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hNFaJpie9tsv0G5mkjlO7d5GS/DaqRz2n989hgwbNJ8=;
	b=KSZ0rmei9/bCWM2Onx9qih2XA/uaD48M1AK7BIjD+9Dwk2h8zygJAYF/lOks8SQEeL9D
	 S52kDIEGa1JIT2/HIXU0v6Qsm9DfYZW9OjsgoizWHlf8MY6jRa9kAVNAjiyIzhT3EqMhp
	 Uny5gs+W2tjXJpGoPihNsZQUd8B0tkklUXpsdRAjdoPexOHrXyJmSFDgL1RAx6zW9oaH0
	 0VP/bJs9DfLdBGQvN/j+wq37vCHyDZAZUBSpHCaipIIe2meMw6KwMu1HqOWAywz9mTF6A
	 24FGu7cplEeQ0R8geVGPJUQmSr1l3TwzCdoeYbdd9Ys9YSWfEq/IHoqatJ5x7esOghA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794758479;
	bh=hNFaJpie9tsv0G5mkjlO7d5GS/DaqRz2n989hgwbNJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DwI/nsCatXfEnHMdCl+EqYmnasag+VZk2Bn5as2NBRvf/Lk7TDF8jl88cEeWDi/02
	 t6thW89hZLsCwhb9BEMMWcDlpx2HFaUeR1Yi/vTJHHoHB0B9LZRVgFPCiGPiW71PXt
	 7w4t6m9wC/3wNp7mIOcio2pmNG+6O+AlIHCncz85RD+BV2fKSvtQKisMBdDzlvUFkk
	 tqp+jIxCc9xtSb7EqY2OYDwyo2BaL7VUKH+xy68tKQPqS3TR+CHqh2dueBcTi4WVds
	 Iq6We7bumEA/k/zZEB5B79GTFpjTp68juWP8wSAbOoBmLHMS/Ili4wc7oMz/2TbY8j
	 mTateiwcHYV4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F013A6061F;
	Sun, 15 Nov 2026 16:01:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC63928C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 16:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A319A80F61
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 16:01:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X2fI3btHAFQ2 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 16:01:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D96DA80F55
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kdYaPLdM
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D96DA80F55
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 16:01:15 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-862b3a39d0dso369238a34.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794758474; x=1795363274;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hNFaJpie9tsv0G5mkjlO7d5GS/DaqRz2n989hgwbNJ8=;
 b=kdYaPLdM+6KahlaTr1Yfee8fBE6YjuEQizrV+l6P4e5e3zH3DeE6o/8T2bcFGX2yHp
 dXbeDkfsWVaK8wmlb8hxhBVTiElEKj1mcsR/r34MueiJ076GBmxepHWxSwGXGM6gDg6x
 mQfeI6LlYuLQ/49Z3Nkw+N5Am8/G3ntcA1c6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794758474; x=1795363274;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hNFaJpie9tsv0G5mkjlO7d5GS/DaqRz2n989hgwbNJ8=;
 b=QCdlNi0dH7Yl1DaqVqCnMTXWzQ2ZlKcY2DOKrA+vn8NElwgDsV7otSj+4w72G3RzGu
 Kes2DaVjcSMinwK7kLH5RKT99k5kgB9F0jSTBSLr/Ok0xoF/GNGkiwaOfSSkqP8dn4ms
 QGT8nqthQmCPHRLiwHj1gFNIJXXxGVhBPR4GIJwoaqBn4gAgqvfuocX2r7A9rBcX6LO6
 uOfVNX1AxJfRiWOMVn0jzSL7Bq0YXEXbIuXSxsGSgcZGleAYRyQgxFO0Ce3IBosXaWRN
 4CdqZgUBbZ8izOEhcsx2TEXhkQj/4/qDHFY4QQR+VMETqbmop2CTmiQzvdKcqMg7lwz2
 /Ckg==
X-Gm-Message-State: APuU4Z+A1R+h8YMEJDoQx2HvXCugjM2rReLTbv5Zcyqd+uzbPuNOBR6z
 YsSh2EK1tAjnPp+f5FMeAqtZhbsNS7tu1aN368gUrrzJhcFEYYbwZCoOEovWOnV28eI=
X-Gm-Gg: AYBFou3S5jJyznsU0WHbBX69H8f1XH/HEqcV0NmurFJK6+dF6Y78fzP8If637Eja2Q2
 xd0z82vb6B+tZuJbeT+/hh+EWE328zstyx/8m+pFp2elQvAQmSy2ciJYm4CfXYnIncS0YA7Xr0g
 OfamCKa0o2cZzGKvZ0vUwjBU2if9PXxcOjHvu9mORxNP24p7C3Gl/it4cVd8jYvVW466emR2MKD
 3nll6Id0LRNwrpwyS4XHAZytLGIOXOpoKP2Zp+xeN0K54xYLKwFXkWrTa8whxoEJOMAVhFhrHOD
 JeptntnGUwhp9cb3SQC6I/TdeRkL0jRe8UAlu4mlzAIM7dUgIY0WuQb2ax1K3iAS0m+DUrtcP3z
 FnqZT+zbQ9WFCizlmeXCNlRyesjrhC/LoWs+EsdvC4KUev3hn0rKooD3/RMSntDM6Zeh2I6cyGf
 wuqy5dJIjeN1lyHmnCI+tS2J/FxRS+mslH715NLq6dBDzlXKesOn9rwQKvxA8tZHtFazRB4qFM9
 KCrF743BV0Dpy8s7T4IfmQSh3FBMfcHPKpQCP2jVUYP0cPBIOOBurk+gUEypJGKVPAnKRuAOJS/
 j7hqHCJ8ryhufKEPj7wUatZlALlXltOc3i5Ln0PECRTlXyjSEOZRVsl/1CxnPsHKde6IL5Zok0q
 ZRVQ5icg8PhXwV/7IYy1JT2cMjk2mmczAu+nDl+oi5u9zza35wEBUnGhi+ofmSd51b+26S0IQWo
 UOKS4YwKQpd+ySdNAZprWbq8cRzo1m6bXN
X-Received: by 2002:a05:6820:c44a:10b0:71a:eb23:a7d1 with SMTP id
 006d021491bc7-71aeb23b6f3mr638200eaf.53.1794758474315; 
 Sun, 15 Nov 2026 08:01:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880a52basm8786059a34.4.2026.11.15.08.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 08:01:13 -0800 (PST)
Date: Sun, 15 Nov 2026 10:01:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Dale Wilcox <wilcox101@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: binman: SPDX tag "Intel" on lib/binman.c and include/binman.h?
Message-ID: <20261115160107.GS554944@bill-the-cat>
References: <CAKtUr1WwwZfggtY3xA5cComHhJcbjNVm_fSrwxDPHWh60E1i8w@mail.gmail.com>
 <CAFLszThWu0iXjhznvWXWiM08cmWV_HS8sOtA2pnyhcny4BOBLA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bNhZgIyrm4vFfMDP"
Content-Disposition: inline
In-Reply-To: <CAFLszThWu0iXjhznvWXWiM08cmWV_HS8sOtA2pnyhcny4BOBLA@mail.gmail.com>
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


--bNhZgIyrm4vFfMDP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 05:48:29AM -0700, Simon Glass wrote:
> Hi Dale,
>=20
> On Sat, 14 Nov 2026 at 23:43, Dale Wilcox <wilcox101@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > lib/binman.c and include/binman.h carry
> >
> > SPDX-License-Identifier: Intel
> >
> > but their headers say "Copyright 2019 Google LLC, Written by Simon Glas=
s", and the
> > rest of binman (tools/binman/*.py) is GPL-2.0+. The tag has been there =
since the
> > files were added (present in v2020.04, not in v2020.01) and is unchange=
d in
> > v2026.10.
> >
> > "Intel" is not an identifier on the SPDX licence list and has no text in
> > Licenses/; in-tree it otherwise marks Intel-released x86 code (arch/x86=
/cpu/quark,
> > the FSP configs). So it looks like a copy-paste slip rather than an int=
ended
> > licence.
> >
> > We noticed it while generating licence notices for a board that enables
> > CONFIG_BINMAN_FDT, which compiles lib/binman.c into u-boot proper. Was =
GPL-2.0+
> > intended? If so, would you send (or ack) a patch changing both tags? On=
ly the
> > copyright holder can confirm the licence, so we haven't sent a patch ou=
rselves.
>=20
> That looks like a mistake. Yes I am happy to ack such a patch.

And please make sure it gets sent to the current mailing list address
Dale, thanks.

--=20
Tom

--bNhZgIyrm4vFfMDP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavnXPwAKCRAr4qD1Cr/k
CkPpAP4nVR7kImAsTrZh+VVWoTLKz07dbizD3NLxG/NOsjSVnQEAjIEFf4lDt5Zo
FUrvpaeRudSthxARdABNe8e21pewkgw=
=FIz9
-----END PGP SIGNATURE-----

--bNhZgIyrm4vFfMDP--
