Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5A0C83F0A
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 16:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D7AB8349B;
	Wed,  9 Jul 2025 18:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LhoumKsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880C783564; Wed,  9 Jul 2025 18:50:29 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F32583479
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 18:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-613aaa2cf43so52955eaf.3
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752079826; x=1752684626; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dp2eJ5s/gen/pn0dqUzgVsPYYxdtr4LaKQboUmIgaYI=;
 b=LhoumKsW1O0WOZa6DXv4JHQYCMbreIQAAqTytrsEIsZFszvPaNif4pr2aXm06kZcTt
 lxWBZpW5xlQJBkKSDEPBLkV/vQaDqXU00IPJKAb5k8TFq9CqlEnNr7BTgGtnbnW5I0SL
 YMbNf6Lx8lbyHFwOFvOcw+oHYtSbznSLmmx5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752079826; x=1752684626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dp2eJ5s/gen/pn0dqUzgVsPYYxdtr4LaKQboUmIgaYI=;
 b=UdFht95ndFSvX7kZNkrOChP5Iya+2fyStCWPwL036Lrp1Lgx2qr98X+972GaKhELez
 IIjiozrH1qwPz5EIEyvS+YB9tnrgMYD/fpiflPqh7bsou6MkDNOxgmH317g6HSiLDpvm
 nLwDCo3ldie20e2ebNtsJC61ikl0dZkAQKWylwHt+CRprDIzghO/LfBouPLHZ7liMbNa
 hw3uAVK7FdPusD9rHleHP9oRltXy0/LWDcWSI5777bRdrPjEeVCNVKfbk4JPif9sQOLQ
 qS+9RHi2ChxnO+YO4ITlnlCf+QUeuQtuI1o4y5yXXKNkE1eQnQ6xp/OmCjEiHp21xXLU
 g8qg==
X-Gm-Message-State: AOJu0YyXLydcDD/PkX724PUylV12cspMj46spuY7Mqu49bvyhRBufWW5
 7hgYPj+Yog6nED5JnnCDw8sSzIaKUBD8k02STJ43r2Db1r4zzejUE7i5aho14kxvXoNakZss5hb
 fIjpn3QE=
X-Gm-Gg: ASbGnctyqTxnKuPOpW1JgCZig32AXKoPRXUUuV0PXtkUm5KHFtycqnx5CtazYqHH4EZ
 /PApCXQXhSNHzsk6kwELHwoe1ibMXS985QpdxxfYW1G7ypFSt5tsoYZPPZJa0AXS6gESUflPgwD
 sTkLNp44cWRy2BUgYgvwSvKdn2VRWkkse4dvaM56N9PdPAPJjdRVdREDSdA9R7J+EDeKeZKSEv8
 16SERPVIYIzibEN3P6ZwHvZq/929esHAOLd/QB/4DMJ3GK2XyF1e88k4Hx4XUObDXkvUSWJzS9B
 RBJKg8FSJayrPTmMeCGv2Ne6S4DzmY0/7mEUAAjYNBUx2CDnE1U/Bq19ywfaHntutSfjvy+lgl1
 Xh4HZBBc+6RzlQ7PS55P2ydq5hDc66fo=
X-Google-Smtp-Source: AGHT+IHBZ/g2OdVnNIcq37fJeO6GlZmgyhwtHlaWEw/uVg9VO51bbGZU2so4TfGqWO5nfk6QfqjgLw==
X-Received: by 2002:a05:6820:1e01:b0:611:a527:226a with SMTP id
 006d021491bc7-613cced2511mr2330363eaf.5.1752079825940; 
 Wed, 09 Jul 2025 09:50:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e59135dsm2010366eaf.25.2025.07.09.09.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 09:50:25 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:50:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] boot: bootflow: Ensure sel_id is initialised before use
Message-ID: <20250709165023.GX6424@bill-the-cat>
References: <20250630-bootflow_menu_fix-v1-1-5d75ced54484@linaro.org>
 <20250709155046.GA1823165@bill-the-cat>
 <6e922f7b-27ab-4e41-8f8c-baf20adbd896@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hlkktmOs/PGoJI8W"
Content-Disposition: inline
In-Reply-To: <6e922f7b-27ab-4e41-8f8c-baf20adbd896@linaro.org>
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


--hlkktmOs/PGoJI8W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2025 at 05:33:37PM +0100, Andrew Goodbody wrote:
> On 09/07/2025 16:50, Tom Rini wrote:
> > On Mon, Jun 30, 2025 at 02:25:44PM +0100, Andrew Goodbody wrote:
> >=20
> > > sel_id is only assigned to in the case of EXPOACT_SELECT, anything
> > > else will leave sel_id uninitialised. Initialise it on declaration
> > > to ensure that it is always valid.
> > >=20
> > > This issue was found with Smatch.
> > >=20
> > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > ---
> > >   boot/bootflow_menu.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Can you please rebase this on current master? Thanks.
>=20
> The patch is no longer relevant with all the changes. Just drop it.

OK, thanks.

--=20
Tom

--hlkktmOs/PGoJI8W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhuncsACgkQFHw5/5Y0
tyxveAv/YWjb59N6Qf4TuCbWOEcs0TGMclG/EhDgJBt0kuPH1ihVrG+US9p11Zb0
FsfTXb8GdNhROH4E9vrVWKDuRKuQVqDM9F8HwH4ByLzh4iXvwaF2nqNEEXExg38+
7qi2E//tURQaF54YrZcr6VbLYdpnrRSS1xzd7Y9hHczwNYxDZ9SUYH1if3G9ov+B
dGic8qBog4FiVqqUO+zdPDATsGAKgURzRW34hYtbJjKyUn+JAUvNqNnqPmt8vfhn
CF7b2i0l9UVb70lynHHw4DZ96ojDn/MQfMZDr5hcE+68+I/2YKrXph0vmSv13vXM
jyoj6LxoqE8dlwlYwAsCtomgVDUtyvaGSq21y7IDXSxdY7qTc6GrSsq49QEWvNyD
rLnwq2J5tAqhnAftx3sNsBCOp+4kTG6vOqLDkhYS5hOd4ADaPS8htTTXtlQubumn
sgQhFou+BO+BYMJL6wojio2easaFNvPETKTPe0v1fkGGAg+OwlbkRsZ0dMOps6EL
jZ/vwv2C
=01Fc
-----END PGP SIGNATURE-----

--hlkktmOs/PGoJI8W--
