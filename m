Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923F0C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B611800B3;
	Mon,  3 Feb 2025 21:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KIThLARU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47666800CF; Mon,  3 Feb 2025 21:07:52 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E2480087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6f1be1daeso460739685a.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613269; x=1739218069; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hgkR5OvuOAfkINGdfgm4hczVUGjbD90gYxIagFUY9dY=;
 b=KIThLARU9oQDQ+rrUYQKx4pgH/MAkXeeZq0mxrk9ez77vd/qHaR9nNGVZ5cXNgIoU3
 +MycRVE5YjeE01+GcdyQ3eq4T25X0zQXhCMfYDwRvq7Dcgmlrb98+PtPLBtmOOFHU9zU
 QPY8NyXElIn98SjnrbVrpo4c0SETRQTmW1YSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613269; x=1739218069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgkR5OvuOAfkINGdfgm4hczVUGjbD90gYxIagFUY9dY=;
 b=uiV7ZtrE9et27Vq1Qb/opkMTyjutR7WqUhdd2vXoAm8ZxDCvYNLcLnPTyxORy/d/Eq
 cY1okkLNG5Fyz7ZBV0m1Klk8rs3f9fEMru4Hhgv4I+Gk6zQngazPve+NCkjK0kSHoVqW
 dOK5vLKwWOCBhTs1FDxR7pA1qQkH3RW/tHU5q2VIzQelpr+IQbke+SLV3GuhhBm4ongl
 1ns9UnlO5PUn8cGX0X6T7mzH7uCn45Bug407Nfr2WCV3XtjiPH1Aw/LNEG8hKD/Y0Qdr
 HpNKg4SVBMs3p/C2cdgrBxBFC6e8ghZL67tZ39Auhocjj0xCzLiWwQSWC2EWAqHWJvcU
 eVpw==
X-Gm-Message-State: AOJu0Yycd1WFKl/8LkbzJl77/QLpvoT+xMFQZd5mkUoMsFRWHzfZcgxA
 2uXxlwFQBahC+4+IytKVr4p9t+Mg/T+4BMl3EuimIoZ8oAvEciQq2arFABoYT7M=
X-Gm-Gg: ASbGncsJnfOqep8vIpfKtwP0CMoj9BrPAEHcRtxvOjdLxwucC6lOu6G373mItifYnoP
 acb7JKcRrAHhRHSXpqHrRqYR7CnuB39KNKK+Nfl89bQTQvGO0799Pah5cKwb2pGc0ow8GCWAjvt
 SVriRDlzjDaI5TZfYFKjaKS9NJ7C23fxpCrwflE2La4jHHOfpctpJrudOnkw4gzC7u07OzCHbJ+
 Hir4NEeDP5b25LqboORtFOe02TuinQszy4VKByVvrIhHxtTPRjxM3PvjNyfwXAbqFzqCeaB40X7
 zLvznPz+iyJCRKs=
X-Google-Smtp-Source: AGHT+IF/TX9lHf025S7PIFDcR1dsL6J4a/qSi8dH+YwID50h7jKg5RGfzIMujqCmFmTp4+BzmJ2L5A==
X-Received: by 2002:a05:620a:3198:b0:7b6:eaa9:d6a4 with SMTP id
 af79cd13be357-7bffcd0c288mr3103877385a.26.1738613268987; 
 Mon, 03 Feb 2025 12:07:48 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8cf5f0sm562803485a.33.2025.02.03.12.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:07:48 -0800 (PST)
Date: Mon, 3 Feb 2025 14:07:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 01/32] Convert build-efi script to Python
Message-ID: <20250203200744.GZ1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l2zRtqI2/6U6WLad"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-2-sjg@chromium.org>
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


--l2zRtqI2/6U6WLad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:41:54AM -0700, Simon Glass wrote:

> Before this gets any longer, convert it to Python so it is easier to
> maintain.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  MAINTAINERS                        |   2 +-
>  doc/develop/uefi/u-boot_on_efi.rst |   4 +-
>  scripts/build-efi.py               | 258 +++++++++++++++++++++++++++++
>  scripts/build-efi.sh               | 207 -----------------------
>  4 files changed, 261 insertions(+), 210 deletions(-)
>  create mode 100755 scripts/build-efi.py
>  delete mode 100755 scripts/build-efi.sh

This should just go live in the u-boot-extras repository as another
sample script. And as a bonus, there you can just push the script right
now.

--=20
Tom

--l2zRtqI2/6U6WLad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIgkACgkQFHw5/5Y0
tywDDQv/ROS2s7ra4JkQdmhzd27LG5Mm0SqJrAoGrtwWT9NThjx3a/itLGgmcilx
Lvq1EOyP4ssvFD/q/iDimsESp+BsHaV0vvWN/hKMvxC4d/avQmr+eJ/1b+CxuPoG
x+glPWe9+FQzQDJk5Rk0UQ1nHJseYqs/13LRXIpIlAauh34UPbDvQvL5uX6YEc1U
wn15HCrd66PdGW/7T2BuASyS/YZj1HSZwU4eBE6d34KR0b+kfM1fVZpHKrp2QxRz
fJnlRr75P2hNg3z0TWmvYGsweRSao/Dh2yY1ZDWn/zNiyY/AbEhkmmmz/CDX6cvs
WfTj3g+Wstc3NEWaXLK9HFAcHd+pBoH1rBTnHt9l2qUoAQV8KyZIG5SueXJtP09l
gg6VaS5/lWfNI1UDDa0KPVBU7D0QiXMc2G3ZNJG0hceOKOMeNH6wvFLuG6YkzaC9
SMdOoFBNAFLlbCa6Io408uJvHjz1qtqv9Nk5QLftJ4sCpYKk1vNczy9Nuj8+e+r0
VNRzqbNF
=K1xG
-----END PGP SIGNATURE-----

--l2zRtqI2/6U6WLad--
