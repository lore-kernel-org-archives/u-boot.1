Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF04E7719A
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 00:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE6E800C2;
	Fri, 10 Jan 2025 01:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EXxw373p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A21A80196; Fri, 10 Jan 2025 01:40:45 +0100 (CET)
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com
 [45.254.49.228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A622F8001F
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 01:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 84493da9;
 Fri, 10 Jan 2025 08:40:36 +0800 (GMT+08:00)
Message-ID: <b93e650c-f6f2-4a9a-ba2d-f155b9cda69a@rock-chips.com>
Date: Fri, 10 Jan 2025 08:40:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-nanopc-t6-lts: Add missing board
 -u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Ricardo Pardini <ricardo@pardini.net>, u-boot@lists.denx.de
References: <20250106182232.3741304-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250106182232.3741304-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMeHVYaGE9NGUkdQkNJGRpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
 pVSktLVUpCS0tZBg++
X-HM-Tid: 0a944da7e66003afkunm84493da9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MS46EQw4EzIUDwkBIhI4MQks
 Sj8aCzlVSlVKTEhNT01CTUhMTElJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSk5PNwY+
DKIM-Signature: a=rsa-sha256;
 b=EXxw373p0+v/Atgndgyx8uRa3vvWhbCvsAWC0f29hqptGhY3596IPk/jqD364/Yng4DuJgkVIWtcK3lEDawJZuM7ZIe+soIjp8yAm7kK88ewWtXeaXaD+Occ0EGLri9JZHs9SsoZuPqK5QgHwUeHWWxbcsi6lV919vLou1kYxtI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=DStl0elXeIqQ/MUHUVsOVXYBb34rsQQXkGntH25YDyk=;
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


On 2025/1/7 02:22, Jonas Karlman wrote:
> The commit 7cec3e701940 ("rockchip: rk3588-nanopc-t6: Add support for
> NanoPC-T6 LTS") added support for the LTS variant of NanoPC T6. However,
> a board specific -u-boot.dtsi file was never added.
>
> Due to the missing -u-boot.dtsi file the LTS fdt included in the FIT is
> never tagged with bootph props.
>
> When ENV_IS_IN_SPI_FLASH is enabled, not enabled in defconfig, the env
> can successfully load from SPI flash on the non-LTS variant, something
> that does not work on the LTS variant due to missing bootph-some-ram
> props in the LTS fdt.
>
> Fix this by adding a LTS -u-boot.dtsi file that just include the non-LTS
> -u-boot.dtsi file.
>
> Reported-by: Ricardo Pardini <ricardo@pardini.net>
> Fixes: 7cec3e701940 ("rockchip: rk3588-nanopc-t6: Add support for NanoPC-T6 LTS")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi   | 3 +++
>   board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS | 3 +--
>   2 files changed, 4 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi
>
> diff --git a/arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi
> new file mode 100644
> index 000000000000..b18f958c8a28
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-nanopc-t6-u-boot.dtsi"
> diff --git a/board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS b/board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS
> index 63ff6fafc8d7..27853188e59e 100644
> --- a/board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS
> +++ b/board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS
> @@ -5,5 +5,4 @@ S:	Maintained
>   F:	board/friendlyelec/nanopc-t6-rk3588
>   F:	include/configs/nanopc-t6-rk3588.h
>   F:	configs/nanopc-t6-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-nanopc-t6.dts
> -F:	arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-nanopc-t6*
