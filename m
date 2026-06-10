Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CE4CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 19:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4F75841C2;
	Wed, 10 Jun 2026 21:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uhXwGX3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A5C848DC; Wed, 10 Jun 2026 21:48:47 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2911841C2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-69e32df92c1so3674037eaf.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781120923; x=1781725723; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jUZsW/iL4juyvFlT2TYW0FpsHuAKn9aPtEa+8/uCWYY=;
 b=uhXwGX3IKzQ8ci9tYTakvjQAUbS99l4TrK7dy7zeWeb6fkknXTZJUKmtSSM4FzyxtM
 LVL4wkN5GTvRIfn3zhJS4mILOi2F1if5UlvvcXVoCtOkgulKW8q3lJ3dx/8YF0aGVus6
 JztkfFbQgKWP/lH0x6pIeACupxg3Lgluda2S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781120923; x=1781725723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUZsW/iL4juyvFlT2TYW0FpsHuAKn9aPtEa+8/uCWYY=;
 b=p9ZZV3XMuXABRBsr58nDOSqurJfVBJMc/8HTrREIjHI551RWQ+d8i4Ynd/rU+xx8+X
 +AFqQpzutDXKcmoqNkJ65Za+wW2SHvxhXvl6Sf7OyxtzA3qr5lurv3XDkKDX8gZO4oyC
 Jc4Ou1wm2p4uTS+B7N9JZVB+DdhmsXZZ2cqdMclNqjRPgnJJzhfc2hnT7KCyByKnukXA
 wKB5Dg+mzRlhFtCxbGbZVMKZBAqaLnjPEVlYEb26PMkGPiv3hu1Zw80wITCLl6itfrWk
 EBt1gvub/fAQC/St2vylqbpcpUkarH/eNIOI+fuX4fSbJiPLHxopeJoeCt7lUya2vVM3
 LTww==
X-Gm-Message-State: AOJu0Ywckk2ZTdrF7u7WZdLi1dlWfEFbrcmD2YVFOEPzFS0Fp7ZoPIej
 MK/YvPWB+oyedjci9Ic2qB6+xKT6y+cCqgVsot/YMkXRq57o3zzCN9/igeX1wZwfSrkQjHxDcrV
 7j1nm7cg=
X-Gm-Gg: Acq92OGSjybXE1WusxJrB118e8Il+U8fEvHXllyngsXDi0BkH15BtrbRKXcKHnFrb1W
 1zWLkkbvL88wcRIve9g6iX00PTYF/SpivgNDB3YdVKQO1SLrbRk79ggUxjXfPTv5CcbYX68Sg1c
 on/fgtNJZNaGCbA19nnE7qlx1icprhZwTQdwWwcloFrBjz2hFgaGEr0wNGuTn6/li4f83jOKh7I
 ouDA6W5Yn0BiPt72dJBDkkNJV8anV8won9EuT7quIx3GOmigr1+W6FDfdZeL3aRLccJIwLcIhyb
 jF1VyYxmxU/FjcSpEGiQA4rNZV9VlWDyprP5NKAlZB6jXrJ1Sazx1wk7Jygc/lYy7iTy8ivqNHn
 +bVC1TLu2XEmdv9RETWzSI+iyWaBeLWrxUGmNowgsuD0SXwsuW26Lgld4MfwrtoPmn1oEdCfdIE
 r0ObSXz0MpIqQj7RkrBR2V272NltDkOl2zGdAeu26Au0rYrYTHPAkO9vvPDafB64yOU96FNFNnD
 E2mfixcvvvCy7G6tggXevXDEnppiHLy498Z6077bKFfpcxqN1llfF700jtXnzH+I0DuwNDY
X-Received: by 2002:a05:6820:62a:b0:69e:3da3:b4d8 with SMTP id
 006d021491bc7-69ec7b7773cmr315370eaf.18.1781120923163; 
 Wed, 10 Jun 2026 12:48:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e46267666sm13858769eaf.7.2026.06.10.12.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:48:42 -0700 (PDT)
Date: Wed, 10 Jun 2026 13:48:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/4] bootm: use CONFIG_SYS_BOOTM_LEN for
 IH_TYPE_KERNEL_NOLOAD decompression buffer
Message-ID: <20260610194840.GH382693@bill-the-cat>
References: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
 <20260610090125.99112-2-nora.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mugylc/zFZqgOnaA"
Content-Disposition: inline
In-Reply-To: <20260610090125.99112-2-nora.schiffer@ew.tq-group.com>
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


--mugylc/zFZqgOnaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:01:23AM +0200, Nora Schiffer wrote:

> CONFIG_SYS_BOOTM_LEN is passed to image_decomp(), so the same should be
> used for the buffer allocation. Deriving a buffer size from the
> compressed size if not possible, as the compression ratio may be
> arbitrarily high for data with many repititions (for example ranges of
> 0x00 or 0xff).
>=20
> Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--mugylc/zFZqgOnaA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaim/mAAKCRAr4qD1Cr/k
Cm7WAQCQbAL73SKH9F84bDHp9+oe8UuN/J7FAHwghX2kenkZdgEApYYMBqeQkvTG
ZzJBhfTc9OrX+aEoUqql2IEtk5xHbgA=
=NXHl
-----END PGP SIGNATURE-----

--mugylc/zFZqgOnaA--
