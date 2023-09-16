Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E75C2BA2B
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 22:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F3B85E44;
	Sun, 17 Sep 2023 00:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s5JY0XsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C466C85E44; Sun, 17 Sep 2023 00:38:14 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B815685DFA
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 00:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d81d09d883dso1665506276.0
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694903891; x=1695508691; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m0tJScoyyXBDx127g74wQQbEbfQi3H6EbfwzeDWjwVY=;
 b=s5JY0XsYTXs8j6pGmYsPKR4c+MTrDFsf/TrHW2tvvfC6EqPSwpUeO+YpeBk1bkg5nM
 VRI6mOqKDPiposdEulPfh3vD0BVLyoFs3Z3oAHs0p479ucGt0VznCD1OwhSpyMtXIHdi
 hUuslgdiGqCDVkikYc7yVoQvbM86T/awxLRLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694903891; x=1695508691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0tJScoyyXBDx127g74wQQbEbfQi3H6EbfwzeDWjwVY=;
 b=tVayaZH8rh2uXnIFLvz2ltRHTxmZjlGheEkuwYnuJPlwzzyUzhqUD7fWVFPcqNyGc3
 CeH3QmIE0I+Iq7EsHQLv29YhMbSheP76fxyA65OH/So9nA6e84vWvcYc+3m0S3/xJ1Tb
 LNONAtwcCZMyPnGegU6RX2RPR9C1nYhuhRXnemL6dACVbW5x8PJR2H8Ie8En7m2JH4SG
 Elc+9SyXtJLRonW/5ZsKiNbc1Pf/Z38xrYtBP3G2sKQwFoH6RL6mvYKyIKHo+g7ZxVbi
 GpzEMOpUREutelx+qpndQTV0L5mjEcxe4zDtrygVeW6MGtPeC0dyJ219xHeku2j+/5pr
 TRfw==
X-Gm-Message-State: AOJu0YxVF7o11cK/ULSm6vRqatSEyOxJIhhh6HdpGkw4td04igHuW7eQ
 WOExBgqQXMkQfAlrV7niNTGq9A==
X-Google-Smtp-Source: AGHT+IHk+teSAXxOrRJWuOf6v/HIsd8bxiI4XSCGLM56X13KljbeOJm5Pz14GLGAjku/833V1y9ipg==
X-Received: by 2002:a5b:644:0:b0:d09:96fe:ac23 with SMTP id
 o4-20020a5b0644000000b00d0996feac23mr3925560ybq.3.1694903891402; 
 Sat, 16 Sep 2023 15:38:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7b8e-9e18-0a32-e8bf.res6.spectrum.com.
 [2603:6081:7b00:6400:7b8e:9e18:a32:e8bf])
 by smtp.gmail.com with ESMTPSA id
 v82-20020a252f55000000b00d8161769507sm1456006ybv.25.2023.09.16.15.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 15:38:10 -0700 (PDT)
Date: Sat, 16 Sep 2023 18:38:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Ryan Lahfa <ryan-uboot@lahfa.xyz>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Zhaofeng Li <hello@zhaofeng.li>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ramon Fried <rfried.dev@gmail.com>, Artem Lapkin <email2tema@gmail.com>
Subject: Re: [PATCH] boot/pxe-utils: populate initrd_filesize for extlinux boot
Message-ID: <20230916223808.GJ305624@bill-the-cat>
References: <20230916131812.4035430-1-ryan-uboot@lahfa.xyz>
 <20230916131812.4035430-3-ryan-uboot@lahfa.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5SvUcNb2uDPYpeiF"
Content-Disposition: inline
In-Reply-To: <20230916131812.4035430-3-ryan-uboot@lahfa.xyz>
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


--5SvUcNb2uDPYpeiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 03:14:58PM +0200, Ryan Lahfa wrote:

> Currently, it seems like the `initrd_filesize` was uninitialized for a
> while.
>=20
> This is particularly problematic when attempting to `zboot` with a
> initrd with a size coming from `label->initrd`, because it will provide
> you with a 0-long initrd at boot time, making the kernel fail to
> continue the boot.
>=20
> This fixes the issue and I confirmed it enable me booting a U-Boot on
> QEMU x86_64 q35 with NixOS kernel and initrds.
>=20
> Signed-off-by: Ryan Lahfa <ryan-uboot@lahfa.xyz>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Zhaofeng Li <hello@zhaofeng.li>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Artem Lapkin <email2tema@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

And since you mentioned it in the follow-up, here's the tag so patchwork
will pick it up:

Fixes: 085cbdafca9c ("pxe: simplify label_boot()")

Thanks!

--=20
Tom

--5SvUcNb2uDPYpeiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUGLlAACgkQFHw5/5Y0
tyxOmAv9HmiETbtQKB1hBtV1Yn8GL+MyN3eORvGBuVojBSHDE9+ahSorXNjH50U8
SdE1mpXjEZ8nxhZv33G0MVcgUpgap5192WwafRbuqWRS9u5z8aqxmeFUBhOZURO9
vQ3EHtkGd8U8UhDT4GOrFrQy2Lo/srbofcOlrYEcNsPfamX/RMg4LBXHE2eYEUlP
SPD19trbDjx5PsWgzSa7EaOSEfCBCCNDRwf2AtNb49EajlUzVbMuSbeM/ANJU5Nx
7xh4+ITayPji+mmqKiGJ8KM0y2fBFZ6kzAcguQNs3OUUSzGQ0z3IN97mOFkZ55On
fXqQsMVQPAXYRpElhQdkTeOm+k3wc0lIbfT/ZhRWyjOGoP8oY6yeRiryxhMaORum
OOI3QVHZNXjn5A5KPFIuY8mDsqkLj57kx5s6CIDOstGdBfYwfsjzC2SBvAjqekNv
b6/gixNwh/E7wivlLqsj/iusf/ooICb4x9xUgtE2MFVkZUf7lbPDLc5S64JuEm4m
0KBbM66g
=Q0dN
-----END PGP SIGNATURE-----

--5SvUcNb2uDPYpeiF--
