Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5D0D3940D
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 10:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D07C5839DF;
	Thu,  2 Apr 2026 12:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="n+11I7YJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E88083CF5; Thu,  2 Apr 2026 12:53:08 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B32180212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 12:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1775127153;
 bh=irYj1II3DiN0dQfx0jnxaC5U26AraDnlXE8fVks4NBI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=n+11I7YJLLbHqI6HHL/4nW2bAC7Snm7kU9deK5HJy/2/kvyZ4LlxRvWydti6my6CU
 vZiHefgb0GEy118/G2SDM+UpR7vrhXMRvdoQvoPGLDSJzFHgcIdd9xYZQRm51U1JyE
 QHBkGYiuoRZQkkurWmoFG/Pz2e3z7GJptkUBaBmyGEOLU8IxEvkeFoflbIsDuIK1lo
 0WCuu5Wel6Nq9pMExSJKKv4NQ7xHAKrGoKM1N90wRqLKHgelyV6pKFLsb6GelSkeRE
 ROdFwN4CleHaL2mp9KFbTZWxgLX0Qk8qgcmx25Gwe/MQx7xi4aJg3x71bNBlXH0XeR
 SofjBU5f08s0g==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E0480B22054F;
 Thu,  2 Apr 2026 12:52:31 +0200 (CEST)
Message-ID: <617dfafa-bb37-4ce0-80c9-6e4334f488cc@freeshell.de>
Date: Thu, 2 Apr 2026 03:52:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Add support for StarFive VisionFive 2 Lite eMMC
 board
To: Hal Feng <hal.feng@starfivetech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20260402070041.2418-1-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260402070041.2418-1-hal.feng@starfivetech.com>
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

Hi Hal,

On 4/2/26 00:00, Hal Feng wrote:
> VisionFive 2 Lite eMMC board uses the eMMC as storage component instead
> of the MicroSD card in VisionFive 2 Lite board. The device tree of
> VisionFive 2 Lite eMMC board is already upstream in Linux, so add support
> in u-boot also.
> 
> Hal Feng (2):
>   configs: visionfive2: Add VisionFive 2 Lite eMMC DT to OF_LIST
>   board: starfive: visionfive2: Support VisionFive 2 Lite eMMC
> 
>  board/starfive/visionfive2/spl.c                  | 7 ++++++-
>  board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
>  configs/starfive_visionfive2_defconfig            | 2 +-
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 98cf83d81617f489d7ff7bf78d33e693e2799254

Looks good to me (for -next). For the series:

Reviewed-by: E Shattow <e@freeshell.de>
