Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBB7CD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 16:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ECAF8404D;
	Fri, 22 May 2026 18:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Q+EX6rP5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB8884659; Fri, 22 May 2026 18:10:07 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E31383FF5
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 18:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1779466197; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RIQF+O+wpWEF1iZpGUbmEvOr8sB9WICuVf1xDTduiHDl3jfkOcinpfeau1N9HqsrAnOMIvLnk6+p3UEs33h0qVXdg5aVsNk7/p5K1VIHnLHKAn+ovEUsNnXV53u7VwwDmlRJ3RYVS5r8yDeTBiU9njVY9P4gcIFkffbZxEfWzjU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779466197;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=G8zDiuGljDbO/KGJpLVW9petotRCDDW85qaxWSTOv00=; 
 b=LnU5PgMaFcACMAmDQebVaK5+xv5tL/nL3FmiYdK/3QYb4sLeD0xxQA21ACSJxvBed0HCGJuJRbTtb+JGlAauPR50dFrd9qjzm8cXqM4w1N6SlkiW5+Kru0megOSYQSCg8YoCBcDmBBIpbOm4M3RhTTw4jdkuUP7Pq2n0VIrMZjE=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779466197; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=G8zDiuGljDbO/KGJpLVW9petotRCDDW85qaxWSTOv00=;
 b=Q+EX6rP5yEWjv7b2mLbqLkIycWVi9O93KsPXh6OnK6Eo+xDS3kzxf19HXOqhoCx0
 /h/R9ulH0s6YGgUsrZ16HrwQ7ehkL51rsoR6fBWLPydNcjutcJ+O/e26NlYyhKEGWBy
 2Vn8+UXUPNU4lDgHvquUahRdqzvuHlIESdooKPb4=
Received: by mx.zohomail.com with SMTPS id 1779466194360794.3919440052836;
 Fri, 22 May 2026 09:09:54 -0700 (PDT)
Date: Fri, 22 May 2026 16:09:41 +0000
From: Yao Zi <me@ziyao.cc>
To: Guodong Xu <guodong@riscstar.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Peter Korsgaard <peter@korsgaard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 u-boot-spacemit@groups.io, Vincent Legoll <legoll@online.fr>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/8] clk: spacemit: Add support for K1 SoC
Message-ID: <ahB_xeaHbMHkIxO6@pie>
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
 <20260510-b4-k1-clk-reset-upstream-dts-v1-1-db0b0503ee44@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510-b4-k1-clk-reset-upstream-dts-v1-1-db0b0503ee44@riscstar.com>
X-ZohoMailClient: External
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

On Sun, May 10, 2026 at 08:06:23AM -0400, Guodong Xu wrote:
> From: Junhui Liu <junhui.liu@pigmoral.tech>
> 
> The K1 SoC exposes four clock providers in the kernel mainline DT: one
> PLL controller ("spacemit,k1-pll") and three syscon clock nodes
> ("spacemit,k1-syscon-{mpmu,apbc,apmu}"). Register a separate
> U_BOOT_DRIVER for each.
> 
> Inter-controller ordering is enforced where the registers actually
> depend on each other.

What do you mean by "registers actually depend on each other"? Do you
refer to the fact that some APBC clocks are derived from APMU/PLL
controllers thus must be registered after them? If so, would this
series[1] help which allows arbitrary clock registration order and
handles dependencies in CCF instead?

> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  drivers/clk/Kconfig               |    5 +-
>  drivers/clk/Makefile              |    1 +
>  drivers/clk/spacemit/Kconfig      |   23 +
>  drivers/clk/spacemit/Makefile     |    7 +
>  drivers/clk/spacemit/clk-k1.c     | 1722 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/spacemit/clk_common.h |   79 ++
>  drivers/clk/spacemit/clk_ddn.c    |   93 ++
>  drivers/clk/spacemit/clk_ddn.h    |   53 ++
>  drivers/clk/spacemit/clk_mix.c    |  403 +++++++++
>  drivers/clk/spacemit/clk_mix.h    |  224 +++++
>  drivers/clk/spacemit/clk_pll.c    |  157 ++++
>  drivers/clk/spacemit/clk_pll.h    |   81 ++
>  include/soc/spacemit/k1-syscon.h  |  149 ++++
>  13 files changed, 2995 insertions(+), 2 deletions(-)

...

> diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
> new file mode 100644
> index 00000000000..03aecefddc4
> --- /dev/null
> +++ b/drivers/clk/spacemit/Kconfig
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (c) 2025, Junhui Liu <junhui.liu@pigmoral.tech>
> +
> +config CLK_SPACEMIT
> +	bool "Clock support for SpacemiT SoCs"
> +	depends on CLK

What about

	depends on CLK || COMPILE_TEST

to allow building-only tests?

> +	select REGMAP
> +	help
> +	  This enables support clock driver for Spacemit SoC
> +	  family.
> +
> +if CLK_SPACEMIT
> +
> +config CLK_SPACEMIT_K1
> +	bool "SpacemiT K1 clock support"
> +	select CLK_CCF
> +	select LIB_RATIONAL

CLK_SPACEMIT instead of CLK_SPACEMIT_K1 should selects LIB_RATIONAL...

> +	help
> +	  This enables support clock driver for Spacemit K1 SoC.
> +	  It's based on Common Clock Framework.
> +
> +endif
> diff --git a/drivers/clk/spacemit/Makefile b/drivers/clk/spacemit/Makefile
> new file mode 100644
> index 00000000000..824e94d1f74
> --- /dev/null
> +++ b/drivers/clk/spacemit/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
> +
> +obj-$(CONFIG_CLK_SPACEMIT) += clk_ddn.o clk_mix.o clk_pll.o

... since the driver actually makes use of rational routines, clk_ddn.o,
is guarded by CONFIG_CLK_SPACEMIT, not CONFIG_CLK_SPACEMIT_K1.

> +obj-$(CONFIG_CLK_SPACEMIT_K1)	+= clk-k1.o
> diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
> new file mode 100644
> index 00000000000..4c0972d952e
> --- /dev/null
> +++ b/drivers/clk/spacemit/clk-k1.c

...

> +struct clk_retry_item {
> +	struct ccu_common *common;
> +	struct list_head link;
> +};
> +
> +static LIST_HEAD(retry_list);
> +
> +static int k1_clk_retry_register(void)
> +{
> +	struct clk_retry_item *item, *tmp;
> +	int retries = 5;
> +	int ret;
> +
> +	while (!list_empty(&retry_list) && retries) {
> +		list_for_each_entry_safe(item, tmp, &retry_list, link) {
> +			struct ccu_common *common = item->common;
> +
> +			ret = common->init(common);
> +			if (ret)
> +				return ret;
> +
> +			list_del(&item->link);
> +			kfree(item);
> +		}
> +		retries--;
> +	}
> +
> +	return 0;
> +}

Is retrying for handling dependencies between clocks? Could the series
I mentioned above help? This version looks very hacking...

Another solution might be carefully specify the order in which clocks
are registered to ensure parents are always registered before children.

...

> diff --git a/drivers/clk/spacemit/clk_ddn.c b/drivers/clk/spacemit/clk_ddn.c
> new file mode 100644
> index 00000000000..7b93f30d5c3
> --- /dev/null
> +++ b/drivers/clk/spacemit/clk_ddn.c

...

> +static unsigned long ccu_ddn_calc_best_rate(struct ccu_ddn *ddn,
> +					    unsigned long rate, unsigned long prate,
> +					    unsigned long *num, unsigned long *den)
> +{
> +	rational_best_approximation(rate, prate / ddn->pre_div,
> +				    ddn->den_mask >> ddn->den_shift,
> +				    ddn->num_mask >> ddn->num_shift,
> +				    den, num);

Rational routines are used here.

> +	return ccu_ddn_calc_rate(prate, *num, *den, ddn->pre_div);
> +}

Best regards,
Yao Zi

[1]: https://lore.kernel.org/u-boot/20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com/
