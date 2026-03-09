Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A5CEA854A
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 03:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D3783F1F;
	Mon,  9 Mar 2026 04:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Hszmd24j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C42883F1F; Mon,  9 Mar 2026 04:02:53 +0100 (CET)
Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com
 [220.197.31.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7D9583EEF
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 04:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36304abc3;
 Mon, 9 Mar 2026 11:02:46 +0800 (GMT+08:00)
Message-ID: <7bdae134-c61d-4fca-9e5f-65bb70437348@rock-chips.com>
Date: Mon, 9 Mar 2026 11:02:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2 01/12] rockchip: board: qnap-ts433: Fix TPL binary in
 build-example
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Daniel Bast <2790401+dbast@users.noreply.github.com>
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-2-heiko@sntech.de>
Content-Language: en-US
In-Reply-To: <20260114082822.4007128-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd08c12ea03afkunm1a416669162bf2c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTh8YVh0fGklLSU4eSxhDTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=Hszmd24jrqgQppmzef3wTL87VrzP5hY1wDEF4++gK0af/R2Jl2Q38hMybRHvueN1U0VL85MYiBE/v4U5oNbFRyzFnaJ/KkUzgK7FVc+51q9KEUz5dROl2NSAsGgQxuvoKApUrcASgY+K+V8vah1LgjPo5DPyboRPTF7BVmUlFEM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=B2QsNLk/1/1QqdtLdMWHhFOdihW2MzpvW8uZFckxgMM=;
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


On 2026/1/14 16:28, Heiko Stuebner wrote:
> In the example on how to modify the serial-console in the TPL binary
> we already use the v1.21 of the 1560MHz DDR-init binary.
>
> Yet in the build-example the TPL link goes to v1.13 of the 1056MHz
> DDR-init.
>
> Not only will that setup reduce performance but it also will prevent
> actual serial output from the DDR init, because someone following the
> examples will have modified a different binary.
>
> I've been running the 1560MHz DDR-speed in all my tests on now 3
> different devices and never saw any issues with it, so adapt the
> build-example to link to the faster binary.
>
> Suggested-by: Daniel Bast <2790401+dbast@users.noreply.github.com>
> Fixes: d3cacb79e706 ("board: rockchip: add support for Qnap TS433 devices")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   doc/board/qnap/ts433.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
> index 1e1bfbb9190..5e5f0394ada 100644
> --- a/doc/board/qnap/ts433.rst
> +++ b/doc/board/qnap/ts433.rst
> @@ -46,7 +46,7 @@ Building U-Boot
>   
>       $ export CROSS_COMPILE=aarch64-linux-gnu-
>       $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.34.elf
> -    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1056MHz_v1.13.bin
> +    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin
>       $ make qnap-ts433-rk3568_defconfig
>       $ make
>   
