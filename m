Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23ACC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 01:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F41B8800CF;
	Tue, 21 Jan 2025 02:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jqpf7/tZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFEF4801CF; Tue, 21 Jan 2025 02:05:55 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 286EC800C2
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 02:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6c3629816so268114385a.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 17:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737421552; x=1738026352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cGz5jTsO+0QZ2U6HfQqXKtRQYuP+xAZb2WvrmaGRUr0=;
 b=jqpf7/tZZh1mqxH+TRnP444c+9HvVoSvEQ5jhJgGtX7j2Lr4qeJNSRLmVTrY1jDasA
 Ltl3ZVrULlEC9kzUKHNglILdPNOR1HRWnBNr83GyLkVtRa/x3j7DwHE1VZ+t3n176adf
 8RUEzu2gW5K5b0QvjVLC3BouPGcLhylzpOKlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737421552; x=1738026352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGz5jTsO+0QZ2U6HfQqXKtRQYuP+xAZb2WvrmaGRUr0=;
 b=EWaYxPL0RikdiD/EV4PPvHnx51i4TpqA3YAPSvAuVMS0jrIVBJ6XMyFUWRX74C3E7c
 XEGzXYy0ec6iZLMqVdJfA17WY72MKNph26TTX8QkZRqu94EgCTHdKKG//bGyz+kFXmSc
 9UfMzLtLwJ1j9JJ5Bpk3G4rJcA2JoKVdwnQqDRrX3eDi7JbOx9y2tbmmPYj1bjk7FH1A
 SeKsgLQvZcxUsiD6Ty8Ql7quPXwnDgHYXHDYBBmgHq8ZzJhpjns2Fc4BxSFsjrN8iZix
 TVi2zCLBA/Zp32R6Oo0wCny4KS/XEkLVPba2ZQ2ar8lJdz/qDz/o9cbz9oe9kNEFcx16
 x+Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKyCPiQpJ01PkbFE+btz5gorNiVPx9roDJ9JeKpluJK2uBCygeSf7+nV4elonXsyofWhzbt8c=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+z0IBCzLrJCWOIAgBRsSUz96P6QcBX5ISeuUWL99oSgsweJF/
 FaILA81M/dV76Ydp8MPSap3hqDOpwRu3Oc27ztP3YdHjAurRfQbq7wsoqHst73A=
X-Gm-Gg: ASbGncs3Ys3XLCxqUfKveGnNSDLPJrEI7MOMsDZDzEqdoYptEWzVEkMVIcAeVGI19ez
 WFjOwxdseSTwwPGV5ehJs8QguC6gHM7Um0qwq+/CjtQ+HdzceFPa6TmiW9Fs5xRObehx0jqGbXE
 MO3fsK/kb00U/JYOfWsI036r/fSJdU0hhXzY9afqIHHunZz1HLMaIhPcw6SCCHL3GC1wDIXsBKt
 r2Gd0P7VGRJtE2tesbUFCvwNMKIMAj5cOJdFAVbpjqALda/fGTu9I1lMSpeT7M6mWk=
X-Google-Smtp-Source: AGHT+IFqzUIGx7m64prNMg3ZOBrHZqv6lUHGhP84+ZXKOOkO2Nt6FBHn4v/DZyWqxq3wepp7SiCdmQ==
X-Received: by 2002:a05:620a:2551:b0:7b6:cb07:24bc with SMTP id
 af79cd13be357-7be63251a00mr2892592685a.48.1737421552056; 
 Mon, 20 Jan 2025 17:05:52 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614ef236sm503516185a.108.2025.01.20.17.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 17:05:50 -0800 (PST)
Date: Mon, 20 Jan 2025 19:05:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] net: use strnstr() for lwip_strnstr()
Message-ID: <20250121010547.GA2881802@bill-the-cat>
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
 <20250103232118.711135-4-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+4C0QZNmxjfpsgWV"
Content-Disposition: inline
In-Reply-To: <20250103232118.711135-4-heinrich.schuchardt@canonical.com>
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


--+4C0QZNmxjfpsgWV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 04, 2025 at 12:21:18AM +0100, Heinrich Schuchardt wrote:

> Using strstr() instead of strnstr() creates a security concern.
>=20
> Fixes: 1c41a7afaa15 ("net: lwip: build lwIP")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  lib/lwip/u-boot/arch/cc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
> index de138846358..6104c296f6f 100644
> --- a/lib/lwip/u-boot/arch/cc.h
> +++ b/lib/lwip/u-boot/arch/cc.h
> @@ -34,7 +34,7 @@
>  	       x, __LINE__, __FILE__); } while (0)
> =20
>  #define atoi(str) (int)dectoul(str, NULL)
> -#define lwip_strnstr(a, b, c)  strstr(a, b)
> +#define lwip_strnstr(a, b, c)  strnstr(a, b, c)
> =20
>  #define LWIP_ERR_T int
>  #define LWIP_CONST_CAST(target_type, val) ((target_type)((uintptr_t)val))

This leads to:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10370&view=3Dl=
ogs&j=3D45c0c132-56cd-504a-56c7-1b8a534aa92b&t=3Df95d3367-9db2-5f2a-d3ed-89=
01d714dd66
as a failure, that I only end up seeing in Azure (I didn't track down if
there's some good reason we don't see this in Gitlab).

--=20
Tom

--+4C0QZNmxjfpsgWV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeO8ucACgkQFHw5/5Y0
tyzLKgv+N8tyOTvavSle5d3xGFVMSY84iT62ID7eXa/ZjFwlKMPOvOLJ4PcU1ej/
MI3hcdLsQIrBYzcgPKVAPJG9AOG/ZCTlCSVm5Vx2Ex/MIY84Rz4R4Uk/vpJ+dP7k
x4vXdCdcnDyB1MTb6uEqUtCNkR2IfkLLayQl4K6N2JcVHnaFf7wjoFI8nxiidoZi
lLthcikckUpRQoPa9jss9fo0jPFyT9uPrlbHlfpnigcLPHLgBHuz/GS9JWb83Cvt
BNMqHAthwokE3t9nWx5TN7aCIyeSvURv6pWFWQjgfeSTMPW2mQ1MlUGb1ApwbEmI
mrozgWoQcNwvc8eqvfa0aDIvECk8WS+kmNPlF4aS7XjmArY93KW5zcaQPN45AbG8
5g+ZhivdI+vs5wt6V0awCLIu+78iDyv+7L6TngYr6QNx4WSN1rcslDxBBjaWJ0W8
Su2tMlm6lOCHTdfIsM4qDmCdqfGu5XSlduKeP9A36mn1m1cq1O33sM1hJgH0Mtad
I2wl4jQI
=/8eh
-----END PGP SIGNATURE-----

--+4C0QZNmxjfpsgWV--
