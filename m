Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9C0C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 11:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C11E18834D;
	Wed,  5 Jun 2024 13:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kTCI4iFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6182388369; Wed,  5 Jun 2024 13:07:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA1588361
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 13:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d3b1=NH=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1717585663;
 bh=yUblC05QHQZ6a3HOiGb/DsVW+bjsYV3wCImWu6sl7JA=;
 b=kTCI4iFCxJ+PhNNKBheujAxHN8IxVzF+xxKpO7g4seMQv9W6f8PQ/pHl6NBkw1m9fxx+fVrtk
 i6Gup4vnSTqg1NHjihDG2b4zV9qtfsiCfoPopyIpzeDq2YicKMHcjrXlhRNCULJxe1bRyT99cGa
 AW85trnDaKdAMtBHBBDf52pIq70BDofpb3SEWYnLDbRES2F5BorXWcEG9x8sAj0JQ7AEeJuyOQw
 /eNU7/5JJLlUAVoP8XuPyEzZFthTWvp6h9l5WG65JQ9qge5tLZzuE+IBo0LZ84tkqKg0cpVafbv
 9ZY+xojGzPc7pTWWOI570JRO+PmSugnyw2vnZY4DLToA==
Message-ID: <d87e132b-f31c-4b3b-a055-9625fb3fbb49@kwiboo.se>
Date: Wed, 5 Jun 2024 13:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] rockchip: bob: kevin: Disable dcache in SPL
To: Simon Glass <sjg@chromium.org>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "Chen-Yu Tsai" <wens@csie.org>, Dragan Simic <dsimic@manjaro.org>, Jeffy
 Chen <jeffy.chen@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-8-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240605032521.1142768-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 666046fb2a3b8a3d945cef0d
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

Hi Simon,

On 2024-06-05 05:25, Simon Glass wrote:
> This causes a hang, so disable it.

When I initially tested this on multiple boards there was some boards
that also hanged, that turned out to be an issue in one of the drivers.

If I remember correctly such hang was related to a null pointer
dereference or unaligned access in one of the drivers.

Could there be a similar underlying issue for these boards?

Regards,
Jonas

> 
> Fixes: 6d8cdfd1536 ("rockchip: spl: Enable caches to speed up checksum validation")
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  configs/chromebook_bob_defconfig   | 1 +
>  configs/chromebook_kevin_defconfig | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index acfe3934104..b2ecfa6050c 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -1,5 +1,6 @@
>  CONFIG_ARM=y
>  CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SPL_SYS_DCACHE_OFF=y
>  CONFIG_COUNTER_FREQUENCY=24000000
>  CONFIG_ARCH_ROCKCHIP=y
>  CONFIG_TEXT_BASE=0x00200000
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 95fdb418d82..da748e4f022 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>  CONFIG_SKIP_LOWLEVEL_INIT=y
>  CONFIG_COUNTER_FREQUENCY=24000000
>  CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_SYS_DCACHE_OFF=y
>  CONFIG_TEXT_BASE=0x00200000
>  CONFIG_SPL_GPIO=y
>  CONFIG_NR_DRAM_BANKS=1

