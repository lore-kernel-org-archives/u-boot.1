Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4711EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 14:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8AA38695F;
	Mon, 21 Aug 2023 16:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uECQ5Ct7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EBB86F16; Mon, 21 Aug 2023 16:53:24 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C4586932
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 16:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58fb73e26a6so24174447b3.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692629600; x=1693234400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z3850kSuduVh9d6rAPdQ2bMSHKoeV8lXlGo0MZ+CBE0=;
 b=uECQ5Ct7fS2p1C+BJkTmqPZRQMIBBAD8VM2CR2NTH+9dZDyqRsqU7FshC3NgYbHqzC
 m0Lhe25BDuzNYH8pdhFO49bL+yFy2jw5wIYyKbokWhVhRJr2VyuhbRCUwhb8eysH4840
 BpWsaGhJnNjsTzh9tDvOrfYrkmtWQTmTWIUiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692629600; x=1693234400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3850kSuduVh9d6rAPdQ2bMSHKoeV8lXlGo0MZ+CBE0=;
 b=bF1FbPli2gG5uKt8hzMRq0qfYXoL2hKnDdhBplf4L6skGZdeiYcmsgFYHZdiiFz05h
 FqBSXs3YuRWBSwuzTLASM784vCjjSUV8ENjoA1y5EE99+EHegPt/M/aN/XcQdroWaZAV
 MLtGDulBjjCeqCoePA/LYqd4g4I2mi5H9F5+xKgP/da6AibfuEnj5IBul3ULGSZcVCPf
 HwU51SgipyJrwshNiY7bLa5XOCusl9fIN9GDfm755sekT5ZBLUD3vH1zHnvmeTbWVOAw
 +yDsKeyZY12yNqbCyBEWt9JcVNUrZ9T4dfvbr0ZHYPNivbyUnqs6bvew1pwv8cFNw9rg
 XuQA==
X-Gm-Message-State: AOJu0Yyw66CWbJkCUnrwMrRoMC+LrKbU/Zs2dnGfcV5PHdL6OMAjUvRf
 OTh1vg+NOKLAfevuo1+86RfqHA==
X-Google-Smtp-Source: AGHT+IG45G8JYM+VBifCmVgB2oaki7l47ixUJ9tOa10Rh3TInCERnRgaRZMlkk3fDqVGC8BJhgXA5w==
X-Received: by 2002:a0d:db46:0:b0:58d:7ec3:16c4 with SMTP id
 d67-20020a0ddb46000000b0058d7ec316c4mr8270036ywe.34.1692629600661; 
 Mon, 21 Aug 2023 07:53:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-49e5-7fcb-0da2-d03f.res6.spectrum.com.
 [2603:6081:7b00:6400:49e5:7fcb:da2:d03f])
 by smtp.gmail.com with ESMTPSA id
 a124-20020a818a82000000b005869ca8da8esm2235737ywg.146.2023.08.21.07.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 07:53:19 -0700 (PDT)
Date: Mon, 21 Aug 2023 10:53:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] configs: Enable CONFIG_DM_SCSI in am57xx_hs_evm_usb
Message-ID: <20230821145317.GC3953269@bill-the-cat>
References: <20230821135910.55795-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YjSZ6/1HcLwO0lKz"
Content-Disposition: inline
In-Reply-To: <20230821135910.55795-1-afd@ti.com>
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


--YjSZ6/1HcLwO0lKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 08:59:10AM -0500, Andrew Davis wrote:

> This should have already been enabled but was missed when converting the
> base platform defconfig, fix this here.
>=20
> Fixes: 3c5aa6caccab ("configs: Enable CONFIG_BLK in am57xx_evm and am57xx=
_hs_evm")
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--YjSZ6/1HcLwO0lKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTjelcACgkQFHw5/5Y0
tyyK8wv/fMNU3prswVxINAvZ5SSZkAzkNzpGm/VGhMG15I/A/bf8u4mOtxKkWiXi
65C0FRX1t+neXCawUU1JpV1tXSS0xmY4N/aSrsMeApcK99kxiPOaBGCMg2B6eqGz
usKH1wsAcFNf0Uf++lqHpPvjUNC8BzeoqQWc/z/QWJkk5GsecK9JUwfqygyrD4jp
XZFOSX12KhvHsVG0RnivTMwLbRA+5Om8pjOyFvBar+2iVbpxNpeS1RaW6cvlua0z
+f+RoiS6Ac3gHUlVYeKQcNcJtJdPSqz1k/hAkO4Z98CtdMhw8QEpj1Taz3LK3eXL
3IynB/u0WQrKYxmT0CSjYPOLflpWExZo5DrpL4kWXgyPCkZUbJJM9PGUAtGf+ly9
3uMZ+ccZKghj6KgP5VZNg92x1UWYxRm7mlOFPBOhsL+EqSR6qxzTVu8LB/7TkBrF
AQQaD0Wf+BcbInETwJhqUAQIxHjD7s2Y+5UZojz2retmZ0eCqBWQFtDWGIBDUUkz
GAayvwi+
=vjLy
-----END PGP SIGNATURE-----

--YjSZ6/1HcLwO0lKz--
