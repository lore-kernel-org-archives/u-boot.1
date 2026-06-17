Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5036CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 14:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 559B584833;
	Wed, 17 Jun 2026 16:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ENxMm3Wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A781D848C5; Wed, 17 Jun 2026 16:08:07 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EAB2846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 16:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso29333015e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781705285; x=1782310085; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GBBlHAROflwyBBTIHKZ02QUrDxEiXjFv7j+f1QupkKY=;
 b=ENxMm3WiVQhxx3/qHKGi0Su/WZUxCDTVJp8fEf6x2PvTNRR6wlEh8sB0TKRMR88O65
 F0f06dlpOmDiUtqRaTpN3PPKiZ/w5WikPYlCigyr0IKm3gLO5UGdyDEYGqObiwuJshlF
 TUpK+wnoZvUJDsfl1bk4j7RiVYF2jCY3ssv2/7G3aavt7KslAyuZvXu46u9a/DgsfhpQ
 eUzHqbzeGwwMNCXkVCZ+4hXprxMbIdZAJ2Ho8a8Jd1eGzdbQCA3fyC2S04kRVaAVHvqc
 yrhMI3GHUF57DM+suJ0aRXceKUkfWUQSRWsj+bNhqHVq0bV95MvSLGg3T1fJ8x/fLFnh
 ygOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781705285; x=1782310085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBBlHAROflwyBBTIHKZ02QUrDxEiXjFv7j+f1QupkKY=;
 b=DyGVob+gwxX1i6ECaaMlxxxvx4edjM+2HvZz6T3NkHCqFsBpU569KJh2rpOrOiPjYF
 f5YvbbDMpat1Qj2bO4lkfBKbQiN2R7iJO/7doAboKQEaFPa4ZW97zF7wrTfK9bQhx1fu
 VM1y61B3gidKVdGxvZni/llhFviLUmHwOisdbqjF+LUYTwCHRQi4r9WvFWn8WVFOl42v
 h2t3HpCg2AZAYfYxxFrqiSDeSzdVi0Fg3cLiC0xpaVWdZ23kVkrLrxTMfwerUELS/hoy
 oRyX9nk/u9v4+9sf/+EjeGC0OxxU7vrHyJul/cHkxZdI81v6U84FrgMrjA4itiDLt4y0
 cZ4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ99J6Yxkv+MZhLpCL9u/do7+sNARNzWJ76TurdzBwngrawU+CyUD1pI6B7CmZDdQ33oRZF8AhI=@lists.denx.de
X-Gm-Message-State: AOJu0YytkbqN8jV9yO0F0GnqQaY+HQ7irTSyipgP12Gw3XRCdSHg9XAH
 PkgSvkw7r6VzATQZ88D2aVlO+rW3doenqhucBeeT1Kwu1y9ECqektzch2G2ZCwyp5LE=
X-Gm-Gg: Acq92OFS4kDibVt51DFi1MLOB8Ob9rieN0yH2tSSNlnoP+PAz0hvDIYnn3sIlxIwuxI
 8DTx/fyGWAkYehbfjeZqqhpxbumSdqcoWO+u/EkfsNg/lYI25dWEUD5RZ2L7Do4WAL7CJ2V8juK
 T3cvjYGyoq6Dm6qZhhMZgVocNcGQzR9eIxucLpQXBeYmfm1OqbFEIQGYX1G1O/3WhQidPg4EYg8
 zqd3d7cyJ8UbrT0ZBwwHP6krPbjOATO0v7u0YLbAG1fvJ51JtNrxFpAxiTqV00OO+Bgu8miSb3V
 IaPcUhbYyEwS+j5FpuSUe3QayWoF4ps8RvfMmV/wjLXtqxW5qznCUAkVKY07D8MUE2OFLGPvC6p
 XB1gIREkJr/FrmfFIX4B1buNeNpwDi6+HoU8zBq2CbfQ8vlt+9GrUvIU6UMwMevoTvQFY5dVbf7
 2nHAPdxtqnFSjaHd1sQODJakRnsao46T67dm3mDGeRLFgMfJKqK2re
X-Received: by 2002:a05:600c:608f:b0:490:c0d8:d517 with SMTP id
 5b1f17b1804b1-492333ba2cdmr81511475e9.3.1781705284815; 
 Wed, 17 Jun 2026 07:08:04 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa9f2c0sm199250995e9.15.2026.06.17.07.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:08:04 -0700 (PDT)
Message-ID: <08b9f32b-45cd-4402-bfd1-5ac5690e35aa@linaro.org>
Date: Wed, 17 Jun 2026 16:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] qcom_defconfig: enable reboot modes
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
 <20260606-pm8916-pon-v1-11-170c9cbe5099@samcday.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260606-pm8916-pon-v1-11-170c9cbe5099@samcday.com>
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

Hi Sam,

On 06/06/2026 10:47, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> Now that there's a PM8916 PON reboot-mode driver, it's worth enabling
> the reboot-mode DM uclass. Additionally the newly introduced fastboot
> support for setting reboot modes is enabled.

I was a little concerned about how this might (mis)behave on chainloaded
device, but I can imagine it being useful in some cases. LGTM.

> 
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index c7bc6829014..736a9424c3a 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -80,6 +80,7 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
>  CONFIG_USB_FUNCTION_FASTBOOT=y
>  CONFIG_FASTBOOT_BUF_ADDR=0x0
>  CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_REBOOT_MODE=y
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>  CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
>  CONFIG_MSM_GPIO=y
> @@ -124,6 +125,7 @@ CONFIG_PMIC_QCOM=y
>  CONFIG_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_DM_REGULATOR_QCOM_RPMH=y
> +CONFIG_DM_REBOOT_MODE=y
>  CONFIG_DM_RNG=y
>  CONFIG_RNG_MSM=y
>  CONFIG_SCSI=y
> 

-- 
// Casey (she/her)

