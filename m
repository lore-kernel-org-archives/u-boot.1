Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79ED7C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1357082CE7;
	Tue,  8 Apr 2025 05:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iySDdwCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CD982CFA; Tue,  8 Apr 2025 05:19:09 +0200 (CEST)
Received: from mail-m8272.xmail.ntesmail.com (mail-m8272.xmail.ntesmail.com
 [156.224.82.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8850382CEB
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101e897b;
 Tue, 8 Apr 2025 11:19:00 +0800 (GMT+08:00)
Message-ID: <cc536f72-c95e-42ae-8d48-bf9dabbf3a80@rock-chips.com>
Date: Tue, 8 Apr 2025 11:18:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] rockchip: Remove partitions env variable for RK356x
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250406002447.1555596-1-jonas@kwiboo.se>
 <20250406002447.1555596-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250406002447.1555596-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlDH1YdHkkdGRkZSU9OTUxWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961368890603afkunm1101e897b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxA6MBw6TTJJVkIuASkuHk5I
 LwwaCi9VSlVKTE9PS0NJSE9KSEpNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ0hJNwY+
DKIM-Signature: a=rsa-sha256;
 b=iySDdwCwWIBwsQS1AmNgBbUyJAg6UNLGjuddPg/zBQp/5115Mu5Dfcon9CvuyzBjPl+UXpC40Ut+2KIpaBHZUkJ4eVSnh/Ygq0YBGfMcsM6vWJIH4U9eR3YBhlC+gwL9aNYiWwNPe6IrfqhePDRAL+hx7UYcjMbvtbwZk8LUP/w=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=s4jWZz8e8q6VZ9rcpDR1Ev6nlTzDUXEBQjRlwykXW7M=;
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
> use of this outdated partition layout on RK356x devices.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/configs/rk3568_common.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
> index 09b7b71c6afd..a68ca381db57 100644
> --- a/include/configs/rk3568_common.h
> +++ b/include/configs/rk3568_common.h
> @@ -29,7 +29,6 @@
>   
>   #define CFG_EXTRA_ENV_SETTINGS		\
>   	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
> -	"partitions=" PARTS_DEFAULT	\
>   	ENV_MEM_LAYOUT_SETTINGS		\
>   	ROCKCHIP_DEVICE_SETTINGS	\
>   	"boot_targets=" BOOT_TARGETS "\0"
