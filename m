Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1443BC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 21:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7E080104;
	Wed,  5 Feb 2025 22:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aJb9n901";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D498033D; Wed,  5 Feb 2025 22:59:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 267A5800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 22:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738792746;
 bh=pNrEgQ06t5GF8gWCgCGIdS5jfgzcM0wFEK2E6hHNgNU=;
 b=aJb9n901huuLxMW5q4eQr6rXr6o4q5i5RZizIRmy3QAraTXngCjjfe6jT9vlcCothG9ZOLC9k
 N1V6hbal5oB9PZrFVBMEtYxNkOxwmghGCJGKRXK4rkhMYUikuPqJ7SwG+pnjNbATu+yVRp7CI+Y
 PFjbppMV1TSej09+fAbK6lltsls3mwbP+Jfgi6IFeC1uEnwFIM+uVhNT5MsGhqP298zpQWT91nG
 sn6dhy1iMdokjsIbMEf2CHD/vjDRy8qVXFuZNhV27GZxNpeNOM7ZZp1yejKoGDBqHNhT1VTmsFK
 xs6YiwGKmHSG1nYmSSMJKcZbWHk7znpaOqnhKPxJlF1g==
X-Forward-Email-ID: 67a3df294f7eea50c61f477b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b3ff6f1b-7bc1-4187-bc91-94d884745e95@kwiboo.se>
Date: Wed, 5 Feb 2025 22:59:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/29] arm: Support a separate stack for VPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-2-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-2-sjg@chromium.org>
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
> VPL has the same needs as TPL in situations where the stack is at the
> top of SRAM. Add an option for this and implement it for arm
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/lib/crt0_64.S |  4 +++-
>  common/spl/Kconfig.vpl | 13 +++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)

[snip]

> diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
> index cf6b36c8e38..d4d4a00d99f 100644
> --- a/common/spl/Kconfig.vpl
> +++ b/common/spl/Kconfig.vpl

[snip]

> @@ -266,6 +272,13 @@ config VPL_MAX_SIZE
>  	  The maximum size (in bytes) of the TPL stage. This size is determined
>  	  by the amount of internal SRAM memory.
>  
> +config VPL_STACK
> +	hex "Address of the initial stack-pointer for the TPL stage"
> +	depends on VPL_NEEDS_SEPARATE_STACK
> +	help
> +	  The address of the initial stack-pointer for the TPL stage.
> +	  Usually this will be the (aligned) top-of-stack.

I am guessing the two mentions of TPL above should be VPL?

Regards,
Jonas

> +
>  config VPL_BINMAN_SYMBOLS
>  	bool "Declare binman symbols in VPL"
>  	depends on VPL_FRAMEWORK && BINMAN

