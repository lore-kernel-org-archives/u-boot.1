Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C68E94139
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 02:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C315A8642A;
	Sat,  7 Oct 2023 04:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Eb2icqX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2289086459; Sat,  7 Oct 2023 04:31:18 +0200 (CEST)
Received: from mail-m92240.xmail.ntesmail.com (mail-m92240.xmail.ntesmail.com
 [103.126.92.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CAE186413
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 04:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Eb2icqX1bB2r3Vp336LNUMSoo6Ds/WLo+5Mgot/FzImWBMQhfqtYF2Kbt7HwevSQpfi8Ec744b8NNZ+LrvRyQJ/xm/xYKPNScCwvXeVqbFawt4ZPXoT2OwmsnJs4tBYfRSBaYSHupIRgrvJSa1PKOK42sEjVGROEV3h75xNj59U=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=6+QL1uHMIYV8hPRlHxLXrrabT3YcG3CD/Tthv5MWQU4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 4694A400254;
 Sat,  7 Oct 2023 10:31:11 +0800 (CST)
Message-ID: <f187966f-d43c-e9ff-12e0-311f7259497f@rock-chips.com>
Date: Sat, 7 Oct 2023 10:31:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] configs: rockchip: rock-pi-s: use default bootdelay (2s)
Content-Language: en-US
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: gajjar04akash@gmail.com
References: <20230911100508.122540-1-naoki@radxa.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230911100508.122540-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU8fSVZJHkxKQ0tLQ0IYHRhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b07f977152eb3kusn4694a400254
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nkk6Iio6KDw6EBkhLDEeKDwq
 Ek9PCkNVSlVKTUJNTU9OQ0xKQkhPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ0NCNwY+
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


On 2023/9/11 18:05, FUKAUMI Naoki wrote:
> align with other boards.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/rock-pi-s-rk3308_defconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index cc3274a98b..cd0a996ee7 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -24,7 +24,6 @@ CONFIG_DEBUG_UART=y
>   CONFIG_ANDROID_BOOT_IMAGE=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> -CONFIG_BOOTDELAY=0
>   CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x20000
