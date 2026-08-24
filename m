Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA64C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 611004067F;
	Mon, 24 Aug 2026 13:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jHjwHdopXIJf; Mon, 24 Aug 2026 13:45:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787579131;
	bh=x73SnFcPBfuK+m/K+EsY32T/bX79IbdwICesITzH/LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HxaeGAm7t9J7ESzZEyJ59YM0HQPfLGbZKjKKm4jZVv/m5AYT8z1IWIbcnUhW+mQTd
	 01g8ggoB4LwK0Awm/CGYMyf5NLKruyC7Ek6SIp8ZYaRNYG5WJjK+iiURpX7u1c74Cl
	 Mr1lrbqRz8kt+WHyTNlApEn0yxV13HYoSuQHQ6eXZbNCU7wxmO/x+yYKgUHTfo1vJL
	 /hFCWqvqH81te4YzxdgCJRORvc40vX6KVIcblZuHXCysQ1iGkKMpsQIu+oF0i6n6fD
	 wNKYgqt4xXxkoocjmvqCBKqsPy2m72yRLHRpMvGatdRW7583dLPOf2fmmBls/WEPhw
	 0F24lsyOlk5Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF2C94064C;
	Mon, 24 Aug 2026 13:45:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 87DFF279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7981660624
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bs50JMTz80NU for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:45:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ne6Gx8Q9
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 377A460618
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:45:27 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so518551366b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787579126; x=1788183926;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x73SnFcPBfuK+m/K+EsY32T/bX79IbdwICesITzH/LM=;
 b=Ne6Gx8Q9omGyPo8VKSQtLI+RL+Miwop2OCeGXhwwc1aCh8xtn6axxs4l6L7B/oIOsP
 h/dqtgwvsAcR7wxCBy/0hZuJNlq1aVboCXI4pHMTWIa4IkT3Rv4PhtDIbVmA47sItHx8
 Q0ENK5Th0vsB6NO5tGHvgdZVkoalm0O2aBLesnV70jLKKFlFAPCNQ9kcHRtwk1bioztK
 oWJYDOKy4hI0UlWwCQ0I2RETnCizygTY0H5fEYxMl0esxn5T5eRu0uJAWGUxM8cAi2yJ
 m9ae22WG0ZhKVJfHrXFzZW/gYLdbitNzW4GBBWUgESK6fqHhtAk4Dkb9EXC2HTGOjfSe
 e2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787579126; x=1788183926;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x73SnFcPBfuK+m/K+EsY32T/bX79IbdwICesITzH/LM=;
 b=hOzCbxOPy68aHU41WnTJJlzd3eDfVKhq092QkPz8nMxoya4g+Z+hNBPgPzg1VDVnpD
 ta3TApZav/hIKecN4MEyD9WfuHOoqr58Y53pocz7Qdc+cKfO30bpV7MEz12VdFDdh3OE
 a6c6J/KQiPSyalREqMk+YFpL9s6P8J3mwFwz6CPysuFwd8xFXsbdo+Oxia+sBiZn7imb
 6dfrXQHs5HOiCAOwkjVKqyzOkAYzYuWPQUF58NeuASR87HYaBcAUdrvN4oacHCS5oD3X
 4MYeGv0biLvEs6lPMIkJyE6xCP3veKmve/H73mYdhTjggVlh1e73Y66PxtAk2OMpBWV5
 pNgQ==
X-Gm-Message-State: AFuF++lPC3WRlUSV/050Pba7GSy9SN/UWbUC37rPdNM2IfrhmqiAdeuV
 ikACm59QSLsJjyrPexW3Prm5QDUGk3Fn2us0VV0F4ms3xZIn3Kttc+fJYLQnGNLtYbM=
X-Gm-Gg: AR+sD12mklJYdDD1MzdrYPVUKSG8RCPPGPVRWUTyD/SpxomNpoHZjWmLB1QKDKLKfBq
 n4vV9PnvNSsGOb5AdLtKkvFgj/b3zMcmo0ssa2vE0QE4/Ojls9dGBDCXf+R2zIGK1iL2dSRbjIv
 jbe5QqlwN2hoPmbegLQ2jnyUJbr0Un7PmXai0kwQQDmZsmYGYzkQNOiAeFTkHokYxGRQf3U0z00
 Y1gKJfGGB8Ax68u2Gj8g/OBFuJAuFGKnH2aqxKZuTN+LYnXU7f2BlsZgmujLp+beEuuSNOIRnfj
 B2+bFdXYwl0mti7AvqQRlOCozETcxINzu2A64fjlRFJApOcgZWkn+bA09OOpcIBQ453yCCaKDdR
 n6+coZnAHISPU1iW1VnLoDmWYxvMb2nsM/QmB7knAuns38yIG/+PEY3pC5xmR+Y6LFEpqRmzqNi
 f53sddfPUTMHOjz7CIZ4bSgpmIPZP/Myie3ZF+djPu/t8Zr7yjBsWSDT8pntrpOd2GjSYnSClpf
 Mk93kuIng==
X-Received: by 2002:a17:906:9c8a:b0:c1c:4c72:e6df with SMTP id
 a640c23a62f3a-c244ceead55mr2996305166b.0.1787579125573; 
 Mon, 24 Aug 2026 06:45:25 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:8b5e:6b33:b439:3e9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249629a901sm1423753766b.25.2026.08.24.06.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:45:24 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:45:22 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v5 07/13] power: regulator: Add AB8500 AUX3 support
Message-ID: <aoxK8lN6OIkBgipH@linaro.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-7-07ca794e2b94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-ux500-external-sdcard-v5-7-07ca794e2b94@kernel.org>
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

On Sun, Aug 23, 2026 at 10:39:26PM +0200, Linus Walleij wrote:
> Add regulator support for LDO AUX3 on AB8500 and AB8505 PMICs.
> AUX3 supplies the removable SD card on the upstream Ux500 Samsung
> device trees.
> 
> Support the AB8505-specific 3.05 V selector override and clear it after
> programming an ordinary voltage. Treat both normal and low-power modes
> as enabled and select the supported voltage closest to a requested
> target. AB8500 cut 2.0 or later is assumed.
> 
> Imply the regulator core for ARCH_U8500 so the driver can instantiate
> from the upstream device trees.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  MAINTAINERS                      |   1 +
>  arch/arm/Kconfig                 |   2 +
>  drivers/power/pmic/ab8500.c      |   1 +
>  drivers/power/regulator/Kconfig  |   7 ++
>  drivers/power/regulator/Makefile |   1 +
>  drivers/power/regulator/ab8500.c | 168 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 180 insertions(+)
> 
> [...]
> diff --git a/drivers/power/regulator/ab8500.c b/drivers/power/regulator/ab8500.c
> new file mode 100644
> index 000000000000..4eab7fcd0f40
> --- /dev/null
> +++ b/drivers/power/regulator/ab8500.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* ST-Ericsson AB8500/AB8505 LDO AUX3 regulator */
> +
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <linux/errno.h>
> +#include <power/ab8500.h>
> +#include <power/pmic.h>
> +#include <power/regulator.h>
> +
> +#define AB8500_VAUX3_REGU	AB8500_REGU_CTRL2(0x0a)
> +#define AB8500_VAUX3_SEL	AB8500_REGU_CTRL2(0x21)
> +#define AB8500_VAUX3_EN_MASK	GENMASK(1, 0)
> +#define AB8500_VAUX3_REGU_EN	BIT(0)
> +#define AB8500_VAUX3_SEL_MASK	GENMASK(2, 0)
> +#define AB8505_VAUX3_SEL3	AB8500_REGU_CTRL2(0x01)
> +#define AB8505_VAUX3_SEL3_MASK	BIT(4)
> +#define AB8505_VAUX3_SEL3_UV	3050000

I'm a bit confused by this list now, please either have all register
addresses (AB8500_REGU_CTRL2(...)) at the top, followed by the bitmasks
or make it interleaved (probably better for readability), i.e.

+#define AB8500_VAUX3_REGU	AB8500_REGU_CTRL2(0x0a)
+#define AB8500_VAUX3_EN_MASK	GENMASK(1, 0) /* <-- would be also good
					to rename this for consistency */
+#define AB8500_VAUX3_REGU_EN	BIT(0)
+#define AB8500_VAUX3_SEL	AB8500_REGU_CTRL2(0x21)
+#define AB8500_VAUX3_SEL_MASK	GENMASK(2, 0)
+#define AB8505_VAUX3_SEL3	AB8500_REGU_CTRL2(0x01)
+#define AB8505_VAUX3_SEL3_MASK	BIT(4)
+#define AB8505_VAUX3_SEL3_UV	3050000

Am I blind or do we have no support for the AB8505 3.05V in the Linux
regulator driver?

Thanks,
Stephan
