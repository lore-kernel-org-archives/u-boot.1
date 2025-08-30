Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81188CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0840F836B2;
	Sat, 30 Aug 2025 17:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="e7KsXyWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45BBA8380E; Sat, 30 Aug 2025 17:23:50 +0200 (CEST)
Received: from mail-m49208.qiye.163.com (mail-m49208.qiye.163.com
 [45.254.49.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCE68341A
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f986d;
 Sat, 30 Aug 2025 23:23:43 +0800 (GMT+08:00)
Message-ID: <45c02be5-2d70-4f0c-a67d-68fdfd32be00@rock-chips.com>
Date: Sat, 30 Aug 2025 23:23:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] rockchip: rk3528-generic: Fix boot after dts/upstream
 v6.16-dts merge
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250730235301.1774089-1-jonas@kwiboo.se>
 <20250730235301.1774089-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250730235301.1774089-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb93cb3303afkunmf4ad8a91415183
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQxhJVkxOTk1JTh5OSxpKTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=e7KsXyWaXM9FJbV6TeAC098OlS7OwAQQ6urBEztOxL/sKFVg+9lTPPqMWxoy10jDHay41+cFnnEl+rdrzIoTv9l/8Y78cdtDPzL58BGKzYrirKCiIR6lswid7f9ryVDRNVd02TQi6r0J+en+c/cO+MIKc2Yu8nZXutc0ymA9OzQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Ut+PXMiLRyGgPq7TuNNB8WxMbOYQChwLJ+oTuBuyFBI=;
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


On 2025/7/31 07:52, Jonas Karlman wrote:
> The rk3528-generic target can no longer boot after v6.16-dts was merged
> into dts/upstream, and instead end up in a boot loop:
>
>    No serial driver found
>    resetting ...
>
> After Linux commit 34d2730fbbdd ("arm64: dts: rockchip: move rk3528
> i2c+uart aliases to board files") there is no longer an alias for
> serial0 defined for the U-Boot only rk3528-generic device tree.
>
> Add a board specific aliases node that include the missing serial0 alias
> to resolve the boot issue and ensure that stdout-path = "serial0:..."
> can be resolved by U-Boot.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3528-generic.dts | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528-generic.dts
> index 3f6f0bed108d..fe9e72c41cd7 100644
> --- a/arch/arm/dts/rk3528-generic.dts
> +++ b/arch/arm/dts/rk3528-generic.dts
> @@ -10,6 +10,11 @@
>   	model = "Generic RK3528";
>   	compatible = "rockchip,rk3528";
>   
> +	aliases {
> +		mmc0 = &sdhci;
> +		serial0 = &uart0;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial0:1500000n8";
>   	};
