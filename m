Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E716CC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 06:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DCA887F80;
	Tue, 20 Feb 2024 07:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QNt8U1jt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA8087DE6; Tue, 20 Feb 2024 07:32:26 +0100 (CET)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C6987F8C
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 07:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7d6275d7d4dso2729502241.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 22:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708410698; x=1709015498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VmlkSBREVXhGdPGkzfbPJIJUkOS/yHKhHqREKfjHI/4=;
 b=QNt8U1jt0/pOhNtS/bVi9IB1z/WNc/9XxwdCrt/lyxvaAr3eRjZIHjP/pUJTAyCzgE
 VSs5U8Hmrhe2VbIGJF3sMr8huh+nwicmu2EYQJyCEwdqAyKZg/3M9BBagCJ6447AQQms
 KTWdSTjSF59rEGuG0zIkUpUX38EWaKSjnTcchrt6/9RCu2qXqZPQkqQs7eptzpKHbRZV
 Dhe28TMSCPA94lxFily+FJqECZdtn893epbyd6YpJPDelEU1ZtneoHFQVBcwozP7yPXp
 Nj8BJB2XD/SBacGydZqz9kg/vtpEI9PrjNGBiwhbzM9xEnQTeYHaCLjcXDqj9k4gHXQT
 lvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708410698; x=1709015498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VmlkSBREVXhGdPGkzfbPJIJUkOS/yHKhHqREKfjHI/4=;
 b=mSudb/RP/muTcoVSaIfZYL4lzPVY7jCqCQeeRdlCSrUXbQuyR/aXB2BpPZidhRLhUh
 JHyowdsUzyoZR6k7yIeoBOecBumhiSTWo3Gdr7MhF6CiQMAhxmbIuQepMLxZE6cB0oWq
 SPd1V+oqEGqU/3JmfKp8d7apA3hw6sYFu7LSva38rIybjkZ1sFLTguEmrBfs/ImhjZWE
 ib/AHgJIBqLTcN//HFldULIFH8pGe7UkvOx0qDolRGffK1BQdgXfwdDcCMlm+pFaGiwa
 t2CHCnJNFkeXPxva7fgH9yDwwCB64DbrU0kPVblZvw0aUbQQxUaDjfL9n7T5/hlOfJbB
 O9Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt1pyDVj7YaySt4ORp+yDjVrOH9jkKJFghbCj85MnS7aGusBSBTci5JC1p2/vZ08ErD9x/QXKV4+oka7qE8IUWKIxe4A==
X-Gm-Message-State: AOJu0Yx3JuConLVLC6OJlndlmyJZ54dnKgz4izhJ2JfmowDB3M6e1oaC
 LSInlyFr9iOWo4u0STHubotFEfuWXnvYOu/zn/obUm4a4QPJmafkD01+g6npGxXCPtmKxvtFInJ
 rcgOGS3hYMUJaq2VcdB1To3pQgBH+5wzzf8Mnvg==
X-Google-Smtp-Source: AGHT+IE8QL2MDnbnBJqqmYZztSKkbC6N54cKFohfx8Oqn7sK8UvO8eH6scxzFYuKNbM0xYaEljfcSzNW/oVgX2R3L3M=
X-Received: by 2002:a67:f4c9:0:b0:470:4671:2fbf with SMTP id
 s9-20020a67f4c9000000b0047046712fbfmr4838250vsn.23.1708410696964; Mon, 19 Feb
 2024 22:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-15-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-15-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 12:01:26 +0530
Message-ID: <CAFA6WYMaMysFrgpEqg3ZCpPZ2_OBUPtsp1PnJH8jBvysM0Wr=A@mail.gmail.com>
Subject: Re: [PATCH v4 15/39] pinctrl: qcom: apq8016: init pre-reloaction
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
> On the DB410c we support running as a first stage bootloader. This
> requires initialising the GPIOs which are muxed to UART before they can
> be used. Add DM_FLAG_PRE_RELOC to the apq8016 pinctrl driver to ensure
> that we do this early enough.
>
> This is required to prevent the first few lines of UART log from being
> dropped.
>
> Reported-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-apq8016.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index 10796710ba7a..df5bd1c19f6e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -73,4 +73,5 @@ U_BOOT_DRIVER(pinctrl_apq8016) = {
>         .of_match       = msm_pinctrl_ids,
>         .ops            = &msm_pinctrl_ops,
>         .bind           = msm_pinctrl_bind,
> +       .flags          = DM_FLAG_PRE_RELOC,
>  };
>
> --
> 2.43.1
>
