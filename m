Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24ECC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 12:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EFF188606;
	Thu, 18 Apr 2024 14:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nMkGcNMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447A888620; Thu, 18 Apr 2024 14:41:02 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED17884C4
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 14:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-418c2bf2f55so5887775e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713444060; x=1714048860; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4CFR71PgSVdQa4puv58irIzYtpvzMyGpPNEhtXiTIPU=;
 b=nMkGcNMZMsG3QrGicmgsJdepmE0kRJvVbh5vbmv9X+LJva+OsVZP0KD65h9YufDlHj
 Wd84jioIdNGEJaE3g7fuLvkcBkG3NlbSPm6gyRzq5Bf7D46NRFacEe0V5SrF0ZattCCG
 xJlIZbto7JqRiC9xndQdm/HLYWHgY8PgrFShMG/HgWfWeBuCkzr18WTLkvjSlfiVhh+h
 RfxiOMZi8FuBKSJoGLGlfBN6i4jJ3fi6WRplzuRIMRYj7SlnRcC9XB14cKjaat1x91iz
 UsW4e0mqZ1Hl7a9HcUKvpL5rztdamk/wD76BH85OoGTXcOi5Xyy0e16ww45BvZvDGjuE
 DGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713444060; x=1714048860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4CFR71PgSVdQa4puv58irIzYtpvzMyGpPNEhtXiTIPU=;
 b=LDFibEZoXt2Nps9pcUV7ErfmgjXEkirZLhDptd0Uj2FaeUxEzRaJ1RoUUxiXLsbTXY
 qlfyBnzz2ftZ/IlIyhDumpwe9ToNU1AePqaH1GF9oSmU+zAhIOllc1HXubWWmvCY44SK
 jV/sY11f9U6qc9mqlsG9P5e8niRoUPPm8kdSUQf8RIpuOkLau744YG1O41PqRbjFLNM1
 AanK2WfZxSt/oswlm9V2v4pVNazwhsHLN3Mv1xp2q6YHAVxijwDN+ty9BBBV/wTKuZ0g
 pVNV6zMz1T+gieuRbvxbds+PZVdBNLv/xhXU24Xvvt2zgcuVevYsbmKm2B9DySDY4a26
 /dyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuu82yqLZ8fBmF93Kpzf6bo79PmYnDcJIWrVQbSGsJL52Hep3/+iT6xoQdDlATdM3emUsHjbmbxf/Jmu6MJnIZQqhQQA==
X-Gm-Message-State: AOJu0Yz711hnRQwRdJ7/osq6MjsNfVSV2AqKuRzvSK2f1K0P8/oVSYSe
 83HhhsuW19CPD8B0r2yBO/VA75MJgwkFO9/ONZm6Py8xE5OS2FMejHyMB9N6oik=
X-Google-Smtp-Source: AGHT+IHVn/qPzXb0/e9sMvtpqki3CCcPi4rcxJgl6z+x3my2nVdKqpI0yT1ToMsJx6d2aUAP+Kag1A==
X-Received: by 2002:adf:e407:0:b0:349:aab4:52a with SMTP id
 g7-20020adfe407000000b00349aab4052amr1454473wrm.71.1713444059640; 
 Thu, 18 Apr 2024 05:40:59 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 iv19-20020a05600c549300b004186c58a9b5sm2571480wmb.44.2024.04.18.05.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 05:40:59 -0700 (PDT)
Message-ID: <4b0f4e3a-f113-4dd4-a278-513798f5f5b3@linaro.org>
Date: Thu, 18 Apr 2024 13:40:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] pinctrl: qcom: allow selecting with ARCH_IPQ40XX
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com
References: <20240418091435.18232-1-robert.marko@sartura.hr>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240418091435.18232-1-robert.marko@sartura.hr>
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



On 18/04/2024 10:14, Robert Marko wrote:
> IPQ4019 pinctrl driver was moved to the dedicated Qualcomm pinctrl
> directory, but the KConfig depends on ARCH_SNAPDRAGON only and thus
> PINCTRL_QCOM_IPQ4019 cannot be selected when ARCH_IPQ40XX is used.
> 
> Fixes: 24d2908e987a ("pinctrl: qcom: move ipq4019 driver from mach-ipq40xx")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/pinctrl/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 2fe6398147..bd2019c866 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -1,4 +1,4 @@
> -if ARCH_SNAPDRAGON
> +if ARCH_SNAPDRAGON || ARCH_IPQ40XX
>  
>  config PINCTRL_QCOM
>  	depends on PINCTRL_GENERIC

-- 
// Caleb (they/them)
