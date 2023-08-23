Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3910EE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A99864E9;
	Wed, 23 Aug 2023 16:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pw+fAIJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DCDA86473; Wed, 23 Aug 2023 16:42:47 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A068864F5
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5925e580f12so8507867b3.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801764; x=1693406564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EhdQSpO6ILBrvfm0CbLgLAE7xN8z1Q8i5gW+UGibuaM=;
 b=Pw+fAIJea9ArwOu2iSJnkY5FKJ5nd1l88m+JEw8kxzmmoCxqpKAoVzXAnn/gKc1MNe
 H4+JXIYnd3+Umix+ZtgwxGicXM86BV8iFKq5bBz8CLI07Z76/3uQEqIifeZSC27SRdBE
 qPGKx3RNycVeT5IlGhIZDRQ+WUnvmUBiwMj7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801764; x=1693406564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhdQSpO6ILBrvfm0CbLgLAE7xN8z1Q8i5gW+UGibuaM=;
 b=TL/36eHy+GZ6CRPngvYA3/7r2kfSEpNuVXETatYKPCqWWxurXnEsvbvpLEViwdjOf+
 +0yh4TT6MZTOGULjrydkZt4LZwdlPUslRmYU2uG9FWtfBiiqhOFA8uGIC3W2XcZfXe8X
 lheQaVYOo9gJIFOr559MhlsBlwA+R1yAnQly07fgtdppJc+uk53s608Uxcoa5QUlk4JC
 MjbpbAt2SgTEC8C2bPyTi5ltaYUl6vKSClt6CHaEfOAsDfThqT8ejfBQUKSI/0ku/EBt
 RYVeWmHhXTRLzz0oBxIyy07ZvAQsi+CLtAbdQHxpF0dp5scnw1kK4MQRnGeQWgIdjH1o
 Wgzw==
X-Gm-Message-State: AOJu0YwK+YEGutwKhZdKKs5oox5IxwXkAc5WxSnyKvfw7cshvphUu2MQ
 wRQ/YTyfuPQLoPCs9XYwLht8t1XaokKRlrPhU8jrPw==
X-Google-Smtp-Source: AGHT+IE6owWNdenWFvuENM6lKHpL7TEpQSd6i4nw3HbNFGxQnE+xCksPIvWTpgyp1412TE0fkXmthw==
X-Received: by 2002:a0d:d5d4:0:b0:58a:1326:cb85 with SMTP id
 x203-20020a0dd5d4000000b0058a1326cb85mr14999933ywd.40.1692801763972; 
 Wed, 23 Aug 2023 07:42:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a0df884000000b0057085b18cddsm3368663ywf.54.2023.08.23.07.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:43 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 1/2] blk: Add bounce buffer support to read/write
 operations
Message-ID: <20230823144241.GC3953269@bill-the-cat>
References: <20230813235000.591239-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kXKb0a7Vy7s/BMCW"
Content-Disposition: inline
In-Reply-To: <20230813235000.591239-1-marek.vasut+renesas@mailbox.org>
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


--kXKb0a7Vy7s/BMCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:49:59AM +0200, Marek Vasut wrote:

> Some devices have limited DMA capabilities and require that the
> buffers passed to them fit specific properties. Add new optional
> callback which can be used at driver level to indicate whether a
> buffer alignment is suitable for the device DMA or not, and
> trigger use of generic bounce buffer implementation to help use
> of unsuitable buffers at the expense of performance degradation.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--kXKb0a7Vy7s/BMCW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGuEACgkQFHw5/5Y0
tyyxxAwAi5HXl3mid7RcL0fGT+afvHZLCPqCLZvz57oXIx/43XV2okyJaovoWiay
CcsEVT+Ki8j3yYeUtqqLYN2+GTr57JlvNN+32w5bNJ0o8y9sQ5Z4wS+Raklnx/Vs
6sOMhs8ZDm1bDliIoDDoILzwiM5xu+6EyVOI8ysVPCdFZZrvzXsCRwasLkflmkua
9x1oLUI1oWBsr+UsvOWXNI+WiVoTXFoL8rAAqishxVeQNbqSRoyRSWM4F8ZHtXkP
AqVlN9J9OwMI4El5QM2qVDrUSSjVNlEwOiRQTWOqX14QduB1xPQbybFzYPVz3CMn
h+jNDHFm7wxYGwmshUg0V4j4PADgVOGN7Jpfxq5QItHEQP1Afurjy2hAOU+ghA44
GTcXilBV8kMPy2t9kpahAAfS4l/EC439nO5uDcVqZCPPSjj6Vce5hSuaQnSgbTXs
aSWphHpyBfHJ4zubQPG5FMbRVHrXlUwKIeXEax2YFIxithftx9YGFS0FC01pAcCD
iyiwrSdL
=58Jh
-----END PGP SIGNATURE-----

--kXKb0a7Vy7s/BMCW--
