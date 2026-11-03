Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9E606EE97
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xzBb6rFt;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZB/OVIO3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEF126070F;
	Tue,  3 Nov 2026 15:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-knx4CBSELT; Tue,  3 Nov 2026 15:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EBDCB6077D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793718701;
	b=StWLLr9uvvvT/RueqgMzTVSHDv4CJkG1UUsISErl6TE4KxJR8D7V0ze30gS/U+QyYxXt
	 W8/+PPbTKm16Ag6rnm5+k2bUXzxaY/ity8T7p4H9ivvgcTop54eoONNFX3r7gNT/7hIeS
	 OraMr4XS+YxqWIbgUxrt0bx1jQMFMOpr5Zu5JisQFX3kwjhwyxIzenRFAfpgoQBBhddP+
	 j3qSP8A4aPekrXUEyVJn+PM38VCun7Fi3CQKOSUA5i7e81cXoDuBsiESnKam5xsQf6HOA
	 qmjRIr0vYMvYIk0dXo7fZuzf2aAbtoEWNgDwPih7ATZc6KST6Hc07j4pvegSIIP3fkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793718701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HxxoDdq6J5FtPJOoEjyBzbLR09pI/fGP9G2fgVJhHis=;
	b=e0MINae5zyfxiHArzCG5doHywjJecbaxXDx0aR2ufc5whX6vd8iKv75n96xoXzc4NbrI
	 Nq5+x/uuzyJrAu2CmtbbIxIbkczlA2s6rOQ8JDE6CAHhB8+hFVEmJEnXdQwIUk8pRti53
	 YuD5//E3uM/AkUUQPIBDwwyD71TsgQwc0d6O606mfFFTDfNZKYorjpy698uMqF2WTZ8mF
	 hePfCz8Vv7264jixM1Od6A4tsB4dPNDARBkEwyvmqFfa1RcWRGaKS/wtoXo7p6p/0wOep
	 zcBxNhvTDE86TpRriBeDefl0naM3yHY+k6FMCdgZGSnBk8tdSByY2GX/Ztz8ntc11kw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="ZB/OVIO3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793718701;
	bh=HxxoDdq6J5FtPJOoEjyBzbLR09pI/fGP9G2fgVJhHis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xzBb6rFtVASeX5LYXRTMVa0hfBPAqcLcjc7GlQ+18sIQ0TfkQNP473PC0sdkxu4ag
	 Fl52BilizMUi+iHnngDqdBnaQ9h+8eoK5vSSrtShB64yddxBjjuaVTNNhsQ7X1hZyr
	 AjLDIDJKrPcZN+xEx0GGe3JIFVc311RHrHl/TCwLkej/ZH4KsymOtTxtCDabaDrZMF
	 DohchKR4BLUnnWpKq/6HY6azqPOt8USlmraBRqy1031+6sw3t3tQMa6zR+fZhJwwla
	 utia9I+ivUqmpJPxDreBbTPJHwH0GbDko6p9yMP06PonQuIubHoJBsLUQO5mvzNK2X
	 ZTUvrwGN52clw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBDCB6077D;
	Tue,  3 Nov 2026 15:11:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B6836356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A80246077D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wAmwbQ8KjSv9 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C6D9F6070F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793718699;
 b=SV+XereyKbzk8Bubx+FrYXVJy0tN2SiIrRkNrMucE46TQW8DuV7lhzwKCdw5/U7Kf5nL
 7SruDeLgHzgk3dqqiP02LDrMi84rGjl6U7oFw6co9pLVLA2aWIFTqPOK+Ar6TSAikGfbj
 3QxD/LDD1IDW3oSzV/5I+pnmFQC4Argi4oYYzlO2OLEHHRDAxN3utRDqIO0zC+Tb8JG1U
 aBaesNKxJ6LaE414SnCaHy6ByzwQS4uhXXqRfJ+7rGuFwRH7x/UgitTZqdhYcx5WCH0Eb
 SW/K9J9VWRF1FA+wwl0kDM5ADsUuCyS0R5eiQxpgOnDLFqNPpMSfycWA1a8FktzMnwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793718699;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=HxxoDdq6J5FtPJOoEjyBzbLR09pI/fGP9G2fgVJhHis=;
 b=BkQ9DWPjSZTBaldSkgrsDO3Yn2ibkLntFXyMp2jgnho0G1A9ieX0IFhSNWNbXmdS8Fb9
 1hcgopt/RbqthOjw3ytF7gYeBoFDmDCSf4e5ZhH4olZnWAn61kMt+fZT10tA5QNig4Y/x
 WXHZFK+gUpUTNXeN60faVlaxyVjtWfXqsJ2STZh+3TGl9EY0DimeV1rxhFl4zEd7zJojG
 uU37cltP8EIMHTMmz9e2lguB1A/E+Pu/gZIa4Yce0cqTKIgPV8JZ99lRsv34GYkrWEUx+
 cW7TIv9SPLh3K0hAjR+ydMSoZgw8DeQbDeahYwfnZuQ+O4m5I7i+ipFe4pMWV3TatQg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="ZB/OVIO3"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZB/OVIO3
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6D9F6070F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:11:38 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6de2f213b7aso1834616eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793718697; x=1794323497;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HxxoDdq6J5FtPJOoEjyBzbLR09pI/fGP9G2fgVJhHis=;
 b=ZB/OVIO32oxUmHF6npXpyLK0vahlqZmzv+BQWOkTfGcxDYNOfKzVulOslX+OEDARWP
 fVHnscmrVQKu5vLjUauKRZQq+P3nPuawPp/dDqMCDvt0EHDHJQo5YFsgKTw1nnCGDiRG
 NjryvkGiKY24P4NDNf2/d5Ron5mqg8pjyUSGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793718697; x=1794323497;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HxxoDdq6J5FtPJOoEjyBzbLR09pI/fGP9G2fgVJhHis=;
 b=ynJNo1Y3A5YoON7bt77ihvDOj+qjj4wYWgL28AfFbyLoUxI3worEJWz+/CRxl5yrZ5
 TwI+rPXafe62RthcxGrEqjNERgDfkDWvFmV8nRPY9F1EkZ4TFWOmU+oI84ZpBjUBFCXu
 EPU7N0pSFNEvhi3dLOdNGsNvjmjKFy31x1eleSIBZYp4lOOf3HpYCNGchmoIYUKEf/Es
 94YKeMxu/GRZ+1uBdme1Fe9NK3GBMcDHLJPKb0/rntBIkaXnfavpCTlooHj1g0szpBhj
 a4Vr3eOs2G97fBH/KytnG4UAKuutvhgJ9D38I6lJMnI/bdQi3WsxFInTyHfYUD5n0yYU
 jYeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIn3y53tnvDQCvarV0HvunfzeGITvca8T7SuoQzdQrPBTMqVABCjGUZvRqrI9vDMC/l2Rlz+4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8LSIsY2oA8Wfi/Rl+aIcjipbDh0MR4/ACU6k26NHgmM6qpkf4i
 Yl8FjTZZYdMEFLGbA5lXtNZnPlGrIUNfvBI9CCAZkagpbvBGu6Olbjh7D/0I95f0z5p3xRWNoCX
 iPI+udQSrC5U9
X-Gm-Gg: AYBFou3Wc6ZiAQeYNTMQyhWm8MpzsWX8sZY6EZ2omRXcvH9jh2NjfThdS51FQ90dj9C
 +BGTd4f12+g3sWgcyWW0QcMk1bfbVkDD1TPHfWp1RyMalredSarqzruC2XcJHHEgUb/ljo5oHy4
 kwNLutycqCOke/me10/DNapbkaFLqAbDY4842w5W+254Pee1e+51bBtxnt+TYFqAwsVT3PZ4FJ9
 6ASuj+RayyGxKDf0Fhl5ALvcaW5ls8RhUzjASTZbtaTE4RnL7on4bhSYQ6vhnUkIzBaPQOaiYQp
 zgoTj7vCkpfssJsAsEEGRltoRCjms3vfkKvQOLXFIkSZ6RB8baWO2HPtEnS7t9l364BN+MVs/rn
 2tPsxbRE3hw4YQ0F9HntoH+1GPriXmxgTGkC2Z0AEuRLinJ5Py2y1UFmaSlmx65QbDP+XPq9KX2
 v4DNFvXkB+pdpW07msYhxpq0EtcJMjQc0VyeWjxgiUf+K1V0RzEZbTzAbtjIN6PyuEWoy6joSdb
 RW+Q9TyB+Ex62IJmonF4flUdWxS7gVJZ9gXiI8x8j/D5vIEHlcd7dvK0S1LZ4lhGJE/rvUDWUKp
 VJO0aa48i9dBwGD5Qq9lm3kIkf49xkCMpkaroEG5aivMnvg2mdzNkG+sdRaz34bHulV2JlytEgF
 2JbCuOLhKD3Ms6ZNYccfmSEUF4ISaKxWFcADcz4QzvvRnMov7EQU+Hl/8qCoSCq/a4cgWW00jJt
 JDAn/HUAm3DMPXFVcqaGtEtBGbCaRVtA==
X-Received: by 2002:a05:6820:1345:b0:70a:549:292e with SMTP id
 006d021491bc7-714f295a3demr6611322eaf.28.1793718697260; 
 Tue, 03 Nov 2026 07:11:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f2a84854sm11608725eaf.2.2026.11.03.07.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:11:36 -0800 (PST)
Date: Tue, 3 Nov 2026 09:11:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: Update my email address
Message-ID: <20261103151134.GN3309461@bill-the-cat>
References: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
 <AD60C4C9-70D5-4C31-B773-86FD9114C1A4@mainlining.org>
 <9D4F1FC7-573E-41E6-96DD-02397083F21E@mainlining.org>
 <20261103144513.GM3309461@bill-the-cat>
 <E2526683-A39B-4D5E-A224-7A5ADAF7BBD4@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="45fwVQfN4NWpIzZ8"
Content-Disposition: inline
In-Reply-To: <E2526683-A39B-4D5E-A224-7A5ADAF7BBD4@mainlining.org>
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


--45fwVQfN4NWpIzZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 02:50:57PM +0000, Bradley Morgan wrote:
> On 3 November 2026 14:45:13 GMT, Tom Rini <trini@konsulko.com> wrote:
> >On Tue, Nov 03, 2026 at 02:35:17PM +0000, Bradley Morgan wrote:
> >> On 3 November 2026 14:27:50 GMT, Bradley Morgan <brads@mainlining.org>
> >> wrote:
> >> >On 3 November 2026 14:03:07 GMT, "Christophe Leroy (CS GROUP)"
> >> ><chleroy@kernel.org> wrote:
> >> >>Some people have reported christophe.leroy@csgroup.eu being stale
> >> >>from time to time.
> >> >>
> >> >>Change to use my Linux Kernel address chleroy@kernel.org
> >> >
> >> >Thanks a ton, I'll merge this in coming days to next.
> >> >
> >>=20
> >> Btw: if anyone else would like to merge this to their trees please tell
> >me..
> >
> >Minor updates like that are fine to take to main and then PR me, but
> >once you've collected things up or it's just otherwise been a while.
> >These changes fall in to the category of obviously correct (on review)
> >and so are safe to put in the release at any point.
>=20
>=20
> Thanks, do you mind also taking my additional maintainers update(s)?
>=20
> the regex and the tree addition if that's okay with you? :)

You should collect them up and send me a PR.

--=20
Tom

--45fwVQfN4NWpIzZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaun5ogAKCRAr4qD1Cr/k
CpNNAQC9Ze8MKcUZITk+Fys1WVn45NtZfAOK8XAyh9gSB16JNgD/bT5AjuHzV9kI
DA4Q38XHKJRv+YbtwNlOMifk8PerXwE=
=+lO2
-----END PGP SIGNATURE-----

--45fwVQfN4NWpIzZ8--
