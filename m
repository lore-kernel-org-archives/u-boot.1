Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385C0C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 08:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B794831D8;
	Fri, 23 May 2025 10:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="g1195kAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34505830EB; Fri, 23 May 2025 10:42:33 +0200 (CEST)
Received: from mail-m49227.qiye.163.com (mail-m49227.qiye.163.com
 [45.254.49.227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E58831D8
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 10:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 162a05442;
 Fri, 23 May 2025 16:42:25 +0800 (GMT+08:00)
Message-ID: <30c1ee2e-be5f-4440-a98d-51ee1ec8e0d6@rock-chips.com>
Date: Fri, 23 May 2025 16:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: puma-rk3399: enable exFAT support
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250514-exfat-tsd-v1-0-83c10d714da3@cherry.de>
 <20250514-exfat-tsd-v1-4-83c10d714da3@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250514-exfat-tsd-v1-4-83c10d714da3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUhPVkMdHR5LGU4ZTBpNSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96fc4ecde403afkunmbd2cdae61cc41f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6KSo6PjE#URUBIxUSVi0Q
 CDIwFBJVSlVKTE9MQkNCTE9MTkxJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpNTUw3Bg++
DKIM-Signature: a=rsa-sha256;
 b=g1195kAr0SWTz52hva4TTXwq02Qlkk/IHafmLHUnyoftYBPhccEVorM7/9HXAj3BmCdTEt0nigYkNMHOhm1hUf/BmJ6EkLH4bUl6xDzVwWs7d/N4osAc+lSNHxtfblNLqMqf1Zr0Kscx7zO/RDGdps4Jpq+mO7Tjtd5+f6FgFyY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=iMMBtKigovnxs5hjTLOhZLLTG+zRIhx/Ywa9JYGeslw=;
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
>   configs/puma-rk3399_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 95ed6eea953d4564eaa2777b282d31cf5dd77c89..4e8cee06775aa020a14c656ce2f810f38354613b 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -104,4 +104,5 @@ CONFIG_USB_ETHER_ASIX88179=y
>   CONFIG_USB_ETHER_MCS7830=y
>   CONFIG_USB_ETHER_RTL8152=y
>   CONFIG_USB_ETHER_SMSC95XX=y
> +CONFIG_FS_EXFAT=y
>   CONFIG_ERRNO_STR=y
>
