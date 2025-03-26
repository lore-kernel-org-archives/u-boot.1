Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ADFC3600E
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 17:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98422810E8;
	Wed, 26 Mar 2025 18:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DVa1gprq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0500781951; Wed, 26 Mar 2025 18:44:25 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD2DD8070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 18:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43948021a45so1354355e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743011062; x=1743615862; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wH1nJx0y+ojq9QNP75ZKu7KaEFHLz/eB4dUAIORRR3c=;
 b=DVa1gprqf5+IE61xiXy4PLHWtsZbF4iaY+86/fqvpgZuQ96bTX4RcA3cwvZQe2nBhG
 JSMGONwlDMd+r9u5iLfQqPQ66zYEkz6ArHXIfZMiXiUFQd/0kjxXe1V76Rk38TsgJIwe
 1Z2ScrkQEBxt1gYUcOirQ2AkBppIm0ZtkQX+Jg69W7EkMgd/s01t78IIZ8V51akWbn/i
 +NGO3esuYYTnPrfuKDK2T5B+ibwe7zPUbGUjaTbVKHaD8b/Dpm0Vrr0HLSrzMyTZKmp9
 /c0Mz2Z2+y+xxl+9fqrtNGtlUMW7Jip8MJtqbpDq1Qkvkc9doYNzq8ll13dCP2BGBjJQ
 2cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743011062; x=1743615862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wH1nJx0y+ojq9QNP75ZKu7KaEFHLz/eB4dUAIORRR3c=;
 b=emGaMFShvCvNwDH3AcOBpBaPEs4Q6g4OWaPHgqLi/WYMduq/+d7jp6mPjKUeHwt8mx
 4j9o8OXMmm8ToHKmHN7lVqd35R8hYliqtFCe82bpvvdC0vCry1n+GU4PFwAG17bBJMT4
 j19wsCTTtzj1TdJNzYSIWhOo4DXEVRlbxJpjSokRO+uXkBJu2gYRAsqNM9QnzdBfbcV2
 AAHs+Ja8hlm2N1bEzp4V4cC3tLTU9PQw5Zbuqc4KwHbyjWiFpdlEXbdXvzre8EFHyKWc
 zU+uazYpnAqSJf0CMMjzqOWvs1nSb7r5n0MiZArdA3LxEmgGyRsFCgcktJfDReCmbrF+
 Tuwg==
X-Gm-Message-State: AOJu0YyH5MLZBwYzFh1J+0z1DdSCSBJSKRxshv4HcKVPgT9u0FTyTpBK
 YKL+s3tpXGKj06oCIU4epQPS0V7UyklysPpuQXX3l/0VnqXlhzb2CqnxD8+beFU=
X-Gm-Gg: ASbGncuTcAHBaswJ+03FT1sbsbDD//wZC2n1O7zw9PwGZAd0VzuVDOPmMJi+46KiwUR
 W49kqMBDY3xNpKiNw5YD4tVUCihTnOYBvzZLhoMrNLI88q3aJ9OR3LFS2V7aX/zw3e+qh9+Ork1
 Y9iWsY8s20vDpStxNpYykBhyvagFwLNoFiRYH9IPcP9YEOgfZNAh/MSm0yN8tAQ69Ao9+D5UFL7
 vslouy8zIojDdqz4nT0v00VRx8o4WVZG9w9Gsln/YxILQtoEQatKlYs5eH9ZQcwcjL6fqsoaGYk
 LG+oLGmvVS3ZJOPs6QFqVM9/4UVSqrWbM+FF7cdVbRJIHtWrOOXBMRDGXvOctsB9vvF3u9A2ZGc
 =
X-Google-Smtp-Source: AGHT+IH7Srg/1JQAw0Vn6J/XUDhOlnmprTQYXRDvltYRyscA+4drVssSXnvzyx1NJP2R9klFrZN8sQ==
X-Received: by 2002:a05:600c:4509:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-43d850c99e8mr2993905e9.31.1743011062150; 
 Wed, 26 Mar 2025 10:44:22 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe3fasm10160675e9.17.2025.03.26.10.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 10:44:21 -0700 (PDT)
Message-ID: <5f80a5cf-f8c5-4cbb-a80b-fc2aeab2308e@linaro.org>
Date: Wed, 26 Mar 2025 18:44:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Qualcomm: expand capsule update support
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
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



On 3/26/25 18:40, Caleb Connolly wrote:
> The initial capsule update support only worked on the RB3 Gen 2 and made
> a lot of assumptions specific to that board.
> 
> Implement the logic necessary to update U-Boot no matter where it was
> flashed to, independent of any particular board.
> 
> First, we keep track of how U-Boot was loaded, specifically if we had a
> valid external FDT (even if we didn't use it) this indicates that we
> were booted via the Android bootloader, in this case the target for
> capsule updates is the boot partition. Otherwise, we target the uefi
> partition (if it exists) or the xbl partition. We handle A/B support for
> all 3 (currently we always flash to the currently active partition with
> a minor exception for the uefi partition).
> 
> We introduce two new fw_name strings to differentiate the GUIDs based on
> the target partition, this means one board can support multiple boot
> methods with capsule update support for all of them (typically this
> would be chainloading OR flashing U-Boot to XBL).
> 
> Lastly, the call to scsi_scan() in dfu_scsi.c is removed. Since
> scsi_scan() unbinds all scsi devices it breaks device handles maintained
> in the EFI layer for the duration of the capsule update process and
> causes the EFI filesystem access to delete the capsule file after the
> update to fail.
> 
> Boards should instead be responsible for calling scsi_scan() before
> initiating DFU.

Forgot to mention: this has been tested on the OnePlus 6 (with U-Boot in 
the boot partition - chainloaded), the rb3 (with U-Boot flashed to xbl), 
and the rb3gen2 (With u-boot flashed to uefi).

More testing is very welcome!
> 
> ---
> Caleb Connolly (4):
>        mach-snapdragon: track boot source
>        mach-snapdragon: CapsuleUpdate: support all boot methods
>        dfu: scsi: don't call scsi_scan()
>        qcom_defconfig: enable capsule update support
> 
>   arch/arm/mach-snapdragon/board.c          |  25 +++
>   arch/arm/mach-snapdragon/capsule_update.c | 256 +++++++++++++++++++++++-------
>   arch/arm/mach-snapdragon/qcom-priv.h      |  14 ++
>   configs/qcm6490_defconfig                 |   6 -
>   configs/qcom_defconfig                    |   3 +
>   drivers/dfu/dfu_scsi.c                    |   5 -
>   6 files changed, 245 insertions(+), 64 deletions(-)
> ---
> base-commit: 68ac813c70d991ec518d0fd815efdb10a05958c0
> 
> Caleb Connolly <caleb.connolly@linaro.org>
> 

-- 
Caleb (they/them)

