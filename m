Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F133CC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 11:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF15874B9;
	Fri,  8 Dec 2023 12:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JAS5qtmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD78C874ED; Fri,  8 Dec 2023 12:13:44 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7D8587140
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 12:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-db549f869a3so2253595276.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702034021; x=1702638821;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bY67WxPSaaxqlP4fbIulswVUo9KLf/7FMfYOvPQfvG8=;
 b=JAS5qtmbL2eMWWFRp5ia5vNnxjIeBZVXNbJ1Wj92qndiQUNe81yLlTkNPT0EIQaeSa
 oke6YRFbjyJqzjhglEl5/Fk995vZZNWtuu1wYzejnwxBsc6IP+nbgqLh9FylSsvfcVoi
 CNkX3hz42dH4FfLDhcrqhlhnOVtiGC6mVORpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702034021; x=1702638821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bY67WxPSaaxqlP4fbIulswVUo9KLf/7FMfYOvPQfvG8=;
 b=APpwGrbEnrwzNqRRuIxqjXuexEl6/+9/Qi3GjlXsGsRm15Qv/9BFPmKY+gPTsQ/wkg
 /WsJBrmLNRkHLJygDuu0pah80VAAxboBjdIA8tOAk9wEb4v7MjzJDS92DPA9pQ9Tf0ID
 XhJqoiNoYBGyo0VZ+Xbf8ZEx4Z8Af/+AdYtrlnwLPzoBbKNgLmotOqTp54xhVO4xO4zU
 6ipGmli4ruVBLuYjrXaJKbkaHdqmyuED1BHwroncG5cSf+wg9cCiVWvPTx/R9LTIF8IM
 v/JDdAcUYiH8fovdAYVsSYUlxwXWJq+nUF4JBvkcf2AbJ2Ul7xEbr4fipV/TUwOPUh4M
 Wf/A==
X-Gm-Message-State: AOJu0Yw1c0TIwKZ3xgyPgRvGvUg600v13tqJ8EB1bmjNdTqyrj+7XzqZ
 sqnH/a4QD5ZOQK/LK7sVtooNG5Jb0G1q2Jv84EFxUg==
X-Google-Smtp-Source: AGHT+IF8dZr9ooriHFNjvWpHVzULeHwvMjstM/pXORyijD0DsmEQCTfWIsSZHeSTVAZOudq+3AFQ17+5uUQsHxXNnCE=
X-Received: by 2002:a25:8187:0:b0:db5:46bf:30ef with SMTP id
 p7-20020a258187000000b00db546bf30efmr3855268ybk.42.1702034021303; Fri, 08 Dec
 2023 03:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
In-Reply-To: <20231119172310.1307942-1-i@shantur.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 8 Dec 2023 16:43:30 +0530
Message-ID: <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Nov 19, 2023 at 10:54=E2=80=AFPM Shantur Rathore <i@shantur.com> wr=
ote:
>
> Rockchip SoCs can support wide range of bootflows.
> Without full bootflow commands, it can be difficult to
> figure out issues if any, hence enable by default.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>
> (no changes since v1)
>
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d812685c98..fca6ef6d7e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
>         imply CMD_DM
>         imply DEBUG_UART_BOARD_INIT
>         imply BOOTSTD_DEFAULTS
> +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS

Yes, but better to give this option to specific board vendors as
defaults are enough to boot 1st bootflow and what ever media's it has.

Jagan.
