Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEB7C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A4C387D2F;
	Tue, 20 Feb 2024 14:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KL/CSWfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9F387D2F; Tue, 20 Feb 2024 14:24:22 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6958A87DE0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-47051c7635dso324485137.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708435446; x=1709040246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=um7Zwtu9VSoRoPcZ+/JhqO0eqE71G2KBBoC7w5dgqRo=;
 b=KL/CSWfHiYFcTitZEPFOo8yLpYtOGNPy4Md/qjOp/N10SZ2qCXst8eFCAZ0aJzYN15
 8k8dnPrez3/PFM9o7HRxvATZgx6LHZDdlvt8zTyX+rNB1JSVz6+FSxOz2ifmHeu2kYFT
 nfA6IJ2i/wbOCcTcnX5Xc+L2qkjejmA+OXxNGiDT+bCwCYFKo7PL+tDKPdySlDD6bf/q
 L/nEv5nZ8paDehy0Z1CI3yIUpTeDO0i6H5rSAF8WuguJf1s+ZWTFYTGz7gHD2qOGSAk6
 nMnkCgGs88UXK5y8hgeClVnLx144JtbyNTXNxkbbBce5gctoXFRNKDGm5ErBveEr4ep3
 15UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708435446; x=1709040246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=um7Zwtu9VSoRoPcZ+/JhqO0eqE71G2KBBoC7w5dgqRo=;
 b=T6L6/4GTV16ZjGXm0EuOpjRBkQSaeikKQD5C3Dw+azUdW7iR4WP+ksFKGrYTM6vDxi
 0lx78cJY6cOo8olONdXo89TzaJkGT/l+lzlED9zaeu3C7zzsOhM69QjlqwCMGo9pQfKM
 mwZiOU3fCyj2wBHIUIYrJJeAtHIOdtg80UIeUcjuCNAGsP1cMhDOC+Rce0hdeQq0Y9BY
 idVsWjb4zPL3YOGU5ftHfU8hhlZu8quO3J3zOs8/Ig4O+3CTCVXg+LaxpO/mSIkqUkXN
 2eJOd0586YXnw4iEzChSDGb6TQX8TYFDqBLQoE2KOk8vfzAiGW+HW7BmIOZwD+4R4tzO
 mm8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvIpvZSjv05VRY1+GlMS7t3lBYTLM6IV2cPsxjro0Kax0T4+pYXeSvQ7oAtJ/mUT6bB4n40VueB4Ww0Qopoe/gA0pcYw==
X-Gm-Message-State: AOJu0YwdkZ5dB0eHtcASTFnBxTGZy2ZmBF9Q1fQOfDICycjrpd6WEaE/
 hR+ZJOyY7zdbjYrGG7+JGWU6TV9l7N9gsQhc5X4Fkfk516RKLyu7r/r95XFHyg1Sb0afOyG4iN9
 aS4aE8TnnqQUTMItVepVWGJB2nXEdT6ulMeHz8Q==
X-Google-Smtp-Source: AGHT+IEXX2frQq00mDwJmND9bGuPPS4zBM5qi0Do9psv+2ZtIi3e+zYFdjl1LEl37X0kwpGGIHbb7pi1Eu5YpJp2liw=
X-Received: by 2002:a05:6102:3a66:b0:470:4d13:94f2 with SMTP id
 bf6-20020a0561023a6600b004704d1394f2mr5661768vsb.15.1708435445121; Tue, 20
 Feb 2024 05:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-16-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-16-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 18:53:54 +0530
Message-ID: <CAFA6WYMf=1wRsgDXv73Z9QGo-AkLFw6TkPC3Qko06ukfw9vnhA@mail.gmail.com>
Subject: Re: [PATCH v4 16/39] board: dragonboard410c: add chainloaded config
 fragment
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add a config fragment for building U-Boot such that it can be
> chainloaded by aboot/LK rather than being flashed directly to the aboot
> partition.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  board/qualcomm/dragonboard410c/configs/chainloaded.config | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/board/qualcomm/dragonboard410c/configs/chainloaded.config b/board/qualcomm/dragonboard410c/configs/chainloaded.config
> new file mode 100644
> index 000000000000..3fd064924a1f
> --- /dev/null
> +++ b/board/qualcomm/dragonboard410c/configs/chainloaded.config
> @@ -0,0 +1,7 @@
> +# CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK is not set
> +CONFIG_TEXT_BASE=0x0
> +# CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR is not set
> +# CONFIG_REMAKE_ELF is not set
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_INIT_SP_RELATIVE=y
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=524288
>
> --
> 2.43.1
>
