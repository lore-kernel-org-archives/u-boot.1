Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2EC10D14AC
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 13:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9CFA83DBF;
	Mon, 30 Mar 2026 15:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j9QS1jaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F18583E7A; Mon, 30 Mar 2026 15:13:28 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6959083D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 15:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C4A860054;
 Mon, 30 Mar 2026 13:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DFEC4CEF7;
 Mon, 30 Mar 2026 13:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774876404;
 bh=iAjMWUoSrdpQhmBnjFsgYp8GcYaEWfI43XE5THLIdGU=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=j9QS1jaPFbzMByJS4VxOSrF5loG1iXfPMLtLPd7677y3VjyjP235n3l+/D/BEPUwE
 EATG022DMj5HtqHa4tIm5XZDdbBFJ4KeKRBvejxi0xLN7XrszZvKnvSM8xDeVmt988
 O70FVfM79qeKhg0ywmoyRX+rjJ9VdVPQWiXqDaz1pN5e7iFIOgkaRsjDxS5hxXsT/X
 wrpqnPEQSjb66XMkPWe5DaP5/2G4iucWT5m7jJXe/WJhWX4UgicF6uNWOGJVgsBTK9
 sET61W/8XMM2oYV8PhklZB/b/aVulzTurHJ24n1GIzBOvBYKXCaPorb77sf9pB+LN2
 KYjC9fNGwIyuA==
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=9ad07232e62596e36e893a4e15810ced404b192c57918d9d3563efd5a5c3;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 30 Mar 2026 15:13:20 +0200
Message-Id: <DHG56AAO63OJ.2FLCLQ8THLEJV@kernel.org>
Subject: Re: [PATCH 3/3] armv7: ls102xa: fix SPI flash clock
Cc: "Tom Rini" <trini@konsulko.com>, "Ashish Kumar" <Ashish.kumar@nxp.com>,
 "Priyanka Jain" <priyanka.jain@nxp.com>, "Kuldeep Singh"
 <kuldeep.singh@nxp.com>, <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Vladimir Oltean" <olteanv@gmail.com>
X-Mailer: aerc 0.20.0
References: <20260318142949.2479033-1-mwalle@kernel.org>
 <20260318142949.2479033-4-mwalle@kernel.org>
 <20260319141112.3mcbxhhuh5ougbjb@skbuf>
 <DH6TT2ZV6049.33QOAOWOYSDWL@kernel.org>
In-Reply-To: <DH6TT2ZV6049.33QOAOWOYSDWL@kernel.org>
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

--9ad07232e62596e36e893a4e15810ced404b192c57918d9d3563efd5a5c3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Vladimir,

>> I can take additional RCW patches if you're willing to send them.
>
> As said above, we have our own repo that isn't a fork of NXPs.

If it helps, this is our change:

 /* QSPI flash clock */
-write 0x57015c, 0x00000803
+write 0x57015c, 0x0000080c

-michael

--9ad07232e62596e36e893a4e15810ced404b192c57918d9d3563efd5a5c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCacp28RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hOlQF/VRZmG8RP2mPY0dqZoVGsaYk7WH3Vrz6P
55VPxKTuZQsIb1ugIynrVxedVSQRzAD/AX45j9o10tzkxU+WMsgfoC1OF+EcfQR7
nOqaG9hUiSrG0R9GbIbcxu8G3d2YQ0btZVI=
=c4SD
-----END PGP SIGNATURE-----

--9ad07232e62596e36e893a4e15810ced404b192c57918d9d3563efd5a5c3--
