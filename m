Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D954C48260
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 02:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7352A876FC;
	Tue,  6 Feb 2024 03:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SUNKyM1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEDE87727; Tue,  6 Feb 2024 03:45:45 +0100 (CET)
Received: from mail-m3270.qiye.163.com (mail-m3270.qiye.163.com
 [220.197.32.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E813A8751F
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 03:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=SUNKyM1PQrcaqbPMFMPGI3n/AYHL3u0Is8ZTqWWy8XmCmuXSvNiwwQX68DDHaIcbtCvhVKfCtbr545FGwJDlX+EgnubPd71bs1mpl04ZRI8t0hs9CBKuZDtNUXUqhH3Bc9B75TQTGsROmWFyax5KVFIN0XVM05sR13AYZDT4Uj4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Z+hlKhs5ec4lX8IDPQt1Zr1lGggxA9zJaMxMgayWwIE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 421C5900107;
 Tue,  6 Feb 2024 10:45:34 +0800 (CST)
Message-ID: <176dc66a-5e92-40c6-bbf3-db82f7c3f8dd@rock-chips.com>
Date: Tue, 6 Feb 2024 10:45:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] board: rockchip: Add support for Powkiddy RGB10MAX3
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, jonas@kwiboo.se,
 jagan@amarulasolutions.com, Chris Morgan <macromorgan@hotmail.com>
References: <20240205185855.21508-1-macroalpha82@gmail.com>
 <20240205185855.21508-3-macroalpha82@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240205185855.21508-3-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk0YT1YdGRodSkxLTkkaTUNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d7c4e7b2203a9kunm421c5900107
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxw6Pgw4IjMLPTMCGE8CIgg2
 NgwwCTJVSlVKTEtMSkNMTkhPQkNPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSUJKNwY+
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


On 2024/2/6 02:58, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Add support to the RGxx3 device for the Powkiddy RGB10MAX3. This device
> is extremely similar to all the other devices and can use the same
> bootloader with the same detection logic.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3566-anbernic-rgxx3.dts     | 9 ++++++---
>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 8 ++++++++
>   doc/board/anbernic/rgxx3.rst               | 1 +
>   3 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3.dts b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
> index 9e0aa9e63b..c393c8d07a 100644
> --- a/arch/arm/dts/rk3566-anbernic-rgxx3.dts
> +++ b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
> @@ -12,9 +12,12 @@
>    * set the correct dtb name for loading mainline Linux automatically.
>    */
>   	model = "RGXX3";
> -	compatible = "anbernic,rg353m", "anbernic,rg353p",
> -		     "anbernic,rg353v", "anbernic,rg353vs",
> -		     "anbernic,rg503", "rockchip,rk3566";
> +	compatible = "anbernic,rg-arc-d", "anbernic,rg-arc-s",
> +		     "anbernic,rg353m", "anbernic,rg353p",
> +		     "anbernic,rg353ps", "anbernic,rg353v",
> +		     "anbernic,rg353vs", "anbernic,rg503",
> +		     "powkiddy,rgb10max3", "powkiddy,rgb30",
> +		     "powkiddy,rk2023", "rockchip,rk3566";
>   };
>   
>   &cru {
> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> index d05502f67a..5c57b902d1 100644
> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> @@ -50,6 +50,7 @@ enum rgxx3_device_id {
>   	RGB30,
>   	RK2023,
>   	RGARCD,
> +	RGB10MAX3,
>   	/* Devices with duplicate ADC value */
>   	RG353PS,
>   	RG353VS,
> @@ -107,6 +108,13 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-d.dtb",
>   		.detect_panel = 0,
>   	},
> +	[RGB10MAX3] = {
> +		.adc_value = 765, /* Observed average from device */
> +		.board = "rk3566-powkiddy-rgb10max3",
> +		.board_name = "Powkiddy RGB10MAX3",
> +		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb10max3.dtb",
> +		.detect_panel = 0,
> +	},
>   	/* Devices with duplicate ADC value */
>   	[RG353PS] = {
>   		.adc_value = 860, /* Observed average from device */
> diff --git a/doc/board/anbernic/rgxx3.rst b/doc/board/anbernic/rgxx3.rst
> index d159ed2f76..1e63e6951e 100644
> --- a/doc/board/anbernic/rgxx3.rst
> +++ b/doc/board/anbernic/rgxx3.rst
> @@ -17,6 +17,7 @@ This allows U-Boot to boot the following Anbernic devices:
>   Additionally, the following very similar non-Anbernic devices are also
>   supported:
>   
> + - Powkiddy RGB10MAX3
>    - Powkiddy RGB30
>    - Powkiddy RK2023
>   
