Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ED7CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 07:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3900843B6;
	Thu, 30 Apr 2026 09:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="adPbXv70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E534845C8; Thu, 30 Apr 2026 09:25:07 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BEF684198
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 09:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3687C61145;
 Thu, 30 Apr 2026 07:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852C1C2BCC4;
 Thu, 30 Apr 2026 07:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777533902;
 bh=RP+vo8MXKcHDwnCMSi6uYFW4LkYqG8FWq2yAlPUbI44=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=adPbXv7004nwNUrCZnF1xBd3N9biGb7moEw8SvKLNGdoPbIgGr56GpfrSGqcxsi1O
 7SsuPeoCI92vBsB7e9AUS5kdTvjn9Vyt5b1Bwhg7Jme4ZNc1o+YMh/P2qcBcQjt7Bu
 xUgutCvGPAEyLDsZwMD5gz6iVfHwgbuZOhkZgEpm0SCHW+n7GsooOiCsgGKRhYREEJ
 LPii/7Pdm+xOiOsnn/IcaWi08reQcY1+zNHySo4g/5dNFJMt7mBVuPtzGjooHQLWJT
 vzdgRWGTeJl8/7MRpM8eNBufbamELhPApfLDpvKHj505+toSCwu5hkY1yzZB50ewyD
 X4SGZwbBF0A9Q==
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=f77fd9e2784eff03c6031d8b4553b925447d8cac3e789eb8f6305d309e4c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 30 Apr 2026 09:24:52 +0200
Message-Id: <DI6B6D3I859S.1EP7GRA58V940@kernel.org>
Subject: Re: [PATCH 09/10] p2041rdb: update README and fix typos
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, "Pramod Kumar"
 <pramod.kumar_1@nxp.com>, "Vladimir Oltean" <olteanv@gmail.com>, "Alison
 Wang" <alison.wang@nxp.com>, "Tang Yuantian" <andy.tang@nxp.com>, "Mingkai
 Hu" <mingkai.hu@nxp.com>, "Priyanka Jain" <priyanka.jain@nxp.com>, "Wasim
 Khan" <wasim.khan@nxp.com>, "Meenakshi Aggarwal"
 <meenakshi.aggarwal@nxp.com>, "TsiChung Liew" <Tsi-Chung.Liew@nxp.com>,
 "Stefano Babic" <sbabic@nabladev.com>, "Fabio Estevam"
 <festevam@gmail.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, "Peng
 Fan" <peng.fan@nxp.com>, "Shengzhou Liu" <Shengzhou.Liu@nxp.com>, "Tomas
 Alvarez Vanoli" <tomas.alvarez-vanoli@hitachienergy.com>, "Jerome
 Forissier" <jerome.forissier@arm.com>, <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.20.0
References: <20260429121816.1026326-1-mwalle@kernel.org>
 <20260429121816.1026326-10-mwalle@kernel.org>
 <20260429152859.GW41863@bill-the-cat>
In-Reply-To: <20260429152859.GW41863@bill-the-cat>
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

--f77fd9e2784eff03c6031d8b4553b925447d8cac3e789eb8f6305d309e4c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Apr 29, 2026 at 5:28 PM CEST, Tom Rini wrote:
> On Wed, Apr 29, 2026 at 02:17:23PM +0200, Michael Walle wrote:
>
>> Nowadays, u-boot can build the pbl image itself. Refer to that image in
>> the documentation. Also fix some typos.
>>=20
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>>  board/nxp/p2041rdb/README | 34 ++++++++++++----------------------
>>  1 file changed, 12 insertions(+), 22 deletions(-)
>
> Thanks for getting this all working again. Would you mind doing a
> follow-up to convert this to rST?

Sure, I'll send it either if the series is picked or if there is a
new version, I'll include it there.

-michael

--f77fd9e2784eff03c6031d8b4553b925447d8cac3e789eb8f6305d309e4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCafMDxRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iOTwGA3PYelE1P3O7lWCKNxZV5mn+HBmXx7ky7
0PzVJK/nuqFIyXamHx7mP97lpppwMV5OAX9wrJP0l3Fy+r5EmsT1JvZ5NX/Dgzmq
x/Ourd8IOEspdSdgCFHUdcPFdizeLV+bupg=
=dWgU
-----END PGP SIGNATURE-----

--f77fd9e2784eff03c6031d8b4553b925447d8cac3e789eb8f6305d309e4c--
