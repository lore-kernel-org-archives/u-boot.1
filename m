Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79162C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E52D382BF2;
	Wed, 30 Apr 2025 19:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MWYUj+Vv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C664A82BF6; Wed, 30 Apr 2025 19:01:44 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E0F782BB4
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7306482f958so31044a34.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746032501; x=1746637301; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v7ejOORqcOW2GSUPEnpgco/Z1dcK5N2TQkczr2+WgAA=;
 b=MWYUj+Vvgl/iaz/RzveXlUUWK5BMea9DveTm7RkjfcDp8lVjbiZIjb5n4uJ85iwliV
 I7SFUV+c+B+7UB1pzoGJqOlwREiFrXR8qQ6xavsflRAqBL8a04TrB/KqJIPGA/Ldn862
 zRaZjs/V1Ke7nMoDZLcinb5HcOVS+nRZwo/yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032501; x=1746637301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7ejOORqcOW2GSUPEnpgco/Z1dcK5N2TQkczr2+WgAA=;
 b=tkHwmnhh3+N55BfFs0ZXQOOf7d7dKDN32sFHFfrxbyWc33YiDWg545ZrHle4xQuAPd
 IjtHu9gdkqbIUfJYexYH9FByslBAbMxs1FgvbsvLDcUcpTAxJwGoN/X1y0BpMrT/Yq9z
 7cshhumBGrNok1QuKKt+R/OMY/DjbsTrU7Mw9mAdQnnLBVXv3MSfq1dzaZHLode5TjBT
 eQ/a5gbUXPDYutrdYubZIB7EORU0aJc85/8YfvA8I8wIPh/AzpBBdLaddgyV+W2jTUti
 Lda9pWpdM7XsboziTnnYAIaI5JPQk5AnBg8zI/dEVCm6wJydrQ2FJvYSY9sCwNqX2Mrt
 4wZg==
X-Gm-Message-State: AOJu0YwNUnrl5hujn+H6NfjGSd/XQ/1NqPPSxVezE7xFDfLLipgmYk+x
 tqYJ+YMgXttfJNSfkWgCLuur69LWNNwj0XgnacqCs0g+gp46v7QncsrhopPYCws=
X-Gm-Gg: ASbGncvB8Lgduhq85SJkrG9AfbSEUpMDxUTHr+WAclW7BRCN8Uol9vexc2Xv0j223vI
 fQMN3GmbY+GSUStSS5ctByc5xxuZ7Bgu9d1xBZcbTqP4HcxWCaTA04u9CHwV8adJx4TAPdaGMma
 P91KZHzPG89ta/yVpJNIqcf/0EnVXT2r0JgJq3e35Oo+wr/SrB4lEUPQH4UO3+n0adRRNTDIwM4
 8y8mLWH3sDqiTARhgfYq3YoqPWidbKcTQnYqXS82iVot63/XZbbwPuC7h0z7H4JdQQDX1KWojYM
 lHcy8xRuV1PZ4rFYUIIte6jaWyJNWitWK77eWW0/dMtes0OtSQ9qFtL0JWvTlHpZ9BtQUiQbx2U
 hxQ==
X-Google-Smtp-Source: AGHT+IHJcE6IsPzSqVZSl/RqZJCsVYdPkRcsowYm8MdXxtFxTV2N5bKCst7eWUcmGAq+wCcp1+iv/g==
X-Received: by 2002:a05:6830:6189:b0:72b:81df:caf9 with SMTP id
 46e09a7af769-731c24b824fmr2583024a34.8.1746032500818; 
 Wed, 30 Apr 2025 10:01:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b1315cfsm950880a34.34.2025.04.30.10.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:01:40 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:01:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250430170137.GW1261075@bill-the-cat>
References: <20250428215930.GI5495@bill-the-cat>
 <19a791c9-19b9-47cd-9444-24846ae5c222@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w6s+cFGhjHCl/ow2"
Content-Disposition: inline
In-Reply-To: <19a791c9-19b9-47cd-9444-24846ae5c222@denx.de>
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


--w6s+cFGhjHCl/ow2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 06:50:50PM +0200, Marek Vasut wrote:
> On 4/28/25 11:59 PM, Tom Rini wrote:
>  > ______________________________________________________________________=
__________________________________
> > *** CID 550306:  Control flow issues  (DEADCODE)
> > /fs/exfat/io.c: 547 in exfat_generic_pwrite()
> > 541             int rc;
> > 542             cluster_t cluster;
> > 543             const char* bufp =3D buffer;
> > 544             off_t lsize, loffset, remainder;
> > 545
> > 546             if (offset < 0)
> > > > >      CID 550306:  Control flow issues  (DEADCODE)
> > > > >      Execution cannot reach this statement: "return -22L;".
> > 547                     return -EINVAL;
> > 548             if (uoffset > node->size)
> > 549             {
> > 550                     rc =3D exfat_truncate(ef, node, uoffset, true);
> > 551                     if (rc !=3D 0)
> > 552                             return rc;
>=20
> This one is I think false positive, off_t can be signed integer, so the
> check should be in place.

I've updated Coverity with this comment.

> > ** CID 550305:  Security best practices violations  (STRING_OVERFLOW)
> > /fs/exfat/io.c: 739 in exfat_fs_opendir()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 550305:  Security best practices violations  (STRING_OVERFLOW)
> > /fs/exfat/io.c: 739 in exfat_fs_opendir()
> > 733                     return err;
> > 734
> > 735             dirs =3D calloc(1, sizeof(*dirs));
> > 736             if (!dirs)
> > 737                     return -ENOMEM;
> > 738
> > > > >      CID 550305:  Security best practices violations  (STRING_OVE=
RFLOW)
> > > > >      You might overrun the 1024-character fixed-size string
> > "dirs->dirname" by copying "filename" without checking the length.
> > 739             strcpy(dirs->dirname, filename);
> > 740             dirs->offset =3D -1;
> > 741
> > 742             *dirsp =3D &dirs->fs_dirs;
> > 743
> > 744             return 0;
> >=20
> > ** CID 550304:  Error handling issues  (NEGATIVE_RETURNS)
> > /tools/fit_check_sign.c: 98 in main()
>=20
> Fixed:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20250430164559.27095-1-m=
arex@denx.de/
>=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
> > /fs/exfat/utils.c: 146 in exfat_humanize_bytes()
> > 140             /* 16 EB (minus 1 byte) is the largest size that can be
> > represented by
> > 141                uint64_t */
> > 142             const char* units[] =3D {"bytes", "KB", "MB", "GB", "TB=
",
> > "PB", "EB"};
> > 143             uint64_t divisor =3D 1;
> > 144             uint64_t temp =3D 0;
> > 145
> > > > >      CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
> > > > >      Expression "divisor", overflows the type of "divisor", which=
 is
> > type "uint64_t".
> > 146             for (i =3D 0; ; i++, divisor *=3D 1024)
> > 147             {
> > 148                     temp =3D (value + divisor / 2) / divisor;
> > 149
> > 150                     if (temp =3D=3D 0)
> > 151                             break;
> Fixed:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20250430164559.27095-2-m=
arex@denx.de/

Thanks!

--=20
Tom

--w6s+cFGhjHCl/ow2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSV24ACgkQFHw5/5Y0
tyyNKgv9GyLGybk3Ai2WsvH6QbidP/BAl8KyVcekQ+7GrjQibprzP8CV/6IilC+x
q7wzFE7zPRXxaa48TVWTQ8FjUz2N7A2whLspqQJJYpr17Pcb21SuTgvh6Rj8A3v7
qbpFpIkN0FcYbqD+z8Xx0PRdhDg6ZGUnUV9WJAXNOqKLcrsnsiUtaiQLwed0PSrr
3EMpdlRqARpnAmdCbKvkGu8OfULMG/05UphU2r1FMuZe6aiYviKEB12ZGuhf5vnT
RIt1oK4FHPCfxC95r9zbjRP6ymxRV6owdwHgS4+imN/YHG2kwfe9Z61i9Mc+xLKr
7qtlGpIKDNg9brtgqAWfbLM9rOGVfa2PM8Ahb+FvYXxVQoINZLF2BdfnV7A8DXyF
7F/AxPP5CDnnnHF5ZGpeMAlEDwU7KygjZZJbdpUdvVBazytft+NCx+GYBrd3FCe/
pA2BGfsilUdumIfioGn4twhPjJ1ZKm4N+u9pFvrJE+jPF+zjO+BGUjt1DZ7lwbv/
BazDGzNh
=6S1g
-----END PGP SIGNATURE-----

--w6s+cFGhjHCl/ow2--
