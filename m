Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6928FC25B7C
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EEBA885B7;
	Thu, 23 May 2024 17:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jj615gaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC5F885B7; Thu, 23 May 2024 17:02:53 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E89885AE
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7948b50225bso192105885a.3
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716476570; x=1717081370; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i54WjWnwg8cd0BGONh/yFN8eOs2aTph6DoJZQz1WjjM=;
 b=jj615gaBE+rE++ilhZcmqo5b5dvJJJbIV7ZZzgG+A1JDnVEUCTcsD+qq7+5+sORGCS
 NocS2UzLnMe3nqAiigjTJnxu1ewEMd/KJRMIE1G/QpYtbuE80cW9TDbpjhCOqoZD67mZ
 8OL+mkiA/kJvctjKvDu0oRNIaKcCf/6kbXUuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476570; x=1717081370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i54WjWnwg8cd0BGONh/yFN8eOs2aTph6DoJZQz1WjjM=;
 b=G8wm/PrqlLjJyf5nGEaqGJQ/4GCjXemFdz6d1DW+dtBURFkRtd5xtqwn4j9ofNryfY
 zo+vSBbag41UT+1+/qAZ3QeXiMUM7qV6Ov+FKDOX72x6bNKRbSjLDoR8mSCUxpj9hQ2T
 /JThiaVzunCnPd4OA9p4y5Hw3buCabvwTvSMRG+zx4wWHWaNMf4YLlTLkqvnoj2rNuUW
 5MY3BbW3p+hqT8ZKHddVoT1drtRmZwEM8JXs76qzAE469TTRocsDk4qunqwn1dpRhLfM
 P0vElup4HxXbPF4BDb+tTRf2/vQfbTKlrZkSbHmq7YxuG4m+8EeievShbsnGDLaXVAAw
 0jWA==
X-Gm-Message-State: AOJu0YxfhLw5i4bWbYwFh1/wOqgIcnMw52LsU66MCel/ysQ+1LEbDAxD
 V8TpLgW/vYc1INQyUDjN7QioMOLl/DHP9m6uT94bL0BtefjrEarW84TZTPuw1j4=
X-Google-Smtp-Source: AGHT+IE1xlVNh/iUfHJ1X9z+ZJ3Vxu3OG+Pf/tunqj9c8HKQbypB573A+ePxCdGX89krimWxol2L+g==
X-Received: by 2002:a05:620a:2681:b0:792:ba9e:d730 with SMTP id
 af79cd13be357-7949935aa11mr677266085a.0.1716476569879; 
 Thu, 23 May 2024 08:02:49 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27f870sm1497607785a.28.2024.05.23.08.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:02:49 -0700 (PDT)
Date: Thu, 23 May 2024 09:02:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>
Subject: Re: [PATCH 12/15] configs: add qemu_arm64_lwip_defconfig
Message-ID: <20240523150246.GO2568172@bill-the-cat>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <67ac1063406f022ccc35b94ba41317b6e9ee8b3e.1716393035.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FadpvYBONqlzKZ/7"
Content-Disposition: inline
In-Reply-To: <67ac1063406f022ccc35b94ba41317b6e9ee8b3e.1716393035.git.jerome.forissier@linaro.org>
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


--FadpvYBONqlzKZ/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 06:00:12PM +0200, Jerome Forissier wrote:

> Add qemu_arm64_lwip_defconfig which was created from
> qemu_arm64_defconfig with CONFIG_NET_LWIP enabled.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  configs/qemu_arm64_lwip_defconfig | 70 +++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 configs/qemu_arm64_lwip_defconfig
>=20
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_=
defconfig
> new file mode 100644
> index 0000000000..c8dadbce37
> --- /dev/null
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -0,0 +1,70 @@
> +CONFIG_ARM=3Dy
> +CONFIG_POSITION_INDEPENDENT=3Dy
> +CONFIG_ARCH_QEMU=3Dy

Setting aside that I would like lwip to default to y, at least in the
first few iterations (so that testing is easier), this should be using
the #include method rather than duplicating the whole config.

--=20
Tom

--FadpvYBONqlzKZ/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZPWpYACgkQFHw5/5Y0
tyx0Egv/YFSBWwonfHDHjjbSNqjJPTujD6RpqCYEdK+Syl7CTD+5PSG5123rwuY0
5auxCj1m8MmsI+aGj5KPaMyUoFqaJMBboIYhxwTPTDfEDprb6EyyOhAPe5r/JPL/
M7ZUEhrYIz5f/M7I5xGlA2e1l/CKnObk5eW0eVflfC3BEuE+mSmfU9qCoaRuO+gB
F7NnHUDMtnBo5jI+DzQTMNv47RjA3Q1GKG+1tJ++ToPoAyenMitaR1ZylBauPgpY
CKplzXm1ICM53Ax2oXJAz9q40ejH60QRQC5YO0xKi/VWC0LFVrxowICW/lQYSCRc
ODONCCNpx2cXu1+AWvatWFtoLjnUF0Rr/9X8j8UU/QzphVXzWx+xoI0IZDsbLzep
v+wIXxatyxI+7ULQ0UkT+YUQVzVBTyztQnqHnywCtvjsXIV25i2PQnuQLzHsn3/6
7KUsAVPmjt8hmBycSc0Yiswl+hiA+DdydP77ZRralAfEOkQJ5gHveLaDFgn15ZFI
6aTW+afe
=nnPe
-----END PGP SIGNATURE-----

--FadpvYBONqlzKZ/7--
