Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24626C4828E
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 08:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80CE086F80;
	Fri,  2 Feb 2024 09:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vth0qfdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 139C6879FE; Fri,  2 Feb 2024 09:51:40 +0100 (CET)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC22A86F7E
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 09:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-46b11fced44so684172137.2
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 00:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706863896; x=1707468696; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=16pnuYfBG2qtc8XySWxs6r91MNecYPxP9lCH4UD4Ok4=;
 b=Vth0qfdfOd8VhbN1XG7qYwwWPrH2Ghunyu7CiKNloNr4oFt3zy0AZbj1cJ3RiqTRur
 PWFvcYDwxR2t80/wP7L2qox6lgRlEbGbVP77h6YYh5hOKYyrg1BWBVa1pkp3LSOUf6Hr
 iXPPrAU3wQ5xrW5Liuu0nfLWOS2WVZyWT0RIS8MAyH54BfCNlfEcxJmo61XGUYBtIgPh
 Aw1LyurRnmfp9Pb+lQxcDKtLM8nTsIYmN139vWPFxrc2RIqYSqe2UB00APtp+dZo2fUu
 RsK/kaI82HzX9zwKN5cNxHqs8f23FZfIFuwvj1M4e7OHVtQO+1QH4RNByAxDENMVH5qE
 focQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706863896; x=1707468696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=16pnuYfBG2qtc8XySWxs6r91MNecYPxP9lCH4UD4Ok4=;
 b=j3m99JmUWo1tQHQyhIwFxdEhe3zyI66Ean5t13sCs4jh5nV9vYwm2valKwUPlBEXVY
 kVcUpxrD7of+RvCjPG4eQb1qluSSpa9eg+VPOGvSc/dqsV6eIutOsibOc7M/d6ralqp8
 qFUHfaWjN/NgjhcIgYLzXyOrfEFufKKQkTFRDDGTI4H+06CgKYDSoYGgb+F/Q9r0yK4W
 +DHHhyNUavouPbUOfF9hmFydwXhfDcAFB4Ot6F2uVZ143iQMOkAZDOtZ66WOIKsl8jtP
 Knt/phhXa/KVLrAn59BDkh6j6x0T9NuqgMh3n8EP6Zy8pLx0qwdfrU44K+b2Ljlu5pAW
 LaeA==
X-Gm-Message-State: AOJu0Yza6PYxF1RU8v7VnIQcvL5h0XJclUlTEKRsCSkryoLNhTmSBKc8
 7fqiwSqQpg8l3TPE8xCPUl5fXDKF+D0XCM9SKhyhUKaKCVU1MgDH+69Y0/4UM/W69j/5fS7geq+
 6twn4pbPZcCQogbncDCXANdUYCIX39cDTH7y6rg5rFIM5YxmBVNY=
X-Google-Smtp-Source: AGHT+IFAHjma21A8JxuZd4M10iiR7GwE3HIAFvfox5cE2YMz25pA9E15rUvzXgiCk3WS/JTrguOEbKwy6ZaFmcWFPik=
X-Received: by 2002:a67:e292:0:b0:46d:706:dc04 with SMTP id
 g18-20020a67e292000000b0046d0706dc04mr306356vsf.13.1706863896620; Fri, 02 Feb
 2024 00:51:36 -0800 (PST)
MIME-Version: 1.0
References: <12e63b80-3c65-494c-94b4-bfd949232ef7@moroto.mountain>
In-Reply-To: <12e63b80-3c65-494c-94b4-bfd949232ef7@moroto.mountain>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Feb 2024 14:21:25 +0530
Message-ID: <CAFA6WYM9zQSG9nu32iHy1o5NGbYqRbm47cSf9Dgw-=Jn-07pwA@mail.gmail.com>
Subject: Re: [PATCH] button: qcom-pmic: fix some error checking
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
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

On Wed, 31 Jan 2024 at 12:39, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The pmic_reg_read() function can return errors.  Add a check for that.
>
> Fixes: 4e8aa0065d4b ("button: qcom-pmic: introduce Qualcomm PMIC button driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This patch is mostly to make static checkers happy but it's obvious and
> harmless.
>
>  drivers/button/button-qcom-pmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> index 34a976d1e6c6..e778e51a4f36 100644
> --- a/drivers/button/button-qcom-pmic.c
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -86,7 +86,7 @@ static int qcom_pwrkey_probe(struct udevice *dev)
>         }
>
>         ret = pmic_reg_read(priv->pmic, priv->base + REG_SUBTYPE);
> -       if ((ret & 0x7) == 0) {
> +       if (ret < 0 || (ret & 0x7) == 0) {
>                 printf("%s: unexpected PMCI function subtype %d\n", dev->name, ret);
>                 return -ENXIO;
>         }
> --
> 2.43.0
>
