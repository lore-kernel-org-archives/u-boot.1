Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2765BD462A7
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52BD89001;
	Wed, 13 Nov 2024 15:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YA6f5NPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13AAD891F1; Wed, 13 Nov 2024 15:14:22 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF2E89023
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d18dff41cdso41656206d6.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731507259; x=1732112059; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W7xg/St2RsQ48M03wr4KKSEH6cOWTZciPUvuhGG/HdY=;
 b=YA6f5NPCFRlfSz76RQ1DqQcYG4Y2x2CWdB9gXMCIu52rde3JlEWjTZiQ70CgLHLlsI
 xEAA5gIefCKxPR9pypWoZO4r2Xi7ovtIsNF5wa606Fm6zoDnRA1e+X+89layQzpaQHXY
 m8YCD1/KZMaA9xqu3aihIlRz97aCczFpnwzVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731507259; x=1732112059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7xg/St2RsQ48M03wr4KKSEH6cOWTZciPUvuhGG/HdY=;
 b=qdumLv3JVCzQPt7v6KO5AbJjxB7payM7+s9pO+ljDRqKbO9i/RMB0mRUYsXxEKk9GJ
 9GJ7b6+2Ei29lH2jRWvMXfCklVKvtdgOQDASmo5N5KJLBq87BnJ7jbJk8cHikNVI8L2F
 Jv9yUXZR3Xhf7fM5W7qs1J3g8k4NoOC95FCThH4CMxsNEIfd4ZdMWCGvGYGXoSKI5We0
 sO0oVZbvaPwNUF5X2sy09DtHk5LKFLBk5bVQsWmyqsigV/U7It5CEz3ocAqXxkDZT4Lk
 6fyO5W0z0Ci4YckdrEZzSVnkthRX7aFCBqNI1JEZ0hL1iqzbqPllIGDCZNBG5KX89k6r
 LRmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJn8dkiF/E/9s4cEzSc9SnWAAwxE1xE/yS51+QXj6zwGK2Dpx6dqOzdCSUX5tKyMsMAVeUTxU=@lists.denx.de
X-Gm-Message-State: AOJu0YzaXqri3khcfF1Ui6lETd51wQ3gC25ToAaF1dZ2LVukKGW5DXE+
 hi3nKNqFyDtQplV4nkeU/6pTe+cECL4i98GHCLPDkylt4rMMVF+Dx6tn4Ti9Oy7B+8Io83Gqda0
 SSJ4=
X-Google-Smtp-Source: AGHT+IFKNu8RFpUKb82zmFeg078VdB750jdzdO9JqfTChqkxZwxG+7WDOw2JaruFaSuWNkHf270sYQ==
X-Received: by 2002:a05:6214:419c:b0:6cb:c85c:5654 with SMTP id
 6a1803df08f44-6d39e166f57mr244471876d6.4.1731507258769; 
 Wed, 13 Nov 2024 06:14:18 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3961df062sm84370036d6.11.2024.11.13.06.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 06:14:18 -0800 (PST)
Date: Wed, 13 Nov 2024 08:14:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Qu Wenruo <wqu@suse.com>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [u-boot PATCH] fs: btrfs: hide 'Cannot lookup file' errors on
 'load'
Message-ID: <20241113141415.GL3600562@bill-the-cat>
References: <ZzRAEgQYS46yM7Ct@codewreck.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lyup+x3+f3wwzdiC"
Content-Disposition: inline
In-Reply-To: <ZzRAEgQYS46yM7Ct@codewreck.org>
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


--lyup+x3+f3wwzdiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 02:58:42PM +0900, Dominique Martinet wrote:
> Dominique Martinet wrote on Wed, Nov 06, 2024 at 09:56:42AM +0900:
> > Running commands such as 'load mmc 2:1 $addr $path' when path does not
> > exists historically do not print any error on filesystems such as ext4
> > or fat.
> > Changing the root filesystem to btrfs would make existing boot script
> > print 'Cannot lookup file xxx' errors, confusing customers wondering if
> > there is a problem when the mmc load command was used in a if (for
> > example to load boot.scr conditionally)
>=20
> Ugh, sorry, I was a bit quick on checking with an updated u-boot on
> this... our tree is *cough* slightly *cough* old and that was the case
> at the time, but since somewhere in 2020 there is a warning in fs/fs.c
> in case load fails.
>=20
> That doesn't change the fact that this patch is useful to avoid the
> message being printed twice, but I'll need to update my scripts anyway
> to use `size` first instead (as a first approximation of `test -e`)
>=20
> Please let me know if you want me to resend this with an updated commit
> message; otherwise I'll let this sleep.

Yes, please reword the commit message based on current overall behavior,
thanks!

--=20
Tom

--lyup+x3+f3wwzdiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc0tDcACgkQFHw5/5Y0
tyzquwv+P0eoEjhBQ+UOy6mWWmsEz0kw+ucwXk4Bjs+hF47kGH0wNw87Uxjd1s3a
cI6lzx5c+8SZYg7VR6+eSZ5GibhTiFVuHRz6KKM7O/WKDYJb0WuFa/hXTzz7H8Sl
QSni/1e+6u9XQXcAMD0lulll+gMCdQlhQ+ukt6pWjKVMDA9HcL+0GE+MpgtfV1f9
g2ouY3r4XbsqRPbXbWc1GAutFk1gNzOeLiiIjNcR16t7zdrblwDQLqQ2q3pWKXhR
ZiET1+Lk404tke0K6yO3VP527TbFocE3jBQM2OeIBEUoSgWYhJmvV8PiFYom6Itr
hvcXPuYLSS03rilcIxgv7lkgGHmOH9XxW1VUea1Vh/JD5xvgfjmpuMIPAjqJY78/
tiI/HQ34RxyO+9cZE12SpuumwEvkb6lI7hAS65PJsJhfwro1wDCd0BIkr6C/TMD4
Az4xFddsVL0l5Hem7W45GzP+irfHF8/KzyWXrkX/RhxApI+lIID8+SN/Wsi219qh
YMb5Wmkm
=q3Gb
-----END PGP SIGNATURE-----

--lyup+x3+f3wwzdiC--
