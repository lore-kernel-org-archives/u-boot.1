Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC26C25B79
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 15:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA8E68818C;
	Fri, 17 May 2024 17:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jcOg7mwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6769A881A9; Fri, 17 May 2024 17:19:02 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5849487F3F
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-43df7f42ac9so4840351cf.2
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715959139; x=1716563939; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XmRlqMKnc/68sCyHmegaAl6GMTxnRvIJKMvNMfgCxfQ=;
 b=jcOg7mwOmS2FpszU4fnVXtSlMxnmpHOnkMvkcoQKbzkmHw/NxWJVLGc36s7SMMtIUE
 xnu5dkaNEvkG9ON/K8Y6jshz/dYTn92xcgofJ4B39ZQjQV9MaScuxbG4PuWywNfU4SOU
 Pp4KJXnoQbNfRdkNVWLS9HUtB6IvgGKM72OHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715959139; x=1716563939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmRlqMKnc/68sCyHmegaAl6GMTxnRvIJKMvNMfgCxfQ=;
 b=DzEhNNKD8smaATnHFWxMEGsNU6EtOnv512bcmWPlUj4yYYaguX9CXKPhxCF/KDo72o
 lIoVlMeLzNR9f91wZ8Vro9QhhuCEReKyANeW9bsFHR0vnTnHBXECpMfwLj3HucxFWJRQ
 AtsEur6sgFSM2bWf4rSgQLSyXxGpiWcujIZGryJHGh+4e53MeYDJzThuuBs9cNgZNY9d
 iTN6BhhlzPQUl+ithXwJcSE9t5N/1fhhwnS5eUFoP41Oyx2gOAcIwSdYUOgXqW3minzM
 N5sz15yq9wuGzJuw0hRQuwNAklvOXLDgBKCWzV5iOK67zp81Wy6/ekYqOnkKHt/PnqfX
 68WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMFdplTw3PP72GgVkPyf2XiebhTU8vqXukpWmel22mCMAYXDGRt3Wfy4Xr5+QtWgLgtdtbI1RxR1O8aGQSea2FOTPQ1g==
X-Gm-Message-State: AOJu0YxAG2VJpwGRIVR/A3YhvxQNmS1O1cICYF+carTIF88fDW7q1opy
 c25p/KROrHsUDDlxglT3Mc8l1jZeD+rk2Gr1LEQD7EUDi+K0xRUqnQDm+2jLk90=
X-Google-Smtp-Source: AGHT+IGf0qJKtBHCavlGtiuYNAR16CeE2jfT3X88zSGEVRTv7mR4knQUQLDbukIvyALEl8ng9iFfcg==
X-Received: by 2002:a05:622a:1906:b0:43a:ed55:f3a9 with SMTP id
 d75a77b69052e-43dfdad7b2amr300577851cf.30.1715959138987; 
 Fri, 17 May 2024 08:18:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e2c8d3d45sm45940231cf.47.2024.05.17.08.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 08:18:58 -0700 (PDT)
Date: Fri, 17 May 2024 09:18:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Makefile: add build-sandbox*/ to mrproper target
Message-ID: <20240517151855.GK2568172@bill-the-cat>
References: <20240517151534.65242-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/4SBospc4SG5Rbq5"
Content-Disposition: inline
In-Reply-To: <20240517151534.65242-1-heinrich.schuchardt@canonical.com>
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


--/4SBospc4SG5Rbq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 05:15:34PM +0200, Heinrich Schuchardt wrote:

> make mrproper should remove all build artefacts.
>=20
> Running make tests without deleting build-sandbox led to an error
>=20
>     *** No rule to make target '../include/common.h',
>     needed by 'include/config/auto.conf'.
>=20
> on my machine.
>=20
> Let's add the build-sandbox*/ directories to the mrproper target.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't believe it's the right place to remove build directories. This
is also incomplete as it wouldn't clean up other platforms that can be
built, and of course it cannot handle out of tree build directories. All
build directories regardless of where they are need to be removed as
that particular change breaks re-using build directories before/after
it.

--=20
Tom

--/4SBospc4SG5Rbq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZHdV8ACgkQFHw5/5Y0
tywb3Av/U2pveAUfd/YtrcTrC9eqOv05KX4ft16wrbwPcO7Qd4sxUoZFEFAqOl/f
ay5fvCP/3iJQP75qL/P+rygsEsLYb2dgfU/Nt08UE+iZ24hOyMkvEeWjrk91kiXY
vDuXbu2d0IjQ/uBYjwDwyHY9mh5klgn50Pr66zEyxn/5iA/r5PG9qrsxKighG29y
N7OJM8bIHVKzqylzhgKR/fkSw/ILu9Cge3L6PV3lfmIr+S7GS4/zb1VZYLs2aekg
2PulU9ZKTXAeWgSpd/WCYkkVDa1yyIlxWFjv3o3+XasKXjTxoK2K+UmgcxjgeJxG
uLudVwfdFIlZCTBJTPob6jkOQeAmFkRnKjoyPGr87FUL3VfAEthPOpClJHcCgt2k
o7vW6LBDPkiQKVXNecE20GxsOwTTsL0BqwvMumzH30q81MmDj3LaPgaop3+F3XjU
digBNiwUBVv2rvqLj7acD0vAoFChM19Ubkm97yjcHj5H+pa9awOLSIrwaEuBj2YZ
I/xzx74k
=NODq
-----END PGP SIGNATURE-----

--/4SBospc4SG5Rbq5--
