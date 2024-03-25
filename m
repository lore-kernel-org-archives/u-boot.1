Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EE7C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 13:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B6F871C7;
	Mon, 25 Mar 2024 14:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uVGFihIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C67CF8718A; Mon, 25 Mar 2024 14:51:37 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1E9874B1
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 14:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c35c4d8878so1790352b6e.1
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711374694; x=1711979494; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XCPMGt0h8jl4LvqdTOm3i4axYRM8zrpw0LEdcRFiUZw=;
 b=uVGFihIhMKPNs7ZXPiZOukFMycpI67olSD8xfcVv1hpqtuOV8Gz3Ix+ty0y1d/8VVB
 f40FOy336Di7etSRcxwhiJxO9YcYO6f28tWu7PcyorDanBUfgXpC2DlEGyAi7npOxOUr
 JhvVIB/4zfpWBC5khSwltYBxX+qlHj+gLcb9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711374694; x=1711979494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCPMGt0h8jl4LvqdTOm3i4axYRM8zrpw0LEdcRFiUZw=;
 b=gJbYzeD6IMWwJYE1SRzbxwYBCPyHasXI5pf4d0/Xi2wKYhNwjD5i4g2YJ/ddI0pigd
 RjmJcOahJYIzFGKHhusFchcrGNrR8voomRsPq7CXSHunfUb8w1ysvD46Z/DaJSDrv3i6
 EmzEp2vWz0vAXFeoG4zIyBi2TBCIFPHTTUMPfRBbVyJAijGwOmH2VGStZuHTz9HpKArm
 FP4ugHs63ZJeOzWyqusSGoUsWQRgmgFqtp5TXL+5x0SFmvEsmIbO1iRLABqSTPwByrvI
 Oy/Ib+Ck90U+UUl4Yd2EfiFXB9sUC0l5uav3q79y9NSDPn9YR/aH3ZkTm2LQom/FMpsz
 6XUw==
X-Gm-Message-State: AOJu0YwwNUyKRmmqMjM6fTrnXw0iCJ2JQVM6wfL237qqDI4LPiN4BCkF
 3EMRk+Pwcx+gIOKRHYIlZcF7oze/NSsnKNN+DPEGlvYsVm6pVErh1XXcSopuu0E=
X-Google-Smtp-Source: AGHT+IG4BVw6SeqB26CIF27JQL1y+I5iQTGylXEcKR5MfI7APDA1wxh9FRVbi3mklYxOl2uY73HhDQ==
X-Received: by 2002:a05:6808:318c:b0:3c3:cb61:dc4a with SMTP id
 cd12-20020a056808318c00b003c3cb61dc4amr6755166oib.39.1711374694033; 
 Mon, 25 Mar 2024 06:51:34 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 fz18-20020a05622a5a9200b0042ee2920298sm2593650qtb.61.2024.03.25.06.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 06:51:33 -0700 (PDT)
Date: Mon, 25 Mar 2024 09:51:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20240324
Message-ID: <20240325135131.GB3442575@bill-the-cat>
References: <20240324175308.1612688-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TdN2KtiS9qsheQ1V"
Content-Disposition: inline
In-Reply-To: <20240324175308.1612688-1-festevam@gmail.com>
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


--TdN2KtiS9qsheQ1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 02:53:08PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull this material for next from u-boot-imx, thanks.
>=20
> The following changes since commit fb49d6c289d942ff7de309a5c5eaa37a7f4235=
db:
>=20
>   remoteproc: uclass: Add methods to load firmware to rproc and boot rpro=
c (2024-03-22 15:50:28 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240324
>=20
> for you to fetch changes up to 9d27e441bb14dd526c60c13d5ff16353ca322eb3:
>=20
>   board: phytec: phycore_imx8mp.env fix netboot issues (2024-03-24 13:42:=
10 -0300)
>=20
> u-boot-imx-next-20240324

Applied to u-boot/next, thanks!

--=20
Tom

--TdN2KtiS9qsheQ1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYBgVkACgkQFHw5/5Y0
tyz8Vgv/btm43clyuMdCsRVjiADqcKch0U/S3OlD3PF17MzT7z2aswR5YpFwm16I
yFOMFoEkDnydzAvzfqVFgzNvbkglUOrvGLPGTk50mrbDdaxilOrA7y6H+I1KUHVi
ijZsqJvX6Tcx+bULLyblg49+kBX+g3CGVvZSskmlCIzeRMSeZVMrS7SsB5G3S+j9
PEdHr1qfuxaheQWV2d/LShs71OVrxM28yyct2d3VNYps3vsw9Qi44dBpcTeG0ap4
9G6TzJLLBVVBWbnCvUWUuocF7ygGGr8+ucEBY+/UbkLLQztLaYWQzZ/hPnsdTmsG
+eQhOKoCXRhuVEpiFSOOgOnSdipTsyZYQt1tzze22yLMAM39IkIxH4ocnHmxuG7z
KjbtdvuV704sDYuNZjxgiogccQuI1hEIcDFKmGzLfZ3j7k3IHkJevlQqEAkH3tMP
np15ZJWqLx06k1dD0FK2hwL8MwqdP9nT/RM2124v/zoJR/+XWfwmRJeIPUWEWHMy
H9mYmvKo
=2TcY
-----END PGP SIGNATURE-----

--TdN2KtiS9qsheQ1V--
