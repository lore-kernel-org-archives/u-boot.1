Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6989EC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F056A83082;
	Sat, 24 May 2025 16:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HlwPs77n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05DEC8310F; Sat, 24 May 2025 16:26:49 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE53182AE2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6060200710bso368323eaf.3
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748096805; x=1748701605; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHy0MKusrwIKDmQ5KokUSKbZTMI6gItRxhsy5HHGJK4=;
 b=HlwPs77n3POXiV/OEhOPuOiHB/ndXnOmuvHa+fr7/+p0K6j1voHmFT49bmmw/9sS8x
 lutEX9ZxDoeJsKUv6ZEoIla+lRFlB7ecZ4amL9FU0JXE5muFpOwjiv07rwBqHYUkPZsc
 QOo9oOpMZpbVOQ1ikg91ZN+CUvYVGPvD+y7mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096805; x=1748701605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHy0MKusrwIKDmQ5KokUSKbZTMI6gItRxhsy5HHGJK4=;
 b=GR/hopJttnowFEy4+gXy5p8J9oY8ounHbiG96zP6YJC0hdN/xyE+tRpF++dXYVWzEG
 leZTntVz3lZMn3L2JuxxW5ma8fCTPE2PcjMXjcdr0n8yVgn5wMoZi3qjhbAQZG7urH1m
 aB97AWFN+Vzd+7kJyUd1HjFF++KTey6PQVShjW8YJaWiiG4/3jQs48hnBx8yoaghQkA+
 g2F23xjl79gA61f4unqjxGcXfLfImHjA+NaNdwjcuSrISi9iYTJsxCjpq3tlWkNC6mtg
 vsNfQwmEKsrEAeYq+V2T7jtSdJu0bhsf87F9W6iDfW/i6HmQcVR6OBjlFfow2jTaVexn
 1lvQ==
X-Gm-Message-State: AOJu0YyoX1IGSvq+XiU9vvZVv6XycnUviG14+f5BJ8KN2qEBAp1nVBof
 NXQph8toBI/ikkXkRPnH5yR+nnDzClagvV3Z6NMcbIvJOxCFvA300Tq0Dkt3lUM6grFUzh2hzxD
 SgZuEKVQ=
X-Gm-Gg: ASbGnctf1fUBpwETSvXMxeAecWZF4SpT+v5paz3hAu4CviD09f0PILlXfDp5ft0Heup
 IgwtbA9iS760MFFJ2BBxkraIYam6nHCgfD1U1GYfXMFGR1IgFlUIM4hC0rEtyZRol1/8YVXlkah
 aoDUURF9O4ikxIlW006hGZ22SFfDvG0fkGrttoqEYeXuttyxbrU1oNt+DKD4MWiMhGaTZnsqDEh
 xj5Rox6xFS3w50zGAfsRgWLXXIcNPvUSHIGI7ybmhCShhbID0k5spt0XXvtkoElmB74OgfWcUKC
 cX00FtEFrJbYf0fJXRDTcdFv4RQ+VmDZ94BoSGsAkdC0h3yJ9XR37nslQqF3J0LzGCX9hCxwDm1
 AdprB7UyQrs+j
X-Google-Smtp-Source: AGHT+IGvCbztqqm5BfJcVyOSEOub99BoNBBB7Rdg2U78Ue71N56oJoZcTv/YPrp4CGgw9Em68pw/jg==
X-Received: by 2002:a05:6820:201:b0:603:f973:1b6 with SMTP id
 006d021491bc7-60b9fb1c9a8mr1438159eaf.5.1748096805514; 
 Sat, 24 May 2025 07:26:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f3000cfasm3759437eaf.25.2025.05.24.07.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:26:44 -0700 (PDT)
Date: Sat, 24 May 2025 08:26:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] video: bochs: Support a copy buffer
Message-ID: <20250524142642.GH100073@bill-the-cat>
References: <20250524141741.1200105-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pQgfsd81MN06LrH9"
Content-Disposition: inline
In-Reply-To: <20250524141741.1200105-1-sjg@chromium.org>
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


--pQgfsd81MN06LrH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 08:17:39AM -0600, Simon Glass wrote:

> Provide support for using CONFIG_VIDEO_COPY with bochs, since this can
> help to reduce flicker with QEMU
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  drivers/video/bochs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
[snip]
> --=20
> 2.43.0
>=20
> base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
> branch: vid

Once again please stop wasting the communities time with things not
based on mainline.

--=20
Tom

--pQgfsd81MN06LrH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx1yIACgkQFHw5/5Y0
tyyNVgv/fcMqt30GbRYZbdyihkmGJr8Hea71/uZrqEA8xOaGHq/cgsgpLeIYhWlV
0YvDnyDezlh5I2CC90Rb/SCKyEVASgmZdzAiY6EE+tEXmOA+feXTYKdk5COt8PDQ
bsRzXYpZwCTBDMNS88tzcXrNKbjW/FuYkdr8+Y/pEMLkHb68Klkp6DSAP9X2gy+o
XkzLPSw6RewO4Ap64l2p2qOSeAJlfNLnos90Auc7v+fzCHh1gyMCZWQRyxkUw2AM
j6XxsmlTudv/z0047ChSe2x0Xl9sDY8FFCcETxrPEu+hzojNKmRjXBCBYcnqJw79
KXkjuFMs7gefAFZSAx32AFmbRHFi8rjgUedxiOd6x3cbV0x9VRtBxESBRGTvY+zw
98yfX5hjGntH/GLf7KuLWhCsRJDB1zeF72fLoJYL1NQqkXp4keIlhoUlQ5yQrz50
8eUsmaN7GNFFYXrsz9TY92rvU+MZ9dq5uE/MkLSFgjm/p4ICdlNd62Zvd50GvQCf
zYUNtL4i
=jbte
-----END PGP SIGNATURE-----

--pQgfsd81MN06LrH9--
