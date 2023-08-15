Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035B4C001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BD7B869AD;
	Tue, 15 Aug 2023 16:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NrOfs2O5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62564869AD; Tue, 15 Aug 2023 16:43:18 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD72686863
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-589f437fd1dso19900457b3.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110594; x=1692715394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e0CCUNmIQXThOiaqriIGAwzlbHYEOcZ92kz+cHe+vpo=;
 b=NrOfs2O5KBFvuYSGMnqebnSqoKWzzWO+lXqtFNWxzWTXrmAgtzT9NtLt+uigH/5Oc/
 l7PRLs1c3Ds187ruACUJHMAbQ6+jhcjop45zQZLzg4hJiAFiUYxfjD24LiOYSoNZM2Ee
 mRf8mLIvjjZ2bNnb2Zgi8XRhvRLl6ocb2jQ6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110594; x=1692715394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0CCUNmIQXThOiaqriIGAwzlbHYEOcZ92kz+cHe+vpo=;
 b=D4r/0BRatkaFq3ou9L1BnZ+oQlFRAld2gkNtYPyX3c4wM0FvgnbxoMwlTqz/AVHHG5
 uWKhqF+iKHIrL9O0xDc9wobW6BvIh/4fCGT2lWEHN9GPqvssgZGdO4OBTfInNS7NH9zd
 pleo856hwPr1S4+VjqySVJ9feO3AtaJbDNlryVIM4XfBqhXUDH7UFJmdu3p+7Va6Qemf
 F4yVSL1AqfsfBAQrKa1brX7JBwK3bk7rIHnpuYkGBWG3v61kpz3XsZnW6+rtW/Tnp3MX
 QNFKu2NFko18zvvaAGBbWdST4TrCfyr0YCpBYGyNPymQaOZOZky268Nzy4JBjc5wWHZm
 ZOKQ==
X-Gm-Message-State: AOJu0Yyh7k34dsF4bozoKHyfst2Y9HeW40ZkuAYzc2EaNMgX+OgbM4zo
 jx4NOHMTThp0Dw4MxWBurd1wAPmkBIsIXQBEL7bJfA==
X-Google-Smtp-Source: AGHT+IGbeVFWuSHsGG4kybhMpEubk7G16nJrzmI/32b0MKI/DdzBV4FCkS2lDiScMadAAJJ9nkgLEQ==
X-Received: by 2002:a0d:d6c1:0:b0:583:973:cc74 with SMTP id
 y184-20020a0dd6c1000000b005830973cc74mr12200118ywd.8.1692110594542; 
 Tue, 15 Aug 2023 07:43:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 x129-20020a81a087000000b00586a09026casm497291ywg.34.2023.08.15.07.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:43:13 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:43:11 -0400
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] phy: Add support for the Apple Type-C PHY
Message-ID: <20230815144311.GQ3630934@bill-the-cat>
References: <20230714202142.95037-1-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yjLEEzZWHXUegNsM"
Content-Disposition: inline
In-Reply-To: <20230714202142.95037-1-kettenis@openbsd.org>
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


--yjLEEzZWHXUegNsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 10:21:42PM +0200, Mark Kettenis wrote:

> This is merely a dummy driver that makes sure the DWC3 XHCI driver
> finds its reset and PHY controllers.  We rely on iBoot to set up
> the PHY for us.
>=20
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>

Applied to u-boot/next, thanks!

--=20
Tom

--yjLEEzZWHXUegNsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjv8ACgkQFHw5/5Y0
tyxapgv/SCeaZKM+Umbe3G3u2nZx8YXZbWysDKXjJs733iCTZNVgcrTV0lMIO5fQ
kt6h70MDQtQzKQkJFh7j3worW2OO06e473Xxx83AtqpUKkJxdF1eRecWuT6oJMyl
BP/U6bSPKGO+xzfbwUi4TLXokCGrmOeLdVMBhRBOLCAmUXH4iZl/2jA79SV7vCNJ
r8nzE/OSRbEOwV038XVWaCS2uoAUl9N5AHWgrhFxOi+oqs634az2RQgukmplKGPJ
7DfICaocAzIKMfogT8uwI2I2367Rl8ponPWs2gFe/jmuYcgpAOCGtTpV8qkx+ol5
23Vx0sS1BB5klhaWLMBqlBCq/dvjLEouJaojCsHOa6AztbDy+j8rP++EPjuuMl3u
hIHepN22aZ/QJ1BGLWIW88ozd1kEcuDjTS3s4ZvLnu5kNdpUFkmnzvaTUlScG4bw
8I1WcIg2Z17j5X+k/fGnLuGt8ds11+nxdmMhpRpyp1YCHtb1BPDNZBxgMVTK3qUj
44HyOb4z
=jOx0
-----END PGP SIGNATURE-----

--yjLEEzZWHXUegNsM--
