Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD107C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2734887A9C;
	Wed,  5 Jun 2024 16:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ttIBjAnr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1156882E6; Wed,  5 Jun 2024 16:42:24 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75B228332E
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2507fa7f37aso1195862fac.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717598541; x=1718203341; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=00UlHPlXxEbLsQ294hUPCaC7iTAMDE3EwTX3r+zkZWQ=;
 b=ttIBjAnrdyrnzUhLnLr97vSgKF1WzZAihsSHquIRP9Et5yBEgarrsP7ErulV7mq2K2
 KT723b6fxbdMCd1aiBy6n9ehcbivaJTI0Z/xlFS4vMY95VXhQSFR2rXq9RRV5Ws4VPSS
 jHFJmc5EuD2b/20VE75H0N2ALr3neUlyR2vFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717598541; x=1718203341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00UlHPlXxEbLsQ294hUPCaC7iTAMDE3EwTX3r+zkZWQ=;
 b=aALPp22ZmPLhfWgWnVDpGeTsmMBXizTR33/i7ZCdKCvB4dN0zmUZoP1VZJM2Atp2jl
 qLOjwo7B7dX5cnjMlf0f5L6v230MzIWtqzFRocxAUF8JV31ocoxnoGSLnJHOv/Ay4edd
 FAQwJ15HcCb+21UxlyloSjzWGmITKHogcjIMt1ovy8tIpOvZAOxM95LYaJk12VBzsGvv
 HPwfOfuZYdTx7EIEjgaiWQiy9GOyrHnYPo5egIwwtMTtCZt3sw61ki6SzuddRwzVq9C5
 7T8gwmpEyNOLm92Pp8gl8Gg4RjUHiJ/GWwVa0Kfod5oGM5DvK2DTDL7unxfu7AQAspu/
 QLiQ==
X-Gm-Message-State: AOJu0YynglWM0KETe6FbeLxjWs1Hbp4hS6mQXWSzNR2ZdInnuj6OzuHj
 qd6lE2UyKS5WdXfRrXFGo8hpQk/anagNRYVfWdQ98X1uTiPnCki69GgHDLGxvv0=
X-Google-Smtp-Source: AGHT+IFuUXdPIytXKR7o/Or4OuNFe6+iIOjTuTbmrhEOTB7nrkyCx5yk/eKgItYUAwrSPnQvUNZJKw==
X-Received: by 2002:a05:6870:658d:b0:250:8970:4993 with SMTP id
 586e51a60fabf-2512212d41dmr3103788fac.57.1717598540935; 
 Wed, 05 Jun 2024 07:42:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25084ab57e3sm4019388fac.0.2024.06.05.07.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:42:20 -0700 (PDT)
Date: Wed, 5 Jun 2024 08:42:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH 6/9] spl: Allow ATF to work when dcache is disabled
Message-ID: <20240605144218.GQ68077@bill-the-cat>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="smoiinBv7o84hoA6"
Content-Disposition: inline
In-Reply-To: <20240605032521.1142768-7-sjg@chromium.org>
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


--smoiinBv7o84hoA6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 09:25:18PM -0600, Simon Glass wrote:

> The dcache may not be enabled in SPL. Add a check to avoid trying to
> use an undefined function.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--smoiinBv7o84hoA6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZgeUoACgkQFHw5/5Y0
tyzgdAwAozVMQUiYpZCUPzv43rr10IGi3ANPtbZ4CiU6DcXTOoS0TGD+w4G6IjJ8
WeiSFU7aQx+KTfw382lHdM17J/QYCsd0MdohsfTObSPfQFEZiZOOQXBVu3eNyfPk
/4C2x7KwTT5KJl/b+HhG5Vb4dPSYTeESezh5Z6uEVeJ6GxbQPkSFRczFsE4mywky
TQaTq5/Vp0qzp2caK8luLgEq4qvw+TVnbSnA4/98lDOL7fctvtZMyKUAf432/QdX
e/uklh9E2AKqMIY++MYk8RPXHgv5WKWhXflIlFuZ5jdqS9+j5OmT+CgsjwrK9KmU
b1Wsx9BmEHOc7ExUYQSp7PYxAe8rhbJs/CxJiDkRq/p+73Vc+pq+wqIXA8Mt4HjA
3h0NGl+28Mgt1HuZhh1nWfizAioAwBLNkWvB5cw6XKO3lvLMm7MirWwIecPMfZ9v
Mf3XAlY4stukpQm6GzRnIn/AbdqUUIMlu4xsZhm01ooBHVvK3JQch39f/Gi+uZ3t
Vf/3zkKv
=j+lk
-----END PGP SIGNATURE-----

--smoiinBv7o84hoA6--
