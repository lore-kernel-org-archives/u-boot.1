Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24982C27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37DAE8885C;
	Wed, 12 Jun 2024 18:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K2idSb9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271E2883D3; Wed, 12 Jun 2024 18:02:57 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85CE388846
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-254d001d03dso1422761fac.3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208173; x=1718812973; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mY+xbSMEwaBB2AoPDnTxdfGlRcJBVBNKY63UKtF+Qgc=;
 b=K2idSb9JrIqRV7YYF3d9jLSr0pUtHZH8/dkacjoFhFcupz/RpqR1p/aYuzWGAmHNhY
 Pmn92t0ZshC14IItb1W5aynB4/DQUe73CUEoqgxFiWR/Ii3QYjPKQ2gu+DvC5g3AJPUP
 q3ltNoO2LkYwZAZ2F55iQHJC7Ct+lXEju1Aew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208173; x=1718812973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mY+xbSMEwaBB2AoPDnTxdfGlRcJBVBNKY63UKtF+Qgc=;
 b=bCIx3YmM2X0yV3yrtPG49ifVnltvZer+cxLGLc/CfevYxaLO9WqvuMF0oL5ZD+7uqa
 vWDayq5PbyPi1n2vawBaKD7J0d/0se2b8tOomFPfFwRddzmgJUM5tHqkeRIMe39By8Er
 oxxLiDUNvmRZhYcandw6ut41Eekueq4L7Vi5QiU/FszPV4MeevsiVb3/+Jzz6ohGHAgo
 lwuHHYB9gpYgj5qREqam+YwQuQZ1IqkvGr5UQUdqJbV7E8tmwvAPtLq3vKKjFFetS3I3
 GqtRxeq86V6SUuFmH02Y/bPfu30Y8juIhVkiV+rzNJN+2I2cMVBvTfTU1OODx7GJnAc7
 35Cw==
X-Gm-Message-State: AOJu0YxwnUSX1Eo9blzXgWOsZXU2TMCdn+nxqUOc8mrzdHCcoqAehkUJ
 UiO7I4RtXddfSvqtZUK7bQVJ71oYLYKynGqLz1wPC6EWQz3N3zFsnTexKx2lhK1ZUDrbI1iQqxM
 aUWA=
X-Google-Smtp-Source: AGHT+IFb9lRmv0NL+qHVwhWKrEoHCrEtzPblrbGcMk+EBuKxcIzpyGQ1f2RgVkz350aWkR36+g2jow==
X-Received: by 2002:a05:6870:a408:b0:24c:a547:7b5a with SMTP id
 586e51a60fabf-25514c7042fmr2642888fac.14.1718208173169; 
 Wed, 12 Jun 2024 09:02:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f97eb7c200sm1659146a34.20.2024.06.12.09.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:02:52 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:02:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de
Subject: Re: [u-boot-test-hooks PATCH 3/4] qemu-xtensa-dc233c: New board
Message-ID: <20240612160250.GZ68077@bill-the-cat>
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
 <20240611210025.798978-4-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kQ6pNpd55MzInSCZ"
Content-Disposition: inline
In-Reply-To: <20240611210025.798978-4-jiaxun.yang@flygoat.com>
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


--kQ6pNpd55MzInSCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:00:24PM +0100, Jiaxun Yang wrote:

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--kQ6pNpd55MzInSCZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxqoACgkQFHw5/5Y0
tyyA1gv+JpUbrtF6UNmBsn3m22mXX9nwUFabj9eefobJvITXlMvxsP+mlWVFo6ee
IT++BFVpilKRaQiW6wExI/f7vE1vkyP2ui73xWNfHSd/HRhk9u5AjB6CJHkRh0k5
FEnnsOElmy7Wu6N8HD9Uh4gpaZRfOaLCg8sIX21TlTdqK+oEZsQFOYSBvBE5GLwb
cc5C8AEf2uSdcuOG0YnjpotnppHTGsxFfrQN3/Kf0NPGEtT4AtP5pRdR5h3bACC3
uMmfa7BFCskL64awToY+0CBPah+ngkqcQE6m5B/xPULO+J/Sc+zFXvI+ywjP7aL6
kD6guUJRFVZH3RIlEOH0jUuGWduWsGuuuj7AUhkSE5UprUiJeVdUR6kNu7841lSD
S/jxT3Z8ljUIjBMKOn80+1+GBelbsE99pIeWAWtcK4sBxp9PJ7oCLaPKuVfmvtPc
e6Of6Y3cXdnkmF4yQrF/ty3Oybyr3S3q1/32tncdtlunMOijaoFzSnrzzqOaqOup
EItM8Ya1
=zZfb
-----END PGP SIGNATURE-----

--kQ6pNpd55MzInSCZ--
