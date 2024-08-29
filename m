Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC4EC8303E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 17:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F97C88CF4;
	Thu, 29 Aug 2024 19:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JysvUPx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94EAC88CE9; Thu, 29 Aug 2024 19:24:40 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E1E88C45
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 19:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5dd43ab0458so532723eaf.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724952277; x=1725557077; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HIPdBia/DFesraWo/Bv5Y0REzh4ctPxdEYPDaolPzf0=;
 b=JysvUPx3liN+IWlPDVzqxrNkjylBamps+eAtG58YBgNaVlejQKUNZQ6COOKUFtQjYT
 cE5A7HRKsIg1PAU4WJiM7rCBHwYtIAylhylg9/c09Wb6W/ncNvm16xWrt3Fpj2csw6yO
 XnW4BP1zTFjiI54mydHU/lHx+r55yxFjiqVKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724952277; x=1725557077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIPdBia/DFesraWo/Bv5Y0REzh4ctPxdEYPDaolPzf0=;
 b=rilFoz13V/4stNR3WHw4ChnACiLcE6SOr3RKBrJ3sAbkJSkn5XQgQqm38eoKQud74C
 YF4HoyWLjsHaK7X+CvrdCMxDPLUxAx9hnbefzyQdESkNAyNSDCe0F/Q4aKMNyw+DWez4
 4vsfHKW6jNf4hZhzqBHxBzGi4941br8TDHQnmbBKftBrOIrZqza/CIJ0C8tHfPUKPdBl
 ScV8lZtw2gKchnKZ2FCUpVoXN/vnTUp+bAP0vrugBGIuiWma1CdoAdeUbJyjOH5qsgMc
 +owkCifcnhoEaRVxXtwaoMhRsDawlgd6YjnuCxCZbn111VPaKBzQrRvcy5hdfLGkfu7Z
 x7Kg==
X-Gm-Message-State: AOJu0YyTAAGyFc69LN+RzP+yj4kUoSe4cQgZsQwOaqOeHQi9UO9tBFxW
 e5rJHjLxkZsaRiRiPXuLKTv5PdSZ8BMkzVHvbCd1ligSlFSzqM2AoXHftCgk/8/q5MbULLj/cY8
 P
X-Google-Smtp-Source: AGHT+IEXyP1lAQC5C/jazQMhkvUXGwXuQEM5QXd01uJCN8AoiUXCIQG+VF/gPj0Yj6NLfEhd02M+QA==
X-Received: by 2002:a05:6820:626:b0:5da:9bde:1c0b with SMTP id
 006d021491bc7-5df9789f4dfmr4119343eaf.0.1724952276705; 
 Thu, 29 Aug 2024 10:24:36 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340bfa6d0sm7066216d6.1.2024.08.29.10.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 10:24:36 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:24:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 02/19] serial: ns16550: Allow clocks to be missing
Message-ID: <20240829172433.GJ2479150@bill-the-cat>
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J8jwIDKXo48nBJKs"
Content-Disposition: inline
In-Reply-To: <20240829145802.1827952-3-sjg@chromium.org>
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


--J8jwIDKXo48nBJKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 08:57:45AM -0600, Simon Glass wrote:
> Allow serial init when clock support is not enabled in a particular phase.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  drivers/serial/ns16550.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
> index 6fcb5b523ac..5cda273623d 100644
> --- a/drivers/serial/ns16550.c
> +++ b/drivers/serial/ns16550.c
> @@ -570,7 +570,7 @@ int ns16550_serial_of_to_plat(struct udevice *dev)
>  		err =3D clk_get_rate(&clk);
>  		if (!IS_ERR_VALUE(err))
>  			plat->clock =3D err;
> -	} else if (err !=3D -ENOENT && err !=3D -ENODEV && err !=3D -ENOSYS) {
> +	} else if (err !=3D -ENOENT && err !=3D -ENODEV && err !=3D -ENOSYS && =
err !=3D -EALREADY) {
>  		debug("ns16550 failed to get clock\n");
>  		return err;
>  	}

Your patch and
https://patchwork.ozlabs.org/project/uboot/patch/20240804150955.3521296-1-j=
onas@kwiboo.se/
would seem to be in conflict and I'm not sure what's the best thing
moving forward.

--=20
Tom

--J8jwIDKXo48nBJKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQrs0ACgkQFHw5/5Y0
tyybSgv+Ktdh0iNnGsVOcrdGZIlcjItA8wvkk1eaehqIobvKpDlvTPZyydMos9cn
NewLtbPk7ufLdlkwI8ihl4z06gdGGZ795Ljmyqgut9WzQ6sQj4jpIDm1SD/LhZ20
RD4yVMdVa4gyAfSNLx44M9PwtJqMdLYVi1uBPUPTanHu3sJhzVAMNA7JjPxkYKsF
O6vyi3OQnNUevy1T4ay3Vk7pmUPAxdMExCqce8Hh4YFhqmaiCgTszof9w+AkjMsG
7VV48tTPRP316v6GYfu5RCQSZt8al7CPa+1D2ACrTIferwUuWU1OkIy6ypBlKDI7
MttvOxR62CxBK3FAXcjychJetVd9KJW2nAowuG6PTzx5IhWgdWWtmgbblHoHgYrI
X6sO0obZIYgZknHqLltm1JGqi0xp7oMK06LmNFJE9D5P+aaTjXBm5+bePd4nt/mT
XIFOkEGvSO8E4kZ61XngHN/hpEZnlzh+0EIMxefO8/ibJfpoSPe2CMvBIgZPhAl8
cw97sAbh
=f3V5
-----END PGP SIGNATURE-----

--J8jwIDKXo48nBJKs--
