Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94212C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 16:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08FC58212F;
	Wed,  7 May 2025 18:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gqy32LWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA8581FAB; Wed,  7 May 2025 18:55:49 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901C58215B
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 18:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-40356cb3352so75984b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746636943; x=1747241743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I2dcfp//8egNktdHuBPVONhHa6kOwzRESjoqWYj61nk=;
 b=gqy32LWWipWvZDpUON1yKqjyuWCtNrsc9rtRCmiXWg0fuInbTnoG3wnJPmF4xPlFOi
 rjAYS8tIlyQrp8HoXimqmKCYofWAokJ5zwiaQukZ6XtjHkDC9e6WV2MzzD3QcwVs3PW7
 E6uVcMYHEfYu6wmwC5IT387nuPWgfD68EcYTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746636943; x=1747241743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2dcfp//8egNktdHuBPVONhHa6kOwzRESjoqWYj61nk=;
 b=XaggR1xoBlTLX3IpPzDmLGNYkdQrONIk3oCc0d49rjaAYZQ1Yb2tAlvw8QmhbVUMnr
 I4/6UgtDduwVbeHWkSyj+hfP7P/ZwtEF7bB5MsXrDah2gEgUXwij1FkZYibHPBS4rWVR
 7IDKzRAEJ5hdVsXBZKDVSJK3hbxFHr5TjFJQ65pGTPfrEXh8XB4WYvzPk0p7oOEiPMjM
 dxfZbqHewvXowwsqST2+M7smP3jT7rDi/a/1BwIn09WvKRA26SV89ZFYASjRbx6+aQn7
 kT864wGL+blFWXYFAx2kYy5NR0SBk8wGz6rcJOgdmjAc/0XGc9GJ4hNAcFk/BdnN3aCq
 vZ0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqDbDEwv0CRaPzCCzDb9GBdoI8f0E+3t2MiBbcc8CQQ+LXTjY0muNFW9z0t7PzU1gqzyXzh9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxgVodgEcxBdToxpvJzXPKhaPyKnQ+/fSAIpFxCJaUeKrNsfQRQ
 pxyx84KSiD5aHCOPDRPV39vCdrEw3xeOLJ277qDoG4Hx5alUzMs5aUl75TRYz+g=
X-Gm-Gg: ASbGncufpYGdCYHbP94BQjnMCw10KJSzLMj9ZHWid7yuu+umpdTT8jwNcfB7IFm98oP
 sO9mgA6Pd8uqJF8jRD4XZItH4Nq/FOLBycpda92kTeO6LnnUhooD5LIZbnjEXZH2vzBQ5xJPlWE
 KGJcIQCYLQNsctd1nz6dRrZBuSnm74XwxghzJZiNA0gdY8wQmkxvgO/Zm3qq/vXvAOsJ6E/JWv+
 KqBsx5Hpkc7TrQGNzBMDWwZed8GGoVwOZ6YKKPGpFdaKCBvZvqTy7VZAIvVl+3xu0nDUhR/KWjB
 OZqE5hmlYbIPoO7LZa8ewEL0jWHvMCicUYk5hYZGEvi9wf4m11EvWoCx3wM5/Yz93i1ym2jQ65b
 tWlrnLJ0h/IFe
X-Google-Smtp-Source: AGHT+IGpd3TPCozhvGnIoZ5AqDpwTVArkIjO9G5hf2OlElDDnJAiw9BZnZBi2SO6rO1uWqHUGrSKnA==
X-Received: by 2002:a05:6808:1406:b0:403:284b:2a58 with SMTP id
 5614622812f47-4037797d979mr156180b6e.6.1746636943200; 
 Wed, 07 May 2025 09:55:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f3874a1sm621044b6e.32.2025.05.07.09.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 09:55:42 -0700 (PDT)
Date: Wed, 7 May 2025 10:55:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 joe.hershberger@ni.com, avromanov@salutedevices.com,
 michael@amarulasolutions.com, hs@denx.de, sjg@chromium.org,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, cniedermaier@dh-electronics.com,
 ansuelsmth@gmail.com, venkatesh.abbarapu@amd.com,
 ilias.apalodimas@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/4] scsi: Implement get_blk() function
Message-ID: <20250507165540.GP5430@bill-the-cat>
References: <20250507112812.3066301-1-quic_varada@quicinc.com>
 <20250507112812.3066301-3-quic_varada@quicinc.com>
 <7d3936e0-a01c-4231-90ce-a66cf944a837@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BoMhIBeOgOizs9xS"
Content-Disposition: inline
In-Reply-To: <7d3936e0-a01c-4231-90ce-a66cf944a837@linaro.org>
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


--BoMhIBeOgOizs9xS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 01:57:11PM +0200, Casey Connolly wrote:
>=20
>=20
> On 5/7/25 13:28, Varadarajan Narayanan wrote:
> > Add a function to obtain the block device for SCSI.
> >=20
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v3: * s/scsi_get_blk/scsi_get_blk_by_uuid
> >      * s/partition_name/uuid
> > ---
> >   drivers/scsi/scsi-uclass.c | 30 ++++++++++++++++++++++++++++++
> >   include/scsi.h             | 10 ++++++++++
> >   2 files changed, 40 insertions(+)
> >=20
> > diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> > index 1ee8236c05c..3eb6069649f 100644
> > --- a/drivers/scsi/scsi-uclass.c
> > +++ b/drivers/scsi/scsi-uclass.c
> > @@ -10,7 +10,9 @@
> >   #define LOG_CATEGORY UCLASS_SCSI
> > +#include <blk.h>
> >   #include <dm.h>
> > +#include <part.h>
> >   #include <scsi.h>
> >   int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
> > @@ -23,6 +25,34 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *=
pccb)
> >   	return ops->exec(dev, pccb);
> >   }
> > +int scsi_get_blk_by_uuid(const char *uuid,
> > +			 struct blk_desc **blk_desc_ptr,
> > +			 struct disk_partition *part_info_ptr)
> > +{
> > +	static int is_scsi_scanned;
> > +	struct blk_desc *blk;
> > +	int i, ret;
> > +
> > +	if (!is_scsi_scanned) {
> > +		scsi_scan(false /* no verbose */);
> > +		is_scsi_scanned =3D 1;
>=20
> At this point I think we should just unconditionally scsi_scan() like we =
do
> with MMC... Tom (others?) any thoughts on this? Anyhow this is probably
> fine.

It's certainly something to talk about stand-alone, yeah.

--=20
Tom

--BoMhIBeOgOizs9xS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgbkIwACgkQFHw5/5Y0
tyw1cQv/ecv0S3iElz/mnwJTeTbYffCRHLxhAJwDUb6Iw/WiKx4iUphlY5aP6jhT
9bXDel8RycJWNIb2jj5DKEnxke/e3Sbw82NLppYBrCQUgym5mx+wWNhTnB+D/UzK
2a2IdJp6rOWjhyCsew7lzC9w5Fnviu0m9SkYqOubkhunEdPk/LNfFeemNf9W0rFu
ANyYflWtGZA5S42O5+ec1AYMwB5U9enjNt5UyMO3YZoxJJlm8VMQtoVwfDDh5D60
hPwneWQTO1uQDvZBKm9ylahXcvVJ+TfvtYwZxlpIkK+f8bC5Wi8Fk8dLaYtjV1Td
C+iRmx/uPkqgFyjNNyiyy7MFjmkyrZvf7iiASwmndovlps7eM+1TNbKZeyUDnV75
UbJc9zWwkbvKEJYk/nP/d2PhuUQw6092joImvzit2bema9fJ4y2bB9yPh8+HcFdS
L3Bz4JObJdV1nXvdNIWQilqz9Zhg7Fup+WgV3p/FsgUooHRALj0g588DR0qlvHvt
y1ceZlG/
=L/yi
-----END PGP SIGNATURE-----

--BoMhIBeOgOizs9xS--
