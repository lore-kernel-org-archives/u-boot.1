Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4792CD58060
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 10:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B653589A35;
	Mon, 25 Nov 2024 11:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ti36jG5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2023289A37; Mon, 25 Nov 2024 11:58:30 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD99689A09
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso3525886b3a.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 02:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732532306; x=1733137106; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vxpwlu5X7gFnNAwE9FJfvYrsqSlWvkTDFraHTXPCzyU=;
 b=Ti36jG5vFgbY6NtRAQyKtdO7vXdA7QgqBQns3TPCPvv40iQGH5c+b3GRHkPRXY9S5p
 3Hymbi3sWBV+NTfGBc0wAOqF7aKZSis8wIE4dY9D6DUjY72nfbhuMKjr1jVU3/Dto+La
 G9Fh5ZH+FAI/Vz4qE0XgJAYrbMt4CZzlfChSqRQmy2Pq2Rn0kE7636aFXzB84y5EOC5F
 ZQomrjc6O358/XWOKq1sC9WsuzZCARdIaEluO+0yOF2bBqe1tWO5DsnpnK72AdCWz1mx
 47aUFEimE7GSC71alX/fFHGDaQxz2q1+AFgLnZhKfUQZQV7SkPMVuNKEo6bJe6/ftNH7
 eRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732532306; x=1733137106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vxpwlu5X7gFnNAwE9FJfvYrsqSlWvkTDFraHTXPCzyU=;
 b=p+Ff435Yxj8gWBZkCqcp2MvFYhb1v4AcBiBHRUmWQzoFUGXmIau7iclcEMDjYRUqmO
 yWpFNip9M+FosDERNxF9IMCv1srelVxZcoLkZjIXYvORScfLmO5AlXnnaR6YoMLy2uCe
 qkRQ+pHSLuiTaqwunlLQhlgzxkltbnK4rPz6wr56IQaVIsu5nZuXDDZUz/ga1vPIuGV4
 eWq+O3JdK5Bg8jHxmmSya64IEcbzD/Pq3V6xTv27BvoXPgeBIN8HFqovzJFqdPdzyqUE
 7/NnLQ72MC6tY0Zl0nidS8fKdmnAROiQ2NtZZQZNtWJ7SGf129JMZrs6y9Eof26u+SC3
 g0ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT1zuD+vyqd69urUMfRgOvvegZ5UBWJdwzFdtMq3H+sJqy05iF5y7tXi9nMA0vypR8cBFHzVA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxvxl1aa3bS+IRa0zq7/koBryOxuJRF3Pg2AcNwC2gZFBd9/fGD
 VuVaCncHOe0JYoqeereQTz2RvAmJFahx9TxPuDACDYP1VlJNGmn76w8eyYu1oG1LQRCvKrdtWL7
 aZdaO7iC/C3Qr/kktkP+Gc/wwpqMyGJOWZwwbBg==
X-Gm-Gg: ASbGncuuI2G/bErIIq3D54vyQCkWIIW6xuTNX0ZYkszYsk5V05KxY2xaBIUI/X+Xw7d
 KXOkr0TCCs/U629qxUUZb7Ly0CxsBHg==
X-Google-Smtp-Source: AGHT+IGvrxFEplRjk/SGG0huaDrINB7ZWupVhjttaTcSnigyvPJDgfTNlPFZXkRBvnjA0UZom59FZk1z4At+iXpwbSI=
X-Received: by 2002:a05:6a00:3d12:b0:724:f51c:8dc2 with SMTP id
 d2e1a72fcca58-724f51c90bamr10537978b3a.9.1732532306245; Mon, 25 Nov 2024
 02:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20241124183832.2476928-1-caleb.connolly@linaro.org>
In-Reply-To: <20241124183832.2476928-1-caleb.connolly@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Nov 2024 12:57:50 +0200
Message-ID: <CAC_iWjLboEqdpziTG-60fmv7AnfeNDrroue4Cz7ETM3cd4XXng@mail.gmail.com>
Subject: Re: [PATCH] common/board_f: init malloc earlier
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
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

On Sun, 24 Nov 2024 at 20:38, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Currently the early malloc initialisation is done partially in
> board_init_f_init_reserve() (on arm64 at least), which configures
> gd->malloc_base. But it isn't actually usable until initf_malloc() is
> called which doesn't happen until after fdtdec_setup().
>
> This causes problems in a few scenarios:
>
> 1. when using MULTI_DTB_FIT as this needs a working malloc (especially
>    for compressed FIT).
> 2. Some platforms may need to allocate memory as part of memory map
>    initialisation (e.g. Qualcomm will need this to parse the memory map
>    from SMEM).
>
> Move the initf_malloc() call earlier so that malloc is available during
> fdtdec_setup().
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index 98dc2591e1d0..bddfa6b992b9 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -867,15 +867,15 @@ static int initf_upl(void)
>  }
>
>  static const init_fnc_t init_sequence_f[] = {
>         setup_mon_len,
> +       initf_malloc,
>  #ifdef CONFIG_OF_CONTROL
>         fdtdec_setup,
>  #endif
>  #ifdef CONFIG_TRACE_EARLY
>         trace_early_init,
>  #endif
> -       initf_malloc,
>         initf_upl,
>         log_init,
>         initf_bootstage,        /* uses its own timer, so does not need DM */
>         event_init,
> --
> 2.47.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
