Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBC5C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 11:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9507583A15;
	Fri,  1 Aug 2025 13:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="cJ3qR0is";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB08883A25; Fri,  1 Aug 2025 13:23:20 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A46839F1
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 13:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-61576e33ce9so3437686a12.1
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1754047398; x=1754652198;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3UYHz8SkUO+pfA9GacjbUuiH7qTCY2GBiniHJ7FWPW4=;
 b=cJ3qR0iskNMr76Ct6IncP7XravgU9EQq4nn9WI2cVHDgvwoh1WOV6pVR9U5nO3ZSaf
 KVMM9NMSFlgJLv1Cb/BgvZGhnP8/8x6355yzcyd6NZv0FmQzCg+zm+zukVpYfC01qK36
 IENO/9scixPBT4QIM4qqD6QpO5vSTLNydyWccEe9lkt/1nMJ4Xx+uHhzuS8h4nQQA+bj
 pK2N17ifil5I7AQuqDd1nYDSkZceq0n9VwUDXIiKacAx3u5Y3iSHkDetn5wlUn0FuyMt
 M67Nfhn/fXm3jGUm4grzMm/0Q5C1ExbnZgeRQeMM3gonZsb+pW+yEpCHSa63PcTShCq/
 REnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754047398; x=1754652198;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3UYHz8SkUO+pfA9GacjbUuiH7qTCY2GBiniHJ7FWPW4=;
 b=R9zfiH+v6KXk294882YgpJsAVZj/Rdc54m+MbusMlXpSuUiEB2bTfi8t+lQ3rmpL4c
 EnHTQmz3mQvpe2OWOEICgCHK9W8iFIGfwGs5tsZwmA08intVBA23IAbNf6wI+xwwD9v/
 5zEDZYCfZ63VcO8QCGfBHZpAW8S7gNFJs1tgtm5lm3R6XRuzexftoe9oNTg3wA/bs3C9
 7HJ3RPNPWrh6rrZ5MgO9BtHHFvy6FSxIblRtUbgimP0lCLRxsh3J2Z3BdzD9uySQQUTI
 WGB3RA8jGmm6GKuqyWhE9I3Pt70PHZgNXTRSL7Z+sHoLsrgSfqPy/Q8ICRoPoet38xW3
 jS0Q==
X-Gm-Message-State: AOJu0Yw+1DViiB0HOEfWaTY5iskXBd7LgRhKEEKkIKrO0T3hSyxBTUVp
 lGQs96/tSrzD6MuLp9Sj5SwqdcCooCXHPxYI62O2Q8JJGeMSsy4YbyAO6EGvDLDWrp6LnRDLtTK
 qatFFlvlX
X-Gm-Gg: ASbGncs9lulKS2DQjHA5ZGnu+q7rq9ydAIQameIxZvUFsG7Pw8oCkHHFbhi29FBnn8h
 K7n893PP2zo1W+XC4X6acV6Hc57iUC7usQPYsxA5K9/+De9sCj7nh8helfVYF62mSj3Sfcb0TbX
 lVD1Ybl3qHoing7R/DtcmgVy7PC+Va4Izcm18z/b8NvNO2uaQ5KOHuFDomqr8MH+Hzwryl8EJWA
 msIhB8lSMeXu5wofnb8z42XvbOoJof+/EJyv7UC+q+xVyPSYN+aMAExxnZKwz3nyK1vYPmj5Nda
 8ehFRycOo3isLBS+jQTxwx78FB4Yw84+lFTq9ezOQLuLGYohQBzCc5Qfw7bdZVucWMRODydjdGM
 eKUXOrMDJbmxVXWYSJyVQvWJo
X-Google-Smtp-Source: AGHT+IFn+paAjTNnd7oGUWcOmnfU61mfgt2YriNpYE4wPRKZU+a8ye+Qsvfmfgm+2VraAU6QRu7law==
X-Received: by 2002:a05:6402:50ca:b0:602:a0:1f2c with SMTP id
 4fb4d7f45d1cf-615ae1b8477mr5260253a12.9.1754047397792; 
 Fri, 01 Aug 2025 04:23:17 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8fe7995sm2576237a12.36.2025.08.01.04.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 04:23:17 -0700 (PDT)
Message-ID: <ff020dd4-1945-4322-89ef-934e174e5f89@monstr.eu>
Date: Fri, 1 Aug 2025 13:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Make XILINX_OF_BOARD_DTB_ADDR depending on
 OF_BOARD only
From: Michal Simek <monstr@monstr.eu>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
References: <063b2e618afb05a32d66218f3631a5f23b30ea3e.1753172103.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <063b2e618afb05a32d66218f3631a5f23b30ea3e.1753172103.git.michal.simek@amd.com>
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



On 7/22/25 10:15, Michal Simek wrote:
> board_fdt_blob_setup() is guarded by OF_BOARD already that's why make no
> sense to depend also on OF_SEPARATE.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
> index f7152d6ee6d5..5c3240da0733 100644
> --- a/board/xilinx/Kconfig
> +++ b/board/xilinx/Kconfig
> @@ -55,7 +55,7 @@ config XILINX_OF_BOARD_DTB_ADDR
>   	default 0x8000 if MICROBLAZE
>   	default 0x100000 if ARCH_ZYNQ || ARCH_ZYNQMP
>   	default 0x83000000 if TARGET_XILINX_MBV
> -	depends on OF_BOARD || OF_SEPARATE
> +	depends on OF_BOARD
>   	help
>   	  Offset in the memory where the board configuration DTB is placed.
>   

Applied.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

