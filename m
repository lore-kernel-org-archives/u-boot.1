Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C4BC2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB2987447;
	Wed, 15 Nov 2023 23:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hFaWGcNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C7FD87444; Wed, 15 Nov 2023 23:36:52 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C5518727A
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-77bcbc14899so7164685a.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087809; x=1700692609; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qBkdSuzffjXCcVZAajmEkA18izQ+NWb/K5Hncg46PSU=;
 b=hFaWGcNKqTBDaV2l28bqe2NC287CD6xrpEtDgE59FsDWk0a8IlLdSdD92RfdSj5cKV
 fB4uBn1pQfAwwt6ICpLo4YicYEiy6nagTmIuod4KNKF0CXwxZHERiUMkTHcEMlLZ33Qa
 Ou7K16/PFUL8G9hCdHG6d8DFX7cgYCXUTV5VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087809; x=1700692609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBkdSuzffjXCcVZAajmEkA18izQ+NWb/K5Hncg46PSU=;
 b=fh8US3xGhD3xM8ULLd+AsUPqdh4k7qfZXm3TfYJHGbKaVerNF7mhpK+mfqZJapKsf7
 O6dwLOAkFpAjTCtQyaOKqKKQ9Y6yqWm92UXD/xt93D2CtcNDN6uDtDyDhTgqYzHAlr/j
 Tdo6UoqT5bTTjOi+IaUT2p1tXQa/oCZ9TR4Mg1fIpCEanNmUbg6QnCSzrOq6RgNo8T6+
 v6s19+BsSNwBwdQ/tEGTnIn8/amLl/YPKfHsAMWX7lH+1qajvPxxzL5BS9WILQfjDarr
 6bPapTpYeYF901n/7GN1Udueq91bc0umvh+2PLSOSvOcr7sf7l0QYJWdtM+SCge8sgLg
 jhBA==
X-Gm-Message-State: AOJu0YyumKgmKGGl1uFGErwEt+DPefj4fRYUhbG+b8AgAKl6f/Xj96zo
 CYA3SZ4/81dPwaAJBsMBwoT3uw==
X-Google-Smtp-Source: AGHT+IHn9kIHydcBFA69DYSHxj0jDEyo4HeqTp6JwMCD0wC3GgPFEQR3TgvieO4uGhdY5grB+hPyYQ==
X-Received: by 2002:a05:620a:2902:b0:77a:4a87:e9b7 with SMTP id
 m2-20020a05620a290200b0077a4a87e9b7mr7619236qkp.42.1700087808941; 
 Wed, 15 Nov 2023 14:36:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a05620a12ce00b007740c0e52edsm3802626qkl.89.2023.11.15.14.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:36:48 -0800 (PST)
Date: Wed, 15 Nov 2023 17:36:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 11/29] image: Document error codes from fit_image_load()
Message-ID: <20231115223646.GS6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-12-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VVExIwdOcYTwjSrE"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-12-sjg@chromium.org>
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


--VVExIwdOcYTwjSrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:56PM -0700, Simon Glass wrote:

> Put a list of these in the function documentation so it is easier to
> decode what went wrong.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--VVExIwdOcYTwjSrE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVR/4ACgkQFHw5/5Y0
tyw8zgv/TUp4GpuWvVRsh1ho/8jdq1uJuIcXvfLXjOg2Kbppe83MFFF7mtrDL53A
GFMcGer4rbH1Xc8Le8DGMTzjnh5laldwu2jTvHczcsABXetj6zQY2oij4+vexLxy
8R+LglNsB/CvqTqkzzJNdQXCEKR21fWwWLSuzUF7oaCKvIZEUlLlAoV8OMrzMJ6x
pukJ+A7VWnfpce3TD+1hs0BOJZ0aygq0Aeo0566L55Eo2ymaYFBI7CXRpBcb9nME
eJu7rI3mC08RSvQDnFup//APpj24f5IfCVBZvSycFMPNEDJUrw/cTBhqSaFIqlCJ
WULkSLcVtUYBpFjK99KghCBspSnP+BVsqTpQ7TS5rbHvtpUKlpwY6oYmjXegQlyt
39u0NBbpGfJOptgwcI3TMWE8x5ylgHdwCPKnHuX+31C4q7vN5JW3s2djTBPJi8ba
/nt7Qqhz9IjuZXDxDjzgX11sLaJLwtznJbPxbIEBbUVMNE+sLEjTDiPIM/gI4Lkx
pm3y24z+
=Zcof
-----END PGP SIGNATURE-----

--VVExIwdOcYTwjSrE--
