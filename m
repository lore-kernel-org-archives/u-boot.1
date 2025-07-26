Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51B2C83F17
	for <u-boot@archiver.kernel.org>; Sat, 26 Jul 2025 15:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA6A98309D;
	Sat, 26 Jul 2025 17:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PdjNmhqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83EB8309E; Sat, 26 Jul 2025 17:45:23 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54CB88309A
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 17:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73e5e3c6a37so1925757a34.0
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753544720; x=1754149520; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OYegFIV+hcTEOTjyqxVr2N/CrxjXV/FjN3uTKRlttJk=;
 b=PdjNmhqm1kXwLCM2/uGiJH7VujyEiymtN48OofDOyicsEz9jSxidx86jbSo+cOa0Vi
 gecvnu7gdeU+85l9QyzZvI3BULVIum2aZLcH7wTObkCcQBDJ1d8vsHtNUcBwkjNUhgf/
 LY/6HZoyS63PmRiZgkIIQVARSmWW22yzQSEKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753544720; x=1754149520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYegFIV+hcTEOTjyqxVr2N/CrxjXV/FjN3uTKRlttJk=;
 b=Ii9Qfp6WYxZUO8+bU+Wbgk1OqO0KBCd+g9HI1BaJC6NlpfYYqcKjNC9DYEV7+DyaDe
 x+1h4H/wObA+0sIHFHql6wY6VpESUyxnQ8U1jGLtcmXQ/wojxEeP+PrVLlN+b7citPLH
 yTkOJZWRNBzkcviK2/yj99BgtluvrBhEo9Y9X3QsJRB7oFFVvJfMDPx5uIYMtch5Y4w9
 RCcadY7IfyUAv4r/rBJnHK1CMcCvVvLDQtKlLgy7ZjdmFpSD58sMeW8jkxLawExrxvhT
 /3IIbw1jC8iLWmfPwyoJkEbEcpn5wYnylG6M367HAw+pTb8I0xNen2O2rf6WG+dxaYFS
 iwtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0aEeP3Bx+wUQ+/DqDX5PbZdG+h0WaOmjB9LeCBKzmed/X7kXId07EUfAh7iuTI3tk4wifHf8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz44cLzQZadp5JrtrRU0552VPy+vQJ8TcOVyDsJU0drMwF6f0gO
 z7OrisLDN2eMtGM5xHM3Lp5nAAVdTSaCQ9sISQ+fMrNrpAPDKFLNnmcUEVE/boZm1uc=
X-Gm-Gg: ASbGnct1WV4hUEW+d7e6+OagfgdouRfsa53IJb8z4449bxC0LiqYYTuKdkKHw8aaVN0
 r117AGr0/d0KibXI9yZfgfHHgVcViVxrYB9ogLyv3t9OcCGkLiaRk8srmlC16gLRpazir8/yW3j
 P9ICWcr9Ez+UvL9gUf/IGwHdwVY6lQJqt5SY2Xs5iA+AbloCDDRiLBDPNIAj0HNUKGsBOnf4pjo
 lc3plmNOJ0YdYoSl+BQwmY3/TZ2pieGW9H6db8QwZqTqjZ0icit1SCehNgXU6JavKCcoAG3bssP
 IZQvmIPrItv8Ypc2Pk3JReIVTLUpR82nGdJ+z/jnpsp9UE61YmXkLKFwgEGNh3DRWmPpp3V3uek
 k5PAdJ52j/+7dk5yxFZ9SkbZ1kyxnPmngYGyDFkjdeniuID4c76zHFRJd
X-Google-Smtp-Source: AGHT+IE7wdnwN92xLCvFy58ezYVAMOS6qSfCEzupnQ/rVr0XnkMY1ANgBnecFtsuxx2WZAU5ek6Pew==
X-Received: by 2002:a05:6830:719a:b0:73e:a0fd:ac6d with SMTP id
 46e09a7af769-7413dd7937cmr4062031a34.9.1753544720039; 
 Sat, 26 Jul 2025 08:45:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74148271a53sm368909a34.54.2025.07.26.08.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Jul 2025 08:45:18 -0700 (PDT)
Date: Sat, 26 Jul 2025 09:45:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] efi_loader: Add support for .wic files in URI boot path
Message-ID: <20250726154516.GG1807455@bill-the-cat>
References: <20250725173534.247188-1-javier.tia@linaro.org>
 <46A97A81-B04A-4BCC-A5EF-2639593DD86F@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qIEYfP5jfvmbPTQG"
Content-Disposition: inline
In-Reply-To: <46A97A81-B04A-4BCC-A5EF-2639593DD86F@gmx.de>
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


--qIEYfP5jfvmbPTQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 07:56:39PM +0200, Heinrich Schuchardt wrote:
> Am 25. Juli 2025 19:35:33 MESZ schrieb Javier Tia <javier.tia@linaro.org>:
> >Together with current '.iso' and '.img', the try_load_from_uri_path
> >function now allows files with the '.wic' extension as viable bootable
> >images.
>=20
> Why wouldn't you simply name your files *.img?

The answer has been lost to time at this point, since output has been
".wic" for over a decade now.

> Shouldn't we get away from the DOS age routine of relying on filename ext=
ensions?
>=20
> Just check if the fileheader is a PE header or if it is a known partitoni=
ng scheme.

Looking in to a cleaner more general solution is worthwhile, I agree.

--=20
Tom

--qIEYfP5jfvmbPTQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIT4CAAKCRAr4qD1Cr/k
CsvzAQD37ORbi0iH20cqq2XxcX2qyCIBO5IVKiAgX3B5dc8GJAD+Je5/fXFcvAfT
ANL8TWIP2qC2fmWMks8gW2uaEI9UYwA=
=BfFs
-----END PGP SIGNATURE-----

--qIEYfP5jfvmbPTQG--
