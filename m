Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20207C5B559
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1289082A9E;
	Fri,  6 Jun 2025 11:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="h9GooNgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A118803DF; Fri,  6 Jun 2025 11:20:57 +0200 (CEST)
Received: from mail-m19731117.qiye.163.com (mail-m19731117.qiye.163.com
 [220.197.31.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9C6A82ADA
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 17c37d8a9;
 Fri, 6 Jun 2025 17:20:50 +0800 (GMT+08:00)
Message-ID: <190f190b-99d4-44b6-ba23-ce00241b98ef@rock-chips.com>
Date: Fri, 6 Jun 2025 17:20:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] rockchip: rk3399-nanopi-4: Allow MMC driver to
 control SD regulators
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250523165406.40915-1-justin@tidylabs.net>
 <20250523165406.40915-5-justin@tidylabs.net>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250523165406.40915-5-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0gdVkIZGB9LTUJNH0IeSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a97448b028503afkunm00abd6821ec1f7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NEk6TTo5GjE2CxkBNEs0SA43
 GSMaCgxVSlVKTE9CSUtKTU5KTU1IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlKQkk3Bg++
DKIM-Signature: a=rsa-sha256;
 b=h9GooNgYpXvz21B2BRcABGdCbyKodI5t++qrPV1+DG9Y1uBOT2MiodGg01KRvlBJRIqafddHlMDHGUzjo1Q5kHcGfc5tvMgoH3oEbTkItEYtnFCow7WvAmMrmZji32t4RBnTY5VRdt1mQJsWRrFhLL0Rb2rHwRhZua+HQs7/51E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=gTUrUfM3krdN0F/69Ts8OPD/bzwXpVmZUlMBKkbsyqY=;
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


On 2025/5/24 00:53, Justin Klaassen wrote:
> This change removes the "regulator-always-on" property from the
> "vcc3v0_sd" (vmmc-supply) and "vcc_sdio" (vqmmc-supply) regulators,
> which otherwise prevents the MMC driver from being able to power cycle
> the SD card as part of the initialization procedure.
>
> It also removes the "regulator-boot-on" from the "vcc_sdio" regulator,
> which could theoretically damage a SD card that is already initialized
> in a low voltage mode.
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Added patch to remove device-tree properties that conflicted with MMC driver initialization
>
>   arch/arm/dts/rk3399-nanopi4-u-boot.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> index 75736124996..ba2b73223d4 100644
> --- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> @@ -19,8 +19,11 @@
>   
>   &vcc3v0_sd {
>   	bootph-pre-ram;
> +	/delete-property/ regulator-always-on;
>   };
>   
>   &vcc_sdio {
> +	/delete-property/ regulator-always-on;
> +	/delete-property/ regulator-boot-on;
>   	regulator-init-microvolt = <3000000>;
>   };
