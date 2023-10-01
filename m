Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F3EE748ED
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 15:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143A686DCA;
	Sun,  1 Oct 2023 17:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cixoMvrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2348646E; Sun,  1 Oct 2023 17:55:12 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E83D786DA8
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 17:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a21ea6baccso43703697b3.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696175709; x=1696780509; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y3gvu27dtSUaTE8nDX6OjbLA/wyLqgMvGRtmb/e/fNI=;
 b=cixoMvrMNx6dQryAF0j0w4IwBK5olVTjsG2ziL5eA8CyWLO/TIYs4ouT2vjJE8uibU
 +RomN6BPGHxFtUqB93oYSEoa4o0fb/3x1mS2cP+R2HuEUaVSBdveAnAf4fLXDd6k/U4k
 e1TFJdKiv5VcD8OJyHaQY6QBq8KD0C5/Ef0e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696175709; x=1696780509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3gvu27dtSUaTE8nDX6OjbLA/wyLqgMvGRtmb/e/fNI=;
 b=thf3Jp1IJkyAZDV1EnWqPfcNPmDdfeh0PMPo1jJfvDDi1rNh+VlpyLmnfi8RhdKWAG
 99F53e5Km6J1ND7laG5Q16JX+7yonn8x3xyxKf9oLm0SGcFJAiIT9u3iZV/wqkb21hQc
 uCeYZnFFonpP92h6PxN1wGYq1VG3TB/+F3wE6BfZS8Neo08fvaKOQcAXsmHU0f3S73Rt
 lhgBBTZQ+RacsWP2sDTocGo3PP0+A0Y6MD80rw7UlIfy9uIdFHpAahthqC4RkEv62AN8
 f+BFh0wzl8F1e5jyV42SvLREobgfUuG1H1bukeYQ8Wl9b7C1npPJNTp6+dVu9/uWaFSr
 OCnA==
X-Gm-Message-State: AOJu0YxRc7yi4utBm7e60k1k/UOZcUijQV3xLtmf7YuYNjJPG+QFj0AO
 T8FgqQ7CcsEsKGx6EWUEKnnE9Q==
X-Google-Smtp-Source: AGHT+IFjeomkfxh68y6od3frqUIGBsyannO2bluVIgPRLfi2BZu9N5XS6xE3JWhSnUV8JvghzT+Nug==
X-Received: by 2002:a81:a24e:0:b0:59b:5170:a0f3 with SMTP id
 z14-20020a81a24e000000b0059b5170a0f3mr9214819ywg.36.1696175709377; 
 Sun, 01 Oct 2023 08:55:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-13fb-ab5b-9ebe-9b3a.res6.spectrum.com.
 [2603:6081:7b00:6400:13fb:ab5b:9ebe:9b3a])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a818308000000b0058ddb62f99bsm7122759ywf.38.2023.10.01.08.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 08:55:08 -0700 (PDT)
Date: Sun, 1 Oct 2023 11:55:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test: fix comment indentation  on tpm tests
Message-ID: <20231001155506.GA2763665@bill-the-cat>
References: <20230601061844.492923-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BQynD1lsZ8yIh/GN"
Content-Disposition: inline
In-Reply-To: <20230601061844.492923-1-ilias.apalodimas@linaro.org>
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


--BQynD1lsZ8yIh/GN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 09:18:44AM +0300, Ilias Apalodimas wrote:

> One out comments is off by one, adjust it
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--BQynD1lsZ8yIh/GN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUZllMACgkQFHw5/5Y0
tyxTuAv+KaT4izuzBzIcrRjHzT5c5C2To3wwIfbDx6aCq6evX3gQ89QTZ3tYtYKs
fS3OF6usWZooYla+1n9KYvK1uwvfSmeND0RYGVgtJZ8U8Uq+4iDLAKuFImaFfcKo
JLA6GePav/C8HYLzLZTtoX4mVj09SO2pjyfHPSCNVa0YzetkKbz+wInfb+Al9Y3d
Ngv4J8SPpNhKgIkjuwp6dp12ISw8VbQFIlMTw8ca+anBqiKoiAHoY/HHnwplMNh9
hkK5BlbqfIaQYh09SSP+b9CkiEt6NOWiW/y74PUa5GPCJlLuHNFi96EwvcRPNEhe
Dd46exGYwqBHc4r3s2+0oyg7E1Dpyi4iqKDyg5S4gFapYY+PqynaA1s2BDVgMAMh
+cgccxLA2N8dDPZO7i3RQWbgWwp0NrqlhHvWYPho9Utk3tVwervteDXm/pI6cA+U
QpkmhqL4fcqjnXI24EnqydWNrbOwaOn2joSas+fBacSO3OmIfUR57g4qQOaMIRsN
nTE6Nj32
=hKcn
-----END PGP SIGNATURE-----

--BQynD1lsZ8yIh/GN--
