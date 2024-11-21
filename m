Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B86ED743CA
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 02:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27AB5895D2;
	Thu, 21 Nov 2024 03:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XPPgIpLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C638960B; Thu, 21 Nov 2024 03:05:36 +0100 (CET)
Received: from mail-m49233.qiye.163.com (mail-m49233.qiye.163.com
 [45.254.49.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D5288EEA
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 03:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 35e9a657;
 Thu, 21 Nov 2024 10:05:30 +0800 (GMT+08:00)
Message-ID: <ce3eb1b8-286f-4728-a7a3-c2df280147a1@rock-chips.com>
Date: Thu, 21 Nov 2024 10:05:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3399-rock-pi-4: Fix Synchronous Abort
To: Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241119001222.3795292-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241119001222.3795292-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRpOHlYeQk0fHR5JGB0eTB5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
 pVSktLVUpCS0tZBg++
X-HM-Tid: 0a934c77a69e03afkunm35e9a657
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORA6HBw5LDIiFkwUGSwOQj4W
 US5PCgJVSlVKTEhJSk5PTEhKSENPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSU1ONwY+
DKIM-Signature: a=rsa-sha256;
 b=XPPgIpLxrZlavxcYocHhqb5v1LzQBIhzBD0J71XWsTkKffw0fOZIZDQvwa/1QJFPvB629CrCmp5z6R5kwiuMrSvT+aSeJHnR2+Kwqka/jospZs1RLa0z+KGQsBam0MaUVc3XoDKVJpqjZJ5UG6tbXiXCwD7/c+VbSd4oL4OqCI8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=gKzp2uqRAcehyJqfP1G4vZoIIS07QtFBz9R7q0bmrTE=;
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


On 2024/11/19 08:12, Jonas Karlman wrote:
> After the commit 788cf33315c7 ("efi: add a helper to generate dynamic
> UUIDs") update_info.num_images must match number of valid update images.
>
> On Rock Pi 4 following Synchronous Abort can be observed due to fw_name
> being NULL:
>
>    Scanning global bootmeth 'efi_mgr':
>    "Synchronous Abort" handler, esr 0x96000010, far 0x0
>    elr: 0000000000200e28 lr : 000000000028adb8 (reloc)
>    elr: 00000000f3efbe28 lr : 00000000f3f85db8
>    x0 : 0000000000000000 x1 : ffffffffffffffff
>    x2 : 0000000000000000 x3 : 000000000000000e
>    x4 : 0000000000000000 x5 : 00000000f1ef0d78
>    x6 : 00000000f3fb3b90 x7 : 0000000000000044
>    x8 : 0000000000000010 x9 : 0000000000000031
>    x10: 00000000f0ea3fff x11: 00000000f1f29e00
>    x12: 0000000000000002 x13: fffffffffffff000
>    x14: 00000000f1f29e00 x15: 0000000000000018
>    x16: 00000000f3f44f7c x17: 0000000000000000
>    x18: 00000000f1ef2de0 x19: 00000000f0ea3040
>    x20: 00000000f3ff53d8 x21: 00000000f3fd0498
>    x22: 0000000000000000 x23: 00000000f1edb960
>    x24: 00000000f1edb95f x25: 00000000f1edb990
>    x26: 00000000f1edb964 x27: 00000000f1edb998
>    x28: 00000000f1edc1ec x29: 00000000f1edb820
>
>    Code: aa0003e2 d2800000 eb01001f 54000060 (78607843)
>    Resetting CPU ...
>
>    resetting ...
>
> Fix this by setting update_info.num_images to 0 when no valid update
> images is added to update_info.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/radxa/rockpi4-rk3399/rockpi4-rk3399.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> index fd827467b30a..856b434df36d 100644
> --- a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> +++ b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> @@ -52,6 +52,8 @@ void rockchip_capsule_update_board_setup(void)
>   
>   		fw_images[0].fw_name = u"ROCKPI4C-IDBLOADER";
>   		fw_images[1].fw_name = u"ROCKPI4C-UBOOT";
> +	} else {
> +		update_info.num_images = 0;
>   	}
>   }
>   #endif /* CONFIG_EFI_HAVE_CAPSULE_SUPPORT && CONFIG_EFI_PARTITION */
