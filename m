Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28F3C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 17:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC0682B18;
	Wed, 18 Jun 2025 19:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AP1hjlQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C47682BCD; Wed, 18 Jun 2025 19:37:20 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA778006D
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 19:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c14138668so1876407a34.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750268237; x=1750873037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TTV7zv1BX/6YxFos4MgHPzW6qyOVPUzw12eZiOy7Atw=;
 b=AP1hjlQ41lTbe/OQWYNwJfcsoY7gzGkmVTK7Yb90kvmWieoZCzH+t/n8g3RvF5fAQc
 jJ8CaSBizevK6/M1+UB3l3iVO43nNswPB+0Ka3gdDbubnU10Hnauki+2y1G+ePj8t85d
 sgZ/0XENGyAQ1ITCfihDKrsb4+Lh/jM2FQwSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750268237; x=1750873037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTV7zv1BX/6YxFos4MgHPzW6qyOVPUzw12eZiOy7Atw=;
 b=LYKGU2S2JC97gvVJjV+fUuurTz4LZZQuN2eQKAfO3imk2XKma0ewrnrWmoTP8jTe01
 nB1fTkhu4kwhLNXJPf5YNP08HYF3DgvRsPZwmPyHI/j8JboYfKlMKwbZixf51GQkAB3y
 UrbouOwuCv5/6HQfrcgsB83+5iH6+VrwtH5LifLOqSiUHlu0kcFjOv32tChlZYJ/SlFM
 xf4Xi/zTONnyH3HH90rXoiF0FqBXMRxohbcRP3PKSILnEPApDIR3yEFES9vey/SRWESr
 +vscpaCr6gyTajRzPjl4rzh+IdGPl5nUiKR4l4mrRMP0VfnxKwiK9RbBH7quxwza6m0d
 Yk5w==
X-Gm-Message-State: AOJu0YyUit1OPL4vXpbeVZp0R8CtToaOPOL5vZoQJOWJdCj2PaDhvXyT
 PfIBzxxHQ0zBEakbt9J9vcbfSGIz8Ix9QsQkOeLjXPG9uVVQZU/JFbkbCUAyrW717lw=
X-Gm-Gg: ASbGncvavKR+tcUeutpPWr2tggZ4yxlviqgjSTmmuhW+VeOK2Rn/NJTqY+ezIcLpdW3
 mTsYqUgOdMbt4Ol4MmIH2FiooGBj04gBgzUWr/0cgiCJIXH/k1OOIR+s6U1RCPo0GhO0p4S0SmP
 evY1zEPdDBsNhMtX9HMeorTpml4POtglz2KRxUKuDSdqCKxW0FlargXlquyAMgSVXCBNAtQSNVt
 egWKh6Ak8ZdC9un7EDW4MarU+ZiF4TG1QgYZWvHg6xTQt3CzZENpHwN3jS2iJzMMFi+2vZWO56r
 Cjz4phhOOxbYtsst5Dx6scVlN3vsFrYivODx7huT66Ety1d1rCxOR6sBOLYtw/xibeFBgXMtPwx
 Bd22j52kNNJ4QibGXODKY3fs=
X-Google-Smtp-Source: AGHT+IGc5Sb91KMJbnshFTYTl5zCRpQZ6aEb9VOaEENTKVf3TheC2wTLH05gGXXSRd1g/j+AZbbk3A==
X-Received: by 2002:a05:6830:8208:b0:739:fa45:591c with SMTP id
 46e09a7af769-73a3632cecamr10191268a34.13.1750268236673; 
 Wed, 18 Jun 2025 10:37:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a285313bbsm2065136a34.45.2025.06.18.10.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 10:37:15 -0700 (PDT)
Date: Wed, 18 Jun 2025 11:37:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/6] bloblist: add blob type for DT overlay
Message-ID: <20250618173713.GH6521@bill-the-cat>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-2-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C0sA/oFJjSUFekBW"
Content-Disposition: inline
In-Reply-To: <20250618145930.2652304-2-raymond.mao@linaro.org>
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


--C0sA/oFJjSUFekBW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 07:59:23AM -0700, Raymond Mao wrote:

> Add blob type for DT overlay according to the update of Firmware
> Handoff spec[1].
>=20
> [1] https://github.com/FirmwareHandoff/firmware_handoff/pull/74
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Once merged, this should be a Link: line for tooling to better pick it
up. And I don't want to merge this here until it is merged / agreed to
in FirmwareHandoff.

> diff --git a/include/bloblist.h b/include/bloblist.h
> index f32faf78560..b40e04fe2d3 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -110,7 +110,8 @@ enum bloblist_tag_t {
>  	BLOBLISTT_ACPI_TABLES =3D 4,
>  	BLOBLISTT_TPM_EVLOG =3D 5,
>  	BLOBLISTT_TPM_CRB_BASE =3D 6,
> -	BLOBLISTT_ACPI_PP =3D 7,
> +	BLOBLISTT_FDT_OVERLAY =3D 7,
> +	BLOBLISTT_ACPI_PP =3D 8,

=2E.. sigh, so BLOBLISTT_ACPI_PP isn't something in FirmwareHandoff yet.
Was someone working on that it should it be moved down to the project
internal numbering area?

--=20
Tom

--C0sA/oFJjSUFekBW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhS+UUACgkQFHw5/5Y0
tyza5Av+JzBwOfBM2OSCEPHNsWcUVoRtP2hkICrrILXllYN8QvEDWkYHfN4qE50R
oyxKTksuY75sDOSf2wd9b3m/9JFYuA3j4a3CzEof7CPHzjIkbTDRrU04E1six/Yl
9o5FVaA4ThphxTEukCdvyxiTrNX2HOnUu9qyEXCqLojSaoyT2og88YduJgN0YOQw
TFEy8DCvuInhauYwgZ7253efuBmK3bd7lrNmLwJPxbYAnuHcOmLPbq1nzQM0StWZ
1zu+BIBrNK9GbZDnA5tHXvQD6bfmP3Z6IIMkyhiy/OKKIUgdaefI96tu3qOrMqpC
I6LetvLtHbsXsPtQA0v0GCjcLeW/q7uqGKpdn/dU0Gnv2os8ZPQ4PcXvd2lOtUGt
2xCHzr+D4ClkoGvU8Y67yr/uvXBfN7miGkyZJ7/tTGcCag1tGxI0it5irKj2Qrc/
l5ZE6GCMoXq+jOhxiSYTXBwO0+mP+FC7ZxeiDhKqmRnYNT0Fs4hNuS9hZqgWu1Ey
b39FJ/eQ
=9a61
-----END PGP SIGNATURE-----

--C0sA/oFJjSUFekBW--
