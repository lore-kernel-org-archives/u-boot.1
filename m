Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63FCC2BA15
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 11:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422C18843F;
	Wed, 19 Jun 2024 13:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718795928;
	bh=R5Womou1mCi+AgQVaolZrmd/ypZXB3jYUqiUK03JKwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uaSCZDgo3vU5QCZTitCtNs1F9H0qvLmyVCr4tFG0+ZrigVmKx/QzOrjVnILoDwlNi
	 hVrGM1BDbptcUVUB2WYcf6b+xb8FzZLdHOXm58gXzg5ZykI0V5aFstQKA493NSD+fZ
	 KCMM7UoTFI92C0hBoEy9A9pTV5/GCXX7d1aSAX9oT+dbULu8TKfF12RjxSDCu70WRm
	 XsH1GR02sYvva9G0C/v/UMfXUs+iSK8usDklt7aIap0Bug2/RYWOdupZfXhICpjF22
	 pUpOLhIpcLFiQ/OPZrvbCkhfuLGXwtm+bKgsWvxcPowM5lT/Si0FVjI+xV7opBxQnb
	 s4/qfE6esVk0g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB0B588445; Wed, 19 Jun 2024 13:18:46 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C7E88363
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 13:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4W41Mk1qDFz9sSX;
 Wed, 19 Jun 2024 13:18:42 +0200 (CEST)
Message-ID: <67da33d0-76f8-449a-912d-d8f86822009d@denx.de>
Date: Wed, 19 Jun 2024 13:18:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: davinci: remove unused defines
Content-Language: en-US
To: Emil Kronborg <emil.kronborg@protonmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, rasmus.villemoes@prevas.dk
References: <20240619105958.43083-1-emil.kronborg@protonmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240619105958.43083-1-emil.kronborg@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/19/24 13:00, Emil Kronborg wrote:
> The last usage of the DV_TIMER_ and DV_WDT_ definitions were removed in
> commits 8d7757637138 ("ARM: davinci: remove support for cam_enc_4xx")
> and cef443c1666c ("arm: davinci: remove leftover code for dm* SoCs"),
> respectively.
> 
> Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
> ---
>   arch/arm/mach-davinci/include/mach/timer_defs.h | 16 ----------------
>   1 file changed, 16 deletions(-)

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> diff --git a/arch/arm/mach-davinci/include/mach/timer_defs.h b/arch/arm/mach-davinci/include/mach/timer_defs.h
> index 110e67e454ce..38188dc699cf 100644
> --- a/arch/arm/mach-davinci/include/mach/timer_defs.h
> +++ b/arch/arm/mach-davinci/include/mach/timer_defs.h
> @@ -20,22 +20,6 @@ struct davinci_timer {
>   	u_int32_t	wdtcr;
>   };
>   
> -#define DV_TIMER_TCR_ENAMODE_MASK		3
> -
> -#define DV_TIMER_TCR_ENAMODE12_SHIFT		6
> -#define DV_TIMER_TCR_CLKSRC12_SHIFT		8
> -#define DV_TIMER_TCR_READRSTMODE12_SHIFT	10
> -#define DV_TIMER_TCR_CAPMODE12_SHIFT		11
> -#define DV_TIMER_TCR_CAPVTMODE12_SHIFT		12
> -#define DV_TIMER_TCR_ENAMODE34_SHIFT		22
> -#define DV_TIMER_TCR_CLKSRC34_SHIFT		24
> -#define DV_TIMER_TCR_READRSTMODE34_SHIFT	26
> -#define DV_TIMER_TCR_CAPMODE34_SHIFT		27
> -#define DV_TIMER_TCR_CAPEVTMODE12_SHIFT		28
> -
> -#define DV_WDT_ENABLE_SYS_RESET		0x00020000
> -#define DV_WDT_TRIGGER_SYS_RESET	0x00020002
> -
>   #ifdef CONFIG_HW_WATCHDOG
>   void davinci_hw_watchdog_enable(void);
>   void davinci_hw_watchdog_reset(void);
> 
> base-commit: 01a5d7547ed3a51a8ac5837c31a150f85bc475f8

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
