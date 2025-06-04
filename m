Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6454C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 18:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B8FC801BE;
	Wed,  4 Jun 2025 20:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KME2ik+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A97F803DF; Wed,  4 Jun 2025 20:24:11 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F0D800D7
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 20:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2e3e58edab5so93700fac.3
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749061448; x=1749666248; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3v3z3FQpjitpOIKff3XKiTaRMq80mgZWcdGHCUhmGkM=;
 b=KME2ik+EO0TKW0lnVXmo1DBwU0Ae7Jtt4NlXSOUYL3vjFM/5q5fQ97LWE5nnhJzqhZ
 aLsCe7ShIrtF53k/M9+nDtXfArRHM65hD4A9mq7zs5n3VtMtq+OHsbKOz1+BdRysT9bu
 /IOK8vS6i37iUqxN0QKGzH4EqCpYkKIfSXFX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749061448; x=1749666248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3v3z3FQpjitpOIKff3XKiTaRMq80mgZWcdGHCUhmGkM=;
 b=vx0fYzpOTRIwHe1Ah1DjWd9qgkXfcZo5I1iZwH2LZe7aAjwaFvO4YOGciouTfH/TX6
 XgSw6qyX1bnWpLN3uudS3Jrj/3cN1Ia+zST4Yeq6dXlTpBq99oWdzCGatiFWU2iJbGlx
 QwZKFuFj043YtmlGdhtqfqR73v+w+azWwLomohCzvgokSdvPB3yuaVg6aJfqWEPBNt16
 J+BT+TFsYPpGjrEF72s381Fsc1xGx7df4m+KwGJ3g5gFaTkwFFWISkDu2BFyiajqaGP2
 eRcHoVxQZcuM5JSjV+jn+6ib4DQrmuImGpvOQhwXkgAhF4KgLtlIzUK0Fass8NQUdH2J
 jHJw==
X-Gm-Message-State: AOJu0YycoWCGDBrE87tckK6fuHxSMXwkO4bHPr0nPzPn376tjgfF+Mx9
 yXWErLTHunxdvELMy50dhY34JmpZibEgak9n3tVAr9EeJH/hunjood4wQuUefvlii1w=
X-Gm-Gg: ASbGncuI5HxSrzEf4O1OkYRhvitKHrKgsVnXYtP9gxNzJIdH5x8GopnmK5/RubdG+Ip
 4Hnd9sjKW9viD+JyJp0yzJkowCo4V7gTMm7gNzXbQ/O2e/i4klUMlZ/0pZC+1bmrIl+SF0hkihx
 noDaY7s7gx0172mYJBSV0eeFb54PwPmYfJLRtvxDE3oqN3isWEZ5r848J7ucsGNIvsTHqKXte7G
 f2V4UmrMqlkSSK5j58HRaa5N8jrRQGMu5e29k4h8ELn3to54/p1cCqOzvL8N6WHtTdz0SW5cOHP
 Req+MAQkvrsplE1mdGSB3VJm3oRm8ZtcqYpHx4Xn5yeZF2oG8/vTiuFmyUi2qtRJNsyC7jn9Z+8
 iHqpNVO9q6kRP
X-Google-Smtp-Source: AGHT+IHOnPplQYRBqFld0MT1P+SU4/XpyR5EUYi7Oouo5B5XGXlAEUQ6Z4YRnqtbzJi67fu45N6Vow==
X-Received: by 2002:a05:6871:408b:b0:2e0:15a3:38c9 with SMTP id
 586e51a60fabf-2e9bf5c5398mr2636420fac.27.1749061447725; 
 Wed, 04 Jun 2025 11:24:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e9960d70ffsm979888fac.14.2025.06.04.11.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 11:24:06 -0700 (PDT)
Date: Wed, 4 Jun 2025 12:24:01 -0600
From: Tom Rini <trini@konsulko.com>
To: ant.v.moryakov@gmail.com, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: scsi: fix: memory leak in do_scsi_scan_one()
Message-ID: <20250604182401.GA1941822@bill-the-cat>
References: <20250516174020.118229-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XV3LwMD2/dffr7/a"
Content-Disposition: inline
In-Reply-To: <20250516174020.118229-1-ant.v.moryakov@gmail.com>
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


--XV3LwMD2/dffr7/a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 08:40:20PM +0300, ant.v.moryakov@gmail.com wrote:

> From: Anton Moryakov <ant.v.moryakov@gmail.com>
>=20
> Free allocated name buffer when blk_create_devicef() fails to prevent
> memory leak. After successful device creation, the name ownership is
> transferred to the device structure and should not be freed manually.
>=20
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>"
> ---
>  drivers/scsi/scsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index cd0b84c0622..a9e364d3fdb 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -522,8 +522,10 @@ static int do_scsi_scan_one(struct udevice *dev, int=
 id, int lun, bool verbose)
>  		return log_msg_ret("pro", ret);
> =20
>  	ret =3D bootdev_setup_for_sibling_blk(bdev, "scsi_bootdev");
> -	if (ret)
> +	if (ret) {
> +		free(name);=20
>  		return log_msg_ret("bd", ret);
> +	}
> =20
>  	if (verbose) {
>  		printf("  Device %d: ", bdesc->devnum);

Your commit message and code changes do not match up. The free() here is
at the end and not by the call to blk_create_devicef(). That said,
looking at blk_create_devicef() and all of the callers, what we really
need I think is to audit all of the callers and update/correct them. The
third parameter, "name" is only used to print to the next string that's
created, so an on-stack str[X], snprintf(...) is fine and what's usually
done. The places calling sprintf(...) not snprintf should be updated for
safety. The scsi case of allocating on stack and then strdup'ing that
should be changed to just on stack. I would check with Heinrich and
Ilias about the
lib/efi_driver/efi_block_device.c::efi_bl_create_block_device() case to
be clear that there's a good reason it's not on-stack. Thanks!

--=20
Tom

--XV3LwMD2/dffr7/a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAjz0ACgkQFHw5/5Y0
tyx6cAv/fidtOj58Z/vf9QrGpkYbtba0EdAsbM+IxWDcCGKyr1cftJ3dzLZfUXNh
RYhZvhjcqtHMgddl7pa8VJ4VKLdkYxGP73JYtaozBtf3+snE+ANiuyaUwoDK/Vxn
nWU4xN2ZgFj1sal5mqV+Q4Jt0u+1x+1Rg5acWQwT/OMFNuxMpDL4o6JS9v0wTg7t
3qsfdnTo4fTVqht5BOAGLB9830h3QmC+ySOc6MmvsDB16joBia5/MdvzqYAkhnPq
94jlnVyDSCiXLCVaGskhatUI/cO1kNhGY3lTepC5eBE3GpfUO7mJsz8aPSizwrka
VGLZAXMW4JID3LsP1L5mYP10i4MpO8skIf5hwU9eP+99cn0ynHt9QmVwfXXnWaEZ
ToSy5LxD0FqNWLac1Ko5BsxXvrgjmZOrjWsKzm312hr6LIAl85MFuXRfibjm8eOw
ZNJ12Sc9RxkKi8wUYqtkqwWJtyVN6bt2uTomXLSq6/OjaMkACdy/JSYk5oUl8FCp
y+MurWFx
=h2PX
-----END PGP SIGNATURE-----

--XV3LwMD2/dffr7/a--
