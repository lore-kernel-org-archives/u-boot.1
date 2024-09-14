Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A09EC0218C
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 10:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E6C888CE2;
	Sat, 14 Sep 2024 12:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LPq/AE6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED3788D10; Sat, 14 Sep 2024 12:00:59 +0200 (CEST)
Received: from mail-m17234.xmail.ntesmail.com (mail-m17234.xmail.ntesmail.com
 [45.195.17.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA28889E2
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 12:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LPq/AE6bUujZp4ZBd4vL8V3mWYB53yRtaQa/hUKX9jIkUL2+siO4131a9A9FZSmRst8MjR0ccw87ocL9/n2vGv6PkVR2IsdvlkPWa1Tq3jmi120GdOy3jkhZe9AC/xDQda1j96zvBnQKD950FeIDmd5Tj2icwNomHb1Ky/66gzM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=9UWApNnFEkrtoDaDx5ODXyzYuJSFk2vA1Bc8zGX8Xe4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A97759008B1;
 Sat, 14 Sep 2024 18:00:43 +0800 (CST)
Message-ID: <5deea5f5-de08-473b-9f80-170c8126ba30@rock-chips.com>
Date: Sat, 14 Sep 2024 18:00:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/12] Bind Syscon driver with OF_REAL
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20240806043849.3607-1-linux.amoon@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240806043849.3607-1-linux.amoon@gmail.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxkdH1YZTB4dTBhDHUhKTU9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91effa4cd203a3kunma97759008b1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Chw5CzI1ShMNCzwcTyw4
 LBRPFApVSlVKTElNSEtDS09PT0hKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNS0lONwY+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Anand,

On 2024/8/6 12:38, Anand Moon wrote:
> Bind syscon driver with dm_scan_fdt_dev
> As OF_PLATDATA is no longer enabled, the related
> code is removed.

The OF_PLATDATA is no removed, basically it's use in TPL/SPL for code size,

and the SPL_OF_PLATDATA and TPL_PLATDAT still available,

The OF_REAL is only to replace "OF_CONTROL && !OF_PLATDATA."

Thanks,
- Kever
>
> Compiled and tested on RK3399 and RV1126 board.
>
> Thanks
> -Anand
>
> Anand Moon (12):
>    arm: rockchip: rk3399: Remove unused syscon drivers code
>    arch: rockchip: rv1126: Update syscon driver binding method
>    arm: rockchip: rv1126: Remove unused syscon drivers code
>    arm: rockchip: px30: Remove unused syscon drivers code
>    arch: rockchip: rk3066: Update syscon driver binding method
>    arm: rockchip: rk3066: Remove unused syscon drivers code
>    arch: rockchip: rk3368: Update syscon driver binding method
>    arm: rockchip: rk3368: Remove unused syscon drivers code
>    arch: rockchip: rk3188: Update syscon driver binding method
>    arm: rockchip: rk3188: Remove unused syscon drivers code
>    arch: rockchip: rk3288: Update syscon driver binding method
>    arm: rockchip: rk3288: Remove unused syscon drivers code
>
>   arch/arm/mach-rockchip/px30/syscon_px30.c     |  31 ----
>   arch/arm/mach-rockchip/rk3066/syscon_rk3066.c |  34 +---
>   arch/arm/mach-rockchip/rk3188/syscon_rk3188.c |  34 +---
>   arch/arm/mach-rockchip/rk3288/syscon_rk3288.c | 157 +-----------------
>   arch/arm/mach-rockchip/rk3368/syscon_rk3368.c |  41 +----
>   arch/arm/mach-rockchip/rk3399/syscon_rk3399.c |  45 -----
>   arch/arm/mach-rockchip/rv1126/syscon_rv1126.c |  27 +--
>   7 files changed, 14 insertions(+), 355 deletions(-)
>
>
> base-commit: 6becf9ba1ab82af6f4fcf9f4d0da38f9c75212d2
