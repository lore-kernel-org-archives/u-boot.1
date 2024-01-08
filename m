Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E08CC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA3487AB5;
	Mon,  8 Jan 2024 18:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aVZS6Gz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DCFF87A7B; Mon,  8 Jan 2024 18:14:02 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DD0687A7E
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-68015293aa3so8207536d6.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704734035; x=1705338835; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+8mI65SXDoHl3v5pVzplTMt2QknMOVkUXf/3YgSsosY=;
 b=aVZS6Gz1ch31rzqyJF8bmS5er5hgq6190S0ASJe7+F7Fm/geHIOXaG7RqHOID+7Aoc
 LXBHGQQ8/yoMi6/mHNgBQCyYU3cTnQBUY+Tn+VZ1lHilAjGeBwW31EsU7jhPOCiz5AoY
 Jg5SX3sifAyAVx0wtHn1G+7aib9RJ4SFHXsuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704734035; x=1705338835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8mI65SXDoHl3v5pVzplTMt2QknMOVkUXf/3YgSsosY=;
 b=XlPLLtwXPutiREs3lhviWmdiB0HjG/lGju3ZAVR/E6SaeVLs3YymSRiTRzmOkVjdM6
 bb2v4skQVI+pFSUA2u5kLukLqWfVRe/GoAQaRmiOYuXefKarmi3RrliRZBQM8JuKLs0h
 a+AA4Ce1DpJprVsQIHhnAuxJPT9TlzjvKjaaoQxM3HOqsOGgNzT20CKkDM0pjpZONmTI
 p+Anair89PSzWYvCATFhfFpHyCtpg3P3jDjvpO7BfBHqNBeL4NEWIPrdjjTUsRAGwoR1
 G+Yu7vVwt9OYdn4UFi+7+40sUaVVV12TtjGgg+7KAVYBJZD7MWOqe6jlOPR7KAXFSvfD
 OftQ==
X-Gm-Message-State: AOJu0Yydpw0smx5nUd0pEnuOMhFkeKTJdmkTYFM7R7p0dacsMxRG5e9Q
 h0tYjjQIufyvLOrUJYE9QuSre9TKk6Y/4itflry4BeqKq8w=
X-Google-Smtp-Source: AGHT+IF7Ap/pYn2d10iN78CbUlpGQPqGmzxGIMgVPkBPQlAGaRCjqDyU+IkFQdMHmjC/+xsFlErrsA==
X-Received: by 2002:a05:6214:260f:b0:680:d21d:441e with SMTP id
 gu15-20020a056214260f00b00680d21d441emr3321989qvb.125.1704734035660; 
 Mon, 08 Jan 2024 09:13:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 pe12-20020a056214494c00b00680e5b70ef3sm127062qvb.62.2024.01.08.09.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 09:13:55 -0800 (PST)
Date: Mon, 8 Jan 2024 12:13:53 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2024.01 released
Message-ID: <20240108171353.GH1610741@bill-the-cat>
References: <20240108153824.GF1610741@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xSKB1GUL2xHaGt80"
Content-Disposition: inline
In-Reply-To: <20240108153824.GF1610741@bill-the-cat>
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


--xSKB1GUL2xHaGt80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 10:38:24AM -0500, Tom Rini wrote:

> Hey all,
>=20
> It's release day and here's v2024.01.  Once again I want to thank
> everyone that's contributed to this release, not just in terms of code,
> but documentation, testing and otherwise ensuring things go as smoothly
> as they can.
>=20
> In terms of a changelog,=20
> git log --merges v2024.01-rc6..v2024.01
> contains what I've pulled since the last RC or:
> git log --merges v2023.10..v2024.01
> for changes since the last full release.  As always, more details in
> pull requests (or the tags referenced by them) will result in more
> details here.
>=20
> The merge window is formally open again, and I'll be merging in next
> shortly. v2024.04 is scheduled for Tuesday, April 2nd, 2024 as I refuse
> to release something on  April Fools day, and the merge window will
> close and -rc1 will be released on the 29th of January, and then the
> next window will open with -rc2, two weeks later.

I've now merged next back to master and pushed that out.

--=20
Tom

--xSKB1GUL2xHaGt80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWcLU0ACgkQFHw5/5Y0
tyzTjwv/f7/sR4rXbaphgsD76m9fYnfDamzUK45X/mcZyUxJxxhLnGOmsG0AlK7n
JPq9CBBe3mxpjrma0Y2fPrAf4T/3XnnFFo3Wj3Bhim8ozoSDxhJOR/UdQHRIStCY
wjkZmr89fifeVjJnYLt6d1Ar+gCl4noWIxZdwUw88nsDtu+FC75bb3zTjom+y+kd
3VWEpCKf02tpwFEr5dnihVAOMPoDFUULhTC92D6Damu9jemRpfKANiqydhlV+ug1
rA6LjdMYAE8z9/G87A8GuP1yeuUKpQCM4j/7rx4RiHAOWg4QXUzJThVYE5jfFCt8
x3Fa6IQar0K846y+NyiXAGQWiFUyxmU/lT/wH9gDA/GU3G1XkKEm6jf5buDnN30G
SZymN34bIBW+zFluaUT8bkNKEd+oqKfxalGMSGGgBgJ/NDZx6MglVDgHp90VtYe2
Qwn3+e3wp0k3enb+Dv98HDssYNlz+8G/DVmCoL0BMxXMo97fylvOxv8hWpvFbZx9
zmBZXf1t
=3yuE
-----END PGP SIGNATURE-----

--xSKB1GUL2xHaGt80--
