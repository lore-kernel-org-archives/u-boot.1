Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BA1CD128A
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6B2E87F39;
	Thu, 11 Apr 2024 14:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n4nojJRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 709858824A; Thu, 11 Apr 2024 14:03:15 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD55E87E47
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ea2ef1c6b6so1166961a34.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712836991; x=1713441791; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MIDagdf8YLb9egZaLnmUjL5gAJnAn31KQ0vjz9i1OTI=;
 b=n4nojJRNv+7TjAmLT8Obh3eg96ULi9IcD28mPRLaNpKIvYxoCTPBSpeRZkV6doqR9F
 M0X2EuBa7mYO0gnkycEJzq8W1YuVRbIT6Xxy/j+JTMwqPL7AKVow1zwYx332Zw1QfxUs
 ybmX0ojhFSUkmvZzS/gvb3kVeCqBaRig9xoDvqP4drSCw6/HtYOV4w67E7l3yAmtiTvh
 qTCBAntxouvKRXjbJbc2GyQwUMfYCahJ2fMprjkCNKwgKZYScmUmDW0gqO93494xwxBo
 /m+dDpBTJ6MTnx6WCuDZyqAMCK4cdJE0um828AIUG4XALbJWHjraZducWLVx/9ZoaXyM
 KGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712836991; x=1713441791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MIDagdf8YLb9egZaLnmUjL5gAJnAn31KQ0vjz9i1OTI=;
 b=asZBglIHTYFjunRbLdILsTsieMhiW9mFe0DA2Ti3f42BU2z7ckTf2u7hqwH6bq6i5k
 PRaMbCFX20N/H/6P+d21t15nehFXGCLC5AO3MkLOwVvri+06LJ5yfXC3UL8iE68ZqB+C
 ur2keH2cxWnVnL1yTpQHxVXijWeigKiiKjgdoaLx/0nEBGD6AhxOvUycivJQFEcEXlpg
 EqYM8fdD4PpPhHJngRJ5Lw2fOKGSTpjw96PTTZRvR4u0r3VreDWhkmL6seTIgNi22H4U
 8xzEiYtCCsc9IPu5htDhjfSYpmXHa0DHWsLv37rr7wksCF48CmG+UOw3A6XiG38/5hmL
 092g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhdlvLO5MNNkZWQ6l0VuHqWH4RkWUZ+a1xUPXrLZHxinPNAX0lVyK6Ji0iVgwbk31G07Rtz3pfgPiRA9NnbR/MS1TdGA==
X-Gm-Message-State: AOJu0YzDRvlqsrGjMy1z7mAl16eUdDC+BsWqRZCGkL70JwWdknWJxWDp
 ntQeBbNq7yItrUZ9GNAUuMsKUYJmLXJm3wT4+86/Sl9f33uK8Tg5QBH5pR45YWIe3VgCpNpKrzc
 QuIyBnxszN/+VBC0XjZh3ZR1Tubka8N1bJUtoBA==
X-Google-Smtp-Source: AGHT+IEdp3Nbi2kj+MILmwxWWyYWO63+SfhQeEaNBVHuD6LI9DpE9MIqi3mKY12zWaajElCmwOBaODBffmIVkBS/L50=
X-Received: by 2002:a05:6808:2228:b0:3c5:e2dc:8a6a with SMTP id
 bd40-20020a056808222800b003c5e2dc8a6amr6789659oib.24.1712836991559; Thu, 11
 Apr 2024 05:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240410-topic-sm8x50-usb-phy-v2-0-9d2d90bd04da@linaro.org>
In-Reply-To: <20240410-topic-sm8x50-usb-phy-v2-0-9d2d90bd04da@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 11 Apr 2024 17:32:59 +0530
Message-ID: <CAFA6WYOAXg0+74k2iudvjt7tHuvGi44y9VaJkDqTY_Qsc9KXBg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] phy: qcom: add support for the Qualcomm Synopsys
 eUSB2 PHY
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
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

On Wed, 10 Apr 2024 at 21:31, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add support for the new Qualcomm Synopsys eUSB2 PHY found in the
> SM8550 and SM8650 SoCs.
>
> Finally enable the driver in the Qualcomm defconfig.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - fixed driver build failure due to missin }
> - Link to v1: https://lore.kernel.org/r/20240405-topic-sm8x50-usb-phy-v1-0-8a8604bf818f@linaro.org
>
> ---
> Neil Armstrong (2):
>       phy: qcom: add Synopsys eUSB2 PHY driver
>       qcom_defconfig: enable the Qualcomm Synopsys eUSB2 PHY driver
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  configs/qcom_defconfig                 |   1 +
>  drivers/phy/qcom/Kconfig               |   8 +
>  drivers/phy/qcom/Makefile              |   1 +
>  drivers/phy/qcom/phy-qcom-snps-eusb2.c | 366 +++++++++++++++++++++++++++++++++
>  4 files changed, 376 insertions(+)
> ---
> base-commit: f0e6aba1218bca578605697eed8aa94582bf57bb
> change-id: 20240404-topic-sm8x50-usb-phy-d09a98f72d1b
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>
