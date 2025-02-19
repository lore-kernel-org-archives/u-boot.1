Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EECC021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 15:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B391180A46;
	Wed, 19 Feb 2025 16:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QUB7apxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2D380EBD; Wed, 19 Feb 2025 16:02:38 +0100 (CET)
Received: from mail-m49201.qiye.163.com (mail-m49201.qiye.163.com
 [45.254.49.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685A8801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.169])
 by smtp.qiye.163.com (Hmail) with ESMTP id b8f4dfe4;
 Wed, 19 Feb 2025 23:02:31 +0800 (GMT+08:00)
Message-ID: <704d3a73-cbbf-43eb-ba1b-160a4284324a@rock-chips.com>
Date: Wed, 19 Feb 2025 23:02:25 +0800
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
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0MdVhkfT0pLH0hMSB1PGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk1CWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a951ebb627403afkunmb8f4dfe4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSI6Myo*ITIJPy4RAgIQLk4d
 HSEaCi1VSlVKTEhCQkxMSE5JTklOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTElVSk1CWVdZCAFZQUpJSks3Bg++
DKIM-Signature: a=rsa-sha256;
 b=QUB7apxx2eDkPB9kdF/Klj5CiSzlu+KkRZPIqT9sLAvxxHbetxxKJLrJqrg8xGqm3gNFNeC5bSbFI79ilTop7je6HMe3rv5Y2f+vLnMV/7Wee4tTlK3EyCuxYz+JpEUf8KJTGMpmGN6Yn4t0UjTNAItj3+v6v6FG406HjftymyE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=g7yvleXxVbGwX+e3Cd1TRcadGu3UhCL9JsloPhBRzO0=;
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

Hi Justin,

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

This was disabled in upstream kernel in 
dts/upstream/src/arm64/rockchip/rk3399-nanopi-r4s.dtsi

Can you also update the upstream kernel dts?

this u2phy1_host should always have the same status as usb_host1_ehci.


Thanks,

- Kever

