Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6D6C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 17:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC5581E14;
	Sat, 26 Apr 2025 19:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="dUB4FpbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C20A81F45; Sat, 26 Apr 2025 19:09:36 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9985810EB
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 19:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8964925C33;
 Sat, 26 Apr 2025 19:09:33 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CtgU5iiot9k6; Sat, 26 Apr 2025 19:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745687372; bh=I76S7BzDIkYAyETdZHudMYV3jyByNsIIQBHl2HZStAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dUB4FpbNUFQRy8f6ekDdd81bG2mGVm0ZMLKbdrYfITjIjyoJeQ+ElC677ZUEcG/Eh
 qzJ8YFOFSQXSO2DO5pMyAUgs/ZsuHlwSLii6DDiJtN+9LvDM1MHgjToWLQik7bgVPK
 h9T2DkKFdYptOa+f6Tb/yolaeYRcypzYBV8rWneYhQCQBIvgefs8UelNteJ3xgd06P
 3q6kb0fm9lHB2ChG20f5m759cEzfEocMR1y8M8B3SQoaOZxXbV3K2cx5QwN7We2GLl
 2vWnUQpBm6zygq4oynNFwOiiT3PPAFS/w5l0On+b+LThI405C49Sg7uprqq9gm/Pkr
 eb7Ff4qc3TIxg==
Date: Sat, 26 Apr 2025 17:09:16 +0000
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 04/10] ram: thead: Add initial DDR controller support for
 TH1520
Message-ID: <aA0TPBV_YN3IHGAf@pie.lan>
References: <20250426165704.35523-1-ziyao@disroot.org>
 <20250426165704.35523-5-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426165704.35523-5-ziyao@disroot.org>
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

On Sat, Apr 26, 2025 at 04:56:58PM +0000, Yao Zi wrote:
> This patch cleans the vendor code of DDR initialization up, converts the
> driver to fit in DM framework and use a firmware[1] packaged by binman to
> ship PHY configuration.
> 
> Currently the driver is only capable of initializing the controller to
> work with dual-rank 3733MHz LPDDR4, which is shipped by 16GiB variants
> of LicheePi 4A boards and I could test with. Support for other
> configurations could be easily added later.

I wrongly repeated this patch twice when sending the series, sorry for
the noise.

> Link: https://github.com/ziyao233/th1520-firmware # [1]
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/ram/Kconfig            |   1 +
>  drivers/ram/Makefile           |   4 +
>  drivers/ram/thead/Kconfig      |   5 +
>  drivers/ram/thead/Makefile     |   1 +
>  drivers/ram/thead/th1520_ddr.c | 781 +++++++++++++++++++++++++++++++++
>  5 files changed, 792 insertions(+)
>  create mode 100644 drivers/ram/thead/Kconfig
>  create mode 100644 drivers/ram/thead/Makefile
>  create mode 100644 drivers/ram/thead/th1520_ddr.c

...

> diff --git a/drivers/ram/thead/th1520_ddr.c b/drivers/ram/thead/th1520_ddr.c
> new file mode 100644
> index 00000000000..ff9860b9c3d
> --- /dev/null
> +++ b/drivers/ram/thead/th1520_ddr.c
> @@ -0,0 +1,781 @@
> +#include <binman.h>
> +#include <binman_sym.h>
> +#include <dm.h>
> +#include <init.h>
> +#include <linux/bitfield.h>
> +#include <linux/iopoll.h>
> +#include <ram.h>

And here is missing an SPDX license header and a copyright notice. I'll
add them in v2.

Thanks,
Yao Zi
