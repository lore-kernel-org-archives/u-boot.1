Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF00CFB441
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 14:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F0588CD9;
	Mon,  7 Oct 2024 16:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LKAhLCEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CAFD88D15; Mon,  7 Oct 2024 16:56:59 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20AF8888EB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 16:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4582c62ee33so51561711cf.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728313016; x=1728917816; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NBpYn0/+ytCThhvMvJov5ohLlW0iAcXdTWufdlzQFFw=;
 b=LKAhLCEXuAApT8UzQB49s8rgcGCJ0sGkFHCWmIAvWpByflwp2rBSJlrPbaRp8jmwBW
 UpsmrODI0yKqk7Jx0ilAPV3d5HDhFM2i9bts6VpjhUbRe/7h29w6ERmDoJkqMXOwOK42
 Efj18VJ5WJL4gjYF2JtPy6yQV+qIoTh40ifmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728313016; x=1728917816;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NBpYn0/+ytCThhvMvJov5ohLlW0iAcXdTWufdlzQFFw=;
 b=UceyicfsXyL9sGsKciFCPCEnmmidKUCgSkUuU8LJdp6+Ip8YSF6jFvk5xx745ytGyC
 wgihOP8CIw16NeIFOppDA04lRhlEpl2dMxvI0B7dw4EA//wTI7VKYOx9ssBftu5n/6Bt
 7eNyHmZ9cubZfm7z/pr+EqDworlgiLuT7jjePjQovD9cebuyXyDG3USV2eLvV3rfekuD
 GOHsX2qbsq1igKVo8Ngqwi0cTok0K6noTCsf2lqP/iaNjDAwnUfztQ5sNjkpxZp00xvG
 Wu01ksYu3G45xdqEHpWGDL0CYYhK4vMFxJm7BNMBn397FOPkpn+7VU9bD2LQ0oYaonCV
 /WPg==
X-Gm-Message-State: AOJu0YyK1zeSYWxRIgiipPIwQrsETpnYDtm6eGaV2oZgbEk0u3pV1+tP
 R7ViIhE27jBINeQcM68GsMTu/IpPVY8V2Nw9mqGyf7vuGneUNPGO4nZuZSOdhjrUoTj2hU+I7Ee
 w+oU=
X-Google-Smtp-Source: AGHT+IFCrfkfv9Dv96Db/IeGtbdq9KoyaJaY3ZalwuIJYMJNxK87hqMHEIFUkS477laSQXD3Ad0f1g==
X-Received: by 2002:a05:622a:134a:b0:458:571c:f9cc with SMTP id
 d75a77b69052e-45d9baeadeamr190323691cf.46.1728313015784; 
 Mon, 07 Oct 2024 07:56:55 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da74ebc5esm27004951cf.25.2024.10.07.07.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 07:56:54 -0700 (PDT)
Date: Mon, 7 Oct 2024 08:56:51 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.10 released
Message-ID: <20241007145651.GU4737@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PhXQIPCSk/7f2rcn"
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


--PhXQIPCSk/7f2rcn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and so here is v2024.07. We had a few last minute bug
fixes come in, and while I'd prefer they come in earlier in the release
cycle, I'm still happier people are testing before the release comes out
instead of after the release is out. I want to thank everyone that's
contributed to this release, not just in terms of code, but
documentation, testing and otherwise ensuring things go as smoothly as
they can.

In terms of a changelog,=20
git log --merges v2024.10-rc6..v2024.10
contains what I've pulled since the last RC or:
git log --merges v2024.07..v2024.10
for changes since the last full release. As always, more details in
pull requests (or the tags referenced by them) will result in more
details here.

The merge window is formally open again, and I'll be merging in next
shortly. v2025.01 is scheduled for Monday, January 6th, 2025 and the
merge window will close and -rc1 will be released on the 28nd of
October, and then the next window will open with -rc2, two weeks later.
I'm also trying something slightly different this release and I've put
-rc6 in for Monday, December 30th to have one more tag over the end of
year holidays, to see if that helps with people finding time to test.
We'll how that went in January.

Thanks all!

--=20
Tom

--PhXQIPCSk/7f2rcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcD9rMACgkQFHw5/5Y0
tyxFggv+NNhVXa5ua4R59/XlAmZJ5yxi6u53epRWg+QOhDXAOw8n0xGlq8Ly/MEv
YueVMeL8Np3H5Qt+5Q8IP573z3fwE6pWMTtjH3V+XC+YVuwAYZLCblgyju/JnAK/
uWXQvU472ZThW4OLgS3XHO3yuBUBb1Fl5InfInhE0aSP2ZOtMPgAjycNqoUUlknV
tOeXQWT62SmydRsz49C0ag93p7/SyV+akqBv8K/e93QT7tWtjXne0jmWTmdElxZl
+5l8TJdCYjy6vOi5Um3Oohlww2wDwYFMClGpZEw3CrK1D9ZZpQNjTdn2psKL15cf
ALrANTKyLxYnNxmbllwC6+lMvbZ4rDT04bNIhHH7/oDTNLaEkRyX76hMdTQn3t7r
3mcnuW+hGD4qnFTLPwqpNL+lTsdpl7VAW/hv+lcFgU0P8JmC73Rljfs3Zz89pXuo
wq5MWRtIc3d1yvGrYfcR0FhNn4doxwdms0GKhFf813Dsv7kzSjH6A0PYgAsrmeSU
nndUGJbW
=w4er
-----END PGP SIGNATURE-----

--PhXQIPCSk/7f2rcn--
