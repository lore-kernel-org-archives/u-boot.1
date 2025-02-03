Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D99C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7D4800B3;
	Mon,  3 Feb 2025 21:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NFXVsxox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BE180079; Mon,  3 Feb 2025 21:10:29 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63CF380243
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8f99cb0d9so40175326d6.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613426; x=1739218226; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UV3Cni9VQeRS0qhn80sh7375aqBH0O4dOStpvdxzEyk=;
 b=NFXVsxox0HIFsRZeFNB9l0fddLsZ9qpaandF/ZWpr9Y6DaciJXA7xrOmBCLA/FPCPN
 UlZFs/qtS897WIA28rPeL8b8fEaU2FnGyJRXQ+UQEHM/W+NnUKyv2ZOfUk1hCWQ2as3c
 ezyrFTqNP7mhmDOMMj0nCZ8zlKdxqpH1HFp/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613426; x=1739218226;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UV3Cni9VQeRS0qhn80sh7375aqBH0O4dOStpvdxzEyk=;
 b=csIvgcAx0Qu8zxrtHTR9h44WZ97eXQVzj2nVQ7xUjIHuaIneiGJxeVYY8ZY9ultKMG
 x7uC1cuVLninyoQJTipC6KOiLXP3smGKvBd3Y/SDKq8q6CC9cKcBJoEzatOvaLE8EUDg
 ShbEt0mD3pPwdwYnPlszfFDGLnNjJ2mbrF/2dKXIedTD7Tie/i3++URZmmm2tYkkthew
 M6PaQFskrUrKB13X3BWqnXR4DEL8NbIx0O3nbLdwNgWI8ZKHGtAu7pArJiOGvyZjrNQh
 XyhHswCsQDc+J/FGg/eyXTs8zIw4geAj9Qpxsyx2EQFwQAyfx+5SSchPJBKtowdZIyvd
 aIyw==
X-Gm-Message-State: AOJu0YxsGqDZBIKEzI3GdVx3omf6IY2zfg4Aaxr4UHlR+tc+tmfBA4YM
 QJuiyCOQOcSpPJEWkrJnAp3LlH6xfkgs52neqikQN5CLlJ5IPkg7J7xpfXDmvlo=
X-Gm-Gg: ASbGncuG4e0HfSd+tK79aSorZ87TOycQhTB7KZtg0IXQLytrnJ3HJrpM4S47q2IpVUS
 rD26h1hnDwe7SWMb596oqN1+eN+tRhI6vV+B/8ZITyYmNSkNxH1DNWgJxkdhwHuBy/BjylsOq+s
 TgU/1l+qC0vCx2yEkU9qxqd9ptatB7NPo1mWCUPoDk4nludxMbUEmzBTkHr84xbaomnbSHdNG0b
 zUNPbRF+8sLHUOLKy12iYLyY68yQ/Vq97oiSSkOAjknzewVH5mhmrw367tH9PJGHd1vfwzJPTlR
 8UJld2vhU0DiZKE=
X-Google-Smtp-Source: AGHT+IHtgtbC8uyeChNXJBuiGBZZHQuTom6hsajaPJZj03dgqnucTfEIaWVCbrVkhXj9TbVolR5YXQ==
X-Received: by 2002:a05:6214:268e:b0:6d4:24cf:aaa4 with SMTP id
 6a1803df08f44-6e243bb9200mr310929216d6.17.1738613426289; 
 Mon, 03 Feb 2025 12:10:26 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2548357b3sm53978836d6.67.2025.02.03.12.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:10:25 -0800 (PST)
Date: Mon, 3 Feb 2025 14:10:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 28/32] efi: Generate the app as a shared library
Message-ID: <20250203201022.GR1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-29-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UUMkuiuhU1gjGDYe"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-29-sjg@chromium.org>
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


--UUMkuiuhU1gjGDYe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:21AM -0700, Simon Glass wrote:
> The app should be built as a shared library, with position-independent
> code and the -shared flags. Update the Makefile to handle this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 3958ea45b9a..990114731b4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -452,9 +452,13 @@ KBUILD_CFLAGS +=3D $(call cc-option, -no-integrated-=
as)
>  KBUILD_AFLAGS +=3D $(call cc-option, -no-integrated-as)
>  endif
> =20
> +ifdef CONFIG_EFI_APP
> +KBUILD_CFLAGS +=3D -shared
> +else
>  # Don't generate position independent code
>  KBUILD_CFLAGS	+=3D $(call cc-option,-fno-PIE)
>  KBUILD_AFLAGS	+=3D $(call cc-option,-fno-PIE)
> +endif
> =20
>  # Read UBOOTRELEASE from include/config/uboot.release (if it exists)
>  UBOOTRELEASE =3D $(shell cat include/config/uboot.release 2> /dev/null)

You should tidy up arch/x86/config.mk while doing this, and I assume
-znocombreloc ends up being common as well?

--=20
Tom

--UUMkuiuhU1gjGDYe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIq4ACgkQFHw5/5Y0
tyyAXwv7BboYIJ5OnV5qgTsTZois9XaEa/EVR0FIVGJ1OMJaRjzVaYk3xLPodobn
a28locr+ix68MeDDahNb6I4LBaC1DbGnCZYEi139YXdsKkH2vCTn6g+HSqzcKVHT
LDcryWwFnyClkQlsCuFxx+1w4IGrXFiJVNNaCS0CAyzFPhQ83t0EnJ0UrD5OQX+1
haG9UByJr5e0TsW7lICRv8jDO4+ccSk03hD5s8Q03l9Qf6ztzYAzu5h3NSonzqkA
1jIaGBGS46xDz3WVInx9fQUSG5gJC68W5NgsBYemz+tY9up7jCZeS4BJWHs3MJS9
txmolmKsWJ/VSbI4gdx5kiRRqAwDIT4CkFOej/LK97/8/ohvM6+XZsFEnlK5N8xN
/PryVGdLHfgZeN9mySEAPjsdBIjo5LTH6cf0VNKKR5Tityf10/t4u94OSXA73Y8J
3vBPurg2rX8pghLGfeaC0bfqWPqlbAgtHd+1CGNgIPLRYZ/qu7/2VOPz4m7vbfj1
qhmJkdLz
=YQqH
-----END PGP SIGNATURE-----

--UUMkuiuhU1gjGDYe--
