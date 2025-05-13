Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE37C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 16:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D938091A;
	Tue, 13 May 2025 18:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wa1Ak9tz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F224680AE0; Tue, 13 May 2025 17:54:27 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91151800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 17:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a0ebf39427so4716569f8f.3
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747151665; x=1747756465; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xAbZaQP7bKx7Q4hU/FuUZzqQz5bvt3ozOkX3voFg1+0=;
 b=wa1Ak9tzbUng4p1pvfVn1WzNkanFy+nnle6JDdbGldQKEPdX2CwMEFxwjPpyxNfieR
 t0qP5ZiE2PwmIOrauaqzdHHonuvX8mjyCOviZjr7k6wZfk6iLegGEzuoQjk75mwlgXAu
 9PFDSYhvPcIHXGQMZ6St7vr6RoxoWHWDqFOy0WKdI4+ns5VEoavnU3JZT9AeprhYrGkV
 fuhpP7Vbhp6JeYETYsARAOfGKoRSVVrQT7smNgptdcgNTCThJKqekbLg/NrPo02EXse8
 ZYdR21UDLBWQafz1PVvpt/zTlvtQ1jToJF2N1zvj9FjVOBAFJnG2y8PUtURa/I+IFxbX
 4VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747151665; x=1747756465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xAbZaQP7bKx7Q4hU/FuUZzqQz5bvt3ozOkX3voFg1+0=;
 b=VXaSmoVVMHpBr7BenYxBHxYOfqVQV2kOAOL5qTtgNdkgfYTyOEoYJklhI6HEeIPm/w
 pPdqe8PmoDkFt1h+vl3LWL7JQyd3hO+d4+siBQxoxuhOPdvXCuIJvzshz7xgTbND3Y0P
 8EBHPUrWELcvKgnwA32ZpoMIPSvC+SVIS4s9ePH4DCXKZok+FswG9hUXaNz3ev61LcjW
 UQLJ96iA2fDSk1gARgLn5OiokjKfd6mXjspy8yDc0P2BzdlIosg+Od7wcJPN99Oqsakd
 eytrvlbeFHg82p/k0VoPG8j4Z58La7EF0N5rC+FR7+lWMLnq2vKUqar9wZyUp5dctMUo
 iP/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWost0B1Dk9CpEGdCVWWKPMCvH8ErRbwj+ZRqFVfkvjTB0LePCbgrgbET+Y/VaCXtE75USQ12w=@lists.denx.de
X-Gm-Message-State: AOJu0YxUKvuL9I6akPGT/moCfRh76nj8Lp2sk0Q717QruQLEKgzs7JfM
 jDDacKqv3FekpJVYS1BoMw0oS34oisbYv+DpGtIQ0C3FY8AwqIf8CQY0V90uCQ4=
X-Gm-Gg: ASbGncuhjLC5TAvLEqMb79G/wnlb/FysEB+Zi6sQ8EcWcZoPxbk9qgN9/9dz0q52ZlG
 t1BNYeQR575b/oAc/Aa9sr9WVopcSAzbskaJE8ax3Mq3W4dvYFKygeTM98P04kZbCHC+UpiTaUs
 gwGLXw+2g63b4DD66LPSb9tL9jLqJ0w88MPZGseHGEiqbCWs4lnN8f2cB25tkbx/+rGUoTOMMLa
 MMj5TyyZdOX4oUDo4HsqHBjUtfA7gOBklCETBEAbHiIV/b4ZUSGPaDR8ibp8K3+UuxBdB+hcycr
 r+5QvbUu4KSFIG9lLS7omwt+6JSKtWZ1lMCxMNNMFI2dyIzLb/KW47FB+0KC/oRQv1ShfbEmr0+
 EcK51RJHrpF+E
X-Google-Smtp-Source: AGHT+IHb0fuze4Wwha2C+b+G3EndRS53Xhbf9ivhtJDZPP1Lz0u7FUCWzZiK10Y8Jdwy/hUbEeVLAw==
X-Received: by 2002:a5d:5f82:0:b0:3a0:7af3:843f with SMTP id
 ffacd0b85a97d-3a1f6432cb9mr13712843f8f.19.1747151664912; 
 Tue, 13 May 2025 08:54:24 -0700 (PDT)
Received: from [10.61.1.138] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f579aa5bsm16577480f8f.0.2025.05.13.08.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 08:54:24 -0700 (PDT)
Message-ID: <8ab60d1b-8afb-4659-837e-fafd4b46a060@linaro.org>
Date: Tue, 13 May 2025 16:54:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom_defconfig: Enable AUTOBOOT_KEYED support
To: Sumit Garg <sumit.garg@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250508103238.230608-1-sumit.garg@kernel.org>
 <fe44fd2a-f16e-4f84-affa-3f9fbbbbdc9b@linaro.org>
 <aB4XFmFxBj30x5U6@linaro.org> <aCGc5giJlI9Wqxwl@sumit-X1>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aCGc5giJlI9Wqxwl@sumit-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 13 May 2025 18:10:14 +0200
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

Hi Sumit,

On 5/12/25 08:01, Sumit Garg wrote:
> On Fri, May 09, 2025 at 04:54:43PM +0200, Stephan Gerhold wrote:
>> On Fri, May 09, 2025 at 12:45:20PM +0200, Casey Connolly wrote:
>>> On 5/8/25 12:32, Sumit Garg wrote:
>>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>
>>>> When debug serial port isn't connected, it is at least reported on RB1
>>>> that autoboot gets interrupted. It is probably due to random characters
>>>> on the UART RX line when disconnected. Lets try to fix this inconsistent
>>>> behaviour via enabling AUTOBOOT_KEYED such that the autoboot gets
>>>> interrupted only when the <SPACE> key gets pressed.
>>>
>>> Honestly I'd much rather fix the bug in the UART driver, maybe it's broken
>>> pinctrl?
>>>
>>> The older UART driver (for msm8916) had a similar but that Stephen was able
>>> to fix with better configuration.
>>>
>>> Anyhow, this is a sensible enough workaround if nobody wants to look into
>>> GENI...
>>>
>>
>> Well, the main fix I did for that isn't related to the UART driver at
>> all, it's simply adding bias-pull-up for the RX pin so that it isn't
>> left floating when UART is not connected.
>>
>> For RB1, qcm2290.dtsi &qup_uart4_default currently has bias-disable for
>> both RX and TX pins. So please try applying bias-pull-up + bootph-all
>> for the GPIO that belongs to RX.
>>
>> For details, please see the following patch series for MSM8916:
>> https://lore.kernel.org/linux-arm-msm/20250422-msm8916-console-pinctrl-v2-0-f345b7a53c91@linaro.org/T/
> 
> Thanks for this reference but unfortunately this doesn't fix the issue
> on RB1. I have tried the diff below [1]. It seems most likely due the
> chainloading via ABL on RB1 as compared to U-Boot running as primary
> bootloader on db410c. The RX line seems to be floating even before the
> U-Boot starts which is causing the autoboot to stop. So for the
> chainloading configuration, we need to enable AUTOBOOT_KEYED. I think
> it should be the default sane configuration on Qcom platforms rather
> than allowing autoboot stopped via any random character on RX line.

I dug into it and the rogue inputs actually come from the button-kbd 
driver, maybe the buttons are slightly misconfigured. This explains why 
it only happens on some boards.

So the right solution here is to fix the buttons, or disable button-kbd 
if you don't need it.

Kind regards,

> 
> [1]
> 
> diff --git a/dts/upstream/src/arm64/qcom/qcm2290.dtsi b/dts/upstream/src/arm64/qcom/qcm2290.dtsi
> index f0746123e59..9392bd6f3e0 100644
> --- a/dts/upstream/src/arm64/qcom/qcm2290.dtsi
> +++ b/dts/upstream/src/arm64/qcom/qcm2290.dtsi
> @@ -551,10 +551,28 @@
>                          };
> 
>                          qup_uart4_default: qup-uart4-default-state {
> +                               tx-pins {
> +                                       pins = "gpio12";
> +                                       function = "qup4";
> +                                       drive-strength = <16>;
> +                                       bias-disable;
> +                                       bootph-all;
> +                               };
> +
> +                               rx-pins {
> +                                       pins = "gpio13";
> +                                       function = "qup4";
> +                                       drive-strength = <16>;
> +                                       bias-pull-up;
> +                                       bootph-all;
> +                               };
> +                       };
> +
> +                       qup_uart4_sleep: qup-uart4-sleep-state {
>                                  pins = "gpio12", "gpio13";
> -                               function = "qup4";
> +                               function = "gpio";
>                                  drive-strength = <2>;
> -                               bias-disable;
> +                               bias-pull-down;
>                          };
> 
>                          sdc1_state_on: sdc1-on-state {
> @@ -1293,7 +1311,8 @@
>                                  clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
>                                  clock-names = "se";
>                                  pinctrl-0 = <&qup_uart4_default>;
> -                               pinctrl-names = "default";
> +                               pinctrl-1 = <&qup_uart4_sleep>;
> +                               pinctrl-names = "default", "sleep";
>                                  interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
>                                                   &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
>                                                  <&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
> 
> 
> -Sumit

-- 
Casey (she/they)

