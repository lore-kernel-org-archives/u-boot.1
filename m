Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6537CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 13:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430ED848D8;
	Wed, 17 Jun 2026 15:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JZ1GW4cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED53E848E2; Wed, 17 Jun 2026 15:54:08 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1828460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 15:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so41942255e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781704446; x=1782309246; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7le2dV3L4iKCtQkXDFG7RLoas84mxgEVguKI/CCaf7I=;
 b=JZ1GW4cxpgxKjBCA9am8r7LLYFmqmTi3U6UBx7rMxwDsib7HbjxIHeu5wK7BvdF2xt
 cRoOtptrWRAMB2qkn19mEUvsD6XOmYmTzSE6ID5AncdmEnHMgLQ7WVvH8RXFhUQNOMa8
 LSpv4WWXJN5fghYwGeFnuhhWwA3w/RN4brw0479M/nfgbNrmMpSU6yo7UI26x2IWPaN3
 JRA5afhHXZTM/7IX28zXyvJqGjT+yUo3lmGx5Djq/kq1a5DuYDG06Qg12IyLalbyvc7l
 o0n3VckZM20iiSoMLwz/uo3nW26UmlgfaUxajUQmdF6MCM1Oon5i4P9Oadtv9mkksiWl
 FSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781704446; x=1782309246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7le2dV3L4iKCtQkXDFG7RLoas84mxgEVguKI/CCaf7I=;
 b=f27TRZujHTfpRbpxCLs+MrOyjrMz3XxClN4WR9Rsan0Nqs/IcUVNPbK/0NSYwHSRlf
 oct6oAHyTcbQK+QIBgfqfoPqOGcCP7v/6rVp9XbkKB2x6nZhKqTWbj9IzeDDAFOpUPs2
 3EL6D4+dO1NybzLxkEyugZEg0Xs+C5kSLIgNATPIfycZDPHkYAq+oJ5DbhJDA1fp2sri
 Q4obvrfukDVSckOFraaKyYq1WnFY8EJhDFboQxuW3LUSWbq/+P3wcf/Fdi7njzv4hccy
 gHbjbmGnC/JrUbnOSgbdI6AXZhHc0JE63i1dqCmIdWCdguusQAdpUVrLtjStfvEncc1h
 aZDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ97fTOwT7EiWGvelyfTuXaTg5821DtyoloIsd8H43X8j84NTEE38tfJyHR1D20iQJH/q2xUfko=@lists.denx.de
X-Gm-Message-State: AOJu0YyuWLX2+5NuG7Eh+8/hnhV8kh3V6aG/Qv06N0t3RsWLeMyXZB/1
 7PCt7bB1rTh8cuUsM0qnQfC17cd9fijkDT1+740+a6kKoU0Sc/vynFZAwB6r9fRmBzk=
X-Gm-Gg: Acq92OE+NGJUIy2krSSm+fFPyt142FlZmCf+4AB+HX+DHHDdZlrIznPcm/B2kxDZ3rN
 fq0p2lXUeLmJ+eYMYdDYQMn6CJrD6BD1TGb07eWA1wc+HWytY9lcxuJzm49FeH7xvQqSxoWT+Ex
 gUue7PC/Q6IYSAfkfbZMH2E7q2iATs6bSGl435PhKyppbOakD/pSt6AeImGQtIK52Dxl0QMBrGa
 j+DcydN7Twi2W3RMRQS0wGtJBjCzbKqkz59WpjJv+eYT1BQHLpX2lOydn40Dfhtwgk/JFh2w0sV
 gUPTNIkIE5qb3uv9XOcaMcnuF1q56JT+XOddoFfnoHjwhxIYBQhjr5u9t5MkhzbWRt8wHMGyV3i
 cH28cC8Ag+Iin5g2oZOQSo9jwpwqMxbS/0Eq3AxAElJxeikzVVuAKP8LVsS+ypbLE+fSntqpp1F
 9k8/cFSZw5cWZ/2Yl8PRy8FvV0jf/ettNwiYIojSZ+PojsKDJ6W+hb
X-Received: by 2002:a05:600c:c113:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-492333bf7efmr62205295e9.9.1781704445892; 
 Wed, 17 Jun 2026 06:54:05 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49233bed5d3sm47232305e9.2.2026.06.17.06.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 06:54:05 -0700 (PDT)
Message-ID: <7617c83d-3de2-4207-8fd8-3242756f8f14@linaro.org>
Date: Wed, 17 Jun 2026 15:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] qcom_defconfig: enable poweroff command
Content-Language: en-US
To: me@samcday.com, u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen
 <justin@tidylabs.net>, Jamie Gibbons <jamie.gibbons@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-6-170c9cbe5099@samcday.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260606-pm8916-pon-v1-6-170c9cbe5099@samcday.com>
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



On 06/06/2026 10:47, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> With the newly introduced PM8916 PON driver and support in PSHOLD
> driver, the poweroff command now works on MSM8916 devices.
> 
> This should also work on any more recent qcom SoC with a functional PSCI
> implementation in TZ. I confirmed that is the case on my google-sargo
> and oneplus-fajita, at least.
> 
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index c5649b9b746..c7bc6829014 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -38,6 +38,7 @@ CONFIG_CMD_DFU=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_POWEROFF=y
>  CONFIG_CMD_UFS=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
> @@ -135,6 +136,7 @@ CONFIG_SPMI_MSM=y
>  CONFIG_SYSINFO=y
>  CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_SYSRESET_CMD_RESET_ARGS=y
> +CONFIG_SYSRESET_CMD_POWEROFF=y
>  CONFIG_SYSRESET_QCOM_PSCI=y
>  CONFIG_SYSRESET_QCOM_PSHOLD=y
>  CONFIG_USB=y
> 

-- 
// Casey (she/her)

