Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475FCCD4F3C
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 22:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79F288BF2;
	Thu,  5 Sep 2024 00:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YKx6hqE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31DD388B86; Thu,  5 Sep 2024 00:25:45 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 298F888BE1
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 00:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e04196b7603so208116276.0
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725488742; x=1726093542; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=snsg4hiuyuXzR635/M00o7N+gLiBq/YQt486htpYjBc=;
 b=YKx6hqE6fk4BahvpDyNYa0Yntu0VuVrTeQXIam72Hza7gzU48vioKIXZw21ORlcEcq
 80EmkHgQKXg3ulL6LWjZLvlbJ0tjYquE7KxWEnsgFzrU9wLW1gm/Uc7dkf26IGBcT0W2
 Y/DfYyvdLP2WTSqIXWBtxckaMtOe96whKEii0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725488742; x=1726093542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snsg4hiuyuXzR635/M00o7N+gLiBq/YQt486htpYjBc=;
 b=bs9x+/eEPNJMLqQvtKYaC+3Ar78IiVgGUeNct9rKAb4ctVnHBBgR7IgmDT7qb3Ov8R
 WSl4T1O4yHpWkNj/ksZXt+qXLBcNUXqs/ARW9zvOO8VK+hWRok1foL5U3l0CcpwrrQpZ
 YqlE7W6Ng8ZvqyEvW55L7yapbKanhJQhBiv+++kTWcm9uN03G8WJFOJmU3Lrq6GvmYmU
 QGRTyqrnrNtcgVaYP9ijqqqmop2MMBRBx9dBLuT+BEI9f+1RGm6f2V9N+PCqXqlrlpr6
 UuRxWg41zQDh9+4RuG7tIOja9EXUbGdXp59bV1y8fotGQAOWy/RxJ1ZPzofiC+zsl8cr
 k5pQ==
X-Gm-Message-State: AOJu0YzBKU1zraro0b5FJmgxeU9S0GrFrqnhS16wEzMC+hUHAhoQTA8n
 Er2ZPx7v2WvVdKyV/YOkKR6N6bUQ0C8J+kjDhpqfSEepM38AtXcDvOtAjcINGW8=
X-Google-Smtp-Source: AGHT+IESTwlwy7icTdwYlopMbRnfnFHpjd0oSAByeIzjCZW2QKP31P8i3okg6sZ8WMj+yZFfe+zZcA==
X-Received: by 2002:a05:6902:2b0c:b0:e16:6992:19e9 with SMTP id
 3f1490d57ef6-e1a7a018ab4mr19867864276.19.1725488741871; 
 Wed, 04 Sep 2024 15:25:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c520315581sm2493126d6.79.2024.09.04.15.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 15:25:41 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:25:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 05/19] boot: Respect the load_op in fit_image_load()
Message-ID: <20240904222538.GB2479150@bill-the-cat>
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KkTiEhN8viOetFFu"
Content-Disposition: inline
In-Reply-To: <20240829145802.1827952-6-sjg@chromium.org>
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


--KkTiEhN8viOetFFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 08:57:48AM -0600, Simon Glass wrote:

> Some code has crept in which ignores this parameter. Fix this and add a
> little debugging.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Can you please add a Fixes tag, as that will help in reviewing this too,
to ensure we aren't breaking the case that initially changed things
here, thanks.

--=20
Tom

--KkTiEhN8viOetFFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbY3mIACgkQFHw5/5Y0
tyz7AAv+PSWUXTbOGRM7E0Fv5YHlYJhP8rbsdezaqNJ5Kg8d2VPGWxeZl+gzj7+3
MdNTviJuZE3t0JQHibyWJ/CLXN3eg2n7OQ8l1stgBOntGsPIFaAjKE3W67SHlbD/
oSEryQ1Q7t/UHf33PKGBYG8rim+6V9Ie/0p1GiIUlHgWUPymiHuynkKQZI1uB4Gn
CyY/8U1NBukVOdiSCghC9LZNOiVQwPxNHKU/GwLqLdMHvzbzu/QQMJ8Mftjw6XPo
TArXB7S8gTeiq3IOmphcvAjge+ZPs53Ve7K8avzgHekr86WotepY6nDUCLapfjtx
0Uo/NccfIJkZAet4pwKzOW6kSPuvnqb5iFokXR92tO2BlhebCvJfpK367t404qJi
Z0CS5adIL/2DKyIWtb9WjurRLtjo+mEuk3tt4D8nUCMflZ5xJIMDdJBhL/Xw8oEx
n13S+O6n8DEIb9WoP7/KgXeVr1J5GvjAtUB/YZ/UqqxQg2o1CtlmqU8pkOzaCi0f
gD6ApteW
=qRhh
-----END PGP SIGNATURE-----

--KkTiEhN8viOetFFu--
