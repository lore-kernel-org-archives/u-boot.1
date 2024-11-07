Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3B8D5AE4C
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 03:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE7289048;
	Thu,  7 Nov 2024 04:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XjvXKoDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F83D891BC; Thu,  7 Nov 2024 04:35:53 +0100 (CET)
Received: from mail-m2410.xmail.ntesmail.com (mail-m2410.xmail.ntesmail.com
 [45.195.24.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 063DC88EE4
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 04:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 20984e1c;
 Thu, 7 Nov 2024 11:35:44 +0800 (GMT+08:00)
Message-ID: <e46008d2-19ae-4f48-a223-6d73e528b39a@rock-chips.com>
Date: Thu, 7 Nov 2024 11:35:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next RFC 0/5] rockchip: panic() when DRAM init fails
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkIZGFYYT0wfHUNMThpMHhhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9304b13dca03afkunm20984e1c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6Dww*FjIdTzcpThwBSC0R
 Ii5PCj1VSlVKTEhLQk5LTk9NS0NIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSElMNwY+
DKIM-Signature: a=rsa-sha256;
 b=XjvXKoDU31xStXIFLe1ZYLDuYk69O5ntX1lSiyXAkS37ZuI2ZZeSOipn27yCgX/UCYKZB8KhmfoI/6YWuWhdge2+6SLSktMp/gc5qITm3QW410uD52xVi1z4fmj9IyYz3RmXXSGs2Rvk95IUaXogoM+EKtyu67BI3Emro0tgYB0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=syp/kBry+ZJ716p6aWDE+t0I46Sb4T5YlPB/JUtwM9c=;
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

Hi Quentin,

On 2024/11/6 01:21, Quentin Schulz wrote:
> I am the unfortunate owner of an RK3399 Puma that is failing DRAM init
> every now and then with the following cryptic error message:
> """
> pctl_start: Failed to init pctl channel 0
> """
>
> When it fails, the current logic is implemented in such a way that the
> board enters an infinite while loop. This is not ideal for embedded
> systems that are not easily accessible and also an issue when having
> devices in a CI lab for example.

It's fine for this patch to make the choice in panic to hang or to reset 
the system.

But I don't understand how this help you, does it may success to init 
the dram after

the reset in your case? I think in most case the board will keep reset 
because this is

more likely hardware issue and not able to became success after reset.


Thanks,

- Kever

>
> Therefore, let's simply panic if the DRAM fails to init. This was tested
> only on RK3399 Puma, similar changes may be required for other SoCs to
> properly propagate the errors.
>
> While this is all but a work-around instead of fixing the DRAM init
> sequence, I believe it is important for resilience of devices in the
> field.
>
> Marking this as RFC because:
> 1) panic()s for all Rockchip SoCs but only tested on RK3399
> 2) unsure about error return values (ENODEV and the likes), not sure
>     what would be better than that though :/
>
> Note that one can still hang() if they want by setting PANIC_HANG
> symbol.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (5):
>        ram: rk3399: allow to fail DRAM init if pctl_start fails
>        ram: rk3399: fail probe if DRAM init failed
>        rockchip: spl/tpl: panic when DRAM init failed
>        ram: rk3399: merge two consecutive ifs with same condition
>        ram: rk3399: fail DRAM init when pctl channel init fails instead of hanging
>
>   arch/arm/mach-rockchip/spl.c        |  7 +++----
>   arch/arm/mach-rockchip/tpl.c        |  6 ++----
>   drivers/ram/rockchip/sdram_rk3399.c | 24 +++++++++++-------------
>   3 files changed, 16 insertions(+), 21 deletions(-)
> ---
> base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
> change-id: 20241105-rk3399-dram-init-207325c2d9ca
>
> Best regards,
