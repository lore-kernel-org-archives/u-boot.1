Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A2AC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A3587DF9;
	Tue, 20 Feb 2024 15:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CbDHgvnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B2A087D7E; Tue, 20 Feb 2024 15:01:13 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424C187EB8
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-47079f43a37so23898137.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708437648; x=1709042448; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ni1qkfc4ztgiYnkDMyMiyTYHTZTDetQQtI3UGzKv2ck=;
 b=CbDHgvnE139y8n56rs8OlLArqN0j99xyqLoxHTuIxTUDhtRLmaDz0GAndktvH7388G
 iK0snehEdVwJOdFFyrqqSa9+khx3OUXhvlSn1T1v5Wlf9Ww8RmcUJmaJ2mmUEOF2r4mg
 kWDdj88iV+y89FiwMFhj/zSWLoRE7sovjwJ1Qn4uPGnxMB0JeuwY9kXGBxG2o+G4o3XN
 2MhbyeejQs0AUfy2w/64yAlMytlWZVw6+Igf76yA0Iy6KJTGAJwxNBLYwRRMBxPeZ9cm
 2njsilQV2VtpUAMONRkfXNKV7YzIqWmGP4/v4DL8CsLDI+Q5xy5v6r6cPyjicB/+agg1
 9diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708437648; x=1709042448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ni1qkfc4ztgiYnkDMyMiyTYHTZTDetQQtI3UGzKv2ck=;
 b=OEEMZpBt4jKVtmm42IURNhWn398kTFlrFFdyOOVZMxCKgM+95yt/eHUw2ebYd+qWxL
 RzuNhG3cXJ51T00VYGplt+Doh0L1djmZhUg3nLe4vopDAVFVjnWDtX7miXzj/0BNS2Kk
 RJDJtMQl9TNaqxMwONbKo1ZYIx/4fLJWVP4hcRfz+u7HykoTxkiLUHPi/F9GO9VGZqmY
 WUimhBpYPXZ30uYQiha2nktMjVXYoKAtcbfNb2QxPimP6JjJTvJf06piTX2W+IeL627a
 ky5JvOUOG9zqwymV3yUin7cvL8OmK6WnyWz/B1Zwpbj/O1UJ92iqTrfReJvZV7luHyB1
 1C7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrUv6xeaynwUXlj3yFsRBxSxt+iGimpkfgthLydK3RMXc0U0kQfJ9YzUy7j2W55tJdvHz/eRPKpC9KGySojCibkY+bIw==
X-Gm-Message-State: AOJu0YxBrfXaBOEoeIwjFQXubrvRRMKs1q3zhOqHsKrqmNEg5ikowrmH
 79HGESOGnQcVi9fMkPeGfGnZi5xQaxHmp6qwZ0C0o+ulp6V2oRenwNs7LtxXZzg5ELu++nn70ue
 WtiYUKNKAJ7N/hda9gxUaoF8mJuj2OHzEEO/j9Q==
X-Google-Smtp-Source: AGHT+IEQ9vtp6S4cVUYB4RTash+0Y7XACsInWdI/dedVXoduPed2fLMs7agUSkCrFi1E+WXS5gF+vrPsTLmMyHPDnkc=
X-Received: by 2002:a05:6102:496:b0:470:5667:5d6a with SMTP id
 n22-20020a056102049600b0047056675d6amr544064vsa.27.1708437647712; Tue, 20 Feb
 2024 06:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-7-ed06355c634a@linaro.org>
 <CAFA6WYOUVRNf1hMMty6uTk_cNckrHQ6QNBkPsPiGuw=P+0OV4A@mail.gmail.com>
 <f9c81d80-0733-4b84-97ff-32143bfe585e@linaro.org>
In-Reply-To: <f9c81d80-0733-4b84-97ff-32143bfe585e@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:30:36 +0530
Message-ID: <CAFA6WYM1+Lf56vZwDy93mmsT1TmDj1KKv7n4h=HLOs7NLY4jhA@mail.gmail.com>
Subject: Re: [PATCH v4 07/39] serial: msm: add debug UART
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

On Tue, 20 Feb 2024 at 17:09, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 20/02/2024 06:08, Sumit Garg wrote:
> > On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Introduce support for early debugging. This relies on the previous stage
> >> bootloader to initialise the UART clocks, when running with U-Boot as
> >> the primary bootloader this feature doesn't work. It will require a way
> >> to configure the clocks before the driver model is available.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>  drivers/serial/Kconfig      |  8 ++++++++
> >>  drivers/serial/serial_msm.c | 37 +++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 45 insertions(+)
> >>
> >> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> >> index 26460c4e0cab..fbd351a47859 100644
> >> --- a/drivers/serial/Kconfig
> >> +++ b/drivers/serial/Kconfig
> >> @@ -319,6 +319,14 @@ config DEBUG_UART_S5P
> >>           will need to provide parameters to make this work. The driver will
> >>           be available until the real driver-model serial is running.
> >>
> >> +config DEBUG_UART_MSM
> >> +       bool "Qualcomm QUP UART debug"
> >> +       depends on ARCH_SNAPDRAGON
> >
> > Since this debug UART only works for chainloaded configuration, can we
> > somehow add explicit dependency here? Something like !REMAKE_ELF?
>
> With a small patch (which didn't make it into v4 apparently) the
> apq8016_clk_init_uart() function from clock-apq8016 can be adjusted to
> just take a base address rather than "struct msm_clk_priv". It can then
> be called from debug_uart_init() and allows for debug UART to be used
> when U-Boot is running as the first stage.
>
> This is definitely not ideal (although fwiw if the GPLLs were configured
> right then this same function could maybe work on QCS404 as well

QCS404 is chainloaded config too, so the debug UART should work there.

> - the
> RCGs are at the same physical addresses), but I don't think gating it
> behind REMAKE_ELF or something is a great solution here.

I don't have a strong opinion here and I could live with just a
documentation update for debug UART too.

-Sumit
