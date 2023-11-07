Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4405C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 04:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF9686DD2;
	Tue,  7 Nov 2023 05:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="W9eCvvrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7DCA86CB1; Tue,  7 Nov 2023 05:03:45 +0100 (CET)
Received: from mail-m17235.xmail.ntesmail.com (mail-m17235.xmail.ntesmail.com
 [45.195.17.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CD2586DD2
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 05:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=W9eCvvrnIh+LUg2MyGXXsq00sJ75jFM1JAl2zvFnEtYKMGdf9f26n+Jr5DE9hkR4kb0SiG2+mA3LK1c9jlEtBW3YJfdugni6r7s+5a6kz7PUmN6Pm/hY8HUncmBCBNseNAa2DAyXN+3OROYyiQQrP6Ze/jJ7P9TStJRNjHPVgVA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=MaF9EenHNfNNcywsurgRvxGQaxMawg2yuXLZeZpGaEA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 1695A400291;
 Tue,  7 Nov 2023 12:03:30 +0800 (CST)
Message-ID: <b5baa462-efa5-4710-9504-2e785113e043@rock-chips.com>
Date: Tue, 7 Nov 2023 12:03:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: otp: Add support for RV1126
Content-Language: en-US
To: Tim Lunn <tim@feathertop.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
References: <20231031020715.684460-1-tim@feathertop.org>
 <20231031020715.684460-2-tim@feathertop.org>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231031020715.684460-2-tim@feathertop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5OGlZLTkhIT0saHUhKGE5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8ba7f31f992eb3kusn1695a400291
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pzo6FRw4PDwzIRUIPy0sMQ4i
 Fy1PCTVVSlVKTUJCSElCQ0pLQkpCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSk5PNwY+
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


On 2023/10/31 10:07, Tim Lunn wrote:
> Extend the otp driver to read rv1126 otp. This driver code was
> adapted from the Rockchip BSP stack.
>
> Signed-off-by: Tim Lunn <tim@feathertop.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/misc/rockchip-otp.c | 76 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
>
> diff --git a/drivers/misc/rockchip-otp.c b/drivers/misc/rockchip-otp.c
> index 4814e0e501..4f757083a1 100644
> --- a/drivers/misc/rockchip-otp.c
> +++ b/drivers/misc/rockchip-otp.c
> @@ -61,11 +61,20 @@
>   #define RK3588_OTPC_INT_ST		0x0084
>   #define RK3588_RD_DONE			BIT(1)
>   
> +#define RV1126_OTP_NVM_CEB		0x00
> +#define RV1126_OTP_NVM_RSTB		0x04
> +#define RV1126_OTP_NVM_ST		0x18
> +#define RV1126_OTP_NVM_RADDR		0x1C
> +#define RV1126_OTP_NVM_RSTART		0x20
> +#define RV1126_OTP_NVM_RDATA		0x24
> +#define RV1126_OTP_READ_ST		0x30
> +
>   struct rockchip_otp_plat {
>   	void __iomem *base;
>   };
>   
>   struct rockchip_otp_data {
> +	int (*init)(struct udevice *dev);
>   	int (*read)(struct udevice *dev, int offset, void *buf, int size);
>   	int offset;
>   	int size;
> @@ -232,6 +241,48 @@ static int rockchip_rk3588_otp_read(struct udevice *dev, int offset,
>   	return 0;
>   }
>   
> +static int rockchip_rv1126_otp_init(struct udevice *dev)
> +{
> +	struct rockchip_otp_plat *otp = dev_get_plat(dev);
> +	int ret;
> +
> +	writel(0x0, otp->base + RV1126_OTP_NVM_CEB);
> +	ret = rockchip_otp_poll_timeout(otp, 0x1, RV1126_OTP_NVM_ST);
> +
> +	if (ret)
> +		return ret;
> +
> +	writel(0x1, otp->base + RV1126_OTP_NVM_RSTB);
> +	ret = rockchip_otp_poll_timeout(otp, 0x4, RV1126_OTP_NVM_ST);
> +
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int rockchip_rv1126_otp_read(struct udevice *dev, int offset, void *buf,
> +				    int size)
> +{
> +	struct rockchip_otp_plat *otp = dev_get_plat(dev);
> +	u32 status = 0;
> +	u8 *buffer = buf;
> +	int ret = 0;
> +
> +	while (size--) {
> +		writel(offset++, otp->base + RV1126_OTP_NVM_RADDR);
> +		writel(0x1, otp->base + RV1126_OTP_NVM_RSTART);
> +		ret = readl_poll_timeout(otp->base + RV1126_OTP_READ_ST,
> +					 status, !status, OTPC_TIMEOUT);
> +		if (ret)
> +			return ret;
> +
> +		*buffer++ = (u8)(readl(otp->base + RV1126_OTP_NVM_RDATA) & 0xFF);
> +	}
> +
> +	return 0;
> +}
> +
>   static int rockchip_otp_read(struct udevice *dev, int offset,
>   			     void *buf, int size)
>   {
> @@ -286,6 +337,20 @@ static int rockchip_otp_of_to_plat(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int rockchip_otp_probe(struct udevice *dev)
> +{
> +	struct rockchip_otp_data *data;
> +
> +	data = (struct rockchip_otp_data *)dev_get_driver_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +
> +	if (data->init)
> +		return data->init(dev);
> +
> +	return 0;
> +}
> +
>   static const struct rockchip_otp_data px30_data = {
>   	.read = rockchip_px30_otp_read,
>   	.size = 0x40,
> @@ -304,6 +369,12 @@ static const struct rockchip_otp_data rk3588_data = {
>   	.block_size = 4,
>   };
>   
> +static const struct rockchip_otp_data rv1126_data = {
> +	.init = rockchip_rv1126_otp_init,
> +	.read = rockchip_rv1126_otp_read,
> +	.size = 0x40,
> +};
> +
>   static const struct udevice_id rockchip_otp_ids[] = {
>   	{
>   		.compatible = "rockchip,px30-otp",
> @@ -321,6 +392,10 @@ static const struct udevice_id rockchip_otp_ids[] = {
>   		.compatible = "rockchip,rk3588-otp",
>   		.data = (ulong)&rk3588_data,
>   	},
> +	{
> +		.compatible = "rockchip,rv1126-otp",
> +		.data = (ulong)&rv1126_data,
> +	},
>   	{}
>   };
>   
> @@ -331,4 +406,5 @@ U_BOOT_DRIVER(rockchip_otp) = {
>   	.of_to_plat = rockchip_otp_of_to_plat,
>   	.plat_auto = sizeof(struct rockchip_otp_plat),
>   	.ops = &rockchip_otp_ops,
> +	.probe = rockchip_otp_probe,
>   };
