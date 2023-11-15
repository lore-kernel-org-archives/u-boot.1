Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49632C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9CC88727A;
	Wed, 15 Nov 2023 23:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BP69B28r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A1387282; Wed, 15 Nov 2023 23:36:57 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2835869F7
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b6d88dbaa3so108189b6e.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087814; x=1700692614; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0Kkk/nYM2tsSr6l46A4zry0+NGsuolqk5uiGolOyxyg=;
 b=BP69B28rvjRZupr5CHAogNkoQ01Fp1zdMjKTgGCRjExIiGqufefrGBSVMCBa7WKuUf
 JtMKWSP86leMBcjF8d8TZjURTI06zcn0luhBFGf5L7o+8NzdmXHAoH94cKU/ldN5lcG2
 fikJSstOQKi64lRLdk+C/5bJ0jSwCJOly0Wuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087814; x=1700692614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Kkk/nYM2tsSr6l46A4zry0+NGsuolqk5uiGolOyxyg=;
 b=blkzj9w1a05DOi4XmHcKfsp6uOJutypzu9RDZl2i1QAQcm77vWwKlZ0EFKD1odtaXG
 wSzU9MMdGnF/BTrYcCF02BCCVmhcdT2U55jzD13+JW1WCNkOYsTHevDNNbeoUq1av2bz
 dPYRMpzEVHGtCls2yA5lNyV8n1sdMWebW1zJnayECc/uN0++VwLmzYarc1ZTkY6LkmiO
 ytBPjQiqMPn7T+pQyv+sri4IpXwMeaeTxDDq3ZNCvoSSJSW9dVklND9HmsqusYggPsTN
 7VWZk0GB7ZrwpVelbepURpdpiMHRpXeB4u/CJehfqIL3N4B0mzdiWHarEHLD2QCboAQA
 aKCA==
X-Gm-Message-State: AOJu0YxA76kaPKRHcSWnGTyY8remBUkF9PDdGOCAOw/xBeoFpZwSNbYM
 LSZwd2yPy1l0vyC2IjkHn82x/g==
X-Google-Smtp-Source: AGHT+IEloVYYGF5Dws/qCVbvNw3oyqm+x8YF9mFhA7fGuJLFKaUqxxXVtiJCSEEkmkTDKQh1NYBZyw==
X-Received: by 2002:a05:6358:2928:b0:16b:d07a:beed with SMTP id
 y40-20020a056358292800b0016bd07abeedmr8048553rwb.31.1700087814370; 
 Wed, 15 Nov 2023 14:36:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 fp3-20020a05622a508300b00417dd1dd0adsm3888684qtb.87.2023.11.15.14.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:36:53 -0800 (PST)
Date: Wed, 15 Nov 2023 17:36:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 12/29] bootm: Adjust boot_get_kernel() to return an error
Message-ID: <20231115223651.GT6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-13-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="awpXRymYdbqnTRHE"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-13-sjg@chromium.org>
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


--awpXRymYdbqnTRHE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:57PM -0700, Simon Glass wrote:

> This function obtains lots of error codes and then throws them away.
> Update it to return the error, moving the image pointer to an
> argument.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> @@ -217,25 +220,28 @@ static const void *boot_get_kernel(const char *cmd_=
name, const char *addr_fit,
>  			vendor_boot_img =3D map_sysmem(get_avendor_bootimg_addr(), 0);
>  		}
>  		printf("## Booting Android Image at 0x%08lx ...\n", img_addr);
> -		if (android_image_get_kernel(boot_img, vendor_boot_img, images->verify,
> -					     os_data, os_len))
> -			return NULL;
> +		ret =3D android_image_get_kernel(boot_img, vendor_boot_img,
> +					       images->verify, os_data, os_len);
> +		if (ret)
> +			return ret;
>  		if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
>  			unmap_sysmem(vendor_boot_img);
>  			unmap_sysmem(boot_img);
>  		}

This highlights a pre-existing leak, yes? If so, can you please do a
follow-up to move if (ret) return ret; to after the unmaps? Or am I
missing something? For the patch itself:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--awpXRymYdbqnTRHE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSAMACgkQFHw5/5Y0
tyx7bgv+OxHAIy7wLoRMoK5sZMZJKapODmr43F/oTBL5EEi/OGxJTJT1vsPaBAJa
xalVGIeKKFWFJNTRVFunBeW0WbqD+VQH/xGmw89OCk3Z5/M9nb2vN0eXDX3svwoB
dLURaCnLVZRkD5RWtOPvZUOqsjB6UUzhZFIr9tIinDg4vAMWnJVXBFXoVZUYeYZ3
AwzstRnSbvzgZ1tr0AhJBxfjRJhuof17pIJGMOJATMCPhHtI/JGjwUs8lF0pazLi
/ncp2Hsc3LGwVLKuctnD0OX/h7i4t4ylYQBxhPuf796NOlqm+sug0AVUju7C5Ote
r0NNrRnskcHpLGGEHYePQDkUiU2cRckM77+YTkG2btEbD/ExmjkOgGu/L4hLWzZ1
cpJfO8qXdD4Y5dDypxq783n0lJQqExcwiyf5UKz2rshZhg/n35cHFIp39b5UHv+n
UPih99pALTLuXIINvZW6CnxRV9794HUppSLWyk+mdnnSDOX+k82VQLcyh6wDhgv6
QFoux45T
=y0tj
-----END PGP SIGNATURE-----

--awpXRymYdbqnTRHE--
