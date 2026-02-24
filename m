Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27AEF3C9AC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E36E83E7F;
	Tue, 24 Feb 2026 17:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ENQgYejP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF2083E13; Tue, 24 Feb 2026 17:05:32 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C322F82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4be94eeacso1080093a34.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 08:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771949129; x=1772553929; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bZgiirjCud6XfehjfjLgrrS5Eoy+9TpFMTWQB59GEvM=;
 b=ENQgYejP5T9jGum4gqakXCGKMQL/DTeSVLdYpRxqQvftERBAeCvR6SURrK3XIvFBiL
 ZpgbiLPBC7JXfuHRu0gFaqYQRPjrnLMCvYhyOaaJvT786Jup7f+K+D6KDvGERp2wQZjT
 4zhil+4GNYlOb4PmofcqMXCIQwnA+dxZepoR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771949129; x=1772553929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bZgiirjCud6XfehjfjLgrrS5Eoy+9TpFMTWQB59GEvM=;
 b=UO+z9/azrtIMwS9rxB4yFb0+WDJ23sBg2f1JwRjrKqS9Ygar2UD6d2gN3lO3ERuJH9
 bmEpmu2hO0NEvKCKgIgJTIcVrLLoWWh/iX2Yn+47ZkhcoyBaLbqS3nbr4FCpWdXyAIsg
 um6UvuVUXR3NmTzxdHJDjJkFwkA4ey8HagTNXERm1uhiR6GJR0iHyZaAHbdQslxoH0Vr
 1LjgVGK4HZTPgpIPLqrDgHnkuIZ1M0evW2IRZ/01Jqj0W3KQeKv161qKYpUkOg5HXSja
 gcTptEXIWcGIzrujl69h9eSqB24JJVTuHe96AvStzonkSC/+ED+rLL6Ov/OjjnIrRdYj
 BQkQ==
X-Gm-Message-State: AOJu0Yz+IA37kyITxjA3coxqLLQLRe9uM+vZuMywPWnvp3xBGO9saR9f
 PdUNcL8THtFVOyYcjQgfGBx7RHYFRSRGAzepMVF4dLzR1Ln3Zz/OAv9Qtd79GzW/R1HpAMuZ0pe
 2YQfDlsU=
X-Gm-Gg: AZuq6aLJsZgiEw6l+uq8SFzP9vMdGT3LAwWxHt9SHOtIO9xWMFb/3Lmfh0Cy7gz6LAU
 hIJT/4jjAbh874HmL9z2rNq3HHof35IMOYnOLkNGUdN/ytczzLHqa5Eyw+kL70D/6nyo7RUyMQ2
 3/E/Xj3non8blOJfAxq3GDpN+0WZfnhXhaFV49X9wJDofuAZaIGu4yGjiyAHffG+b/6TI80WU1I
 oKdJCWgdCXvvgAusTB3XslU7r11MX1xpbiCgoGMOp+qlcT0RnglW/QZjqWh5A1OVfjoCvAKnDih
 /hMdoDJgkv7sahT0mLFh2iFfcYBOCqQxq489/o4d4c4J3BOnO688Pu4yS0yYxEVoizk/t5tT2a0
 yOYFk2drdb4OrKN3fH8vcT85KPNJzA0Ajvtn/NHX2EEPSIdBVeMvz8qV7IEf3sEmr6gYSEU/slu
 YpOYc3wD5SGb+qr9noVH9HEcU6HerWvIOhk4pp6bsHOIiOAYWUu8LeEkLOgSzB1JB5PSRW0LBlJ
 nNHrxnB8elXKYwFmu4Wf4J44dTieIZFb3b0ib6KL9+6bGyFjs0=
X-Received: by 2002:a05:6830:81d5:b0:7c6:9d7b:b033 with SMTP id
 46e09a7af769-7d52bf9c5e8mr7705187a34.22.1771949129500; 
 Tue, 24 Feb 2026 08:05:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dae9sm10105708a34.20.2026.02.24.08.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:05:28 -0800 (PST)
Date: Tue, 24 Feb 2026 10:05:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH v2 2/9] bootm: Remove active devices in bootm_final()
Message-ID: <20260224160526.GU3233182@bill-the-cat>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
 <20260224142553.1608883-3-simon.glass@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZuWuQ2N/901OJoaV"
Content-Disposition: inline
In-Reply-To: <20260224142553.1608883-3-simon.glass@canonical.com>
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


--ZuWuQ2N/901OJoaV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:25:44AM -0700, Simon Glass wrote:

> Add a call to dm_remove_devices_active() there to ensure that active
> devices are removed.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>=20
> Changes in v2:
> - Replace 'efi: Make use of bootm_final()' with a non-EFI patch
>=20
>  boot/bootm_final.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/boot/bootm_final.c b/boot/bootm_final.c
> index 15ddbbe5e74..263cd95dcb3 100644
> --- a/boot/bootm_final.c
> +++ b/boot/bootm_final.c
> @@ -6,7 +6,9 @@
>   */
> =20
>  #include <bootm.h>
> +#include <dm/root.h>
> =20
>  void bootm_final(enum bootm_final_t flags)
>  {
> +	dm_remove_devices_active();
>  }

And lets just make the function be introduced non-empty, and document
what it's doing in the header too. In fact, this comment applies to the
first few parts of this series. Just introduce the function with the
basic and common to all functionality.

--=20
Tom

--ZuWuQ2N/901OJoaV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3MRgAKCRAr4qD1Cr/k
CtaPAP4sNvcLAys1IW+4+5Pd7d200P8Ts7KJqUd48X8jQrUCnAD+Lf+Qc60Kb+AX
VKBUFn4dd0QkKDMQ66VpGzBD35hJgg8=
=Ft00
-----END PGP SIGNATURE-----

--ZuWuQ2N/901OJoaV--
