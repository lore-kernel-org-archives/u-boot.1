Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940F6C98302
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 21:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D9E1607EC;
	Tue, 22 Sep 2026 21:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eLikkBOl_gu8; Tue, 22 Sep 2026 21:23:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 59AB5607BB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790112197;
	b=Yja1l+SYr57zed5k3M64oWbEC6rCrGVRPv5r9WeJeQh05j3anmjCpZqwGPxYRmVsIRUY
	 jQ83FAkOQzAQARFkOtns87KQug/qpf6iNH1ZhkDtO25yW0dqa+93JL6nh7jvv7hrJ0SEr
	 ZU6RykKS9PZjWWTdd/kD0vkeOnl8xtbJuufGbtzj/WCefdY2oDPckhR2RE8NMswMpWuuC
	 vujjlHkHC5kLNVsGOi/Zn+1rYsSGzQc/yFhdTGMWL0mCOCWjzOre9VGrvWKeMDfs/x89l
	 /xQbu5NmGEi0vF6abJ0OaXu2gCzWbu93QXLVjS3ceixKmBRYnERxC2MK3teOfiT8+uQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790112197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AiQX5pW9w+f9+IdAbMaxLAXwEZwydympp6pj95MTXts=;
	b=DeFaYDS84ItrSHYO4m8VDONFjFqN/lyly7HGpNVCj2xlcFaTNuI5IhDIuQzu7PHaket6
	 nt4g5Da3N4Y+rfdjO1mnXXqTiYlxQqzB2b8QX5SKBzbumQ4dxHiyoG4TOemp6NUBHVSdZ
	 zaHddbFEKj1OgiGNytre7mRgnpOu/oBVcmv5BAAt8OTL+knaC6xGSHVLKI4ka7ELQip9w
	 buT/CwXdi6jfUTG84hlcowd9KQJPXtFwVi8F6SA4Bmf8kiPA6wOdOgnEIVhs20Pc7rIiQ
	 qViUF2gK9heOD+PPKJFm8Y3jYIOQ6oTJ7N4xjMejatr2mzhXzI9ocSJ3UzPcKokh/gQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790112197;
	bh=AiQX5pW9w+f9+IdAbMaxLAXwEZwydympp6pj95MTXts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xZV0MRolI0J0Q9H9dsoq/3xmpLfEnTbuLtrvIK9QckZBho+vdLHJjVYscUxC+H1zA
	 BStAuvtaNxeULMSOFYj+6FeUJFN2jO2+yXiHFPWB1c1o3wuyQMA/fZJUME1a96Vh7p
	 Q7Bf4t8XKgYmTydE8akSnTa7HTbFl9+VX1bvd1Ml8dMN6/fKpgPNy6paHhypywZN73
	 pv6ATV1pMD/ItClOvpLGnZSPb6BWuFo8KPm+lsGCEDza6sxBM8bS2bkoUIiU73ttM4
	 A6MvywO0vABkZ8t5wmxMIfhKl4zXjWGp97/LQAIHlgT2z366xc6IdT5SeEDMFfS0Sd
	 WeZq97waJCrOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59AB5607BB;
	Tue, 22 Sep 2026 21:23:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F33BF3A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 21:23:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8C6940282
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 21:23:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZ-T87B5lHTa for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 21:23:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D1998401E3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790112195;
 b=l3N+Y8MHUj5jyVhjiaqa+1e2Sg0eyfU63VYVGVmQpID0L3LLP9hAg/IQt7I3n4SvTmcw
 fBT6nKaaAOGqYjanbXUYtaBhrmvr1dI0fjHzHl/qx39sT5s48txjPX0KRtfzxJ1fCviLD
 nDNcEvfltz5P3tSTHNyRlXpYDWWuDERFPvl8Rpm1yYO1Udj6rYdR/PvjvJj7vOhYTvpN8
 X+yRjBpxQm3dglGwsmgjxDJRWckPUyGjV8VePtBMEZHbuoVXRZ38uUwpd3pd3MCI8nLaD
 wBfSeucZK+tUZmXyH4Og2RWuqSZfyUlOipPP0ufwqEBiVmaGvnkP0lksFzRzYx3fT7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790112195;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=AiQX5pW9w+f9+IdAbMaxLAXwEZwydympp6pj95MTXts=;
 b=knBuRfL15doAaFg+ZzHMIF+NaCUPMQvamQKw2sAO3y+/75ViM/jVnIQdoDE7/erCsr3R
 cMjIX8FvTfWxvSIUZ6epT8kVIRVlKcQRiDcFzYO1GKfq5e1yQgBEqLEPsyqTPH54dA+U9
 m+b3MazgmVSIiVdPsvxSexOBOVyDlaFj24bcFpM3o74ya0ljJXXFcHWtv8gtN5Wcgjyo3
 ouNMzKy+FJvcGKgp4tyq5rBZJBC/UsHkM7IOh+jZBu2WisM+5VfjwTBX+p6RvOnSZEFvS
 F/Yne+0KyF2+qZOxl0SwVF69UOiKpCmXc/WPol+RmoKR014XaFemEaEpp0/wEv4+M2A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hgWtiHP4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::f;
 helo=mail-oi2-x0f.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hgWtiHP4
Received: from mail-oi2-x0f.google.com (mail-oi2-x0f.google.com
 [IPv6:2607:f8b0:4864:32::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1998401E3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 21:23:11 +0000 (UTC)
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-81201ed7d35so313807a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790112190; x=1790716990;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AiQX5pW9w+f9+IdAbMaxLAXwEZwydympp6pj95MTXts=;
 b=hgWtiHP4Ys4H6P/bdNZ6ZzrVu+Px6mhPKwmzgwWS5VJX2Ua6/1VFwsE+rhxpNW1bj8
 ZLDByCyVp4VxT510ZHO0Ixw44hBNSaCYGQaXqljHmfzpDfEG5itndanNskqyI2WJy3Og
 64UASP+q+xDgfeiTI4WgB6MGPps6UMKjZyv0Ad4eUw9dKEa4ZrqbJ2Gxi3vrMTp8KyUj
 cwYc2musm3X6uWFuyMq5kxUTuQmt968spXlsdnH1OaeF1jWvLmbl2/a6fTY1MCZ2Rfni
 ZpI+ckQnoyqNSed9k2pFzZ6xFUJCbCVIYW+cUJu/M+fyTGkNOO2r/0C+intotzmo53ig
 o36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790112190; x=1790716990;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AiQX5pW9w+f9+IdAbMaxLAXwEZwydympp6pj95MTXts=;
 b=KrlXqz6MvI1P0vMnZ2SAZ6escciyhYrv0Wp8vWv1w2fc5KEeSj+ZWVukEKAWskOcIE
 wJmHoyazIxEjQmLjqLSN832OR/cSWmg+vXkWUNbp3hIheETs61NR+9RHNV0tV0NbI1Fy
 cG+g+N6wQKlW/G9bVm9LCBvI9CfLQAbaaWGINBMtOgKn/5wnEZPGJOm4g6Jtp/UZssPW
 ooj629pXZDtLLt5zmltnn9ozaIVKf6aFNwI3O2RWzz3XZGh4cfuPJ0Kl6SBddC3a1Ttx
 ScJZkB8rz9/oTZpN9VnDJs4f6SlzJ3PfjkG+ZixfExBrvAjLd/87iQgzrkeuPU6fP2//
 xjew==
X-Forwarded-Encrypted: i=1;
 AKwUvByFWdCEvv/0Dgi5fz8Kc1+Wg1vqRiGEWksopBicVtBzWkgTueqrohJ/CLePkLBZBjnVtAaWec4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n36oKuM6e+2TQ2lfK517p0jboO3hPFilame1YetkWkVkYcoHMb
 o6TKRM0VzT11rZYkU+5cpKtPG7A9Z8sIgXXgLyos33TzaGWCmsCiZ7Q9yIWQC4N9leM=
X-Gm-Gg: AYBFou0Ut/xvrFQsHoU1qPv4EVh0ihUv92RNCeEYdadZalv74loy+178t5Q6dsyp1CW
 P8z9b8TaH/LsFCDyI4IMhMiiTmgY+ViMCMZmgr061Wtrl33mmEnYsjc5sqFWH1FtWhguPWdDbCo
 go+bL/VCNAdMZMhDFjLZKsxIAZpdzoKDWVVLILRCTNLlbDMeOVTjq8ZonvoHkDD67LRunmS0YZB
 JFdApRRFf3LKxX+4/8Emq6IG+In7YwCLGKHdOhVP5xVmEZlKUdY1/71El8Bs0RA+OaLonwVy4Dg
 0lCz06PC2K/lSeO/aAVp1V+gotHr7paghePCIDuPtR+LcktEIqG+3nG2/F7UkzuRJFk7pCMx1l1
 SIXqkavttdSUDqm3Ewf1Ep8pVmNo1sPWXNQl4hM0daj2QTg7hDpD6qWSKAmIKvZc6p4xK2xNoKW
 MlbBspJ8CyKdcTjP0gzZvL5i/zWWuYfAH1CRav/GZnWzCNAHQdy7jjyw+ybsk0us2/vfvA6uPyt
 0vz3kcLY1vRNrgKaGIyqNS5P6B5EVREEdeOBwWIiUC4vlcirfgK0M77VHg=
X-Received: by 2002:a05:6830:81ca:b0:80c:d30f:976 with SMTP id
 46e09a7af769-815f2a1f5bbmr1096046a34.23.1790112190461; 
 Tue, 22 Sep 2026 14:23:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e?
 ([2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-816045c02fdsm830549a34.21.2026.09.22.14.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 14:23:09 -0700 (PDT)
Message-ID: <6becea3a-02fa-47ce-8f89-95a535ac962a@baylibre.com>
Date: Tue, 22 Sep 2026 16:23:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] arm: dts: mt8390: add framebuffer reserved-memory
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
 <20260904-add-genio-510-and-genio-700-hdmi-v5-12-dd9dde2f972e@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-12-dd9dde2f972e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/4/26 8:50 AM, Julien Stephan wrote:
> Add a U-Boot specific reserved-memory region holding the HDMI
> framebuffer, and point the hdmi node at it through a "memory-region"
> phandle.
> 
> Both are only needed by boards driving the HDMI output, so define them
> in mt8390-genio-common-u-boot.dtsi (included by the Genio 510 and 700
> EVKs) rather than in the SoC-wide mt8188-u-boot.dtsi. The region is
> placed at 0x72000000 to stay clear of the reserved-memory pools
> declared by the boards using this SoC (the Genio EVKs reserve the range
> 0x60000000-0x61100000 for the ADSP and AFE DMA pools) and of the kernel
> load window (the Genio kernel FIT images load and decompress the kernel
> at 0x64000000).
> 
> Its size, 32 MiB, is just enough for the largest mode the HDMI driver
> accepts: 3840x2160 at 4 bytes per pixel is 31.6 MiB. Raising
> MTK_HDMI_MAX_WIDTH or MTK_HDMI_MAX_HEIGHT means growing this region too.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |  1 +
>  arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |  1 +
>  arch/arm/dts/mt8390-genio-common-u-boot.dtsi  | 26 ++++++++++++++++++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> index 586d15bf72e..dda05bcf7f4 100644
> --- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> @@ -5,3 +5,4 @@
>   */
>  
>  #include "mt8188-u-boot.dtsi"
> +#include "mt8390-genio-common-u-boot.dtsi"
> diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> index 586d15bf72e..dda05bcf7f4 100644
> --- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> @@ -5,3 +5,4 @@
>   */
>  
>  #include "mt8188-u-boot.dtsi"
> +#include "mt8390-genio-common-u-boot.dtsi"
> diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> new file mode 100644
> index 00000000000..87953c30776
> --- /dev/null
> +++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +/ {
> +	reserved-memory {
> +		/*
> +		 * Keep this region clear of the board reserved-memory
> +		 * pools (the boards using this SoC reserve regions up to
> +		 * 0x61100000 for the adsp/afe DMA pools) and of the kernel
> +		 * load window: the kernel FIT images load and decompress
> +		 * the kernel at 0x64000000.
> +		 */
> +		framebuffer: framebuffer@72000000 {
> +			reg = <0 0x72000000 0 0x02000000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&hdmi {
> +	/* U-Boot specific: the framebuffer lives in this reserved region */
> +	memory-region = <&framebuffer>;
> +};
> 

This isn't part of the upstream binding. I think we should be able to just
drop the reserved-memory node and let U-Boot allocate it. We aren't handing
it off to Linux or anything like that.
