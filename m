Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3F7C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 13:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D80F987F78;
	Tue, 26 Mar 2024 14:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UIrAztDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F3187FAC; Tue, 26 Mar 2024 14:48:35 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A630487F65
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 14:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 75D6BCE2142;
 Tue, 26 Mar 2024 13:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6332AC433F1;
 Tue, 26 Mar 2024 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711460910;
 bh=edLiWMdo0Y3CxMachJdVrm0TDElF4ls53slF1rbPoEk=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=UIrAztDybADAaLmYPGCucVXkBCzjtoDkU3hfvjQPPD9Lb8ZBvjRB/6eq53mokkAyd
 XTsRrjmnxllpzJWLB7PeFbmqBYyGTiNWygzHn6PPz3Kb2oUMtiUlbzHm/SOyC322ie
 kn4Uz9U6dRrbIgNuvThCWnwomFW1peuR0rtuljQlcM6XOsZOxPxLL8Qkm3nHPq72PK
 vmH7PHPl2Jymyq34yOUVJ1FBtw59NPmFE6zNpmdKKSeSF6ps8d14NKNacA0Mtta9FQ
 JuJ0c2z71gaNHmT8FP6vplXt4vFRO0JSdOsobTT+wEezC9fy6zC2aJxYRL3Z3zuUhq
 A94O9L/v/uIZw==
Content-Type: multipart/signed;
 boundary=2a666c3e8316120ed72cc5a0ba21c70da685767dccdd517302239d962389;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 26 Mar 2024 14:48:26 +0100
Message-Id: <D03Q9AGO5ND9.1TJM3KSNA71WG@kernel.org>
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
Cc: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Neha Malcom Francis" <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <bb@ti.com>, <nm@ti.com>, <sumit.garg@linaro.org>
X-Mailer: aerc 0.16.0
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
In-Reply-To: <20240322131011.1029620-4-n-francis@ti.com>
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

--2a666c3e8316120ed72cc5a0ba21c70da685767dccdd517302239d962389
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Mar 22, 2024 at 2:10 PM CET, Neha Malcom Francis wrote:
> Clean up templatized boot binaries for all K3 boards. This includes
> modifying the k3-binman.dtsi to use SPL_BOARD_DTB, BOARD_DESCRIPTION and
> UBOOT_BOARD_DESCRIPTION from the files that include it to further reuse
> code.
>
> All k3-<soc>-binman.dtsi will contain only templates. Only required boot
> binaries can be built from the templates in the boards' respective
> -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
> clear distinction between the SoC common stuff vs. what is additionally
> needed to boot up a specific board.

I appreciate the cleanup. But as far as I can see, a board might
only have one device tree. How would that work if the uboot proper
must support multiple device trees?

Thanks,
-michael

--2a666c3e8316120ed72cc5a0ba21c70da685767dccdd517302239d962389
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZgLSKxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/g1MgGAp5D0ggNk4efJrW7BioXgDJHZlY0klnFf
LiATMn0FPKTVB8gnHKPGGTImkWTUK3eTAYCmcSAEbClaJYFDZphJHZ37I2GOLCGp
lCbXO3tV52s6VstAiH7f3TP6OW/Zf6i4+pE=
=oO0c
-----END PGP SIGNATURE-----

--2a666c3e8316120ed72cc5a0ba21c70da685767dccdd517302239d962389--
