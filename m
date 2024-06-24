Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F534C41513
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 00:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76161882E6;
	Mon, 24 Jun 2024 02:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719189372;
	bh=HAPNo0HdqO7vc0nrVHdHtmfGphbhMh4rYkmtDDEVjUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xdehS7YuWBNpYwKppzlV3vm38g0d3+XQoGBS6nhi/u2nlK4EHUz7VYQlAnkqszFDS
	 KELLVAt+rAwWNvFsx+a4nFm/RPOqNSlTaf/l4NE40gJcUQKO3193T3Fzarr5um0Dml
	 ZMsppT85SQFBzKRXQ4DINKH9HMlG3aepdf8gM53ONz4WLR+4fIUUX3r6YQ3OoJwmxf
	 OkPZMKODXhET/CCNT0Jdbj7SE4aH9g3DKs6LMjhe/CFHci8sUxGJOqt8qvXsJcUPhW
	 NeLFZmCX8KKJvTrwPvdQsozGeetZXAwKo/Frf4GxRzq+Vf6S6GeGzPxW9+d/GhfhJo
	 2xteyI5BhYTmQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0A2DA882DF;
 Mon, 24 Jun 2024 02:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719189371;
 bh=HAPNo0HdqO7vc0nrVHdHtmfGphbhMh4rYkmtDDEVjUU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Felz4AsI3oNMe0KDjVcXUDTQEkMqhi6HLTduN4zkUHO4KgeIOSpRrAOQ2IX+qlCiG
 2DkhNtgcj39DMn66VU5LV6WwFXxHtlfBdz+xeQ1WmAf+JNPWvLiJX38+fJMhPfWIhI
 TDUnYam6lbTTCjnI3nDzHeVp8occAOGs1PHhxYzaBlcdj0QjyU5cl+ioYN2M51gQQg
 0R6oZ61HqEJHvE+TTvazqEJZOnOvmn+WRQQHtgIXXH/7N/4UYW+kmhzahTb1WtMNIq
 xgAypXQjv0QL/LvAXL1zjvCDR7XHVMCmfxigffek4koNunXAizAJjX5IthTyKqIMzB
 pplaOOe0oYiUA==
Message-ID: <be9fafa8-c3a1-4434-b344-caf32527460a@denx.de>
Date: Mon, 24 Jun 2024 02:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: respect role-switch-default-mode
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20240621021135.1600847-2-caleb.connolly@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240621021135.1600847-2-caleb.connolly@linaro.org>
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

On 6/21/24 4:11 AM, Caleb Connolly wrote:
> * Factor out the common pattern of checking the dr_mode property on
>    the usb node and it's parent
> * Respect the usb-role-switch property, rather than requiring dr_mode be
>    set
> * Override OTG mode with the value in role-switch-default-mode
> 
> The devicetree bindings don't dictate that dr_mode is a required
> property, but the dwc3 driver would refuse to probe if it was unset
> (this breaks the Qualcomm RB2 board which doesn't set it).
> 
> Here, we update the driver to respect the other properties that can be
> used to describe the controller, and more gracefully handle some of the
> edge cases.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 56 +++++++++++++++++++++++++--------
>   1 file changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index cbb5d61dfb0b..1cf8b90e8bbf 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -49,8 +49,46 @@ struct dwc3_generic_host_priv {
>   	struct dwc3_generic_priv gen_priv;
>   	struct udevice *vbus_supply;
>   };
>   
> +/**
> + * dwc3_get_preferred_dr_mode() - Get the preferred DR mode for the USB node
> + *
> + * Since we don't support dynamic role switching yet in dwc3, this is a slightly
> + * opinionated wrapper around usb_get_dr_mode() which will respect the
> + * role-switch-default-mode property if it is present and the dr_mode is OTG.
> + *
> + * @child: Node to get the DR mode for
> + */
> +static enum usb_dr_mode dwc3_get_preferred_dr_mode(ofnode node)
> +{
> +	enum usb_dr_mode mode;
> +	bool is_role_switch = ofnode_has_property(node, "usb-role-switch");

The usb-role-switch DT property is not DWC3 specific, even in U-Boot it 
is used by e.g. STM32MP15xx which is DWC2. This should be added to core 
code.

Also, it would be really good to sync the DWC3 driver with more up to 
date Linux state, but that's out of the scope of this patch obviously.
