Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F0ECD13DD
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 16:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7E583CEB;
	Wed, 12 Nov 2025 17:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kKANYWrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B0783CB9; Wed, 12 Nov 2025 17:59:21 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A0B83952
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 17:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c71c875304so346579a34.1
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762966758; x=1763571558; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RJBv3hQt3HNG1SE5eQgfWYT7qyLX983ouX7hQI9DjOM=;
 b=kKANYWrf2BMLE/A8tNhXsZqnVA8Rf6KS0lx5eHpz+iYyrXND5spRd4H9Lx3pBmEjAo
 Yas68xN9BHor4XNygjGWFHNT4+GuJGz8UFIAuMhK65d+GjGNzMF5ycQ344ASMjhWBuSC
 BsF8c23PlfQbZPjeQM5W2DXJyEvSs8XKZnwz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762966758; x=1763571558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJBv3hQt3HNG1SE5eQgfWYT7qyLX983ouX7hQI9DjOM=;
 b=FiQFljitwHgbKy87mFBfhAKDdd5eaL/Rc5QpYt2gTKxVVWYq3Yco+vpcHlf+lHEzBP
 BfCij99KgisyFZdEyN4b5lSRI75CdY8fviTG2ErSqhcDX3GCKbdkbZhTWlsyWMehgg6u
 PdyaIPNtMMn6gs84UA2mi80dzKCh5yAQ68ZETxCUKLEL16ob+AnZErVqGpsKRGsN4pTI
 w75GAtueiDInn+gYubDc/b6I4bZKljRGxqUiocFuDIa0g2CFB5JpV+59m/JPYLbpRUuO
 xRon5IQMF0+ecHFacKvoSCCo7v/y7jRc4X6w0TUk5VPG3YIc2mvtcoj+Yefcx6CYW2ch
 sMoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSdPdOzaawkMEuqio1q4nmbZOreLImH8MH5yaLjIXAxMNI5MuH8ERYeI48DtLq9rCBDt+oVCs=@lists.denx.de
X-Gm-Message-State: AOJu0YzMzfd5Z2QDj5FeXR4jbkptxVExZIAH0lI5B2Z1wcWtR3r092JF
 jk+dkKQQ8vfxUueuXumBVeG8Kr20XorpLr2tGWpLzEUAgF48258Rjs1IJZbkW7n6RiA=
X-Gm-Gg: ASbGncuTSS3GsuqkbkO0E0u4BxG6bop7tXjR/ei1fqmQ/beM53H8V2YZ54kruYx+EKg
 Btvvx9UwJ4nKZcqdlwKCZgo4TJjQ4MrD6tsm+C77ehCHbipBn4kuqz8w6QqLGiE4jYb8+xfy2wB
 IwqeBCQjvrg/t/QKhG4BW/Prd17WL2F1q4k7g97cJRrNfKtAtIZCdlqRwnX5FN9bVCdrCYtPFcu
 UTlgjjD92NP70AgdEiD9W0YJ5UzhHanzfJ2C8G/oEb9iH5GD6iHmx6Yp7hFvE3Ed2OOhINEfj+h
 3tJ7ZL8wYSd2MSBkJYFlO98d/KU4eI4D7N7ZlHk/qmSNBRUuhA9f6JioRiKtLYPhYqaI7EXr1Tk
 a6Ot74vLhULQa0XDu5d4d0JeJfy6KUvJEo1Ly4/9SM8fHMk6Wteemmk3RfeRxn6MA1CLaWisCij
 B1vVJ3BO4r3QwsMHSmj59cDsP61UzTjS0i0TxCo7w=
X-Google-Smtp-Source: AGHT+IElhbSkFe/8BZlw45izzigY62pqCTYOYVmniPtAR6a6QLfuDpQKyKyRvk+bWp1M7m1+ISYj0g==
X-Received: by 2002:a05:6830:7008:b0:7c2:8937:5d2e with SMTP id
 46e09a7af769-7c72e213727mr1946955a34.15.1762966757998; 
 Wed, 12 Nov 2025 08:59:17 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0b17f2fsm8976981a34.0.2025.11.12.08.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 08:59:17 -0800 (PST)
Date: Wed, 12 Nov 2025 10:59:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, ilias.apalodimas@linaro.org,
 sajattack@postmarketos.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 david.wronek@mainlining.org, adrian@mainlining.org,
 luca.weiss@fairphone.com, alexeymin@minlexx.ru, danila@jiaxyga.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/2] qcom_defconfig: enable pinctrl for QCS615
Message-ID: <20251112165914.GD6688@bill-the-cat>
References: <20251112164758.1560041-1-aswin.murugan@oss.qualcomm.com>
 <20251112164758.1560041-3-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zzMXq6AzOukFCMPF"
Content-Disposition: inline
In-Reply-To: <20251112164758.1560041-3-aswin.murugan@oss.qualcomm.com>
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


--zzMXq6AzOukFCMPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:17:58PM +0530, Aswin Murugan wrote:

> Enable the pinctrl driver for QCS615
>=20
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index e686ea857b9..919897b8d40 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -114,6 +114,7 @@ CONFIG_PINCTRL_QCOM_APQ8016=3Dy
>  CONFIG_PINCTRL_QCOM_APQ8096=3Dy
>  CONFIG_PINCTRL_QCOM_QCM2290=3Dy
>  CONFIG_PINCTRL_QCOM_QCS404=3Dy
> +CONFIG_PINCTRL_QCOM_QCS615=3Dy
>  CONFIG_PINCTRL_QCOM_SA8775P=3Dy
>  CONFIG_PINCTRL_QCOM_SC7280=3Dy
>  CONFIG_PINCTRL_QCOM_SDM670=3Dy

All of these options are already covered under a menu and if
ARCH_SNAPDRAGON || ARCH_IPQ40XX so perhaps a follow-up making these
default y if appropriate_ARCH would be in order?

--=20
Tom

--zzMXq6AzOukFCMPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRS84gAKCRAr4qD1Cr/k
CjfMAQDnmojLFZ9t/i37aDywPjSyNlpm9/WlJmmY4lvo+GJ3kgEAuRDVUF/c+QLM
UX6zqphoIg64K4uC7+fVHi0ck5zxZgs=
=NeR/
-----END PGP SIGNATURE-----

--zzMXq6AzOukFCMPF--
