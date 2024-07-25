Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF77EC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 15:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 405E987C38;
	Thu, 25 Jul 2024 17:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cs47yXnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 164FD87C38; Thu, 25 Jul 2024 17:58:16 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2044879AF
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3db145c8010so487149b6e.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721923092; x=1722527892; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BB9D/kg51YUMTNqunV+tZun9DjJwz37kX1DcgFlBNZs=;
 b=cs47yXnBPMTNqovHbpO6gGR59/nCzFGQa9pRrteWSh/i2DrqFC20iSS0cIDX44NIxy
 eNe/Onr1P0m2xYmHpB2WDlDNao+TdSozI8VSUwu7UX1grtX7gElF6puIudXB91mGIR43
 CNHOzyQ2G6c/I/V+iAWE4+L55N5KpwzPN+UEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721923092; x=1722527892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BB9D/kg51YUMTNqunV+tZun9DjJwz37kX1DcgFlBNZs=;
 b=NJEM12crihp3hfRGSGjn9vTb5cf4aTXybTj1qNGGPObkDVay/am4l5F3ub+tWinNF2
 fwaqqoDVtUhiLOUan4j5Ic06kWChdEo0XGgATIEHzB2m1lriJwlKH0hUS+makTdwb42R
 SvJOFeTbiHs86BVjEikXb4huTjTans876+OZmShae/PCpGVMA+4N8KAdhfxB7Hy5UPg+
 trOCaJM1w1ry0b37YjRNBp+dUDIjCMUOtUkY9Whdnxay2ryDUTd+Avo7YDjIwc2gkhhq
 4j6jSdfVXfY8VRkyGVwQ6+uIEZpi7Ekxlmla3fhHFPx0MLb5VKBTBxDkG7FRKd8g07XN
 OYgQ==
X-Gm-Message-State: AOJu0Yw391QU581F2n4hp7tq072AjY/1PtJVgM6+GcOqxAz7arB9+zzc
 sZaNlwQCS14zlQbeAtD053KUUCm0bYnI8jNUUZHNUy75ez3+689ytwfK4Nj6n3k=
X-Google-Smtp-Source: AGHT+IGO0eACJ1KkMFxPu9eVKFVmrulkW+FxgzxOTwhIAZmrgOaYhPMQ2tgfrmmkYtbzDDegEU5uUg==
X-Received: by 2002:a05:6808:14c8:b0:3db:1576:710f with SMTP id
 5614622812f47-3db157672b5mr2192199b6e.48.1721923092485; 
 Thu, 25 Jul 2024 08:58:12 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db135619c3sm330783b6e.53.2024.07.25.08.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 08:58:12 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:58:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v5 16/20] configs: add qemu_arm64_lwip_defconfig
Message-ID: <20240725155806.GV989285@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <dcb78f4958be3ad322168ccac6214991af44c884.1721910373.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/XHmg2Up6dBSNsbX"
Content-Disposition: inline
In-Reply-To: <dcb78f4958be3ad322168ccac6214991af44c884.1721910373.git.jerome.forissier@linaro.org>
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


--/XHmg2Up6dBSNsbX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 02:57:37PM +0200, Jerome Forissier wrote:

> Add qemu_arm64_lwip_defconfig which #include's qemu_arm64_defconfig and
> selects NET_LWIP instead of NET. This config has all the supported net
> commands enabled.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  configs/qemu_arm64_lwip_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 configs/qemu_arm64_lwip_defconfig
>=20
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_=
defconfig
> new file mode 100644
> index 00000000000..1afef04d7a0
> --- /dev/null
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -0,0 +1,5 @@
> +#include <configs/qemu_arm64_defconfig>
> +CONFIG_NET_LWIP=3Dy
> +CONFIG_CMD_DNS=3Dy
> +CONFIG_CMD_WGET=3Dy
> +CONFIG_EFI_HTTP_BOOT=3Dy

This doesn't work, you need:

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_de=
fconfig
index 1afef04d7a04..d3d8ef16e668 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -1,4 +1,8 @@
 #include <configs/qemu_arm64_defconfig>
+
+CONFIG_ARM=3Dy
+CONFIG_ARCH_QEMU=3Dy
+
 CONFIG_NET_LWIP=3Dy
 CONFIG_CMD_DNS=3Dy
 CONFIG_CMD_WGET=3Dy

--=20
Tom

--/XHmg2Up6dBSNsbX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaidggACgkQFHw5/5Y0
tyzu4gwAqjM4+gF90nwypJDhF3vhm6MVyvll0RoHLyCEAebnYWbEKiyaonyrrQ2V
J21iVv0CY74OF+05//RMYpSekPU5l3KyHpC7p4hP5DY+RlcBq2meMfnfoRpzbKu0
7tX//pylh89yBPrmx4dHKmVvXifN9rP2VKOumWSw+ym+nRPU2oR4aQsvZ5DBYkhT
7e1NCGfhjCGkxYLQ67VRT8KM5pHz9dwSmJh00qSuSSlCwjhNEX5AE43PS+2/xC1L
tMA/indUyrtAk86nPBc6jUfxGQ8SGpQl/GNZe9+5nH4C/DqVnHXERprSFZ3kT9zL
r1+kfGzZF/PG+v8yCBmeDW3y60GZdBJGN+xKtP5XjangSlxjUTilrAeeFasfm7fi
9HPP2AE4XcZEo20+5bNR8mumjmVHKPZ1TNb9EqE/iWmOfsw0lVJTXMUpmqn1LsJi
22ZK1JYwg4KL1C3KATGOa+Loa9ROvAM1Tbei1L2c4+KYZXxS5YhDAl0wOGUwQHZj
FnOJ+cOW
=lGYA
-----END PGP SIGNATURE-----

--/XHmg2Up6dBSNsbX--
