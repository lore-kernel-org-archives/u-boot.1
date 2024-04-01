Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5568CCD1283
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 04:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D62FA882CC;
	Mon,  1 Apr 2024 06:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ktFpLcWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA8F882CD; Mon,  1 Apr 2024 06:49:49 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A958C88074
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 06:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7dfacd39b9eso2952864241.1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 21:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711946985; x=1712551785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ciziciljWeCkobme4p2yixrHnSpQeynS3QcMGIzk8Zc=;
 b=ktFpLcWRuQndCKCciv5GXHvPaPNxq7NmPoMRKLm2XLXgyj+oxDjdmQkWyf4ia9CoLg
 aaHyyc2Z9+tzyov57sUYpVjf1C+oAbLsQhbTNX7mLGuDD3DiKu2DWfuXIVN/fEcp9gbE
 RYQfciXIwVOUi8TpMDwxD8aYOVP2pN0JAGhonyMSfpJ+mjuEiBxpMa0rWwWrJwD/9HoD
 pOwoaHnDzIA3NMa6YlFC0eEhYhkygxHn1o2JlkVyXtoTVhUt5TktmCzSbkBwAM5uhT55
 xX1ZrjnrEg/R4uz7xxdOfgweflI5aue8N4HcN07DhUUdnF97jW1H9X0VlKSzoEJj5Jpk
 CzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711946985; x=1712551785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciziciljWeCkobme4p2yixrHnSpQeynS3QcMGIzk8Zc=;
 b=RtdVgCtqVrVLyCagYxwNA8GgDCeYJJYUjk80zF3imUto2vm6vlaOWHbEn3kgMrQl7P
 zXd3pwqDdXinlMGXTzPEFBZE90fmhCJxgBjZO01vj1/8mmKBIajN/u8mtB6c8UH5Byyh
 hpUAhXVONyH97UpY1wgtPGT6YG/9ZxUH4m4AL26dEB0YITG84+RRW/GounNsEqvXa/Gf
 lrdqzUMibWzmVHqFeoigLmYnzufTmo2nxOH1FpmVjQo9D6Ab1WVaTKxOq/9FD/4RcJj1
 7vJaaqyskJ7C6FpJRHvg7mDcpmo0ivmRZosauU4yFr09ItRLKUKobNs2MV+VdjXdSa6W
 WGyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZitIWV9+A9PMXtTyLm/DXu6IrRIvDqvOGMk0ShxIA8PiXDDJ6QiodpoUz1bznRz8JsEnXUiOvWFn7GJIfnccbQP519g==
X-Gm-Message-State: AOJu0YxP/8j0ZVw0lu7pBYhgvos3kmfHwu95tmJdCB833Kcpvast89AC
 IlCrOkYSg1+Wg5iRSxN61r4rZ5G2O5BLAjAvje/lT0NJeym0e4Rt3mLdBVMZy3l3hif4j50JJvh
 LR0NIVODsjs198hQyEoo+jCvtIxt/SB0upN0VCQ==
X-Google-Smtp-Source: AGHT+IHRDxIHGcJfcmJDT2r/MODWjGOO4etUJ796GPTKfeArdyCmFrji7s7bC3No28jzm1paXd0uABx7ZMtxt3kpudU=
X-Received: by 2002:a05:6102:24a7:b0:478:5464:615e with SMTP id
 s7-20020a05610224a700b004785464615emr4304503vse.3.1711946985535; Sun, 31 Mar
 2024 21:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-14-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-14-4e98228b3d03@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 10:19:34 +0530
Message-ID: <CAFA6WYMKdFWQC616aP7jEpJ+2uzmqnbWREjgb+BCSXXvUOn55g@mail.gmail.com>
Subject: Re: [PATCH v5 14/16] qcom_defconfig: enable livetree
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
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

On Thu, 28 Mar 2024 at 23:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Qualcomm FDTs are on the larger size, and with the addition of DT
> modifications during board_init() it makes sense to enable OF_LIVE
> globally. The cost of building the tree should be offset by the
> increased efficiency at which we can walk it.
>
> Some rough measurements with CONFIG_BOOTSTAGE suggests that this might
> add 0.1-0.2ms to the boot-to-console time. However the reset-to-reset
> timer difference is in the range of 0.5ms so this could just be noise.
>
> Suffice to say, no significant slow down.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index cbc612b44bd9..8c4402e8f780 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -25,8 +25,9 @@ CONFIG_CMD_UFS=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_CAT=y
>  CONFIG_CMD_BMP=y
>  CONFIG_CMD_LOG=y
> +CONFIG_OF_LIVE=y
>  CONFIG_BUTTON_QCOM_PMIC=y
>  CONFIG_CLK=y
>  CONFIG_CLK_QCOM_QCS404=y
>  CONFIG_CLK_QCOM_SDM845=y
>
> --
> 2.44.0
>
