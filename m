Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D058C52D70
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF1388B9D;
	Fri,  2 Aug 2024 08:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Gkqhg21p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3BCB88B9B; Fri,  2 Aug 2024 08:19:09 +0200 (CEST)
Received: from mail-m19731114.qiye.163.com (mail-m19731114.qiye.163.com
 [220.197.31.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5622387C38
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Gkqhg21pBaXKTnXyyMHC857jR2dqd5phbGzOLVMP3papmMuvO0+0nKEFeoz2NHJhh6Zl9yEauIiWOZQnO5lP2j5309Fi3EAlTj+Xa1yTY86yE0yWq+sNIyDuYxC7mQXqR4HJAkoTgwsxuCEAklSydMa8JBmPz8eUpu6GjXd1KyY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=RdB8+DXxizL4qBdroq1im1huBnXIwf/pAtSeR5jhLBw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4C530900461;
 Fri,  2 Aug 2024 14:18:59 +0800 (CST)
Message-ID: <49eb4670-a54f-4997-92d6-c70c89c05da6@rock-chips.com>
Date: Fri, 2 Aug 2024 14:18:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] rockchip: rk3308-rock-pi-s: Remove unnecessary u-boot
 dtsi overrides
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240730145148.849245-1-jonas@kwiboo.se>
 <20240730145148.849245-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730145148.849245-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNOGVYfGE9LHUkaTk1PSk9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111bdd7ae03a9kunm4c530900461
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzY6ASo6DTI1TCIREgxWFCMj
 MQ0wC1ZVSlVKTElJTkxCTk9LSUJDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUxDNwY+
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


On 2024/7/30 22:51, Jonas Karlman wrote:
> With the emmc and uart0 DT nodes updated to v6.11-rc1 in dts/upstream
> there is no longer any need to keep overrides in board u-boot dtsi.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi | 19 -------------------
>   1 file changed, 19 deletions(-)
>
> diff --git a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
> index a6fb8b12da38..ff5bab316a34 100644
> --- a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
> @@ -4,17 +4,6 @@
>    */
>   #include "rk3308-u-boot.dtsi"
>   
> -&emmc {
> -	cap-sd-highspeed;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus4>;
> -};
> -
> -&emmc_bus4 {
> -	bootph-pre-ram;
> -	bootph-some-ram;
> -};
> -
>   &u2phy_otg {
>   	/delete-property/ phy-supply;
>   };
> @@ -24,14 +13,6 @@
>   	clock-frequency = <24000000>;
>   };
>   
> -&uart0_cts {
> -	bootph-all;
> -};
> -
> -&uart0_rts {
> -	bootph-all;
> -};
> -
>   &uart0_xfer {
>   	bootph-all;
>   };
