Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48153C83F14
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCC1B86504;
	Tue, 29 Aug 2023 16:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ILhKhPJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0683F86500; Tue, 29 Aug 2023 16:09:24 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD4B864E8
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-58fc4eaa04fso51044697b3.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318160; x=1693922960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DB9E5HmFHLeDQiKUiPAd4CuAJ9uCYRt8gGZzT45vw50=;
 b=ILhKhPJodrPRLHd4FnNutYbIOiA/n2cue8Zsr6P/EdOl0Leto2lVYwAalGtaO4x5Af
 NhXur+FO5eUb5PIHYYNhKCIGX5Fa8FGA9dqLHEFjDk/Z7j+RKUdV8gFfyv3rulvOl/HA
 ler6DmwipWFokmUctXFs/tWKpoDqjDVbDuH+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318160; x=1693922960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DB9E5HmFHLeDQiKUiPAd4CuAJ9uCYRt8gGZzT45vw50=;
 b=j0tCJ/MNYvt/sWhFuOkgcs4fEGRgBGIBmTSo7GTn0C6+Nln2h36adrALFSsgZMEtWW
 mk00ygHp9F0Uz/qZPTb7RrW5Pn6yGb4EdAto1lB9fwUYOC+ZSI2/6IA1Eouy0mbNQA+/
 e9CKoUobX/qoSjxRXBPOmPPFXF9jtJSu/8GQH5yFyQESIJonYtbVb1NcmTMqAeYoa0uN
 8nfhboEv8q8/RbUMQuYwl32RRgwPOahSRCMOTQn2y000JSFvLU5AlyhW0Vl2ojYAdV8K
 qrXC4JpTnVVu1uHt+CueK2oNi5czLtOceyFg4Ouux6FuyAvv3WW5kMB2RLC40QC71w9x
 vy9w==
X-Gm-Message-State: AOJu0Yy7WZI/NtQI+5sQWWTX+SVv15PFGGZQIXb3UndZx3kQNEhFrq1g
 VbPam9qFDmq12ltulrODrda7VQ==
X-Google-Smtp-Source: AGHT+IHM9Y5yjDU63euqFMxpMh7cNuJ7ubvENaupmderwDkUpFkTYEVkI/HlyCmITRd/X/5AVeO+iQ==
X-Received: by 2002:a81:6241:0:b0:583:d722:9ae9 with SMTP id
 w62-20020a816241000000b00583d7229ae9mr32838881ywb.41.1693318159931; 
 Tue, 29 Aug 2023 07:09:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 x67-20020a81a046000000b005922c29c025sm2731408ywg.108.2023.08.29.07.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:19 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: u-boot@lists.denx.de, Ricardo Salveti <ricardo@foundries.io>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] Revert "arm: imx: mx7: Move CONFIG_OPTEE_TZDRAM_SIZE
 from lib/optee"
Message-ID: <20230829140917.GU3953269@bill-the-cat>
References: <20230825134734.21041-1-oleksandr.suvorov@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uYCqnDpCejap1Rxy"
Content-Disposition: inline
In-Reply-To: <20230825134734.21041-1-oleksandr.suvorov@foundries.io>
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


--uYCqnDpCejap1Rxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 04:47:11PM +0300, Oleksandr Suvorov wrote:

> From: Ricardo Salveti <ricardo@foundries.io>
>=20
> This reverts commit c5b68ef8af3c2f515c1f5b8d63a69359a85d753b.
>=20
> CONFIG_OPTEE_TZDRAM_SIZE is used by imx6-based SoCs as well. Move the
> option back.
>=20
> Signed-off-by: Ricardo Salveti <ricardo@foundries.io>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>

Applied to u-boot/master, thanks!

--=20
Tom

--uYCqnDpCejap1Rxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt/A0ACgkQFHw5/5Y0
tywfDQwAjIdtt9vTaqb/XG2fSKeWji5R70KXGHZdcuz1s4D85l0b9baeaWUh9j8e
qDevMT3M6oqT7CAsBgvfGzI88qs4yypic44MfGMOEaAPH+HgZtnU04vQmbKh7EqL
8489kSFhcvIjEWf1gPwT0cS9hnzFahEkKg0yX9ceKBUG80bOSH5kx6vQgnzVBtCI
XgiEzvAPUKbcd+Q4JBGd8XbPkdarPfekWs7A8jAjbBg01hCgcP1dwg58EhykE87f
G0d79GRkvN7n39c0HWzTwY07ULGu+2cd4h4uHTn3pMqUmnKNOodoFXmW/NCY5W+t
ARRhTZnt8gsTMIgAUriI3r4dMsQ9vXE7hvwOT7mZwoOWHrUpRN20AwfOtkClEWcV
0Cuido5WQzWAt84imzoyEnu6f9o+7CFLBOOMDaKz+EXNGnSIZNA00spY07pCqbto
fg9dZf9HzlkJAycRhFu03qc2SB1v0GoKAuORspFUq6gMRt4epmkpCUjrWw+UWcvV
oVLM1hWp
=ET0u
-----END PGP SIGNATURE-----

--uYCqnDpCejap1Rxy--
