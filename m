Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCC8CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F408484C;
	Tue, 16 Jun 2026 14:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="knPqLxz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8565F84884; Tue, 16 Jun 2026 14:43:54 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87758846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso2373790f8f.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781613832; x=1782218632; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XxgZ08dKkAyXmJ9rJoKDTggKXowq9Ke/6BBkc3ehBYM=;
 b=knPqLxz7aAj/iBOvSSPA4lYjsyqE6dHfOZIulBjxD+X+Bgx3T6ndSIxBBToJ7pkwna
 ddwOvaehkvShCILBMHSj16wqLGVhvb1AOjj4HkP8ltoY+jXCj4QgYy+T5j8iSt+Mif2z
 1jm1qqKXygA7kqusxfz6iDeC5BksxNbqNguUPvV5LtB2qEiJWnixwidEV5DWGFTpL3TY
 qu/i5qqlAM97RptcC5jCNYwoNPOI9buDtw4T+2SGdDTtNWRgSfx3jxK1QUle3CSFEpMQ
 hDP9VHYwUHWi2/yCRE8KeR2/6aTTcISCqyVcDS85TwcSRG9cmuMjpHArPkH0NLfbZQpj
 3h0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781613832; x=1782218632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XxgZ08dKkAyXmJ9rJoKDTggKXowq9Ke/6BBkc3ehBYM=;
 b=STjqBHWuJksskeFTISrk9mARxQHxif1OeivcHqLVqkYMmSLTcDWlaJ7aY61/ZFT6qm
 ugsdEVQWBXl3Mz3aD7qf4ev/XgjABfyHqjnt9G0nL1W5RRIBy5CGJSZe8ytqhhLauwSA
 G5d76bhPLOSoazyO5p5BuDWXDjRzHmxWNLn46UAsBs07+k01YQmlD5zG2kdAwpq6jVwl
 XiNevNEK8jGNFWn+DNeKZJ4kkgCY3C4zJoKDBfHXb/xJl+y/yUWim+dfObOTgooKTE7q
 T2mhzv27bsCBoGAdFkzVpNJgRk4mOvf+jsdYC2MyFbpIObSjkvf0Bi5NWQMVAeafHarP
 9c9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ85nMREqQXgW9Bpw/Ek8Wx5pCan4N1q3tbgcxMjTCvboGi8xQe88y/RabKB28EGiqNraJrcWPU=@lists.denx.de
X-Gm-Message-State: AOJu0YwNtWPMncuLAq3YDMbVDSSQZ5zfzBwdvX06fDeI9Nrob8q1JIvx
 5SC6EQtoPytF02BlXUH8xIzBv7XkbkLxtNN/f9PP01Q2bj5Gj47FrpClzm4stIujOso=
X-Gm-Gg: Acq92OHoo0uHk3ohe5TNIk9UiBf1kEkE/IfuZWbYp4MrBEKixyqB5hKvHSEHSVPNBSC
 ixWl9QQDhL2ago788Y3qWJat44Hrg0m2h2t4bNb17a0oRuBmgr5qCP5DTHsWpnY/SLVv7g4n3G9
 QC81bJRiOfYaoPjRJXVNCM22TG9zi78IwBw1cWSutYG5mMZC2ttvkHH+CRRFdgUVWEfDBvxMmeH
 a0jbBB8+iNw1AAeHz74qV8aNi0W5Hi0TL67en1TgKljAuWeTuRSk0YMJIf9UBehFr4G3kYClRLc
 dohoAfHTCnk/P6gwCfJpwKIca4Q5E5BfcRtvQmUXOltroBjdDZRVKZ4rFoB75cB283Zzr7E71QI
 bZXBW1egM5n1tFG7rW1jdC9AS5ahUfdRzc2UE/I8oM6wjT2r3ZWCKrwsOnQqsQHgp2TbPaEa++0
 4VJkQnww9bD0ApoD4hHtaDVoMXhfVgDpRmiuBAS0OrDnlvcFkBPN9WKOu3MKcEjjo=
X-Received: by 2002:a05:6000:1787:b0:45e:73b3:4515 with SMTP id
 ffacd0b85a97d-46074b87912mr21415252f8f.35.1781613831468; 
 Tue, 16 Jun 2026 05:43:51 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f264333sm45645979f8f.4.2026.06.16.05.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 05:43:50 -0700 (PDT)
Message-ID: <7c31cef5-f79d-4bd2-8052-4beaa04ab7ab@linaro.org>
Date: Tue, 16 Jun 2026 14:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_SUPPORT
 option
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
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
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <20260616-sngboot-v3-3-6fb0dee8125c@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260616-sngboot-v3-3-6fb0dee8125c@oss.qualcomm.com>
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
> Add CONFIG_QCOM_SNAGBOOT_SUPPORT to the boot0.h workaround choice
> block to enable snagboot mode support on Qualcomm platforms.
> 
> This config option automatically selects the
> required dependencies: QCOM_COMMAND_DB_OPTIONAL,
> ENABLE_ARM_SOC_BOOT0_HOOK to enable early boot hooks, and SKIP_RELOCATE.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Newly introduced in v3
> ---
>  arch/arm/mach-snapdragon/Kconfig | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 931d25c1023..e173af1ce45 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -63,6 +63,19 @@ config QCOM_EL2_GUNYAH_EXIT_SUPPORT
>  	  Exit Gunyah hypervisor and switch to EL2 during early boot. This must
>  	  happen before EL register configuration in start.S so that U-Boot can
>  	  run properly at EL2.
> +
> +config QCOM_SNAGBOOT_SUPPORT

SNAGBOOT_SUPPORT implies that this adds support for some feature, but
presumably this shouldn't be enabled in normal U-Boot builds, rather
enabled to configure U-Boot for a particular usecase right?

I think it would make sense to rename this to QCOM_SNAGBOOT_MODE, then
we can probably also avoid adding "QCOM_COMMAND_DB_OPTIONAL" later and
just check this option instead.

Please also move this option out of the boot0 hook choice, since it
really doesn't belong under there, add a QCOM_BOOT0_SNAGBOOT_MODE option
there and select it instead.

> +	bool "Enable snagboot mode support"
> +	select QCOM_COMMAND_DB_OPTIONAL
> +	select ENABLE_ARM_SOC_BOOT0_HOOK
> +	select SKIP_RELOCATE

I see in the new defconfig you add later that there are some other
changes that seem to be required for snagboot, like disabling IOMMU,
those dependencies should be expressed here.

> +	help
> +	  Enable support for running U-Boot in snagboot mode on Qualcomm
> +	  platforms. In snagboot mode, XBL loads U-Boot directly for
> +	  manufacturing and recovery use cases.

This is not very clearly phrased, just be clear that this build of
U-Boot is to be loaded in EDL mode.

> +
> +	  This option performs early boot initialization to ensure a clean
> +	  state for U-Boot when loaded by XBL in snagboot mode.

I'd just drop this sentence.

>  endchoice
>  
>  endif
> 

-- 
// Casey (she/her)

