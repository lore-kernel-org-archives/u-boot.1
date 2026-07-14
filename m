Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7F1C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 06:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066F6838D7;
	Tue, 14 Jul 2026 08:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="TXZI+1bF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17EEC84CCF; Tue, 14 Jul 2026 08:34:46 +0200 (CEST)
Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch
 [109.224.244.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2FA84AF6
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 08:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1784010882; x=1784270082;
 bh=BiOXVYcsmC3MS9jjLzpUWTOen+CGikhZIDYTJI4G3+0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=TXZI+1bFS5ezE9yz35h9VdA7k38RvbZdhkFdeMdZMtdK8EnKq1bt5F9n0ewYEFRMw
 IGXYG2BP7PEl4isvsL23MNPnw75V5RoOXjhA6QGdARc3pGwWbw2NuFORGYY3R32OCo
 pMBFpT07vIBniKINR0QLcAg1i55yNbMYrnFtwNwbRaabXTcoSTYPqx0X2HdiYRco0R
 JLBWo85iJWWagssff+s03BNgJaYMazO/gfN5RqOwKzUI3zO4ZPULH2n7HqMv9PrGAE
 TOZkveiH0bYK1jpgfuINL6dQb3eWS16Li7RhQzVnaRpPhpOPuJPDduTveN8l8eREqP
 7vQPNZT5cDqJA==
Date: Tue, 14 Jul 2026 06:34:36 +0000
To: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip@philipmolloy.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/4] Minor i.MX DDR init clean-up
Message-ID: <vfcezmx9WyHVT_Uc9zLDmz_hAPWHe-JRoMvZSk1Lexc3hiZu2sQSUW9GcRGFv5DXGLzGNao7481RjpAgLVWQUWpCPRoLtCo__jw-j1tx_rI=@philipmolloy.com>
In-Reply-To: <20260306085824.886254-1-philip@philipmolloy.com>
References: <20260306085824.886254-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: c0b35944e61934d51cd427bc381c0747fa83bc24
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Peng and Fabio,

It looks like this may have been lost in review. Peng replied to the series=
 about some topics in the cover letter, but not requesting any changes to t=
he patches. I assume as a result it was marked as "Changes Requested" in Pa=
tchwork.[1]

Fabio, it looks the patches were delegated to you in Patchwork. I'm not sur=
e if there's anything else you need to do.

Best,
Philip

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20260306085824.886254=
-2-philip@philipmolloy.com/

On Friday, March 6th, 2026 at 9:58 AM, Philip Molloy <philip@philipmolloy.c=
om> wrote:

> This series makes minor clean-up changes to the i.MX DDR init code.
>=20
> Unfortunately, I don't have access to any NXP hardware. I ran into LTO
> issues with my Fedora toolchain building imx8mm_evk_defconfig. And
> binman issues because of missing binary blobs with some imx9*
> defconfigs. But compilation was successful.
>=20
> To support an upcoming ADI SoC that also uses LPDDR4 and Synpsys IP I
> would like to leverage the i.MX implementation. Therefore this clean-up
> can also serve as a kind of pre-RFC. I would love to know if the
> maintainers are open to transitioning to a more generic implementation.
> If so, I'll submit a proper RFC. I'll also be at Embedded World next
> week if anyone would like to discuss in person.
>=20
> Some additional context and a comparison of DDR init implementations:
>=20
> https://philipmolloy.com/ddr-init.html
>=20
> I reviewed the NXP i.MX downstream repo on Github.[1] The changes in
> this series are not fixed downstream. The only major difference with
> downtream for the PHY driver appears to be "Quickboot" support, which is
> specific to the i.MX 95.
>=20
> [1]: https://github.com/nxp-imx/uboot-imx
>=20
> Philip Molloy (4):
>   ddr: imx: Remove duplicate includes
>   ddr: imx: Remove undefined declarations
>   ddr: imx: Remove unused macros
>   ddr: imx: Remove unnecessary macro argument
>=20
>  arch/arm/include/asm/arch-imx8m/ddr.h | 10 ++++------
>  arch/arm/include/asm/arch-imx9/ddr.h  |  8 ++------
>  drivers/ddr/imx/imx8m/ddr_init.c      |  8 ++++----
>  drivers/ddr/imx/phy/ddrphy_utils.c    | 15 +++++++--------
>  drivers/ddr/imx/phy/helper.c          |  4 +---
>  5 files changed, 18 insertions(+), 27 deletions(-)
>=20
> --=20
> 2.53.0
>=20
> base-commit: 7995bf8dea2d5b3eb7fcb836636f4773924ec35d
> branch: ddr-imx-clean-up
> 
