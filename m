Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB14EC3271E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 00:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18552889E1;
	Sat,  6 Jul 2024 02:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720227527;
	bh=HNfWJW0jEhGsyjQ2f07TeMbYUNpOkl5/lQH0bop75oM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YCmqEXF7qckHc8BCr6BO4g0+7w4Lrg6Ue2CEX9golCr++xp/69WMceIL/b3cnmed7
	 whYwpHPp8S8K90FzlYc1W1e05QWFCkW7OcngrFVmdU9o6LSuvEi6duaI5CB0wuHWkR
	 hBNdi2rJhS1VpKJ9Tju3jmrYLt+cw01MDln6xB9+lpreNesLtXfjhP4KvksZ0QkS/m
	 XDDKAVSQ7rtInqmxVDJIkxCiW0wosqj9wfn8wsUej899yXxlC+KA7TY7SU2SS3VaG+
	 U/6l4DFdAlMniHOqbP2DDR/4pNNfbTgxUUiBRpmBhtoKMq3zIA7D2mGIwU2VLy4z3x
	 0gKx2w5jROL/Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6717D88641;
 Sat,  6 Jul 2024 02:58:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720227525;
 bh=HNfWJW0jEhGsyjQ2f07TeMbYUNpOkl5/lQH0bop75oM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DxrALYnIS6t+SdxujYLzTn8b8dfWIBxQ/LpdJ45xAwwQR14/6ijpNVHQN0xVvsBpL
 vxa1ENte+81MA56Gd6uI8g0pGZIEXwL3ttENlCV3NQqZ1k1HYaK8IUHI28BGPO7vJe
 Hs76OUT/luM5ZAKUBs+h4W0MWQ/GZ3PAiwZ+SOIAtz+GgomitDrLhHOyrjqzCyj7Sn
 Z92/nZfXrrud+CBet6CB1hfnhqm0K7QabCPP8DQ8KAnl8QJMcOft3QFE+9aPClEHrN
 GiKCvf9GiGkM+rAEUteF3Lz8yVB6nouFuC7fBUCc4XTEeIWcsw5QdHiQypE66ReRdK
 zxkdUxozvbT7w==
Message-ID: <f2743dc3-4789-4f53-bfed-8fbcb6faf3f5@denx.de>
Date: Sat, 6 Jul 2024 02:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] board: rock5b-rk3588: add USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 u-boot@lists.denx.de, Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
 <20240604163546.60225-4-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240604163546.60225-4-sebastian.reichel@collabora.com>
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

On 6/4/24 6:33 PM, Sebastian Reichel wrote:
> Enable support for the fusb302 USB Type-C controller.
> 
> This will do early USB PD (power deliver) negotiation, which must happen
> within 5 seconds after the USB-C connector has plugged in according to
> the specification. It takes almost 5 seconds to go through the bootchain
> on Rock 5B and jump to the operating system. When the Linux initializes
> the fusb302 usually 20-30 seconds have gone since the device has been
> plugged, which is far too late. The USB PD power source reacts with a
> hard reset, which disables VBUS for some time. This is not a problem for
> a battery driven device, but Rock 5B will loose its power-supply and
> reset. By initializing PD in U-Boot, this can be avoided.
> 
> The DT node can be sourced from the Linux kernel DT in the future,
> but to get things going it makes sense to add it in the U-Boot
> specific file for now. Because of the reset issue it is important
> to get support in U-Boot first.

[...]

> +int misc_init_r(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = tcpm_get("usb-typec@22", &dev);
> +	if (ret) {
> +		printf("Failed to probe Type-C controller\n");
> +		return 0;
> +	}
> +
> +	return 0;
> +}

A code comment similar to commit message content would be nice here.
