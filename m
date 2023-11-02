Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0425C4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 812B5876D0;
	Thu,  2 Nov 2023 23:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M9E6+CJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABEE68768D; Thu,  2 Nov 2023 23:46:30 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C816B87645
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so2488669a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965180; x=1699569980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sbOhSBxMSadJCJkynP5JzFFHDgawckNuLSC2mwJKWZA=;
 b=M9E6+CJPUyg9SQCcYknQ04mM2fGzDw+RMR2EoJuYX71cxMRJUD3+GoFhzMqnwcoAHd
 sjBmBmATgt6IePjxBguXjIBw8qtzFlwg4tUfku3po9Wgb1JoWSzT6jVXNL4sgbHLl+lD
 a1X/Fi2DolsvCvrFoieBqbwqUZi49s9I/TLCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965180; x=1699569980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sbOhSBxMSadJCJkynP5JzFFHDgawckNuLSC2mwJKWZA=;
 b=oSrLjIghjfAGIlDfhBuHdhlHNriwvIC1cK3lDEwYGO/h5a+tl+0ZbmqfjIrO0SbihB
 R/hNyRwxb58NnY+rMREFHL28VvzodeHgcokofC7WLB5jlFI1ykdd0Hpy5NWmbTHhxDBH
 TqX5OPMEQn5ZThXQwZ4HrjJVMWE2hiaIAt7QISfz+8pMR0FAlBCkX1h1fBTnp5AjzuYD
 gUx3VtD9oSRaW+mRUT+nYMHkj1saEeZQqFDhgaLyxex2txwLG0ImSu4EcP2YAVZaxNdM
 FJm5PGtyP/qJSZytYtae5fZpyhhuLjW3eUriv/ZfKqxa+gbrdjfsscszVo9dJAhFkVPz
 YF4Q==
X-Gm-Message-State: AOJu0YyU6sogghhDnkbAO5vksLOVtdVH/70KqR+ncAOCWMyeAcR5mB29
 f5sKu1CEzf89LOjPqGxDajLAn63solb5IKoA0BHdAg==
X-Google-Smtp-Source: AGHT+IGDqXlKmwwAcuRnFk7sKcmAY3GofgI1jj4cROKkySV0F1vGRpcWiom9vITvm+63C8ZZDzAHgzoqOaruSlW4hmc=
X-Received: by 2002:a05:6402:5214:b0:540:caed:3619 with SMTP id
 s20-20020a056402521400b00540caed3619mr21089515edd.24.1698965180100; Thu, 02
 Nov 2023 15:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231102091648.40520-1-avromanov@salutedevices.com>
 <20231102091648.40520-3-avromanov@salutedevices.com>
In-Reply-To: <20231102091648.40520-3-avromanov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Nov 2023 22:46:03 +0000
Message-ID: <CAPnjgZ2ro=rdN8301Jt_nZn8sqxBSci-Pz-QzXPOqcHfCBOFWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rng: add dm_rng_read_default() helper
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: sughosh.ganu@linaro.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, u-boot@lists.denx.de, kernel@sberdevices.ru
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

Hi Alexey,

On Thu, 2 Nov 2023 at 12:57, Alexey Romanov <avromanov@salutedevices.com> wrote:
>
> Add dm_rng_read_default() function, which obtain a series
> of random bytes. In some cases, such function would be
> useful because it allows the caller to abstract away from
> RNG device.

It should not do that. It should create a RNG device for its needs.

>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/rng/rng-uclass.c | 18 ++++++++++++++++++
>  include/rng.h            | 10 ++++++++++
>  2 files changed, 28 insertions(+)

Regards,
Simon
