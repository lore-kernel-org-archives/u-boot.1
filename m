Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC446CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 10:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA5C849CE;
	Tue, 23 Jun 2026 12:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bIMe01bf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E820C849E5; Tue, 23 Jun 2026 12:53:41 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF4F849C5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 12:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=803a=ET=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1782212018;
 bh=uaqxpEzqi3ZmnAFzCbMzcVVc8FPPGlvt72OhLDQ0L38=;
 b=bIMe01bfamBm8nPoXSWN0aJB7zAqIikldBtYdeNSR2/tgy0ExXxWd5C1+KEtqjsA3cqPJuj1L
 +crPbfc3JbNEx9aC10VTk3K6VQ0q4TEUlbZSBNE/JBp8YX/iRRbSMhOXX6VENVPJ++Pryq/wcia
 YjkV0Cc2rQhz3lSP+Nc9AjmgMyDX/jDc0fX25nJ+xzvMWs498s5DVCROUakv1r5Ba2/osmjaDwq
 Xb5GPkBfXkIfVzNpbBiZeEWsWw7lVWmbhaGYhQA5sr/KrEjrQXsr07ytownlynk2QJBE5/Sh7np
 gLBhb9JyBxbrXVqzz7FaDBLe01P50vJgcMGsd30GdR4g==
X-Forward-Email-ID: 6a3a65b0f88c55edcdd73219
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.32
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5e0b06e0-5003-4242-a1b0-ea76fa5808d4@kwiboo.se>
Date: Tue, 23 Jun 2026 12:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3568: make the WDT trigger a first global
 reset
To: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
 <20260619220820.301787-2-andreas.zdziarstek@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260619220820.301787-2-andreas.zdziarstek@gmail.com>
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

Hi Andreas,

On 6/20/2026 12:08 AM, Andreas Zdziarstek wrote:
> Default is a second global reset which causes a system hang on a timeout
> in U-Boot.
> 
> Verified on the Hardkernel ODROID-M1S (RK3566): a watchdog timeout now
> cleanly reboots the board.
> 
> Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
> ---
>  arch/arm/mach-rockchip/rk3568/rk3568.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index 2b1eafee37c..77610a6a6ec 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -37,6 +37,10 @@
>  #define CPU_GRF_BASE		0xfdc30000
>  #define GRF_CORE_PVTPLL_CON0	(0x10)
>  
> +#define CRU_BASE		0xfdd20000
> +#define CRU_GLB_RST_CON		(CRU_BASE + 0x0dc)
> +#define WDT_GLB_SRST_CTRL	BIT(1)
> +
>  /* PMU_GRF_GPIO0D_IOMUX_L */
>  enum {
>  	GPIO0D1_SHIFT		= 4,
> @@ -146,6 +150,10 @@ int arch_cpu_init(void)
>  	writel((PMU_PD_VO_DWN_ENA << 16),
>  	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
>  #endif
> +
> +	/* Make WDT trigger a first global reset */
> +	setbits_le32((void __iomem *)CRU_GLB_RST_CON, WDT_GLB_SRST_CTRL);

It should likely be enough to configure this in XPL_BUILD?

We should possibly also clear SOC_CON1 to handle reset in similar way as
TF-A / PSCI reset. RK356x boards use PSCI reset in U-Boot proper
primarily to work around issues found when working on [1], using first
global reset seemed to wipe too much information we may want to retain.

[1] https://lore.kernel.org/u-boot/20240202001221.531207-1-jonas@kwiboo.se/

Regards,
Jonas

> +
>  	return 0;
>  }
>  

