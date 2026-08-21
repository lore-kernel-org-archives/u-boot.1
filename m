Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06613C5DF97
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 16:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68ACB60AA1;
	Fri, 21 Aug 2026 16:21:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ursy7DjIuTaQ; Fri, 21 Aug 2026 16:21:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787329265;
	bh=XZnA62XIr18shssMyhfk9Gdy1f+hoWxVE+rzxjnzR7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LAE81L0PsP7ozMyMH7mlUCe8zxe0yxzFd59QnycwerLAJROheU5xPcEY6s3Vae+OB
	 Lz4nFoAb6O/RnwyWLonbjDdFxC7glQQ/bEG95VgyaUFSqxs+6QDOlXJNgsCZ3xzNeX
	 nmfD0qA4obvgZMqBIUZIO0gLDH78/AfjeqlUlVXH5z15QqZSjjWIq/bx0bR+DlUMye
	 Rgn9Wq8NZJtRrOegQ9LNsW/68LxidYN+2Rf3REQDBdaHZpBs084EwZE35n7y+m5VWt
	 v9U8+IkGsdzU0GKgoUe0kuyn2+iq7um5I+nW7QHse3clf3PgStlxtmit1C3BarnFIF
	 1A2eCSwVgWRnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8060160896;
	Fri, 21 Aug 2026 16:21:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 65E294B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:21:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BBB7812F9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:21:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jckZAhuo9xbq for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 16:21:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=qB2bBy4Y
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70B4181175
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:21:00 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66c83e34212so1519987d50.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787329260; x=1787934060;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XZnA62XIr18shssMyhfk9Gdy1f+hoWxVE+rzxjnzR7I=;
 b=qB2bBy4YC6fupc3BYhZoaOguhRmYsYAnFmsDil/DDO9WwR0LTG9wRmiKdU+97InyKa
 ZDCNGVbKkAjktZbiqfOQkgRH4YjXmEy0btCnS2uw/qCUdMkbPp1qMfP+TnED5o4t1aqH
 bAoueBptILpl5Rh5IqtbEEfFOFLXnooKGaYSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787329260; x=1787934060;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XZnA62XIr18shssMyhfk9Gdy1f+hoWxVE+rzxjnzR7I=;
 b=FX/s/wRvy8yK/JCZ3EvLgh+ddIbRctA6SgwZtop5BSeLZbx7UPdRlq+HcdZM23iQvV
 nEMnHxomLXO5kv2CqDOnNMAZB4PvvX7a463agy/ci99EI81ygLb48TdKRzMCS8FS7pXH
 GtIdQund0ZpMdHO1jUkKi9yp6Q2iC3FQoxm44XuSu1uFh59zI2ly5vNsXkZ6ZbAd70rG
 mP5k5T0lrSmLbiOpUxGuMjUx6HRUv6WkDqRqddFF+xSza71iHAiyqFN57Dza/1o6EewO
 NS0ZdaizGDEIBu9YbjVQmyl22RbTIgOB5ypIjiLxmDiHCDXrkElCQQqwXZB3QQYx9hO+
 4kHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6jS+rH8rkajDMxzX4n342xWvLWQap+eisVB/5t/tdliQaH+P/o/AW0AZFqcGIobLVRuh0vyI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mtwIBY5iKQlBV43/QcPyV377HBWvTfk0x3uoLmZS3etmYQWLRr
 BnnHCk5RKwdH0zsVtMfJ6xa0aGTGzEc0puraBMQii3UOTDiu4QXW/qyyU3+Ob2FfrCGkHrV76ux
 ztupcfz+HCt4W
X-Gm-Gg: AR+sD10PHHh8/2A3a9PuyxUExvL2cdbAlprSVIKmukwzTCXv3pOog5h3WH8jQV42zhC
 8k9TA3PC3LE9yqd3SV2ObZRBsQWqfa+zKh7hkaRhQnDX6QdSzivgru/LirFc6ZKeVZ02w124Jbf
 JrJVXqqNTUvzHiZvInjUTP02uXHNinka/HVXreaodsL8mRLluCM5UBU2DbAjg18li6nWHBQGSom
 +rbSP6VX0WD8Cbe9KJpfVelY2iD4TyCFMPTKuFDGBkQXMdkSSo/NYngyI5YkA8DBCYvIeXYE9CS
 6kjU2ycp+mUOUiBQBG4yRDFs71lUk4oZVu1PcBSmHEzsQxmlXCzpMBhSLWK9y4Tyil4Gpuv77uW
 Iqn1O2F8EbDQzoZVu8HEIWRf1wPOqz/pptyG/rurtfRnwX9Cc1boswiTFHw8ASZaQL8Hs6dGmLq
 +X288Soo1B52FdoAoidA9rRSMNarikGIFoG8zruu4r45A2/Bp19eSW3Kjtly7pn/gJ/mTjbGK6R
 jPthzuXMieEuTg4nlY/LY7KSkFlzrBH6wF/BlcNJd+9CzRhaoKfwlnO8ZtVQW8U8kwKik0I69UD
 vooLVYZo3w==
X-Received: by 2002:a05:690e:4349:b0:66c:6aeb:3a38 with SMTP id
 956f58d0204a3-66ce4a6b47emr2617784d50.20.1787329259634; 
 Fri, 21 Aug 2026 09:20:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccb1737ccsm4659742d50.16.2026.08.21.09.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 09:20:58 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:20:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 14/19] board: emulation: Add qemu-loongarch
Message-ID: <20260821162055.GO523975@bill-the-cat>
References: <20260821084219.1703743-1-me@ziyao.cc>
 <20260821084219.1703743-15-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="POnAC+QdIYlENH1d"
Content-Disposition: inline
In-Reply-To: <20260821084219.1703743-15-me@ziyao.cc>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--POnAC+QdIYlENH1d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 08:42:14AM +0000, Yao Zi wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> Yet another generic QEMU VIRT machine.
>=20
> LoongArch QEMU splits the main RAM into two parts: the first 512M is
> placed at 0x0, and the rest is placed at 0x8000000. FDT locates at
> 0x100000. BIOS is mapped to the first flash mapped to 0x1c000000, where
> U-Boot starts execution.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
[snip]
> diff --git a/arch/loongarch/dts/qemu-loongarch64.dts b/arch/loongarch/dts=
/qemu-loongarch64.dts
> new file mode 100644
> index 000000000000..39d303798fcb
> --- /dev/null
> +++ b/arch/loongarch/dts/qemu-loongarch64.dts
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +};

I thought I had pushed everything so that we do not need to have fake
empty dts files anymore.

--=20
Tom

--POnAC+QdIYlENH1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoh65wAKCRAr4qD1Cr/k
CqArAQDl3orVdi3W78C85pCC7MhIc8XWI0Fx7BADs39QmytX3AEAqGiMcDDSPRZV
bUzh9BqVjgebe0gy92aohED8u/oLeg4=
=kfkg
-----END PGP SIGNATURE-----

--POnAC+QdIYlENH1d--
