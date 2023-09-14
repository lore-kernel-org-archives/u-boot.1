Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA89AEEAA57
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9A286A38;
	Thu, 14 Sep 2023 18:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jt5IpIvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F164286A45; Thu, 14 Sep 2023 18:29:30 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76D286A0A
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59c0281d72dso4412237b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694708967; x=1695313767; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zxl7XbBrGh3Z/d9MpZg5Ky9I+qCzohoKvLoT2ZdSWDU=;
 b=jt5IpIvA8cBgxPrnsIyTFwGQsTwrB1YZTT9A/Gg45VQkrY1YQfNaYrTsS/oKqB0V3O
 i61RTN5sut25WBK00bOB7JiUM6FGBH8avSg9crFsdPYihnD7X7nCEa5/O4/5xMkTDQOL
 NOv5YFmYNx5uZz10WNm3Q6SIa/RWdhO/RM/YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708967; x=1695313767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxl7XbBrGh3Z/d9MpZg5Ky9I+qCzohoKvLoT2ZdSWDU=;
 b=JQ6FDh7MimPg02phityQVG/GBiz2rLxZKuTtsrE6pCKKTc40kPM0QhTO7r23M0OVGz
 LKubvSUMpZXZVmKJOHxVp5oHqO5Eh95gCx0Z8JDaAyJKrJDLJFJ2h8paoXD/SPhUV0kr
 Jv91WV6y3bYIka2nBUalFkX9ePrRh+YA/LczxEEuCZvnPI84u2HtnpNMLuwiO0Bvpkok
 nBOS8GVFaWthb41ZXmDnQAB/tMdNu88qteZBOmnIsrOOyQB97bXkrLzOC1B6vbOXbgiy
 yGbCh+aZmBkpcnjvnV0gROMkybp3+s4LckK0mql29m5oWaHH8lLz+FUQPV77lDW2qnrZ
 MN3Q==
X-Gm-Message-State: AOJu0YwugNfL5xzIrcQpcqNk7o80QamCRXf9vR/ypIvFYcwUs7nZNI52
 SXixD2fdczlOmFk5epYSk50LZA==
X-Google-Smtp-Source: AGHT+IEiqC6S79Vgv6su9KYqYnCn0vQ+PkxDDRVERfUpJ+LRWuxWbcCPIIsVY7ZJUIx7cEkOd3HOVQ==
X-Received: by 2002:a81:48c4:0:b0:583:7b49:57ac with SMTP id
 v187-20020a8148c4000000b005837b4957acmr6002883ywa.25.1694708967462; 
 Thu, 14 Sep 2023 09:29:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 i123-20020a0df881000000b0059935151fa1sm389383ywf.126.2023.09.14.09.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:29:26 -0700 (PDT)
Date: Thu, 14 Sep 2023 12:29:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v1 2/2] spl: Add support for booting from ESP
Message-ID: <20230914162924.GA305624@bill-the-cat>
References: <20230914100821.755904-1-mchitale@ventanamicro.com>
 <20230914100821.755904-3-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i34qqY7HLT9xzAC9"
Content-Disposition: inline
In-Reply-To: <20230914100821.755904-3-mchitale@ventanamicro.com>
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


--i34qqY7HLT9xzAC9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 03:38:21PM +0530, Mayuresh Chitale wrote:

> Some platforms as described by EBBR specification may store images in
> the FIRMWARE directory of the UEFI system partition(ESP). Add support
> to boot from the EFI system partition if it is enabled for a platform.
>=20
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
[snip]
> +config SPL_ESP_BOOT
> +	bool "Load next stage boot image from the UEFI system partition"
> +	select SPL_PARTITION_TYPE_GUID
> +	help
> +	  When enabled, first try to boot from the UEFI system partition as
> +	  described in the Ch.4 of the EBBR specification.

We need to select this by perhaps BOOT_DEFAULTS or BOOTMETH_DISTRO,
whatever is supposed to signify that yes, this is going to be a
SystemReady IR (or higher) compliant build.

[snip]
>  int spl_blk_load_image(struct spl_image_info *spl_image,
>  		       struct spl_boot_device *bootdev,
>  		       enum uclass_id uclass_id, int devnum, int partnum)
>  {
>  	const char *filename =3D CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
> -	struct legacy_img_hdr *header;
[snip]
> @@ -63,24 +88,26 @@ int spl_blk_load_image(struct spl_image_info *spl_ima=
ge,
>  	}
> =20
>  	blk_show_device(uclass_id, devnum);
> -	header =3D spl_get_load_buffer(-sizeof(*header), sizeof(*header));
> -
[snip]

Is this an artifact of Sean's patch series where "header" is no longer
actually used?  As-is this won't compile on top of next (which is where
given Sean's feedback, the series needs to be rebased upon anyhow).

> +	/*
> +	 * First try to boot from EFI System partition. In case of failure,
> +	 * fall back to the configured partition.
> +	 */

I don't know that this is the right behavior.  If we're configured to
boot from partition X, we boot from partition X.  If we're configured to
find the ESP and use that, we find and use that.

--=20
Tom

--i34qqY7HLT9xzAC9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUDNOEACgkQFHw5/5Y0
tyzVfQv9ErmzV+xrCZ+GeomSQfWKq6DdR4PIFVWbxJuLeNHKnmrQCUoFtaw3PmHV
X1E3DDL8jdZ/W2Irz1Eh7cXamsjqdYLrafh849o7rqlNEY8oBEAxKvAtlVY3+E0n
1f4EDommgWdREYwkaj8MgjoCaBxjfjq9S0t4LezEQ1kffv//Rc5z/jkZXcFTVcIc
gGebScutQ6zBPcjDPBiWLhgkx4uSuXT/nR1q1YaOlWa+Vf4KZ9pQG2AB+19Ttga2
3w8df+Fg87MnalBS5a9QkWZsLPIMshI6SImusKY7+zChchr8Px9zi8c6HXcdjfHN
hkWa4KZfad51OLAsvVokt0+/4vJtck72TH+qbDforc+XFle8gWpPZ4V0Sg2KQAzi
O2ya0tiOqNcmPxBSyk2XvaAu9Yght7TmX5TX+9qitnF606ftoCcfs9BMptYC7Xy4
QTUtEKsBmQsqfIcdUZB963OgbhfqYyLHf9G1Vz7mVffNaXeD9Q7HMVnCuafZDX2Q
3e9yO0B9
=jSzq
-----END PGP SIGNATURE-----

--i34qqY7HLT9xzAC9--
