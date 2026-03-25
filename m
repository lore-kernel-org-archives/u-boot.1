Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4D3109C048
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87830838BB;
	Wed, 25 Mar 2026 17:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MxbVqRE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 071FE83A91; Wed, 25 Mar 2026 17:54:27 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA71881E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4094b31a037so59637fac.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774457663; x=1775062463; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lger8soUN0DkzqUK3ISYHnmhj1vt3o4EaG5spU1kipA=;
 b=MxbVqRE45mDGIQddVrksZnqevCyzgf5CWyxGzhNjs/I4lSdxlJaZn87dEr9ye06dBW
 8SeU1UhihCAA4F21foJvWGxQfFBSmu1WY4EAhhjmzWDpEbk8lOPwJ7PQhKRpkjkLblqH
 MLSQ1lb1O9ztjG8meTDv01/gUiUTBfnU7PTbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457663; x=1775062463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lger8soUN0DkzqUK3ISYHnmhj1vt3o4EaG5spU1kipA=;
 b=KyUHubnNjPXHbqQ9Sx9Q87paEfDwiSiMAMzpNDtRkcIcl75S6pFiGMsGgxE8vUneh9
 IXs3Tg/f/Y5zclevN9JuO7rybWRFw1meo2rDUaO54Ss3zwk5djkmuva5rfDhLGmHSlXQ
 VkM/k85H3uY3aEo0g54B1MoKeGvPWToSKY87g3mVGHoRAU5aKghsFHPeuH98z5dAfDZr
 luqw4CR81yN6PpNpAHId1DV4lWoeK7OhQbmyuPg8bjsYogOxn5b+f1WO63STW/8sOmRq
 O1EiilRitfnIq+CoYgDJkLUGEnSqSQn/GCBbXTwAfwXzn1WRaZHGUb/g7i7CjLVaG2Yj
 rn6w==
X-Gm-Message-State: AOJu0YwASFJk94lOncRVtCCT9FOhKB2G8A23CYzgFnEdpdpRrGsC4WZx
 YSIYtWXKGc4xvjVo2y9w95AEdxeskCB/vHv5QKx+7aEplpbrQ+SpfYyyNf/qF0E3DLA=
X-Gm-Gg: ATEYQzyEPs70DchSsYBMqBxI2Fb45gnhhhLyhcL2jBeKusyoRMplD/84PPe9hW7b584
 nSLXOMmEgaqHtTxdVp6dwDCU6OE0s2KtshSy0uzshJ3QgBA9LQBA/Jtu5pNioYkznyFWGRHxNCR
 p/mfvkLj1EtcLydlInVKpzkUV3VUazVNml3AHlHasmQySrzcdFdp9Ik4MsIrrqnA3g8L994QQX7
 jk9yIPCyBgB40r53LfU0AsBbZTjNmEDxFl7tltEmSfY7uY+IGPrirFfz8rUodmBijZAVhsLm3r9
 2pWayQvxwzaP1UgOuq28fzj2KEIv/0Nvl55OM1PcjjaKtznf2h4Gty9JuU+Uf0jklYrrTk/Yds0
 rckty4ASKOtGK1jSsInNOVptAtBKTcfSsreY1xr+xoQiH06S83IE/MV4FqX2PSseceLZavVVsdR
 wCKMJWAhz+/ej3hIjlgi7VUuabpQO+OKO81dSv3GlCDzE7PkgL6fqnAu/zeTaLoyU1ITpl8Fk7L
 Cw/9O/OhKvecaBX+J6z7EnVhNEhaVSUAt6/zmvrZw/VcW/g
X-Received: by 2002:a05:6870:458c:b0:416:32c1:4276 with SMTP id
 586e51a60fabf-41ca7005de9mr2344187fac.28.1774457663608; 
 Wed, 25 Mar 2026 09:54:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41cc7b6312csm56309fac.15.2026.03.25.09.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:54:22 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:54:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH] kbuild: Use relative paths in generated .incbin directives
Message-ID: <20260325165420.GT502704@bill-the-cat>
References: <20260325130811.447377-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8iyf4/4mPO/q5dlm"
Content-Disposition: inline
In-Reply-To: <20260325130811.447377-1-sjg@chromium.org>
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


--8iyf4/4mPO/q5dlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 07:08:09AM -0600, Simon Glass wrote:
> The generated .S files for fonts, splash screens and EFI apps use
> .incbin with the full prerequisite path. When building with O=3D this
> bakes an absolute path into the .S file. If the build directory is
> later used on a different machine (e.g. in a container), the assembler
> cannot find the source file.
>=20
> Use $(src)/$(notdir $<) instead of $< so the .incbin directive contains
> a source-relative path like drivers/video/fonts/nimbus_sans_l_regular.ttf
> rather than an absolute one. Add -Wa,-I$(srctree) to the assembler
> flags so the assembler can resolve these paths.
>=20
> The DTB and DTBO rules are left unchanged since their prerequisites are
> generated files in the build directory.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  scripts/Makefile.lib | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

This is generic kbuild infrastructure now. Is there a fix we're missing
=66rom upstream, a change we haven't pulled in yet (as we need to keep
syncing upwards) or a problem upstream too? Thanks!

--=20
Tom

--8iyf4/4mPO/q5dlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacQTPAAKCRAr4qD1Cr/k
CqwaAP90fpAq8F475xxF7KfZi0rUdxC51glB6Y9RcX9+eKjKnwD8DR+1KFar/buw
zO444zcSzNkLuRrhs12sjCTd8d8XmAs=
=5aDx
-----END PGP SIGNATURE-----

--8iyf4/4mPO/q5dlm--
