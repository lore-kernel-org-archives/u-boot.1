Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E6EA8542
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 03:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52A728063E;
	Mon,  9 Mar 2026 04:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Sa2kVHCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A528A83A8C; Mon,  9 Mar 2026 04:10:48 +0100 (CET)
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com
 [45.254.49.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012A680517
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 04:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36309128c;
 Mon, 9 Mar 2026 11:10:43 +0800 (GMT+08:00)
Message-ID: <e47c0f92-ebd9-4ec0-a420-6d3396ac161e@rock-chips.com>
Date: Mon, 9 Mar 2026 11:10:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Add support for Radxa E52C
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 jonas@kwiboo.se, heiko@sntech.de, christopher.obbard@linaro.org,
 cnsztl@gmail.com, xuhui.lin@rock-chips.com
References: <20260110011505.36915-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260110011505.36915-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd093584503afkunm86a91966162e04f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEgeVh5JHx0eTE5PQ01JTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktISkpCTFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=Sa2kVHCB+7Jd7JVioyaq3QGA3S4kLGkANVz5SBQbjhg3HjNjDkQXnzrD14UDA9sfegLefmIKHA26KTHv+GkOGBpAxDyZ4T7xA2Vsf3RaUSojFFrqofdFztRAKxfXnN4HOzqsWE9vldV4Lp4tAiw/EOn9yW3r2qYwYMQSGb7pqvw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=uvinRqWuQIYQbEaQOL62Hws30Q38pyKo1uANG8vogVY=;
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

Hi Naoki,

On 2026/1/10 09:15, FUKAUMI Naoki wrote:
> The Radxa E52C is a compact network computer developed by Radxa, based
> on the Rockchip RK3582 SoC. [1]
>
> Specification:
> - Dual Cortex-A76 and Quad Cortex-A55 cores
> - 5TOPS NPU
> - Up to 8GB LPDDR4x RAM
> - Up to 64GB eMMC
> - microSD card slot
> - USB 3.0 Type-A OTG port
> - USB Type-C debug port (USB-UART)
> - USB Type-C power port (5V)
> - 2x Gigabit Ethernet ports
> - Maskrom and User buttons
> - Aluminum alloy case
>
> [1] https://dl.radxa.com/e/e52c/radxa_e52c_product_brief.pdf
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> This patch depends on
>   https://patchwork.ozlabs.org/project/uboot/patch/20260107230747.3552391-2-jonas@kwiboo.se/
> ---
>   arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi | 24 +++++++
>   configs/radxa-e52c-rk3582_defconfig        | 77 ++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |  1 +

WARNING: no maintainers for 'radxa-e52c-rk3582'

Please fix this warning by CI system.


Thanks,

- Kever

