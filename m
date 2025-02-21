Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2649AC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 13:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A610180FA6;
	Fri, 21 Feb 2025 14:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AXr7Q/zO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D1880FBA; Fri, 21 Feb 2025 14:58:06 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E47C806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 14:58:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so340183066b.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 05:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740146281; x=1740751081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EuesJE7mgGLP0XRzFs050R4j+nSvkeq6ywS3m0vkBtc=;
 b=AXr7Q/zOXgPPeLrHEwFeF4eDwyhDeXRoQ1/aPJjTcjoZUf/nomh6YBINqfncSRJxP5
 nu+9Zx7K31Y0WT2kZhXfygeBgfjNqf3MQkAgIgpncK92ApTRduGzOVUl0ftO/p45Uo5g
 AW4jc19IC6ayrX3b5qym+x9LDNAufEV2U/5kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740146281; x=1740751081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EuesJE7mgGLP0XRzFs050R4j+nSvkeq6ywS3m0vkBtc=;
 b=qzjNLf4qgH2cP2iOarbDXMDRpkITzvqjVjVrvTwVGTSQQaNVZycnlFVTy2g3zaEInj
 D84Mq8vf71LjxNUiHrAZn2ZfQ7Y6Bg4TGB4pJ0ou8O+QlyK0RNClKLx0M4fOUmJvpMsg
 48Up/1mmswidujVK/tcONwdnSr9gTyEAqVzNkDBk/n/SsjKs9Guhiz+wFuo4rnsDaPXr
 f01mCAZ3ypzv3mtXQx1R+eTABE0KScsa4U/m2crODkWdKRNIXdZ5AyF3iSvFK/cQbfHw
 qbNiSYH/4peKpGah0emYwER9svoM3BxtlqXVKAnf31Gx7Wcr/oPfiiojOaQC6Vvb14I3
 rS3A==
X-Gm-Message-State: AOJu0YyJr7RCLryp2rAUNPR9sWERdF3NsKSG032a9g9rq39AjGOPtCr5
 bis3N1XKwzmvIyCtOwKSpEVPLvhTbs/ZHrI92UWwiV9ikocqFhoZMyoGOet18H7D7peQbNpcb+x
 L9PG2V/3NYP49uiGgJNPZI6GR5xyldoL9h0k2
X-Gm-Gg: ASbGncve+WbSvEtFBtk949rminNQ67ysszhfpZBNh2wEWJBspSV2NUr8Cr3GJ3QpYK/
 Yx6bTJ/4Ql7xPF8BF2xJWJuJWE2nNc6iVOgENfnFzRInfnKwVbF83SpWiIM6wuoKczGk3VQgEo0
 o/azLKGSbQ
X-Google-Smtp-Source: AGHT+IE+uPlxm89hxdrwBCcMTNcfAVEKvns1C9CynI4ZV1i6V+O16BteJQb6PxoCxM+LNR4xfA2ThelMTtaSWk0NCWE=
X-Received: by 2002:a17:907:7285:b0:ab6:f06b:4a26 with SMTP id
 a640c23a62f3a-abc0da33bf1mr341706866b.34.1740146280819; Fri, 21 Feb 2025
 05:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-12-swboyd@chromium.org>
In-Reply-To: <20250220205900.3127680-12-swboyd@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Feb 2025 06:57:49 -0700
X-Gm-Features: AWEUYZneXYFEtWTD_XDknoIAq3xJUcbW5IykQdWC5ClOrZsueZmJh8YeVKx85hM
Message-ID: <CAFLszTgxNUnyfTtvhQFJC9xs5EZYCW1kAdk3gHz-YH3FGKJHRQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] bootstd: cros: Return negative error code
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot-qcom@groups.io
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

Hi Stephen!

On Thu, 20 Feb 2025 at 13:59, Stephen Boyd <swboyd@chromium.org> wrote:
>
> This should be negative EFAULT to indicate an error code.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  boot/bootmeth_cros.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
> index c7b862e512a0..d4c4ed328bd0 100644
> --- a/boot/bootmeth_cros.c
> +++ b/boot/bootmeth_cros.c
> @@ -340,7 +340,7 @@ static int cros_read_kernel(struct bootflow *bflow)
>
>         /* Check that the header is not smaller than permitted */
>         if (priv->body_offset < PROBE_SIZE)
> -               return log_msg_ret("san", EFAULT);
> +               return log_msg_ret("san", -EFAULT);
>
>         /* Read kernel body */
>         num_blks = priv->body_size >> desc->log2blksz;
> --
> Sent by a computer, using git, on the internet
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
