Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA08606A333
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lfMJMnMY;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Rzwh2qHj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C5156080C;
	Tue,  3 Nov 2026 14:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h-fXAXGnyb6o; Tue,  3 Nov 2026 14:45:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5918D607BE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717121;
	b=MdipWCIqN9AI4Rje39sMUyVw7qtSvS//Yo3BMwahNVPPjPhXql0PXYTlvqnELMYxJlin
	 tzIVcBrFJHL4iuv3w7tXl8AvU33qrB7Uadhor1GUU8wWPatzm+qNacbOEckIwF90M/NEu
	 p0saJT7j3YsL7XOaAce98ef6sZCBMecou1yuDPzZCfHpOPyEUQPPnmq9Z3uquVWwBb6oF
	 iggEO6c1zSz9DkrsLOYBL8UUvbKQRlfwS8HJya7X1R3DdYZYvswg/wzcY7w7c3V6iewkM
	 KaNepF2u/lF0beheY7AWjVmJFOUUy+/n7wM6nJwyiakL7riNlDGjdRu3k3ialTrb06A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SzLIqrFFYPtDAYwZh/bRH7eqOm4bIrzSMbYpJAoF8zA=;
	b=cbg9dDTTd59YPO659RO9s1Tt/J39lTu0M80aAF2JtOaBY0YZEavhTLEfkRgX2x+kxqw/
	 cPyQh6d/u33dEegSrp1iTzJqIYhxKEwqhmtFnPdy38HDFxpCDnjEH4+luWlVCqfr9UWAf
	 QzbPUJWrke2FN805Tvq9U/YQc3g3CzgiXBRryzx2IXERIOBYkjR1l52keWEGtKwlkj4Hf
	 acLB5bgY5GAaN1aKo87eOfNhzGPxNCIX+STcAtpMQnqI9ka2Aa2+qoYEDJ+i0kSLZDC+c
	 oITcaXzt6+ebzQC0NVz53QzgjIci7oWFNoI/phaIF0/1p9Xif+xwTJpubXkJn0kSN6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793717121;
	bh=SzLIqrFFYPtDAYwZh/bRH7eqOm4bIrzSMbYpJAoF8zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lfMJMnMYMeMu+KYITs/TewllBTPIn+neNONdxliRqWTnDOW7XNb5eqEsIOeXI+gbQ
	 JasYYXUgpOgNXP0i0DNSq0Klokz91vMlQmPayPgyuAVKDJcss1u6TUShyPF83/H6Ei
	 VYHS33Qcjj2Mc98zlNcnYVMATZu7wKGikbldducAFe1EXoXz03tMDS3TCv32mYi/jp
	 jj3v4UnD9XCzMQzDoufQ1RCJuemhFu+4Q/3wqpRLXI3uH80RVu9hCmWdac8ahTu/jB
	 38LgSXvYokmp6JY9zjVtxxIsvgOd89YE4KPfN4eYMKvYdDWlIBpcR37K7sIPrhSiJ6
	 dfD2UCudP2e5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5918D607BE;
	Tue,  3 Nov 2026 14:45:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DF90356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E7EB640070
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:45:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2vCCvHV8taGj for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:45:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 287FD40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793717119;
 b=n3CxTY+aTKJOeKwaFaMFof02hrEbLaeIbyo8CUgjtvEs2YMIAv3Ounb/0ZrqK7u4WmWl
 u8AEYNhN5QP+uypZIxzkyamOiTmKRqqSDAWKO1w3NbhkD8GiPl3w3acGZXNFUQ0XoTVjo
 9jcqvzIeqR66a7QY4R969dyKNhrJII3mVRLRVkXHYjauPZh4tnKB+CnCuz++eCkpCYexw
 QSgksCK8I2eYRILb7a73m/0Ph4b6qO53dTmxyz9B7D8nqPMbIvAdd5QuSFI50yWQ3Ksnd
 yFi6VGP7fG5MX0tI06h/cuEaeSFx+cSimmHieB5ompqyUyWzo6y1KZKcBjJaMs5ZnYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793717119;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=SzLIqrFFYPtDAYwZh/bRH7eqOm4bIrzSMbYpJAoF8zA=;
 b=Yn9lBCuC2zecQ5zXVbPYgcDQ14OavmbeikF34mMqsP9xluhgHXQNa0oyHB1311kXP1KF
 rj5cHEINySe/k2nnK5u3nT8l0AU9oOthBY1sqBS+iTllkn/497y/VzZCcuiAVbBF9zDc1
 Wiz6gfNqlmEevzAtHO+y4coHboM3OW3c+v0dXXnVsM/J3HAqRZ7tGSFwQl5ehWuyc4RGd
 RaD2dgY8qydNOl0hXDNm4MqEmCVoBh9w4uy2nB2h/WpOf92AXdjHUdDlL6d0Klp9DinMp
 /8CyvgX5KKKJ9m5RhtyozAHPEUp3MGTB1TJZ0jgPP0eMx3uq0un0dARUnVqyCYJFw1Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Rzwh2qHj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Rzwh2qHj
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 287FD40068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:45:18 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-705cb6cedd5so485903eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 06:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793717117; x=1794321917;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SzLIqrFFYPtDAYwZh/bRH7eqOm4bIrzSMbYpJAoF8zA=;
 b=Rzwh2qHjt0EeJZuI0gLmDt7UUvOU/0X1+9Jvey/LUrFbiIxj+HjxuxrKZNLa1nkrnm
 w9rUw2MQ3D9X+6RYYpKyisg6vB2DssjcCCsuQFGlas7tk5q4wq7iopXIEeOcD7sfDjq7
 ZKjvFlxi+XBfiMbjWrjds+Wz5TQ92CtN/zpHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793717117; x=1794321917;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SzLIqrFFYPtDAYwZh/bRH7eqOm4bIrzSMbYpJAoF8zA=;
 b=ec3pjtly/jfITetC9UkqXxkx/ZXTUwhdfWurNsjA0s7SvZdh/HshQDRm+rInWUYB2p
 mbs9/E4kEwg6MSqxwlKRzCoCKAQz9EsaUzwdjVLivqCfc3yTOkrhBcp1aZXwgHPdXhaD
 uT+w0Hcr/KBTmflBKvaz+OMK7LzdAs1zhtTosAKB4CLOHccRzSJsOZY4gGe+bIa1r3p/
 oOaFXbZi0E0kIdj7h0EykVNjg3qlC9ckYMf5oUjOz+O6cnOIMW/caANfnDmITdlBQw9O
 ElsuDENxgEtgyg7QuYkwZIpZUmY1DwP3OnXFGD2HfqCHjTllu1pRBO71unGj09gTEe2F
 6Z8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBznVWGPu1qPgoVgm4BVysYw3tx+ON7gPXWoG19sl1qFQbTINhmgQumG+RVCVnJHA2Grsppo6fo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9GoTQ/+rPxz/VnRBPqPK1i74wZvifYySc/u4VpE/aexVmBur8o
 VT1jFofZoXVir1BS9D6g+OCkeJ9cmrbSbGvL5NzXzNUwJ8/1oAU2yUpLD3c2BpSc+TM=
X-Gm-Gg: AYBFou2qUCRvJttZl9WElpBiPPxPGWs54sToZvJZEuHq2ppJxPx7JGRmnux0SHxxkXQ
 I/CVRaNsqE+9YctAwb3v2U+z3JndZtivoMGaGBANbzWjmte3R9fs/FF3MJEMWphG7gzwhlRhYnF
 aTlQOyfZ1uebwalD8wXmr1P2SVm3SMHc5GayWpN95BsaaJwXLk1WumKHrBTbwUd08DBzKIG3Aqq
 R2IUAyJyq2HHUrOAaabLRb22bJJmH4FpbgaKMdYAcRAjWTBG5AzLhqatLnen7FWMGbPYXhbWw5a
 DYrAEEvRKOjs44KNt9exdtg11u0uMqV6HoszdQC7hH8mFqPoFgwWV5kWaOmsk1Gj2c9LyiNE01S
 mSqldSDZioHlcvfPzgPbdFQOH04CTSsOA73w4E3LFlM3lWuEUjHeoiHRuEUmFnwSL7Z3NsocYJd
 zvJd5atLNp3NpU0tSSfVHIpZKTaBP5Fh2HB0ya5y9q+g/3YfAkJmIJkqku7epCxL4HBAq4W9JyK
 6U1Lzke1e1ZsZQcNPqVbWFEJ8y2TdPQ2a6iMwkhzeXVTekEIR7NlsoEtXpVaoEMOlGzyM7NchI/
 Be4KLYxNm5CIHkTg+agfSJoxTpv+lOhMG9ESdO82RJ/Fmt8SeVY8e7FeAZB6/sQHceTVqK8rtWM
 l93wLDOUuTLxuW4SXq8H9ETALQk9/uiqnQYzpvSZX2sjMbuHwfOWH8TjwE9SVYpM7hcJboYYxBG
 5KTTxpuUeRKPGUTwRFfPvGXGGXJiaxMg==
X-Received: by 2002:a05:6820:151a:b0:715:205e:4b72 with SMTP id
 006d021491bc7-715205e65dfmr2484991eaf.24.1793717117270; 
 Tue, 03 Nov 2026 06:45:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f2ce7c9csm10770566eaf.5.2026.11.03.06.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:45:16 -0800 (PST)
Date: Tue, 3 Nov 2026 08:45:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: Update my email address
Message-ID: <20261103144513.GM3309461@bill-the-cat>
References: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
 <AD60C4C9-70D5-4C31-B773-86FD9114C1A4@mainlining.org>
 <9D4F1FC7-573E-41E6-96DD-02397083F21E@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zWpDsdacanfwxRkP"
Content-Disposition: inline
In-Reply-To: <9D4F1FC7-573E-41E6-96DD-02397083F21E@mainlining.org>
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


--zWpDsdacanfwxRkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 02:35:17PM +0000, Bradley Morgan wrote:
> On 3 November 2026 14:27:50 GMT, Bradley Morgan <brads@mainlining.org>
> wrote:
> >On 3 November 2026 14:03:07 GMT, "Christophe Leroy (CS GROUP)"
> ><chleroy@kernel.org> wrote:
> >>Some people have reported christophe.leroy@csgroup.eu being stale
> >>from time to time.
> >>
> >>Change to use my Linux Kernel address chleroy@kernel.org
> >
> >Thanks a ton, I'll merge this in coming days to next.
> >
>=20
> Btw: if anyone else would like to merge this to their trees please tell m=
e..

Minor updates like that are fine to take to main and then PR me, but
once you've collected things up or it's just otherwise been a while.
These changes fall in to the category of obviously correct (on review)
and so are safe to put in the release at any point.

--=20
Tom

--zWpDsdacanfwxRkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaunzeQAKCRAr4qD1Cr/k
CpGPAP971wLzcWCQBd34XxHanEvPvajUZX/fn1hOOC/OvwKgVgD8CRHqA2YIujFY
yBEVBeyPaVZowoPZdhs192MrJpiXSAQ=
=VZNz
-----END PGP SIGNATURE-----

--zWpDsdacanfwxRkP--
