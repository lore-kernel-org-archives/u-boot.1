Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC862CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 13:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E26384913;
	Tue,  5 May 2026 15:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O799N9x1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE75D84933; Tue,  5 May 2026 15:22:39 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4192084910
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ad135063so49876075e9.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777987357; x=1778592157; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nhsXeuGAGWP0woc4Om42MRHCqyE0/v7DeZbO1lJH8bI=;
 b=O799N9x16WAZNckhlU3BXO0IcPk4vva98NzxFnGcXLLxeSObCjyobcXmLwIJIroOXz
 mqlfq0ZtR3infu1vgD0DOdclY95MJbLn4YHXCsqKqlT5bTruRxzgVX7NK/tcBjKSN6hp
 Jae1+0/QM+nPg1hFU+dLgpWInE2SnrVJ7LnKZMOwShhsIm5T0DxpM4cBHFUpVAFRWwdS
 12ecK2z4Tl76gRsfhCc7KmoeNCnlP3N4mE3awcxQae6YdcUHxQBSXJXR+b8rfHwLA878
 DGho5ReCyKb6R0xSG4k5H948UlvO5hDWUc6fSqW8URdnp/DgezFA0XPjD8jam2BLlNje
 HDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777987357; x=1778592157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nhsXeuGAGWP0woc4Om42MRHCqyE0/v7DeZbO1lJH8bI=;
 b=qsy7zlGZNsLn2siIZDCKyLM7l/Zftx1f6pV9hSMzz9LL0GABXz3Rd/H6N214B75R47
 IsQjz592Qy7FslSYc6llApG9mPbSZjYzmEmicyAw9Jxxpn5r0FwF2li9x3eWbQkH6G2c
 YE2vcjoTbQ8VCU77c6plwRAlb+MKtPGKCcw4O1ygoSWYU0PoDOfwpH6DzrbF03yTp7LO
 rjI6IJTcrBnqDwGb3RpbA51/wCtkZ6Smz0VK6p2jXRnOrBOAJVMq/YLoZ5DSvMNfmBzF
 pUMvy2MFElodp2NiIOCdC+1EepAB3sZuv6Vf4XHQzTPGAXloA2jDv/ZTNY6343Wg6IjX
 3/tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jokQIQdPCfjk9hqdSwsTBW+zR28g61cdxgNBvcjPYNxVwmdljAp5kwXmKaYhotARs+OHKqvg=@lists.denx.de
X-Gm-Message-State: AOJu0YzxhKXUHZtiD6egrAOyiPHzPFYDsZ8GJBxOfjz33uiiBqE1E6Fw
 fHoen4Mk/gklCbeq/1XGBr1/QCT0kUzCPyv000Sae9Al9lUmFLi8rZ2os5BnItj4ej3Xy0wDu5A
 mTPyeCV4=
X-Gm-Gg: AeBDies5gnUrfXgIW4TGtDmd5cuQy0+IIxDBBVRaAOkeDuastr0Gpku7J2mh/AKsDCT
 exa3CudIQ9m65YpbFAep6Dm5tk5jiXoznH5aJ4Y7UppdnOnEVsYXFpRE8cuzdypUT3MKtK5WWxj
 rRgsJRsJDNYNbih/Qc9gqWYQKvM/EXjZsaVAj1gw3Cn39n8xWRrJ1Tnqc5+UFI8SrrAtARyjVBx
 bYp70XLIzhaFD7rZ2lLNObwE0ACGcp4/IkBhK3pcX7nZvpeT+x8W0fVLSoiRLfV+vp6luKdSDet
 0gOZWSKU/I8xS14ab8hspa3WemJZCLMfPT2uAFyjVcm/lhyguLpBPk297cGnWCcrgY2elL+AugY
 Q8SZ5dSv/h8S/PkiGAl2ioDsrB33/RkVeHLcG059B1SKFQS8eR7d012qLicSFY+ddcajjU6Fi3k
 +yQ8ZBK88VMe3a/2aYtumPItdASd1sNvfdAK+FZ0po4WPH7quKKkHzM3eIDrBr0wWEi8HSywTzt
 Oq9
X-Received: by 2002:a05:600c:4f48:b0:487:59c:2bb8 with SMTP id
 5b1f17b1804b1-48a988ccc94mr258999325e9.27.1777987356639; 
 Tue, 05 May 2026 06:22:36 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d149f4f7dsm20512675e9.6.2026.05.05.06.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:22:36 -0700 (PDT)
Message-ID: <fe9645bd-db37-4210-9973-8edd115d8e35@linaro.org>
Date: Tue, 5 May 2026 15:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qcom: qcs615: align storage and environment with eMMC
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, Tom Rini
 <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com>
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



On 02/05/2026 04:01, Balaji Selvanathan wrote:
> This patch series updates the QCS615 defconfig to correctly reflect the
> platform's use of eMMC-only storage.
> 
> Patch 1 disables SCSI support and overrides inherited fastboot
> settings to use the MMC block interface, as QCS615 platforms are equipped
> with eMMC only and do not support UFS or other SCSI-backed devices.
> 
> Patch 2 configures the U-Boot environment to be stored in eMMC
> using a software-defined partition.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Balaji Selvanathan (2):
>       qcom: qcs615: disable SCSI and use MMC for fastboot
>       qcom: qcs615: store environment in eMMC logfs partition
> 
>  configs/qcom_qcs615_defconfig | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> ---
> base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
> change-id: 20260502-talos_emmc-fb6a079387d7
> 
> Best regards,

-- 
// Casey (she/her)

