Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8EFE95A86
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 01:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB45586DC7;
	Sun,  8 Oct 2023 03:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ELPHzJnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46EEF86DC4; Sun,  8 Oct 2023 03:21:02 +0200 (CEST)
Received: from mail-m12748.qiye.163.com (mail-m12748.qiye.163.com
 [115.236.127.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 099D586DEE
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 03:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ELPHzJnInTf3fp5Axm10Ppq5gLlob4KhpoUbP68xR21qR2xKy1UmF3+yvOZA8lcU/dwv5ZSKWH8YVN0rO14mhTu0iDKiKy9E6R/B15PaLmR/C7Tvl9kuEFkwgayB4t2F5XvbNOrkWw7tH7lJsPax6TgBvHjPnuOQ1RyEh1Vnnj4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=fqY+RMwsuDuoQ9HvKjDOR4tjO00IblHbY7Fu0VX7t90=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 332B64001BC;
 Sun,  8 Oct 2023 09:19:16 +0800 (CST)
Message-ID: <04067d34-097e-f946-a67e-584790d99cdb@rock-chips.com>
Date: Sun, 8 Oct 2023 09:19:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 RESEND] mmc: dw_mmc: reset controller after data error
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, u-boot@lists.denx.de
Cc: Ziyuan Xu <xzy.xu@rock-chips.com>, Jason Zhu <jason.zhu@rock-chips.com>
References: <20230619103347.278004-1-eugen.hristev@collabora.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230619103347.278004-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlPSVYYS0MfQ0MdSR4eSkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b0cddfb812eb3kusn332b64001bc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pj46Cxw5VjwwUR9LLA5IVi8d
 TE8wCyhVSlVKTUJNTElMQk5NQktLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITktLNwY+
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


On 2023/6/19 18:33, Eugen Hristev wrote:
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


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
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
