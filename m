Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8FDC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 14:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89AA2863DC;
	Wed, 30 Aug 2023 16:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HfdheACp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F833863E7; Wed, 30 Aug 2023 16:45:25 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68CDA862F1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59231a1ca9eso63219317b3.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693406721; x=1694011521; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JbUMkeyziwsE+vD3wz9wNAyfWaycEw0zJ0eX6m1wvrQ=;
 b=HfdheACpFvpT7jzWJK5g9raNlKfT/gdBXoWNTdPd6AfQ19e8HybWfIlbRhwbeL+Vnw
 Gwy0AsuUUWlHNFla31sPKuY8L7wfoAA9kjxPVQ48zf20OoKIpqeB/yAY2PkNMs+t+713
 8oHplp8JpyCuZPKj4kQOQuEwWf73srxYbBPXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693406721; x=1694011521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbUMkeyziwsE+vD3wz9wNAyfWaycEw0zJ0eX6m1wvrQ=;
 b=T10+P5/0xCW7/Jlivu/6dYgqDyxNmpEWUgklAurF9QfKhK27KXhqjBMpcIBKsMqTFZ
 ncghxeFfAq1rTYFjVYRryw9lGV+0geRUJg39oYJd56sG2LVEwoszlDKedz4W+9q0vmSV
 +Cezerp1ZhMM77d6QC/8GTT1xblQJ3udKF3UCCCKhT4OIgbiRVlJJEj4IFrGZ+nkWQCp
 QgOhvyOEu91ypFG33hvpo+jk/Qn5pCeOFYDa6rULPo4ljiYUzlGKNDQjJdbuck4dAz6h
 nu3Ozkf5o6TwMIzww3sV7mMZptWPxLv8VX+K+6NqlOyN1H8F4nshWOlPsz/JDkJKKfCG
 wt2A==
X-Gm-Message-State: AOJu0YwtJxpRTs6dg61hLbHYgE9OabEu4LnBpDcW4FINbJOVZ/x0KiTn
 YXt3+RwIb8GTLz+pX5w6DmB6mg8jXZFzDAwDRCCW9A==
X-Google-Smtp-Source: AGHT+IEJeE82asqnR3o6Erx3NKz6J4aTqBzFWjU+eKCCFaz5PTjIxF+kTnMSrM2Vb5/LIB/HztvBJg==
X-Received: by 2002:a0d:d7d3:0:b0:573:527b:747b with SMTP id
 z202-20020a0dd7d3000000b00573527b747bmr2106197ywd.36.1693406721184; 
 Wed, 30 Aug 2023 07:45:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a815f06000000b005869ca8da8esm3318080ywb.146.2023.08.30.07.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:45:20 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:45:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PULL next] u-boot-at91-2023.10-a
Message-ID: <20230830144519.GC3101304@bill-the-cat>
References: <0b6d43cf-3afc-a2c6-a29f-efefbbf1d5d8@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oR3jMH6gF8D8cnCL"
Content-Disposition: inline
In-Reply-To: <0b6d43cf-3afc-a2c6-a29f-efefbbf1d5d8@collabora.com>
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


--oR3jMH6gF8D8cnCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 12:55:49PM +0300, Eugen Hristev wrote:

> Hello Tom,
>=20
>=20
> Please pull tag u-boot-at91-2023.10-a , the first set of at91
> features for the next cycle 2023.10 .
>=20
> This feature set includes a new board sama5d29 Curiosity, and various fix=
es
> and alignments for sam9x60 and sam9x60 curiosity board.
>=20
> Thanks,
> Eugen
>=20
>=20
> The following changes since commit 7755b2200777f72dca87dd169138e95f011bbc=
b9:
>=20
>   Merge tag 'x86-pull-20230801' of
> https://source.denx.de/u-boot/custodians/u-boot-x86 (2023-08-01 11:57:55
> -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-at91.git
> tags/u-boot-at91-2023.10-a
>=20
> for you to fetch changes up to 6e8c9d29e3a72f93e4d5125079eaaa1b5a52a951:
>=20
>   ARM: dts: at91: sam9x60-curiosity: Sync gpio button from Linux (2023-08=
-29
> 17:39:01 +0300)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--oR3jMH6gF8D8cnCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTvVfUACgkQFHw5/5Y0
tywEkQwAiHmXG4Vr6Rb3WdsiGXEYQlY09iQfZUMJLV3FsN/+G20wKotVsodcjDRp
2jCCAlQCSMaX1DoPmaEAAxCN8nQ9ROpVt9Ec1hCeAGYWHorvRV5kJD37AsPUZMgB
4G4MyKK5ekSOGAtmeCMMnUDnJdvZSjpsifp9j1y8Lqhkim/vYh3clfjs0VV0ANxY
QNVC5YCuBY/xd340KXwpc1Z9q5hd5KzHEwFcIW3gavoO0mzQzdeF2SzWfe38Z/dn
59jka9XghaSLa45LI98hvmkAi1tgMyv+DkLtYWJ7H8aKrNGBX/AxVuLgrwGdeo/H
31mrd2Py+Ao9E1N2+yFcV9KkzQgNx3dsLtl0WfafKu0xwU+uboz/8r+gMFcbfP9M
/H4XDxBTSF7sroHgnHXsA4fkbcTjMcF0L+K168VmCtEd+SEDKweAM1kdag+7NRdA
mJvQ+oxGFBQznSHasjZAgDdWmjzgusVZQ2+moHduBaj/ARMFS0zKVVj1GU69wmAi
490Z22o5
=kiGV
-----END PGP SIGNATURE-----

--oR3jMH6gF8D8cnCL--
