Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCF5C5321E
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4049288AA9;
	Fri, 23 Aug 2024 23:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tG4MeTFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B879288AAA; Fri, 23 Aug 2024 23:30:37 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5587988A56
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-690ad83d4d7so23162287b3.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724448634; x=1725053434; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5r7/V4zev9erZqfIlAe2TQD1DHBhsHqzTjLh4p3U9FE=;
 b=tG4MeTFbvp/XTKbjs9qA0Ph+ALdaAljsIlYZGNZpNUupkUk+EGWFSd/GJGCLWtBKYh
 bzkSb/jxbPPPEYYbj2TQ1tGZzKESM85YQWnGpkHrlqBW8+0rY5gGhTaHpl1kIYRD9J1P
 jBBwz/hdr/YmpJwuhVIsxvgL9sbIn35iJzRmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724448634; x=1725053434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5r7/V4zev9erZqfIlAe2TQD1DHBhsHqzTjLh4p3U9FE=;
 b=CP+61qDG3a7rkCOuT7Yq+e4/IjiJLr8THBLT7zwAXxd/YYZoiqBHgVu2XVdpi8C7UU
 oPUasPODa4SrjluPCraTt/wRLJQhxDRCMRMMKSgsLxPlJxpXs6ahNrNcBCbM44IAFhI2
 AJrnsJCNEm/F1iPQEgiy4KgKS6Sfb+DFYh0r5bhPnqn4/Wj/ZaEFVuXLJ8n9ZBEpxT/+
 ZDEQrlmGTWIXCa3hNqFv9pbaanw3jMp3awWuUsZ9sQKz2vBuXzjIO3+CDgQd9dAVgqbG
 /WPE+6FJDPvGQcuA6WPp7XmG4l2AdL0ndQp9CSbxITPYqvC2xKyZdfM0XJqtLZwr1TVb
 Fxgw==
X-Gm-Message-State: AOJu0Yz2HmSm7bIsG9Squ79vgoxDDLTGoDFQbDg3V+L89R2MnloMILVM
 D7OgA8CP+3DBDu5QtrQcA90eDQuPhJENbajgkkhZ3agX7O7b9KHoA4nzy1j3EPY=
X-Google-Smtp-Source: AGHT+IEpFJVPqyhuwGRkOvtai2xf82YQafc++SIeU1IG73I+TbiGEOX0I8BU4n3eGXfc7PV+otc+cg==
X-Received: by 2002:a05:6902:200a:b0:e16:6c22:8112 with SMTP id
 3f1490d57ef6-e17a83d45c8mr3643639276.1.1724448634044; 
 Fri, 23 Aug 2024 14:30:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dcd296sm22425886d6.119.2024.08.23.14.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 14:30:33 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:30:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v9 34/37] configs: use syntax CONFIG_FOO=n in
 tools-only_defconfig
Message-ID: <20240823213030.GA2479150@bill-the-cat>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <1cd8b6cde8ba55d6f78cc8ca4c4376bc5ce62294.1724419624.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DCghIHKe1WMs7E9x"
Content-Disposition: inline
In-Reply-To: <1cd8b6cde8ba55d6f78cc8ca4c4376bc5ce62294.1724419624.git.jerome.forissier@linaro.org>
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


--DCghIHKe1WMs7E9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 03:48:38PM +0200, Jerome Forissier wrote:

> The tools-only defconfig causes troubles on MacOSX due to the default
> C compiler being Clang (LLVM) rather than GCC and more specifically
> due to [1]. Therefore replace "$ CONFIG_FOO is not set" with the

"# CONFIG_FOO" not "$ CONFIG_FOO".

> equivalent "CONFIG_FOO=3Dn" using the following command:
>=20
>  $ sed -i -e 's/# \(CONFIG_[^ ]*\) is not set/\1=3Dn/' \
>        configs/tools-only_defconfig
>=20
> This fixes the tools_only_macOS CI job on GitHub [2].
>=20
> [1] https://github.com/llvm/llvm-project/issues/78778
> [2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D9105&vie=
w=3Dresults
>=20
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--DCghIHKe1WMs7E9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbI/3UACgkQFHw5/5Y0
tyxSYQv+OGjLKGj3eoMocoYRJn87+eNRKyEy8MoHxOhAAltAJTe9NZbysVanuKxd
qdL3c9ZZvZtaphHqtyLXpx0V9Jjo4P7XnJBNKzLSv/QvcXlZ7qQXcMHI3mSM4mV9
Yc7GKCCaWNtuZk/X3MjTPhw9R8IvF4sGaYNZ+uvL8GnVxU5lbu66F4NnVTv7tUs6
O/unJlcMspoKdxFlzwT3e67uVKXwMn81zkhuvvRFXuVg+w1FrIwLaEWNHY1WWi01
gMvSC8++83Rnml1CD4GTXLnvKzE762d4NcgkXhG0MumulSXNmB01uwfgsAOBvFaZ
2N+SUqtWAYB96CPaPdvb9LJfpb8+efsZFtBoCqJtyAJBear4gCf0JASFrFgv+WKa
AMCfoHelLf9r8G2V8UwM9pO+rs0qm8CdqbQwTJ+upupzIYxNEnOBq68lItHufxo5
PRWbc+dTujxGXgOZIK9NHXmcrWsjR89I2A616wVRHQzP3wHLqXCgvHcA7U1du/HE
WJO5g+bp
=Zp8M
-----END PGP SIGNATURE-----

--DCghIHKe1WMs7E9x--
