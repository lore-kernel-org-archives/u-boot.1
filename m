Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADD7C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 21:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A463F8083C;
	Mon, 17 Feb 2025 22:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VlOykT3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1BF780BAD; Mon, 17 Feb 2025 22:22:23 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7009A80077
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 22:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a97e=VJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739827340;
 bh=nBUurqQgYwNz/X9cCfJkKVa8OGvdaO1wCkXJhe3zN0U=;
 b=VlOykT3Qr0nVrJVaD5BwL0iCZvQkCc/yx4v7caNEQctv7bNBkYWIsMdfDT3fAH5iIRIk6Wyg9
 m6Y8Kl3n1dXvYPRz9ksHGXC6b6xovQGUixHWW6Ooxja6x2z0ngFdGjOILkHJDHHlccuSOLu+awu
 0BNckPRRHSDDyVTznRa6x/Bo5PIJcg16JPbVMQ0tLQ94fTuMBy5OTB5ToKzS3VUvBNlj/Xydyle
 6IBD81XQdQLrep0K9gPuUUhOzZ+x5uHkfblt1YR9Pq/dgSoQzeMMpW/PG9ytOSY3RjlJwh3kGPc
 F5a08ewIEsB3+P5UhMX57xRQmRqAVx38msnrjgvBuoDQ==
X-Forward-Email-ID: 67b3a88a179e723bb8e576e7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0180063b-7300-4156-97a8-2e5e12b061cd@kwiboo.se>
Date: Mon, 17 Feb 2025 22:22:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/35] arm: Support a separate stack for VPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-5-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-5-sjg@chromium.org>
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

On 2025-02-09 22:14, Simon Glass wrote:
> VPL has the same needs as TPL in situations where the stack is at the
> top of SRAM. Add an option for this and implement it for arm
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Reply on existing CONFIG_VAL() to select the VPL stack
> - Correct reference to TPL when VPL was intended
> 
>  common/spl/Kconfig.vpl | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
> index cf6b36c8e38..4abb96221bb 100644
> --- a/common/spl/Kconfig.vpl
> +++ b/common/spl/Kconfig.vpl
> @@ -266,6 +266,20 @@ config VPL_MAX_SIZE
>  	  The maximum size (in bytes) of the TPL stage. This size is determined
>  	  by the amount of internal SRAM memory.
>  
> +config VPL_HAVE_INIT_STACK

Please see my remark on the name from the TPL patch.

> +	bool "VPL requires a initial, fixed, stack-pointer location"
> +	help
> +	  Enable if the VPL phase should not use inherit its initial
> +	  stack-pointer from the settings for U-Boot proper, but should set
> +	  its own value.
> +
> +config VPL_STACK
> +	hex "Address of the initial stack-pointer for the VPL stage"
> +	depends on VPL_HAVE_INIT_STACK
> +	help
> +	  The address of the initial stack-pointer for the VPL stage.
> +	  Usually this will be the (aligned) top-of-stack.

Here you are using stage, when you changed it to phase for TPL and use
phase for the above symbol, please be consistent.

As already mentioned, please split patch 1-4 into a separate series.

Regards,
Jonas

> +
>  config VPL_BINMAN_SYMBOLS
>  	bool "Declare binman symbols in VPL"
>  	depends on VPL_FRAMEWORK && BINMAN

