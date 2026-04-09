Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4812AE9DE61
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 08:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E8783693;
	Thu,  9 Apr 2026 10:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HpVpB3vR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D31E083693; Thu,  9 Apr 2026 10:00:56 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F4B83DC9
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 10:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43b983bb07eso313115f8f.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775721653; x=1776326453; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=b0pkEPfVJHYQa0fWxiLYSX8oYgr1zh/pt7pLDfKBF7Q=;
 b=HpVpB3vR17+20bFPL72dMS6tJSWtFqqxmd6uQagSC+o6tJFEoMbeJ7Al9tMI9S0PHN
 UgW32cDiYQVzGHXsjYCQkpzgsj6DJXaQJ+kakvU4iMpil+5m3Uc9Uz2X6vwwCeg26Q0u
 r3Jam48iOf73RPVuOi730CuiS/8gZ3Wx9sIFMejz5JwtNnWBgsj/m7jD9sTojzx9bory
 iHXuq4Ey8p6pisooOUXSzus8kcR1opMLSrBP2jGBThYKjdrpLblfobDcs4/7sGiu6yNI
 WYRCOdPIv8FF5BYVpsWkCryffkpukOJyigp+sahkNwEd66PzFJFLMAE81WlbvMu86JLK
 34sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775721653; x=1776326453;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0pkEPfVJHYQa0fWxiLYSX8oYgr1zh/pt7pLDfKBF7Q=;
 b=qGEtIHMC1oMsWmazfZKIbgJHpDPGTxMgB09W24GPk2HKGxQud3E8yeiOVYyEU3cFm0
 94/OEYKvWbrLZFG2ebxgYBIfUzL7KsH0sKBbm2784tetk2I/0b13/SdIP5CXKaxfYzLL
 16oRwt9fPLW4EagREsGbqziqnmQhfM56BTOIQ89ZPk+trm6Wc0XmuTqXvxSttcvHTITM
 3iBxwTlxidMooKfuNr2aR/exQfWiUME31+WrMTkFmgPk2b0kTTF+mmnfMsMsxbJx84dn
 pn0TfqBqDRFHgsob/nlhNYYMrq1pOUtEchdANDuioLterl/Q+aIDyzNeymc6RUWP5pj5
 In0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfY2dCCflducSgdcXGwFdaZLMezeaSw7Wgym1saIGZqSaAt4sUuUii92fmbe062w0pWIwGw8w=@lists.denx.de
X-Gm-Message-State: AOJu0YwySYyiWUxw0gJZFBg/D1xnlPt6K57r8mAIYYZoGw7ZQoDrSNuc
 NNcXncYYQxKSLeNKHdEpPTqaqNWHt3L8yFUT8DBNoFwPPnSLNZ3oyApEe7UgQ08ruF8=
X-Gm-Gg: AeBDieu8eG3O4IkHFYnJTJFSYo5JIovx57ipO6GZG1uYQ8RZDiyGpl4jYxd6uclAvC/
 ICzvACX7W8CEQn6AU1nnQs+aVSrv4pJ5kT5hZ+emWyAcGP2+klqpG/tdfMLscnU6NpL9IMjGXCI
 qbs1dUp5Ezm+otn50/rdt2OX+Kg6qk7L191J33lq6jhwR8cZlNzx9scFDy3LXwECJ8ZSxRUayHx
 nO6v6KFC6SfzpQZSmQHf2MZvxcUN6PEd0o10GthKixzO82r0S3qYWZhbRHpbdn7o8MxFugQ7QKs
 DrZLihntsKHa+YC27Cm0+yudT99O3Evj4rZWbTHbrVjTDoiEwAEHt0d8crBEX3u7m/vl+5rgFHB
 2JYbE5FqXKfRQ4o88EIuSCC3fU4h6JGBlAx60VIqKzxeMyVIzCCFO3DZvVUIQFHCXRoNBfZAxtq
 /c8LeOTLFsaPzWUHVvvmNxK7HEEMbjCOCS9ecWE3VieB6PQ7bwL1ABD7MJfzPEiT4vf1TtJmGqV
 lFrDvU=
X-Received: by 2002:a05:6000:4313:b0:439:c040:cc8a with SMTP id
 ffacd0b85a97d-43d292e43d7mr36776743f8f.32.1775721653242; 
 Thu, 09 Apr 2026 01:00:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:70d5:8219:5bd4:e213?
 ([2a01:e0a:106d:1080:70d5:8219:5bd4:e213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c5253sm58880667f8f.9.2026.04.09.01.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 01:00:52 -0700 (PDT)
Message-ID: <14d1214a-f787-44eb-b66e-2f6d26deba42@linaro.org>
Date: Thu, 9 Apr 2026 10:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] arm: meson: enable SYSRESET_PSCI
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
 <20260408-b4-amlogic-sysreset-capsules-v1-2-6f3386eb5124@postmarketos.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-2-6f3386eb5124@postmarketos.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/8/26 22:30, Ferass El Hafidi wrote:
> Previously, Amlogic SoCs defined their own reset_cpu() implementation
> that essentially just did what the sysreset PSCI driver already
> supports. To reduce duplication (and allow for EFI Capsule on Disk
> support), make use of it instead of a board-specific reset_cpu.
> 
> This does not affect SPL, as in that stage we do not actually have PSCI
> (BL31 is not loaded yet at that point).
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/mach-meson/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index ef86129b535..a615d871095 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -7,6 +7,8 @@ config MESON64_COMMON
>   	select DM
>   	select DM_SERIAL
>   	select SYSCON
> +	select SYSRESET
> +	select SYSRESET_PSCI
>   	select REGMAP
>   	select PWRSEQ
>   	select MMC_PWRSEQ
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
