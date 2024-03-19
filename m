Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E4C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 13:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4268C88062;
	Tue, 19 Mar 2024 14:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fe85JoA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A896888063; Tue, 19 Mar 2024 14:27:50 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8397088062
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 14:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-476665f067fso1814223137.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710854866; x=1711459666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4kGGg2mvExQr2aTyZprmV5sLyGMhcGHDU+l58tw3+Bk=;
 b=Fe85JoA2qbILXAaS8IGQsRq5AJWqLDeNrwOVImDH/dsMBfErUWCrlS1aSVqqJGa+Z1
 7TLMKcP3xQvl7UC5DBL42pL/ciRr9c3wUMSAdFdgwKpxISLMcCRWi6WbTbHSN6xhXZ2W
 EFPlnIFe2oa/Bu9PC49C5o2F7HcsqCx4HoP1PaEy1EH99Yze5MpO0AlZkOS6Bm9BLyyW
 4m25ju4mddj4RH3tV+W8/AzedVO26E5n1cHvrRC7zRwudG0QO5W+e/ji27QyBVaNlnCm
 DCCIXDD9uXkTC/d8iFYobuLA7F+Qqw733gUwGCRbetetPhrXZN7eyL1/AghAO5CpYxoB
 /WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710854866; x=1711459666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4kGGg2mvExQr2aTyZprmV5sLyGMhcGHDU+l58tw3+Bk=;
 b=c28KCxOFrFmlf20rVqpsYDa1gXt4FQ24sS/IkYDLKqwIQgnRc3MI2w2heZ/E9qrbxf
 1t7Xx5cl2JXxIO+zZJTTyS67d3lk2PH7+WEmH0XlRj5BDNzHtA4aoqgb4P/DCM0TFLVw
 lTLC2e3OqSopVl53Bj/qAq8U8lkNWaMcmImeMJVm6Mogw1+Yh/uKIH/8DHOd+mA6H3PW
 foRkDWbhNiyJBasQzUvmkvDwVUPrFLz1b9aqqA3l2XxC0m+w33XRPL265HXTZjdCVugA
 xRiZII0H6uf864CXQu9deDJ25PuMDrrOHYqeEdKJOh3MEeK8ZvJxGoNYCB7CDu00rbm5
 tDBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCbEbD1ywqvL6EX+ka9M70NXC06DMQ9SeIMuk8Z35uisyjWHq6rTpwVnz/ERm8BBxDm2+BbOk2x+ApqmPMSJHaU9ut4A==
X-Gm-Message-State: AOJu0YzDM8tZnRcZ4meJLBXscOfONMJSZh5awJkW6zAm3bnKOp/KJ4oN
 hF+muT7fxqYAYQwpTW5YIeZc4OAywJRwwvppgVlvowOe3le9Poo8++RX4gTtGrfJFWQdttAku8h
 XytwjIJ5hVwvXycvBaR0aF2ox0Uht3AiKfNbAog==
X-Google-Smtp-Source: AGHT+IFAgwddyEvEB6CnSLtnuUuMrJhU5l3VJost0V093y4CbA1IcdUFF9jyP2AlalPO0SMo04IJcTHZD/B1sR1xtUc=
X-Received: by 2002:a67:ed9a:0:b0:476:a051:3223 with SMTP id
 d26-20020a67ed9a000000b00476a0513223mr1454576vsp.34.1710854865346; Tue, 19
 Mar 2024 06:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-13-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-13-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Mar 2024 18:57:34 +0530
Message-ID: <CAFA6WYMvTdxgO4DwWoAdVc15+05veSTJU8HN8ak1AS1DLDtwoQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] qcom_defconfig: enable livetree
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

On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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
>  configs/qcom_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index cbc612b44bd9..eebd0d74bd51 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -25,8 +25,11 @@ CONFIG_CMD_UFS=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_CAT=y
>  CONFIG_CMD_BMP=y
>  CONFIG_CMD_LOG=y
> +CONFIG_OF_LIVE=y
> +# CONFIG_NET is not set

Is there any reason to disable CONFIG_NET here? We already support
networking on QCS404 based devices?

-Sumit

> +# CONFIG_OFNODE_MULTI_TREE is not set
>  CONFIG_BUTTON_QCOM_PMIC=y
>  CONFIG_CLK=y
>  CONFIG_CLK_QCOM_QCS404=y
>  CONFIG_CLK_QCOM_SDM845=y
>
> --
> 2.44.0
>
