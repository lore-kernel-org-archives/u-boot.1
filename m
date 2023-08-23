Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F456EE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871FF8646D;
	Wed, 23 Aug 2023 16:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fLPiZNq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432498646D; Wed, 23 Aug 2023 16:42:07 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39B6786403
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bcbb0c40b1so4370468a34.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801724; x=1693406524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DSOOFK0DyGJ4YDOk+f9+FUOWkjPBArmKGM7rkoC4+6M=;
 b=fLPiZNq46KDAmsLZjJXsVhocAcFQanV/+LUPsIH09ylEATYxtUhYKPQIgcwkXEbdBE
 YByHbJ6ob2A2ACXAWI7QgWsuB6A6fd9D9Tkm4OjmgcHYRmc8eTQbbRJ8HkWzx2ipCkG1
 vTp94t87ySVanp4+LpLmgt4kCwMbv0IjJdZc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801724; x=1693406524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSOOFK0DyGJ4YDOk+f9+FUOWkjPBArmKGM7rkoC4+6M=;
 b=YBDNbmnoXr+WAF6OkrDBeA9u0Kc/0tnJMBOpvT/7qXAM66dy7FzIg2XCT0pPDKj/8s
 Z2zRcebm4PVm2fi6qArkDc0Ym1ff49iVI3113GVota8+fJJiPKTUc7bfflrxd5MdaSKV
 6fVORlb4kIFE5I5Gr2ozwYnjLrzupQdg4Hp51rEg2WfiCG6YpRqMYeb52zFq/yt2Z7cS
 0bAKzC/6DsTyc3chgDyPTKxv4A0Ioyy/3R+1u0EYEU1/WQO5Xd5/zXNW05TMz8Druzcm
 hjkkoHVDOsm0pGkcCzDTW2w7mDxYcOrtqevKayMLCQIxuCNk6sizSqebo1mnKXJ/bu2e
 Me1Q==
X-Gm-Message-State: AOJu0Yw+FfEkOuiEVGlbolNBKUkla+g06mcnOkX2nhsR13mmcfEMrwPN
 FjFaKiDKQfjddAXbVzGB72kTpw==
X-Google-Smtp-Source: AGHT+IHOg7O7m3bsj5nkf4CJzXJIhUR9vmH7Ob1fvjEQ4HbmMQbgz3oFOqHCp8vJjSC524iJpQ6F8g==
X-Received: by 2002:a05:6358:5923:b0:133:7f9:303f with SMTP id
 g35-20020a056358592300b0013307f9303fmr11013714rwf.23.1692801723715; 
 Wed, 23 Aug 2023 07:42:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a258047000000b00d7236548a62sm2745678ybn.14.2023.08.23.07.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:03 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 1/8] disk: Drop always true conditional check
Message-ID: <20230823144201.GS3953269@bill-the-cat>
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DDmIQ1JJuzFWLPni"
Content-Disposition: inline
In-Reply-To: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
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


--DDmIQ1JJuzFWLPni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:46:41AM +0200, Marek Vasut wrote:

> if (device_get_uclass_id(dev) =3D=3D UCLASS_PARTITION) is always
> true, because this disk_blk_read() function calls dev_get_blk()
> above and checks its return value for non-NULL. The dev_get_blk()
> performs the same device_get_uclass_id(dev) check and returns NULL
> if not UCLASS_PARTITION. Drop the duplicate check.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--DDmIQ1JJuzFWLPni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGrkACgkQFHw5/5Y0
tyx2twwAt7Zm0fOleGyNHmztNuaPQSIkoZs4kZ4s7D8Y54936IbRBuNfO7XYKgYq
DXgUTo4I38b1oZqvIDLLcuy4S6rbO59LfihfjjPDb1T8Zf/t7tJn5n0IoPKBZ5Z/
bbYx5F0m/7TPqHVuL+CRJONMOix4YCTpOlqZbMumK7Wy4xxrjCOcRBlSXENDtOyC
NJpy8mxQQeD8XVN70ppk4+pMIXL1zCLLTbLN4M+7IJBwPPDhDOwrfmIWWvgJ2z1S
r7y26snai3mcIGlHOdsj/Gw/XC6SzWVwxJwJTtsuNV2j7Ehkje54wuFrS0u9jI+S
c9iNIbi+Mc+8zOMhQbr6JZD2q/Q78rKFvnl2/n6u7YutMZhr9srqopQ7lSKANS6o
h8K8UnBPfdnrFgZo/M5Xd4CP3odI8i0ME0IO3d5Yhaaw3qvMWTyM5EAeb0grORVr
TCZhXoGVzlICkhkZMrLcyhCBHqLZTprdrLCi0I6xwBdUPhMgMtPkpGMxrJlrx4uu
QDG16Uam
=KPGb
-----END PGP SIGNATURE-----

--DDmIQ1JJuzFWLPni--
