Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489F0C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 17:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A08C82B18;
	Wed, 18 Jun 2025 19:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fNiksVL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0855582BCD; Wed, 18 Jun 2025 19:40:18 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA9C082B0F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 19:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40905ae04e4so2041452b6e.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750268414; x=1750873214; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=13a26GiaR1GRAfo7pC7QTRKhNAumEWUvcf4MQ9jXjwg=;
 b=fNiksVL03g8qAEAGI51KMj/6RqgF81eoQQzfK0HidN70FVWZMlF2ifijlzX9IuWDHs
 qzpup1hMFziKFEQVxdnHO30ISw2bQfNUJtgysXQ/VveA9TlXdZ85hf0I/hfTMYFD/HW+
 S2l/SL67M6tZ0tHbHvItKXxx3HtY4WaB5McmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750268414; x=1750873214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13a26GiaR1GRAfo7pC7QTRKhNAumEWUvcf4MQ9jXjwg=;
 b=ieFEYrkGd7Z09aGytYM1jhtSLtTSD1sky6dL7lGsDCEL/RacxDf7y/RTEVwjZ6DHbD
 Rp1tJMeeYxqsKI5YejXcSVTCvbLzrO74NtEw0HxW8O34Xz5EETU4zojmtgamP9m1l965
 kaDPFj9cEsos4xCqmjFE+7IhB8uw2uY76FopWngMRqrOgt4DWHt0M9GWXJQKsWlPlVrS
 gDLT83i52zxrGn/c7zhxKzOrhO0ImT7aZG4BHY7XaUAun/bcAP8xEKhpICjEo5OI36fl
 820kl4i5c125x72Oew6aLGZ9fxushdNscCvYoY0TJNhN1PP38knJQfP5f1kY72n0Ubjz
 6wEQ==
X-Gm-Message-State: AOJu0Yz2GiGCABBVKas+0CsFmbA8NGmUyI51UGR4sr9c/qN47wuzYwtk
 pNGHsDtgwi81PbbD5KKwEX7PuZ16CDxDz1bolC37HQGMFmzz+tJdV302xq61SFgM8u4=
X-Gm-Gg: ASbGncsEgxRlX0O6uPeQdFPcwzRM/7w4LNcFw+otZ1AlUd5ZmNs7OTCE3nBVFTFbdM5
 3kccNgDemZfLRROPVMcsBA7q9DRpfqrVOprIQDffesYgW+IicQEXwfFz0heDWh0cVoy4ncN9cn6
 5CHqRpp/MfaZ0YyOUXism7WKtbHczR4xFIHrkZT8KdUNV3RAzI92J39xZk53sbWEUw5Uv0GtN3M
 F9gR/IF8ZJ8AGa2lHmL/+EbWFZIJHZVduzHq+FbZOfCQ2qvsjCsHzDMEOM6M+OZ/L2zAFEkkxP8
 /JBqtJEzgpLO7FyaChVSXLG2l06xUn6mYz6nbnZd2FXi4yyUsbQfhm4ciwIsL7MnrNN2FS7gJiP
 MznHxQjmNq9S2kaKiSnS5YbnElVVqXxlgJg==
X-Google-Smtp-Source: AGHT+IHNuapaxxGaQ2lOIeO6zfTZpyKeoLP62zsU7MgNNjm6L8vg8AwknvQ0EXMhtosOmpG0ihf0yA==
X-Received: by 2002:a05:6820:809:b0:605:f34d:7e00 with SMTP id
 006d021491bc7-61110ed95b6mr10897873eaf.7.1750268414551; 
 Wed, 18 Jun 2025 10:40:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a4fb46457sm1139189a34.62.2025.06.18.10.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 10:40:13 -0700 (PDT)
Date: Wed, 18 Jun 2025 11:40:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>, Harrison Mutai <harrison.mutai@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 4/6] bloblist: expose 'expand_by' as an output argument
Message-ID: <20250618174011.GI6521@bill-the-cat>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-5-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/2YZqXhObREdW05T"
Content-Disposition: inline
In-Reply-To: <20250618145930.2652304-5-raymond.mao@linaro.org>
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


--/2YZqXhObREdW05T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 07:59:26AM -0700, Raymond Mao wrote:

> Some advanced usecases of bloblist needs to know the actual bytes
> expanded or shrunk after blob resizing.
> For example, to support applying DT overlay from bloblist, firstly
> the FDT blob needs to be resized for potential size increasing after
> applying overlay. If the DT overlay blob is one of the following blobs
> of the FDT, its address will be shifted after FDT blob resizing.
> Thus, returning 'expand_by' helps the caller to get the shifted data
> pointer when it comes to get the overlay for applying.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
[snip]
> @@ -337,6 +338,7 @@ void *bloblist_ensure(uint tag, int size);
>   */
>  int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp);
> =20
> +#if CONFIG_IS_ENABLED(BLOBLIST)
>  /**
>   * bloblist_resize() - resize a blob
>   *
> @@ -345,10 +347,17 @@ int bloblist_ensure_size_ret(uint tag, int *sizep, =
void **blobp);
>   *
>   * @tag:	Tag to add (enum bloblist_tag_t)
>   * @new_size:	New size of the blob (>0 to expand, <0 to contract)
> + * @expand_by:	Number of bytes actually expanded by (-ve to contract)
>   * Return: 0 if OK, -ENOSPC if the bloblist does not have enough space, =
-ENOENT
>   * if the tag is not found
>   */
> -int bloblist_resize(uint tag, int new_size);
> +int bloblist_resize(uint tag, int new_size, int *expand_by);
> +#else
> +static inline int bloblist_resize(uint tag, int new_size, int *expand_by)
> +{
> +	return -EPERM;
> +}
> +#endif

Do we really need to be doing this if/else in the header? What's failing
otherwise, and can we not guard that with:
if (IS_ENABLED(CONFIG_BLOBLIST)) {
  ..
}
in the code?

--=20
Tom

--/2YZqXhObREdW05T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhS+fsACgkQFHw5/5Y0
tyxi8wv+MACrwbmnGlYVnVuS/MeBjX42oCTHP6G7gH8KGh7AtykI99MWcJjCM07f
N6UM6lcrfeDAvP8OrDeO1YqGk5UEU0NcZ0gkKJuTELXz1qQjSDLw1PmECd69JZ6i
4Y4ZTkqnieDqlDT9vAeVbardgy0l4SSs9qixEe0b3lrFL/SHl4G3FCELjxEvrzZK
I7xhJdt+2dFkXbzXIHAX2pv1GIL2liqF4HKyINtYzWSfXiS6gY0epMQAcV5wiV15
WtE82PVC/VSs44sjiukMumJREfbUp2R39pEqXO7SWLvUzD/Sqxom1C70+GpoxZR6
swGEtEzrJti9S1i8Mc4xv2P5/NQTxzA9YWlwjNf/LUJmaXTv1OwJNfwl1+IFFJad
D9qVgWPc9CexxHkVnmvWW//Px2q5B+3vjjoMkuDMW10vq6Bj4yVObUADgw81WLVJ
pTtLEcR0/MyBFLfS7VlobVr7wqFm8i7/5FYe7dvUJOXUa+kSXUnfgpE81z8hTia1
7zAqHWcz
=zmgn
-----END PGP SIGNATURE-----

--/2YZqXhObREdW05T--
