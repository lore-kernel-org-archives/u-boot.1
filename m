Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B206CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 07:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC1AF866AA;
	Fri,  1 Sep 2023 09:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="a5s+VHLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D3386725; Fri,  1 Sep 2023 09:50:13 +0200 (CEST)
Received: from mail-m2839.qiye.163.com (mail-m2839.qiye.163.com [103.74.28.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB0B8669D
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 09:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=a5s+VHLAVp5o3NlYKYT65y8o3GbyKkpULKKtKpIOu80QN+x9uorEIDY4x/+4I3ZGVp48vAmTsA6iWFhiWd+6rHuA2Vwxi9vX+ktm9IGz6VoMgxnGZEZCkmLTodhJKYDigmdd2qs2jVNaVUH11WIV4botjkc1Z/rhLCz0uoz3Q/I=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=fP18NPWQaxRHAJMepYg3PFQhlJ26AliuxlI08dYL7tM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m127102.qiye.163.com (Hmail) with ESMTPA id 0FAA06C01FC;
 Fri,  1 Sep 2023 15:49:54 +0800 (CST)
Message-ID: <7532dcdb-ed81-b424-a8ad-5f98a8acf81d@rock-chips.com>
Date: Fri, 1 Sep 2023 15:49:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] video: rockchip: dw_mipi_dsi: Use generic_phy_valid()
 helper
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Anatolij Gustschin <agust@denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Ondrej Jirman <megi@xff.cz>
Cc: u-boot@lists.denx.de
References: <20230831221629.1027552-1-jonas@kwiboo.se>
 <20230831221629.1027552-7-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230831221629.1027552-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUkaSlZPHkxIQk5PSR5PQkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8a4fb851d0b280kuuu0faa06c01fc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mwg6MRw6SD0DESgNNAlCLhw2
 FRxPFElVSlVKTUJITk5PTkJPTElMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITkxMNwY+
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

Hi Jonas,

     Why is this patch 6/6 and didn't see other patches?

On 2023/9/1 06:16, Jonas Karlman wrote:
> The documentation for struct phy state that "The content of the
> structure is managed solely by the PHY API and PHY drivers".
>
> Change to use the generic_phy_valid() helper to check if phy is valid.
>
> Fixes: b7d8d40346f2 ("video: rockchip: dw_mipi_dsi: Fix external phy existence check")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
> index 0852b53ebed5..1a5ab781e3f1 100644
> --- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
> +++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
> @@ -377,7 +377,7 @@ static int dsi_phy_init(void *priv_data)
>   	struct dw_rockchip_dsi_priv *dsi = dev_get_priv(dev);
>   	int ret, i, vco;
>   
> -	if (dsi->phy.dev) {
> +	if (generic_phy_valid(&dsi->phy)) {
>   		ret = generic_phy_configure(&dsi->phy, &dsi->phy_opts);
>   		if (ret) {
>   			dev_err(dsi->dsi_host,
> @@ -559,7 +559,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct display_timing *timings,
>   	}
>   
>   	/* for external phy only the mipi_dphy_config is necessary */
> -	if (dsi->phy.dev) {
> +	if (generic_phy_valid(&dsi->phy)) {
>   		phy_mipi_dphy_get_default_config(timings->pixelclock.typ  * 10 / 8,
>   						 bpp, lanes,
>   						 &dsi->phy_opts);
> @@ -859,7 +859,7 @@ static int dw_mipi_dsi_rockchip_probe(struct udevice *dev)
>   	}
>   
>   	/* Get a ref clock only if not using an external phy. */
> -	if (priv->phy.dev) {
> +	if (generic_phy_valid(&priv->phy)) {
>   		dev_dbg(dev, "setting priv->ref to NULL\n");
>   		priv->ref = NULL;
>   
