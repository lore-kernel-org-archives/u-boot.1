Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90696C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE0688DEB;
	Wed, 21 Aug 2024 16:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QZl2gNqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 126B388E04; Wed, 21 Aug 2024 16:00:11 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B2288C36
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d5c8c1006eso4186483eaf.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724248807; x=1724853607; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8+zv9WaMzGGup6fPBxJSMXLwOepdsR76PqH60wNAu40=;
 b=QZl2gNqUDCPzZMiF/3MC6Yay1AllTIW3JWXCW3Z/s+k2qFFVchGoTAOLkoRAhTDM0g
 U8LJBlN3KooxWTCFKHAek1OG7JDVgN0YAsEnk1NyQofKolTeck53jmBXROuoxHvBSaqe
 piSsrMzoIH7XNhN0SMjuasqlaDbMimdBtUqkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724248807; x=1724853607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8+zv9WaMzGGup6fPBxJSMXLwOepdsR76PqH60wNAu40=;
 b=Myp8+WYlQrHMt62Eb3moaoEU8tVpVX4oVU8Xw7BXpp4BDNe7UoyIsfoIsQSPf6AeRv
 Wx4SxaY5jfL/8AeorvcEpzhC7Yp5gyC6cN4xu1/aDBEW9ZraZ7UJqtCeJVyMLGirfwY6
 XVMS66heEaMSCUckKyKyRbJgZPDBRaJO7QXVBgxNgxsfx8BEmO1hCRCdUdaN/PlHMUA7
 cdppf1Zzmt9tFNi1usahj21bMV4wthJIrvdLsJFOFj+JbCuiYjybahsD97Nl5RNBYkqS
 TrTAT71208Iy7E6VKfUEl9Gv7ei0mgfkGS8q4VBtaKTSjTbC5iloVRcP6gRXtcXJzusJ
 I6bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKiu1bQxu8nBvcIqEo1KG3of+2Cns4e+io060p9hVn5YwRS1SGMPa2FRvOmfWmd/tTfJHiEmg=@lists.denx.de
X-Gm-Message-State: AOJu0YxyA9hVMuzYQUVpigH8mDJYbG4c1OQqdKpOKKgFiynZ5v3XH98o
 hwyAzUlU4ADhDSfXxkmBDKXHNBFFWhjWL2gVxu1XZ2HFP6gxpR8BkXyWYOR3N0sJRHvtexW3Xs3
 xDn82HD9qgWUPbWi8EFYPtqtwE8VNGQemdl/k
X-Google-Smtp-Source: AGHT+IE7f3Ak/kjfHXb+01XML/huA7DAXMrJpZ8Hv6cZpMdcWDfqGNYTnA39SUhz0rnFsokZ2jscSktFdOOrDhb05fc=
X-Received: by 2002:a05:6358:93a5:b0:1ab:e07d:c93c with SMTP id
 e5c5f4694b2df-1b5a264caebmr276632755d.4.1724248807671; Wed, 21 Aug 2024
 07:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-5-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-5-49b07633f3a8@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 07:59:55 -0600
Message-ID: <CAFLszTjyYOfiFXD1sSsftDR4DZcqAK4epuD_JZcn=WyLe9U+6w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] qcom_defconfig: enable SC7280 clocks
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Wed, 21 Aug 2024 at 07:42, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Enable clocks on SC7280
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 24b71ba7be29..1a079264a554 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -44,8 +44,9 @@ CONFIG_CLK=y
>  CONFIG_CLK_QCOM_APQ8016=y
>  CONFIG_CLK_QCOM_APQ8096=y
>  CONFIG_CLK_QCOM_QCM2290=y
>  CONFIG_CLK_QCOM_QCS404=y
> +CONFIG_CLK_QCOM_SC7280=y
>  CONFIG_CLK_QCOM_SDM845=y
>  CONFIG_CLK_QCOM_SM6115=y
>  CONFIG_CLK_QCOM_SM8250=y
>  CONFIG_CLK_QCOM_SM8550=y
>
> --
> 2.46.0
>
