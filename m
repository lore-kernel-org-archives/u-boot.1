Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCCBCD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 17:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141D283FEC;
	Sat, 13 Jun 2026 19:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="l6LClQJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D268466E; Sat, 13 Jun 2026 19:47:44 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A33D801A9
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 19:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8eb6=EK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1781372861;
 bh=QX9zZAf5Gl/UoVjrpjXfAh6/sLnSAE7mOQnpzOXmoDI=;
 b=l6LClQJFVQC/S47YpVrXaM7Q8K+no9MujfvaGw+KOBcUsx1f2iZ76owTi8sJ8w5YgRwMgyDAv
 RE0zjJ6E5un5pbIGZVWknt+/2FOxwiAdwyALwme93KFkIkp5b2Ev5UHBlDFnfnYEfsSW80Afc9l
 CHOI5U42fWHN/2dx0jqZE+kNyx2fS5rgXKgcn3SURDui1X7UyIoRsjUyAEpjtcsWkgKG+8SXeyQ
 j9U5xzbP/NL7yQvgaQKGzAbaOkn96mY52bOUAsdI/fvVHaJILxENuZSJts8j83Ny9c52qCGALRY
 mO14551NR5qM+sqVDiNe1mi4lysnbXT6rBDXSbDlvAfg==
X-Forward-Email-ID: 6a2d97baf2d49c73df64480f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c03d8f52-a262-4212-81ed-727342c7b046@kwiboo.se>
Date: Sat, 13 Jun 2026 19:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Add the Rockchip architecture as requiring DMA below
 4G
To: Heiko Stuebner <heiko@sntech.de>, trini@konsulko.com
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, kever.yang@rock-chips.com
References: <20260613172444.4023442-1-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260613172444.4023442-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 6/13/2026 7:24 PM, Heiko Stuebner wrote:
> Loading EFI parts like a Debian-Installer on Rockchip SoCs creates
> interesting results, in that on some boards the Grub bootloader can't
> find any partitions on a USB-Stick, or loading a kernel from Grub spews
>     EHCI fail timeout STS_IAA set
> messages before failing and on others the loading something like efivars
> from an eMMC creates read errors and making the MMC vanish from U-Boot.
> 
> This only affected boards with at least 4GB of RAM.
> 
> These boards have at least 256MB of memory placed above the actual 4GB
> address space (due to the iomem being in between) and while kernel,
> initramfs, dt are generally loaded to predefined addresses, additional
> EFI parts (efivars, etc) are likely just loaded "somewhere" and it seems
> this always landed in that higher up memory part.
> 
> Also in the Linux-kernel peripherals like EMMC, USB, etc already run
> with a 32bit dma-mask set.
> 
> So far, I've seen this on RK3568 and RK3588, but as the same peripherals
> are used on most Rockchip SoCs, it makes sense to limit this on all.
> 
> So add ARCH_ROCKCHIP to the default-y list of LMB_LIMIT_DMA_BELOW_RAM_TOP.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

I have also faced above 4GB of RAM issue on Rockchip boards, so this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  lib/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index cf13ac1bdad..9e0f0ad7d06 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1298,7 +1298,7 @@ config SPL_LMB_ARCH_MEM_MAP
>  config LMB_LIMIT_DMA_BELOW_RAM_TOP
>  	bool
>  	depends on LMB
> -	default y if ARCH_BCM283X
> +	default y if ARCH_BCM283X || ARCH_ROCKCHIP
>  	help
>  	  Some architectures can not DMA above ram_top boundary,
>  	  which is after 4 GiB or 32-bit boundary too. Limit the

