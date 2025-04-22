Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45651C369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:28:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5032812BC;
	Tue, 22 Apr 2025 17:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Hloxwto8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCC338171B; Tue, 22 Apr 2025 17:28:17 +0200 (CEST)
Received: from mail-m155100.qiye.163.com (mail-m155100.qiye.163.com
 [101.71.155.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C5782054
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bfc6169;
 Tue, 22 Apr 2025 23:28:09 +0800 (GMT+08:00)
Message-ID: <d5dafd7b-5a1e-47fc-9606-c250d2a057d8@rock-chips.com>
Date: Tue, 22 Apr 2025 23:28:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] rockchip: rk356x: Remove rng node from u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250408221151.2762853-1-jonas@kwiboo.se>
 <20250408221151.2762853-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250408221151.2762853-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkgdVk0fQ09MSUNKTBoeH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1
 VLWQY+
X-HM-Tid: 0a965e1d22ae03afkunm12bfc6169
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxw6LBw*KzJWLEkJUQEWPzg3
 KBdPCUJVSlVKTE9OSEhOTUJLQ01PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUlLTko3Bg++
DKIM-Signature: a=rsa-sha256;
 b=Hloxwto8xFbmzhkkHMAJr2Ix4PSRzShRCQQUNIxDbVZjvGbbDzSwSwNzMdoMKzFkOKjGGzRPG1a3CDrVIAeODwCNv3qohiHbkqhtimigONRzG9gXocTaXd+gp29rfjMwE3h0+KV3DddWOkzRoU6C459WzURbMFUbC0ip86ykqnw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=gpw05odOPS074vH5/B3bz+u6ZxaZRsfwVb0JsMbW5EE=;
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


On 2025/4/9 06:11, Jonas Karlman wrote:
> Linux commit afeccc408496 ("arm64: dts: rockchip: add DT entry for RNG
> to RK356x") merged for v6.12-rc1 add a proper rng node to the SoC DT.
>
> Remove the rng node from SoC u-boot.dtsi now that the rng driver support
> the compatible used in dts/upstream DT. Ensure the rng node is enabled
> to support rng on RK3566 variants.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Split SoC u-boot.dtsi change into own patch
> ---
>   arch/arm/dts/rk356x-u-boot.dtsi | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 24a976cf7e21..871869739536 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -21,11 +21,6 @@
>   		bootph-all;
>   	};
>   
> -	rng: rng@fe388000 {
> -		compatible = "rockchip,cryptov2-rng";
> -		reg = <0x0 0xfe388000 0x0 0x2000>;
> -	};
> -
>   	otp: nvmem@fe38c000 {
>   		compatible = "rockchip,rk3568-otp";
>   		reg = <0x0 0xfe38c000 0x0 0x4000>;
> @@ -121,6 +116,10 @@
>   	bootph-all;
>   };
>   
> +&rng {
> +	status = "okay";
> +};
> +
>   &sdhci {
>   	bootph-pre-ram;
>   	bootph-some-ram;
