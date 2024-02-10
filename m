Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0451AC48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 16:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D56E87E95;
	Sat, 10 Feb 2024 17:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="rsmNWl83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D275887E5F; Sat, 10 Feb 2024 17:37:49 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42985879F3
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 17:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707583066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XgH32FZ8WVEpIjrTYUmMo1Js4YlYbKMjoamcRJOKz0=;
 b=rsmNWl83VeMqu+aZmDQl499eb3j6WH/0SrTbQi14G6WoXyXGMyDUX36GxxpdbkpBUIgIGR
 XkuwoJYI24KvE/mXvrmlFm+1dJDHFBv73USf+C1bQ4yN85Vt6Vj7w7SHsKWr79J4dK69VS
 rSNZzuq5j8rDYwaJnUiUr9gejLyKt7p3hY4ttxsnhlLXN869wBKB/rBU/q0qbuvfuaEs1X
 DBGm3vPPaAwVMbc1VIWzbXZyJRpdpJI/AtUfUKnmLpQWfwNUxGN7NMiFZYIQX0N/a7Thg4
 cVX5l9N7LUEI0mCk1fj9BZrvnR4+eVgEKg4ZzsKHKJuD9R6HPshtXmUcIYjTXA==
Date: Sat, 10 Feb 2024 17:37:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: u-boot@lists.denx.de, Chen-Yu Tsai <wens@csie.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Alper
 Nebi Yasak <alpernebiyasak@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 David Bauer <mail@david-bauer.net>, Xiaobo Tian <peterwillcn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Loic Devulder <ldevulder@suse.com>,
 Jonas Karlman <jonas@kwiboo.se>, Levin Du <djw@t-chip.com.cn>, Suniel Mahesh
 <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>, Christopher
 Obbard <chris.obbard@collabora.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 0/4] rockchip: Read cpuid and generate MAC address from
 efuse for RK3328 and RK3399
In-Reply-To: <20240210063252.1065611-1-wens@kernel.org>
References: <20240210063252.1065611-1-wens@kernel.org>
Message-ID: <4f3337a316b6ac3ae788cc8d2522c3e0@manjaro.org>
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

On 2024-02-10 07:32, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> This series enables ROCKCHIP_EFUSE and MISC_INIT_R by default for 
> RK3328
> and RK3399 so that the cpuid is read from the efuse and used to 
> generate
> a serial number and MAC addresses for all boards.
> 
> This stacks on top of the recent defconfig update series [1] from 
> Jonas.

The entire series is looking good to me!

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> [1] 
> https://lore.kernel.org/u-boot/20240207000301.3270722-1-jonas@kwiboo.se/
> 
> Chen-Yu Tsai (4):
>   rockchip: rk3328: Read cpuid and generate MAC address from efuse
>   rockchip: rk3399: Read cpuid and generate MAC address from efuse
>   rockchip: rk3328: regenerate defconfigs
>   rockchip: rk3399: regenerate defconfigs
> 
>  arch/arm/mach-rockchip/Kconfig                | 4 ++++
>  configs/chromebook_bob_defconfig              | 2 --
>  configs/chromebook_kevin_defconfig            | 2 --
>  configs/evb-rk3328_defconfig                  | 2 --
>  configs/firefly-rk3399_defconfig              | 2 --
>  configs/nanopi-r2c-plus-rk3328_defconfig      | 2 --
>  configs/nanopi-r2c-rk3328_defconfig           | 2 --
>  configs/nanopi-r2s-rk3328_defconfig           | 2 --
>  configs/nanopi-r4s-rk3399_defconfig           | 2 --
>  configs/orangepi-r1-plus-lts-rk3328_defconfig | 2 --
>  configs/orangepi-r1-plus-rk3328_defconfig     | 2 --
>  configs/pinebook-pro-rk3399_defconfig         | 2 --
>  configs/pinephone-pro-rk3399_defconfig        | 2 --
>  configs/puma-rk3399_defconfig                 | 2 --
>  configs/roc-cc-rk3328_defconfig               | 2 --
>  configs/roc-pc-mezzanine-rk3399_defconfig     | 2 --
>  configs/roc-pc-rk3399_defconfig               | 2 --
>  configs/rock-4c-plus-rk3399_defconfig         | 3 ---
>  configs/rock-4se-rk3399_defconfig             | 3 ---
>  configs/rock-pi-4-rk3399_defconfig            | 3 ---
>  configs/rock-pi-4c-rk3399_defconfig           | 3 ---
>  configs/rock-pi-e-rk3328_defconfig            | 2 --
>  configs/rock-pi-n10-rk3399pro_defconfig       | 1 -
>  configs/rock64-rk3328_defconfig               | 2 --
>  configs/rock960-rk3399_defconfig              | 1 -
>  configs/rockpro64-rk3399_defconfig            | 2 --
>  26 files changed, 4 insertions(+), 52 deletions(-)
