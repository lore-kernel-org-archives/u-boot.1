Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B620C0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 15:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5D2D80A55;
	Mon, 10 Feb 2025 16:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tBmTsA0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0853380548; Mon, 10 Feb 2025 16:52:18 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D18CC80A55
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6f47ed1f40dso34471397b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739202734; x=1739807534; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vrb9twe9rcO7V/qo5UW/2/J8pTEVTphPhwB5IBnK8e8=;
 b=tBmTsA0gTI5hMClsQw5XLVXMSAWN3RoPHAyhBZv4PEH0sNeGn0W2HXpe7lD0UebF8W
 uqEABJELE1OK2srflHfQMQYP1mGsCys4jAm/9higu2RrTD7OgTpLwVhARjoRAoSwQxs+
 LL3vEnhGNvwUw8uTjqXauUN9IODyyaejHMyf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202734; x=1739807534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrb9twe9rcO7V/qo5UW/2/J8pTEVTphPhwB5IBnK8e8=;
 b=hbxdYNRqSOV8WWOxXYJgWk5pqgyQmvdHgpSWbsSt3LUqmIsNaUizWYpOWkAMJIrQ6V
 J6fQq9cEZAVCLAJ01JoilOQhInxx3ZRHKt6SU9tvcKmPIF874d7nq1EyPBR3DcUfdo96
 08dMDrW0XYPDwL8CkAxeSI+HISNuJ1EAIfA5uvMF3w1IaA22CE5mwy9o5nym170gQTGk
 Ld+a+RYYG1P1Gzilf7i8U/1zTjYzIilUpuRzIdQ2wyYnen8ZHeEDmWZK5jXA/gJUymIl
 MWhCoL3986vGI06R++d9VeTkBtKEDk4zQyEoaOaMOm4MxwRbrxHnJsvanpyNv6MJJf8x
 AcJQ==
X-Gm-Message-State: AOJu0YxRaNDF4t8VePUWRR10Izm0SDr7LRSz0c+EpAlRqr2f+koaIx4f
 uoiFLlRk2XF9k2Ja+uPsYlJfJmjiK7X0w3XhDRYNSTz94L50dNxiyCIADPcFEC8=
X-Gm-Gg: ASbGnctvKUHG/6PcakPhWBRMUUIICzpYBRpwewrnIBuT4VkUbSA6of1LxJIRgjefyG6
 tHGatCKCDIlgtR8jyVZ5segPoRIRlsdB45Uemw/KsYZgAgZ29ysJc0hODueLAviNEkhKHqILAoD
 OzpfXoac66X2RQn8nIWumRnweQlG9f9KMvm/s2NWQo0JacmbMh5x68erMSz4N/YTUmmEyKO5F0k
 apRquOHub9aZCPD1rHuESe3s+qJmBt73N0DsWllAGQbMME34RK/VqU/Hf7XhWl60bgfkDWDsFMv
 7QxDsZkOFinEjU8=
X-Google-Smtp-Source: AGHT+IGyJhGfYnSa4psKwd45kn9HORpBNqZ4jlkcyKg0EQ7fjPyYLyl11jA/Eg3OWNZRXBpC96QZZw==
X-Received: by 2002:a05:690c:4986:b0:6ef:a4ec:f698 with SMTP id
 00721157ae682-6f9b280fac4mr131404627b3.3.1739202734629; 
 Mon, 10 Feb 2025 07:52:14 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd17024sm17145117b3.28.2025.02.10.07.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:52:14 -0800 (PST)
Date: Mon, 10 Feb 2025 09:52:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>
Subject: Re: [PATCH v3 12/29] efi: Rename ImageBase to image_base
Message-ID: <20250210155211.GI1233568@bill-the-cat>
References: <20250209020136.4108987-1-sjg@chromium.org>
 <20250209020136.4108987-13-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZUVUtOBqHHWMLyhp"
Content-Disposition: inline
In-Reply-To: <20250209020136.4108987-13-sjg@chromium.org>
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


--ZUVUtOBqHHWMLyhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 07:01:11PM -0700, Simon Glass wrote:

> It is confusing to have a camel-case indentifier in the these files.
> Rename them to fit with U-Boot's snake-case style.
>=20
> The image_base symbol is already used in the x86 link-scripts.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v2)
>=20
> Changes in v2:
> - Rework the commit message to clarify the relationship to link-scripts

Thanks for explaining where this comes from a bit more. I still think
this is a case where our x86 code gets it backwards. To me following the
naming convention of the specification we're implementing is more
important than stylization. But I'd really like anyone else who deals
with this area to chime in.

--=20
Tom

--ZUVUtOBqHHWMLyhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqIKsACgkQFHw5/5Y0
tyx/cwv7BepzUR8UAkQvyOKw+FEQx25hLnVDdlPBkZPZTHZq3VIlgqLtgfOAmUma
tvs69+XvUegBunEfWpFxNgEG3nCzUy9DdXHbHfoQAcs+0LQyZVxd4Kq7884nMMLo
QVeykuVvRxHlpTEHuViWMgBTLLPdK/FO064tD38r3a9UUmecsG/ZBmDeub8LFzKF
UeLywC096sYLDpmV/S1w+OWaKDJlqxknsfumeucvXCppJ1WjRAqpLL6jxb1pFuz/
Qn2jfyWGPIRvn0puqXImbT0NldrqPYeqdO4PK5vdl6vWVu6qxRUB61L/hiVd+9Uf
3SGGLDdvy+blMjt3ZQGF0NZ123TsC2AxV/XF1LUxHCGjdzPD/KbutgHdrbL72/cb
36aobtFwVRz/g0Og1EOYbKg+o/F+t7QwTTLjLRWm3aePKkPbhN/DFIzYhXMAp2SV
tcejZWGkFu9VufQNaR9Ut7QZJhxDu6z+0ujErJ3+6WGkiAK4hZ5IyIrGizBBeH9T
zKQe95q8
=NYyU
-----END PGP SIGNATURE-----

--ZUVUtOBqHHWMLyhp--
