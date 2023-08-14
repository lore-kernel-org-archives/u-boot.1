Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F54C001E0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A86286957;
	Mon, 14 Aug 2023 17:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="teah/vtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 525B48692C; Mon, 14 Aug 2023 17:04:09 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505AE86927
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d299ed34bacso7776102276.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692025446; x=1692630246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8WnICEoLe8oldF5pb9NLn8d0Zd32C8nQkdLaqfJVRfE=;
 b=teah/vtfIWe3OSBs+3W5unIF3J6SANcJVmIAYBpV7IcpYmrSCYDu3aGJ1B4iNx5f9b
 GM1l5Ps5AoTp0OC+Vh9emzad+seHVfsioIt114u3ot0WUDLp++8HyiDekqKecsPmfgko
 Nv1urcdS9zEG/deH0pAON+eSICR9cEHfZQtcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692025446; x=1692630246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WnICEoLe8oldF5pb9NLn8d0Zd32C8nQkdLaqfJVRfE=;
 b=V/Xu+A/yz/Xphx1UqyFyQRtAn9GyT7zGvarnLw3VELnTz1wPzhyOziSJq1xrjR4nmc
 DLcRjdoaU0FZNwK8M5FIIz8+7USGTWIViaT47zkvnKOrGdduoGkwFdOky77LCV1XJstn
 mrQZRWtkNCdfrEbNqUnLfQVjBy1c73ZqsRUCZWX6Zs5FCtbrmKoQEQhESrOY8CN14Wl+
 +hY2l4qzPVJxmh2KGn05Vq5g8+ZG4q/mvxoYHPxAw+D/iUJCF8fc+2AqK4Ex+drD8HkN
 asZMcA9EpY0Pau4Rn6PxVot929lTuk6ZyVtZdesLGayo+wcaEd4UiuDTj+EPr0sQ/YRz
 sX2w==
X-Gm-Message-State: AOJu0YzbSIYWyJMTYZpgRcvtqN8jVRrA8ySNupAcajgkH/zhNBoU6S23
 6G4j399YUbpakyxG8CgM6WF58g==
X-Google-Smtp-Source: AGHT+IEdzAQ3L/xJX3p2iLp9RSXlsVCRsF8IquzHhkZBh0wxZ7zyzjAnQYIRnrNARG7ibCBSX478eg==
X-Received: by 2002:a25:ac0f:0:b0:d4a:499d:a881 with SMTP id
 w15-20020a25ac0f000000b00d4a499da881mr16797044ybi.9.1692025446079; 
 Mon, 14 Aug 2023 08:04:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a25fc0e000000b00d20d4ffbbdbsm2456493ybd.0.2023.08.14.08.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 08:04:05 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:04:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de, r-gunasekaran@ti.com
Subject: Re: [PATCH v2 2/2] doc: printf() codes: Fix format specifier for
 unsigned int
Message-ID: <20230814150403.GS3630934@bill-the-cat>
References: <20230814045348.49105-1-s-vadapalli@ti.com>
 <20230814045348.49105-3-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GQ/7jkoof5a17ID4"
Content-Disposition: inline
In-Reply-To: <20230814045348.49105-3-s-vadapalli@ti.com>
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


--GQ/7jkoof5a17ID4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 10:23:48AM +0530, Siddharth Vadapalli wrote:

> The format specifier for the "unsigned int" variable is documented as
> "%d". However, it should be "%u". Thus, fix it.
>=20
> Fixes: f5e9035043fb ("doc: printf() codes")
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--GQ/7jkoof5a17ID4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaQmMACgkQFHw5/5Y0
tywtowv/egmCU5ONYfBY/3dFTBL2UN6uSkwuWl9FsbX0MxyShNHJNTAhSHyOvKvf
UfLDGG3Sf1kDYUa1BwekDROxVzAYtvU/+LcyrvwdJovH3kGCDovzJdRwPH58Yhxc
D8n+l7cqqi7xgOSOqn4njfmjg9aprC1PoaIObtr/PHLbSZI5MhgHBstLIQ4jrifU
UnYPnscaMyr65wHn7O/ZtBcs2/24vew1IKBhp3bllr7OUdeYI81/SE1ZITNE/Lmk
hfMuIYp8UTBjhp7KwdWstTUka2JFobjpghJBW7rliLzXC37AH8a/y+UbefES4z+U
lDs/fnN0BDXkPdBAdkGfjhPXoMdZC4YpJ2rTtcptAFOYlj1YtnWPj6z2qh2h7Tbj
oYXsBNwU7hGGRY67Yol89By3e8PTHQPVWUjs6pAXW1zC/5SAduXT4bp1P+hvVzu/
36l2ngJTfB7fTpFwOV7Xdlt/Yeh3J406mQ6nmkXsjMFkiHjQFXDkdTnX3CUSoG9e
9whITOe9
=CXll
-----END PGP SIGNATURE-----

--GQ/7jkoof5a17ID4--
