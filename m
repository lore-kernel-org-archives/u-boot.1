Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FA2C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 15:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62A284119;
	Tue, 30 Jun 2026 17:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fyGBfJ0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D8268490A; Tue, 30 Jun 2026 17:44:44 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E1E84105
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 17:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4629051c946so632440f8f.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782834281; x=1783439081; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E7yPN89FmMCs0FJHxLsLK6ePCa4fduPHd54v3rLIlh8=;
 b=fyGBfJ0X3yxhXgeVJVpHH3q9dgq8JwFgMz1rPnXUB8r3NGDqnOCd8tzoE92GuVypTa
 hoLk/hC5XI8Ap1m/f7YljmirUIASz0AYVpd8tpWxeXzV01nqbh+ZrObwk3ZfKRGRLUCX
 +9ZEOU9OY6fNqgFCUBXv3MrgolO9SjedBlpfauagfGwOHzXv/Apv+0HQBFI6AUaDuQYw
 Oli6WXe7wYmgQqOOZPKf196EIc8FGod4AVd3wN2UR58eAjR3/fipfhhCqx7q1kIJgl7R
 EYTKpq8trKr4QAHHk6t8M4CUrONL7hg3v6DQupKnnqYfHHqj+Hf5fZRQCaBZjA1Se6Yk
 GC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782834281; x=1783439081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E7yPN89FmMCs0FJHxLsLK6ePCa4fduPHd54v3rLIlh8=;
 b=EDcMU928u6JhZgtx/HTj94PlTTc+R2XM/8wyimK3FpNI7Jva/WBPmENNDeGmwIQDC3
 BLsgzLR6GPpkl1wVDWPuoYLuzkD4DEuQlK8GLYBmbmsbmtCr5iOx6nkGUKnqDNMzpsw2
 GSemOxcRdE8Ox2JJ0Hdrzq6DK3ij96I3UHjmsOzyOpXavThyMjp38E+5sWa74R99iNV4
 8Byj64Ji0f/7wgJzQ/IVDfMrJZEbGgPQkOHc3fOfiSwGa87BYFp4YCFPT+IYHbT753qk
 4iqOuHXEC/E5YqxUdlXHkUkU1VyttDBtWNR8HvtiBOmiYkf7tGqozqFqRE/C/79FOOr7
 SaCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMd0WzjbhudfLmC076hmXd0wGEiTECg0VxJru7Y6KTOrJ+Koehygk77c5cc4HsoKMpNLm1Les=@lists.denx.de
X-Gm-Message-State: AOJu0YxpFe7vUGc869l792luDCvqSkKupNqvSC9FtKsL3uzpN1klUOOW
 rqVkRoPoEhv7Di8JZaksT8P2KzbZ9rcgO15m3QbUyz+BXFRDFhxdgO5cAIGCCKyF1cc=
X-Gm-Gg: AfdE7cluLMhjJUGcoxm7CTxMJbCJI4E9O0tBe7FLg8kaA882XaIE2zB+QlIcyWWLis/
 A7O2G3bWTIFBS+lUKIkuJxRZT4A7BM9CEsSuDErbMrekqhTWNU9m2bnc4ovGxTlbnu4dgSQ8tXj
 2KA8IhEbWOi1Pl6r27kTqn7aiwq1uoYu4XEnwSO+nRt6ZUkluZPE+Sy6x4SAZ4fFVic4bLrZKJi
 7gNYGW5fu8CAbh+93wggLg9X4CHh2uwr5PMDF0DKnwZCWBtu7qS2jGpZqZaNFbpDxNGnkiTD2zi
 0tMJnI+S1xrDZskIJFrMAsr/A41bgpZNhXexI0Iu806GQktjMImy01nQ6wSCmDbpvzuKnGvU54J
 oYrIRsDBnX/GNmxH0wZaPt+mgwJ8r65asnpuHIl5rVFYTPvfKg1EzMY2k/XmtVBvQ1hs1sDDqub
 ltmOBkKpDNHB6MnA84DHdFjCDN9OQ=
X-Received: by 2002:a05:6000:2386:b0:475:f0c2:75b0 with SMTP id
 ffacd0b85a97d-475f743ba52mr3257932f8f.27.1782834281287; 
 Tue, 30 Jun 2026 08:44:41 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636ce7esm9374897f8f.23.2026.06.30.08.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 08:44:40 -0700 (PDT)
Message-ID: <c281dc48-a940-4d6f-a886-040a75d6a0b0@linaro.org>
Date: Tue, 30 Jun 2026 17:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm: dts: ipq9650: Add override dtsi
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>, trini@konsulko.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, quic_varada@quicinc.com, luca.weiss@fairphone.com,
 danila@jiaxyga.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, adrian@mainlining.org,
 david.wronek@mainlining.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
 <20260610053655.2825589-4-badhrinath.s@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260610053655.2825589-4-badhrinath.s@oss.qualcomm.com>
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



On 6/10/26 07:36, Badhrinath S wrote:
> Add U-Boot specific device tree overrides for IPQ9650 RDP488 board.
> This includes memory configuration and SDHCI reset configuration.
> 
> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
> ---
> Changes in v2:
> - Fix SPDX license identifier to GPL-2.0-only (reported by Ferass)
> 
>   arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 29 +++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>   create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
> new file mode 100644
> index 000000000000..4733fc7ccd08
> --- /dev/null
> +++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * IPQ9650 RDP488 board device tree source
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/ {
> +	/* Will be removed when SMEM parsing is updated */
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x20000000>;
> +	};
> +
> +};
> +
> +&sdhc {
> +	sdhci-caps-mask = <0x0 0x04000000>;
> +	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
> +
> +	/*
> +	 * This reset is needed to clear out the settings done by
> +	 * previous boot loader. Without this the SDHCI_RESET_ALL
> +	 * reset done sdhci_init() times out.
> +	 */
> +	resets = <&gcc GCC_SDCC_BCR>;

Send these fixes upstream please.> +
> +	status = "okay";
> +};

