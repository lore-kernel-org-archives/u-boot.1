Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5852CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D1B84942;
	Tue,  9 Jun 2026 21:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N/qq7NEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC29184911; Tue,  9 Jun 2026 21:01:25 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD2884942
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-48673dc56a8so4989631b6e.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781031681; x=1781636481; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7mX2hSJVmRmUkMc6VRgE2fccrI7AKw8sESrMOkm56HE=;
 b=N/qq7NEAX9sJHNy/WUHFGtvmNNfBRDv63FSSN0ayNrxuQAwBTmQbsID6Ns3JCrLErR
 sn8MSEr1SmYVlYzQmW1i4REEjZY+tH/zhbXgx4QdPQxLCicOgyr9DDCJ8YE0LEs9Xjvr
 2ls+9kNrmi9IKiTvWL2d14oNcpwxkNw/0UgyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031681; x=1781636481;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mX2hSJVmRmUkMc6VRgE2fccrI7AKw8sESrMOkm56HE=;
 b=cwye4OUWR8QduMdQBl/mxPq3IeN8VSR5H2K0xr6uUmhwL+O1YBAenGGXYGx14CAxBt
 CVRmAeFDdcRXaV43wecJmL0l2ZTnYSvspbrBSOTXeXsJsGL2Q8/sdckhKbcrw/h/Vn1K
 gmf2+GgyP/mBUin7y1la0egNp6xNffIPegdu9A7i9BfPhbCwWX/3m+Ojhsf8mgw+MCB5
 ecPx2CvXe6HG7K0LoHsEp4LUwpfdqZqxvDwupY3JokmRreyevCtuSVVxnPMHZzhfFc+h
 87rNmy9mqpehHCZ20SSDJFr12QtC/Ac4/1UwpbL44SArKuCCxVMYvJ5xVa3g675S+1P7
 fZgA==
X-Gm-Message-State: AOJu0YzBqJhCPWRvmX2TIvQGRabl1p2SbAATdLxkDndMU6zuuIdoxeoC
 pzoRHtmC+k0OGILbMGg6AGkriY82uWk1vCXxqhLtJntcJOhZFOwtnPhG13D5gLiPErI=
X-Gm-Gg: Acq92OGCMLzCqyaHvT14V31KmjBYV0gyz3JiiANKoAzGlw77zrrgdzfmI9O4UlrXCrP
 sAX0+SCs0JQaPCXEadpa+arvcKjAysKLI8ZdgWkb75eh7fb50XZc0WrxhGXTk6AevF72TMpRWxy
 uPHO59x8Xq4a6CV5qKaJU05AZ2dlQHTCyWzC3X+yW6nUCnIb7DGKQEJcCtkBenKGMOPKMCfjKZR
 L2JRbA33eA0oEE4Mabiz380Z2kJ1b4YrliFg5mTEozRIQjZ/GQHC8h1Ex34b+ugMAyy8FyOOwW/
 Jhohd3xi3pu4vFHXppspZ/N77QqOD8nR5pjxXwJP5Zjvwg4+2yMrlztkY7B4zmSjrb+V7qijDIg
 4J4guBizDhkltfTGYgTWVRjVs6vGgSvC7LDkJV4HJRDSjikKnMADmaKCdEGGUOjQ0PIQsZkXD65
 J6d1CtZq4q8XJuVh+n8aVSkpfJ+bf/42PoTX2rXQ4VUeRC81XtR7JW+cPOS1860LSOO/tLhSIdS
 B8B/hcGHGg1EChCHMHj9+p9nJ0qfv4HM6lt6oWxYMhI8w6D19nZGyQpqzKjIg==
X-Received: by 2002:a05:6808:e804:20b0:486:978f:7b1f with SMTP id
 5614622812f47-486978f7df5mr8462951b6e.36.1781031681333; 
 Tue, 09 Jun 2026 12:01:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b9c584csm17329180b6e.17.2026.06.09.12.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:01:20 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:01:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/8] Kconfig: powerpc: mpc85xx: fix typo
Message-ID: <20260609190118.GV382693@bill-the-cat>
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
 <49fe8243-d33b-41ec-b492-33be6ab5ca46@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z08ikmHuBvS+UQ9t"
Content-Disposition: inline
In-Reply-To: <49fe8243-d33b-41ec-b492-33be6ab5ca46@gmail.com>
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


--Z08ikmHuBvS+UQ9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 03:24:54AM +0200, Johan Jonker wrote:

> While restyling Kconfig the script checkpatch.pl gives
> this info:
>=20
> WARNING: 'Enble' may be misspelled - perhaps 'Enable'?
>=20
> Fix by changing 'Enble' to 'Enable'.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Z08ikmHuBvS+UQ9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaihi/gAKCRAr4qD1Cr/k
CtzfAQD5oD0w3ffb/Xnvx0wMd3uaBZH6d4Y2bUy+OsQ0IklWcgEA/WfjpyH/+V4F
CoIpKOjJjQaDd2g+sbn3dcES4mMrAAQ=
=EaRt
-----END PGP SIGNATURE-----

--Z08ikmHuBvS+UQ9t--
