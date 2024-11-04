Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5417D1CA09
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 23:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F3B88EC4;
	Tue,  5 Nov 2024 00:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FLQFkbJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F8088ECC; Tue,  5 Nov 2024 00:28:27 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E78B88C7C
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 00:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-460ad98b043so38180251cf.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 15:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730762904; x=1731367704; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mxPqlScyQ1v6aWgMHbG16EFewFqiD0mWskL6ZoHxbUg=;
 b=FLQFkbJRUpOfb9BGHQNU9Hhz0r9HXeIDUdC0Xa6ZffqdzhN6/9tXmvJy4JXibrhdAc
 gKkb6MY5BgyWzu326jGaQ2ljYxI82VZ0+BsVXUsnaJBZc4kXcW6+rL5Zpv3b/lEv9jam
 6V0Sc4Erknfrq6jAxzLNCHLA4+o5yHFQyYVrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730762904; x=1731367704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxPqlScyQ1v6aWgMHbG16EFewFqiD0mWskL6ZoHxbUg=;
 b=jJ1R2Y6EBxKjoQLaA0RqZ62VMOUpYgM6zSas9Whh2Z8pXc3AUDBj+QhKDp+nm2lFr9
 GCNjW9f+zeMUFUrU4cCZMOu/eGnFryr2PXJYI9w50iS+Ksv1BQErO2LiAp2m0NeBw5y0
 h9w4FAK28+qz6F5SnkeExplIXFpQ2z3hkwA18beB69AZlzla81OOKxKHYRrl0Hr3iTF0
 N196LyCiMVEtuajZ6vp/b9M5iT7wlw3AqO4qf9IxxbakH/mvUcH1MMauRmJogzdfHcg/
 wETOEZat2dKztsHXtL3rtdGYig2Rup09llcNMiM4r9e9ldGuPMzi/6v2p9BYHo1efvfp
 wB3w==
X-Gm-Message-State: AOJu0YyjjxHP58fsyTuhPdRh9Mq0GvZm08kmzkjQ7PVpx+iM4SDg9vX4
 zJEPZK5tzZRKXBYbtucHjHkadStq12L+OQIEYh5BrAcTPT3EL88NBFvYdnNPia8=
X-Google-Smtp-Source: AGHT+IGxqVhY7mA1tDab1+J4a3YSNZ+JnX4jnIdWaIOqmcW2TBt3N+TshGg0GYkFa2+4+IQiK2w+hQ==
X-Received: by 2002:a05:622a:134a:b0:460:854f:a1c with SMTP id
 d75a77b69052e-462b6eb7b4fmr254158181cf.27.1730762904368; 
 Mon, 04 Nov 2024 15:28:24 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0d1e37sm52153001cf.54.2024.11.04.15.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 15:28:23 -0800 (PST)
Date: Mon, 4 Nov 2024 17:28:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 04/25] pinephone: Drop status-LED code and use LED
Message-ID: <20241104232820.GZ3600562@bill-the-cat>
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6G7RAr+daEQe/Z9V"
Content-Disposition: inline
In-Reply-To: <20241103003322.626036-5-sjg@chromium.org>
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


--6G7RAr+daEQe/Z9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2024 at 06:32:56PM -0600, Simon Glass wrote:

> Drop the STATUS_LED options and enable LED and LED_BOOT instead, since
> this is the new way to access the LED functionality.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v3:
> - Combine removal and enable patches
>=20
> Changes in v2:
> - Add a patch to enable LED and LED_BOOT for these boards
>=20
>  configs/pinephone_defconfig | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> index 9d39204a439..272fce1c1a4 100644
> --- a/configs/pinephone_defconfig
> +++ b/configs/pinephone_defconfig
> @@ -11,8 +11,5 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_PINEPHONE_DT_SELECTION=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_OF_LIST=3D"sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
> -CONFIG_LED_STATUS=3Dy
> -CONFIG_LED_STATUS_GPIO=3Dy
> -CONFIG_LED_STATUS0=3Dy
> -CONFIG_LED_STATUS_BIT=3D114
> -CONFIG_LED_STATUS_STATE=3D2
> +CONFIG_LED=3Dy
> +CONFIG_LED_BOOT=3Dy

Adding more people to the email. Where this really got stuck last
posting was that Peter couldn't convert the board functionally and there
wasn't enough documentation about the new way to be clear on how to
implement it. I'm hoping Christian can chime in on the latter part.

--=20
Tom

--6G7RAr+daEQe/Z9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcpWJEACgkQFHw5/5Y0
tywxggv2NkL3fxEbMlr8GpCRBBBm5hcuNgpQ4SDZykEy1VcaHSQiWt87NF6GYuSC
yg10YT0GQQ2UIBXZhLr2lHiZ5BoBCF1hEZI9944TDR0SNZkOzkrEETnbxyjzZHuv
51g77BzNDE85s8pOpcz5OVdSyyHlP43YpQN2/qcw1IFlPSrHjGFYA5luyvKHIrwv
U9WoxNTv+M+SjxkWCL/ZNJEAJhjx9iIz0CTypXSsMRi8PNjjyrC3N95dn1JwoCpo
bg5Bg+fxoAa6LqvNi+Ppvr/r6RFOXoQERofvhFXo5WHfRTQgXVYAGfeVPmWe247C
AlcgdcAs+zMs02QlP3SGtv+77YeYJdt07NN1Cqe/YdEj8GwhyrG5kicXP6rZJIr0
PsvYKpyCaxmHekOkfdk+g9bmUHLbbTm4qyTU+OQy81AYnC4jRnBG5e8JTmd0vcxs
1DgnXhyd17vjmJAZnCtYLfiqAv4MbAfSxXRqYQ3P6SYis2M+dpLcHym/ckiylNrS
/sc8iEI=
=DULS
-----END PGP SIGNATURE-----

--6G7RAr+daEQe/Z9V--
