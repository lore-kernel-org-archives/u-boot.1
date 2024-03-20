Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6338C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 05:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A7E880D6;
	Wed, 20 Mar 2024 06:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DWQGd6Q0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D59487F78; Wed, 20 Mar 2024 06:43:05 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AD3880D6
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7e0594e8bfcso840025241.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710913380; x=1711518180; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AwvH7GgSTIhL8zxnA5rCKPKLh6EDs6X89QIatH64XPs=;
 b=DWQGd6Q0EW8riIPo+++8+V79pJIBwGbiWoXrY7bvwcUAls86L/Ee4Tb8ZrEWZKs6vG
 0c7Vmu4uKVMC+sd3HgfHJcEDrSzTDMLPYHAH/hKQwCTv0Ani/IMtPSLqv+7jc9dMke5t
 b2KRMN4agYXVMv/vXOpZyfpVQn7XJ8uHva0ljhvR7tMUGuuSmMebrTBhC5fGfgmSBe1y
 65f+BaCH6ujd320LO9IRKnru46Sg8g83OHA8J5gpqWlXAazhbTrj1/AtVve88pLZvRgf
 0851tUHuYAx6H0iE5lrowjZ1iRy4IFRNRqeNU+CA9I9X9FHOwvtuQiG4TdrnHSeu8mJ+
 7Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710913380; x=1711518180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AwvH7GgSTIhL8zxnA5rCKPKLh6EDs6X89QIatH64XPs=;
 b=TtDmc0Mw3Bo/XfPvJ39jyMw1NNhoioYOVvJxU3wOd1AU132MnUEqPmjzUP1dUddq+V
 zdwU/vbOdZQEPoNaZvDswZyYscUVx8lOAT3HHLuBlGM07tOawIIAPpK0oKzT566C6o3D
 0dKXEeBleTY9wabU+NakFLBTaybAjE8ceb0+6xAsIPJgCuuPJbHX4d4tDSWtnsqOizTc
 /9QWg7wxe7SRKi2jxI8RNUp/8Nt1Fd8i6k8tZZ+d+WT11RkY5q2+Iyv/RHgm22Hi4EAz
 gBeBiBahgpOS05RiaWQktEL+9GY96cEanKb2Fs5Zh8I3/5xWYPQrVqbxpOYHnU2hTSJm
 i7ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkFBnheQnIXaXXeN4IoRgD2xfyAYGLEi1g2qWbUvBUnKPO3EZFTHzBELPO/wADz6IdFAd6OXbVVb1d5RHQZXUuebYxYA==
X-Gm-Message-State: AOJu0Ywubc84gLs0bWVxfV7fgk+xN4rqn9EI92f3SpFvUJYcHV13RW4+
 HRp5uQVfp8D8QIYfkl+l0qo0YNIc9VScPtdqCw1yQYUSc8rE66N3tyw/rSHbjwOqb9XTS4fEgaE
 YjRx/XNKbKiypGjBNZWb/nclNa+DSUMJhd+8KSA==
X-Google-Smtp-Source: AGHT+IFFIg8CBuZhDraWLI/OtWqA9LV8Zm2rFLYc3FZSlrslnTb5s+rhu1Uumwc11xH8toUl90/dLEtt15wkveGx1fs=
X-Received: by 2002:a05:6102:906:b0:473:ed7:fbc with SMTP id
 x6-20020a056102090600b004730ed70fbcmr12069042vsh.5.1710913380192; Tue, 19 Mar
 2024 22:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-6-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-6-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 11:12:49 +0530
Message-ID: <CAFA6WYMSdoHSmhEp2c3mq4o_375oZZ88d0VEempXrSjnZH8ycg@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] clk/qcom: sdm845: add gdscs
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
> Define the GDSC power domains for SDM845.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/clk/qcom/clock-sdm845.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index ccb0cf245d33..b7154360894a 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -145,13 +145,31 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
>         [GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
>         [GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
>  };
>
> +static const struct qcom_power_map sdm845_gdscs[] = {
> +       [PCIE_0_GDSC] = { 0x6b004 },
> +       [PCIE_1_GDSC] = { 0x8d004 },
> +       [UFS_CARD_GDSC] = { 0x75004 },
> +       [UFS_PHY_GDSC] = { 0x77004 },
> +       [USB30_PRIM_GDSC] = { 0xf004 },
> +       [USB30_SEC_GDSC] = { 0x10004 },
> +       [HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { 0x7d030 },
> +       [HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC] = { 0x7d03c },
> +       [HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { 0x7d034 },
> +       [HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { 0x7d038 },
> +       [HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040 },
> +       [HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048 },
> +       [HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
> +};
> +
>  static struct msm_clk_data sdm845_clk_data = {
>         .resets = sdm845_gcc_resets,
>         .num_resets = ARRAY_SIZE(sdm845_gcc_resets),
>         .clks = sdm845_clks,
>         .num_clks = ARRAY_SIZE(sdm845_clks),
> +       .power_domains = sdm845_gdscs,
> +       .num_power_domains = ARRAY_SIZE(sdm845_gdscs),
>
>         .enable = sdm845_clk_enable,
>         .set_rate = sdm845_clk_set_rate,
>  };
>
> --
> 2.44.0
>
