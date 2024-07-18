Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E27C3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 14:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B2288A93;
	Thu, 18 Jul 2024 16:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PcDf7Dtr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F14188A9B; Thu, 18 Jul 2024 16:36:33 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38EE88A91
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 16:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-260e6298635so465229fac.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721313389; x=1721918189; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gDuAbPUkmPaWeNZqb6CJ9mPncStQSFO0PXuuFPdw6G8=;
 b=PcDf7DtrAsvqE2o5w3JFPdtcAEODDTQeeUXn/zxtoPG/UYwalYI1fhbCm7+nW8JFWF
 JdlsTWBCwFELctK/1APUSlVPgniPWAYZmI2knYqSBAwLswywPfqD+OJYimGqLsIhDIjO
 IYz8uLVHiX+LtN+cS2t6OVFeV5oubZ+qSiLrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721313389; x=1721918189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDuAbPUkmPaWeNZqb6CJ9mPncStQSFO0PXuuFPdw6G8=;
 b=IzzqLRu74u0cF9vKHe4DMENffn1Vr4b9ZxCjSkSWm/dmuWU18D5ZoHBxTIyR3A4fdK
 2DtN2zqVmkMbA82h07hkDsOCz69a+6vbyRXIte5k2chlnkvwmnvEPKk3m4lE64DxrDOW
 AYstZzrqHzsxrPY+aWDbM7tMmAJHmc2i8zUc/7nR1EM/gFkYOfSbobEs1xyatu2iGTSN
 l8afBQs3VLAQa+xNepzHOSjEsOhlEinr52GIKqsc2VH+tWMu1TmpOK3pyGgp0MCb6YDD
 Pkbhve8haiHY2MdOPdIxq2ovVBLPxQFtjsT0YqpuwCRQMOQ1cd7t++KCDNC4dsoHGq2M
 hAvQ==
X-Gm-Message-State: AOJu0Yy2NliiItiPpar6Lihgnm90DeJXoC7jaskRxnRpeXbcIY47gOSQ
 yc3WMAcaxy6vErC4e8LRCNLSY+0crpGFN8wsSYokZW44N7FeAjsdov/OqHFCoV8=
X-Google-Smtp-Source: AGHT+IGi+vIPk+6g89I3oHFQ2mEGdTrCiFkcRXqDon13FELDhhHwtoxEz/3QE09mL0EhD2cDFALmVw==
X-Received: by 2002:a05:6871:e2e4:b0:25e:b8ca:4b5 with SMTP id
 586e51a60fabf-260ef111473mr1388218fac.4.1721313389392; 
 Thu, 18 Jul 2024 07:36:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260fdd199c7sm102793fac.38.2024.07.18.07.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 07:36:28 -0700 (PDT)
Date: Thu, 18 Jul 2024 08:36:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 00/18] New CI image and fixes
Message-ID: <20240718143626.GX561963@bill-the-cat>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PPQcvFD67IzxUGqk"
Content-Disposition: inline
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
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


--PPQcvFD67IzxUGqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 10:29:11PM +0800, Jiaxun Yang wrote:

> Hi all,
>=20
> This series build a new CI image based on Ubuntu focal with LoongArch64
> support, fixed various python scripts for python 3.12, fixed various
> problems popped up when testing againt latest software.
>=20
> Last two commits are for demonstration purpose and not for commit
> into repo.
>=20
> CI runs passed at azure [1].
>=20
> Thanks
> [1]: https://flygoat.visualstudio.com/u-boot/_build/results?buildId=3D64&=
view=3Dresults
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Overall this looks good but please split this up as:

> ---
> Jiaxun Yang (18):
>       binman: Replace pkg_resources with importlib.resources
>       py: Replace distutils.core with setuptools
>       doc/sphinx: Remove usage of six
>       py: Bump pylint version and clear warnings
>       binman: Workaround lz4 cli padding in test cases
>       tests/test_event_dump: Relax match rule for output
>       lib/charset & efi: Fix possible unaligned accesses

The binman patches (and change py: Replace.. to tool: Replace..).
The doc/sphinx patch, standalone.
Break the pylint patch up in to chunks fixing various tools, and then
standalone bump the version.
The dump test change by itself.
The unaligned access change by itself.


>       CI: Ensure pip install is always performed in venv
>       CI: Dockerfile: Set global git name & email config
>       CI: Dockerfile: Bump base OS version
>       CI: Dockerfile: Bump GRUB to 2.12
>       CI: Dockerfile: Bump QEMU to 9.0.1
>       CI: Dockerfile: Bump fiptool to 2.10.4
>       CI: Dockerfile: Bump genimage to 17
>       CI: Dockerfile: Use kernel.org upstream for trace-cmd
>       CI: Dockerfile: Bump coreboot to 24.05
>       CI: Dockerfile: Add LoongArch64 support

These are their own series.

>       [NFC] Use Jiaxun's CI Image

Just don't send this part next time.

Thanks!

--=20
Tom

--PPQcvFD67IzxUGqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaZKGcACgkQFHw5/5Y0
tyx60Av9HSbLCmepIl5i9kdkPFED9cSZ9Fa4E4YLpkWKKj297trXRMfUS0oIvmeJ
QK+6Z4WXDZ2HURyaqpSZvjINrSedCXkjypxN56y+WCOa6+xKkXjITg1ZIisz0PfY
GH3mKGqnhi7PL2smSVz/1GHJPhQ6tDCQ4+Xr0a7FAg3zyHDPKYkyWClAp3lkWrSq
8qoxW5MX2zvPnetDr0TgVpw8qzy0O6LpWNG+nDC9Vk6zItxHFebt6KZnUF/ppata
1F1woEXPv5xvkCCxfHgKeTxEOfX2AbFXBWDrVwtztY+CCtVo3VGpCzZWThVkLitD
61fM8qkVIjH384NMVBQT3/fpxy7wEaccR76g5Lsra0B33ZWhN/1XWaiuKUTxCBFK
sroW60XTqGFk/Phgx9j0YitRZoX6aQ4pSmE2Bvc6UmeRYtqB8KS2j+pNydWaN8Gj
+9Dp/SOihm0VceXpnFZbShZpIMdcd2JSbGa8NU6J3nYh3GUD9JBhHk11sgEswprO
Jpvc1NhY
=y0q4
-----END PGP SIGNATURE-----

--PPQcvFD67IzxUGqk--
