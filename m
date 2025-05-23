Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27DCC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 08:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F26E83145;
	Fri, 23 May 2025 10:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Pdbj5s7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8308783208; Fri, 23 May 2025 10:42:23 +0200 (CEST)
Received: from mail-m15589.qiye.163.com (mail-m15589.qiye.163.com
 [101.71.155.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03043831FE
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 10:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 162a05401;
 Fri, 23 May 2025 16:42:15 +0800 (GMT+08:00)
Message-ID: <9bed1025-19b5-4162-aa1a-3d420cbe7ef8@rock-chips.com>
Date: Fri, 23 May 2025 16:42:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: tiger-rk3588: enable exFAT support
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250514-exfat-tsd-v1-0-83c10d714da3@cherry.de>
 <20250514-exfat-tsd-v1-3-83c10d714da3@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250514-exfat-tsd-v1-3-83c10d714da3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGktKVh1PT0xOHh0aSUsYT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96fc4ea8f403afkunm39b1dd661cc234
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46EAw4NTE9SRU1FRUsVj0C
 AzIaCSlVSlVKTE9MQkNCTEhMQ0pKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpNTk83Bg++
DKIM-Signature: a=rsa-sha256;
 b=Pdbj5s7O1/oWLsGiGHCJIAAdFfOoZrXp4FMaBE50F/XQOw16n6VblWQ5xBskIUzF09I/JL69Ee8ucaDRgfAmStK0K+mudBPhAnxP7YwBAsJ9CDn1JbFMWbkldWS5Q7JTPi9Mvm37MiPy5xWXfQBKgB9/0EQVT/Pkipr6HM8n2pg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=pcLWrA+xvbaOSwmSlyet0enz4aGAywOAFxNMm3J9Vlo=;
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
>   configs/tiger-rk3588_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
> index b3726b6b511ed035a4f8acd03bbe7d4d9e3ca724..c14bd9774e96fa2c2494d10a875d36365533863a 100644
> --- a/configs/tiger-rk3588_defconfig
> +++ b/configs/tiger-rk3588_defconfig
> @@ -113,4 +113,5 @@ CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_FS_EXFAT=y
>   CONFIG_ERRNO_STR=y
>
