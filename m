Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DAFC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B66F8144A;
	Mon, 28 Apr 2025 19:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YenEaQiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B8581E0F; Mon, 28 Apr 2025 19:24:45 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C31F80FDA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 19:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c173211feso1329438a34.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745861082; x=1746465882; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GMAFJ9cvR+ATmX6OS6HjUIWU/cwPzatpYlSoyOwPV7M=;
 b=YenEaQizZXuqP+32CXSGIgqKWaManm2FMBFMZ9xD32E17kqzc6uabwESgbgawnzNEl
 Sj5jdBGfXoButg6dtSRDORfxeaWydyAoLh3+RvxNo1IR0+pbbBQFl9gbtM4Uf0gjs+x9
 CKujsMHOnlyKtH3dmirDDDYDl9NBatZkjsRNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745861082; x=1746465882;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMAFJ9cvR+ATmX6OS6HjUIWU/cwPzatpYlSoyOwPV7M=;
 b=kAWJkb78Hgfd5C98Rv3jTRaWEDe2GMXSusIg9evWMhiBjBzuLLKhxSVmLoA09d/gcr
 jSOTlFfzRsfuiQNB7tZMRncPDZ4XHlljvqjZwYKH1ogQH++lCi2UW8YSaGOi8wKGGNve
 kI1M6nOnvG2CCTMw7vVZvois21hNf0NvogOaQI23Iq/ZafutaE9Ch7DkbWe3AKoj5n7K
 R/UlkTbKwYJ2QRcLZ4Y8JqcIphlKcv1LFzbcWlO+/z20TaIEkfmujtxKZ+bM+qpvxVXY
 0iF3698RgIw4MajERwaoFqnNDdO0l9Hd1Svsov+Cdojp2nSCtt20tgYB6uRhyV76m5/U
 FWBw==
X-Gm-Message-State: AOJu0YzPBF8q1KI1TCK7RA+/LyelsW7ADZOWMnK163D5VgfB9bkSXP2D
 cWjMH5jqr1yarG3pJ9Ajq9irFF0dc6P4Q/VWY+cXcZorTor9YERmdNdFDVlHFHc=
X-Gm-Gg: ASbGncsl4Hqu0QVTOL3W8KPWsm+It9+y4F5cZ3FPFps/svuosIFzYNveK5bqyNVTIzN
 3NNc9hRHfWzhLtT4w9ZSikW65I2CvhD+72Km+GBVcrJZgcbI/PdGDMOAbY8muckm4sumpEqH597
 R1TCfJZLW5H8wMcu4Xx2FU5SOPxEH52m0ch6hdjw8w91r5h5qhZHLgAydxDbidq5WeU2BTRKVaw
 d/PJ6y+smmglgcSrbXY85FLc4JFQtbodpp58AETeQYHyB8axkXrM3UjI7HRJz6Yszm5wyQmXuNv
 n+FaXGVPTXxV4eb6HoZbaBZHTbIKChZQYf/vGuF7sbgUsY1UqWdu0Up5dcoy0elp7fmwnr35heH
 tPA==
X-Google-Smtp-Source: AGHT+IE3LTf/4qIYW2jE2U+tKvMSgOCm9UT1Vkf4i287qCz1MSpKMaJGsDI5Odi9qkFBgkgX5gezJw==
X-Received: by 2002:a05:6830:d1b:b0:72b:9e3b:82bc with SMTP id
 46e09a7af769-7306519bfbfmr6366178a34.11.1745861082272; 
 Mon, 28 Apr 2025 10:24:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f37d404sm1853847a34.46.2025.04.28.10.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 10:24:41 -0700 (PDT)
Date: Mon, 28 Apr 2025 11:24:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <jj251510319013@gmail.com>
Cc: u-boot@lists.denx.de, aristo.chen@canonical.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 mkorpershoek@kernel.org, Zone.Niuzh@hotmail.com
Subject: Re: [PATCH] bootm: improve error message when gzip decompression
 buffer is too small
Message-ID: <20250428172439.GD5495@bill-the-cat>
References: <20250428060757.125596-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ETH6SEU0ez6wZIsi"
Content-Disposition: inline
In-Reply-To: <20250428060757.125596-1-aristo.chen@canonical.com>
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


--ETH6SEU0ez6wZIsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 02:07:57PM +0800, Aristo Chen wrote:

> Currently, when decompressing a gzip-compressed image during bootm, a
> generic error such as "inflate() returned -5" is shown when the buffer is
> too small. However, it is not immediately clear that this is caused by
> CONFIG_SYS_BOOTM_LEN being too small.
>=20
> This patch improves error handling by:
> - Detecting Z_BUF_ERROR (-5) returned from the inflate() call
> - Suggesting the user to increase CONFIG_SYS_BOOTM_LEN when applicable
> - Preserving the original return code from zunzip() instead of overwriting
>   it with -1
>=20
> By providing clearer hints when decompression fails due to insufficient
> buffer size, this change helps users diagnose and fix boot failures more
> easily.
>=20
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

I like the concept but:

> @@ -573,12 +574,26 @@ static int handle_decomp_error(int comp_type, size_=
t uncomp_size,
>  			       size_t buf_size, int ret)
>  {
>  	const char *name =3D genimg_get_comp_name(comp_type);
> +	bool likely_buf_too_small =3D false;
> =20
>  	/* ENOSYS means unimplemented compression type, don't reset. */
>  	if (ret =3D=3D -ENOSYS)
>  		return BOOTM_ERR_UNIMPLEMENTED;
> =20
> +	switch (comp_type) {
> +	case IH_COMP_GZIP:
> +		if (ret =3D=3D Z_BUF_ERROR) /* -5 */
> +			likely_buf_too_small =3D true;
> +		break;
> +	// Add more if necessary
> +	default:
> +		break;
> +	}
> +
>  	if (uncomp_size >=3D buf_size)
> +		likely_buf_too_small =3D true;
> +
> +	if (likely_buf_too_small)
>  		printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
>  	else
>  		printf("%s: uncompress error %d\n", name, ret);

This is a lot of code, why not just:
if (comp_type =3D=3D IH_COMP_GZIP && ret =3D=3D Z_BUF_ERROR)
  printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");

And we can expand the tests for other algorithms either later or in
follow-up. Thanks!

--=20
Tom

--ETH6SEU0ez6wZIsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgPucsACgkQFHw5/5Y0
tyz1AAv9FGenn6T2tgY6vHU5FxavmZ18of+dgP/fbCa7Z2bIxkGAbHCdIzZ4ErDj
3Uwjr9uZJ8zMNmW4uUuQtJUX4DycXNZQX7FAeMguZlsk9dAGhj5LQcuLNPtTqa2T
RKTB3+czczHCkaLk0Ep5PVGL8ts7wvTOXFUBU8FigpwJcjGV5LpMjoNeyEKxr7GC
ngcRe10SK9PhC2drj2o2Ka3an/3gxSfbtGLY5Ynd8zxzCVKfbRLVbaHbhxETYA/h
nSn/UasVnQ5uTTJAl0IVYiKtUKrsU0I91wbY53nCrzcd0k20Ql5t9eiexvZm1hsy
QUuqs0U+oWb3Yskf1z8Vt3RQISxCSuXb0VRlVw1dcxPVtBmIaC/OzD8uaIG9bD23
KZpRQUlMy5L+FPfcKeLjhDCsJpF3lp1DjpmfBSJQthMRtTsQlExthQTe60P8VFPx
tFFEPnoO1ra6I7JM2UZ9MW/RhHhQ7jYb2tiu/Oy+nYL0w2hPE5rt8qbWzqkhaHU5
TeKdHZbM
=a1nG
-----END PGP SIGNATURE-----

--ETH6SEU0ez6wZIsi--
