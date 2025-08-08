Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE29C87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 11:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D456B846DC;
	Fri,  8 Aug 2025 13:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xWRz3aRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D884846DE; Fri,  8 Aug 2025 13:57:13 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B806B846CC
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 13:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bz2ZW6Cn2z9spD;
 Fri,  8 Aug 2025 13:57:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754654227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WPemvSbZQL5ab9SJAac5m8xd/HaQZb94fHUqfhnN+Go=;
 b=xWRz3aRcrjq3LfwLcJXh+f33idyg+cBm22tluVkopMfrMXb75g0tm2Ae0VP8KY3ALJfoRG
 /yfKUKmHF4tSnGTd8apN2C3WtmT6OmawLRIsVuV3uWM0QYdxSO09UmpMgTgm879pQ7Sr4C
 fQGo21WPVnChVKop+0fuNhdhVsm+4g5uw+wzEZG3MXvDes7KuflN3TvZQ80B8s4JY1RE1o
 12DnbKHuaFzLDNWxqjHrfCjNzNpAI/4/94+4SPj26KZ9PIgxZg7wA+Agf5jsEyHcJuhJws
 N0h6bHZJaBhQ9PuLtTC0Zz5GzHwe5TndEier8g1wZ/UzvuyWRdY4kO+alOhvyw==
Message-ID: <f9d9fa2c-32f4-4e53-b50b-e0f03d9dc943@mailbox.org>
Date: Fri, 8 Aug 2025 13:57:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] phy: marvell: Cannot test unsigned field to be
 negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250806-phy_marvell_comphy-v1-0-ad9f4e789d5b@linaro.org>
 <20250806-phy_marvell_comphy-v1-2-ad9f4e789d5b@linaro.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250806-phy_marvell_comphy-v1-2-ad9f4e789d5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: f55gawzhnbbkceirnwgtp7o4xknuexk3
X-MBO-RS-ID: d097c75153703ee5325
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

On 06.08.25 18:43, Andrew Goodbody wrote:
> In comphy_cp110_init_serdes_map in comphy_cp110.c there are two fields
> in cfg, comphy_lanes_count and comphy_mux_bitcount, which are fetched
> from the FDT blob with fdtdec_get_int which returns an int. These two
> fields are then tested for being negative. However the fields are
> declared as unsigned so those tests must always fail. Change the
> declaration of those fields to be int instead of u32 and the code will
> work as expected.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/phy/marvell/comphy_core.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/marvell/comphy_core.h b/drivers/phy/marvell/comphy_core.h
> index f3d04939387..086a4d82f26 100644
> --- a/drivers/phy/marvell/comphy_core.h
> +++ b/drivers/phy/marvell/comphy_core.h
> @@ -47,8 +47,8 @@ struct chip_serdes_phy_config {
>   	int (*rx_training)(struct chip_serdes_phy_config *, u32);
>   	void __iomem *comphy_base_addr;
>   	void __iomem *hpipe3_base_addr;
> -	u32 comphy_lanes_count;
> -	u32 comphy_mux_bitcount;
> +	int comphy_lanes_count;
> +	int comphy_mux_bitcount;
>   	const fdt32_t *comphy_mux_lane_order;
>   	u32 cp_index;
>   	struct comphy_map comphy_map_data[MAX_LANE_OPTIONS];
> 

