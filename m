Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863D6C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 15:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26748081A;
	Mon, 17 Mar 2025 16:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CzttDCCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2F380F4C; Mon, 17 Mar 2025 16:13:25 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DAA80107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 16:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6fee50bfea5so40545867b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742224402; x=1742829202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jK1LJHKlkuKBrHalx2yqZTccSaGJF4uK+XofHEos5JE=;
 b=CzttDCCdt8FU3zUj5IZUvOiZTis7lt4sFQ2aYwChQC7VLyL6yM6hA3D7toQJ2RJ0FZ
 /PN/Bm8tKDgKoDLiT/oIkwolbpI4crozSmZA5n2N0D8JR41c0XelPWhB/+GWc0hsslWn
 ChF7WZuv8kMDS+QpkpgnqDGfDkL3W+/oMgqts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742224402; x=1742829202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jK1LJHKlkuKBrHalx2yqZTccSaGJF4uK+XofHEos5JE=;
 b=GyWNDpjdn3ttPq9FfgUyWXdrN8wzGP5hdwqudRJwQ8Ov5NBWYkgbp2VoMps5r8HDTA
 8IC7LQOafu21sPg/pabXnzASiUBrz4FcMojov2uP3GYfxoFP9El2ZlFGWEMc9kVayzVO
 S9z/QnyG5mZUOlQuNbl02xjb+HLv8aaA4WR1INget8tCbIFwR9VuLk63eDemM+hRr1Lw
 M4X3TbJD8UZOoNdKQ6DE6AaD0sddPGqn2WlnynDvAHsBJOqcoipt5anN36Rczxzh4wV4
 sft05kOTYMMOIIDQ5Qym0uxWOlmAnFXDuRJEbFZIyFnuvqoE5CSoDZQNHnx3gnJbhFHg
 lfAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH1G5smZflgt7rOadSzf8qj0MdnqoSAx//z2T1U3K7mLZhrFPt2nwkEw+xT0tyKHrmaGZo4aA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2rOjJbd2W3BzHH9NvIz1KnrRt05f8HhSJcNbHrrdJ8qbacsts
 9hZA/hicxUIGsa98Ex14SHRJed2tIAARXsv6xmDTG4l8njbNudXxGSby31LVBjk=
X-Gm-Gg: ASbGnct2MhWolPolyIOmrKM9u+WeGemL2+X9a1WclxX14mJdQQK96xIz75k2Zrt9guu
 DGx5E6YgFm9nMyJ0VgSqiSETHxVzI3GWjshdpIcMCWdDIIvv57z3bsndOXy4X9HKoiHht/C2cHL
 Vl78CQEZiN29olM91A4d0iwgc1a9sAz0b3ZcziepN1OHjr3X8BjJWhiOhhIsPYRT4x+FSx6JsaN
 8oq72hN1QG74nq1TlRAaPlS+V4ZnlYuyo75BB9jE2iM4afGrLE0G+9f5jE6LyeFz+ti49bkx7kF
 4tp/iWeCQr+Zfl9xoIgg4SbmtcDOvV4Wu5Z+W98Mow58ug==
X-Google-Smtp-Source: AGHT+IFiuhAVP0jGYIt/f8l15cSsi8D8/TArj8zMKmt9OB+QiVzUUyysLktAPgnqtQPPufTr6kk+ug==
X-Received: by 2002:a05:690c:6e0c:b0:6fd:5a3b:7af9 with SMTP id
 00721157ae682-6ff45fa637bmr182517517b3.20.1742224402205; 
 Mon, 17 Mar 2025 08:13:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ff32cba5basm21989097b3.113.2025.03.17.08.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 08:13:21 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:13:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Prasanth Babu Mantena <p-mantena@ti.com>
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, u-boot@lists.denx.de,
 vigneshr@ti.com, u-kumar1@ti.com, n-francis@ti.com, vaishnav.a@ti.com
Subject: Re: [PATCH] common: spl: Enable Instruction cache after relocation
 in board_init_r
Message-ID: <20250317151318.GR2640854@bill-the-cat>
References: <20250317064507.1702120-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XxYm1gasaIXgl5rj"
Content-Disposition: inline
In-Reply-To: <20250317064507.1702120-1-p-mantena@ti.com>
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


--XxYm1gasaIXgl5rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 12:15:07PM +0530, Prasanth Babu Mantena wrote:

> ICACHE is enabled in board_init_f which executes only before relocation.
> Instruction cache invalidation is needed after relocation as well in the
> common spl, which is taken care in the u-boot init_sequence, but missing
> for the spl. So, enable it at the start of board_init_r for spl, which
> invalidates icache needed after instruction relocation.
>=20
> Fixes: 52a86e69e20 ("arm: k3: Enable instruction cache for main domain SP=
L")
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>  arch/arm/mach-k3/common.c | 1 +
>  common/spl/spl.c          | 1 +
>  2 files changed, 2 insertions(+)

What's missing from spl_enable_cache() in K3 already? And looking more
at this, since Rockchip does this slightly differently I wonder if we
need to think harder about making some of these hook points generic.

--=20
Tom

--XxYm1gasaIXgl5rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYPAcACgkQFHw5/5Y0
tywSEgv8DgBaF+GiNBV57Q5kehaSx6nB1nJrm2f0HZHM1SuMLOAkABbYs6sjYmOF
muBlpJRZK0+PV1LK4gCi1YG+5t4e8hATE2hmfDBqpyMt289Fb3kfmd7UvFZSX/t9
i/e1RVaj/JbNOW5LERgZO1NfrYzv0DeOQLSiv1WHdJtBhC/Jc8xJaBKQqX0+jSeZ
TlIq8r47pfhKFTmXSHG6rN1X5KFzO6TLHoa6nm8h2h2XhL7S5n5a8ZH1LKE1xxrs
wlHhPQn42q9Tm0+xsVUmdbL/SolU/qvazCKBFrIBBZkN+kc15inSiG4kguwfbM4A
eRCBETJy31JuTAxF3SCME2/o65yFutxsHL7Xzo3k+UjybgrvAo34peI27IdlU3oN
XnPc6JxBuAeHLC7gYJ1OaEGI6GEueKgebkf9M6Oxo2o69ZnvuLBgLN3dIWuKJNly
UrpoETSDKSMpqMre1GQmu4uSs3ajjao8MeH1s5zF/6ddRPtF1EC6nO4LLhXa04UL
IoEtGv+G
=cKTc
-----END PGP SIGNATURE-----

--XxYm1gasaIXgl5rj--
