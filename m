Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A676AC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 15:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F6C806FE;
	Wed,  5 Feb 2025 16:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LgQcPF4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0968070F; Wed,  5 Feb 2025 16:19:23 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2911980562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 16:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738768760;
 bh=RMxKZ0pL+pCmUKckh3y9+gqQZh5W4SpE/tLY6oBZbZ8=;
 b=LgQcPF4aXYdScSDQZ2/RkxrYbp4XVRyHVlBO8YIZzrx2gj0q6BpB/0xMhUfAUsL7J9KjM/SqW
 O/UKf4RC79gtRtxCbuijH1v0+GnB+vfWI3cgB+UkUfJO15iAyutW4DDUy0K2ipkKIAgaiQDn7xp
 QIJAfiGf2qEQ/nHdSpdiL3XmWpY5ncm0tE7P3zqcdg3AuI98eQt9VaRqw0xVCnGcju7ngR9tQb1
 +WbujbxQ0GWdHdfPLiHY3kOVKwmKooYNJ9Hbtg6NNfZ4p5QtfdHqx8RaXOOD914Je857tJK0QjN
 ffb8emo68wouPXJR4SVgOIi2C00DQjp8FIrhgVzB3t1w==
X-Forward-Email-ID: 67a38174fb44099d0e594476
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0c300f04-04ef-4624-9c8f-b1cd10d1d50f@kwiboo.se>
Date: Wed, 5 Feb 2025 16:19:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/29] rockchip: Add more space below the stack pointer
 with kevin
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-9-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-9-sjg@chromium.org>
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

On 2025-02-05 02:54, Simon Glass wrote:
> Move this up higher on kevin and bob so we can accommodate a larger
> U-Boot, e.g. with debugging info enabled.

These targets have moved to use ROCKCHIP_COMMON_STACK_ADDR and now use a
completely different CUSTOM_SYS_INIT_SP_ADDR, please rebase.

Regards,
Jonas

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  configs/chromebook_bob_defconfig   | 2 +-
>  configs/chromebook_kevin_defconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index decac2e1935..2f08cff41e6 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -7,7 +7,7 @@ CONFIG_TEXT_BASE=0x00200000
>  CONFIG_SPL_GPIO=y
>  CONFIG_NR_DRAM_BANKS=1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x400000
>  CONFIG_SF_DEFAULT_SPEED=20000000
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-bob"
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 5bbea6c42a8..8959d397256 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -7,7 +7,7 @@ CONFIG_TEXT_BASE=0x00200000
>  CONFIG_SPL_GPIO=y
>  CONFIG_NR_DRAM_BANKS=1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x400000
>  CONFIG_SF_DEFAULT_SPEED=20000000
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-kevin"

