Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B813DC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2440981951;
	Fri, 28 Mar 2025 17:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QJjaKFOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AFB81DCC; Fri, 28 Mar 2025 17:16:57 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1DE68144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72be=WQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743178613;
 bh=2UlpkJdBn72vG4OLK/t3KDn9YQlPfkpp8mVL6efOros=;
 b=QJjaKFOKYDXaCKbQdp9Gt7Y4Lz/boGjpIx2Zl1V1/i8dbQAQJrh8w5d0KbGKLRPU+mDwjXs1r
 itl1c1zSmOzHVcuiEqKKGpy1zj7ETSIswlwuri5+7z4SOU2fg0308V7RYjhZhUNkiWBN576PGAA
 AjirtFqcchvMgf3yxpbZDP5CQl89/M5fyYfJvJxIA3E0TLOLcYg0DBvU2/x7BVMk6JP/c4HP/ar
 /qI9Hxw8ZJ3IEWK0+DvYFGZ0z11AqiicL9DpLhpynPggM6LrQJAlHbCxq3KAy6J5hdqtE4Qntjv
 ssHcwIgV44fiur7ZXrJIaWkA6nFnhrDgc+m2cCWrqG0g==
X-Forward-Email-ID: 67e6cb7137e81528de2ba155
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6721d34c-83eb-44d9-9be5-a4f8346481e3@kwiboo.se>
Date: Fri, 28 Mar 2025 17:16:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/31] rockchip: Provide a VPL phase on rk3399
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <greg.malysa@timesys.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 huang lin <hl@rock-chips.com>
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-20-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250328153522.3555472-20-sjg@chromium.org>
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

Hi Simon,

On 2025-03-28 16:34, Simon Glass wrote:
> Add support for this new phase, which runs after TPL. It determines the
> state of the machine, then selects which SPL image to use. SDRAM init is
> then done in SPL, so that it is updatable.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
> - Skip spl-boot-order.c for VPL (rather than modifying it)
> 
>  arch/arm/include/asm/spl.h               |   1 +
>  arch/arm/mach-rockchip/Kconfig           |  25 +++++-
>  arch/arm/mach-rockchip/Makefile          |  11 ++-
>  arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
>  arch/arm/mach-rockchip/spl.c             |   3 +
>  arch/arm/mach-rockchip/tpl.c             |   2 +-
>  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
>  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
>  common/spl/Kconfig                       |   1 +
>  9 files changed, 205 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
>  create mode 100644 arch/arm/mach-rockchip/vpl.c
> 

This patch and therefore this series does not apply to the next branch.

Are there any depends that are missing or are you only testing based on
your own fork?

Regards,
Jonas

[snip]
