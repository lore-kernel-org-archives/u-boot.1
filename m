Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBD3EA8521
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 15:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C38680517;
	Sun,  8 Mar 2026 16:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GOLsCqP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98748839D5; Sun,  8 Mar 2026 16:08:31 +0100 (CET)
Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com
 [45.254.49.248])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45C6A80212
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 16:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3] (unknown
 [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36250d5aa;
 Sun, 8 Mar 2026 23:08:26 +0800 (GMT+08:00)
Message-ID: <9f536f5a-6cc2-4152-a1bd-953703f72573@rock-chips.com>
Date: Sun, 8 Mar 2026 23:08:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: rockchip: naneng-combphy: Enable U3 port for
 USB3OTG on RK3568
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260106233646.3184154-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260106233646.3184154-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ccdfe141303afkunm7d2ad93d15ba193
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSEpMVklNTkgaH0tCSxpMTVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSE9BHh5BSUJNHUFCGEIeQUJPQ0tBGU5NT0FIQh1IWVdZFh
 oPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=GOLsCqP0l+85VfaiektM6/i+xWC6vNOErfj+kVFTaGPSJLSo2knQcEFRDB0XGtU3OJwX5LBsIFs6g5mriJVRhlVD3wFWnKI48gUFd5hymLyVJqXeo1YDqYNlLwgh+EobxgeRf/b6OsVyjZVXLyPX38Yy5wFkvii6jPD2d3IzcU4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=jCECnjRGJCRjUgf4gHI+3fMs3QCxltoPFqi4tNy2tOk=;
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


On 2026/1/7 07:36, Jonas Karlman wrote:
> The USB OTG U3 port may have been disabled early, add support to the
> COMBPHY driver to re-enable the U3 port.
>
> This matches changes made in the Linux commit 7bb14b61b7d0 ("phy:
> rockchip: naneng-combphy: Enable U3 OTG port for RK3568").
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change, drop second patch
> ---
>   drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index d602f965d6aa..82353ae7678c 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -399,6 +399,14 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
>   		param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
>   		param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
>   		param_write(priv->phy_grf, &cfg->usb_mode_set, true);
> +		switch (priv->id) {
> +		case 0:
> +			param_write(priv->pipe_grf, &cfg->u3otg0_port_en, true);
> +			break;
> +		case 1:
> +			param_write(priv->pipe_grf, &cfg->u3otg1_port_en, true);
> +			break;
> +		}
>   		break;
>   	case PHY_TYPE_SATA:
>   		writel(0x41, priv->mmio + 0x38);
