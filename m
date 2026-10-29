Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66E606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cjo9OtAl;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H8G28sQQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D45680FEF;
	Thu, 29 Oct 2026 18:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DMUU38BjHyTG; Thu, 29 Oct 2026 18:48:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6FA3280F7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793299690;
	b=No2jhWvbXBJRsRY+t+JiQHHp/yPoaLwCNV+tz2cZcibhz1s7hCUu387sjn+UJD96MKly
	 GxeSzPVM9jxQpMKZjfyEZC1D/gehuiDKR4x3AQnRjDiIXZEfA9cQD0e3v8kAF1XHUm9VK
	 ZD3OCmjU03Is2IRRDMBM2YoCliYTbUQgS7rjDcieEEUfMEYlcQvvuyhx6fYYsRjOTIkX0
	 kMIQHOwWjDRctOlON72jeYmAfFraAJGO6c2c5EQi84dKp9YKpLMf40DkEwHZ11o+syePJ
	 XRjsZUY/+T3gicQYHKW8T5twAijU8XXSEmPvDzHwC++is1SWYILGBRrkjOhTJPjvf2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793299690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Kl/VQVuHNQv1vqGa+0S7vtk3vXRSi1qIhrW248O9qi0=;
	b=ImJ/xZ3ZmR8ORx3RF9+qNTRbUJOzLgzo6A4jIQDpo2px+e0qfC41407G9ox4YwySKimy
	 4OWmyn1vU2CITsSFzsIiYhZjb7hgAEokv19dfLl4qyKLcokTAig+OVjPNi15FFQPEw6J7
	 IQ32BnQFArlgnxtn9YhtDhAv6/nyfhqbVIPeJyiFBd34A8JZI2+Kqq1TmOyehtqgSye0N
	 Rt79Y993R3iWXWVji6Z+uT/7jShXVIiZCC2UCpHBabNjXyeHqxlF11grcErGZM/xccM5u
	 CQKHetNMv66AROAQtyaEy1w0k49Hlmb364JOzt32VBatyBOcHwFoIJ1waeXLsIsxgEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793299690;
	bh=Kl/VQVuHNQv1vqGa+0S7vtk3vXRSi1qIhrW248O9qi0=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cjo9OtAl/N6tL9fPpEaSnhokVAeV4bm+VwuPoqdSZ8cCaKbKmIYHVad+3Vtt1vrxU
	 U0kvM8/emQYq0cARL76jEVoZ3Bpr6crGFixTH6GEBZH2vdtRa8SqJFJv8pZrVFXJEk
	 mIi2ROvxNqkS4j2m+7Jycvzipw77r/ZxW0lq4L8xQ7j6VFCN435DKIEVMviQ507wNT
	 C98GxGMuTcVlr8Yyx7OmQiWxV/XbsLqCZLKqw5KFdA9c9QhBQ5hYXTG5ff4WewyGrO
	 nRn2JCa+pnJ6AKo04++7vTYT8R5+5yYuBDqqXCm2mI28OuOJfw0hzYWEVCtXiD7pkN
	 f11ZwZIJra0tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FA3280F7A;
	Thu, 29 Oct 2026 18:48:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C999C2E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBA6C606B0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:48:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 96G0cgYaFLis for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 18:48:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9ADAE60697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793299687;
 b=tCfCK+uDYnYYWrvt9LOZY0eezlqTVtNKcBlHwdEOOZvL1pftHLCq7zweEk1YivYzQcd1
 MuXDoieP6/jtZ5UY0we9NDq9+fvNuEYPPhCRvsi4uVxeyW98BMA36Cr4Y2RNaKp2pRVb7
 T4nEEFkTd233nxilvwL1yijlPK0xvaylMzOF4Y+RnGw+cAp6gdeDBEexMY8GkCo2M1Bwb
 3jo8LoGgBoHim/vaYvu8yxnFP78X05r+khSF5InYdvGxNDsiMXJ1+l9bOJm9FeSSTAbDo
 wTpYoRLH0m7/0DWGqbWMdjj3SPm4jyPB91HLKnw7I9mczCx6+VIkMtcByoyHw5i4ZpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793299687;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=Kl/VQVuHNQv1vqGa+0S7vtk3vXRSi1qIhrW248O9qi0=;
 b=drQ+DahEv2LIfBFuU6BRlVLTeF9qJBfTY4Sff/qDrxEQjyg4AFTKWOGAGyY1UK7HsGuU
 SkEV2GLJVHjhcfod6qb7cehIpog5mT71vJTvS+iwCTEcHA00uB+Ho2Olxp/81M1lLzdBS
 B7VToMORzOxY6F5aTkllLFV5dASzQBjaQ4kZnOOegIK7GByvf+BgoCpxCqgLs2ujQbWwB
 jinmQs7S8sLnAUhNWUvy9X+T+qDNxPCFOwp0nNm7P1olpwbRy2IrBWFYl5ZS9y8rRM3t2
 QeDvwggcC92DBkjYshpftHNUKxa8d2yRvsNjMhee0nm3ILBgSM11tIUVq7pRwHrtxTQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=H8G28sQQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=H8G28sQQ
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ADAE60697
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:48:05 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so30005605e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793299684; x=1793904484;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kl/VQVuHNQv1vqGa+0S7vtk3vXRSi1qIhrW248O9qi0=;
 b=H8G28sQQR03Wpr2VhSxVe3Hbc5XOixUVGMOf3wj3OaAOHr/VICMj6WyZ+t1OYiz7wV
 NnYR4aiK6OPQs6sdCD0w+2E/3Ku49h8yOduRPdOmNaah90Cw27Dwyi+sYoFEDfh0Stk3
 Q7VmEVup45mRvUNiMOGCVfWm8hOYPnhfNFpDw/nDfCzW6BamjmSEh3rS5Jew2u1ohPI1
 egtkYETuGC34lTYCsfE+c45RkzxsRznrld198CSUiQA1yYrKeT1Sxm6pK0PDVbYg8vpg
 Imz5PSAaaDbQsL/gqDoen5XUfb0ifr/DalHg/NpPdZtzDh7MSjLZmTXjrUrPYJFrFN9G
 fsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793299684; x=1793904484;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Kl/VQVuHNQv1vqGa+0S7vtk3vXRSi1qIhrW248O9qi0=;
 b=orKVa8BM1ARB0zxjCsGGzLKpaTscAv7sOIK7WyKZq5JGBbxhsUfPLZHfZadAn1+q8Q
 DN1EV0eBovIOP76MhJpxGUrMDlJ5mp5zrJ6hmHB6R3pGS5rUZvVHbL4HX+IqTwjzx0zS
 fJ9Ncbjq4CDQpww0ZJczs4uZxaVExAG6xcYKFFYz2mEtmq5fsxY9UHxiHKY5lCkhtq6S
 81mJ3Bv3RcHhr1L0C+Mu6oiGvuRR9BQVyB9JCGr0Hpb7vHriSLEVy17WQNHmzoYYJFa5
 NmH4jRinuzOOKuYDWoXl59z7pyEQ1JLcMGOQvI4lKm+A02sr/RAMkNoTXpaM6O9Chizb
 QWKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxstehxVdcO255BeexuHkUsJ0kBXCH2tU14+FS3peimemYMmvbZ20cD05lp8p+J2Ac13/PXUXY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIgfDYwGDI7OzKeQWh/GTBXiiE0pz+IlskEjKW27efhfAs7Q5Rn
 ntqGIbG3n4QXlQjwuvI4p2hF4JFjY6V4ofaXlQRO2xNy5QaEGETw6u2kVCoLW+Ji9QU=
X-Gm-Gg: AYBFou3zPE5C6/+9VL0GEPHN7xCcP8+1O3ZowAF8JTYTIVQHLUTjvTc8+R3NYwqiQfn
 ws+GJ8UkMq7QwkWOHNi8+AHm3I86inv9X07hNsEsNsZ9Khb/tg8x4GdmWKvyvGmbbxZh/1SxlwO
 kwagjIDVnxqoU7/gAEh7IJ9fW6ArXTsZdzngNRckHHgfArMjVJwvs3scdZvHwj1wj2gbhyXQefH
 JzERISZtjJGTXTnmPAQCQiqlUWjIkvZApoa3Z08lKBbZXz50HiFDIy17FtZQn9fCdsQQkJjOBGD
 rG1iSfDa1LSiFwHITBhTL4g8DRgE5yBBBrQX/oJox1mTRBzRvYILj2XfkHnl57ZaMxGhwptNnyp
 9sZh9eXVe+HMXFG99TbstjXQv0vrbTtUShB+6HaIPwW7eUdXJTOjHAuYXSN1z0OrjMwZm/HfCkn
 5cmwUfEA1eopKpgjdwNJlB+8zChYEUv5CzuyJkVexK1x5okAkaVSUYaWbrF+mMMxjdxZqi/1QhN
 GWcff1/CUM15Kp5d6QjDED/eibrdEfQxhda5JG+Hk6WeNQVhr46sbmFidgs5z5Czb7v/UIs4Cf8
 IuDB2yn1cQmpUIKvyoYpd2UHwlmSXjfClUF4NgaNDMGpdn/qJR5sNxz+3SXK43Z4J8SI
X-Received: by 2002:a05:600c:a314:b0:4a3:5d64:df91 with SMTP id
 5b1f17b1804b1-4a96b29d208mr112638055e9.18.1793299683796; 
 Thu, 29 Oct 2026 11:48:03 -0700 (PDT)
Received: from [192.168.1.37] (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7c5063e3sm83780765e9.0.2026.10.29.11.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 11:48:02 -0700 (PDT)
Message-ID: <9a5b5220-3c37-4779-839d-08b0690c71d4@linaro.org>
Date: Thu, 29 Oct 2026 19:48:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: msm_sdhci: add HS200/HS400 support
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, nathbappai@gmail.com,
 varadarajan.narayanan@oss.qualcomm.com, quentin.schulz@cherry.de,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
 <20260902170559.3225833-3-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260902170559.3225833-3-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 02/09/2026 19:05, Aswin Murugan wrote:
> The Qualcomm SDHCI driver lacked DLL init/calibration and tuning
> support, so it never negotiated above high-speed/DDR52. Add the
> CM_DLL init/phase-tuning sequence for HS200 and the SDC4 DLL
> calibration for HS400, matching the SDCC core generation variants
> already distinguished in this driver.

Please check this actually builds, you need to select a config option to
expose MMC tuning support, and ensure we can also build without it for SPL.

Thanks

> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  drivers/mmc/msm_sdhci.c | 752 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 751 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index e0753a1cd5d..668aadf6c6e 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -15,7 +15,9 @@
>  #include <wait_bit.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +#include <linux/iopoll.h>
>  #include <power/regulator.h>
> +#include <memalign.h>
>  
>  /* Non-standard registers needed for SDHCI startup */
>  #define SDCC_MCI_POWER   0x0
> @@ -38,6 +40,52 @@
>  #define CORE_DLL_PDN		BIT(29)
>  #define CORE_DLL_RST		BIT(30)
>  
> +/* DLL configuration */
> +#define CORE_DLL_EN		BIT(16)
> +#define CORE_CDR_EN		BIT(17)
> +#define CORE_CK_OUT_EN		BIT(18)
> +#define CORE_CDR_EXT_EN		BIT(19)
> +#define CORE_DLL_LOCK		BIT(7)
> +#define CORE_CMD_DAT_TRACK_SEL	BIT(0)
> +
> +#define CDR_SELEXT_SHIFT	20
> +#define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
> +
> +/* MCLK frequency selection (CMUX_SHIFT_PHASE) - required for the DLL to lock */
> +#define CMUX_SHIFT_PHASE_SHIFT	24
> +#define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
> +
> +/* 14LPP DLL reset / Tassadar DLL extras, for SDCC minor >= 0x42 / 0x71 */
> +#define CORE_DLL_CLOCK_DISABLE	BIT(21)
> +
> +#define DLL_USR_CTL_POR_VAL	0x10800
> +#define ENABLE_DLL_LOCK_STATUS	BIT(26)
> +#define FINE_TUNE_MODE_EN	BIT(27)
> +#define BIAS_OK_SIGNAL		BIT(29)
> +
> +#define DLL_CONFIG_3_LOW_FREQ_VAL	0x08
> +#define DLL_CONFIG_3_HIGH_FREQ_VAL	0x10
> +
> +#define CORE_CLK_PWRSAVE	BIT(1)
> +
> +/* Timing mode selection */
> +#define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
> +#define CORE_HC_MCLK_SEL_HS400	(3 << 8)
> +#define CORE_HC_MCLK_SEL_MASK	(3 << 8)
> +#define CORE_HC_SELECT_IN_EN	BIT(18)
> +#define CORE_HC_SELECT_IN_HS400	(6 << 19)
> +#define CORE_HC_SELECT_IN_MASK	(7 << 19)
> +
> +/* HS400 DDR/SDC4 DLL calibration, needed alongside the SDR CM_DLL above */
> +#define CORE_DDR_CAL_EN		BIT(0)
> +#define CORE_DDR_DLL_LOCK	BIT(11)
> +#define CORE_PWRSAVE_DLL	BIT(3)
> +#define CORE_CMDIN_RCLK_EN	BIT(1)
> +#define DDR_CONFIG_POR_VAL	0x80040873
> +
> +#define CORE_FREQ_100MHZ	(100 * 1000000)
> +#define MAX_PHASES		16
> +
>  #define MHZ(X) ((X) * 1000000UL)
>  
>  struct msm_sdhc_plat {
> @@ -50,14 +98,39 @@ struct msm_sdhc {
>  	void *base;
>  	struct clk_bulk clks;
>  	struct udevice *vqmmc;
> +
> +	/* HS200/HS400 tuning and calibration state */
> +	bool tuning_done;
> +	bool calibration_done;
> +	u8 saved_tuning_phase;
> +
> +	/* DLL init sequence variant selection, from the SDCC core version */
> +	u32 dll_config;		/* qcom,dll-config DT override, 0 if absent */
> +	bool use_14lpp_dll_reset;	/* core_minor >= 0x42 */
> +	bool uses_tassadar_dll;		/* core_minor >= 0x71 */
> +
> +	/* HS400 support */
> +	bool use_cdclp533;		/* core_minor < 0x34, legacy calibration path */
> +	bool updated_ddr_cfg;		/* core_minor >= 0x49 */
> +	u32 ddr_config;			/* qcom,ddr-config DT override, else POR value */
>  };
>  
>  struct msm_sdhc_variant_info {
>  	bool mci_removed;
>  
>  	u32 core_dll_config;
> +	u32 core_dll_status;
> +	u32 core_dll_config_2;
> +	u32 core_dll_config_3;
> +	u32 core_dll_usr_ctl; /* Present on SDCC5.1 onwards */
>  	u32 core_vendor_spec;
>  	u32 core_vendor_spec_capabilities0;
> +
> +	/* HS400 DDR/SDC4 calibration registers */
> +	u32 core_ddr_200_cfg;
> +	u32 core_vendor_spec3;
> +	u32 core_ddr_config_old; /* Applicable to sdcc minor ver < 0x49; 0 if N/A */
> +	u32 core_ddr_config;
>  };
>  
>  static int msm_sdc_clk_init(struct udevice *dev)
> @@ -149,12 +222,624 @@ static int msm_sdc_mci_init(struct msm_sdhc *prv)
>  	return 0;
>  }
>  
> +static int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
> +{
> +	u32 ck_out_en;
> +	struct udevice *dev = host->mmc->dev;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	int ret;
> +
> +	ret = read_poll_timeout(readl, ck_out_en,
> +				(!!(ck_out_en & CORE_CK_OUT_EN) == poll),
> +				1, 50,
> +				host->ioaddr + var_info->core_dll_config);
> +	if (ret) {
> +		printf("%s: CK_OUT_EN bit is not %d\n",
> +		       host->name, poll);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
> +{
> +	int rc;
> +	static const u8 grey_coded_phase_table[] = {
> +		0x0, 0x1, 0x3, 0x2, 0x6, 0x7, 0x5, 0x4,
> +		0xc, 0xd, 0xf, 0xe, 0xa, 0xb, 0x9, 0x8
> +	};
> +	u32 config;
> +	struct udevice *dev = host->mmc->dev;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +
> +	if (phase > 0xf)
> +		return -EINVAL;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~(CORE_CDR_EN | CORE_CK_OUT_EN);
> +	config |= (CORE_CDR_EXT_EN | CORE_DLL_EN);
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	rc = msm_dll_poll_ck_out_en(host, 0);
> +	if (rc)
> +		return rc;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CDR_SELEXT_MASK;
> +	config |= grey_coded_phase_table[phase] << CDR_SELEXT_SHIFT;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CK_OUT_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	rc = msm_dll_poll_ck_out_en(host, 1);
> +	if (rc)
> +		return rc;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CDR_EN;
> +	config &= ~CORE_CDR_EXT_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	return 0;
> +}
> +
> +/*
> + * Programs the MCLK_FREQ (CMUX_SHIFT_PHASE) field. Must be set before
> + * enabling CORE_DLL_EN/CORE_CK_OUT_EN, otherwise the DLL will not lock.
> + *
> + * host->clock is not updated by the generic sdhci.c, so mmc->clock is
> + * used instead.
> + */
> +static void msm_cm_dll_set_freq(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	struct mmc *mmc = host->mmc;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 mclk_freq = 0, config;
> +	unsigned int clock = mmc->clock;
> +
> +	if (clock <= 112000000)
> +		mclk_freq = 0;
> +	else if (clock <= 125000000)
> +		mclk_freq = 1;
> +	else if (clock <= 137000000)
> +		mclk_freq = 2;
> +	else if (clock <= 150000000)
> +		mclk_freq = 3;
> +	else if (clock <= 162000000)
> +		mclk_freq = 4;
> +	else if (clock <= 175000000)
> +		mclk_freq = 5;
> +	else if (clock <= 187000000)
> +		mclk_freq = 6;
> +	else if (clock <= 200000000)
> +		mclk_freq = 7;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CMUX_SHIFT_PHASE_MASK;
> +	config |= mclk_freq << CMUX_SHIFT_PHASE_SHIFT;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +}
> +
> +static int msm_dll_poll_lock_status(struct sdhci_host *host)
> +{
> +	u32 dll_status;
> +	struct udevice *dev = host->mmc->dev;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	int ret;
> +
> +	ret = read_poll_timeout(readl, dll_status,
> +				(dll_status & CORE_DLL_LOCK),
> +				1, 50,
> +				host->ioaddr + var_info->core_dll_status);
> +	if (ret) {
> +		printf("%s: DLL failed to LOCK (DLL_STATUS=0x%08x)\n",
> +		       host->name,
> +		       readl(host->ioaddr + var_info->core_dll_status));
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +/* CM_DLL initialization sequence */
> +static int msm_init_cm_dll(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config;
> +	int ret;
> +
> +	/*
> +	 * Keep the clock enabled while DLL tuning is in progress; PWRSAVE
> +	 * may otherwise turn it off.
> +	 */
> +	config = readl(host->ioaddr + var_info->core_vendor_spec);
> +	config &= ~CORE_CLK_PWRSAVE;
> +	writel(config, host->ioaddr + var_info->core_vendor_spec);
> +
> +	if (priv->dll_config)
> +		writel(priv->dll_config, host->ioaddr + var_info->core_dll_config);
> +
> +	if (priv->use_14lpp_dll_reset) {
> +		config = readl(host->ioaddr + var_info->core_dll_config);
> +		config &= ~CORE_CK_OUT_EN;
> +		writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +		if (var_info->core_dll_config_2) {
> +			config = readl(host->ioaddr + var_info->core_dll_config_2);
> +			config |= CORE_DLL_CLOCK_DISABLE;
> +			writel(config, host->ioaddr + var_info->core_dll_config_2);
> +		}
> +	}
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_DLL_RST;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_DLL_PDN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	/*
> +	 * MCLK_FREQ must be programmed while the DLL is reset and powered
> +	 * down, unless a DT dll-config override is in effect.
> +	 */
> +	if (!priv->dll_config)
> +		msm_cm_dll_set_freq(host);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CORE_DLL_RST;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CORE_DLL_PDN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	if (priv->use_14lpp_dll_reset) {
> +		if (!priv->dll_config)
> +			msm_cm_dll_set_freq(host);
> +
> +		if (var_info->core_dll_config_2) {
> +			config = readl(host->ioaddr + var_info->core_dll_config_2);
> +			config &= ~CORE_DLL_CLOCK_DISABLE;
> +			writel(config, host->ioaddr + var_info->core_dll_config_2);
> +		}
> +	}
> +
> +	/* Applicable to SDCC v5.1 onwards only */
> +	if (priv->uses_tassadar_dll && var_info->core_dll_usr_ctl) {
> +		config = DLL_USR_CTL_POR_VAL | FINE_TUNE_MODE_EN |
> +			 ENABLE_DLL_LOCK_STATUS | BIAS_OK_SIGNAL;
> +		writel(config, host->ioaddr + var_info->core_dll_usr_ctl);
> +
> +		if (var_info->core_dll_config_3) {
> +			config = readl(host->ioaddr + var_info->core_dll_config_3);
> +			config &= ~0xFF;
> +			if (host->mmc->clock < 150000000)
> +				config |= DLL_CONFIG_3_LOW_FREQ_VAL;
> +			else
> +				config |= DLL_CONFIG_3_HIGH_FREQ_VAL;
> +			writel(config, host->ioaddr + var_info->core_dll_config_3);
> +		}
> +	}
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_DLL_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CK_OUT_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	ret = msm_dll_poll_lock_status(host);
> +	if (ret)
> +		return ret;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CDR_EN;
> +	config &= ~CORE_CDR_EXT_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	priv->calibration_done = false;
> +
> +	return 0;
> +}
> +
> +/*
> + * HS400 DDR calibration via SDC4 CM_DLL, used when use_cdclp533 is false
> + * (core_minor >= 0x34).
> + */
> +static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config, ddr_cfg_offset, wait_cnt;
> +	int ret;
> +
> +	/*
> +	 * core_ddr_config defaults to the desired configuration on reset;
> +	 * reprogram the POR value in case an earlier bootloader stage
> +	 * modified it.
> +	 */
> +	if (priv->updated_ddr_cfg)
> +		ddr_cfg_offset = var_info->core_ddr_config;
> +	else
> +		ddr_cfg_offset = var_info->core_ddr_config_old;
> +	writel(priv->ddr_config, host->ioaddr + ddr_cfg_offset);
> +
> +	config = readl(host->ioaddr + var_info->core_ddr_200_cfg);
> +	config &= ~CORE_CMDIN_RCLK_EN;
> +	writel(config, host->ioaddr + var_info->core_ddr_200_cfg);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config_2);
> +	config |= CORE_DDR_CAL_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config_2);
> +
> +	ret = -ETIMEDOUT;
> +	wait_cnt = 100;
> +	while (wait_cnt--) {
> +		if (readl(host->ioaddr + var_info->core_dll_status) &
> +		    CORE_DDR_DLL_LOCK) {
> +			ret = 0;
> +			break;
> +		}
> +		udelay(10);
> +	}
> +
> +	if (ret) {
> +		printf("%s: CM_DLL_SDC4 calibration was not completed\n",
> +		       host->name);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Skip CORE_PWRSAVE_DLL for the 14lpp DLL reset variant: it cannot
> +	 * guarantee the MCLK-gating timing PWRSAVE_DLL depends on.
> +	 */
> +	if (!priv->use_14lpp_dll_reset) {
> +		config = readl(host->ioaddr + var_info->core_vendor_spec3);
> +		config |= CORE_PWRSAVE_DLL;
> +		writel(config, host->ioaddr + var_info->core_vendor_spec3);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * HS400 DLL calibration, performed once when transitioning into HS400 at
> + * clock > 100MHz.
> + */
> +static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config;
> +	int ret;
> +
> +	ret = msm_init_cm_dll(host);
> +	if (ret)
> +		return ret;
> +
> +	/* Restore the phase found during HS200 tuning */
> +	ret = msm_config_cm_dll_phase(host, priv->saved_tuning_phase);
> +	if (ret)
> +		return ret;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CMD_DAT_TRACK_SEL;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	/*
> +	 * use_cdclp533 only applies to legacy SDCC (core_minor < 0x34); our
> +	 * supported targets always use the SDC4 calibration path.
> +	 */
> +	if (priv->use_cdclp533) {
> +		printf("%s: CDCLP533 HS400 calibration path is not implemented\n",
> +		       host->name);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return sdhci_msm_cm_dll_sdc4_calibration(host);
> +}
> +
> +static int msm_find_most_appropriate_phase(struct sdhci_host *host,
> +					   u8 *phase_table,
> +					   u8 total_phases)
> +{
> +	int ret;
> +	u8 ranges[MAX_PHASES][MAX_PHASES] = { {0}, {0} };
> +	u8 phases_per_row[MAX_PHASES] = { 0 };
> +	int row_index = 0, col_index = 0, selected_row_index = 0;
> +	int i, longest_range_len = 0;
> +	bool found = false;
> +
> +	if (!total_phases || total_phases > MAX_PHASES) {
> +		printf("%s: Invalid argument: total_phases=%d\n",
> +		       host->name, total_phases);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < total_phases; i++) {
> +		ranges[row_index][col_index] = phase_table[i];
> +		phases_per_row[row_index] += 1;
> +		col_index++;
> +
> +		if ((i + 1) == total_phases)
> +			continue;
> +
> +		if (phase_table[i] + 1 != phase_table[i + 1]) {
> +			row_index++;
> +			col_index = 0;
> +		}
> +	}
> +
> +	if (row_index == 0) {
> +		ret = phase_table[total_phases / 2];
> +		goto exit;
> +	}
> +
> +	for (i = 0; i <= row_index; i++) {
> +		if (phases_per_row[i] > longest_range_len) {
> +			longest_range_len = phases_per_row[i];
> +			selected_row_index = i;
> +			found = true;
> +		}
> +	}
> +
> +	if (found) {
> +		ret = ranges[selected_row_index][longest_range_len / 2];
> +	} else {
> +		ret = -EIO;
> +		printf("%s: Failed to find a valid phase\n", host->name);
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +static bool sdhci_msm_is_tuning_needed(struct sdhci_host *host)
> +{
> +	struct mmc *mmc = host->mmc;
> +
> +	return mmc->selected_mode == MMC_HS_200;
> +}
> +
> +static int sdhci_msm_execute_tuning(struct mmc *mmc, u8 opcode)
> +{
> +	struct sdhci_host *host = mmc->priv;
> +	int tuning_seq_cnt = 10;
> +	u8 phase, tuned_phases[MAX_PHASES], tuned_phase_cnt = 0;
> +	int rc;
> +	struct udevice *dev = mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +
> +	if (!sdhci_msm_is_tuning_needed(host))
> +		return 0;
> +
> +	/*
> +	 * The SDHCI core may call execute_tuning before host->clock is
> +	 * updated to match mmc->clock.
> +	 */
> +	if (host->clock != mmc->clock) {
> +		rc = sdhci_set_clock(mmc, mmc->clock);
> +		if (rc) {
> +			printf("%s: Failed to set clock for tuning\n", host->name);
> +			return rc;
> +		}
> +	}
> +
> +	priv->tuning_done = false;
> +
> +retry:
> +	rc = msm_init_cm_dll(host);
> +	if (rc) {
> +		printf("%s: Failed to init DLL\n", host->name);
> +		return rc;
> +	}
> +
> +	phase = 0;
> +	tuned_phase_cnt = 0;
> +
> +	do {
> +		rc = msm_config_cm_dll_phase(host, phase);
> +		if (rc) {
> +			printf("%s: Failed to set DLL phase %d\n",
> +			       host->name, phase);
> +			return rc;
> +		}
> +
> +		rc = mmc_send_tuning(mmc, opcode);
> +		if (!rc)
> +			tuned_phases[tuned_phase_cnt++] = phase;
> +	} while (++phase < MAX_PHASES);
> +
> +	if (tuned_phase_cnt) {
> +		if (tuned_phase_cnt == MAX_PHASES) {
> +			/*
> +			 * All phases valid is close to as bad as none valid:
> +			 * likely no phase is really reliable. Retry a few
> +			 * times rather than guessing.
> +			 */
> +			if (--tuning_seq_cnt) {
> +				tuned_phase_cnt = 0;
> +				goto retry;
> +			}
> +		}
> +
> +		rc = msm_find_most_appropriate_phase(host, tuned_phases,
> +						     tuned_phase_cnt);
> +		if (rc < 0) {
> +			printf("%s: Failed to find appropriate phase\n",
> +			       host->name);
> +			return rc;
> +		}
> +		phase = rc;
> +
> +		rc = msm_config_cm_dll_phase(host, phase);
> +		if (rc) {
> +			printf("%s: Failed to set final phase %d\n",
> +			       host->name, phase);
> +			return rc;
> +		}
> +
> +		priv->saved_tuning_phase = phase;
> +	} else {
> +		if (--tuning_seq_cnt)
> +			goto retry;
> +		printf("%s: No tuning point found\n", host->name);
> +		rc = -EIO;
> +	}
> +
> +	if (!rc)
> +		priv->tuning_done = true;
> +
> +	return rc;
> +}
> +
> +/*
> + * Configure HC mode selection. On the first HS400 transition,
> + * calibration_done is still false, so the HS400 mux-select bits are
> + * deferred until calibration completes in msm_sdhci_config_dll(); see
> + * sdhci_msm_hs400_select_in().
> + */
> +static void sdhci_msm_hc_select_mode(struct sdhci_host *host)
> +{
> +	struct mmc *mmc = host->mmc;
> +	struct udevice *dev = mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	bool is_hs400 = mmc->selected_mode == MMC_HS_400;
> +	u32 config;
> +
> +	config = readl(host->ioaddr + var_info->core_vendor_spec);
> +	config &= ~CORE_HC_MCLK_SEL_MASK;
> +
> +	if (mmc->selected_mode == MMC_HS_200)
> +		config |= CORE_HC_MCLK_SEL_DFLT;
> +	else if (is_hs400)
> +		config |= CORE_HC_MCLK_SEL_HS400;
> +	else
> +		config |= CORE_HC_MCLK_SEL_DFLT;
> +
> +	writel(config, host->ioaddr + var_info->core_vendor_spec);
> +
> +	if (is_hs400) {
> +		if (priv->calibration_done) {
> +			config = readl(host->ioaddr + var_info->core_vendor_spec);
> +			config |= CORE_HC_SELECT_IN_HS400;
> +			config |= CORE_HC_SELECT_IN_EN;
> +			writel(config, host->ioaddr + var_info->core_vendor_spec);
> +		}
> +	} else {
> +		/*
> +		 * Clear these bits for every non-HS400 mode so a previous
> +		 * HS400 attempt never leaves them stuck set.
> +		 */
> +		if (!priv->use_cdclp533) {
> +			config = readl(host->ioaddr + var_info->core_vendor_spec3);
> +			config &= ~CORE_PWRSAVE_DLL;
> +			writel(config, host->ioaddr + var_info->core_vendor_spec3);
> +		}
> +
> +		config = readl(host->ioaddr + var_info->core_vendor_spec);
> +		config &= ~CORE_HC_SELECT_IN_EN;
> +		config &= ~CORE_HC_SELECT_IN_MASK;
> +		writel(config, host->ioaddr + var_info->core_vendor_spec);
> +	}
> +}
> +
> +/*
> + * Selects HS400 in the HC_SELECT_IN mux. Must only be called after
> + * sdhci_msm_hs400_dll_calibration() succeeds.
> + */
> +static void sdhci_msm_hs400_select_in(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config;
> +
> +	config = readl(host->ioaddr + var_info->core_vendor_spec);
> +	config |= CORE_HC_SELECT_IN_HS400;
> +	config |= CORE_HC_SELECT_IN_EN;
> +	writel(config, host->ioaddr + var_info->core_vendor_spec);
> +}
> +
> +static void sdhci_msm_set_control_reg(struct sdhci_host *host)
> +{
> +	struct mmc *mmc = host->mmc;
> +	struct udevice *dev = mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config;
> +
> +	/*
> +	 * This controller has no HOST_CONTROL2 encoding for HS400. Keep the
> +	 * UHS field at SDR104 (same as HS200) for HS400 too; the data path
> +	 * is switched to HS400 timing via the vendor-specific
> +	 * CORE_HC_MCLK_SEL/CORE_HC_SELECT_IN bits instead.
> +	 */
> +	sdhci_set_voltage(host);
> +	if (mmc->selected_mode == MMC_HS_400) {
> +		u32 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +		ctrl2 &= ~SDHCI_CTRL_UHS_MASK;
> +		ctrl2 |= SDHCI_CTRL_UHS_SDR104;
> +		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +	} else {
> +		sdhci_set_uhs_timing(host);
> +	}
> +
> +	sdhci_msm_hc_select_mode(host);
> +
> +	/*
> +	 * Below 100MHz the feedback clock must be provided without the DLL,
> +	 * so tuning can be skipped.
> +	 */
> +	if (mmc->clock && mmc->clock <= CORE_FREQ_100MHZ) {
> +		if (mmc->selected_mode == MMC_HS_200 ||
> +		    mmc->selected_mode == MMC_HS_400) {
> +			config = readl(host->ioaddr + var_info->core_dll_config);
> +			config |= CORE_DLL_RST;
> +			writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +			config = readl(host->ioaddr + var_info->core_dll_config);
> +			config |= CORE_DLL_PDN;
> +			writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +			/* Calibration must be redone once the clock returns to HS400 speed. */
> +			priv->calibration_done = false;
> +		}
> +	}
> +}
> +
>  static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
>  {
>  	struct udevice *dev = mmc_to_dev(host->mmc);
> +	struct mmc *mmc = host->mmc;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
>  	const struct msm_sdhc_variant_info *var_info = (void *)dev_get_driver_data(dev);
>  	u32 config;
>  
> +	if (clock == 0)
> +		return 0;
> +
>  	if (enable && clock < MHZ(100)) {
>  		/*
>  		 * DLL is not required for clock <= 100MHz
> @@ -169,12 +854,33 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
>  		writel(config, host->ioaddr + var_info->core_dll_config);
>  	}
>  
> +	/*
> +	 * HS400 requires a dedicated DDR/SDC4 DLL calibration step, performed
> +	 * once per calibration cycle once the clock is running above 100MHz.
> +	 */
> +	if (enable && clock > MHZ(100) &&
> +	    mmc->selected_mode == MMC_HS_400 && priv->tuning_done &&
> +	    !priv->calibration_done) {
> +		int ret = sdhci_msm_hs400_dll_calibration(host);
> +
> +		if (!ret) {
> +			priv->calibration_done = true;
> +			/* Safe to switch the data-path mux into HS400 timing now. */
> +			sdhci_msm_hs400_select_in(host);
> +		} else {
> +			printf("%s: Failed to calibrate DLL for HS400 mode (%d)\n",
> +			       host->name, ret);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
>  struct sdhci_ops msm_sdhci_ops = {
>  	.config_dll = &msm_sdhci_config_dll,
> -	.set_control_reg = &sdhci_set_control_reg,
> +	.set_control_reg = &sdhci_msm_set_control_reg,
> +	.platform_execute_tuning = &sdhci_msm_execute_tuning,
>  };
>  
>  static int msm_sdc_probe(struct udevice *dev)
> @@ -186,6 +892,7 @@ static int msm_sdc_probe(struct udevice *dev)
>  	struct sdhci_host *host = &prv->host;
>  	u32 core_version, core_minor, core_major;
>  	struct reset_ctl bcr_rst;
> +	struct blk_desc *bdesc;
>  	u32 caps;
>  	int ret;
>  
> @@ -235,6 +942,24 @@ static int msm_sdc_probe(struct udevice *dev)
>  
>  	log_debug("SDCC version %d.%d\n", core_major, core_minor);
>  
> +	/* Feature support depends on the SDCC core version. */
> +	if (core_major == 1 && core_minor >= 0x42)
> +		prv->use_14lpp_dll_reset = true;
> +
> +	if (core_major == 1 && core_minor >= 0x71)
> +		prv->uses_tassadar_dll = true;
> +
> +	if (core_major == 1 && core_minor < 0x34)
> +		prv->use_cdclp533 = true;
> +
> +	if (core_major == 1 && core_minor >= 0x49)
> +		prv->updated_ddr_cfg = true;
> +
> +	dev_read_u32(dev, "qcom,dll-config", &prv->dll_config);
> +
> +	if (dev_read_u32(dev, "qcom,ddr-config", &prv->ddr_config))
> +		prv->ddr_config = DDR_CONFIG_POR_VAL;
> +
>  	/*
>  	 * Support for some capabilities is not advertised by newer
>  	 * controller versions and must be explicitly enabled.
> @@ -249,6 +974,12 @@ static int msm_sdc_probe(struct udevice *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (plat->cfg.host_caps & MMC_CAP_NONREMOVABLE) {
> +		bdesc = mmc_get_blk_desc(&plat->mmc);
> +		if (bdesc)
> +			bdesc->removable = 0;
> +	}
> +
>  	host->mmc = &plat->mmc;
>  	host->mmc->dev = dev;
>  	host->ops = &msm_sdhci_ops;
> @@ -318,16 +1049,35 @@ static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
>  	.mci_removed = false,
>  
>  	.core_dll_config = 0x100,
> +	.core_dll_status = 0x108,
> +	.core_dll_config_2 = 0x1b4,
>  	.core_vendor_spec = 0x10c,
>  	.core_vendor_spec_capabilities0 = 0x11c,
> +
> +	.core_ddr_200_cfg = 0x184,
> +	.core_vendor_spec3 = 0x1b0,
> +	.core_ddr_config_old = 0x1b8,
> +	.core_ddr_config = 0x1bc,
>  };
>  
>  static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
>  	.mci_removed = true,
>  
>  	.core_dll_config = 0x200,
> +	.core_dll_status = 0x208,
> +	.core_dll_config_2 = 0x254,
> +	.core_dll_config_3 = 0x258,
> +	.core_dll_usr_ctl = 0x388,
>  	.core_vendor_spec = 0x20c,
>  	.core_vendor_spec_capabilities0 = 0x21c,
> +
> +	.core_ddr_200_cfg = 0x224,
> +	.core_vendor_spec3 = 0x250,
> +	.core_ddr_config = 0x25c,
> +	/*
> +	 * core_ddr_config_old not present on V5 - updated_ddr_cfg is
> +	 * effectively always true here since V5 implies core_minor >= 0x49
> +	 */
>  };
>  
>  static const struct udevice_id msm_mmc_ids[] = {

-- 
// Casey (she/her)

