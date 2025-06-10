Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0663DC61DB2
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 22:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D3E82A4B;
	Wed, 11 Jun 2025 00:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pCchngMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916C282B20; Wed, 11 Jun 2025 00:59:51 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63AF48070C
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 00:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60ef850d5fbso1407147eaf.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 15:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749596388; x=1750201188; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ims8GPDFVStBARAI2ot6LtY3iIC6z+WGXP8gNtWxBHA=;
 b=pCchngMZeCScNxid4gyix9iJHRJbCb6NvJn7x1TN1Aih8vd1YGrOHqZ61ou2SI0ROO
 nE1tzzb9kV/2Xc+ypzWRLsgCGk0qQaNcjI3GZO2gSlmuGOD7Y4pj2P6BFuDGBVPkltyN
 T4V1OXNm0My6sdNpXWhHC+lRRzLCJP5VSriuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749596388; x=1750201188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ims8GPDFVStBARAI2ot6LtY3iIC6z+WGXP8gNtWxBHA=;
 b=H8n9FL5SP2vjwZbF3Izf6+q+xn06vEUJu631gAELywo5xJ6A2Ws0aAZ9gPUmofAd+k
 hLwMAwR/SqWmZ2J4cBV8vRdneFgGPwRWKyymk6PjX7RpOCSi4NAxnYbRJnXZ6TBNZof0
 K68aoRraiDMPr309F1b5Md3TyztncxNNxpI23mPmYW18+3J6lxai5dU0cZ4nxXmQO41J
 Oyz36QAaToUoWShViYXmBhCJXYvaNK5mosU2KCWjEabNifoSh2n4YARSornBS9c7l+Yz
 Tob9Ic8ycObtfzuoTgF7z4ivKLG5bnT2i++x2MbT8OGbZZuR47T/KFggCfJKAT4Q9Md2
 YB1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/nFUl5poI5VrRboE2b8cTtQJYpazyKNoOL3BICpl1upK++bZZ1s9pvSIGEi9oBJS7Qg2ASww=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3Rra6+QCqZ3ru9Txrt7WvEmXhOJgzaZuliLK2Pr1mdPQWNej3
 dS1LLfWd3zYxzEBNVpj5cXWP4SkjHcZZAxL79OwsrbCCpVzaUX3HfDxbWc8j86LoZhs=
X-Gm-Gg: ASbGncv4TJdTac5+hwYskDUbuV/OATKDD1Kcdc9CvmvC4g7HzZAaa5zjZdR+CSP+q0V
 Jjh6yC6sbrLGRIszW47FxDbJIbEuqN667xUIlwnRebbwVhbTJWRRdCzpUSChQ1BwmtaM+FLan/B
 ApAycXu7grzA0kIn/8gFjbdYr1FvHtaQNpQirkHOVHtGbJkH7bJQHRaRk85Ugd5p5dTJxXZbr7h
 bE6ueAe5gMr+h0hbb0E8qLj/ONOy7GoRxT9Q9M00NWWboPcljpvmR6nd92eePvKZNdtEBAVaV1L
 daD3ST0z4caaOInQkIAWlCUdghMfV/veof45BPr4fGL+fMY98M5MaUtXGrNhZ7f641YPNBilfbJ
 4TTD0w7cGkLHiZb9YV0hx+wo=
X-Google-Smtp-Source: AGHT+IEbQLjUjcbfPhoRB0JqnbasCRCaB75RHtdU9b7hbMnHEhLssLr4um7ZCA1diuD7VGRyYdpsZw==
X-Received: by 2002:a05:6820:2486:b0:610:f22b:220 with SMTP id
 006d021491bc7-610f22b0347mr41036eaf.8.1749596387825; 
 Tue, 10 Jun 2025 15:59:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-610ef5ae756sm73473eaf.0.2025.06.10.15.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 15:59:46 -0700 (PDT)
Date: Tue, 10 Jun 2025 16:59:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Heiko Schocher <hs@denx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v2 2/3] misc: introduce Qcom GENI wrapper
Message-ID: <20250610225944.GG1382132@bill-the-cat>
References: <20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org>
 <20250610-geni-load-fw-v2-2-7cad6bc18db0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+5n8O40YQbYj7ZqE"
Content-Disposition: inline
In-Reply-To: <20250610-geni-load-fw-v2-2-7cad6bc18db0@linaro.org>
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


--+5n8O40YQbYj7ZqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 06:50:51PM +0200, Casey Connolly wrote:

> Qualcomm peripherals like UART, SPI, I2C, etc are all exposed under a
> common GENI Serial Engine wrapper device. Replace the stub driver we use
> for this currently with a full-on misc device and implement support for
> loading peripheral firmware.
>=20
> Each of the peripherals has it's own protocol-specific firmware, this is
> stored on the internal storage of the device with a well-known partition
> type GUID.
>=20
> To support this, GENI will bind peripherals in two stages. First the
> ones that already have firmware loaded (such as the serial port) are
> bound in the typical way. But devices that require firmware loading are
> deferred until EVT_LAST_STAGE_INIT. At this point we can be sure that
> the storage device is available, so we load the firmware and then bind
> and probe the remaining children.
>=20
> Child devices are expected to determine if firmware loading is necessary
> and call qcom_geni_load_firmware().
>=20
> Since Linux currently doesn't support loading firmware (and firmware may
> not be available), we probe all GENI peripherals to ensure that they
> always load firmware if necessary.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
[snip]
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 579c8acfcb466122c4fe66950ec7ca24c355b43a..5b83e3386be6ab7fa8d7f5306=
851d90a87fb75c3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1124,8 +1124,9 @@ config ARCH_SNAPDRAGON
>  	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>  	select SYSRESET
>  	select SYSRESET_PSCI
>  	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
> +	select QCOM_GENI
>  	imply OF_UPSTREAM
>  	imply CMD_DM
>  	imply DM_USB_GADGET
> =20
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index ffc5868c0dd3e884fddb98b10f4b878d3f08b43a..78aaf003852aab96450963d93=
678787d30892f1b 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -82,8 +82,17 @@ config GATEWORKS_SC
>  	  Enable access for the Gateworks System Controller used on Gateworks
>  	  boards to provide a boot watchdog, power control, temperature monitor,
>  	  voltage ADCs, and EEPROM.
> =20
> +config QCOM_GENI
> +	bool "Qualcomm Generic Interface (GENI) driver"
> +	depends on MISC

So, this can get tricky. In ARCH_SNAPDRAGON you do not select MISC.
QCOM_GENI correctly depends on MISC. Therefore there's a possible
dependency problem that Kconfig might start complaining about. In fact,
using qconfig to poke at what has which things set:
dragonboard410c dragonboard820c hmibsc qcom_ipq9574_mmc
should all have some warning? But IIRC, annoyingly, we couldn't
figure out how to make those kind of Kconfig warnings fatal in CI.

--=20
Tom

--+5n8O40YQbYj7ZqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhIuNwACgkQFHw5/5Y0
tywXIwwAtux146GuneaAxOLbWZtnDo02MAMSi/IRUFEDeqMkXwwae3CAuHK4XeEa
I6gjCCDeusWfOSXlmKbhoYpH9kN2CRcpGj1HcV4UxhjyR3Bav5KtRxognkEjmxF4
SpRscynPybfkEHHeG6Cpp6r8FPwdfaNULYRj8Mzm437S1RUyLTwv9R7/WbrRJR8K
RWTBwHLHm4yr1KL1YSQd0/oF29TmI+knWTJSD5QQxSdEFIZn4rxBodeg6AemgNyX
Mf+o5HfOSkKhigFl3fbBTJPxfzQPdWrXv1XlleXMKocDnRkbO6V9XyS9hKH0nE81
CCa2nOrgGcHIMLn/w3JMa3rfWIToqsoB+spi5iln3uqaVHtTM0GciNsAfm94rOmh
HCf3C//Lx2PcB8y/mRj//IiMrgW0TOx2cT22/cK905zXjp3U8JNaoRtHhm143Iq/
FJRa+NIJmvW2rIPD7nmmGAYaf83eJa8IKBwSHeRox6CkoXqFzI/CJelHMY2X+M+X
k6HhZ5FV
=PlA0
-----END PGP SIGNATURE-----

--+5n8O40YQbYj7ZqE--
