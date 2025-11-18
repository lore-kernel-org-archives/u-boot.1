Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115E1CED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 12:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928D583B99;
	Tue, 18 Nov 2025 13:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="dF1xzyrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD7A83C5E; Tue, 18 Nov 2025 13:42:17 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE8883A8F
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 4AD921FA5F;
 Tue, 18 Nov 2025 13:42:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1763469734;
 bh=AKW5apfEjfzT1chaGlcQoON2Stcf+jN+cygzcWgXeJo=; h=From:To:Subject;
 b=dF1xzyrH4Idu96KYFz29Fq544RQjx5N9QEIrXjP395IPFY4PQe8rgFGuxir14WQu0
 nAI8B8jb13OG7FTDC7G56umy999v6cmEwziamgeztjEQBWCAnd79YCdF01lv3eChRV
 vOsCB4EX75s5/J6vi4nIZ3wsDrNwcp4FQa8tgHb9VbkXo+uQtL9gjJhO9Zm35W1TyB
 bGRcGAxaco3qEfvAxT/suzYGNkhuYTXJ4P0WSRzLVqIG7xb2h1fBve//z2T/bDCKpx
 QLiva7btNjNCQ/CnTubnCjRhd9dCZLTFXldpyXZZn1i30ioAlHvUgEShsQnwJcPGH1
 Hw/JN01T39Vug==
Date: Tue, 18 Nov 2025 13:42:09 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Ernest Van Hoecke <ernestvanhoecke@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] configs: colibri-imx7*: set 'fdtfile' generically in
 PREBOOT
Message-ID: <20251118124209.GA40603@francesco-nb>
References: <20251118123056.1124089-1-ernestvanhoecke@gmail.com>
 <20251118123640.GA39789@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118123640.GA39789@francesco-nb>
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

On Tue, Nov 18, 2025 at 01:36:48PM +0100, Francesco Dolcini wrote:
> On Tue, Nov 18, 2025 at 01:30:52PM +0100, Ernest Van Hoecke wrote:
> > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > 
> > In TEZI (Toradex Easy Installer), we use one U-Boot binary for both our
> > NAND and eMMC Colibri iMX7 modules. Currently, CONFIG_PREBOOT sets the
> > environment variable 'fdtfile' depending on which defconfig was used,
> > adding the '-emmc' variant for the emmc defconfig. Since we always build
> > the TEZI recovery U-Boot with the standard (non-emmc) defconfig, fdtfile
> > has to be overwritten later or it will be wrong there.
> > 
> > By using '$variant', the fdtfile var is properly constructed at run time
> > for both the NAND and eMMC variants, and we do not have to worry about
> > setting fdtfile again when building the recovery TEZI U-Boot.
> > 
> > This also synchronizes these configs with how we handle the iMX6ULL.
> > 
> > Fixes: 327381e8b57c ("colibri_imx7: use preboot for fdtfile evaluation")
> > Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

nack, I did a mistake.

There is an error in the patch, we need to keep the ${soc} variable to
differentiate between imx7d and imx7s

Francesco

