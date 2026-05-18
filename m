Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4B8CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22DE84693;
	Mon, 18 May 2026 16:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UQDzNHem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8464A8467A; Mon, 18 May 2026 16:34:48 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 958DE8469A
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so1370189f8f.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779114886; x=1779719686; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=rwzSfBhLSooGfmZTR2tKTPjnpm4bhJBTtjQrZIDV7WE=;
 b=UQDzNHemyj/mzbRESG9dN3/PAh5loVTK3C27Z3fQUiV9UNZDzSzmt7tJJnmunlEUNi
 4FSCg5Qj5qvRyT3EU0qrLAOrli2xIk2t6vARu9fbTH/nfy4CztnbTejYhhxMT869/z9N
 cpPyfbCit+Vw/zc6DtXaMWa9jiXNQOqqqHv0uTsQQ2+gNLH2moLR/ENCdvYa8onFLoCP
 8oCQi1WiRz5bdlMMxjIcHayC5jgDmN5rQR1L3QJFwC7lrPLFw9+yp5BXr+dBaueXXzeJ
 PFLbY5laFbUSRlcduGoxs4EZ3pl9bt80sSm1V9jgI44/+UiJ/0NjmXmBDijS0ekd9i2L
 IYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114886; x=1779719686;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwzSfBhLSooGfmZTR2tKTPjnpm4bhJBTtjQrZIDV7WE=;
 b=Q7/VCHollPLddJ538taFSjcw/DoUv86PItCXBOq0DPU5TX0GXlSsdm0WzoHfij4arK
 LwsRp+Gb1/l/Da1hjOZrFdyfiOERSBspInCkBRpaG1P5EEmEAGnHuEv71Ww3pxfkCIrn
 yHFfsSkBtMXGN/KJkiSRRmSLSY+jxCctk5eyfnlW9/wtzvp8whooi/0ERPkta1mLvnxM
 iHIerbzklP0lc7l1hwc7dGe+Y9wPjUDs5eID3rvnraGfuTuUE/gaw6E5zxBJVNLoRfRJ
 tvBcoZKLsINmp23qL/C1fcdYL+FcGV+/MdR5KEoDZDE6GbD6arMYQAGEKYdu2zFV16cQ
 5j3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OByoI5jxI32TWHv3IqdJNce6pdVKX6a9N3ppKTK1YDzGISu3Bf7/GSZuOjs1Ocy/NmoloIgc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz82fFz4xUJvn/JKFd50irvZ/OAe7mCOUY+9xC3eVTV6NaE37bx
 DdZn4uALik/cv3tuV+NBc2nx1ygZBD/jn/xLS/RkNVCsxIzFV+jSooyPlZpKijaXccM=
X-Gm-Gg: Acq92OG/DOlVvPmovyNQF0hy4TCPkFHkQQWYZjZxe0bSBRYu5yFTR5SHkfaGFp5+57Y
 /taxpJxZyhQNKjW8PK/hU13cp1Hw7ZNSvBIirhSVD5CyluzWKdfy0usyBC7j2W6QrF1EsiiQINe
 sgmsU1CPV9zzSIrQ5HwOvo0hT6oviLn4NNvJijcu4oOacMkDJijK+k3o+h5jBpT2u/UgKG2gi0p
 X4VYt+J2XauGOjYv2OJBAiL+PzLr36aT6S7pgYcFG/c1ZG4Gj5+ZoQFW37f5yf4Zhx61w86L58x
 t0Ne9kuUgbYU5G5g9yc9K58/YmD5MbPKixvmGpZo0NQFMxsLRed4XTRUw75GO9vu7DckRTCAaPM
 EsQ39vL7JznqcUseXIK+c+ReCIN0aMyZTdHF9HgpKLO1eRt1aCSpFlifaiFIcKUM5A8G3bTjbQy
 WM5sqDHbSd6t8pkASnZUsd0ucGus0gXGCxI4vip1IhFeI2i4wbXT8r+Cdw3nKKWUcuf4zP0E5Li
 D4px4u5iig8PNZ2ag==
X-Received: by 2002:a5d:5d13:0:b0:43d:7a97:78a2 with SMTP id
 ffacd0b85a97d-45e5c5e3384mr25116481f8f.28.1779114885838; 
 Mon, 18 May 2026 07:34:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm35055720f8f.11.2026.05.18.07.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:34:45 -0700 (PDT)
Message-ID: <3ea57cef-c9fa-440a-b72b-6fc7cf4a2656@linaro.org>
Date: Mon, 18 May 2026 16:34:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 04/15] Revert "drivers: smem: sandbox"
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-4-c01ec2ff3886@linaro.org>
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
In-Reply-To: <20260504-b4-modernise-smem-v2-4-c01ec2ff3886@linaro.org>
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

On 5/4/26 20:57, Casey Connolly wrote:
> This reverts commit 7fd7e2cf339ea2ec570f6dae1cdfaf8e066eb4af.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   arch/sandbox/dts/test.dts   | 4 ----
>   configs/sandbox64_defconfig | 2 --
>   configs/sandbox_defconfig   | 2 --
>   3 files changed, 8 deletions(-)
> 
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index ac92ebf1afd7..50201ad61ccd 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -1521,12 +1521,8 @@
>   		compatible = "sandbox,scsi";
>   		sandbox,filepath = "scsi.img";
>   	};
>   
> -	smem@0 {
> -		compatible = "sandbox,smem";
> -	};
> -
>   	sound {
>   		compatible = "sandbox,sound";
>   		cpu {
>   			sound-dai = <&i2s 0>;
> diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
> index 60a30d048750..53f7af4270af 100644
> --- a/configs/sandbox64_defconfig
> +++ b/configs/sandbox64_defconfig
> @@ -240,10 +240,8 @@ CONFIG_SANDBOX_RESET=y
>   CONFIG_DM_RTC=y
>   CONFIG_RTC_RV8803=y
>   CONFIG_SCSI=y
>   CONFIG_SANDBOX_SERIAL=y
> -CONFIG_SMEM=y
> -CONFIG_SANDBOX_SMEM=y
>   CONFIG_SOUND=y
>   CONFIG_SOUND_SANDBOX=y
>   CONFIG_SOC_DEVICE=y
>   CONFIG_SANDBOX_SPI=y
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index f26295103f1c..7f26405e6ed0 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -331,10 +331,8 @@ CONFIG_RTC_RV8803=y
>   CONFIG_RTC_HT1380=y
>   CONFIG_SCSI=y
>   CONFIG_SANDBOX_SERIAL=y
>   CONFIG_SANDBOX_SM=y
> -CONFIG_SMEM=y
> -CONFIG_SANDBOX_SMEM=y
>   CONFIG_SOUND=y
>   CONFIG_SOUND_DA7219=y
>   CONFIG_SOUND_MAX98357A=y
>   CONFIG_SOUND_SANDBOX=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
