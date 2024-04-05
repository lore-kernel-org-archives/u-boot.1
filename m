Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF922C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 10:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5F9884CD;
	Fri,  5 Apr 2024 12:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LvhQI+Af";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63CB884B2; Fri,  5 Apr 2024 12:37:02 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD75884CD
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 12:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-516d536f6f2so465802e87.2
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712313418; x=1712918218; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QcRYXe/f2Ifxafv8LcL3lAK1E8vWOVXzV9IPbFbVEhc=;
 b=LvhQI+Afanpgt1blkT+jTlzIZ8ufkZxz4AZ0mjCrh8dmD21j8G+dorl4ffkB2RnwyS
 ksxf42Vgofcmy4LEiGz9JvA/ImBqWqpj1XfHPox7dZq7e3oTkqNUa4yZ+5u9HHMpuePy
 iXRiAmScpAcVRfO1Jr0Qkin9pBO3fCp1+8R/kVT5FPdbPtj7lUPD/lL0H7/aJuO88ecg
 nVdbZ3V/gCc+GIH4Yz5/ERLN4SIWd0pR7HvpeVGzYOmivjuYsNwobtHcFO6J02iK46S+
 TQohkuc4b2xgdGjov1idf7+0RxvtkMZbZJBT8SdRW3JPUWbWJmpaYqgubGtZxHM6vOsL
 R4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712313418; x=1712918218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QcRYXe/f2Ifxafv8LcL3lAK1E8vWOVXzV9IPbFbVEhc=;
 b=qCoG9QAOsl5f2G9kAbdGNlID/gVzaH65bkOWlj5aX5abN0DbF7kyr//6F2NIjnZijw
 BB9K7s1/blRt30gHc5R8xzuJTkW8dDv1QsmFRc0AgRdoLTHhXqR71Lh2ZH6IzpET7z63
 FzHlafH2C6ocFST8cK4eO9EkpK3X4VKWLySEg5rqKx1eVWP4J+YNTtzdeBvuBEEX5eYt
 e+J332PDfNmnDJ4tsFZM9u7/xSgQRjWNtK4K7vFxsEaoiG4bYmUd5yjiCnZaXJbO/0h4
 nAxVjD9WPu/IBLNkhp/WT34mR8Tgjv5laNwUU3liGJuAyfY+PHVk4hFboyZ0zIPjN7o4
 KleA==
X-Gm-Message-State: AOJu0YxS9sAUInv6Kjy4H6otYS3t4LCbBb7tSG6EHULiFB6rb5NnnnkN
 w6ypCrEJt7y+CdD6MusrEsfpZOaS8gLTKRuHTxFEKqRWqQMhU/O4Yx5JVKiu0Z0=
X-Google-Smtp-Source: AGHT+IGfBlFOvQSbb7hy/HyU/SJYYeSyfdI/lInkDofRVn2ki9vurSxcH2Qh3h6iCpKi2aMtKcXrgg==
X-Received: by 2002:a19:6915:0:b0:513:ca77:82cc with SMTP id
 e21-20020a196915000000b00513ca7782ccmr816269lfc.8.1712313418386; 
 Fri, 05 Apr 2024 03:36:58 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::4716? ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a170906830500b00a4734125fd2sm684643ejx.31.2024.04.05.03.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 03:36:58 -0700 (PDT)
Message-ID: <667f57a8-e53c-4de8-a9e4-3abfd968b643@linaro.org>
Date: Fri, 5 Apr 2024 12:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] qcom: add clock driver support for SM8550 and SM8650
 SoCc
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
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

Hi Neil,

On 04/04/2024 18:46, Neil Armstrong wrote:
> Add the GCC and TCSRCC clock driver for the SM8550 & SM8650 SoCs.
> 
> The GCC driver uses the clk-qcom infrastructure to support GDSCs,
> Resets and gates. While the TCSRCC is a simpler clock driver which
> only supports gates.
> 
> The GCC enable and set_rate callbacks contains some tweaks to
> setup clocks for Debug UART, SDCard controller and USB.
> 
> The TCSRCC gates returns the XO frequency, which is used by the
> Synopsys eUSB2 driver to determine the PHY configuration.
> 
> In addition, the drivers are enabled in the Qualcomm defconfig.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Neil Armstrong (3):
>        clk: qcom: Add SM8550 clock driver
>        clk: qcom: Add SM8650 clock driver
>        qcom_defconfig: enable SM8550 & SM8650 clock driver
> 
>   configs/qcom_defconfig          |   2 +
>   drivers/clk/qcom/Kconfig        |  16 ++
>   drivers/clk/qcom/Makefile       |   2 +
>   drivers/clk/qcom/clock-sm8550.c | 335 ++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/qcom/clock-sm8650.c | 332 +++++++++++++++++++++++++++++++++++++++
>   5 files changed, 687 insertions(+)
> ---
> base-commit: f0e6aba1218bca578605697eed8aa94582bf57bb
> change-id: 20240404-topic-sm8x50-clock-a76f8359b5fb
> 
> Best regards,

-- 
// Caleb (they/them)
