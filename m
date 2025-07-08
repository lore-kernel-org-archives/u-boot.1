Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75895C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 22:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74FCC83371;
	Wed,  9 Jul 2025 00:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lCD5ssrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1527C83390; Wed,  9 Jul 2025 00:19:09 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91A3831C3
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 00:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73cdce0ee0eso345333a34.3
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752013145; x=1752617945; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vkE54BU7zbib4wlGXnNN9J4PKwvURusyj//KVhpQd7k=;
 b=lCD5ssrtX/fl4DPnKrFL6tZW6dksjPBMQqyKScqZkld0fKsGQ1Rasz6BsPYGGIoEUP
 vDEg3QfwU0vQyeUsqku3pyV6HRrTeR9jMuKB3vwvoRT0lPCP8bI6ZvomeixlJmlF4nx2
 1f6oIx1gNTPc6bmhk+yV4sJobMtlDnOhZ7MEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752013145; x=1752617945;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkE54BU7zbib4wlGXnNN9J4PKwvURusyj//KVhpQd7k=;
 b=res+1qn1Lkf1UMQFHcsHPv6nvk34ffvWymk3yscneB9SaW9Y13+SqQN2Q8DIOZ6Ptk
 eVAXPT0hTQppEM2102+PDOfPFW8ZOr8P5TEArUi2xC+ynCAtGXZ2X+tg5qv7R0YbZNFS
 xwq9OoYA0iLpnWgqaRo4MmqiI5BpYG6EiPLEwfa2RA5BARP5mgpQ80WbuG7vkjxyGUgB
 ZV7D5xjjTDlSgtOB4jxdfF8QSzyCbomTRdgeNZjscdb4u+2KSWAy0skTBmLc9kcNI9O0
 XTiUd1/oPHQFsEth67+i+pPOaQOS4kkO7MSzwq/OL1SKIcE9tUM/+iAcsuFBJTzKtNeX
 vw1A==
X-Gm-Message-State: AOJu0Yw9LgETaeVS0C0d++pGau2c6eYs0GBzFHKf3Hi/96hr9StahvIO
 SItTWOwuznWZNnok+topl3108Rw25huJJ4osLp8iuUcnQZ/DX5m2FESlS2jmACm8fIk=
X-Gm-Gg: ASbGnctpqRyOAFRKR93gOC3BWsGpGKMUgWiN3uTyYFLOqDXaTjO9+dMaegVtDXUaP81
 8GMVNePQVE/lQVdqhCFMIn/Ucc2lcQ66v2ZfLXD6C47SGY0G5LVS4UQubK33+VkNNIXeilrriBm
 AbJ6u/vaU+FNYrvTk5k6RFPqaqbUJOIqN/C73JQ3QLawlLAgU0AFntkGIt0CkaaTrMyluubnJrS
 KDn5v1bOhuLy4JoQOXaNHNFM1VoiSxYbaxSPqf6gc7cpcdRJz1au8c5+EN93UK5Z67XohCi6TkN
 hvhZ2ap5mKjKL+fGGn+faHyzFe7dVT7wZirzUuIPZzaCV1HFn9KLL2mKmPg6VW2JfhTAsDWsjHU
 wpGf8T8tEAARP8uUyJfFn
X-Google-Smtp-Source: AGHT+IG9cbIGwXoLFFUk9cNAWWeGJpI3xiZLbopCnEWlR5TzuREzFcQh3FpI1uVF3h/KTup8ylAqFg==
X-Received: by 2002:a05:6871:440f:b0:29e:766d:e969 with SMTP id
 586e51a60fabf-2fef84c7e1dmr81089fac.10.1752013145383; 
 Tue, 08 Jul 2025 15:19:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff4c088sm3133567fac.18.2025.07.08.15.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 15:19:04 -0700 (PDT)
Date: Tue, 8 Jul 2025 16:19:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] spl: add linux initrd ramdisk properties to dtb
Message-ID: <20250708221902.GA1391688@bill-the-cat>
References: <20250625210132.800789-1-agust@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M+rAIqwb+MvlXhCv"
Content-Disposition: inline
In-Reply-To: <20250625210132.800789-1-agust@denx.de>
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


--M+rAIqwb+MvlXhCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:01:32PM +0200, Anatolij Gustschin wrote:

> Currently when SPL is booting FIT images with ramdisk
> the kernel fails to find the ramdisk and panics.
>=20
> This is due to missing "linux,initrd-start/end"
> properties in the device tree. Add fixup to insert
> these properties if a ramdisk is detected in the
> FIT image.
>=20
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  common/spl/spl_fit.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Since this doesn't test with SPL_OS_BOOT it leads to ~400 byte SPL
growth and failure to link due to excess site in a lot of platforms.
Please rework this and put it through CI, thanks.

--=20
Tom

--M+rAIqwb+MvlXhCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhtmVIACgkQFHw5/5Y0
tyzXggwAhgMMjejBuovdEbFQ5WFEh0iyic9PuXm9VtjkBD0uFnN2Yod5PvI8hvcw
3t1ofwIv8HSCM6WPmaOinZ8FFVtoGDcTMvZnR6Q5bNysyhViW/tW2ho56S57WDgS
uSQtG6ccIZfdDhNZFeGR3be46G3YtB5w4e8IrzQUV+/Ub4iRZ+4iNI9DZT1av2Ww
Ttu0KbuLT2g7mO3Lp2HUO/ESNJTRWh1LKlXMJOb3Bo1rWDlSHuAEmoTpmY4pynne
WyxE1jbIYC+X3GLXxMjA4sO1iy0gO13EEDaux3uQxXyY9SXezv+tZNp2HEVhX8fY
Pd25C0w6qL61OlVCQra+aY5zZmacqd3wCmzPW+8liqRP2L/RWlI0PdWr37G4gIZ8
mbnw+ZBrh0WB37I8Dk1l04gC6uY9yKwC8q9upPq+Qa7K3R/GwYFp4RM7S60ufCCP
muSHG1x9bI7QgQc85LHo/tl0xZ3Qn98bXmrd7Gd7qmhwIZqo3M3SwkCgHaRKlfWz
c89NXLVB
=80cg
-----END PGP SIGNATURE-----

--M+rAIqwb+MvlXhCv--
