Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5226C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 19:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F40F82B34;
	Sun, 25 May 2025 21:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="leocSPdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C531882B37; Sun, 25 May 2025 21:25:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B4A082B27
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 21:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=671e=YK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1748201152;
 bh=H+aP/WU0CTnrdikaivqz/s2INGMs5mCalFWEwm/VSE0=;
 b=leocSPdqg7JNkz7Ddxz9yENz6qYjpKoxjh2qLS1IHXneBr181efiibKuw77UiACJhu+PLhlkj
 0kAMn+EnE1wD0WVMEMO/8SEgCDjt5cHl4IpIIQHywnR9Satye0NPFCeGIYsrGtAO8LihmQ27Lpf
 feeq7CmwxY1rERp5yeJLi5BD/Kc+r5sLus9qKFKjZ8MsBnYxQoKAB+n4Fcr6cP6nLBAUr44XqF2
 vjMiwWArodUXYqG8zvBENmpgqWc0zBouVtl4YSDMKR02QQr4AYp4axPh3JX2wVhtic8obOb00ZC
 CLzg6SFxWwC9C7GQHCrtrJ30g689gxERrqHWdQsmGsxw==
X-Forward-Email-ID: 68336ebea0e3f2dd0ce237e2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <bca898a4-cb1c-4b78-a2ed-4f7e6025a3e9@kwiboo.se>
Date: Sun, 25 May 2025 21:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/25] rockchip: rk3399: Adjust initial TPL-stack to
 match SPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250525104801.1440260-1-sjg@chromium.org>
 <20250525104801.1440260-16-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250525104801.1440260-16-sjg@chromium.org>
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

On 2025-05-25 12:47, Simon Glass wrote:
> There doesn't seem to be a good reason to use a different value for TPL
> than SPL. Change the TPL value, since it allows a 256-byte bloblist to
> be safely located above the stack in all phases.

As mentioned for prior versions of this, this commit message does not
make any sense with the current state of SPL stack used.

This does not change the TPL stack to match SPL stack, it only moves it
to make room for a 256-byte bloblist used by VBE/VPL.

Please update the commit message and subject to reflect the reason for
this change.

Regards,
Jonas

> 
> Note that for most boards, SDRAM init happens in TPL so the SPL stack
> ends up in DRAM, at address CONFIG_SPL_STACK_R_ADDR.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Reword commit to mention comments from Jonas
> 
>  arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
> index 7b2d47fcb49..cbe718a428a 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -145,7 +145,7 @@ config TPL_LDSCRIPT
>  	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
>  
>  config TPL_STACK
> -        default 0xff8effff
> +        default 0xff8eff00
>  
>  config TPL_TEXT_BASE
>          default 0xff8c2000

