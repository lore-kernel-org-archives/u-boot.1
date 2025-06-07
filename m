Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4FFC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 13:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 641A580E9A;
	Sat,  7 Jun 2025 15:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="j8WWbwyh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5235081F0D; Sat,  7 Jun 2025 15:29:46 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C41D807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 15:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (adsl-178-39-61-184.adslplus.ch [178.39.61.184])
 by mail11.truemail.it (Postfix) with ESMTPA id 8B1BC20ADA;
 Sat,  7 Jun 2025 15:29:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1749302982;
 bh=Gag/5prgXaPqs251dF3nIxjpEDzJaZO80LabzyOevxk=; h=From:To:Subject;
 b=j8WWbwyhpYF0j07ZCW8rgz+C3EP7MvkJWkia3jLceD5oDvNXTJyxdEIi/6cSdBIXe
 /Gz1GBa9JflqBN6tMbSiqCAbv3RjVN9eocKdwKRdKqzxca0z/KuH7Cx+tmVjjCxgrG
 eCPSBT34zV8Ls47AkRZ6XHp4+v64mygzbU95GSIgm97nj+TS3GVmcXDCwcgqpgQGE9
 sOrwF55xUH3QL4s0dVGDYZaDkda+98cR49SUuUrhNw6WMQWM/PKilPfkqsjZSlSiDH
 i1Ov2uZXwdpEGuPA4jSeVlMArcdD2EKOKLK++6M4lOpUzQqtEc9SzEn26YFEavO6tz
 t7VciPX+Po0EQ==
Date: Sat, 7 Jun 2025 15:29:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] verdin-am62p: include linux/sizes.h
Message-ID: <20250607132932.GA4145@francesco-nb>
References: <20250607120303.210990-1-heinrich.schuchardt@canonical.com>
 <20250607120303.210990-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607120303.210990-2-heinrich.schuchardt@canonical.com>
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

On Sat, Jun 07, 2025 at 02:03:01PM +0200, Heinrich Schuchardt wrote:
> Avoid build failures
> 
> In file included from include/config.h:3,
>                  from board/toradex/verdin-am62p/verdin-am62p.c:9:
> board/toradex/verdin-am62p/verdin-am62p.c: In function 'dram_init':
> include/configs/verdin-am62p.h:13:33: error: 'SZ_2G' undeclared (first use in this function)
>    13 | #define CFG_SYS_SDRAM_SIZE      SZ_2G /* Maximum supported size */
>       |                                 ^~~~~
> board/toradex/verdin-am62p/verdin-am62p.c:63:65: note: in expansion of macro 'CFG_SYS_SDRAM_SIZE'
>    63 |         gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
>       |                                                                 ^~~~~~~~~~~~~~~~~~
> include/configs/verdin-am62p.h:13:33: note: each undeclared identifier is reported only once for each function it appears in
> board/toradex/verdin-am62p/verdin-am62p.c:65:28: error: 'SZ_1G' undeclared (first use in this function)
>    65 |         if (gd->ram_size < SZ_1G)
>       |                            ^~~~~
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/toradex/verdin-am62p/verdin-am62p.c | 1 +
>  include/configs/verdin-am62p.h            | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
> index 8b246e9d304..5ca4f8ee21d 100644
> --- a/board/toradex/verdin-am62p/verdin-am62p.c
> +++ b/board/toradex/verdin-am62p/verdin-am62p.c
> @@ -15,6 +15,7 @@
>  #include <fdt_support.h>
>  #include <init.h>
>  #include <k3-ddrss.h>
> +#include <linux/sizes.h>
>  #include <spl.h>
>  #include <linux/sizes.h>
You are including sizes.h twice, remove this change?

Francesco
