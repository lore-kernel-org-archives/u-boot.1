Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E92FF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0212F8419E;
	Mon, 27 Apr 2026 09:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q40J3Tyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E5998419E; Mon, 27 Apr 2026 09:57:10 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB78B8416F
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79ea87af213so150905227b3.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 00:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777276627; cv=none;
 d=google.com; s=arc-20240605;
 b=jdwAeZ1C8mOF8kzvwrT2b1LMZSMByW3G+PO81lPjQRD7qRoX+bM8/V2oQMI0pMg/aO
 rRY9DdbtZFiK7P9EIzTBsMBhb4lXRKZcHABZ/2QJ9UT35i2kgxbW08aRg385jzDGAfSY
 laDjQqsUdKicKfvuVekHdTqUKXazDhX291HG6cXFYGqLPnMAJnNl9sg20DKBwCEq6qy4
 ciEMXsHB9g9AbrZEBVwJbdTRjQDQVBERs5suppcTtCbZYU2bCMlERc+5U0S9GDls9Ftj
 GrK1m/gl3E9E+8aa5Y0/cybOVIHkK/Sj8JlBoc8hJ/cb/I527wk6YKrX25qdlihWcrzO
 MupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pcMIbqB2kKcYex0D6adCrlJhh6fmpmhPK+/X9OajpsY=;
 fh=ImUlq5X5PTm8yLMTWig4dzxPpH7liUFxG2zCFCr2ynk=;
 b=kcXzBAudslVbO+qlz+/G0NPQxjhV+H+8ZrcAd0dCOyE9dyhCUknGw5LyxEsQKl6jHT
 O0iM15lckw+leC0WzSfJM4d8oYsnmN/2DZJAsHmQjxLNG5nCsizAZ6RuK1EHxFkiwbdk
 EtSW3dgSDbB2yPcfRXyI/niB1DfqfkUVyyWU7ciKPpE8qt7s0x1PAkZfkzcQ1Z6C4Mvm
 xYoUmdmhr2v+rg3mzruLANOLggeQjySugpWl7yWb5KvpL8ILLvFsT09kjLsyksdqDRwa
 yrz8WE/lFkRkSu6vm0dHeAt6cai9aTZWv6H/LjXH5Kdxxm+nslttyLOe29yL0FN7+FeX
 ooYw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777276627; x=1777881427; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pcMIbqB2kKcYex0D6adCrlJhh6fmpmhPK+/X9OajpsY=;
 b=Q40J3TynQANYeDqCb7yrbKCggS+cskf5aIJUWVYdxOew9nnOvN64OJeI3VzYcRi+FI
 VyglAHPJ7JIndkSH/tj63/Yz4EbLBh1DdAOa2nxZ2V2HJ2q3A9WTvC1vUXCTPj77r6dr
 vuLnR4TnPq3JDMm5Tdz1uZgj+5MpMs5ynsw+NnB37dN4RrccwsO5BgvSJcHqopePZQkX
 sdwT6UJE1Wopw/k/p1X5bxXRRTXKwsw5Sjjb+lcBDuRfUyUa9wiAC0vjksnKiFTAJkAx
 sX0TVoBtBRSou6Miw32V6kJ75OapYhJ/mdln6YrjGwQkx1EhlSLpL1+9Mpv/2R/OaCJk
 Q1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777276627; x=1777881427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcMIbqB2kKcYex0D6adCrlJhh6fmpmhPK+/X9OajpsY=;
 b=snc2Ck+8Io21fCEFBgyvXwMyKni1UvLUaQKg/CpPjzKHoUeRygpdZWgrzRS483Mq0O
 O7wtG8QbQXws6vg70lpI3qIE7Wsz9VbU+FGfYqgVBEf50omYG26u/QJ3Eg7laFnNUuvv
 tj8WEF/5zHhkgJxauQYlhqR+cwwoeIT6xELwva3CHBYUvftwkkcAfzgftVSL066FOE8a
 cucz/sV+HFyHSijlc3cJ02avDwGCGMYdfc33lzOTp5iF0P5f39mCn1GH3EdUop0KbrTt
 KmG5udWlVsRjEt+Z3oCT6igBP3/fwdYeB1Fh4b8OuisLj5tRXlI25LFJ/tjtXMw0iJlg
 LDuQ==
X-Gm-Message-State: AOJu0YzW9EKU9ATeZXoCWfxwSVloB0hGSWxjkFXgv2ytvSM6TNXzSCRI
 hwFvDmz8bb/GB7GTOB9Wxkr0NSs1z1niUD/DZxJmyL4bZPsoLHSTlkEn7VgDvu849paHqy78uIy
 PDU3+3ePW+g7K1aQK05WB8BiFKdq4OkQJcWLP45Jquw==
X-Gm-Gg: AeBDieuYETtMuPQeH1adxyrfO8N7Ab144VxJZTJrnP7B5HIZW3b4/5MHK/oxntbmQ5D
 F1x0MiICZ0Y5VHOaJzeTV0u5krcRIOrJYzbi3x0q/CyB4Y6WoHWvCXvbQXToJEul5fmsmKbJ3fK
 OHhHd0CSiX0F+QfH3qT9eK/4JJcpzFQjPZcg9zVMgApIz87jwxlE1xQ0uIUZ2hWRMOxHItFZrUx
 PzXoP8ZpCUPvezDSKjgRp8X00WpENEFE1KZhgixCYDYygfwaCHM294Rpo4Lmvt1nGA+CzoRx0zn
 WEHoEuxwbr19VIlP1lpbkfg5bo5fzh6X0KUNT5xNSqPPwr6KYahq/qz3ZzujDoJfnPRTtSKzsw0
 n0o8nxa/fWVF5bmCsZojFVYIXgZG5sYf59jEp+sCDf4iZS24wLa5Hw5oSVGT9SXfYoXYAIWUWp0
 VdyFcV1EV+6/VPEvC6l+dAUBGcXmV6/5RjULqGKr8rkf7+kJpv0Hd+DlkyizrfEpcZY2yZ5wDpq
 6d92sJOe6vkK8qlvZp0RTJ9HBegf6I1fFw0A2eazwfU/are8g+btyajEg9ZffUDoya7bkmOly3P
 rF9bFcSiteQ6gZlrN6o54NpmjTyrZ3ohrj5SpZr4NqMapiF2qcxJq4exlW5lTQOBYYwI0oBm4T5
 /ulsVNDGby5zehx+Y
X-Received: by 2002:a05:690e:1449:b0:650:97c:b1be with SMTP id
 956f58d0204a3-653118e48ebmr28774011d50.10.1777276626741; Mon, 27 Apr 2026
 00:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-7-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-7-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Apr 2026 10:56:30 +0300
X-Gm-Features: AQROBzDBr5352K_OYYqt4PA0-MzMH7MyeJaoSTfSeMMLPzaiSYwFpZ4vkIyrf1s
Message-ID: <CAC_iWj+X-bkRvymmTWc5gYFFT_bdeRR2E6QesaGxS_ZtOf+pYA@mail.gmail.com>
Subject: Re: [PATCH 06/12] corstone1000: enable bootefi selftest
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 24 Apr 2026 at 20:32, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Enable UEFI selftest command in Corstone-1000 defconfig
>
> Turn on CONFIG_CMD_BOOTEFI_SELFTEST in the Corstone-1000 defconfig
> so the board can run the built-in UEFI self-test suite during
> development and validation.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  configs/corstone1000_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> index 527a679b785..b5fb4868e0f 100644
> --- a/configs/corstone1000_defconfig
> +++ b/configs/corstone1000_defconfig
> @@ -32,6 +32,8 @@ CONFIG_SYS_PROMPT="corstone1000# "
>  # CONFIG_CMD_CONSOLE is not set
>  CONFIG_CMD_FWU_METADATA=y
>  CONFIG_CMD_BOOTZ=y
> +# CONFIG_CMD_BOOTEFI_HELLO is not set
> +CONFIG_CMD_BOOTEFI_SELFTEST=y
>  # CONFIG_CMD_XIMG is not set
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_LOADM=y
> @@ -63,6 +65,7 @@ CONFIG_SYSRESET=y
>  CONFIG_SYSRESET_PSCI=y
>  CONFIG_TEE=y
>  CONFIG_OPTEE=y
> +# CONFIG_CMD_POWEROFF is not set
>  CONFIG_USB=y
>  CONFIG_USB_ISP1760=y
>  # CONFIG_RANDOM_UUID is not set
> --
> 2.34.1
>
