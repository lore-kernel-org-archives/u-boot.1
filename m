Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D83CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DEB984894;
	Fri, 26 Jun 2026 12:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yok4FwtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17D7F8494B; Fri, 26 Jun 2026 12:58:57 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D0F68460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gmt2j2nYnz9v9m;
 Fri, 26 Jun 2026 12:58:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782471533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bGn+6Fsk+j7aX3HVwwylhGHS/Qr7rebvjHBrUOWXjg=;
 b=yok4FwtBZLmbKhRSsq1fJd27gjEI5GJjYVWnaIBKFh2j5B8mXFfY/1MI5z+200uGqTAon2
 To0minsXU/bE7rY4nmjFpSuRgXozg7itfBPNmlvIXq7N/DmGlBiknUHSX+j7NTPQSD1hDd
 G21QijBf05Pdo8C/cmbHVuyl/oZ2mNassAjS5wFmrD46uH2ItlXgy9yRCzUoxU8mnJswH6
 RGyeQUeqDYog6yR5JWzDKUUMRrjDSX5Jv7Z3Vv+Sosj6g13dANkZikbzzl6s0wnUDJI4TD
 Gx20VzlR40YeR0FaE0T6UJPmFyM5Agi6fukO77mmRDqhAnCdhyL5vAmUlGqBMw==
Message-ID: <1d5d87ce-1e8b-4e5a-8edd-8a030f7205c4@mailbox.org>
Date: Fri, 26 Jun 2026 12:58:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mach-mvebu: Add more AC3 & PC3 variants
To: Chris Packham <judge.packham@gmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260626071156.3129812-1-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260626071156.3129812-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: z7jtf6e3ash6o6guyk4tgp1waiqfowbb
X-MBO-RS-ID: 09d20288c99131b4fa9
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

On 6/26/26 09:11, Chris Packham wrote:
> Add IDs for more of the Alleycat3 and Poncat3 variants. This makes the
> SoC information at boot say something other than "Unknown-??".
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   arch/arm/mach-mvebu/cpu.c              | 24 ++++++++++++++++++++++++
>   arch/arm/mach-mvebu/include/mach/soc.h |  6 ++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/cpu.c b/arch/arm/mach-mvebu/cpu.c
> index da44727cf4f5..a1eb6927c3e0 100644
> --- a/arch/arm/mach-mvebu/cpu.c
> +++ b/arch/arm/mach-mvebu/cpu.c
> @@ -276,9 +276,27 @@ int print_cpuinfo(void)
>   	case SOC_88F6828_ID:
>   		puts("MV88F6828-");
>   		break;
> +	case SOC_98DX3233_ID:
> +		puts("98DX3233-");
> +		break;
> +	case SOC_98DX3234_ID:
> +		puts("98DX3234-");
> +		break;
> +	case SOC_98DX3235_ID:
> +		puts("98DX3235-");
> +		break;
>   	case SOC_98DX3236_ID:
>   		puts("98DX3236-");
>   		break;
> +	case SOC_98DX3333_ID:
> +		puts("98DX3333-");
> +		break;
> +	case SOC_98DX3334_ID:
> +		puts("98DX3334-");
> +		break;
> +	case SOC_98DX3335_ID:
> +		puts("98DX3335-");
> +		break;
>   	case SOC_98DX3336_ID:
>   		puts("98DX3336-");
>   		break;
> @@ -337,7 +355,13 @@ int print_cpuinfo(void)
>   		}
>   		break;
>   
> +	case SOC_98DX3233_ID:
> +	case SOC_98DX3234_ID:
> +	case SOC_98DX3235_ID:
>   	case SOC_98DX3236_ID:
> +	case SOC_98DX3333_ID:
> +	case SOC_98DX3334_ID:
> +	case SOC_98DX3335_ID:
>   	case SOC_98DX3336_ID:
>   	case SOC_98DX4251_ID:
>   		switch (revid) {
> diff --git a/arch/arm/mach-mvebu/include/mach/soc.h b/arch/arm/mach-mvebu/include/mach/soc.h
> index 495530d84522..33fdfd6d6c1b 100644
> --- a/arch/arm/mach-mvebu/include/mach/soc.h
> +++ b/arch/arm/mach-mvebu/include/mach/soc.h
> @@ -21,7 +21,13 @@
>   #define SOC_88F6810_ID		0x6810
>   #define SOC_88F6820_ID		0x6820
>   #define SOC_88F6828_ID		0x6828
> +#define SOC_98DX3233_ID		0xf413
> +#define SOC_98DX3234_ID		0xf412
> +#define SOC_98DX3235_ID		0xf411
>   #define SOC_98DX3236_ID		0xf410
> +#define SOC_98DX3333_ID		0xf403
> +#define SOC_98DX3334_ID		0xf402
> +#define SOC_98DX3335_ID		0xf401
>   #define SOC_98DX3336_ID		0xf400
>   #define SOC_98DX4251_ID		0xfc00
>   

