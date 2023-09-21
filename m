Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CD1E71084
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 14:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E8286ACF;
	Thu, 21 Sep 2023 16:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XW+L8FYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4019786AA8; Thu, 21 Sep 2023 16:52:02 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B80F86098
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 811526607318;
 Thu, 21 Sep 2023 15:51:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1695307920;
 bh=cOeizgoDmgWqZ1SidV7oa8x3FT2KOGyVdJLHkvUHdiI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XW+L8FYweHdBnWhlNDn2ToQoJUGPE9GUrCgv22BUs1bHG/iTdm4KSun6p2URELMOv
 GFnqw5oAqqa3XsPDTdW/4KtqrzpURaHv2ln7EAI3QNxveh6hfKPAyHWnTwOSWQae+I
 Mg0MBOn3OW0N7u/Yc6exmNG203pBwueVO2cwx5SID2oiY/FFmK1k6hfFTrQ+Ubp44R
 0IaGWBP5E6V0S6/LbVQobxMlS2mEptr6dU+avWeD47S3YwmdFdlarQNGjMFuf5xCBX
 C9+xrTCAk8E00BnYdAP0fdf08QotcE7phQpoRcoCLkx/fzMKkror62IbmYjk8rPFQV
 QDI612/noH4fA==
Message-ID: <fc944f13-8446-c428-2d11-9ec2e176b771@collabora.com>
Date: Thu, 21 Sep 2023 17:51:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 RESEND] mmc: dw_mmc: reset controller after data error
Content-Language: en-US
To: peng.fan@nxp.com, jh80.chung@samsung.com, u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, Ziyuan Xu <xzy.xu@rock-chips.com>,
 Jason Zhu <jason.zhu@rock-chips.com>
References: <20230619103347.278004-1-eugen.hristev@collabora.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230619103347.278004-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/19/23 13:33, Eugen Hristev wrote:
> From: Ziyuan Xu <xzy.xu@rock-chips.com>
> 
> Per dw_mmc databook, it's recommended to reset the host controller if
> some data-related error occurred.
> Implement a reset mechanism.
> 
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> Co-developed-by: Jason Zhu <jason.zhu@rock-chips.com>
> Signed-off-by: Jason Zhu <jason.zhu@rock-chips.com>
> [eugen.hristev@collabora.com: modified a bit the variables initialization]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---

Hi,

Gentle ping.
This patch require any more changes?

Thanks,
Eugen

>   drivers/mmc/dw_mmc.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
> index 5085a3b491da..d6cad998b0cd 100644
> --- a/drivers/mmc/dw_mmc.c
> +++ b/drivers/mmc/dw_mmc.c
> @@ -138,7 +138,7 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
>   {
>   	struct mmc *mmc = host->mmc;
>   	int ret = 0;
> -	u32 timeout, mask, size, i, len = 0;
> +	u32 timeout, reset_timeout = 100, status, ctrl, mask, size, i, len = 0;
>   	u32 *buf = NULL;
>   	ulong start = get_timer(0);
>   	u32 fifo_depth = (((host->fifoth_val & RX_WMARK_MASK) >>
> @@ -159,6 +159,24 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
>   		/* Error during data transfer. */
>   		if (mask & (DWMCI_DATA_ERR | DWMCI_DATA_TOUT)) {
>   			debug("%s: DATA ERROR!\n", __func__);
> +
> +			dwmci_wait_reset(host, DWMCI_RESET_ALL);
> +			dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_PRV_DAT_WAIT |
> +				     DWMCI_CMD_UPD_CLK | DWMCI_CMD_START);
> +
> +			do {
> +				status = dwmci_readl(host, DWMCI_CMD);
> +				if (!reset_timeout--)
> +					break;
> +				udelay(100);
> +			} while (status & DWMCI_CMD_START);
> +
> +			if (!host->fifo_mode) {
> +				ctrl = dwmci_readl(host, DWMCI_BMOD);
> +				ctrl |= DWMCI_BMOD_IDMAC_RESET;
> +				dwmci_writel(host, DWMCI_BMOD, ctrl);
> +			}
> +
>   			ret = -EINVAL;
>   			break;
>   		}

