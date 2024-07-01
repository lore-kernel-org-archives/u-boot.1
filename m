Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F76C3065A
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 18:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 530A4886E1;
	Mon,  1 Jul 2024 20:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cjelJNhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 451FB886CF; Mon,  1 Jul 2024 20:09:04 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84CF886DB
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 20:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-700cc97b220so1480288a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719857340; x=1720462140; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ATeZIP7BvO9eXc9DhcBQGwG+STZozJelJ16JsNlU2f8=;
 b=cjelJNhsnjC/lzHPii3VMv5121gXyRAjxPACjf9qEatZuRGCqoLZRJ9SaEp6811nxG
 CZkgMPDxM5MujPNlPExAAlm+wB2alN8i0BC3lCScNIPoabEB8WdTxgKA8D1HjxFptycl
 rhTEeynKZoS5dFi6xWzIirmFtbJUtx12nedso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719857340; x=1720462140;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ATeZIP7BvO9eXc9DhcBQGwG+STZozJelJ16JsNlU2f8=;
 b=xJI+owV0tpRisjalhpVxyBhpVqbnCjoa53P2eV/Rbq1WmYiS97E/+XTjnMUJhvP2l+
 Cf4RSEHffBaczoSVt6ws/QINwJuWlVHrFwGpq7dl38J3e1iMwV8RtDeNXqB5JXMv0wAO
 +9CMxyiDHm4yCVia0NpaIDrXwiJWaB0jblAeg+kUCgs1lx+t1YR/Djf+hYnrZMQm4DCp
 b4H+IZvnaa8XNZHNMR/SFXY9bbHcFom7hX74ZO0jA2gbNukAb/H77qBfnM/B1IVKDcTl
 1noBv/g20pND9mYF6w6qWLfOvEMX37N6uPaN+buCjbvj9kyEF2SX2ItiEL1tPdapk0x+
 QLSg==
X-Gm-Message-State: AOJu0Yx4EuQqK/6Udr9EOzrAvcCdDTHHiT1WjEXQ0xEUgkjV0/ntt6Jj
 Nh1MHaawixvdom5nMT7Dh3vpmxe0NlHqIDzKZLJd50M/4JxIYGkx43swVhJAR6xduflNdslFtad
 zet4=
X-Google-Smtp-Source: AGHT+IFHXCwzvH+0tFzaGN2OMBpKgk2eghu2VuYmrkTkRJsl9x8eNPz62mKO3ijHEaXgE0nvUNWGTA==
X-Received: by 2002:a05:6870:1584:b0:259:8463:43a6 with SMTP id
 586e51a60fabf-25db35870cdmr4168897fac.34.1719857340302; 
 Mon, 01 Jul 2024 11:09:00 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d8e159f15sm1875044fac.7.2024.07.01.11.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 11:08:59 -0700 (PDT)
Date: Mon, 1 Jul 2024 12:08:57 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.07 released
Message-ID: <20240701180857.GN38804@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jRqHtFQTEHiga9r8"
Content-Disposition: inline
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


--jRqHtFQTEHiga9r8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and so here is v2024.07. Due to some last minute
testing, a problem was found with the zlib update and the safest path
(given how long we've been behind) was to revert and fix it for
v2024.10.  Once again I want to thank everyone that's contributed to
this release, not just in terms of code, but documentation, testing and
otherwise ensuring things go as smoothly as they can.

In terms of a changelog,=20
git log --merges v2024.07-rc5..v2024.07
contains what I've pulled since the last RC or:
git log --merges v2024.04..v2024.07
for changes since the last full release. As always, more details in
pull requests (or the tags referenced by them) will result in more
details here.

The merge window is formally open again, and I'll be merging in next
shortly. v2024.10 is scheduled for Monday, October 7th, 2024 and the
merge window will close and -rc1 will be released on the 22nd of July,
and then the next window will open with -rc2, two weeks later.

Thanks all!

--=20
Tom

--jRqHtFQTEHiga9r8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaC8LkACgkQFHw5/5Y0
tyzyMAv/f5+x+5QOQ+KAILZpUKO8CWi9aj6S5DizSid9XviZkFFRj3LSnvLPMuqU
mzJFLQXQPRHG7c3w4nc+fX08NQPgJ2VmT+gVvMYgaPjIcORGyFxJ2HgWTcngQFf6
5bpvQN4Qwt1p3E6lV8dqg3YkBLdQaTYdT9gjTrIEbP3rvmXEII83J/pQVLyLn1jr
YrGjoTYpinKFHO5j2Kr8N3NQZlN4ihqK6Ji5c05hsL9wl3eapqX7BfyFS90ntZcU
veVdRHgzJ02jeeT5wehWr5MBsQ5X1BkYqTQk/nMnA1ln9+AKchDpnFY+Y1FKvzDL
oMcVcAJ99oXbysmJbdkXmMbH5gTB7KWVt2sRL+5pNR4OTJvDFvz9+XQcsn9ZWd4u
cTtAIcjx46CqojOnNO1/K7AC9k+1gBW2f5j3G2Sh2Nt2v5EoceCpcPCeH9OUFk/N
ZXWeCa6mA+tLR+e1GbZLkXcejjAun/yVVX5mtTsxL/Q/68k3MzEVjpORmh/Sny4z
NN9ydt0Q
=ZMLv
-----END PGP SIGNATURE-----

--jRqHtFQTEHiga9r8--
