Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB1ECAC59B
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC33883071;
	Tue, 16 Sep 2025 20:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rx+lHcKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F75803CC; Tue, 16 Sep 2025 20:27:44 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9276B83321
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3326d9ee5edso1983370fac.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758047260; x=1758652060; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J5SDE5U2nAtPiYIGxuCk/GUHDg4vze/f5gCjnGY5peo=;
 b=Rx+lHcKLm4nKq+D1LL5TXfD+eZ/nfuHOFDz0DhBcp92ldu33R2Wwa3H8LDafLBNTZr
 0PhMgBXtEiUpiojyEUSzxhXMEXowDW6pnrP1Bt3LBhWsM777wkYoOAw9NFjAMq1LllXH
 16X7ICajUh0TEXkmwlMMTKrQKfZkEWrjZY3to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758047260; x=1758652060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5SDE5U2nAtPiYIGxuCk/GUHDg4vze/f5gCjnGY5peo=;
 b=qEPB47YC5GY/aQ0Q5Vqlh7Qb7eKKGAfnhV4YJcAJuYmiOR+DvvrpTjX2jGeXZXcxf1
 Lg1GgrUCPG80XeLcInb1HpaQWs4pMdGwiOh6Fa3ILVk8GTy9np8riJaKeBw1xLBSiMyR
 xYaep9aV/NX2zKXONpKxS3H0dnBgRJhsq/m/UoYFY5G/DEB+z1vMVWXFKmTanrVwFlur
 +4JrfR/RX5SP/1gHtnzEIN+YbBFYlYilD6kuxHfM0p/wr6dcKo3TlVBOLGdkWNHAGL3A
 f9X5fvI12Vlpvz0Zx1uqyesvrZbdAnof86xtgS1H4324FbkLLYPfU3PGXwjp8eSVmRDV
 jnjQ==
X-Gm-Message-State: AOJu0YywxznE5ewtMLFtDXj5ux00EHefzUR8f/7r83A3R9/jCFADh5Y+
 DZz7LusPawhLE/+hUKQXj+8xz8VmalFSOot60/LwW+tlXUfs6UCNKQ+run0GxRTPmxM=
X-Gm-Gg: ASbGnctoDkWaXjEbyUXCGJmgRSWRaT0KBAVej48YHgQ73NEkklR1livKak09NSzF+HY
 a9gKK42gXoBrRjkXkDiCc9QtWQ+MHo10PpflKS+Cg9bcw6SyxgkynYkER7x0FuWpK4yJih1P8OR
 7DH/riw4GagUjB1y8TSNt8R08Dpgk+eysfKXbly4OmVKTeisjr5tITQncpNp9wd3luWCvrLJLlC
 kThGLWYaffWPd8J7Gv4bbakG7BN5FCBcUYVcbKZci2YFQVRL7t4S1HP83BiO1VndBZgUt8hfI2N
 a+e09PEWiZ+9TUf6zuaMAd4jaGWl8cLgtPF61xVJd3jnwyjLaztf94aHk6T+lVbBsp/YrmQZ2ug
 ZWGeMxWMgkVbsuaJ3V71Ttm2LIvBOz1EyT5SaCAhozEWFVPrE624Zda+J
X-Google-Smtp-Source: AGHT+IHSd+0KVeQzRpfCKN6OhXa23bVSv//oRhho7vrpC4X2+ML/Oezgm6dGIeJmJPZI+W+2WR7Ljg==
X-Received: by 2002:a05:6870:c081:b0:321:2680:2f8e with SMTP id
 586e51a60fabf-32e560cd615mr9870776fac.10.1758047260169; 
 Tue, 16 Sep 2025 11:27:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7607e2047ddsm144846a34.11.2025.09.16.11.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:27:39 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:27:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 1/5] docker: add OP-TEE build for testing Firmware Handoff
Message-ID: <20250916182737.GY124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-2-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5YQqgdfELgnZCyAm"
Content-Disposition: inline
In-Reply-To: <20250916161426.32259-2-raymond.mao@linaro.org>
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


--5YQqgdfELgnZCyAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 09:14:17AM -0700, Raymond Mao wrote:
> Fetch OP-TEE (4.7.0) and build it with Firmware Handoff enabled.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  tools/docker/Dockerfile | 77 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 5b4c75f8400..02a8a2fb37c 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -54,6 +54,83 @@ RUN if [ "$TARGETPLATFORM" =3D "linux/amd64" ]; then \
>  		wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2=
020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz; \
>  	fi
> =20
> +# Build OP-TEE
> +RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,sharing=3Dlocked \
> +    --mount=3Dtype=3Dcache,target=3D/var/lib/apt,sharing=3Dlocked \
> +    apt-get update && apt-get install -y \
> +	adb \

Whatever in this list of dependencies that are new for OP-TEE should be
added to the normal list of things we install.

[snip]
> +RUN git clone https://github.com/OP-TEE/optee_os.git /tmp/optee_os && \
> +	cd /tmp/optee_os/ && \
> +	git checkout 4.7.0 && \
> +	make CROSS_COMPILE=3D/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64=
-linux- \
> +		CROSS_COMPILE_core=3D/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch6=
4-linux- \
> +		CROSS_COMPILE32=3D/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-l=
inux-gnueabi- \
> +		CROSS_COMPILE_ta_arm32=3D/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bi=
n/arm-linux-gnueabi- \
> +		CROSS_COMPILE_ta_arm64=3D/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aa=
rch64-linux- \
> +		ARCH=3Darm \
> +		CFG_ARM64_core=3Dy \
> +		CFG_TRANSFER_LIST=3Dy CFG_MAP_EXT_DT_SECURE=3Dy \
> +		PLATFORM=3Dvexpress-qemu_armv8a CFG_RPMB_FS=3Dy \
> +		CFG_RPMB_FS_DEV_ID=3D0 CFG_CORE_HEAP_SIZE=3D524288 CFG_RPMB_WRITE_KEY=
=3Dy \
> +		CFG_CORE_HEAP_SIZE=3D524288 CFG_CORE_DYN_SHM=3Dy CFG_RPMB_TESTKEY=3Dy \
> +		CFG_RPMB_WRITE_KEY=3D1 \
> +		CFG_REE_FS=3Dn CFG_CORE_ARM64_PA_BITS=3D48  \
> +		CFG_TEE_CORE_LOG_LEVEL=3D4 CFG_TEE_TA_LOG_LEVEL=3D1 DEBUG=3Dy

And this should be much farther down in the file, near where we build
TF-A and coreboot and everything else, not up top.

--=20
Tom

--5YQqgdfELgnZCyAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmsGAAKCRAr4qD1Cr/k
CluDAQCvLPkeP8IImA8T36hRVv1FmnLWrqO65Mao9w5yP4swZgEAv5SHZ5mLyX5m
Ebyyw+7vvu44RJUbGo0u9BsqYuPhZAg=
=YQD+
-----END PGP SIGNATURE-----

--5YQqgdfELgnZCyAm--
