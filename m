Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374F9C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 16:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A86D187DB3;
	Sun, 25 Feb 2024 17:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UWmRwD8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E586187DEF; Sun, 25 Feb 2024 17:05:50 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB51687DB3
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 17:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6089b64f4eeso22748547b3.2
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 08:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708877147; x=1709481947; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2sVtbgcKtfibt/7SVjW/4A/Sqgi5S7zw1Kpt/1NRwyA=;
 b=UWmRwD8KVBp0QnVHAUolwUMxtGliJqZE1W0hbXjl1ien+41uDC16Zp24RgEujiPLsb
 ar0aaqavEm/Xlc2AlrbNCGf4CtBtwBNiAu3RYOqCa0EJ7oKB850F/s+58mbojEJd0UGj
 wQqAbW2YV9vFHzrH0MBzl93OCuGMroR+DZVU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708877147; x=1709481947;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sVtbgcKtfibt/7SVjW/4A/Sqgi5S7zw1Kpt/1NRwyA=;
 b=X6gRyFqwc5QW6OdKhAyOhMwUonchyb517+K770QvH9mrpSqb4ZDqjmtq+fduMFbu2E
 JQ5sqaACC6mGMA6q3HVxIJhDEOog4NBsnZHX5q3YJhGEpyCZj25NiWdzhFVUeY3E8D2u
 wOrRtC8pPbZqeJMtg97i5y3EGsFlIfEUOrRkwNvuICoL8evTV1KxnOPwF3lwpe6krb5M
 dpwKqR7T3hOXNhgRxqQyY3ZhKr60Hh0/+EBlFQSX8xjxignmuQNInQNabG6Hi4+v6i0+
 lOHNjwe4wjsy9eMZ6ErCBvYvqB1fUjK247DxkDPFSW8JNDcEuqalpHvwc13UxOUlq8cI
 pl+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFqO1Gt3g5fUFIag3BRXB0/S0KkfMwgxjLQbfqxEXOsrxTjyW1bNMMaLG+8UgiBFh2wuUaW/wEyO9riSe10/MngdRgIg==
X-Gm-Message-State: AOJu0YzPcPQtWDsMOWm6hL8IDfYacPFPbfQqlQ+O8UpP9ayxLzbqSOte
 0Lfh/Ypm5O4r9Z24yixX/5yDdwaXkW3BjC2f2WrSETVSKDJZH4IO1T+Ukgphdu/nY3XKMAZP2yh
 A
X-Google-Smtp-Source: AGHT+IGEzytIVT+KhEU1D8o4A2RHMnJNnRoFq7nycwa5bxsmEJSfQwnlTMvaysnOrXTLGB1Bpoz07Q==
X-Received: by 2002:a81:ae53:0:b0:608:a004:13f4 with SMTP id
 g19-20020a81ae53000000b00608a00413f4mr4103610ywk.47.1708877147449; 
 Sun, 25 Feb 2024 08:05:47 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 p201-20020a0de6d2000000b00608b3e03ec7sm787690ywe.90.2024.02.25.08.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 08:05:46 -0800 (PST)
Date: Sun, 25 Feb 2024 11:05:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET
 is disabled
Message-ID: <20240225160544.GG3040305@bill-the-cat>
References: <20240225152715.1821613-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eqXZCEd11rtATHfK"
Content-Disposition: inline
In-Reply-To: <20240225152715.1821613-1-jonas@kwiboo.se>
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


--eqXZCEd11rtATHfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 03:27:13PM +0000, Jonas Karlman wrote:

> Build fail with the following error when DM_USB_GADGET is enabled and
> USB_DWC3_GADGET is disabled:
>=20
>   dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
>   dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
>     undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>=20
> Build also fail with the following error when USB_GADGET_DWC2_OTG +
> DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled:
>=20
>   gadget/dwc2_udc_otg.o: in function `dm_usb_gadget_handle_interrupts':
>   gadget/dwc2_udc_otg.c:947: multiple definition of `dm_usb_gadget_handle=
_interrupts';
>     dwc3/dwc3-generic.o:dwc3/dwc3-generic.c:197: first defined here
>=20
> Fix this by checking for USB_DWC3_GADGET in addition to DM_USB_GADGET.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--eqXZCEd11rtATHfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXbZVUACgkQFHw5/5Y0
tyzDsQwAoSRO8lMR9VYQHmOAAyhPGJBgT8CDSQd3mxsVrIgV/rPFRVZa1ASpXc5G
EHpXaVuk8re2/3DLyd+jh3ASQ1LhsTIbW//DDNO8fmwnPUHLlYPaBso1uOkgIRQu
RVUI6ZN893VDDE3sV1MGqswFNwhDGAFGH+dtTITRQHFMPXQnm86hGN8uYgHRKFkn
yN18KPykH/No3csyh8aYEeE7oK6Nbsl8E3MznQXsrD0yw4EG1NdgQPqfU8CrbOh8
UqcoqzYxj9MZ8AQRxq8+LAppiG/6DxKEiIQBSr7idXLWvVWB/HIMiWgnlSTpC0Ki
b9FQM3/Il9NNTFJMBGOGU/aAgF+EABbciZoac3QwWuM+sKdWkbJZ3K8WQiuUA7X3
gc6u0NwqkzCjWunHgxHMmDDatApfRz9GG0aVIoAhquOnSpCLN4+RWt2jMPyz4RT8
LO64oKxUJKXgX7qsxKfEc4R5SDjZJXlBi4DgwN4tENJDyLZ6dCqtC4LDPHkBHeF8
zn7tU7UC
=zfFc
-----END PGP SIGNATURE-----

--eqXZCEd11rtATHfK--
