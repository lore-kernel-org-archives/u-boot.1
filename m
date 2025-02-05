Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D11C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE073801BE;
	Wed,  5 Feb 2025 17:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OVAfpd/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3093E806C9; Wed,  5 Feb 2025 17:10:36 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B026080104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738771831;
 bh=Cc0PlOq0SQdgr8CI5Erh4OdXOK1fEwPXubl7O3Xjhek=;
 b=OVAfpd/G5iubO9Cv0IfPYOko1zvsKSox76yYhLZgLspMn8aIPAmkvAx+4/NyW+j0fw5xn/YNI
 xFNHNJqbEpMSTokzU2z4MRdMn8faxGK65k9hHvg1kRLh6iO6rh+cIcnVvIU64Z2+n0U7l8jVOK8
 KxCBAmVfPhbaROvpY39ZQz2/jCPTRGtC3Ks8Ay0FK0HfyyRlGybcKCSEW/k2DTvI1LQjunf3h96
 KCJCN4hS4+X0BhXLFLF7zrrqdmLXW76n2m5dDLOzdWQmD3Q5oAYJMCNAYJBuc9/OsHd/1JHkSqm
 d5L3j5/xk9/DpHoalyNWBbijKnYPw2N8Xy0VZlcapaJw==
X-Forward-Email-ID: 67a38d76fb44099d0e594c3e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d9418169-8516-478d-8e77-02b03a3d33a3@kwiboo.se>
Date: Wed, 5 Feb 2025 17:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/29] rockchip: Adjust rk3399 TPL-stack to the same as SPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-24-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-24-sjg@chromium.org>
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

On 2025-02-05 02:55, Simon Glass wrote:
> There doesn't seem to be a good reason to use a different value for TPL
> than SPL. Change the TPL value, since it allows a 256-byte bloblist to
> be safely located above the stack in all phases.

SPL is currently using DRAM memory as stack on all Rockchip AArch64
boards, so this commit subject and message does not make much sense.

Regards,
Jonas

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
> index fc55b498111..8064b6286fc 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -159,7 +159,7 @@ config TPL_LDSCRIPT
>  	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
>  
>  config TPL_STACK
> -        default 0xff8effff
> +        default 0xff8eff00
>  
>  config TPL_TEXT_BASE
>          default 0xff8c2000

