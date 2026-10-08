Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F16ACA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 20:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E1474092A;
	Thu,  8 Oct 2026 20:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xi5JwEAeNPXI; Thu,  8 Oct 2026 20:49:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2DC444090C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791492554;
	b=nWEVeax9SO4LP+Yi0ekSjhpAoa2IRoIngfUce6L1qi6VUc/eQ3b9HNlxF236u1TdBfw3
	 udzLesdiaZmJolgkcdeiFEaqsRz7JAX662UR4/Rx0OQnrKCPHg8sJd1uVsivrNVbURLDb
	 0bMQefFlOU+bXDaJLX79GKwuawjzUVws8NpKqLIXOreB4sXDNSQ38Ms+VtkQ31wR+OWDo
	 /dE5RZt28qqVjR4WPWJhYaKicywt48/9Hjs+TJljz4jjpMo8sYwnNicPLu6n/qd/UGvAE
	 AiB2BwykTPOV4GM9cXYH3OtPBjlLEDjpKFRv+ip+a4jfHovuRQ6ff+77kjPvBZhyMIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791492554;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FLjU82T5LGEZVzJu/gMIAko/4y27KBOYGpbDHBD2Si4=;
	b=iCkW21JikOY0j2MGMBRpgq+uCjsX0EEByv8hvKGYjHrjwvOGjQi1q6aTLLAssjBm8uS/
	 YI4cqw2h/ft5ZvOhOidA6ic+PEy/Uoc97tOu0ofJTF0aZHalUfOuYla5ks9uX8hXrsFuD
	 gsv2H3HqUDgbvz4TUXEZ7qOIvqpRt2v7bwCdA/47GRgVWl7xmtzx/M0DarCh4ioDmXpx5
	 ru7DGGu14AG+3i4TmDLkqMLecynUqMtxOO702v1B640FLpzHt21ntYicVNk3oYXyz83GM
	 0/NP808Nb4SnNMB8F80DmVrrF7Ro7FZ6o8clNG8nxrRqW+XSc0uIFYwXQn2qEmfJcqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=AfpsjyzI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791492554;
	bh=FLjU82T5LGEZVzJu/gMIAko/4y27KBOYGpbDHBD2Si4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S5kJHm19eGP/1i2O35hpUDI8VvheWIcEpDRqKfQrqUYl/X8cPH8H0VRCLB4C4YQm7
	 bSf+iro9rQP+vaR+cHX9v0SAO6COG9ml2KDBrGIigLBco6G0jV7kO8ixGk2L+QdVlS
	 pyhBNSH8f7KIgdCiInd4iJ58La9NZtkICKweAL7fQ/xCJgx4m4In9mt+cNKEVgqSt6
	 PsqV1Y8L03cqZ3n9mIvLBGbwhah3ARTYwYpIu234weiABuMZ2IGQehOcdz621TlrKY
	 eB8M78Bbp5uHDke1YwjNKpHp4JHV/ip4Y+CWhS6LpopSM04pSVjsIrsp5muEi1tPhO
	 a3ndHr0ERotGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DC444090C;
	Thu,  8 Oct 2026 20:49:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 16A4C34E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0A804090C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KgpVro7WKrrF for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 20:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CEBA140903
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=45.157.188.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791492551;
 b=Ax4h5twsfmXABgiVoySqynKlKfAB72lERRmewepvNtCeRHe27qrPolzwWLNFz60yhM3p
 szuc6LBXzf1m7a62ziwkG5O7lhE7oWiklaxi7wZXdWmVpY/o92Fm6VGm/38XERmeZhA7O
 xcG/2gRK/uIQ2gSFThnMGImlr4irkZcLOoQFM5VIyuDK89l5RXBxIIAHo35HcP2yXHHi7
 ABL7pT2WdddaRNDS8K2YfC0iLhS+r7c+k2TCHvJGrY3HAas+l9r2raUfnWmDltlkCifhU
 0aJKVtzFOUq1xvOcZMg7S0b7qsFt36RDpsoNl094BXjU2O0RL1ntqbEES/Gr4kS+nTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791492551;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=FLjU82T5LGEZVzJu/gMIAko/4y27KBOYGpbDHBD2Si4=;
 b=BjwAy2KBouvxBCT2isO0VBu19+CcUP1m51w0bJ4kdI2yCIySE6cF91xJbX47RI2yGNla
 4fqsdEH/2EnT9Lf47OPfHxUWpNL2fNwnW7CFJ/U8L6V0RtMJkbIoZMTrGZ3p080MXMgP3
 55MLvfyoizQ3eVM2JM6cm0ZDq76ZEQmseN+nZQ8GviUsRYoJS51bnRWjzRghZhMpCap2J
 N0JcfgOPyks2Itqc9hYBGJRPGDb+O7e+hamQvjW05eaC0M6FI5cCURLzg5VcPVat2vJ7u
 HPwFRHyDH7jE2+lJYg5bSeTz1jQJChHiRGXfDShJcvhvvzZk698N3u5rfH3dv7q1ulA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=AfpsjyzI; 
 arc=none smtp.remote-ip=45.157.188.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.12;
 helo=smtp-bc0c.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=AfpsjyzI
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEBA140903
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:49:08 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j12Ck5V3kzRjC;
 Thu,  8 Oct 2026 22:49:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791492546;
 bh=FLjU82T5LGEZVzJu/gMIAko/4y27KBOYGpbDHBD2Si4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AfpsjyzIgjsgAFoEE009rdAXWkIe3JHcwVu+AjjqbADkMuGV0k+o4+tjCdOpp6v+J
 5eC1pYBMin04EbHYjdOi3ULKhpP3l7U/YcRGM5FXnjRDZKJ526+FhO7m/qOg9DMEhO
 6bsQArc3WCNv0PFWIxwiuLN+0lSOuj3Cq7nZVIlPiPzOhpkIPfQ9DcVOCCRj3O8Joy
 040vR8AgIsuPGhNOtn0wjO87wi0ltHZ7CJ36vPLdC7Fxqpbqbj+N0WV651omXEJKuL
 tfoVpgMPwbV7M/m24AoVz/H1A9+55mw36VF0gTXhwDlq6n/As2sta+5JO8xZGNiWaY
 WkEuzOUMNTc9g==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j12Cj0JCpzkpf; Thu,  8 Oct 2026 22:49:04 +0200 (CEST)
Message-ID: <8a92f1ee-08c4-4f55-b0df-8098c4da7c1f@0leil.net>
Date: Thu, 8 Oct 2026 13:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ram: rockchip: improve ddr type configs selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
 <20260829-ddr-multi-v1-1-c0c7837aed20@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260829-ddr-multi-v1-1-c0c7837aed20@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Massimo,

Thanks for the patches. Note that the timing is interesting as we were 
considering having two variants of the same product, one with DDR3 and 
one with DDR4 and we don't want to have with deal with multiple binaries 
just for that.

On 8/29/26 7:03 PM, Massimo Pegorer wrote:
> Not all the DDR type config options named in the Kconfig are supported
> by each one of the Rockchip SoCs. Moreover, the LPDDR4 option has a
> different meaning in the context of the RK3399 SoC than in the RV1126
> one. Improve clarity splitting config options, using SoC specific help
> sections and adding depends on conditionals.

Yeah, we shouldn't do that.

> 
> Involved Rockchip SoCs are: RK3399, PX30, RV1126.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   drivers/ram/rockchip/Kconfig | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> index d707d09c1c8..61a3193b3f5 100644
> --- a/drivers/ram/rockchip/Kconfig
> +++ b/drivers/ram/rockchip/Kconfig
> @@ -26,26 +26,53 @@ config RAM_ROCKCHIP_DEBUG
>   
>   config RAM_ROCKCHIP_DDR4
>   	bool "DDR4 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126

This kind of change is very welcome.

>   	help
>   	  This enables DDR4 sdram support instead of the default DDR3 support
>   	  on Rockchip SoCs.
>   

We should get rid of the part that says "instead of the default DDR3 
support". We should have instead an option for DDR3 which is enabled by 
default and then we don't have to care about that part.

> +	  Note that even if multiple DDR/LPDDR types are selected, support is
> +	  enabled only for the selected one that comes first in the following
> +	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.

This one change though is less welcome. I don't want to have this in the 
Kconfig help text. I suspect nobody will maintain this in the long term.

> +
>   config RAM_ROCKCHIP_LPDDR2
>   	bool "LPDDR2 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30
>   	help
>   	  This enables LPDDR2 sdram support instead of the default DDR3 support
>   	  on Rockchip SoCs.
>   
> +	  Note that even if multiple DDR/LPDDR types are selected, support is
> +	  enabled only for the selected one that comes first in the following
> +	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> +
>   config RAM_ROCKCHIP_LPDDR3
>   	bool "LPDDR3 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30
>   	help
>   	  This enables LPDDR3 sdram support instead of the default DDR3 support
>   	  on Rockchip SoCs.
>   
> +	  Note that even if multiple DDR/LPDDR types are selected, support is
> +	  enabled only for the selected one that comes first in the following
> +	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> +
>   config RAM_ROCKCHIP_LPDDR4
> +	depends on ROCKCHIP_RV1126
>   	bool "LPDDR4 support for Rockchip SoCs"
>   	help
> -	  This enables LPDDR4 sdram code support for the platforms based
> +	  This enables LPDDR4 sdram support instead of the default DDR3 support
>   	  on Rockchip SoCs.
>   
> +	  Note that even if multiple DDR/LPDDR types are selected, support is
> +	  enabled only for the selected one that comes first in the following
> +	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> +
> +config RAM_ROCKCHIP_LPDDR4
> +	bool "LPDDR4 support for Rockchip SoCs"
> +	depends on ROCKCHIP_RK3399
> +	help
> +	  This enables LPDDR4 sdram code support for the platforms based
> +	  on Rockchip RK3399 SoC.
> +

Please do not duplicate the same symbol twice just to change its helptext.

For drivers that support multiple DRAM types but not at the same time, 
the easiest answer would be to enforce that outside of Kconfig with 
something like:

#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4) + 
defined(CONFIG_RAM_ROCKCHIP_DDR4) + defined(CONFIG_RAM_ROCKCHIP_LPDDR2) > 1
#error "This driver only supports one DRAM configuration at a time"
#endif

in the driver. I don't like it too much as this should really be in the 
Kconfig symbol but I couldn't think of a way to easily have only one 
symbol among a list to be allowed to be selected (that's typically a 
choice Kconfig) and also have the same symbols allowed to be selected as 
many as possible, depending on the SoC. I think it's a good compromise 
for now to fail the build by having this kind of check in the driver. 
However, this won't play nice with COMPILE_TEST so not sure if it's 
acceptable to Tom.

Ideally, we should also figure out which DRAM type(s) are supported by 
DRAM drivers that do not make use of the Kconfig symbols. e.g. RK3066 
for example, and have them explicitly enabled in Kconfig for 
completeness. That isn't required for this series.

Cheers,
Quentin
