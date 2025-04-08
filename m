Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB221C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C453C82CEA;
	Tue,  8 Apr 2025 05:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CZSQGo4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4572982CE7; Tue,  8 Apr 2025 05:24:00 +0200 (CEST)
Received: from mail-m1973190.qiye.163.com (mail-m1973190.qiye.163.com
 [220.197.31.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A8C833BF
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208baf;
 Tue, 8 Apr 2025 11:23:52 +0800 (GMT+08:00)
Message-ID: <b66be7d0-2d7d-496d-9897-93e422577c38@rock-chips.com>
Date: Tue, 8 Apr 2025 11:23:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/30] mmc: rockchip_sdhci: Gate clock for glitch free
 phase switching
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-23-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-23-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tPHlZOH01DQh9OS09IHk1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136cfe5503afkunm110208baf
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDo6Tjo6IzIMLUJMEQ8KThIe
 LjIaFB5VSlVKTE9PS0NJTUhITU9KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISktONwY+
DKIM-Signature: a=rsa-sha256;
 b=CZSQGo4aSLiozRVSa6JdjdRItJVqRfHH9t7r4TV++WyKA+0AMPaplE4bcNQD5gqW1TVAuLRpQOrPLA7vbg4NdLRG3Nz3TBHlo0SJIuJhP3+neOH3CVIN51SUqmpKRSqNhVQA4hazUmJNZHJq+jrNMScAP8ib3yJ3dQC62XDeDAE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=kq1V1VOudNNLzdGTI/k19jJmTA9YsghgDe9spX3zds4=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/4/8 06:46, Jonas Karlman wrote:
> Enable clock stopping to gate clock during phase code change to ensure
> glitch free phase switching in auto-tuning circuit. Fixes HS200 mode
> on RK3528.
>
> POST_CHANGE_DLY
> Time taken for phase switching and stable clock output.
> - Less than 4-cycle latency
>
> PRE_CHANGE_DLY
> Maximum Latency specification between transmit clock and receive clock.
> - Less than 4-cycle latency
>
> TUNE_CLK_STOP_EN
> Clock stopping control for Tuning and auto-tuning circuit. When enabled,
> clock gate control output is pulled low before changing phase select
> codes. This effectively stops the receive clock. Changing phase code
> when clocks are stopped ensures glitch free phase switching.
> - Clocks stopped during phase code change
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   drivers/mmc/rockchip_sdhci.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index 2c54b8a942da..c0f986784366 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -50,6 +50,10 @@
>   #define DWCMSHC_EMMC_EMMC_CTRL		0x52c
>   #define DWCMSHC_CARD_IS_EMMC		BIT(0)
>   #define DWCMSHC_ENHANCED_STROBE		BIT(8)
> +#define DWCMSHC_EMMC_AT_CTRL		0x540
> +#define EMMC_AT_CTRL_TUNE_CLK_STOP_EN	BIT(16)
> +#define EMMC_AT_CTRL_PRE_CHANGE_DLY	17
> +#define EMMC_AT_CTRL_POST_CHANGE_DLY	19
>   #define DWCMSHC_EMMC_DLL_CTRL		0x800
>   #define DWCMSHC_EMMC_DLL_CTRL_RESET	BIT(1)
>   #define DWCMSHC_EMMC_DLL_RXCLK		0x804
> @@ -326,6 +330,11 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>   		udelay(1);
>   		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
>   
> +		extra = 0x3 << EMMC_AT_CTRL_POST_CHANGE_DLY |
> +			0x3 << EMMC_AT_CTRL_PRE_CHANGE_DLY |
> +			EMMC_AT_CTRL_TUNE_CLK_STOP_EN;
> +		sdhci_writel(host, extra, DWCMSHC_EMMC_AT_CTRL);
> +
>   		/* Init DLL settings */
>   		extra = DWCMSHC_EMMC_DLL_START_DEFAULT << DWCMSHC_EMMC_DLL_START_POINT |
>   			DWCMSHC_EMMC_DLL_INC_VALUE << DWCMSHC_EMMC_DLL_INC |
