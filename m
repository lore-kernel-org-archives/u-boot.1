Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9479FD185F9
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D9984194;
	Thu,  8 Jan 2026 15:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZHEihQXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD3AB841B8; Thu,  8 Jan 2026 15:15:17 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9CE83B72
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45358572a11so1955212b6e.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767881714; x=1768486514; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K2CML9GUNRT8u2/121PWjRABCNp+0yIuQcaKb5+Hu8E=;
 b=ZHEihQXLhrF62pVXe1wHb9badEuMgoXTc54KoqOMps6f3MSOHlmHk/LBJ4ljNFDrWN
 tmsAVqPOjj4r2WeZPTKw6JoB+byjBwnUyMrcw0W1+Mqv+6BYKLDrtXxiazEO3Vh7UCPY
 Zvhz27UmncAAPNqgcxA0TUrXXaZZx8YCtcd4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767881714; x=1768486514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K2CML9GUNRT8u2/121PWjRABCNp+0yIuQcaKb5+Hu8E=;
 b=E/cJmPQiYtKA9UXWcBVLRcYmiKWflQQe39HK635BCZNT6PsI1lt/2+bQveHqA3wvtf
 ipSGQY2dKXxatenlKdecNo7dK/Y1+A43fmnaU7vDnsHSAoeXXznHI8eqS6ROfcLeblrO
 BbghijgwT6U8qLrnw+3BnFKXHZzCkM0G9+7iUYK1I3Zb2l2PyRnZSOadT9d8Yfld0EEe
 Ef8k+6256En8oZuLdN4ECgKk7VYHwGb2CWYahs01FvwWbN/sOJUkamCt2IeZUW4paTGG
 lCWD/GuHy7SI1IGKcu1MFjZcd0HSqsNPoAlUHaFyYziqdZsLQKbHn+SvFARB6POsK2eh
 1v4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm3ujMc/EyXIhEYREsmDXGkm+ZrXBHCGQIQtrFTIsrCP7UA5ntmecEDOMf3yCRVWmoqsh6lNQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyhLCEKU/fd6PH7bQtuvWmzQmvNIfmBbPl0Q/zrZslC993sCw+/
 UxVUw2U7ezgarRemxio6f12rpvIHnu7gQpv9uLIOTSu9zbHKH3BJXi5ijzob+JfBpq4=
X-Gm-Gg: AY/fxX7vOo89PR5nWU+PuG9OmtUXAnfyDl+9jSO9BdKu3H4/cVbR2xX3DEG/y6EGf6Y
 g8Yxsk80z7BzOXlibvm5sL6eVv0+pM5HC7UTngOXNgUBiRz4f7Bz4YcDre975BtS5CPQr/CYc8T
 x8hFRD59b/d2rpoNJUUIAkOuKSYq4dwfHFyemkWNKOMuSYUw7rGyxbSOA0i3EKxQ1FCcbxNS3pi
 CZ2PZSHWsO7+kdZGnw8CHwAGSqCqHSopH6b11pxrP6qZcTEyjBudk+nZ44HX2nMlwdrl+ig0ZyF
 7J8wlaTb15hGgamp05DWnaH3+YS+AGwEtPgcPRtlt8uZdimpGpHJhvBzxc93QR0Dsxa8xdczZcn
 nlcFLm+3eSSBb6hBu5G//1T7L5xOX1NljjNckbD8t/DJP2o/8nH4EtPHDswioaY1wN8mLwBfWTX
 zY2MHKtXQDQMd+UTcJlSsfeS9iMGL0PdWI9GnVt/PYhpBDwLQqRyiMayphqkas8xSmeqKxkCO90
 fSOj+oCpZeJgB/qAqnDZJmSjSR/W3JqwlNChzQ=
X-Google-Smtp-Source: AGHT+IGP+1MNLPrlzgpvE7JFCyLmvWZg+y2/TEd/LSwzT+I1eHHuuS/0Gl1YhgwLwpf/VhKKpyXpfA==
X-Received: by 2002:a05:6808:c292:b0:450:b215:8f22 with SMTP id
 5614622812f47-45a6bedfafcmr3252624b6e.55.1767881712669; 
 Thu, 08 Jan 2026 06:15:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e2b2b20sm3654693b6e.18.2026.01.08.06.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:15:11 -0800 (PST)
Date: Thu, 8 Jan 2026 08:15:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Jerome Forissier <jerome@forissier.org>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2] spl: fix incorrect dependency for SPL_NET
Message-ID: <20260108141509.GR3416603@bill-the-cat>
References: <20260108-spl_net-deps-v2-1-e412128520f2@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1/tKPPZ+TMQ+i67g"
Content-Disposition: inline
In-Reply-To: <20260108-spl_net-deps-v2-1-e412128520f2@cherry.de>
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


--1/tKPPZ+TMQ+i67g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 01:28:36PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> When SPL_NET is included, scripts/Makefile.xpl includes net/. However,
> in this directory, the Makefile only compiles things if CONFIG_NET or
> CONFIG_NET_LWIP is defined (it doesn't use $(PHASE_)). Therefore, at
> least one networking stack needs to be enabled for SPL_NET=3Dy to do
> anything meaningful.
>=20
> In certain cases (e.g. am62px_evm_r5_ethboot_defconfig + NO_NET=3Dy via
> menuconfig), it is possible to fail the build with undefined references
> (since include/net-common.h does check with CONFIG_IS_ENABLED(NET) which
> would be true for SPL_NET, but the implementation wouldn't be compiled).
>=20
> Fix this oversight by making sure a network stack (and the legacy one)
> is available when selecting SPL_NET.
>=20
> Fixes: 8cb330355bd5 ("net: introduce alternative implementation as net/lw=
ip/")
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> I'm wondering if this is the proper fix... Maybe we should migrate
> net/Makefile to use $(PHASE_) there instead? This would allow SPL_NET
> (haven't checked the whole codebase, maybe we still have CONFIG_NET
> checks instead of IS_ENABLED(NET) where we shouldn't) to build without
> any network stack in proper (meaning that SPL_NET is selecting the
> legacy networking stack for SPL only), and maybe even that would allow
> us to have legacy stack in SPL and lwip stack in proper? This seems like
> a much bigger task than this simple patch here.

The $(PHASE_) way is probably the right way, I had noticed there's a few
other things that get compiled (but, discarded) too because of this. At
least:
diff --git a/lib/Makefile b/lib/Makefile
index 70667f3728c2..a247aa0331b9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -133,7 +133,7 @@ obj-y +=3D string.o
 obj-y +=3D tables_csum.o
 obj-y +=3D time.o
 obj-y +=3D hexdump.o
-obj-$(CONFIG_GETOPT) +=3D getopt.o
+obj-$(CONFIG_$(PHASE_)GETOPT) +=3D getopt.o
 obj-$(CONFIG_TRACE) +=3D trace.o
 obj-$(CONFIG_LIB_UUID) +=3D uuid.o
 obj-$(CONFIG_LIB_RAND) +=3D rand.o

--=20
Tom

--1/tKPPZ+TMQ+i67g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV+77QAKCRAr4qD1Cr/k
Cm8kAQDF7tH//2BzwotIUk9d54MgKgishJXYJQmzN9mATuEF5AEA2WpoxZDeyrpt
GHYaFx1yjlUKnwggGJykS9/6y5gN/wU=
=26sF
-----END PGP SIGNATURE-----

--1/tKPPZ+TMQ+i67g--
