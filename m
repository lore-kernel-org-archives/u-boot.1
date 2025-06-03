Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BFDC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 16:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE05882AA7;
	Tue,  3 Jun 2025 18:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cuyup01D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D6E82AAA; Tue,  3 Jun 2025 18:05:05 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E817D82A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 18:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so37304025e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748966702; x=1749571502; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yI20UDCq0U23XHgjqKxTNBpBU/dnPuyWCOqOLV+kLFA=;
 b=cuyup01DJVV/uTegrOADeIzznn33aDKi9jXwl/nmAf2R2SXczhqWZUmpQs2kWmLvqo
 SNlRDqNnDH+Q3JGGzWY+/r8L0DW6XqNHTvRcuKHb6G0pR6uWlha/DzjcG2yVlI7RPgdW
 tBPw8Ge9EEQ8WXLDw+epqSKlx0KdbMThn0SeSU5XpwpqcMt7d67+2MdzAWZOOp8JhWTK
 r4aoV0AcX0DFdzbp34hGeFxOGGyAuzZr0pcbVb3XGUhcQYgNeoeM8Roqn+iion2miRMz
 8a/esUo+qx9+tkaIDVvFudhHkEE+8j74+iMfuOoeTrvr4PtwcuNam8yURBydOiW+cLc7
 Ji7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748966702; x=1749571502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yI20UDCq0U23XHgjqKxTNBpBU/dnPuyWCOqOLV+kLFA=;
 b=W7VPMhj5Sg+/TPBHT6jRmRHoEl01ODQKsLvFdRzGiyzAFdDwpgl87G5fuKEO/tA7tE
 i8S96uoMJlbmyelJacjR0+dQBK+MxtcXeKx05+ROwyESFwDK8VY4w4+D5/pZUWDfeSUF
 DXb4nMiTJgf9onF2IR1p8sm8dMvtZteZMnBjN9iC+b4s3IDedL2vFcHqwTVaSCxlh4ci
 WACsApFqQ+iEZSeuy/XEx4pfRtwyGW+mqd3bNAXuEq67+dw1APBu/y8RSfdRamE3Fsgg
 jrOxQK9zOjIG38zl9SFnwNzWy1lFTzK6XG03U8/Rmd4GTOlrMyfMchz2+j2wepSOk8d4
 Td4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw6YVNI0QPgG5qJeY9FPrVTBOHA3M9xocKa3kPWYPEZ6J86jaV5BcnIQgtrn21rxgPgXH7Dlg=@lists.denx.de
X-Gm-Message-State: AOJu0YwVMFwBOSpUl0BdFUpGZvE/GShJdfvD4EeIUMTLqWOn6200XdiQ
 Xv5Yy9hkD2lOl3MHbJbCAr/BlL2JYejvE49Lq9O1apTGQ764JpvW9r+WaCUrPJGaHcs=
X-Gm-Gg: ASbGnctJmnr73n6mwIrSKWPwlhfIEpzUN2s81KTm0+z9UGTAdcg5rb3tvPMolMYNoJD
 EhRiNJrb5k/uItOqittuwgag2bBnGv7y5cD524sZ4wrfQTORqn+69qJfTHexVUE702aMZBA7YKr
 232HIbLq8so6QEM+XG8yxtzTxpP+lUt8TIRKzvXLgiZ28G28AiZ5h7i+6B4r+jGBlODV6vsocXL
 zi6FF+qxK8bVgZotsueUI4hexGveYLayHR8gMZDDFUEGURs0k6J9uAsK2WdUCK/zMY1QkVnILMX
 iJLMB9Jyu53oOjDwggYyku1YZI50SetbGH/Pvwxd7u5KRI5H1Cxoo/8jeKTstoSWjQgc0HjrvTT
 5MFfDMjmkXry7nwe1/FIehRpyCg==
X-Google-Smtp-Source: AGHT+IH/wU2e4+wKCl2sNraBqt7zuT5g7Jzxho5a2wDwbOhd8d3oTxn0TyzfWc5HA6fN6ZMMTK4SAQ==
X-Received: by 2002:a05:600c:500e:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-4511edd5e6fmr113125435e9.21.1748966702232; 
 Tue, 03 Jun 2025 09:05:02 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:e089:f4a9:4c4d:e359?
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b87csm18991160f8f.12.2025.06.03.09.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 09:05:00 -0700 (PDT)
Message-ID: <76de0f0c-8487-4a54-bad6-38e04321751e@linaro.org>
Date: Tue, 3 Jun 2025 18:04:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Introduce support for QCS615 SoC based Platform
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, me@samcday.com,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
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



On 5/21/25 05:53, Aswin Murugan wrote:
> These patches introduce the initial support code needed
> for the Qualcomm QCS615 SoC IQ6 based Platform.
> 
> Please see [1] for SoC related details

Thanks!

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> 
> Thanks
> Aswin
> 
> 1 - https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Replaced the "1" with BIT(0) in drivers/clk/qcom/clock-qcs615.c
> - Link to v1: https://lore.kernel.org/u-boot/20250513110213.330495-1-aswin.murugan@oss.qualcomm.com/
> ---
> 
> Aswin Murugan (5):
>    dts: qcs615-ride-u-boot.dtsi: Add memory entry to bootup
>    phy: qcom: Enable QMP UFS PHY driver for QCS615
>    clk/qcom: qcs615: Add GCC clock driver for QCS615
>    qcom_defconfig: Enable QCS615 clock driver
>    configs: add qcs615_defconfig
> 
>   arch/arm/dts/qcs615-ride-u-boot.dtsi |  14 +++
>   configs/qcom_defconfig               |   1 +
>   configs/qcom_qcs615_defconfig        |  22 ++++
>   drivers/clk/qcom/Kconfig             |   8 ++
>   drivers/clk/qcom/Makefile            |   1 +
>   drivers/clk/qcom/clock-qcs615.c      | 163 +++++++++++++++++++++++++++
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c  | 127 +++++++++++++++++++++
>   7 files changed, 336 insertions(+)
>   create mode 100644 arch/arm/dts/qcs615-ride-u-boot.dtsi
>   create mode 100644 configs/qcom_qcs615_defconfig
>   create mode 100644 drivers/clk/qcom/clock-qcs615.c
> 

-- 
Casey (she/they)

