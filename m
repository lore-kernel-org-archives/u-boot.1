Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511C0C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E66682BE4;
	Sun,  6 Apr 2025 17:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WTFneumj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E36A82BF6; Sun,  6 Apr 2025 17:33:55 +0200 (CEST)
Received: from mail-m1973199.qiye.163.com (mail-m1973199.qiye.163.com
 [220.197.31.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B9E82A96
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0680d9;
 Sun, 6 Apr 2025 23:33:47 +0800 (GMT+08:00)
Message-ID: <d900a930-56c5-431b-a0f1-c7779a12ee5a@rock-chips.com>
Date: Sun, 6 Apr 2025 23:33:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] rockchip: binman: Use the skip-at-start prop in
 simple-bin image
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki
 <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250329150626.2879942-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTh1NVkMYTR9KShlCHh4ZQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960bbc8a3f03afkunm10d0680d9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Kww*FTJLKUkLTjwoPAsj
 SRAaCQpVSlVKTE9IQk5ITUlDTE5PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFJSUJKNwY+
DKIM-Signature: a=rsa-sha256;
 b=WTFneumj+zkmJdmOBDSDwB4Po8Vuszg/01bnmAgmyyMe8Kk4cZtZ6OnbCVvpPZO3e4b5xm3qB8amXxR1pEjsjXxKoKZsbHxtEwfrqRhP2QddaREju/CuXzC2zcpUDdjjKrIWrkYJdYmsBIEYS4b2IDRVdS+oUai6dYaIFIVZDvc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=CO21cHaiAsuHrRF07fbcZZDFlu5cMpBWDzNkNiALzhE=;
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


On 2025/3/29 23:06, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
>
> The simple-bin image is normally written to MMC media at block 64, which
> is a 32K offset from start of storage media.
>
> Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
> other embedded binman symbols in the output binary is referencing image
> offsets correctly.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v4:
> - Drop defconfig changes
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>
> Changes in v2:
> - Move this patch to the end of the series
> - Drop 0x8000 offset for SPI
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index fb38b7b80c43..65b81bf58626 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -154,6 +154,7 @@
>   	simple-bin {
>   		filename = "u-boot-rockchip.bin";
>   		pad-byte = <0xff>;
> +		skip-at-start = <0x8000>;
>   
>   		mkimage {
>   			filename = "idbloader.img";
> @@ -178,7 +179,7 @@
>   #else
>   		u-boot-img {
>   #endif
> -			offset = <CONFIG_SPL_PAD_TO>;
> +			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
>   		};
>   
>   		fdtmap {
