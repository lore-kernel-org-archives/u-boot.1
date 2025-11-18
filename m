Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98BCCED617
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 12:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C1883B99;
	Tue, 18 Nov 2025 13:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="uhoY9F6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7212183CB9; Tue, 18 Nov 2025 13:36:49 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8589983A8F
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 4D7B01FB42;
 Tue, 18 Nov 2025 13:36:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1763469404;
 bh=O0kHl9z+jaOzuDFcacYJgudQ7mwQdNiOcw84+cZsd/I=; h=From:To:Subject;
 b=uhoY9F6+vi3ncgm0+jEVf/N0C1Vvv1R3QSRNVQAMRtWTIG4nTaVIyglblNj7HKOzl
 G18QB/axYcNE7jbLmjD1v2u2+xbiqyfMOOpzQm40/jbPesbvPOFIlumnKXG+Uo4dI4
 RyLKKKlHhYjpVLWrp2393py9ThClAts8IRTOIutk+UyeYDAYHv+5vKxUC7LX3BFSJA
 FVUBovDN+J91HEI4n9vkD/fbPb7Mhip6KY+FG4pjoYhFhxMVKXyHmF8Fv07Rxo0/dy
 8pazk0lHAOyv/Ic4kuzY+GZfZayjx8j1J0cmrH3qRO0ANkvlcRthyMxtZQsxP8rwzl
 UUDl/LHNW67Ug==
Date: Tue, 18 Nov 2025 13:36:40 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] configs: colibri-imx7*: set 'fdtfile' generically in
 PREBOOT
Message-ID: <20251118123640.GA39789@francesco-nb>
References: <20251118123056.1124089-1-ernestvanhoecke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118123056.1124089-1-ernestvanhoecke@gmail.com>
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

On Tue, Nov 18, 2025 at 01:30:52PM +0100, Ernest Van Hoecke wrote:
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

