Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D651C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 17:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCD980ADF;
	Tue, 18 Feb 2025 18:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e2fMJVWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F6480BAE; Tue, 18 Feb 2025 18:38:19 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7156680646
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38f31f7732dso5026f8f.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739900296; x=1740505096; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kx2Qyu45b/xHJo3j90iUWaUqZxLtQt++JkNM7Mf6q08=;
 b=e2fMJVWbBOM4lipfHo14A8dWT9Ku2uJzuCWn+q/u91dxzRh5hBWE0dyTh6o2PuCdsS
 FL2AYxOIIp6ebfRfWx+s09Y6NumdtsKZarqRm7PJTwlHQZ8irPYdM3nOKN2tyWh2eD6y
 VZXalLEoY/mRkVsH8Vj+HpbaXzUaRZL8lq+DAjX+pyayE5rz47csXxte0Cu2VqKaJwGc
 CyFHkoJXfpH6SRPlZnK1v++ETnJG2PcvLxIu3kIgoBfH3w2sBSeNr35n/OAgg0BPkcVw
 zBQyU1E36uusDb3sSXvHpG77XL6Li8mB0/7nrfqxytwa35u/j0I6QL4PtceG/3DUf0pq
 dnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739900296; x=1740505096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kx2Qyu45b/xHJo3j90iUWaUqZxLtQt++JkNM7Mf6q08=;
 b=hKW7n/aPDHW6fGO675uNadcEhZeLkDfZiEvAYxRAYgfioSHVmDcw425HhJEYMmR84W
 cHuqCPMbF8cZ7z+1hI7+T+c29N4XXHstetQJDjRqcDyONYbHfO+PL8xRhziED9nKk8Og
 ud2Vm2JVD7JeM5RfxvR9hE7UlsyztM1mvfxZ2t2uv/u1smiX4r50TY8TKOGlWArS12cY
 nkdn4V5r3cmr6vdEcYs+FWj9Xt45dHaGG73gifdCdKJWXZ/K6+hj6BtSXKgi6niWsidU
 r4K4HIB0xcvkNJW54TZ1WYm4XmvYWr3RxlvAJ02JIvCyUgpqCnmg6WImm/35i/g57q3g
 zCUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUCZy2w5ERna9+IKpVShBG2+stebAPjpCv2ODY7mFPcd5zJQdKl6Sxk/ALQ/giE6F2jciRb6o=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt4YdCKz0YWT1LJTZWBruYqPf9ATotUOATslFG3U5nETtKPmfa
 gR8/U3HIRzCel39apn70hxcDm65axbpXsRq+qWpTG9SOYKSDtv45A+9JwTxhQog=
X-Gm-Gg: ASbGncsbXIA9EGHDACgemQWBzOkG14vXLWZyof70DTr+gfLDGumLTXxbNx8yXyh04ma
 UpPETB6HaG4MsqQHqeVEfgjgdLi+mAvW4lZqj+cwozhIvo2FA7GM8iZam5BbogcvgQ6zM1VxqIu
 V6NyUSy3SMLgarCcZicuWGSlo7sz/K7TjlP7ZzzQbLQsoQOa/aKdPgGKvbW7n0rpvQgiMuRU8Y4
 fJxHfdspMdeCz9gSqnbGezQNyF5jxuGQ0knDb97TKQV1CjTaDb9ha2LZe7B2fyGW33t/ypRT++2
 rkt/FZ+CnMKC4Uk4876aHRaEUgl8QWiBdqDXDKgkJ3FUpyqFZhdwMrMLCOWfRjmqENyy1KjK
X-Google-Smtp-Source: AGHT+IHdKE7TVX8YRhdoK3gcH+lkWtd4RzbhUcNDRtdh5FAQKolhzkNWAXieVlT7zBbbKvDAEtFpeA==
X-Received: by 2002:a5d:47a1:0:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-38f57ea182bmr699074f8f.25.1739900295735; 
 Tue, 18 Feb 2025 09:38:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:9130:73e1:1d41:9989?
 ([2a0a:ef40:1d11:ab01:9130:73e1:1d41:9989])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddba7sm15803975f8f.38.2025.02.18.09.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 09:38:15 -0800 (PST)
Message-ID: <504430a1-5275-48a5-8f29-3a4c8fdd4269@linaro.org>
Date: Tue, 18 Feb 2025 17:38:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] dts: ipq9574-rdp433-u-boot: add override dtsi
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 robert.marko@sartura.hr, luka.perkov@sartura.hr,
 ilias.apalodimas@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 Volodymyr_Babchuk@epam.com, marek.vasut+renesas@mailbox.org,
 pbrobinson@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250218085430.2422287-1-quic_varada@quicinc.com>
 <20250218085430.2422287-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250218085430.2422287-3-quic_varada@quicinc.com>
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



On 2/18/25 08:54, Varadarajan Narayanan wrote:
> Add initial support for the IPQ9574 MMC based RDP platforms.
> Define memory layout statically.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Fix comments and give additional details
>      No code change
> 
> v2: Use upstream and override DT instead of own DT
> ---
>   arch/arm/dts/ipq9574-rdp433-u-boot.dtsi | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> new file mode 100644
> index 0000000000..390e2338d6
> --- /dev/null
> +++ b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/ {
> +	/* Will be removed when SMEM parsing is updated */
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0x0 0x40000000>,
> +		      <0x0 0x4a500000 0x0 0x00100000>;
> +	};
> +};
> +
> +&sdhc_1 {
> +	sdhci-caps-mask = <0x0 0x04000000>;
> +	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
> +
> +	/*
> +	 * This reset is needed to clear out the settings done by
> +	 * previous boot loader. Without this the SDHCI_RESET_ALL
> +	 * reset done sdhci_init() times out.
> +	 */

Thanks, this should be accompanied by a patch upstream adding this 
property so it can be removed from here later.

Kind regards,
> +	resets = <&gcc GCC_SDCC_BCR>;
> +};

-- 
Caleb (they/them)

