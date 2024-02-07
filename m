Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86449C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B8887D1D;
	Wed,  7 Feb 2024 16:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ukghdCjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E239A87D1E; Wed,  7 Feb 2024 16:45:19 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E229287D1D
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6860ff3951aso3722436d6.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320716; x=1707925516; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jd5EouVR78FQ0LeT/kM0uBqvccsRjle5DpRtojOFR7I=;
 b=ukghdCjZUx0jvu8Xf9BMOZAgbn2zoYT3UQ+i2B71+SwxYLdThuk05YOpkYHZDCnPQ5
 XQJFOLkbkuG/jXbpvQXMTB2wAKYgWcR3A/3XANBYdctlHbHtpKai5x39qWuluLgD1qV1
 ADrT8WnvqOitHnpSqCZISAyTOh2XFDwgD8TSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320716; x=1707925516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jd5EouVR78FQ0LeT/kM0uBqvccsRjle5DpRtojOFR7I=;
 b=TmCaZxPy4Sk+jYrOu3rxc4WRrpvVVu713qwOd1IrHDwR0L7o6SfKRlz/hq3Qfq65c8
 hpMKIFXuTkuT1tVk7q9U+AZMsdM+4mSLdxj3kcUNEHIL3khqUCM0O2x1iWThVL92Alup
 uA7+NinRcmQb/P0BxlFaDtXdDbktBABFo9cwnP1Db1oFXG1TF+u2C93vv9NRsCicPTGk
 zqY3DA3/3PcX67ElVj1dRVbz7q55m3XXwfz/c5O4G9HZ9QSCeD99EP+SlYytBBIu3po0
 vDsLrXoi6HQnqH9FXw1aQ3f8MjVFaGr5Ua9GCK+uGDbrsR4mnCzjriFZWZTLZZEXL2dX
 tGdA==
X-Gm-Message-State: AOJu0Yz+YoCi2UNwvcQ14r/vFnNb3etQLQYfDHnhF4skobOS9vPUmwQ8
 6w5SHZxdGlZz0HqBQVKiCN9HpFibZgRbPRfXDt0kItPIoGy8Q1C4QSstnZGmwug=
X-Google-Smtp-Source: AGHT+IGT9raWwhwxbBoZA04zxIP1EwLFnkudLhJhj6EKvczw9WCLPT4w7sZZxzx4M84ME7QA7uLlTQ==
X-Received: by 2002:a05:6214:caa:b0:68c:aecf:a3da with SMTP id
 s10-20020a0562140caa00b0068caecfa3damr7110686qvs.44.1707320716704; 
 Wed, 07 Feb 2024 07:45:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV+mJV5+5k/gprd/RCA2QLMy+SqM7/dE/aarPDN3P4GU0pD23SM6sCWxFdX1nm9gVbJOvag/iMM2zw=
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 es17-20020a056214193100b0068c7eb9c640sm677202qvb.137.2024.02.07.07.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:45:16 -0800 (PST)
Date: Wed, 7 Feb 2024 10:45:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 1/2] firmware: ti_sci: fix the secure_hdr in do_xfer
Message-ID: <20240207154514.GF1152441@bill-the-cat>
References: <20240130145959.879882-1-d-gole@ti.com>
 <20240130145959.879882-2-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7zCqGoyXRlZuKxoF"
Content-Disposition: inline
In-Reply-To: <20240130145959.879882-2-d-gole@ti.com>
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


--7zCqGoyXRlZuKxoF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 08:29:59PM +0530, Dhruva Gole wrote:

> The ti_sci driver in U-Boot has support for secure_msg as part of it's
> do_xfer function. This let's U-boot send secure messages during boot up.
>=20
> The protocol to send such secure messages is described as part of the
> struct ti_sci_secure_msg_hdr. As part of this, there are 2 fields for
> checksum and reserved that occupy the first 4 bytes of any secure
> message. This is called as the secure_hdr.
>=20
> As of now, the secure_hdr needs to be 0 init-ed before sending secure
> messages. However the existing code was never putting the zero-inited vars
> into the secure_buf, leading to possibility of the first 4 bytes of
> secure_buf being possibly garbage.
>=20
> Fix this by initialising the secure_hdr itself to the secure_buf
> location, thus when we make secure_hdr members 0, it automatically ensures
> the first 4 bytes of secure_buf are 0.
>=20
> Fixes: 32cd25128bd849 ("firmware: Add basic support for TI System Control=
 Interface (TI SCI)")
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--7zCqGoyXRlZuKxoF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpYoACgkQFHw5/5Y0
tyzFWwv/btnc+OU/70DKXyAfAG/h81haIFuyJFMyHTCusXK7oPr3SGE2tKaopRbx
rDbnkOWmGAumR9DxkfC0BjddYd42KM9RxXHiuLbNZN08nD1pFYUTnzLC+O5moES+
/knhlT6WaB+TblCkUDVyhmzDod6uA15QKqkOgpGHRAB9mHNevqczhDzK4kiW2DcL
u7KZE8RYUr3ytXZ9UYxUK5UelUR/ulVSueiSXvo17qNWb5xNiXg/YWdUR19GysNW
szRygV8rXlaZziznVYVy0LqXTHxM5PBgMLRiKp34wkAXMUtG+oZV71zZcYQSAojs
ALmqrkHSSwmecrH2p/G+fB+gczCxzSci2EFSuG0MwK8c3qWOUL/UUgoh5rs53+kg
zZWpGurXqCw9hzcOlUshve7cwBoRc9Zdo8IQ+x/CL0u9VKMRPmR7d8gvBWYQRI4F
0HtVEhXJehGVuDOr4F3+uVJ70sTzGfyoem6lKwozqcQMcRG1Y9/bSEmlyOTdiuDs
7vMTCmXa
=S3ms
-----END PGP SIGNATURE-----

--7zCqGoyXRlZuKxoF--
