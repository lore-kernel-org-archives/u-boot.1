Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB43CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 20:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1ABF8465D;
	Sun, 17 May 2026 22:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HG9jSiq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375BC8466F; Sun, 17 May 2026 22:43:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 627E6845E3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 22:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5134=DP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779050596;
 bh=hdMhvxS9HOEerGcAN4G+tX3jIuuyp3vOyCTMuva7sFM=;
 b=HG9jSiq4nMaNZkXmS6qA3cucXv/LF3z8UyKQP52/ab3FEKxImQ8wtOf903EH9kbuntfrj5pkO
 4cFfHjItsOqVwozedMNujUI8+KX66Ue4Z+ZUtal1np+EMw8iyaMp+j8CKTdPfBKusVYEy80c4jS
 Xk5fC4Bf2MdNowuC9txkNg65KwIDNGcycS4TWhwuXCVtu4v0HZCDUIcIvIjpA/Lz6aN8G3rbzCr
 fSUQ5M0W9C7sj6rOu+lcrX8ybTsu2ROrtt+Z7ohXzyQMHQCRJVaxVMBHcGOXYsCVFrmvqL+d7wU
 LTz+68KyXsYg4A+9oyefBvF1l+JevyFeABQy0404LGoA==
X-Forward-Email-ID: 6a0a285751d6696912bb7488
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f81748c8-00b0-4b87-960f-eff2d2f96707@kwiboo.se>
Date: Sun, 17 May 2026 22:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/18] rockchip: rk3568: syscon: Add MSCH, SGRF and
 DDRGRF support
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
 <20260517-rk3568-raminit-v1-4-a24e16302a13@ya.ru>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260517-rk3568-raminit-v1-4-a24e16302a13@ya.ru>
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
> Add support for the MSCH, SGRF and DDRGRF register regions in syscon,
> which are necessary for RK3568's DRAM controller initialization.
> 
> Signed-off-by: Pavel Golikov <paullo612@ya.ru>
> ---
>  arch/arm/include/asm/arch-rockchip/clock.h    |  1 +
>  arch/arm/mach-rockchip/rk3568/syscon_rk3568.c | 26 +++++++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
> index 95b08bfd046..a6b399da4ff 100644
> --- a/arch/arm/include/asm/arch-rockchip/clock.h
> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
> @@ -39,6 +39,7 @@ enum {
>  	ROCKCHIP_SYSCON_PIPE_PHY2_GRF,
>  	ROCKCHIP_SYSCON_VOP_GRF,
>  	ROCKCHIP_SYSCON_VO_GRF,
> +	ROCKCHIP_SYSCON_DDRGRF,
>  };
>  
>  /* Standard Rockchip clock numbers */
> diff --git a/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c b/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
> index b9d59a4721e..7f6caf9ca67 100644
> --- a/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
> @@ -8,8 +8,11 @@
>  #include <asm/arch-rockchip/clock.h>
>  
>  static const struct udevice_id rk3568_syscon_ids[] = {
> -	{ .compatible = "rockchip,rk3568-grf", .data = ROCKCHIP_SYSCON_GRF },
> +	{ .compatible = "rockchip,rk3568-grf",    .data = ROCKCHIP_SYSCON_GRF    },
>  	{ .compatible = "rockchip,rk3568-pmugrf", .data = ROCKCHIP_SYSCON_PMUGRF },
> +	{ .compatible = "rockchip,rk3568-msch",   .data = ROCKCHIP_SYSCON_MSCH   },
> +	{ .compatible = "rockchip,rk3568-sgrf",   .data = ROCKCHIP_SYSCON_SGRF   },
> +	{ .compatible = "rockchip,rk3568-ddrgrf", .data = ROCKCHIP_SYSCON_DDRGRF },

Please do not add more mappings, all ROCKCHIP_SYSCON usage should
instead be removed. See [1] and [2] for some uncompleted work.

Please define constants instead of trying to do dynamic lookup. Drivers
that typically need to know these reg addresses are already specific for
a single SoC or needs to be known at compile-time to save space.

No need to waste cpu cycles at runtime trying to resolve them :-)

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/optimize
[2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/d1601adc6b0bb092b66863e0c515dda5746c6f6f

Regards,
Jonas

>  	{ }
>  };
>  
> @@ -37,4 +40,25 @@ U_BOOT_DRIVER(rockchip_rk3568_pmugrf) = {
>  	.of_match = rk3568_syscon_ids + 1,
>  	.bind = rk3568_syscon_bind_of_plat,
>  };
> +
> +U_BOOT_DRIVER(rockchip_rk3568_msch) = {
> +	.name = "rockchip_rk3568_msch",
> +	.id = UCLASS_SYSCON,
> +	.of_match = rk3568_syscon_ids + 2,
> +	.bind = rk3568_syscon_bind_of_plat,
> +};
> +
> +U_BOOT_DRIVER(rockchip_rk3568_sgrf) = {
> +	.name = "rockchip_rk3568_sgrf",
> +	.id = UCLASS_SYSCON,
> +	.of_match = rk3568_syscon_ids + 3,
> +	.bind = rk3568_syscon_bind_of_plat,
> +};
> +
> +U_BOOT_DRIVER(rockchip_rk3568_ddrgrf) = {
> +	.name = "rockchip_rk3568_ddrgrf",
> +	.id = UCLASS_SYSCON,
> +	.of_match = rk3568_syscon_ids + 4,
> +	.bind = rk3568_syscon_bind_of_plat,
> +};
>  #endif
> 

