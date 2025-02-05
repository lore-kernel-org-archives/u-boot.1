Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D320C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 14:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02DA480711;
	Wed,  5 Feb 2025 15:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rDS61MVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D305C80562; Wed,  5 Feb 2025 15:51:45 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79183806C9
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 15:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21f11b0e580so28781555ad.1
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 06:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738767102; x=1739371902; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0k3HeVdwTFW+dzCtS+G3aEcR6K893SVz2tXdEzvq7X8=;
 b=rDS61MVNK6lDxmwMb6kqDZ7ytvp6rNmE8C5bkX445UZYDU8+cRlUtxpHJhPyGELCnv
 uTqk83mV2nd4nWvGBFbc4dW1ThTLKb1kQSCRg1voEGKdb4cZqRhKR0IeVyOo3DaFOGvq
 VCmaSN/35qVkfsBc6fJsvmj+qo15sKRiZkvk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738767102; x=1739371902;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0k3HeVdwTFW+dzCtS+G3aEcR6K893SVz2tXdEzvq7X8=;
 b=Ps0sYy1+FqrpYWFg1K1f+x8LNnotmE1Jxjv8+MOBVCaZqtRgGNYEI6ZIcwv5gV01hb
 ntok79kL45PKGoXOhzP681dqqP9cFDTix3jR8gxObwyn7u9a7qqVaprHKOZgxMzfaPx9
 jsfHbCH8JmC/o7JUxQSsGn68Z4T2AhIK151fxMwCs8/hG0cOOjyAQZONdgH3NAFjeuPy
 0iQ2NrFjKDRxkjKpX+tUMZL8MQdkHeuXOtxftvnGccJ5fUKGd1I3q/SZZhxEFi8neAPp
 FwIgZsepDYlWoo6Fk6EbX1rJ2Pa9NdHzogCk/e12o35dD6dJ6Gm67yoLbGFNLRKj/gzv
 cxVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/LLrBAWh1ZqE+x1OMAEr3HwmfZ5tfmXLBvA9Ic9gAu35J8N/ntZdubXfEEVMz5y5lKFeMGcI=@lists.denx.de
X-Gm-Message-State: AOJu0YyzOTWko6Jad561WsWh6oJMVaI3EjWgRNztEocHXmjzpLdhaMW2
 Jkhg6XX7mxGPbXDg6CaI4bZm8PgKED8PR7+bA/BZxzsuprGOHf4a2qrZlHf6rLs=
X-Gm-Gg: ASbGncue19JqVPKq89ovTgmhh4tHSNVRpeS9MVaLoeu6ObIuzvAa3Kj8QEn9Ytt5JFL
 5s3CJOSGTmqJRsXdrCoLomo2WjOO0pBix40PWFQtQCkWDPtDlWkfHmMEGIQDMOrbPF9Py7sdi64
 nXRsRjFXzeSaw2yWmknzblUCuBALSxEEYe6477TF77nErKtHnLTo0CplgHbIt9iMuYiGCDuwsNa
 w8T006c5Z7UADDOkkkD9IHOs6tyfViIN0dUwnupDJndP6814C35fxsZrodFv3twZ+EAs9Mn7DmY
 T1LBZygprpvSMlI=
X-Google-Smtp-Source: AGHT+IG2Lh3ZI1l82gOQtpCpQ26fnj0hyantaQ6kE877syqrlZ+nhG7zx34ctG5eVTNltyqIp4LOmw==
X-Received: by 2002:a17:902:ce03:b0:216:48dd:d15c with SMTP id
 d9443c01a7336-21f17e74b7amr52644145ad.27.1738767100375; 
 Wed, 05 Feb 2025 06:51:40 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de3308e32sm116320285ad.207.2025.02.05.06.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 06:51:39 -0800 (PST)
Date: Wed, 5 Feb 2025 08:51:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: w.egorov@phytec.de, ggiordano@phytec.com, joe.hershberger@ni.com,
 u-boot@lists.denx.de, nm@ti.com, d-gole@ti.com, n-francis@ti.com,
 nmorrisson@phytec.com, m.otto@phytec.de, bb@ti.com,
 upstream@lists.phytec.de
Subject: Re: [PATCH 00/10] phyCORE-AM62x/AM64x: Add RAUC and Secure Boot
Message-ID: <20250205145136.GU1233568@bill-the-cat>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J/RU4eLhIY/A0WT5"
Content-Disposition: inline
In-Reply-To: <20250205080146.1944928-1-d.schultz@phytec.de>
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


--J/RU4eLhIY/A0WT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 12:01:36AM -0800, Daniel Schultz wrote:

> This patch series adds support to boot PHYTEC's reference distros for
> RAUC and Secure Boot.
>=20
> It adds a new Kconfig entry to embed the RAUC boot logic into the K3 MMC
> boot logic. The boot flow itself got extended to run the raucinit functio=
n.
>=20
> It also adds Kconfig entries to pass private keys from an external locati=
on
> to U-Boot to sign bootloader images. An additional config entries allows =
to
> enable FIT image, because our Secure Boot implementation uses fitimages
> instead of normal images.

First, does CI pass with this series? Second, is this also based on the
RAUC support to bootstd series? Thanks.

--=20
Tom

--J/RU4eLhIY/A0WT5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejevEACgkQFHw5/5Y0
tyxW0gv/afE1F/iBsnkMA1rOmGXsVlnDrqxXBFmtv1ISf0YCOJIjrfL0OREHo2+3
7veTYUB4jfe9xoRmnewhlCBegnMEixhNLkzOc6TKLCXecPwND0QY0IZWR6/nNm71
CCfDdVcZeZp/uGHHudjLLHiDT6CIup8TkJxpndruRmzrDds1A9s0yZ70TBPSIM84
XwIg+3PmIgDO84YNRa5jC1pEP/GGQwjlADfiSbzYOO6rcON2+qQUUwepuuOmxlsk
dHtUqny82JuMRir5Tq8N2Kj6igbxUa2sOpq9liGEKs3lR1U32PJPBAETwi+Svta9
sfO4MGz7Ddq933AL/USDbua6Unyaw/EUMa8ndZRWvLm7TWpobCTvi4PHYpptlvfE
ehrGgaxoSVvG4T1Z/qA+ys8CEi04G5VjRz31BAW+RDsKZoRuYiIjfvgWul1smzcm
cgXM7A5KDOzOMy5YejRSyt98fKZysUwVX6DxB1mEFAmF77WGpdxnaXy10xw8H1Cr
QJ2y3nMC
=xDCz
-----END PGP SIGNATURE-----

--J/RU4eLhIY/A0WT5--
