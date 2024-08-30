Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89EBCA0ED0
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5AD88D3D;
	Fri, 30 Aug 2024 03:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724981203;
	bh=O0NSCwAOX1yAo/GBTMHYZhghLu36SXBxZDIF4Fg2Xf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hmN3Tt5HmT3ksjzPiQDdLGBkBl2prL+YccgacStgOV7TKsFFUR/d/LQpfvP9CrATP
	 cXy9bEJaXR+R65PMrqv35pa4FYN6xc0OvNxu+98BFcOru1lyH+gHt0kxLOUfoq99mH
	 nOaWZBv5wHwlM6jizjwN+/t97COVKcdzG46mK38OM/00QGZD8ahgIGBU9GSIpxQf40
	 R6VThmQmh9hgPmO85vta+5EDlUX84MfKn6xHrycDt3Rpcdy1MyprQWjTfD9EFWpDqK
	 yazObPyHS59KtVZrfoE38Nct463MjNOl2GUk9yoVA8+wM17KhPdUkbuAphCXskwAsR
	 jCVdS2tenbMmQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AA1BF87F19;
 Fri, 30 Aug 2024 03:26:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724981201;
 bh=O0NSCwAOX1yAo/GBTMHYZhghLu36SXBxZDIF4Fg2Xf0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JiEtd3HDg/ltI7xYjaYk9ZP59cI9ec935wyXI1rHXBOWSa5CR2BQAtQT6w3MdtjbW
 MKd2X1DBkORwIAM8wjF1IKvHo52mog87T5dKVzIo32Z3+u+mtcGnPK3qkPxjNc9dXp
 U8hjqrhnPKcFlhrTG55d0My4hqtLvTtIZQgaCVyPA1RpyXqwSMU5oQ69tXZIP3/K/Q
 ezwtk8EnpfacljIoRXSxQCWEy6rH9plg6B2NG2mxRnYOlP+stIpTGLqZOzravkSzEQ
 kscZ5v6Hl4mM7V5iuyCMHMoiDprQsjQrltoEl/iGaIA5biZPBG5r6+ab7OvR48FdDP
 KU0JdHeVYK5ew==
Message-ID: <cf1beaa1-8811-4c33-aad3-febd7ea3c00b@denx.de>
Date: Fri, 30 Aug 2024 03:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] phy: starfive: Add Starfive JH7110 USB 2.0 PHY
 driver
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-3-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240829013058.6178-3-minda.chen@starfivetech.com>
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

On 8/29/24 3:30 AM, Minda Chen wrote:

[...]

> +menu "Starfive PHY driver"
> +
> +config PHY_STARFIVE_JH7110_USB2
> +	bool "Starfive JH7110 USB 2.0 PHY driver"
> +	select PHY

Can this PHY_STARFIVE_JH7110_USB2 symbol be selected if CONFIG_PHY is 
not set ? I think it cannot, so this 'select PHY' is unnecessary and 
should be removed.

[...]

> +static void usb2_set_ls_keepalive(struct jh7110_usb2_phy *phy, bool set)
> +{
> +	/* Host mode enable the LS speed keep-alive signal */
> +	if (set)
> +		clrsetbits_le32(phy->regs + USB_LS_KEEPALIVE_OFF,
> +				USB_LS_KEEPALIVE_ENABLE,
> +				USB_LS_KEEPALIVE_ENABLE);
> +	else
> +		clrsetbits_le32(phy->regs + USB_LS_KEEPALIVE_OFF,
> +				USB_LS_KEEPALIVE_ENABLE, 0);

Either use clrbits_le32() or use rework the function this way:

		clrsetbits_le32(phy->regs + USB_LS_KEEPALIVE_OFF,
				USB_LS_KEEPALIVE_ENABLE,
				set ? USB_LS_KEEPALIVE_ENABLE : 0);

[...]
