Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4034CCA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C446B836AB;
	Sat, 30 Aug 2025 16:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Vpr5p4DL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1668380E; Sat, 30 Aug 2025 16:58:53 +0200 (CEST)
Received: from mail-m49236.qiye.163.com (mail-m49236.qiye.163.com
 [45.254.49.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F8A83542
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4ca6;
 Sat, 30 Aug 2025 22:58:47 +0800 (GMT+08:00)
Message-ID: <899d94c0-943c-4589-9a2e-537b64ed716b@rock-chips.com>
Date: Sat, 30 Aug 2025 22:58:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rockchip_sdhci: Do not test unsigned for being less
 than 0
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250731-mmc_rockchip-v1-1-74baef656cca@linaro.org>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250731-mmc_rockchip-v1-1-74baef656cca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb7cf74103afkunm2f517abf40de3c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSksaVhhLTRhDTE1DHkMYH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Vpr5p4DL+mk1IQZesitxuvVZnfgGEEfKbm4doTkVyRaL07bJJwyi5vIjJkuRV9+gGc2JxMIN/MUor7v1iCeUYqEeBnIMnkjlIO30UACpavxEzAXV2lFqEytdt9TXjDjIMWP2zW3AStkKOcXGcJZi646jiz/mPx0xgAEt3yEunR0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=IrvFvkhjbyqGSF6w5ouHKys1eAJh56m1Gz4UQJlIlBI=;
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


On 2025/7/31 19:46, Andrew Goodbody wrote:
> In rockchip_sdhci_execute_tuning the variable tuning_loop_counter is
> tested for being less than 0. Ensure that it is a signed type by
> declaring it as s8 instead of char.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/mmc/rockchip_sdhci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index 761e3619329..5e025d76a82 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -500,7 +500,7 @@ static int rockchip_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>   {
>   	struct rockchip_sdhc *priv = dev_get_priv(mmc->dev);
>   	struct sdhci_host *host = &priv->host;
> -	char tuning_loop_counter = SDHCI_TUNING_LOOP_COUNT;
> +	s8 tuning_loop_counter = SDHCI_TUNING_LOOP_COUNT;
>   	struct mmc_cmd cmd;
>   	u32 ctrl, blk_size;
>   	int ret;
>
> ---
> base-commit: 79f3e77133bd7248e4579827effc13f97a32a8a8
> change-id: 20250731-mmc_rockchip-78721a751131
>
> Best regards,
