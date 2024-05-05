Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697C6C4345F
	for <u-boot@archiver.kernel.org>; Sun,  5 May 2024 02:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73DCB88158;
	Sun,  5 May 2024 04:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="VltPz95W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28A51881C1; Sun,  5 May 2024 04:58:49 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A495B88011
 for <u-boot@lists.denx.de>; Sun,  5 May 2024 04:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1714877926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9dSo1vMicqUW/HEDqu5TMMcjhe+x7sz3GVA1MVl1Tk=;
 b=VltPz95W4UdgmW8xiW0UGd79FgopMNew9i3LAPfBQvAP0hG6OXcd5Fbxlcn6YvkBVIW5+p
 SpNlGLgV+pLPPhV3dM56LlIqb1TCms2V+iUARjSVXBpA8Zm1uSFpaxYx2aGZZU2TqaYYtg
 UKeal1TNXx9HTTmOthImUvVBKPOcqfu+WodpOHt/95OC6xA/WV6zpytn3JaAXJ/X4N+OcQ
 5Y7F8EvqVjHDzKeCcbKNZN5IC5Bqs7gpCZXWqHeLseJqfwfeZLhAzDIW7mgXgJWZaN0mgg
 8tBa4ZzsWyGDXR9O41tSvy35mAs/qZnWjy7mz8fZZF1ALy7UmJLFdaH2dpQHxw==
Date: Sun, 05 May 2024 04:58:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 00/16] rockchip: Migrate RK3308, RK3328, RK356x and RK3588
 to OF_UPSTREAM
In-Reply-To: <20240504194346.2462489-1-jonas@kwiboo.se>
References: <20240504194346.2462489-1-jonas@kwiboo.se>
Message-ID: <dcf309cb12d8c8fce993138725ae04a5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Jonas,

On 2024-05-04 21:42, Jonas Karlman wrote:
> This series migrate RK3308, RK3328, RK356x and RK3588 boards that 
> exists
> in Linux kernel v6.8 to use OF_UPSTREAM.

I went quickly through all the patches in this series and they
in general look good to me.  I didn't check all of them in detail,
to make adding Reviewed-by tags appropriate, though.

> The usbdp phy driver is also updated to work with the DT binding that
> is targeted for v6.10.
> 
> And the usb3 related nodes currently part of the SoC u-boot.dtsi is
> updated to match the soc/board DT that is targeted for v6.10 in order 
> to
> avoid breaking changes in future when dts/upstream gets updated.
> 
> Following targets has not been migrated to use OF_UPSTREAM:
> - anbernic-rgxx3-rk3566: Multi device target
> - generic-rk3568: Generic target only meant for U-Boot use
> - generic-rk3588: Generic target only meant for U-Boot use
> - nanopi-m4-2gb-rk3399: DDR3 variant of nanopi-m4-rk3399 (LPDDR3)
> - pinetab2-rk3566: Merged in v6.9-rc1
> - toybrick-rk3588: Merged in v6.9-rc1
> 
> This series depends on the following series:
> - rockchip: rk3399: Fix loading FIT from SD-card when booting from eMMC 
> [1]
> - rockchip: rk3399: Sync DT with v6.8 and update defconfigs [2]
> 
> A copy of this series and its depends can also be found at [3].
> 
> [1] https://patchwork.ozlabs.org/cover/1929673/
> [2] https://patchwork.ozlabs.org/cover/1930271/
> [3] 
> https://github.com/Kwiboo/u-boot-rockchip/commits/rk3xxx-of-upstream-v1
> 
> Jonas Karlman (16):
>   rockchip: rk3308: Migrate to OF_UPSTREAM
>   rockchip: rk3308: Remove redundant device tree files
>   rockchip: rk3328: Migrate to OF_UPSTREAM
>   rockchip: rk3328: Remove redundant device tree files
>   rockchip: rk3399: Migrate to OF_UPSTREAM
>   rockchip: rk3399: Remove redundant device tree files
>   rockchip: rk356x: Add rk3568-u-boot.dtsi
>   rockchip: rk356x: Migrate to OF_UPSTREAM
>   rockchip: rk356x: Remove redundant device tree files
>   phy: rockchip: usbdp: Find phy-id from the io address
>   phy: rockchip: usbdp: Drop rockchip_u3phy_uboot_init()
>   phy: rockchip: usbdp: Adopt driver to work with upstream DT
>   rockchip: rk3588-rock-5b: Drop usb-typec node from u-boot.dtsi
>   rockchip: rk3588: Update USB3 related nodes in u-boot.dtsi
>   rockchip: rk3588: Migrate to OF_UPSTREAM
>   rockchip: rk3588: Remove redundant device tree files
