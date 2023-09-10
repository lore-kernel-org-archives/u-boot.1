Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD889C71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB1586D2B;
	Sun, 10 Sep 2023 21:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G3ybZT/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09A886D27; Sun, 10 Sep 2023 21:14:53 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A1BC86CFF
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d7e9d849bdfso3245377276.3
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qRDyRuJQs4DfMiL4IwASX57QnlfkBSVEAIWxitxCzmM=;
 b=G3ybZT/xx9X9ySpU6B1WWs2ibDuueBkNTmjKcWByAjiodSrziGHoPzC379cPPOBqdr
 y4/d4CYCEHhcCM5BeARalMcALjGY/IUDwC01OvE3RWN2f8/xc+fe0tEuNsQz7CZj43DE
 6J4Hp6sKviNdNalVWoJ0f3O2icpo9lRyKwk6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qRDyRuJQs4DfMiL4IwASX57QnlfkBSVEAIWxitxCzmM=;
 b=rikwcTzO7EipMqj+vHj3HJrOS26Dk2SDh4BEQH8FhNIv4EdxUwSiWiyheu0oMzgkPd
 Ld5K3Fy2WZmdRL6sU8xuEsHYxzcGDqm+AbGSh/Wv0j18ZPPBsKTcATxsMYgXEbGhmYnM
 8q8wVVTEkQCzxie5zc+gz3sSqEiuga8/NSSwsGg4k+X895aW+4+udfVQHbF+ObZybjOU
 8pFFfnauUiiVY3ASMFRiBbobsDr/MuHVe6fHgHFz0cnwiMszG9IREJ912NSAekZ/7eMA
 YEHx/7+05tNzLUzzLo2ccaUmH79JANbuhwR2TBxZ0ekCLRpXTV4C0qWjyVaWOXf+1VW0
 wArw==
X-Gm-Message-State: AOJu0Yy3kSJ5PfD1DtL3wp1ZkzBfwqxszpIKF1mImZAaYkWWpKkWsf09
 gTouE0n0XYbdng8YIgcdtONu4CjoKzF/OjmNnwthgg==
X-Google-Smtp-Source: AGHT+IHIvU9Zvsr3Bd4hg3BwyaxAVSr/Pw9pFYr8ZQR9joY64BRnNSO897qKqCPAgD8COp/WmcBzTx5tOasQcVp9BnQ=
X-Received: by 2002:a5b:743:0:b0:d79:d23f:b49c with SMTP id
 s3-20020a5b0743000000b00d79d23fb49cmr6741070ybq.35.1694373286977; Sun, 10 Sep
 2023 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-4-takahiro.akashi@linaro.org>
In-Reply-To: <20230906024011.17488-4-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:27 -0600
Message-ID: <CAPnjgZ00tEakxn4qq+o5W2Ks-bq+YW=JngJhE-zoqJYtjBFwtA@mail.gmail.com>
Subject: Re: [RFC 3/6] pinctrl: add scmi driver
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com, 
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
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

Hi AKASHI,

On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> This DM-compliant driver deals with SCMI pinctrl protocol and presents
> pinctrl devices exposed by SCMI firmware (server).
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/pinctrl/Kconfig        |  11 +
>  drivers/pinctrl/Makefile       |   1 +
>  drivers/pinctrl/pinctrl-scmi.c | 537 +++++++++++++++++++++++++++++++++
>  3 files changed, 549 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-scmi.c


[..]

+
> +U_BOOT_DRIVER(scmi_pinctrl) = {
> +       .name = "scmi_pinctrl",
> +       .id = UCLASS_PINCTRL,
> +       .ops = &scmi_pinctrl_ops,
> +       .probe = scmi_pinctrl_probe,
> +       .priv_auto      = sizeof(struct scmi_pinctrl_priv),
> +};
> --
> 2.34.1
>

Where is the compatible string for this driver?

Regards,
Simon
