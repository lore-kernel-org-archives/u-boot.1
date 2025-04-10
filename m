Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6EDC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF7183B5F;
	Thu, 10 Apr 2025 11:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H7RfpFsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D0B83B63; Thu, 10 Apr 2025 11:51:51 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B5E83B4F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso277626f8f.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744278709; x=1744883509; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NYuVEDDGDFkzY4hIdvbBzTJd9pjIV9fNjs79UBrCGyA=;
 b=H7RfpFsTWMufkOThkqpujdWnWwH1q3WRVWe9w5b1XDDCN3b+m0NxE6+WU7bj6uxlLR
 2vUTNehHKFYiWSh45wz4dYVT+x1jpmWvgyRSU0BXZqeAfG8YQv1SawgMs7/NBb7RBZwT
 giHyzT0MUl0VyIwUqQ377ud9ll5aP8QqHr1Y/J0D935WpxkT1ObCFsAASDOOzo3m+OAo
 N5DNSYvR/V0/WFrLzes5tFpHwQVbrActU6JvcM3oCgKWih7GOwWc4q8o9vsrD7EI82gm
 qrneNQZC5FcQlIMG5ZeHLSYKxbnV+VCeiplmP/9VQ8k/0RrIsVnab77ZwiVhttpvUdTH
 yRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744278709; x=1744883509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NYuVEDDGDFkzY4hIdvbBzTJd9pjIV9fNjs79UBrCGyA=;
 b=cXXo0+DKXH1kLktBv1LhVajsC7GB9USFF9fMJGW+SgNOAekb6EcrImM9GeYMNclkLM
 D+LBqCWWef5uuntzf22SypFxUtnWFyqkjDvsWpzlt0797BzD/438guDJ3e8gznF1UU28
 GnU0cmmMUmyoNbc8/2bOm6sesCTq3OyQUaPfWZZbbXipkndFvv1CsE22i7WoXzbvOkCF
 cRNZ6Ead8oRbrBShULGZTolKWnOVUboo/cIR7dB/1Qn4HSIM1A4O2X3D3Vc5mmzpyhcK
 0BAEcT3t8Kmq5iKU3W92DQsBY4jQW3Fl2VBKTnBPzTG1N669VvyF4At4xppCpOo64KRF
 lp8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOocdi9mRllIuDa33HEqAJpSut3mh1bcZSdRYq1BduERoG5hI08N5x7ZzIk89KfGuQJjZzHm4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywmy7vE/htd5ghM7pyYjO+tHrlbm4pMIJtzUCCrb8cReU/gct4A
 HKMoaTwmnCMvmgwdI8i9HteGcNfT1Nh3B1lFKGZoMd5BUE5kXM+3gwdtJ0a5x3s=
X-Gm-Gg: ASbGnct+mztOdbbYRBiQQZEzncHdMju9D7WS3C7aZj3y69+9rvKEzs+WcMXxozTQqaO
 bNA1xWb4oHOc+zTdldZyd9KKhT8MYOzUIpHnqAllKnzWh3cww8AlYhbt9fH5uYuXIIaCvqyAoRR
 ajyf0JU/LeVqdrzDbzdAORp0xk5WEMbhhWPJof/HQy7qJd7ygz0UiEOq3fLrw+5lsQhfvmG93s5
 nE5fg6okZ3b686XhrkuY2ONULfDoOvRoaruWogfyXtYlSkSiUMYLRebsTMH6MajwhzFlKIgdaNE
 b//ATZAzBH+6RdDXzFcU8JJNcFDeBRZZjHS/JhKfZX1ntZt5eGT3NZtxwbNkC/sDGfPw
X-Google-Smtp-Source: AGHT+IFlgzJ7d6HeAUid58KY8Z6heHDpIiDsKjiriinmnai1QFFVew98Sua7OKNNo5sSdO4DCYoC2A==
X-Received: by 2002:a5d:598d:0:b0:390:fbcf:56be with SMTP id
 ffacd0b85a97d-39d8f22a482mr1602455f8f.0.1744278708625; 
 Thu, 10 Apr 2025 02:51:48 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d89400148sm4167543f8f.89.2025.04.10.02.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 02:51:47 -0700 (PDT)
Message-ID: <d13cf199-47e7-436e-964b-c089dce913e8@linaro.org>
Date: Thu, 10 Apr 2025 11:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: phy-qcom-qusb2: Fix USB PHY power on sequence
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: neil.armstrong@linaro.org, trini@konsulko.com,
 alexeymin@postmarketos.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250410080027.208674-1-sumit.garg@kernel.org>
 <20250410080027.208674-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250410080027.208674-3-sumit.garg@kernel.org>
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



On 4/10/25 10:00, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Recent addition of support for SDM660 inadvertently broke USB PHY power
> on sequence on RB1/RB2 and others with following error:
> 
> starting USB...
> Bus usb@4e00000: QUSB2PHY pll lock failed: status reg = 0
> qcom-qusb2-phy phy@1613000: PHY: Failed to power on phy@1613000: -16.
> Can't power on PHY0
> probe failed, error -16
> No USB controllers found
> 
> The root cause was the addition of flag se_clk_scheme_default which was
> configured correctly for SDM660 but incorrect for all other supported
> SoC. Fix that by properly assignment as per upstream Linux driver.
> 
> Fixes: 475497dc3c15 ("phy: Add SDM660 support to Qualcomm QUSB2 phy")
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Nice find! Thanks.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>> ---
>   drivers/phy/qcom/phy-qcom-qusb2.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
> index cabd05bf5a6..d98f6108e69 100644
> --- a/drivers/phy/qcom/phy-qcom-qusb2.c
> +++ b/drivers/phy/qcom/phy-qcom-qusb2.c
> @@ -230,6 +230,7 @@ static const struct qusb2_phy_cfg sm6115_phy_cfg = {
>   	.regs = sm6115_regs_layout,
>   
>   	.has_pll_test = true,
> +	.se_clk_scheme_default = true,
>   	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
>   	.mask_core_ready = PLL_LOCKED,
>   	.autoresume_en = BIT(3),
> @@ -256,6 +257,7 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
>   			 POWER_DOWN),
>   	.mask_core_ready = CORE_READY_STATUS,
>   	.has_pll_override = true,
> +	.se_clk_scheme_default = true,
>   	.autoresume_en = BIT(0),
>   	.update_tune1_with_efuse = true,
>   };

-- 
Caleb (they/them)

