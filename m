Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379C1CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99ACC84523;
	Fri, 28 Nov 2025 12:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="dlNs2P/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BD484528; Fri, 28 Nov 2025 12:29:28 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E0584513
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 281A41F928;
 Fri, 28 Nov 2025 12:29:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1764329366;
 bh=QI/EP1/wWJS6tv4pXuSlNyX4+EKxujEwUKvg914O4Rg=; h=From:To:Subject;
 b=dlNs2P/uKtY5Maq1oQ7NjlN2s1NcuvVlkcPMqjzTTYj8gzAMBFJe/sY1XTScnzZn8
 LIFrCOAgduC/IwOBASKDwuRBNoj6cIG2WvWIB3cwKDUYV0aZeEEXfygqyUE2RjWGbk
 pWxeXBn2DE9D0ygt0uejYcOht27hmcBrPwrgtCmzhKbi78UHr03ABnG/A4l4pSVVYI
 Nd0dlFGy3heFoEj/SOy6tcU2Nue5GjccWBEeKQ7NGqdtsolIaYbqsHe1WJ61fiUiy7
 Z8bxMrskyW3fWZhc7VHXIpeQH/XANJfDM2P6zTGOLrJToA3ThoNMqgBxgg31KabBqo
 VuQRUBT8k5Zgg==
Date: Fri, 28 Nov 2025 12:29:24 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 5/5] board: toradex: add splash screen to Toradex i.MX7D
 Colibri board
Message-ID: <20251128112924.GB32259@francesco-nb>
References: <20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com>
 <20251126-repair_imx7_splash-v1-5-d3877afb7381@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-repair_imx7_splash-v1-5-d3877afb7381@bootlin.com>
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

On Wed, Nov 26, 2025 at 12:41:57AM +0100, Thomas Bonnefille wrote:
> This commit fixes the PWM<A> that was previously used as a GPIO output
> instead of a real PWM, it also reserve the framebuffer region to
> preserve the splash screen while the OS is booting.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  board/toradex/colibri_imx7/colibri_imx7.c | 40 +++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
> index 69a8a18d3a7..b5d22337a04 100644
> --- a/board/toradex/colibri_imx7/colibri_imx7.c
> +++ b/board/toradex/colibri_imx7/colibri_imx7.c
> @@ -7,6 +7,8 @@
>  #include <env.h>
>  #include <init.h>
>  #include <net.h>
> +#include <fdt_simplefb.h>
> +#include <video.h>

The includes here are "somehow" sorted, please keep it the same way.

Francesco

