Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8382CF8843
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 14:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 530B388A4C;
	Fri,  4 Oct 2024 16:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="erKP2F3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F224988CD1; Fri,  4 Oct 2024 16:59:25 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72EFE87F19
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 16:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4581e7f31eeso17688881cf.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728053962; x=1728658762; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XF/wuD6cFivD8pHUXcyzeXvz4bn9dKHqt7fZdG+dPtM=;
 b=erKP2F3m9TGnHPZ7QAsbf9gxjvDnjev4ngtWMqoHh52wfm49vipi87b8PRlzDCvvUs
 q3lu7r+Xn2WtOXvnkeRJwtjx7PAsb+53ipMYrPYFQnn/vc3c0+AtpHqsA4et0fARC2/X
 VrqBTa0Prtdr2dcp8M0KEpjLn7/Cagjysrc4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728053962; x=1728658762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XF/wuD6cFivD8pHUXcyzeXvz4bn9dKHqt7fZdG+dPtM=;
 b=fm+dm9iJo0d7OFAsp6JAFq1AYhGB/bm/iwRHwiN9h8aLtw4fWUqZAlQYsf0FMKCsoU
 RkVl2tIuUGeQ2ht6+7tmeo5R2pBixQlYdm5rtym4P+XHoPcJhRaFKslVla0RAhcl51kM
 vzoI/aihENeBgcyVJmlCMBF7O1uBHyhx5p2pMQVOhSTHWJY/s7xQRDzDAxkeST05MbrA
 PZ4rivfLZini+q8zQF62YCcHEJEFUTjFFebwCVQugMoUz794QWQNNW0VIu5SA6AnCvvG
 25V2f+quwl11musmtnF4zZ2MK5sc41qwyDlKAYlzxdAdsk+Dw9+TrgY3fUmPVo4qbO4D
 Phww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy5K0CgBGP4q8D68kSdP6A6xQkkmjHpM4OtgIe/CjJJrSYnI5840kwxt9R6sPnsciTZHpafXY=@lists.denx.de
X-Gm-Message-State: AOJu0YzWKU/pWhbjcjjgKnx6fsw0cwOXlIxkRFiJz57Byd+Y6Kh2NUUJ
 qteTsPE7VkvYVVmqq0epOMxQnUs+Jh4BoRjkUPSHxGvX8q0un1Aez7bXFRax36k=
X-Google-Smtp-Source: AGHT+IH8NvAjWZBZs+zFmJahXMSfWqT2AArwagirbl1aZEcFtDFZZ8Jyc1x5RxyJ7wTsDH7d4PTmIQ==
X-Received: by 2002:ac8:7c55:0:b0:458:59e3:2b52 with SMTP id
 d75a77b69052e-45d9bb4956dmr46644891cf.55.1728053962305; 
 Fri, 04 Oct 2024 07:59:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92e137c8sm15624821cf.37.2024.10.04.07.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 07:59:21 -0700 (PDT)
Date: Fri, 4 Oct 2024 08:59:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 18/18] rockchip: Provided SPL control over efuse
 presence
Message-ID: <20241004145917.GA4737@bill-the-cat>
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-19-sjg@chromium.org>
 <538c3d08-4426-4981-bf78-b906a92516e8@kwiboo.se>
 <20241003222544.GY4737@bill-the-cat>
 <77265bf8-875e-47dd-92d2-30dcf1bfe73b@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xtpIi6MXZ2gLQd5q"
Content-Disposition: inline
In-Reply-To: <77265bf8-875e-47dd-92d2-30dcf1bfe73b@kwiboo.se>
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


--xtpIi6MXZ2gLQd5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 08:28:40AM +0200, Jonas Karlman wrote:
> Hi Tom,
>=20
> On 2024-10-04 00:25, Tom Rini wrote:
> > On Fri, Sep 20, 2024 at 05:08:52PM +0200, Jonas Karlman wrote:
> >> Hi Simon,
> >>
> >> On 2024-09-20 09:24, Simon Glass wrote:
> >>> This driver should not generally be present in SPL, even if misc devi=
ces
> >>> are enabled. Update the Makefile rule accordingly.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> (no changes since v1)
> >>>
> >>>  drivers/misc/Makefile | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> >>> index e53d52c47b3..ff984d7b191 100644
> >>> --- a/drivers/misc/Makefile
> >>> +++ b/drivers/misc/Makefile
> >>> @@ -68,7 +68,7 @@ obj-$(CONFIG_QFW_MMIO) +=3D qfw_mmio.o
> >>>  obj-$(CONFIG_QFW_SMBIOS) +=3D qfw_smbios.o
> >>>  obj-$(CONFIG_SANDBOX) +=3D qfw_sandbox.o
> >>>  endif
> >>> -obj-$(CONFIG_ROCKCHIP_EFUSE) +=3D rockchip-efuse.o
> >>> +obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_EFUSE) +=3D rockchip-efuse.o
> >>>  obj-$(CONFIG_ROCKCHIP_OTP) +=3D rockchip-otp.o
> >>
> >> Please also include similar change for ROCKCHIP_OTP, the EFUSE and OTP
> >> drivers provide same functionality, just for different Rockchip SoCs.
> >=20
> > This is reasonable as a clean-up I believe (and possibly post "xPL"
> > series being merged), to reduce churn.
> >=20
>=20
> I was to quick before reading this and have already sent a fix to keep
> these two drivers in sync.
>=20
> https://lore.kernel.org/r/20241004062136.491995-1-jonas@kwiboo.se/

Ah, thanks.

--=20
Tom

--xtpIi6MXZ2gLQd5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAAr4ACgkQFHw5/5Y0
tyydvgv/Qy1zvB8S5JXmC5zqdVERBHjfq3cHM+ZP4w1RXWWY3x33ji9it4Y2742L
qIY5ZPtAAkYNqgzR8vRW8MhGjlRSDEKWewdziXhgElEVTFvD8oO3b32s1GHZPQ2X
xXNeCU57ZlQTlsgv/1CpRn7DKFyczt+j/YGxZtTEQCoD/d2dkS6acBnSifTgEdJZ
36jiHeG0Y6PskWhPkjLrSo+a5MxoE3YQHii7U1Aq/yF13dxzlZ2sAJl2QDiS0ycI
uEmC0NSEAe73lS1DQX6FcX74OWbzJYjdc9bqPzAgMSVoLsj+FPKXTQ5r//2YLtPS
VcYOArouPssF7WN4Zz+k8YliU0REbXa0dvOlkvPDaRlrUrOQbZfvXt4+nhVrG7C2
gaWNAuq63bBR2d8vlz1IedHED8HfoQkQ6oFWxWMTUTkfibMlGjaTsT0sdEFq45ac
A1qWMpOxyzZZLhelTxg6zm6OmoJJS96drAPa8H+8RW2m7nYp6pKIlSPFrsxNBxo7
hZVxNx1W
=E0HR
-----END PGP SIGNATURE-----

--xtpIi6MXZ2gLQd5q--
