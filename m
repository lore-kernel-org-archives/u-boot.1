Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC2A109C058
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 18:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5465783E76;
	Wed, 25 Mar 2026 19:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Od3F8rd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FBE683F6D; Wed, 25 Mar 2026 19:33:52 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4AEC83DA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 19:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-467e8aaa865so55408b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774463628; x=1775068428; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cSVIMzStd8iA9dq9sFlBOCCsSdrbdM1i8uX/yTkb4NI=;
 b=Od3F8rd+xIoLixT/c/zPbvaT32agRZNwgcyHWKg7ap+Bf8aZrlTYqMW06sNOr6B0xt
 jPVi7Cn6zCQMGw5L5IRtu+edyg5YfPN9rpZ3R+uIZAX4T2+wE2i0umrWqcsvQjFyIv+Y
 oCPCVLX9kZUVv6soBbE5Q+74MJrjN9lC6vn9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774463628; x=1775068428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSVIMzStd8iA9dq9sFlBOCCsSdrbdM1i8uX/yTkb4NI=;
 b=RAUhCm6UsM/7oyPGNOebKKJL7Wmnr9MSvqEmVWQcfc6oDP6RerhpJBnP/Q2saCMU7G
 R6MUKjaXEisuVANcXs6ECVgzS4dAKg4++arIEVVZ8Dcj453vR+1u9goV7XJ9zc4DNjwf
 v6/pav0iLAFaIPOMzqu3CPN5BoqFtpKwX6ZVQQh6RvPBdtlS2vTLmZtnF4skojLSgVoH
 soQNLEpcqnnZNPd7Q4PN9AOk3eE9bB4v+S9n2I66BQXxKn0rvNgMwE/0m/+irB2mrAyV
 +moPq5gkZhfZW7sYSiJlye4Qc0ObVJeIXjfsku3Wej3/Z0FnXtu0MzIwW7xQNQEvhjjn
 6gMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFB8whYRxJbsXsg960AvzwZcgclyqDxMxM0LEevB9l3asMGZlzseSxEULKX5mhRJARKnKdw1E=@lists.denx.de
X-Gm-Message-State: AOJu0Yxtmus3uZhMq97ofNEFKYmafjoI00JmtE1k/1279jjuTa1TBVsa
 fQxkZb43f+TsFj56QEcQzQdeBP2Bq0Jm36/VAkM7yLzZzTKFGPgqGqLAblFl98gVCXX+h64+Dle
 Kje0bZ4Q=
X-Gm-Gg: ATEYQzxxiMhWDnOVHLX3090uXBcejr8w/gV8gZ59aig/V7K2p/9EG/U1yK0QA7BDGzh
 caoibRqH6zbc+kUMVk9Djdr97QeI6v0S5ThNVq1zMq2sCxqC62CyaW23HaIyrHmJlyBzVIiqn3q
 LoFMN9P9r/1w2bIIPRKxe0z8IL1HdAegYfB2kbkJx6QywOGIExOTgcnE6ujfKqZzS4EMUkrk8GA
 DH6QPfyNViahAmzjGFmYT0rjpFFAf9EI9HmlrYpLiR5Hrb/oFnpiQbIqjeraYvF0RJfdv65EGqU
 deqHxno0CiPzZL7ZHGwI7cSl16p7jyEBcgSNyrb/1a7TRuogvYACdgpyFI2LOX4PiOwrayURHJO
 6SIR2Qhb5GceKb5Ko2albSaAhR2FyJwgGcGVf0/nAhsV6Rr2kV4xLnkWvbzV2zsrfr0vQE80myX
 EeCD9ksUOPucS7VhAh8Ebs+7pts7m3skaJwfqbuW5r+qTvCvDxKYeTjLLbvDQNrkGeR8pVKOkp/
 LSfKl2Wv/CeTMYZUZQUyoKcXYSkgEUStkL8fHhpnU1sCkPo
X-Received: by 2002:a05:6808:22a1:b0:467:1e7b:72de with SMTP id
 5614622812f47-46a5c5552a2mr2257698b6e.2.1774463628588; 
 Wed, 25 Mar 2026 11:33:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a703c406asm227379b6e.0.2026.03.25.11.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 11:33:47 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:33:45 -0600
From: Tom Rini <trini@konsulko.com>
To: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 6/8] board: tqma7: add code for u-boot with spl
Message-ID: <20260325183345.GW502704@bill-the-cat>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-7-Alexander.Feilke@ew.tq-group.com>
 <699c7adc-d636-4ef3-9844-52a28333ef0c@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g0EC2x7LXh8BV/Ez"
Content-Disposition: inline
In-Reply-To: <699c7adc-d636-4ef3-9844-52a28333ef0c@ew.tq-group.com>
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


--g0EC2x7LXh8BV/Ez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 06:50:59PM +0100, Feilke, Alexander wrote:

> Hi,
>=20
> Please wait with applying the series. I just stumbled over a weird issue
> related to the environment.
>=20
> The default rootpath is set to `rootpath=3D"/srv/nfs"` (with quotes).
> This is wrong. Running `env default rootpath` will reset it correctly
> to rootpath=3D/srv/nfs
> However, `env default -fa` resets it back to `rootpath=3D"/srv/nfs"`
>=20
> Independently of that, the variables inside load_nfs are not being replac=
ed
> correctly. They appear to be empty, as I get `Filename '/'.` in the run l=
og
> when it should be something like `Filename '/srv/nfs/boot/imx7d-mba7.dtb'`
>=20
> We will fix this before the patch should be accepted. The first issue see=
ms
> pretty weird tho. Any idea what might be causing this?

Using plain text environment can be funny about quotes, especially when
dealing with values that come from another CONFIG option and so come
=66rom Kconfig. One thing to look at, at least while debugging, is that
"make u-boot-initial-env" will give you the resulting environment in
u-boot-initial-env so you can check the output quicker than flashing
cycles. If there's a quoting issue, commit b3087d21f022 ("env: Provide
another work-around for unquoting fdtfile") may get you pointed in the
right direction for a solution at least.

--=20
Tom

--g0EC2x7LXh8BV/Ez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacQqiQAKCRAr4qD1Cr/k
Cp0BAQD4UdI6cHhxe7i80khmWwSay67G1ePvXTUMbtfdIAsqfwEAzRrog5lxN2vQ
Qhi1JF14jR7MoTr8FzfhGAKTSQjqsAg=
=Ewtc
-----END PGP SIGNATURE-----

--g0EC2x7LXh8BV/Ez--
