Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F544CAC58F
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 16:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8934788AAC;
	Tue, 17 Sep 2024 18:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pfAJpfcc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D6088AAC; Tue, 17 Sep 2024 18:54:29 +0200 (CEST)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E9788A74
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 18:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-49bcfbc78a6so1448311137.3
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726592065; x=1727196865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O/NADssTmngv1bXmMuCL5ZX0Rj4Roo+NX/Ah8IR6M+Y=;
 b=pfAJpfcc3rJD48ZIlTvwyuhnkzA94Q0lhpl4B9fgZp9gUIw1aMt+95YYIN9wFTn66V
 MBTYPAbhXLw2T/TfdrVDJ1KWrBmgJm7BmePvGjmrA2Cx7/ULjsvXXcxnSNtPjQkwolW0
 3bZ/GXLZ7/eCLY07Z258r+SLMCcASCU0dF4/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726592065; x=1727196865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/NADssTmngv1bXmMuCL5ZX0Rj4Roo+NX/Ah8IR6M+Y=;
 b=M0qA+9strPluQC/gLdT4xBljiej7VDtfFwu4b2V9wG7eW13Cnpaa66W+qi4Y7a8ALq
 SiAaIsmgkC8cCQFk913TEuAyCdaQXlWvFQ1lRvHcQtD0dX94zt9mu92EvM/b83Ll9NOH
 lHXTzWwNM0gNwbzQGzkeccT/SJlLVuP1OjKEvPirpqfFlrtDTKxz2f6nB/Yej7gvstPt
 C+H+UcRmoTDqjP2XwTpPuIsw/zy2ifjejS0r75H8aSGtZtnbemwlDAtk78Jo9w0zL+vV
 ZcTrK/BRRKYwleXAj1F5YIad6LcBgD2mR9kv0m1yi8vaawBhZMRrq7JJ08L9blTK4KUR
 uuHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJfGPvxEgK9D/LDcYX6hg5a8u2bdippxeGCa1qXg6ULdqvLht+Rcu70HhKUzBvLEG4OSeZQeY=@lists.denx.de
X-Gm-Message-State: AOJu0YzAzhf+iQFFixzevl/5/S8F6+KrrFt4IHvwbiNEKyse+FXJ+wtG
 RuodiHWJYl/1cEZmtDcYPdGCQ+gptaXhvtiiG2KOHVkN/KHJiZUKbkkt8wGcXvA=
X-Google-Smtp-Source: AGHT+IFo5Ll/AQ+cHz+OhVlDoAVgVLWhMr3eN27Z7tckbOLYzdbWr5gEgp4xVoVhaNZKYaKL/o6FaA==
X-Received: by 2002:a05:6102:1611:b0:497:70dc:c with SMTP id
 ada2fe7eead31-49d4f6b0302mr10463518137.19.1726592065172; 
 Tue, 17 Sep 2024 09:54:25 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c634dd7sm36508096d6.44.2024.09.17.09.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 09:54:24 -0700 (PDT)
Date: Tue, 17 Sep 2024 10:54:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de, n-francis@ti.com, rogerq@kernel.org,
 afd@ti.com, bb@ti.com, j-humphreys@ti.com, sumit.garg@linaro.org,
 Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] dts: beagleboneai64: Add boothph in chipid node
Message-ID: <20240917165420.GL4252@bill-the-cat>
References: <20240917081329.370288-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YFzdGPstyUkLivzm"
Content-Disposition: inline
In-Reply-To: <20240917081329.370288-1-u-kumar1@ti.com>
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


--YFzdGPstyUkLivzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 01:43:29PM +0530, Udit Kumar wrote:
> beagleboneai64 boot was broken after OF_UPSTREAM support for
> J721E SOC.
> So add bootph in chipid node similar to other boards of
> this SOC.
>=20
> Fixes: 46bb1405b461 ("arm: dts: k3-j721e: Move to OF_UPSTREAM")
> Reported-by: Robert Nelson <robertcnelson@gmail.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Boot logs
> https://gist.github.com/uditkumarti/32604960dec65401cde8979e51160ba7
>=20
>  arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/=
dts/k3-j721e-beagleboneai64-u-boot.dtsi
> index 884f44239e..27851b7d08 100644
> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> @@ -64,6 +64,10 @@
>  	bootph-all;
>  };
> =20
> +&chipid {
> +	bootph-all;
> +};
> +

Someone is upstreaming both of these, right?

--=20
Tom

--YFzdGPstyUkLivzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbptDwACgkQFHw5/5Y0
tywAbQv/dRnwvUb1qGvS9IAbLvZw4UU0WlaXBU5QgG27quIBefmVOR5yeWqmoAwO
mCIr5O9ozg+bAh6igg0LVEh05vdqCZAlpvk2xJ0GB5YmVIcVJhp1LVXKZ3ZmJcTL
IB+8m2gcca7kWp0Ct6beUXy3Psco4PB6B+Zr2dDWAv/CMuFmpKX6TWXPoxFZyFAx
HbBmLiaDoyZqP4TH4mtzGWvAopqxXrCNdsiT074zkK9TWqXLhi4zANsBpKfqcFi/
ZPCAyMDdFwh/kcA/v39Xx/c1SK19yVcYoiNnAaOe2r9nZW+VJKVcozuvI2tbwGS9
A8KAqOofribq6dHUU32Pa9hzcswyRHIWMo0bBiHav8jIDB2CXViBEMUJryiqoWk+
Yc4qxrmcgYfPesgLEdA0hq1HJJClA8YAuiDhsOUA66ahtquKdpbmFgMOv5bFlvPS
0DCKpDGojk0WQjX/IqtAkb1144pp9+c65/4ZjSDALHr6r3baMG705do6mcJCpIVC
5qn0pkay
=VW1W
-----END PGP SIGNATURE-----

--YFzdGPstyUkLivzm--
