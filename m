Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64482D729F3
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 18:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C508947A;
	Fri, 29 Nov 2024 19:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732904777;
	bh=uB3Bws2nhjgEvGA5B3O9X479bxoTIuu7McBcpqw7xfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uaQb1lZpd1YoedZec3fVYD4g7fgcG10pyySYuwNl9YdafbL1G3FETy6BYERdywcXd
	 UW4K4pNTHcRdOgy6att8RGSsd/DezqSEAizozTlmNSpydIJd9KDZN+z3Z44ITADZs0
	 AX8grdzZt7WPkY4vBeGP0rnuVBbN1HTI6AYgPEcYMXzBGiVBAxq0eKL5aUI2ffc3qk
	 qprA6vutkdUiPEUsjReLxHEOw0X0crq2zMjpwkdeWJmhPxO7o9nn4bBAjS/B0cXuRA
	 zOkICLvi2fd6QQUvaCKHsjYaxHgbcKr8fyIvnJS0zH+lupa16PXDpr/FOeuo/Y8zwM
	 FGcs4AZpphM1g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1AEFF89452;
 Fri, 29 Nov 2024 19:26:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732904774;
 bh=uB3Bws2nhjgEvGA5B3O9X479bxoTIuu7McBcpqw7xfU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ruxMfZNaM/X8mpNnfH9pQbreG9p7BoIIljCiU1qAlcVg8Sdtf+YksmWztjXUim3kQ
 nxL0EvLiftGBR/sDVpXk/XwN/k+z4yPW1pfXMLw7x8+8smVPh/mcm7bseQb64WZIQX
 lUVYEu0aRipQhEdh8KRgi1ebeq7ufR8o1gVsTzsIBxdFzw+EI4xQLRbdg97WMe+gox
 nrZh6ni48xIvzboztnH2J7JSRgLOnq39xz4pbOlxllnhXgZdS5YY+wbWoGTYTea08X
 jERgj5K40ZOo2PcDeelw/8xl31J+nkBl8M14d2571SenArmAcPzm1Z/iHpH0ENOGDN
 S40Sk2pE/+iLw==
Message-ID: <98fb1df2-b5ba-4ccf-97c8-d0555c1cdb61@denx.de>
Date: Fri, 29 Nov 2024 18:35:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Add schedule() in
 sleep_thread()
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241129124617.436381-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241129124617.436381-1-patrice.chotard@foss.st.com>
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

On 11/29/24 1:46 PM, Patrice Chotard wrote:
> In case "ums" command is used on platforms which don't implement
> g_dnl_board_usb_cable_connected() and USB cable is not connected,
> we stay inside sleep_thread() forever and watchdog is triggered.
> 
> Add schedule() call to avoid this issue.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
>   drivers/usb/gadget/f_mass_storage.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index ffe1ae6eb73..6dc73ef447b 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -680,6 +680,7 @@ static int sleep_thread(struct fsg_common *common)
>   				return -EIO;
>   
>   			k = 0;
> +			schedule();
>   		}
>   
>   		dm_usb_gadget_handle_interrupts(udcdev);

Shouldn't that schedule() be placed right before/after 
dm_usb_gadget_handle_interrupts() ?
