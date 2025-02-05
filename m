Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C38AC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00CE8807D9;
	Wed,  5 Feb 2025 14:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ln28q53A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E10C8807D9; Wed,  5 Feb 2025 14:49:48 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0557807E1
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 14:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso5866515ad.1
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 05:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738763385; x=1739368185; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9fo93gIQmUwpFq89oFRfR/MuaiH0LlFuIZoJC8149Pk=;
 b=ln28q53A08MPbLZpgU29sBnQhixcTYsFrUgHkojUPQ7+XBjqOir/Dej8PA/TXuMCR2
 fObPbMb5Y8bfUe9XiFfnXUfBsdmWLF+Vmz6VsasRW9D8vhg+RAbSd0c1/yOPRJHRiiT/
 dj7xSEYrjKo1U11F8ULVN/FDJaSQMsowjfvyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738763385; x=1739368185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fo93gIQmUwpFq89oFRfR/MuaiH0LlFuIZoJC8149Pk=;
 b=RACzU+kWEtgi6RFjqQ7iqlnz+0S8HzZV2ZTWDArH/AZUC9q4D+7t8IzGNcY3j2QmJk
 BvxKHnJ/scxh0VRgCgw3k01j79xJtSNSaxVE+DRmgEIkpWyDIWh/xjiUaunUyL5AA3it
 OxGvZtXbBAk+QvJGoSxfjvN+oXz1VMFF5XCssGSYzXmNaXfN4iek1P+45ZuaZS63hoCe
 m9fxTXw0R2U4bY6wuKFRLHceAiYiYio22BYvf4RUajzAneXg3iZGvCSs9wp6Hx5cTnOE
 d6taaStDbHEz0A1P62KAe4LLiFPEMa2ucwYlw28sGLHOX2rQ1PdWRf7VWkhacR+fhmXK
 0baw==
X-Gm-Message-State: AOJu0Yx4e9sWsy5H6667cqUWBA84p1WYkKZ1QrKQMhqWS0etmQtbICFw
 7Jqt9fH3duf0+FdmyX8DsrT8KYn2pJKJZBMfeQmj08tzJCtJapTkIymIfxav2qA=
X-Gm-Gg: ASbGncuccgA232TLdX7Is9uyFrNNIExApLOgMgumJ11YN7beUCVCW27v1hNYd2OmrGB
 v/GT0bYwPkNtuyG4AMF7Rvm3NfHYsOCg6ikFkkQf5Yxf6o3HaNUhXtjHVXCcr3sWL8UQtW8SX1w
 dHRMDCNTDu0p2lcV44J6e62LsRxZ8qBI+YS2D1FpKSrMqgawRjxZMXdDakiKhkxA2yKlQRvo4cc
 c9aXj380xOnCCqYzEz78HiR67HcGNw+qb4ABU0UBgAeFWluZ51d/dlTzmFuKJhVVKpL51q/Kw+c
 TCRLDDLL5DdSh+I=
X-Google-Smtp-Source: AGHT+IGTBpzpTWd+4h/GC3Cc6MshyUF3kjYxRVguIhllyW2V37jA9NFuEu7kctHNknaEoSCbF655gA==
X-Received: by 2002:a17:903:24a:b0:216:14fb:d277 with SMTP id
 d9443c01a7336-21f01d3c371mr103902385ad.22.1738763384860; 
 Wed, 05 Feb 2025 05:49:44 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f0454ce1dsm33354715ad.145.2025.02.05.05.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 05:49:44 -0800 (PST)
Date: Wed, 5 Feb 2025 07:49:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 02/29] spl: Adjust xPL symbols
Message-ID: <20250205134941.GN1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uFajmFRwkXpBfB+H"
Content-Disposition: inline
In-Reply-To: <20250205015606.2686149-3-sjg@chromium.org>
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


--uFajmFRwkXpBfB+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2025 at 06:54:52PM -0700, Simon Glass wrote:

> Update for the new xPL naming, which was missed in a previous patch
> which proported to do this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uFajmFRwkXpBfB+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejbHUACgkQFHw5/5Y0
tyyWEQwAmhoOT6O1Q3wCYAlBC6qMQqg6QwuuqDnStXqtg4UnG74UAeKsb2vy3iMT
rjjqxq57J4rg9eQeojtMMH9OZ8MNnGiY9eeF+9u/MC4dv+NLRwe+cR2dsR4xyrOY
LlNSjWhgMenR/CbR9CHc2ZOqsg/ZpX/e/6qHuBcjVr7hzqcBvhwUCBRycmcClgXC
gQEUDB3udtt9P+Tzc8c0rQFcaNVC6u2L0lAHo2Tqo6QVzoFFnsVIhv8u8i4UdJIK
ihaJyjlG1oOJ8jXezYFlRQgyJMEmXFK9SIK84zjU2020Cq8wQzDoL/IriFXNtiFQ
jX7WvVaShCvvNblvumxD02xn7uWhV4bKDNUJxtZsaxqaUZyqoHssOe9470LYjBOL
lv7YtsRG7636A23j/69BQoH2GXOLJ42oynQ+VhbmNfofT9SVu3aPKgPaD2xJnsu/
yCo5Krr6JhMomh/jwKtREuHFqsvSc4oiTVvWNP35U9zPE+MF4m6eE1QOk0ydiuUW
kQNc5qkw
=DslR
-----END PGP SIGNATURE-----

--uFajmFRwkXpBfB+H--
