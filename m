Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB165C369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 06:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF338209F;
	Mon,  5 May 2025 08:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746427775;
	bh=M2BPF5yZngjcHb6asWc0u5uUrQu7uf/bBzjgQ1tXnGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W9XwXy0neZryzOiUsq5leIrLlcE1n1myihrLY76MRy4SczzDMHNNLmDnyeGQQBtU3
	 hZqRCyv+dN0j4PpRokwAQug7oRGLRMleUv1idrzMa8INCMi9THGtLA2Bqi7MLz8/TH
	 slhHYDnktCarZAk5cyOmJ0RqkXiAeniov4n4kmGTU8FrN0tu9dber5vP4ZIuEDbUWj
	 gUmvhGTpRzN1JbvjXWamVVd+lE7W//msgON2ACRqdDdx1+LH816Ywcnxg0kZPWuhZ+
	 d67rTba3Y3YeoY1tDUl9iusFNdYl11SPJ2hlkZvPnJ26bpG6eITA6VoIt5ZSJDEOdz
	 YnJBZYw1wLcZQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F5A820E1; Mon,  5 May 2025 08:49:34 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 821BE805D7
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 08:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZrXFQ2ws3z9t9n;
 Mon,  5 May 2025 08:49:30 +0200 (CEST)
Message-ID: <416e16a8-e54d-4e9c-bfb7-f9408e6c50ff@denx.de>
Date: Mon, 5 May 2025 08:49:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/6] ARM: dts: sam9x60: Add watchdog DT node
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
 <20250428-wdt-v4-5-bb7d1c7c051a@hifiphile.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250428-wdt-v4-5-bb7d1c7c051a@hifiphile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZrXFQ2ws3z9t9n
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

On 28.04.25 11:16, Zixun LI wrote:
> Add the watchdog timer node for the sam9x60 SoC's.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/arm/dts/sam9x60.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
> index 7631dfaa07fc1e7c605c70840da1196c1daeb638..79449042c24f90686613f0082f40d4f2c13f122f 100644
> --- a/arch/arm/dts/sam9x60.dtsi
> +++ b/arch/arm/dts/sam9x60.dtsi
> @@ -311,6 +311,14 @@
>   				clocks = <&slow_rc_osc>, <&slow_xtal>;
>   				#clock-cells = <1>;
>   			};
> +
> +			watchdog: watchdog@ffffff80 {
> +				compatible = "microchip,sam9x60-wdt";
> +				reg = <0xffffff80 0x24>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +				clocks = <&clk32 0>;
> +				status = "disabled";
> +			};
>   		};
>   	};
>   
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

