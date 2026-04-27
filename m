Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA8BFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F6F83AA9;
	Mon, 27 Apr 2026 14:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uI4YU23l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6CA83FDB; Mon, 27 Apr 2026 14:33:29 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3057983693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E011439C6;
 Mon, 27 Apr 2026 12:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA83CC19425;
 Mon, 27 Apr 2026 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777293205;
 bh=LvMMl94EdaFmjbDys43LpqXInplP9pNqsJBtC0gp808=;
 h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
 b=uI4YU23lM9vUahs0t6mu9yg7ZnTaGrrmdpOx0KRzVPMK3ZNyFuOujXi7FDDf5F03y
 S2xnPmhmWojlU1gvgnKE0M4vFfTrFyv38/KbImtCqDEdLlul0vkiRN+zoBfaQ8JjrN
 pI5V3qMLJOZDhUx7hICyvvMBp+12n4EWVhdJTugATIf5ax9iDJtKdibqECwPtXIkrC
 txf7d5mm08PDdpJLdFY4DDLHAbWNOO/WxSCs30fmlWODAQdPKFGalhv3kG/OsUxLvm
 rwC5bxCm1uDU+1XFWK4nLTpyzSt6JOw/nWJxXWoqJMcaaOFZjld/tXS1pnPBP19hkH
 HjMyMA1BUmaLw==
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b1d6eedbecbfb52dd6325f6443de9506fa081379a60cbeac4c41ec61dc8f;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 27 Apr 2026 14:33:20 +0200
Message-Id: <DI3XUWVXNGP3.2TI0N0LDP7ZJ4@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tomas Alvarez Vanoli" <tomas.alvarez-vanoli@hitachienergy.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/1] spi: fsl_espi: fix din offset
Cc: <trini@konsulko.com>, <chuanhua.han@nxp.com>
X-Mailer: aerc 0.20.0
References: <20260324170212.481394-1-tomas.alvarez-vanoli@hitachienergy.com>
In-Reply-To: <20260324170212.481394-1-tomas.alvarez-vanoli@hitachienergy.com>
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

--b1d6eedbecbfb52dd6325f6443de9506fa081379a60cbeac4c41ec61dc8f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Tomas,

On Tue Mar 24, 2026 at 6:02 PM CET, Tomas Alvarez Vanoli wrote:
> Hello,
>
> While working on an old T1040-based board, I ran into issues when reading=
 data
> with spi_xfer. It seems to me that the driver is copying the data back to=
 the
> caller at the wrong addresses. I am not entirely sure what was the intent=
ion
> with the original code as far as I can tell.
>
> With my suggested change, at least a small tx of 3 bytes works correctly =
and I
> can see the expected data in the buffer.
>
> I've really only tested this with a 2016 version of u-boot but the code h=
as not
> changed regarding this since then, and I suspect that there's not a lot o=
f
> boards left using this driver to read spi data in u-boot :)

This will break the SPI NOR flash on the P2041RDB:

=3D> sf probe
jedec_spi_nor flash@0: unrecognized JEDEC id bytes: 00, 01, 20
Failed to initialize SPI flash at 0:0 (error -2)

After reverting this commit, I get:
=3D> sf probe
SF: Detected s25sl12801 with page size 256 Bytes, erase size 64 KiB, total =
16 MiB

What kind of issues do you see? And how does your patch resolves
this? I guess we can assume the code was working correctly once.
Honestly, I don't understand that code either. But I doubt just
moving pointers around will fix anything.

Thanks,
-michael

--b1d6eedbecbfb52dd6325f6443de9506fa081379a60cbeac4c41ec61dc8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCae9XkRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gySgGA9qeQXdK45vOKmtvdbMRIEVyVLHHDBoD5
0GZ9heiQqhKc+0COTCSgD9qz8Apf0lySAYCiZcexefkveP1pjp+VyNQ3/5oN/FsS
zGSuhTVumoJPu2vO8/xam+xNaMtHayUgarI=
=Btmm
-----END PGP SIGNATURE-----

--b1d6eedbecbfb52dd6325f6443de9506fa081379a60cbeac4c41ec61dc8f--
