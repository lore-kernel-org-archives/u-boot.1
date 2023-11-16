Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9DDC47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 18:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91DCF874BF;
	Thu, 16 Nov 2023 19:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BL+mnj/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E65874BD; Thu, 16 Nov 2023 19:37:18 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0A1874D2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-670e7ae4a2eso20249626d6.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700159826; x=1700764626; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y02HGSOfzdU3ivqrBZ1080bLApZnP22YdDIX2TaezkQ=;
 b=BL+mnj/8MMmvSrhLPcXhwTDKDRaDGwACA8oo861J/963ztVS8eulEqi40HBNGFZ0Ep
 7uSIQbJ4HUbOEahqYU7WE3xb5tWi+6Gd69UiyvdBFfe7Qhx/2Vg+m7tbZOSL6Vx/aWBp
 g63EC1Z8c8yhoHbRdLGuuGGf8mKQa0lRSHunk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700159826; x=1700764626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y02HGSOfzdU3ivqrBZ1080bLApZnP22YdDIX2TaezkQ=;
 b=q+v6aFoLI2chmfDdo42lbYpwIQoBvqwTC5Nkq3W5tLEg93KMI2Be1uAf600l/qv0Dc
 4V8jaCJ6kZDqK3Z8r3Uyuw0aN8idbNlFxrkmxuUC8R2wuNpgC/mHQTuymvHkwj7o0F/U
 xVl1h/s3CCvjUnLJKS88TEPrhWOHQBcbwVUIiChDgSQPMFJtzm8rUeuHxED+GNVX9mnU
 P/W1y3GPtd9bB1W+KNQIV9j55d9jv6UldbbKDQSjbs+SEhdGZhIPZlinL+vZDlDSd7ns
 UsfcVVcPTV2rLRNNoI0lTnPPe/HaqQg/4Y2YGJ/jbW1oIqinkF+ZyqRAkTUNk8X6B/fB
 8P5w==
X-Gm-Message-State: AOJu0YwYGRIjen2JoIb9AP1bF/aQyWx1295QWKwV6aXwblduN/4qbXPI
 NZkPNt+y5PRmF/hgAknh1Dy0BA==
X-Google-Smtp-Source: AGHT+IGaHMznwbalHkzYvmKAevJOb2ssrxfX8QvXGyX1MaX1/sJLf3HjWc+mbrdKmngf8oTHXUfglA==
X-Received: by 2002:ad4:5c89:0:b0:66f:b9ef:9636 with SMTP id
 o9-20020ad45c89000000b0066fb9ef9636mr3601198qvh.32.1700159826238; 
 Thu, 16 Nov 2023 10:37:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-31e8-20a7-2ee8-ec91.res6.spectrum.com.
 [2603:6081:7b00:6400:31e8:20a7:2ee8:ec91])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a0cebcd000000b00670c15033aesm1532373qvq.144.2023.11.16.10.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 10:37:05 -0800 (PST)
Date: Thu, 16 Nov 2023 13:37:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Zong Li <zong.li@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] configs: defconfig for QEMU RISC-V with ACPI
Message-ID: <20231116183703.GD170968@bill-the-cat>
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
 <20231115142355.123038-7-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NZBjy5nBSgBE/Qjv"
Content-Disposition: inline
In-Reply-To: <20231115142355.123038-7-heinrich.schuchardt@canonical.com>
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


--NZBjy5nBSgBE/Qjv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 03:23:55PM +0100, Heinrich Schuchardt wrote:

> Provide a defconfig for testing ACPI on RISC-V.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/emulation/qemu-riscv/MAINTAINERS    |  1 +
>  configs/qemu-riscv64_acpi_smode_defconfig | 27 +++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 configs/qemu-riscv64_acpi_smode_defconfig

This feels like a case where we should start using fragments rather than
a cp'd defconfig.

--=20
Tom

--NZBjy5nBSgBE/Qjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWYU8ACgkQFHw5/5Y0
tyzwzQwAifuwsxVXclJ50xkZcbPWzthy0ZR7GgMqLDTjfK4lsksWTipEW4mpQMvF
4G4pU3C69Op15GSK9yGAKanlCck1BPxPNtyVbtCjIQUB6hoVrV0TFvxgwFLVMLQb
b8Os/sRqIt88Vst0Le4M/EEn3d1krIV+OqiuwdPhQqgDVkM7Nh4oAHpTdtyJpKt0
y//6cHW8U5FzDy5J9CpUVjn8pmP7nP/rIxejJ6w4rrThjTHM+cnJnRAtEggnPkAT
f4Cd/dm84kSeMkJmFsPjdPN93PgmiXH/lRPSvVb54jAwfueBZZxzsPrC6EkAnGc+
EAr4xXv1Hw4TQNQ48KsYS58Od2LWv37DIqWwrBzm6bW/KBX1iIw+ZFa+XhVxjAPl
+q0cE5ECT6Aj99l7T/+op31y8R01DV/p2OM2XsoUItPf4RvTMvto0KCY1Ck5HXpr
YWt30jrZ3s41OM/U94Q1aPOAbCQwsmk5aqHbEihziM4ANxTGhobjPK/xkpeNoggF
8Mq+9fTQ
=8d9k
-----END PGP SIGNATURE-----

--NZBjy5nBSgBE/Qjv--
