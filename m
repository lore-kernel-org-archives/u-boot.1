Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D438BC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9247C87691;
	Mon, 27 Nov 2023 14:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jnnM5O/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E3F877BE; Mon, 27 Nov 2023 14:08:33 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D5287565
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5c08c47c055so40590597b3.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701090510; x=1701695310; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sriu89eFcdKK2eTXqxG8JKihfvEi97DcpZoGK+x3O00=;
 b=jnnM5O/k0u7FwlewDWpVegAvbDg/+i9EogFplxDZwh9d18VVu8ckhW+mXitYjtxTy/
 YN/gJIbN9HZfL/+SaN27Unhu5WvImeMZBD1omVTJCsEbE9RRjHjgoJ0Eb6zHvB8zSwCK
 49NTqw0ktOw99cqV76+GiNLBVeV0JwY/mWlZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090510; x=1701695310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sriu89eFcdKK2eTXqxG8JKihfvEi97DcpZoGK+x3O00=;
 b=rVjED4YjR8S4akoSqXG+HdjVPWRkbN+L/+AoNzZcIy0ui4FESu341kta/mYWXDb6Wf
 wrUgn9OvC1lpwMKtEZ1HeGJOzi0Ll3PNqnnK5kRCu8Ys4oLViqHb7qJObNrMrh/XfObV
 TLH84sC6ZJloerg94CDM28aALb4bUToE28LIR8m2ym/DCVe5fkeu7BxAErqzqPy+dnu+
 AlECPTF6uU3ksd12IKcjsuqzgFjYnT29Uq/wv9yP4zDBpWjKF7Y625t8Wg4Z4LsMkR+7
 vB5AZraPa1+aIQgOpVceVPbhH0vSQUS2ozTYdyaDUeImNavoL8+NBmAWeIffwudD6V5W
 4xWA==
X-Gm-Message-State: AOJu0Yw6wTDs5hISP+Oo0/M7TOD7TQLuSHiPwi+mV5yOsEULOAXw+0VZ
 eEIdYxnE3yJwKsV91qt9BYtWJqf9UNZL9PkM9N9NHA==
X-Google-Smtp-Source: AGHT+IHCP/AW+vR9d5Q59l0yQ5oXNHhjPa/ULpfzDOm2sX3ZLdjCPJOZQpu/H1qsX69q928jdaZakA==
X-Received: by 2002:a05:690c:2a93:b0:5ce:a930:d641 with SMTP id
 ek19-20020a05690c2a9300b005cea930d641mr7819627ywb.4.1701090510415; 
 Mon, 27 Nov 2023 05:08:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a819e0e000000b005869ca8da8esm3164091ywj.146.2023.11.27.05.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:08:29 -0800 (PST)
Date: Mon, 27 Nov 2023 08:08:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
Message-ID: <20231127130828.GC2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-34-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZXLqt/bvWdh2y8gy"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-34-maxim.uvarov@linaro.org>
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


--ZXLqt/bvWdh2y8gy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:57:16PM +0600, Maxim Uvarov wrote:

> Increase allowed binary size to fit lwip code.
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  configs/am335x_evm_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
> index f048e60f7f..9fd608bd76 100644
> --- a/configs/am335x_evm_defconfig
> +++ b/configs/am335x_evm_defconfig
> @@ -124,3 +124,4 @@ CONFIG_WDT=3Dy
>  CONFIG_DYNAMIC_CRC_TABLE=3Dy
>  CONFIG_RSA=3Dy
>  CONFIG_LZO=3Dy
> +CONFIG_SPL_MAX_SIZE=3D0x29000

As probably a problem for other platforms you made this change on too,
you can't do this. The link limit is here because that's the limit the
hardware (and ROM) imposes.

You might need to either:
- Figure out how to make lwip even tinier for the SPL case
- Limit the old network stack to just for SPL, and a later task is to
  reduce what's in the old stack to just what's also needed within SPL.

--=20
Tom

--ZXLqt/bvWdh2y8gy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVklMgACgkQFHw5/5Y0
tyy29Qv+PDQwZi6kVthwys+rpsdViHPjVnEorV7VLsGaTsW+fg5npKtYyTGDCdRp
tk4G/06c7jmB07mW4BgqAH7DrHcmXhMfPdUPhLaZdyVgxm0f7sdGlqo80sllTDG0
TdMNfPXcFa/LFJ644EFO5mwZNdaDeG9fKdWEmSF6S3VB0/W788TGH9gA65B/stuS
+eb2ZNXm6TVZF99lsoCjS+pt0eMyrFbECgnflKDW9lyJ9gCBfmZltHvqdbaBcuCX
CpLMiKHzZtmacCDYnsdGOrabUw71+vpLI2FLAGeHMQPAIIFw7urHJWv0yPyg7jFt
jltpJCDNRV1w+1kvxMNXDsUTmGBaSgArE+Wqp5xEAPtdB4Qcd3dwCYO0SAtiw2R+
L41Xeli8QVNwYvhjTUjcQmBcMyR1q6fIEBZQKnaz2inYYq9F3enXnBVE58Qum9Xz
9YxrTQIek2ygbLL2iU++MDRK83hgdlrSXGf1ZbIE3WBc2Gn1Pq7aKzYLcBAF4HjX
mpkGkXEC
=belb
-----END PGP SIGNATURE-----

--ZXLqt/bvWdh2y8gy--
