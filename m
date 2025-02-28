Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE098C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 11:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D418811B3;
	Fri, 28 Feb 2025 12:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hJA94DsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41323811C5; Fri, 28 Feb 2025 12:11:10 +0100 (CET)
Received: from mail-m1973195.qiye.163.com (mail-m1973195.qiye.163.com
 [220.197.31.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF2BF810EB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id c85b7458;
 Fri, 28 Feb 2025 19:11:01 +0800 (GMT+08:00)
Message-ID: <5416662d-8546-438d-95c9-234aed6262af@rock-chips.com>
Date: Fri, 28 Feb 2025 19:11:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: nanopi-r4s: Enable second usb port and fix crash
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Xiaobo Tian <peterwillcn@gmail.com>
References: <20250131170622.747101-1-justin@tidylabs.net>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250131170622.747101-1-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0weHVZIHxpNTUwaTUIaGBpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a954c40ad2e03afkunmc85b7458
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6MQw*MjIVAQEDLkM3ETgS
 HkMKCS5VSlVKTE9LTE9KS01JQk5OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0lINwY+
DKIM-Signature: a=rsa-sha256;
 b=hJA94DsNI/PWi4z1RnQmEIOFLa31phoQ1fOrS7jQW4KQKFtGCgqMAcO9OVuru2G8fM1s26QzD7nByYWydp9WGQdfzREz8Gzx0xUDEQVOVokWeQiyFlKlxoOfUoXjcHHQolOJ11JkKTr3e91B7XSndG2CJDPrlRSarc5PGet7auM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=A+NL6WMfTE7HLk3uKypYs+7L6q6jsTw2isU/MZS6ZAo=;
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


On 2025/2/1 01:06, Justin Klaassen wrote:
> The patch enables the second USB3.0 Type-A USB port on the NanoPi R4S
> board, which prevents a crash when initializing the usb system in U-Boot
> and allows both Type-A USB ports to be used for booting.
>
> => usb start
> starting USB...
> Bus usb@fe380000: USB EHCI 1.00
> Bus usb@fe3c0000: "Synchronous Abort" handler, esr 0x96000010, far 0x0
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> ---
>
>   arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi b/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
> index 69800cc368d..931499b084c 100644
> --- a/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
> @@ -36,3 +36,8 @@
>   		};
>   	};
>   };
> +
> +&u2phy1_host {
> +	phy-supply = <&vdd_5v>;
> +	status = "okay";
> +};
