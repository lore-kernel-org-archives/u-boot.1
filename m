Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B59C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D14383020;
	Mon, 14 Jul 2025 15:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eGM5gVpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E3F83045; Mon, 14 Jul 2025 15:14:17 +0200 (CEST)
Received: from mail-m32122.qiye.163.com (mail-m32122.qiye.163.com
 [220.197.32.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE2382F49
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.33.147] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1bf33294e;
 Mon, 14 Jul 2025 21:14:11 +0800 (GMT+08:00)
Message-ID: <dce6837b-abfb-4bfa-8da1-cccde3707a9f@rock-chips.com>
Date: Mon, 14 Jul 2025 21:14:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] phy: rockchip: inno-usb2: Add rk3576 config
To: Andri Yngvason <andri@yngvason.is>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
References: <20250710173154.1244430-1-andri@yngvason.is>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250710173154.1244430-1-andri@yngvason.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkhCSVYaHksfHR8aTkhJSx5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9809124fd003afkunm3fce05021cc66e5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MC46NCo5EzE4FRdKHRcTNw48
 SSMaCQhVSlVKTE5JT0JDQ05JTUJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0pNNwY+
DKIM-Signature: a=rsa-sha256;
 b=eGM5gVpek0VZKnVXlfSWRQUcmZ0huqxaQNMiEBK1289v1XxdGPzi64lQ7XfXVu+HpebJB5Xrw38HtlTY4+ni8td1U1pwOYUlhrGDxu6Nfkxpyh7TuvUcdFWxQ/kKoiI8d9JIHXm1cGI+RBYUjPkleLu7YV4ZtNhlrPnHGMUPlIg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=t5r/rrGOpIgmdE/0pmxYm7JSATJYUxa9erQvEuldNAQ=;
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

Hi Andri,

     Thanks for your patch, pls add commit msg for your commit, it 
should not empty.


Thanks,
- Kever
On 2025/7/11 01:31, Andri Yngvason wrote:
> Signed-off-by: Andri Yngvason <andri@yngvason.is>
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 26 +++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 88b33de1b2a..c38b48d0c71 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -456,6 +456,28 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
>   	{ /* sentinel */ }
>   };
>   
> +static const struct rockchip_usb2phy_cfg rk3576_phy_cfgs[] = {
> +	{
> +		.reg		= 0x0000,
> +		.clkout_ctl	= { 0x0008, 0, 0, 1, 0 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x0000, 8, 0, 0, 0x1d1 },
> +			}
> +		},
> +	},
> +	{
> +		.reg		= 0x2000,
> +		.clkout_ctl	= { 0x2008, 0, 0, 1, 0 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x2000, 8, 0, 0, 0x1d1 },
> +			}
> +		},
> +	},
> +	{ /* sentinel */ }
> +};
> +
>   static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
>   	{
>   		.reg		= 0x0000,
> @@ -517,6 +539,10 @@ static const struct udevice_id rockchip_usb2phy_ids[] = {
>   		.compatible = "rockchip,rk3568-usb2phy",
>   		.data = (ulong)&rk3568_phy_cfgs,
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-usb2phy",
> +		.data = (ulong)&rk3576_phy_cfgs,
> +	},
>   	{
>   		.compatible = "rockchip,rk3588-usb2phy",
>   		.data = (ulong)&rk3588_phy_cfgs,

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

