Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C23EE2082
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 10:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE4B83AA9;
	Fri,  6 Feb 2026 11:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hq1kjRgh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E818F83AAD; Fri,  6 Feb 2026 11:24:30 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5227683A64
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 11:24:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 93ABE60010;
 Fri,  6 Feb 2026 10:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA2AC116C6;
 Fri,  6 Feb 2026 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770373466;
 bh=OkoTGsaPBgYU5nE0fwHp8WDalhRqsHXGhv2fzYObYEI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hq1kjRghYVAZApjdhvMJ0u3fqyHz1yLUTicwTejJPsG1bKp0rjEzmKaZgkVRSE7Ev
 OjmT3E6qiUWcbsWsB+cHDX5QWKK79K4yIwYtjraYRecK7arfXO2UiiNfHMRjwDV7kU
 OLJAfzUNgCCb0FV1tjUje8URr+gIhyLrPqjmEVSX2ykXj8XNWqtXlR1fueFaWiLE/L
 G7UF6OKKbutle1JPVL6sq4EWNt8YYoTmoaMY9yDyGulo/Fy97X30qMjsAkx340Tgef
 1pSTnckKRuog1OzV26UC31lLkG53nU4Qb1xkF7FQj0cTLE/4llIArse53eZC5pOL1J
 z9r+Oo2An1fEA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heiko Schocher <hs@nabladev.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>, Heiko Schocher
 <hs@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v1 2/2] arch: imx8qxp: Override weak
 fb_mmc_get_boot_offset function
In-Reply-To: <20260124054712.7939-3-hs@nabladev.com>
References: <20260124054712.7939-1-hs@nabladev.com>
 <20260124054712.7939-3-hs@nabladev.com>
Date: Fri, 06 Feb 2026 11:24:23 +0100
Message-ID: <87pl6ikw4o.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Heiko,

Thank you for the patch.

On Sat, Jan 24, 2026 at 06:47, Heiko Schocher <hs@nabladev.com> wrote:

> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
> Add IMX8QXP SoCs specific implementation of fb_mmc_get_boot_offset()
>
> This is needed as bootloader offset is different dependent on SoC
> revision!
>
> For revision B0 the bootloader starts at 32k offset. On offset
> 0x0 the bootloaders environment is stored.
>
> On C0 revisions of the SoC bootloader image starts at offset 0x0
>
> Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

This looks good to me but please have a look at Peng's comment [1]

I can pick this up but I'll need an ACK from Stefano, Fabio or someone
from u-boot-imx@nxp.com

[1] https://lore.kernel.org/all/aXbHDnU+SpgnEt+Q@shlinux89/

> ---
>
>  arch/arm/mach-imx/imx8/cpu.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
