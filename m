Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCADC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 21:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF888209F;
	Sat,  3 May 2025 23:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B044820E8; Sat,  3 May 2025 23:34:29 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51F8380F6B
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 23:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.61.17]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B9196B4C258C;
 Sat,  3 May 2025 23:34:25 +0200 (CEST)
Message-ID: <b832da5c-4a7c-499d-96ee-9ec03269700a@freeshell.de>
Date: Sat, 3 May 2025 14:34:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: jh7110: override syscrg assigned clock rates
 with defaults
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250503122952.973129-1-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250503122952.973129-1-e@freeshell.de>
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


On 5/3/25 05:29, E Shattow wrote:
> JH7110 drivers are missing support for CPU frequency scaling, so override
> upstream device-tree to use default clock rates for syscrg. This override
> duplicates a portion of jh7110-common-u-boot.dtsi file planned for removal.
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/dts/jh7110-u-boot.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
> index a9e318c4a31..13adbb6922c 100644
> --- a/arch/riscv/dts/jh7110-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-u-boot.dtsi
> @@ -108,6 +108,7 @@
>  
>  &syscrg {
>  	bootph-pre-ram;
> +	assigned-clock-rates = <0>; /* cpufreq not implemented, use defaults */
>  };
>  
>  &stgcrg {
> 
> base-commit: 6cc812f8cc55c132458c7da5b9fb7666315cbe8c

I missed the sort ordering on adding this, it should be ordered above
the bootph-pre-ram hint. Will fix with v2 after review and taking
comments.  -E
