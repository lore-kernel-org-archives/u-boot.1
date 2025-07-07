Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156CFC83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 19:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F468831D3;
	Mon,  7 Jul 2025 21:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bIO08gJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64897831C3; Mon,  7 Jul 2025 21:58:51 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331A28318E
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 21:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-736f9e352cbso1985959a34.2
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751918328; x=1752523128; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CyGEFhCfHCgY4d3CJtCqwXGArBDf0l5qOPTtK3d5T4U=;
 b=bIO08gJL3RZ/SnGIQOHs6xzfTvUiznONHnWTGRaU++esgsYKQjNcrQ1wHMnrJzkz9A
 zFQYuJYlur+A2YERiqm8c72ZGJk+S5A7UBpNOO7J5GEcftwKD7uhdcqBUxwqjeOOg0X1
 NSHcPVxlIwqHKlDrH0EScD8aphEJxQX5y1O1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751918328; x=1752523128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyGEFhCfHCgY4d3CJtCqwXGArBDf0l5qOPTtK3d5T4U=;
 b=U7v/sUM04OHGEV7gvgmoEQVaCyZ25VtJRkw5767tqSbOf0xOxft/aGQGRKnOcZD2fv
 5KimhtZF49yDY7/k14X2YYnLFPArbtxyPUv8RnsQFSisdTMba50vS9Wk/vlFB/vlcEdQ
 jeKxPUM8F4EVMpiqYMgaMPdO5XSLzbnjL+7YL3Lkco7Lf4hnIMOppsEi0/zIFpQuV8Ee
 y4woAnln70qHv+uA0WwQlhGOsW27qYsPTk/eC0Si0pUOzQRnUIKmaCkneCN3RpSshPyp
 ZdeuxXgkU0V8elHXWr3uEZ3zyRvxMxMg6H4IY1k4xMUH/JOxrKB2756WXGdMke65+pDB
 HoKg==
X-Gm-Message-State: AOJu0YxwNusHKSyP/+7XaIPsAqnOKI8AfjHFKh9Uu8DNpafV+DUcyaa6
 QhSoJ9JZo/Ze17PHRUUXMQSR66VFxS6/Fhhda/XQkBXJFPp0PFfMn5IthwBo/uE8t4okLZYMBHL
 vyGeg/go=
X-Gm-Gg: ASbGncuB7GN8NODM5AyyObTUVevZSvuXQIGMbdY+dxou0udE4SrsOcaAvNI0oWHZ86u
 LRh8QWUMnLpOaZPRTsbZXSC0D7VWeKG5pKB7Leyjgb5sFMEc1Q2SaLzGjEKc1cVzerzhxQp6TlX
 jldKNzwsdoRJmTmsKNeXCVtem6DRjZgoGM/Ow3Sgsl6NsHuC3RUnUy7zcdlYyGxgHAa17nfaDWC
 hp7vQlVfCyxHX6voADpwXQ9Y60o37B7/c84pO/dSTviZ8vTFwguQkC54PdNDUqMhHHn3B9qDhSd
 ZtRPAWKbBujTYgDqNyjstvIkIAbIAS+FHAVH8zaIM0ETGyioJQptjfb3163Pz9Xs+0tzrnQl4dQ
 hyqSt9hTpmsb4v+YXnqyDBp5gP/v1wVk=
X-Google-Smtp-Source: AGHT+IGCZSLnuwwJ9FFK8LOctEe/A5kEIrulQD9HWVo1jZue0Y6YV5aGrF+TMmQ9o/svmbXNO1lCyg==
X-Received: by 2002:a05:6808:220b:b0:405:6b13:ca55 with SMTP id
 5614622812f47-40d0444633dmr10774815b6e.37.1751918327914; 
 Mon, 07 Jul 2025 12:58:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02a4593esm1387275b6e.17.2025.07.07.12.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 12:58:47 -0700 (PDT)
Date: Mon, 7 Jul 2025 13:58:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] scsi: Make static functions consistent using lbaint_t
Message-ID: <20250707195845.GP6424@bill-the-cat>
References: <20250707-scsi_fix-v1-1-26a3b1af4b9f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zjr8VRZp5Kz2Udr0"
Content-Disposition: inline
In-Reply-To: <20250707-scsi_fix-v1-1-26a3b1af4b9f@linaro.org>
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


--Zjr8VRZp5Kz2Udr0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 03:12:20PM +0100, Andrew Goodbody wrote:

> The static helper functions are inconsistent in their use of their third
> parameter which is used to pass a block count. Keep consistency by
> always using lbaint_t here. This will fix an issue where two left shifts
> were overflowing the variable type in use.
>=20
> This issue found by Smatch
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Zjr8VRZp5Kz2Udr0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhsJvUACgkQFHw5/5Y0
tyz+3Qv/VyUZqAHE8wKJU3ntIAsGko1oRF1krnecsqH3ZHTJKGm7MPGETHokQ+YW
mafJxtfo2NF6QTbfo9pMhLQWxRB2NDuZf83oolKGH3rZb1zRse5Tbd6kE4I6ciM5
NM6PbzENpAzhx2m5U42ceKRIbPIkXCAfmELXFuHmI/ul6d2VHrPfb95uGuUSt0ER
Uj+6QMBuFTC/mI1yINPu12WtdW5Jq8ZuCSVOG5gomJosMxnTUAQ+0WC/jPK1FHPe
Jq5blfI2gukewF/0r+gm7xsIJ0N0n8u/L34xX/4VjDGbZZJtP9S3ulo+xA8feYPE
JlJo5DjzwUZQ0XfSVBz21kijipiVuhbwp8yh6MoMw36udlDFixZjLN3l6Ook6/KA
3QQikz6E+LkoAZvU55ckaWtR9ltfFM3teRRamlmjLisihdZuifsGZITeCSNL4kYK
kn7D5xo4GZ+THUfU5gdh3QkyKXvCZ5FoSHmYLjmgJsVN0YogCvYKJwq1Wpu8EROp
Y+f7QRVe
=0gi0
-----END PGP SIGNATURE-----

--Zjr8VRZp5Kz2Udr0--
