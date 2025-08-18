Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC040CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 13:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3BF801BE;
	Mon, 18 Aug 2025 15:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fy/U/Dfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B72801DD; Mon, 18 Aug 2025 15:58:19 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 416C080107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 15:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b9edf504e6so1936276f8f.3
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755525495; x=1756130295; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1S94n1Lj2aywoAfkmv6G9iuPh5IvbuZr+p39q/fQnV4=;
 b=fy/U/DfbbJws4+8ve+mK7tD/68y2OGybKBOPEQzafipye8xyctWqFmC5VFVHT7KZlN
 Aj1MBbkC7xzCPFdZrHKKhaEH5TrEuSNl4mSt+qLXQ/XtJJJd2YDcuzPr3hFA37bMjWJf
 9Z6tFh0a4YiNowaCey8kvGHGocITQHMOefk9BkAm6WM1Rnsb8IvvpdEPCC7EOnul2GLz
 twQr+VraQX0FwJGGLO0FJtNoi698GVPPV0dT9g39U09uHE23QhoL97ZfPJGVu7BYTUfU
 EKM52oBoFJQt1UYoqjvDOmBAOCealmIwqjtmopBnGVk4sQ8xcClBozfQw9O1zPlLxBJy
 OLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755525495; x=1756130295;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1S94n1Lj2aywoAfkmv6G9iuPh5IvbuZr+p39q/fQnV4=;
 b=khCd6vrYITH1rggeshAiv2qHAT/1BZrTg0m4cjPcGEyyYca7eu/M9eOyJpx9lq8KLJ
 LkqBsnxaJJkkJ3iSU+5gv1KYs+RXwDficwXr1DkhbvF38L7jZIxjcZV4Ef8mpvi57quK
 4H7HtPFIFWKZiWTJLRet5gID+XD4NVCW4cY3nU6+nv1nneN4Zf8CxeeMJa3B7JBdaWsn
 D/XAcdZw9PrYMSjbVENkVHaUX1+F2Cieou/PrsnABomXQHsJ4zbJ2b9RvEFdyXpwoJ5Z
 GWF1aGWzWFuvIsttQMeNIaYoPT+OSqN+En9+QJenI23G81MdjqSOGmK5vtAq1tvYJvX8
 fvzw==
X-Gm-Message-State: AOJu0Yzp49UO2Z5MFlbu1fbhSXvAK92omt6kCnn1rtGdavxaELQoSi42
 Yhxz91XB72bVQmnx5g6XLDGdZbX0HBKpM79PqFEb4jZmxOMDvEmWHLzQhNleimduX/YNRpqe3Mc
 l6Itqkdfj0g==
X-Gm-Gg: ASbGnct7iLerWiYnLHg55vF5DUnUqv44foeCwj0eqXc4+OZD3zUSH0yEYnGJGmvAcVz
 +A5PCHvhKYknx8jkP82bhyUHyTx//GWETZF9CvSPi+Pp2REJ8kEZFLyk4hgobaUmnyhdveIlwhw
 cTTx0kYmRQDI8a0ktjC8gcrexLS6tmLbGe/+CjRiqQuKXgiM3wJ7PzVoi6chCoHKFQHKGXiVdS+
 7kTimUsWpymFqCetN7GzZAljF7JljqARy1Y8guNx/O3XnbqFIzP3Rz5/6hMmJyrdY4efXqZWf4u
 4SZcO1p4inos0crsJRvyXpZSqsgFbbKeQbYKzoCMDzQdSV6xtgsuoRSOnv+fccQ4B3IVvqAIkji
 Q+/XYfgrno66T6nVOC6oO0ticS80FxJL492FECnMhyRuUuybdjQuSYMZBG8N/jB5L9oTfl4Hp+M
 14cg==
X-Google-Smtp-Source: AGHT+IF0Fu0YMW3X/SstfbAsRap5RhJkbWpskk7DIq4+wxi1jZRzf9bjqdlvKOIovyZL0ZaxLkn7SA==
X-Received: by 2002:a05:6000:200e:b0:3b7:8cac:821b with SMTP id
 ffacd0b85a97d-3bb66c296e0mr8788083f8f.20.1755525495101; 
 Mon, 18 Aug 2025 06:58:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:2d28:4b2d:6840:1003?
 ([2a01:e0a:3cb:7bb0:2d28:4b2d:6840:1003])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb64d2a405sm13190038f8f.20.2025.08.18.06.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 06:58:14 -0700 (PDT)
Message-ID: <43827d75-e2ad-4c78-b540-112c1cde68e9@linaro.org>
Date: Mon, 18 Aug 2025 15:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Add SYS_FAULT_MII_ADDR to Kconfig
To: Tom Rini <trini@konsulko.com>
References: <20250812175633.3056595-1-trini@konsulko.com>
Content-Language: en-US
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250812175633.3056595-1-trini@konsulko.com>
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

Hi Tom,

On 8/12/25 19:56, Tom Rini wrote:
> The support found under SYS_FAULT_ECHO_LINK_DOWN requires that the
> SYS_FAULT_MII_ADDR symbol also be set. This wasn't previously found in
> Kconfig, so add it now.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> This was found as part of testing "allyesconfig". I'm not sure if
> there's anything useful that could be put in the "help" text here.
> ---
>  README      | 3 ---
>  net/Kconfig | 4 ++++
>  2 files changed, 4 insertions(+), 3 deletions(-)>
> diff --git a/README b/README
> index 65305e6a0371..7808af528625 100644
> --- a/README
> +++ b/README
> @@ -1249,9 +1249,6 @@ Note: once the monitor has been relocated, then it will complain if
>  the default environment is used; a new CRC is computed as soon as you
>  use the "saveenv" command to store a valid environment.
>  
> -- CONFIG_SYS_FAULT_MII_ADDR:
> -		MII address of the PHY to check for the Ethernet link state.
> -
>  - CONFIG_DISPLAY_BOARDINFO
>  		Display information about the board that U-Boot is running on
>  		when U-Boot starts up. The board function checkboard() is called
> diff --git a/net/Kconfig b/net/Kconfig
> index 24508026200d..6d5de9a675e4 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -60,6 +60,10 @@ config SYS_FAULT_ECHO_LINK_DOWN
>  	  this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
>  	  be configured.
>  
> +config SYS_FAULT_MII_ADDR
> +	hex "MII address of the PHY to check for the Ethernet link state"
> +	depends on SYS_FAULT_ECHO_LINK_DOWN
> +
>  config TFTP_PORT
>  	bool "Set TFTP UDP source/destination ports via the environment"
>  	help

This breaks qemu_m68k in CI [1].

[1] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1224987

More specifically:

$ tools/buildman/buildman -o /tmp/build -w -E -W -e --board M5208EVBE
Building current source for 1 boards (1 thread, 24 jobs per thread)
      m68k:  +   M5208EVBE
+.config:598:warning: symbol value '' invalid for SYS_FAULT_MII_ADDR
+
+Error in reading or end of file.
+make[3]: *** [scripts/kconfig/Makefile:75: syncconfig] Terminated
+make[2]: *** [Makefile:647: syncconfig] Terminated
+make: *** [Makefile:198: sub-make] Terminated
+(** did you define an int/hex Kconfig with no default? **)
    0    0    1 /1              M5208EVBE
Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25

Cheers,
-- 
Jerome
