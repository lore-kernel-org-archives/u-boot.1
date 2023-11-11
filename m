Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A183C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 00:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3AE87015;
	Sat, 11 Nov 2023 01:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VuUGQMYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9134A86F32; Sat, 11 Nov 2023 01:26:22 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D5D8784B
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 01:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41cd4446cf5so16780391cf.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 16:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699662365; x=1700267165; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JgZ12Ah5u5iG4Lkdk0HvLiBzD/bjeBJwH20EVTERwGg=;
 b=VuUGQMYuvdZYPAPHfx12O8rIVnCz4BxbvWzneTjBWjJBrPGS2z1y/IpWHV5YzAF13l
 XiynPVTWkCcTehiKgfawCBB+605a/RrBEcMDkwcH8as6s2cqXtuIOPSjMWucJQ5Ic/CA
 h/pt314nHIF7X66Ksv8iTmn8yjg4P5Q6wW8RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699662365; x=1700267165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgZ12Ah5u5iG4Lkdk0HvLiBzD/bjeBJwH20EVTERwGg=;
 b=U9BtVCzM/wQrl2RF8b6y0y9OGtuuHp+pl0PxETdlZTKb7lc/4O+6uUDcAjfd7yXXUk
 N54AChqU1wShz7OkIcWASFEoPRtMwDUSc4B/NSV0+7eku9Us/r6b9Kp1WfeL+BSVmcUF
 /INm0J7RnEWZureOPxsPHK/BkTIHHG1aXlVYCq2ClAXex4uPV/7QMed9dVGfjd3t91Ae
 xy+W0hckbhAGIEF/E/vtJ5w7UwkVeM07rrSOPrPr3f02C2ZqOm8rD868ktQuk8i2gobs
 o/Wx1CAqy2o2EeXBoAvx6+O632WLG1xSgzGf8BZ75mM0jlgSqjDuBPuj/M6OcSU9J+Il
 6X+g==
X-Gm-Message-State: AOJu0Yy7ZSvmYmtVMLU3C7FQl7rTfQheYi002nAkuVvT9n/9172mftGW
 V31Hpp5GGlqv99+3uR1PsDcDxw==
X-Google-Smtp-Source: AGHT+IGDWruhjI5+T/KhJZNAKwjmtqufj/Z+bYn9VGPxau0k5Bs8ROv+XeEX3w4qyK8QxOkD3sBlqw==
X-Received: by 2002:ac8:590b:0:b0:41e:4968:12e4 with SMTP id
 11-20020ac8590b000000b0041e496812e4mr683009qty.39.1699662365394; 
 Fri, 10 Nov 2023 16:26:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8290-1a12-bb4e-bdf4.res6.spectrum.com.
 [2603:6081:7b00:6400:8290:1a12:bb4e:bdf4])
 by smtp.gmail.com with ESMTPSA id
 d22-20020ac86696000000b0041818df8a0dsm196657qtp.36.2023.11.10.16.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 16:26:04 -0800 (PST)
Date: Fri, 10 Nov 2023 19:26:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com
Subject: Re: [PATCH] arm: dts: rockpro64: Add RockPro64 smbios
Message-ID: <20231111002602.GC6601@bill-the-cat>
References: <20231110235806.525529-1-i@shantur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CjozVMbCXa4VDyCZ"
Content-Disposition: inline
In-Reply-To: <20231110235806.525529-1-i@shantur.com>
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


--CjozVMbCXa4VDyCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 11:58:06PM +0000, Shantur Rathore wrote:

> ---
>  arch/arm/dts/rk3399-rockpro64.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/arm/dts/rk3399-rockpro64.dtsi b/arch/arm/dts/rk3399-roc=
kpro64.dtsi
> index 6bff8db7d3..cf850a69e6 100644
> --- a/arch/arm/dts/rk3399-rockpro64.dtsi
> +++ b/arch/arm/dts/rk3399-rockpro64.dtsi
> @@ -20,6 +20,26 @@
>  		stdout-path =3D "serial2:1500000n8";
>  	};
> =20
> +	smbios {
> +		compatible =3D "u-boot,sysinfo-smbios";

This needs to be in a -u-boot.dtsi file.

--=20
Tom

--CjozVMbCXa4VDyCZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOyhcACgkQFHw5/5Y0
tywY3wwAmwvbBpXuQ6yezqLLo/EEoqqXFCuqYdJr7v7vQrn959IP5nU1VqUiZSsw
jS2ln9GH7FPsAIpfw6W8eqLr5E/tn2syDkyK5gZafCQ0l3wxPROUZ4YErH0T6+HC
habhtm7ooV601kyECttfdgFB/Dexgek8CmofKwGRMSeKKPJvfEa5FXMEQhaLiAih
4rMGQn5glTIe4ywWS6XcGBGsE7U/96nS+RNVYgnEd1ZyKu6n5ySpbrsOt/XuOwUT
4RCXMY9lOZJQaJ7xCOtf6U+66eK1b9ta4f/S7ce0FpBMuxnlneIE/QJdypSPuQbW
tXbg2uTH+QzCScdT36GNhCusDdGuOViRRRbl0GiTyy0y0Lk36X0/obOuS19QEtsQ
oKHgzYQRqclRUajcE+ig8PW45TLqUH0tb/GkvCUPgpdGwQTzbdVvBNo82ihnxLhF
FJHdJZ3N16RVFpHCHZVWYSh2F1wRQQqIHv+WxS6lC0psle8gYqlZDAPn6V++bFQF
6PNqtBsz
=7XnE
-----END PGP SIGNATURE-----

--CjozVMbCXa4VDyCZ--
