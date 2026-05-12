Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A2ECD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7205838BB;
	Tue, 12 May 2026 19:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JCQ9sJ0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD74783C2B; Tue, 12 May 2026 19:09:44 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C249B8341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso4934121a34.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778605781; x=1779210581; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CkeFlvFVLaavx3d0556NinAaSkp3A/SxFkTwTglRz3k=;
 b=JCQ9sJ0FEHmqjFrgPmq277C5HZQ9SIyeT3k7nh7fa6X1dqCNMM7iBKNic8nNlezEcf
 S+6g+GscrI84zlAsgi2G+Y/XxSAFhLWaVvNPEl9Wxlo+IWX3kp/1/emzGBYEurhwk0ft
 yDn1piT7TN9lr2p4CdE8U7OKMYnYt2EMGgbGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778605781; x=1779210581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CkeFlvFVLaavx3d0556NinAaSkp3A/SxFkTwTglRz3k=;
 b=K4u4Mcr8l0RdYPpNHrJ1xEa0rMCTB0fgwFn1rnAFhqKnjmITAJ1MHkH2f+PVGzkjwG
 EqRT3RLKqZlyt/KdlwDldJy6TnKjIx9OxsDGuaBVXXwc1iS8nCBanDZymk2VHQGpBnF5
 i5o28nt3yjvxgGhMcAYcgoLuWnkMBgYLg5csepHKa43uia1rxtU/OSf38q/iahtXBLsy
 wsfAkpa2qR2EKLQ+wPuzqG+DELwimlJ+L523NaN60kMdK923bjev4uUZIVPD4Fkp0xGr
 1fKg4v3TobSXf1nhTVnJdbFfikCG9Za0hBrnVdI6AUZmCHDvyZ40eliS7Q4tONF4HIEv
 PBeA==
X-Gm-Message-State: AOJu0YwpJvyrF08l2H2OluFCeNuBlmyVuvNCT1v58Klfw+5zYSQ3Kyfu
 qaFQNUBZWYXnGXxNFceJ841ylkNvLQqFvBd+HWLX5hvNsa3oeErfx/Pxx0EPyq2Le/U=
X-Gm-Gg: Acq92OHnnQBrN6vdRmzPTjtyen5hdaqDInTD/g/a0Og0Yz4NDV68cmKcBYCSPQzQ2we
 4x3Fm7e2BDVKwkiQBCA5RCReJole7z3oLeqnSGke5xeBECAD77Fl/m8k7GjYIiQ8PEdL1V8Ku5Q
 PZWd28XUP3OoJ3vHpe7YFexe9FhP5Jx58HW1mVMiNNkXASO9dE5dYSAPJo94CGZWpBTycLXfg0x
 zTdp8hSyfb87zS/Gtq+x9ykhPyG5bkiv1q7ZhxSxXRptajfbQP8cHApkXz1bV/RG/X6wvAwI1Xz
 7vy/BQh1VWiZEQtlplRGYPLceb5qjkpx5v7/HJaHUZ7upBaKqydKXHu4C4BolypDMGR5ez2Rc0I
 Lc6FJdYy9SeqxJ4AUrdon0tRUtCnikhCduar07Ehlmgi/3QYoe1Jmicq+KeXPqmXI6ZbHv2aTeD
 osocBfCD75ZFvWGGYTYwRwd7tn9HllCRAFF0P7M4Dob4G9cx/2rlQsy8G2K10z8oq4pSDBaWTwF
 y9dvT6Req5JxcTaGap3+PyYYi7NybIIxFSZqRrhBOQncqwKQvg=
X-Received: by 2002:a05:6830:6182:b0:7d9:b58e:55f2 with SMTP id
 46e09a7af769-7e3c3fe2b7fmr2178469a34.24.1778605781508; 
 Tue, 12 May 2026 10:09:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm8931249a34.23.2026.05.12.10.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 10:09:40 -0700 (PDT)
Date: Tue, 12 May 2026 11:09:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] video console: add 6x8 console font from linux
Message-ID: <20260512170938.GO1858239@bill-the-cat>
References: <20260512-font6x8-v1-1-8cee71a7cc71@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6WTQXtwJ+WaW8icc"
Content-Disposition: inline
In-Reply-To: <20260512-font6x8-v1-1-8cee71a7cc71@flipper.net>
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


--6WTQXtwJ+WaW8icc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 04:38:14PM +0400, Alexey Charkov wrote:

> Small screens on the order of 256x144 pixels can't fit much text at 8x16,
> and 4x6 is virtually illegible, so add an in-between 6x8 font from Linux.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

The commit message needs to say what commit / release from Linux this is
taken from, and since it's not obvious what file this is based on, that
should be in the commit message and...

[snip]
> diff --git a/include/video_font_6x8.h b/include/video_font_6x8.h
> new file mode 100644
> index 000000000000..c338377a0bd2
> --- /dev/null
> +++ b/include/video_font_6x8.h
> @@ -0,0 +1,2574 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * 6x8 bitmap font from the Linux kernel adapted for U-boot video console
> + */

here as well. Thanks!

--=20
Tom

--6WTQXtwJ+WaW8icc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagNezwAKCRAr4qD1Cr/k
CpVKAP4jVTbEnjetRIY1gpveCrtzdMnByl50r9RtYE4HVYOv+QD/aS4bdVEEyy5t
NVGmRviqZjDOP1C2x/uvpdxKEon03AU=
=EFG8
-----END PGP SIGNATURE-----

--6WTQXtwJ+WaW8icc--
