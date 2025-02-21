Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95D4C021B2
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 01:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC9B80F56;
	Fri, 21 Feb 2025 02:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nVdyDn02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC04C8006D; Fri, 21 Feb 2025 02:07:18 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E3680F56
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso43532215ad.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 17:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740100035; x=1740704835; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S9EHqRVTEy632ALLg728tuF31BJRsNKI7tlWfl/hHYg=;
 b=nVdyDn02NDITnbKY/eWKO+kisD/NAgJ9m0gaN+RXJXjMlC7uNjtRMUmhCSJXkcySt7
 px7wZqPSLO4sN4gREf6EhEbFZn6RGwamwp8Ii6hQK0Av0j92L2xOTxJqaSM6YF1aaT1s
 6m29vF7NhSW5gbhegytMQjNC5wvBaLjkCWb8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740100035; x=1740704835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9EHqRVTEy632ALLg728tuF31BJRsNKI7tlWfl/hHYg=;
 b=rh/lwX69sRRfETi+2Mk034TgPRP3sls0j+ZbpmgthoSTJp/Q0rRy6DGcEVKD4sP4G0
 2cI8ChcFiRhKkeIaa3eyIZ+oUVivZmVB00HrgniAn6gqjcpbPtLtYDpu3VT69AvkV5ZF
 OIWf2xO7niSBPLNGVw5tSYSQFJXOnM8kyh93Ehy30zi9ykkU8fM0XYcTJAPpoilBiKQp
 PXrm9BCUQHV+dNNuQHWHU0hc6DJ98kbxIHstQhbHDpDbd/lEmWMZuQcPHpRwW5ZxU87E
 HmifXARj/pO0Z/wOMb+S19w5IHlm4Cj+D84hmfwZXKOQbbtt8m4aa7aXu8SO2i8upN5c
 seOw==
X-Gm-Message-State: AOJu0YzJlOrrt5lfR88HXTnqn9uo5jf9U8BwDfduTzsInP0xVXsbrzqH
 ko/HGLwMLj5jpxz8UqUXdCtYVkcD5pTxlAM3BtD8QgH+/zv1s1c8su8/1W7LSAs=
X-Gm-Gg: ASbGncuuHJwTP6qXXZ55dMSwqjHZ/2WdVbBOktFsB8MDt0gcZ6hKHtnmMtekJ4/epRs
 qO2WGI7JYNfERsfh3Jp6DPNpbzKt35O55qSEFntrmz9iY7kQH7bIA2GC7p7WWkpwmll30rIBTiO
 oGYnhC9jxp6h5RYCcwxVk7u6I45TdqzQDEzTN6uMQAcUH+/wyeCClWYLP3z20hnlG70OKEnfZP4
 fi+CKkt0Du4zt3Es9X9/g84o4ODIbY+1Brafh41Sbq9VO/CL3Pr9uWDbCv+dPhlW7DSrD3DvlzO
 xpN9vhXG7dKWbg==
X-Google-Smtp-Source: AGHT+IGRLCwlPMFk79lXPdwwAVL559WEbPUsAvytQ/6gpgUqu9jfrDaCF0DJgpTcKuqk8fVtt4SqcA==
X-Received: by 2002:a17:902:ccca:b0:216:1543:196c with SMTP id
 d9443c01a7336-2219ff61e14mr21033135ad.27.1740100034891; 
 Thu, 20 Feb 2025 17:07:14 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d55960ecsm126584615ad.253.2025.02.20.17.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 17:07:14 -0800 (PST)
Date: Thu, 20 Feb 2025 19:07:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH 05/12] arm: Support running U-Boot as a coreboot payload
 on ARM64
Message-ID: <20250221010711.GE1233568@bill-the-cat>
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-6-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OPIpclWqICfpLDku"
Content-Disposition: inline
In-Reply-To: <20250220205900.3127680-6-swboyd@chromium.org>
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


--OPIpclWqICfpLDku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:58:47PM -0800, Stephen Boyd wrote:

> Add a 'coreboot' cpu to armv8 that looks for the coreboot table near the
> top of the 4G address space.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm/Kconfig                     |  2 ++

We can't really ask SYS_COREBOOT in two places, as unlike the kernel
everyone always parses arch/*/Kconfig, so we should move
arch/x86/cpu/coreboot/Kconfig to say arch/Kconfig.coreboot and do
something like:
config SYS_COREBOOT
	bool "Support for booting u-boot as a coreboot payload" if ARM64
	depends on ARM64 || VENDOR_COREBOOT
	default y if VENDOR_COREBOOT

And then any of the sub-options that are imply'd by the existing stanza
in the x86 file aren't applicable to ARM64 they can be "... if X86".

As similar to the work to make EFI payload be a more generic option
rather than x86 only, this too needs some thought to be easily
expandable to cover the ARM case today and I'll assume RISC-V at some
point in the future.

--=20
Tom

--OPIpclWqICfpLDku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme30b4ACgkQFHw5/5Y0
tyycwQv+PX/uik0Tep/wMajRTsGY66Yi6dwHWP6OQHSUcnFNpPhGSU9m4M0MzpgU
I6wXFcfsPRQ3HIwXa/jkKlhoE6ZifHS43j/wRY+n5HUidkj9mtcttF6rkFRc6YM9
fJo8fuDZ4jX61jzP4v80LxYVsxtxOQptVonM/Gn6MfCjgIxH5VCWQ6DhkQK94Gl9
Zn1e9k4RxogKVOnjQGt4jWsTFPstJnOvw1qLuKNSgo6Dy+7u0V7NcAuLeaI/8+ZG
HCNdB1Mq6iMdig5E9leGZG0bnCZQOHKZKPHnA0HO8sMQcBHRNN7zuCMsLiFrfJY0
HPNfWlrMQlBKZ7U6DHxxxC666FlFO57bC2TX1vbbBsshLnoEyRlIVEd7Crm7niUM
1nS7pKxXEYjoUy5gaf5Znc/p1hY+7/raFaF/nbFZu8I75ZUwfYct6G+CuWO4dQVX
+zqLGRVh2MJ/mTFDdp9iElHy+O29nR/q9DnGDFMfqFKRjnIaEs32/sCvtQLMReY4
t9LBU7KW
=kIAb
-----END PGP SIGNATURE-----

--OPIpclWqICfpLDku--
