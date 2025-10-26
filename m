Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83309CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2228183849;
	Sun, 26 Oct 2025 16:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WF1MMiAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D335838BB; Sun, 26 Oct 2025 16:44:27 +0100 (CET)
Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com
 [45.254.49.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D1D832AD
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748fce;
 Sun, 26 Oct 2025 23:44:21 +0800 (GMT+08:00)
Message-ID: <2de44fc6-e487-49fc-9082-a870428dece4@rock-chips.com>
Date: Sun, 26 Oct 2025 23:44:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] rockchip: odroid-go2: Remove incorrect
 re-defined spi0 alias
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250831165001.2749711-1-jonas@kwiboo.se>
 <20250831165001.2749711-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250831165001.2749711-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2131286003afkunm16b3f9c24d2e4d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGE9IVktIGhodQh5CShpDH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=WF1MMiAyEtgu03KBEJRJVWRZ7v8ktAE8+GPTS/Z7x84yzp+NAqRjoMqdGmQ0IftbBvN2gT9PYgA5k1t9PbpGF5IFNYEfIuXGb3U9KcQJb82cQE9f5g6hANEz2oQo+KVZWHKBkbIUUQ23L4PTlC4vxL/4VCqzM0ZiBJ4bdT0OYYg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=NEmWzhL0UJ028mu26I0mGoT+ILKpopxB5KxHsxDfnq0=;
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


On 2025/9/1 00:49, Jonas Karlman wrote:
> The alias spi0 is incorrectly being re-defined in board u-boot.dtsi to
> the SPI flash controller instead of the actual spi0 controller.
>
> SPI flash support is currently not working on odroid-go2 due to missing
> Kconfig options and other required device tree changes.
>
> Remove the re-defined alias for spi0 to allow use of the real spi0,
> proper SPI flash support is introduced in a later patch.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch, split from next patch
> ---
>   arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> index f37daa893c79..38778d1aa6cf 100644
> --- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> @@ -16,7 +16,6 @@
>   		mmc0 = &sdmmc;
>   		serial1 = &uart1;
>   		serial2 = &uart2;
> -		spi0 = &sfc;
>   	};
>   
>   	dmc {

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

