Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150EFC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 20:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B34287572;
	Tue, 21 Nov 2023 21:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CkRh74M+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5809B87619; Tue, 21 Nov 2023 21:23:07 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20782875FB
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6ce2c5b2154so3613838a34.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700598183; x=1701202983; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pSdSM8CxcLaUF8fU0Ai9SdmNqXAmiGPS1r9ki/YttjQ=;
 b=CkRh74M+bxdffVXVrCYV9SKB//P4u4ckw0yDx8KXyS7DbU7fYnFsSod57fZKBUwy/C
 608nAvjI7k6+mmMxNH00VeL6PpZFggpXEPLePD5VC7BWDqJlQVLPQgDUmnvBX23C+KlN
 XxXsKfAL87Wky9SwNsr4gs0e8rnNwzJ4j6eik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700598183; x=1701202983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSdSM8CxcLaUF8fU0Ai9SdmNqXAmiGPS1r9ki/YttjQ=;
 b=DRIBMzdMQwTKrMncVXojCqaGwb6oZ2AEI4rwWfAqwCoM5pF2TrjJVmm7kJLtrrYDFQ
 Xn6gLpVK3IRZnWPO2IHK3rN3yWyIIXxpOJTtBlDUhoN3l3/9DRLnyeyASzlg8bYUQw2W
 hGMTntB3/UW0sKkJuEogTOWuIjoWJSxoWt1jLqRdfXeQwbpptXyjfACgYVZHfp5Q75D6
 fAlURZDXZK3Srwvo8QWbToOC5A0PZQKaq8OIBKXicM3KgM5zonmI6h15D8WTPHjF/TMs
 5teYRxkF/KoczMErKYt5nL3gqMNV+erO63x8mokpHTUfk8JIUF8l3R/7HDlok92mKPID
 /WGw==
X-Gm-Message-State: AOJu0Yx3ypldbViVT0uMZff7dC8GuGy92Jy3+UTiNznrxmHB5U0ZjChi
 aPWhgfpbKmVTosqfsjb2E3kqjw==
X-Google-Smtp-Source: AGHT+IGcNlxDaRsZ7b0ZHhTwYYnnp56yP4HTcyCQMgddwGULZpcNbxoY/WxuvO53l38ejo/g8CKfEw==
X-Received: by 2002:a9d:6185:0:b0:6b9:b600:589 with SMTP id
 g5-20020a9d6185000000b006b9b6000589mr419292otk.15.1700598182802; 
 Tue, 21 Nov 2023 12:23:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a0cc3d0000000b006648514e276sm4224709qvi.78.2023.11.21.12.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 12:23:02 -0800 (PST)
Date: Tue, 21 Nov 2023 15:22:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 02/21] arm: allow CONFIG_LINUX_KERNEL_IMAGE_HEADER to be
 set in defconfig
Message-ID: <20231121202259.GK2513409@bill-the-cat>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-2-9492198e0c15@linaro.org>
 <20231121190720.GD2513409@bill-the-cat>
 <adda70dc-b81e-4684-9ff2-7169af1ce4f3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5hlxPdkEr9UoXkxk"
Content-Disposition: inline
In-Reply-To: <adda70dc-b81e-4684-9ff2-7169af1ce4f3@linaro.org>
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


--5hlxPdkEr9UoXkxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 08:17:30PM +0000, Caleb Connolly wrote:
>=20
>=20
> On 21/11/2023 19:07, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 05:09:25PM +0000, Caleb Connolly wrote:
> >=20
> >> Let this option be enabled dynamically for boards that support multiple
> >> mechanisms for booting U-Boot (e.g. as a first-stage or chainloaded
> >> bootloader).
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >> This patch has no dependencies
> >>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> ---
> >>  arch/arm/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index bd48131292e3..1add4282f336 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -81,7 +81,7 @@ config SPL_SYS_NO_VECTOR_TABLE
> >> =20
> >>  config LINUX_KERNEL_IMAGE_HEADER
> >>  	depends on ARM64
> >> -	bool
> >> +	bool "Linux kernel binary header"
> >>  	help
> >>  	  Place a Linux kernel image header at the start of the U-Boot binar=
y.
> >>  	  The format of the header is described in the Linux kernel source at
> >=20
> > Why are we not select'ing this like the other platforms which need the
> > same do?
>=20
> On some Qualcomm boards we can boot either as a Linux kernel or we can
> replace the first-stage bootloader. To run as the primary bootloader we
> unset this option and enable REMAKE_ELF as well as configuring a few
> other things.
>=20
> Would it make more sense to introduce a Qualcomm specific config option
> to handle these cases?

Well, part of the image header is that if you try and execute it, it's a
jump over the rest of the header, yes? So can't we still do the
REMAKE_ELF on top of it?

--=20
Tom

--5hlxPdkEr9UoXkxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdEaAACgkQFHw5/5Y0
tyyVuAv+JT2whQBabRX71hPr24+Fwb6JZKqHYIZg+RD98ypOX114b9+zblqqfn2N
amuznXIwba+CuOZOkGHXq79CasWGutkLtrFJHAywg1dmljjJRVCASSUSsaA2ExCb
bfsoCB+xtR+53ogNyQs5bl5/EaWbi8jDlo5XtJw2NUGts89kXrEmk62ijqP0sTkG
IOTqQyXLVqAOqmUMkR68HxDVFAKnD5miySZwa/jilky2gJzjIUr5Fuoi5icN9cm0
eNngNHbgiLkxKojpcxf1sDpIuX6H5k/Cqd5Q3fjFdGlmT/g6PMpWssie8rUpucAu
yTqIP/J7TD31vx/3NQ8X4PI5yUSUFhh4WPzCRWNQDadKbNeu7/HvWKQlQwtNnHhR
H1iyPc/3H4C7j3FYnR6p4+EGn5ah5waoQxyl1yplySx1Cekf6M5r26qStY/szslk
3LCRyN8WKBU/Ry+5xMdaeKWihxEW11/LHBnM6Cn0+z2PikfrzYNRgVJUjlblDKN2
62Z7AwwJ
=e9+b
-----END PGP SIGNATURE-----

--5hlxPdkEr9UoXkxk--
