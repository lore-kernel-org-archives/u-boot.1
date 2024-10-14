Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF65D1813B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44C188FAF;
	Mon, 14 Oct 2024 20:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="otGjunyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D943788FAF; Mon, 14 Oct 2024 20:23:45 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1CBA88CA1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbd005d0f9so44374266d6.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728930222; x=1729535022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6/NCrlSaRbu8kEwqMKvjEwARWdLP+pas3YxKZg4scxA=;
 b=otGjunyGC8WR939VU5Jij8hvQ0L/HLWv3le/QPtYcpQQhjQPAmrgxr+xkrwdfy31mQ
 YrOX18wf0jGhAtylhsv2NB3A6K9cOKil/uTIciPo5DckEh5Em2zrPYR7EZirB+jR+Hcs
 ygAJYmgFSUOJ4jDc5g93gxzLtFRHt0gon4l64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728930222; x=1729535022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/NCrlSaRbu8kEwqMKvjEwARWdLP+pas3YxKZg4scxA=;
 b=t7igII/i5FzIAKqE33SkD4rOar5kbNkEjAOPtIPnsujqTkcy81uXy1c4/U9JZST0Qh
 SOHJ+NJzY0+1tcwvlKsA+l8yZtyU26r7mfcKmOKwJXsD65/N+VJQbwfzBEzXHCf+vTnq
 6z+0169lvRlPOvOIau5cG0vPg4DAVYHo4WI1ybOK+DswHuAPf8XUZCU6RGt6ufcv2akM
 yIEq4ZkpbnBD2lPeXJ4h4z1h2/B7S57XirR6f3JmrGNWMeFEMEluRIHuTxIqjeQ0NYar
 dxPJLFN6xDNebtbdy/pxhjEmOq8/tKIQrX5BFwUj29t2oiwj5rcYi7pndPm1RokQyEz0
 ZbeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD3sOwQHIiuGkWqSZ8vycA+KeYYY4Wcfa7VLTBAUZQRzfEEGj3KtAY6q6PG6e9oJTlhGxn238=@lists.denx.de
X-Gm-Message-State: AOJu0YzmHTuCvDsPj2ZyfqFdiAmxBc6A8zto5XzHdGg0+s7nQY3o643N
 3DZe255ULEY0uqvGJvUnrMQvCph3D+Nv5d8CU5aSIpF7ilclXY+xYS88bcSNo6I=
X-Google-Smtp-Source: AGHT+IEou054ryJaohKRddj+5+o+HP983byJ1TEqaaVsW6YxMcdtB/HyKpbPMYTZQdClqmu6skancA==
X-Received: by 2002:a05:6214:43c3:b0:6cc:1c6c:db92 with SMTP id
 6a1803df08f44-6cc1c6cdbe1mr22714656d6.47.1728930222553; 
 Mon, 14 Oct 2024 11:23:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc01327906sm25368196d6.21.2024.10.14.11.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 11:23:42 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:23:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: mkorpershoek@baylibre.com, nm@ti.com, n-francis@ti.com, a-limaye@ti.com,
 seanga2@gmail.com, sjg@chromium.org, marex@denx.de,
 john@phrozen.org, ansuelsmth@gmail.com, sumit.garg@linaro.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 Oliver.Gaskell@analog.com, robert.marko@sartura.hr,
 semen.protsenko@linaro.org, u-boot@lists.denx.de, vigneshr@ti.com,
 srk@ti.com
Subject: Re: [PATCH v3 1/2] pci: Add TI K3 Cadence PCIe Controller
Message-ID: <20241014182338.GS53053@bill-the-cat>
References: <20241014053924.4027491-1-s-vadapalli@ti.com>
 <20241014053924.4027491-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yIg5iXdHyaTTXuV+"
Content-Disposition: inline
In-Reply-To: <20241014053924.4027491-2-s-vadapalli@ti.com>
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


--yIg5iXdHyaTTXuV+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:09:23AM +0530, Siddharth Vadapalli wrote:

> Add support for the Cadence PCIe Controller present on TI's K3 SoCs.
> This driver is an adaptation of the Linux driver.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--yIg5iXdHyaTTXuV+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNYaoACgkQFHw5/5Y0
tyz5YQwApMVG+y3UturUHRk+NqcBwEuozAI+ts3SdmJNavqrhiTwyYl4IC8Ws7Oh
yBEf1p+c/BDjALqNG4VXvgYyAwca3MfRBZcIzlv8JpK/OI7b/b4Pmz2p+N9lMjFc
qGFBkRrFlXFUhO2nOdv2XQj1FvN5OFqXPm+Z8LCNHfImd5GX4NizI3Y738vY2EN4
XZssJ6po/LYGcrcziyJosKeS+4ReqolQSHwUKpO/5rWvfI2fC/dXalEqxA2Lv1EW
BgSbEHlLnzmRXNmpStxkSP0fEgYOfLxfQefPreWgXOA9/EIf0EJgn337dpSP8fXl
cozQaF4/lwcA05y4sG0ZAnCTidSYfZKjIXdxHqVZtngM5sMwERBIuB2mpBrF0Dmh
JTOuwZT+9kUqSbdm9137kDBB+GVOnr1b9d3+B48zAfosbZ7xr9W3BU8hu8aZ1Axf
iF4xTPTtdqytgd3R4tL6d+prC5Y/OszZzWuK3dRuKdDqF2QEjMBLyxmCZ3OWZjpE
4JQr0J54
=QnFC
-----END PGP SIGNATURE-----

--yIg5iXdHyaTTXuV+--
