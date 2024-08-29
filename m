Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F033C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC61B8862E;
	Thu, 29 Aug 2024 09:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J2LEuVo7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C924D88A2D; Thu, 29 Aug 2024 09:34:02 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE9488360
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-201df0b2df4so2585635ad.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724916839; x=1725521639; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V5AV+864QF/d2jvolZRudEj9DuTV+dZMFePeb4bKWi0=;
 b=J2LEuVo7OrKDrb7D30pMXCz/8jdlghHnhUTd1R1gX2CoMDaC82HJQLxXa1+gGU7VM3
 pRSNUk7Nl8xhMhJySsofjqdvDnN1CmMcMMZl/xJI7wtHPlldHvH3WH9Uf0XZatURvA5A
 xydBYTaUNHvLe3CIOnKqNf8wXPZDcjADLIx/4KkcTANzhweCwpvj9kUGFdbjs5mm2+bZ
 l7oiSsi+7vqb5QQ/33UlPd9dvH6ST0YmS9JRE75IQKlG73FmeW9WFMpvl5KD+451cMtn
 f+Qi32mALXwbq/amjI8tyuO7VPB59PyAiZfuUjLrFERp7kgLAq/g2NnsmSu0uyLNs927
 kqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724916839; x=1725521639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V5AV+864QF/d2jvolZRudEj9DuTV+dZMFePeb4bKWi0=;
 b=ex9J6eJ+/4LCLMoYC8RqimEW50V1NlbZwuZVBV0sS3E0KnBwxCi/81Yv0NHklZcLcY
 w9CgWpaPigYJ21Z7Ty8m1EPgk4Ue5miYf3cpBVReUMNeBXK2N+5ywZRQECt4G5p8O4hZ
 Htn2dYSpkAPj9saaTqHC9mZ+syySC93F8wKvqpLYu+oCVSoT3fteKcvzJPwW/MJP7jdG
 CjXzB1hyUxZX3ejy541vNhtT+2NCSaR4TQprl/lK1hz2txGAzw6zFeLmSAIyYY5eeKXK
 pPuNf0n/d5hXX5vPIzl9s6O9LaSFyg71RqR7K1Dm2kGgBsPQG0LjHhJpgtiDFjda38rG
 s5dw==
X-Gm-Message-State: AOJu0YzB6WAcGMIPMuFYLh5n9jw+FIbn66HDBUL+Sxa53r17iurOj1s4
 k8Fg/WyHyU5YQchGmTvFCGfc+BK4uOkvrmkkIXqHlKkWPsNR8NMickd31VRL2YQC9ZBM9TAiKgm
 cpvOdvRoVTvic6w1MJmzRRsYHQPKBEyQAgB1YpA==
X-Google-Smtp-Source: AGHT+IHQziB0iS7rQS5J+DLw4gOns3Zyqvxd33KoKJTpXs3Y2cmrJOafmDh92V2xmEhyho7sI3U5LFdyatho3+q4jok=
X-Received: by 2002:a17:903:2444:b0:203:a046:c665 with SMTP id
 d9443c01a7336-2050c35478emr24182265ad.15.1724916838966; Thu, 29 Aug 2024
 00:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <898bcb397c26f6eb7b0750b91c6c6ad2783d5195.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <898bcb397c26f6eb7b0750b91c6c6ad2783d5195.1724846454.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Aug 2024 10:33:22 +0300
Message-ID: <CAC_iWjKEaoPVAcbVsZxms4fQvij42Nqvkyoq-nmOA6ia6G7ygg@mail.gmail.com>
Subject: Re: [PATCH 07/13] net: phy: ncsi: depend on NET
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> PHY_NCSI enables drivers/net/phy/ncsi.c which calls net_loop() and
> net_set_timeout_handler(). That's the legacy NET stack (as opposed to
> NET_LWIP). Therefore add the dependency to Kconfig.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/net/phy/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 73064b2af6..a9efc50981 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -368,6 +368,7 @@ config PHY_FIXED
>
>  config PHY_NCSI
>         bool "NC-SI based PHY"
> +       depends on NET
>
>  endif #PHYLIB
>
> --
> 2.40.1
>

This sounds like that should be fixed on the phy driver if we want to use LWIP
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
