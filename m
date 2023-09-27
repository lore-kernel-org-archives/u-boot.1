Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9313E7F150
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F6D886D73;
	Wed, 27 Sep 2023 04:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QagwcxJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D482286D93; Wed, 27 Sep 2023 04:47:36 +0200 (CEST)
Received: from mail-m15592.qiye.163.com (mail-m15592.qiye.163.com
 [101.71.155.92])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D25386D73
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QagwcxJzG6KIeVi3PMhVDjl/KjBRd1f0rQJymWASkMXdaHpp8crIDLdIjIbCTbwxgBZmgOQpG7Oyto/Mcxc0suv7ivkMOSjUwBN6nX85EcV8RIO7rJIY3akqE9Ag1lwwyCAgNgnPTnnNW4SkPJ5drzEQZcT4Pu+Ppq3ynztkbsk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=y2yYa0Amc9R7HjSylCpmXwmsCtBEbq2D8cZ1FsrL9kA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id AF4CD4001FA;
 Wed, 27 Sep 2023 10:47:26 +0800 (CST)
Message-ID: <5ec85abb-e801-b685-5eda-8af88e7708da@rock-chips.com>
Date: Wed, 27 Sep 2023 10:47:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/7] phy: rockchip: naneng-combphy: Use signal from
 comb PHY on RK3588
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jon Lin
 <jon.lin@rock-chips.com>, Eugen Hristev <eugen.hristev@collabora.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, John Clark <inindev@gmail.com>,
 u-boot@lists.denx.de
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <20230802190424.2963185-7-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230802190424.2963185-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxkaSFZCSkoeHUpMQ0pKS0hVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad488c23e2eb3kusnaf4cd4001fa
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6HAw5ODw*IjYtPE85Tio2
 QyEKCS9VSlVKTUJOTENJQ09MTEtOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITENJNwY+
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


On 2023/8/3 03:04, Jonas Karlman wrote:
> Route signal from comb PHY instead of PCIe3 PHY to PCIe1l0 and PCIe1l1.
>
> Fixes use of pcie2x1l0 on ROCK 5B.
>
> Code imported from mainline linux driver.
>
> Fixes: c5b4a012bca8 ("phy: rockchip: naneng-combphy: Support rk3588")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - New patch
>
>   drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index d5408ccac976..9ca66bf8db92 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -61,6 +61,8 @@ struct rockchip_combphy_grfcfg {
>   	struct combphy_reg pipe_con1_for_sata;
>   	struct combphy_reg pipe_sgmii_mac_sel;
>   	struct combphy_reg pipe_xpcs_phy_ready;
> +	struct combphy_reg pipe_pcie1l0_sel;
> +	struct combphy_reg pipe_pcie1l1_sel;
>   	struct combphy_reg u3otg0_port_en;
>   	struct combphy_reg u3otg1_port_en;
>   };
> @@ -435,6 +437,8 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
>   		param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
>   		param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
>   		param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> +		param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
> +		param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
>   		break;
>   	case PHY_TYPE_USB3:
>   		param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> @@ -507,6 +511,8 @@ static const struct rockchip_combphy_grfcfg rk3588_combphy_grfcfgs = {
>   	/* pipe-grf */
>   	.pipe_con0_for_sata	= { 0x0000, 11, 5, 0x00, 0x22 },
>   	.pipe_con1_for_sata	= { 0x0000, 2, 0, 0x00, 0x2 },
> +	.pipe_pcie1l0_sel	= { 0x0100, 0, 0, 0x01, 0x0 },
> +	.pipe_pcie1l1_sel	= { 0x0100, 1, 1, 0x01, 0x0 },
>   };
>   
>   static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
