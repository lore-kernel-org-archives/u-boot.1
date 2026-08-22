Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C183C5DF8C
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 20:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4C6D40731;
	Sat, 22 Aug 2026 20:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Le-67wzBDVsO; Sat, 22 Aug 2026 20:51:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787431894;
	bh=M9iGLgjkiIquDHPVz2vMYwx4KlCLdPOOZlhYVvAB8es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vyI2BwIYlyAaJq4HbE8M6c4MyWrvmcxPyZxGmXjYa9g4OGknLgcEo+VMciO7vqdVQ
	 bvI00cJP5HNdEwCcqsNg9hsTte2Co4GH9FN4azb2AQbTjzYRU+SEMwRqbzZqeQjVub
	 cEWw/AdK30DFE3aHWeo20EMjrKJZrQZViQYjSwjLPxJxWoDl4ckFxPknzlllMOjAaZ
	 y7yTtrIsaZF4vl7i3K0+w8wZoaNRxls/3Reh5Pdxoy47xa3znLqrk2pbHfB+7n0eTd
	 +X1jL52i9neCjBnYwCysHE19/yWArDRggSBRxvtqX/nUHLJ3yb/X1JTXiVsY4vp3Gr
	 UAqcn23AheGzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9DDF4070F;
	Sat, 22 Aug 2026 20:51:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E9E24279
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB88240116
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YbVNZJAJmWTM for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 20:51:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::;
 helo=mail-oa2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ePhLoq4x
Received: from mail-oa2-x00.google.com (mail-oa2-x00.google.com
 [IPv6:2607:f8b0:4864:30::])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F153C40076
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:51:31 +0000 (UTC)
Received: by mail-oa2-x00.google.com with SMTP id
 586e51a60fabf-451e8472960so1376746fac.1
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787431890; x=1788036690;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M9iGLgjkiIquDHPVz2vMYwx4KlCLdPOOZlhYVvAB8es=;
 b=ePhLoq4xhAMz/52bRoIKaQbNKEbgWKjTAXnDBq2tBDlqoSrlzUFnZ1xYu2ZYBH3433
 gIpt4KmC492cVsjiVkxYfiUmw2bXDszTBZpGpPyTzf4Kx3aUqOIMn7X3UkAjLiL1rSBh
 weabBckel8OoaW8hT0d/NKa37opKa8Pay2nzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787431890; x=1788036690;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M9iGLgjkiIquDHPVz2vMYwx4KlCLdPOOZlhYVvAB8es=;
 b=Mt9fAr9MSatE71t7QpDCNmnT8xzF9pJ6DWsPfOJ6V+iQSKaBFvFaSgTgYYZ33cvg9T
 kpiJhj6XuLOMeBjqeW+X+vcVvRveMtbNNHTcxip07Fe4NRiJCxyUr+8VjqeVMqnIAwDp
 +875YHwNHH4qpjXW5X82Voq8ZkHK+xdnAyWHeP5mQofvQyezJt5/YZdF8jnFpt4x7a6/
 OV/WTi8YipAvJGeKtp1gSwEDfYQcX5qx1pXDh9ds+32tLYMZE6331XNjOaiSsg17vVin
 RlAuJ+45yBbLOhadmZSGht+lEAQY4Nd7HGDuYitHg4ywYb4XKLR1nBwNfWazhp24WoR/
 NLrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrppVf2Hwdx6G0JU1fnWs9quyp6YiVMsJv5ddpO6UymZPvGOvW1Fohrkn0Tma787YZhO6ljtrc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nws3dNO+jDRRVkRNsvP4KiIBiaGGhRuuBYAC77hXd3d6O4wzC8
 TNGRl6+ox4mgWrIlf+MEzjA8lQGmB86tdxMxkDU3DVJlwn6c3MfSTXH3rGku+j5ZnMrHGTchVdV
 p697ye2xkYOqTUH4=
X-Gm-Gg: AR+sD12iYSqEWl+fYf7Zfi5JlOywu2rp1f0iBonCrBEq80NWUAVzVnGnrPvxrUjLNTp
 xODLybGQdDgwVINEA9kL6R/S8uLmWnaQLc7lJwdCKOca2r3imOzyJFbL19VgMuJsc26zSslMraA
 eXoKozMUcCZVSD7Z7dhiIbz8robQMtuUoOa88BZDuA1R60AS4PUAA+mckON76L+RnRhfGWse9IW
 uz8F6oYkxd7YGG/5B4FW1/QsjZGmJ/LZhjrqaLMtHeby0VbEmBgOEG5Utr5BSukAzD+zPyzdrmT
 j3w+vDcBk+90JmBz2c19Dq+2am2lroVg5Zf6YqiMVb2zfW1YDfrUJY3x/20IFizBe31q+VlCPzr
 xxTfxcCDSnzE0nm3NKbbNg/ioVXsGTWGV3YHYZRzl5s0urDT8syMjWaBYWds9otWm3XFDOtuOTQ
 3zDZZpOnE5qfSz915U6ICv9fJd4NAeWQWWEKRAgWAp+zUcbkKP5kMFHtz1E5dts3szt+rckU49h
 B9X2JEDuUJDXN9WbYrf98XBZHqp/oR0XJrQYvW+lMVUm8s8oMI6eYiGj1OzvUqBdQq03W+slIAz
 4JdRu0Z1Dw==
X-Received: by 2002:a05:6820:83c6:10b0:6b0:be69:d3cd with SMTP id
 006d021491bc7-6b1593b2035mr12664834eaf.17.1787431890328; 
 Sat, 22 Aug 2026 13:51:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13c90d160sm12266604eaf.0.2026.08.22.13.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 13:51:29 -0700 (PDT)
Date: Sat, 22 Aug 2026 14:51:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 14/19] board: emulation: Add qemu-loongarch
Message-ID: <20260822205127.GY523975@bill-the-cat>
References: <20260821084219.1703743-1-me@ziyao.cc>
 <20260821084219.1703743-15-me@ziyao.cc>
 <20260821162055.GO523975@bill-the-cat> <aooJQpeCbhlWkczO@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HLTQw0D8jS+bXQGo"
Content-Disposition: inline
In-Reply-To: <aooJQpeCbhlWkczO@pie>
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


--HLTQw0D8jS+bXQGo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 08:40:34PM +0000, Yao Zi wrote:
> On Fri, Aug 21, 2026 at 10:20:55AM -0600, Tom Rini wrote:
> > On Fri, Aug 21, 2026 at 08:42:14AM +0000, Yao Zi wrote:
> >=20
> > > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >=20
> > > Yet another generic QEMU VIRT machine.
> > >=20
> > > LoongArch QEMU splits the main RAM into two parts: the first 512M is
> > > placed at 0x0, and the rest is placed at 0x8000000. FDT locates at
> > > 0x100000. BIOS is mapped to the first flash mapped to 0x1c000000, whe=
re
> > > U-Boot starts execution.
> > >=20
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > [snip]
> > > diff --git a/arch/loongarch/dts/qemu-loongarch64.dts b/arch/loongarch=
/dts/qemu-loongarch64.dts
> > > new file mode 100644
> > > index 000000000000..39d303798fcb
> > > --- /dev/null
> > > +++ b/arch/loongarch/dts/qemu-loongarch64.dts
> > > @@ -0,0 +1,9 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +/ {
> > > +};
> >=20
> > I thought I had pushed everything so that we do not need to have fake
> > empty dts files anymore.
>=20
> Do you mean OF_OMIT_DTB? Even with it enabled, a devicetree blob,
> specified by CONFIG_dEFAULT_DEVICE_TREE, is always built, but not
> integrated in the final u-boot.bin.
>=20
> qemu_arm_defconfig also ships an empty devicetree. I'm not sure whether
> there's really a way to avoid building a dtb...

There is, but, OK, I didn't post a v2 of the series:
https://lore.kernel.org/u-boot/20260708013019.288985-1-trini@konsulko.com/
So, this comment doesn't apply as it's not something you can avoid doing
yet.

--=20
Tom

--HLTQw0D8jS+bXQGo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaooLywAKCRAr4qD1Cr/k
ClSwAP96JZFBFM95+3AqtudPFz7rq0wu2XrwFXs/DWTihb8m3gEA8ebivx1ENX1x
j9gvLee/avhrK14IStnUW/bfT5froQo=
=xvPW
-----END PGP SIGNATURE-----

--HLTQw0D8jS+bXQGo--
