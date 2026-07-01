Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E03C43602
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2957C84B74;
	Wed,  1 Jul 2026 12:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dhYCHSET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4747684B96; Wed,  1 Jul 2026 12:06:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2438F84B72
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A299543C7B;
 Wed,  1 Jul 2026 10:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1CC1F000E9;
 Wed,  1 Jul 2026 10:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782900376;
 bh=lqUhDZZt+jAA9WqygBZ9lvCBkK6R8lsX5aovtQfwjTs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dhYCHSET6VjFSsh9GUATFGsduyL/Yn61jFXlvNfyeUwmEcpaMlmQ2WR0jq8ZT346u
 gV/vkTTEOtAjcxKz+Q/TNUGspF8PshAi7FiA2LGnCxF7oVha5pa/JPZUoqRYktmvuq
 IhqLMzrM0HJxdy99eTZnmPETHp7Eb0yUhkccc/46HKL5R/7HB/tWYbHZN7J1x/OJ18
 Nte5AXFaGTB7StZoaL7TgYNKSEb+IS09xNPrucZK1lyE0FLUFQqjp6RGGbsa7fZWjE
 PycjUPiRDRbiCyd2P7w3aIdy7jW4iTwy6CLZ0UdMDNYVFCnL57W5ozcZJiMXkc9v78
 LOKLfIX1kaImg==
Date: Wed, 1 Jul 2026 11:06:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 7/8] mailbox: mpfs: add bounded wait for BUSY to clear
 before sending request
Message-ID: <20260701-blinker-splendid-72713bd0b9eb@spud>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
 <20260625122325.834568-8-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UdYTkPUuGCVgfxju"
Content-Disposition: inline
In-Reply-To: <20260625122325.834568-8-jamie.gibbons@microchip.com>
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

--UdYTkPUuGCVgfxju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--UdYTkPUuGCVgfxju
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakTmlAAKCRB4tDGHoIJi
0hpiAP9ojgmfqP+leSES1FU4aupBZcPY5zJ1o5fMLjr1P4qWQwD/fUvRXakbyegY
MIF16Shyz1LB18gDrpEybSM0K0YTiwA=
=UUYv
-----END PGP SIGNATURE-----

--UdYTkPUuGCVgfxju--
