Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E16C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 17:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3AB87FA0;
	Fri, 15 Mar 2024 18:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uNzQVD8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA0A87FC1; Fri, 15 Mar 2024 17:59:16 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41FEF87F3E
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 17:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1de0f92e649so15385875ad.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710521952; x=1711126752; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CKEVD60P+QbqVVyYDAoPRf3dPAd+jilTcKO8BwAuCow=;
 b=uNzQVD8xDpyBncNoY9dQFoKoLnLnjK71kAVnX6xsZdRFRYm9iNaEOvv9XOMbYFvTcR
 N2eNkJuv6xUlY6ICtGnFOuz0HEZ+xfdS1dcMM12NnK9i54HHgtKAzcg5RdFwMVgFIUXB
 sJf8YIGEg3fFBX5ATq/ZGPIlP8Kpj/cnmBAVrpbkxJtcjqYVBvYix8xzPegiPITsb/t3
 cHktSf6OEqHLyICiWH8pXeCXRa7woSd9MCz1RTyhjsNy+dAsOOrdFjTSi+XRKU5jznAU
 nfXIDU7iqH6eYPfPZfnIb8VQciG3laezn/x7G2Z4SeslfJFyNqWJgCyLC8Bs6E/DdOGz
 A8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710521952; x=1711126752;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CKEVD60P+QbqVVyYDAoPRf3dPAd+jilTcKO8BwAuCow=;
 b=YjeC83wwhNJA+7LVMphPxSsZt6whII+Os9Xt7jgD2KO+0qa/iLMDyZNoAkiZmsZbzV
 RFnKaZk+w8GODsubi1qa2dxzDUBxGqjteoLJy7x2P2y20cJiYwq7SDDJkDdv0nkccnU/
 dylTwc0frdzjpZs83XTf3n3c7sheW/dY7EPPLfeGKlBSdGICv8byV5GtmBD2uvmhAi6S
 C7VSFs4SFEmBb3YkGmX/4WQXUDzVW3hp+1cdkQDNvo8cXbhbvsfu8ZW+2NKm1iLQGGJd
 xtGVKyXHsW2iQeaPO92JyWYANhW1gg50olT/IQChbDtysvmAV7m5BQ+U9HsQ/UbqKhfd
 T55w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY0M91Tqmoe+dB5TFglQKLIUuJ+9LS9+bFt33hfeNZcR6codgsk4QYG0uKeKS5F+INNZwBgKf9WBTnNbhbO0cD6MPiNw==
X-Gm-Message-State: AOJu0Yzvbzr5Jgk8u5fTTrRTzTYxLsIy25TVNgdCjxXBtI0sbxSvBgQt
 fFi30aBiaymjwttFTQ8L2b/5i9YTw7ytkk7Wwo9bQXj6ygVCtUu8kBzwHgrh1P8=
X-Google-Smtp-Source: AGHT+IFxFDA7Gpgco3t2p006dOo3dYmf9MtJ/QRX25FeE33FNz/zMAiUXbi9RiUIo8KK/Xe8WOSJtA==
X-Received: by 2002:a17:903:2b06:b0:1dd:c7e6:de91 with SMTP id
 mc6-20020a1709032b0600b001ddc7e6de91mr5452449plb.12.1710521951708; 
 Fri, 15 Mar 2024 09:59:11 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 jv12-20020a170903058c00b001deecb4f897sm2107451plb.100.2024.03.15.09.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 09:59:10 -0700 (PDT)
Message-ID: <1205cd81-ad2e-414f-a124-69d744164a50@linaro.org>
Date: Fri, 15 Mar 2024 06:58:59 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] arm: clean up v7 and v8 linker scripts for
 bss_start/end
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 trini@konsulko.com, cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
References: <20240315064354.2215266-1-ilias.apalodimas@linaro.org>
 <20240315064354.2215266-3-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240315064354.2215266-3-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 15 Mar 2024 18:15:51 +0100
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

On 3/14/24 20:43, Ilias Apalodimas wrote:
> commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
> and
> commit f84a7b8f54db ("ARM: Fix __bss_start and __bss_end in linker scripts")
> were moving the bss_start/end on c generated variables that were
> injected in their own sections. The reason was that we needed relative
> relocations for position independent code and linker bugs back then
> prevented us from doing so [0].
> 
> However, the linker documentation pages states that symbols that are
> defined within a section definition will create a relocatable type with
> the value being a fixed offset from the base of a section [1].
> So let's start cleaning this up starting with the bss_start and bss_end
> variables. Convert them into symbols within the .bss section definition.
> 
> [0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
> [1]https://sourceware.org/binutils/docs/ld/Expression-Section.html
> 
> Tested-by: Caleb Connolly<caleb.connolly@linaro.org>  # Qualcomm sdm845
> Tested-by: Sam Edwards<CFSworks@gmail.com>  # Binary output identical
> Signed-off-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
> ---
>   arch/arm/cpu/armv8/u-boot-spl.lds        | 18 +++++++-----------
>   arch/arm/cpu/armv8/u-boot.lds            | 16 ++++------------
>   arch/arm/cpu/u-boot.lds                  | 22 +++++++---------------
>   arch/arm/lib/sections.c                  |  2 --
>   arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 15 ++++-----------
>   arch/arm/mach-zynq/u-boot.lds            | 22 +++++++---------------
>   6 files changed, 29 insertions(+), 66 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
