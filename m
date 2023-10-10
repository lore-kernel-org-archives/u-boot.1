Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6372FCD80D8
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0E386E17;
	Tue, 10 Oct 2023 14:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S9wfhBCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF8986E08; Tue, 10 Oct 2023 14:59:06 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C620486DFD
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59f82ad1e09so70326767b3.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942738; x=1697547538; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2uZjv4JZft2kThBmw9JZuwBKDtyiB20d7jEH4ei8NYc=;
 b=S9wfhBCeZ890c5BXCdiF6AQiEQSsXq5sWft9aNUifh4S1zOHTApEj5OrO6YgCwEY1i
 LPfi91wZeRURRmztP56YMo880PPe/eZDH2UpVneTwZQ6kW4vTxwI1A76hgzo3oK555at
 htRioG06ZZWhjTecoNC4BEOaokVMs9DPW4c0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942738; x=1697547538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uZjv4JZft2kThBmw9JZuwBKDtyiB20d7jEH4ei8NYc=;
 b=mkJmSRMqVXcyN76tCkp86pEJAIw4zC8aVJPf7K/Dm7dzlN7X55ggpKUu7P8X7T5Lob
 vM7M7ft9AgBaYsgTI8Hn6B6DRk3Y0KsSwEV3V/0Qqs6ZYMrUnqod6c10tqgJnkvzgvSe
 P3nhILa3uvaZgy6oejRI5gbyFU+qGCbLKQT7l9lySpJppuD7Jk9LlzMU9x5kLK687Y4Z
 UXW3BSyBtiR4U/A3Wtnpu2hsh8BJOPe8JjvZuLLhsbgWCiqs7c58or5k/CUkVnieMS2g
 +TaMMkoAmLIjMO4y6Il6NQEjKsjAyKjGYFmFZTb/fIJLpDwIzARhZaK08HaKRd1cbs9H
 F3tw==
X-Gm-Message-State: AOJu0YzOs64qR14ta35lb9p0Jjuu6mLODATxyRTevBj9rpI6Fbqf6edb
 Z7ADmswPniwIdUynY+b046GGVA==
X-Google-Smtp-Source: AGHT+IHtN68AKVswXhKto/kmNMcOIWsoiiDwJ+jFZBi8PMwoZc9vVW6Vggf37mAdpxsw/VQnnSey9w==
X-Received: by 2002:a05:6902:4e9:b0:d9a:68a5:975a with SMTP id
 w9-20020a05690204e900b00d9a68a5975amr1033266ybs.15.1696942738066; 
 Tue, 10 Oct 2023 05:58:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a254c04000000b00d9a36ded1besm806796yba.6.2023.10.10.05.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:57 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:58:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Suchanek <msuchanek@suse.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] stdio: fix stdio_deregister_dev()
Message-ID: <20231010125855.GF2227687@bill-the-cat>
References: <20230929004717.37413-1-heinrich.schuchardt@canonical.com>
 <20230929004717.37413-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="71z/DdIswLZT2Vt8"
Content-Disposition: inline
In-Reply-To: <20230929004717.37413-3-heinrich.schuchardt@canonical.com>
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


--71z/DdIswLZT2Vt8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 02:47:17AM +0200, Heinrich Schuchardt wrote:

> When copying the name of a stdio device we must ensure that it is NUL
> terminated before passing it to strcmp() to avoid a buffer overrun.
>=20
> Truncating the name field leads to failure to deregister a stdio device.
> When copying we must ensure that the name field sizes match.
>=20
> Addresses-Coverity-ID: 350462 String not null terminated
> Fixes: 5294e97832a6 ("stdio: extend "name" to 32 symbols")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--71z/DdIswLZT2Vt8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSo8ACgkQFHw5/5Y0
tyyqBwv+K+J5zN7KdfzFDdM885muLnIZrMW99J7GOKBfDLtl5xdn6shlAsBQ3naH
DHTmY9pCDcjtWU5LeZr7h1QwfTqP8Gu/z/ArIvIwZ0xA0gaElc9A1pGvga8oriSu
ZGDa7fs9hDNT0LVnczjO/PfeomaPdudO7UsbqI1YoZMLY3QAqNRA1gnOECY1BIkg
2QL0ReiIFW+lJghsa4EdBTBrBlx8kCuo1f45nWZaSAPg+Qvby//fXYfFugrSZ2KL
NK0iKslu9MulbbaScyHsSUgwAJqmrbx1+s8iGwXjTfsi/MJZMdgxgIlfXP/dpLys
FRIhjZNHE3ifjI5xx7utDyHYjAgztCSpGFOEtWGvYvh0iv/nUOmva3fcoGJfJvzX
hyHFupMSNbtY0LDy6kYCyPh+GMpLswKhjlND68eWumCS1CUK5HHX/0oX6geTS+tl
UeQj35RBxMaBQOkQA9qmLunxoXpaBq1nrl/Kj2o1FalNR6AGMeRJL8XnPTVNlw3X
mQvPn4wq
=gErP
-----END PGP SIGNATURE-----

--71z/DdIswLZT2Vt8--
