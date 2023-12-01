Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48117C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 12:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A67A87209;
	Fri,  1 Dec 2023 13:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UE1YDyqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A28887638; Fri,  1 Dec 2023 13:47:51 +0100 (CET)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A5ED871CC
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 13:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4b29d7e3a37so687828e0c.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 04:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701434867; x=1702039667; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3VpCDBOKvqyH19GDhzFoK5MvCVUJ9eSb4hth5u8Uiyo=;
 b=UE1YDyqF/IH1o9cwZyV9kQogSFL6cbFTjAUQSLtGOxAxJ1Nrima4cSVqO/bbf/MasF
 xSV56jwKjiQUeVzEED1cUktKfUmC52k+mOqV9n6sv6QPyHyDq5chY0WKwiez6sG+yxye
 m1Ge5iwgiZ1Wqykikqwtz4jtSbkYyOlkBVUxhgpK+FtNEDATdOEXhoAvTBUP1LmsE0mp
 Ly5r67pfO3ZQ0GW7ujfDJ3Bo2t8wNr5z+sHJm9hxyZhwa5T6IR9BZq/rG0C6UYg0ohN9
 1zgfGkncj/nUKln0v4LBxkHqF3jsIurzeczrBQ654jbgm9+/6xQf6HIP8q6p+Y4duffi
 KsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701434867; x=1702039667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3VpCDBOKvqyH19GDhzFoK5MvCVUJ9eSb4hth5u8Uiyo=;
 b=QBpLc+pZSJ4ZbYRYoD1N4li+gQ8pTtLv3UAKFHoaUSM4fAXzFA26OYqBY9miqaIjIH
 YJb06fKAhrtb/A8ewlHU++Ot7GdnMn0N6UW9FnhZWsJWTt/E76nkSd6L/CyIdo4xDOww
 tvSQyak9Pcs4y8oqHplDJ1pkh4EOznE609iF7j6KPe/uPm8n1sAodJMq/0qrK+vh39ej
 acdRV2FgblfkQAAxoMVKCWWt8h++AJFEttvEKdbKGauXRNuug55/piCGsrbtflhcUyC3
 RN7nBjOhM9SE66nIW6ZzR4T4jyesurup63F1fTV78xZD0MvsUXZKKe5APw5aedxBMAA4
 2zqQ==
X-Gm-Message-State: AOJu0Yzr/3ypMk7WzkUFEcG6UQBmuK6QUMvM/8N17uh+pz3Wa2OfSHy1
 fw8RTjro6iP1YwT1V2l8PAHEmEs5MlLreE49BtSV/g==
X-Google-Smtp-Source: AGHT+IGyhIMnTyEbG91gNQKCnyJb2+J3kKKOPJs/Z15UDRMWd120EIhQxncFjGXrbqoKNKFuKT+pq73v/DjrR/VtrUU=
X-Received: by 2002:a1f:4ac2:0:b0:495:febd:9187 with SMTP id
 x185-20020a1f4ac2000000b00495febd9187mr20832821vka.0.1701434867619; Fri, 01
 Dec 2023 04:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
 <20231130-b4-qcom-dt-compat-v5-6-41500e237ad0@linaro.org>
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-6-41500e237ad0@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 1 Dec 2023 18:17:30 +0530
Message-ID: <CAFA6WYOW2MqMZ55cot7e3gCALtRs1pSoiBz2EbPLLBKs6B34iQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] dts: qcom: adjust pmic gpio to use upstream
 bindings
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Stephan Gerhold <stephan@gerhold.net>,
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

On Fri, 1 Dec 2023 at 01:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Use the upstream gpio-ranges property instead of gpio-count, and drop
> the bank-name property for Qualcomm boards.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/dragonboard410c.dts | 3 +--
>  arch/arm/dts/dragonboard820c.dts | 3 +--
>  arch/arm/dts/qcs404-evb.dts      | 2 +-
>  arch/arm/dts/sdm845.dtsi         | 3 +--
>  4 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
> index c41fee977813..6a4e3ccf17b1 100644
> --- a/arch/arm/dts/dragonboard410c.dts
> +++ b/arch/arm/dts/dragonboard410c.dts
> @@ -170,9 +170,8 @@
>                                         compatible = "qcom,pm8916-gpio";
>                                         reg = <0xc000 0x400>;
>                                         gpio-controller;
> -                                       gpio-count = <4>;
> +                                       gpio-ranges = <&pm8916_gpios 0 0 4>;
>                                         #gpio-cells = <2>;
> -                                       gpio-bank-name="pmic";
>                                 };
>                         };
>
> diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
> index 0d9c9f7a4922..146a0af8aafe 100644
> --- a/arch/arm/dts/dragonboard820c.dts
> +++ b/arch/arm/dts/dragonboard820c.dts
> @@ -132,9 +132,8 @@
>                                         compatible = "qcom,pm8994-gpio";
>                                         reg = <0xc000 0x400>;
>                                         gpio-controller;
> -                                       gpio-count = <24>;
> +                                       gpio-ranges = <&pm8994_gpios 0 0 22>;
>                                         #gpio-cells = <2>;
> -                                       gpio-bank-name="pm8994.";
>                                 };
>                         };
>
> diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
> index 84224a8a3d39..3bb580ba4e17 100644
> --- a/arch/arm/dts/qcs404-evb.dts
> +++ b/arch/arm/dts/qcs404-evb.dts
> @@ -378,7 +378,7 @@
>                                         compatible = "qcom,pms405-gpio";
>                                         reg = <0xc000 0x400>;
>                                         gpio-controller;
> -                                       gpio-count = <12>;
> +                                       gpio-ranges = <&pms405_gpios 0 0 12>;
>                                         #gpio-cells = <2>;
>                                         gpio-bank-name="pmic";

Looks like you forgot to drop this one.

-Sumit

>                                 };
> diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
> index cd5d890e9a45..a26e9f411ee0 100644
> --- a/arch/arm/dts/sdm845.dtsi
> +++ b/arch/arm/dts/sdm845.dtsi
> @@ -103,9 +103,8 @@
>                                         compatible = "qcom,pm8998-gpio";
>                                         reg = <0xc000 0x1a00>;
>                                         gpio-controller;
> -                                       gpio-count = <21>;
> +                                       gpio-ranges = <&pm8998_gpios 0 0 26>;
>                                         #gpio-cells = <2>;
> -                                       gpio-bank-name = "pm8998.";
>                                 };
>                         };
>
>
> --
> 2.42.1
>
