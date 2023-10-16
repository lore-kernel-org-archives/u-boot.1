Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D22CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DFF86823;
	Mon, 16 Oct 2023 16:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697466126;
	bh=KAtptBOUZKv90CViAOJy1O2xwJUOj7UAbq6JGykb1Yo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SGdjQw7RZih4Mv+l50yDcM5sBCtMb0VMbhrl460d+tmPuiBDcuosgCVi9JKtjk5Q0
	 AcfYtfzQ46lsnWgJ401aRVWo5V5YcNmQFhvbXCjnqcltgElMyudy8Jeeumk8j2MwCF
	 2VIoa5+YWwZYFSuPgN6jVz0DUMkYoj6ZyQcgQcEIhnHthJzE1WHAp+JFiXnSogWTKP
	 Kbqi54FI+3vzg6WYU+FuqibgyTzWyV0uURuWY3niEXbl559BNcujLK+/Mj+Uf9ZV0J
	 HWYuIqrkzHjwLKLB5yC7GLEV1HPn+qlSF/RoQoiE6dCUk5eYh3NRwuf+n0hxKB84S3
	 L/fbPMrM44k7A==
Received: from [IPV6:2001:a61:606e:f301:54d3:fa40:6980:4d01] (unknown
 [IPv6:2001:a61:606e:f301:54d3:fa40:6980:4d01])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EFCEB86823;
 Mon, 16 Oct 2023 16:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697466123;
 bh=KAtptBOUZKv90CViAOJy1O2xwJUOj7UAbq6JGykb1Yo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YqTBFA6cq2PnQvIw2FdeCaGiTMW3jiqBiajAi9DhZ7cuDeUu6zY95v1w+Obn6vaAs
 Un5v4nzQU7U3x7ztKWzO5MKrb6J9hIfOrJwgKJq4GreJimf+NOUF8qXl17RI/AyNFp
 gJVetTpMFT8poLfilprlpl3mxclmkBmhNas/41lXzv4Wp8OXi07NzwU4TfjwC8Dw4b
 VePOgV5UsIAxHqE58AgxoESiKaiZnJD61MlDnuoEUmqt4DMCDuEk2e1wI8/nZjqvjh
 BnAOcJXY2KIRGgPOXxQcnX/i2ESh5uEgDLe9u7ZeuL7awPPJ+KWRPqkUqUknvFHng7
 +dzLHeThFLFGg==
Message-ID: <d52e94bb-1da4-41af-a329-4b49799f17c2@denx.de>
Date: Mon, 16 Oct 2023 16:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] net: dwc_eth_qos: add i.MX93 support
Content-Language: de-DE
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <20230727083336.15301-1-sebastien.szymanski@armadeus.com>
 <20230727083336.15301-2-sebastien.szymanski@armadeus.com>
From: Stefano Babic <sbabic@denx.de>
In-Reply-To: <20230727083336.15301-2-sebastien.szymanski@armadeus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Sebastian,

On 27.07.23 10:33, Sébastien Szymanski wrote:
> Add support for DWC EQoS MAC on i.MX93.
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>   drivers/net/dwc_eth_qos.c     | 4 ++++
>   drivers/net/dwc_eth_qos_imx.c | 3 +++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 1e92bd9ca9c0..f70f8afe5831 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1717,6 +1717,10 @@ static const struct udevice_id eqos_ids[] = {
>   		.compatible = "nxp,imx8mp-dwmac-eqos",
>   		.data = (ulong)&eqos_imx_config
>   	},
> +	{
> +		.compatible = "nxp,imx93-dwmac-eqos",
> +		.data = (ulong)&eqos_imx_config
> +	},
>   #endif
>   
>   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_QCOM)
> diff --git a/drivers/net/dwc_eth_qos_imx.c b/drivers/net/dwc_eth_qos_imx.c
> index 60f3f3f5a10f..e3f55dd98173 100644
> --- a/drivers/net/dwc_eth_qos_imx.c
> +++ b/drivers/net/dwc_eth_qos_imx.c
> @@ -181,6 +181,9 @@ static int eqos_set_tx_clk_speed_imx(struct udevice *dev)
>   	ulong rate;
>   	int ret;
>   
> +	if (device_is_compatible(dev, "nxp,imx93-dwmac-eqos"))
> +		return 0;
> +
>   	debug("%s(dev=%p):\n", __func__, dev);
>   
>   	if (eqos->phy->interface == PHY_INTERFACE_MODE_RMII)

Your series breaks Rockchip's boards. For example:

+aarch64-linux-ld.bfd: 
drivers/net/dwc_eth_qos.o:(.rodata.eqos_ids+0x28): undefined reference 
to `eqos_imx_config'
+make[1]: *** [Makefile:1765: u-boot] Error 1
+make: *** [Makefile:177: sub-make] Error 2
    aarch64:  w+   rock-4c-plus-rk3399

But it is just an example, quite all boards are broken. Please check 
this and repost, thanks !

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

