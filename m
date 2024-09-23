Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0B6CF9C6F
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 14:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C193F88AD7;
	Mon, 23 Sep 2024 16:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="n+V4x/E7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D7B88AD7; Mon, 23 Sep 2024 16:59:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF1788BB2
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 16:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7457=QW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727103551;
 bh=EleCeyCEFajismY6Hig7BVLpdR2n0sMg84f4ts2JhdE=;
 b=n+V4x/E722U4nM17gX/NVsXab3ck82iKFjrHpC0pvgLUictqiE3SY6u9P/6dMKViFo70Wzv04
 QL2X/E9Xe6Kw2xS8dPs9SwwVwe0KxhtI+3cbhTtftzqIU5EdtieWtyMZKpRRb///SUqG1dJ0g7O
 pC7GsN43EoH0ZNsZEIT/QhqgP1QnZWojAsLt3XcGiYn5CX6/C9FhFBhcbwA+6kJFgfNxSVE8y+Z
 gxwfhDMslMIsYF1nZPr9bFnNMKhWj8ubldlZPTEcJTGwL1bW8WuN0/XGzQXU016p7UITnMD9Ae+
 hGqM7lPE8Ui156RU0J4QnqrO33XaQcysEwRibqpVTneQ==
Message-ID: <bf5a5a65-bf69-4b9c-aad6-552e3ab8b8a9@kwiboo.se>
Date: Mon, 23 Sep 2024 16:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix power on/off delay issue
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, festevam@gmail.com,
 sbabic@denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20240923132409.28947-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240923132409.28947-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66f1823d8fcc81b4f15e70da
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

Hi,

On 2024-09-23 15:24, Peng Fan (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> We meet SD initialization issue with some UHS-I SD cards on
> iMX8MM/iMX93/iMX91 EVK. When sending operation condition to card,
> the OCR does not return correct status. We find it is the issue
> in MMC power cycle after below commit applied:
> 4fcba5d (regulator: implement basic reference counter)
> 
> When SD startup, the sequence of MMC power cycle is:
> mmc_power_init(get vmmc_supply dev) -> mmc_power_off -> udelay(2000)
> -> mmc_power_on
> 
> Before the commit, as a fixed regulator, the GPIO is set as:
>   GPIO inactive (in mmc_power_init) ->
>   GPIO inactive and delay off-on-delay-us (in mmc_power_off) ->
>   udelay(2000) ->
>   GPIO active (in mmc_power_on)
> 
> After the commit:
>   GPIO inactive (in mmc_power_init) ->
>   enable_count is 0, regulator_set_enable returns -EALREADY,
>   GPIO is inactive but NO delay (in mmc_power_off) ->
>   udelay(2000) ->
>   GPIO active (in mmc_power_on)

If I understand correctly your regulator is enabled outside of the
reference counting, so the regulator common code never tries to disable
it.

This should probably be solved at the initialization of the reference
count, a gpio controlled regulator should possible check the gpio status
at probe.

Is your regulator flagged with regulator-boot-on flag?

If I remember correctly the reference count should be initialized to 1
with boot-on, if that is the case your regulator should have been
disabled and the delay would be applied.

> 
> Because the lost of off-on-delay-us, the SD card is not completely
> power off. To fix the issue, add the delay after the GPIO setting in
> regulator_common_of_to_plat which is called in device probing.
> So in mmc_power_init, after GPIO is set to default inactive, the
> off-on-delay-us is applied.
> 
> Fixes: 4fcba5d556b ("regulator: implement basic reference counter")
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/power/regulator/regulator_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
> index e3565d32a01..2192e900697 100644
> --- a/drivers/power/regulator/regulator_common.c
> +++ b/drivers/power/regulator/regulator_common.c
> @@ -45,6 +45,12 @@ int regulator_common_of_to_plat(struct udevice *dev,
>  			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
>  	}
>  
> +	if ((flags & GPIOD_IS_OUT_ACTIVE) && plat->startup_delay_us)
> +		udelay(plat->startup_delay_us);
> +
> +	if (!(flags & GPIOD_IS_OUT_ACTIVE) && plat->off_on_delay_us)
> +		udelay(plat->off_on_delay_us);

I do not understand why adding the delay here would solve your issue if
your enable_count is 0 and the GPIO is already inactive why is the power
off delay needed before you power on for the first time? Is your
regulator somehow disabled at probe time or enabled before probe time?

Regards,
Jonas

> +
>  	return 0;
>  }
>  

