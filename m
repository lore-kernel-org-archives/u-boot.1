Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C351C83F26
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFA688C4F;
	Thu, 29 Aug 2024 16:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZDPLG95E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7DB288C20; Thu, 29 Aug 2024 16:05:37 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A27488C6A
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-714187df604so1142730b3a.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940334; x=1725545134; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cequSLI8GYbIkzDeuQs6+OcaDeVsAwBs3xgDWvTcDE0=;
 b=ZDPLG95EZeHkkA9EYc00bnYLZog/XedINKkIbbhcvtk1vuOKSp0SaGLn1/g0Mmgrdf
 r1qasgalgouItj+F9Tl4MDMt/BLQ5V06ReDz1yz5Pt/1oEXDFsn6XsyJeazx74L5scCZ
 8QoxS+VWXizbOchah10xn9snyiy47vLyUWAV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940334; x=1725545134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cequSLI8GYbIkzDeuQs6+OcaDeVsAwBs3xgDWvTcDE0=;
 b=EZetj3gwgHafqROzlfNuv0GweGEIUe1t+eyHy4jAi1cj1IHLjUM0GN2ObxcjLvFnk3
 gAju3jsOk9gVciVzyOokrUc5x7mupl2X2n7E4DO9gNeM9pnrA9lAorNqLXCHp7aYpj1W
 5aUdFRxt81sE+Ev0EPXVMEmkjAwIhkXpTep+AdbSZNgyJu0kWrr9Wpm1T7+1bBateUyJ
 MnqJhcbU1LrJZ5YSGdycNz5wvmjWxSTYzRLL9ztGAc+QLXW1W6aBCwP935UvJMjrVEFn
 kaki9hsw95U1htahjT25WGPvUlIEPVKqmbYxSx2bXNTkBwRUhCbUitSniBYFem45+jVt
 c1zw==
X-Gm-Message-State: AOJu0Yz+40/BXzjN7q3GgMNTsIEknNkd5nQLDJpmAF3gpfVpW/caFA22
 sV2Sq08waJ48eE2e+V8JFNexLWFlG83oMwL95RapWuF3JvGdBqyGpSCckkFdIAuCSQjX2OuHy8f
 N0H4aURjZ6ACSw7pDMdlDGy+RQFj4f5t1qQN+
X-Google-Smtp-Source: AGHT+IEdHViHOOCNNsycaW0jBmt4s/Uj+J7LxnXYmExCldpasx+CQC17KLfRsmc/VA/4h5UgGLQ2RHiJsrqDX++8Ut8=
X-Received: by 2002:a05:6a00:21c9:b0:70d:36ad:3f67 with SMTP id
 d2e1a72fcca58-715e78ce191mr3612438b3a.11.1724940331206; Thu, 29 Aug 2024
 07:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <1629f6845b448edcdead09a9350f1ae2ae7a4bb6.1724419624.git.jerome.forissier@linaro.org>
In-Reply-To: <1629f6845b448edcdead09a9350f1ae2ae7a4bb6.1724419624.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:05:05 -0600
Message-ID: <CAFLszThJzVvHSd+dEjTSff2DUPPaQTGWeyCmHmP56Vtjr0WF-g@mail.gmail.com>
Subject: Re: [PATCH v9 35/37] [TESTING] Kconfig: enable NET_LWIP by default
 except for SANDBOX
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Shengyu Qu <wiagn233@outlook.com>
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

Hi Jerome,

On Fri, 23 Aug 2024 at 07:50, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Enable NET_LWIP by default for testing purposes. SANDBOX doesn't support
> NET_LWIP so default to NET in this case.

Sandbox needs to support NET_LWIP.

>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Kconfig b/Kconfig
> index 6657b9e5e30..2b316afa542 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -749,6 +749,7 @@ menu Networking
>
>  choice
>         prompt "Networking stack"
> +       default NET_LWIP if !SANDBOX
>         default NET
>
>  config NO_NET
> --
> 2.40.1
>

Regards,
Simon
