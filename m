Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8324ECD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E3748484C;
	Tue, 16 Jun 2026 14:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JETwjAfz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B2B2848A2; Tue, 16 Jun 2026 14:51:43 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0B2846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-46013161068so2271818f8f.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781614300; x=1782219100; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xnC+mQ4e2QYovWieHNPaZwJndcAkb3pWoEgBVN+oc8c=;
 b=JETwjAfzyQUl29XzJvOL+ftWAfy5RXRVfnQjbXAFp2aYMd97CWOQxBDm34OryNN3dy
 PnHqP0iPCAyxOpL+Jthp4Bv6bSGW1AjjVIw3Zt4hXbxzUGvyW/GMJNu3OU2xQ7/KCmes
 nQz2sH4pL+giLH+s9fVDZInDEuCLe94Ven/gLhKQLmpCargIH6AkPUXFw6swpYExuToK
 j8uV+n/+tlnLcKLMJkO+psbNmDiiVqkQbnuy6cJe6UTmoth3hoLMxTZdT85CTi1Z9Lv6
 50FEG6wtThTvSiZaPcWwxbjBAPuFilMcoKS6mXaaol05SWqorWvFdpt79gnAszkTMuEy
 8dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614300; x=1782219100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xnC+mQ4e2QYovWieHNPaZwJndcAkb3pWoEgBVN+oc8c=;
 b=GEe4V9l1bZXbRzqUajHlW34F431Fn39pj2CggD8oMwkHiBuoCljZV/zw7EJx8YOzVU
 ZmebjcFX+yPfRgBRszNZ5KTk3dmpicAKmloZLDZk0woxphk3tYxyR+JJmnz8h+JEwfEk
 fpN3M6bKAshSoESatl/ghPzt4APEtj5B6vjT4bYNzn9xhIdcQH5i75qhJYZRv1CPtKDo
 mMeLgQ5t4TEBKaL6z3QBxU5XSSwxSj52b5oelkYrPpV9iYZtObtZOwVsEKGQQ4bG6rue
 qruXqtKmpoLaW0cm4TKnNqsRDWo4i775yGEUyeiSvKCdqvoNxUa6DuMCgpjFJgX6qDgn
 msPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+S9mm3N+igl6LwsxsuOZz4G1CTS1QxzoOIbKRDG8Tt4jkrl/61OZoO8rJhnT1G2Pf08MZWOa8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3f/mv1IILQVCUmY2ML+nblpzQ+s9ZvXuBLMZzI1vvTDtbV2IC
 3TVZSyQDhGFL3zmBg0yFqA6+Ovkg1+ap/U4CwlRbuGzKHjmgBIY733mv9voAfds+9LE=
X-Gm-Gg: Acq92OGrybmx/a+VMBnfI8Xfg2nFlF+d8dvT7Dav1Ed0flpUzP3Qyz1cwm5fkeUpGJF
 8u5PcvRBfqrFxpF38nqBIeYne7I3RXgDbfe/ag8zqCHm70M/vfhiojr+eGerJhjyMtzpJ/cu6k9
 YeB06nJH8KigUyufW5eUXID1RYRkK7IRHS5mmjJJTY/drL1Dxujye1v1iaMiHMSAOQjZttnyXRt
 UP0c7EtEpjBbGNEmkBl8zi/StLT5ZzbMLQFfWMRT2WoC45udIQpmjoKv3Z70zJEKCa8hEbvUnIP
 AAu1HpIvQklDeCLf2NyVSqZkhixAG47FXo6IH9ezTJSbju97JMJdwCXIsyoo1rLNUGX4S45nCiM
 //vj0B6W90GdzktuzgHgVqWgISg8UnoNSYu6wtznu29FaY6duJdoA4Z8uB7dNNC/arLgO36EmbP
 rKQ/rGoTkuhwacjI31lsBtaFI8XEzFBN4yboy7FuxitmY0WmaGEhdK2NWavd8G+Uw=
X-Received: by 2002:a05:6000:25e6:b0:460:31d1:74de with SMTP id
 ffacd0b85a97d-4619f385b8amr6110519f8f.10.1781614300479; 
 Tue, 16 Jun 2026 05:51:40 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2cd6c2sm44407059f8f.30.2026.06.16.05.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 05:51:39 -0700 (PDT)
Message-ID: <3566a21d-b560-4b32-831f-c4eb988586d3@linaro.org>
Date: Tue, 16 Jun 2026 14:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] arm: snapdragon: Make SYSRESET_PSCI optional
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Simon Glass <sjg@chromium.org>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <20260616-sngboot-v3-1-6fb0dee8125c@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260616-sngboot-v3-1-6fb0dee8125c@oss.qualcomm.com>
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

Hi Balaji,

On 16/06/2026 11:22, Balaji Selvanathan wrote:
> In snagboot mode, U-Boot is loaded directly by XBL without a prior
> bootloader to initialize PSCI firmware. Forcing SYSRESET_PSCI via
> 'select' causes failures in this scenario. Change to 'imply' to
> allow it to be disabled when PSCI is unavailable.

General feedback, I assume you're not writing these descriptions by
hand, they are overly verbose and don't convey much useful context. This
doesn't need to be a paragraph, just:

"In snagboot mode, there is no PSCI firmware and U-Boot will crash if it
attempts to make PSCI calls so disable it in this case."

It isn't acceptable to send me patches like this that have a full
sentence explaining how it changes a 'select' and an 'imply', i can see
that from the diff.

Please do better, take 30 seconds to write a sensible commit message.
This goes for everyone with an @oss.qualcomm.com email

> 
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - No changes
> 
> Changes in v2:
> - Newly introduced in v2
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 514bf2000b4..a6d36f39069 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1150,7 +1150,7 @@ config ARCH_SNAPDRAGON
>  	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>  	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>  	select SYSRESET
> -	select SYSRESET_PSCI
> +	imply SYSRESET_PSCI

Let's not allow disabling SYSRESET_PSCI in defconfigs.

	select SYSRESET_PSCI if !QCOM_SNAGBOOT_MODE

>  	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>  	select MMU_PGPROT
>  	imply OF_UPSTREAM
> 

-- 
// Casey (she/her)

