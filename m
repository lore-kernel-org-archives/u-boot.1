Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D702BCD484A
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 17:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED1285DFA;
	Fri, 22 Sep 2023 19:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U/QCE27w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8089C86199; Fri, 22 Sep 2023 19:58:05 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3513A85894
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 19:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59c07cf02ebso30180847b3.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695405482; x=1696010282; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+ogebeoaWvRl4PVuzMaIQPKwyY8UoGJTNbaMGqzHVH0=;
 b=U/QCE27wolk/ukbAfUV4kMDNriFMJTR5ApQUGembElWC0lNG9aAuCHWxxsOGN12Aln
 6ArW57nhp/xgXpzJBwMJPEzj9bq0fSpS2SO8CwCahqxWNww7HacNDuYXPSXSr6XXR1GO
 efsadUK2HrtOznTxpV83tB6sqsIhEwXSAHus8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695405482; x=1696010282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ogebeoaWvRl4PVuzMaIQPKwyY8UoGJTNbaMGqzHVH0=;
 b=fRwbpGOJBDKo+xfUUEPbMOeHru6nEybbenULVHv7YQAeONv0HkwYwJhm0nKz5ibzM0
 pX1uma7bxUdQQawsBwxGMhlmSjb0JJZJ7BaP+/HoVukWMUJpSelZii3gd02c75DNn5Xf
 3z5hbH1k6o92vRZmDGJjDM5x29kTmIWfDfF+oczk+aD5aZp1ou4v5DoDQDmYzuAVBw0Z
 s9Os6HuLqy9g0PknXc4KubfcNFRNA4smTplj3EDus7yRfgogts4vGO1qe0VZCb6fIhEw
 5mf3n64H74f7rdqJ54D+fJ1QNXdIQbpKz7HGGxpzg7PQ0UTEtb9EsaRZdZ/pP5VTWweX
 cAwQ==
X-Gm-Message-State: AOJu0Yxj2JKQC62UgHSXPjOQ5JEWqGbK2IF9aS6Yt78csr0qljXZQ7/y
 WD3nmaUUVTZsI1A2ikDFkdLO+w==
X-Google-Smtp-Source: AGHT+IFVlKbS9+EsliuPD77uA8zYCQEhkczho4UDC0zn0KWiRvl3d8vlhi2zRAzrrR5ss887PJz2IA==
X-Received: by 2002:a0d:c084:0:b0:59b:1763:bff9 with SMTP id
 b126-20020a0dc084000000b0059b1763bff9mr481605ywd.49.1695405481785; 
 Fri, 22 Sep 2023 10:58:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b22c-a20b-ddfe-6409.res6.spectrum.com.
 [2603:6081:7b00:6400:b22c:a20b:ddfe:6409])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a816004000000b005773babc3cdsm1005972ywb.83.2023.09.22.10.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 10:58:01 -0700 (PDT)
Date: Fri, 22 Sep 2023 13:57:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-x86 into -next
Message-ID: <20230922175758.GC305624@bill-the-cat>
References: <CAEUhbmUrZp5bgVOb+n28YL7D0FGz6pmVFPt77E3nd2X3rTynsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ml7YJ0rWQxwICFQ5"
Content-Disposition: inline
In-Reply-To: <CAEUhbmUrZp5bgVOb+n28YL7D0FGz6pmVFPt77E3nd2X3rTynsA@mail.gmail.com>
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


--ml7YJ0rWQxwICFQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 11:04:24PM +0800, Bin Meng wrote:

> Hi Tom,
>=20
> The following changes since commit 5d2fae79c7d60eaf7f50322e4ec125d2f58544=
e9:
>=20
>   Merge tag 'xilinx-for-v2024.01-rc1-v2' of
> https://source.denx.de/u-boot/custodians/u-boot-microblaze into next
> (2023-09-21 10:51:58 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-x86.git tags/x86-pull-2=
0230922
>=20
> for you to fetch changes up to 5728246dfa11400d4f7aa8262ea630d8c09a85b9:
>=20
>   x86: doc: coreboot: Mention 64-bit Linux distros (2023-09-22 06:05:40 +=
0800)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--ml7YJ0rWQxwICFQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUN1aMACgkQFHw5/5Y0
tyzB8wwAl9+Y+EKx4xUGBFwo+Zqg4T0oLb9S7+Lpj/M7uGfdokbzPz2a597pd6Y4
IB/1CDJgpk90RgB6JuUHEfsxwlCe7BZ9ygBzzeyjt5DeMXPYL+P6nAud9Xb40uvt
gklFO3x+iTF2YrD81vhD6TsbGCdzH3h5R3C3suVymPmTH2ry6F66rTmHit7nBd/K
gOL4WM+JA7t6E7+iXQRdLeVcCDJssM/p8B8J/9uQkG+mexaM88ASR4F4wWmwcnFM
p+WEi15ILxyjakJXoG4cUQiJINOAMvlV38cDL4LqfRUJu6p8VvqR0wIicKL2gqhr
prwqkn7DmbjI1gvUCyEByC/q3DeZtZLQ2j0IWMSnqSIMtUCjTP8mQ9UmOr1ODjYK
U4A7DEPmJ7PGLRx1h/R6WaYfq0J6Of6jyn1ag6akwwU9R6ES7V05la1j/Zi8gxpb
EoJSfgS0Rz/dorltHQlZQuD1MzWh4XoaBwQ+KeS9paDzTKQJSNORUCi/DVBrtZuY
2anxZ3AJ
=k0ji
-----END PGP SIGNATURE-----

--ml7YJ0rWQxwICFQ5--
