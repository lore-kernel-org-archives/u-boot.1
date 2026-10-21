Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E582606A335
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ia2vbJuz;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=oC/yLuqO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3FBA40B22;
	Wed, 21 Oct 2026 22:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fthWVfAKQKqL; Wed, 21 Oct 2026 22:00:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3AA3140B17
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792620046;
	b=WzUVsYrmOUoWiV30I8glXcuF0G3ePrlo8QirLzwp/sbCzeXhlmxdc3OS0JOrIbkUKZgB
	 EocX17sumP+oZOthC0p126qUlRAbCYwTqlu9F9rTVaCgmz5G3xmn7gmWXVPqcoPXiQiXA
	 fB/OAU9lLlhFunCrRpRW5LhgL5+BmYlrzeAmnhDvF3+zk+/071P9GB/oLrSpLzXmWnEmC
	 IHR1M8/Rh//4KrXxcZ+CGJsUpj56gMfV1PWi1bnaCCp4Jk3HIBX+OAi2ZY6TA1Pwi5LiO
	 0yHO53+pwW/FcFE3oL4sXvlkgszQPWa+HvynchcGV2ZcilNnlkKSTcpvoxSqKOG86jA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792620046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RGRa7D21YG8EYTAh+AbQPQ7OFU2VnUdGSUdU9O63hXM=;
	b=qzQICKxqT0o8onHzrtNH33vcHFLTy0Px5sRPSgftLLPBcQwpGatogf6C/vEg6xiOcDum
	 jtlWK3M1+H3T7v3RaSai2R8V/3JPdmgvJ3KROOCGnSVu+1INiK6T9K5xbfgggCKGyXqJ3
	 vZDZQIw2rpNBJZgqjl5YvNqbYeYGJFq5htPC5HAJbmIw3ARzBFKawupiSOXWGdWkUuK4M
	 dGsbb8VM0l2+wnuT9KaGooHaq4hlrBGu06gP63tR6N2xExOEl/tjRqtLkOYdU5FzHBeDl
	 dr+vi2oL/dTCnjkOvYUoi/JDLwZ2nTO7zoIVPmr8p0knA0Xheol4jAsqMXS+71bNxVg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="oC/yLuqO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792620046;
	bh=RGRa7D21YG8EYTAh+AbQPQ7OFU2VnUdGSUdU9O63hXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ia2vbJuz2lJisRCX73LGozFO+7Mia3ytHscJ75EHAdB7CL7tIl303IVFRPbFT7laH
	 Iu3aGGveYo+0cICiYJn1wiXEig4jYymDRDhPLxHvGwbXJdrL7tgh1aJ+9HZ8iV7Rh0
	 sxIvO5ldB3BobnWSMnvmqbtLrFkjflIwcn9aK7a97Tcr+eDk9mhtaxPNuSsD0NJADy
	 mrnuCjsJeq9LvJEMqI6lAcD+aYCDcI3c8+H/ItgvsdqE4YvrOVqFZHebxgDH7QQoTD
	 lORST5+Tuf9bfs8gBdseN7qlD90OxbEjZ4AKiaxKRjuFN+UeFKPpneBgMmWGIDWHpd
	 S4qVOr732NvAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AA3140B17;
	Wed, 21 Oct 2026 22:00:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EDC9095C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF6BB40AF3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:00:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qgXjW_vsQvQ4 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 22:00:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 238B440AE7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792620043;
 b=HZ8NmUbv6m3BSt1lJfFaYaykGtyZcMLql//JVoc/B3CtlQQDxQyvvFZom1Vz9Ao0zbkb
 vtMYN8ZheO6pOwmw3O/+e4oHdQyJfe+uBGzQ5P8CW4HvP6tFxAJsT09zXetBJ7TwCFlOZ
 4wE9yTm6DRq0k+mhyewBb5FSTzi76oy4bfksUwKeqOZfauyuv5KPYTToG0Hf8ze4SgV3s
 uJob/1nDftAwtuTcLD/aoIpxaVEWxunvOfvIKrwIe0hlg9YqzTkNuGQb9upO0h3gF+HAK
 LHeQG/dgKK/sibslXUb54Zbrma87cu/xRjiwhwwn69VhXvq+0BE25PFiH7Pt7hGaxiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792620043;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=RGRa7D21YG8EYTAh+AbQPQ7OFU2VnUdGSUdU9O63hXM=;
 b=OB7EjR4NXp1NOaWNzJvp+vtmbIfglmK+F/4mAaFBtSehRWs6oSTXuI5kDiiX5/sr34Hy
 bXKmUgzQBM7OyZIIf4EfHM9gEE/T1f4MCdiguuCzIuZZSC4Re0foIGihPMwhFmqNIQ0Mg
 sliTMHy19nxpiXtkxKJiNhcf5qfsG9enO8aWNOFTAtXiUZ9Pq7/LkUfG+152Rce4ygLuC
 2C8qyzJCdQjZiv12Mz2VgQGjNO+JTyUfWi3plPr60mOSNQsdtrTTavd6q9gUhDznsXu1P
 JEjAqIODW/sOBONAMG2tZcKMsL99H/u++yDcj8RIzHjUmpMB8YBFOJkO2A+1jKhZOdg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="oC/yLuqO"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oC/yLuqO
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 238B440AE7
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:00:42 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-705cb6ceebaso727264eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792620042; x=1793224842;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RGRa7D21YG8EYTAh+AbQPQ7OFU2VnUdGSUdU9O63hXM=;
 b=oC/yLuqOxEPxcZ62qNsbtQOhpJiRlzQB6i8pPBYdQOmt+ifQyi7lzHb2+3vUvEUPI8
 J66MBut/JrD3XvY3YrBJ7UVEpyHYX1WUfm5Io1ejmlXWX9f8iSE44oi+L/YIammAprju
 32PoS3NRs2WH6LuQ4c4u34pVD5te1R4YayU24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792620042; x=1793224842;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RGRa7D21YG8EYTAh+AbQPQ7OFU2VnUdGSUdU9O63hXM=;
 b=HFCGYmGG4VAYwvC9s9SoO4e2k/z7S4kbYuICB3DXFohTLRsLypKNfueUmzfFkWQok0
 cBWXm86PumGE0I8TMBU5exBiqGydD0VYZJJkiHuzmLa30gW5vcuqZAHrIgRDwOA7ZHts
 Zembywf8Y6tp4RlIdTon8wXKX0Ut9gFBDnnOJBlw3sGPq/Uyo/nDw1gkLMsRBIWZQNPB
 sK1y1HaoxzIXtueNNEEQbbRyJtYAliztjH4d9AhUzQZLdZw7ykrVFs9FCRAWEk9oQZJC
 GPR7yxJeqWGQPlyCRXGhFaAcRGehrqRR6Q/NLSH0mUesk2nI6uFVYSrnLLpWFZJCSK5D
 QldA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYodQigHJCFzwAzRmsTS/y/Sl57jaV7cmLEH3j3Dk6xvhz45PjoXlSu15JpAk0dmgpkDOehCU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKk3Dy/u5ujDyUxwtEw1LfwFADM2tWjmcne05TpyG6FT96Rk/rg
 qTBu23PMsDohGsv+k8h54D3xUtKkQTprggK0Un/1hZD0HJYkG6YXn54cCukIw5yLIcI=
X-Gm-Gg: AYBFou1fi71qnkibal+cisFd0kALFtiChy16dJco3i+oRNiMah+gLP3ORbYSHpVImwO
 Zawh75RnMkUNA4XWNqExf304jDADc7oW2AoCKJVxOgH6Gt54CRkfTo1Lz9v4Y5bVZOZgtvtR5G/
 toP9QGbqb5PHBmH9DcWji1nO5btbIFtQcx8wGRk3x845+aTCdE08qp8UyfMf1IKffJUuF4J+7fY
 qKnxl2gReHB8F2iD4B7QZ1enJUQx7yTk3CjED2JxqOK9OCh1gMG+Ll1oZ7YmlzpEyC9vREVwOMA
 V4FiMURxGwej8BIxILyq/Q5BNR4diFAyib0aMSHQsnQ/HQFtCxQoU6sXe1YPHdF6KdCVi/Ul/lK
 ZRswYt8VHWUnmhwZLq8fiN6PuaZpxaOu1hcGORzxhswNMCi2ZcW66HRYUAdOofZqfRjRgcto5BN
 cD6MTOKYc8xXgB5JF1BKRY/ZhLyhPSj50QI7aGfoC1J8VbYAyds/xep2/KlEmo1DIJ9kKdshfVg
 Xa6bBtsQGSA3ZBI9GtrVDID5JjlHxHjOfDQI4aRVMQzV/EjrxCC5NVBZeDFPC3jVkK5Rsa3ksp2
 dcD9lI0GyCAye/FE7IQYC3/7Ft4uavMIqP911yA4JCB1iUgncn/lwBlMY1FmkIMMvd2o3S3em9u
 n
X-Received: by 2002:a05:6820:1356:b0:6de:2f70:dae3 with SMTP id
 006d021491bc7-7093f8a8aa1mr2486071eaf.29.1792620041750; 
 Wed, 21 Oct 2026 15:00:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70a49e2e00fsm1024023eaf.2.2026.10.21.15.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:00:40 -0700 (PDT)
Date: Wed, 21 Oct 2026 16:00:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org, Vignesh R <vigneshr@ti.com>,
 Ssunk <ssunkkan@gmail.com>, Jeffrey Yu <jeyu@issi.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: Re: [PATCH 2/2] spi: dw: Add supports_op function to reject
 unsupported transfer modes
Message-ID: <20261021220037.GJ3275858@bill-the-cat>
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
 <20260803-spi_fixes-v1-2-33f36e764104@oss.tenstorrent.com>
 <20261021205719.GA3366009@bill-the-cat>
 <CAEev2e-afN=ryWtttsRL7UYWqawRggTPA3jrn87Ux6h2YycTfQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zS1UWsXwxd/hEeGh"
Content-Disposition: inline
In-Reply-To: <CAEev2e-afN=ryWtttsRL7UYWqawRggTPA3jrn87Ux6h2YycTfQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--zS1UWsXwxd/hEeGh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 04:14:42PM -0500, Anirudh Srinivasan wrote:
> Hello Tom,
>=20
> On Wed, Oct 21, 2026 at 3:57=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, Aug 03, 2026 at 02:00:35PM -0500, Anirudh Srinivasan via U-Boot=
 wrote:
> >
> > > The designware spi driver doesn't support dual/quad/octal modes, but
> > > the driver still tries using these modes when it sees a capable flash
> > > chip in the devicetree. Add a supports_op function to this driver to
> > > prevent this from happening and force single lane operation.
> > >
> > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> >
> > This introduces a failure to build:
> > +(socfpga_secu1) arm-linux-gnueabi-ld: drivers/spi/designware_spi.o: in=
 function `dw_spi_supports_op':
> > +(socfpga_secu1) drivers/spi/designware_spi.c:707:(.text.dw_spi_support=
s_op+0x18): undefined reference to `spi_mem_default_supports_op'
> > +(socfpga_secu1) make[1]: *** [Makefile:2131: u-boot] Error 1
> > +(socfpga_secu1) make: *** [Makefile:189: __sub-make] Error 2
>=20
> Thanks for catching this. I think the solution would be for
> DESIGNWARE_SPI to select SPI_MEM. Other spi drivers that call this
> function also do this (nxp_xspi, spi-aspeed-smc, cadence_qspi....).
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index cfbedd64c4c..a5623a2cec6 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -222,6 +222,7 @@ config DAVINCI_SPI
>=20
>  config DESIGNWARE_SPI
>         bool "Designware SPI driver"
> +       select SPI_MEM
>         help
>           Enable the Designware SPI driver. This driver can be used to
>           access the SPI NOR flash on platforms embedding this Designware
>=20
>=20
> I will send a v2 with this fixed.

Yes, and please have that in its own patch as a bugfix. Thanks!

--=20
Tom

--zS1UWsXwxd/hEeGh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatk2AgAKCRAr4qD1Cr/k
CkpkAP4u0T/BTfN8idJFd5aYrVuUZyvgVx4QuCQiSoG0DuUNbwD+Im1nKJwjCJl8
EChBeGe5tfBOBzVCivOpWkszh4FIzQA=
=Jzr2
-----END PGP SIGNATURE-----

--zS1UWsXwxd/hEeGh--
