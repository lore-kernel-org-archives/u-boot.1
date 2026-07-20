Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD54C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 13:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90728848A1;
	Mon, 20 Jul 2026 15:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GvE+9fJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C8D08498B; Mon, 20 Jul 2026 15:14:36 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2DF848A1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 15:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso425261f8f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784553274; x=1785158074; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NaAgez9Zqkk8Ur46+kmVp21ZxHYk+VbiG1OfIiXkYNA=;
 b=GvE+9fJCqsHuXOQbnYsZklpeAHGNfTvK2CDb7TwmiUTeLqtQ6NL4zW72PQ7fTuekk4
 tfcCmpME0dVO0EUZ57QM2zAA2uQ1Jas5VfnOPfzzYwOEInPg14s7Vu2cGi4xNUpNu2Nb
 SE7jsiasR5L/Lx36HE71zwz00KgFl7IzX+FkPOBTQN91o/9PlFu/C4IOdD53DHkAEbqv
 sFDIC/wWpM/Gq3NPmTdH1Q2ZEaeBRO/9YrE8/8Ui1zxctWiq1fsAhICFpr7iSVm/GQUg
 R2v1foFD6ieDsL23oqEx97j2k0NY7OJIfRGLtlQCT0HxItWNT6rt0W06tvCVEUNlfvj1
 CxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553274; x=1785158074;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NaAgez9Zqkk8Ur46+kmVp21ZxHYk+VbiG1OfIiXkYNA=;
 b=DbHbI8/ZX5msSNFSlJmzfKe3QZ+7oSeScpJ55SiWb34OLkPEx8fJgUx5ncObDagZBI
 trcWlE0ukRjqzrLDVE4538A38bltg3ZCuK5MQLidGY46pP+tbDMqDu9dcdKMlhklac0H
 yejSKgXtocRDsyT24eCVLM8fBsr50nxZwjKuuWKP+NskcVklLI0xOTXEcjFiFMljJBXz
 Rfz64L/J6bhEVxTlTvT+abUI51qOszktPcPGlyBRKuDrL+kg3qDkvZP/KXL5GflEm4QN
 dCrH2ApKVznepH6K0n7OfeINBWqcgWwUlIC6nOz2CZjLWCOk/uoa6bJPhJ5I0DF9g1l0
 KOUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS7fsi2RPfdJcwyUtSOO1A9Gqy3j87EM0WqCTQBlDqCL9QwheHNC6dmkLMGnSa7TGfJIBrBIU=@lists.denx.de
X-Gm-Message-State: AOJu0YwrZpN8SjLFNTlLRSXceDqL+a/tl7yI44CI52DeXwqJ+mlj0OwY
 HkqoQz7oWQu3SxcS/ebmkjOip3+MK9Js4cR9lJ3uaW3Oqohr/98M25SXHvyYLX+KZJs=
X-Gm-Gg: AR+sD131yj7um4yXf+ya07QzVIYmdJYGoumlUlak6ceoCCv7E6QujKd8F2jOIg9qDNM
 2cq2AFuxHfTdjUwUcHN+EliZnu1RyR0tJ533RsksoJd67JfgNWP9n4/GlUmS+UKleAqw4ta7srR
 Mg9QdW9V0pjBdpBZWqyw10cPxyoGOhZB+XKoiNEjDYSJlMtQYFba95TP91XVUS7J0ZVMEcxibjt
 vcBW6ZlhuOZ5uKiDLTazKypfudFVvPwZd6y/MFr8uzcOfcAewn1s91mlv8Z6d0PCmkHaFevwPFQ
 O845SJHLNjm671NPNaUa9oz5jrlGdJsP8s/L435VMGs2a55abZfW0b24B9H0SUt9q06a3P+j5+S
 BfWcFLYNeMxb3FXpBZhhPmEovwm5m+BTpfbUk5be1Fy1+3ei0hmKadXjX1tPNcjHq6KUPwkE1o2
 /SczJBssOtaxx8ZvSihrCmDwXLTCFY45mNWJpij8nPnY1GKkPUbJ69PlvaZGo=
X-Received: by 2002:a05:6000:2c10:b0:477:80fa:f474 with SMTP id
 ffacd0b85a97d-47f6232700cmr17151814f8f.38.1784553273707; 
 Mon, 20 Jul 2026 06:14:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:1101:a3b4:4010:a727:b812?
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f6b85970esm23811496f8f.15.2026.07.20.06.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 06:14:33 -0700 (PDT)
Message-ID: <3be820f2-be69-45a3-9a64-dfba21dc33c3@linaro.org>
Date: Mon, 20 Jul 2026 14:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: qcom_defconfig: Enable EFI variable runtime
 storage
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260720-runtime-v1-1-7f904b4cb3ed@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260720-runtime-v1-1-7f904b4cb3ed@oss.qualcomm.com>
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

Hi Balaji,

On 7/20/26 11:25, Balaji Selvanathan wrote:
> Allow SetVariable at runtime on U-Boot's in-RAM EFI variable
> store so the OS can write EFI variables via efivarfs. With this
> enabled U-Boot also advertises EFI_RT_SUPPORTED_SET_VARIABLE and
> exposes the RTStorageVolatile and VarToFile variables, which
> userspace tools such as efivar use to persist runtime changes
> back to the ubootefi.var store on the ESP across reboots.
> 
> EFI_RT_VOLATILE_STORE depends on EFI_VARIABLE_FILE_STORE; select
> it explicitly so the option is not silently dropped if that
> default changes.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Thanks, nice to get this enabled!

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   configs/qcom_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index c52f619850d..01c70c25c66 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -10,6 +10,8 @@ CONFIG_SYS_LOAD_ADDR=0xA0000000
>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>   CONFIG_EFI_CAPSULE_ON_DISK=y
>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_EFI_VARIABLE_FILE_STORE=y
> +CONFIG_EFI_RT_VOLATILE_STORE=y
>   CONFIG_BUTTON_CMD=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> 
> ---
> base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
> change-id: 20260720-runtime-4b0d467f5b73
> 
> Best regards,

