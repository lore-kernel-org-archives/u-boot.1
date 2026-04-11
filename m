Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD780F3ED4D
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 413EF841E6;
	Sat, 11 Apr 2026 15:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eov8fIQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B8288416F; Sat, 11 Apr 2026 15:16:04 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5ED984118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-66e129e457dso2961980a12.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775913361; cv=none;
 d=google.com; s=arc-20240605;
 b=E6UdqlTwTdF1dT8PDbA3NQyPo5Fx19jQ27UD8sSyjNDr1GsxqDdnOo3Dm5Zk+zH3Ts
 md5E0Iw/gYt/Bpi5jXK//s4f8KrZIfhO6gNeAMym6A44Ai1c+YhobrRJSCYgtMcpRfNN
 USkGeVAPM4PO2q5cIKokRGDxhExmaQeQ1SXuIMhmb9u7euVyJjuSVWdtThMgC700lzPW
 7ESbVIbd7w77rZNm3VJ7t3b1P9qD8lyA4MXr65rXuE/rvIK1GCmnpIwZJehQ7Xln/4u3
 1LNODxozxq/+bWsDDybiDpwfB78npTsGKfTqh8VyRUzM6zZs8fwr9rd+MIgCz6EDuTZN
 J1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=msScTXxiIpHxgM77PHECV+9p7Wvdsj/JUo2/i0lsyoU=;
 fh=NpULHgXzxRUaUGWaxtHjbS3A2FSifvlQUVWx4+lAb70=;
 b=C+mT327oaIMs3zYMUOA911r19Uq/FKYYn0RME2SJHq71SNnRURDPHwMCiqQ6kdBcW9
 tQ0Sw4Bk4KwPqXk6lnrrcXrAR6RNF+CEDM30oY5n56pFnaMaSMCEgptArLcb9gN0Tbpy
 v4WBMXEUKIJYcgFUuMxMde353tHP4fO0A9bDkeHBZ0zgbLKdokCCvrkpZAZUygP4A7rS
 OI24u0oDuYwEqd0fE4eCE+C2aIT0lqJ9vhhDDLPDwxnlsmYT70f75lEM93X1tZLUCfIf
 +6HItJXvSRezxFjeDCL6Ivej71XulUrvTbjs6O/WFHWnJjXZQBvdbUPv6KDwRc5HAy3E
 bIlw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775913361; x=1776518161; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=msScTXxiIpHxgM77PHECV+9p7Wvdsj/JUo2/i0lsyoU=;
 b=eov8fIQTNl5Qi+aEZVBsBTQdvz4edhNvA6UfL0pgdM6GlLj1sWJrFISgWeHlLjLPAD
 tJRn1WWjMlPi9BSQrXmYa+qtWyUmA3veB/n4PG2YvLZwPUHH6vg6pA1By+aB3ZUNGMPp
 YFJ3MUsUeriHtNbfuIkdCoRILlsmVFATx8e8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775913361; x=1776518161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msScTXxiIpHxgM77PHECV+9p7Wvdsj/JUo2/i0lsyoU=;
 b=sm4ObeXnnjQgsgN/9XhXfVVT8nFUJeXQFL5kmfHPPgUUcqcLN1IPwAmfiu4rSfamAf
 twAg/dgTQ+xQ3asB0weINloeq95e4ESEUzMjBDoseaZ+7kSnZ9yQu2aX+45nP1w1Cvdw
 yLqYHcFolOYAtcSVik/CG0pJFhf0bTxjyTGUMXl8Zn7KylC29E/IVz6UWxQEzvwzgMLz
 lV5STzetWgp1HajNcNkeqoUtFtTW7Rl0SOVeVjIz19vnMkD4mMrpWYcCxPWjfaqBAYb5
 ZmpIX0fhh3qtWcorASfmyNiwOqOwgWLeo+QZEhJIfbSkCy/DuLDQQgSHuxUgMnaYNHxu
 ZnlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeQvb8k3JYoPIiNghaS77s6VNJtDisfVBdmGzwXeFTKPqQ6eiHDbMOOz0tMuPGQm5rf+0+lJ8=@lists.denx.de
X-Gm-Message-State: AOJu0YxfkN2FopY6h+yhbn88yHPYQ/rdJWqof1K0kxk3wsCSBjmAAdqm
 oyWx3rKsvp3L7GOB1npLd0qoys7WBV3QVAkZuabipGyTfiCiLZIVYYs+4qkGv85Rggn6YE9FoyG
 U+zRG5d8sCsM7BnasoDY6XpDdHhgNa1GmULKAaH6q
X-Gm-Gg: AeBDies2TrmSAeudl0gek0JpnrGNFNFbrsZLflJxfxXx4kkPsODsq+JDPk1g2NmeXOv
 Y+xUuHh0vray5PySKBjTScHcATumt0rFIbegKuMYJei+zc2+kjdTeBtTN8P1M1lXgTzMfYqskRa
 OFLVJ8XfjFcBy14lv78AmnhhvIwOQUCwD9B7eWvBC1UvMds3Dez0hDSZVl89MbGpzDc3o4yCSy9
 xVX+Xz63LQFW3o8V6zBot/DdWmCvCrJbldQ4UDO3xeIen4eo8GsDc3nuoFR594fC0AcEWe6hl4H
 ZhJohA==
X-Received: by 2002:a17:907:6c0f:b0:b98:cb6:e896 with SMTP id
 a640c23a62f3a-b9d7298ffa1mr385019766b.38.1775913361068; Sat, 11 Apr 2026
 06:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-10-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260410091154.1001021-10-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:15:46 -0600
X-Gm-Features: AQROBzAU5aY-vMx5e2Xlm-QxNmciliGrF4emsIJuDJC-qrUUv0jUb7Xgu61-Tug
Message-ID: <CAFLszTgkdQxRmzfXOW3+RcNO0+aSeYFEq_iA3spWd8nnf2egaA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] configs: add qcom_ipq5210_mmc_defconfig
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com, 
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com, wens@kernel.org, 
 jamie.gibbons@microchip.com, david.wronek@mainlining.org, 
 alexeymin@postmarketos.org, james.hilliard1@gmail.com, 
 michael@amarulasolutions.com, richard.genoud@bootlin.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 11 Apr 2026 15:25:15 +0200
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

Hi Varadarajan,

On 2026-04-10T09:11:45, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> configs: add qcom_ipq5210_mmc_defconfig
>
> Introduce a defconfig for the Qualcomm IPQ5210 SoC based RDPs.
> Presently supports eMMC.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> configs/qcom_ipq5210_mmc_defconfig | 106 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)

> diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
> @@ -0,0 +1,106 @@
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y

The other IPQ defconfigs (ipq5424, ipq9574) have CONFIG_DEBUG_UART=y
along with CONFIG_DEBUG_UART_BASE and CONFIG_DEBUG_UART_CLOCK. Without
these, preloader_console_init() in your SPL likely won't produce early
debug output. Please can you add these.

> diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
> @@ -0,0 +1,106 @@
> +CONFIG_SPL_TEXT_BASE=0x08c24000
> +CONFIG_SPL_MAX_SIZE=0x3D000
> +...
> +CONFIG_SPL_STACK=0x08c60000

Just to check, the SPL code region ends at 0x08c61000 (SPL_TEXT_BASE +
SPL_MAX_SIZE) but the stack is at 0x08c60000 which is inside that
region. If the SPL binary approaches the maximum size the stack will
collide with code. Is this intentional?

Regards,
Simon
