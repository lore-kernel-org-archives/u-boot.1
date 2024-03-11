Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB14C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 10:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7410387F5A;
	Mon, 11 Mar 2024 11:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="C4ypz9/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38FA87F6B; Mon, 11 Mar 2024 11:12:25 +0100 (CET)
Received: from mail-m6027.netease.com (mail-m6027.netease.com [210.79.60.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C7387F3D
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=C4ypz9/PRqEhBfsrq1NGxdkEYDi96qQm6EBsHlDBeAWp/phHVq3LnaVJBiQgCoycWKWBUJ2M+54jKziPjbGqUeJ8Yrz4174D0wAIo7vkm3UkcdNCAU3VQfnh5RN9EBMiupBGKzYU/JL3pkrxnKp2Ro08BmXi3unabZfrrswwrdg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=jB5uumTu2QSkD6QCMCS6Z7qbg2U2ceRJnO0GmOe9TVs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 54B82900127;
 Mon, 11 Mar 2024 18:12:12 +0800 (CST)
Message-ID: <a0da09c6-e47b-484b-9f05-cb9aa6df1606@rock-chips.com>
Date: Mon, 11 Mar 2024 18:12:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/16] pmic: reword help text
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-6-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-6-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01LQ1ZOSh5JHxhIQhlMHx9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e2cff9dc903a9kunm54b82900127
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAg6TSo*CzMPKDABSUoMNAgs
 Ok4aCSxVSlVKTEpLSk5KQkhIQ09LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQk5CNwY+
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


On 2024/3/4 19:30, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Reword the help text for the pmic read and pmic write commands to better
> match what's expected from the user.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   cmd/pmic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/pmic.c b/cmd/pmic.c
> index 49a405fa297..c9e9730adf9 100644
> --- a/cmd/pmic.c
> +++ b/cmd/pmic.c
> @@ -225,6 +225,6 @@ U_BOOT_CMD(pmic, CONFIG_SYS_MAXARGS, 1, do_pmic,
>   	"list          - list pmic devices\n"
>   	"pmic dev [name]    - show or [set] operating PMIC device\n"
>   	"pmic dump          - dump registers\n"
> -	"pmic read address  - read byte of register at address\n"
> -	"pmic write address - write byte to register at address\n"
> +	"pmic read <reg>    - read byte of 'reg' register\n"
> +	"pmic write <reg> <byte> - write 'byte' byte to 'reg' register\n"
>   );
>
