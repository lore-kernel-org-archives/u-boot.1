Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3671C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 681E8829A1;
	Fri,  9 May 2025 14:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uL4W9PHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340258059D; Fri,  9 May 2025 13:05:06 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E258059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 13:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a0af41faa5so1062002f8f.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746788698; x=1747393498; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XvE9Cmb0W1lSVWirOROyYLJ6/JaVutA2UCf+OhT47OE=;
 b=uL4W9PHxxEPc9+lLGBp02T/qQt1dVWdnHZNASz6tfVLTK7EE5oBUeKnasr5kmK3dD7
 +ZJ/CntYJcM5dw5WiUWEasdWqP/WwDY5wC+CDXbLeGiqmqDi2rJImOPn2atcuDncuvzS
 aJXlNYg2Nf3cazRmibYlTjopCViabHEOYEe79EFNKFC+Ky9pCYpUj5AzbbTOsnaGUcHJ
 Rl4pKctMk0I7+AfSYeT2VdDOQf3lebF67JvEuDHBc5TtuhVoHYt7nb4ycc0oJrMDKTg0
 8TKjA42uWVCRA4vqlD/XfbA4MZoHtz8VoZ+PeTY/zIpI6rUd9CtdFuP8xsGNUSEGIYrA
 Z6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746788698; x=1747393498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XvE9Cmb0W1lSVWirOROyYLJ6/JaVutA2UCf+OhT47OE=;
 b=FpmX2C0dXFPP5sYRAT3Ul1Tmj0usJYmTWvme2lh9gkMIcUddGJTVXuPmyIjG4aCsqq
 s9dvD/skeVG0gm1Ch3IilJHc0xj5ACD33jR8mbM9n9/tEJ6ymz1pfKNfLJX+VmOJgKap
 fqOenJad9w0UjMFR4GUT0NWMuCMYW6PsAjMJNJW78XeqIswW9zqZ+1S2FbPoriKqNXF2
 TGfatU26OMZK2m82nNT3WT0LDhrpYePzfXUJuksCrOJkxAzhRlPonTaw5vZisftio8kA
 C2VTWZiZ2xuIaJzUdkC9oXo0DOsAxAA1IdLxnTWQph7bmnp8Uli9y8VSORCmra49Vs55
 /aYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXpKZrp1OSKOUMyYjdD9YcQFR7bcCh6TcGu2TFVIKXd01F6AXiCtHwphAQmAvmJhRYFJzgFqQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyJbeMc+hnJM5vSyVb3nulQFSYNMWUQAVPGHbp+3exDbAfUIVxi
 hgY1UkGjQcbK43rUhT82ZnrDB+MX1IAtuvq7J9Vwhl/+cWrLDGQEQPTLUFEGCss=
X-Gm-Gg: ASbGnctdkGOxpeivX/IarZ8DIlYJL7KST5E/REZcrBE6hQyzcNHX/D/m30x7Evxu61l
 ZpzM3McPuNXF75KkKEFfVmotAs+mTHOeA3JUQr1G07oEpllFm8cfiZ2j94nh5F8MfG2wwh4I3OQ
 bfXBQhh0VFFTG76qV2ygCfLnglQSO8QBtTAww79eqIb6bnkkyI/d0Ntxe0KoNOi9yplRn8giiUj
 2nA59nUyRAwNUPc8z4hEPE/vzLK9lCdBj25ZMDjPWHbAkQt9FlBj6yoRvdKZWHlv57B0gOfIQHX
 rXuxmMX86ahEtuK8cpQeOJh59jIBICbmjeuCvC08UtmIPQGPy+x9xkTaB9dnRZAejSmrugusXeI
 c+15OUzMoJCMUDQ==
X-Google-Smtp-Source: AGHT+IFJPSkZ59vKtaz87XHwipAQsvtptA1rdhA4zDWWDe26C9LFFPMgjB51W4Ksxrpzxu1WxAs3xA==
X-Received: by 2002:a5d:584b:0:b0:3a1:f635:1136 with SMTP id
 ffacd0b85a97d-3a1f6487d80mr2596312f8f.28.1746788698049; 
 Fri, 09 May 2025 04:04:58 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-77.ptr.icomera.net.
 [185.104.138.77]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddfd6sm2877401f8f.4.2025.05.09.04.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 04:04:57 -0700 (PDT)
Message-ID: <e4681e49-1296-405b-8ea0-db2e114b835a@linaro.org>
Date: Fri, 9 May 2025 13:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Introduce support for QCS8300 SoC based IQ8 Series
 Platform
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 May 2025 14:39:39 +0200
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

Hi Balaji,

On 5/8/25 13:19, Balaji Selvanathan wrote:
> These patches introduce the initial support code needed
> for the QTI QCS8300 SoC based IQ8 Series Platform.

Thanks for this series, it's great to see support for this new platform.

Given you're introducing a new defconfig, please update 
doc/board/qualcomm to document how to build and use this platform. We 
missed this with the QCS8100 but I guess they're pretty similar so both 
could be mentioned.

Like we had for the IPQ "RDP" boards, a "Dragonwing" or QCS8xxx document 
which lists the supported boards and build instructions would be awesome.

These docs serve as a good reference for users and an easy way to get 
some idea of what platforms are supported. They should also link to the 
product brief.

Kind regards,

> 
> Please see [1] for SoC related details
> 
> Thanks
> Balaji
> 
> 1 - https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
> 
> Balaji Selvanathan (6):
>    dt-bindings: power: rpmpd: Add QCS8300 Power Domain Indexes
>    dts: qcs8300-ride-u-boot.dtsi: Add memory entry to bootup
>    clk/qcom: qcs8300: Add GCC clock driver for QCS8300
>    phy: qcom: Enable QMP UFS PHY driver for QCS8300
>    qcom_defconfig: Enable QCS8300 clock driver
>    configs: add qcs8300_defconfig
> 
>   arch/arm/dts/qcs8300-ride-u-boot.dtsi         |  19 +++
>   configs/qcom_defconfig                        |   1 +
>   configs/qcs8300_defconfig                     |  21 +++
>   drivers/clk/qcom/Kconfig                      |   8 +
>   drivers/clk/qcom/Makefile                     |   1 +
>   drivers/clk/qcom/clock-qcs8300.c              | 146 ++++++++++++++++++
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c           |   1 +
>   .../include/dt-bindings/power/qcom-rpmpd.h    |  19 +++
>   8 files changed, 216 insertions(+)
>   create mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
>   create mode 100644 configs/qcs8300_defconfig
>   create mode 100644 drivers/clk/qcom/clock-qcs8300.c
> 
-- 
Casey (she/they)

