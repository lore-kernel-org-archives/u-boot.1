Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC7ECFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F7088FB9;
	Fri,  4 Oct 2024 08:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ecsmUKeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7021B88FDE; Fri,  4 Oct 2024 08:56:05 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C9488D7F
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so837607a12.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728024961; x=1728629761; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cf9fIGPPZLB1hCV1VK/fkSdhXiLHbyaftXjoaB6VtJ8=;
 b=ecsmUKeXyLJlDDXjf2gkSlvGJpArus1GiTNkhda81e1wf9bS57p0pt8rfiwGCv9Dsq
 yNz5iowTM1qQOv7IgvD51hEtwvyYsRqWiGsSEYVPWc3kTz13uW/Nf4Peu5XFvsKIwyvy
 4JaH9C6AhLMHF0iOoVRXL9Ym+OU71nHCaZQb+B90QesOVtZk+2qPocLAfT95Pmftmulo
 b2hVEYHTIEsoSMw/o8hPLUhUfs2VvALrQzNLiHKUIptM41zCXwWJ8RqkBCynHNd0N+Wc
 SWJbFHYWXvQLPbLevMjAUaFIMvL1Ur7QydHrsGWxpqsWKv0t7cHQ3xg2RVLxX1D0Z8Cc
 gm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728024961; x=1728629761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cf9fIGPPZLB1hCV1VK/fkSdhXiLHbyaftXjoaB6VtJ8=;
 b=SueQY3ZQt6BZyCswxFgFspIh8DvgqhX5f+nPrynp0IKoeqAMD2yB8QhPfeyCEH7DNU
 60vchW7DN5HxgRh0NJc0fSleCaG0lQwaJ2npQ9Ft0l44ZXmCoZKEdFk0f/v9YqPzBOf3
 8RPZfyR7zEMJ+S5kOSS3V977NoQJdUdkL9kl97+eIkL41llnzIqrvIbzMEe8rLMTsrA2
 PR9SNgtDZujzOouAgYRN03SxiwWu6hkSAtoiRnGIlo8SsRxtn28rXiAThCpEW//k2g/B
 4j8mUJYwII8lux58hPerpa7Jhp70TG2WNo9tm+jwKTuuSKunME3ev7PtyczmVx+C4JZb
 njVQ==
X-Gm-Message-State: AOJu0Ywne5ZkFlXADc539CzbT+UaoYfgCOt0c6NQJvG9yexSvAVqCaY+
 LJYgIS0ktIRRzsZvMTVDbohMshFpfR9o7O6bTE9CWxUIeL/iC2HraronKhazQ/2wnPUCCkdRXEz
 0oiWafdvPUEnCXkFTuSN8lr5swexNbeScwVcDhg==
X-Google-Smtp-Source: AGHT+IH/eBZTWayu7/v8e9uQrzdumtu/PldCcNucbUT7T5Lj4BaP0uIIWx+VX8YCXFVsF2xC1ra7HjhnCRIF9FfZ8Hs=
X-Received: by 2002:a05:6a21:1583:b0:1d3:2923:e37 with SMTP id
 adf61e73a8af0-1d6dfa42fc5mr3081458637.30.1728024961497; Thu, 03 Oct 2024
 23:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <2e8206d8bbd7d3140cf2734ca9b3fcd12ced4f14.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <2e8206d8bbd7d3140cf2734ca9b3fcd12ced4f14.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 09:55:25 +0300
Message-ID: <CAC_iWjLTVV=QpfgGMTSJ205JGRzNDkBuJeO9GwEW4D4PhrJWrw@mail.gmail.com>
Subject: Re: [PATCH v11 06/29] test: boot: fix bootflow_cmd_label for when
 DSA_SANDBOX is disabled
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
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

On Thu, 3 Oct 2024 at 18:23, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> When DSA_SANDBOX is not set, the sandbox tests fail as follows:
>
>  $ ./test/py/test.py --build-dir=$(pwd) -k bootdev_test_any
>  [...]
>  Scanning for bootflows with label '9'
>  [...]
>  Cannot find '9' (err=-19)
>
> This is due to the device list containing two less entries than
> expected. Therefore, look for label '7' when DSA_SANDBOX is disabled.
>
> The actual use case is NET_LWIP=y (to be introduced in later patches)
> which implies DSA_SANDBOX=n for the time being.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/boot/bootflow.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 6ad63afe90a..c440b8eb778 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -109,9 +109,12 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
>          * 8   [   ]      OK  mmc       mmc2.bootdev
>          * 9   [ + ]      OK  mmc       mmc1.bootdev
>          * a   [   ]      OK  mmc       mmc0.bootdev
> +        *
> +        * However with CONFIG_DSA_SANDBOX=n we have two less (dsa-test@0 and
> +        * dsa-test@1).
>          */
> -       ut_assertok(run_command("bootflow scan -lH 9", 0));
> -       ut_assert_nextline("Scanning for bootflows with label '9'");

Shouldn't this under and #ifdef, IS_ENABLED etc?

> +       ut_assertok(run_command("bootflow scan -lH 7", 0));
> +       ut_assert_nextline("Scanning for bootflows with label '7'");
>         ut_assert_skip_to_line("(1 bootflow, 1 valid)");
>
>         ut_assertok(run_command("bootflow scan -lH 0", 0));
> --
> 2.40.1
>
