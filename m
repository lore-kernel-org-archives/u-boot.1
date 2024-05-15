Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC98C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 18:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59903841BC;
	Wed, 15 May 2024 20:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D9VIj3lq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E85870AB; Wed, 15 May 2024 20:21:31 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8087883334
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 20:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-61be74097cbso76716217b3.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715797287; x=1716402087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3qHurFWXOjtb3Lk9Jd2E88MTmActuiMxc6dNHOx/1k=;
 b=D9VIj3lqmp2D0nZUWMrx/f4Jx7UwZWou1vinF4aG2IWbKiJMfhRZZmtAN0FH7sFJ8+
 N60Liz0W40JNCQpsJcpkZbXhWxUSKkQCgsM+yAvkgZPG5a/7YCPJGECtwWmg9vWviZu6
 WIL53+ybI0cKS0MH+9s0BQy6QeTjalTIwSsvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715797287; x=1716402087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3qHurFWXOjtb3Lk9Jd2E88MTmActuiMxc6dNHOx/1k=;
 b=S4uWMBCrlQz9LJA1BdGTOM0QAwVQ9VmonL+mK7Zy1uOGLeeoPctqDRhjVxoij3/zKG
 KQvR/iXNCWtz/nw8aIFPXmnKvNs9hkJnoNPaTZJPA8gCrhzHrRR7uEuiG53//hsxgD67
 zOhZ4Xs+KGQLldeY3oocHAVGU7PEW5eC0axddAx7IuzVcZBhkvJMgDR8AtOYgONFisQ1
 Ha7dEUMACfkTyLPyiDFvaBiv97KAI88ZYXhAaHgoTCeWYpmJGyCkpRJjgwDESnUhyVDF
 hSE/2PX0dud85ujtBgJBqBT8EjH/13WtB+q00kdhrMtrf6mxwpggbTaW2dHjurWxmEwC
 LUSA==
X-Gm-Message-State: AOJu0YwooX2AuzclGKhf9Y61eXxgn/rvOljb24bqxqduOH+b5VLIjq7I
 xsUIypa25MJmt9Xy3x3UQOBaqQnkJY5HyB1xZkoDf0go8qR9Q0yoAflxbfc1J60=
X-Google-Smtp-Source: AGHT+IEViyOO/FBP7U6L7FIoprFUthVVhsUCGyUHiEDKM87yF/+44MYyZVUxVCfx/ltI8djalyTyIw==
X-Received: by 2002:a0d:e28b:0:b0:618:412a:d12b with SMTP id
 00721157ae682-622affa80a5mr163785877b3.15.1715797287195; 
 Wed, 15 May 2024 11:21:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df56d1915sm85820881cf.87.2024.05.15.11.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 11:21:26 -0700 (PDT)
Date: Wed, 15 May 2024 12:21:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de, Nitin Yadav <n-yadav@ti.com>,
 Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 2/2] configs: add defconfigs for the am625-lp-sk
Message-ID: <20240515182123.GY2568172@bill-the-cat>
References: <20240429-am62q-wip-v3-0-17dcfdb1075a@ti.com>
 <20240429-am62q-wip-v3-2-17dcfdb1075a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+iS2YAyjeiQaM54f"
Content-Disposition: inline
In-Reply-To: <20240429-am62q-wip-v3-2-17dcfdb1075a@ti.com>
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


--+iS2YAyjeiQaM54f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 11:44:29AM -0500, Bryan Brattlof wrote:

> The am62x-lp-sk is a package and reference board spin of the am62x-sk to
> showcase the low-power features of the am62x SoC family. Because it so
> closely resembles the am62x-sk board, use the preprocessor to inherit
> its configuration making the needed changes for this board where
> necessary.
>=20
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  configs/am62x_lp_sk_a53_defconfig | 3 +++
>  configs/am62x_lp_sk_r5_defconfig  | 2 ++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/configs/am62x_lp_sk_a53_defconfig b/configs/am62x_lp_sk_a53_=
defconfig
> new file mode 100644
> index 0000000000000..904b2142b2f53
> --- /dev/null
> +++ b/configs/am62x_lp_sk_a53_defconfig
> @@ -0,0 +1,3 @@
> +#include <configs/am62x_evm_a53_defconfig>
> +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/k3-am62-lp-sk"
> +CONFIG_OF_UPSTREAM=3Dy

So, there's a problem here. The #include trick for defconfig files isn't
working as intended, exactly. The example here doesn't work right.
First, it shows up as a variant of "sandbox" (as buildman will show and
leads to https://source.denx.de/u-boot/u-boot/-/jobs/835067#L119)

And this becomes clearer if you look at configs/am69_sk_r5_defconfig
which has to set some symbols already found in
configs/j784s4_evm_r5_defconfig in order to work. This is seemingly very
not equivalent to invoking "make foo_defconfig bar.config" to combine
things.

--=20
Tom

--+iS2YAyjeiQaM54f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZE/SAACgkQFHw5/5Y0
tyw5Cwv/W1Y+xAP2/QifMH4JKWcu3QNR1Su8CxOSSq+IKO3IUIL9AlNez2mcStka
LD4KI9nIjG41YoruJzZelc/w+SJDakiT41wWJuDxXtPEdwj15h7qpUglhzJOZVFr
83od249QIe+u8aciHAX787J0pmI5DpJI7P+gianCoUvGkJePL62O2XRNBosVcSDw
0NYdTftvvCblp+yH+75EMqEiM/Q+mhc/L5Hs5vHCOsb44ZTYWTjQr1I7UDB9mPpC
agFuJ+bIscytzJyUPrWuz0Hz5MbYZNZ4Qi6BlDEAVCCeJPLzolS+4CgQ+glu1c3v
XnviJoR7W7/nencrSfygV6X92WaDgk9eEhVKyQAbB+3hGg7jb+4z+wXrv39FXklQ
WFOJ4XdDwa6HR2ouNabw5v2if0Iqdv/jQ9F8aeYhlAOxGI9v/xB55Xh1wmuF3ZPE
L0hlZIngzhCSfHt+bFyAbbH27aOzLHDm5WcCw51HoJAf5UVaH9AmkplSCtmVPLcQ
qW2J5AYq
=CtTZ
-----END PGP SIGNATURE-----

--+iS2YAyjeiQaM54f--
