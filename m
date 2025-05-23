Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92375C3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 08:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBECF831E1;
	Fri, 23 May 2025 10:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="d6vG1i/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703A98310F; Fri, 23 May 2025 10:42:18 +0200 (CEST)
Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com
 [220.197.31.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 403C9830EB
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 10:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 162a053cd;
 Fri, 23 May 2025 16:42:07 +0800 (GMT+08:00)
Message-ID: <4e7889e7-f919-4608-8d14-360a9c0d4811@rock-chips.com>
Date: Fri, 23 May 2025 16:41:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] configs: ringneck-px30: enable exFAT support
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250514-exfat-tsd-v1-0-83c10d714da3@cherry.de>
 <20250514-exfat-tsd-v1-1-83c10d714da3@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250514-exfat-tsd-v1-1-83c10d714da3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0odVktLHR5KGk0fTUJMSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96fc4e863203afkunm39b1dd661cc0ee
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mi46CRw4PzE#FBUDMxUsVjkL
 PTIKCSpVSlVKTE9MQkNCTElCSU1KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpMSk83Bg++
DKIM-Signature: a=rsa-sha256;
 b=d6vG1i/1I5e4JTkKAN0Rxwnk/3hmjybNlNBJm4tfroV+wp5oV/ALg9dNhqWAMh+ycmSgC3i/ZPwXJRXEHcnNIxn9B2uQqa/8oaNAk3pWyx/3DHfCz98URY9J/raV40HnD5dMvSBuRfYhY4XDIAgds7TLM2hiphGF6x0Rbkz5miQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=2ERyNglcTV/hlXLoLoW7Sv9LIXNQyiibJuQHdHB0xsM=;
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
>   configs/ringneck-px30_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index 5c651a18b0b52e81d3bd5cb98c850778e0db3426..a6562d03edc96557428d51e2f73609ed3d230895 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -110,6 +110,7 @@ CONFIG_DM_THERMAL=y
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_FS_EXFAT=y
>   CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_TPL_TINY_MEMSET=y
>   # CONFIG_RSA is not set
>
