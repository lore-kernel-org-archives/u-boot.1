Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEAED10F5A
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 14:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F32C84214;
	Wed, 26 Nov 2025 15:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TshlmtIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1E58421F; Wed, 26 Nov 2025 15:24:37 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AC084201
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b2a0c18caso4185147f8f.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764167075; x=1764771875; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cwdvnage6p9SH6Ue63bnPqMswGLC/B03l2ml360FTqA=;
 b=TshlmtICybebnrj9K/OLttW2bOnTKvL7w9KDKSss5TIXpH7T8OPrJsSCHdHuesycfx
 dgHE8r0P8EPNfXVtuMMtsg5IThTWaP+1Djt3ZDcsNWZ/41eJUwC5Exj9Wg6eHfzTzsLU
 oXWX+XQqvu+JY2ShM5a/kbLstdd+WRS0PZVqoMBMOV0UsVoo2lFhq9pMhT/uxiJWQHjz
 a5yHSyOL36ou+efFWJARpnxtsb36lH0O6AG7iiP02yni0LeVG8HmeC/myV37FvYUj65Q
 Pz417Gc/jDHEFzK9TtZaAgJr3XqEo8y81N/lp/jU13QnNkxuprA9fwXr34KyBbTTPJag
 B/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764167075; x=1764771875;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cwdvnage6p9SH6Ue63bnPqMswGLC/B03l2ml360FTqA=;
 b=hhN+I1Y0CcKjo7W4MfZjIlv0UtJN9AyOzGnaX0KF31ywRaQzEa5J5gwAosxHRmkmDb
 VVqx9sL1Mtdq9WPwBF9qHa75uJNaTgetEhvq3eajsIF0/bvFrEXIf/aTB3qXEaPc+HPA
 4bNePYEZaK/QEkmbBZukQIe0lsSTtmeVFXm8ju6ozKJJx52rLSMOFXNGXnaU3l1fdJ3g
 xGh63Dw6wWj0XD5JDVWYQVx/jA/0oSCqzVMZCkWOHueIHONuy5vCivCWL1x2+sRwez35
 UzdCEKNA9ea6si0Sw3zZugcWzt93UCSeu7ceDL1mSKmk4jSblQ8sBSWhOamI4MG+HuV7
 r70A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU53iSsgP4kwlVpu58xN1nMlhoUatJZ+7wERI5JYxfgK2WRpm08ukRhnNfooENivIjVnr9M/sU=@lists.denx.de
X-Gm-Message-State: AOJu0YzZkBOND+9lIMP8oJZppZtcTTP4zO6uK+GwbWhhvN99eh/wlmbP
 ObYMP9bC6f3TIzgPzLpGv9L8URGb68jz7f3xp6K0VmCmtFn7/1CFa1pgEuj95J92Kom3O+e3vzB
 DJD6M
X-Gm-Gg: ASbGnctw+OJRh1qCxUA4UJdKPP+WMTb8GwJRsDGLafpreOE7hUFZSdbeZ7wbdkb7awe
 zVavK+pk7FlbapJC5PQFiZEO6U236Ax17c9yoNvZ7aJbfNM315T9QRAQG+We4r7qV7YLuVq+AkJ
 kMMWBQPk67UXS18cAPKGZRYP/HPbHsMPDX8dm0/zEMljuu+rnimTs8LszRDKqKdh0tujR9v7MyW
 +viJvp76Vb3+G9mGx6vS75dcfO4d/SZ9EmcFrvajGjEj+G5ZlLWeJuBX/UFF5PGL+zDHmjCVVMM
 Yl8C+BwvzCKBRfzEyRjMCWzkxAjb4AI5MzWGz+UWKYhGqRN7qslDzj8UwNJ3P9T1rs+1Ub8vNmU
 YUurFcCrx9EghiZ9lTQOQ796BPTRlpK8g2FuR9MCuE5uTnqTT65xNQj0gcecoImgGl42irs/ikH
 xJMnG1bwvog+2ga0K8RJ88eUNkTxsFwgK49XjVEs5GWJNU2pMrq3sp
X-Google-Smtp-Source: AGHT+IGo49NFBd7tnJnOBSdWITkWqdiuLbaEB5H7lx2lcsBSbW71klmRbK9V37gfGhzz9CA6WHXyTg==
X-Received: by 2002:a5d:5c84:0:b0:42b:2c53:3aa8 with SMTP id
 ffacd0b85a97d-42cc1d0cfd9mr21042388f8f.37.1764167074840; 
 Wed, 26 Nov 2025 06:24:34 -0800 (PST)
Received: from [192.168.1.36] (p549d4195.dip0.t-ipconnect.de. [84.157.65.149])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e574sm40484494f8f.3.2025.11.26.06.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 06:24:34 -0800 (PST)
Message-ID: <15b7482e-166b-43df-8a76-cdf150575872@linaro.org>
Date: Wed, 26 Nov 2025 15:24:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arch: arm: mach-snapdragon: Make USB speed fixup
 configurable
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, marex@denx.de, malysagreg@gmail.com,
 arturs.artamonovs@analog.com, utsav.agarwal@analog.com,
 vasileios.bimpikas@analog.com, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-5-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251124155503.2839766-5-balaji.selvanathan@oss.qualcomm.com>
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

On 24/11/2025 16:55, Balaji Selvanathan wrote:
> Add CONFIG_QCOM_USB_FIXUP option to allow platforms to disable
> the USB speed limitation fixup when they have proper super-speed
> USB support in U-Boot.

In general, we prefer to handle cases like this at runtime rather than
compile time. Could you rework this to check for the "qcom,sc7280-dwc3"
compatible and just skip the check in that case? I would also propose
adding a log_warning() in the fixup case so that folks working on other
platforms know to add their compatible too.

Obviously that's still not an ideal solution, maybe it would be possible
to implement the Super Smart (tm) fix and actually check if a driver
/will/ bind to the ss-phy node before the fixup, it depends how slow
that would be.

Kind regards,

> 
> Currently, U-Boot limits USB to high-speed mode on all Qualcomm
> platforms by fixing up the device tree at runtime. This was
> necessary because most platforms lacked super-speed PHY drivers.
> 
> However, newer platforms now have proper QMP PHY drivers that support
> super-speed USB. For these platforms, the fixup is counterproductive
> as it prevents the hardware from operating at its full capability.
> 
> This change:
> - Adds CONFIG_QCOM_USB_FIXUP (default y) to maintain backward
>   compatibility with existing platforms
> - Wraps the fixup code with #ifdef to allow selective disabling
> - Allows platforms with super-speed support to disable the fixup
>   via their defconfig
> 
> Platforms without super-speed PHY drivers will continue to work
> as before with the fixup enabled by default.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig    | 10 ++++++++++
>  arch/arm/mach-snapdragon/of_fixup.c |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 976c0e35fce..6c53aeef597 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -29,6 +29,16 @@ config SYS_MALLOC_LEN
>  config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>  	default 0x80000000
>  
> +config QCOM_USB_FIXUP
> +	bool "Enable USB speed fixup for Qualcomm platforms"
> +	default y
> +	help
> +	  Enable runtime fixup of USB device tree nodes to limit USB to
> +	  high-speed mode. This is needed on some Qualcomm platforms where
> +	  U-Boot doesn't support super-speed USB.
> +	  Disable this for platforms that have proper super-speed USB support
> +	  in U-Boot.
> +
>  config SYS_BOARD
>  	string "Snapdragon SoCs based board"
>  	help
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index eec2c0c757e..6a64168f67e 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -27,6 +27,7 @@
>  #include <stdlib.h>
>  #include <time.h>
>  
> +#ifdef CONFIG_QCOM_USB_FIXUP
>  /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
>   * USB controllers. Rather than requiring source level DT changes, we fix up
>   * DT here. This improves compatibility with upstream DT and simplifies the
> @@ -115,6 +116,7 @@ static void fixup_usb_nodes(struct device_node *root)
>  			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
>  	}
>  }
> +#endif
>  
>  /* Remove all references to the rpmhpd device */
>  static void fixup_power_domains(struct device_node *root)
> @@ -157,7 +159,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>  {
>  	struct device_node *root = event->data.of_live_built.root;
>  
> +#ifdef CONFIG_QCOM_USB_FIXUP
>  	time_call(fixup_usb_nodes, root);
> +#endif
>  	time_call(fixup_power_domains, root);
>  
>  	return 0;

-- 
// Casey (she/her)

