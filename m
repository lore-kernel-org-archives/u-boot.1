Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C2AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3EF08895D;
	Fri,  9 Aug 2024 11:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="W/jusurE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCC7588A0E; Fri,  9 Aug 2024 11:17:39 +0200 (CEST)
Received: from mail-m12741.qiye.163.com (mail-m12741.qiye.163.com
 [115.236.127.41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA4686BF1
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=W/jusurE/cOGBGBCS/nFnlhFnmLAnXTKqigWp48ZDyzoch6yNlm6c4GTZyuKZZFVprbWUkXgJODS7QNiWfylyhB3PPsiZu96yXaihbfv54x2GYASNyyV+VujOCGO42IIxZ9B5fwKUqUtrhfo352AEHBTWKRzW+NtSO/gP4bB1Ys=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=whf+DDbqIqY5hMgdoU0UzP1YaL6N3gSH7cTcEZh3TL4=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8B5E3900557;
 Fri,  9 Aug 2024 17:17:28 +0800 (CST)
Message-ID: <16dd321a-2ef8-44d3-bbf1-64eb8139c751@rock-chips.com>
Date: Fri, 9 Aug 2024 17:17:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: remove upstreamed props for Radxa
 ROCK 5B
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: eugen.hristev@collabora.com, jonas@kwiboo.se, sjg@chromium.org,
 philipp.tomsich@vrull.eu
References: <20240806033742.50411-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240806033742.50411-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTk4eVh4YTkpNS00dT0pDGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lIQkhCVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91366dc47303a9kunm8b5e3900557
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRQ6LQw4NTIrCw4TLzZWCSo1
 OQJPFApVSlVKTElISkJOS09CTktOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlJSkw3Bg++
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


On 2024/8/6 11:37, FUKAUMI Naoki wrote:
> "usb_host1_xhci" and related node were already upstreamed. remove
> unnecessary properties from u-boot.dtsi.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 17 -----------------
>   1 file changed, 17 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index 8e318e624a8..4dd17ff408c 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -39,18 +39,6 @@
>   	status = "okay";
>   };
>   
> -&u2phy1 {
> -	status = "okay";
> -};
> -
> -&u2phy1_otg {
> -	status = "okay";
> -};
> -
> -&usbdp_phy1 {
> -	status = "okay";
> -};
> -
>   &usbdp_phy0 {
>   	status = "okay";
>   };
> @@ -60,8 +48,3 @@
>   	maximum-speed = "high-speed";
>   	status = "okay";
>   };
> -
> -&usb_host1_xhci {
> -	dr_mode = "host";
> -	status = "okay";
> -};
