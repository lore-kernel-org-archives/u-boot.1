Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1D6C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA142885AE;
	Fri,  2 Aug 2024 08:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DEj2+ZWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A86C5885AE; Fri,  2 Aug 2024 08:18:13 +0200 (CEST)
Received: from mail-m12781.qiye.163.com (mail-m12781.qiye.163.com
 [115.236.127.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E33A87C38
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=DEj2+ZWp0AyiT/vekWOVmXy2SUB9s6C/EF/lNZATxIa0byEKPVB+RaYWtJhLwFV749AwBzGeQJE3J6LqD7IGuqipmYHb/q+FQJ9C67VmEl1vJGXOX+EuOtRoutnGQqjmxDMLy0xhu2emrJfgucdBPYH2rHDVQl8B30caV1ZWz/U=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=c1JSKHTqwreUUj6ROoDleqT08JOUiDqeqnWQD31G4co=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A2C2D9001F7;
 Fri,  2 Aug 2024 14:17:59 +0800 (CST)
Message-ID: <70fef317-c4da-4177-b642-2df75f1f6056@rock-chips.com>
Date: Fri, 2 Aug 2024 14:17:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] arm64: dts: rockchip: Add rk3308 IO voltage domains
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20240730145148.849245-1-jonas@kwiboo.se>
 <20240730145148.849245-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730145148.849245-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNLTlZMH0NCGUpOT09NQ09WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111bcee5303a9kunma2c2d9001f7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6TSo5ITI0KSIuOA8QMkkt
 L0wKCQNVSlVKTElJTkxCT0NLTUhMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTEpKNwY+
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
> Add a disabled RK3308 IO voltage domains node to SoC DT.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240521211029.1236094-12-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: d1829ba469d5743734e37d59fece73e3668ab084 ]
>
> (cherry picked from commit cebde305971e33a76efc3280e09814499ef89f54)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3308.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3308.dtsi b/dts/upstream/src/arm64/rockchip/rk3308.dtsi
> index 6531ede13af9..31c25de2d689 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3308.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3308.dtsi
> @@ -173,6 +173,11 @@
>   		compatible = "rockchip,rk3308-grf", "syscon", "simple-mfd";
>   		reg = <0x0 0xff000000 0x0 0x08000>;
>   
> +		io_domains: io-domains {
> +			compatible = "rockchip,rk3308-io-voltage-domain";
> +			status = "disabled";
> +		};
> +
>   		reboot-mode {
>   			compatible = "syscon-reboot-mode";
>   			offset = <0x500>;
