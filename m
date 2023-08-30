Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5091C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 15:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C5328652F;
	Wed, 30 Aug 2023 17:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693408711;
	bh=bfhiaHdMu59TbFvbRiQ6frHt46FeRhSnbc2XVscnafQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KPyERPp1imJqTP/GbIkvmX5BSebVQzqbCvfaJpEUE/J+zGR0jwDzg4QTgZ7WL1rZu
	 IwqYDU+q1n+A9DpE0ZaKRmmTsXM4UzMOUQp9qUVaRX9RiHjiJAJgVkFX6uyMHFJm0r
	 cwGtrpmtlY7WvL7LbnVxTt0JOV6vZrd9zSu5s3qURDmI06bjS6P/uMo0U08McjpdjL
	 L45pqDw8olJcdGtrptDfyFez3SF/tzvujxsVOgRud1gtB1nFsVRQvrX15QRd4fMSSK
	 0Avh1srDwtm68wV9Hvrrh5alda/6Y91cvGBVAlaJ3pFQGHdhMI07fVxZVN4to3df0U
	 o0jwKXRBmaHuQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4AF8F863DD;
 Wed, 30 Aug 2023 17:18:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693408710;
 bh=bfhiaHdMu59TbFvbRiQ6frHt46FeRhSnbc2XVscnafQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kaYU3qObJ3MsAuK2twVfH20G1IMT7EHTrAMwenI9rxbJ5MhumTuCSaaJjtqU2Opi3
 T+0nbLHP3T5Ae8tdzCBV86VK25Ik8mK++982/FnmlKIbW8Prh7h1hpnyBlrwuyMujU
 mSx8AT6DCNdkYBKw/FSJBquVqWr5B55QYFWqA0MWv2wQ9IzUzYoelnIMP1qaWOdl9f
 UnosRB7DXh3ftqg4Ye/XB5tOKVNJYGlYv3ScOc/Hj/6S08mkelH3hab05HfvlerFUI
 SyQMhaU/Xgx+6dHh2rffq3kMxHnjm7EP12FHz1UXVcFN57oIQZIU62f4PkdT3omOAR
 oldmzrqyYDbuA==
Message-ID: <84041468-abf2-9b68-6701-6605f4948bf5@denx.de>
Date: Wed, 30 Aug 2023 17:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] usb: host: ohci-generic: Make usage of clock/reset bulk()
 API
Content-Language: en-US
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
References: <20230830080150.473374-1-fabrice.gasnier@foss.st.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230830080150.473374-1-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/30/23 10:01, Fabrice Gasnier wrote:
> Make usage of clock and reset bulk API in order to simplify the code
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> 
>   drivers/usb/host/ohci-generic.c | 92 +++++++++++----------------------
>   1 file changed, 29 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
> index 2d8d38ce9a40..95aa608d8c19 100644
> --- a/drivers/usb/host/ohci-generic.c
> +++ b/drivers/usb/host/ohci-generic.c
> @@ -16,75 +16,41 @@
>   
>   struct generic_ohci {
>   	ohci_t ohci;
> -	struct clk *clocks;	/* clock list */
> -	struct reset_ctl *resets; /* reset list */
> +	struct clk_bulk clocks;	/* clock list */
> +	struct reset_ctl_bulk resets; /* reset list */
>   	struct phy phy;
> -	int clock_count;	/* number of clock in clock list */
> -	int reset_count;	/* number of reset in reset list */
>   };
>   
>   static int ohci_usb_probe(struct udevice *dev)
>   {
>   	struct ohci_regs *regs = dev_read_addr_ptr(dev);
>   	struct generic_ohci *priv = dev_get_priv(dev);
> -	int i, err, ret, clock_nb, reset_nb;
> -
> -	err = 0;
> -	priv->clock_count = 0;
> -	clock_nb = dev_count_phandle_with_args(dev, "clocks", "#clock-cells",
> -					       0);
> -	if (clock_nb > 0) {
> -		priv->clocks = devm_kcalloc(dev, clock_nb, sizeof(struct clk),
> -					    GFP_KERNEL);
> -		if (!priv->clocks)
> -			return -ENOMEM;
> -
> -		for (i = 0; i < clock_nb; i++) {
> -			err = clk_get_by_index(dev, i, &priv->clocks[i]);
> -			if (err < 0)
> -				break;
> -
> -			err = clk_enable(&priv->clocks[i]);
> -			if (err && err != -ENOSYS) {
> -				dev_err(dev, "failed to enable clock %d\n", i);
> -				clk_free(&priv->clocks[i]);
> -				goto clk_err;
> -			}
> -			priv->clock_count++;
> -		}
> -	} else if (clock_nb != -ENOENT) {
> -		dev_err(dev, "failed to get clock phandle(%d)\n", clock_nb);
> -		return clock_nb;
> +	int err, ret;
> +
> +	ret = clk_get_bulk(dev, &priv->clocks);
> +	if (ret && ret != -ENOENT) {
> +		dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);

Plural of 'clock' is still 'clock' , please fix just the text, keep the 
variable name .

> +		return ret;
> +	}
> +
> +	err = clk_enable_bulk(&priv->clocks);
> +	if (err) {
> +		dev_err(dev, "Failed to enable clocks (err=%d)\n", err);

DTTO here

> +		goto clk_err;
>   	}
>   
> -	priv->reset_count = 0;
> -	reset_nb = dev_count_phandle_with_args(dev, "resets", "#reset-cells",
> -					       0);
> -	if (reset_nb > 0) {
> -		priv->resets = devm_kcalloc(dev, reset_nb,
> -					    sizeof(struct reset_ctl),
> -					    GFP_KERNEL);
> -		if (!priv->resets)
> -			return -ENOMEM;
> -
> -		for (i = 0; i < reset_nb; i++) {
> -			err = reset_get_by_index(dev, i, &priv->resets[i]);
> -			if (err < 0)
> -				break;
> -
> -			err = reset_deassert(&priv->resets[i]);
> -			if (err) {
> -				dev_err(dev, "failed to deassert reset %d\n", i);
> -				reset_free(&priv->resets[i]);
> -				goto reset_err;
> -			}
> -			priv->reset_count++;
> -		}
> -	} else if (reset_nb != -ENOENT) {
> -		dev_err(dev, "failed to get reset phandle(%d)\n", reset_nb);
> +	err = reset_get_bulk(dev, &priv->resets);
> +	if (err && err != -ENOENT) {
> +		dev_err(dev, "failed to get resets (err=%d)\n", err);
>   		goto clk_err;
>   	}
>   
> +	err = reset_deassert_bulk(&priv->resets);
> +	if (err) {
> +		dev_err(dev, "failed to get deassert resets (err=%d)\n", err);

Drop the 'get' from the text here, I think it's copy-paste error.

> +		goto reset_err;
> +	}
> +
>   	err = generic_setup_phy(dev, &priv->phy, 0);
>   	if (err)
>   		goto reset_err;

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

Nice cleanup, thanks !
