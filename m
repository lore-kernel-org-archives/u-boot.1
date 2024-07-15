Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97775C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECE7D88835;
	Mon, 15 Jul 2024 13:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CC4Zmnix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0868D8882C; Mon, 15 Jul 2024 13:39:43 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803E4887FA
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4f2f31a9410so1574942e0c.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721043579; x=1721648379; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=26XzJ0PYeZ2z2nJwrANa11Fgb/nqiGXBzn/iwax/d80=;
 b=CC4ZmnixjiaxTzCHIlBZfW/cHGuP0iLa6qXt7Qa6b8rypuHWvdJUqEl2rQGgAkMWKn
 yjIh7EsW0CAcxqTPzlOtXgfmZgoS2C0sJ9G/RqZIK8lypJTsrZwNYfIKdU/l4dtVN7bx
 tkUI06q/Xc49+dBynPq0wT+zu7Wd61enRAbrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721043579; x=1721648379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=26XzJ0PYeZ2z2nJwrANa11Fgb/nqiGXBzn/iwax/d80=;
 b=W4MaSUfGBMFEM1Q/mfcmo7mo9jnHDuiyYRyBY0QvRoXBVWgEBw9a3yZcXISjDkSb/w
 I5BVJxGtClKtvn+pBjwALHpmodA0teRtdnMNRPOcS7wI6fxQkwWAqyGqKFn9d2uVJ19t
 YmBtJS0ePonAdwBmoXiVYbDrQJvCLLzeOoZPylhVMjlTr2x6Aq81yrJ/wSe3h4Ju//bD
 h42XMA2BpVBTBPJ/aiejXhlyOJ089rHUxVJdx1+nHxY32xVbaZxaWtXj8Plpq0BTriM1
 kmeRt4P8X0we30YAxKqFTlbzTPoI2ad7kSZEfcvDeMOXF3pNHm38PrZpJP522V/BeIAb
 SVww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpv1lTGH77Zsx5vDlmYTT+NKuHH7uC/ICYzXyWi2XvljbqUxWzsje8TZFILiynOX5UiZk/D8iynz12k2DH8pffuqPOUg==
X-Gm-Message-State: AOJu0YyuF6s0ZlLjkFLt+J28uA9Ds9ozWLfbuP0gICn5I9KSc86ZKsiF
 Fq19uYEGtWPUwxi5ZdR9QeDzcAAXqRopa1OSj+GjRMc3lvrVI2ReRw3SM+Myggs9psYx+OYpJpe
 eVMZk3qPXF+3wwHXdcNs6RNBq1kFGdlWYAYjW
X-Google-Smtp-Source: AGHT+IHOZpXF4//BuIXZEGTSFzWGVsV28WFHaHNwPkixN6LfGN3MI2gh2014JQoCrMKoR1x3TXf9/6KRWiSqb331mfo=
X-Received: by 2002:a05:6122:4109:b0:4d3:36b9:2c26 with SMTP id
 71dfb90a1353d-4f33f31b0abmr24888690e0c.14.1721043579357; Mon, 15 Jul 2024
 04:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
 <20240715-b4-qcom-rpmh-v6-1-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-1-0c948a25d018@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 12:39:28 +0100
Message-ID: <CAFLszThF_q7qVcrv5bvVckZK6r=_b7GApWcmwfomUMA77V3f-w@mail.gmail.com>
Subject: Re: [PATCH v6 01/24] dm: core: scan reserved-memory nodes
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
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

On Mon, 15 Jul 2024 at 11:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Qualcomm platforms may have drivers that bind to reserved memory nodes
> (cmd-db [1] and smem [2]) which are relevant to U-Boot. Include
> /reserved-memory in dm_extended_scan() so that these will be handled
> correctly.
>
> [1]: https://www.kernel.org/doc/Documentation/devicetree/bindings/reserved-memory/qcom%2Ccmd-db.yaml
> [2]: https://www.kernel.org/doc/Documentation/devicetree/bindings/soc/qcom/qcom%2Csmem.yaml
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> To: Simon Glass <sjg@chromium.org>
> ---
>  drivers/core/root.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
