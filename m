Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E54BCEE328
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 15:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27F283D07;
	Tue, 18 Nov 2025 16:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Zt+mVA0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C746F83D07; Tue, 18 Nov 2025 16:35:19 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC89383B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 16:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 9F2311FA82;
 Tue, 18 Nov 2025 16:35:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1763480117;
 bh=aujTqfYXrpDpq4joxunmVR0Nsc6OSmHzDpayluN8AnE=; h=From:To:Subject;
 b=Zt+mVA0zak2C8ytRSon10DOso9OhER/HbXuGBZMiN7PEweXCH3/eV8Xzjo1msHixI
 lmfmnTg4YYU8V9AB6rJVNCk/qAbHdK0F1DYDr/6e9QcYffeX05KIt3VpAjAes/hdpi
 g84xGkfxjjhSga4j6/izeFeuNla26CNDsw4SKb3Bm+tqUDKAWuLGEHM+gw764CutQ3
 BA3IeKmORujIlVoYqnik8nSPWne772Q6Q+7lNtNvIzIu5JpoXa7Ptj37IUihW1cqR0
 9KeC2SWojDdWiqbClaAAJU05SSNHZVuT5+mc2Iecz0WNR0+aVgOb4Xf9F9kyYd6grs
 MKyytlFwlnlhQ==
Date: Tue, 18 Nov 2025 16:35:13 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] configs: colibri-imx7*: set 'fdtfile' generically in
 PREBOOT
Message-ID: <20251118153513.GA56804@francesco-nb>
References: <20251118144815.1242023-1-ernestvanhoecke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118144815.1242023-1-ernestvanhoecke@gmail.com>
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

On Tue, Nov 18, 2025 at 03:48:00PM +0100, Ernest Van Hoecke wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> In TEZI (Toradex Easy Installer), we use one U-Boot binary for both our
> NAND and eMMC Colibri iMX7 modules. Currently, CONFIG_PREBOOT sets the
> environment variable 'fdtfile' depending on which defconfig was used,
> adding the '-emmc' variant for the emmc defconfig. Since we always build
> the TEZI recovery U-Boot with the standard (non-emmc) defconfig, fdtfile
> has to be overwritten later or it will be wrong there.
> 
> By using '$variant', the fdtfile var is properly constructed at run time
> for both the NAND and eMMC variants, and we do not have to worry about
> setting fdtfile again when building the recovery TEZI U-Boot.
> 
> This also synchronizes these configs with how we handle the iMX6ULL.
> 
> Fixes: 327381e8b57c ("colibri_imx7: use preboot for fdtfile evaluation")
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

