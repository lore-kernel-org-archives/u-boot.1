Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09716107637F
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5A584010;
	Wed,  1 Apr 2026 16:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Up8Emvos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 697C084010; Wed,  1 Apr 2026 16:32:28 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3129983F7D
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 2EBE11F963;
 Wed,  1 Apr 2026 16:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1775053945;
 bh=wO1rM/pnGB8aQrsJ11Et0LIJMT520yzArvXeEpwAQ2g=; h=From:To:Subject;
 b=Up8EmvosR+XvEMplBJPUiduQqKcsNbeW6dP3efYw01VufwcU6OPeuWRnmZffMEkhX
 EI2g9QjRfYoZB+L/aaCWmWfe4HhEtfR20jkEt10Y0USa3c8D9yqRMZrPgfScTs6TQ9
 WxlgUpMb8FxN8L5wbWE+Cn1/rxqLrDCZQxzHTtAM6ibVtGWeWGnYXT1nAngrH5TvA/
 v+Y4cS1bmpgRgpEzrz/oTBuKoGpxS16bYbh77CRu4NpERlbfV2cm07VsdXR8HY+HHj
 RB9n39eDfTP0AdebWGAWKAXv330CJPzl2Di7SILe5sJBywg9JdAt9aCOgPKdgX6Vb/
 dua+6/gN1En+w==
Date: Wed, 1 Apr 2026 16:32:21 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] configs: aquila-am69: Set ENV_MMC_EMMC_HW_PARTITION
 and ENV_RELOC_GD_ENV_ADDR
Message-ID: <20260401143221.GA52316@francesco-nb>
References: <20260401141844.539308-2-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401141844.539308-2-ivitro@gmail.com>
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

Hello Tom,

On Wed, Apr 01, 2026 at 03:18:42PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Set CONFIG_ENV_MMC_EMMC_HW_PARTITION=1 to store the environment in the
> eMMC first hardware boot partition instead of defaulting to 0 (user
> data area), where the rootfs and data partitions normally reside,
> risking corruption. This keeps the full boot stack self-contained in
> the eMMC hardware boot partition.
> 
> Enable CONFIG_ENV_RELOC_GD_ENV_ADDR so that gd->env_addr is adjusted by
> the relocation offset during U-Boot relocation. Without it, gd->env_addr
> keeps pointing to the pre-relocation address of the default
> environment, leading to incorrect environment access before env_load()
> completes.
> 
> Fixes: 3f0528882c0d ("board: toradex: add aquila am69 support")
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Tom, this is for master, I know we are very close to the release date.

Thanks,
Francesco

