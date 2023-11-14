Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8D4C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 16:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D37688703A;
	Tue, 14 Nov 2023 17:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XIPGDH6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C624486FBC; Tue, 14 Nov 2023 17:38:52 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C624C87227
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-66d134a019cso37184236d6.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 08:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699979928; x=1700584728; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hNjBKq9cXJKgh2hv8ryjX1Sv5YaefTEAcWeXWws5Gjs=;
 b=XIPGDH6+OVeiqX3TPe6vHBLRcF06s3erXP8zSw1YEisyqAQMHGRbd/M+thH2nhW7zP
 17TErElvkNzuYB6DPvyGb6JfdVB7kWUATto1/OBbpVdH/1QJ81q3hRxtXhrj5uNKvx+v
 JNK0QQ4rAOlYW+byxyenRRN7y9ZXkYo5oqb9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979928; x=1700584728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNjBKq9cXJKgh2hv8ryjX1Sv5YaefTEAcWeXWws5Gjs=;
 b=sShT78lpVJaudVpgZ9CY+JGrsxQJBe0+ONl06CsfzoMRotrLmiOlklqETNPbQ6EzLn
 20ytx7uYLJAlzXAu2jTvZfk1zy1Td5hxFGzp16eS2spVR+M7xxl8Cx9dqs+p/HwlfYxr
 5kawlXE18aUzGNUB/hzYK6LIdIFmD6IUm3jRUGk/v8JKoJAOMzBtKePPkZlr4p8+Paba
 RvdRY4yDWq2MjgqJGHUD3TQI64xMBvlP5pne2maHQQ50+EaT86cLYgLKoQZfuW8E/cui
 IUnjSOcQOm9wxo9UvDvGx1RI1SAk0oI4DMgKqCIYS8s7MapH8R49pQxpliyUVF75WxeL
 IVTA==
X-Gm-Message-State: AOJu0YyxqziMZI3s4HPQMyipZZGPcqslTQ5Hlt2a6DFw70ohiy+6oQxc
 a6Zbvr6GLWQMW0Fg1x7fZoBzsQ==
X-Google-Smtp-Source: AGHT+IFWVbGm0+blWTrsInkrN5ix8awE0IZRmVu6cKemkvTTwCbwINUxSK8yVFHRMB3zHHJVVtXC/w==
X-Received: by 2002:ad4:5bcf:0:b0:66d:4d04:37db with SMTP id
 t15-20020ad45bcf000000b0066d4d0437dbmr3850469qvt.39.1699979928579; 
 Tue, 14 Nov 2023 08:38:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a0cfd91000000b0066cfd398ab5sm2998648qvr.146.2023.11.14.08.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 08:38:48 -0800 (PST)
Date: Tue, 14 Nov 2023 11:38:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 3/5] bootm: Allow omitting the load address
Message-ID: <20231114163846.GX6601@bill-the-cat>
References: <20231112035001.103897-1-sjg@chromium.org>
 <20231111204954.v2.3.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PVsoPcl6tXJ8gOsO"
Content-Disposition: inline
In-Reply-To: <20231111204954.v2.3.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
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


--PVsoPcl6tXJ8gOsO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 08:49:55PM -0700, Simon Glass wrote:

> The kernel_noload image type indicates that no loading is to be done by
> U-Boot. This works well when the image is uncompressed.
>=20
> When the image is compressed, loading is of course required. The load
> address in the FIT is used for loading.
>=20
> However a FIT built from Linux v6.6 supports about 990 boards. Each has
> a different memory arrangement, so no one load address is suitable.
> Therefore the 'load' address in the kernel node is not useful.
>=20
> It would be better in this case to be able to omit the load address and
> have U-Boot choose something suitable. The kernel_addr_r environment
> variable seems to be a more reliable final address for the kernel. Use
> that as a backup when the load address is missing.
>=20
> Similarly, use the load address as the entry address when the latter is
> omitted.
>=20
> Update the FIT documentation accordingly.
>=20
> Note that mkimage still requires each image in a FIT to have a load
> address, at least for now.
>=20
> Another option would be to create a new Kconfig for this, or to use a
> region of memory known to be free, e.g. calculated from the DRAM banks.
> But in any case we should try to avoid conflicting with the
> kernel_addr_r variable. So the approach in this patch seems reasonable
> to me.
>=20
> It might perhaps be useful to introduce an 'entry-offset' property
> which allows the entry to be set as an offset from the load address,
> whether that is explicit or calculated.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

OK, so I dug out what I was trying to determine before, and while I
might see if I can bisect down to when this regressed, it might be a
little hard given that my previously functional image is from 2013.

What should happen in the case of kernel_noload, and why the later patch
to fail on kernel_noload + compression, is that we don't move the kernel
contents of the FIT. We don't need the load address to be set because
we're using it where it is. What happened before in the case of the
ramdisk, and more importantly device tree, is what I why I want to
bisect down to when my image stopped working. But:

> @@ -177,10 +177,17 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int=
 flag, int argc,
>  		images.os.end =3D fit_get_end(images.fit_hdr_os);
> =20
>  		if (fit_image_get_load(images.fit_hdr_os, images.fit_noffset_os,
> -				       &images.os.load)) {
> -			puts("Can't get image load address!\n");
> -			bootstage_error(BOOTSTAGE_ID_FIT_LOADADDR);
> -			return 1;
> +				&images.os.load)) {
> +			ulong load;
> +
> +			load =3D env_get_hex("kernel_addr_r", -1UL);
> +			if (load =3D=3D -1UL) {
> +				puts("Can't get image load address!\n");
> +				bootstage_error(BOOTSTAGE_ID_FIT_LOADADDR);
> +				return 1;
> +			}
> +			printf("Using kernel load address %lx\n", load);
> +			images.os.load =3D load;

The load address shouldn't be what kernel_addr_r is set to, it should be
where exactly the kernel portion is in memory, right now. We don't move
it, it XIPs. That's what used to happen, and how we could avoid having
to put in a load address. And so long as we then later ensure it's
properly aligned for the underlying image, it should be fine.  _That_
however might be the harder case to deal with and then we need to
perhaps note-and-move (not warn, it'll be scary sounding for just a
memmove) as it's probably not the case that we've got the Image itself,
for aarch64, at a 2MiB aligned boundary. The FIT was probably loaded
there rather than 2MiB-sizeof(FIT header). And we need to not overwrite
other contents too.

--=20
Tom

--PVsoPcl6tXJ8gOsO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVTopYACgkQFHw5/5Y0
tywCAQv+LzKladBpJmYCetjKjLtMjBIDpRTDQu39x/OO3j3JOotgfYFdTLNSTvPs
V4IAjMj3Y8bc11BDtesfo1CF1/tw3lP2VtRtWZhZJgg5iiy058YJPTjDcAxj8oyE
oWiAMGhFTusVsX6CQWIwSwMKMlN8KnPcVtsD+ZhVv11N2NZBPBPskqLceNbyOyxy
zdQGbnQCEgZsuAb5em2b97Fsz3csElErMDBRtJ4IdAbfpiDMAk4VMtTo2LilfRlh
Fx/3w3VTHGw9cgLajMvTeMdBaLGSnasiQ6VRpdAARr+a5iHmGmoN+DrHFMO+wIUw
/HotdpTuMggS62LOQz3wn5tIXFfLZJyX/9QBVo2/zauslgd2YFalu94Sj1PVhFo5
tkOHM+XSQXwidMPN1MtGaDybgsenuyl0+Doz9ndBk68x9DQzq7knHUcq9iNhDdXM
Sm5Rwfjx5n7imUuBONQGX08jgPWio9hBZJiqWgyWy5jjv/i75KUYhQx2InAbvFW9
vCMgePKg
=d8AA
-----END PGP SIGNATURE-----

--PVsoPcl6tXJ8gOsO--
