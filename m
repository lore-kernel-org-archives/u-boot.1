Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F71FCCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 07:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB6983B1A;
	Sat,  1 Nov 2025 08:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DD5I9ozE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1B5283B27; Sat,  1 Nov 2025 08:57:35 +0100 (CET)
Received: from mail-m49225.qiye.163.com (mail-m49225.qiye.163.com
 [45.254.49.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 724FD83B0A
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 08:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 27ff79887;
 Sat, 1 Nov 2025 15:57:29 +0800 (GMT+08:00)
Message-ID: <3dce43f8-bb2d-4c56-b543-7b576c9c31b4@rock-chips.com>
Date: Sat, 1 Nov 2025 15:57:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] board: theobroma-systems: jaguar_rk3588: explicit
 UART IOMUX
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger <klaus.goger@cherry.de>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250730-tsd-readme-update-v1-0-5a96672d2211@cherry.de>
 <20250730-tsd-readme-update-v1-3-5a96672d2211@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250730-tsd-readme-update-v1-3-5a96672d2211@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a3e6be4a303afkunmdb2e58cc9251ac
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTRofVkxDHUhNSxhKSkkYGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=DD5I9ozEDZuE1UrRk15gm0VgpGgYVq6l4dLteFJJ2O8VJV3WJkHTrGQ46X5VkX3ej5HuFV2CzB3ibE6qHuVGG0Ey/9PU3M3xIntXEVioAdJNCLF2EC2fhV1JElcE8i7t6eyQma/flBZACh7ol4QAuC0tZp507nhY0GYTQf052aI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=q/gkmaxXlqmCPjjOE65ykCMIh8ICfJoUYgrXgc7gk3c=;
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


On 2025/7/30 20:46, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> When one attempts to build Tiger and Jaguar from the same directory,
> because Tiger will set the IOMUX to 2 but Jaguar doesn't reset it,
> Jaguar will have IOMUX set to 2 if built after Tiger.
>
> This isn't an issue if in separate directories or building Tiger after
> Jaguar because the default if missing from the configuration file is 0.
>
> Let's make it explicit that the iomux is 0 for Jaguar.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   doc/board/theobroma-systems/jaguar_rk3588.rst | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/doc/board/theobroma-systems/jaguar_rk3588.rst b/doc/board/theobroma-systems/jaguar_rk3588.rst
> index eff0ee7347c7d0e810d9dba542ce3aaf28ef359d..d09cfaa88ff81b679421dc941984d47f3b3a2f67 100644
> --- a/doc/board/theobroma-systems/jaguar_rk3588.rst
> +++ b/doc/board/theobroma-systems/jaguar_rk3588.rst
> @@ -41,6 +41,7 @@ Get DDR init (TPL) binary
>      cd rkbin
>      export ROCKCHIP_TPL=$(readlink -f bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin | head -1)
>      sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
> +   sed -i 's/^uart iomux=.*$/uart iomux=0/' tools/ddrbin_param.txt
>      python3 ./tools/ddrbin_tool.py rk3588 tools/ddrbin_param.txt "$ROCKCHIP_TPL"
>      ./tools/boot_merger RKBOOT/RK3588MINIALL.ini
>      export RKDB=$(readlink -f rk3588_spl_loader_v*.bin | head -1)
>
