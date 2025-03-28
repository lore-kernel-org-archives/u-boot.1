Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D4BC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 17:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C2AD8070C;
	Fri, 28 Mar 2025 18:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hdjCX/ne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC74809A5; Fri, 28 Mar 2025 18:28:49 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DEED8059D
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 18:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72be=WQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743182925;
 bh=qMwnVDcMwhurNS0Klb/tA9j7IRBs4Y4HwlxLMEO3YV4=;
 b=hdjCX/nemGgbPfdkAoGVl/3xXf6rMd/QPe9HxtAUFWehIiuivngVB3+QIiU/9lX3fnsxpexXy
 WsfLY6bFQv/kRdyYvhfZiHM6VUbPE6iI5LrXa9cFeb1MOs4nBWw9zldG3dLIrTt6MDu/ovRD0cn
 nfQ9dflmPH5aQZXnRnRqNSPJAKkSTLKSMdCk6N98NuCs6NnTLu+ntgT2wJL2eiOb0eeSR+tenrI
 qkpM+T/hHnUwjqjY2qjvU4WlQ4jamGrRzgxnsC3BrvEURpw37/mKf5KuIFQUHmtlpvVNVO4ul3r
 vryckj3NyFHzIRvlkVGTcyC3iUlo8XQIw65tC29MqaGA==
X-Forward-Email-ID: 67e6dc4937e81528de2bba8a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c4466a25-5a65-4228-a1a2-1aa93747ce21@kwiboo.se>
Date: Fri, 28 Mar 2025 18:28:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/31] rockchip: rk3399: Adjust initial TPL-stack to
 match SPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-22-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250328153522.3555472-22-sjg@chromium.org>
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

On 2025-03-28 16:35, Simon Glass wrote:
> There doesn't seem to be a good reason to use a different value for TPL
> than SPL.

This reference to SPL stack addr is still a little bit confusing, all
RK3399 boards now use a SPL stack addr in DRAM and not i SRAM.

So SPL and TPL stack addr will continue to use a different addr after
this patch.

Regards,
Jonas

> Change the TPL value, since it allows a 256-byte bloblist to
> be safely located above the stack in all phases.
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

