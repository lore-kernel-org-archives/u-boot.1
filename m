Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F4CEA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D758422D;
	Thu,  9 Apr 2026 15:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HCcnno2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556B483CF5; Thu,  9 Apr 2026 07:49:08 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD9E483693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 07:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b2469e5117so2244975ad.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 22:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775713744; x=1776318544; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Umjtv+EHLj8jC/NQuj8AIH6yEyonErlCAtX3lp8krPE=;
 b=HCcnno2xQAjpQny84esfzzv7ma3Yxb/m6OmORxZRA5tqELwehF7IyRHdpuuv30tv/G
 yq4QSlB6BA5AQG3bvJtIoJrPPEb54xLSIQ8nIi70xbzTJ+5UG4nYP+/AKY2KCP59CMZL
 BMySjpm1wW/ViGevjKlxn5bwvQ4zUi8CGdCogAbSMeMbuszo3orFR/mI7tdCW5nqTkFl
 YT9Is7T2n07OCRAUD7JMeV8eZrr8bjBrn2AT56DgAbX2dEsx6LDOG1L8CSo6qI1G1Z23
 SD4cZ5J6YrJ79ieoO82GBBwmz19NKVq2O4tZzAPlielEfv96yoAdOMhbr4X3U0HvpNKD
 7Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775713744; x=1776318544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Umjtv+EHLj8jC/NQuj8AIH6yEyonErlCAtX3lp8krPE=;
 b=C+yct9osc2xSMhaTSgBlMX9h8HI6tmUDF4lRb5X7SNzjWqcf8cqmrhWlfGTlOBs4fL
 qGfRfkqM3hG6rnFZmBit0HcKyNFAR7Z7w66HxwIrBjapsmEOCXlleaT/DKsKG2fZuIl7
 0VdKIqix5rtqio7tck7MwkgsaU3x7CRkWIG6MZta5sZqXbpgZNzASVGtC2xx7V9YG1e2
 mWfR6RHwQqv4HCCfsh/A0OEjwuNgdwlj2exUD0/uoqtcVBBLVzM4URb/lblHvbF+oXrn
 gkrP0LJ9C79Oa2lnhmoz0mtV23Z35b8T+I2vCp/IqS+BcMwrvp2YrvpKPsOwUBEgFfTE
 t40w==
X-Forwarded-Encrypted: i=1;
 AJvYcCViFodgkyYUmsdKc3TDkV+CrfycaIyzBWL2wO6tS0nQYjZGwbsI4YHLAd57Kq5mqE6Tmb9BTIY=@lists.denx.de
X-Gm-Message-State: AOJu0YzDkRZTyplv7mSKLb3E5YZJSkJ1Dqx7q0/pf6GI481ZMZrST9XB
 lx1Zb+rscP92V/9VHVlUlSZSH3G9rdhByiS1nyJKCzn8QUysm5CTw1yX
X-Gm-Gg: AeBDieueJhVZnjIEpz6HPjzxLNTDMpKRAqNRmK85cY4GDYnuXioDJlSxzf0xMxkz4T8
 M1ceVWEYV2NMDqa6DY2dqcDWlW7j0D143rmV68BE9T1R5idw5EFA5SzQnmaROolS7PVW219RJmJ
 K5dh7xZn0SlN4S0UiaA3p0dMihzmvPm1f2ECMu1QVFYzesdBCoGkF23sGO4yFKBesaHE2nJnX2h
 0TTyK+93/S2Ks62iYbDvdC6JE32DyLehgOOhBlFtnIrhLDQ3Oxm9B03KEpurjxUC31GG7VjieTr
 RwSa5wIN6Cl8jIMyyp8U3sBO98Rx9j3NttzWp0DSDMPuA8KkOQDOh+o0ptPE8ONPUk3y5DmG06Y
 XhP0F8UN+sicr1Voo8GuBwLc1jeN7rqTVROqIZDKei7xfEgwq8UANuRG9JdCcVltqUgJl0i5Giq
 uZ2Q==
X-Received: by 2002:a17:903:3848:b0:2b2:9a84:e870 with SMTP id
 d9443c01a7336-2b2c72d51d9mr19904655ad.8.1775713743673; 
 Wed, 08 Apr 2026 22:49:03 -0700 (PDT)
Received: from [192.168.101.188] ([2605:e440:15::152])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbc58sm232244335ad.78.2026.04.08.22.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 22:49:02 -0700 (PDT)
Message-ID: <f78d23da-0e61-4a06-ae48-22cadd7ac24d@gmail.com>
Date: Thu, 9 Apr 2026 13:48:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sunxi: H616: dram: fix LPDDR3 TRP6 parsing
To: Philippe Simons <simons.philippe@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>, Cody Eksal
 <masterr3c0rd@epochal.quest>, Samuel Holland <samuel@sholland.org>,
 u-boot@lists.denx.de
References: <20260407164717.7356-1-simons.philippe@gmail.com>
Content-Language: en-US
From: Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <20260407164717.7356-1-simons.philippe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:00:51 +0200
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

On 4/8/26 00:47, Philippe Simons wrote:
> From: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> Allwinner's BSP DRAM code uses parameter TPR6, presumably containing
> some "Vref" parameter, to encode the values for *all* four supported DRAM
> types. The code selects one byte based on the DRAM type used at runtime.
> To allow copying DRAM parameters from vendor firmware, we used this value
> and its encoding, but wrongly: the proper order of bytes is DDR3, DDR4,
> LPDDR3, LPDDR4, from LSB to MSB, cf. the A523 and A133 DRAM code.
>
> Correct the masking for LPDDR3 to fix DRAM operation on some boards
> using this DRAM type.
>
> With LPDDR3 TRP6 parsing fixed, adapt default DRAM_SUNXI_TPR6 value.
> Also change LPDDR4 default value to 0x38 used by A523 boards.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> [adjusted commit message, update default value]
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> ---
>   arch/arm/mach-sunxi/Kconfig            | 2 +-
>   arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index e979ee4a2cc..a1ddc6a1fc8 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -144,7 +144,7 @@ config DRAM_SUNXI_TPR3
>   
>   config DRAM_SUNXI_TPR6
>   	hex "DRAM TPR6 parameter"
> -	default 0x3300c080
> +	default 0x38c00080
I don't think this will be a good solution. The changes in this series
were originally made to improve compatibility with the vendor driver,
but now you are introducing an additional inconsistency by closing the
previous one. The default values are not just arbitrary values — they
are part of the vendor code that was obtained through binary analysis.
https://lore.kernel.org/all/20231018172109.085cce24@donnerap.manchester.arm.com/

There are several options here:
1. If our goal is to improve compatibility, then we should not change
the default values for LPDDR4, and only keep the changes for LPDDR3.
2. Add the changes from option 2, and additionally introduce the default
values for the A523 platform that I made during the initial binary
analysis but for some reason did not get merged into mainline.
(https://github.com/iuncuim/u-boot/blob/b17c5c8911a4fce328b01e6332632a9ccd88ebc6/arch/arm/mach-sunxi/Kconfig#L102)
3. If we accept the incompatibility between the vendor driver and
the mainline driver, then this patch series is unnecessary because
they introduce additional inconsistency with the vendor driver.

I think option two is the most correct, but option one is also suitable,
since the DRAM driver for the A523 only supports DDR3 and LPDDR4,
and the default values in this case are the same as for the H616
(A523 is 0x33808080, H616 is 0x33c00080).
>   	help
>   	  TPR6 value from vendor DRAM settings.
>   
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index 3345c9b8e82..42a0550e015 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -975,7 +975,7 @@ static bool mctl_phy_init(const struct dram_para *para,
>   		val = para->tpr6 & 0xff;
>   		break;
>   	case SUNXI_DRAM_TYPE_LPDDR3:
> -		val = para->tpr6 >> 8 & 0xff;
> +		val = para->tpr6 >> 16 & 0xff;
>   		break;
>   	case SUNXI_DRAM_TYPE_LPDDR4:
>   		val = para->tpr6 >> 24 & 0xff;
