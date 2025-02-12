Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AFBC021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 15:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ACE880C72;
	Wed, 12 Feb 2025 16:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bbsRc5qG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0684A80C7E; Wed, 12 Feb 2025 16:52:26 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0744980017
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 16:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f22fe889aso159064f8f.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 07:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375543; x=1739980343; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=75hxt+/uhcQc6Trweg0wnd+ajHl6lZlsfpxSJDiUV/w=;
 b=bbsRc5qGo/5FlJxFQMjviiJofo1FTeqfYoiR/ICTkANN8lXfmdTNzCaDeOqGxSr07z
 LrXp5kSprVELP9RTkXNqZ4PQ/6z9aqBMM4QNPUPdx3J/7/Le584cBcMBzgwnmc2BBC3u
 imd2sQ9n5Mj93hzZ+2CG2WyW5Ox8zsnh/8JlSFrneKNfz4hEzJI/TSivOAwQwEV3d6Ui
 3aLTgAmdmEuN8+kJNIjx4FyJrOEMOm8K0emDdqMrpopFjItlR/3bxiM/r3ID3CzRQq09
 gniq7Cku0Su7JjkKarUke7GFAM9oBqfHTsMEIKF/e+gCxghYY7VwLqHsnU9oTjAqs97r
 I4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375543; x=1739980343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=75hxt+/uhcQc6Trweg0wnd+ajHl6lZlsfpxSJDiUV/w=;
 b=Xf7Ki0ymr3QOzQIRJmYn6OpVLYJccEqQ0t2ERyIIGB/keH7nYnZX6gdLKR4wuPXRLa
 OQw1FK0b5nsUTEKi4eSeKAfaRVAfhhN6rFpRm0Z32KXoJ7U8QiMFtXZASdOUsCh7Xrlx
 I29QzGZwbFaOU5jZlFSDeVZlTX8KFJ2ZU7ISMEJMY8hIVWhMwadXvsdL+5SsV2Ln9C4J
 +DGYvLBZ0OhnbGSJaxph+adqUqeJEj8VXHsNPXCBWgsS6Dp7oyWZJ4d1p1FyU07ybFCl
 zilEG2N/ICLcaBqBeF+4hCxy49aWu9s6MM277lnKVWcYBmPRKl7hnYhmQLLezq5iUNZu
 pI4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj44b7ZBhQ8qU0Q5r+0OY4uG9D17qpNMCLyIF1wl7nUksMxwMSR6wvHMWPOQF60YaXc2r2iho=@lists.denx.de
X-Gm-Message-State: AOJu0Yx37RN8I8tKNbo7nNtXPfZf2sCB0ZQZDQ4bLreOGh3ePv8fMTw7
 A6tkyN6iAPf+Hh7p2BLwgCISdiqP8UWT4yWGC+ao2CKgmYZpcnpc1Q1yq2C8JtM=
X-Gm-Gg: ASbGncverRL/YZFRYmKQ+1jgeT8gXybOrdct7VbXE9A3M10zRen56xCEEpqFV9rU7Ne
 VGRs4kHMjyLFUVp0uY3YmAY2jiDPZISDQNfj0vh7br6DOPZs6QsQhqefPtViudKcVDuflNXz99L
 DYwvFUSr1Er2W6TTF5jtAuYft7dSd44BCUXbKI68NHhIp5zcjGfhfQGs+cFaxdkeMhZ8OT01jcY
 Uq+U8LVoeiyoVdPRDHWivSfHKyZiedTo6s80Q743dzK0jXJv+iwI8CMPbEkv9aRHMVnbU5z7UVj
 bm+D2P4wqjDSKUqyrufqxcGxB7LuVuChTu2GyCI4EB3kiVskCIAR3+a9L7PUjiuyFUEiAQ==
X-Google-Smtp-Source: AGHT+IGbhcCaK+v8umtFCQJEOH3Q6ltwTk8It4hcHAl1V5mVELkyF1c3r4j6PiAb5ps5TgpAyLfFHg==
X-Received: by 2002:a05:6000:156a:b0:38d:cbc2:29ca with SMTP id
 ffacd0b85a97d-38dea286d9fmr3734376f8f.32.1739375543470; 
 Wed, 12 Feb 2025 07:52:23 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:416b:3913:893e:bb4?
 ([2a0a:ef40:1d11:ab01:416b:3913:893e:bb4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc672b55bsm16071431f8f.79.2025.02.12.07.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 07:52:22 -0800 (PST)
Message-ID: <4f4d1663-11df-4023-bb8b-a64f90175960@linaro.org>
Date: Wed, 12 Feb 2025 15:52:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] qcom_defconfig: enable ipq9574 clock & pinctrl
 driver
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, Volodymyr_Babchuk@epam.com,
 lehmanju@devpi.de, pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250130053751.3148614-1-quic_varada@quicinc.com>
 <20250130053751.3148614-6-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250130053751.3148614-6-quic_varada@quicinc.com>
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



On 1/30/25 05:37, Varadarajan Narayanan wrote:
> Enable the IPQ9574 clock & pinctrl driver in the Qualcomm defconfig.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index e4abfdf16b..865381f75d 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -47,6 +47,7 @@ CONFIG_BUTTON_QCOM_PMIC=y
>   CONFIG_CLK=y
>   CONFIG_CLK_QCOM_APQ8016=y
>   CONFIG_CLK_QCOM_APQ8096=y
> +CONFIG_CLK_QCOM_IPQ9574=y
>   CONFIG_CLK_QCOM_QCM2290=y
>   CONFIG_CLK_QCOM_QCS404=y
>   CONFIG_CLK_QCOM_SA8775P=y
> @@ -94,6 +95,7 @@ CONFIG_PINCTRL=y
>   CONFIG_PINCONF=y
>   CONFIG_PINCTRL_QCOM_APQ8016=y
>   CONFIG_PINCTRL_QCOM_APQ8096=y
> +CONFIG_PINCTRL_QCOM_IPQ9574=y
>   CONFIG_PINCTRL_QCOM_QCM2290=y
>   CONFIG_PINCTRL_QCOM_QCS404=y
>   CONFIG_PINCTRL_QCOM_SDM845=y

-- 
Caleb (they/them)

