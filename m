Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B113C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 691E88322F;
	Tue,  8 Apr 2025 05:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MWZdLbkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90BEA83156; Tue,  8 Apr 2025 05:19:14 +0200 (CEST)
Received: from mail-m1973174.qiye.163.com (mail-m1973174.qiye.163.com
 [220.197.31.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF7B8312E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101e89a2;
 Tue, 8 Apr 2025 11:19:06 +0800 (GMT+08:00)
Message-ID: <91b7dd71-5d37-4c95-85d9-1d50b22b1d43@rock-chips.com>
Date: Tue, 8 Apr 2025 11:19:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] rockchip: Remove partitions env variable for RK3588
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250406002447.1555596-1-jonas@kwiboo.se>
 <20250406002447.1555596-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250406002447.1555596-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGksZSlZDQk4ZTE8aGUtLThhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961368a21d03afkunm1101e89a2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6ITo5KTJWSEICLykwHk0K
 FkgaFCNVSlVKTE9PS0NJSE9MSE1CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ0hJNwY+
DKIM-Signature: a=rsa-sha256;
 b=MWZdLbkTJbbYyEvl484WrMKUMS7Az57qPjmS2nV7Fqz8b8uQYdrW6Fo0ooo8JnNAYSq9B5H+WA/T2L3JGZvaIay41IEBlqHI+5UBmlE9y/OVmiopjdBAjyBN/bPh1ejtnO08la9UTTyDAlETver4dw7dJ8Zvt7XJmIk4PPv23A8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=WUdKBWgQHVd8NM3ip0OrAr7C4AfA4RNOdZDPeuWpqY8=;
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


On 2025/4/6 08:24, Jonas Karlman wrote:
> The partitions env variable is using an outdated partition layout that
> is typically expected to be used with older vendor miniloader blobs.
>
> Rockchip devices will run fine using any partition layout if the first
> 16 MiB of MMC storage is ignored/skipped.
>
> Remove the partitions env variable to stop encourage users a continued
> use of this outdated partition layout on RK3588 devices.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/configs/rk3588_common.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
> index e6654c275ac5..7b02560971ad 100644
> --- a/include/configs/rk3588_common.h
> +++ b/include/configs/rk3588_common.h
> @@ -28,7 +28,6 @@
>   
>   #define CFG_EXTRA_ENV_SETTINGS		\
>   	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
> -	"partitions=" PARTS_DEFAULT	\
>   	ENV_MEM_LAYOUT_SETTINGS		\
>   	ROCKCHIP_DEVICE_SETTINGS	\
>   	"boot_targets=" BOOT_TARGETS "\0"
