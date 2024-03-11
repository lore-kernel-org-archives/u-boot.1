Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F177C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 10:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A46387F47;
	Mon, 11 Mar 2024 11:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aVfMfgSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B1E87F46; Mon, 11 Mar 2024 11:08:17 +0100 (CET)
Received: from mail-m92102.xmail.ntesmail.com (mail-m92102.xmail.ntesmail.com
 [103.126.92.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2DEC87EF5
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=aVfMfgSQk0mV+ya2sKilwM1woBwDV1MsG04+0xbkMsn7Dya7EQkf9NWR0ugWvNNzDS62zDkyNYzl2R52JvlOm6TKvSivDJ9k/lEVnUkc2hNfF8SUYZUQyz4t5ak/fB7XgI7xl36Iixa5aWwATalrVPo6kj8xsQnxGD7/HvDPA4k=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=I2lMUFTU93lxyt4SSYpEjYUBv6jmvyqZen1fO1WvBMQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 5F771900380;
 Mon, 11 Mar 2024 18:08:00 +0800 (CST)
Message-ID: <8d6624ad-8cdb-4f43-95a5-33e73a7c2e3e@rock-chips.com>
Date: Mon, 11 Mar 2024 18:08:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/16] regulator: rk8xx: fix SWITCH enable on RK809
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 William Wu <william.wu@rock-chips.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-3-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-3-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MeHVZLTEoeH09NTkoYTklVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e2cfbc51a03a9kunm5f771900380
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAw6Syo6LzMUCjBPMgosSg0j
 MxQKCRRVSlVKTEpLSk5KTUNKTElDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISUpCNwY+
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


On 2024/3/4 19:29, Quentin Schulz wrote:
> From: William Wu <william.wu@rock-chips.com>
>
> On RK809 in PMIC_POWER_ENX registers, in order to set or clear a bit N,
> the bit at offset N + 4 needs to be set otherwise nothing is done.
>
> This fixes the inability to modify the SWITCH state on RK809.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> [reworded commit log]
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/power/regulator/rk8xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 97d73ac95e0..e905df3a800 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -901,7 +901,7 @@ static int switch_set_enable(struct udevice *dev, bool enable)
>   	case RK809_ID:
>   		mask = (1 << (sw + 2)) | (1 << (sw + 6));
>   		ret = pmic_clrsetbits(dev->parent, RK817_POWER_EN(3), mask,
> -				      enable ? mask : 0);
> +				      enable ? mask : (1 << (sw + 6)));
>   		break;
>   	case RK818_ID:
>   		mask = 1 << 6;
>
