Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5CCC52D70
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91B388B77;
	Fri,  2 Aug 2024 08:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jNxn8zDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED73D88B89; Fri,  2 Aug 2024 08:18:40 +0200 (CEST)
Received: from mail-m127223.xmail.ntesmail.com
 (mail-m127223.xmail.ntesmail.com [115.236.127.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105D387C38
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=jNxn8zDSXkC6tDWK3+BFhLJ/OApMExH6LZsSm5Pb9luKtMpUVUN90KZOV10gchxtTWwTaeVKyjm/xlNype/kG5QVn48hHbhjP+lOiOxNJz1E0AZlla/vDq7LgQ5Kq976eaYdxvQnVlwYAh1fv0bPGJQIsG8OKDcJkN9IxUBhGU8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=gnZo2WAnM+iSTqPiqbwjABolNU2O6h9DFRIzew9c/3A=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id CD16A90045F;
 Fri,  2 Aug 2024 14:18:27 +0800 (CST)
Message-ID: <4fa716c9-da84-429f-940d-f42104083020@rock-chips.com>
Date: Fri, 2 Aug 2024 14:18:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: rockchip: Add pinctrl for UART0 to
 rk3308-rock-pi-s
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20240730145148.849245-1-jonas@kwiboo.se>
 <20240730145148.849245-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730145148.849245-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNITFZDGkwYTB5OGR9OHU9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111bd5cd203a9kunmcd16a90045f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTI6Cyo*SzI*PSIBOAFJFU0L
 VhUwCzVVSlVKTElJTkxCTktDQkxNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0hJNwY+
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
> UAR0 CTS/RTS is not wired to any pin and is not used for the default
> serial console use of UART0 on ROCK Pi S.
>
> Override the SoC defined pinctrl props to limit configuration of the
> two xfer pins wired to one of the GPIO pin headers.
>
> Fixes: 2e04c25b1320 ("arm64: dts: rockchip: add ROCK Pi S DTS support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240521211029.1236094-6-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 7affb86ef62581e3475ce3e0a7640da1f2ee29f8 ]
>
> (cherry picked from commit 9c72cd5fa9f971be8ebbc1f43bd74a72e33db2fa)
> ---
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>   dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> index 8ea984906403..d4cf6026241c 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> @@ -294,6 +294,8 @@
>   };
>   
>   &uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_xfer>;
>   	status = "okay";
>   };
>   
