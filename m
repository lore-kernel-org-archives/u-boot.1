Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075A3CF3959
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CC2D84022;
	Wed, 19 Nov 2025 18:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FDZP2VQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1335A83FF9; Wed, 19 Nov 2025 18:05:28 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BAE8404A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-657490df6f3so1677444eaf.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763571922; x=1764176722; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vrQwvbR+xwO8BxrjGcwPgHtc/Q1/ReXKUcXDM6KYEVo=;
 b=FDZP2VQOhl4PHkfpQ8Hw9XpBRdHNtJ6ozV1ahT8RP9c7qJW5JR76hVWtcXtXd3w5UQ
 ymmzdqqDB2GApxwmHzLzi6WnyTDUTHwWU/FH8EANo21Q6KM1zvvuZR7/i8dm2y/iRnFu
 P57MbEIGz/oddfc7bbe98J6r+S0SLMehvdXKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763571922; x=1764176722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrQwvbR+xwO8BxrjGcwPgHtc/Q1/ReXKUcXDM6KYEVo=;
 b=r/k41utW+nwXqQoy/r7amfe8qPbq25nIVgU2+9YEuZiidVHwTBanRLRThUXUb+4pEN
 dS2orkVC4GbDTeF/1NzdeQu73QRWqtkJfYXaIEcp2UfC3eZ/PeVkebFboPMPPLJEwBOs
 ylr0++VfJWCgGhFTZxxMgWSvYdPwhBAoyk0BWk18IwHx0T6v3ASUsZF3EquWILBrqRJI
 2BR7WRURVfZj++Ywq4lN2QeAn7AkN8Zixi5DsZ3w/X+QXd2JKx/LInSpb8SlIFThdUow
 FKtBOjkg2H5OrKoRrVENvLRBtPhr6AIzd8dYmAqzqmAboMoV4+8W/JRBPP69uiQrBSW0
 mTvg==
X-Gm-Message-State: AOJu0YxrBosrcpXfl/vXZag1kmFSwH8/vCWRPopuOL8pdjY5nN8qVvW2
 8VS5oUI0FodgLp4q31+2ctEQTsx8k82k85FF4jhDkWBQPZW2KEDwmkZasjM5XFOlr+0=
X-Gm-Gg: ASbGncvCYbifraYmo5o/V9k2yL/1l/yPRMwsjO0SYTxevaK0iI/nVOpTJmjQX6tM155
 DJAAlMBAIZORkV5cJ0N855ksMUdOBIVlt9cxNO80nFkpjbww8k2C20g9gCJVYS8dCNZZloLu3JC
 +MFxt375vfWYaM6KdUYO0Ei0btUhffzOKJEvT8NjPs2TCrwx9n6iI2XnvQXGia8kX9q/MEB8+vH
 EC/LjCMlcID2b/HrI5xjwUUU4q/H2KAbN7A5Z2padqnRKz2fzAORai/1P5MPFo0RQhHD3uRXJj9
 SmTCgRhgTp2pMLEf8abwFQ6vlrhm594Xc7WdL5INLpJtaxctK+hO4KD27j7QwY3EuIGDpEVJHt8
 qAJ6udnaD9KYDfV1vHZEShqyvnu4qYOHIO+I5zosTBCG81RrE+euUuLdnLFpYngUIR1+oic/8Ov
 XzWeW4uf7RM74LLmXCfm/1LSoAACt0mLsDugl0WonAl2w+kMODQzBuqJoeM+JwEVZkpPjmHEQ=
X-Google-Smtp-Source: AGHT+IFTsaLmJsY3wvJaHvoh4pekXyguVQCZArnjBbQQcclU5qAeI33VlMp6AnJMa2iKfH4/2RSQ7g==
X-Received: by 2002:a05:6870:4413:b0:3e8:5248:2f5b with SMTP id
 586e51a60fabf-3ec9a36c8d0mr28238fac.18.1763571922062; 
 Wed, 19 Nov 2025 09:05:22 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522637e2sm2310492fac.12.2025.11.19.09.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:05:21 -0800 (PST)
Date: Wed, 19 Nov 2025 11:05:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Robinson <pbrobinson@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <hackpascal@gmail.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Max Merchel <Max.Merchel@ew.tq-group.com>, Mario Six <mario.six@gdsys.cc>,
 =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>,
 Sinan Akman <sinan@writeme.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 1/5] led: remove code guarded by always false conditions
Message-ID: <20251119170518.GB2125796@bill-the-cat>
References: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
 <20251119-legacy-led-unused-code-v1-1-bc0ae1235baa@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6qxuaCXOkILOoQof"
Content-Disposition: inline
In-Reply-To: <20251119-legacy-led-unused-code-v1-1-bc0ae1235baa@cherry.de>
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


--6qxuaCXOkILOoQof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 05:43:45PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> The last CONFIG_MVS in code was removed almost 12 years ago in commit
> 3b98b57fa796 ("include: delete unused header files").
>=20
> STATUS_LED_PAR was last seen 8 years ago when removed in commit
> 5b8e76c35ec3 ("powerpc, 8xx: remove support for 8xx").
>=20
> If CONFIG_LED_STATUS_BOARD_SPECIFIC is not defined, the build will fail
> so we won't even reach this part of the code.
>=20
> Let's simplify the if block to actually possible configurations.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Fixes: 3b98b57fa796 ("include: delete unused header files")
Fixes: 5b8e76c35ec3 ("powerpc, 8xx: remove support for 8xx")
Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6qxuaCXOkILOoQof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR34ygAKCRAr4qD1Cr/k
CguuAP4zytkSrhwgL+LYC12AXXAnlO95DPh5l7/LQzdBg77vyAD/SDGKYlq2m/Ms
nfbe93iK3mSINBObM9TGj3127umaswE=
=mTiN
-----END PGP SIGNATURE-----

--6qxuaCXOkILOoQof--
