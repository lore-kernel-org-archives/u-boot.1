Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C19C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8528829F5;
	Tue, 29 Jul 2025 13:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WWxLZkI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E2FF82ADA; Tue, 29 Jul 2025 13:52:22 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE7D82103
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45617887276so31383015e9.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753789940; x=1754394740; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/mDIPytXdYbBta79c/lzj2IcyIm2Ld8iH0BeZDwkR6A=;
 b=WWxLZkI8NuxzcOis+nFuu0MU6RD67aml0FV6txPoySI9MnueTwZwQpDzCCQItvfImS
 6ouSAmamPnqtIHdeIp2OP2zJYuGATPq20JeGFnqw2khdB+357PlU7uL0ci4wxnHJXG/y
 unfYDGItJ45hPtHK4rN99/MwCbp4+JtBSvwYuz5G8bUv0XjQbejXUQsqBf/5E6qq/ZV5
 u7aWEFiJG5NU6lY3Xc7WNCkRyoYvcUzBn3neGkapiCEVyLiqsGh3obih6bzyUca9Yfnm
 WBzT4n8XTE5dom1hycnZKEJ90Xx7iy8mUS8T+662T5lpTGLOl4k9PuT3olIs/yPvrtuw
 Xuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753789940; x=1754394740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/mDIPytXdYbBta79c/lzj2IcyIm2Ld8iH0BeZDwkR6A=;
 b=tCNJWraGEhxbKM4flWJMXrzulDQAf+2bdrX3ozdYXcBxSM+7HI1VEKeyUb60Jqt6Zs
 6Bth0y1LcqyqCbs6YoJIAniPIDNUlB671YPVp7JZq4k8o758rsWq5d1GNDvmp9uIiq3Y
 nAM66YDqaFopMoN4f6CWEZPvP631tEnd+DJtHgNR+0MvegkP3EtQIL7xGWKiOlY97GY1
 +HbFyQMzLmk7YIdppHsWs1sCjbv6ZPd0T7gOExZCjR3MyTZFaU4oJzE0mWQBoNXdvHOc
 x3UxawrpXBUrPVoP8ubgx8z39OWnR448JRLIItMQQh5NcEykNRZZEvHGTTxHW4Tzn7PU
 CqYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAuo3wlWZr/JOwht7aG84rydxuIGczf7D8gpzCb8i5Zz9dUZUJc7Fc7JRMHlMB4Fp3cif2+Uo=@lists.denx.de
X-Gm-Message-State: AOJu0YwpA9vh84n1/oIi53iNIFdCzLXZcqJI/a8eFm3tKHaoxc/aXVKT
 XK44XTmORPggwLWiitA1ppWSzBDQO9wko0A/Xla9ANSbgeOPKn6IG22iCiYSerYfc3s=
X-Gm-Gg: ASbGnctWQhVBfLhA5k8wPN7HeoJkFADGMfMbOKych9TkNLTfmlxgY190djhGt2Ciy9D
 BS88uH28BS+AxahV12zlZWHdO4zxNSK58xyo7LWqs2xttY0ejYPxvXOoNkm63ihpXjdoZGESkyN
 AWoAwlCmDlvPnNoAvzNYShkbM5YQBsNo/zT3hbn/QX7+UirtIhstNNVg6TmiDRMXFeMPQKj0PEw
 qUwO9HvwKRCAR/u2R36IxusS7hJWegrAyxlITz3ciWqtn/tcx+XVpZhcfYjXYRxuQXC9O+6VMHV
 a+OB86ZguGv3159HIXEcH3AWEOSh3tuSuALw21p9Y8QliDWSIczzfloGh53nJ1UviSfo6HcwMLh
 Hwaxyh1QVcY0FSi02oAAzD8j8ZXYUXF5REtbCruf4LAb1ltGvFA5j+kPX6FnUDb2r1UmYCDKeJQ
 EMV8AAX9s94BMbTm7H5SA=
X-Google-Smtp-Source: AGHT+IE4MQR3Hs6/zukNsdrHiZBKL83Sc4WuodkELUpbo2hOYhu87OdTBtsLyh0+fm83roMYZFB2PQ==
X-Received: by 2002:a05:600c:6309:b0:456:161c:3d77 with SMTP id
 5b1f17b1804b1-4588072e3femr96210865e9.16.1753789939685; 
 Tue, 29 Jul 2025 04:52:19 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f0c1b8sm11998331f8f.56.2025.07.29.04.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 04:52:19 -0700 (PDT)
Message-ID: <ea359f49-2961-430f-8abf-a6e3e4650791@linaro.org>
Date: Tue, 29 Jul 2025 13:52:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: Add pixel3_defconfig for Pixel 3 / 3 XL
To: David Heidelberg <david@ixit.cz>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20250729103950.1154040-2-david@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250729103950.1154040-2-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi David,

Thanks for the patch! Great to see more devices up and running :D

On 7/29/25 12:39, David Heidelberg wrote:
> Introduce a defconfig for the Pixel 3 and Pixel 3 XL.
> 
> On these devices, U-Boot must be chainloaded via Fastboot. However, due to
> a Fastboot bug, U-Boot won’t start unless a specific condition is met.
> 
> To work around this, U-Boot must provide a TEXT_OFFSET of 0x00080000,
> which allows Fastboot to successfully launch U-Boot.

tbh I think we could just make this the default TEXT_BASE, since we 
don't set one in qcom_defconfig. I don't think(?) that would mess up 
anything else since U-Boot is relocatable anyways.

Neil: any thoughts there?

> 
> Clearing the framebuffer improves the Pixel 3 experience,
> as it prevents collisions with the Fastboot logo left on the display.

Does framebuffer actually work on the 3 (non-XL)? This reminds me that 
we should turn off dcache flush for simplefb heh

> 
> Instead of:
> $ make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig qcom-phone.config
> do
> $ make CROSS_COMPILE=aarch64-linux-gnu- O=.output pixel3_defconfig qcom-phone.config
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   configs/pixel3_defconfig | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>   create mode 100644 configs/pixel3_defconfig

I think this makes more sense as a config fragment than a standalone 
defconfig, since it's just changing a few core options that don't have 
any other effects

$ make qcom_defconfig google-blueline.config qcom-phone.config

What do you think? Otherwise it should be renamed to 
qcom_google_blueline_defconfig or something like that.

> 
> diff --git a/configs/pixel3_defconfig b/configs/pixel3_defconfig
> new file mode 100644
> index 00000000000..9c0c8ca63c4
> --- /dev/null
> +++ b/configs/pixel3_defconfig
> @@ -0,0 +1,13 @@
> +# Pixel 3 has special requirement to have TEXT_BASE set for the fastboot.
> +
> +#include "qcom_defconfig"
> +
> +# Otherwise buildman thinks this isn't an ARM platform
> +CONFIG_ARM=y
> +
> +# some Pixel 3 bootloaders aren't able to start without TEXT_BASE
> +CONFIG_TEXT_BASE=0x80080000
> +CONFIG_HAVE_SYS_UBOOT_START=y

Can you explain the purpose of HAVE_SYS_UBOOT_START here? It just allows 
for SYS_UBOOT_START which afaict isn't used?

> +
> +# fastboot logo distorts u-boot output
> +# CONFIG_NO_FB_CLEAR is not set

I'd like to add this to qcom_defconfig, I was holding off until I could 
add an option to prevent simplefb from doing dcache flash on qcom which 
makes display refreshes actually fast... Would you be interested in 
adding a config option for that?

Kind regards,// Casey (she/her)
