Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446DCE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 17:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB8FF803A9;
	Wed, 11 Dec 2024 18:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="jLtITHca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC0C803AE; Wed, 11 Dec 2024 18:39:38 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2221E80316
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 18:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 02C00201BA;
 Wed, 11 Dec 2024 18:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1733938775;
 bh=bKNXmwB33qNmlg1f7xBsqh85FCqcvipHj+UAPN/ga/M=; h=From:To:Subject;
 b=jLtITHca8z6+pNTmgVp0+w1dxMhAMBLDvstqV+6pBKQmlFOOXtWDH1gWGg0ysdd2f
 Ns5lT8HmjKvfR8bHUkNtqUsubyVEZCvyXsaaNNmhqhtCYNqyZw2EttFc1S2Af2U9+x
 GVTGVDIVN+1W8gAE1KVv76dR0qvNE8CRdPMyDgGX9MQI40lxROrdNG+sVhereQvUsr
 c7W7jKKSFQ5e01AwSADJmhbeE2s17fr7D3vexYniGQBlGcdKjDZnVB7UguWM3YmKaz
 nUVOKtrasuJGCDqv6CyMuSatmCi8ewj54OPg2IbwCqGSMesARI4zlP0ebVjASebQyv
 qKB5FXb7Wi4Eg==
Date: Wed, 11 Dec 2024 18:39:30 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, francesco.dolcini@toradex.com,
 stefan.eichenberger@toradex.com, peng.fan@nxp.com,
 emanuele.ghidoli@toradex.com, joao.goncalves@toradex.com,
 vitor.soares@toradex.com, igor.opaniuk@foundries.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] add support for Apalis iMX8 1300MHz version
Message-ID: <20241211173930.GA48532@francesco-nb>
References: <20241211122036.103383-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211122036.103383-1-eichest@gmail.com>
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

On Wed, Dec 11, 2024 at 01:18:50PM +0100, Stefan Eichenberger wrote:
> This patch series adds support for the Apalis iMX8, which utilizes the
> industrial 1300MHz version of the iMX8 SoC. Additionally, it includes
> minor cleanups that do not affect functionality.

...

>  arch/arm/mach-imx/imx8/fdt.c            | 132 +++++++++++++++++
>  board/toradex/apalis-imx8/apalis-imx8.c |  19 ++-
>  board/toradex/common/tdx-cfg-block.c    | 183 ++++++++++++------------
>  board/toradex/common/tdx-cfg-block.h    |   5 +
>  4 files changed, 239 insertions(+), 100 deletions(-)

For the whole series,

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

