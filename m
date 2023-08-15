Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91B3C001E0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 20:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB25B869AE;
	Tue, 15 Aug 2023 22:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FwJGBEJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A77EC869A3; Tue, 15 Aug 2023 22:24:14 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82174869A0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 22:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1c4de3b9072so1928896fac.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692131050; x=1692735850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MLMe7Ryg8HjCgDVgcsqK5LA3Ubejww3FZ1LpKEYTFr8=;
 b=FwJGBEJ006KOuwPjQL/kzZv1Hnz7V8TMkTE1paSjy3KfvykyC01qsgK4GbvTkTt/0N
 JDOWfUzK7IcBXxWIjJTj+vxuIpx5yJ/7fGM0AU6A8xwo47ohiGJDvvMKfx9ug8TiNRyn
 +DR199VdemGIlT7SYVX/9aE/wVntzKhjwJaQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692131050; x=1692735850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLMe7Ryg8HjCgDVgcsqK5LA3Ubejww3FZ1LpKEYTFr8=;
 b=BVkRnENV5iaCBxkxdLJpgTbFPWnSRwh3V8HsIBq7646PzzD1L+5t+Dmn/WroMLZbk2
 NizQR9Mm/NSTZfO8HziVyzNWs2TNz14gYVWpmSSsXf+OwNWzVjSH3XMZ3u0yLebmtNNa
 l4o7pVjg/65SVjyPxBimmExfF7aHq8urWZ+ns262ZTgf8lQ/62FMNPyJPIF59Q5ndnK5
 v2LxSWeqVVaeS5I4JOgwVByO4zOctVVLRbchA79QAMerbpVhnoEYSJQ9Yz61Uz74jdNR
 DRjfXc4eK3ezZbUHpDz9bMz3l99IU+Q5b0YbPNcDLrQC5AxtBplCYOV6/tYL0y0tx+aI
 AFyA==
X-Gm-Message-State: AOJu0YwnMDiw4O2MOOkzZ7E5virEe18mbFmdafl4X1PAxAforjKG2LEQ
 mtiuAdES0/iMw1m18MHdFpb1lg==
X-Google-Smtp-Source: AGHT+IFWPqbeEjoWnw1rhH7gKkGUP+JBovoj9o1cDVkGNsMgl0JteSVTzvJMoBIaqSuJ0mXY26+WCA==
X-Received: by 2002:a05:6870:472c:b0:1c4:ee87:d3f6 with SMTP id
 b44-20020a056870472c00b001c4ee87d3f6mr8441431oaq.50.1692131050122; 
 Tue, 15 Aug 2023 13:24:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 i65-20020a0df844000000b005773afca47bsm3614548ywf.27.2023.08.15.13.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:24:09 -0700 (PDT)
Date: Tue, 15 Aug 2023 16:24:07 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: Pull request for efi-2023-10-rc3
Message-ID: <20230815202407.GE3630934@bill-the-cat>
References: <5e7a5766-0afd-0051-af97-d3bedf4712d2@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wq+etbQ1DkzOU8MC"
Content-Disposition: inline
In-Reply-To: <5e7a5766-0afd-0051-af97-d3bedf4712d2@gmx.de>
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


--wq+etbQ1DkzOU8MC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 06:31:39PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 832148f675e427060be074c276956962fa9b5c=
b6:
>=20
>   Merge tag 'u-boot-rockchip-20230814' of
> https://source.denx.de/u-boot/custodians/u-boot-rockchip (2023-08-14
> 09:11:09 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2023-10-rc3
>=20
> for you to fetch changes up to d768dd88552df18d4a0527cf3d6ddd05dc072f02:
>=20
>   common: return type board_get_usable_ram_top (2023-08-15 18:21:17 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--wq+etbQ1DkzOU8MC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTb3ucACgkQFHw5/5Y0
tyzjegwAmnvh3nrRNffrWfuflFBewMSdO0XStQMaU/rWSHNeekDtSJG/hCefA25r
Svw7/UEmam5JHaOgKcKmM+oWO4dZUawSzAqBrqmN2BwevhU1pIWmJRyAU3Z4yK2F
bRAqC7i58vHKTQDuoklIzTfDCuANN533ILYtZEGPVp/s4sZyE0BB2ChHBdCD7M3F
HGv2xH8jVsf51hsmEQYBGojV+NJ3XBGV5p8t01OrA6AM7wBi1hFZETOM284aqNwi
3/lhgSwUzPkPnbbMFwqHiVLPY4Fzk1CsK4Ne0UUaDDSdiivHb38GvY8JhFOu8h8l
AOtwAW/hA3WlWT8LOJiq3iHCEGYNVmGQdQ5swpAZjoysBDkHcDSH0NEPBFgqpWI/
f80wu+cDJgmNseAh6LDKBbXUjPrr69eq7YxzUxOu6ZWPHN6vdQPbBZFgKnLMsGLL
yN9pOfiP/2EPHY2VmZgYLaLYyQLEyVDCre9mDbgu3Ab4WJSopS1AX/00WhF/djwY
fu8pWyHf
=vF5w
-----END PGP SIGNATURE-----

--wq+etbQ1DkzOU8MC--
