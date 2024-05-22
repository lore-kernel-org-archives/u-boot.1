Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DC1C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B978987D74;
	Thu, 23 May 2024 01:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 700B283333; Thu, 23 May 2024 01:39:41 +0200 (CEST)
Received: from smtp.gentoo.org (dev.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0151882A9
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Date: Wed, 22 May 2024 23:39:15 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: u-boot@lists.denx.de, Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: Re: [PATCH 2/4] clk: sophgo: cv1800b: Add clock controller driver
 for cv1800b SoC
Message-ID: <20240522233915.GA1990099@ofsar>
References: <20240519150736.13203-1-seashell11234455@gmail.com>
 <20240519150736.13203-3-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519150736.13203-3-seashell11234455@gmail.com>
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

Hi Kongyang:

I've got one compiling error

On 23:07 Sun 19 May     , Kongyang Liu wrote:
> Add clock controller driver for sophgo cv1800b SoC
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
>  drivers/clk/Kconfig              |   1 +
>  drivers/clk/Makefile             |   1 +
>  drivers/clk/sophgo/Kconfig       |  14 +
>  drivers/clk/sophgo/Makefile      |   6 +
>  drivers/clk/sophgo/clk-common.h  |  74 +++
>  drivers/clk/sophgo/clk-cv1800b.c | 794 +++++++++++++++++++++++++++++++
>  drivers/clk/sophgo/clk-cv1800b.h | 123 +++++
>  drivers/clk/sophgo/clk-ip.c      | 594 +++++++++++++++++++++++
>  drivers/clk/sophgo/clk-ip.h      | 288 +++++++++++
>  drivers/clk/sophgo/clk-pll.c     | 284 +++++++++++
>  drivers/clk/sophgo/clk-pll.h     |  74 +++
>  11 files changed, 2253 insertions(+)
>  create mode 100644 drivers/clk/sophgo/Kconfig
>  create mode 100644 drivers/clk/sophgo/Makefile
>  create mode 100644 drivers/clk/sophgo/clk-common.h
>  create mode 100644 drivers/clk/sophgo/clk-cv1800b.c
>  create mode 100644 drivers/clk/sophgo/clk-cv1800b.h
>  create mode 100644 drivers/clk/sophgo/clk-ip.c
>  create mode 100644 drivers/clk/sophgo/clk-ip.h
>  create mode 100644 drivers/clk/sophgo/clk-pll.c
>  create mode 100644 drivers/clk/sophgo/clk-pll.h
> 

...

> +static ulong cv1800b_ipll_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct cv1800b_clk_ipll *pll = to_clk_ipll(clk);
> +	ulong parent_rate = clk_get_parent_rate(clk);
> +	u32 pre_div, post_div, div;
> +	u32 pre_div_sel, post_div_sel, div_sel;
> +	ulong new_rate, best_rate = 0;
> +	u32 mode, ictrl;
> +	u32 test, val;
> +
> +	FOR_RANGE(pre_div, PLL_PRE_DIV)
> +	{
> +		FOR_RANGE(post_div, PLL_POST_DIV)
> +		{
> +			FOR_RANGE(div, PLL_DIV)
> +			{
> +				new_rate = DIV_ROUND_DOWN_ULL(parent_rate * div
                                                                          ~~~~~~
							     miss a comma here
> +							      pre_div * post_div);
> +				if (rate - new_rate < rate - best_rate) {
> +					best_rate = new_rate;
> +					pre_div_sel = pre_div;
> +					post_div_sel = post_div;
> +					div_sel = div;
> +				}
> +			}
> +		}
> +	}
> +
> +	FOR_RANGE(mode, PLL_MODE)

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
