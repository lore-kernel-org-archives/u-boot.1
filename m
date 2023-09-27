Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0D2E810B3
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 10:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75EB686E07;
	Wed, 27 Sep 2023 12:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40EB186E08; Wed, 27 Sep 2023 12:00:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 33FC086E06
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 12:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 815C61FB;
 Wed, 27 Sep 2023 03:01:21 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB11B3F59C;
 Wed, 27 Sep 2023 03:00:41 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:00:32 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Okhunjon Sobirjonov <okhunjon72@gmail.com>
Cc: bigunclemax@gmail.com, cfsworks@gmail.com, jagan@amarulasolutions.com,
 jernej.skrabec@gmail.com, linux-sunxi@lists.linux.dev, samuel@sholland.org,
 u-boot@lists.denx.de, uwu@icenowy.me, Okhunjon Sobirjonov
 <Okhunjon.Sobirjonov@Mec-electronics.com>
Subject: Re: sunxi: introduce NCAT2 generation model
Message-ID: <20230927110032.5b9a69e1@donnerap.manchester.arm.com>
In-Reply-To: <20230927094252.61765-1-okhunjon72@gmail.com>
References: <20230721134606.4505-9-andre.przywara@arm.com>
 <20230927094252.61765-1-okhunjon72@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 27 Sep 2023 12:42:52 +0300
Okhunjon Sobirjonov <okhunjon72@gmail.com> wrote:

Hi,

> When NCAT2 generation model's introduced for t113,
> the modification in drivers/mmc/sunxi_mmc.c
> > + IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) && (sdc_no == 2))  
> in struct mmc *sunxi_mmc_init(int sdc_no) seems to have
> some negative side effects, meaning enabling 8-bit mode for MMC2.

"Some negative side effects" sounds cute, but it actually breaks it ;-)

> Paticularly,  IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
> should not be used for D1/T113 
> since there is not support for 8-bit mode for MMC2 yet.
> Therefore, the solution would be to drop this particular
> change entirely.

So yeah, that line is just plain wrong, it seems like all the NCAT SoCs we
have seen (D1/T113/R329) do no support 8-bit eMMC.

So thanks for the heads up, I will remove that line from v2.

> Signed-off-by: Okhunjon Sobirjonov <Okhunjon.Sobirjonov@Mec-electronics.com> 

S-o-b:'s are only needed for actual patch submissions, not for comments on
the list.

Cheers,
Andre
