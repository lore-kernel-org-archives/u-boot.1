Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7661CCD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 18:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E758A848EB;
	Sun, 24 May 2026 20:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="C8K4d3jU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809FF848FC; Sun, 24 May 2026 20:42:43 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C77B848D7
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 20:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=46ba=DW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779648158;
 bh=09ADxbmtY1TDxhBqAOScYnd1LpHTH3iYWPv+u1PaZc8=;
 b=C8K4d3jUNmweZPFydqBQK86ZDuRbHl+oBUtm7q4vhAZ4tIFUm8F3rivDbOaH3sIYSKrWJyRKr
 a4VBPLhcHvtut4EmHe7BZdH8Yjvt5wLRODBKJJ7ft2TRVZb+Rx9qSMHwImbwltsS6p2CO6nFuTY
 FyqfkOPKjHi5kl8ejajqMc/qt7fCilUKjEaVkzbCxaKFmJTF1UDHeuDgFw2LY+lcH5XSkZTfjre
 4HQpxG15D+Mt09GOT3FEXSUhv+3E8A47EcV2yIQ17BhaLrd3BAo5G6dAMYC6koxX5Hjhj7UfPpz
 PRCavcg9EHGcdFNt2WtdxEHSua7l//Id3X/2W6WRB/Sw==
X-Forward-Email-ID: 6a13469d1434e766ef8727cb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <bc4973d8-2b04-4f24-a6bf-62b182a100be@kwiboo.se>
Date: Sun, 24 May 2026 20:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/18] clk: rockchip: rk3568: Fix probe with
 OF_PLATDATA enabled
To: Pavel Golikov <paullo612@ya.ru>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
 <20260517-rk3568-raminit-v1-2-a24e16302a13@ya.ru>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260517-rk3568-raminit-v1-2-a24e16302a13@ya.ru>
Content-Type: text/plain; charset=UTF-8
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

Hi Pavel,

On 5/17/2026 9:24 PM, Pavel Golikov wrote:
> Properly initialize cru address space reference when CONFIG_OF_PLATDATA
> is enabled.

Do we have to use OF_PLATDATA for TPL to fit into SRAM?

Also, why do we need CLK driver in TPL? Based on small glance at the
code it looks like the DPLL was handled by the RAM driver itself.

I will also shortly send out a series that cleanup a few of these
syscon_get_first_range(ROCKCHIP_SYSCON_x), rockchip_get_cru() or
rockchip_get_clk() usage.

Hopefully that can give you a cleaner baseline, with the direction most
recently added RK SoCs have been following.

Regards,
Jonas

> 
> Signed-off-by: Pavel Golikov <paullo612@ya.ru>
> ---
>  drivers/clk/rockchip/clk_rk3568.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 67bc04b81c0..199bb51fa6f 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -9,6 +9,7 @@
>  #include <dm.h>
>  #include <dt-structs.h>
>  #include <errno.h>
> +#include <mapmem.h>
>  #include <syscon.h>
>  #include <asm/arch-rockchip/cru_rk3568.h>
>  #include <asm/arch-rockchip/clock.h>
> @@ -2906,8 +2907,14 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
>  static int rk3568_clk_probe(struct udevice *dev)
>  {
>  	struct rk3568_clk_priv *priv = dev_get_priv(dev);
> +#if CONFIG_IS_ENABLED(OF_PLATDATA)
> +	struct rk3568_clk_plat *plat = dev_get_plat(dev);
> +#endif
>  	int ret;
>  
> +#if CONFIG_IS_ENABLED(OF_PLATDATA)
> +	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
> +#endif
>  	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>  	if (IS_ERR(priv->grf))
>  		return PTR_ERR(priv->grf);
> @@ -2926,9 +2933,11 @@ static int rk3568_clk_probe(struct udevice *dev)
>  
>  static int rk3568_clk_ofdata_to_platdata(struct udevice *dev)
>  {
> -	struct rk3568_clk_priv *priv = dev_get_priv(dev);
> +	if (CONFIG_IS_ENABLED(OF_REAL)) {
> +		struct rk3568_clk_priv *priv = dev_get_priv(dev);
>  
> -	priv->cru = dev_read_addr_ptr(dev);
> +		priv->cru = dev_read_addr_ptr(dev);
> +	}
>  
>  	return 0;
>  }
> 

