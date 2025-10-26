Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB718CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63089838CC;
	Sun, 26 Oct 2025 16:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BwWMLrvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0865A838D2; Sun, 26 Oct 2025 16:44:36 +0100 (CET)
Received: from mail-m49224.qiye.163.com (mail-m49224.qiye.163.com
 [45.254.49.224])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012D4832AD
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748fd8;
 Sun, 26 Oct 2025 23:44:30 +0800 (GMT+08:00)
Message-ID: <51f155a5-32db-48c0-bd68-2bf810196f71@rock-chips.com>
Date: Sun, 26 Oct 2025 23:44:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] rockchip: odroid-go2: Remove u-boot.dtsi props
 already defined
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250831165001.2749711-1-jonas@kwiboo.se>
 <20250831165001.2749711-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250831165001.2749711-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a21314ed003afkunmd11f64224d2f13
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHhlPVkJPHh8dGEtCHh1MTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=BwWMLrvWnM9BkzuBV/KeBLWC2u/L4yyBMHtkVw6epbAhQc1Irfy2ry4BNeJ3Ar3/qJYEcdKr7kAluaU8zuucLMUikRvk92pv5wBMzx+Owbc+0qemFHkc4brzj8W7ybvmKb9J7l0F64XvgDVwZ0mL1E0MAGe9NBBUamJ8y1q7iRE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=dyPoSVi+tHsIoIPBTt+K1of9c2x7UWecYYQX6AWBD4s=;
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
> DTs from dts/upstream already contain aliases for i2c, mmc and serial.
>
> Remove the aliases and status=okay that are already defined in upstream
> board or SoC DT.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Split out unrelated spi0 alias change into separate patch
> ---
>   arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> index 38778d1aa6cf..df21747fad78 100644
> --- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> @@ -10,14 +10,6 @@
>   		u-boot,spl-boot-order = &sdmmc;
>   	};
>   
> -	aliases {
> -		i2c0 = &i2c0;
> -		i2c1 = &i2c1;
> -		mmc0 = &sdmmc;
> -		serial1 = &uart1;
> -		serial2 = &uart2;
> -	};
> -
>   	dmc {
>   		bootph-all;
>   		compatible = "rockchip,px30-dmc", "syscon";
> @@ -27,7 +19,6 @@
>   	rng: rng@ff0b0000 {
>   		compatible = "rockchip,cryptov2-rng";
>   		reg = <0x0 0xff0b0000 0x0 0x4000>;
> -		status = "okay";
>   	};
>   };
>   
> @@ -84,7 +75,6 @@
>   
>   &saradc {
>   	bootph-all;
> -	status = "okay";
>   };
>   
>   &sdmmc {

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

