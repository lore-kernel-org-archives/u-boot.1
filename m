Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF96C02198
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 23:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A46780F53;
	Fri,  7 Feb 2025 00:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JOhUXTH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B772B80F56; Fri,  7 Feb 2025 00:33:07 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D8AE80F30
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 00:33:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f53ad05a0so183405ad.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 15:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738884783; x=1739489583; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aP88OhNCMQlHFEK753OSmiEua5uQn5NtdYhV78yksoc=;
 b=JOhUXTH0RlaRoR6pzp4WDzgjMLJnOPoylXR+wgI1IUo7CruP2Gykk3B9miOq3TgvSa
 4ea9Pj2TpVK1KYPLkDYTdlXCzAxDnPsTC4dzwp6rblzMFduNexbo8kKwUQui5t2kKKmx
 ZYwBVXQkkKd6wzC5XC3LSjaGPJIPS7Foeq56g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738884783; x=1739489583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aP88OhNCMQlHFEK753OSmiEua5uQn5NtdYhV78yksoc=;
 b=LDn2zk3BoHPIcrU5hMYIjvj3qV3ZfME9msgHXI/eUvLVRcVIcXUysUwF01sZXP71h2
 enkCW0gAqmOF2jIfJESQUNGhP2efkLlFbdtopkbFFp5yPZJMPV071idZDDDEoJhtC9gQ
 oh3W+x1qJRLL8FAnJY5cThRMyX3pumlXpiz6/oKLd/ayqPraVbsngWCLDAphsOygZq5l
 n7Fv0xDHw/k98N/DZF7wuP9aEQ3D1eHx3u7YsWqHHeql/8KHb8wo0Kqc5+46PBjqj5qc
 S5jOeaa94K5Vt3HbxOrWyRCLhrqqCZhkwRXlto8CkE/h2GBscI2Yp2I3V6UMa9cYPHVj
 5CCg==
X-Gm-Message-State: AOJu0YwD4WvqPLU2breiEy2sO9uL4wBUZcG1H64Wwsgotc71YddWZpjp
 3AhmURDpT9lX04hqNVpEcVXu6SeJa4RDcBCUI1lMxN+MNKRJY3iMgMV47QmXqOWfH7EGwtL2TBe
 pb9s=
X-Gm-Gg: ASbGncs/BGCRKN/IjAJzA5/qzLetPKt7MZ7Luw10t+NZiFdVQF8lVdRkyoWdGgEAzOH
 D2WyjhGYte4NpzU8Pdxkz/wcTJbWeHJc7kZ0oGPB9p1ZPRDfzvONBhdCjZmK7NKzSeVxEVsjkrG
 b0+KUbcFOf0YxeaoeoVKK6PuMGI74x1ElnLSYlRaLZ1w3SNbqc0W/AR+lmKDkTXM9xbIQ2K5O1g
 zKXaaaF1swa294ra+r+WKroe3Uq4dMiymwSydw8TywiJm3tcUK6gjjlPzW92tWnvnERZBmvZ9cV
 9GxSNwy33tadU/g=
X-Google-Smtp-Source: AGHT+IH/aTeyj/9B4KHbN+Yu2B8cKPeTJ9b8RLa34FlbLqgxlFQ//yeeG9vsqbL3OLMJ5ZmStvhXyw==
X-Received: by 2002:a17:902:d592:b0:217:9172:2ce1 with SMTP id
 d9443c01a7336-21f4e6d7d8bmr22248545ad.22.1738884783637; 
 Thu, 06 Feb 2025 15:33:03 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f365616d0sm18229325ad.93.2025.02.06.15.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 15:33:03 -0800 (PST)
Date: Thu, 6 Feb 2025 17:33:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] amd/xilinx patches for v2025.04-rc2
Message-ID: <20250206233300.GS1233568@bill-the-cat>
References: <08076b31-b5e6-4321-af5f-0d59b559e21f@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QYLNVVZiLkc3yu8P"
Content-Disposition: inline
In-Reply-To: <08076b31-b5e6-4321-af5f-0d59b559e21f@monstr.eu>
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


--QYLNVVZiLkc3yu8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 08:57:41AM +0100, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your tree. Nothing really significant there.
> Some binman fixes which were not spot before and switching our platform to
> LWIP to have cover it better.
>=20
> Thanks,
> Michal
>=20
>=20
> The following changes since commit 97c125e6bb441a8062bdd28e82f17b1da12244=
16:
>=20
>   Gitlab: Add results.xml to the list of artifacts as well. (2025-02-04
> 11:57:36 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2025.04-rc2

Please note that if change your .git/config to something like:
	url =3D https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-microblaze.git

for this remote I can then use "b4 pr" to apply these.

> for you to fetch changes up to 0f019056b2d23aaa839fab31c016d73009870a23:
>=20
>   zynqmp: Save "bootseq" environment variable in decimal format (2025-02-=
05
> 16:22:55 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--QYLNVVZiLkc3yu8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelRqwACgkQFHw5/5Y0
tyzw/wwAlB4Zaobl4shw+H+xpXttXwn4lccjrLvpvnukWdtApXix4sijSEM6raXe
MP1LKDHOlUkKQ6v6K1VxjNbeIPUBprNF8rEPoLZp/YSWQljXUctOK8DXTMKb+u5g
iAQ+q6ZNJY9L6qRIpFa6XdqBsMZ1p6nD6NOQ9WtF/iAL2rsReuaDRDWDMQ3BpWDq
j5Kcy+FC0lcvtBBzfH/cj+pN7lET6DgKYpfcK1oEdyHvZTLKIM6OTshZiVNbbRZu
lBjv54jMlFVJd+CY34R7NYT3VW51so2LnCxs8NaFFSsXidi5zZeInKduitFRiDo1
OVricMzZ4n+fX16x77870VNnqcGoKVPsOPbDgyJYmdd0DMpIB7W1s1PY0B6fMv39
+rI347e7tButlVH500MPLcgsvfp42PB+pmmvXsGYz4eRx4yoEtiDQlziLbOVDLHK
ss350LkbQXTAmpPOVEcj4MG5MoNqQVIay3YbiZQ78MCJAbsxN5Mjibg+ZUZwCWQY
SMKTj3Sz
=mgUN
-----END PGP SIGNATURE-----

--QYLNVVZiLkc3yu8P--
