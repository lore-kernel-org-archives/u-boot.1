Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4437BE6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F59893AA;
	Sat, 23 Nov 2024 03:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pCBXK/M7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F724893AA; Sat, 23 Nov 2024 03:41:48 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04491891E8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-460b16d4534so17363411cf.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329705; x=1732934505; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qWdkdl8Vw2Iclued7UuZ9ZpIB1/iwdBzCegRZYKDF2k=;
 b=pCBXK/M7snrUgoDmISMVaDolLFzmQxDsaEBg4d4LCwmI41am9t5WpiQ7oQmArd2V2E
 1xiFZB+aUreWA0rdFJlF5A5igN24CEvMNtH1aNOE5uo+IJQwk3uN83UC/UOmq7dUrn5N
 CmbvYzByCU/yMOcnyeganl6r2Wfh/1mt7ROeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329705; x=1732934505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWdkdl8Vw2Iclued7UuZ9ZpIB1/iwdBzCegRZYKDF2k=;
 b=o7N62rdvQWavBqRpGA0hfNtJ+H/z8RjeNNS3K6wswl6eLOthE8c15XLpuxRCB5df/S
 1KK9V2zKtCsSKoRgvRRxphBDAGpF1QZTnClPcHNWrXjTFpjnNBoJ6JT4E+NAfGkLUKOM
 17X5zLxciWgTOV28BUX5vdvQamfq1vHe+nIj24but4R2o2CXs78NtpKPof6A5Qe3UZfk
 3CaIf0hIwkAfIR3OAW9mJKfurbVHLZmFyxJqMtbjXSDXcQ0P0UJClE3zMJ0lZ+qICdPJ
 H6Vd0PkdJFY9upu/Tw8UTuwfEngDpHodOeXuPK0dGeQGBHp/gr5eHmlB1nGU2UBEbajH
 XqtA==
X-Gm-Message-State: AOJu0YxM1//xu6yzUYx1kLWaaRXaTrZ/u4wTD5CEz0iv0LUyBguG4S+z
 84GLxYMsrOhegddOpGh/e7PgRQJ1wRytbL07y7G62kOtGkcAx3cfQqCIDX3HqlGKA6rOyqj3BJ9
 T
X-Gm-Gg: ASbGncvsGV8kNaRSCRXjBzpVHt21PfNSxy5WpxyIX115QBwleAxfLZgwL8T4mFA29A6
 7siMD736lKkPa0n7CL5bL+4/NryJoyb9CfCxnxGlsLB2C53Hm+XMo7chSWgzL+klNwAAAm9lbBj
 elyQoMSJD48OS9WnO/XoNiKPf8XwN2j+ISjMEUt7Q/ccpF227dBK6enzW4KEqp4bxf5B+Lgx6UJ
 R4WLRud86Lyf3koV/Z+MdVjvWnYPDvuwmelFBuF46wn0SVshw==
X-Google-Smtp-Source: AGHT+IFQzv9KBvUaZzO/VCcp4oKg45gzbIKDIuKL7OwNk/bqu/i0Y6KmOWbBs/Sxt/zqP7KZSV20Tw==
X-Received: by 2002:a05:6214:501d:b0:6d4:254f:1c8e with SMTP id
 6a1803df08f44-6d45112ef8emr78012696d6.37.1732329704871; 
 Fri, 22 Nov 2024 18:41:44 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b4c2fesm17186526d6.114.2024.11.22.18.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:41:43 -0800 (PST)
Date: Fri, 22 Nov 2024 20:41:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] net: lwip: wget: update help string
Message-ID: <20241123024141.GQ3600562@bill-the-cat>
References: <20241114142040.2051271-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9DLT9rZWcB+8B4KN"
Content-Disposition: inline
In-Reply-To: <20241114142040.2051271-1-jerome.forissier@linaro.org>
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


--9DLT9rZWcB+8B4KN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 03:20:40PM +0100, Jerome Forissier wrote:

> The lwIP version of wget also supports the legacy syntax. Document it in
> the help string.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--9DLT9rZWcB+8B4KN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQOUACgkQFHw5/5Y0
tyxiFQv/c2qjgOdw/aATLcrNbWkFvbpGTY1GnApmTnWGYg6bZ9a82BmfJ46AG+tZ
M4MHT9YmNzXVyvWiZmcGmRDy9JCv3wUxpccbGW/IxZ8n9rBIuw4bgVhjjcz8mUGR
uIvjFvkRH1dN9Ry61SSSzraE/NEUvjhTeQZ9Tkp78HqVd+R9b8F5B64F3V3GFOl6
0y9ZNkiNbywEWXoggXFu9WDM54JANf+Hk7p7oZgqvo8YjGL0021wOPHtQJ89dZ5M
yn1Cdk6KF7DF1SOFO7FrksUaqJuEtiHCZrDTNE9L6hN0vBDvmh//RTE7iRlOyFtC
u0tdikRuyQM47ApyM1Z2Ma04edzdkKEzS8W4+zekRDfrjGZfW39H6NxRLl8TqfT4
rFnTC1KifOQxjhBjaB1Mh0ZcEGOiGhBcvvO6MuWtWd+TnG+k7eN/bX8D867ZWDem
otedw992bxbb1hLOrDR04ZeD9bdAqmoevwolxiNqMDpzrM3/ptdh9jbTTlGIZGjr
ePszARbT
=J26O
-----END PGP SIGNATURE-----

--9DLT9rZWcB+8B4KN--
