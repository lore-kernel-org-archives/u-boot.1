Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B0AC44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E413A84A9E;
	Sun, 19 Jul 2026 20:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jne4Ceic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1CFD84A91; Sun, 19 Jul 2026 20:22:26 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB9A84A6B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a3897109bfso3194274eaf.3
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784485342; x=1785090142; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ose+NvywzuV8oC2sAjMpx5eQy7cPjJehrnEHf55qfSk=;
 b=Jne4CeickySO1vjM8/GL2Ev+NPJ5YwIX7s2Yh4yjYAI8x8cWMBj73pBDK55eDosyce
 gvf/mN3j47phJMZptOGqyyZa8OpNIetrx7mpqqRoT39YAwnnPFAPOajZ+JHr9voYCPJ+
 bOcx10fqhJbXVio4B/UCn53yoFDbXN/BB4v20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784485342; x=1785090142;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ose+NvywzuV8oC2sAjMpx5eQy7cPjJehrnEHf55qfSk=;
 b=NKASuLvHAuuTwQ7zW3JwST46FPuz1nEzHa+4v0aa24kRnh1NGqbrJB5y8H92Q4c2Yc
 oSUf0gs5p6rpHsWoN98YPMfPig0ErH9flnyGRtcuBwGved0G2yGTlTRzlwooNj4xzgSB
 qhTpKtORhOf6DJjlocXmcBVu+03lXIEpZ2UjY5r9+8rKRKNrLnOfyMqbWFXTA7K3Tr6e
 I21+h8vxp50LGaZ5Rf219u4xjfxr4Y1TtxFp0Mp7cX7ajoISWg7jMUE8Aajlzm7di0w7
 zA8052LiKC+FjK1O0Vz0OkA3nhuDqRdXn2/KoqOYpkTmWS1e0roMtbS9CJfeIFfvrr4w
 14UQ==
X-Gm-Message-State: AOJu0Yw7zXzmb89nJtHI9wsjLaSKZQsPsghTKCXqVhKgWp3UpZ58f1xc
 OvSjK7uJ3G5VCtouNluQcQFUh9fbPjkN1g8a/2kezdOB7LumR0EY15MIGGFgVdDIzIjYuclTRSA
 RobsrZnk=
X-Gm-Gg: AfdE7cnVlKrcU7lCAdRL026ygKY4o69oSJVaqNOKX2NmM3aPR19QRMzEJMjWxGdrfUK
 yiBdly1cWi/0vOD1ys0ivQNawGQ3aeyvKZzhKLLZzk5dM6eaAIBx4+XajMwDBKuXnAcH3fuIhWz
 rPCHoFWNYh1wYI3Dl0Ji8uNOxYBVV4X2IbJWVXDIqOUIrlHoK12ijq9Eo0Q1AIF02E1/Q/o9G6w
 ObVFPfr78ME4rv9h3NFD3bwu+lTY0OcZazvIcpTwoEJ+ucNS2g0FvKt2XEB5n/Ze4TDSYV77gbf
 SKzuH8rSMMnZ+FknQ73D2bjlC/imYAk35AUgysZLTtgUpKER9CWI9r98RmTVqHMQIW1DFaOjt/U
 YYxc71kRg355SuNMFzc81uT3pAKjyoG3VHu+cgzJtSsX8VT3X0aqspI1U7x9IXWGu8k/FuP7tHa
 WOTwX2w5K+tnDlZYU82xu2vj85HSczUXnqEdPyONrQNgyrcrbufqW8FXC47jRzN3/11466ispnt
 lFzm4xomuDXzgyGS/PJiXLqhsU=
X-Received: by 2002:a05:6820:1612:b0:6a1:4347:8ffa with SMTP id
 006d021491bc7-6a53685fe31mr5367689eaf.36.1784485342264; 
 Sun, 19 Jul 2026 11:22:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e0be46asm5891073fac.2.2026.07.19.11.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:22:21 -0700 (PDT)
Date: Sun, 19 Jul 2026 12:22:19 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de
Subject: Re: [ANN] Updating branching scheme to use "main"
Message-ID: <20260719182219.GX749385@bill-the-cat>
References: <20260708161945.GU749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Uzt51vZpwofah+CG"
Content-Disposition: inline
In-Reply-To: <20260708161945.GU749385@bill-the-cat>
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


--Uzt51vZpwofah+CG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:19:45AM -0600, Tom Rini wrote:

> Hey all,
>=20
> As part of migrating from source.denx.de and over to
> git.u-boot-project.org, I think it's time to change the branching scheme
> from master or next to main or next. Since we'll be changing the URLs, I
> don't think we need to (and I'm not sure we can automatically) have a
> period where both exist. Thanks!

This is now in effect. The "main" branch on
https://git.u-boot-project.org/u-boot/u-boot is up to date, and the
"master" branch (per Marek's suggestion) is on v2026.07. The GitHub,
Gitlab.com and also source.denx.de repositories match this.

On a related note, that I'll emphasize more stand-alone, it is best to
switch over to https://git.u-boot-project.org/u-boot/u-boot for all of
your git-based needs.

--=20
Tom

--Uzt51vZpwofah+CG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal0V2wAKCRAr4qD1Cr/k
Ciw/AQDLQgS/vF1DG2CzyNeGKd7vRWFQ6b5TDetdh5h2uMTA7wD+MY9x3Q58m+fP
AVy8ATNAnulxV0itdgn2eG/zUNOdvAA=
=pLKG
-----END PGP SIGNATURE-----

--Uzt51vZpwofah+CG--
