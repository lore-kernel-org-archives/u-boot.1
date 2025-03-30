Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4EEC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 15:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09DB08144A;
	Sun, 30 Mar 2025 17:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vu2xPGNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A04B881D3B; Sun, 30 Mar 2025 17:18:49 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A6880FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 17:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso26133885e9.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743347925; x=1743952725; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nScqgIFBA+0q/lHN/5AJNBjRHJVC6rzKrANBGwo9LT8=;
 b=vu2xPGNvup2JYPewW48lV2FKKwMIvyqiRHx3RGkoAbzNuUkhijM5sznSGHs75ADRNV
 UBZiQaeqyLOzxFcOwKchswZGpiZQthwWmQKELnh7WmUpt3ZyzcYA2POc3C4JcwHdNz+z
 QkLGPmiX4htnxM4dFHXAj6Q1H0yYeBgdo60M/sXmAJ/sKjWsE813kUy/vMt0NQ3A8Il+
 Hw7I6O52reDDh7utNVVhaeyZv2znnXCllldZjhAzXyiv6HBVrPdEpCQxF0TtiJ0c1Fau
 53lB9xAffMNwsh0x0ZbHU0R/tXt+GAPOK0LnPp7FtdqCkztHhpmigcxwELHugCCGbEii
 YxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743347925; x=1743952725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nScqgIFBA+0q/lHN/5AJNBjRHJVC6rzKrANBGwo9LT8=;
 b=B6kMRJ+Pt9RU1fN2DLqRsafCkSoO4ARQ74u19f2TaW2jm3vLF93gpLvCd0QnAz+5Sd
 UaYxJZ6eFaoaSJKtSvDb66NM1+f8eRHTE6u7sSFSoxYhXDtL2JF1sZMxBXD0TSb9ahfZ
 G83W7zHw1QYqlmMJ/HA+VHuF9UAXU4Xu9xr7GdCX+E/Us0PRDUeiKHJq+880zCj2vUWx
 2rvkG2s2E0SRIVZ9LDn9TQVpzafBn/JbZErc9gNfTA0D4aF1CLvZni90Ut3+q9uZBbgt
 72NzFN5WEgs9RaQS8bqVvLthN0HxKgMBvjw1vxR9f9TIHdFZezeL7n7FZ4JVSAGTop9G
 RE5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4ToGHIGyZumwQejke5V6rnjYjpugWQKHkJrAw4eFRVgJF1fa+6H6EcpK6XAegfSMyGNYNxTU=@lists.denx.de
X-Gm-Message-State: AOJu0YzfkvkYVff6cdc3kzLvR6bRwWZ09ddyXVm1pTmKZjWf7hjHKnYF
 3V0rug3BVstY7st+c3XQWqw3mwRwmVJ4IIJ2ijq1JaP5o3exPhhnD9EwSg66e3k=
X-Gm-Gg: ASbGncuQvm8ve7lu66nMDBW5GqRNTxOPJKjO2RDbYyekwBCjL7iHF1QsbPGjUE4jDR+
 peJOixPBumhwwp5IULJ8WTiJPk311iG2PpTQFCy8zgV9pNz/vCUcWi86tkkA23O9ynjoMNxIY87
 WAGX0DZdDuCda/ZTlD8T6dlb163NL8DoYYAXavO1MsY4TbNb+zZPo2vrQIFoXVTrx3p0gFBOVMF
 9RIT99YWqY1b+iF3WdWtl0k5HqNamh3gp0Y4MCnH9kELYhAeropMxR2REsvpV/I6vyuzwybYpyI
 J3ZCt0Zu6kKtkv8l4i8AsvY51YEWbsscSwrcL3/y7aFb/FG/uhnobXyC2r4q6s+LG1N5wWooUxY
 =
X-Google-Smtp-Source: AGHT+IHjQ1JWCYQR1Hvu4YSJPMKzKdrCsBPxim4tffaTpqagUuZQAbxQ99p5gs9AofAuaS7jp0UgKw==
X-Received: by 2002:a05:600c:83c3:b0:43c:ef13:7e5e with SMTP id
 5b1f17b1804b1-43db62bd98bmr45279775e9.26.1743347924869; 
 Sun, 30 Mar 2025 08:18:44 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbc10e1sm93897775e9.12.2025.03.30.08.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 08:18:43 -0700 (PDT)
Message-ID: <0a322070-9c9b-4ae7-a91c-824535d3f408@linaro.org>
Date: Sun, 30 Mar 2025 17:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] pinctrl: qcom: add driver for SA8775P SoC
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 robert.marko@sartura.hr, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250324080504.2385747-1-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250324080504.2385747-1-quic_varada@quicinc.com>
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

Hi Varadarajan,

On 3/24/25 09:05, Varadarajan Narayanan wrote:
> Add pinctrl and GPIO driver for SA8775P. Driver code is based on the
> similar U-Boot and Linux drivers.

Thanks, this mostly looks good.

[...]

> +static const unsigned int sa8775p_pin_offsets[] = {
> +	  [0] = SA8775_PIN_OFFSET,   [1] = SA8775_PIN_OFFSET,   [2] = SA8775_PIN_OFFSET,
> +	  [3] = SA8775_PIN_OFFSET,   [4] = SA8775_PIN_OFFSET,   [5] = SA8775_PIN_OFFSET,
> +	  [6] = SA8775_PIN_OFFSET,   [7] = SA8775_PIN_OFFSET,   [8] = SA8775_PIN_OFFSET,
> +	  [9] = SA8775_PIN_OFFSET,  [10] = SA8775_PIN_OFFSET,  [11] = SA8775_PIN_OFFSET,

I guess we're really hitting the limit with the current model, and 
should probably just aligned the API here with the Linux one (adding 
struct msm_pingroup, etc).

That's a fair bit of work which isn't fair to drop in your lap, and I 
don't really see a better way of solving this with the current API 
(though I do question if the devicetree is just wrong here?), so I'll 
take this as-is.

That all being said, I feel like some justification for this would have 
been good, either in the commit message (or below it with --- 
separator), certainly it would have saved me the time of 
reverse-engineering why it was done this way.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Kind regards,
> +	 [12] = SA8775_PIN_OFFSET,  [13] = SA8775_PIN_OFFSET,  [14] = SA8775_PIN_OFFSET,
> +	 [15] = SA8775_PIN_OFFSET,  [16] = SA8775_PIN_OFFSET,  [17] = SA8775_PIN_OFFSET,
> +	 [18] = SA8775_PIN_OFFSET,  [19] = SA8775_PIN_OFFSET,  [20] = SA8775_PIN_OFFSET,
> +	 [21] = SA8775_PIN_OFFSET,  [22] = SA8775_PIN_OFFSET,  [23] = SA8775_PIN_OFFSET,
> +	 [24] = SA8775_PIN_OFFSET,  [25] = SA8775_PIN_OFFSET,  [26] = SA8775_PIN_OFFSET,
> +	 [27] = SA8775_PIN_OFFSET,  [28] = SA8775_PIN_OFFSET,  [29] = SA8775_PIN_OFFSET,
> +	 [30] = SA8775_PIN_OFFSET,  [31] = SA8775_PIN_OFFSET,  [32] = SA8775_PIN_OFFSET,
> +	 [33] = SA8775_PIN_OFFSET,  [34] = SA8775_PIN_OFFSET,  [35] = SA8775_PIN_OFFSET,
> +	 [36] = SA8775_PIN_OFFSET,  [37] = SA8775_PIN_OFFSET,  [38] = SA8775_PIN_OFFSET,
> +	 [39] = SA8775_PIN_OFFSET,  [40] = SA8775_PIN_OFFSET,  [41] = SA8775_PIN_OFFSET,
> +	 [42] = SA8775_PIN_OFFSET,  [43] = SA8775_PIN_OFFSET,  [44] = SA8775_PIN_OFFSET,
> +	 [45] = SA8775_PIN_OFFSET,  [46] = SA8775_PIN_OFFSET,  [47] = SA8775_PIN_OFFSET,
> +	 [48] = SA8775_PIN_OFFSET,  [49] = SA8775_PIN_OFFSET,  [50] = SA8775_PIN_OFFSET,
> +	 [51] = SA8775_PIN_OFFSET,  [52] = SA8775_PIN_OFFSET,  [53] = SA8775_PIN_OFFSET,
> +	 [54] = SA8775_PIN_OFFSET,  [55] = SA8775_PIN_OFFSET,  [56] = SA8775_PIN_OFFSET,
> +	 [57] = SA8775_PIN_OFFSET,  [58] = SA8775_PIN_OFFSET,  [59] = SA8775_PIN_OFFSET,
> +	 [60] = SA8775_PIN_OFFSET,  [61] = SA8775_PIN_OFFSET,  [62] = SA8775_PIN_OFFSET,
> +	 [63] = SA8775_PIN_OFFSET,  [64] = SA8775_PIN_OFFSET,  [65] = SA8775_PIN_OFFSET,
> +	 [66] = SA8775_PIN_OFFSET,  [67] = SA8775_PIN_OFFSET,  [68] = SA8775_PIN_OFFSET,
> +	 [69] = SA8775_PIN_OFFSET,  [70] = SA8775_PIN_OFFSET,  [71] = SA8775_PIN_OFFSET,
> +	 [72] = SA8775_PIN_OFFSET,  [73] = SA8775_PIN_OFFSET,  [74] = SA8775_PIN_OFFSET,
> +	 [75] = SA8775_PIN_OFFSET,  [76] = SA8775_PIN_OFFSET,  [77] = SA8775_PIN_OFFSET,
> +	 [78] = SA8775_PIN_OFFSET,  [79] = SA8775_PIN_OFFSET,  [80] = SA8775_PIN_OFFSET,
> +	 [81] = SA8775_PIN_OFFSET,  [82] = SA8775_PIN_OFFSET,  [83] = SA8775_PIN_OFFSET,
> +	 [84] = SA8775_PIN_OFFSET,  [85] = SA8775_PIN_OFFSET,  [86] = SA8775_PIN_OFFSET,
> +	 [87] = SA8775_PIN_OFFSET,  [88] = SA8775_PIN_OFFSET,  [89] = SA8775_PIN_OFFSET,
> +	 [90] = SA8775_PIN_OFFSET,  [91] = SA8775_PIN_OFFSET,  [92] = SA8775_PIN_OFFSET,
> +	 [93] = SA8775_PIN_OFFSET,  [94] = SA8775_PIN_OFFSET,  [95] = SA8775_PIN_OFFSET,
> +	 [96] = SA8775_PIN_OFFSET,  [97] = SA8775_PIN_OFFSET,  [98] = SA8775_PIN_OFFSET,
> +	 [99] = SA8775_PIN_OFFSET, [100] = SA8775_PIN_OFFSET, [101] = SA8775_PIN_OFFSET,
> +	[102] = SA8775_PIN_OFFSET, [103] = SA8775_PIN_OFFSET, [104] = SA8775_PIN_OFFSET,
> +	[105] = SA8775_PIN_OFFSET, [106] = SA8775_PIN_OFFSET, [107] = SA8775_PIN_OFFSET,
> +	[108] = SA8775_PIN_OFFSET, [109] = SA8775_PIN_OFFSET, [110] = SA8775_PIN_OFFSET,
> +	[111] = SA8775_PIN_OFFSET, [112] = SA8775_PIN_OFFSET, [113] = SA8775_PIN_OFFSET,
> +	[114] = SA8775_PIN_OFFSET, [115] = SA8775_PIN_OFFSET, [116] = SA8775_PIN_OFFSET,
> +	[117] = SA8775_PIN_OFFSET, [118] = SA8775_PIN_OFFSET, [119] = SA8775_PIN_OFFSET,
> +	[120] = SA8775_PIN_OFFSET, [121] = SA8775_PIN_OFFSET, [122] = SA8775_PIN_OFFSET,
> +	[123] = SA8775_PIN_OFFSET, [124] = SA8775_PIN_OFFSET, [125] = SA8775_PIN_OFFSET,
> +	[126] = SA8775_PIN_OFFSET, [127] = SA8775_PIN_OFFSET, [128] = SA8775_PIN_OFFSET,
> +	[129] = SA8775_PIN_OFFSET, [130] = SA8775_PIN_OFFSET, [131] = SA8775_PIN_OFFSET,
> +	[132] = SA8775_PIN_OFFSET, [133] = SA8775_PIN_OFFSET, [134] = SA8775_PIN_OFFSET,
> +	[135] = SA8775_PIN_OFFSET, [136] = SA8775_PIN_OFFSET, [137] = SA8775_PIN_OFFSET,
> +	[138] = SA8775_PIN_OFFSET, [139] = SA8775_PIN_OFFSET, [140] = SA8775_PIN_OFFSET,
> +	[141] = SA8775_PIN_OFFSET, [142] = SA8775_PIN_OFFSET, [143] = SA8775_PIN_OFFSET,
> +	[144] = SA8775_PIN_OFFSET, [145] = SA8775_PIN_OFFSET, [146] = SA8775_PIN_OFFSET,
> +	[147] = SA8775_PIN_OFFSET, [148] = SA8775_PIN_OFFSET, [148] = SA8775_PIN_OFFSET,
> +	[149] = SA8775_PIN_OFFSET, [150] = SA8775_PIN_OFFSET, [151] = SA8775_PIN_OFFSET,
> +	[152] = SA8775_PIN_OFFSET, [153] = SA8775_PIN_OFFSET, [154] = SA8775_PIN_OFFSET,
> +};
> +
> +static const struct msm_pinctrl_data sa8775p_data = {
> +	.pin_data = {
> +		.pin_count = 155,
> +		.special_pins_start = 149,
> +		.special_pins_data = msm_special_pins_data,
> +		.pin_offsets = sa8775p_pin_offsets,
> +	},
> +	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +	.get_function_name = sa8775p_get_function_name,
> +	.get_function_mux = sa8775p_get_function_mux,
> +	.get_pin_name = sa8775p_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{ .compatible = "qcom,sa8775p-tlmm", .data = (ulong)&sa8775p_data },
> +	{ /* Sentinal */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_sa8775p) = {
> +	.name           = "pinctrl_sa8775p",
> +	.id             = UCLASS_NOP,
> +	.of_match       = msm_pinctrl_ids,
> +	.ops            = &msm_pinctrl_ops,
> +	.bind           = msm_pinctrl_bind,
> +	.flags          = DM_FLAG_PRE_RELOC,
> +};
> 
> base-commit: 244e61fbb7f5045e4e187024f7ae80434c952145

-- 
Caleb (they/them)

