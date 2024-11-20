Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A114D6393C
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2CD8967B;
	Wed, 20 Nov 2024 14:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WMGbpLe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D1F89672; Wed, 20 Nov 2024 14:47:34 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E700895AF
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a6b4ca29bso820991966b.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110452; x=1732715252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fyc7lFDnYEwJiJP+LfqFc/acwW59WT8rsqaCNly7FKY=;
 b=WMGbpLe8GbCkFgOtW/JOmzOqzg6AZAvVdn6/acYPxKnEOfdKKvuhUH0Y7JwmNNls0L
 afEExoM8+fP+eLZqwH59o2lZFAtjOji16tviC24A8oBdzf4gvouuLCuLG89U19Tw5P0Q
 oNznwKusO04pIxnotI2JmukOzYP1W3kGwlsjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110452; x=1732715252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fyc7lFDnYEwJiJP+LfqFc/acwW59WT8rsqaCNly7FKY=;
 b=L650GnijiFpfy6vr7cCLZyQWG60CccUjmDlgpgBbWiwftoEOCoODQ10g9n1SuCcW3t
 0ubw9OStwSgp6swCBHwriBwdelsxdnsXaDDebML8G5fK45cLoKK2U9e2h5NdWm7CsoIR
 Z4xvA/eTDeH/hbAXCiR6hshZSWq0jYP/SIWVO6htqcEA/zBay+ir8/c5OgJjkjzMun6R
 zbnI68Nt04NHbof3qkoSIB8FaMy2w+Gfj9Ho5xC1sf/+tqt2Jchv00cEaD+/KdwXUwwo
 zMqaDL9Y6iiTVXWeg0DSLqkVQOy22jGnctRvgy7o6KtlYLsPAaDP/P/4Jgu90poDGMSw
 RAaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeE9dhlVfveZJEj4Y0U76rH8mgQeUbNgu6aE/z46xDZdKUCu/HWzxqwkE/1B7K3BWZEQJnskk=@lists.denx.de
X-Gm-Message-State: AOJu0YxE11FULTLEKAOja/xWjbzhi3AAoWAQ0OkKxNf/yC6YRTky6vgQ
 vbTG7gwpo+O6evnx/Kj9cmYenq39H7LeFuRVftD++Xs43G+Pf+ZYYUpxC+vr6MmJ5Rq/MXr96Yk
 SuxuUSopT1MxfMqNRO2+NZpoVfUqvmH4olgta
X-Google-Smtp-Source: AGHT+IElvmkjRv1YsKlrgdrfFWW36aQsAob4yG71ofZKQK/nprlt9tNbLOym+3JI3g84mgzYEuwvbexe2x2ApZv6SZk=
X-Received: by 2002:a17:907:9707:b0:aa1:e51d:cf75 with SMTP id
 a640c23a62f3a-aa4dd52fd8dmr249622166b.12.1732110451450; Wed, 20 Nov 2024
 05:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
 <20241110115054.2555-3-ansuelsmth@gmail.com>
In-Reply-To: <20241110115054.2555-3-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:46:53 -0700
Message-ID: <CAFLszTjVX3bob1Hv-7zFv1J_B2TOrE60WbDZJVmXXha8+kbNOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] test: dm: fix broken dm_test_ofnode_phandle_ot and
 get_by_phandle_ot
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
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

On Sun, 10 Nov 2024 at 04:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Fix broken dm_test_ofnode_phandle_ot test. They never actually worked
> and were passing test by pure luck by having the same phandle index of
> test.dts that coincicentally had #gpio-cells in the same index node.
>
> It was sufficient to add a phandle to test.dts to make the test fail.
>
> To correctly test these feature, make use oif the new OPs oftree to
> parse phandle.
>
> For consistency with the dm_test_ofnode_phandle, rework the test and
> other.dts to use the same property with the other- prefix to every
> node.
>
> Also fix dm_test_ofnode_get_by_phandle_ot by making it more robust and
> renaming the phandle property to other-phandle.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/sandbox/dts/other.dts | 24 ++++++++++-
>  test/dm/ofnode.c           | 83 +++++++++++++++++++++++++++++++-------
>  2 files changed, 91 insertions(+), 16 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
