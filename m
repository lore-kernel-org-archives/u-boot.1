Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27182C3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 08:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 734EB8310F;
	Fri, 23 May 2025 10:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="D1SlpGiT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2CB831D7; Fri, 23 May 2025 10:42:18 +0200 (CEST)
Received: from mail-m19731119.qiye.163.com (mail-m19731119.qiye.163.com
 [220.197.31.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E2678310F
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 10:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 162a053e3;
 Fri, 23 May 2025 16:42:09 +0800 (GMT+08:00)
Message-ID: <58ff545d-f646-4414-9d9b-c560c695121a@rock-chips.com>
Date: Fri, 23 May 2025 16:42:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] configs: jaguar-rk3588: enable exFAT support
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250514-exfat-tsd-v1-0-83c10d714da3@cherry.de>
 <20250514-exfat-tsd-v1-2-83c10d714da3@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250514-exfat-tsd-v1-2-83c10d714da3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGk4eVkxIQkNCQhhJQx5MSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96fc4e913003afkunm39b1dd661cc159
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kz46Qhw6CzE1DBUSFRBNVj5W
 DgEKChxVSlVKTE9MQkNCTEhJSUlIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpNTU83Bg++
DKIM-Signature: a=rsa-sha256;
 b=D1SlpGiT6l48No3mIVQVHfHQAB1UltRQwQJDAdBI5PbRTc8Q+/JSqwiwCKCWvAhckIHRrXUl2R+c4gGdDREjIpsDfXtLGa/BXOwHBAqqPSONxsRR/bj4RQAn1wjEB22gldJg6003fXtD7yVq8o5tL9Zadej8avB1A954sYG8aks=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=LfUJNi+syUtOkwSb5rdt/TajbG/I+jgo0TmD5OkskLo=;
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


On 2025/5/15 00:18, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Our upcoming Mass Flasher solution will be storing boot artifacts on an
> exFAT partition so enable its support.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/jaguar-rk3588_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
> index 35f34ebf07134f2dc1f3690d31c202979ec77aa2..03d38274b15f78929c025154be0b7f1268574cfe 100644
> --- a/configs/jaguar-rk3588_defconfig
> +++ b/configs/jaguar-rk3588_defconfig
> @@ -108,4 +108,5 @@ CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_FS_EXFAT=y
>   CONFIG_ERRNO_STR=y
>
