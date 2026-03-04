Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF817EDEC16
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 06:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35529839A8;
	Wed,  4 Mar 2026 07:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bYWOUuBf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA0183D8A; Wed,  4 Mar 2026 07:58:07 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C08AA838BB
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 07:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinguyen@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AB7D960097;
 Wed,  4 Mar 2026 06:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FE8C19423;
 Wed,  4 Mar 2026 06:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772607482;
 bh=IOqwr6MNxR3cdUwktbD+9o/8qEcV8Vhergjv1YvZc6o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bYWOUuBfdfxq8BzXPB16cmSt3+Nj+HkX8ujnN4HE1f7zIXiXPZALAyctan5kfoSdz
 AXATan/oo2DwB28hJl7sNQi9NIoYcUE5u8iWxwGz8vT+seQOXCMFU1dmIBrLbJd921
 e/bK0J0+R5N6lwtHYfhEVGc24dGiOmJ1hZA9QycxX6BhiAwJk62GYFEy90wuwxPwVs
 1QSPgGwK7R+aXQ+zo2APQ4/O5E46U81exNvb6YgvqkQ3s2Hup/FZ9GxM3qbQlJ6di0
 EKYQ8WNSZ7+JfX5uzAUGh2bZch5QHAsxdpNkQleMsgYbqxJd9hEPCkEBxtGulOOUIE
 8qK0eNIUGvKzQ==
Message-ID: <d1f767bb-85ad-4b63-b695-161b12cfcc0b@kernel.org>
Date: Wed, 4 Mar 2026 00:58:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: socfpga: arria10: Disable CONFIG_USE_TINY_PRINTF
Content-Language: en-US
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Chin-Liang See <clsee@altera.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>, Ley Foon Tan <ley.foon.tan@intel.com>
References: <20260304035307.16125-1-dinesh.maniyam@altera.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260304035307.16125-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 3/3/26 21:53, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> CONFIG_USE_TINY_PRINTF is enabled by default, disable it.
> Arria 10 has 256KB of onchip ram and it is enough to support full printf.
> Full printf allows us to have more complex format printing, example %ll.

Do you have a size diff for the SPL with this change?
> 
> Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>

Is the above contact valid? Also, try to just include contacts returned 
from get_maintainer.


> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/Kconfig     | 1 -
>   configs/socfpga_arria10_defconfig | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index f2e959b5662..ba01ec08be2 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -101,7 +101,6 @@ config TARGET_SOCFPGA_ARRIA10
>   	select SPL_SYSCON if SPL
>   	select ETH_DESIGNWARE_SOCFPGA
>   	imply FPGA_SOCFPGA
> -	imply SPL_USE_TINY_PRINTF
>   
>   config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>   	bool "Always reprogram Arria 10 FPGA"
> diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
> index b32f40ae408..d5feabe5ce0 100644
> --- a/configs/socfpga_arria10_defconfig
> +++ b/configs/socfpga_arria10_defconfig
> @@ -69,3 +69,4 @@ CONFIG_USB=y
>   CONFIG_USB_DWC2=y
>   # CONFIG_SPL_WDT is not set
>   # CONFIG_TOOLS_MKEFICAPSULE is not set
> +# CONFIG_USE_TINY_PRINTF is not set

This does not disable CONFIG_SPL_USE_TINY_PRINTF, you need to add this:

# CONFIG_SPL_USE_TINY_PRINTF is not set

Dinh

