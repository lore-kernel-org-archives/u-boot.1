Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD62C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501F680FA8;
	Tue, 22 Apr 2025 17:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="joddMUGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A89C780FF7; Tue, 22 Apr 2025 17:28:08 +0200 (CEST)
Received: from mail-m19731110.qiye.163.com (mail-m19731110.qiye.163.com
 [220.197.31.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3587680F6B
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bfc615a;
 Tue, 22 Apr 2025 23:28:00 +0800 (GMT+08:00)
Message-ID: <a33df5d1-b382-433a-b3e1-b3e2538618ba@rock-chips.com>
Date: Tue, 22 Apr 2025 23:28:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] rng: rockchip_rng: Add compatible for RK3568
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20250408221151.2762853-1-jonas@kwiboo.se>
 <20250408221151.2762853-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250408221151.2762853-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUIZVk0ZTRkZH0MfSUsZSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1
 VLWQY+
X-HM-Tid: 0a965e1cff1303afkunm12bfc615a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjI6Dgw4FjJMMEkCPgEWPzk3
 OVYKCShVSlVKTE9OSEhOTUNKTk1OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUlLTEo3Bg++
DKIM-Signature: a=rsa-sha256;
 b=joddMUGlc5JbhnI6kKzePvyk6vlLsoDZN9vo/SeuVMijUp0c50JBPRpoll0UbR96vXfvxs+hP8rj5fprUWwtyy1Dl5QvSaw1+wuBDImfp0vS5oXM0n8NMRo04hDP9HrO/WyWck9gPCp4GdwN7DBnqnnDIIImtToZDPh1h0u19Rw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=pYkfOK79ye7WgIWMtZmlWa1i5YhM/7CAS7iDRWTS7d8=;
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
> The compatible used differs compared to what U-Boot is currently using.
>
> Add support for the rk3568-rng used in upstream Linux. Support for the
> cryptov2-rng compatible is still kept because PX30/RK3326 and RK3308 are
> still using it.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Split SoC u-boot.dtsi change into own patch
> ---
>   drivers/rng/rockchip_rng.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
> index 2426648fbd57..f673e2657c94 100644
> --- a/drivers/rng/rockchip_rng.c
> +++ b/drivers/rng/rockchip_rng.c
> @@ -312,6 +312,10 @@ static const struct udevice_id rockchip_rng_match[] = {
>   		.compatible = "rockchip,rk3399-crypto",
>   		.data = (ulong)&rk_cryptov1_soc_data,
>   	},
> +	{
> +		.compatible = "rockchip,rk3568-rng",
> +		.data = (ulong)&rk_cryptov2_soc_data,
> +	},
>   	{
>   		.compatible = "rockchip,cryptov2-rng",
>   		.data = (ulong)&rk_cryptov2_soc_data,
