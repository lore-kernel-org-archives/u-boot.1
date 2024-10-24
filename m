Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CADECE8E68
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 11:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A26D588E81;
	Thu, 24 Oct 2024 13:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729770678;
	bh=Zr2u+Qc2bzLM5wvVlX5Qbzsc0iho8H3jaVpCqny/gBE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aboD6/6dcTFcVD3ARkaa/mBpC3Vl929x9MTjkqkkifFtIsXan2OMA2n9nf00/WcaB
	 jDtc0kAbNZEqR4uBZWSso6kSWiCLXv0/REMdg9toW8LgM6rjGQuysLYw2mm6buAho7
	 xkyQXCjnO/s4j09TJFpDPtE9y4EEuuHHKQL3tuaDJQF5Li1RERvfrnOZfUpMiP8yrh
	 /sRlNjdTP5OAdFOKbXpf3lw0FYl7CYDlF/f+IBYKjzWn/DAjpuaTHdsP1ixNlqINSK
	 P6FrgjeOgsKfp48q65VDvSD9ODMNH0jlXieogERmLQ6CmRI2TkyiiwMQ3445b2Usph
	 TGa9jLymwszSw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DA6B688ECD;
 Thu, 24 Oct 2024 13:51:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729770677;
 bh=Zr2u+Qc2bzLM5wvVlX5Qbzsc0iho8H3jaVpCqny/gBE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OpoAjh18b6dmVmH0wdBih58zhUgE3zYhWZScYOD54c7VFUEa/3B7UzuBiwosDNnKa
 xiKM7crECz+b4tLpzQP2F30WVnobE4iwTiDdcpUXgyEcUgCJQbAuJOn510ETZh5YPj
 VcZsOgGaRp4+6Ad9erknpmnvqTQT34KumcVWJA72d7fcICaMShwJOTYh1D1xP82pa6
 fDRpNaUkxTvTNlxqmamqnLWDUwu/5yYzxwGWp26Wegn/I1aHyjYrjn1rN/DTOlhQnI
 VqCG+23qORHl6tU16wrH6VvTGdApPGXf7US/a1ASyfUi6BgFVbasATamBQCoEQIrwV
 peSjNkd16k7hA==
Message-ID: <58754a24-eb1a-4306-a5de-e990539b1717@denx.de>
Date: Thu, 24 Oct 2024 13:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20241024100145.841964-1-ravi@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241024100145.841964-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/24/24 12:01 PM, Rasmus Villemoes wrote:
> I enabled IMX_HAB on an imx8mp board, but even though I knew about the
> implementation, I forgot that I had to provide a sane value for
> SPL_LOAD_FIT_ADDRESS. The help text for IMX_HAB doesn't mention this
> implicit requirement, and there's no build-time warning; the default
> 0x0 value just ends up being returned from
> board_spl_fit_buffer_addr(), obviously resulting in a non-booting
> board.
> 
> The existing imx8m* board configs that set a non-zero value currently
> all use 0x44000000. The actual value doesn't matter too much, but 0 is
> always wrong for imx8m platforms. So just use 0x44000000 as default
> for those platforms.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>   boot/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 940389d4882..72d1f69afcd 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -231,6 +231,7 @@ config SPL_LOAD_FIT
>   config SPL_LOAD_FIT_ADDRESS
>   	hex "load address of fit image"
>   	depends on SPL_LOAD_FIT
> +	default 0x44000000 if ARCH_IMX8M
This only applies to HAB , for non-HAB the fitImage can be loaded at 
arbitrary location, do you need:

default 0x44000000 if ARCH_IMX8M && IMX_HAB

right ?
