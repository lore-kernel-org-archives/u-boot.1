Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C455FCA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D6BD836AB;
	Sat, 30 Aug 2025 16:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hotV2L/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3168836B2; Sat, 30 Aug 2025 16:56:24 +0200 (CEST)
Received: from mail-m19731116.qiye.163.com (mail-m19731116.qiye.163.com
 [220.197.31.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 867E58341A
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4c51;
 Sat, 30 Aug 2025 22:56:17 +0800 (GMT+08:00)
Message-ID: <48e65bfb-a4ce-4b3f-adcd-59823a39b845@rock-chips.com>
Date: Sat, 30 Aug 2025 22:56:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] rng: rockchip_rng: Add compatible for RK3576
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20250801203255.2590535-1-jonas@kwiboo.se>
 <20250801203255.2590535-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250801203255.2590535-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb7aad2303afkunmfbdf7f9840d268
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHU0fVkJDS0JNSExJH08aQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=hotV2L/aGhaH9J/Bm9fx+PmxB2zBFg7MCBBB70ZSF8pzP5QGIZqIVfJPmKqQbnLCGxI4Mst162Aqd6DYn74ASgLhQ/i0eB6ke0VI4iqa9aLNGLNVpfYbcwteAbWHCegeRcjxnKknHdkHhmronT+94k9l2Rn3qoRfk2P3iMlRfXY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=to9flIPTFVLe02aNDAH43TIuJ/25Ev3ylrm+zMkl2dc=;
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


On 2025/8/2 04:32, Jonas Karlman wrote:
> The RK3576 SoC contains a RKRNG block that can be used to generate
> random numbers using the rockchip_rng driver.
>
> Add compatible for RK3576 to support random numbers:
>
>    => rng list
>    RNG #0 - rng@2a410000
>
>    => rng
>    00000000: 36 dd ab 98 ec fb fe d1 cf 36 b3 e1 9b 3d 00 90  6........6...=..
>    00000010: f5 84 de 75 6b 27 48 9e 13 62 12 6c 50 ca 47 1a  ...uk'H..b.lP.G.
>    00000020: b3 4d fc 43 c5 b5 2d be 07 27 03 26 bb 69 61 2a  .M.C..-..'.&.ia*
>    00000030: 6f 70 01 83 4e ce 91 7a 5a 6c 7c 00 43 87 3e c5  op..N..zZl|.C.>.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: New patch
> ---
>   drivers/rng/rockchip_rng.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
> index d854ea900442..8cf750e043cf 100644
> --- a/drivers/rng/rockchip_rng.c
> +++ b/drivers/rng/rockchip_rng.c
> @@ -393,6 +393,10 @@ static const struct udevice_id rockchip_rng_match[] = {
>   		.compatible = "rockchip,rk3588-rng",
>   		.data = (ulong)&rk_trngv1_soc_data,
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-rng",
> +		.data = (ulong)&rkrng_soc_data,
> +	},
>   	{
>   		.compatible = "rockchip,rkrng",
>   		.data = (ulong)&rkrng_soc_data,
